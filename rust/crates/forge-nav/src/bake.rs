//! Baked guide legs (data/local/research/NavArchitecture.md §4.1 layer L1, §4.5): the walk into a
//! guide step, routed at build time on the hybrid backend (Leffe's navigation maps, our grid where
//! his have no way or a detour, as the walks stage chooses: hybrid.rs), simplified to its corners
//! with each segment's move and floor, and the ground's height every STRIP_YD along it, packed as
//! one printable string the addon decodes (addon/Polestar/Nav/Baked.lua).
//!
//! A leg: the drawn way; 3D Douglas-Peucker at SIMPLIFY_YD that never drops a corner where the move
//! or the floor changes, or a hop (jump, drop, climb, lift) starts or ends; then the ground every
//! STRIP_YD along the kept line: our grid's surface nearest the line's own height there (its
//! heights are the collision mesh's), else the drawing backend's, else the line's. A leg that does
//! not route, or runs more than DETOUR times the straight line without passing a named chokepoint
//! (Polestar_Nav's Chokepoints.lua), is not baked: it goes to the QA list.
//!
//! The string: base-64 digits (A-Z a-z 0-9 + /), each 5 bits of a varint plus a continuation bit
//! (32), signed values zigzagged. Version 2: 2, n; per point dx, dy (QXY yd) and dz (QZ yd) from the
//! previous one (the first from 0); n-1 segment moves (grid::cls: 0 walk, 1 steep, 2 swim, 3 jump,
//! 4 drop, 5 indoor, 6 climb, 7 lift); n-1 segment floors (the surface's index in its column on
//! the backend that drew it, 0 the lowest); the tail (QZ yd from the last point to the goal); m;
//! then the strip's m ground heights as changes in QZ yd from the one before (the first from the
//! first point's z), one digit per token: 32..63 a run of 1..32 unchanged heights; 0..24 two
//! changes a, b in -2..2 (digit (a + 2) * 5 + b + 2); 25..30 one change of -3, -2, -1, 1, 2 or 3;
//! 31 one change whose zig value follows as a varint. The encoder takes a run when two level
//! samples come next, else a pair when it can, else a single (on our grid's heights about 0.55 of
//! a digit per sample, where one varint per change took 1).
//! Version 1 (pack format 6) has no floors and its strip one zigzagged varint per change.

use crate::cost::{Profile, RUN};
use crate::f4::{Floor, Move, Opts, Route, Style, Validate, F4, P};
use crate::grid::{cell_of, cls, flag, Grid, TILE_CELLS};
use crate::legs::SnapAsk;
use crate::space::WayCell;
use crate::walker::Walker;

pub const SIMPLIFY_YD: f64 = 4.0;
pub const STRIP_YD: f64 = 2.0;
pub const DETOUR: f64 = 1.5;
pub const PASSAGE_YD: f64 = 15.0;
pub const QXY: f64 = 0.5;
pub const QZ: f64 = 0.25;
pub const VERSION: u32 = 2;
/// The grid's surface nearest the line's height is its ground when within this many yards of it.
pub const GROUND_YD: f64 = 8.0;

const DIGITS: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

/// A drawn way: points, and per segment (one fewer) its move and floor.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Way {
	pub pts: Vec<[f64; 3]>,
	pub cls: Vec<u8>,
	pub floor: Vec<u8>,
}

/// A packed leg (what the string holds).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Leg {
	pub pts: Vec<[f64; 3]>,
	pub cls: Vec<u8>,
	pub floor: Vec<u8>,
	pub tail: f64,
	pub strip: Vec<f64>,
}

fn is_hop(c: u8) -> bool {
	matches!(c, cls::JUMP | cls::FALL | cls::CLIMB | cls::LIFT)
}

/// The move of a format-4 motion arc (or a ride on Leffe's lift layer) as a segment class.
pub fn move_class(m: Move) -> u8 {
	match m {
		Move::Walk | Move::Motion => cls::WALK,
		Move::Swim => cls::SWIM,
		Move::Jump => cls::JUMP,
		Move::Drop => cls::FALL,
		Move::Climb => cls::CLIMB,
		Move::Lift => cls::LIFT,
	}
}

/// A format-4 segment's class by his maps alone: its move, and for a walk or motion step on his steep slope (3: a
/// terrain triangle from 40°) or indoor ground (4 indoor, 5 indoor city) STEEP or INDOOR. Way::onto_grid replaces it
/// with our grid's ground wherever our grid has a surface there.
pub fn leg_class(m: Move, ground: u8) -> u8 {
	match (move_class(m), ground) {
		(cls::WALK, 3) => cls::STEEP,
		(cls::WALK, 4 | 5) => cls::INDOOR,
		(c, _) => c,
	}
}

impl Way {
	/// A grid way (Walker::route_path's cells): each segment takes the class of the step into its
	/// end and the floor of its start.
	pub fn from_cells(cells: &[WayCell]) -> Way {
		let pts = cells.iter().map(|c| [c.x, c.y, c.z]).collect();
		let cls = cells.windows(2).map(|w| w[1].cls).collect();
		let floor = cells.windows(2).map(|w| w[0].floor).collect();
		Way { pts, cls, floor }
	}

	/// A format-4 route: its legs' classes (leg_class) and floors over the points they span; a point without a
	/// height takes its neighbours' (linear along the way), or `height` where none has one. The floors are his maps'
	/// numbering: onto_grid puts them on ours.
	pub fn from_route(r: &Route, height: impl Fn(f64, f64) -> Option<f64>) -> Option<Way> {
		if !r.ok || r.points.len() < 2 {
			return None;
		}
		let n = r.points.len();
		let mut cls = vec![cls::WALK; n - 1];
		let mut floor = vec![0u8; n - 1];
		for l in &r.legs {
			for i in l.from..l.to.min(n - 1) {
				cls[i] = leg_class(l.kind, l.ground);
				floor[i] = l.floor.unwrap_or(0).min(255) as u8;
			}
		}
		let mut pts: Vec<[f64; 3]> = r.points.clone();
		fill_heights(&mut pts, height);
		Some(Way { pts, cls, floor })
	}

	/// A way drawn on Leffe's maps, put on our grid's surfaces (`surface`: our grid's surface at (x, y) nearest
	/// height z, within GROUND_YD -> its index in its column, its height, its flags). His floor numbers are his maps'
	/// own (a different run of the grid adds surfaces in places), so each segment takes the index of our surface
	/// nearest its start; his heights are 2 yd steps (floors whole yards), so each corner between the ends stands on
	/// our surface nearest it. A walking segment takes its class from our grid's ground at its matched ends, as grid
	/// ways do (move.js segmentClass: indoor when either end is, steep on a steep column), not from his ground
	/// classes (his steep is from 40°, ours from 50°). A hop's ends (jump, drop, climb, ride: his exact heights) keep
	/// his height, and where ours has no surface near, his floor, height and class stay.
	pub fn onto_grid(&mut self, surface: impl Fn(f64, f64, f64) -> Option<(u8, f64, u8)>) {
		let n = self.pts.len();
		let his = self.pts.clone();
		let ours: Vec<_> = his.iter().map(|p| surface(p[0], p[1], p[2])).collect();
		for s in 0..n.saturating_sub(1) {
			let Some((f, _, fa)) = ours[s] else { continue };
			self.floor[s] = f;
			if matches!(self.cls[s], cls::WALK | cls::STEEP | cls::INDOOR) {
				let fl = fa | ours[s + 1].map_or(0, |o| o.2);
				self.cls[s] = if fl & flag::INDOOR != 0 {
					cls::INDOOR
				} else if fl & flag::STEEP != 0 {
					cls::STEEP
				} else {
					cls::WALK
				};
			}
		}
		for i in 1..n.saturating_sub(1) {
			if is_hop(self.cls[i - 1]) || is_hop(self.cls[i]) {
				continue;
			}
			if let Some((_, z, _)) = ours[i] {
				self.pts[i][2] = z;
			}
		}
	}

	/// The way's 3D length.
	pub fn yards(&self) -> f64 {
		self.pts.windows(2).map(|w| dist3(&w[0], &w[1])).sum()
	}
}

fn dist3(a: &[f64; 3], b: &[f64; 3]) -> f64 {
	((b[0] - a[0]).powi(2) + (b[1] - a[1]).powi(2) + (b[2] - a[2]).powi(2)).sqrt()
}

/// Unknown heights (NaN): interpolated along the way between known ones, the ends held; with none
/// known, `height` at each point (else 0).
fn fill_heights(pts: &mut [[f64; 3]], height: impl Fn(f64, f64) -> Option<f64>) {
	let known: Vec<usize> = (0..pts.len()).filter(|&i| pts[i][2].is_finite()).collect();
	if known.is_empty() {
		for p in pts.iter_mut() {
			p[2] = height(p[0], p[1]).unwrap_or(0.0);
		}
		return;
	}
	for i in 0..pts.len() {
		if pts[i][2].is_finite() {
			continue;
		}
		let before = known.iter().rev().find(|&&k| k < i).copied();
		let after = known.iter().find(|&&k| k > i).copied();
		pts[i][2] = match (before, after) {
			(Some(a), Some(b)) => {
				let along = |x: usize, y: usize| (x..y).map(|k| ((pts[k + 1][0] - pts[k][0]).powi(2) + (pts[k + 1][1] - pts[k][1]).powi(2)).sqrt()).sum::<f64>();
				let (da, total) = (along(a, i), along(a, b));
				let t = if total > 0.0 { da / total } else { 0.0 };
				pts[a][2] + (pts[b][2] - pts[a][2]) * t
			}
			(Some(a), None) => pts[a][2],
			(None, Some(b)) => pts[b][2],
			(None, None) => 0.0,
		};
	}
}

/// Douglas-Peucker in 3D at SIMPLIFY_YD, keeping every corner where the class or floor changes, a
/// hop starts or ends, or the height jumps more than FLOOR_YD. A kept segment takes the class and
/// floor of the first raw segment it stands for.
pub fn simplify(w: &Way) -> Way {
	let n = w.pts.len();
	if n < 3 {
		return w.clone();
	}
	let mut keep = vec![false; n];
	keep[0] = true;
	keep[n - 1] = true;
	for i in 1..n - 1 {
		let (a, b) = (i - 1, i);
		if w.cls[a] != w.cls[b] || w.floor[a] != w.floor[b] || is_hop(w.cls[a]) || is_hop(w.cls[b]) {
			keep[i] = true;
		}
	}
	fn seg_dist(p: &[f64; 3], a: &[f64; 3], b: &[f64; 3]) -> f64 {
		let ab = [b[0] - a[0], b[1] - a[1], b[2] - a[2]];
		let ap = [p[0] - a[0], p[1] - a[1], p[2] - a[2]];
		let l = ab[0] * ab[0] + ab[1] * ab[1] + ab[2] * ab[2];
		let t = if l > 0.0 { ((ap[0] * ab[0] + ap[1] * ab[1] + ap[2] * ab[2]) / l).clamp(0.0, 1.0) } else { 0.0 };
		((ap[0] - t * ab[0]).powi(2) + (ap[1] - t * ab[1]).powi(2) + (ap[2] - t * ab[2]).powi(2)).sqrt()
	}
	// Iterative (a long cell path would nest deep).
	let mut stack = Vec::new();
	let mut a = 0;
	for i in 1..n {
		if keep[i] {
			stack.push((a, i));
			a = i;
		}
	}
	while let Some((a, b)) = stack.pop() {
		let mut best = None;
		let mut bd = SIMPLIFY_YD;
		for i in a + 1..b {
			let d = seg_dist(&w.pts[i], &w.pts[a], &w.pts[b]);
			if d > bd {
				bd = d;
				best = Some(i);
			}
		}
		if let Some(i) = best {
			keep[i] = true;
			stack.push((a, i));
			stack.push((i, b));
		}
	}
	let idx: Vec<usize> = (0..n).filter(|&i| keep[i]).collect();
	Way { pts: idx.iter().map(|&i| w.pts[i]).collect(), cls: idx[..idx.len() - 1].iter().map(|&i| w.cls[i]).collect(), floor: idx[..idx.len() - 1].iter().map(|&i| w.floor[i]).collect() }
}

/// The ground every STRIP_YD along the polyline (2D distance, the first at its start): `ground(x, y,
/// z)` there, z the line's own height, else that height.
pub fn strip(pts: &[[f64; 3]], ground: impl Fn(f64, f64, f64) -> Option<f64>) -> Vec<f64> {
	let mut out = Vec::new();
	let mut carry = 0.0;
	for w in pts.windows(2) {
		let (a, b) = (&w[0], &w[1]);
		let len = ((b[0] - a[0]).powi(2) + (b[1] - a[1]).powi(2)).sqrt();
		let mut t = carry;
		while t < len {
			let f = if len > 0.0 { t / len } else { 0.0 };
			let (x, y, z) = (a[0] + (b[0] - a[0]) * f, a[1] + (b[1] - a[1]) * f, a[2] + (b[2] - a[2]) * f);
			out.push(ground(x, y, z).filter(|h| h.is_finite()).unwrap_or(z));
			t += STRIP_YD;
		}
		carry = t - len;
	}
	out
}

fn put(out: &mut Vec<u8>, v: u64) {
	let mut u = v;
	loop {
		let mut d = u % 32;
		u /= 32;
		if u > 0 {
			d += 32;
		}
		out.push(DIGITS[d as usize]);
		if u == 0 {
			break;
		}
	}
}

fn zig(v: i64) -> u64 {
	if v < 0 {
		(-2 * v - 1) as u64
	} else {
		(2 * v) as u64
	}
}

fn q(v: f64, step: f64) -> i64 {
	(v / step).round() as i64
}

/// The leg as its string (version 2).
pub fn encode(leg: &Leg) -> String {
	let mut out = Vec::new();
	put(&mut out, u64::from(VERSION));
	put(&mut out, leg.pts.len() as u64);
	let (mut px, mut py, mut pz) = (0, 0, 0);
	for p in &leg.pts {
		let (x, y, z) = (q(p[0], QXY), q(p[1], QXY), q(p[2], QZ));
		put(&mut out, zig(x - px));
		put(&mut out, zig(y - py));
		put(&mut out, zig(z - pz));
		(px, py, pz) = (x, y, z);
	}
	for &c in &leg.cls {
		put(&mut out, u64::from(c));
	}
	for &f in &leg.floor {
		put(&mut out, u64::from(f));
	}
	put(&mut out, q(leg.tail, QZ).max(0) as u64);
	put(&mut out, leg.strip.len() as u64);
	let mut sz = q(leg.pts.first().map_or(0.0, |p| p[2]), QZ);
	let ds: Vec<i64> = leg
		.strip
		.iter()
		.map(|&z| {
			let v = q(z, QZ);
			let d = v - sz;
			sz = v;
			d
		})
		.collect();
	let mut i = 0;
	while i < ds.len() {
		let a = ds[i];
		let b = ds.get(i + 1).copied();
		if a == 0 && b == Some(0) {
			let mut j = i;
			while j < ds.len() && ds[j] == 0 && j - i < 32 {
				j += 1;
			}
			out.push(DIGITS[31 + (j - i)]);
			i = j;
		} else if let Some(b) = b.filter(|b| a.abs() <= 2 && b.abs() <= 2) {
			out.push(DIGITS[((a + 2) * 5 + (b + 2)) as usize]);
			i += 2;
		} else if a == 0 {
			out.push(DIGITS[32]);
			i += 1;
		} else if a.abs() <= 3 {
			out.push(DIGITS[SINGLE.iter().position(|&s| s == a).expect("a single") + 25]);
			i += 1;
		} else {
			out.push(DIGITS[31]);
			put(&mut out, zig(a));
			i += 1;
		}
	}
	String::from_utf8(out).expect("base-64 digits")
}

/// The strip's single-change tokens 25..30.
const SINGLE: [i64; 6] = [-3, -2, -1, 1, 2, 3];

/// A leg string's reader: digits, varints.
struct Reader<'s> {
	b: &'s [u8],
	i: usize,
}

impl Reader<'_> {
	fn digit(&mut self) -> Option<u64> {
		let ch = *self.b.get(self.i)?;
		self.i += 1;
		DIGITS.iter().position(|&x| x == ch).map(|d| d as u64)
	}
	fn var(&mut self) -> Option<u64> {
		let (mut v, mut mul) = (0u64, 1u64);
		loop {
			let d = self.digit()?;
			v += (d % 32) * mul;
			if d < 32 {
				return Some(v);
			}
			mul = mul.checked_mul(32)?;
		}
	}
}

fn unzig(u: u64) -> i64 {
	if u % 2 == 1 {
		-((u as i64 + 1) / 2)
	} else {
		(u / 2) as i64
	}
}

/// A leg string (version 1 or 2) -> the leg (heights and yards at their quantisation), or None.
pub fn decode(s: &str) -> Option<Leg> {
	let mut r = Reader { b: s.as_bytes(), i: 0 };
	let version = r.var()?;
	if version != 1 && version != 2 {
		return None;
	}
	let n = r.var()? as usize;
	if n < 2 || n > s.len() {
		return None;
	}
	let mut pts = Vec::with_capacity(n);
	let (mut x, mut y, mut z) = (0i64, 0i64, 0i64);
	for _ in 0..n {
		x += unzig(r.var()?);
		y += unzig(r.var()?);
		z += unzig(r.var()?);
		pts.push([x as f64 * QXY, y as f64 * QXY, z as f64 * QZ]);
	}
	let cls = (0..n - 1).map(|_| r.var().map(|c| c as u8)).collect::<Option<Vec<_>>>()?;
	let floor = if version == 2 { (0..n - 1).map(|_| r.var().map(|c| c as u8)).collect::<Option<Vec<_>>>()? } else { vec![0; n - 1] };
	let tail = r.var()? as f64 * QZ;
	let m = r.var()? as usize;
	let mut sz = (pts[0][2] / QZ).round() as i64;
	let mut strip = Vec::with_capacity(m.min(32 * s.len()));
	while strip.len() < m {
		if version == 1 {
			sz += unzig(r.var()?);
			strip.push(sz as f64 * QZ);
			continue;
		}
		let d = r.digit()?;
		if d >= 32 {
			for _ in 0..d - 31 {
				strip.push(sz as f64 * QZ);
			}
		} else if d < 25 {
			for c in [d as i64 / 5 - 2, d as i64 % 5 - 2] {
				sz += c;
				strip.push(sz as f64 * QZ);
			}
		} else if d < 31 {
			sz += SINGLE[d as usize - 25];
			strip.push(sz as f64 * QZ);
		} else {
			sz += unzig(r.var()?);
			strip.push(sz as f64 * QZ);
		}
	}
	(r.i == r.b.len() && strip.len() == m).then_some(Leg { pts, cls, floor, tail, strip })
}

/// A named chokepoint (Polestar_Nav's Nav/Chokepoints.lua): a gate, bridge, tunnel, cave or
/// building mouth, pass or lift.
#[derive(Clone, Debug, PartialEq)]
pub struct Choke {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub r: f64,
}

/// Nav/Chokepoints.lua's entries (`PolestarNavChokepoints[<c>] = {` then one `{ wx = .., wy = ..,
/// z = .., r = .., kind = "..", name = ".." ...` per line).
pub fn load_chokepoints(text: &str) -> Vec<Choke> {
	let mut out = Vec::new();
	let mut c = None;
	let num = |line: &str, key: &str| -> Option<f64> {
		let at = line.find(&format!("{key} = "))? + key.len() + 3;
		let rest = &line[at..];
		let end = rest.find([',', ' ', '}']).unwrap_or(rest.len());
		rest[..end].parse().ok()
	};
	for line in text.lines() {
		if let Some(rest) = line.strip_prefix("PolestarNavChokepoints[") {
			c = rest.split(']').next().and_then(|v| v.parse::<u32>().ok());
			continue;
		}
		let Some(c) = c else { continue };
		if !line.contains("kind = \"") {
			continue;
		}
		if let (Some(wx), Some(wy), Some(r)) = (num(line, "wx"), num(line, "wy"), num(line, "r")) {
			out.push(Choke { c, wx, wy, r });
		}
	}
	out
}

/// Whether the polyline passes within PASSAGE_YD (plus its radius) of a named chokepoint.
pub fn passes_named(pts: &[[f64; 3]], c: u32, chokes: &[Choke]) -> bool {
	chokes.iter().filter(|p| p.c == c).any(|p| pts.iter().any(|q| ((q[0] - p.wx).powi(2) + (q[1] - p.wy).powi(2)).sqrt() <= PASSAGE_YD + p.r))
}

/// A leg's end: continent (map id), world x/y, and the height of the goal there when known.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct End {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub z: Option<f64>,
}

/// Which backend drew a leg.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Backend {
	Leffe,
	Grid,
}

impl Backend {
	pub fn name(self) -> &'static str {
		match self {
			Backend::Leffe => "leffe",
			Backend::Grid => "grid",
		}
	}
}

/// A baked leg, or why not.
#[derive(Clone, Debug, PartialEq)]
pub enum Baked {
	Leg { string: String, backend: Backend, yards: f64, corners: usize },
	Qa { reason: String },
}

/// The walking maps a bake routes on: our grid (always) and Leffe's maps (the hybrid's first
/// choice, when given).
pub struct Baker<'a> {
	pub walker: &'a Walker,
	pub zones_tag: String,
	pub f4: Option<&'a F4>,
	pub chokes: Vec<Choke>,
}

impl Baker<'_> {
	/// The grid's open surface at (x, y) nearest height z (within GROUND_YD) -> its index in its column (the floor
	/// grid ways carry), its height, its flags.
	fn grid_surface(grid: &Grid, c: u32, x: f64, y: f64, z: f64) -> Option<(u8, f64, u8)> {
		let (col, row, i, j) = cell_of(x, y);
		let t = grid.tile(c, col, row)?;
		let k = (j * TILE_CELLS as i64 + i) as usize;
		let (a, b) = (*t.first.get(k)? as usize, *t.first.get(k + 1)? as usize);
		(a..b)
			.filter(|&e| t.flags[e] & flag::BLOCKED == 0)
			.map(|e| ((e - a).min(255) as u8, t.z[e] as f64, t.flags[e]))
			.filter(|s| (s.1 - z).abs() <= GROUND_YD)
			.min_by(|p, q| (p.1 - z).abs().total_cmp(&(q.1 - z).abs()))
	}
	/// The grid's open surface height at (x, y) nearest height z (within GROUND_YD).
	fn grid_ground(grid: &Grid, c: u32, x: f64, y: f64, z: f64) -> Option<f64> {
		Self::grid_surface(grid, c, x, y, z).map(|s| s.1)
	}

	/// Leffe's way from a to b for a faction (None: his maps have none, or none were given).
	fn leffe(&self, a: &End, b: &End, faction: Option<&'static str>) -> Option<(Route, f64)> {
		let f4 = self.f4?;
		let o = Opts { profile: faction, style: Style::Balanced, validate: Validate::Tolerant, ..Opts::default() };
		let r = f4.route(a.c, P { x: a.wx, y: a.wy, z: a.z }, P { x: b.wx, y: b.wy, z: b.z }, &o);
		(r.ok && r.points.len() >= 2).then(|| {
			let cost = r.cost;
			(r, cost)
		})
	}

	/// The walk from `a` to `b` for a faction's profile, drawn on the hybrid backend (Leffe's way when
	/// it costs at most hybrid::SLACK times the grid's, else the grid's), packed; or why not. Err: the
	/// maps cannot be read (a walk graph not prepared, a broken tile), which no leg can fix.
	pub fn bake(&self, a: &End, b: &End, faction: Option<&'static str>, p: &Profile) -> Result<Baked, String> {
		let ask = |e: &End| SnapAsk { c: e.c, wx: e.wx, wy: e.wy, z: e.z, radius: 20.0, under: true, stand: true };
		let grid = self.walker.route_path(&ask(a), &ask(b), p, &self.zones_tag)?;
		let grid_cost = grid.as_ref().map(|g| g.seconds * RUN);
		let leffe = self.leffe(a, b, faction);
		let take_leffe = match (&leffe, grid_cost) {
			(Some((_, lc)), Some(gc)) => *lc <= crate::hybrid::SLACK * gc,
			(Some(_), None) => true,
			_ => false,
		};
		let gridref = &self.walker.grid;
		let (way, backend) = if take_leffe {
			let f4 = self.f4.expect("leffe way without his maps");
			let (r, _) = leffe.unwrap();
			match Way::from_route(&r, |x, y| f4.height_at(a.c, x, y, Floor::Base)) {
				Some(mut w) => {
					w.onto_grid(|x, y, z| Self::grid_surface(&self.walker.grid, a.c, x, y, z));
					(w, Backend::Leffe)
				}
				None => return Ok(Baked::Qa { reason: "leffe: an empty way".into() }),
			}
		} else {
			match grid {
				Some(g) => (Way::from_cells(&g.cells), Backend::Grid),
				None => return Ok(Baked::Qa { reason: "no way on either map".into() }),
			}
		};
		let yards = way.yards();
		let straight = ((b.wx - a.wx).powi(2) + (b.wy - a.wy).powi(2)).sqrt();
		let kept = simplify(&way);
		if yards > DETOUR * straight && !passes_named(&kept.pts, a.c, &self.chokes) {
			return Ok(Baked::Qa { reason: format!("detour {:.2}x straight on {}, no named passage", yards / straight.max(1e-9), backend.name()) });
		}
		// Our grid's heights first (the collision mesh's own, unrounded), else Leffe's surface for a
		// way only his maps carry (a bridge deck our grid lacks), else the line's height.
		let ground = |x: f64, y: f64, z: f64| {
			Self::grid_ground(gridref, a.c, x, y, z).or_else(|| {
				if backend == Backend::Leffe {
					self.f4.and_then(|f| f.height_at(a.c, x, y, Floor::Near(z))).filter(|h| (h - z).abs() <= GROUND_YD)
				} else {
					None
				}
			})
		};
		let last = kept.pts[kept.pts.len() - 1];
		let tail = ((b.wx - last[0]).powi(2) + (b.wy - last[1]).powi(2)).sqrt();
		let strip = strip(&kept.pts, ground);
		let corners = kept.pts.len();
		let leg = Leg { pts: kept.pts, cls: kept.cls, floor: kept.floor, tail, strip };
		Ok(Baked::Leg { string: encode(&leg), backend, yards, corners })
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	fn way(pts: &[[f64; 3]], cls: &[u8]) -> Way {
		Way { pts: pts.to_vec(), cls: cls.to_vec(), floor: vec![0; cls.len()] }
	}

	// A way drawn on Leffe's maps: a stair walk on his floor 3 at his 2 yd height steps, then a jump down. Our grid
	// (the closure) has the stair as its column's surface 1, half a yard off his steps, and nothing under the far end.
	#[test]
	fn a_leffe_way_takes_our_grids_floors_and_heights_but_keeps_his_at_a_hop_and_where_ours_has_none() {
		let mut w = way(&[[0.0, 0.0, 10.0], [10.0, 0.0, 12.0], [20.0, 0.0, 14.0], [25.0, 0.0, 4.0], [40.0, 0.0, 4.0]], &[cls::WALK, cls::STEEP, cls::JUMP, cls::WALK]);
		w.floor = vec![3, 3, 3, 3];
		w.onto_grid(|x, _, z| (x < 30.0).then_some((1, z + 0.5, if x < 5.0 { flag::INDOOR } else { flag::TERRAIN })));
		assert_eq!(w.floor, vec![1, 1, 1, 1], "our grid's floor index for each segment's start");
		assert_eq!(w.cls, vec![cls::INDOOR, cls::WALK, cls::JUMP, cls::WALK], "walks classed by our grid's ground (his steep slope is plain ground on ours), the jump kept");
		let z: Vec<f64> = w.pts.iter().map(|p| p[2]).collect();
		assert_eq!(z, vec![10.0, 12.5, 14.0, 4.0, 4.0], "the corner between walks re-heighted; the jump's ends and the way's ends keep his");
		let mut far = way(&[[0.0, 0.0, 10.0], [40.0, 0.0, 12.0], [50.0, 0.0, 12.0]], &[cls::WALK, cls::STEEP]);
		far.floor = vec![3, 3];
		far.onto_grid(|x, _, z| (x < 30.0).then_some((1, z + 0.5, flag::TERRAIN)));
		assert_eq!((far.floor, far.cls[1], far.pts[1][2]), (vec![1, 3], cls::STEEP, 12.0), "where ours has no surface near, his floor, class and height stay");
	}

	#[test]
	fn leffe_walks_on_steep_or_indoor_ground_are_steep_or_indoor_segments_his_hops_keep_their_move() {
		assert_eq!([0, 1, 2, 3, 4, 5].map(|g| leg_class(Move::Walk, g)), [cls::WALK, cls::WALK, cls::WALK, cls::STEEP, cls::INDOOR, cls::INDOOR]);
		assert_eq!(leg_class(Move::Motion, 4), cls::INDOOR);
		assert_eq!([leg_class(Move::Jump, 3), leg_class(Move::Lift, 4), leg_class(Move::Swim, 4)], [cls::JUMP, cls::LIFT, cls::SWIM]);
	}

	#[test]
	fn a_leg_reads_back_at_its_quantisation() {
		// Level for 40 samples (a run past 32), two pairs of small changes, a single +3, a 19 yd drop (escaped), level.
		let mut strip = vec![140.25; 40];
		strip.extend([140.5, 140.75, 140.25, 139.75, 140.5, 121.0, 121.0]);
		let leg = Leg { pts: vec![[-1007.0, 260.5, 140.25], [-1010.5, 250.0, 141.0], [-1050.0, 200.0, 120.75]], cls: vec![cls::INDOOR, cls::LIFT], floor: vec![1, 0], tail: 2.5, strip };
		let s = encode(&leg);
		assert!(s.bytes().all(|b| DIGITS.contains(&b)));
		assert_eq!(decode(&s), Some(leg));
		assert_eq!(decode(&s[..s.len() - 1]), None, "a cut string does not read");
		assert_eq!(decode(&format!("{s}A")), None, "nor one with trailing digits");
	}

	#[test]
	fn version_1_strings_still_read() {
		// tools/lib/nav/bake.js encodeLeg({ pts: [[0,0,0],[1,40,7.75],[2,41,8]], cls: [0,3], tail: 2.5, strip: [0,0.5,1] })
		let mut v1 = Vec::new();
		put(&mut v1, 1);
		put(&mut v1, 3);
		for (x, y, z) in [(0, 0, 0), (2, 80, 31), (2, 2, 1)] {
			put(&mut v1, zig(x));
			put(&mut v1, zig(y));
			put(&mut v1, zig(z));
		}
		put(&mut v1, 0);
		put(&mut v1, 3);
		put(&mut v1, 10);
		put(&mut v1, 3);
		for d in [0, 2, 2] {
			put(&mut v1, zig(d));
		}
		let leg = decode(std::str::from_utf8(&v1).unwrap()).unwrap();
		assert_eq!(leg.pts, vec![[0.0, 0.0, 0.0], [1.0, 40.0, 7.75], [2.0, 41.0, 8.0]]);
		assert_eq!(leg.cls, vec![0, 3]);
		assert_eq!(leg.floor, vec![0, 0]);
		assert_eq!(leg.tail, 2.5);
		assert_eq!(leg.strip, vec![0.0, 0.5, 1.0]);
	}

	#[test]
	fn simplify_keeps_class_floor_and_hop_corners() {
		// A straight run of walk cells, then a lift, then indoor on floor 1.
		let mut pts: Vec<[f64; 3]> = (0..10).map(|i| [i as f64 * 2.0, 0.0, 10.0]).collect();
		pts.push([20.0, 0.0, 40.0]);
		pts.extend((1..6).map(|i| [20.0 + i as f64 * 2.0, 0.0, 40.0]));
		let mut c = vec![cls::WALK; 9];
		c.push(cls::LIFT);
		c.extend([cls::INDOOR; 5]);
		let mut w = way(&pts, &c);
		w.floor = vec![0; 10];
		w.floor.extend([1; 5]);
		let s = simplify(&w);
		assert_eq!(s.pts, vec![[0.0, 0.0, 10.0], [18.0, 0.0, 10.0], [20.0, 0.0, 40.0], [30.0, 0.0, 40.0]]);
		assert_eq!(s.cls, vec![cls::WALK, cls::LIFT, cls::INDOOR]);
		assert_eq!(s.floor, vec![0, 0, 1]);
	}

	#[test]
	fn simplify_keeps_a_bend_past_the_tolerance() {
		let w = way(&[[0.0, 0.0, 0.0], [50.0, 10.5, 0.0], [100.0, 20.0, 0.0], [150.0, 30.0, 0.0], [200.0, 0.0, 0.0]], &[0, 0, 0, 0]);
		let s = simplify(&w);
		assert_eq!(s.pts.len(), 3, "the half-yard wobble goes, the 30 yd bend stays");
		assert_eq!(s.pts[1], [150.0, 30.0, 0.0]);
	}

	#[test]
	fn the_strip_samples_every_2_yd_along_the_line() {
		let pts = [[0.0, 0.0, 0.0], [5.0, 0.0, 10.0], [5.0, 3.0, 10.0]];
		let s = strip(&pts, |x, _, _| Some(x));
		assert_eq!(s, vec![0.0, 2.0, 4.0, 5.0]);
		let s = strip(&pts, |_, _, _| None);
		assert_eq!(s, vec![0.0, 4.0, 8.0, 10.0], "no ground: the line's own height");
	}

	#[test]
	fn unknown_heights_are_interpolated_along_the_way() {
		let mut pts = vec![[0.0, 0.0, 10.0], [10.0, 0.0, f64::NAN], [20.0, 0.0, 30.0], [40.0, 0.0, f64::NAN]];
		fill_heights(&mut pts, |_, _| None);
		assert_eq!(pts.iter().map(|p| p[2]).collect::<Vec<_>>(), vec![10.0, 20.0, 30.0, 30.0]);
	}

	#[test]
	fn chokepoints_read_from_the_pack_file() {
		let text = "PolestarNavChokepoints[1] = {\n\t{ wx = -1290.5, wy = 188, z = 67.5, r = 6, kind = \"lift\", name = \"Mesa Elevator\" },\n}\n";
		let c = load_chokepoints(text);
		assert_eq!(c, vec![Choke { c: 1, wx: -1290.5, wy: 188.0, r: 6.0 }]);
		assert!(passes_named(&[[-1300.0, 180.0, 0.0]], 1, &c));
		assert!(!passes_named(&[[-1300.0, 180.0, 0.0]], 0, &c));
	}
}
