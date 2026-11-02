//! forge writer apply-route: a route written into the guides (the output tree and summary line
//! of `polestar apply-route`); apply-routes: every start of a build's routes, as the guides stage
//! writes them; gate-diff: the writer gate's comparison (crate::gate).

use std::collections::BTreeMap;
use std::path::PathBuf;
use std::process::ExitCode;

pub(super) const USAGE: &str = "usage: forge writer apply-route <route.json> --world <world-faction.json> --out <dir>
                           [--guides <dir>] [--data <dir>] [--root <checkout>] [--checkout <dir>] [--walks <file>]
                           [--format-0-3] [--no-engine] [--no-along] [--no-use] [--no-when] [--no-level]
                           [--no-tips] [--no-warnings] [--no-groups]
                           [--no-route-legs] [--no-repair]

Copies the guides (default <root>/guides) to --out and rewrites the route's chain in the route's order:
the guides' own lines move with their step's tips, added quests become accept, objective and turn-in
steps, dropped quests' lines go, and each changed guide gets a comment block. Travel between steps is
the route's own legs (walks, flights, rides, hearths). The faction's shared guides (from the Barrens or
Westfall on) are written once, from the shared order of every route of the faction beside this one
(routes/<Start>.json): the same files for every start (docs/forge/writer.md, \"One shared route\").

  --world          the simulator world the route's points index (world-horde.json, world-alliance.json)
  --walks          the walk file for walking yards (default walks-<faction>.bin beside --world)
  --data           the game data (default <root>/data/forever)
  --root           the Polestar checkout (default: the nearest folder above here with data/forever)
  --checkout       the checkout whose data/places.json and data/guide-fixes.json are applied to the
                   written guides, last (default: --root); each record's state is printed
  --no-route-legs  keep the guides' own travel lines, checked by playing them (--no-repair: unchecked)
  --no-engine      plain steps only, without the addon features below
  --no-along, --no-use, --no-when, --no-level   leave out one feature: `along until` for work the route
                   walks past, `use` for item quests, `when onquest`/`when bound` guards, fractional
                   `level` targets
  --no-tips        no notes on where a goal's NPC or object stands (upstairs, below ground, in a cave,
                   under water) or that an NPC walks around
  --no-warnings    no `Careful:` tips from the quest notes (ambushes, stealthed mobs, adds)
  --no-groups      the route's elite and group quests unasked: no `when group`, no elite tip or group
                   size on them, no solo grind for a player who skips them
  --format-0-3     also `when group`, `task`/`cast`, `abandon`, `skipto` (guide pack format 5, Polestar 0.3.0)

usage: forge writer apply-routes <routes dir> --sim <dir> --out <dir> [--starts Orc,Human,...]
                           [--guides <dir>] [--data <dir>] [--root <checkout>] [--checkout <dir>]

Every start's route in <routes dir> (default: every start of its starts.json) written as forge build's
guides stage writes it: the default options, world-<faction>.json and walks-<faction>.bin from --sim,
each faction's starts in turn sharing its shared guides (the factions at once). Writes <out>/<Start>/,
<out>/<Start>.fixes.json (the fix pass's rows), <out>/<Start>.log (the writer's log) and
<out>/<Start>.status (`ok`, or why the start was not written). Exit 1 when a start was not written.

usage: forge writer gate-diff <previous run> <new run> [--out <file>] [--labels <previous>,<new>]

The writer gate's comparison (rust/scripts/writer-gate.sh runs it; docs/forge/writer.md, \"The writer
gate\"): each run holds a folder per route set with check.json (forge judge check --out) and guides/
(apply-routes' output, with <Start>.seed.json from forge judge seed-tests --json). Blockers, failing
player-report checks, records that no longer apply and refused starts are compared by what they are,
not by line number. Writes the report to --out (default <new run>/gate.md) and gate.json beside it,
prints its verdict and counts. Exit 1 when the new run has one the previous run has not (or meets it
for more classes).";

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	let usage = |m: &str| {
		eprintln!("forge writer: {m}\n(forge writer --help for the options)");
		ExitCode::from(2)
	};
	match args.first().map(String::as_str) {
		Some("apply-route") => {}
		Some("apply-routes") => return report(run_many(&args[1..]), usage),
		Some("gate-diff") => return report(gate_diff(&args[1..]), usage),
		Some(x) => return usage(&format!("unknown command {x}")),
		None => return usage("a command is needed"),
	}
	report(run(&args[1..]), usage)
}

/// A command's exit: usage errors exit 2, failures 1, a refused start or a failed gate 1 (Ok(Ok(false))).
fn report<R: Into<Done>>(r: Result<Result<R, String>, String>, usage: impl Fn(&str) -> ExitCode) -> ExitCode {
	match r {
		Ok(Ok(d)) => match d.into() {
			Done::Yes => ExitCode::SUCCESS,
			Done::No => ExitCode::from(1),
		},
		Ok(Err(m)) => usage(&m),
		Err(e) => {
			eprintln!("forge writer: {e}");
			ExitCode::from(1)
		}
	}
}

enum Done {
	Yes,
	No,
}

impl From<()> for Done {
	fn from(_: ()) -> Done {
		Done::Yes
	}
}

impl From<bool> for Done {
	fn from(ok: bool) -> Done {
		if ok {
			Done::Yes
		} else {
			Done::No
		}
	}
}

/// Value options and positionals of a subcommand's arguments (`names`: the options taking a value).
fn parse<'a>(args: &'a [String], names: &[&str]) -> Result<(Vec<String>, BTreeMap<&'a str, String>), String> {
	let (mut positional, mut opt) = (Vec::new(), BTreeMap::new());
	let mut i = 0;
	while i < args.len() {
		let a = args[i].as_str();
		if names.contains(&a) {
			let v = args.get(i + 1).ok_or_else(|| format!("{a} needs a value"))?;
			opt.insert(a, v.clone());
			i += 2;
		} else if a.starts_with("--") {
			return Err(format!("unknown option {a}"));
		} else {
			positional.push(a.to_string());
			i += 1;
		}
	}
	Ok((positional, opt))
}

/// forge writer apply-routes: Ok(Ok(false)) when a start was not written.
fn run_many(args: &[String]) -> Result<Result<bool, String>, String> {
	let (positional, opt) = match parse(args, &["--sim", "--out", "--starts", "--guides", "--data", "--root", "--checkout"]) {
		Ok(p) => p,
		Err(m) => return Ok(Err(m)),
	};
	let ([routes], Some(sim), Some(out)) = (positional.as_slice(), opt.get("--sim"), opt.get("--out")) else {
		return Ok(Err("one routes folder, --sim <dir> and --out <dir> are required".into()));
	};
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	let (routes, sim, out) = (cwd.join(routes), cwd.join(sim), cwd.join(out));
	let root: PathBuf = match opt.get("--root") {
		Some(r) => cwd.join(r),
		None => cwd.ancestors().find(|d| d.join("data/forever").is_dir()).ok_or("no data/forever above the working directory (give --root)")?.to_path_buf(),
	};
	let guides = opt.get("--guides").map_or_else(|| root.join("guides"), |g| cwd.join(g));
	let data_dir = opt.get("--data").map_or_else(|| root.join("data/forever"), |d| cwd.join(d));
	let checkout = opt.get("--checkout").map(|c| cwd.join(c));
	let starts: Vec<String> = match opt.get("--starts") {
		Some(s) => s.split(',').map(str::trim).filter(|s| !s.is_empty()).map(str::to_string).collect(),
		None => {
			let table: serde_json::Value = forge_writer::native::read_json(&routes.join("starts.json"))?;
			table.as_array().into_iter().flatten().filter_map(|r| r["start"].as_str().map(str::to_string)).collect()
		}
	};
	// Each start's faction from its route; the factions' starts in the given order.
	let mut by_faction: BTreeMap<String, Vec<String>> = BTreeMap::new();
	for s in &starts {
		let route: serde_json::Value = forge_writer::native::read_json(&routes.join(format!("{s}.json")))?;
		let f = route["faction"].as_str().ok_or_else(|| format!("{s}.json: no faction"))?.to_lowercase();
		by_faction.entry(f).or_default().push(s.clone());
	}
	std::fs::create_dir_all(&out).map_err(|e| format!("{}: {e}", out.display()))?;
	let write_one = |start: &str, faction: &str, cache: &mut forge_writer::native::SharedCache| -> Result<bool, String> {
		let pin = forge_writer::native::PathInputs {
			route: routes.join(format!("{start}.json")),
			world: sim.join(format!("world-{faction}.json")),
			walks: Some(sim.join(format!("walks-{faction}.bin"))),
			guides: guides.clone(),
			root: root.clone(),
			data_dir: Some(data_dir.clone()),
			out: out.join(start),
			checkout: checkout.clone(),
		};
		let file = |ext: &str| out.join(format!("{start}.{ext}"));
		let put = |ext: &str, text: String| std::fs::write(file(ext), text).map_err(|e| format!("{}: {e}", file(ext).display()));
		match forge_writer::native::run_paths(&pin, &forge_writer::RunOpts::default(), cache) {
			Ok(r) => {
				put("log", r.log.join("\n") + "\n")?;
				put("fixes.json", serde_json::to_string_pretty(&r.fixes).map_err(|e| e.to_string())?)?;
				put("status", "ok\n".into())?;
				println!("apply-routes {start}: {}", r.summary);
				Ok(true)
			}
			Err(e) => {
				put("status", format!("failed: {e}\n"))?;
				eprintln!("apply-routes {start}: not written: {e}");
				Ok(false)
			}
		}
	};
	let results: Vec<Result<bool, String>> = std::thread::scope(|scope| {
		let handles: Vec<_> = by_faction
			.iter()
			.map(|(faction, starts)| {
				let write_one = &write_one;
				scope.spawn(move || -> Result<bool, String> {
					let mut cache = forge_writer::native::SharedCache::default();
					let mut all = true;
					for s in starts {
						all &= write_one(s, faction, &mut cache)?;
					}
					Ok(all)
				})
			})
			.collect();
		handles.into_iter().map(|h| h.join().unwrap_or_else(|_| Err("a writer thread panicked".into()))).collect()
	});
	let mut all = true;
	for r in results {
		all &= r?;
	}
	Ok(Ok(all))
}

/// forge writer gate-diff: Ok(Ok(false)) when the new run fails the gate.
fn gate_diff(args: &[String]) -> Result<Result<bool, String>, String> {
	use forge::gate;
	let (positional, opt) = match parse(args, &["--out", "--labels"]) {
		Ok(p) => p,
		Err(m) => return Ok(Err(m)),
	};
	let [base, cand] = positional.as_slice() else {
		return Ok(Err("the previous run's and the new run's folders are needed".into()));
	};
	let (base, cand) = (PathBuf::from(base), PathBuf::from(cand));
	let labels = opt.get("--labels").cloned().unwrap_or_else(|| format!("{},{}", base.display(), cand.display()));
	let (lb, lc) = labels.split_once(',').unwrap_or((labels.as_str(), ""));
	// The route sets: the new run's folders with a check.
	let mut names: Vec<String> = std::fs::read_dir(&cand)
		.map_err(|e| format!("{}: {e}", cand.display()))?
		.flatten()
		.filter(|e| e.path().join("check.json").is_file())
		.map(|e| e.file_name().to_string_lossy().into_owned())
		.collect();
	names.sort();
	if names.is_empty() {
		return Err(format!("{}: no route set folder with a check.json", cand.display()));
	}
	let mut sets = Vec::new();
	let (mut all_b, mut all_c) = (Vec::new(), Vec::new());
	for n in names {
		let (b, c) = (gate::read_set(&base.join(&n), &n)?, gate::read_set(&cand.join(&n), &n)?);
		all_b.extend(b.items.iter().cloned());
		all_c.extend(c.items.iter().cloned());
		sets.push((n, b, c));
	}
	let o = gate::compare(&all_b, &all_c);
	let md = gate::markdown(&sets, &o, (lb, lc));
	let out = opt.get("--out").map_or_else(|| cand.join("gate.md"), PathBuf::from);
	std::fs::write(&out, &md).map_err(|e| format!("{}: {e}", out.display()))?;
	let js = out.with_extension("json");
	std::fs::write(&js, serde_json::to_string_pretty(&o).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", js.display()))?;
	let count = |r: &gate::SetRun| r.items.len();
	println!(
		"writer gate: {} ({} new, {} met by more classes, {} gone; {}) -> {}",
		if o.passes() { "PASS" } else { "FAIL" },
		o.new.len(),
		o.spread.len(),
		o.gone.len(),
		sets.iter().map(|(n, b, c)| format!("{n} {}->{}", count(b), count(c))).collect::<Vec<_>>().join(", "),
		out.display()
	);
	Ok(Ok(o.passes()))
}

/// Ok(Err(message)): a usage error; Err: a failure.
fn run(args: &[String]) -> Result<Result<(), String>, String> {
	let mut positional = Vec::new();
	let mut opt: BTreeMap<&str, String> = BTreeMap::new();
	let mut i = 0;
	while i < args.len() {
		let a = args[i].as_str();
		match a {
			"--world" | "--out" | "--guides" | "--route" | "--root" | "--checkout" | "--data" | "--walks" => {
				let Some(v) = args.get(i + 1) else {
					return Ok(Err(format!("{a} needs a value")));
				};
				opt.insert(a, v.clone());
				i += 2;
			}
			"--no-engine" | "--format-0-3" | "--no-along" | "--no-use" | "--no-when" | "--no-level" | "--no-tips" | "--no-warnings" | "--no-groups" | "--no-route-legs" | "--no-repair" => {
				opt.insert(a, String::new());
				i += 1;
			}
			_ if a.starts_with("--") => {
				return Ok(Err(format!("unknown option {a}")));
			}
			_ => {
				positional.push(a.to_string());
				i += 1;
			}
		}
	}
	if let Some(r) = opt.remove("--route") {
		positional.push(r);
	}
	let (Some(world_f), Some(out)) = (opt.get("--world"), opt.get("--out")) else {
		return Ok(Err("--world <file> and --out <dir> are required".into()));
	};
	if positional.len() != 1 {
		return Ok(Err(format!("one route file is needed, got {}", positional.len())));
	}
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	let abs = |p: &str| -> PathBuf { cwd.join(p) };
	let root: PathBuf = match opt.get("--root") {
		Some(r) => abs(r),
		None => cwd.ancestors().find(|d| d.join("data/forever").is_dir()).ok_or("no data/forever above the working directory (give --root)")?.to_path_buf(),
	};
	let guides_dir = opt.get("--guides").map_or_else(|| root.join("guides"), |g| abs(g));
	let out = abs(out);
	let data_dir = opt.get("--data").map_or_else(|| root.join("data/forever"), |d| abs(d));

	let pin = forge_writer::native::PathInputs {
		route: abs(&positional[0]),
		world: abs(world_f),
		walks: opt.get("--walks").map(|w| abs(w)),
		guides: guides_dir,
		root,
		data_dir: Some(data_dir),
		out: out.clone(),
		checkout: opt.get("--checkout").map(|c| abs(c)),
	};
	let engine = !opt.contains_key("--no-engine");
	let ropts = forge_writer::RunOpts {
		engine,
		level: !opt.contains_key("--no-level"),
		route_legs: !opt.contains_key("--no-route-legs"),
		repair: !opt.contains_key("--no-repair"),
		rules: forge_writer::engine::Opts {
			format_0_3: opt.contains_key("--format-0-3"),
			along: !opt.contains_key("--no-along"),
			use_items: !opt.contains_key("--no-use"),
			when: !opt.contains_key("--no-when"),
			tips: !opt.contains_key("--no-tips"),
			warnings: !opt.contains_key("--no-warnings"),
			groups: !opt.contains_key("--no-groups"),
		},
	};
	let ro = forge_writer::native::run_paths(&pin, &ropts, &forge_writer::native::SharedCache::default())?;
	for m in &ro.log {
		eprintln!("{m}");
	}
	println!("apply-route: {}", ro.summary.replacen("rewritten;", &format!("rewritten in {};", out.display()), 1));
	if !ro.fixes.is_empty() {
		let mut counts: std::collections::BTreeMap<&str, usize> = Default::default();
		for f in &ro.fixes {
			*counts.entry(f.state.as_str()).or_default() += 1;
		}
		println!("fixes: {}", counts.iter().map(|(k, v)| format!("{v} {k}")).collect::<Vec<_>>().join(", "));
		for f in ro.fixes.iter().filter(|f| f.state == "applied") {
			println!("  {} {}: applied at {}", f.file, f.id, f.lines.join(", "));
		}
	}
	Ok(Ok(()))
}
