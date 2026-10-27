//! The `forge` command: `forge build` (the whole pipeline), `forge data pack|fetch`, `forge version`,
//! and the other commands in [`cli`].

mod cli;

use forge::{build, parse_starts, BuildOpts, Nav};
use std::path::{Path, PathBuf};
use std::process::ExitCode;

/// `forge 0.1.0 (<commit>)`.
fn version() -> String {
	let hash = env!("FORGE_GIT_HASH");
	if hash.is_empty() {
		format!("forge {}", env!("CARGO_PKG_VERSION"))
	} else {
		format!("forge {} ({hash})", env!("CARGO_PKG_VERSION"))
	}
}

const USAGE: &str = "Forge builds Polestar's leveling guides from your own game client: it plans each start's route
through the quests, writes the route into the guides and judges the result.

usage: forge <command> [options]

Commands:
  build      the whole pipeline: the game client and the guides to judged guides for every start
  doctor     what Forge finds: the game, its builds, the quest data, the data, Leffe's maps, the grid
  data       the data builders one at a time (build, trainers, travel, ..., pack, fetch)
  gamedata   the game's tables (list, export, check) and the client's caches (cache, hotfix)
  guide      compile or lint guides
  judge      judge a guide pack; the route report; the player-report tests
  nav        the walking grid from the installed client (grid, prepare)
  record     the Recorder's chunks into data/recordings: from this PC's game (import) or the server (pull)
  sim        route cuts, the shared route, why a quest is in or out (why, skips), calibration (calibrate)
  walks      the world and walks stages on their own
  writer     write a route into the guides (apply-route)
  release    release the addon: the version, the release zips, the release notes, the credits
  changelog  the changelog fragments in changes/: add, check, show, build
  i18n       the translations: interface strings (status, check, sync, keys, import), guide texts, leaks
  version    print Forge's version

forge <command> --help shows a command's options; forge build --help the build's.";

const BUILD_HELP: &str = "usage: forge build --out <dir> [--guides <dir>] [--wow <dir>] [--starts all|Orc,Human,...] [--threads N]
                   [--nav grid|leffe|hybrid] [--leffe <dir>] [--checkout <dir>] [--root <checkout>] [--data <dir>]
                   [--data-root <checkout>] [--walks-from <dir>] [--grid <dir>] [--pack <dir>] [--allow-incomplete]
                   [--strict] [--until walks]

Runs the stages grid, data, prepare, world, walks, routes, guides and report into --out. A stage whose
inputs did not change since the last run (a BLAKE3 key in <out>/.forge/<stage>.key) is skipped.

  --guides       the guides to start from (default: the checkout's guides/; with a seed in the checkout,
                 forge/seed/guides, its generated guides are read from the seed)
  --out          the output folder: routes/, guides/<start>/, report.md, report.json
  --wow          the game folder (remembered in Forge's config file for later runs; forge doctor --forget)
  --starts       the starts to build (default: every start)
  --threads      worker threads (default 8)
  --nav          the walks backend (default: hybrid when Leffe's navigation maps or the data pack's
                 saved walks on them are found, else grid)
  --leffe        Leffe's navigation maps, private (default $POLESTAR_LEFFE_NAV); without them the hybrid
                 uses the data pack's saved walks on his maps and our grid for the rest
  --checkout     the Polestar checkout whose fixes the build applies: forever-db/corrections
                 and data/route-fixes.json (default: the nearest checkout above --guides, else above here)
  --root         the checkout whose data/sources, data/local, tools and addon are read (default: the
                 nearest folder above here with data/sources; without one, the data pack)
  --data         a built data/forever to use instead of the data stage
  --data-root    the checkout the data stage reads its sources from
  --walks-from   a forge output folder whose walk store to start from
  --grid         a built walking grid (default: built from the client, or $POLESTAR_GRID)
  --pack         the data pack folder (default $POLESTAR_DATA_PACK, else the user's data folder)
  --allow-incomplete   build the grid from an install with missing files (the grid is wrong there)
  --strict       fail when a fix no longer applies (fixes.md lists them): for release builds
  --until walks  stop after the walks stage (the walk stores for a data pack: rust/scripts/data-pack.sh)

With more than one start of a faction, its routes are one shared route from the join (the Horde after
horde/02-the-barrens, the Alliance after alliance/02-westfall); each start's own cut is kept in
routes/own/, and routes/starts.json lists every start's hours.

Every build writes fixes.md and fixes.json (and a Fixes section in report.md): the commit of each
input, and what became of every fix record in the checkout: corrections, mechanics, route fixes and
the player-report checks.";

const PACK_HELP: &str = "usage: forge data pack --out <dir> [--root <checkout>] [--walks-from <forge output>]
                       [--grid <the grid the walk stores were built on>]

Writes the data pack (sources, licences and credits in its manifest.json) as
<out>/polestar-data-pack.tar.gz and the index <out>/polestar-data-pack.json. The walk stores
include the walks answered on Leffe's navigation maps; his maps themselves are private and never
packed.";

const FETCH_HELP: &str = "usage: forge data fetch [--url <pack index URL or path>] [--dest <dir>]

Downloads the data pack (default: the `data-pack` release, or $POLESTAR_DATA_PACK_URL), checks its
BLAKE3 and unpacks it into --dest (default: $POLESTAR_DATA_PACK, else the user's data folder,
polestar/data-pack). No public data pack has been published yet: until one is, build from your own
game client (forge build --wow <dir>).";

/// The options each of build, pack and fetch takes: (with a value, flags).
fn options(cmd: &str) -> (&'static [&'static str], &'static [&'static str]) {
	match cmd {
		"build" => (
			&["--guides", "--out", "--checkout", "--wow", "--data", "--data-root", "--starts", "--nav", "--leffe", "--root", "--walks-from", "--grid", "--pack", "--threads", "--until"],
			&["--allow-incomplete", "--strict"],
		),
		"pack" => (&["--out", "--root", "--walks-from", "--grid"], &[]),
		_ => (&["--url", "--dest"], &[]),
	}
}

/// A usage error (exit 2) or a failure (exit 1).
enum Fail {
	Usage(String),
	Run(String),
}

impl From<String> for Fail {
	fn from(e: String) -> Self {
		Fail::Run(e)
	}
}

impl From<&str> for Fail {
	fn from(e: &str) -> Self {
		Fail::Run(e.to_string())
	}
}

fn main() -> ExitCode {
	let args: Vec<String> = std::env::args().skip(1).collect();
	let is_help = |a: &String| matches!(a.as_str(), "-h" | "--help" | "help");
	let (cmd, help) = match (args.first().map(String::as_str), args.get(1).map(String::as_str)) {
		(None, _) => {
			eprintln!("{USAGE}");
			return ExitCode::from(2);
		}
		(Some("-h" | "--help" | "help"), _) => {
			println!("{USAGE}");
			return ExitCode::SUCCESS;
		}
		(Some("-V" | "--version" | "version"), _) => {
			println!("{}", version());
			return ExitCode::SUCCESS;
		}
		(Some("build"), _) => ("build", BUILD_HELP),
		(Some("data"), Some("pack")) => ("pack", PACK_HELP),
		(Some("data"), Some("fetch")) => ("fetch", FETCH_HELP),
		(Some(a), _) => {
			return match cli::run(a, &args[1..]) {
				Some(code) => code,
				None => {
					eprintln!("forge: unknown command {a} (forge --help lists the commands)");
					ExitCode::from(2)
				}
			}
		}
	};
	let rest = &args[if cmd == "build" { 1 } else { 2 }..];
	if rest.iter().any(is_help) {
		println!("{help}");
		return ExitCode::SUCCESS;
	}
	let name = if cmd == "build" { "build".to_string() } else { format!("data {cmd}") };
	match run(cmd, rest) {
		Ok(()) => ExitCode::SUCCESS,
		Err(Fail::Usage(e)) => {
			eprintln!("forge {name}: {e}\n(forge {name} --help for the options)");
			ExitCode::from(2)
		}
		Err(Fail::Run(e)) => {
			eprintln!("forge: {e}");
			ExitCode::from(1)
		}
	}
}

fn run(cmd: &str, args: &[String]) -> Result<(), Fail> {
	let (values, flags) = options(cmd);
	cli::check_args(args, values, flags, 0).map_err(Fail::Usage)?;
	let val = |k: &str| -> Option<String> {
		args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k).and_then(|r| r.strip_prefix('=')).map(String::from)))
	};
	let need = |k: &str| -> Result<String, Fail> { val(k).ok_or_else(|| Fail::Usage(format!("{k} <dir> is required"))) };
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	let abs = |p: String| -> PathBuf {
		let p = PathBuf::from(p);
		if p.is_absolute() {
			p
		} else {
			cwd.join(p)
		}
	};
	let mut log = |m: &str| eprintln!("forge: {m}");
	let found_root = || cwd.ancestors().find(|d| d.join("data/sources").is_dir()).map(Path::to_path_buf);
	if cmd == "pack" {
		let out = abs(need("--out")?);
		let root = val("--root").map(abs).or_else(found_root).ok_or_else(|| Fail::Usage("no data/sources above here: pass --root <checkout>".into()))?;
		let o = forge::pack::PackOpts { root, walks_from: val("--walks-from").map(abs).map(|d| d.join("walks")), grid: val("--grid").map(abs), nav_fp: std::env::var("POLESTAR_NAV_FP").ok(), out };
		let t = std::time::Instant::now();
		let p = forge::pack::pack(&o, &mut log)?;
		eprintln!(
			"forge: data pack: {} files, {:.1} MB unpacked, archive {:.1} MB ({}), index {}, {:.1} s; private-data scan clean",
			p.files,
			p.bytes as f64 / 1e6,
			p.archive_bytes as f64 / 1e6,
			p.archive.display(),
			p.index.display(),
			t.elapsed().as_secs_f64()
		);
		for (name, path, bytes) in &p.assets {
			eprintln!("forge: asset {name}: {:.1} MB ({})", *bytes as f64 / 1e6, path.display());
		}
		return Ok(());
	}
	if cmd == "fetch" {
		let url = val("--url").unwrap_or_else(forge::fetch::default_url);
		let dest = val("--dest").map(abs).or_else(forge::fetch::default_pack_dir).ok_or_else(|| Fail::Usage("no user data folder: pass --dest <dir>".into()))?;
		let f = forge::fetch::fetch(&url, &dest, &mut log)?;
		eprintln!("forge: data pack in {}: {} files, {:.1} MB (archive {:.1} MB), every file verified", f.dir.display(), f.files, f.bytes as f64 / 1e6, f.archive_bytes as f64 / 1e6);
		return Ok(());
	}
	let root = val("--root").map(PathBuf::from).or_else(found_root).unwrap_or_else(|| cwd.clone());
	let given = val("--guides").map(abs);
	let checkout = match val("--checkout").map(abs) {
		Some(c) if c.join(forge::CHECKOUT_MARK).is_file() => c,
		Some(c) => return Err(Fail::Usage(format!("--checkout {}: not a Polestar checkout (no {})", c.display(), forge::CHECKOUT_MARK))),
		None => given
			.as_deref()
			.and_then(forge::find_checkout)
			.or_else(|| forge::find_checkout(&cwd))
			.ok_or_else(|| Fail::Usage(format!("no Polestar checkout ({}) above --guides or here: pass --checkout <dir>", forge::CHECKOUT_MARK)))?,
	};
	let guides = given.unwrap_or_else(|| checkout.join("guides"));
	let o = BuildOpts {
		checkout,
		wow: val("--wow").map(abs),
		data: val("--data").map(abs),
		data_root: val("--data-root").map(abs),
		guides,
		out: abs(need("--out")?),
		starts: parse_starts(&val("--starts").unwrap_or_else(|| "all".into())).map_err(Fail::Usage)?,
		nav: match val("--nav").as_deref() {
			None => None,
			Some("grid") => Some(Nav::Grid),
			Some("leffe") => Some(Nav::Leffe),
			Some("hybrid") => Some(Nav::Hybrid),
			Some(x) => return Err(Fail::Usage(format!("--nav {x}: grid, leffe or hybrid"))),
		},
		leffe: val("--leffe").map(abs),
		root: if root.is_absolute() { root } else { cwd.join(root) },
		walks_from: val("--walks-from").map(abs),
		grid: val("--grid").map(abs),
		pack: val("--pack").map(abs),
		allow_incomplete: args.iter().any(|a| a == "--allow-incomplete"),
		strict: args.iter().any(|a| a == "--strict"),
		threads: match val("--threads") {
			None => 8,
			Some(v) => v.parse().ok().filter(|&n: &usize| n > 0).ok_or_else(|| Fail::Usage(format!("--threads {v}: a positive number")))?,
		},
		until: match val("--until").as_deref() {
			None => None,
			Some("walks") => Some("walks".into()),
			Some(x) => return Err(Fail::Usage(format!("--until {x}: only walks"))),
		},
	};
	if let Some(w) = &o.wow {
		match forge_gamedata::remember_wow(w) {
			Ok(Some(f)) => log(&format!("remembered the game folder {} in {}", w.display(), f.display())),
			Ok(None) => {}
			Err(e) => return Err(format!("--wow: {e}").into()),
		}
	}
	rayon_threads(o.threads);
	let runs = build(&o, &mut log)?;
	let built: Vec<&str> = runs.iter().filter(|r| !r.skipped).map(|r| r.stage).collect();
	eprintln!("forge: {} stage(s) built ({}), {} unchanged; outputs in {}", built.len(), built.join(", "), runs.len() - built.len(), o.out.display());
	Ok(())
}

/// The routes stage uses rayon's global pool.
fn rayon_threads(n: usize) {
	std::env::set_var("RAYON_NUM_THREADS", n.to_string());
}
