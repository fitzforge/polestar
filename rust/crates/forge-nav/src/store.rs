//! The walk store: walks asked, never tabulated (docs/forge/nav.md, "The walk store").
//!
//! An answer is kept by what decides it: its two ends (the coordinates the router is sent, both
//! heights), the grid's build id and the cost model's parameters (a model). Never by source text
//! or world point numbers: a quest fix, a comment or a new place costs nothing.
//!
//! `walks(&[(from, to, profile)], router)` answers from the store and asks the router only for the
//! pairs it lacks, one call per model. A profile is a model and, for a danger band, the base model
//! the band falls back to where it holds no walk of its own (the walks documents' rule: a band
//! re-routes only the pairs its danger reaches).
//!
//! Stage 1 fills it from today's walks file (`import_doc`: walklookup's answers, last entry wins,
//! unwalkable pairs +inf) and from the router's saved band tables (`import_table`).

use crate::lookup::{Band, WalksDoc};
use crate::psbn::{self, Bin, Error, Section};
use rustc_hash::FxHashMap;
use serde_json::{json, Map, Value};

/// A walk's end as the router is sent it: continent, grid x/y, the point's own height and the
/// surface's height (NaN: none).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct End {
	pub c: i32,
	pub x: f64,
	pub y: f64,
	pub z: f64,
	pub zf: f64,
}

impl End {
	pub fn new(c: i32, x: f64, y: f64, z: Option<f64>, zf: Option<f64>) -> End {
		End { c, x, y, z: z.unwrap_or(f64::NAN), zf: zf.unwrap_or(f64::NAN) }
	}
	fn bits(&self) -> [u64; 5] {
		let b = |v: f64| if v.is_nan() { u64::MAX } else { (v + 0.0).to_bits() };
		[self.c as u32 as u64, b(self.x), b(self.y), b(self.z), b(self.zf)]
	}
}

/// What decides a walk besides its ends: the grid's build id and the cost model's parameters
/// (router, faction, move profile, style, smooth, danger band and the zone levels it reads).
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct Model {
	pub grid: String,
	pub params: String,
}

impl Model {
	/// The model's key: sha1 of grid and parameters, 16 hex.
	pub fn key(&self) -> String {
		let mut h = forge_core::key::ContentHasher::new();
		h.update(self.grid.as_bytes()).update(b"\n").update(self.params.as_bytes());
		h.hex()[..16].to_string()
	}
}

/// A walk: walked yards (the router's × its smooth) and cost (seconds); yards -1 not walkable,
/// +inf unwalkable (a cliff and its foot).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Answer {
	pub yd: f64,
	pub cost: f64,
}

impl Answer {
	pub const NONE: Answer = Answer { yd: -1.0, cost: -1.0 };
	pub const UNWALKABLE: Answer = Answer { yd: f64::INFINITY, cost: f64::INFINITY };
}

/// A model and the base model a danger band falls back to.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Profile {
	pub model: u32,
	pub base: Option<u32>,
}

/// A walk's yards per 200 yd zone cell (router.js cellKey), rounded to 0.1 as the tables keep them.
pub type ZoneCells = Box<[(u32, f32)]>;

/// One model's pairs to answer, and the answers (in pair order) for them.
pub type Job<'a> = (&'a Model, Vec<(End, End)>);
pub type Answers = Vec<(Answer, Option<ZoneCells>)>;

/// Who answers the pairs the store lacks.
pub trait Router {
	/// One answer per pair, in order, for this model; with `cells`, a walkable answer's zone cells.
	fn walks(&mut self, model: &Model, pairs: &[(End, End)], cells: bool) -> Answers;
	/// Several models' pairs at once, one answer list per job in order. A router that can answer the jobs
	/// together (on threads across the models) overrides it; the answers must be `walks`' for each job.
	fn walks_many(&mut self, jobs: &[Job], cells: bool) -> Vec<Answers> {
		jobs.iter().map(|(m, pairs)| self.walks(m, pairs, cells)).collect()
	}
}

/// A router that answers nothing (reading only: the browser, a store that must already hold it).
pub struct NoRouter;
impl Router for NoRouter {
	fn walks(&mut self, _: &Model, pairs: &[(End, End)], _: bool) -> Vec<(Answer, Option<ZoneCells>)> {
		vec![(Answer::NONE, None); pairs.len()]
	}
}

#[derive(Default)]
pub struct WalkStore {
	ends: Vec<End>,
	end_ix: FxHashMap<[u64; 5], u32>,
	models: Vec<Model>,
	model_ix: FxHashMap<Model, u32>,
	/// The answers the file held, as they lie in it: read without hashing each one, written back
	/// merged with what changed.
	base: Base,
	/// Answers given or replaced since the file was read: a key here wins over the file's.
	answers: FxHashMap<Key, Answer>,
	/// Zone cells set (Some) or dropped (None) since the file was read; a key not here keeps the file's.
	cells: FxHashMap<Key, Option<ZoneCells>>,
	/// Keys of `answers` the file lacks.
	added: usize,
	/// Each end's zone (uiMapID) as the backend that answered saw it: Leffe's stores keep it so a build
	/// without his maps can price the danger bands' models alike (`end.zone`, -1 unknown).
	zones: FxHashMap<u32, u16>,
	/// Pairs asked of the router since the store was opened.
	pub asked: usize,
	/// An end, model, answer, zone cells or zone changed since the file was read (else the file as
	/// it is holds the store: `changed() == false` means `encode` gives the file's bytes again).
	changed: bool,
}

/// An answer's key: (from end, to end, model).
type Key = (u32, u32, u32);

/// A store file's answers as the file holds them: by model, then (from, to) ascending, each key once.
#[derive(Default)]
struct Base {
	/// Each model's answers: `range[m]` of the arrays below.
	range: Vec<(usize, usize)>,
	/// from << 32 | to.
	ab: Vec<u64>,
	yd: Vec<f64>,
	cost: Vec<f64>,
	/// Answer i's zone cells, when has[i]: cell_key and cell_yd [off[i], off[i + 1]).
	has: Vec<u8>,
	off: Vec<u32>,
	cell_key: Vec<u32>,
	cell_yd: Vec<f32>,
}

impl Base {
	fn len(&self) -> usize {
		self.ab.len()
	}
	fn find(&self, (a, b, m): Key) -> Option<usize> {
		let &(lo, hi) = self.range.get(m as usize)?;
		let k = (a as u64) << 32 | b as u64;
		self.ab[lo..hi].binary_search(&k).ok().map(|i| lo + i)
	}
	fn answer(&self, i: usize) -> Answer {
		Answer { yd: self.yd[i], cost: self.cost[i] }
	}
	fn has_cells(&self, i: usize) -> bool {
		self.has.get(i).is_some_and(|&h| h != 0)
	}
	fn cell_range(&self, i: usize) -> std::ops::Range<usize> {
		self.off[i] as usize..self.off[i + 1] as usize
	}
	fn cells(&self, i: usize) -> Option<ZoneCells> {
		self.has_cells(i).then(|| self.cell_range(i).map(|x| (self.cell_key[x], self.cell_yd[x])).collect())
	}
}

/// What `walks` did: answers (and with cells asked, each walkable answer's zone cells), how many
/// came from the store, how many the router gave.
pub struct Walks {
	pub answers: Vec<Answer>,
	pub cells: Vec<Option<ZoneCells>>,
	pub stored: usize,
	pub routed: usize,
}

const STORE_SCHEMA: i64 = 2; // 2: answers f64 (router tables' costs reach millions of seconds)

impl WalkStore {
	pub fn new() -> Self {
		Self::default()
	}

	pub fn len(&self) -> usize {
		self.base.len() + self.added
	}
	pub fn is_empty(&self) -> bool {
		self.len() == 0
	}
	pub fn models(&self) -> &[Model] {
		&self.models
	}
	/// Whether anything changed since the store was read (a new store: whether anything was put in it).
	pub fn changed(&self) -> bool {
		self.changed
	}

	pub fn end(&mut self, e: &End) -> u32 {
		let k = e.bits();
		if let Some(&i) = self.end_ix.get(&k) {
			return i;
		}
		let i = self.ends.len() as u32;
		self.ends.push(*e);
		self.end_ix.insert(k, i);
		self.changed = true;
		i
	}

	fn end_of(&self, e: &End) -> Option<u32> {
		self.end_ix.get(&e.bits()).copied()
	}

	/// Keeps `e`'s zone (the answering backend's zone_at).
	pub fn set_zone(&mut self, e: &End, zone: u16) {
		let i = self.end(e);
		if self.zones.insert(i, zone) != Some(zone) {
			self.changed = true;
		}
	}

	/// The zone kept for `e`, if any.
	pub fn zone(&self, e: &End) -> Option<u16> {
		self.end_of(e).and_then(|i| self.zones.get(&i).copied())
	}

	/// The Leffe pack (`leffe:<id>` models' id) and lift layer (`lifts=` of their params) holding the most
	/// answers of the current f4 answer version: what the store's Leffe walks were last built on (a store
	/// keeps older packs' and versions' answers too).
	pub fn leffe_pack(&self) -> Option<(String, String)> {
		let v = format!("|v={}", crate::f4walks::MODEL_VERSION);
		let mut per_model: FxHashMap<u32, usize> = FxHashMap::default();
		for (m, &(lo, hi)) in self.base.range.iter().enumerate() {
			if hi > lo {
				*per_model.entry(m as u32).or_default() += hi - lo;
			}
		}
		for &k in self.answers.keys() {
			if self.base.find(k).is_none() {
				*per_model.entry(k.2).or_default() += 1;
			}
		}
		let mut n: FxHashMap<(&str, &str), usize> = FxHashMap::default();
		for (m, count) in per_model {
			let model = &self.models[m as usize];
			let Some(id) = model.grid.strip_prefix("leffe:") else { continue };
			if !model.params.ends_with(&v) {
				continue;
			}
			let lifts = model.params.split('|').find_map(|p| p.strip_prefix("lifts=")).unwrap_or("none");
			*n.entry((id, lifts)).or_default() += count;
		}
		n.into_iter().max_by(|a, b| a.1.cmp(&b.1).then(b.0.cmp(&a.0))).map(|((id, l), _)| (id.to_string(), l.to_string()))
	}

	pub fn model(&mut self, m: &Model) -> u32 {
		if let Some(&i) = self.model_ix.get(m) {
			return i;
		}
		let i = self.models.len() as u32;
		self.models.push(m.clone());
		self.model_ix.insert(m.clone(), i);
		self.changed = true;
		i
	}

	pub fn put(&mut self, a: &End, b: &End, model: u32, ans: Answer) {
		let (a, b) = (self.end(a), self.end(b));
		self.put_ix(a, b, model, ans);
	}

	fn put_ix(&mut self, a: u32, b: u32, model: u32, ans: Answer) {
		let k = (a, b, model);
		if self.answers.insert(k, ans).is_none() && self.base.find(k).is_none() {
			self.added += 1;
		}
		self.changed = true;
	}

	fn set_cells(&mut self, k: Key, cells: Option<ZoneCells>) {
		self.cells.insert(k, cells);
		self.changed = true;
	}

	fn contains(&self, k: Key) -> bool {
		self.answers.contains_key(&k) || self.base.find(k).is_some()
	}

	/// The answer kept under k and, when the file holds k, its place there.
	fn entry(&self, k: Key) -> Option<(Answer, Option<usize>)> {
		let at = self.base.find(k);
		match self.answers.get(&k) {
			Some(&a) => Some((a, at)),
			None => at.map(|i| (self.base.answer(i), Some(i))),
		}
	}

	/// Whether k (at `at` in the file) has zone cells kept.
	fn has_cells(&self, k: Key, at: Option<usize>) -> bool {
		match self.cells.get(&k) {
			Some(c) => c.is_some(),
			None => at.is_some_and(|i| self.base.has_cells(i)),
		}
	}

	fn cells_of(&self, k: Key, at: Option<usize>) -> Option<ZoneCells> {
		match self.cells.get(&k) {
			Some(c) => c.clone(),
			None => at.and_then(|i| self.base.cells(i)),
		}
	}

	/// The stored walk of (a, b) in the profile (its model, else its base), or None.
	pub fn get(&self, a: &End, b: &End, p: Profile) -> Option<Answer> {
		let (a, b) = (self.end_of(a)?, self.end_of(b)?);
		self.key_ix(a, b, p).map(|x| x.1)
	}

	/// The key the profile's answer of (a, b) is kept under (its model's, else its base's), the answer and
	/// its place in the file.
	fn key_ix(&self, a: u32, b: u32, p: Profile) -> Option<(Key, Answer, Option<usize>)> {
		let k = (a, b, p.model);
		if let Some((ans, at)) = self.entry(k) {
			return Some((k, ans, at));
		}
		let k = (a, b, p.base?);
		self.entry(k).map(|(ans, at)| (k, ans, at))
	}

	/// Answers for the asks: the store's, and the router's for the pairs it lacks (asked once per
	/// distinct pair, one call per model, then kept).
	pub fn walks(&mut self, asks: &[(End, End, Profile)], router: &mut dyn Router) -> Walks {
		self.walks_cells(asks, router, false)
	}

	/// walks(), with each walkable answer's zone cells: a stored walk without them is asked again.
	pub fn walks_cells(&mut self, asks: &[(End, End, Profile)], router: &mut dyn Router, cells: bool) -> Walks {
		let ix: Vec<(u32, u32)> = asks.iter().map(|(a, b, _)| (self.end(a), self.end(b))).collect();
		// The store's answers (reads only: on threads where there are any).
		let look = |i: usize| -> Option<(Answer, Option<ZoneCells>)> {
			let (a, b) = ix[i];
			let (k, ans, at) = self.key_ix(a, b, asks[i].2)?;
			if !cells {
				return Some((ans, None));
			}
			if ans.yd >= 0.0 && ans.yd.is_finite() && !self.has_cells(k, at) {
				return None;
			}
			Some((ans, self.cells_of(k, at)))
		};
		#[cfg(feature = "native")]
		let found: Vec<Option<(Answer, Option<ZoneCells>)>> = {
			use rayon::prelude::*;
			(0..asks.len()).into_par_iter().with_min_len(4096).map(look).collect()
		};
		#[cfg(not(feature = "native"))]
		let found: Vec<Option<(Answer, Option<ZoneCells>)>> = (0..asks.len()).map(look).collect();
		let mut answers = vec![Answer::NONE; asks.len()];
		let mut out_cells: Vec<Option<ZoneCells>> = vec![None; asks.len()];
		let mut missing: FxHashMap<u32, Vec<(u32, u32)>> = FxHashMap::default();
		let mut pending: Vec<(usize, Key)> = Vec::new();
		let mut stored = 0;
		for (i, f) in found.into_iter().enumerate() {
			match f {
				Some((a, c)) => {
					answers[i] = a;
					out_cells[i] = c;
					stored += 1;
				}
				None => {
					let ((a, b), m) = (ix[i], asks[i].2.model);
					missing.entry(m).or_default().push((a, b));
					pending.push((i, (a, b, m)));
				}
			}
		}
		let mut models: Vec<(u32, Vec<(u32, u32)>)> = missing.into_iter().collect();
		models.sort_by_key(|x| x.0);
		for (_, pairs) in &mut models {
			pairs.sort_unstable();
			pairs.dedup();
		}
		let mut routed = 0;
		if !models.is_empty() {
			let jobs: Vec<Job> = models.iter().map(|(m, pairs)| (&self.models[*m as usize], pairs.iter().map(|&(a, b)| (self.ends[a as usize], self.ends[b as usize])).collect())).collect();
			let got = router.walks_many(&jobs, cells);
			assert_eq!(got.len(), jobs.len(), "router: one answer list per model");
			drop(jobs);
			for ((m, pairs), got) in models.iter().zip(got) {
				assert_eq!(got.len(), pairs.len(), "router: one answer per pair");
				routed += pairs.len();
				for (&(a, b), (x, c)) in pairs.iter().zip(got) {
					self.put_ix(a, b, *m, x);
					if let Some(c) = c {
						self.set_cells((a, b, *m), Some(c));
					}
				}
			}
		}
		self.asked += routed;
		for (i, k) in pending {
			let (ans, at) = self.entry(k).expect("walk store: a routed pair is kept");
			answers[i] = ans;
			if cells {
				out_cells[i] = self.cells_of(k, at);
			}
		}
		Walks { answers, cells: out_cells, stored, routed }
	}

	/// A walks document's walks (walklookup's answers: per band its table, last entry wins), ends
	/// by world point (`ends[pt]`), each band under `model_of(band)`; the unwalkable pairs under
	/// the base model where it holds no walk. -> the profile of each band (doc order).
	pub fn import_doc(&mut self, doc: WalksDoc, ends: &[End], model_of: &dyn Fn(i64) -> Model) -> Vec<(i64, Profile)> {
		let nw = ends.len();
		let stride = doc.stride();
		let smooth = doc.smooth();
		let built = doc.nw() == Some(nw);
		let ix: Vec<u32> = ends.iter().map(|e| self.end(e)).collect();
		let base = doc.bands.contains(&0).then(|| self.model(&model_of(0)));
		let mut out = Vec::new();
		for ((band, arr), l) in doc.bands.iter().zip(&doc.pairs).zip(doc.lookup) {
			let t = match l {
				Some(t) if built => t,
				_ => Band::build(arr, nw, stride, smooth),
			};
			let m = self.model(&model_of(*band));
			self.answers.reserve(t.nbr.len());
			for (a, b, k) in t.entries() {
				self.put_ix(ix[a], ix[b as usize], m, Answer { yd: t.yd[k] as f64, cost: t.cost[k] as f64 });
			}
			out.push((*band, Profile { model: m, base: if *band == 0 { None } else { base } }));
		}
		if let Some(m) = base {
			for p in doc.unwalkable.chunks_exact(2) {
				for (a, b) in [(p[0], p[1]), (p[1], p[0])] {
					let k = (ix[a as usize], ix[b as usize], m);
					if !self.contains(k) {
						self.put_ix(k.0, k.1, m, Answer::UNWALKABLE);
					}
				}
			}
		}
		out
	}

	/// A router band table (walktables.js: pair i from `src[i]` to `dst[i]`, yards y and cost c as
	/// asked, -1 not walkable) under `model`; walked yards are y × smooth.
	/// `cells`: the table's zone cells (xoff, x: [cellKey, yards, ...] per pair), base tables only.
	pub fn import_table(&mut self, y: &[f64], c: &[f64], src: &[i32], dst: &[i32], ends: &[End], model: u32, smooth: f64, cells: Option<(&[u32], &[f32])>) {
		self.answers.reserve(y.len());
		for i in 0..y.len() {
			let (a, b) = (self.end(&ends[src[i] as usize]), self.end(&ends[dst[i] as usize]));
			let ans = if y[i] >= 0.0 && c[i] >= 0.0 { Answer { yd: y[i] * smooth, cost: c[i] } } else { Answer::NONE };
			self.put_ix(a, b, model, ans);
			if let Some((off, x)) = cells {
				let v: Option<ZoneCells> = (ans.yd >= 0.0).then(|| x[off[i] as usize..off[i + 1] as usize].chunks_exact(2).map(|p| (p[0] as u32, p[1])).collect());
				self.set_cells((a, b, model), v);
			}
		}
	}

	/// Answers with zone cells kept.
	pub fn cells_kept(&self) -> usize {
		let mut n = self.base.has.iter().filter(|&&h| h != 0).count();
		for (&k, c) in &self.cells {
			n += c.is_some() as usize;
			n -= self.base.find(k).is_some_and(|i| self.base.has_cells(i)) as usize;
		}
		n
	}

	/// The store as a PSBN file (header: schema, models; sections: ends and answers sorted by
	/// model, from, to): [`WalkStore::write_to`]'s bytes, in memory.
	pub fn encode(&self) -> Vec<u8> {
		let mut out = Vec::new();
		self.write_to(&mut out).expect("walk store: writing to memory");
		out
	}

	/// The store's file written to `w` section by section: the file's answers and the new ones merged by
	/// model, then (from, to), a key in both the new one. Only the merge order is held (8 bytes an answer),
	/// never the merged answers, their sections' bytes or the file's (the whole store three more times: an
	/// Alliance grid store of 1.85 GB went past a 10 GB budget at its save).
	pub fn write_to(&self, w: &mut dyn std::io::Write) -> std::io::Result<()> {
		let mut over: Vec<Key> = self.answers.keys().copied().collect();
		over.sort_unstable_by_key(|&(a, b, m)| (m, a, b));
		assert!(over.len() < 1 << 31 && self.base.len() < NO_AT as usize, "walk store: too many answers to write");
		let (slots, runs) = self.merge_order(&over);
		let o = Order { over, slots, runs };
		let n = o.slots.len();
		let mut cells = 0;
		self.each_slot(&o, |m, v| cells += self.slot_cells(&o.over, m, v).len());
		let mut header = Map::new();
		header.insert("schema".into(), json!(STORE_SCHEMA));
		header.insert("kind".into(), json!("walkstore"));
		header.insert("models".into(), Value::Array(self.models.iter().map(|m| json!({ "key": m.key(), "grid": m.grid, "params": m.params })).collect()));
		let e = &self.ends;
		let mut small = vec![
			Section::i32s("end.c", &e.iter().map(|x| x.c).collect::<Vec<_>>()),
			Section::f64s("end.x", &e.iter().map(|x| x.x).collect::<Vec<_>>()),
			Section::f64s("end.y", &e.iter().map(|x| x.y).collect::<Vec<_>>()),
			Section::f64s("end.z", &e.iter().map(|x| x.z).collect::<Vec<_>>()),
			Section::f64s("end.zf", &e.iter().map(|x| x.zf).collect::<Vec<_>>()),
		];
		if !self.zones.is_empty() {
			small.push(Section::i32s("end.zone", &(0..e.len() as u32).map(|i| self.zones.get(&i).map_or(-1, |&z| z as i32)).collect::<Vec<_>>()));
		}
		let o = &o;
		let column = |name: &str, kind: psbn::Kind, len: usize, size: usize, col: Col| psbn::Stream {
			name: name.into(),
			kind,
			len,
			bytes: len * size,
			emit: Box::new(move |out: &mut dyn FnMut(&[u8])| self.emit_column(o, col, out)),
		};
		// The sections in the order the file has always had them.
		let mut streams: Vec<psbn::Stream> = small[..5].iter().map(psbn::Stream::of).collect();
		streams.push(column("a", psbn::Kind::U32, n, 4, Col::A));
		streams.push(column("b", psbn::Kind::U32, n, 4, Col::B));
		streams.push(column("m", psbn::Kind::U32, n, 4, Col::M));
		streams.push(column("yd", psbn::Kind::F64, n, 8, Col::Yd));
		streams.push(column("cost", psbn::Kind::F64, n, 8, Col::Cost));
		streams.extend(small[5..].iter().map(psbn::Stream::of));
		streams.push(column("cell.off", psbn::Kind::U32, n + 1, 4, Col::Off));
		streams.push(column("cell.key", psbn::Kind::U32, cells, 4, Col::CellKey));
		streams.push(column("cell.yd", psbn::Kind::F32, cells, 4, Col::CellYd));
		streams.push(column("cell.has", psbn::Kind::U8, n, 1, Col::Has));
		psbn::encode_to(w, &header, &streams).map(|_| ())
	}

	/// f(model, slot) for every answer in file order.
	fn each_slot(&self, o: &Order, mut f: impl FnMut(u32, u64)) {
		for &(m, lo, hi) in &o.runs {
			for &v in &o.slots[lo..hi] {
				f(m, v);
			}
		}
	}

	/// Column `col` of every answer in file order, as little-endian bytes to `out`.
	fn emit_column(&self, o: &Order, col: Col, out: &mut dyn FnMut(&[u8])) {
		let mut c = Chunks::new(out);
		let mut off = 0u32;
		if col == Col::Off {
			c.put(&off.to_le_bytes());
		}
		self.each_slot(o, |m, v| match col {
			Col::A | Col::B | Col::M | Col::Yd | Col::Cost => {
				let ((a, b, mm), x, _) = self.slot(&o.over, m, v);
				match col {
					Col::A => c.put(&a.to_le_bytes()),
					Col::B => c.put(&b.to_le_bytes()),
					Col::M => c.put(&mm.to_le_bytes()),
					Col::Yd => c.put(&x.yd.to_le_bytes()),
					_ => c.put(&x.cost.to_le_bytes()),
				}
			}
			Col::Off => {
				off += self.slot_cells(&o.over, m, v).len() as u32;
				c.put(&off.to_le_bytes());
			}
			Col::CellKey => self.slot_cells(&o.over, m, v).each(|k, _| c.put(&k.to_le_bytes())),
			Col::CellYd => self.slot_cells(&o.over, m, v).each(|_, y| c.put(&y.to_le_bytes())),
			Col::Has => c.put(&[!matches!(self.slot_cells(&o.over, m, v), Cells::None) as u8]),
		});
		c.flush();
	}

	/// The file order of the answers: each a slot (`NEW` clear: the file's answer i; set: `over[o]`, with
	/// its key's place in the file or `NO_AT`), and the runs of one model, (model, from, to) of the order.
	fn merge_order(&self, over: &[Key]) -> (Vec<u64>, Vec<(u32, usize, usize)>) {
		let mut order = Vec::with_capacity(self.len());
		let mut runs = Vec::new();
		let models = self.base.range.len().max(over.last().map_or(0, |k| k.2 as usize + 1));
		let new = |o: usize, at: Option<usize>| NEW | (o as u64) << 32 | at.map_or(NO_AT, |i| i as u64);
		let mut o = 0;
		for m in 0..models as u32 {
			let start = order.len();
			let (lo, hi) = self.base.range.get(m as usize).copied().unwrap_or((0, 0));
			let mut i = lo;
			let o_end = o + over[o..].iter().take_while(|k| k.2 == m).count();
			while i < hi || o < o_end {
				let base_ab = (i < hi).then(|| self.base.ab[i]);
				let new_ab = (o < o_end).then(|| (over[o].0 as u64) << 32 | over[o].1 as u64);
				match (base_ab, new_ab) {
					(Some(x), Some(y)) if x == y => {
						order.push(new(o, Some(i)));
						i += 1;
						o += 1;
					}
					(Some(x), Some(y)) if x > y => {
						order.push(new(o, None));
						o += 1;
					}
					(None, Some(_)) => {
						order.push(new(o, None));
						o += 1;
					}
					_ => {
						order.push(i as u64);
						i += 1;
					}
				}
			}
			runs.push((m, start, order.len()));
		}
		(order, runs)
	}

	/// Slot v (of model m's run): its key, answer and place in the file.
	fn slot(&self, over: &[Key], m: u32, v: u64) -> (Key, Answer, Option<usize>) {
		if v & NEW == 0 {
			let i = v as usize;
			let ab = self.base.ab[i];
			return (((ab >> 32) as u32, ab as u32, m), self.base.answer(i), Some(i));
		}
		let k = over[((v & !NEW) >> 32) as usize];
		let at = (v & 0xFFFF_FFFF != NO_AT).then_some((v & 0xFFFF_FFFF) as usize);
		(k, self.answers[&k], at)
	}

	/// Slot v's zone cells as the file keeps them: the store's own for its key (a new walk, or cells
	/// dropped), else the file's.
	fn slot_cells(&self, over: &[Key], m: u32, v: u64) -> Cells<'_> {
		let (k, _, at) = self.slot(over, m, v);
		match self.cells.get(&k) {
			Some(Some(c)) => Cells::Kept(c),
			Some(None) => Cells::None,
			None => match at {
				Some(i) if self.base.has_cells(i) => {
					let r = self.base.cell_range(i);
					Cells::File(&self.base.cell_key[r.clone()], &self.base.cell_yd[r])
				}
				_ => Cells::None,
			},
		}
	}

	pub fn decode(bytes: &[u8]) -> Result<WalkStore, Error> {
		let bin = Bin::parse(bytes)?;
		if bin.header.get("kind").and_then(|v| v.as_str()) != Some("walkstore") || bin.header.get("schema").and_then(|v| v.as_i64()) != Some(STORE_SCHEMA) {
			return Err(Error("not a walk store of this schema".into()));
		}
		let mut s = WalkStore::new();
		for m in bin.header.get("models").and_then(|v| v.as_array()).ok_or_else(|| Error("walk store: no models".into()))? {
			let get = |k: &str| m.get(k).and_then(|v| v.as_str()).unwrap_or("").to_string();
			s.model(&Model { grid: get("grid"), params: get("params") });
		}
		let (c, x, y, z, zf) = (bin.i32s("end.c")?, bin.f64s("end.x")?, bin.f64s("end.y")?, bin.f64s("end.z")?, bin.f64s("end.zf")?);
		for i in 0..c.len() {
			s.end(&End { c: c[i], x: x[i], y: y[i], z: z[i], zf: zf[i] });
		}
		let zone_raw = if bin.has("end.zone") { Some(bin.i32s("end.zone")?) } else { None };
		for (i, &z) in zone_raw.iter().flatten().enumerate() {
			if z >= 0 {
				s.zones.insert(i as u32, z as u16);
			}
		}
		let (a, b, m, yd, cost) = (bin.u32s("a")?, bin.u32s("b")?, bin.u32s("m")?, bin.f64s("yd")?, bin.f64s("cost")?);
		let n = a.len();
		if [b.len(), m.len(), yd.len(), cost.len()].iter().any(|&l| l != n) {
			return Err(Error("walk store: answer sections of different lengths".into()));
		}
		let cells = if bin.has("cell.off") { Some((bin.u32s("cell.off")?, bin.u32s("cell.key")?, bin.f32s("cell.yd")?, bin.u8s("cell.has")?)) } else { None };
		if let Some((off, ck, cy, has)) = &cells {
			let end = off.last().copied().unwrap_or(0) as usize;
			if off.len() != n + 1 || has.len() != n || ck.len() < end || cy.len() < end || off.windows(2).any(|w| w[0] > w[1]) {
				return Err(Error("walk store: zone cell sections do not match the answers".into()));
			}
		}
		// As the store writes them (by model, from, to; each key once), the answers are kept as they lie;
		// a file in another order is read key by key, the last of a key winning.
		let in_order = m.iter().all(|&x| (x as usize) < s.models.len()) && (1..n).all(|i| (m[i - 1], a[i - 1], b[i - 1]) < (m[i], a[i], b[i]));
		// Whether encode gives the file's bytes back: only then is a store that gained nothing left as it is.
		let canonical = in_order
			&& s.ends.len() == c.len()
			&& zone_raw.as_ref().is_none_or(|z| z.len() == c.len() && !s.zones.is_empty() && z.iter().all(|&v| (-1..=u16::MAX as i32).contains(&v)))
			&& cells
				.as_ref()
				.is_some_and(|(off, ck, cy, has)| off[0] == 0 && ck.len() == off[n] as usize && cy.len() == ck.len() && (0..n).all(|i| has[i] == 1 || (has[i] == 0 && off[i] == off[i + 1])))
			&& Self::header_as_encoded(&bin.header, &s.models)
			&& psbn::as_encoded(bytes, &Self::section_names(!s.zones.is_empty()));
		if in_order {
			let mut range = vec![(0, 0); s.models.len()];
			let mut i = 0;
			while i < n {
				let (mm, lo) = (m[i], i);
				while i < n && m[i] == mm {
					i += 1;
				}
				range[mm as usize] = (lo, i);
			}
			let ab = a.iter().zip(&b).map(|(&a, &b)| (a as u64) << 32 | b as u64).collect();
			let (off, cell_key, cell_yd, has) = cells.unwrap_or_default();
			s.base = Base { range, ab, yd, cost, has, off, cell_key, cell_yd };
		} else {
			s.answers.reserve(n);
			for i in 0..n {
				s.answers.insert((a[i], b[i], m[i]), Answer { yd: yd[i], cost: cost[i] });
			}
			if let Some((off, ck, cy, has)) = &cells {
				for i in 0..n {
					if has[i] != 0 {
						s.cells.insert((a[i], b[i], m[i]), Some((off[i] as usize..off[i + 1] as usize).map(|x| (ck[x], cy[x])).collect()));
					}
				}
			}
			s.added = s.answers.len();
		}
		s.changed = !canonical;
		Ok(s)
	}

	/// The sections encode writes, in order (`end.zone` when some end's zone is kept).
	fn section_names(zones: bool) -> Vec<&'static str> {
		let mut v = vec!["end.c", "end.x", "end.y", "end.z", "end.zf", "a", "b", "m", "yd", "cost"];
		if zones {
			v.push("end.zone");
		}
		v.extend(["cell.off", "cell.key", "cell.yd", "cell.has"]);
		v
	}

	/// Whether a file's header (its sections taken out) is the one encode writes for these models.
	fn header_as_encoded(header: &Map<String, Value>, models: &[Model]) -> bool {
		let keys: Vec<&str> = header.keys().map(String::as_str).collect();
		let Some(Value::Array(ms)) = header.get("models") else { return false };
		keys == ["contentId", "schema", "kind", "models"]
			&& header["schema"] == json!(STORE_SCHEMA)
			&& header["kind"] == json!("walkstore")
			&& ms.len() == models.len()
			&& ms.iter().zip(models).all(|(v, m)| {
				let Some(o) = v.as_object() else { return false };
				o.keys().map(String::as_str).eq(["key", "grid", "params"]) && o["key"] == json!(m.key()) && o["grid"] == json!(m.grid) && o["params"] == json!(m.params)
			})
	}
}

/// A slot of the merge order (write_to): set for a new or replaced answer (`over[o]` in bits 32-62), its
/// key's place in the file in bits 0-31 (`NO_AT`: none); clear for the file's answer i.
const NEW: u64 = 1 << 63;
const NO_AT: u64 = 0xFFFF_FFFF;

/// write_to's merge: the new answers' keys sorted (model, from, to), every answer's slot in file order,
/// and the runs of one model (model, from, to) of the slots.
struct Order {
	over: Vec<Key>,
	slots: Vec<u64>,
	runs: Vec<(u32, usize, usize)>,
}

/// A per-answer column of the store's file.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Col {
	A,
	B,
	M,
	Yd,
	Cost,
	Off,
	CellKey,
	CellYd,
	Has,
}

/// An answer's zone cells as the file keeps them: none, the store's own (a new walk's), or the file's.
enum Cells<'a> {
	None,
	Kept(&'a [(u32, f32)]),
	File(&'a [u32], &'a [f32]),
}

impl Cells<'_> {
	fn len(&self) -> usize {
		match self {
			Cells::None => 0,
			Cells::Kept(c) => c.len(),
			Cells::File(k, _) => k.len(),
		}
	}
	fn each(&self, mut f: impl FnMut(u32, f32)) {
		match self {
			Cells::None => {}
			Cells::Kept(c) => c.iter().for_each(|&(k, y)| f(k, y)),
			Cells::File(k, y) => k.iter().zip(y.iter()).for_each(|(&k, &y)| f(k, y)),
		}
	}
}

/// Bytes gathered into pieces of CHUNK for a psbn stream's sink.
struct Chunks<'a> {
	buf: Vec<u8>,
	out: &'a mut dyn FnMut(&[u8]),
}

impl<'a> Chunks<'a> {
	const CHUNK: usize = 1 << 16;
	fn new(out: &'a mut dyn FnMut(&[u8])) -> Self {
		Chunks { buf: Vec::with_capacity(Self::CHUNK), out }
	}
	fn put(&mut self, b: &[u8]) {
		if self.buf.len() + b.len() > Self::CHUNK {
			self.flush();
		}
		self.buf.extend_from_slice(b);
	}
	fn flush(&mut self) {
		if !self.buf.is_empty() {
			(self.out)(&self.buf);
			self.buf.clear();
		}
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	fn end(x: f64) -> End {
		End::new(0, x, 2.0 * x, Some(1.0), None)
	}

	/// A store as a build leaves it: two models, answers with and without zone cells, a zone kept.
	fn sample() -> WalkStore {
		let mut s = WalkStore::new();
		let (m0, m1) = (s.model(&Model { grid: "g".into(), params: "base".into() }), s.model(&Model { grid: "g".into(), params: "danger".into() }));
		let mut r = Fixed(vec![]);
		let asks: Vec<(End, End, Profile)> = (0..40).map(|i| (end(i as f64), end((i * 7 % 13) as f64 + 0.5), Profile { model: if i % 3 == 0 { m1 } else { m0 }, base: None })).collect();
		s.walks_cells(&asks, &mut r, true);
		s.set_zone(&end(3.0), 1519);
		s
	}

	/// Answers yards from the ends, zone cells for the walkable ones.
	struct Fixed(Vec<usize>);
	impl Router for Fixed {
		fn walks(&mut self, model: &Model, pairs: &[(End, End)], cells: bool) -> Answers {
			self.0.push(pairs.len());
			let k = if model.params == "base" { 1.0 } else { 2.0 };
			pairs
				.iter()
				.map(|(a, b)| {
					let y = (b.x - a.x) * k;
					if y < 0.0 {
						(Answer::NONE, None)
					} else {
						(Answer { yd: y, cost: y / 7.0 }, cells.then(|| vec![(a.x as u32, y as f32), (b.x as u32, 1.5)].into_boxed_slice()))
					}
				})
				.collect()
		}
	}

	#[test]
	fn a_read_store_encodes_to_its_file() {
		let s = sample();
		assert!(s.changed());
		let file = s.encode();
		let r = WalkStore::decode(&file).unwrap();
		assert!(!r.changed(), "read as written: unchanged");
		assert_eq!(r.len(), s.len());
		assert_eq!(r.encode(), file);
		assert_eq!(r.cells_kept(), s.cells_kept());
		assert_eq!(r.zone(&end(3.0)), Some(1519));
	}

	#[test]
	fn what_changes_merges_with_the_file() {
		let file = sample().encode();
		let mut s = WalkStore::decode(&file).unwrap();
		let m0 = s.model(&Model { grid: "g".into(), params: "base".into() });
		assert!(!s.changed(), "a model the store has changes nothing");
		s.set_zone(&end(3.0), 1519);
		assert!(!s.changed(), "the same zone changes nothing");
		let before = s.get(&end(1.0), &end(7.5), Profile { model: m0, base: None }).unwrap();
		// Replaced, added, and a new end; the stored walk of a pair asked again is the store's.
		s.put(&end(1.0), &end(7.5), m0, Answer { yd: 99.0, cost: 9.0 });
		s.put(&end(100.0), &end(1.0), m0, Answer { yd: 5.0, cost: 1.0 });
		assert!(s.changed());
		assert_eq!(s.len(), WalkStore::decode(&file).unwrap().len() + 1);
		let mut r = Fixed(vec![]);
		let w = s.walks_cells(&[(end(1.0), end(7.5), Profile { model: m0, base: None })], &mut r, false);
		assert_eq!((w.answers[0], w.stored, r.0.len()), (Answer { yd: 99.0, cost: 9.0 }, 1, 0));
		assert_ne!(before.yd, 99.0);
		// The same store built in one go (no file) writes the same bytes.
		let mut fresh = sample();
		fresh.put(&end(1.0), &end(7.5), m0, Answer { yd: 99.0, cost: 9.0 });
		fresh.put(&end(100.0), &end(1.0), m0, Answer { yd: 5.0, cost: 1.0 });
		assert_eq!(s.encode(), fresh.encode());
		let again = WalkStore::decode(&s.encode()).unwrap();
		assert_eq!(again.get(&end(100.0), &end(1.0), Profile { model: m0, base: None }), Some(Answer { yd: 5.0, cost: 1.0 }));
		assert_eq!(again.encode(), s.encode());
	}

	#[test]
	fn a_walkable_walk_without_cells_is_asked_again_and_dropped_cells_stay_dropped() {
		let mut s = WalkStore::decode(&sample().encode()).unwrap();
		let m0 = s.model(&Model { grid: "g".into(), params: "base".into() });
		// A not walkable answer over a file's walk drops its cells; then asked with cells it is the store's.
		let ends = [end(1.0), end(7.5)];
		s.import_table(&[-1.0], &[-1.0], &[0], &[1], &ends, m0, 1.0, Some((&[0, 0], &[])));
		let mut r = Fixed(vec![]);
		let w = s.walks_cells(&[(end(1.0), end(7.5), Profile { model: m0, base: None })], &mut r, true);
		assert_eq!((w.answers[0], w.cells[0].is_none(), r.0.len()), (Answer::NONE, true, 0));
		// A walkable one without cells is asked again.
		s.put(&end(2.0), &end(9.0), m0, Answer { yd: 7.0, cost: 1.0 });
		let w = s.walks_cells(&[(end(2.0), end(9.0), Profile { model: m0, base: None })], &mut r, true);
		assert_eq!((w.routed, w.cells[0].is_some()), (1, true));
		let back = WalkStore::decode(&s.encode()).unwrap();
		assert_eq!(back.encode(), s.encode());
		assert_eq!(back.cells_kept(), s.cells_kept());
	}

	#[test]
	fn a_file_laid_out_otherwise_is_written_again() {
		let file = sample().encode();
		let mut padded = file.clone();
		padded.extend([0u8; 8]);
		let s = WalkStore::decode(&padded).unwrap();
		assert!(s.changed(), "bytes past the last section: written again");
		assert_eq!(s.encode(), file);
		let bin = Bin::parse(&file[..]).unwrap();
		let mut off = bin.u32s("cell.off").unwrap();
		let shift = |v: &mut Vec<u32>| v.iter_mut().for_each(|x| *x += 2);
		shift(&mut off);
		let (ck, cy) = (bin.u32s("cell.key").unwrap(), bin.f32s("cell.yd").unwrap());
		let (ck, cy): (Vec<u32>, Vec<f32>) = ([7, 7].into_iter().chain(ck).collect(), [0.5, 0.5].into_iter().chain(cy).collect());
		let mut sections = Vec::new();
		for name in WalkStore::section_names(true) {
			sections.push(match name {
				"end.c" | "end.zone" => Section::i32s(name, &bin.i32s(name).unwrap()),
				"a" | "b" | "m" => Section::u32s(name, &bin.u32s(name).unwrap()),
				"cell.off" => Section::u32s(name, &off),
				"cell.key" => Section::u32s(name, &ck),
				"cell.yd" => Section::f32s(name, &cy),
				"cell.has" => Section::u8s(name, &bin.u8s(name).unwrap()),
				_ => Section::f64s(name, &bin.f64s(name).unwrap()),
			});
		}
		let s = WalkStore::decode(&psbn::encode(&bin.header, &sections).0).unwrap();
		assert!(s.changed(), "zone cells not from the first: written again");
		assert_eq!(s.encode(), file);
	}

	#[test]
	fn a_file_out_of_order_reads_as_before_and_is_written_again() {
		let file = sample().encode();
		let bin = Bin::parse(&file[..]).unwrap();
		// The same sections with the answers reversed (a file the store never writes).
		let rev = |v: Vec<u32>| v.into_iter().rev().collect::<Vec<_>>();
		let (a, b, m) = (rev(bin.u32s("a").unwrap()), rev(bin.u32s("b").unwrap()), rev(bin.u32s("m").unwrap()));
		let (yd, cost): (Vec<f64>, Vec<f64>) = (bin.f64s("yd").unwrap().into_iter().rev().collect(), bin.f64s("cost").unwrap().into_iter().rev().collect());
		let (off, ck, cy, has) = (bin.u32s("cell.off").unwrap(), bin.u32s("cell.key").unwrap(), bin.f32s("cell.yd").unwrap(), bin.u8s("cell.has").unwrap());
		let n = a.len();
		let (mut off2, mut ck2, mut cy2, mut has2) = (vec![0u32], Vec::new(), Vec::new(), Vec::new());
		for i in (0..n).rev() {
			has2.push(has[i]);
			ck2.extend_from_slice(&ck[off[i] as usize..off[i + 1] as usize]);
			cy2.extend_from_slice(&cy[off[i] as usize..off[i + 1] as usize]);
			off2.push(ck2.len() as u32);
		}
		let mut sections = Vec::new();
		for name in ["end.c", "end.x", "end.y", "end.z", "end.zf"] {
			sections.push(if name == "end.c" { Section::i32s(name, &bin.i32s(name).unwrap()) } else { Section::f64s(name, &bin.f64s(name).unwrap()) });
		}
		sections.extend([Section::u32s("a", &a), Section::u32s("b", &b), Section::u32s("m", &m), Section::f64s("yd", &yd), Section::f64s("cost", &cost)]);
		sections.push(Section::i32s("end.zone", &bin.i32s("end.zone").unwrap()));
		sections.extend([Section::u32s("cell.off", &off2), Section::u32s("cell.key", &ck2), Section::f32s("cell.yd", &cy2), Section::u8s("cell.has", &has2)]);
		let shuffled = psbn::encode(&bin.header, &sections).0;
		let s = WalkStore::decode(&shuffled).unwrap();
		assert!(s.changed(), "a file out of order is written again");
		assert_eq!(s.encode(), file);
	}

	/// encode as it was up to 0.3.8: the merged answers built whole in memory, then every section's bytes,
	/// then the file's (write_to streams the same file without them).
	fn merged_encode(s: &WalkStore) -> Vec<u8> {
		#[derive(Default)]
		struct Merged {
			a: Vec<u32>,
			b: Vec<u32>,
			m: Vec<u32>,
			yd: Vec<f64>,
			cost: Vec<f64>,
			off: Vec<u32>,
			ck: Vec<u32>,
			cy: Vec<f32>,
			has: Vec<u8>,
		}
		let mut out = Merged { off: vec![0], ..Default::default() };
		let push = |out: &mut Merged, (a, b, m): Key, x: Answer, c: Option<&[(u32, f32)]>| {
			out.a.push(a);
			out.b.push(b);
			out.m.push(m);
			out.yd.push(x.yd);
			out.cost.push(x.cost);
			out.has.push(c.is_some() as u8);
			for &(k, y) in c.unwrap_or_default() {
				out.ck.push(k);
				out.cy.push(y);
			}
			out.off.push(out.ck.len() as u32);
		};
		let mut over: Vec<Key> = s.answers.keys().copied().collect();
		over.sort_unstable_by_key(|&(a, b, m)| (m, a, b));
		let models = s.base.range.len().max(over.last().map_or(0, |k| k.2 as usize + 1));
		let mut o = 0;
		for m in 0..models as u32 {
			let (lo, hi) = s.base.range.get(m as usize).copied().unwrap_or((0, 0));
			let mut i = lo;
			let o_end = o + over[o..].iter().take_while(|k| k.2 == m).count();
			while i < hi || o < o_end {
				let base_ab = (i < hi).then(|| s.base.ab[i]);
				let new_ab = (o < o_end).then(|| (over[o].0 as u64) << 32 | over[o].1 as u64);
				let (k, x, at) = match (base_ab, new_ab) {
					(Some(x), Some(y)) if x == y => {
						i += 1;
						o += 1;
						(over[o - 1], s.answers[&over[o - 1]], Some(i - 1))
					}
					(Some(x), Some(y)) if x > y => {
						o += 1;
						(over[o - 1], s.answers[&over[o - 1]], None)
					}
					(None, Some(_)) => {
						o += 1;
						(over[o - 1], s.answers[&over[o - 1]], None)
					}
					_ => {
						let ab = s.base.ab[i];
						i += 1;
						(((ab >> 32) as u32, ab as u32, m), s.base.answer(i - 1), Some(i - 1))
					}
				};
				push(&mut out, k, x, s.cells_of(k, at).as_deref());
			}
		}
		let mut header = Map::new();
		header.insert("schema".into(), json!(STORE_SCHEMA));
		header.insert("kind".into(), json!("walkstore"));
		header.insert("models".into(), Value::Array(s.models.iter().map(|m| json!({ "key": m.key(), "grid": m.grid, "params": m.params })).collect()));
		let e = &s.ends;
		let mut sections = vec![
			Section::i32s("end.c", &e.iter().map(|x| x.c).collect::<Vec<_>>()),
			Section::f64s("end.x", &e.iter().map(|x| x.x).collect::<Vec<_>>()),
			Section::f64s("end.y", &e.iter().map(|x| x.y).collect::<Vec<_>>()),
			Section::f64s("end.z", &e.iter().map(|x| x.z).collect::<Vec<_>>()),
			Section::f64s("end.zf", &e.iter().map(|x| x.zf).collect::<Vec<_>>()),
			Section::u32s("a", &out.a),
			Section::u32s("b", &out.b),
			Section::u32s("m", &out.m),
			Section::f64s("yd", &out.yd),
			Section::f64s("cost", &out.cost),
		];
		if !s.zones.is_empty() {
			sections.push(Section::i32s("end.zone", &(0..e.len() as u32).map(|i| s.zones.get(&i).map_or(-1, |&z| z as i32)).collect::<Vec<_>>()));
		}
		sections.push(Section::u32s("cell.off", &out.off));
		sections.push(Section::u32s("cell.key", &out.ck));
		sections.push(Section::f32s("cell.yd", &out.cy));
		sections.push(Section::u8s("cell.has", &out.has));
		psbn::encode(&header, &sections).0
	}

	// The store's save streams its file (write_to: the merge order only; an Alliance grid store's save went past
	// a 10 GB budget building it in memory): byte for byte the file the in-memory merge wrote, for a store
	// built in one go, one read back, and one whose file answers were replaced, added to, given and stripped of
	// zone cells; and through a writer that takes a few bytes at a time.
	#[test]
	fn the_streamed_file_is_the_merged_one_byte_for_byte() {
		let fresh = sample();
		let file = fresh.encode();
		assert_eq!(file, merged_encode(&fresh), "built in one go");
		let mut s = WalkStore::decode(&file).unwrap();
		assert_eq!(s.encode(), merged_encode(&s), "read back, unchanged");
		let m0 = s.model(&Model { grid: "g".into(), params: "base".into() });
		let m1 = s.model(&Model { grid: "g".into(), params: "danger".into() });
		s.put(&end(1.0), &end(7.5), m0, Answer { yd: 99.0, cost: 9.0 });
		s.put(&end(100.0), &end(1.0), m1, Answer { yd: 5.0, cost: 1.0 });
		s.import_table(&[-1.0], &[-1.0], &[0], &[1], &[end(2.0), end(9.5)], m0, 1.0, Some((&[0, 0], &[])));
		let mut r = Fixed(vec![]);
		s.walks_cells(&[(end(200.0), end(3.0), Profile { model: m1, base: None })], &mut r, true);
		s.set_zone(&end(200.0), 1537);
		assert!(s.changed());
		let merged = merged_encode(&s);
		assert_eq!(s.encode(), merged, "replaced, added, cells kept and dropped");
		/// A writer that takes at most 3 bytes a call.
		struct Trickle(Vec<u8>);
		impl std::io::Write for Trickle {
			fn write(&mut self, b: &[u8]) -> std::io::Result<usize> {
				let n = b.len().min(3);
				self.0.extend_from_slice(&b[..n]);
				Ok(n)
			}
			fn flush(&mut self) -> std::io::Result<()> {
				Ok(())
			}
		}
		let mut t = Trickle(Vec::new());
		s.write_to(&mut t).unwrap();
		assert_eq!(t.0, merged, "through a writer of short writes");
	}
}
