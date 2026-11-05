//! `forge judge seed-tests`: v1's guide checks from player reports (the seed's tests/guides-reported.test.js
//! and tests/guides-caves.test.js) run from Rust on any guides folder: each test compiled with the reference
//! data and asserted the same way, by the same name, so a written tree reports pass/fail per test as
//! `node --test` does on it.
//!
//! A test is `fn(&Ctx, &mut Check)`: [`Ctx`] compiles guides on demand (memoised) and gives the JS helpers
//! (`goals`, `at`, `is`, `yards`, ...); [`Check`] records failed assertions instead of panicking, so one
//! test's failure does not stop the others.

use std::cell::RefCell;
use std::path::{Path, PathBuf};

use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use rustc_hash::FxHashMap;
use serde::Serialize;

mod caves;
mod reported;

/// The guides folder (holding `forever/`) and the data the tests compile against.
pub struct Ctx {
	pub guides: PathBuf,
	pub data: Data,
	/// The checkout the guides come from (data/sources, data/local), for tests that read more than data/forever.
	pub root: PathBuf,
	memo: RefCell<FxHashMap<String, V>>,
}

/// A goal in a compiled guide (the JS `{ step, goal, s }`; `s` the 1-based step number).
#[derive(Clone)]
pub struct Row {
	pub step: V,
	pub goal: V,
	pub s: usize,
}

impl Ctx {
	pub fn new(guides: &Path, data_dir: &Path, root: &Path) -> Result<Ctx, String> {
		Ok(Ctx { guides: guides.to_path_buf(), data: forge_guide::data::load_data(data_dir)?, root: root.to_path_buf(), memo: RefCell::new(FxHashMap::default()) })
	}

	/// The guide (`forever/....guide`, relative to the guides folder) compiled with the reference data
	/// (`compiled(guide)`); V::Undef when it does not compile to one guide.
	pub fn compiled(&self, guide: &str) -> V {
		if let Some(g) = self.memo.borrow().get(guide) {
			return g.clone();
		}
		let file = self.guides.join(guide);
		let text = std::fs::read_to_string(&file).unwrap_or_default();
		let src = Source { file: file.to_string_lossy().into_owned(), source: guide.to_string(), text };
		let out = compile_sources(&[src], &self.data, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
		let g = if out.guides.len() == 1 { out.guides[0].clone() } else { V::Undef };
		self.memo.borrow_mut().insert(guide.to_string(), g.clone());
		g
	}

	/// `goals(guide)`: the guide's goals in order.
	pub fn goals(&self, guide: &str) -> Vec<Row> {
		let mut out = Vec::new();
		for (s, step) in self.compiled(guide).get("steps").items().into_iter().enumerate() {
			for goal in step.get("goals").items() {
				out.push(Row { step: step.clone(), goal, s: s + 1 });
			}
		}
		out
	}

	/// `allGuides()`: every guide under forever/, relative, forward slashes, sorted.
	pub fn all_guides(&self) -> Vec<String> {
		let mut out = Vec::new();
		fn walk(dir: &Path, rel: &str, out: &mut Vec<String>) {
			let Ok(rd) = std::fs::read_dir(dir) else { return };
			let mut es: Vec<_> = rd.filter_map(|e| e.ok()).collect();
			es.sort_by_key(|e| e.file_name());
			for e in es {
				let name = e.file_name().to_string_lossy().into_owned();
				let r = format!("{rel}/{name}");
				if e.path().is_dir() {
					walk(&e.path(), &r, out);
				} else if name.ends_with(".guide") {
					out.push(r);
				}
			}
		}
		walk(&self.guides.join("forever"), "forever", &mut out);
		out
	}

	/// `yards(a, b)`: yards between two compiled points on one map (Era frame); None when not on one
	/// map with an Era frame.
	pub fn yards(&self, a: &V, b: &V) -> Option<f64> {
		let f = self.data.era_frame(&a.get("map"));
		if !f.truthy() || !a.get("map").strict_eq(&b.get("map")) {
			return None;
		}
		let n = |v: &V, k: &str| v.get(k).as_num().unwrap_or(f64::NAN);
		Some(((n(&f, "right") - n(&f, "left")) * (n(a, "x") - n(b, "x")) / 100.0).hypot((n(&f, "bottom") - n(&f, "top")) * (n(a, "y") - n(b, "y")) / 100.0))
	}
}

/// `at(list, what, pred)`: index of the first goal matching (a failed check, and None, when absent).
pub fn at(c: &mut Check, list: &[Row], what: &str, pred: impl Fn(&V) -> bool) -> Option<usize> {
	let i = list.iter().position(|r| pred(&r.goal));
	c.ok(i.is_some(), &format!("{what} is in the guide"));
	i
}

/// `is(t, quest)`.
pub fn is(t: &'static str, quest: i64) -> impl Fn(&V) -> bool {
	move |g: &V| g.get("t").as_str() == Some(t) && g.get("quest").as_num() == Some(quest as f64)
}

/// `located`: the goal has a map and an x.
pub fn located(r: &Row) -> bool {
	!r.goal.get("map").is_nullish() && !r.goal.get("x").is_nullish()
}

/// `everyone`: no `only` on the goal or its step.
pub fn everyone(r: &Row) -> bool {
	!r.step.get("only").truthy() && !r.goal.get("only").truthy()
}

/// The correction of `section` (`quests`, `npcs`, ...) `id` as `data build` applies it: the
/// checkout's forever-db/corrections/<section>.json entry with the private overlay's
/// (data/local/corrections-private.json) keys over it; Undef when neither has one.
pub fn correction(root: &Path, section: &str, id: &str) -> V {
	let read = |p: PathBuf| std::fs::read_to_string(p).ok().and_then(|t| forge_guide::js::parse_json(&t).ok()).unwrap_or(V::Undef);
	let public = read(root.join("forever-db/corrections").join(format!("{section}.json"))).get(id);
	let private = read(root.join("data/local/corrections-private.json")).get(section).get(id);
	if !private.is_obj() {
		return public;
	}
	if !public.is_obj() {
		return private;
	}
	let out = forge_guide::js::Obj::new();
	for (k, v) in public.entries().into_iter().chain(private.entries()) {
		out.set(&k, v);
	}
	V::Obj(out)
}

/// `forClass(cls)`: an `only` naming classes on the goal or its step lists it.
pub fn for_class(cls: &str) -> impl Fn(&Row) -> bool + '_ {
	move |r: &Row| {
		[r.step.get("only"), r.goal.get("only")].iter().all(|o| {
			let cs = o.get("classes");
			!o.truthy() || !cs.truthy() || cs.items().iter().any(|c| c.as_str() == Some(cls))
		})
	}
}

/// A test's assertions: failures recorded, the test goes on (as far as its own logic allows: a test
/// returns early where the JS assertion would have thrown and later lines depend on it).
#[derive(Default, Debug, Serialize)]
pub struct Check {
	pub failures: Vec<String>,
	/// The test does not apply (the JS `skip`: data it needs is absent).
	pub skipped: Option<String>,
}

impl Check {
	pub fn ok(&mut self, cond: bool, msg: &str) -> bool {
		if !cond {
			self.failures.push(msg.to_string());
		}
		cond
	}
	pub fn eq<T: PartialEq + std::fmt::Debug>(&mut self, a: T, b: T, msg: &str) -> bool {
		if a != b {
			self.failures.push(format!("{msg}: {a:?} != {b:?}"));
			return false;
		}
		true
	}
	pub fn skip(&mut self, why: &str) {
		self.skipped = Some(why.to_string());
	}
	pub fn passed(&self) -> bool {
		self.failures.is_empty()
	}
}

/// One test: its name as `node --test` prints it, and its body.
pub type SeedTest = (String, fn(&Ctx, &mut Check));

/// Every test, in the JS files' order.
pub fn all() -> Vec<SeedTest> {
	let mut v = reported::tests();
	v.extend(caves::tests());
	v
}

/// One test's outcome.
#[derive(Debug, Serialize)]
pub struct Outcome {
	pub name: String,
	pub passed: bool,
	pub skipped: Option<String>,
	pub failures: Vec<String>,
}

/// Run every test (or those whose name contains `filter`).
pub fn run(ctx: &Ctx, filter: Option<&str>) -> Vec<Outcome> {
	all()
		.into_iter()
		.filter(|(n, _)| filter.is_none_or(|f| n.contains(f)))
		.map(|(name, f)| {
			let mut c = Check::default();
			let r = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| f(ctx, &mut c)));
			if r.is_err() {
				c.failures.push("panicked".into());
			}
			Outcome { passed: c.passed(), skipped: c.skipped.clone(), failures: c.failures, name }
		})
		.collect()
}

/// `polestar lint` on a guides folder: every compile check on its guides (and the solo policy against
/// no exclusions). -> (errors, warnings, the first errors as text).
pub fn lint(guides: &Path, data: &Data) -> (usize, usize, Vec<String>) {
	let files = forge_guide::project::find_guide_files(guides, false);
	let sources: Vec<Source> =
		files.iter().map(|rel| Source { file: guides.join(rel).to_string_lossy().into_owned(), source: rel.clone(), text: std::fs::read_to_string(guides.join(rel)).unwrap_or_default() }).collect();
	let diags = forge_guide::project::lint_sources(&sources, data, &V::Obj(forge_guide::js::Obj::new()));
	let errors: Vec<String> = diags.iter().filter(|d| d.severity == "error").map(forge_guide::diag::format).collect();
	let warnings = diags.iter().filter(|d| d.severity == "warning").count();
	(errors.len(), warnings, errors.into_iter().take(20).collect())
}
