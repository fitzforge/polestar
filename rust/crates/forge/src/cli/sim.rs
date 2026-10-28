//! forge sim: the route of a start cut from the current guides' order and improved, the shared
//! route, the guards, why a quest is in or out, the skip ledgers, calibration; `replay` (a
//! developer check, not in the help) replays a reference order on the evaluator.
//!
//!   forge sim route --faction F --start <race> [--seed guides|<file>] [--tries N] --out <file.json>

use forge_sim::chain::{compare_reference, events_from, goals_from, replay_events};
use forge_sim::profile::Profile;
use forge_sim::route::{stats_json, Extras};
use forge_sim::search::GuardMode;
use forge_sim::search::SearchOpts;
use forge_sim::shared::{shared_route, Start};
use forge_sim::stage::{self, RouteOpts};
use forge_sim::{compile_run, Model, NoWalks, Params, WalkTable, Walks};
use forge_world::{Rules, World};
use serde_json::json;
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::time::Instant;

/// `--k v` or `--k=v`.
fn arg(args: &[String], k: &str) -> Option<String> {
	args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k).and_then(|r| r.strip_prefix('=')).map(String::from)))
}

/// `--k v` or `--k=v` parsed as a number; a usage error when it is not one.
fn num<T: std::str::FromStr>(args: &[String], k: &str) -> Option<T> {
	arg(args, k).map(|v| v.parse().unwrap_or_else(|_| usage(&format!("{k} {v}: not a number"))))
}

/// `--cut knee|all`: where an edit descent is cut (default all: every edit it made).
fn cut_arg(args: &[String]) -> forge_sim::search::edits::Cut {
	match arg(args, "--cut") {
		None => forge_sim::search::edits::Cut::All,
		Some(v) => forge_sim::search::edits::Cut::parse(&v).unwrap_or_else(|| usage(&format!("--cut {v}: knee or all"))),
	}
}

/// `--param name=value`, repeatable: e.g. camps=1, spots=1; `--deathskips` is deathskips=1 (the
/// route profiles may die and take a graveyard's Spirit Healer where that beats the leg).
fn overrides(args: &[String]) -> Vec<(String, f64)> {
	let mut v: Vec<(String, f64)> = args
		.windows(2)
		.filter(|w| w[0] == "--param")
		.map(|w| {
			let (k, v) = w[1].split_once('=').unwrap_or_else(|| usage("--param name=value"));
			(k.to_string(), v.parse().unwrap_or_else(|_| usage(&format!("--param {k}: not a number"))))
		})
		.collect();
	if args.iter().any(|a| a == "--deathskips") {
		v.push(("deathskips".into(), 1.0));
	}
	v
}

/// A failure: exit 1.
fn die(m: &str) -> ! {
	eprintln!("forge sim: {m}");
	std::process::exit(1)
}

/// A usage error: exit 2.
fn usage(m: &str) -> ! {
	eprintln!("forge sim: {m} (forge sim --help)");
	std::process::exit(2)
}

/// [`super::check_args`], a usage error when it fails.
fn check(args: &[String], values: &[&str], flags: &[&str], bare: usize) {
	super::check_args(args, values, flags, bare).unwrap_or_else(|e| usage(&e));
}

fn faction_arg(args: &[String]) -> forge_core::Faction {
	match arg(args, "--faction") {
		Some(f) => forge_core::Faction::parse(&f).unwrap_or_else(|| usage(&format!("--faction {f}: horde or alliance"))),
		None => usage("--faction horde|alliance is required"),
	}
}

/// `--walks on|off` (default `on_default`).
fn walks_arg(args: &[String], on_default: bool) -> bool {
	match arg(args, "--walks").as_deref() {
		None => on_default,
		Some("on") => true,
		Some("off") => false,
		Some(x) => usage(&format!("--walks {x}: on or off")),
	}
}

fn threads_arg(args: &[String]) {
	let threads = num(args, "--threads").unwrap_or(8usize);
	rayon::ThreadPoolBuilder::new().num_threads(threads).build_global().ok();
}

pub struct Loaded {
	pub world: World,
	pub walks: Box<dyn Walks>,
	pub params_doc: Option<Value>,
}

fn load(root: &Path, faction: forge_core::Faction, walks_on: bool) -> Loaded {
	let t0 = Instant::now();
	forge_sim::fixes::load_for(&[root]).unwrap_or_else(|e| die(&format!("route fixes: {e}")));
	let world = forge_sim::load_world(&root.join("data/sim"), faction).unwrap_or_else(|e| die(&e));
	eprintln!("world {} loaded in {:.2} s ({} points, {} quests)", faction.name(), t0.elapsed().as_secs_f64(), world.points.len(), world.quests.len());
	let walks: Box<dyn Walks> = if walks_on {
		let t1 = Instant::now();
		let f = root.join(format!("data/sim/walks-{}.bin", faction.lower()));
		let w = WalkTable::load(&f, world.points.len()).unwrap_or_else(|e| die(&e));
		if !w.built_on(&world) {
			eprintln!("warning: {} was built on another world ({})", f.display(), w.built_on_text(&world));
		}
		eprintln!("walks: {} pairs in {:.2} s", w.len(), t1.elapsed().as_secs_f64());
		Box::new(w)
	} else {
		Box::new(NoWalks)
	};
	let params_doc = std::fs::read(root.join("data/sim/params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
	Loaded { world, walks, params_doc }
}

fn replay(args: &[String]) {
	check(args, &["--root", "--faction", "--race", "--walks", "--ref"], &[], 0);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let faction = faction_arg(args);
	let race = arg(args, "--race").unwrap_or_else(|| usage("--race <race> is required"));
	let walks_on = walks_arg(args, false);
	let rf = arg(args, "--ref").unwrap_or_else(|| usage("--ref <file.json> is required"));
	let doc: Value = serde_json::from_slice(&std::fs::read(&rf).unwrap_or_else(|e| die(&format!("{rf}: {e}")))).unwrap_or_else(|e| die(&format!("{rf}: not JSON: {e}")));
	let l = load(&root, faction, walks_on);
	let t0 = Instant::now();
	let rules = Rules::new(&l.world, &race, None, false);
	let run = compile_run(&l.world, &rules, &race, None, &[]).unwrap_or_else(|e| die(&e));
	let p = Params::effective(l.params_doc.as_ref(), None, &[]);
	let model = Model::new(run, &p, &*l.walks);
	eprintln!("model compiled in {:.2} s ({} quests, {} points)", t0.elapsed().as_secs_f64(), model.run.n_quests(), model.run.pt_list.len());
	let events = events_from(&doc);
	let mut ev = model.evaluator(&*l.walks);
	ev.journaling = false;
	let t1 = Instant::now();
	let rep = replay_events(&mut ev, &model.run, &events);
	let dt = t1.elapsed().as_secs_f64();
	let reps = 20;
	let t2 = Instant::now();
	for _ in 0..reps {
		replay_events(&mut ev, &model.run, &events);
	}
	let per_eval = t2.elapsed().as_secs_f64() / reps as f64;
	let c = compare_reference(&doc, &events, &rep);
	let jsteps = doc["atEnd"]["steps"].as_u64().unwrap_or(0);
	println!(
        "{} {} walks {}: events {} (compared {}), steps done {} (reference {}), unknown {}, hours to 60 {:.4} (reference {:.4}), to 30 {:.4} (reference {:.4}), max |Δlevel| {:.2e}, max |Δt| {:.3} s, first mismatch {:?}, replay {:.2} ms (first {:.2} ms)",
        faction.name(),
        race,
        if walks_on { "on" } else { "off" },
        rep.per.len(),
        c.compared,
        ev.s.steps,
        jsteps,
        rep.unknown.len(),
        c.hours60,
        c.js_hours60,
        c.to30,
        c.js_to30,
        c.max_dlevel,
        c.max_dt,
        c.first,
        per_eval * 1000.0,
        dt * 1000.0
    );
	if let Some(k) = c.first {
		for j in k.saturating_sub(2)..(k + 3).min(rep.per.len()) {
			println!("  event {j} {:?}: {:?}", events[j], rep.per[j]);
		}
	}
}

/// The seed of a start: `--seed <file>` (a chain document: `goals`), or `--seed guides` (the
/// default): the goal stream made from the current guides as `forge build` makes it
/// ([`forge::v1_goals`]: `--guides <dir>`, default <root>/guides, over <root>/data/forever), or,
/// with $POLESTAR_V1_SEEDS set, the file v1-<faction>-<race>-on.json there.
fn seed_doc(args: &[String], faction: forge_core::Faction, race: &str) -> (String, Value) {
	let s = arg(args, "--seed").unwrap_or_else(|| "guides".into());
	if s == "guides" {
		if let Ok(dir) = std::env::var("POLESTAR_V1_SEEDS") {
			let f = format!("{dir}/v1-{}-{}-on.json", faction.lower(), race.to_lowercase());
			let b = std::fs::read(&f).unwrap_or_else(|e| die(&format!("seed {f}: {e}")));
			return (f, serde_json::from_slice(&b).unwrap_or_else(|e| die(&format!("seed: {e}"))));
		}
		let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
		let guides = arg(args, "--guides").map(PathBuf::from).unwrap_or_else(|| root.join("guides"));
		let guides = guides.canonicalize().unwrap_or(guides);
		let doc = forge::v1_goals(&guides, &root.join("data/forever"), faction, race).unwrap_or_else(|e| die(&format!("the guides' order in {}: {e}", guides.display())));
		return (format!("the guides' order in {}", guides.display()), doc);
	}
	let b = std::fs::read(&s).unwrap_or_else(|e| die(&format!("seed {s}: {e}")));
	(s, serde_json::from_slice(&b).unwrap_or_else(|e| die(&format!("seed: {e}"))))
}

/// `args` without `--seed X` (several starts each take their own seed).
fn without_seed(args: &[String]) -> Vec<String> {
	let mut out = Vec::new();
	let mut it = args.iter();
	while let Some(a) = it.next() {
		if a == "--seed" {
			it.next();
		} else {
			out.push(a.clone());
		}
	}
	out
}

fn profile_of(name: &str, f: forge_core::Faction) -> Profile {
	match name {
		"gate" => Profile::gate(),
		"slow" => Profile::slow(f),
		"fast" => Profile::fast(f),
		"avg" => Profile::average(f),
		x => usage(&format!("--profile {x}: avg, slow, fast or gate")),
	}
}

/// forge sim widen --faction F --starts A,B,... [--edits N] [--budget K] [--cut knee|all] --out <json>:
/// the shared tail of the starts (the first canonical) with an edit budget, no start slower.
fn widen_cmd(args: &[String]) {
	check(
		args,
		&["--root", "--faction", "--starts", "--out", "--threads", "--seed", "--guides", "--param", "--edits", "--budget", "--cut", "--members", "--join-at"],
		&["--diagnose", "--deathskips"],
		0,
	);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let faction = faction_arg(args);
	let list = arg(args, "--starts").unwrap_or_else(|| usage("--starts A,B,... is required"));
	let out = arg(args, "--out").unwrap_or_else(|| usage("--out <file.json> is required"));
	threads_arg(args);
	let starts: Vec<forge_sim::widen::WidenStart> = list
		.split(',')
		.map(|r| {
			let (_, doc) = seed_doc(&without_seed(args), faction, r);
			forge_sim::widen::WidenStart { race: r.to_string(), events: events_from(&doc), goals: goals_from(&doc) }
		})
		.collect();
	let l = load(&root, faction, true);
	let base = Params::effective(l.params_doc.as_ref(), None, &overrides(args));
	let data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&root)).unwrap_or_else(|e| die(&format!("game data: {e:?}")));
	let atlas = judge_atlas(&root, faction, &data);
	let doubtful = kb_doubts_of(&root);
	let rewards = forge_sim::needs::load_rewards(&root);
	let kb_missing = kb_missing_of(&root);
	let ex = Extras { data: Some(&data), atlas: Some(&atlas), guard: Some(GuardMode::Current), doubtful: Some(&doubtful), rewards: Some(&rewards), kb_missing: Some(&kb_missing) };
	let edits = num(args, "--edits").unwrap_or(400);
	let budget = num(args, "--budget");
	let members = num(args, "--members").unwrap_or(8);
	if args.iter().any(|a| a == "--diagnose") {
		let doc = forge_sim::widen::diagnose(&l.world, &*l.walks, &base, &starts, &Profile::average(faction), &ex, arg(args, "--join-at").as_deref()).unwrap_or_else(|e| die(&e));
		std::fs::write(&out, serde_json::to_string_pretty(&doc).unwrap_or_default()).unwrap_or_else(|e| die(&format!("{out}: {e}")));
		eprintln!("wrote {out}");
		return;
	}
	let join_at = arg(args, "--join-at");
	let doc = forge_sim::widen::widen(&l.world, &*l.walks, &base, &starts, &Profile::average(faction), &ex, edits, budget, cut_arg(args), members, join_at.as_deref()).unwrap_or_else(|e| die(&e));
	for r in doc["rows"].as_array().into_iter().flatten() {
		eprintln!(
			"  {:9} the guides' own {:.2} h, the guides' shared tail {:.2} h, knee {:.2} h, converged {:.2} h",
			r["start"].as_str().unwrap_or(""),
			r["v1Own"].as_f64().unwrap_or(0.0),
			r["v1Shared"].as_f64().unwrap_or(0.0),
			r["knee"].as_f64().unwrap_or(0.0),
			r["converged"].as_f64().unwrap_or(0.0)
		);
	}
	std::fs::write(&out, serde_json::to_string_pretty(&doc).unwrap_or_default()).unwrap_or_else(|e| die(&format!("{out}: {e}")));
	eprintln!("wrote {out}");
}

fn route(args: &[String]) {
	check(
		args,
		&[
			"--root",
			"--world-dir",
			"--faction",
			"--start",
			"--out",
			"--walks",
			"--profile",
			"--tries",
			"--members",
			"--rng",
			"--share-every",
			"--edits",
			"--budget",
			"--cut",
			"--search",
			"--guard",
			"--param",
			"--search-draws",
			"--holdout",
			"--threads",
			"--seed",
			"--guides",
		],
		&["--deathskips"],
		0,
	);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let world_dir = arg(args, "--world-dir").map(PathBuf::from).unwrap_or_else(|| root.join("data/sim"));
	let faction = faction_arg(args);
	let race = arg(args, "--start").unwrap_or_else(|| usage("--start <race> is required"));
	let out = arg(args, "--out").unwrap_or_else(|| usage("--out <file.json> is required"));
	let walks_on = walks_arg(args, true);
	let o = RouteOpts {
		profile: profile_of(&arg(args, "--profile").unwrap_or_else(|| "avg".into()), faction),
		search: SearchOpts {
			// --search edits|free|hybrid; without it, edits when --edits is given, else free.
			mode: match arg(args, "--search").as_deref() {
				None if num::<usize>(args, "--edits").is_some() => forge_sim::search::Mode::Edits,
				None => forge_sim::search::Mode::Free,
				Some(v) => forge_sim::search::Mode::parse(v).unwrap_or_else(|| usage(&format!("--search {v}: edits, free or hybrid"))),
			},
			no_worse: false,
			tries: num(args, "--tries").unwrap_or(20_000),
			members: num(args, "--members").unwrap_or(8),
			seed: num(args, "--rng").unwrap_or(1),
			share_every: num(args, "--share-every").unwrap_or(250),
			edits: num(args, "--edits"),
			budget: num(args, "--budget"),
			cut: cut_arg(args),
		},
		guard: match arg(args, "--guard").as_deref() {
			Some("off") => None,
			Some("current") => Some(GuardMode::Current),
			Some("seed") | None => Some(GuardMode::V1),
			Some(x) => usage(&format!("--guard {x}: seed, current or off")),
		},
		over: overrides(args),
		search_draws: num(args, "--search-draws").unwrap_or(0),
		holdout: num(args, "--holdout").unwrap_or(16),
	};
	threads_arg(args);
	let (seed_file, doc) = seed_doc(args, faction, &race);
	let l = stage::load(&world_dir, faction, walks_on).unwrap_or_else(|e| die(&e));
	let cx = stage::context(&root, faction).unwrap_or_else(|e| die(&e));
	let outp = Path::new(&out);
	let dir = outp.parent().filter(|p| !p.as_os_str().is_empty()).unwrap_or(Path::new("."));
	let name = outp.file_name().and_then(|n| n.to_str()).unwrap_or("route.json").trim_end_matches(".json").to_string();
	let resume = route_resume(args, &root, &world_dir, faction, &doc, dir, &name);
	let (r, files) = stage::route_one(&l, &cx, &race, &doc, &seed_file, &o, dir, &name, Some(&resume.unit(&name)), None).unwrap_or_else(|e| die(&e));
	resume.clear().unwrap_or_else(|e| die(&e));
	let h = |v: &Value, k: &str| v[k].as_f64().unwrap_or(f64::NAN);
	eprintln!(
		"guards ({:?}): avoidable returns {} -> {}, passed by {} -> {}; added {}, dropped {}",
		o.guard,
		r.guard_v1.avoidable_returns,
		r.guard_best.avoidable_returns,
		r.guard_v1.passed_by,
		r.guard_best.passed_by,
		r.added.len(),
		r.dropped.len()
	);
	eprintln!(
		"{} {} ({} profile, walks {}): the guides {:.2} h to 60 ({:.2} to 30) -> improved {:.2} h ({:.2} to 30); other model {:.2} -> {:.2}; gate {:.2} -> {:.2}; holdout gain {:.2} h ({} draws)",
		faction.name(),
		race,
		o.profile.name,
		if walks_on { "on" } else { "off" },
		h(&r.seed_hours, "hours60"),
		h(&r.seed_hours, "hours30"),
		h(&r.best_hours, "hours60"),
		h(&r.best_hours, "hours30"),
		h(&r.seed_other, "hours60"),
		h(&r.best_other, "hours60"),
		h(&r.seed_gate, "hours60"),
		h(&r.best_gate, "hours60"),
		r.holdout.mean,
		r.holdout.draws,
	);
	eprintln!("ledgers: {} skipped quests ({} missing info), {} edits", r.skips.len(), r.skips.iter().filter(|x| x["reason"] == "missing-info").count(), r.edit_rows.len());
	eprintln!("wrote {} files under {} ({out} + ledgers + judge goal streams)", files.len(), dir.display());
}

/// `forge sim route`'s checkpoints (forge_sim::resume): `<dir>/.<name>.resume/`, for its arguments
/// (but `--threads`: the route is the same at any thread count, so a rerun with fewer resumes),
/// seed, inputs and the forge binary, so a killed run resumes where it was and a run of other inputs
/// or code starts afresh. The world and walks files by size and time (the walks can be large).
fn route_resume(args: &[String], root: &Path, world_dir: &Path, faction: forge_core::Faction, seed: &Value, dir: &Path, name: &str) -> forge_sim::resume::Resume {
	use forge::Part;
	let stamp = |p: &Path| std::fs::metadata(p).map_or_else(|_| "missing".to_string(), |m| format!("{} {:?}", m.len(), m.modified().ok().and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())));
	let files = format!("{}\0{}", stamp(&world_dir.join(format!("world-{}.json", faction.lower()))), stamp(&world_dir.join(format!("walks-{}.bin", faction.lower()))));
	let env = ["POLESTAR_KB", "POLESTAR_GRID", forge_sim::fixes::ENV].map(|k| std::env::var(k).unwrap_or_default()).join("\0");
	let exe = std::env::current_exe().unwrap_or_default();
	let fixes = forge_sim::fixes::find(&[]).unwrap_or_default();
	let kb = stage::kb_path(root);
	let argv: Vec<&str> = args.iter().enumerate().filter(|&(i, a)| a != "--threads" && (i == 0 || args[i - 1] != "--threads")).map(|(_, a)| a.as_str()).collect();
	let key = forge::key(
		"sim-route",
		forge::ROUTES_VERSION,
		&[
			Part::Text(&argv.join("\0")),
			Part::Text(&env),
			Part::Text(&seed.to_string()),
			Part::Text(&files),
			Part::File(&world_dir.join("params.json")),
			Part::File(&fixes),
			Part::File(&kb),
			Part::Manifest(&root.join("data/forever")),
			Part::Manifest(&root.join("data/sources")),
			Part::File(&exe),
		],
	);
	let r = forge_sim::resume::Resume::open(&dir.join(format!(".{name}.resume")), &key).unwrap_or_else(|e| die(&e));
	eprintln!("checkpoints: {} (every {} s)", r.dir().display(), r.every.as_secs());
	r
}

/// Start races per faction (Troll and Gnome share a starting area with Orc and Dwarf and play the
/// same guides).
fn start_races(f: forge_core::Faction) -> &'static [&'static str] {
	match f {
		forge_core::Faction::Horde => &["Orc", "Troll", "Tauren", "Undead", "Skyborne"],
		forge_core::Faction::Alliance => &["Human", "Dwarf", "Gnome", "NightElf", "Skyborne"],
	}
}

fn opts_of(args: &[String], tries_key: &str, default: u64) -> SearchOpts {
	SearchOpts {
		tries: num(args, tries_key).unwrap_or(default),
		members: num(args, "--members").unwrap_or(8),
		seed: num(args, "--rng").unwrap_or(1),
		share_every: num(args, "--share-every").unwrap_or(250),
		..Default::default()
	}
}

/// forge sim shared --faction F [--tries N] [--own-tries M] --out <file.json>
fn shared(args: &[String]) {
	check(
		args,
		&["--root", "--faction", "--out", "--threads", "--walks", "--param", "--seed", "--guides", "--guard", "--own-tries", "--tries", "--members", "--rng", "--share-every"],
		&["--deathskips"],
		0,
	);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let faction = faction_arg(args);
	let out = arg(args, "--out").unwrap_or_else(|| usage("--out <file.json> is required"));
	threads_arg(args);
	let l = load(&root, faction, walks_arg(args, true));
	let base = Params::effective(l.params_doc.as_ref(), None, &overrides(args));
	let starts: Vec<Start> = start_races(faction)
		.iter()
		.map(|r| {
			let (_, doc) = seed_doc(&without_seed(args), faction, r);
			Start { race: r.to_string(), goals: goals_from(&doc), events: events_from(&doc) }
		})
		.collect();
	let data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&root)).unwrap_or_else(|e| die(&format!("game data: {e:?}")));
	let atlas = judge_atlas(&root, faction, &data);
	let doubtful = kb_doubts_of(&root);
	let judge = match arg(args, "--guard").as_deref() {
		Some("off") => None,
		None | Some("on") => Some((&data, &atlas, &doubtful)),
		Some(x) => usage(&format!("--guard {x}: on or off")),
	};
	let r = shared_route(&l.world, &*l.walks, &base, &starts, &opts_of(args, "--own-tries", 100_000), &opts_of(args, "--tries", 50_000), judge).unwrap_or_else(|e| die(&e));
	eprintln!(
		"{} shared route: sum over {} starts x 3 profiles {:.1} h -> {:.1} h; own routes {:.1} s, shared search {:.1} s ({} tries, {} kept)",
		faction.name(),
		starts.len(),
		r.seed_sum / 3600.0,
		r.best_sum / 3600.0,
		r.own_seconds,
		r.seconds,
		r.stats.tries,
		r.stats.kept
	);
	for row in &r.rows {
		eprintln!("  {:9} {:4}: join L{:.1}, the guides {:.2} h, own best {:.2} h, shared {:.2} h, lost {:+.2} h", row.start, row.profile, row.join_level, row.v1, row.own, row.shared, row.lost);
	}
	let doc = json!({ "faction": faction.name(), "rows": r.rows, "seedSum": r.seed_sum / 3600.0, "bestSum": r.best_sum / 3600.0, "search": stats_json(&r.stats, r.seconds), "steps": r.order.len() });
	std::fs::write(&out, serde_json::to_string_pretty(&doc).unwrap_or_default()).unwrap_or_else(|e| die(&format!("{out}: {e}")));
	eprintln!("wrote {out}");
}

/// forge sim guards --faction F --race R <chain.json>...: the guards' counts of each chain's
/// order (avg profile, walks on), to check them against the judge's on the same guides.
fn guards_cmd(args: &[String]) {
	check(args, &["--root", "--faction", "--race", "--export"], &[], usize::MAX);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let faction = faction_arg(args);
	let race = arg(args, "--race").unwrap_or_else(|| usage("--race <race> is required"));
	let l = load(&root, faction, true);
	let base = Params::effective(l.params_doc.as_ref(), None, &[]);
	let profile = Profile::average(faction);
	let (m, rules) = forge_sim::route::model_for(&l.world, &race, &profile, &base, &*l.walks).unwrap_or_else(|e| die(&e));
	let data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&root)).unwrap_or_else(|e| die(&format!("game data: {e:?}")));
	let atlas = judge_atlas(&root, faction, &data);
	let t0 = Instant::now();
	let g = forge_sim::guards::GuardData::new(&l.world, &m.run, &rules, &data, &atlas);
	eprintln!("guard data in {:.2} s", t0.elapsed().as_secs_f64());
	for f in args.iter().filter(|a| a.ends_with(".json")) {
		let doc: Value = std::fs::read(f).map_err(|e| e.to_string()).and_then(|b| serde_json::from_slice(&b).map_err(|e| e.to_string())).unwrap_or_else(|e| die(&format!("{f}: {e}")));
		let mut ev = m.evaluator(&*l.walks);
		let o = forge_sim::order::seed_order(&mut ev, &events_from(&doc), true);
		let t0 = Instant::now();
		let c = &forge_sim::search::runs(&forge_sim::search::Problem::single(&m, &*l.walks, Vec::new(), Vec::new()), &o)[0];
		let gc = c.guard_counts(&g, &m.run);
		println!("{f}: {:.2} h cost (grinding weighted), {} steps, guards {:?} ({:.1} ms)", c.total / 3600.0, o.len(), gc, t0.elapsed().as_secs_f64() * 1000.0);
		if let Some(dir) = arg(args, "--export") {
			let out = Path::new(&dir).join(Path::new(f).file_name().unwrap_or_default());
			let goals = forge_sim::route::judge_goals(&m, &l.world, &rules, &o.steps, c);
			std::fs::write(&out, serde_json::to_string(&json!({ "goals": goals })).unwrap_or_default()).unwrap_or_else(|e| die(&format!("{}: {e}", out.display())));
			eprintln!("wrote {}", out.display());
		}
	}
}

/// The quest atlas as the judge builds it: the faction's, subzones from the walking grid's tile
/// heads (data/local/nav4, or $POLESTAR_GRID).
fn judge_atlas(root: &Path, faction: forge_core::Faction, data: &forge_world::GameData) -> forge_world::Atlas {
	let t0 = Instant::now();
	let grid = std::env::var("POLESTAR_GRID").map(PathBuf::from).unwrap_or_else(|_| root.join("data/local/nav4"));
	let sub = forge_world::atlas::GridSubzones::open(&grid, &root.join("data/sources"));
	let a = forge_world::Atlas::build_for(faction, data, Some(&sub), None);
	eprintln!("atlas in {:.2} s ({} areas)", t0.elapsed().as_secs_f64(), a.areas.len());
	a
}

/// The knowledge base's doubtful quests (data/local/kb/forever-kb.sqlite, or $POLESTAR_KB).
fn kb_missing_of(root: &Path) -> rustc_hash::FxHashMap<u32, Vec<forge_sim::insertable::Missing>> {
	let kb = std::env::var("POLESTAR_KB").map(PathBuf::from).unwrap_or_else(|_| root.join("data/local/kb/forever-kb.sqlite"));
	forge_sim::insertable::kb_missing(&kb).unwrap_or_else(|e| die(&format!("knowledge base: {e}")))
}

fn kb_doubts_of(root: &Path) -> rustc_hash::FxHashMap<u32, String> {
	let kb = std::env::var("POLESTAR_KB").map(PathBuf::from).unwrap_or_else(|_| root.join("data/local/kb/forever-kb.sqlite"));
	let d = forge_sim::insertable::kb_doubts(&kb).unwrap_or_else(|e| die(&format!("knowledge base: {e}")));
	eprintln!("knowledge base: {} quests uncertain (never added)", d.len());
	d
}

pub fn main() {
	let args: Vec<String> = super::args().skip(1).collect();
	match args.first().map(String::as_str) {
		Some("replay") => replay(&args[1..]),
		Some("route") => route(&args[1..]),
		Some("widen") => widen_cmd(&args[1..]),
		Some("shared") => shared(&args[1..]),
		Some("guards") => guards_cmd(&args[1..]),
		Some("calibrate") => calibrate_cmd(&args[1..]),
		Some("why") => why_cmd(&args[1..]),
		Some("skips") => skips_cmd(&args[1..]),
		Some(x) => usage(&format!("unknown command {x}")),
		None => usage("a command is needed"),
	}
}

/// forge sim calibrate [--root R] [--world-dir D] [--fdj DIR] [--recordings DIR] [--out FILE]:
/// params.json from the two worlds (default <R>/data/sim), the dungeon journal's observed rewards
/// (default: the installed journal) and the recordings (default <R>/data/recordings); written to
/// --out (default <world dir>/params.json).
fn calibrate_cmd(args: &[String]) {
	check(args, &["--root", "--world-dir", "--fdj", "--recordings", "--out", "--at"], &[], 0);
	let root = PathBuf::from(arg(args, "--root").unwrap_or_else(|| ".".into()));
	let world_dir = arg(args, "--world-dir").map(PathBuf::from).unwrap_or_else(|| root.join("data/sim"));
	let fdj = arg(args, "--fdj").map(PathBuf::from).or_else(|| forge_data::dungeons::find_dungeon_journal(None));
	let recordings = arg(args, "--recordings").map(PathBuf::from).unwrap_or_else(|| root.join("data/recordings"));
	let out = arg(args, "--out").map(PathBuf::from).unwrap_or_else(|| world_dir.join("params.json"));
	let at = arg(args, "--at").unwrap_or_else(forge_data::build::now_iso);
	let c = forge::calibrate::calibrate(&world_dir, fdj.as_deref(), &recordings, &at).unwrap_or_else(|e| die(&e));
	let tmp = out.with_extension("json.tmp");
	std::fs::write(&tmp, &c.text).and_then(|_| std::fs::rename(&tmp, &out)).unwrap_or_else(|e| die(&format!("{}: {e}", out.display())));
	let f = |x: &Option<forge::calibrate::Fit>| x.map_or("none".to_string(), |f| format!("n {}, median ratio {:.3}, spread x{:.2}", f.n, f.mean, f.spread.exp()));
	println!("quest rewards vs the QuestXP table: {}", f(&c.est));
	println!("observed Forever rewards vs the data's: {} (of {})", f(&c.forever), c.forever_total);
	println!("recordings: {} sessions{}", c.sessions, if c.sessions == 0 { " (time parameters keep their priors)" } else { "" });
	println!("wrote {}", out.display());
}

/// The routes folder `why` and `skips` read: --dir D, else <O>/routes for --out O (a forge build's
/// output), else $POLESTAR_ROUTES.
fn routes_dir(args: &[String]) -> PathBuf {
	arg(args, "--dir")
		.map(PathBuf::from)
		.or_else(|| arg(args, "--out").map(|o| PathBuf::from(o).join("routes")))
		.or_else(|| std::env::var_os("POLESTAR_ROUTES").map(PathBuf::from))
		.unwrap_or_else(|| usage("--dir <routes dir> or --out <forge build output> is required (or POLESTAR_ROUTES)"))
}

/// forge sim why <quest> --start S [--dir D]: where the quest is in S's cut (and the edits
/// that moved it) or why it is not (its skip ledger row). D: the cut's directory ([`routes_dir`]);
/// files <S>.json, <S>.skips.json, <S>.edits.json.
fn why_cmd(args: &[String]) {
	check(args, &["--start", "--dir", "--out"], &[], 1);
	let q: u32 = args.first().and_then(|v| v.parse().ok()).unwrap_or_else(|| usage("why <quest id> --start S [--dir <dir>]"));
	let start = arg(args, "--start").unwrap_or_else(|| usage("--start <race> is required"));
	let dir = routes_dir(args);
	let read = |name: String| -> Value { std::fs::read(dir.join(&name)).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_else(|| die(&format!("{}: missing", dir.join(&name).display()))) };
	let route = read(format!("{start}.json"));
	print!("{}", forge_sim::ledger::why(q, &route["order"], &read(format!("{start}.skips.json")), &read(format!("{start}.edits.json"))));
}

/// forge sim skips [--reason R] [--dir D]: the skip ledger rows of every start in D (one row
/// per quest, with the starts), e.g. --reason missing-info for a "help us with these quests" list.
fn skips_cmd(args: &[String]) {
	check(args, &["--reason", "--dir", "--out"], &[], 0);
	let reason = arg(args, "--reason");
	let dir = routes_dir(args);
	let mut by: std::collections::BTreeMap<u64, (Value, Vec<String>)> = Default::default();
	let mut files: Vec<PathBuf> =
		std::fs::read_dir(&dir).unwrap_or_else(|e| die(&format!("{}: {e}", dir.display()))).flatten().map(|e| e.path()).filter(|p| p.to_string_lossy().ends_with(".skips.json")).collect();
	files.sort();
	for f in files {
		let start = f.file_name().unwrap_or_default().to_string_lossy().trim_end_matches(".skips.json").to_string();
		let rows: Value = std::fs::read(&f).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or(Value::Null);
		for r in rows.as_array().into_iter().flatten() {
			if reason.as_deref().is_some_and(|x| r["reason"].as_str() != Some(x)) {
				continue;
			}
			let id = r["q"].as_u64().unwrap_or(0);
			by.entry(id).or_insert_with(|| (r.clone(), Vec::new())).1.push(start.clone());
		}
	}
	println!("| quest | level | where | reason | what is missing / detail | fix in | starts |");
	println!("|---|---|---|---|---|---|---|");
	for (id, (r, starts)) in &by {
		let miss: Vec<&str> = r["missing"].as_array().into_iter().flatten().filter_map(|m| m["what"].as_str()).collect();
		let mut fix: Vec<&str> = r["missing"].as_array().into_iter().flatten().filter_map(|m| m["fix"].as_str()).collect();
		fix.dedup();
		let detail = if miss.is_empty() { r["detail"].as_str().unwrap_or("").to_string() } else { miss.join("; ") };
		println!(
			"| {id} {} | {} | {} | {} | {} | {} | {} |",
			r["title"].as_str().unwrap_or(""),
			r["level"],
			r["guide"].as_str().unwrap_or(""),
			r["reason"].as_str().unwrap_or(""),
			detail.replace('|', "/"),
			fix.join("; "),
			starts.join(", ")
		);
	}
	eprintln!("{} quests", by.len());
}
