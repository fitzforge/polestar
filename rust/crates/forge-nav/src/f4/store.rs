//! The decoded clusters of a format-4 pack: decoded on first use, kept in a byte-bounded LRU shared by every thread
//! (a port of tools/lib/nav/nav4/store.js; the decoding is pack.rs, ported from Leffe's reader). GPL-3.0-or-later.

use super::pack::{self, Cluster, Graph, Meta, Span, R};
use super::PackSource;
use rustc_hash::FxHashMap;
use std::sync::atomic::{AtomicU64, AtomicUsize, Ordering};
use std::sync::{Arc, Mutex, OnceLock};

/// The store's counters.
#[derive(Clone, Debug, Default)]
pub struct Stats {
	pub decodes: u64,
	pub graph_decodes: u64,
	/// Decode time (native builds only; 0 on wasm).
	pub decode_ms: u64,
	pub hits: u64,
	pub evictions: u64,
	pub cached: usize,
	pub cached_mb: f64,
	/// The largest the cache has held.
	pub peak_mb: f64,
}

#[derive(Clone)]
enum Entry {
	Cluster(Option<Arc<Cluster>>),
	Graph(Arc<Graph>),
}

/// A part of the cache: (entry, its bytes, its last use) by key, and the part's hits.
#[derive(Default)]
struct Shard {
	map: FxHashMap<u64, (Entry, usize, u64)>,
	hits: u64,
}

/// The cache's parts: a key's part by its hash, so threads looking up different clusters rarely wait on each other.
const SHARDS: usize = 64;

type MetaCell = Arc<OnceLock<R<Option<Arc<Meta>>>>>;
/// A decode in flight: (the entry, its bytes) once decoded.
type Pending = Arc<OnceLock<R<(Entry, usize)>>>;

pub(crate) struct Store {
	pub(crate) source: Box<dyn PackSource>,
	metas: Mutex<FxHashMap<u32, MetaCell>>,
	shards: Vec<Mutex<Shard>>,
	/// Keys being decoded: a thread asking for one waits for its decode rather than decoding it again.
	pending: Mutex<FxHashMap<u64, Pending>>,
	/// The use clock: one tick per entry kept (a hit is stamped with the clock as it stands).
	tick: AtomicU64,
	bytes: AtomicUsize,
	peak: AtomicUsize,
	/// One thread evicts at a time.
	evicting: Mutex<()>,
	limit: usize,
	decodes: AtomicU64,
	graph_decodes: AtomicU64,
	decode_us: AtomicU64,
	evictions: AtomicU64,
}

impl Store {
	pub(crate) fn new(source: Box<dyn PackSource>, cache_mb: usize) -> Store {
		Store {
			source,
			metas: Mutex::default(),
			shards: (0..SHARDS).map(|_| Mutex::default()).collect(),
			pending: Mutex::default(),
			tick: AtomicU64::new(0),
			bytes: AtomicUsize::new(0),
			peak: AtomicUsize::new(0),
			evicting: Mutex::default(),
			limit: cache_mb.saturating_mul(1_048_576),
			decodes: AtomicU64::new(0),
			graph_decodes: AtomicU64::new(0),
			decode_us: AtomicU64::new(0),
			evictions: AtomicU64::new(0),
		}
	}

	fn shard(&self, key: u64) -> &Mutex<Shard> {
		&self.shards[(key.wrapping_mul(0x9E37_79B9_7F4A_7C15) >> 58) as usize % SHARDS]
	}

	pub(crate) fn meta(&self, map: u32) -> R<Option<Arc<Meta>>> {
		let cell = self.metas.lock().unwrap().entry(map).or_default().clone();
		cell.get_or_init(|| self.load_meta(map)).clone()
	}

	fn load_meta(&self, map: u32) -> R<Option<Arc<Meta>>> {
		let Some(text) = self.source.meta(map)? else { return Ok(None) };
		let mut meta = pack::parse_meta(&text, map)?;
		let mut asm = pack::Assembly::default();
		for part in 0..self.source.parts(map) {
			let name = format!("Nav{map}_{}.lua", part + 1);
			let mut res = Ok(());
			self.source.with_part(map, part, &mut |bytes| res = pack::scan_part(bytes, part as u32, &mut meta.index, &mut asm, &name))?;
			res?;
		}
		for (field, n) in &meta.counts {
			let have = meta.index.get(field).map_or(0, |m| m.len()) as u64;
			if have != *n {
				return pack::fail(format!("map {map}: {field} holds {have} clusters, counts promise {n}"));
			}
		}
		Ok(Some(Arc::new(meta)))
	}

	/// The inflated field of cluster k, read straight from its part file(s).
	pub(crate) fn read_field(&self, meta: &Meta, field: &str, k: u32) -> R<Option<Vec<u8>>> {
		let Some(spans) = meta.spans(field, k) else { return Ok(None) };
		let mut parts = Vec::new();
		for &Span { part, start, end } in spans {
			let buf = self.source.read(meta.map, part as usize, start, end)?;
			pack::inflate_blocks(&buf, &mut parts)?;
		}
		Ok(Some(if parts.len() == 1 { parts.pop().unwrap() } else { parts.concat() }))
	}

	fn lookup(&self, key: u64) -> Option<Entry> {
		let tick = self.tick.load(Ordering::Relaxed);
		let mut shard = self.shard(key).lock().unwrap();
		let e = shard.map.get_mut(&key)?;
		e.2 = tick;
		let entry = e.0.clone();
		shard.hits += 1;
		Some(entry)
	}

	fn remember(&self, key: u64, value: Entry, bytes: usize) {
		let tick = self.tick.fetch_add(1, Ordering::Relaxed) + 1;
		if let Some(old) = self.shard(key).lock().unwrap().map.insert(key, (value, bytes, tick)) {
			self.bytes.fetch_sub(old.1, Ordering::Relaxed);
		}
		let now = self.bytes.fetch_add(bytes, Ordering::Relaxed) + bytes;
		self.peak.fetch_max(now, Ordering::Relaxed);
		if now > self.limit {
			self.evict();
		}
	}

	/// Over the limit: the least recently used entries dropped down to 7/8 of it (at least 4 kept).
	fn evict(&self) {
		let Ok(_one) = self.evicting.try_lock() else { return };
		if self.bytes.load(Ordering::Relaxed) <= self.limit {
			return;
		}
		let mut all: Vec<(u64, u64)> = Vec::new();
		for s in &self.shards {
			all.extend(s.lock().unwrap().map.iter().map(|(&k, e)| (e.2, k)));
		}
		all.sort_unstable();
		let (target, mut left) = (self.limit / 8 * 7, all.len());
		for (_, k) in all {
			if self.bytes.load(Ordering::Relaxed) <= target || left <= 4 {
				break;
			}
			if let Some(e) = self.shard(k).lock().unwrap().map.remove(&k) {
				self.bytes.fetch_sub(e.1, Ordering::Relaxed);
				self.evictions.fetch_add(1, Ordering::Relaxed);
				left -= 1;
			}
		}
	}

	fn timed<T>(&self, counter: &AtomicU64, f: impl FnOnce() -> T) -> T {
		#[cfg(feature = "native")]
		let t0 = std::time::Instant::now();
		let v = f();
		#[cfg(feature = "native")]
		self.decode_us.fetch_add(t0.elapsed().as_micros() as u64, Ordering::Relaxed);
		counter.fetch_add(1, Ordering::Relaxed);
		v
	}

	/// The entry under `key`: the cache's, else decoded once (threads asking for a key being decoded wait for it).
	fn get_or_decode(&self, key: u64, decode: impl FnOnce() -> R<(Entry, usize)>) -> R<Entry> {
		if let Some(e) = self.lookup(key) {
			return Ok(e);
		}
		let cell = self.pending.lock().unwrap().entry(key).or_default().clone();
		let got = cell.get_or_init(decode).clone();
		// The first thread through keeps it (the others asked while it decoded).
		let mut pending = self.pending.lock().unwrap();
		if pending.get(&key).is_some_and(|c| Arc::ptr_eq(c, &cell)) {
			pending.remove(&key);
			drop(pending);
			if let Ok((e, bytes)) = &got {
				self.remember(key, e.clone(), *bytes);
			}
		}
		got.map(|x| x.0)
	}

	pub(crate) fn cluster(&self, meta: &Meta, k: u32) -> R<Option<Arc<Cluster>>> {
		let key = (meta.map as u64 * 4096 + k as u64) * 2;
		let e = self.get_or_decode(key, || {
			let c = self.timed(&self.decodes, || pack::decode_cluster(meta, k, &mut |f, k| self.read_field(meta, f, k)))?.map(Arc::new);
			let bytes = c.as_ref().map_or(64, |c| c.bytes());
			Ok((Entry::Cluster(c), bytes))
		})?;
		match e {
			Entry::Cluster(c) => Ok(c),
			Entry::Graph(_) => unreachable!("f4 store: a cluster key holds a graph"),
		}
	}

	pub(crate) fn graph(&self, meta: &Meta, k: u32) -> R<Arc<Graph>> {
		let key = (meta.map as u64 * 4096 + k as u64) * 2 + 1;
		let e = self.get_or_decode(key, || {
			let c = self.cluster(meta, k)?;
			let g = Arc::new(self.timed(&self.graph_decodes, || pack::decode_graph(k, &mut |f, k| self.read_field(meta, f, k), c.as_deref()))?);
			let bytes = g.bytes();
			Ok((Entry::Graph(g), bytes))
		})?;
		match e {
			Entry::Graph(g) => Ok(g),
			Entry::Cluster(_) => unreachable!("f4 store: a graph key holds a cluster"),
		}
	}

	pub(crate) fn stats(&self) -> Stats {
		let (mut hits, mut cached) = (0, 0);
		for s in &self.shards {
			let s = s.lock().unwrap();
			hits += s.hits;
			cached += s.map.len();
		}
		Stats {
			decodes: self.decodes.load(Ordering::Relaxed),
			graph_decodes: self.graph_decodes.load(Ordering::Relaxed),
			decode_ms: self.decode_us.load(Ordering::Relaxed) / 1000,
			hits,
			evictions: self.evictions.load(Ordering::Relaxed),
			cached,
			cached_mb: self.bytes.load(Ordering::Relaxed) as f64 / 1_048_576.0,
			peak_mb: self.peak.load(Ordering::Relaxed) as f64 / 1_048_576.0,
		}
	}

	pub(crate) fn clear(&self) {
		for s in &self.shards {
			let mut s = s.lock().unwrap();
			for (_, (_, b, _)) in s.map.drain() {
				self.bytes.fetch_sub(b, Ordering::Relaxed);
			}
		}
	}
}
