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

/// Who answers the pairs the store lacks.
pub trait Router {
	/// One answer per pair, in order, for this model; with `cells`, a walkable answer's zone cells.
	fn walks(&mut self, model: &Model, pairs: &[(End, End)], cells: bool) -> Vec<(Answer, Option<ZoneCells>)>;
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
	answers: FxHashMap<(u32, u32, u32), Answer>,
	cells: FxHashMap<(u32, u32, u32), ZoneCells>,
	/// Pairs asked of the router since the store was opened.
	pub asked: usize,
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
		self.answers.len()
	}
	pub fn is_empty(&self) -> bool {
		self.answers.is_empty()
	}
	pub fn models(&self) -> &[Model] {
		&self.models
	}

	pub fn end(&mut self, e: &End) -> u32 {
		let k = e.bits();
		if let Some(&i) = self.end_ix.get(&k) {
			return i;
		}
		let i = self.ends.len() as u32;
		self.ends.push(*e);
		self.end_ix.insert(k, i);
		i
	}

	fn end_of(&self, e: &End) -> Option<u32> {
		self.end_ix.get(&e.bits()).copied()
	}

	pub fn model(&mut self, m: &Model) -> u32 {
		if let Some(&i) = self.model_ix.get(m) {
			return i;
		}
		let i = self.models.len() as u32;
		self.models.push(m.clone());
		self.model_ix.insert(m.clone(), i);
		i
	}

	pub fn put(&mut self, a: &End, b: &End, model: u32, ans: Answer) {
		let (a, b) = (self.end(a), self.end(b));
		self.answers.insert((a, b, model), ans);
	}

	fn put_ix(&mut self, a: u32, b: u32, model: u32, ans: Answer) {
		self.answers.insert((a, b, model), ans);
	}

	/// The stored walk of (a, b) in the profile (its model, else its base), or None.
	pub fn get(&self, a: &End, b: &End, p: Profile) -> Option<Answer> {
		let (a, b) = (self.end_of(a)?, self.end_of(b)?);
		self.get_ix(a, b, p)
	}

	fn get_ix(&self, a: u32, b: u32, p: Profile) -> Option<Answer> {
		self.key_ix(a, b, p).map(|k| self.answers[&k])
	}

	/// The key the profile's answer of (a, b) is kept under (its model's, else its base's).
	fn key_ix(&self, a: u32, b: u32, p: Profile) -> Option<(u32, u32, u32)> {
		if self.answers.contains_key(&(a, b, p.model)) {
			return Some((a, b, p.model));
		}
		p.base.map(|m| (a, b, m)).filter(|k| self.answers.contains_key(k))
	}

	/// Answers for the asks: the store's, and the router's for the pairs it lacks (asked once per
	/// distinct pair, one call per model, then kept).
	pub fn walks(&mut self, asks: &[(End, End, Profile)], router: &mut dyn Router) -> Walks {
		self.walks_cells(asks, router, false)
	}

	/// walks(), with each walkable answer's zone cells: a stored walk without them is asked again.
	pub fn walks_cells(&mut self, asks: &[(End, End, Profile)], router: &mut dyn Router, cells: bool) -> Walks {
		let mut answers = vec![Answer::NONE; asks.len()];
		let mut out_cells: Vec<Option<ZoneCells>> = vec![None; asks.len()];
		let mut missing: FxHashMap<u32, Vec<(u32, u32)>> = FxHashMap::default();
		let mut pending: Vec<(usize, u32, u32, u32)> = Vec::new();
		let mut stored = 0;
		for (i, (a, b, p)) in asks.iter().enumerate() {
			let (ai, bi) = (self.end(a), self.end(b));
			let k = self.key_ix(ai, bi, *p);
			let have = k.filter(|k| !cells || self.answers[k].yd < 0.0 || !self.answers[k].yd.is_finite() || self.cells.contains_key(k));
			match have {
				Some(k) => {
					answers[i] = self.answers[&k];
					if cells {
						out_cells[i] = self.cells.get(&k).cloned();
					}
					stored += 1;
				}
				None => {
					missing.entry(p.model).or_default().push((ai, bi));
					pending.push((i, ai, bi, p.model));
				}
			}
		}
		let mut routed = 0;
		let mut models: Vec<_> = missing.into_iter().collect();
		models.sort_by_key(|x| x.0);
		for (m, mut pairs) in models {
			pairs.sort_unstable();
			pairs.dedup();
			let ends: Vec<(End, End)> = pairs.iter().map(|&(a, b)| (self.ends[a as usize], self.ends[b as usize])).collect();
			let got = router.walks(&self.models[m as usize], &ends, cells);
			assert_eq!(got.len(), pairs.len(), "router: one answer per pair");
			routed += pairs.len();
			for (&(a, b), (x, c)) in pairs.iter().zip(got) {
				self.put_ix(a, b, m, x);
				if let Some(c) = c {
					self.cells.insert((a, b, m), c);
				}
			}
		}
		self.asked += routed;
		for (i, a, b, m) in pending {
			answers[i] = self.answers[&(a, b, m)];
			if cells {
				out_cells[i] = self.cells.get(&(a, b, m)).cloned();
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
					self.answers.entry((ix[a as usize], ix[b as usize], m)).or_insert(Answer::UNWALKABLE);
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
				if ans.yd >= 0.0 {
					let v: ZoneCells = x[off[i] as usize..off[i + 1] as usize].chunks_exact(2).map(|p| (p[0] as u32, p[1])).collect();
					self.cells.insert((a, b, model), v);
				} else {
					self.cells.remove(&(a, b, model));
				}
			}
		}
	}

	pub fn cells_kept(&self) -> usize {
		self.cells.len()
	}

	/// The store as a PSBN file (header: schema, models; sections: ends and answers sorted by
	/// model, from, to).
	pub fn encode(&self) -> Vec<u8> {
		let mut keys: Vec<_> = self.answers.keys().copied().collect();
		keys.sort_unstable_by_key(|&(a, b, m)| (m, a, b));
		let mut header = Map::new();
		header.insert("schema".into(), json!(STORE_SCHEMA));
		header.insert("kind".into(), json!("walkstore"));
		header.insert("models".into(), Value::Array(self.models.iter().map(|m| json!({ "key": m.key(), "grid": m.grid, "params": m.params })).collect()));
		let e = &self.ends;
		let sections = vec![
			Section::i32s("end.c", &e.iter().map(|x| x.c).collect::<Vec<_>>()),
			Section::f64s("end.x", &e.iter().map(|x| x.x).collect::<Vec<_>>()),
			Section::f64s("end.y", &e.iter().map(|x| x.y).collect::<Vec<_>>()),
			Section::f64s("end.z", &e.iter().map(|x| x.z).collect::<Vec<_>>()),
			Section::f64s("end.zf", &e.iter().map(|x| x.zf).collect::<Vec<_>>()),
			Section::u32s("a", &keys.iter().map(|k| k.0).collect::<Vec<_>>()),
			Section::u32s("b", &keys.iter().map(|k| k.1).collect::<Vec<_>>()),
			Section::u32s("m", &keys.iter().map(|k| k.2).collect::<Vec<_>>()),
			Section::f64s("yd", &keys.iter().map(|k| self.answers[k].yd).collect::<Vec<_>>()),
			Section::f64s("cost", &keys.iter().map(|k| self.answers[k].cost).collect::<Vec<_>>()),
		];
		let mut sections = sections;
		let mut off = vec![0u32];
		let (mut ck, mut cy) = (Vec::new(), Vec::new());
		let mut has = Vec::with_capacity(keys.len());
		for k in &keys {
			has.push(self.cells.contains_key(k) as u8);
			if let Some(c) = self.cells.get(k) {
				for &(key, y) in c.iter() {
					ck.push(key);
					cy.push(y);
				}
			}
			off.push(ck.len() as u32);
		}
		sections.push(Section::u32s("cell.off", &off));
		sections.push(Section::u32s("cell.key", &ck));
		sections.push(Section::f32s("cell.yd", &cy));
		sections.push(Section::u8s("cell.has", &has));
		psbn::encode(&header, &sections).0
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
		let (a, b, m, yd, cost) = (bin.u32s("a")?, bin.u32s("b")?, bin.u32s("m")?, bin.f64s("yd")?, bin.f64s("cost")?);
		s.answers.reserve(a.len());
		for i in 0..a.len() {
			s.answers.insert((a[i], b[i], m[i]), Answer { yd: yd[i], cost: cost[i] });
		}
		if bin.has("cell.off") {
			let (off, ck, cy, has) = (bin.u32s("cell.off")?, bin.u32s("cell.key")?, bin.f32s("cell.yd")?, bin.u8s("cell.has")?);
			for i in 0..a.len() {
				let (lo, hi) = (off[i] as usize, off[i + 1] as usize);
				if has[i] != 0 {
					s.cells.insert((a[i], b[i], m[i]), (lo..hi).map(|x| (ck[x], cy[x])).collect());
				}
			}
		}
		Ok(s)
	}
}
