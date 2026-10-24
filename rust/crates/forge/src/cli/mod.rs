//! The pipeline's other commands, as subcommands of `forge` (`forge data build ...`,
//! `forge sim route ...`): each module reads its arguments through [`args`]
//! (`["forge <subcommand>", rest...]`).

use std::sync::OnceLock;

pub mod data;
pub mod doctor;
pub mod gamedata;
pub mod guide;
pub mod i18n;
pub mod judge;
pub mod nav;
pub mod navprep;
pub mod sim;
pub mod walks;
pub mod writer;
// The addon's release: forge release pack|version|notes|credits and forge changelog.
pub mod changelog;
pub mod pack;
pub mod release;
pub mod version;

static ARGS: OnceLock<Vec<String>> = OnceLock::new();

/// The subcommand's arguments, the first being `forge <subcommand>`.
pub fn args() -> std::vec::IntoIter<String> {
	ARGS.get().cloned().unwrap_or_default().into_iter()
}

/// A command's error: a usage error (exit 2) or a failure while running (exit 1). `?` on a
/// `Result<_, String>` makes a failure.
#[derive(Debug)]
pub enum Fail {
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

/// A usage error.
pub fn usage(m: impl Into<String>) -> Fail {
	Fail::Usage(m.into())
}

/// Prints `forge <cmd>: <error>` and exits: 2 for a usage error (with a pointer to the help), 1 for
/// a failure.
pub fn exit(cmd: &str, r: Result<(), Fail>) {
	match r {
		Ok(()) => {}
		Err(Fail::Usage(m)) => {
			eprintln!("forge {cmd}: {m}\n(forge {cmd} --help for the options)");
			std::process::exit(2)
		}
		Err(Fail::Run(m)) => {
			eprintln!("forge {cmd}: {m}");
			std::process::exit(1)
		}
	}
}

/// Checks a command's arguments: each `--option` one of `values` (followed by its value, or as
/// `--option=value`) or of `flags`, and at most `bare` other arguments. Err: what is wrong.
pub fn check_args(args: &[String], values: &[&str], flags: &[&str], bare: usize) -> Result<(), String> {
	let mut it = args.iter();
	let mut n = 0;
	while let Some(a) = it.next() {
		if a.starts_with("--") && a.len() > 2 {
			let (k, inline) = a.split_once('=').map_or((a.as_str(), false), |(k, _)| (k, true));
			if values.contains(&k) {
				if !inline && it.next().is_none() {
					return Err(format!("{k} needs a value"));
				}
			} else if !(flags.contains(&k) && !inline) {
				return Err(format!("unknown option {a}"));
			}
		} else {
			n += 1;
			if n > bare {
				return Err(format!("unexpected argument {a}"));
			}
		}
	}
	Ok(())
}

const DATA_HELP: &str = "usage: forge data <command> [options]

The data builders, one at a time (forge build's data stage runs the ones it needs):
  build         data/forever/*.json from the game's data and the quest data, behind the statistics gate
                (options below)
  sources       fill data/sources: client tables, pfQuest, EG Link, forever-vo, CMaNGOS, web XP, WoWDBDefs
                [--only LIST --root --sources --build --forever-build --forever-tables --wow --defs --data]
  check         data/forever's statistics against its last good ones  [--root --data --sources --accept --all]
  itemdb        addon/Polestar_ItemDB (Items.lua + TOC)  [--root --sources --build --out --offline]
  questdb       addon/Polestar_QuestDB from data/forever  [--root --data --out --radius --droppers --json]
  names         Names.lua in addon/Polestar_<locale>, the data's names per language  [<locale>... --offline --no-questie
                --no-tables --build --sources --ding --pfquest --guides --questdb --codex --travel
                --chokepoints --out --root --json]
  talents       build|check addon/Polestar/Talents/Builds.lua  [--root --plans --out --sources --build --offline]
  maps          build: Maps/ZoneLevels.lua [--data --lua]; overlays: UI/ZoneArtOverlays.lua
                [--build --sources --offline --lua]
  check-corrections  check an edit of forever-db/corrections, mechanics-public.json or route-fixes.json
                [--root --data --corrections --mechanics --route-fixes --json]
  trainers      trainers.json and Core/ClassTrainers.lua  [--data --guides --recordings --out --lua]
  dungeons      dungeons.json from the installed dungeon journal addon  [--source --data --out]
  travel        travel.json, TravelData.lua, FlightPaths.lua  [--root --data --recordings --sources --grid <dir>|none
                --crossings --build --forever-build --json --lua --flight-lua --travel-addon]
  codex         data/forever/codex and the Polestar_Codex pack  [--root --data --sources --addons --build --out --pack
                --local-extras]
  gear          Forever.lua, SpecData.lua and gear/report.json  [--root --addons --wowsims --built-at]
  professions   professions.json  [--root --data --sources --build --out]
  sim-inputs    the sources the simulator's world reads (Map, AreaTable, QuestXP, object facts...)  --out <dir>
                [--root --sources --forever-tables client|wago --wow --product --defs]
  pack, fetch   the data pack (forge --help)
";

const GUIDE_HELP: &str = "usage: forge guide compile [<dir>] [options]
       forge guide lint [<dir>] [options]
       forge guide check <dir> [--json] [--fix] [--data <dir>] [--root <checkout>]
       forge guide bake --guides <dir>[,<dir>...] [--grid <dir>] [--leffe <dir>] [--root <checkout>] [--data <dir>]
                        [--threads N]
       forge guide seed [--checkout <dir>] [--force]
       forge guide publish --from <written guides> [--checkout <dir>]
       forge guide check-generated [--checkout <dir>]

compile: a pack's .guide files (docs/GUIDE_FORMAT.md) into its community addon folder, as its pack.json
describes it (TOC, Pack.lua, MapFrames.lua, Guides.lua, LICENSE-DATA.txt, and LICENSE as LICENSE.txt).
lint: every compile check without writing anything; with a cached simulator world also the solo policy.
The pack is the one in <dir> (or --pack), else the nearest folder holding a pack.json (this one or a
parent), else our guides/. Another pack is checked with our guides as context and written to
<pack>/dist/<folder>/; ours to <checkout>/addon/<folder>/. Nothing is written when there are errors (unless
--force), nor without reference data: the command then stops with one error, unless --no-data.

options (compile and lint):
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --root <dir>          the Polestar checkout (default: the one above here, else above the forge binary)
  --guides <dir>        our pack's guide sources in another folder (default guides/)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, read as context for another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)
  --no-data             without reference data: every quest title, NPC name and place must be in the guide
  --include-drafts      also the pack's drafts/**
  --format <f>          text (default), json (one document on stdout, no summary) or github (annotations)
  --quiet               print errors only
  --time                phase timings on stderr
compile only:
  --out <dir>           the addon folder (default as above)
  --force               write the files even with errors
lint only:
  --sim <dir>           simulator cache with world-<faction>.json (default data/sim/, used only with the
                        default --data); a world built from other data is skipped

check: read every chain of written guides under <dir> (a folder is one chain, in file-name order;
catch-up guides left out) line by line as a player would, against the reference data, and report each
line that lacks what it needs with the cheapest repair; --fix writes the repairs (travel steps are the
writer's travel pass in forge build). Exit 1 when a failure is left.

bake: the walk into every step of the leveling guides of written guide trees (--guides, comma-separated),
routed on Leffe's maps (--leffe, default the data pack's) where his way costs at most 1.2x the walking
grid's (--grid), else on the grid, written as legs.json and legs-qa.txt beside each tree's guides (forge
build's legs stage does the same); compile writes them into the race parts' Legs.lua. --threads: default 4.

seed: cut forge/seed/guides from the checkout's leveling guides (guides/forever/horde, .../alliance),
once, when Forge takes them over (--force cuts it again: every route's baseline changes).
publish: copy the seed's guides as a build wrote them (--from, e.g. <out>/guides/<start>) into the
checkout's guides/ with the generated header, and list them in guides/GENERATED.json; the tree's legs.json
with them (or none when the tree has none).
check-generated: fail (exit 1) when a generated guide or a seed file was edited by hand, and say
where the fix goes instead.
";

const SIM_HELP: &str = "usage: forge sim <command> [options]

  route   one start's route, cut from the current guides' order and improved:
          --faction F --start <race> --out <file.json> [--root <checkout>] [--world-dir <dir>]
          [--seed guides|<file>] [--guides <dir>] [--edits N] [--budget K] [--guard seed|current|off]
          [--profile avg|slow|fast|gate] [--walks on|off] [--param name=value ...] [--tries N] [--members N]
          [--rng S] [--share-every N] [--search-draws K] [--holdout N] [--threads N]
  widen   the shared 12-60 route of a faction: --faction F --starts A,B,... --out <file.json>
          [--join-after <guide>] [--diagnose] [--edits N] [--budget K] [--members N] [--threads N]
  shared  the shared route by the free search: --faction F --out <file.json> [--own-tries N] [--tries N]
          [--guard on|off] [--walks on|off] [--threads N]
  guards  the judge's guards on orders: --faction F --race R <chain.json>... [--export <dir>]
  why     <quest> --start S (--dir <routes dir> | --out <forge build output>): where the quest is in S's
          route, or why it is not
  skips   [--reason R] (--dir <routes dir> | --out <forge build output>): every start's skip ledger, one
          row per quest
  calibrate [--root <checkout>] [--world-dir <dir>] [--fdj <dir>] [--recordings <dir>] [--out <file.json>]
          [--at ISO]: params.json (fitted quest-reward scales and kill times) from the worlds, the
          dungeon journal and recordings

--seed guides (default): the order of the guides in --guides (default <root>/guides), as forge build
makes it; --seed <file>: a chain document. --guard: a kept change may not raise the seed's guard counts
(seed), the current order's (current), or is unguarded (off). The route fixes are <root>/data/route-fixes.json
($POLESTAR_ROUTE_FIXES names another file); $POLESTAR_ROUTES the routes dir for why and skips.
";

const WALKS_HELP: &str = "usage: forge walks <command> ...

  world <root> <grid> <simDir> <faction>                         world-<faction>.json from root's data
  walks <root> <grid> <simDir> <faction> <store> <navFp> [bands] the walks (default: the hybrid when
                                                                  POLESTAR_LEFFE_NAV=<Leffe's Nav folder>,
                                                                  else our grid; POLESTAR_NAV=grid|leffe|hybrid)
  hybrid <grid walks.bin> <Leffe walks.bin> <out.bin> [slack]    the hybrid of two walks files
";

/// The help text of subcommand `name`.
fn help(name: &str) -> Option<String> {
	Some(match name {
		"data" => format!(
			"{DATA_HELP}
{}",
			data::USAGE
		),
		"doctor" => doctor::USAGE.to_string(),
		"gamedata" => gamedata::USAGE.to_string(),
		"guide" => GUIDE_HELP.to_string(),
		"nav" => format!("{}\n\n{}", nav::USAGE, navprep::USAGE),
		"judge" => format!(
			"{}
       {}
       {}
       {}
       {}",
			judge::USAGE,
			judge::REPORT_USAGE.lines().next().unwrap_or("").trim_start_matches("usage: "),
			judge::SEED_USAGE.lines().next().unwrap_or("").trim_start_matches("usage: "),
			judge::STATUS_USAGE.lines().next().unwrap_or("").trim_start_matches("usage: "),
			judge::FEEDBACK_USAGE.lines().next().unwrap_or("").trim_start_matches("usage: ")
		),
		"sim" => SIM_HELP.to_string(),
		"walks" => WALKS_HELP.to_string(),
		"writer" => writer::USAGE.to_string(),
		"release" => release::USAGE.to_string(),
		"changelog" => changelog::USAGE.to_string(),
		"i18n" => i18n::usage_text(),
		_ => return None,
	})
}

/// Runs subcommand `name` with `rest` (the arguments after it); None when there is none by that name.
pub fn run(name: &str, rest: &[String]) -> Option<std::process::ExitCode> {
	use std::process::{ExitCode, Termination};
	// The former binaries' mains return () (exiting the process themselves on failure) or an ExitCode.
	let done = |f: fn()| {
		f();
		ExitCode::SUCCESS
	};
	if matches!(rest.first().map(String::as_str), Some("help")) || rest.iter().any(|a| a == "-h" || a == "--help") || (rest.is_empty() && name != "doctor") {
		let sub = match name {
			"data" => rest.first().and_then(|s| data::sub_usage(s)),
			"release" => rest.first().map(|s| release::help(Some(s))),
			_ => None,
		};
		let text = match sub {
			Some(u) => u.to_string(),
			None => help(name)?,
		};
		if rest.is_empty() {
			eprintln!("{}", text.trim_end());
			return Some(ExitCode::from(2));
		}
		println!("{}", text.trim_end());
		return Some(ExitCode::SUCCESS);
	}
	let mut argv = vec![format!("forge {name}")];
	argv.extend_from_slice(rest);
	let _ = ARGS.set(argv);
	Some(match name {
		"data" => done(data::main),
		"doctor" => doctor::main(),
		"gamedata" => done(gamedata::main),
		"guide" => done(guide::main),
		"judge" => done(judge::main),
		"nav" => done(nav::main),
		"sim" => done(sim::main),
		"walks" => done(walks::main),
		"writer" => writer::main().report(),
		"release" => release::main(),
		"changelog" => changelog::main(),
		"i18n" => i18n::main(),
		_ => return None,
	})
}
