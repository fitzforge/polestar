//! `forge judge <pack dir> --faction F --race R [--class C] [--to N] [--sim DIR] [--levels FILE] [--root DIR]
//! [--data DIR] [--legacy] [--json]`
//!
//! Plays the pack honestly (rules R1-R10; `--legacy`: R1-R5 only, as `polestar playtest --honest`)
//! and walks the faction/race chain for passed-by quests and avoidable returns. Levels come from
//! forge-sim's evaluator on the sim dir's world and params (`--sim`, default `<root>/data/sim`);
//! `--levels` instead reads a judge walk's levels (`{ goals: [{ lvl, time, lvlAfter, timeAfter }] }`).
//! Without either the walk is skipped.

use super::{usage, Fail};
use std::path::{Path, PathBuf};
use std::time::Instant;

use forge_judge::honest::{self, HonestOpts, PackRun};
use forge_judge::levels::SimLevels;
use forge_judge::walk::{judge_walk, DumpLevels, JudgeOpts, LevelModel};
use serde_json::{json, Value};

pub(super) const USAGE: &str = "usage: forge judge <pack dir> --faction F --race R [--class C] [--to <level>] [--sim <dir>] [--levels <file>]
                   [--root <dir>] [--data <dir>] [--legacy] [--json]

Plays the pack as a player of that race would (rules R1-R10; --legacy: R1-R5 only) and walks its chain
for passed-by quests and avoidable returns, with levels from the simulator's world in --sim (default
<root>/data/sim) or from a --levels file.";

pub fn main() {
	super::exit("judge", run());
}

/// The checkout holding `data/forever`, from `start` upwards.
fn find_root(start: &Path) -> Option<PathBuf> {
	let start = start.canonicalize().ok()?;
	start.ancestors().find(|d| d.join("data/forever").is_dir()).map(Path::to_path_buf)
}

fn run() -> Result<(), Fail> {
	if super::args().nth(1).as_deref() == Some("report") {
		return report(super::args().skip(2).collect());
	}
	if super::args().nth(1).as_deref() == Some("check") {
		return check(super::args().skip(2).collect());
	}
	if super::args().nth(1).as_deref() == Some("seed-tests") {
		return seed_tests(super::args().skip(2).collect());
	}
	if super::args().nth(1).as_deref() == Some("feedback") {
		return feedback(super::args().skip(2).collect());
	}
	if super::args().nth(1).as_deref() == Some("route-status") {
		return route_status(super::args().skip(2).collect());
	}
	let mut args = super::args().skip(1);
	let (mut pack, mut faction, mut race, mut cls, mut to, mut levels, mut root, mut data, mut sim) = (None, None, None, None, 61.0, None, None, None, None);
	let (mut legacy, mut as_json) = (false, false);
	while let Some(a) = args.next() {
		let mut val = || args.next().ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--faction" => faction = Some(val()?),
			"--race" => race = Some(val()?),
			"--class" => cls = Some(val()?),
			"--to" => {
				let v = val()?;
				to = v.parse::<f64>().map_err(|_| usage(format!("--to {v}: a level")))?;
			}
			"--levels" => levels = Some(PathBuf::from(val()?)),
			"--root" => root = Some(PathBuf::from(val()?)),
			"--data" => data = Some(PathBuf::from(val()?)),
			"--sim" => sim = Some(PathBuf::from(val()?)),
			"--legacy" => legacy = true,
			"--json" => as_json = true,
			"-h" | "--help" => {
				println!("{USAGE}");
				return Ok(());
			}
			s if s.starts_with('-') => return Err(usage(format!("unknown option {s}"))),
			s if pack.is_none() => pack = Some(PathBuf::from(s)),
			s => return Err(usage(format!("unexpected argument {s}"))),
		}
	}
	let pack = pack.ok_or_else(|| usage("a pack folder is required"))?;
	let faction = faction.ok_or_else(|| usage("--faction horde|alliance is required"))?;
	let race = race.ok_or_else(|| usage("--race <race> is required"))?;
	let root = match root {
		Some(r) => r,
		None => find_root(&pack).or_else(|| find_root(&std::env::current_dir().ok()?)).ok_or("no data/forever above the pack or here; pass --root")?,
	};
	let data_dir = data.unwrap_or_else(|| root.join("data/forever"));

	let t0 = Instant::now();
	let gdata = forge_guide::data::load_data(&data_dir)?;
	let kb = honest::load_kb(&root.join("data/local/kb/forever-kb.sqlite"))?;
	let opts = if legacy { HonestOpts::legacy() } else { HonestOpts::default() };
	// Classes as the data files name them (WARRIOR, DEATHKNIGHT).
	let run = PackRun { filter: None, faction: Some(faction.clone()), race: Some(race.clone()), classes: cls.clone().map(|c| vec![c.to_uppercase().replace([' ', '-'], "")]) };
	let played = honest::play_pack(&pack, &gdata, kb.as_ref(), &run, &opts)?;
	let honest_ms = t0.elapsed().as_secs_f64() * 1e3;

	let t1 = Instant::now();
	let lv: Option<Box<dyn LevelModel>> = match &levels {
		Some(file) => {
			let js: Value = serde_json::from_slice(&std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?).map_err(|e| format!("{}: {e}", file.display()))?;
			let goals = js["goals"].as_array().ok_or_else(|| format!("{}: no goals list", file.display()))?;
			let f = |g: &Value, k: &str| g[k].as_f64().unwrap_or(f64::NAN);
			Some(Box::new(DumpLevels(goals.iter().map(|g| [f(g, "lvl"), f(g, "time"), f(g, "lvlAfter"), f(g, "timeAfter")]).collect())))
		}
		None => {
			let dir = sim.clone().unwrap_or_else(|| root.join("data/sim"));
			let fac = forge_core::Faction::parse(&faction).ok_or_else(|| usage(format!("--faction {faction}: horde or alliance")))?;
			match forge_sim::load_world(&dir, fac) {
				Err(e) if sim.is_some() => return Err(e.into()),
				Err(_) => None,
				Ok(world) => {
					let params: Option<Value> = std::fs::read(dir.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
					Some(Box::new(SimLevels::new(&world, &race, params.as_ref())?))
				}
			}
		}
	};
	let walk = match &lv {
		None => None,
		Some(lv) => {
			let mut o = JudgeOpts::new(&pack, &faction, &race, cls.as_deref(), &root);
			o.data_dir = data_dir.clone();
			o.to = to;
			Some(judge_walk(&o, lv.as_ref())?)
		}
	};
	let walk_ms = t1.elapsed().as_secs_f64() * 1e3;

	if as_json {
		let mut out = json!({
			"faction": faction, "race": race, "class": cls,
			"honest": { "played": played.played, "findings": played.findings },
			"ms": { "honest": honest_ms, "walk": walk_ms },
		});
		out["walk"] = match &walk {
			None => json!({ "skipped": "no sim world: pass --sim <dir with world-<faction>.json> or --levels <file>" }),
			Some(j) => json!({
				"chain": j.walk.chain, "goals": j.walk.goals.len(), "endLevel": j.walk.end_level, "hours": j.walk.hours,
				"background": j.background, "passedBy": j.passed_by, "returns": j.returns,
			}),
		};
		println!("{}", serde_json::to_string_pretty(&out).map_err(|e| e.to_string())?);
		return Ok(());
	}
	let mut per: std::collections::BTreeMap<(&str, String), usize> = Default::default();
	for f in &played.findings {
		*per.entry((f.rule, format!("{:?}", f.severity))).or_default() += 1;
		let [a, b] = honest::finding_lines(f);
		println!("{a}\n{b}");
	}
	println!("\nhonest: {} guides played, {} findings ({honest_ms:.0} ms)", played.played, played.findings.len());
	for ((rule, sev), n) in &per {
		println!("  {rule} {sev}: {n}");
	}
	match &walk {
		None => println!("walk: skipped (no sim world: pass --sim or --levels)"),
		Some(j) => {
			let v = serde_json::to_value(&j.returns).unwrap_or_default();
			println!(
				"walk: {} guides, {} goals, level {:.2}, {:.1} h; passed by {} ({} never, {} later); avoidable returns {}, left behind {}, same mob {} ({walk_ms:.0} ms)",
				j.walk.chain.len(),
				j.walk.goals.len(),
				j.walk.end_level,
				j.walk.hours,
				j.passed_by.count,
				j.passed_by.never,
				j.passed_by.later,
				v["summary"]["avoidableReturns"],
				v["summary"]["leftBehind"],
				v["summary"]["sameMobAvoidable"],
			);
		}
	}
	Ok(())
}

pub(super) const REPORT_USAGE: &str = "usage: forge judge report (--route <route.json> ... | --routes <dir>) --guides <dir> [--stream <judge stream.json>] [--base <dir>]
                          [--root <dir>] [--data <dir>] [--sim <dir>] [--out <dir>] [--json] [--along-walked] [--no-checks]

The route report (forge build's report stage): per start, the base guides' chain and the written chain to
30 and 60 (hours, level, quests, zone changes, passed by, avoidable returns, area visits, deaths, trains
and training trips, grind minutes, the quest log's peak), the order's judge stream against the written
walk (hours, quest events in both / out of order / only in one, where time is lost), and the race's
findings (rules R1-R5) on the chain with the ones the base guides do not have.
--routes: every <start>.json in the dir (not .judge-*, .skips, .edits). --guides: the written guides; a
<dir>/<start> subfolder when there is one. --stream: one route's stream (default <route>.judge-improved.json
when present). --root: the checkout the guides were built with (default: above --guides, else here);
--base: the guides the routes started from (default <root>/guides); --data <root>/data/forever, --sim
<root>/data/sim. --out: writes report.md and report.json there (else the text to stdout; --json the
JSON). --along-walked: walk to `along` steps' goals where the steps stand (default: as the addon, on the
way). The player-report tests and lint run on the base guides and each written tree (--no-checks: not).
Hours come from the routes stage's model on the sim dir's walk store: the route profile's accept and
bag rules, and every placed line with no quest (a goto, getfp, vendor) travelled to.";

fn report(argv: Vec<String>) -> Result<(), Fail> {
	use forge_judge::report::{markdown, run, Inputs, StartInput};
	let mut along_walked = false;
	let mut no_checks = false;
	let (mut routes, mut stream, mut guides, mut v1, mut root, mut data, mut sim, mut out, mut as_json): (
		Vec<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		Option<PathBuf>,
		bool,
	) = Default::default();
	let mut it = argv.into_iter();
	while let Some(a) = it.next() {
		let mut val = || it.next().map(PathBuf::from).ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--route" => routes.push(val()?),
			"--routes" => {
				let dir = val()?;
				let mut fs: Vec<PathBuf> = std::fs::read_dir(&dir)
					.map_err(|e| format!("{}: {e}", dir.display()))?
					.filter_map(|e| e.ok().map(|e| e.path()))
					.filter(|p| p.extension().is_some_and(|x| x == "json") && p.file_stem().is_some_and(|s| !s.to_string_lossy().contains('.')))
					.collect();
				fs.sort();
				routes.extend(fs);
			}
			"--stream" => stream = Some(val()?),
			"--guides" => guides = Some(val()?),
			"--base" => v1 = Some(val()?),
			"--root" => root = Some(val()?),
			"--data" => data = Some(val()?),
			"--sim" => sim = Some(val()?),
			"--out" => out = Some(val()?),
			"--json" => as_json = true,
			"--along-walked" => along_walked = true,
			"--no-checks" => no_checks = true,
			"-h" | "--help" => {
				println!("{REPORT_USAGE}");
				return Ok(());
			}
			k => return Err(usage(format!("unexpected {k}"))),
		}
	}
	let guides = guides.ok_or_else(|| usage("--guides <dir> is required"))?;
	let along_walked = along_walked;
	if routes.is_empty() {
		return Err(usage("--route <route.json> or --routes <dir> is required"));
	}
	let root = match root {
		Some(r) => r,
		None => find_root(&guides).or_else(|| find_root(&std::env::current_dir().ok()?)).ok_or("no data/forever above the guides or here; pass --root")?,
	};
	let starts = routes
		.iter()
		.map(|r| {
			let start = r.file_stem().map(|s| s.to_string_lossy().into_owned()).unwrap_or_default();
			let sub = guides.join(&start);
			StartInput { route: r.clone(), stream: if routes.len() == 1 { stream.clone() } else { None }, guides: if sub.join("forever").is_dir() { sub } else { guides.clone() } }
		})
		.collect();
	let inp = Inputs {
		starts,
		v1: v1.unwrap_or_else(|| root.join("guides")),
		data_dir: data.unwrap_or_else(|| root.join("data/forever")),
		sim_dir: sim.unwrap_or_else(|| root.join("data/sim")),
		root,
		along_walked,
		checks: !no_checks,
		route_model: true,
	};
	let o = run(&inp)?;
	let js = serde_json::to_string_pretty(&o).map_err(|e| e.to_string())?;
	match out {
		Some(dir) => {
			std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
			std::fs::write(dir.join("report.md"), markdown(&o)).map_err(|e| e.to_string())?;
			std::fs::write(dir.join("report.json"), js).map_err(|e| e.to_string())?;
			eprintln!("report: {} and report.json", dir.join("report.md").display());
		}
		None if as_json => println!("{js}"),
		None => print!("{}", markdown(&o)),
	}
	Ok(())
}

pub(super) const CHECK_USAGE: &str = "usage: forge judge check <out>/guides [--json] [--out <dir>] [--start S ...] [--route-fixes <file>] [--root <dir>]
                         [--sim <dir>] [--routes <dir>] [--base <dir>] [--threads N]

The route gate on a build's written guides (<guides>/<start>/forever), read with the build's files beside
the guides folder: ../routes, ../.forge/root, ../.forge/sim and ../fixes.json. One line per broken rule,
`<start> <file>:<line> <rule> blocker|warn: <message>` (classes in brackets when not every class meets
it): the honest playtest's new R1/R2/R3/R5/R6/R10 fails against the base guides, an item looted from a
locked chest before its key, an item used before it is got, deliberate orders broken, the fixes ledger's
blocking rows, required waits on rare drops, hearths on cooldown, travel legs that go somewhere, do
nothing and come back, and the player view worse than the base guides' (avoidable returns, wasted trips,
zone changes, quests passed by, area visits: all blockers); each return and zone change the base guides
do not make (from the model order or the writer), the written walk against the model route and work
under the quest's level or turned in grey (warnings). Exit 1 when there is a blocker. --json: one
document { starts, violations }. --out: also write check.md (the player view table first) and
check.json there. --route-fixes: the deliberate orders (default $POLESTAR_ROUTE_FIXES, else
data/route-fixes.json of the checkout here). --base: the guides compared against (default
<root>/guides). --threads: default the machine's.";

fn check(argv: Vec<String>) -> Result<(), Fail> {
	use forge_judge::check::{run, Inputs};
	let mut guides: Option<PathBuf> = None;
	let (mut starts, mut fixes, mut root, mut sim, mut routes, mut base, mut threads, mut as_json) = (Vec::new(), None, None, None, None, None, 0usize, false);
	let mut out: Option<PathBuf> = None;
	let mut it = argv.into_iter();
	while let Some(a) = it.next() {
		let mut val = || it.next().ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--json" => as_json = true,
			"--start" => starts.push(val()?),
			"--out" => out = Some(PathBuf::from(val()?)),
			"--route-fixes" => fixes = Some(PathBuf::from(val()?)),
			"--root" => root = Some(PathBuf::from(val()?)),
			"--sim" => sim = Some(PathBuf::from(val()?)),
			"--routes" => routes = Some(PathBuf::from(val()?)),
			"--base" => base = Some(PathBuf::from(val()?)),
			"--threads" => {
				let v = val()?;
				threads = v.parse().map_err(|_| usage(format!("--threads {v}: a number")))?;
			}
			"-h" | "--help" => {
				println!("{CHECK_USAGE}");
				return Ok(());
			}
			k if k.starts_with('-') || guides.is_some() => return Err(usage(format!("unexpected {k}"))),
			k => guides = Some(PathBuf::from(k)),
		}
	}
	let guides = guides.ok_or_else(|| usage("the guides folder (<out>/guides) is required"))?;
	let mut inp = Inputs::beside(&guides);
	inp.starts = starts;
	if let Some(r) = root {
		inp.v1 = r.join("guides");
		inp.root = r;
	}
	if let Some(s) = sim {
		inp.sim = s;
	}
	if let Some(r) = routes {
		inp.routes = r;
	}
	if let Some(b) = base {
		inp.v1 = b;
	}
	inp.route_fixes = fixes.or_else(|| std::env::var_os("POLESTAR_ROUTE_FIXES").map(PathBuf::from)).or_else(|| {
		let here = std::env::current_dir().ok()?;
		find_root(&here).map(|r| r.join("data/route-fixes.json")).filter(|f| f.is_file())
	});
	let pool = rayon::ThreadPoolBuilder::new().num_threads(threads).build().map_err(|e| e.to_string())?;
	let t0 = std::time::Instant::now();
	let o = pool.install(|| run(&inp))?;
	if as_json {
		println!("{}", serde_json::to_string_pretty(&o).map_err(|e| e.to_string())?);
	} else {
		print!("{}", o.text());
	}
	if let Some(dir) = &out {
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		std::fs::write(dir.join("check.md"), o.markdown()).map_err(|e| e.to_string())?;
		std::fs::write(dir.join("check.json"), serde_json::to_string_pretty(&o).map_err(|e| e.to_string())?).map_err(|e| e.to_string())?;
	}
	eprintln!(
		"check: {} blockers, {} warnings ({}) in {:.1} s{}",
		o.blockers(),
		o.warns(),
		o.starts.iter().map(|s| format!("{} {}/{}", s.start, s.blockers, s.warns)).collect::<Vec<_>>().join(", "),
		t0.elapsed().as_secs_f64(),
		inp.route_fixes.as_ref().map_or(String::new(), |f| format!("; deliberate orders from {}", f.display()))
	);
	if o.blockers() > 0 {
		std::process::exit(1);
	}
	Ok(())
}

pub(super) const SEED_USAGE: &str = "usage: forge judge seed-tests --guides <dir> [--data <dir>] [--root <dir>] [--filter <text>] [--lint] [--json]

The player-report guide checks on a guides folder (holding forever/), compiled with --data (default
<root>/data/forever): one line per test, then the counts. --lint: the compile checks' error and warning
counts too. Exit 1 when a test fails.";

fn seed_tests(argv: Vec<String>) -> Result<(), Fail> {
	let (mut guides, mut data, mut root, mut filter, mut lint, mut as_json): (Option<PathBuf>, Option<PathBuf>, Option<PathBuf>, Option<String>, bool, bool) = Default::default();
	let mut it = argv.into_iter();
	while let Some(a) = it.next() {
		let mut val = || it.next().ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--guides" => guides = Some(PathBuf::from(val()?)),
			"--data" => data = Some(PathBuf::from(val()?)),
			"--root" => root = Some(PathBuf::from(val()?)),
			"--filter" => filter = Some(val()?),
			"--lint" => lint = true,
			"--json" => as_json = true,
			"-h" | "--help" => {
				println!("{SEED_USAGE}");
				return Ok(());
			}
			k => return Err(usage(format!("unexpected {k}"))),
		}
	}
	let guides = guides.ok_or_else(|| usage("--guides <dir> is required"))?;
	let root = match root {
		Some(r) => r,
		None => find_root(&guides).or_else(|| find_root(&std::env::current_dir().ok()?)).ok_or("no data/forever above the guides or here; pass --root")?,
	};
	let data = data.unwrap_or_else(|| root.join("data/forever"));
	let ctx = forge_judge::seed::Ctx::new(&guides, &data, &root)?;
	let out = forge_judge::seed::run(&ctx, filter.as_deref());
	let lint = if lint { Some(forge_judge::seed::lint(&guides, &ctx.data)) } else { None };
	let failed = out.iter().filter(|o| !o.passed).count();
	if as_json {
		println!("{}", serde_json::to_string_pretty(&json!({ "tests": out, "lint": lint.as_ref().map(|(e, w, l)| json!({ "errors": e, "warnings": w, "first": l })) })).map_err(|e| e.to_string())?);
	} else {
		for o in &out {
			let mark = if o.skipped.is_some() {
				"﹣"
			} else if o.passed {
				"✔"
			} else {
				"✖"
			};
			println!("{mark} {}", o.name);
			for f in &o.failures {
				println!("    {f}");
			}
		}
		println!("ℹ pass {}\nℹ fail {failed}", out.len() - failed);
		if let Some((e, w, first)) = &lint {
			println!("lint: {e} errors, {w} warnings");
			for l in first {
				println!("  {l}");
			}
		}
	}
	if failed > 0 {
		std::process::exit(1);
	}
	Ok(())
}

pub(super) const STATUS_USAGE: &str = "usage: forge judge route-status --report <file> [--out <file>]

The dashboard's route status from a judge report (forge judge report's report.json): per start the base
and new hours to 30 and 60, passed-by quests and avoidable returns to 60, honest fails, seed tests and
lint, the routes stage's skips (missing information and all; <start>.skips.json beside the route), the
report's time and data sources. --out: write it there, whole (the dashboard reads
data/local/dashboard/routes.json); else stdout.";

fn route_status(argv: Vec<String>) -> Result<(), Fail> {
	let (mut report, mut out): (Option<PathBuf>, Option<PathBuf>) = (None, None);
	let mut it = argv.into_iter();
	while let Some(a) = it.next() {
		let mut val = || it.next().map(PathBuf::from).ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--report" => report = Some(val()?),
			"--out" => out = Some(val()?),
			"-h" | "--help" => {
				println!("{STATUS_USAGE}");
				return Ok(());
			}
			k => return Err(usage(format!("unexpected {k}"))),
		}
	}
	let report = report.ok_or_else(|| usage("--report <file> is required"))?;
	let s = forge_judge::report::route_status(&report)?;
	let js = serde_json::to_string_pretty(&s).map_err(|e| e.to_string())?;
	match out {
		Some(f) => {
			// Written whole, then renamed: the dashboard never reads half a file.
			let tmp = f.with_extension("json.tmp");
			std::fs::write(&tmp, js).map_err(|e| format!("{}: {e}", tmp.display()))?;
			std::fs::rename(&tmp, &f).map_err(|e| format!("{}: {e}", f.display()))?;
		}
		None => println!("{js}"),
	}
	Ok(())
}

pub(super) const FEEDBACK_USAGE: &str = "usage: forge judge feedback --out <file> [--root <dir>] [--feedback <file>] [--route-fixes <file>] [--cache <file>]
                   [--offline] [--report <file>]

Player reports into the route's overrides: RouteFeedback.json's insert, drop and constraint inputs and the
GitHub issues labelled `guide` (gh api, cached; --offline: the cache only) become route-fixes override lines
(include, skip, and pairs as `deliberate` writes them), each with its source and whether the sim already
honours it. --out: the route fixes with those overrides (the sim reads it as $POLESTAR_ROUTE_FIXES);
--report: the full result (entries, manual specs, untriaged issues) as JSON. Defaults under --root (the
checkout above the current folder): data/local/research/RouteFeedback.json, data/route-fixes.json, and
data/local/research/guide-issues.json as the issue cache.";

fn feedback(argv: Vec<String>) -> Result<(), Fail> {
	let (mut out, mut root, mut fb, mut fixes, mut cache, mut report): (Option<PathBuf>, Option<PathBuf>, Option<PathBuf>, Option<PathBuf>, Option<PathBuf>, Option<PathBuf>) = Default::default();
	let mut offline = false;
	let mut it = argv.into_iter();
	while let Some(a) = it.next() {
		let mut val = || it.next().map(PathBuf::from).ok_or_else(|| usage(format!("{a} needs a value")));
		match a.as_str() {
			"--out" => out = Some(val()?),
			"--root" => root = Some(val()?),
			"--feedback" => fb = Some(val()?),
			"--route-fixes" => fixes = Some(val()?),
			"--cache" => cache = Some(val()?),
			"--report" => report = Some(val()?),
			"--offline" => offline = true,
			"-h" | "--help" => {
				println!("{FEEDBACK_USAGE}");
				return Ok(());
			}
			k => return Err(usage(format!("unexpected {k}"))),
		}
	}
	let dest = out.ok_or_else(|| usage("--out <file> is required"))?;
	let root = match root {
		Some(r) => r,
		None => find_root(&std::env::current_dir().map_err(|e| e.to_string())?).ok_or("no data/forever above the current folder; pass --root")?,
	};
	let read = |p: &Path| -> Result<Value, Fail> { Ok(serde_json::from_slice(&std::fs::read(p).map_err(|e| format!("{}: {e}", p.display()))?).map_err(|e| format!("{}: {e}", p.display()))?) };
	let research = root.join("data/local/research");
	let feedback = read(&fb.unwrap_or_else(|| research.join("RouteFeedback.json")))?;
	let fixes_file = fixes.unwrap_or_else(|| root.join(forge_sim::fixes::FILE));
	let fixes = forge_sim::fixes::parse(&std::fs::read(&fixes_file).map_err(|e| format!("{}: {e}", fixes_file.display()))?, &fixes_file.display().to_string())?;
	let (issues, from) = forge_judge::feedback::issues(&cache.unwrap_or_else(|| research.join("guide-issues.json")), offline);
	let res = forge_judge::feedback::run(&feedback, &issues, &from, &fixes["overrides"], &fixes["deliberate"]);
	let mut doc = fixes.clone();
	doc["overrides"] = res.overrides.clone();
	std::fs::write(&dest, serde_json::to_string_pretty(&doc).map_err(|e| e.to_string())? + "\n").map_err(|e| format!("{}: {e}", dest.display()))?;
	if let Some(r) = report {
		std::fs::write(&r, serde_json::to_string_pretty(&res).map_err(|e| e.to_string())? + "\n").map_err(|e| format!("{}: {e}", r.display()))?;
	}
	let by = |sec: &str, applied: bool| res.entries.iter().filter(|e| e.section == sec && e.applied == applied).count();
	println!(
		"feedback: issues from {} ({}); include {} new / {} applied, skip {} / {}, pairs {} / {}; {} specs manual, {} issues untriaged -> {}",
		res.issues_from,
		issues.len(),
		by("include", false),
		by("include", true),
		by("skip", false),
		by("skip", true),
		by("pairs", false),
		by("pairs", true),
		res.manual.len(),
		res.untriaged.len(),
		dest.display()
	);
	Ok(())
}
