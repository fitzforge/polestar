//! `forge i18n`: Polestar's translations (docs/TRANSLATING.md; forge_i18n): the interface strings
//! (status, check, sync, keys, import), a pack's guide texts (guides sync|check|stats) and the English
//! left on a non-English client (leaks). Port of tools/commands/i18n.js; `i18n fit` still runs there,
//! and the names addons are `forge data names`.

use super::release::{checkout, opt, positional};
use super::{usage, Fail};
use forge_guide::i18n_files::read_locale_files;
use forge_guide::i18n_guides::{guide_state, pack_locales};
use forge_guide::js::{stringify, Obj, V};
use forge_guide::locales::{locale, LOCALE_CODES};
use forge_guide::obj;
use forge_i18n::project::{locale_state, sync_files, State};
use forge_i18n::{absolute, leaks, plural, rel, Addon, ADDONS};
use std::path::{Path, PathBuf};
use std::process::ExitCode;

pub fn usage_text() -> String {
	let scenes: Vec<&str> = leaks::SCENE_NAMES.to_vec();
	format!(
		"usage: forge i18n <status|check|sync|keys|import|leaks|guides> [options]

Polestar's interface translations (docs/TRANSLATING.md): one file per
locale, addon/Polestar/Locales/<locale>.lua, and the same for the Recorder,
addon/Polestar_Recorder/Locales/<locale>.lua. Locales: {}.
check and sync read both addons; status, keys and import read Polestar's
unless --addon names the other. (`i18n fit` still runs on node
tools/polestar.js; the names addons are forge data names.)

  i18n status                per locale: its language, status (reviewed or
                             ai), translators, and how many keys it
                             translates. --markdown prints a table for the
                             README and release notes.
  i18n check [<locale>...]   fails (exit 1) on a file Lua cannot load, a
                             stale key (one the code no longer has), a key
                             set twice, or a translation whose %s/%d/%1$s,
                             |4one:many; or |c/|r/|T escapes differ from the
                             English. Warns where a translation leaves out its
                             glossary's word (data/i18n/glossary). Missing
                             translations are fine: the English shows.
  i18n sync [<locale>...]    adds the keys the code gained to each file as
                             -- L[\"English\"] = \"\" lines under their file's
                             group, and moves translations of keys it lost to
                             a commented block at the end. Never rewrites a
                             translation. A locale named that has no file
                             gets one, loaded from Core/Core.xml (the
                             Recorder's TOC lists its own).
  i18n keys                  every interface key with where it is used.
  i18n import <locale> <file.lua>...
                             merges translations written apart (a file that
                             returns {{ [\"English\"] = \"translation\" }}, sets
                             L[\"English\"], or calls ns.AddTranslations) into
                             the locale's file: only into keys not translated
                             yet; a broken format is refused; keys the code
                             lacks go to the commented block at the end.
  i18n leaks [<locale>...]   runs the addon on the client stub in each locale
                             (or those named) with its shipped translations,
                             names pack and guide texts, the client's own
                             names as placeholders, through every scene (or
                             those --scene names), and lists the English left
                             on screen: a Latin word of 3+ letters in a text,
                             tooltip, chat line or menu that none of the
                             locale's own texts uses and
                             data/i18n/leaks-allow.json does not allow,
                             grouped by where it came from (an untranslated
                             interface string or guide text, a name missing
                             from the names pack, a name Polestar.Names was
                             not asked for, English in the code). Fails (exit
                             1) on any, or on a scene that errors. Scenes
                             (--scene; default all):
{}

  i18n guides sync [<locale>...]
                             writes a pack's texts in other languages
                             (docs/TRANSLATING.md, \"Guide texts\"):
                             <pack>/locales/<locale>/<guide path>.lua per
                             guide and _pack.lua for the pack's own texts,
                             each with every text that needs words, the
                             game's names as {{kind:id}} tokens, \"\" while not
                             translated. Keeps every translation; one whose
                             English the guide lost moves to a commented
                             block at the end. Without a locale: every
                             language the pack has a folder for.
  i18n guides check [<locale>...]
                             fails (exit 1) on a texts file Lua cannot load,
                             a translation that leaves out or adds a name
                             token or a line break, a stale translation (its
                             English changed or went away: the new English
                             is named when it can be told) or a file no
                             guide has. Missing translations are fine.
  i18n guides stats          the texts to translate: unique texts, words and
                             characters (tokens left out), in all and by
                             guide folder; the names the compiler made
                             tokens, by kind and source; the notes dropped
                             for naming only their goal.

options:
  --json            status, check, keys, leaks, guides: one JSON document on stdout
  --scene <a,b>     leaks: only these scenes
  --guide <id,...>  leaks: the guides the guide scene shows (default a few)
  --jobs <n>        leaks: runs at a time (default one per core)
  --update-baseline leaks: write data/i18n/leaks-baseline.json: add the
                    names no source has that the runs showed in English,
                    drop the entries that no longer show
  --pack <dir>      guides: the pack (default our guides/)
  --data <dir>      guides: the reference data (default data/forever)
  --markdown        status: a Markdown table
  --addon <name>    status, check, sync, keys, import: Polestar or
                    Polestar_Recorder only
  --root <dir>      the checkout (default: the one above here, else above the forge binary)",
		LOCALE_CODES.join(", "),
		wrap_words(&format!("{}.", scenes.join(", ")), 29)
	)
}

/// Words wrapped to 79 columns, every line indented `indent` spaces.
fn wrap_words(text: &str, indent: usize) -> String {
	let mut lines: Vec<String> = Vec::new();
	let mut line = String::new();
	for w in text.split(' ') {
		if !line.is_empty() && indent + line.len() + 1 + w.len() > 79 {
			lines.push(std::mem::replace(&mut line, w.to_string()));
		} else if line.is_empty() {
			line = w.to_string();
		} else {
			line = format!("{line} {w}");
		}
	}
	if !line.is_empty() {
		lines.push(line);
	}
	lines.iter().map(|l| format!("{}{l}", " ".repeat(indent))).collect::<Vec<_>>().join("\n")
}

const VALUES: [&str; 7] = ["--root", "--addon", "--pack", "--data", "--scene", "--guide", "--jobs"];
const FLAGS: [&str; 3] = ["--json", "--markdown", "--update-baseline"];

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	match run(&args) {
		Ok(0) => ExitCode::SUCCESS,
		Ok(code) => ExitCode::from(code),
		Err(e) => {
			super::exit("i18n", Err(e));
			ExitCode::FAILURE
		}
	}
}

struct Opts<'a> {
	args: &'a [String],
	root: PathBuf,
	json: bool,
}

impl Opts<'_> {
	fn opt(&self, k: &str) -> Option<String> {
		opt(self.args, k)
	}
	fn flag(&self, k: &str) -> bool {
		self.args.iter().any(|a| a == k)
	}
}

fn run(args: &[String]) -> Result<u8, Fail> {
	super::check_args(args, &VALUES, &FLAGS, usize::MAX).map_err(usage)?;
	for k in VALUES {
		if args.iter().any(|a| a == k) && opt(args, k).is_none_or(|v| v.is_empty()) {
			return Err(usage(format!("{k} needs a value")));
		}
	}
	let named = positional(args, &VALUES);
	let Some((sub, rest)) = named.split_first() else { return Err(usage("i18n needs a subcommand")) };
	if sub == "names" {
		return Err(usage("i18n names is forge data names [<locale>...] (docs/forge/data.md)"));
	}
	if sub == "fit" {
		return Err(usage(format!("i18n {sub} still runs on the JS tools: node tools/polestar.js i18n {sub}")));
	}
	let root = absolute(&checkout(opt(args, "--root"))?);
	let o = Opts { args, root, json: args.iter().any(|a| a == "--json") };
	match sub.as_str() {
		"status" => status(&o),
		"check" => check(&o, rest),
		"sync" => sync(&o, rest),
		"keys" => keys(&o),
		"import" => import(&o, rest),
		"leaks" => run_leaks(&o, rest),
		"guides" => guides(&o, rest),
		_ => Err(usage(format!("unknown i18n subcommand \"{sub}\""))),
	}
}

fn locales(positional: &[String]) -> Result<Vec<String>, Fail> {
	if positional.is_empty() {
		return Ok(LOCALE_CODES.iter().map(|l| l.to_string()).collect());
	}
	positional.iter().map(|l| if locale(l).is_some() { Ok(l.clone()) } else { Err(usage(format!("unknown locale \"{l}\": one of {}", LOCALE_CODES.join(", ")))) }).collect()
}

/// --addon <name> -> that addon; else every addon, or Polestar's alone for the commands that read one.
fn addons<'a>(o: &Opts, one: bool) -> Result<Vec<&'a Addon>, Fail> {
	if let Some(a) = o.opt("--addon") {
		return match ADDONS.iter().find(|x| x.name == a) {
			Some(x) => Ok(vec![x]),
			None => Err(usage(format!("unknown addon \"{a}\" ({})", ADDONS.iter().map(|x| x.name).collect::<Vec<_>>().join(", ")))),
		};
	}
	Ok(if one { vec![&ADDONS[0]] } else { ADDONS.iter().collect() })
}

fn addon_dir(o: &Opts, a: &Addon) -> PathBuf {
	o.root.join("addon").join(a.name)
}

fn json(v: V) {
	println!("{}", stringify(&v, Some(" ")));
}

fn arr(items: impl IntoIterator<Item = V>) -> V {
	V::from(items.into_iter().collect::<Vec<_>>())
}

fn strs<'a>(items: impl IntoIterator<Item = &'a String>) -> V {
	arr(items.into_iter().map(|s| V::from(s.as_str())))
}

/// `s` as a JSON string.
fn q(s: &str) -> String {
	leaks::quote(s)
}

fn status(o: &Opts) -> Result<u8, Fail> {
	let a = addons(o, true)?[0];
	let codes: Vec<String> = LOCALE_CODES.iter().map(|l| l.to_string()).collect();
	let st = locale_state(&o.root, &addon_dir(o, a), &codes, None)?;
	let total = st.keys.len();
	struct Row<'a> {
		locale: &'a str,
		language: &'a str,
		status: &'a str,
		translators: Vec<&'a str>,
		file: bool,
		translated: usize,
	}
	let rows: Vec<Row> = LOCALE_CODES
		.iter()
		.map(|l| {
			let s = st.locale(l).unwrap();
			let m = locale(l).unwrap();
			Row { locale: l, language: m.language, status: m.status, translators: m.translators.to_vec(), file: s.exists, translated: s.translated.len() }
		})
		.collect();
	if o.json {
		let list = rows.iter().map(|r| {
			V::Obj(obj! { "locale" => r.locale, "language" => r.language, "status" => r.status, "translators" => arr(r.translators.iter().map(|t| V::from(*t))), "file" => r.file, "translated" => r.translated, "keys" => total })
		});
		json(V::Obj(obj! { "keys" => total, "locales" => arr(list) }));
		return Ok(0);
	}
	let pct = |r: &Row| format!("{}%", (r.translated * 100).checked_div(total).unwrap_or(0));
	if o.flag("--markdown") {
		println!("| Language | Locale | Translated | Status | Translators |");
		println!("|---|---|---|---|---|");
		for r in &rows {
			let done = if r.file { format!("{}/{total} ({})", r.translated, pct(r)) } else { "not yet".into() };
			let who = if r.translators.is_empty() { "-".to_string() } else { r.translators.join(", ") };
			println!("| {} | {} | {done} | {} | {who} |", r.language, r.locale, if r.status == "ai" { "AI-made" } else { "reviewed" });
		}
		return Ok(0);
	}
	println!("{total} interface keys");
	for r in &rows {
		let done = if r.file { format!("{}/{total} ({})", r.translated, pct(r)) } else { "no file yet".into() };
		println!("{}  {:<24}{done:<18}{:<10}{}", r.locale, r.language, r.status, r.translators.join(", "));
	}
	Ok(0)
}

/// Locales/<x>.lua files that are not one of LOCALES.
fn stray_files(dir: &Path) -> Vec<PathBuf> {
	let Ok(rd) = std::fs::read_dir(dir.join("Locales")) else { return Vec::new() };
	let mut out: Vec<PathBuf> = rd
		.flatten()
		.map(|e| e.file_name().to_string_lossy().into_owned())
		.filter(|f| f.ends_with(".lua") && locale(f.trim_end_matches(".lua")).is_none())
		.map(|f| dir.join("Locales").join(f))
		.collect();
	out.sort();
	out
}

fn check(o: &Opts, positional: &[String]) -> Result<u8, Fail> {
	let list = locales(positional)?;
	let report_addons = Obj::new();
	let mut first: Option<(usize, Obj)> = None;
	let mut failures = 0usize;
	let mut fail = |msg: String| {
		failures += 1;
		if !o.json {
			eprintln!("error: {msg}");
		}
	};
	let all = addons(o, false)?;
	for a in &all {
		let dir = addon_dir(o, a);
		let st = locale_state(&o.root, &dir, &list, None)?;
		let part_locales = Obj::new();
		report_addons.set(a.name, obj! { "keys" => st.keys.len(), "locales" => part_locales.clone() });
		if first.is_none() {
			first = Some((st.keys.len(), part_locales.clone()));
		}
		if all.len() > 1 && !o.json {
			println!("{}:", a.name);
		}
		if positional.is_empty() {
			for f in stray_files(&dir) {
				fail(format!("{}: not a locale Polestar ships (LOCALES in rust/crates/forge-guide/src/locales.rs)", rel(&f)));
			}
		}
		for (l, s) in &st.locales {
			let file = rel(&s.file);
			let r = obj! {
				"file" => file.as_str(),
				"exists" => s.exists,
				"translated" => s.translated.len(),
				"missing" => s.missing.len(),
				"stale" => arr(s.stale.iter().map(|(k, _)| V::from(k.as_str()))),
				"problems" => arr(s.problems.iter().map(|(k, p)| V::Obj(obj! { "key" => k.as_str(), "problem" => p.as_str() }))),
				"warnings" => arr(s.warnings.iter().map(|w| V::Obj(obj! { "key" => w.key.as_str(), "value" => w.value.as_str(), "id" => w.id.as_str(), "term" => w.term.as_str() }))),
				"error" => s.error.as_deref().map_or(V::Null, V::from)
			};
			part_locales.set(l, r);
			if !s.exists {
				if !o.json {
					println!("{l}: no file yet (`forge i18n sync {l}` starts one)");
				}
				continue;
			}
			if let Some(e) = &s.error {
				fail(format!("{file}: {e}"));
			}
			for (k, _) in &s.stale {
				fail(format!("{file}: stale key {} (not in the code; `i18n sync {l}` moves it to the end as a comment)", q(k)));
			}
			for (k, p) in &s.problems {
				fail(format!("{file}: {}: {p}", q(k)));
			}
			if !o.json {
				for w in &s.warnings {
					eprintln!("warning: {file}: {} = {}: the glossary says \"{}\" for {}", q(&w.key), q(&w.value), w.term, w.id);
				}
				let stale = if s.stale.is_empty() { String::new() } else { format!(", {} stale", s.stale.len()) };
				let warn = if s.warnings.is_empty() { String::new() } else { format!(", {}", plural(s.warnings.len(), "glossary warning")) };
				println!("{l}: {}/{} translated, {} missing{stale}{warn}", s.translated.len(), st.keys.len(), s.missing.len());
			}
		}
	}
	if o.json {
		let (keys, locs) = first.unwrap_or_default();
		json(V::Obj(obj! { "ok" => failures == 0, "keys" => keys, "locales" => locs, "addons" => report_addons }));
	}
	if failures > 0 {
		return Err(Fail::Run(format!("check failed: {}", plural(failures, "problem"))));
	}
	Ok(0)
}

/// The Core/Core.xml line that loads a locale file, added after the last one.
fn load_in_core_xml(o: &Opts, locale: &str) -> Result<bool, String> {
	let xml = o.root.join("addon/Polestar/Core/Core.xml");
	let text = std::fs::read_to_string(&xml).map_err(|e| format!("{}: {e}", xml.display()))?;
	let line = format!("\t<Script file=\"..\\Locales\\{locale}.lua\"/>");
	if text.contains(&line) {
		return Ok(false);
	}
	let mut lines: Vec<String> = text.split('\n').map(String::from).collect();
	let at = lines.iter().rposition(|l| l.contains("file=\"..\\Locales\\")).or_else(|| lines.iter().position(|l| l.contains("file=\"Init.lua\"")));
	let at = at.map_or(0, |i| i + 1);
	lines.insert(at, line);
	std::fs::write(&xml, lines.join("\n")).map_err(|e| format!("{}: {e}", xml.display()))?;
	Ok(true)
}

/// Writes the files that changed. A new Polestar locale file is loaded from Core/Core.xml; another
/// addon's TOC lists its files. -> how many were written.
fn write_sync(o: &Opts, files: &[(PathBuf, String)]) -> Result<usize, String> {
	let own = o.root.join("addon/Polestar/Locales");
	let mut written = 0;
	for (file, text) in files {
		if std::fs::read_to_string(file).is_ok_and(|t| t == *text) {
			continue;
		}
		let dir = file.parent().unwrap_or(Path::new("."));
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		let created = !file.exists();
		std::fs::write(file, text).map_err(|e| format!("{}: {e}", file.display()))?;
		let mine = dir == own;
		let stem = file.file_stem().map(|s| s.to_string_lossy().into_owned()).unwrap_or_default();
		if created && mine && load_in_core_xml(o, &stem)? {
			println!("Core/Core.xml loads {}", rel(file));
		}
		if created && !mine {
			println!("{} is new: list it in its addon's TOC", rel(file));
		}
		written += 1;
	}
	Ok(written)
}

fn sync(o: &Opts, positional: &[String]) -> Result<u8, Fail> {
	let mut code = 0;
	let mut files = Vec::new();
	for a in addons(o, false)? {
		let dir = addon_dir(o, a);
		let list = if positional.is_empty() { LOCALE_CODES.iter().filter(|l| dir.join("Locales").join(format!("{l}.lua")).exists()).map(|l| l.to_string()).collect() } else { locales(positional)? };
		let st = locale_state(&o.root, &dir, &list, None)?;
		for (l, s) in &st.locales {
			if let Some(e) = &s.error {
				eprintln!("error: {}: {e}; fix it first (nothing written for {l})", rel(&s.file));
				code = 1;
			}
		}
		let create = if positional.is_empty() { Vec::new() } else { list.clone() };
		files.extend(sync_files(&st, &create, &[], &[], a.title)?);
	}
	for (file, r) in &files {
		let mut parts = Vec::new();
		if !r.added.is_empty() {
			parts.push(format!("{} added", plural(r.added.len(), "key")));
		}
		if !r.retired.is_empty() {
			parts.push(format!("{} of keys the code lost moved to the end", plural(r.retired.len(), "translation")));
		}
		if !r.dropped.is_empty() {
			parts.push(format!("{} the code lost removed", plural(r.dropped.len(), "untranslated key")));
		}
		if !parts.is_empty() {
			println!("{}: {}", rel(file), parts.join(", "));
		}
	}
	let texts: Vec<(PathBuf, String)> = files.into_iter().map(|(f, r)| (f, r.text)).collect();
	println!("{} written", plural(write_sync(o, &texts)?, "file"));
	if code != 0 {
		return Err(Fail::Run("a locale file Lua cannot load was left as it is".into()));
	}
	Ok(0)
}

fn keys(o: &Opts) -> Result<u8, Fail> {
	let a = addons(o, true)?[0];
	let keys = forge_i18n::keys::extract_keys(&o.root, &addon_dir(o, a))?;
	let place = |w: &forge_i18n::keys::Use| if w.data { format!("{} (data)", w.file) } else { format!("{}:{}", w.file, w.line) };
	if o.json {
		let out = Obj::new();
		for (k, w) in &keys.list {
			out.set(k, arr(w.iter().map(|x| V::from(place(x)))));
		}
		json(V::Obj(out));
		return Ok(0);
	}
	for (k, w) in &keys.list {
		println!("{}\t{}", q(k), w.iter().map(place).collect::<Vec<_>>().join(", "));
	}
	println!("{} keys", keys.len());
	Ok(0)
}

fn import(o: &Opts, positional: &[String]) -> Result<u8, Fail> {
	let Some((l, files)) = positional.split_first().filter(|(_, f)| !f.is_empty()) else { return Err(usage("import needs <locale> <file.lua>...")) };
	locales(std::slice::from_ref(l))?;
	let a = addons(o, true)?[0];
	let st: State = locale_state(&o.root, &addon_dir(o, a), std::slice::from_ref(l), None)?;
	let s = st.locale(l).unwrap();
	if let Some(e) = &s.error {
		return Err(Fail::Run(format!("{}: {e}", rel(&s.file))));
	}
	let (fill, retire) = (Obj::new(), Obj::new());
	let mut bad = 0;
	let entries: Vec<(String, String)> = files.iter().map(|f| (absolute(Path::new(f)).to_string_lossy().into_owned(), l.clone())).collect();
	for r in read_locale_files(&entries)? {
		let shown = rel(Path::new(&r.file));
		if !r.ok {
			eprintln!("error: {shown}: {}", r.error.unwrap_or_default());
			bad += 1;
			continue;
		}
		for (k, v) in r.strings.entries() {
			let v = v.to_js_string();
			if v.is_empty() {
				continue;
			}
			if !st.keys.has(&k) {
				retire.set(&k, v);
				continue;
			}
			let problems = forge_i18n::format::format_problems(&k, &v);
			if !problems.is_empty() {
				eprintln!("error: {shown}: {}: {}", q(&k), problems.join("; "));
				bad += 1;
				continue;
			}
			fill.set(&k, v);
		}
	}
	let out = sync_files(&st, std::slice::from_ref(l), &[(l.clone(), V::Obj(fill))], &[(l.clone(), V::Obj(retire))], a.title)?;
	let texts: Vec<(PathBuf, String)> = out.iter().map(|(f, r)| (f.clone(), r.text.clone())).collect();
	write_sync(o, &texts)?;
	let r = &out.iter().find(|(f, _)| *f == s.file).ok_or("nothing to write")?.1;
	let kept = if r.kept.is_empty() { String::new() } else { format!(", {} kept as translated before", plural(r.kept.len(), "key")) };
	let retired = if r.retired.is_empty() { String::new() } else { format!(", {} the code lacks put in the block at the end", plural(r.retired.len(), "key")) };
	let problems = if bad > 0 { format!(", {}", plural(bad, "problem")) } else { String::new() };
	println!("{l}: {} imported into {}{kept}{retired}{problems}", plural(r.filled.len(), "translation"), rel(&s.file));
	if bad > 0 {
		return Err(Fail::Run(format!("{} refused", plural(bad, "problem"))));
	}
	Ok(0)
}

// ------------------------------------------------------------ leaks

fn split_list(v: Option<String>) -> Vec<String> {
	v.map(|s| s.split(',').map(|x| x.trim().to_string()).filter(|x| !x.is_empty()).collect()).unwrap_or_default()
}

fn run_leaks(o: &Opts, positional: &[String]) -> Result<u8, Fail> {
	let chosen = locales(positional)?;
	let scene_names: Vec<String> = match o.opt("--scene") {
		Some(s) => split_list(Some(s)),
		None => leaks::SCENE_NAMES.iter().map(|s| s.to_string()).collect(),
	};
	let guides = split_list(o.opt("--guide"));
	let jobs = match o.opt("--jobs") {
		None => None,
		Some(j) => match j.parse::<usize>() {
			Ok(n) if n >= 1 => Some(n),
			_ => return Err(usage(format!("--jobs {j}: a number of 1 or more"))),
		},
	};
	let scenes: Vec<leaks::Scene> = scene_names.iter().map(|n| leaks::scene(&o.root, n, &guides)).collect::<Result<_, _>>().map_err(usage)?;
	let quiet = o.json;
	let results = leaks::find_leaks(&o.root, &chosen, &scenes, jobs, &mut |r| {
		if !quiet {
			eprintln!("{}", leaks::run_line(r));
		}
	})?;
	let mut errors: Vec<V> = Vec::new();
	for r in &results {
		for e in leaks::run_errors(r) {
			let x = obj! { "locale" => r.get("locale"), "scene" => r.get("scene") };
			for (k, v) in e.entries() {
				x.set_str(k, v);
			}
			errors.push(V::Obj(x));
		}
	}
	let baseline = leaks::load_baseline(&o.root)?;
	let file = leaks::baseline_file(&o.root);
	if o.flag("--update-baseline") {
		if !errors.is_empty() {
			return Err(Fail::Run(format!("{}: fix them before the baseline is written", plural(errors.len(), "scene error"))));
		}
		let mut reason = leaks::baseline_reason(&o.root);
		let next = leaks::updated_baseline(&results, &baseline, &mut reason);
		std::fs::write(&file, leaks::baseline_text(&next)).map_err(|e| format!("{}: {e}", file.display()))?;
		let left: usize = results.iter().map(|r| leaks::run_leaks(r).iter().filter(|l| l.get("names").is_empty() && !l.get("textKey").truthy()).count()).sum();
		println!(
			"{}: {} -> {} names; {} it cannot take (not a missing name: fix the code or translation)",
			rel(&file),
			leaks::baseline_count(&baseline),
			leaks::baseline_count(&next),
			plural(left, "English text")
		);
		return Ok(if left > 0 { 1 } else { 0 });
	}
	let count: usize = results.iter().map(leaks::leak_count).sum();
	let stale = leaks::stale_baseline(&results, &baseline);
	let groups = leaks::group_by_source(&results);
	let failed = count > 0 || !errors.is_empty() || !stale.is_empty();
	if o.json {
		let runs = results.iter().map(|r| {
			let x = obj! { "locale" => r.get("locale"), "scene" => r.get("scene") };
			if r.get("skipped").truthy() {
				x.set("skipped", r.get("skipped"));
			}
			if !r.get("texts").is_undef() {
				x.set("texts", r.get("texts"));
			}
			if r.get("leaks").is_arr() {
				x.set("leaks", leaks::leak_count(r));
			}
			if r.get("baselined").is_arr() {
				x.set("baselined", r.get("baselined").len());
			}
			V::Obj(x)
		});
		let stale_v = stale.iter().map(|(l, k, e)| V::Obj(obj! { "locale" => l.as_str(), "name" => k.as_str(), "scenes" => e.get("scenes") }));
		let groups_v = groups.iter().map(|g| {
			let entries = g.entries.iter().map(|(w, e)| {
				let locs = Obj::new();
				for (l, t) in &e.locales {
					locs.set(l, t.as_str());
				}
				V::Obj(obj! { "words" => w.as_str(), "locales" => locs, "scenes" => strs(&e.scenes), "sites" => strs(&e.sites) })
			});
			V::Obj(obj! { "source" => g.source.clone(), "label" => g.key.as_str(), "entries" => arr(entries) })
		});
		json(V::Obj(obj! { "ok" => !failed, "runs" => arr(runs), "errors" => V::from(errors), "stale" => arr(stale_v), "groups" => arr(groups_v) }));
		return Ok(if failed { 1 } else { 0 });
	}
	for e in &errors {
		let (scene, error) = (e.get("scene").to_js_string(), e.get("error").to_js_string());
		let prefix = if scene == error { String::new() } else { format!("{scene}: ") };
		println!("error: {} {scene}: {prefix}{}", e.get("locale").to_js_string(), error.split('\n').next().unwrap_or(""));
	}
	for (l, k, e) in &stale {
		let scenes: Vec<String> = e.get("scenes").items().iter().map(|x| x.to_js_string()).collect();
		println!("stale: {}: {l} {k} no longer shows in English ({}): remove it, or run with --update-baseline", rel(&file), scenes.join(", "));
	}
	for g in &groups {
		println!("\n{} ({})", g.key, plural(g.entries.len(), "text"));
		for (words, e) in &g.entries {
			let (l, text) = &e.locales[0];
			println!("  {words}  [{}]", e.locales.iter().map(|(x, _)| x.as_str()).collect::<Vec<_>>().join(" "));
			println!("    {l}: {}", leaks::example(text));
			let more = if e.scenes.len() > 1 { format!(" and {} more", e.scenes.len() - 1) } else { String::new() };
			println!("    in {}{more}; set at {}", e.scenes[0], e.sites.first().map_or("?", |s| s.as_str()));
		}
	}
	let ran = results.iter().filter(|r| !r.get("skipped").truthy()).count();
	let what = if count > 0 { format!("{} from {}", plural(count, "English text"), plural(groups.len(), "source")) } else { "no English left".into() };
	let errs = if errors.is_empty() { String::new() } else { format!(", {}", plural(errors.len(), "scene error")) };
	let st = if stale.is_empty() { String::new() } else { format!(", {}", plural(stale.len(), "stale baseline name")) };
	println!("\n{ran} of {} ({}, {}): {what}{errs}{st}", plural(results.len(), "run"), plural(chosen.len(), "locale"), plural(scenes.len(), "scene"));
	Ok(if failed { 1 } else { 0 })
}

// ------------------------------------------------------------ guide texts

struct Pack {
	dir: PathBuf,
	manifest: V,
	guides: Vec<V>,
	tokens: V,
}

/// The pack (--pack, else the nearest pack.json above here, else our guides/) compiled in memory, with
/// its tokenised texts.
fn pack_guides(o: &Opts) -> Result<Pack, Fail> {
	use forge_guide::project::{compile_project, find_pack_dir, load_project_data, no_reference_data, same_path};
	let cwd = std::env::current_dir().unwrap_or_default();
	let official = o.root.join("guides");
	let dir = match o.opt("--pack") {
		Some(p) => absolute(Path::new(&p)),
		None => find_pack_dir(&cwd).unwrap_or_else(|| official.clone()),
	};
	let (manifest, _) = forge_guide::manifest::read_manifest(&dir, same_path(&dir, &official));
	let Some(manifest) = manifest.filter(V::truthy) else { return Err(Fail::Run(format!("{}: no valid pack.json", dir.display()))) };
	let data_dir = o.opt("--data").map_or_else(|| o.root.join("data/forever"), |d| absolute(Path::new(&d)));
	if no_reference_data(&data_dir, None, false).is_some() {
		return Err(Fail::Run("no reference data: run `forge data build` (or pass --data)".into()));
	}
	let mut diag = forge_guide::diag::Diagnostics::new();
	let data = load_project_data(&data_dir, &mut diag)?;
	let project = compile_project(&dir, &manifest, &data, diag, false, None);
	let errors = project.diag.errors().len();
	if errors > 0 {
		return Err(Fail::Run(format!("the pack does not compile ({}): run `forge guide lint`", plural(errors, "error"))));
	}
	let guides = project.guides.into_iter().filter(|g| g.hidden("_ast").get("source").truthy()).collect();
	Ok(Pack { dir, manifest, guides, tokens: project.tokens })
}

fn guides(o: &Opts, positional: &[String]) -> Result<u8, Fail> {
	let Some((what, rest)) = positional.split_first().filter(|(w, _)| ["sync", "check", "stats"].contains(&w.as_str())) else {
		return Err(usage("i18n guides needs sync, check or stats"));
	};
	let pack = pack_guides(o)?;
	if what == "stats" {
		let (total, by_folder) = forge_i18n::guides::text_stats(&pack.manifest, &pack.guides);
		if o.json {
			let folders = Obj::new();
			for (f, c) in &by_folder {
				folders.set(f, obj! { "guides" => c.guides, "texts" => c.texts, "words" => c.words, "chars" => c.chars });
			}
			json(V::Obj(obj! { "total" => obj! { "texts" => total.texts, "words" => total.words, "chars" => total.chars }, "byFolder" => folders, "tokens" => pack.tokens.clone() }));
			return Ok(0);
		}
		let row = |name: &str, guides: String, c: &forge_i18n::guides::Counts| format!("{name:<34}{guides:>7}{:>8}{:>9}{:>10}", c.texts, c.words, c.chars);
		println!("{:<34}{:>7}{:>8}{:>9}{:>10}", "folder", "guides", "texts", "words", "chars");
		let mut sorted = by_folder.clone();
		sorted.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.0, &b.0));
		for (f, c) in &sorted {
			println!("{}", row(f, c.guides.to_string(), c));
		}
		println!("{}", row("all (each text once)", pack.guides.len().to_string(), &total));
		let t = &pack.tokens;
		let replaced = t.get("replaced");
		let sum: f64 = replaced.values().iter().map(V::num).sum();
		let kinds: Vec<String> = replaced.entries().iter().filter(|(_, n)| n.truthy()).map(|(k, n)| format!("{k} {}", n.to_js_string())).collect();
		println!("\nnames made tokens: {} ({})", V::from(sum).to_js_string(), kinds.join(", "));
		let by: Vec<String> = t.get("bySource").entries().iter().map(|(k, n)| format!("{k} {}", n.to_js_string())).collect();
		println!("  by source: {}", by.join(", "));
		println!("notes dropped for naming only their goal: {}", t.get("dropped").to_js_string());
		return Ok(0);
	}
	let dir = pack.dir.to_string_lossy().into_owned();
	let chosen = if rest.is_empty() { pack_locales(&dir) } else { locales(rest)? };
	if chosen.is_empty() {
		println!("{}: no languages yet (`forge i18n guides sync <locale>` starts one)", rel(&pack.dir.join("locales")));
		return Ok(0);
	}
	let st = guide_state(&dir, &pack.manifest, &pack.guides, &chosen)?;
	if what == "sync" {
		let mut code = 0;
		for (_, l) in &st {
			for s in &l.files {
				if let Some(e) = &s.error {
					eprintln!("error: {}: {e}; fix it first (left as it is)", rel(Path::new(&s.file)));
					code = 1;
				}
			}
			for f in &l.orphans {
				println!("note: {}: no guide has this path (left alone: rename it after its guide, or delete it)", rel(Path::new(f)));
			}
		}
		let mut written = 0;
		for (file, text) in forge_i18n::guides::sync_files(&st) {
			if std::fs::read_to_string(&file).is_ok_and(|t| t == text) {
				continue;
			}
			if let Some(p) = Path::new(&file).parent() {
				std::fs::create_dir_all(p).map_err(|e| format!("{}: {e}", p.display()))?;
			}
			std::fs::write(&file, text).map_err(|e| format!("{file}: {e}"))?;
			written += 1;
		}
		for (l, ls) in &st {
			let texts: usize = ls.files.iter().map(|s| s.texts.len()).sum();
			let done: usize = ls.files.iter().map(|s| s.translated.keys().len()).sum();
			println!("{l}: {done}/{texts} texts translated");
		}
		println!("{} written", plural(written, "file"));
		if code != 0 {
			return Err(Fail::Run("a texts file Lua cannot load was left as it is".into()));
		}
		return Ok(0);
	}
	let report = Obj::new();
	let mut failures = 0;
	let mut fail = |msg: String| {
		failures += 1;
		if !o.json {
			eprintln!("error: {msg}");
		}
	};
	for (l, ls) in &st {
		let (mut texts, mut translated, mut missing, mut stale, mut problems) = (0, 0, 0, 0, 0);
		let orphans: Vec<String> = ls.orphans.iter().map(|f| rel(Path::new(f))).collect();
		let files = ls.files.iter().filter(|s| s.exists).count();
		for s in &ls.files {
			texts += s.texts.len();
			translated += s.translated.keys().len();
			missing += s.missing.len();
			if !s.exists {
				continue;
			}
			let file = rel(Path::new(&s.file));
			if let Some(e) = &s.error {
				fail(format!("{file}: {e}"));
			}
			for (t, p) in &s.problems {
				problems += 1;
				fail(format!("{file}: {}: the translation {p}", q(t)));
			}
			for k in s.stale.keys() {
				stale += 1;
				let next = s.successors.get(&k);
				let why = match next.as_str() {
					Some(n) => format!("its English is now {}", q(n)),
					None => "the guide no longer has it".into(),
				};
				fail(format!("{file}: stale translation of {} ({why}; `i18n guides sync {l}` moves it to the end)", q(&k)));
			}
		}
		for f in &orphans {
			fail(format!("{f}: no guide has this path"));
		}
		report.set(l, obj! { "texts" => texts, "translated" => translated, "missing" => missing, "stale" => stale, "problems" => problems, "orphans" => strs(&orphans), "files" => files });
		if !o.json {
			let st = if stale > 0 { format!(", {stale} stale") } else { String::new() };
			println!("{l}: {translated}/{texts} texts translated in {}, {missing} missing{st}", plural(files, "file"));
		}
	}
	if o.json {
		json(V::Obj(obj! { "ok" => failures == 0, "locales" => report }));
	}
	Ok(if failures > 0 { 1 } else { 0 })
}
