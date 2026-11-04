//! `forge data build`: data/forever/*.json from the source cache (filled first unless --offline)
//! behind the statistics gate, and the other data builders one at a time.

use super::{usage, Fail};
use std::path::{Path, PathBuf};
use std::time::Instant;

use forge_data::tables::Source;
use forge_data::{build, Options};

pub(super) const USAGE: &str = "usage: forge data build [--out <dir>] [options]

Builds data/forever/*.json from pfQuest, QuestieDB's Forever store, the Forever and Classic Era
client tables, data/recordings and the web and CMaNGOS facts. The sources are fetched into
data/sources first (forge data sources; a cached file is never fetched again) unless --offline.

Validation (docs/ARCHITECTURE.md, Reference data, Validation): the build is made in <out>.staging/
first and its field statistics (forge data check) are compared with the last good build's
(<out>/stats-good.json). A shift past a field's limit stops the build: <out> is left as it was, the
report names the fields, and the new build stays in <out>.staging/; rerun with --accept when the
change is intended. The first build with no last good one is taken.

options:
  --offline              read the source cache only (fetch nothing)
  --accept               take the build even when its statistics shifted
  --root DIR             the Polestar checkout (default: the one above the current folder)
  --out DIR              output folder (default: <root>/data/forever)
  --sources DIR          source cache folder (default: <root>/data/sources)
  --recordings DIR       recordings folder (default: <root>/data/recordings)
  --pfquest DIR          pfQuest checkout (default: <sources>/pfQuest)
  --questie DIR          QuestieDB folder or the AddOns folder holding it (default: detected)
  --no-questie           build without QuestieDB
  --build V              wago.tools Classic Era build (default: newest cached)
  --forever-build V      Forever build (wago, saved: a cached one; client: must be the installed one)
  --forever-tables S     client (default when a client is found: the installed client via
                         forge-gamedata), wago (the cached wago.tools CSVs) or saved (the client
                         tables forge build saved under <sources>/client-tables)
  --wow DIR              World of Warcraft folder (default: $POLESTAR_WOW_DIR or detected)
  --product P            client product (default wow_classic_beta)
  --defs DIR             WoWDBDefs checkout (default: <sources>/wowdbdefs)
  --no-forever           skip the Forever client tables
  --no-web-xp            skip the web quest XP (looked up for the quests still without XP)
  --no-web-zones         skip the web zone quest lists
  --cap N                max spawn points per entity per map (default 24)
  --built-at ISO         meta.json timestamp (default: now, or SOURCE_DATE_EPOCH)
  --corrections PATH     the corrections: a folder of section files (default
                         <root>/forever-db/corrections) or one file in the old single-file form
  --corrections-private FILE
                         the private overlay merged over them (default with the local sources:
                         <root>/data/local/corrections-private.json, when present)
  --kb                   also the merge rules, training.json and the knowledge base (mechanics.json,
                         trainers.json, <local>/kb/forever-kb.sqlite and verify-in-game.json);
                         facts.sqlite only with the local-sources feature
  --local DIR            data/local for --kb (default: <root>/data/local)
  --mechanics FILE       the public mechanics layer for --kb (default: <root>/data/mechanics-public.json)
  --kb-file FILE         the KB's sqlite (default: <local>/kb/forever-kb.sqlite)
  --verify-file FILE     verify-in-game.json (default: <local>/kb/verify-in-game.json)
  --no-client            --kb without the installed client (by default its caches are the
                         client.cache source and its tables with their hotfixes the client source)
  --client-cache DIR     the client caches for --kb: a Cache folder (WDB/enUS, ADB/enUS) or a folder
                         of the .wdb files and DBCache.bin (default: the --product's Cache folder)
  --client-tables DIR    the client tables for --kb as <Table>.csv files instead of the install's
POLESTAR_DATA_TIMES=1 prints each phase's elapsed time.";

pub fn main() {
	super::exit("data", run());
}

fn find_root(start: &Path) -> Option<PathBuf> {
	start.ancestors().find(|d| d.join(forge::CHECKOUT_MARK).is_file()).map(Path::to_path_buf)
}

fn abs(p: String) -> PathBuf {
	std::path::absolute(&p).unwrap_or_else(|_| PathBuf::from(p))
}

/// `key value` pairs of a subcommand's options (all take a value).
fn pairs(args: Vec<String>, known: &[&str]) -> Result<Vec<(String, String)>, Fail> {
	let mut out = Vec::new();
	let mut it = args.into_iter();
	while let Some(a) = it.next() {
		if !known.contains(&a.as_str()) {
			return Err(usage(format!("unknown option {a}")));
		}
		let v = it.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
		out.push((a, v));
	}
	Ok(out)
}

/// sim-inputs, professions and gear.
fn other(cmd: &str, args: Vec<String>) -> Result<(), Fail> {
	let root = find_root(&std::env::current_dir().map_err(|e| e.to_string())?);
	let t = Instant::now();
	match cmd {
		"sim-inputs" => {
			// The sources the sim world reads beside data/forever, under --out (data/sources layout).
			let kv = pairs(args, &["--root", "--sources", "--out", "--forever-tables", "--wow", "--product", "--defs"])?;
			let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
			let root = get("--root").map(abs).or(root).ok_or_else(|| usage("--root <dir> is required (no checkout above here)"))?;
			let sources = get("--sources").map(abs).unwrap_or_else(|| root.join("data/sources"));
			let out = get("--out").map(abs).ok_or_else(|| usage("--out <dir> is required"))?;
			let defs = get("--defs").map(abs).unwrap_or_else(|| sources.join("wowdbdefs"));
			let product = get("--product").unwrap_or_else(|| "wow_classic_beta".into());
			let wow = get("--wow").map(abs).or_else(forge_gamedata::find_install);
			let src = match get("--forever-tables").as_deref() {
				Some("wago") => Source::Wago,
				Some("client") | None => match wow {
					Some(w) if defs.join("definitions").is_dir() => Source::Client { wow: w, product, defs },
					_ if get("--forever-tables").is_none() => Source::Wago,
					_ => return Err("--forever-tables client: no World of Warcraft folder or WoWDBDefs found".into()),
				},
				Some(x) => return Err(usage(format!("--forever-tables {x}: client or wago"))),
			};
			let o = forge_data::sim_inputs::build(&sources, &src)?;
			let files = forge_data::sim_inputs::write(&out, &o)?;
			eprintln!("sim inputs: Forever build {}, {} files under {} ({:.2} s)", o.forever_build, files.len(), out.display(), t.elapsed().as_secs_f64());
		}
		"travel" => {
			// travel build: --data, --recordings, --sources, --grid DIR|none, --crossings, --json, --lua, --flight-lua, --travel-addon.
			let kv = pairs(args, &["--root", "--data", "--recordings", "--sources", "--grid", "--crossings", "--build", "--forever-build", "--json", "--lua", "--flight-lua", "--travel-addon"])?;
			let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
			let root = get("--root").map(abs).or(root).ok_or_else(|| usage("--root <dir> is required (no checkout above here)"))?;
			let mut o = forge_data::travel::Options::new(&root);
			if let Some(d) = get("--data") {
				o.data_dir = abs(d);
				o.crossings_file = o.data_dir.join("..").join("local").join("crossings.json");
			}
			if let Some(d) = get("--recordings") {
				o.recordings_dir = abs(d);
			}
			if let Some(d) = get("--sources") {
				o.sources_dir = abs(d);
			}
			match get("--grid").as_deref() {
				Some("none") => o.grid_dir = None,
				Some(g) => o.grid_dir = Some(abs(g.to_string())),
				None => {}
			}
			if let Some(c) = get("--crossings") {
				o.crossings_file = abs(c);
			}
			o.build = get("--build");
			o.forever_build = get("--forever-build");
			let out = forge_data::travel::build(&o)?;
			let mut to = forge_data::travel::Targets::new(&root, &o.data_dir);
			if let Some(f) = get("--json") {
				to.json = abs(f);
			}
			if let Some(f) = get("--lua") {
				to.lua = abs(f);
				if get("--flight-lua").is_none() {
					to.flight_lua = to.lua.with_file_name("FlightPaths.lua");
				}
			}
			if let Some(f) = get("--flight-lua") {
				to.flight_lua = abs(f);
			}
			if let Some(f) = get("--travel-addon") {
				to.travel_addon_dir = abs(f);
			}
			forge_data::travel::write(&out, &to)?;
			for w in &out.warnings {
				eprintln!("warning: {w}");
			}
			println!("{}", out.summary);
		}
		"codex" => {
			// codex build: --data, --sources, --addons, --build, --out (json), --pack; --local-extras also
			// merges the installed AtlasLoot, RareScanner and dungeons.json (this machine only).
			let local_extras = args.iter().any(|a| a == "--local-extras");
			let kv = pairs(args.into_iter().filter(|a| a != "--local-extras").collect(), &["--root", "--data", "--sources", "--addons", "--build", "--out", "--pack"])?;
			let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
			let root = get("--root").map(abs).or(root).ok_or_else(|| usage("--root <dir> is required (no checkout above here)"))?;
			let mut o = forge_data::codex::Options::new(&root);
			if let Some(d) = get("--data") {
				o.data_dir = abs(d);
			}
			if let Some(d) = get("--sources") {
				o.sources_dir = abs(d);
			}
			o.addons = get("--addons").map(abs);
			o.build = get("--build");
			o.local_extras = local_extras;
			let out = forge_data::codex::build_logged(&o, &|m| eprintln!("{m}"))?;
			// A --local-extras build never lands where `pack` and `install` look.
			let extras = root.join("data").join("local").join("codex-extras");
			let json_dir = get("--out").map(abs).unwrap_or_else(|| if local_extras { extras.clone() } else { o.data_dir.join("codex") });
			let pack_dir = get("--pack").map(abs).unwrap_or_else(|| if local_extras { extras.join("Polestar_Codex") } else { root.join("addon").join("Polestar_Codex") });
			forge_data::codex::write(&out, &json_dir, &pack_dir)?;
			for w in &out.warnings {
				eprintln!("warning: {w}");
			}
			for r in &out.report {
				println!("{r}");
			}
		}
		"professions" => {
			let kv = pairs(args, &["--root", "--data", "--sources", "--build", "--out"])?;
			let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
			let root = get("--root").map(abs).or(root).ok_or_else(|| usage("--root <dir> is required (no checkout above here)"))?;
			let mut o = forge_data::professions::Options::new(&root);
			if let Some(d) = get("--data") {
				o.data = abs(d);
			}
			if let Some(d) = get("--sources") {
				o.sources = abs(d);
			}
			o.build = get("--build");
			let out = forge_data::professions::build(&o)?;
			let dir = get("--out").map(abs);
			let file = match &dir {
				Some(f) => {
					std::fs::write(f, &out.files[0].1).map_err(|e| format!("{}: {e}", f.display()))?;
					f.clone()
				}
				None => {
					forge_data::professions::write(&o.data, &out)?;
					o.data.join(&out.files[0].0)
				}
			};
			for w in &out.warnings {
				eprintln!("warning: {w}");
			}
			println!("{}", out.summary(&file));
		}
		_ => {
			let kv = pairs(args, &["--root", "--addons", "--wowsims", "--built-at"])?;
			let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
			let root = get("--root").map(abs).or(root).ok_or_else(|| usage("--root <dir> is required (no checkout above here)"))?;
			let built_at = match get("--built-at") {
				Some(b) => build::parse_iso(&b)?,
				None => build::now_iso(),
			};
			let o = forge_data::gear::Options { root: root.clone(), addons: get("--addons").map(abs), wowsims_cache: get("--wowsims").map(abs), built_at };
			let out = forge_data::gear::build(&o)?;
			for (rel, text) in &out.files {
				let f = root.join(rel);
				std::fs::create_dir_all(f.parent().unwrap()).map_err(|e| e.to_string())?;
				std::fs::write(&f, text).map_err(|e| format!("{}: {e}", f.display()))?;
			}
			println!("{}", out.summary);
		}
	}
	if cmd != "sim-inputs" {
		eprintln!("{cmd}: {:.2} s", t.elapsed().as_secs_f64());
	}
	Ok(())
}

fn run() -> Result<(), Fail> {
	let mut args = super::args().skip(1);
	let cmd = args.next().unwrap_or_default();
	if cmd == "extracts" {
		// The CMaNGOS classic-db extracts rebuilt from the cached dump into --out (a developer check).
		let (mut sources, mut out, mut tdb) = (None, None, None);
		while let Some(a) = args.next() {
			match a.as_str() {
				"--tdb" => tdb = args.next().map(abs),
				"--sources" => sources = args.next().map(abs),
				"--out" => out = args.next().map(abs),
				_ => return Err(usage(format!("unknown option {a}"))),
			}
		}
		let root = find_root(&std::env::current_dir().map_err(|e| e.to_string())?);
		let sources = sources.or_else(|| root.map(|r| r.join("data/sources"))).ok_or_else(|| usage("--sources <dir> is required (no checkout above here)"))?;
		let out = out.ok_or_else(|| usage("--out <dir> is required"))?;
		std::fs::create_dir_all(&out).map_err(|e| e.to_string())?;
		if let Some(db) = tdb {
			let t = Instant::now();
			let x = forge_data::tdb::extract(&db)?;
			std::fs::write(out.join("forever-tdb-extract.json"), format!("{}\n", forge_guide::js::stringify(&x, None))).map_err(|e| e.to_string())?;
			eprintln!("forever-tdb extract: {:.2} s", t.elapsed().as_secs_f64());
			return Ok(());
		}
		return Ok(forge_data::cmangos::extract_all(&sources, &out)?);
	}
	if cmd == "sim-inputs" || cmd == "professions" || cmd == "gear" || cmd == "travel" || cmd == "codex" {
		return other(&cmd, args.collect());
	}
	if cmd == "dungeons" {
		// dungeons build: --source DIR (ForeverDungeonJournal; default: installed), --data DIR (input and output folder), --out FILE.
		let root = find_root(&std::env::current_dir().map_err(|e| e.to_string())?);
		let (mut source, mut data, mut out) = (None, None, None);
		while let Some(a) = args.next() {
			let v = args.next().map(abs);
			match a.as_str() {
				"--source" => source = v,
				"--data" => data = v,
				"--out" => out = v,
				_ => return Err(usage(format!("unknown option {a}"))),
			}
		}
		let data = data.or_else(|| root.as_ref().map(|r| r.join("data/forever"))).ok_or_else(|| usage("--data <dir> is required (no checkout above here)"))?;
		let t = Instant::now();
		let (text, n, rep) = forge_data::dungeons::run(source.as_deref(), &data)?;
		let out = out.unwrap_or_else(|| data.join("dungeons.json"));
		std::fs::write(&out, text).map_err(|e| e.to_string())?;
		let total: f64 = rep.coverage.values().sum();
		let cov: Vec<String> = rep.coverage.iter().map(|(k, v)| format!("{k} {v} ({}%)", forge_core::jsnum::js_round(v / total * 100.0))).collect();
		eprintln!("dungeons: {n} dungeons; quest positions {}", cov.join(", "));
		for (d, q, w) in &rep.unresolved {
			eprintln!("warning: {d}: quest {q} has no {w} position");
		}
		eprintln!("wrote {} in {:.2} s", out.display(), t.elapsed().as_secs_f64());
		return Ok(());
	}
	if cmd == "trainers" {
		// trainers build: --data DIR (data/forever, also the default output), --guides, --recordings, --out, --lua.
		let root = find_root(&std::env::current_dir().map_err(|e| e.to_string())?);
		let (mut data, mut guides, mut recs, mut out, mut lua) = (None, None, None, None, None);
		while let Some(a) = args.next() {
			let v = args.next().map(abs);
			match a.as_str() {
				"--data" => data = v,
				"--guides" => guides = v,
				"--recordings" => recs = v,
				"--out" => out = v,
				"--lua" => lua = v,
				_ => return Err(usage(format!("unknown option {a}"))),
			}
		}
		let data = data.or_else(|| root.as_ref().map(|r| r.join("data/forever"))).ok_or_else(|| usage("--data <dir> is required (no checkout above here)"))?;
		let guides = guides.or_else(|| root.as_ref().map(|r| r.join("guides")));
		let recs = recs.or_else(|| root.as_ref().map(|r| r.join("data/recordings"))).ok_or_else(|| usage("--recordings <dir> is required (no checkout above here)"))?;
		let t = Instant::now();
		let (json, text, rep) = forge_data::trainers::run(&data, guides.as_deref(), &recs)?;
		let out = out.unwrap_or_else(|| data.join("trainers.json"));
		std::fs::write(&out, json).map_err(|e| e.to_string())?;
		for (c, n, m) in &rep.unverified {
			eprintln!("warning: curated {c} trainer \"{n}\" not found on map {m} in npcs.json; skipped");
		}
		eprintln!("wrote {}: curated {}, from guides {} goals, from recordings {} npcs", out.display(), rep.curated, rep.guide, rep.record);
		if let Some(l) = lua.or_else(|| root.map(|r| r.join("addon/Polestar/Core/ClassTrainers.lua"))) {
			std::fs::write(&l, text).map_err(|e| e.to_string())?;
			eprintln!("wrote {}", l.display());
		}
		eprintln!("trainers: {:.2} s", t.elapsed().as_secs_f64());
		return Ok(());
	}
	if cmd == "publish" {
		return publish(args.collect());
	}
	if cmd == "check-corrections" {
		return check_corrections(args.collect());
	}
	match cmd.as_str() {
		"sources" => return sources(args.collect()),
		"check" => return check(args.collect()),
		"itemdb" => return itemdb(args.collect()),
		"questdb" => return questdb(args.collect()),
		"names" => return names(args.collect()),
		"talents" => return talents(args.collect()),
		"maps" => return maps(args.collect()),
		_ => {}
	}
	if cmd != "build" {
		return Err(usage(if cmd.is_empty() { "a command is needed".to_string() } else { format!("unknown command {cmd}") }));
	}

	let known = [
		"--root",
		"--out",
		"--sources",
		"--recordings",
		"--pfquest",
		"--questie",
		"--build",
		"--forever-build",
		"--forever-tables",
		"--wow",
		"--product",
		"--defs",
		"--cap",
		"--built-at",
		"--corrections",
		"--corrections-private",
		"--local",
		"--kb-file",
		"--verify-file",
		"--mechanics",
		"--client-cache",
		"--client-tables",
	];
	let mut kv: Vec<(String, Option<String>)> = Vec::new();
	let flags = ["--offline", "--accept", "--no-questie", "--no-forever", "--no-web-xp", "--no-web-zones", "--kb", "--no-client"];
	while let Some(a) = args.next() {
		if a == "-h" || a == "--help" {
			println!("{USAGE}");
			return Ok(());
		}
		if flags.contains(&a.as_str()) {
			kv.push((a, None));
		} else if known.contains(&a.as_str()) {
			let v = args.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
			kv.push((a, Some(v)));
		} else if a.starts_with("--") {
			return Err(usage(format!("unknown option {a}")));
		} else {
			return Err(usage(format!("unexpected argument {a}")));
		}
	}
	let get = |k: &str| kv.iter().find(|(a, _)| a == k).and_then(|(_, v)| v.clone());
	let has = |k: &str| kv.iter().any(|(a, _)| a == k);
	let root = match get("--root") {
		Some(r) => abs(r),
		None => find_root(&std::env::current_dir().map_err(|e| e.to_string())?).ok_or_else(|| usage("no checkout (forever-db/corrections/quests.json) above the current folder; pass --root"))?,
	};
	if !root.is_dir() {
		return Err(format!("--root {}: no such folder", root.display()).into());
	}
	let mut o = Options::new(&root);
	if let Some(s) = get("--sources") {
		o.sources = abs(s);
	}
	if let Some(s) = get("--recordings") {
		o.recordings = abs(s);
	}
	o.pfquest = get("--pfquest").map(abs);
	o.build = get("--build");
	o.forever_build = get("--forever-build");
	o.forever = !has("--no-forever");
	o.web_xp = !has("--no-web-xp");
	o.web_zones = !has("--no-web-zones");
	if let Some(c) = get("--cap") {
		o.cap = c.parse().ok().filter(|&n: &usize| n > 0).ok_or_else(|| usage("--cap must be a positive integer"))?;
	}
	if let Some(b) = get("--built-at") {
		o.built_at = build::parse_iso(&b)?;
	}
	if let Some(q) = get("--questie") {
		let d = abs(q.clone());
		o.questie = Some(forge_data::questie::questie_db_dir(&d).ok_or_else(|| format!("--questie {q}: no QuestieDB_Forever.toc there or in its QuestieDB folder"))?);
	} else if !has("--no-questie") {
		o.questie = forge_data::questie::detect_questie();
		match &o.questie {
			Some(d) => eprintln!("QuestieDB: {}", d.display()),
			None => eprintln!("QuestieDB: not found in a Forever client; building without it (pass --questie <dir>)"),
		}
	}
	let defs = get("--defs").map(abs).unwrap_or_else(|| o.sources.join("wowdbdefs"));
	let product = get("--product").unwrap_or_else(|| "wow_classic_beta".into());
	let wow = get("--wow").map(abs).or_else(forge_gamedata::find_install);
	o.offline = has("--offline");
	if !o.offline {
		// The sources the build reads, as the JS build fetched them (web XP: inside the build, for
		// the quests still without any).
		let mut plan = forge_data::sources::Plan::new(&o.sources);
		plan.parts = ["wago", "pfquest", "cmangos", "wowdbdefs"].iter().map(|s| s.to_string()).collect();
		if has("--kb") {
			plan.parts.extend(["eglink".to_string(), "forever-vo".to_string()]);
		}
		plan.build = o.build.clone();
		plan.forever_build = o.forever_build.clone();
		plan.without_client = get("--forever-tables").as_deref() == Some("wago") || wow.is_none();
		plan.pfquest = o.pfquest.clone();
		plan.defs = defs.clone();
		let rep = forge_data::sources::fetch(&plan, &|m| eprintln!("{m}"))?;
		for w in &rep.warnings {
			eprintln!("warning: {w}");
		}
	}
	let client = (!has("--no-client")).then(|| forge_data::client::Options {
		wow: wow.clone().filter(|_| defs.join("definitions").is_dir()),
		product: product.clone(),
		defs: defs.clone(),
		cache: get("--client-cache").map(abs),
		tables: get("--client-tables").map(abs),
	});
	o.forever_source = match get("--forever-tables").as_deref() {
		Some("wago") => Source::Wago,
		Some("saved") => Source::Saved,
		Some("client") => Source::Client { wow: wow.ok_or("--forever-tables client: no World of Warcraft folder found; pass --wow")?, product, defs },
		None => match wow {
			Some(w) if defs.join("definitions").is_dir() => Source::Client { wow: w, product, defs },
			_ => {
				eprintln!("Forever tables: no client or WoWDBDefs checkout found; reading the cached wago.tools CSVs");
				Source::Wago
			}
		},
		Some(x) => return Err(usage(format!("--forever-tables {x}: client, wago or saved"))),
	};
	let out_dir = get("--out").map(abs).unwrap_or_else(|| root.join("data").join("forever"));
	if let Some(c) = get("--corrections-private") {
		o.corrections_private = Some(abs(c));
	}
	if let Some(c) = get("--corrections") {
		o.corrections = abs(c);
	}
	if has("--kb") {
		let mut k = build::KbOptions::new(&root, &out_dir);
		if let Some(l) = get("--local") {
			k.local = abs(l);
			if std::env::var_os("FOREVER_TDB").is_none() {
				k.tdb_db = k.local.join("forever-tdb").join("world.sqlite");
			}
		}
		k.kb_file = get("--kb-file").map(abs);
		k.verify_file = get("--verify-file").map(abs);
		if let Some(m) = get("--mechanics") {
			k.public_mechanics = abs(m);
		}
		k.client = client;
		o.kb = Some(k);
	}
	let t = Instant::now();
	let out = forge_data::run(&o, &|m| eprintln!("{m}"))?;
	for w in &out.warnings {
		eprintln!("warning: {w}");
	}
	// The validation gate: the build staged beside <out>, its statistics against the last good ones.
	let files: Vec<(String, String)> = out.files.iter().map(|(n, t)| (format!("{n}.json"), t.clone())).collect();
	let dropped: Vec<String> = out.stale.iter().map(|n| format!("{n}.json")).collect();
	let staging = forge_data::stats::stage(&out_dir, &files, &dropped.iter().map(String::as_str).collect::<Vec<_>>())?;
	let now = forge_data::stats::compute(&staging, get("--sources").map(abs).as_deref(), Some(&root.join("guides")), Some(&root.join(NAMES)))?;
	let good = forge_data::stats::read_good(&out_dir);
	let cmp = forge_data::stats::compare(good.as_ref(), &now);
	match &good {
		None => eprintln!("data build: no last good statistics ({}): this build's become them", out_dir.join(forge_data::stats::GOOD_FILE).display()),
		Some(g) if !cmp.ok => {
			eprintln!("data build: the statistics shifted against the last good build ({}):\n{}", built_at(&g.built_at), forge_data::stats::format_report(&cmp, false));
			if !has("--accept") {
				return Err(format!("stopped: {} is unchanged; the new build is in {}. If the change is intended, rerun with --accept", rel(&out_dir), rel(&staging)).into());
			}
			eprintln!("data build: --accept: taken");
		}
		Some(_) => {}
	}
	forge_data::write(&out_dir, &out)?;
	let _ = std::fs::remove_dir_all(&staging);
	forge_data::stats::write_stats(&out_dir, &now, true)?;
	let shown = out_dir.strip_prefix(std::env::current_dir().unwrap_or_default()).map(|p| p.display().to_string()).unwrap_or_else(|_| out_dir.display().to_string());
	println!("wrote {}: {}", if shown.is_empty() { "." } else { &shown }, out.summary);
	eprintln!("data build: {:.2} s", t.elapsed().as_secs_f64());
	Ok(())
}

/// The deDE names the statistics' names.matched reads (the deDE language folder's Names.lua).
const NAMES: &str = "addon/Polestar_deDE/Names.lua";

fn rel(p: &Path) -> String {
	let s = forge_data::jsv::relative(&std::env::current_dir().unwrap_or_default(), p);
	if s.is_empty() {
		".".into()
	} else {
		s
	}
}

fn built_at(v: &forge_guide::js::V) -> String {
	if v.truthy() {
		v.to_js_string()
	} else {
		"?".into()
	}
}

/// `--key value` options and flags of a subcommand: (values, flags, positionals).
fn opts(args: Vec<String>, values: &[&str], flags: &[&str]) -> Result<(Vec<(String, String)>, Vec<String>, Vec<String>), Fail> {
	let (mut kv, mut fl, mut pos) = (Vec::new(), Vec::new(), Vec::new());
	let mut it = args.into_iter();
	while let Some(a) = it.next() {
		if values.contains(&a.as_str()) {
			let v = it.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
			kv.push((a, v));
		} else if flags.contains(&a.as_str()) {
			fl.push(a);
		} else if a.starts_with("--") {
			return Err(usage(format!("unknown option {a}")));
		} else {
			pos.push(a);
		}
	}
	Ok((kv, fl, pos))
}

fn root_of(kv: &[(String, String)]) -> Result<PathBuf, Fail> {
	match kv.iter().rev().find(|(k, _)| k == "--root") {
		Some((_, r)) => Ok(abs(r.clone())),
		None => find_root(&std::env::current_dir().map_err(|e| e.to_string())?).ok_or_else(|| usage("no checkout above the current folder; pass --root")),
	}
}

pub(super) const SOURCES_USAGE: &str = "usage: forge data sources [options]

Fills the source cache (data/sources) the data builders read, in the layout they read it from; a
cached file is never fetched again (cached builds and pinned commits do not change):
  wago        the client table CSVs `forge data build` reads (wago.tools): the Classic Era build's
              map and faction tables, the Forever build's when no client is installed, QuestXP
  builders    the other builders' client tables: itemdb's Era item tables, the Codex's, professions'
              and travel's, and the pinned builds of talents and map overlays
  pfquest     the pfQuest checkout at its pinned commit
  eglink      the EG Link output at its pinned commit
  forever-vo  forever-vo's dialog captures at their pinned commit
  cmangos     the CMaNGOS classic-db dump (sha256-checked)
  webxp       the web quest XP of the quests --data has none for
  wowdbdefs   the table definitions the installed client is read with (only when one is found)

options:
  --only LIST          these parts only, comma-separated (default: all)
  --root DIR           the Polestar checkout (default: the one above the current folder)
  --sources DIR        source cache (default: <root>/data/sources)
  --build V            Classic Era build (default: the newest wago.tools lists)
  --forever-build V    Forever build (default: the newest listed)
  --forever-tables S   client (default when a client is found) or wago: whether the data build's
                       Forever tables come from wago.tools
  --wow DIR            World of Warcraft folder (default: $POLESTAR_WOW_DIR or detected)
  --defs DIR           WoWDBDefs checkout (default: <sources>/wowdbdefs)
  --data DIR           the data build whose quests without XP webxp looks up (default: <root>/data/forever)";

/// `forge data sources`.
fn sources(args: Vec<String>) -> Result<(), Fail> {
	let (kv, _, pos) = opts(args, &["--only", "--root", "--sources", "--build", "--forever-build", "--forever-tables", "--wow", "--defs", "--data"], &[])?;
	if let Some(p) = pos.first() {
		return Err(usage(format!("unexpected argument {p}")));
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	let src = get("--sources").map(abs).unwrap_or_else(|| root.join("data").join("sources"));
	let mut plan = forge_data::sources::Plan::new(&src);
	if let Some(only) = get("--only") {
		let parts: Vec<String> = only.split(',').map(|s| s.trim().to_string()).filter(|s| !s.is_empty()).collect();
		if let Some(bad) = parts.iter().find(|p| !forge_data::sources::PARTS.contains(&p.as_str())) {
			return Err(usage(format!("--only {bad}: one of {}", forge_data::sources::PARTS.join(", "))));
		}
		plan.parts = parts;
	}
	plan.build = get("--build");
	plan.forever_build = get("--forever-build");
	let wow = get("--wow").map(abs).or_else(forge_gamedata::find_install);
	plan.without_client = match get("--forever-tables").as_deref() {
		Some("wago") => true,
		Some("client") => false,
		None => wow.is_none(),
		Some(x) => return Err(usage(format!("--forever-tables {x}: client or wago"))),
	};
	if let Some(d) = get("--defs") {
		plan.defs = abs(d);
	}
	if plan.parts.iter().any(|p| p == "webxp") {
		let data = get("--data").map(abs).unwrap_or_else(|| root.join("data").join("forever"));
		if data.join("quests.json").exists() {
			plan.web_xp_ids = Some(forge_data::sources::quests_without_xp(&data)?);
		} else {
			eprintln!("webxp: no {}; nothing to look up (build the data first)", data.join("quests.json").display());
		}
	}
	let rep = forge_data::sources::fetch(&plan, &|m| eprintln!("{m}"))?;
	for w in &rep.warnings {
		eprintln!("warning: {w}");
	}
	println!(
		"sources: {} fetched into {}{}{}",
		rep.fetched,
		rel(&src),
		rep.era_build.map(|b| format!("; Classic Era {b}")).unwrap_or_default(),
		rep.forever_build.map(|b| format!(", Forever {b}")).unwrap_or_default()
	);
	Ok(())
}

pub(super) const DATA_CHECK_USAGE: &str = "usage: forge data check [--root DIR] [--data DIR] [--sources DIR] [--accept] [--all]

Compares the data as it is (default <root>/data/forever, with the compiler reading data/sources
beside it) against its last good statistics (stats-good.json; forge data build --help, Validation):
exit 1 on a shift; --accept makes them the last good ones; --all lists every field.";

/// `forge data check`: the data as it is against its last good statistics.
fn check(args: Vec<String>) -> Result<(), Fail> {
	let (kv, fl, pos) = opts(args, &["--root", "--data", "--sources"], &["--accept", "--all"])?;
	if let Some(p) = pos.first() {
		return Err(usage(format!("unexpected argument {p}")));
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	let accept = fl.iter().any(|f| f == "--accept");
	let data = get("--data").map(abs).unwrap_or_else(|| root.join("data").join("forever"));
	let now = forge_data::stats::compute(&data, get("--sources").map(abs).as_deref(), Some(&root.join("guides")), Some(&root.join(NAMES)))?;
	let good = forge_data::stats::read_good(&data);
	let cmp = forge_data::stats::compare(good.as_ref(), &now);
	forge_data::stats::write_stats(&data, &now, accept || good.is_none())?;
	let Some(good) = good else {
		println!("data check: no last good statistics in {}: these are now them", rel(&data));
		return Ok(());
	};
	println!("data check: {} against the last good build ({}):\n{}", rel(&data), built_at(&good.built_at), forge_data::stats::format_report(&cmp, fl.iter().any(|f| f == "--all")));
	if cmp.ok {
		return Ok(());
	}
	if accept {
		println!("data check: --accept: these are now the last good statistics");
		return Ok(());
	}
	Err(format!("{} statistics shifted past their limits (rerun with --accept if the change is intended)", cmp.rows.iter().filter(|r| r.bad).count()).into())
}

pub(super) const ITEMDB_USAGE: &str = "usage: forge data itemdb [options]

Writes the load-on-demand data addon addon/Polestar_ItemDB (Items.lua + TOC): stats of every
equippable Classic Era item (item level, required level, inventory type, armor, weapon damage and
speed, primary stats and the equip bonuses Polestar.Gear scores), from the Classic Era client
tables (ItemSparse, Item, ItemEffect, SpellEffect). Size budget: 1024 KiB.

  --offline            use cached tables only
  --build V            Classic Era build (default: the newest wago.tools lists)
  --root DIR           the Polestar checkout (default: the one above the current folder)
  --sources DIR        source cache (default <root>/data/sources)
  --out DIR            default <root>/addon/Polestar_ItemDB";

fn itemdb(args: Vec<String>) -> Result<(), Fail> {
	let (kv, fl, pos) = opts(args, &["--root", "--sources", "--build", "--out"], &["--offline"])?;
	if let Some(p) = pos.first() {
		return Err(usage(format!("unexpected argument {p}")));
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	let mut o = forge_data::itemdb::Options::new(&root);
	if let Some(s) = get("--sources") {
		o.sources = abs(s);
	}
	if let Some(s) = get("--out") {
		o.out = abs(s);
	}
	o.build = get("--build");
	o.offline = !fl.is_empty();
	let r = forge_data::itemdb::build(&o, &|m| eprintln!("{m}"))?;
	for w in &r.warnings {
		eprintln!("warning: {w}");
	}
	let skipped: Vec<String> = r.skipped.iter().map(|(k, n)| format!("{n} {k}")).collect();
	let kib = forge_core::jsnum::js_to_fixed(r.bytes as f64 / 1024.0, 0);
	let budget = forge_data::itemdb::SIZE_BUDGET / 1024;
	println!("wrote {} from Classic Era build {}: {} items, {kib} KiB (budget {budget} KiB)", rel(&o.out), r.build, r.count);
	println!("left out: {}", skipped.join(", "));
	if r.bytes > forge_data::itemdb::SIZE_BUDGET {
		return Err(format!("Items.lua is {kib} KiB, over the {budget} KiB budget").into());
	}
	Ok(())
}

pub(super) const QUESTDB_USAGE: &str = "usage: forge data questdb [options]

Builds the load-on-demand quest database addon (addon/Polestar_QuestDB) from data/forever: quests
(levels, race/class masks, faction, givers, enders, prerequisites, objectives), NPCs and objects
(spawn clusters per map, covering every known spawn; Era frames) and items (drop sources, objects,
vendors). Prints the Lua size and an estimate of the in-game memory it costs once loaded.

  --root DIR           the Polestar checkout (default: the one above the current folder)
  --data DIR           data/forever (quests, npcs, objects, items, map-frames)
  --out DIR            output addon folder (default: <root>/addon/Polestar_QuestDB)
  --radius YD          spawn cluster radius (default 70)
  --droppers N         NPC drop sources kept per item (default 8)
  --json               print the stats as JSON";

fn questdb(args: Vec<String>) -> Result<(), Fail> {
	let (kv, fl, pos) = opts(args, &["--root", "--data", "--out", "--radius", "--droppers"], &["--json"])?;
	if let Some(p) = pos.first() {
		return Err(usage(format!("unexpected argument {p}")));
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	let mut o = forge_data::questdb::Options::default();
	let positive = |v: String, flag: &str| -> Result<f64, Fail> {
		let n: f64 = v.parse().map_err(|_| usage(format!("{flag} expects a positive number")))?;
		if !(n.is_finite() && n > 0.0) {
			return Err(usage(format!("{flag} expects a positive number")));
		}
		Ok(n)
	};
	if let Some(v) = get("--radius") {
		o.cluster_radius = positive(v, "--radius")?;
	}
	if let Some(v) = get("--droppers") {
		o.max_droppers = positive(v, "--droppers")? as usize;
	}
	let data = get("--data").map(abs).unwrap_or_else(|| root.join("data/forever"));
	let out = get("--out").map(abs).unwrap_or_else(|| root.join("addon").join(forge_data::questdb::ADDON));
	let r = forge_data::questdb::build(&data, &root, &o)?;
	forge_data::questdb::write(&r, &out)?;
	let s = &r.stats;
	let mb = |n: usize| format!("{} MB", forge_core::jsnum::js_to_fixed(n as f64 / 1048576.0, 2));
	if !fl.is_empty() {
		println!(
			"{{\"quests\":{},\"npcs\":{},\"objects\":{},\"items\":{},\"maps\":{},\"spawnPoints\":{},\"clusters\":{},\"luaBytes\":{},\"memoryBytes\":{},\"warnings\":{}}}",
			s.quests,
			s.npcs,
			s.objects,
			s.items,
			s.maps,
			s.spawn_points,
			s.clusters,
			s.lua_bytes,
			s.memory_bytes,
			r.warnings.len()
		);
		return Ok(());
	}
	println!("questdb: {} quests, {} NPCs, {} objects, {} items, {} map frames", s.quests, s.npcs, s.objects, s.items, s.maps);
	println!("questdb: {} spawn points -> {} clusters", s.spawn_points, s.clusters);
	println!("questdb: Lua {} ({} bytes), estimated in-game memory ~{}", mb(s.lua_bytes), s.lua_bytes, mb(s.memory_bytes));
	for w in r.warnings.iter().take(20) {
		println!("warning: {w}");
	}
	if r.warnings.len() > 20 {
		println!("warning: ... {} more", r.warnings.len() - 20);
	}
	println!("wrote {}", rel(&out));
	Ok(())
}

pub(super) const NAMES_USAGE: &str = "usage: forge data names [<locale>...] [options]

Builds the names in the language folders addon/Polestar_<locale> (every language, or those named; Names.lua
beside our guides' Texts.lua, the TOC shared with `forge guide compile`): the names of
quests, NPCs, objects, items, instances, encounters, factions and flight points (and the objectives of
dungeon event quests) in each language. Per id, the first source with a name that is no English name
wins: the Forever client's tables (wago.tools, &locale=), the web quest database's Forever pages in that
language (only what is cached in data/sources/web/names), DingDB (pinned commit and sha256s, cloned into
data/sources/ding), then pfQuest's db/<locale>. Only the ids the compiled guides, the quest database, the
Codex's data, the travel data and the chokepoints' lifts name. A language left without names loses its
Names.lua (and its folder when no texts are left there); the old Polestar_Names_<locale> folders are
removed. A build into the checkout's addon folder also writes data/local/names-same-as-english.json.

  --root DIR           the Polestar checkout (default: the one above the current folder)
  --offline            no downloads: the cached clones and tables only
  --no-questie         leave DingDB out (its base data is QuestieDB's)
  --no-tables          leave the client tables out (otherwise missing tables stop the build)
  --build VERSION      this Forever client build (default the newest wago.tools lists)
  --sources DIR        the client-table and web cache (default data/sources)
  --ding DIR           this DingDB checkout, used as it is (default data/sources/ding)
  --pfquest DIR        this pfQuest checkout (default data/sources/pfQuest)
  --guides FILE        the compiled guides (default addon/Polestar_Guides/Guides.lua)
  --questdb DIR        the built quest database (default addon/Polestar_QuestDB)
  --codex DIR          the Codex's data (default data/forever/codex)
  --travel FILE        the travel data (default addon/Polestar/Nav/TravelData.lua)
  --chokepoints FILE   the walking map's chokepoints, for the lifts' objects
                       (default addon/Polestar_Nav/Nav/Chokepoints.lua)
  --out DIR            where the addon folders go (default addon/)
  --json               one JSON document on stdout";

fn names(args: Vec<String>) -> Result<(), Fail> {
	let values = ["--root", "--build", "--sources", "--ding", "--pfquest", "--guides", "--questdb", "--codex", "--travel", "--chokepoints", "--out"];
	let (kv, fl, pos) = opts(args, &values, &["--json", "--offline", "--no-questie", "--no-tables"])?;
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| abs(v.clone()));
	let root = root_of(&kv)?;
	let mut o = forge_data::names::Options::new(&root);
	if !pos.is_empty() {
		o.locales = pos;
	}
	o.offline = fl.iter().any(|f| f == "--offline");
	o.no_questie = fl.iter().any(|f| f == "--no-questie");
	o.no_tables = fl.iter().any(|f| f == "--no-tables");
	o.build = kv.iter().rev().find(|(a, _)| a == "--build").map(|(_, v)| v.clone());
	if let Some(p) = get("--sources") {
		o.sources = p;
	}
	o.ding = get("--ding");
	o.pfquest = get("--pfquest");
	for (flag, slot) in
		[("--guides", &mut o.guides), ("--questdb", &mut o.questdb), ("--codex", &mut o.codex), ("--travel", &mut o.travel), ("--chokepoints", &mut o.chokepoints), ("--out", &mut o.out)]
	{
		if let Some(p) = get(flag) {
			*slot = p;
		}
	}
	o.same_as_english = o.out == root.join("addon");
	let json = fl.iter().any(|f| f == "--json");
	let log = |m: &str| {
		if !json {
			println!("{m}");
		}
	};
	let r = forge_data::names::run(&o, &log)?;
	for w in &r.warnings {
		eprintln!("warning: {w}");
	}
	if json {
		println!("{}", r.json());
		return Ok(());
	}
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	for l in r.lines(&cwd) {
		println!("{l}");
	}
	Ok(())
}

pub(super) const TALENTS_USAGE: &str = "usage: forge data talents build|check [options]

Resolves the talent plans in talents/forever/*.json (one file per class, one pick per level, by
talent name) against the Forever client's trait tables (wago.tools, a pinned build, cached under
data/sources/wago/), replays every pick under the client's rules (one point a level from 10, tier
gates, arrows; arrows need their source at full rank), and writes every class into
addon/Polestar/Talents/Builds.lua. check rebuilds in memory and fails if the file differs or a plan
breaks a rule.

options:
  --root DIR       the Polestar checkout (default: the one above the current folder)
  --plans DIR      plan sources (default <root>/talents/forever/)
  --out DIR        output folder (default <root>/addon/Polestar/Talents/)
  --sources DIR    source cache (default <root>/data/sources/)
  --build V        client build (default the pinned one)
  --offline        use cached tables only";

fn talents(args: Vec<String>) -> Result<(), Fail> {
	let (kv, fl, pos) = opts(args, &["--root", "--plans", "--out", "--sources", "--build"], &["--offline"])?;
	let check = match pos.as_slice() {
		[m] if m == "build" => false,
		[m] if m == "check" => true,
		_ => return Err(usage("expected `talents build` or `talents check`")),
	};
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	let mut o = forge_data::talents::Options::new(&root);
	if let Some(p) = get("--plans") {
		o.plans = abs(p);
	}
	if let Some(p) = get("--out") {
		o.out = abs(p);
	}
	if let Some(p) = get("--sources") {
		o.sources = abs(p);
	}
	if let Some(b) = get("--build") {
		o.build = b;
	}
	o.offline = !fl.is_empty();
	let (r, warnings) = forge_data::talents::run(&o, &|m| println!("{m}"))?;
	for w in &warnings {
		eprintln!("warning: {w}");
	}
	for e in &r.errors {
		eprintln!("error: {e}");
	}
	if !r.errors.is_empty() {
		return Err(format!("{} plan error(s)", r.errors.len()).into());
	}
	for c in &r.results {
		let picks: usize = c.builds.iter().map(|b| b.picks.len()).sum();
		let s = &c.facts.strays;
		let strays = if s.is_empty() { String::new() } else { format!(" (left out stray node{} {})", if s.len() > 1 { "s" } else { "" }, s.iter().map(i64::to_string).collect::<Vec<_>>().join(", ")) };
		println!("{}: tree {}, {} talents{strays}, {} plans, {picks} picks replayed", c.class, forge_guide::js::num_str(c.facts.tree), c.facts.nodes.len(), c.builds.len());
	}
	let file = o.out.join("Builds.lua");
	if check {
		if std::fs::read_to_string(&file).ok().as_deref() != Some(r.lua.as_str()) {
			return Err(format!("Builds.lua is out of date ({})", forge_data::talents::COMMAND).into());
		}
		println!("1 files up to date");
		return Ok(());
	}
	std::fs::create_dir_all(&o.out).map_err(|e| format!("{}: {e}", o.out.display()))?;
	std::fs::write(&file, &r.lua).map_err(|e| format!("{}: {e}", file.display()))?;
	println!("wrote Builds.lua");
	Ok(())
}

pub(super) const MAPS_USAGE: &str = "usage: forge data maps build|overlays [options]

build: zone level ranges for the world map (hostile creature levels per zone, spawn-weighted
P10..P90) -> addon/Polestar/Maps/ZoneLevels.lua.
  --data DIR      data/forever (npcs.json, zones.json, map-frames.json)
  --lua FILE      output (default: <root>/addon/Polestar/Maps/ZoneLevels.lua)

overlays: every world map overlay of every zone map (the explored-area paintings), from the
client's tables via wago.tools, so the zone art shows a map without fog of war
-> addon/Polestar/UI/ZoneArtOverlays.lua.
  --build V       client build (default: the pinned Forever build)
  --sources DIR   source cache folder (default: <root>/data/sources)
  --offline       use cached tables only
  --lua FILE      output (default: <root>/addon/Polestar/UI/ZoneArtOverlays.lua)

Both take --root DIR (default: the checkout above the current folder).";

fn maps(args: Vec<String>) -> Result<(), Fail> {
	let (kv, fl, pos) = opts(args, &["--root", "--data", "--lua", "--build", "--sources"], &["--offline"])?;
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| v.clone());
	let root = root_of(&kv)?;
	match pos.as_slice() {
		[m] if m == "build" => {
			if let Some(k) = ["--build", "--sources"].iter().find(|k| get(k).is_some()).or(fl.first().map(|_| &"--offline")) {
				return Err(usage(format!("{k} is an overlays option")));
			}
			let data = get("--data").map(abs).unwrap_or_else(|| root.join("data").join("forever"));
			let out = get("--lua").map(abs).unwrap_or_else(|| root.join("addon/Polestar/Maps/ZoneLevels.lua"));
			let (n, lua) = forge_data::worldmap::zone_levels(&data)?;
			std::fs::write(&out, lua).map_err(|e| format!("{}: {e}", out.display()))?;
			println!("maps: {n} zone level ranges");
			println!("wrote {}", rel(&out));
		}
		[m] if m == "overlays" => {
			if get("--data").is_some() {
				return Err(usage("--data is a build option"));
			}
			let build = get("--build").unwrap_or_else(|| forge_data::worldmap::OVERLAYS_BUILD.to_string());
			let src = get("--sources").map(abs).unwrap_or_else(|| root.join("data").join("sources"));
			let out = get("--lua").map(abs).unwrap_or_else(|| root.join("addon/Polestar/UI/ZoneArtOverlays.lua"));
			let t = forge_data::worldmap::overlay_tables(&src, &build, !fl.is_empty(), &|m| println!("{m}"))?;
			let o = forge_data::worldmap::build_overlays(&t);
			for w in &o.warnings {
				eprintln!("warning: {w}");
			}
			let lua = forge_data::worldmap::emit_overlays(&o, &build);
			std::fs::write(&out, &lua).map_err(|e| format!("{}: {e}", out.display()))?;
			println!("maps: {} overlays ({} tiles) on {} map arts, build {build}", o.count, o.tiles, o.arts.len());
			println!("wrote {} ({} bytes)", rel(&out), lua.len());
		}
		_ => return Err(usage("expected `maps build` or `maps overlays`")),
	}
	Ok(())
}

/// The help of `forge data <sub>`, for the subcommands with one of their own.
pub(super) fn sub_usage(sub: &str) -> Option<&'static str> {
	Some(match sub {
		"check-corrections" => CHECK_USAGE,
		"sources" => SOURCES_USAGE,
		"check" => DATA_CHECK_USAGE,
		"itemdb" => ITEMDB_USAGE,
		"questdb" => QUESTDB_USAGE,
		"names" => NAMES_USAGE,
		"talents" => TALENTS_USAGE,
		"maps" => MAPS_USAGE,
		"build" => USAGE,
		_ => return None,
	})
}

pub(super) const CHECK_USAGE: &str = "usage: forge data check-corrections [--root <checkout>] [--data <dir>] [--corrections <path>]
                                   [--mechanics <file>] [--route-fixes <file>] [--places <file>]
                                   [--guide-fixes <file>] [--json]

Checks the data files contributors edit before a build: their shape, that every correction names
its source, that the quests, NPCs, objects and items they name exist in the built data
(data/forever; ids are not checked without it), and conflicts (a key written twice, a quest both
included and skipped, a public mechanic a correction overrides), and the note-fix records
(notes.json beside the section files: one of set, drop, add, promote, with a source and a note).
Exits 1 when there is an error.

  --corrections <path> default <root>/forever-db/corrections (a folder of section files; one
                       corrections.json in the old single-file form is still read)
  --mechanics <file>   default <root>/data/mechanics-public.json
  --route-fixes <file> default <root>/data/route-fixes.json
  --places <file>      default <root>/data/places.json (where objectives are done, for the arrow)
  --guide-fixes <file> default <root>/data/guide-fixes.json (a step's tip, a level gate)
  --data <dir>         default <root>/data/forever
  --json               the findings as JSON lines";

/// `forge data check-corrections`: forge_data::corrections::check over the three files.
fn check_corrections(args: Vec<String>) -> Result<(), Fail> {
	let mut kv: Vec<(String, String)> = Vec::new();
	let mut json = false;
	let mut it = args.into_iter();
	while let Some(a) = it.next() {
		match a.as_str() {
			"-h" | "--help" => {
				println!("{CHECK_USAGE}");
				return Ok(());
			}
			"--json" => json = true,
			"--root" | "--data" | "--corrections" | "--mechanics" | "--route-fixes" | "--places" | "--guide-fixes" => {
				kv.push((a.clone(), it.next().ok_or_else(|| usage(format!("{a} needs a value")))?))
			}
			s if s.starts_with("--") => return Err(usage(format!("unknown option {s}"))),
			_ => return Err(usage(format!("unexpected argument {a}"))),
		}
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).map(|(_, v)| abs(v.clone()));
	let root = match get("--root") {
		Some(r) => r,
		None => find_root(&std::env::current_dir().map_err(|e| e.to_string())?).ok_or_else(|| usage("no checkout (forever-db/corrections/quests.json) above the current folder; pass --root"))?,
	};
	if !root.is_dir() {
		return Err(format!("--root {}: no such folder", root.display()).into());
	}
	let corrections = get("--corrections").unwrap_or_else(|| forge_data::corrections::locate(&root));
	let mechanics = get("--mechanics").unwrap_or_else(|| root.join("data/mechanics-public.json"));
	let overrides = get("--route-fixes").unwrap_or_else(|| root.join(forge_sim::fixes::FILE));
	let places = get("--places").unwrap_or_else(|| root.join(forge_writer::native::PLACES));
	let guide_fixes = get("--guide-fixes").unwrap_or_else(|| root.join(forge_writer::native::GUIDE_FIXES));
	let data_dir = get("--data").unwrap_or_else(|| root.join("data/forever"));
	let read = |p: &Path| -> Result<Option<String>, String> {
		match std::fs::read_to_string(p) {
			Ok(t) => Ok(Some(t)),
			Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(None),
			Err(e) => Err(format!("{}: {e}", p.display())),
		}
	};
	let data = forge_data::corrections::Tables::load(&data_dir)?;
	if data.is_none() {
		eprintln!("forge data check-corrections: no {} (run `forge data build`): shapes checked, ids not", data_dir.join("quests.json").display());
	}
	let label = |p: &Path| p.strip_prefix(&root).map(|r| r.display().to_string()).unwrap_or_else(|_| p.display().to_string());
	let ct = if corrections.exists() { Some(forge_data::corrections::read_text(&corrections)?) } else { None };
	let (mt, ot, pt, gt) = (read(&mechanics)?, read(&overrides)?, read(&places)?, read(&guide_fixes)?);
	let (cl, ml, ol, pl, gl) = (label(&corrections), label(&mechanics), label(&overrides), label(&places), label(&guide_fixes));
	for (t, l) in [(&ct, &cl), (&mt, &ml), (&ot, &ol), (&pt, &pl), (&gt, &gl)] {
		if t.is_none() {
			eprintln!("forge data check-corrections: {l} not found, skipped");
		}
	}
	let findings = forge_data::corrections::check(&forge_data::corrections::CheckInputs {
		corrections: ct.as_deref().map(|t| (cl.as_str(), t)),
		mechanics: mt.as_deref().map(|t| (ml.as_str(), t)),
		route_fixes: ot.as_deref().map(|t| (ol.as_str(), t)),
		places: pt.as_deref().map(|t| (pl.as_str(), t)),
		guide_fixes: gt.as_deref().map(|t| (gl.as_str(), t)),
		data: data.as_ref(),
	});
	let mut findings = findings;
	// The note-fix records beside the section files (forever-db/corrections/notes.json).
	let notes = corrections.join("notes.json");
	if corrections.is_dir() && notes.is_file() {
		let nl = label(&notes);
		match std::fs::read_to_string(&notes).map_err(|e| e.to_string()).and_then(|t| serde_json::from_str::<serde_json::Value>(&t).map_err(|e| e.to_string())) {
			Ok(v) => {
				findings.extend(forge_data::publish::notes::shape_problems(&v).into_iter().map(|(at, message)| forge_data::corrections::Finding { severity: "error", file: nl.clone(), at, message }))
			}
			Err(e) => findings.push(forge_data::corrections::Finding { severity: "error", file: nl.clone(), at: String::new(), message: format!("not valid JSON: {e}") }),
		}
	}
	let errors = findings.iter().filter(|f| f.severity == "error").count();
	for f in &findings {
		// A folder's finding names its section file: forever-db/corrections/quests.json 1919.set.races.
		let (file, at) = match f.at.split_once('.').filter(|(sec, _)| f.file == cl && corrections.is_dir() && forge_data::corrections::SECTIONS.contains(sec)) {
			Some((sec, rest)) => (format!("{cl}/{sec}.json"), rest.to_string()),
			None => (f.file.clone(), f.at.clone()),
		};
		let f = forge_data::corrections::Finding { file, at, ..f.clone() };
		if json {
			println!("{}", serde_json::json!({ "severity": f.severity, "file": f.file, "at": f.at, "message": f.message }));
		} else {
			println!("{}{}: {}: {}", f.file, if f.at.is_empty() { String::new() } else { format!(" {}", f.at) }, f.severity, f.message);
		}
	}
	eprintln!("forge data check-corrections: {errors} error(s), {} warning(s)", findings.len() - errors);
	if errors > 0 {
		std::process::exit(1);
	}
	Ok(())
}

pub(super) const PUBLISH_USAGE: &str = "usage: forge data publish --out DIR [options]
       forge data publish --check DIR [--provenance FILE] [--evidence DIR] [--corrections PATH]
       forge data publish --from DIR [--zip] [--sqlite FILE] [--lua DIR]

Writes the public quest-data release (forever-db/): values an independent source holds, in the clean
schema. Generated and replaced: data/<table>.jsonl, schema/, datapackage.json, index.json,
CHANGELOG.md (this version's section over the earlier ones) and corrections/LEDGER.md. Hand-written
and kept: README.md, NOTICE.md, LICENSE, LICENSE-CC-BY-4.0.txt and corrections/ (seeded when absent).
The private provenance sidecar goes outside the release. The same inputs, --date and
--producer-commit give the same bytes. --check exits 1 on any finding (a conflicting note fix
included; a stale one is a warning).

options:
  --root DIR             checkout (default: the one above the current folder)
  --kb FILE              the KB (default: <root>/data/local/kb/forever-kb.sqlite; without it the
                         release comes from the public data builds alone)
  --public-data DIR      a public data build with QuestieDB (default: built into a temp folder)
  --public-drops DIR     a public data build without QuestieDB, for drops (default: built)
  --provenance FILE      the sidecar (default: <root>/data/local/publish/provenance.sqlite)
  --previous DIR         the previous release, for CHANGELOG.md and the version number
  --version YYYY.MM.N    release version (default: the one in --out, else the next one this month)
  --factoruide FILE      Factoruide's sqlite (row sources, until the KB splits them)
  --cmangos FILE         CMaNGOS classic-db as sqlite (default: <root>/data/local/mechanics/cm.db)
  --tdb FILE             ForeverTDB world.sqlite (default: <root>/data/local/forever-tdb/world.sqlite)
  --corrections PATH     the corrections: section files and notes.json (default:
                         <root>/forever-db/corrections; copied into DIR/corrections when elsewhere)
  --note-fixes FILE      the note-fix records (default: notes.json in the corrections folder)
  --notes FILE           the rewritten quest notes (quest-notes.json): steps and notes come from it
                         instead of the KB's steps (default: none)
  --sources DIR          source cache: the public builds' inputs and CMaNGOS quest_facts.json
                         (default: <root>/data/sources)
  --producer-commit SHA  index.json producerCommit (default: $PRODUCER_COMMIT, else this forge's git HEAD)
  --date YYYY-MM-DD      release date (default: today, or SOURCE_DATE_EPOCH)
  --zip                  also write forever-db-<version>.zip beside DIR
  --sqlite FILE          also write the tables as one sqlite file
  --lua DIR              also write the in-game library DIR/LibForeverData
  --from DIR             an existing release (default with --zip, --sqlite or --lua and no --out:
                         <root>/forever-db): only the zip, sqlite file and library are written
  --evidence DIR         local evidence quotes (default: <root>/data/local/mechanics/evidence):
                         steps running 8 words of page text are held; --check: the 8-word check";

/// `forge data publish`: the public release, or `--check` of one.
fn publish(args: Vec<String>) -> Result<(), Fail> {
	let mut kv: Vec<(String, Option<String>)> = Vec::new();
	let mut it = args.into_iter();
	while let Some(a) = it.next() {
		match a.as_str() {
			"-h" | "--help" => {
				println!("{PUBLISH_USAGE}");
				return Ok(());
			}
			"--zip" => kv.push((a, None)),
			"--out" | "--check" | "--root" | "--kb" | "--public-data" | "--public-drops" | "--provenance" | "--previous" | "--version" | "--factoruide" | "--cmangos" | "--tdb" | "--corrections"
			| "--producer-commit" | "--date" | "--evidence" | "--sources" | "--sqlite" | "--notes" | "--note-fixes" | "--lua" | "--from" => {
				let v = it.next().ok_or_else(|| usage(format!("publish: {a} needs a value")))?;
				kv.push((a, Some(v)));
			}
			_ => return Err(usage(format!("publish: unknown option {a}"))),
		}
	}
	let get = |k: &str| kv.iter().rev().find(|(a, _)| a == k).and_then(|(_, v)| v.clone());
	let root = match get("--root") {
		Some(r) => Some(abs(r)),
		None => find_root(&std::env::current_dir().map_err(|e| e.to_string())?),
	};
	let t = Instant::now();
	if let Some(dir) = get("--check") {
		let o = forge_data::publish::check::CheckOptions {
			provenance: get("--provenance").map(abs).or_else(|| root.as_ref().map(|r| r.join("data/local/publish/provenance.sqlite")).filter(|p| p.is_file())),
			evidence: get("--evidence").map(abs),
			corrections: get("--corrections").map(abs),
		};
		let (find, notes) = forge_data::publish::check::check(&abs(dir.clone()), &o).map_err(|e| Fail::Run(format!("publish: {e}")))?;
		for n in &notes {
			eprintln!("note: {n}");
		}
		for f in &find {
			println!("{f}");
		}
		eprintln!("publish --check {dir}: {} finding(s) ({:.2} s)", find.len(), t.elapsed().as_secs_f64());
		if !find.is_empty() {
			return Err(Fail::Run(format!("publish --check {dir}: {} finding(s)", find.len())));
		}
		return Ok(());
	}
	let lua = get("--lua").map(abs);
	let sqlite = get("--sqlite").map(abs);
	let zip = kv.iter().any(|(a, _)| a == "--zip");
	let from = match (get("--from"), get("--out")) {
		(Some(_), Some(_)) => return Err(usage("publish: --from or --out, not both")),
		(Some(f), None) => Some(abs(f)),
		(None, None) if lua.is_some() || sqlite.is_some() || zip => Some(root.as_ref().map(|r| r.join("forever-db")).ok_or_else(|| usage("publish: no checkout above here: pass --from DIR"))?),
		_ => None,
	};
	if let Some(dir) = from {
		if lua.is_none() && sqlite.is_none() && !zip {
			return Err(usage("publish: --from needs --zip, --sqlite or --lua"));
		}
		let ex = forge_data::publish::export(&dir, zip, sqlite.as_deref()).map_err(|e| Fail::Run(format!("publish: {e}")))?;
		report_exports(&ex, lua.as_deref(), &dir)?;
		eprintln!("data publish: {:.2} s", t.elapsed().as_secs_f64());
		return Ok(());
	}
	let root = root.ok_or_else(|| usage("publish: no checkout (forever-db/corrections/quests.json) above the current folder; pass --root"))?;
	let out = get("--out").map(abs).ok_or_else(|| usage("publish: --out DIR, --check DIR or --from DIR"))?;
	let mut o = forge_data::publish::Options::new(&root, &out);
	if let Some(v) = get("--kb") {
		o.kb = abs(v);
	}
	o.public_data = get("--public-data").map(abs);
	o.public_drops = get("--public-drops").map(abs);
	if let Some(v) = get("--provenance") {
		o.provenance = abs(v);
	}
	o.previous = get("--previous").map(abs);
	o.version = get("--version");
	o.zip = zip;
	for (k, slot) in [("--factoruide", &mut o.factoruide), ("--cmangos", &mut o.cmangos), ("--tdb", &mut o.tdb)] {
		if let Some(v) = get(k) {
			let p = abs(v);
			if !p.is_file() {
				return Err(usage(format!("publish: {k} {}: not found", p.display())));
			}
			*slot = Some(p);
		}
	}
	if let Some(v) = get("--corrections") {
		o.corrections = abs(v);
	}
	o.producer_commit = get("--producer-commit");
	if let Some(v) = get("--sources") {
		o.sources = abs(v);
	}
	o.date = get("--date");
	if let Some(v) = get("--evidence") {
		o.evidence = Some(abs(v));
	}
	o.sqlite = sqlite;
	for (k, slot) in [("--notes", &mut o.notes), ("--note-fixes", &mut o.note_fixes)] {
		if let Some(v) = get(k) {
			let p = abs(v);
			if !p.is_file() {
				return Err(usage(format!("publish: {k} {}: not found", p.display())));
			}
			*slot = Some(p);
		}
	}
	let s = forge_data::publish::run(&o, &|m| eprintln!("{m}")).map_err(|e| Fail::Run(format!("publish: {e}")))?;
	for n in &s.notes {
		eprintln!("note: {n}");
	}
	println!("release {} (client {}) in {}", s.version, s.client_build, out.display());
	for (t, n) in &s.counts {
		println!("  {t}: {n} rows");
	}
	for (k, of, n) in &s.coverage {
		println!("  {k}: {n} / {of} ({:.1}%)", if *of == 0 { 0.0 } else { *n as f64 * 100.0 / *of as f64 });
	}
	for (k, n) in &s.cuts {
		println!("  not published {k}: {n}");
	}
	for (k, n) in s.held.iter().filter(|(k, _)| k.starts_with("quest")) {
		println!("  dropped {k}: {n}");
	}
	let held_steps: usize = s.held.iter().filter(|(k, _)| k.starts_with("step")).map(|(_, n)| n).sum();
	println!("  steps held (not structured, not high, or quoting page text): {held_steps}");
	if !s.ledger.is_empty() {
		println!("  note fixes: {}", s.ledger.iter().map(|(k, n)| format!("{n} {k}")).collect::<Vec<_>>().join(", "));
	}
	report_exports(&forge_data::publish::Exported { zip: s.zip.clone(), sqlite: s.sqlite.clone() }, lua.as_deref(), &out)?;
	println!("  provenance {}", o.provenance.display());
	eprintln!("data publish: {:.2} s", t.elapsed().as_secs_f64());
	Ok(())
}

/// Prints the zip and sqlite lines, and writes the library when asked.
fn report_exports(ex: &forge_data::publish::Exported, lua: Option<&Path>, release: &Path) -> Result<(), Fail> {
	if let Some((p, n)) = &ex.zip {
		println!("  zip {} ({n} bytes)", p.display());
	}
	if let Some((p, n)) = &ex.sqlite {
		println!("  sqlite {} ({n} bytes)", p.display());
	}
	if let Some(l) = lua {
		let (files, bytes) = forge_data::publish::lua::write(release, l).map_err(|e| Fail::Run(format!("publish --lua: {e}")))?;
		println!("  library {} ({files} files, {bytes} bytes)", l.join(forge_data::publish::lua::ADDON).display());
	}
	Ok(())
}
