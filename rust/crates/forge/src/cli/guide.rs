//! `forge guide compile|lint`: compiles or checks a guide pack (port of tools/commands/compile.js and
//! lint.js, with pack/locate.js and pack/build.js's packCommand). The pack is the folder argument (or
//! `--pack`), else the nearest folder holding a pack.json (this one or a parent), else our guides/.
//! Another pack is compiled with our guides as context and written to <pack>/dist/<folder>/; ours to
//! <checkout>/addon/<folder>/. `--force` writes the files even with errors; lint's `--sim <dir>` (default
//! <checkout>/data/sim with the default data) reads world-<faction>.json's `excluded` for the solo policy,
//! skipping a world built from other data.
//!
//! `forge guide bake --guides <dir>[,<dir>...] [--grid <dir>] [--leffe <dir>] [--root <repo>] [--data <dir>] [--threads N]`:
//! the baked legs of written guide trees (forge::bake).

use forge_guide::data::Data;
use forge_guide::diag::{format_diagnostics, Diag, Diagnostics};
use forge_guide::js::{parse_json, Obj, V};
use forge_guide::project::{build_pack, find_guide_files, find_pack_dir, load_project_data, no_reference_data, read_sources, same_path, BuildOpts, Context};
use std::path::{Path, PathBuf};
use std::time::Instant;

/// The Polestar checkout: the nearest folder above the working directory, else above the forge binary,
/// holding addon/Polestar/Polestar.toc and guides/pack.json.
fn find_root() -> Option<PathBuf> {
	let is_root = |d: &&Path| d.join("addon/Polestar/Polestar.toc").exists() && d.join("guides/pack.json").exists();
	let cwd = std::env::current_dir().unwrap_or_default();
	let exe = std::env::current_exe().unwrap_or_default();
	cwd.ancestors().find(is_root).or_else(|| exe.ancestors().find(is_root)).map(Path::to_path_buf)
}

fn plural(n: usize, word: &str) -> String {
	format!("{n} {word}{}", if n == 1 { "" } else { "s" })
}

/// printDiagnostics (lib/cli.js): text on stderr, one line per diagnostic; json (one document) and
/// github annotations on stdout. `quiet` leaves the warnings out (json still counts them).
fn print_diagnostics(all: &[Diag], fmt: &str, quiet: bool) {
	let items: Vec<Diag> = all.iter().filter(|d| !(quiet && d.severity == "warning")).cloned().collect();
	match fmt {
		"json" => println!("{}", format_diagnostics(&items, "json", all)),
		"github" => {
			if !items.is_empty() {
				println!("{}", format_diagnostics(&items, "github", all));
			}
		}
		_ => {
			for d in &items {
				eprintln!("{}", forge_guide::diag::format(d));
			}
		}
	}
}

/// The positional arguments of `args` (after the command), skipping option values.
fn positional(args: &[String], values: &[&str]) -> Vec<String> {
	let mut out = Vec::new();
	let mut it = args.iter();
	while let Some(a) = it.next() {
		if a.starts_with("--") && a.len() > 2 {
			if values.contains(&a.as_str()) {
				it.next();
			}
		} else {
			out.push(a.clone());
		}
	}
	out
}

/// soloExclusions (lint.js): faction -> { quest id -> world.excluded entry } from the cached worlds in
/// `sim`; a faction without one is not checked, nor one whose world was built from other data or by
/// another builder (its `dataHash` differs from the inputs' now) -> (excluded, stale factions).
fn solo_exclusions(sim: &Path, root: &Path, data_dir: &Path) -> (Obj, Vec<&'static str>) {
	let excluded = Obj::new();
	let mut stale = Vec::new();
	let mut hash: Option<Option<String>> = None;
	for faction in ["Alliance", "Horde"] {
		let Ok(text) = std::fs::read_to_string(sim.join(format!("world-{}.json", faction.to_lowercase()))) else { continue };
		let Ok(w) = parse_json(&text) else { continue };
		let now = hash.get_or_insert_with(|| data_hash(root, data_dir));
		if now.as_deref() != w.get("dataHash").as_str() {
			stale.push(faction);
			continue;
		}
		let m = Obj::new();
		for e in w.get("excluded").items() {
			m.set(&e.get("id").to_js_string(), e);
		}
		excluded.set(faction, m);
	}
	(excluded, stale)
}

/// The `dataHash` a world built now from `data_dir` would carry (forge_world::inputs; None when the
/// inputs cannot be read).
fn data_hash(root: &Path, data_dir: &Path) -> Option<String> {
	let mut inputs = forge_world::inputs::world_inputs(root).ok()?;
	if !same_path(data_dir, &root.join("data/forever")) {
		for (k, v) in inputs.iter_mut() {
			if forge_world::inputs::WORLD_DATA_FILES.iter().any(|f| format!("{f}.json") == *k) {
				*v = std::fs::read(data_dir.join(&*k)).map(|b| forge_core::content_key(&b)).unwrap_or_else(|_| "-".into());
			}
		}
	}
	Some(forge_world::inputs::inputs_hash(&inputs))
}

/// `forge guide seed|publish|check-generated` (forge::generated).
fn generated(cmd: &str, args: &[String]) -> i32 {
	use forge::generated;
	let usage = |m: &str| {
		eprintln!("forge guide: {m}\n(forge guide --help for the options)");
		2
	};
	let fail = |m: &str| {
		eprintln!("forge guide: {m}");
		1
	};
	if let Err(e) = super::check_args(args, &["--checkout", "--from"], &["--force"], 0) {
		return usage(&e);
	}
	let opt = |k: &str| args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k)?.strip_prefix('=').map(String::from)));
	let cwd = std::env::current_dir().unwrap_or_default();
	let abs = |p: String| {
		let p = cwd.join(p);
		p.canonicalize().unwrap_or(p)
	};
	let checkout = match opt("--checkout").map(abs) {
		Some(c) if c.join(forge::CHECKOUT_MARK).is_file() => c,
		Some(c) => return usage(&format!("--checkout {}: not a Polestar checkout (no {})", c.display(), forge::CHECKOUT_MARK)),
		None => match forge::find_checkout(&cwd) {
			Some(c) => c,
			None => return usage(&format!("no Polestar checkout ({}) above here: pass --checkout <dir>", forge::CHECKOUT_MARK)),
		},
	};
	match cmd {
		"seed" => match generated::cut_seed(&checkout, args.iter().any(|a| a == "--force")) {
			Ok(n) => {
				eprintln!("forge guide seed: {n} leveling guides in {}/{} ({})", checkout.display(), generated::SEED_DIR, generated::SEED_MANIFEST);
				0
			}
			Err(e) => fail(&e),
		},
		"publish" => {
			let Some(from) = opt("--from").map(abs) else { return usage("publish needs --from <a written guides folder>") };
			match generated::publish(&checkout, &from) {
				Ok(n) => {
					eprintln!("forge guide publish: {n} generated guides from {} into {}/guides ({}); compile them with forge guide compile", from.display(), checkout.display(), generated::GENERATED);
					0
				}
				Err(e) => fail(&e),
			}
		}
		_ => match generated::check(&checkout) {
			Ok(bad) if bad.is_empty() => {
				eprintln!("forge guide check-generated: no generated guide or seed file is edited");
				0
			}
			Ok(bad) => {
				for b in &bad {
					println!("{b}");
				}
				fail(&format!("{} generated file(s) edited by hand: forge build writes them and would undo the edit.\n{}", bad.len(), generated::WHERE_FIXES_GO))
			}
			Err(e) => fail(&e),
		},
	}
}

/// `forge guide bake`: legs.json and legs-qa.txt beside each written guide tree.
fn bake(args: &[String]) -> i32 {
	let usage = |m: &str| {
		eprintln!("forge guide: {m}\n(forge guide --help for the options)");
		2
	};
	if let Err(e) = super::check_args(args, &["--guides", "--grid", "--leffe", "--root", "--data", "--threads"], &[], 0) {
		return usage(&e);
	}
	let opt = |k: &str| args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k)?.strip_prefix('=').map(String::from)));
	let cwd = std::env::current_dir().unwrap_or_default();
	let Some(trees) = opt("--guides") else { return usage("bake needs --guides <written tree>[,<tree>...]") };
	let trees: Vec<PathBuf> = trees.split(',').map(|t| cwd.join(t.trim())).collect();
	let Some(root) = opt("--root").map(|r| cwd.join(r)).or_else(find_root) else {
		return usage("no Polestar checkout (addon/Polestar/Polestar.toc and guides/pack.json) above here or the forge binary: pass --root <checkout>");
	};
	let data = opt("--data").map(|d| cwd.join(d)).unwrap_or_else(|| root.join("data/forever"));
	let grid = forge::grid_dir(opt("--grid").map(|g| cwd.join(g)).as_deref(), &root);
	let leffe = forge::find_leffe(opt("--leffe").map(|l| cwd.join(l)).as_deref());
	let threads = match opt("--threads").map(|t| t.parse::<usize>()) {
		Some(Ok(t)) => t,
		Some(Err(_)) => return usage("--threads needs a number"),
		None => 4,
	};
	let src = forge_world::data::DirSource::repo(&root);
	let Some(build) = forge_world::data::forever_build(&src) else { return usage(&format!("no cached Forever AreaTable in {}/data/sources/wago", root.display())) };
	let area_table = root.join(format!("data/sources/wago/{build}/AreaTable.csv"));
	let say = |m: &str| eprintln!("forge guide bake: {m}");
	let r = forge::bake::bake_trees(&forge::bake::BakeIn {
		trees: &trees,
		data: &data,
		grid: &grid,
		leffe: leffe.as_deref(),
		area_table: &area_table,
		zones: &data.join("zones.json"),
		chokepoints: &root.join("addon/Polestar_Nav/Nav/Chokepoints.lua"),
		threads,
		log: &say,
	});
	match r {
		Ok(o) => {
			eprintln!("forge guide bake: {}", o.stats);
			for f in &o.files {
				eprintln!("  {}", f.display());
			}
			0
		}
		Err(e) => {
			eprintln!("forge guide bake: {e}");
			1
		}
	}
}

pub fn main() {
	std::process::exit(run());
}

/// `path.relative(from, to)`: `to` from `from`, with `..` where it leaves it.
fn relative(from: &Path, to: &Path) -> String {
	let (a, b): (Vec<_>, Vec<_>) = (from.components().collect(), to.components().collect());
	let common = a.iter().zip(&b).take_while(|(x, y)| x == y).count();
	let mut parts: Vec<String> = vec!["..".into(); a.len() - common];
	parts.extend(b[common..].iter().map(|c| c.as_os_str().to_string_lossy().into_owned()));
	parts.join("/")
}

/// `forge guide check <dir> [--json] [--fix] [--data <dir>] [--root <checkout>]` (forge_guide::guidecheck).
fn guidecheck(args: &[String]) -> i32 {
	use forge_guide::guidecheck::{check_files, find_chains, Kb, KbStep, RULES};
	let usage = |m: &str| {
		eprintln!("forge guide check: {m}\n(forge guide --help for the options)");
		2
	};
	if let Err(e) = super::check_args(args, &["--data", "--root"], &["--json", "--fix"], 1) {
		return usage(&e);
	}
	let named = positional(args, &["--data", "--root"]);
	let Some(dir) = named.first() else { return usage("a folder of guides is needed: forge guide check <dir>") };
	let opt = |k: &str| args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k)?.strip_prefix('=').map(String::from)));
	let flag = |k: &str| args.iter().any(|a| a == k);
	let cwd = std::env::current_dir().unwrap_or_default();
	let t0 = Instant::now();
	let root = opt("--root").map(|r| cwd.join(r)).or_else(find_root);
	let data_dir = match (opt("--data"), &root) {
		(Some(d), _) => cwd.join(d),
		(None, Some(r)) => r.join("data/forever"),
		(None, None) => return usage("no Polestar checkout above here: pass --data <dir> or --root <checkout>"),
	};
	let data = match forge_guide::data::load_data(&data_dir) {
		Ok(d) => d,
		Err(e) => {
			eprintln!("forge guide check: {e}");
			return 1;
		}
	};
	// The knowledge base's required steps (local only: none without it).
	let kb: Option<Kb> = root
		.as_ref()
		.and_then(|r| forge_judge::honest::load_kb(&r.join("data/local/kb/forever-kb.sqlite")).ok().flatten())
		.map(|kb| kb.into_iter().map(|(q, steps)| (q, steps.into_iter().map(|s| KbStep { n: s.n, action: s.action, kind: s.kind, target: s.target, item: s.item }).collect())).collect());
	let dir = cwd.join(dir);
	let chains = find_chains(&dir);
	if chains.is_empty() {
		eprintln!("forge guide check: no .guide files under {}", dir.display());
		return 2;
	}
	let read = |files: &[PathBuf]| -> Vec<(String, String)> { files.iter().map(|f| (f.to_string_lossy().into_owned(), std::fs::read_to_string(f).unwrap_or_default())).collect() };
	let mut fixed: Option<Vec<(String, usize)>> = None;
	if flag("--fix") {
		let mut all: Vec<(String, usize)> = Vec::new();
		for files in &chains {
			let r = forge_guide::guidecheck_repair::repair_chain(&read(files), &data, kb.as_ref(), 4);
			for (file, text) in &r.texts {
				if std::fs::read_to_string(file).ok().as_deref() != Some(text.as_str()) {
					if let Err(e) = std::fs::write(file, text) {
						eprintln!("forge guide check: {file}: {e}");
						return 1;
					}
				}
			}
			for (k, v) in r.applied {
				match all.iter_mut().find(|e| e.0 == k) {
					Some(e) => e.1 += v,
					None => all.push((k, v)),
				}
			}
		}
		fixed = Some(all);
	}
	let mut failures = Vec::new();
	for files in &find_chains(&dir) {
		failures.extend(check_files(&read(files), &data, kb.as_ref()).1);
	}
	let shown = |f: &str| relative(&cwd, Path::new(f));
	let mut counts: Vec<(&str, usize)> = Vec::new();
	for f in &failures {
		match counts.iter_mut().find(|c| c.0 == f.rule) {
			Some(c) => c.1 += 1,
			None => counts.push((f.rule, 1)),
		}
	}
	let secs = t0.elapsed().as_secs_f64();
	if flag("--json") {
		let obj = |pairs: Vec<(String, serde_json::Value)>| serde_json::Value::Object(pairs.into_iter().collect());
		let doc = obj(vec![
			("chains".into(), chains.len().into()),
			("counts".into(), obj(counts.iter().map(|(k, v)| (k.to_string(), (*v).into())).collect())),
			("fixed".into(), fixed.as_ref().map_or(serde_json::Value::Null, |f| obj(f.iter().map(|(k, v)| (k.clone(), (*v).into())).collect()))),
			(
				"failures".into(),
				failures
					.iter()
					.map(|f| {
						obj(vec![
							("rule".into(), f.rule.into()),
							("severity".into(), "fail".into()),
							("file".into(), shown(&f.file).into()),
							("line".into(), f.line.into()),
							("message".into(), f.message.clone().into()),
							("repair".into(), f.repair.clone().into()),
						])
					})
					.collect(),
			),
			("ms".into(), obj(vec![("total".into(), ((secs * 1000.0) as u64).into())])),
		]);
		println!("{}", serde_json::to_string_pretty(&doc).unwrap_or_default());
	} else {
		for f in &failures {
			println!("{}:{}  {}  {}\n    repair: {}", shown(&f.file), f.line, f.rule, f.message, f.repair);
		}
		if let Some(fx) = &fixed {
			let list: Vec<String> = fx.iter().map(|(k, v)| format!("{k} {v}")).collect();
			println!("fixed: {}", if list.is_empty() { "nothing".into() } else { list.join(", ") });
		}
		let by_rule: Vec<String> = RULES.iter().filter_map(|r| counts.iter().find(|c| c.0 == *r).map(|c| format!("{r} {}", c.1))).collect();
		println!("{}: {} ({secs:.1} s)", plural(chains.len(), "chain"), if failures.is_empty() { "no failures".into() } else { by_rule.join(", ") });
	}
	i32::from(!failures.is_empty())
}

const COMPILE_VALUES: [&str; 8] = ["--root", "--pack", "--guides", "--data", "--context", "--context-data", "--out", "--format"];
const LINT_VALUES: [&str; 8] = ["--root", "--pack", "--guides", "--data", "--context", "--context-data", "--sim", "--format"];

fn run() -> i32 {
	let args: Vec<String> = super::args().skip(1).collect();
	let usage = |m: &str| {
		eprintln!("forge guide: {m}\n(forge guide --help for the options)");
		2
	};
	let cmd = args.first().cloned().unwrap_or_default();
	if cmd == "check" {
		return guidecheck(&args[1..]);
	}
	if matches!(cmd.as_str(), "seed" | "publish" | "check-generated") {
		return generated(&cmd, &args[1..]);
	}
	if cmd == "bake" {
		return bake(&args[1..]);
	}
	if cmd != "compile" && cmd != "lint" {
		return usage(&format!("unknown command {cmd}: compile, lint, check, bake, seed, publish or check-generated"));
	}
	let rest = &args[1..];
	let values: &[&str] = if cmd == "compile" { &COMPILE_VALUES } else { &LINT_VALUES };
	if let Err(e) = super::check_args(rest, values, &["--quiet", "--force", "--time", "--no-data", "--include-drafts"], usize::MAX) {
		return usage(&e);
	}
	let opt = |k: &str| rest.iter().position(|a| a == k).and_then(|i| rest.get(i + 1)).cloned().or_else(|| rest.iter().find_map(|a| a.strip_prefix(k)?.strip_prefix('=').map(String::from)));
	let flag = |k: &str| rest.iter().any(|a| a == k);
	let cwd = std::env::current_dir().unwrap_or_default();
	let at = |p: String| cwd.join(p);

	// Which pack (locate.js packArgument, commandPack).
	let named = positional(rest, values);
	if named.len() > 1 {
		return usage(&format!("one pack folder only, got {}: {}", named.len(), named.iter().map(|p| format!("\"{p}\"")).collect::<Vec<_>>().join(" ")));
	}
	let pack_arg = match (named.first(), opt("--pack")) {
		(Some(p), Some(q)) => return usage(&format!("the pack folder is named twice (\"{p}\" and --pack {q}); give it once")),
		(p, q) => p.cloned().or(q),
	};
	if let Some(p) = &pack_arg {
		if !at(p.clone()).join("pack.json").exists() {
			return usage(&format!("no pack.json in {p}"));
		}
	}
	let fmt = opt("--format").unwrap_or_else(|| "text".into());
	if !["text", "json", "github"].contains(&fmt.as_str()) {
		return usage(&format!("unknown --format {fmt} (use text, json, github)"));
	}
	let no_data = flag("--no-data");
	if no_data {
		if let Some(k) = ["--data", "--context-data", "--sim"].into_iter().find(|k| opt(k).is_some()) {
			return usage(&format!("--no-data and {k} cannot be used together"));
		}
	}
	if opt("--guides").is_some() && pack_arg.is_some() {
		return usage("--guides and a pack folder cannot be used together");
	}
	for k in ["--context", "--context-data"] {
		if let Some(v) = opt(k) {
			if !at(v.clone()).is_dir() {
				return usage(&format!("{k} {v} is not a folder"));
			}
		}
	}
	let Some(root) = opt("--root").map(at).or_else(find_root) else {
		return usage("no Polestar checkout (addon/Polestar/Polestar.toc and guides/pack.json) above here or the forge binary: pass --root <checkout>");
	};
	if !root.join("guides/pack.json").is_file() {
		eprintln!("forge guide {cmd}: no guides/pack.json in {}: pass --root <checkout>", root.display());
		return 1;
	}
	let official_dir = root.join("guides");
	let (pack_dir, official) = match opt("--guides") {
		Some(g) => (at(g), true),
		None => {
			let dir = pack_arg.map(at).or_else(|| find_pack_dir(&cwd)).unwrap_or_else(|| official_dir.clone());
			let official = same_path(&dir, &official_dir);
			(dir, official)
		}
	};
	if !pack_dir.is_dir() {
		eprintln!("forge guide {cmd}: {}: no such folder", pack_dir.display());
		return 1;
	}
	let (context_dir, context_data_dir) = if official {
		(None, None)
	} else {
		(Some(opt("--context").map(at).unwrap_or_else(|| official_dir.clone())), Some(opt("--context-data").map(at).unwrap_or_else(|| root.join("data/forever"))))
	};
	let quiet = flag("--quiet");
	let summary = fmt != "json";
	let t0 = Instant::now();

	let (manifest, extra) = forge_guide::manifest::read_manifest(if official { &official_dir } else { &pack_dir }, official);
	let Some(manifest) = manifest.filter(V::truthy) else {
		print_diagnostics(&extra, &fmt, quiet);
		if summary {
			eprintln!("{cmd} failed: {} in pack.json", plural(extra.iter().filter(|d| d.severity == "error").count(), "error"));
		}
		return 1;
	};

	// The reference data (pack/build.js packCommand, noReferenceData; project.js compileProject).
	let data_dir = opt("--data").map(at).unwrap_or_else(|| root.join("data/forever"));
	let mut data_diag = Diagnostics::new();
	let (data, context_data) = if no_data {
		(Data::empty(), context_dir.as_ref().map(|_| Data::empty()))
	} else {
		if let Some(missing) = no_reference_data(&data_dir, context_data_dir.as_deref(), true) {
			print_diagnostics(&missing.sorted(), &fmt, quiet);
			if summary {
				eprintln!("{cmd} failed: no reference data");
			}
			return 1;
		}
		let load = |dir: &Path, diag: &mut Diagnostics| load_project_data(dir, diag).map_err(|e| eprintln!("forge guide {cmd}: {e}"));
		let Ok(data) = load(&data_dir, &mut data_diag) else { return 1 };
		let context_data = match &context_data_dir {
			Some(c) if !same_path(c, &data_dir) => match load(c, &mut data_diag) {
				Ok(d) => Some(d),
				Err(()) => return 1,
			},
			_ => None,
		};
		(data, context_data)
	};
	let t_data = t0.elapsed();
	let context = context_dir.as_ref().map(|dir| Context { sources: read_sources(dir, &find_guide_files(dir, false)), data: context_data.as_ref().unwrap_or(&data) });
	let opts = BuildOpts { include_drafts: flag("--include-drafts"), context, force: flag("--force") };
	let built = match build_pack(&root, &pack_dir, &manifest, extra, &data, data_diag, opts) {
		Ok(b) => b,
		Err(e) => {
			eprintln!("forge guide {cmd}: {e}");
			return 1;
		}
	};
	let mut diag = built.project.diag;
	let mut stale = Vec::new();
	if cmd == "lint" {
		// The default world was built from the default data; other data needs its own --sim.
		let sim = if no_data { None } else { opt("--sim").map(at).or_else(|| opt("--data").is_none().then(|| root.join("data/sim"))) };
		let excluded = match sim {
			Some(sim) => {
				let (excluded, s) = solo_exclusions(&sim, &root, &data_dir);
				stale = s;
				excluded
			}
			None => Obj::new(),
		};
		forge_guide::validate::validate_solo_policy(&built.project.guides, &V::Obj(excluded), &mut diag);
	}
	let t_built = t0.elapsed();
	let out = match opt("--out") {
		Some(o) => at(o),
		None => {
			let folder = manifest.get("folder").to_js_string();
			if !forge_guide::format::is_folder(&folder) {
				eprintln!("forge guide {cmd}: refusing the pack folder {folder:?}: not a plain folder name");
				return 1;
			}
			if official {
				root.join("addon").join(folder)
			} else {
				pack_dir.join("dist").join(folder)
			}
		}
	};
	// Write before reporting: a failed write is one more error, so the JSON document's `ok` matches the exit code.
	if let Some(files) = built.files.as_ref().filter(|_| cmd == "compile" && (!diag.has_errors() || flag("--force"))) {
		if let Err(e) = forge_guide::project::write_pack_dir(&out, files) {
			diag.error(&out.to_string_lossy(), 0.0, e, None);
		}
	}
	print_diagnostics(&diag.sorted(), &fmt, quiet);
	if flag("--time") {
		eprintln!("time: data {:?}, compile {:?}, total {:?}", t_data, t_built - t_data, t0.elapsed());
	}
	let (e, w) = (diag.errors().len(), diag.warnings().len());
	let guides = &built.project.guides;
	let files = built.project.sources.len();
	if cmd == "lint" {
		// Another pack: the simulator's world is ours to rebuild, not the pack author's.
		if !stale.is_empty() && official {
			eprintln!(
				"note: solo-filter checks skipped for {}: the simulator's cached world is from other data or an older builder (`forge walks world . data/local/nav4 data/sim <faction>` rebuilds it)",
				stale.join(" and ")
			);
		}
		let line = format!("{}, {}: {}, {}", plural(files, "file"), plural(guides.len(), "guide"), plural(e, "error"), plural(w, "warning"));
		if summary {
			if e > 0 {
				eprintln!("lint failed: {line}");
			} else {
				println!("lint ok: {line}");
			}
		}
	} else if e > 0 {
		if summary {
			eprintln!("compile failed: {}, {}", plural(e, "error"), plural(w, "warning"));
		}
	} else if summary {
		let steps: usize = guides.iter().map(|g| g.get("steps").len()).sum();
		println!("compiled {} ({}) from {} into {}; {}", plural(guides.len(), "guide"), plural(steps, "step"), plural(files, "file"), out.display(), plural(w, "warning"));
		// Place ids (places.rs): how many place goals got an area, getfp goals a taxi node.
		let p = forge_guide::places::place_counts(guides);
		let n = |v: &V, k: &str| v.get(k).num() as usize;
		if data.areas.truthy() {
			println!("areas: {} of {} got an area (AreaTable {})", n(&p, "withArea"), plural(n(&p, "places"), "place goal"), data.areas.get("build").to_js_string());
		} else {
			println!("areas: none (no cached Forever AreaTable in the sources beside the reference data; `forge data build` downloads it)");
		}
		if !data.flight_nodes().is_empty() {
			println!("nodes: {} of {} got a taxi node (travel.json)", n(&p, "withNode"), plural(n(&p, "getfp"), "getfp goal"));
		} else {
			println!("nodes: none (no travel.json in the reference data; `forge data travel` writes it)");
		}
		// Heights (heights.rs): NPC and object goals, smart-target candidates and their spawn spots with z.
		let h = forge_guide::heights::height_counts(guides);
		if data.spawnz.truthy() {
			println!(
				"heights: {} of {}, {} of {} and {} of {} got z (spawnz.json)",
				n(&h, "withZ"),
				plural(n(&h, "eligible"), "NPC or object goal"),
				n(&h, "candidatesWithZ"),
				plural(n(&h, "candidates"), "smart-target candidate"),
				n(&h, "spotsWithZ"),
				plural(n(&h, "spots"), "spawn spot")
			);
		} else {
			println!("heights: none (no spawnz.json in the reference data; `forge data build` writes it)");
		}
	}
	i32::from(e > 0)
}
