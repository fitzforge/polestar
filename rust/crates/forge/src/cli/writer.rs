//! forge writer apply-route: a route written into the guides (the output tree and summary line
//! of `polestar apply-route`).

use std::collections::BTreeMap;
use std::path::PathBuf;
use std::process::ExitCode;

pub(super) const USAGE: &str = "usage: forge writer apply-route <route.json> --world <world-faction.json> --out <dir>
                           [--guides <dir>] [--data <dir>] [--root <checkout>] [--checkout <dir>] [--walks <file>]
                           [--format-0-3] [--no-engine] [--no-along] [--no-use] [--no-when] [--no-level]
                           [--no-tips] [--no-warnings]
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
  --format-0-3     also `when group`, `task`/`cast`, `abandon`, `skipto` (guide pack format 5, Polestar 0.3.0)";

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	let usage = |m: &str| {
		eprintln!("forge writer: {m}\n(forge writer --help for the options)");
		ExitCode::from(2)
	};
	match args.first().map(String::as_str) {
		Some("apply-route") => {}
		Some(x) => return usage(&format!("unknown command {x}")),
		None => return usage("a command is needed"),
	}
	match run(&args[1..]) {
		Ok(Ok(())) => ExitCode::SUCCESS,
		Ok(Err(m)) => usage(&m),
		Err(e) => {
			eprintln!("forge writer: {e}");
			ExitCode::from(1)
		}
	}
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
			"--no-engine" | "--format-0-3" | "--no-along" | "--no-use" | "--no-when" | "--no-level" | "--no-tips" | "--no-warnings" | "--no-route-legs" | "--no-repair" => {
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
		},
	};
	let ro = forge_writer::native::run_paths(&pin, &ropts)?;
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
