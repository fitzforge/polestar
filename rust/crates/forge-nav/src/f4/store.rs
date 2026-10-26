//! The decoded clusters of a format-4 pack: decoded on first use, kept in a byte-bounded LRU shared by every thread
//! (a port of tools/lib/nav/nav4/store.js; the decoding is pack.rs, ported from Leffe's reader). GPL-3.0-or-later.

use super::pack::{self, Cluster, Graph, Meta, Span, R};
use super::PackSource;
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;
use std::sync::atomic::{AtomicU64, Ordering};
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

#[derive(Default)]
struct Lru {
	map: FxHashMap<u64, (Entry, usize, u64)>,
	order: BTreeMap<u64, u64>,
	tick: u64,
	bytes: usize,
	peak: usize,
}

type MetaCell = Arc<OnceLock<R<Option<Arc<Meta>>>>>;

pub(crate) struct Store {
	pub(crate) source: Box<dyn PackSource>,
	metas: Mutex<FxHashMap<u32, MetaCell>>,
	lru: Mutex<Lru>,
	limit: usize,
	decodes: AtomicU64,
	graph_decodes: AtomicU64,
	decode_us: AtomicU64,
	hits: AtomicU64,
	evictions: AtomicU64,
}

impl Store {
	pub(crate) fn new(source: Box<dyn PackSource>, cache_mb: usize) -> Store {
		Store {
			source,
			metas: Mutex::default(),
			lru: Mutex::default(),
			limit: cache_mb.saturating_mul(1_048_576),
			decodes: AtomicU64::new(0),
			graph_decodes: AtomicU64::new(0),
			decode_us: AtomicU64::new(0),
			hits: AtomicU64::new(0),
			evictions: AtomicU64::new(0),
		}
	}

	/// The map's metadata and part index (scanned once; None: no such map in the pack).
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
		let mut lru = self.lru.lock().unwrap();
		let lru = &mut *lru;
		lru.tick += 1;
		let tick = lru.tick;
		let e = lru.map.get_mut(&key)?;
		lru.order.remove(&e.2);
		e.2 = tick;
		lru.order.insert(tick, key);
		self.hits.fetch_add(1, Ordering::Relaxed);
		Some(e.0.clone())
	}

	fn remember(&self, key: u64, value: Entry, bytes: usize) {
		let mut lru = self.lru.lock().unwrap();
		let lru = &mut *lru;
		lru.tick += 1;
		let tick = lru.tick;
		if let Some(old) = lru.map.insert(key, (value, bytes, tick)) {
			lru.order.remove(&old.2);
			lru.bytes -= old.1;
		}
		lru.order.insert(tick, key);
		lru.bytes += bytes;
		lru.peak = lru.peak.max(lru.bytes);
		while lru.bytes > self.limit && lru.map.len() > 4 {
			let (_, old) = lru.order.pop_first().unwrap();
			let e = lru.map.remove(&old).unwrap();
			lru.bytes -= e.1;
			self.evictions.fetch_add(1, Ordering::Relaxed);
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

	pub(crate) fn cluster(&self, meta: &Meta, k: u32) -> R<Option<Arc<Cluster>>> {
		let key = (meta.map as u64 * 4096 + k as u64) * 2;
		if let Some(Entry::Cluster(c)) = self.lookup(key) {
			return Ok(c);
		}
		let c = self.timed(&self.decodes, || pack::decode_cluster(meta, k, &mut |f, k| self.read_field(meta, f, k)))?.map(Arc::new);
		let bytes = c.as_ref().map_or(64, |c| c.bytes());
		self.remember(key, Entry::Cluster(c.clone()), bytes);
		Ok(c)
	}

	pub(crate) fn graph(&self, meta: &Meta, k: u32) -> R<Arc<Graph>> {
		let key = (meta.map as u64 * 4096 + k as u64) * 2 + 1;
		if let Some(Entry::Graph(g)) = self.lookup(key) {
			return Ok(g);
		}
		let c = self.cluster(meta, k)?;
		let g = Arc::new(self.timed(&self.graph_decodes, || pack::decode_graph(k, &mut |f, k| self.read_field(meta, f, k), c.as_deref()))?);
		self.remember(key, Entry::Graph(g.clone()), g.bytes());
		Ok(g)
	}

	pub(crate) fn stats(&self) -> Stats {
		let lru = self.lru.lock().unwrap();
		Stats {
			decodes: self.decodes.load(Ordering::Relaxed),
			graph_decodes: self.graph_decodes.load(Ordering::Relaxed),
			decode_ms: self.decode_us.load(Ordering::Relaxed) / 1000,
			hits: self.hits.load(Ordering::Relaxed),
			evictions: self.evictions.load(Ordering::Relaxed),
			cached: lru.map.len(),
			cached_mb: lru.bytes as f64 / 1_048_576.0,
			peak_mb: lru.peak as f64 / 1_048_576.0,
		}
	}

	pub(crate) fn clear(&self) {
		let mut lru = self.lru.lock().unwrap();
		lru.map.clear();
		lru.order.clear();
		lru.bytes = 0;
	}
}
