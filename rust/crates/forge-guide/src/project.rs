//! Port of tools/lib/dsl/project.js (compileSources, localise, buildPackFiles, racePart, readLegs, readRetired,
//! findGuideFiles, compileProject), tools/lib/pack/build.js (buildPack) and the parts of tools/lib/pack/locate.js
//! the compile and lint commands use. The in-memory core ([`compile_sources`], [`build_pack_files`]) takes
//! strings; reading folders is native only.

use crate::data::Data;
use crate::diag::Diagnostics;
use crate::js::{Obj, V};
use crate::obj;

/// One `.guide` source: `file` names it in diagnostics, `source` in the emitted comment.
#[derive(Clone, Debug)]
pub struct Source {
	pub source: String,
	pub file: String,
	pub text: String,
}

/// Our guides read as context for another pack.
pub struct Context<'a> {
	pub sources: Vec<Source>,
	pub data: &'a Data,
}

pub struct CompileOpts<'a> {
	/// The pack id the guides belong to (None: ours, and pack ownership is not checked).
	pub pack: Option<String>,
	pub author: Option<String>,
	pub context: Option<Context<'a>>,
	/// The pack folder pictures are looked up in (native).
	pub pack_dir: Option<std::path::PathBuf>,
}

pub struct Compiled {
	pub guides: Vec<V>,
	pub tokens: V,
}

/// resolveSources: parse and resolve sources into guides of `pack`.
pub fn resolve_sources(sources: &[Source], data: &Data, diag: &mut Diagnostics, pack: Option<&str>, author: Option<&str>) -> Vec<V> {
	let mut guides = Vec::new();
	for s in sources {
		let ast = crate::parse::parse_guide(&s.text, &s.file, diag);
		if !ast.truthy() || !ast.get("id").truthy() {
			continue;
		}
		ast.set("source", if s.source.is_empty() { s.file.as_str() } else { s.source.as_str() });
		guides.push(crate::resolve::resolve_guide(&ast, data, diag, pack, author));
	}
	guides
}

/// compileSources: parse, resolve and validate in-memory sources.
pub fn compile_sources(sources: &[Source], data: &Data, diag: &mut Diagnostics, opts: &CompileOpts) -> Compiled {
	let mut lap = Lap::new();
	let guides = resolve_sources(sources, data, diag, opts.pack.as_deref(), opts.author.as_deref());
	#[cfg(feature = "native")]
	if let Some(dir) = &opts.pack_dir {
		crate::images::check_images(&guides, dir, diag);
	}
	if opts.pack.is_some() {
		for g in &guides {
			let pack = g.get("pack").to_js_string();
			let id = g.get("id").to_js_string();
			if crate::format::owns_guide_id(&pack, &id) {
				continue;
			}
			let prefix = if pack == "guides" { "\"forever/\" or \"draft/\"".to_string() } else { format!("\"{pack}/\"") };
			let ast = g.hidden("_ast");
			let line = if ast.get("lines").get("guide").truthy() { ast.get("lines").get("guide") } else { ast.get("line") };
			diag.error(
				&ast.get("file").to_js_string(),
				line.num(),
				format!("guide id \"{id}\" is outside pack \"{pack}\": its guide ids start with {prefix}"),
				Some(format!("start the id with `{}/`", if pack == "guides" { "forever" } else { &pack })),
			);
		}
	}
	lap.at("parse+resolve");
	let Some(ctx) = &opts.context else {
		crate::validate::validate_guides(&guides, data, diag);
		lap.at("validate");
		let tokens = localise(&guides, data, diag);
		lap.at("tokens");
		return Compiled { guides, tokens };
	};
	let ours = resolve_sources(&ctx.sources, ctx.data, &mut Diagnostics::new(), Some("guides"), None);
	let our_files: rustc_hash::FxHashSet<&str> = ctx.sources.iter().map(|s| s.file.as_str()).collect();
	let mut all = Diagnostics::new();
	let both: Vec<V> = ours.iter().chain(guides.iter()).cloned().collect();
	crate::validate::validate_guides(&both, data, &mut all);
	for d in all.list {
		if !our_files.contains(d.file.as_deref().unwrap_or("")) {
			diag.list.push(d);
		}
	}
	crate::validate::validate_pack_frames(&guides, data, &ours, ctx.data, diag);
	let tokens = localise(&guides, data, diag);
	Compiled { guides, tokens }
}

/// Phase timings on stderr when POLESTAR_TIME is set (native).
struct Lap(Option<std::time::Instant>);
impl Lap {
	fn new() -> Lap {
		#[cfg(feature = "native")]
		if std::env::var_os("POLESTAR_TIME").is_some() {
			return Lap(Some(std::time::Instant::now()));
		}
		Lap(None)
	}
	fn at(&mut self, what: &str) {
		if let Some(t) = self.0 {
			eprintln!("time: {what} {:?}", t.elapsed());
			self.0 = Some(std::time::Instant::now());
		}
	}
}

/// Lint in memory (the planner's and wasm's entry point): every compile check on `sources`, plus the solo
/// policy against `excluded` (validate_solo_policy's `{ <Faction>: { <quest id>: entry } }`, or an empty
/// object). -> the diagnostics, sorted as the CLI prints them.
pub fn lint_sources(sources: &[Source], data: &Data, excluded: &V) -> Vec<crate::diag::Diag> {
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: None, author: None, context: None, pack_dir: None };
	let c = compile_sources(sources, data, &mut diag, &opts);
	crate::validate::validate_solo_policy(&c.guides, excluded, &mut diag);
	diag.sorted()
}

/// localise: gives each guide `_localised` (its prose with name tokens); -> tokens.js's stats.
pub fn localise(guides: &[V], data: &Data, diag: &mut Diagnostics) -> V {
	let r = crate::tokens::tokenise_guides(guides, data);
	let loc = r.get("guides");
	for (i, g) in guides.iter().enumerate() {
		g.set_hidden("_localised", loc.at(i));
	}
	for p in r.get("problems").items() {
		diag.error(
			&p.get("guide").hidden("_ast").get("file").to_js_string(),
			p.get("line").num(),
			p.get("message").to_js_string(),
			Some("write a name token as {kind:id}, kind one of npc object item quest zone area spell faction skill, with an id the data has".into()),
		);
	}
	r.get("stats")
}

/// The id rule of retired.json entries: `^[a-z0-9_-]+(?:\/[a-z0-9_-]+)*$`.
fn is_guide_id(s: &str) -> bool {
	!s.is_empty() && s.split('/').all(|p| !p.is_empty() && p.bytes().all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_' || b == b'-'))
}

/// readRetired on retired.json's text (None: no file). `file` names it in diagnostics.
pub fn read_retired_text(text: Option<&str>, file: &str, guides: &[V], diag: &mut Diagnostics) -> Vec<String> {
	let Some(text) = text else { return Vec::new() };
	let list = match crate::js::parse_json(text) {
		Ok(v) => v,
		Err(e) => {
			diag.error(file, 1.0, format!("retired.json is not JSON: {e}"), None);
			return Vec::new();
		}
	};
	if !list.is_arr() || !list.items().iter().all(|id| id.as_str().is_some_and(is_guide_id)) {
		diag.error(file, 1.0, "retired.json must be a list of guide ids", Some("write [\"forever/horde/02-the-barrens\", ...]".into()));
		return Vec::new();
	}
	let live: rustc_hash::FxHashSet<String> = guides.iter().map(|g| g.get("id").to_js_string()).collect();
	let ids: Vec<String> = list.items().iter().map(|v| v.to_js_string()).collect();
	for id in &ids {
		if live.contains(id) {
			diag.warn(file, 1.0, format!("retired guide id \"{id}\" is still a guide of the pack: Polestar keeps opening it"), None);
		}
	}
	let mut out: Vec<String> = Vec::new();
	for id in ids {
		if !out.contains(&id) {
			out.push(id);
		}
	}
	out.sort_by(|a, b| crate::js::cmp_utf16(a, b));
	out
}

/// readLegs on legs.json's text (None: no file): a leveling guide (legs_races) whose leg ends still
/// hash as when it was baked gets its legs hidden as `_legs` (step -> string) and `_legsGrid`, for
/// build_pack_files to write into the race parts' Legs.lua.
pub fn read_legs_text(text: Option<&str>, file: &str, guides: &[V], data: &Data, diag: &mut Diagnostics) {
	let Some(text) = text else { return };
	let doc = match crate::js::parse_json(text) {
		Ok(v) => v,
		Err(e) => {
			diag.error(file, 1.0, format!("legs.json is not JSON: {e}"), None);
			return;
		}
	};
	if !doc.truthy() || doc.get("schema").as_num() != Some(1.0) || !(doc.get("legs").is_object() || matches!(doc.get("legs"), V::Null)) || !doc.get("grid").is_str() {
		diag.error(file, 1.0, "legs.json is not a legs file of schema 1 (forge guide bake)", None);
		return;
	}
	let legs = doc.get("legs");
	let mut stale = 0;
	for g in guides {
		let entry = legs.get(&g.get("id").to_js_string());
		if !entry.truthy() || legs_races(g).is_none() {
			continue;
		}
		if !entry.get("hash").strict_eq(&V::from(crate::bake::guide_hash(g, &data.map_frames))) {
			stale += 1;
			continue;
		}
		let steps = Obj::new();
		let gsteps = g.get("steps");
		for (s, st) in entry.get("steps").entries() {
			let ok = st.as_str().is_some_and(|x| !x.is_empty() && x.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'+' || b == b'/'));
			let n = crate::js::str_to_num(&s);
			if ok && crate::js::is_integer(n) && n >= 1.0 && gsteps.at(n as usize - 1).truthy() {
				steps.set_str(s, st);
			}
		}
		if !steps.is_empty() {
			g.set_hidden("_legs", steps);
			g.set_hidden("_legsGrid", doc.get("grid"));
		}
	}
	if stale > 0 {
		diag.warn(file, 1.0, format!("{stale} guide(s) changed since their legs were baked: they go without until `forge guide bake` runs again"), None);
	}
}

/// The race parts a leveling guide's baked legs ship in: its own race part's races (race_part),
/// else the races its `race` header names, else every race of its faction; None for any other
/// guide (not leveling, or no faction).
pub fn legs_races(g: &V) -> Option<Vec<String>> {
	let cat = g.get("category");
	if !cat.is_nullish() && cat.as_str() != Some("Leveling") {
		return None;
	}
	if let Some(own) = race_part(g) {
		return Some(own);
	}
	let named: Vec<String> = g.get("races").items().iter().filter_map(|r| r.as_str().filter(|s| crate::races::RACE_FILES.contains(s)).map(str::to_string)).collect();
	if !named.is_empty() {
		return Some(named);
	}
	let faction = g.get("faction");
	let side = faction.as_str().filter(|f| *f == "Alliance" || *f == "Horde")?;
	Some(crate::races::RACE_FILES.iter().filter(|r| crate::races::race_by_file_ref(r).is_some_and(|x| x.sides.iter().any(|s| s.0 == side))).map(|r| r.to_string()).collect())
}

/// The races a guide's own addon part is for (a Leveling guide with `class` and `race` headers), or None.
pub fn race_part(g: &V) -> Option<Vec<String>> {
	let cat = g.get("category");
	if !cat.is_nullish() && cat.as_str() != Some("Leveling") {
		return None;
	}
	let (classes, races) = (g.get("classes"), g.get("races"));
	if !classes.is_arr() || classes.is_empty() || !races.is_arr() || races.is_empty() {
		return None;
	}
	let r: Vec<String> = races.items().iter().filter_map(|r| r.as_str().filter(|s| crate::races::RACE_FILES.contains(s)).map(str::to_string)).collect();
	if r.is_empty() {
		None
	} else {
		Some(r)
	}
}

pub fn part_addon(folder: &str, race: &str) -> String {
	format!("{folder}_{race}")
}

/// The factions of Polestar's own pack's faction parts (`<folder>_<faction>`, format 8).
pub const FACTION_PARTS: [&str; 2] = ["Alliance", "Horde"];

/// The faction part a guide of Polestar's own pack ships in: its faction's, unless a race part holds it
/// or it has none (those stay in Guides.lua).
pub fn faction_part(g: &V) -> Option<&'static str> {
	if race_part(g).is_some() {
		return None;
	}
	let f = g.get("faction");
	FACTION_PARTS.into_iter().find(|p| f.as_str() == Some(*p))
}

/// Our guide pack's folder (pack id `guides`).
pub const OWN_FOLDER: &str = "Polestar_Guides";

/// The texts addon of pack folder `folder` in `locale` (Core/GuideTexts.lua TextsAddon): <folder>_<locale>,
/// and for our own pack the language folder Polestar_<locale> it shares with the game's names.
pub fn texts_addon(folder: &str, locale: &str) -> String {
	if folder == OWN_FOLDER {
		crate::toc::language_addon(locale)
	} else {
		format!("{folder}_{locale}")
	}
}

/// HEIGHTS_SOURCE (tools/lib/travel/cmangos.js): meta.json's entry for spawn heights.
pub fn heights_source() -> V {
	const DB_REV: &str = "22b51464f1625f6ef6275771de1f5466c6f5d19e";
	obj! {
		"name" => "CMaNGOS classic-db: creature and gameobject spawn heights",
		"url" => format!("https://raw.githubusercontent.com/cmangos/classic-db/{DB_REV}/Full_DB/ClassicDB_1_12_1_z2815.sql.gz"),
		"revision" => DB_REV,
		"license" => "GPL-3.0; spawn heights (z) only, used as facts like the transport periods: a guide goal, spawn spot or smart-target candidate at an NPC or object (and Core/ClassTrainers.lua's class trainers) carries its spawn's height",
		"copyright" => "CMaNGOS (https://github.com/cmangos/classic-db)",
	}
	.into()
}

/// Era bounds for every map any emitted coordinate uses.
pub fn referenced_frames(guides: &[V], data: &Data) -> V {
	let frames = Obj::new();
	crate::validate::for_each_goal_map(guides, |map: &V, _g: &V, _goal: &V| {
		let k = map.to_js_string();
		if frames.get(&k).truthy() {
			return;
		}
		let fr = data.era_frame(map);
		if fr.truthy() {
			frames.set(&k, obj! { "c" => fr.get("c"), "left" => fr.get("left"), "right" => fr.get("right"), "top" => fr.get("top"), "bottom" => fr.get("bottom") });
		}
	});
	frames.into()
}

/// A file of the pack folder: text, or bytes (pictures).
#[derive(Clone, Debug, PartialEq)]
pub enum FileContent {
	Text(String),
	Bytes(Vec<u8>),
}

/// buildPackFiles: the addon folder as (name, content) in JS object order; `../<addon>/<file>` names the
/// race parts and texts addons beside it. `iface` is the core TOC's `## Interface:` value; `images` the
/// pictures' bytes by pack-relative path (native callers read them with images::image_files).
pub fn build_pack_files(
	guides: &[V],
	manifest: &V,
	data: &Data,
	license: Option<&str>,
	translations: &V,
	retired: &[String],
	iface: &str,
	images: Vec<(String, Vec<u8>)>,
) -> Vec<(String, FileContent)> {
	let sources = if data.meta.get("sources").is_arr() { data.meta.get("sources") } else { V::arr() };
	let h = crate::heights::height_counts(guides);
	let any_z = h.get("withZ").num() + h.get("candidatesWithZ").num() + h.get("spotsWithZ").num() != 0.0;
	let hs = heights_source();
	let meta = if any_z && !sources.items().iter().any(|s| s.truthy() && s.get("name").strict_eq(&hs.get("name"))) {
		let m = data.meta.as_obj().map(Obj::spread).unwrap_or_default();
		let mut list = sources.items();
		list.push(hs);
		m.set("sources", list);
		V::Obj(m)
	} else {
		data.meta.clone()
	};
	// Polestar's own pack is written for memory (format 8): spawn spots as strings, and each faction's
	// guides in a load-on-demand part Polestar loads for a player of that faction only.
	let ours = manifest.get("id").as_str() == Some("guides");
	let entry = |g: &V| {
		let loc = g.hidden("_localised");
		let ast = g.hidden("_ast");
		let src = ast.get("source");
		obj! { "guide" => if loc.truthy() { loc } else { g.clone() }, "source" => if src.truthy() { src } else { V::Null } }.into()
	};
	// Leveling guides for one class and named races go into an addon per race (race_part), which
	// Polestar loads for the player's race only; so do the baked legs of every leveling guide
	// (read_legs_text, legs_races), in its Legs.lua.
	let mut parts: Vec<(String, Vec<V>)> = Vec::new();
	let mut leg_parts: Vec<(String, Vec<V>)> = Vec::new();
	let add = |m: &mut Vec<(String, Vec<V>)>, r: String, g: &V| match m.iter_mut().find(|(k, _)| *k == r) {
		Some((_, l)) => l.push(g.clone()),
		None => m.push((r, vec![g.clone()])),
	};
	let mut factions: Vec<(&str, Vec<V>)> = Vec::new();
	let mut main: Vec<V> = Vec::new();
	for g in guides {
		if g.hidden("_legs").truthy() {
			for r in legs_races(g).unwrap_or_default() {
				add(&mut leg_parts, r, g);
			}
		}
		match race_part(g) {
			None => match faction_part(g).filter(|_| ours) {
				Some(f) => match factions.iter_mut().find(|(k, _)| *k == f) {
					Some((_, l)) => l.push(g.clone()),
					None => factions.push((f, vec![g.clone()])),
				},
				None => main.push(g.clone()),
			},
			Some(races) => {
				for r in races {
					add(&mut parts, r, g);
				}
			}
		}
	}
	// The first format the guides need, at least PACKED_FORMAT for ours and LEGS_FORMAT with baked legs.
	let mut format = crate::format::format_for(guides);
	if ours {
		format = format.max(crate::format::PACKED_FORMAT);
	}
	if !leg_parts.is_empty() {
		format = format.max(crate::format::LEGS_FORMAT);
	}
	let folder = manifest.get("folder").to_js_string();
	let id = manifest.get("id").to_js_string();
	let mut files: Vec<(String, FileContent)> = Vec::new();
	let t = FileContent::Text;
	files.push((format!("{folder}.toc"), t(crate::emit::emit_toc(manifest, iface, format))));
	files.push(("Pack.lua".into(), t(crate::emit::emit_pack(manifest, format))));
	files.push(("MapFrames.lua".into(), t(crate::emit::emit_map_frames(&referenced_frames(guides, data), &id))));
	let main_entries: Vec<V> = main.iter().map(entry).collect();
	let mut gl = crate::emit::emit_guides_with(&main_entries, false, ours);
	if !retired.is_empty() {
		gl.push_str(&crate::emit::emit_retired(&id, retired));
	}
	files.push(("Guides.lua".into(), t(gl)));
	let license_data = crate::emit::emit_license(&meta, !leg_parts.is_empty());
	files.push(("LICENSE-DATA.txt".into(), t(license_data.clone())));
	if let Some(l) = license {
		files.push(("LICENSE.txt".into(), t(l.to_string())));
	}
	factions.sort_by_key(|(f, _)| *f);
	for (faction, list) in &factions {
		let name = part_addon(&folder, faction);
		files.push((format!("../{name}/{name}.toc"), t(crate::emit::emit_faction_toc(manifest, faction, iface))));
		let es: Vec<V> = list.iter().map(entry).collect();
		files.push((format!("../{name}/Guides.lua"), t(crate::emit::emit_guides_with(&es, false, true))));
		files.push((format!("../{name}/LICENSE-DATA.txt"), t(license_data.clone())));
		if let Some(l) = license {
			files.push((format!("../{name}/LICENSE.txt"), t(l.to_string())));
		}
	}
	let mut races: Vec<String> = parts.iter().chain(leg_parts.iter()).map(|(r, _)| r.clone()).collect();
	races.sort_by(|a, b| crate::js::cmp_utf16(a, b));
	races.dedup();
	for race in &races {
		let name = part_addon(&folder, race);
		let own = parts.iter().find(|(r, _)| r == race).map(|(_, l)| l);
		let legs = leg_parts.iter().find(|(r, _)| r == race).map(|(_, l)| l);
		files.push((format!("../{name}/{name}.toc"), t(crate::emit::emit_part_toc(manifest, race, iface, own.is_some(), legs.is_some()))));
		if let Some(list) = own {
			let es: Vec<V> = list.iter().map(entry).collect();
			files.push((format!("../{name}/Guides.lua"), t(crate::emit::emit_guides_with(&es, true, ours))));
		}
		if let Some(list) = legs {
			files.push((format!("../{name}/Legs.lua"), t(crate::emit::emit_legs(&id, list))));
		}
		if let Some(l) = license {
			files.push((format!("../{name}/LICENSE.txt"), t(l.to_string())));
		}
	}
	for (rel, bytes) in images {
		files.push((rel, FileContent::Bytes(bytes)));
	}
	let mut locales = translations.keys();
	locales.sort_by(|a, b| crate::js::cmp_utf16(a, b));
	for locale in locales {
		let name = texts_addon(&folder, &locale);
		let language = crate::locales::language(&locale);
		files.push((format!("../{name}/{name}.toc"), t(crate::emit::emit_texts_toc(manifest, &locale, &language, iface))));
		files.push((format!("../{name}/Texts.lua"), t(crate::emit::emit_texts(&id, &locale, &translations.get(&locale)))));
		if let Some(l) = license {
			files.push((format!("../{name}/LICENSE.txt"), t(l.to_string())));
		}
	}
	files
}

#[cfg(feature = "native")]
pub use native::*;

#[cfg(feature = "native")]
mod native {
	use super::*;
	use std::path::Path;

	fn rel_to_cwd(abs: &Path) -> String {
		let cwd = std::env::current_dir().unwrap_or_default();
		match abs.strip_prefix(&cwd) {
			Ok(r) => {
				let s = r.to_string_lossy().replace(std::path::MAIN_SEPARATOR, "/");
				if s.is_empty() {
					".".into()
				} else {
					s
				}
			}
			Err(_) => abs.to_string_lossy().into_owned(),
		}
	}

	/// The path as JS `path.relative(cwd, abs)` would show it when inside cwd, else absolute.
	pub fn shown(abs: &Path) -> String {
		rel_to_cwd(abs)
	}

	/// Sorted .guide paths relative to pack_dir (dist/, drafts/ unless include_drafts, dot folders, node_modules skipped).
	pub fn find_guide_files(pack_dir: &Path, include_drafts: bool) -> Vec<String> {
		let mut out = Vec::new();
		fn walk(abs: &Path, rel: &str, include_drafts: bool, out: &mut Vec<String>) {
			let Ok(rd) = std::fs::read_dir(abs) else { return };
			let mut ents: Vec<_> = rd.flatten().collect();
			ents.sort_by_key(|e| e.file_name());
			for d in ents {
				let name = d.file_name().to_string_lossy().into_owned();
				if name.starts_with('.') {
					continue;
				}
				let r = if rel.is_empty() { name.clone() } else { format!("{rel}/{name}") };
				let ft = d.file_type().unwrap();
				if ft.is_dir() {
					if name == "node_modules" || r == "dist" || (!include_drafts && r == "drafts") {
						continue;
					}
					walk(&d.path(), &r, include_drafts, out);
				} else if ft.is_file() && name.ends_with(".guide") {
					out.push(r);
				}
			}
		}
		walk(pack_dir, "", include_drafts, &mut out);
		out.sort_by(|a, b| crate::js::cmp_utf16(a, b));
		out
	}

	pub fn read_sources(dir: &Path, sources: &[String]) -> Vec<Source> {
		sources
			.iter()
			.map(|rel| {
				let abs = dir.join(rel);
				Source { source: rel.clone(), file: rel_to_cwd(&abs), text: std::fs::read_to_string(&abs).unwrap_or_default() }
			})
			.collect()
	}

	/// loadProjectData: a missing folder or core file is a warning.
	pub fn load_project_data(data_dir: &Path, diag: &mut Diagnostics) -> Result<Data, String> {
		let data = crate::data::load_data(data_dir)?;
		let shown = data_dir.to_string_lossy();
		if !data_dir.exists() {
			diag.warn(&shown, 0.0, "reference data not found (run `forge data build` or pass --data); nothing can be filled in", None);
		} else if !data.missing_core.is_empty() {
			diag.warn(&shown, 0.0, format!("missing {}", data.missing_core.join(", ")), None);
		}
		Ok(data)
	}

	/// findPackDir (pack/locate.js): the nearest folder holding pack.json, from `start` up to the root.
	pub fn find_pack_dir(start: &Path) -> Option<std::path::PathBuf> {
		start.ancestors().find(|d| d.join("pack.json").exists()).map(Path::to_path_buf)
	}

	/// The same folder, through symlinks when both exist (locate.js samePath).
	pub fn same_path(a: &Path, b: &Path) -> bool {
		let real = |p: &Path| p.canonicalize().unwrap_or_else(|_| p.to_path_buf());
		real(a) == real(b)
	}

	/// noReferenceData (pack/build.js): without any core file in `data_dir` every lookup fails, so the
	/// build stops with this one error instead of one on every line. `context_data`: another pack's
	/// context data folder (named in the hint when it lacks data too); `no_data_flag`: the command takes
	/// --no-data. None when there is data.
	pub fn no_reference_data(data_dir: &Path, context_data: Option<&Path>, no_data_flag: bool) -> Option<Diagnostics> {
		if crate::data::has_core_data(data_dir) {
			return None;
		}
		let core: Vec<String> = crate::data::FILES.iter().map(|f| format!("{f}.json")).collect();
		let what = if data_dir.exists() { format!("the folder holds none of {}", core.join(", ")) } else { "the folder does not exist".into() };
		let context = if context_data.is_some_and(|c| !crate::data::has_core_data(c)) { ", and --context-data <dir> for our guides read as context" } else { "" };
		let flag = if no_data_flag { "; --no-data checks guides that give every quest title, name and place themselves" } else { "" };
		let mut diag = Diagnostics::new();
		diag.error(
			&rel_to_cwd(data_dir),
			0.0,
			format!("no reference data: {what}, so no quest, NPC or place can be looked up"),
			Some(format!("run `forge data build`, or pass --data <dir>{context}{flag}")),
		);
		Some(diag)
	}

	pub struct Project {
		pub guides: Vec<V>,
		pub diag: Diagnostics,
		pub sources: Vec<String>,
		pub retired: Vec<String>,
		pub tokens: V,
	}

	/// compileProject for a pack folder; `context`: our guides, read as context for another pack.
	pub fn compile_project(pack_dir: &Path, manifest: &V, data: &Data, mut diag: Diagnostics, include_drafts: bool, context: Option<Context>) -> Project {
		let sources = find_guide_files(pack_dir, include_drafts);
		let opts = CompileOpts { pack: manifest.get("id").as_str().map(str::to_string), author: manifest.get("author").as_str().map(str::to_string), context, pack_dir: Some(pack_dir.to_path_buf()) };
		let c = compile_sources(&read_sources(pack_dir, &sources), data, &mut diag, &opts);
		let retired_file = pack_dir.join("retired.json");
		let retired = read_retired_text(pack_text(pack_dir, "retired.json", &mut diag).as_deref(), &retired_file.to_string_lossy(), &c.guides, &mut diag);
		let legs_file = pack_dir.join("legs.json");
		read_legs_text(pack_text(pack_dir, "legs.json", &mut diag).as_deref(), &legs_file.to_string_lossy(), &c.guides, data, &mut diag);
		Project { guides: c.guides, diag, sources, retired, tokens: c.tokens }
	}

	/// read_pack_file's text of `name` in the pack folder, None without it; a refused one (a link,
	/// or outside the folder) is an error in diag and None.
	fn pack_text(pack_dir: &Path, name: &str, diag: &mut Diagnostics) -> Option<String> {
		crate::manifest::read_pack_file(pack_dir, name).unwrap_or_else(|e| {
			diag.error(&pack_dir.join(name).to_string_lossy(), 1.0, e, None);
			None
		})
	}

	/// coreInterface: the `## Interface:` value of addon/Polestar/Polestar.toc under `root`.
	pub fn core_interface(root: &Path) -> Result<String, String> {
		let file = root.join("addon/Polestar/Polestar.toc");
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		for line in text.lines() {
			if let Some(v) = line.strip_prefix("## Interface:") {
				return Ok(v.trim().to_string());
			}
		}
		Err(format!("{} has no ## Interface line", file.display()))
	}

	/// The pack's LICENSE file (text) with the placeholder warning (pack/build.js readLicense); a
	/// LICENSE that is a link or lies outside the pack folder is an error, never read.
	pub fn read_license(pack_dir: &Path, manifest: &V, diag: &mut Diagnostics) -> Option<String> {
		let file = pack_dir.join("LICENSE");
		let text = match crate::manifest::read_pack_file(pack_dir, "LICENSE") {
			Ok(text) => text?,
			Err(e) => {
				diag.error(&rel_to_cwd(&file), 1.0, e, Some("make LICENSE a plain file holding the licence text".into()));
				return None;
			}
		};
		if let Some(at) = text.split('\n').map(|l| l.strip_suffix('\r').unwrap_or(l)).position(|l| l.contains(crate::format::LICENSE_PLACEHOLDER)) {
			diag.warn(
				&rel_to_cwd(&file),
				(at + 1) as f64,
				"LICENSE still holds the placeholder line `polestar new` writes, not the licence text",
				Some(format!("replace the line with the full text of the {} licence: the built addon ships LICENSE as LICENSE.txt", manifest.get("license"))),
			);
		}
		Some(text)
	}

	/// The `## <key>: <value>` line of a TOC (`X-Polestar-Pack`, `-Part`, `-Texts`), when generated.
	fn toc_line(text: &str, key: &str) -> Option<String> {
		let prefix = format!("## {key}:");
		text.lines().find_map(|l| {
			let v = l.strip_prefix(&prefix)?.trim_matches([' ', '\t']);
			(!v.is_empty() && !v.contains([' ', '\t'])).then(|| v.to_string())
		})
	}

	/// The folder's entries (None: not readable as a folder).
	fn entries(dir: &Path) -> Option<Vec<std::fs::DirEntry>> {
		std::fs::read_dir(dir).ok().map(|r| r.flatten().collect())
	}

	fn is_toc(name: &str) -> bool {
		name.to_lowercase().ends_with(".toc")
	}

	/// packDirRefusal (project.js): an absent or empty folder, or one we generated (a TOC or the old
	/// Pack.xml with the marker, new or legacy), may be replaced; with `pack_id`, a generated folder of
	/// another pack may not. -> None, or why not: `--out` at the repository on a case-insensitive file
	/// system, or at someone's own addon, must never be touched.
	pub fn pack_dir_refusal(dir: &Path, pack_id: Option<&str>) -> Option<String> {
		let Some(list) = entries(dir) else { return dir.exists().then(|| "it is not a folder".into()) };
		if list.is_empty() {
			return None;
		}
		let text = |e: &std::fs::DirEntry| std::fs::read_to_string(e.path()).unwrap_or_default();
		let marked: Vec<String> = list
			.iter()
			.filter(|e| e.file_type().is_ok_and(|t| t.is_file()))
			.filter(|e| {
				let n = e.file_name().to_string_lossy().into_owned();
				is_toc(&n) || n == "Pack.xml"
			})
			.map(text)
			.filter(|t| crate::format::is_generated(t))
			.collect();
		if marked.is_empty() {
			return Some(format!("it is not a generated community addon (no TOC with the \"{}\" line); move it away first", crate::format::GENERATED_MARKER));
		}
		let owner = pack_id.and_then(|_| {
			list.iter().filter(|e| e.file_type().is_ok_and(|t| t.is_file()) && is_toc(&e.file_name().to_string_lossy())).find_map(|e| {
				let t = text(e);
				crate::format::is_generated(&t).then(|| toc_line(&t, "X-Polestar-Pack")).flatten()
			})
		});
		match (owner, pack_id) {
			(Some(o), Some(p)) if o != p => Some(format!("it holds the community addon \"{o}\", not \"{p}\"; set \"folder\" in pack.json to a folder name of your own")),
			_ => None,
		}
	}

	/// partDirRefusal / textsDirRefusal (project.js): whether `dir` may hold pack `pack_id`'s race part
	/// (`what` "race part", key X-Polestar-Part), faction part ("faction part", X-Polestar-Part) or texts
	/// addon ("texts addon", X-Polestar-Texts).
	fn sibling_refusal(dir: &Path, pack_id: Option<&str>, what: &str, key: &str) -> Option<String> {
		let Some(list) = entries(dir) else { return dir.exists().then(|| "it is not a folder".into()) };
		if list.is_empty() {
			return None;
		}
		let toc = list.iter().find(|e| is_toc(&e.file_name().to_string_lossy()));
		let text = toc.and_then(|e| std::fs::read_to_string(e.path()).ok()).unwrap_or_default();
		let Some(id) = crate::format::is_generated(&text).then(|| toc_line(&text, key)).flatten() else {
			return Some(format!("it is not a generated {what} (no TOC with the \"{}\" line); move it away first", crate::format::GENERATED_MARKER));
		};
		match pack_id {
			Some(p) if p != id => Some(if what != "texts addon" {
				format!("it holds a {what} of the community addon \"{id}\", not \"{p}\"")
			} else {
				format!("it holds the texts of the community addon \"{id}\", not \"{p}\"")
			}),
			_ => None,
		}
	}

	/// writePackDir (project.js): writes a pack folder where [`pack_dir_refusal`] allows it (for the pack
	/// the files' TOC names). The old layout (Pack.xml, Guides/) is removed, and a LICENSE.txt the build no
	/// longer has; generated files are replaced; anything else is left alone. Files named
	/// `../<texts addon>/...` (texts addons, [`texts_addon`]), `../<folder>_<race>/...` (race parts) and
	/// `../<folder>_<faction>/...` (faction parts) are each written whole beside `out`, named after `out` as
	/// the pack folder is; one of the pack the build no longer has is removed. Our pack's texts go into
	/// the language folders Polestar_<locale>, which the game's names share: there only the TOC and
	/// Texts.lua are written (or Texts.lua removed), and the retired Polestar_Guides_<locale> folders are
	/// removed.
	pub fn write_pack_dir(out: &Path, files: &[(String, FileContent)]) -> Result<(), String> {
		let content = |c: &FileContent| match c {
			FileContent::Text(t) => t.clone().into_bytes(),
			FileContent::Bytes(b) => b.clone(),
		};
		let toc = files.iter().find(|(n, _)| !n.starts_with("../") && is_toc(n));
		let pack_id = toc.and_then(|(_, c)| toc_line(&String::from_utf8_lossy(&content(c)), "X-Polestar-Pack"));
		let pack_id = pack_id.as_deref();
		let parent = out.parent().unwrap_or(Path::new("."));
		let base = out.file_name().map(|b| b.to_string_lossy().into_owned()).unwrap_or_default();
		// The files name the parts and texts addons after the pack's folder (its TOC, <folder>.toc): beside an
		// `out` named otherwise they take its name, as the pack folder does.
		let folder = toc.and_then(|(n, _)| n.strip_suffix(".toc")).map(|f| format!("{f}_"));
		let mut siblings: std::collections::BTreeMap<String, Vec<(String, Vec<u8>)>> = Default::default();
		for (name, c) in files {
			if let Some(rest) = name.strip_prefix("../") {
				let (sibling, file) = rest.split_once('/').unwrap_or((rest, ""));
				let sibling = match folder.as_deref().and_then(|f| sibling.strip_prefix(f)) {
					Some(suffix) => format!("{base}_{suffix}"),
					None => sibling.to_string(),
				};
				siblings.entry(sibling).or_default().push((file.to_string(), content(c)));
			}
		}
		let shown = out.display();
		if let Some(why) = pack_dir_refusal(out, pack_id) {
			return Err(format!("refusing to write into {shown}: {why}"));
		}
		let texts: Vec<String> = crate::locales::LOCALE_CODES.iter().map(|l| texts_addon(&base, l)).collect();
		let parts: Vec<String> = crate::races::RACE_FILES.iter().map(|r| part_addon(&base, r)).collect();
		let factions: Vec<String> = FACTION_PARTS.iter().map(|f| part_addon(&base, f)).collect();
		let refusal = |folder: &str| {
			let dir = parent.join(folder);
			if texts.iter().any(|t| t == folder) {
				sibling_refusal(&dir, pack_id, "texts addon", "X-Polestar-Texts")
			} else if factions.iter().any(|f| f == folder) {
				sibling_refusal(&dir, pack_id, "faction part", "X-Polestar-Part")
			} else {
				sibling_refusal(&dir, pack_id, "race part", "X-Polestar-Part")
			}
		};
		for folder in texts.iter().chain(parts.iter()).chain(factions.iter()) {
			if siblings.contains_key(folder) {
				if let Some(why) = refusal(folder) {
					return Err(format!("refusing to write into {}: {why}", parent.join(folder).display()));
				}
			}
		}
		let io = |e: std::io::Error, p: &Path| format!("{}: {e}", p.display());
		std::fs::create_dir_all(out).map_err(|e| io(e, out))?;
		let _ = std::fs::remove_dir_all(out.join("Guides"));
		let _ = std::fs::remove_file(out.join("Pack.xml"));
		if !files.iter().any(|(n, _)| n == "LICENSE.txt") {
			let _ = std::fs::remove_file(out.join("LICENSE.txt"));
		}
		let mut own: Vec<&(String, FileContent)> = files.iter().filter(|(n, _)| !n.starts_with("../")).collect();
		own.sort_by(|a, b| crate::js::cmp_utf16(&a.0, &b.0));
		for (name, c) in own {
			let file = out.join(name);
			if let Some(p) = file.parent() {
				std::fs::create_dir_all(p).map_err(|e| io(e, p))?;
			}
			std::fs::write(&file, content(c)).map_err(|e| io(e, &file))?;
		}
		// Our pack's texts share the language folder with the game's names (`forge data names`): only
		// the texts' own files are written or removed there, and the folder goes once it holds no names.
		let shared = base == OWN_FOLDER;
		for folder in texts.iter().chain(parts.iter()).chain(factions.iter()) {
			let dir = parent.join(folder);
			let language = shared && texts.iter().any(|t| t == folder);
			match siblings.get(folder) {
				None if language => {
					if refusal(folder).is_none() {
						let _ = std::fs::remove_file(dir.join("Texts.lua"));
						if entries(&dir).is_some_and(|l| !l.iter().any(|e| e.file_name() == "Names.lua")) {
							let _ = std::fs::remove_dir_all(&dir);
						}
					}
				}
				None => {
					if entries(&dir).is_some_and(|l| !l.is_empty()) && refusal(folder).is_none() {
						let _ = std::fs::remove_dir_all(&dir);
					}
				}
				Some(list) => {
					if !language {
						let _ = std::fs::remove_dir_all(&dir);
					}
					std::fs::create_dir_all(&dir).map_err(|e| io(e, &dir))?;
					for (name, bytes) in list {
						std::fs::write(dir.join(name), bytes).map_err(|e| io(e, &dir))?;
					}
				}
			}
		}
		// The texts folders the language folders replaced (Polestar_Guides_<locale>, before 0.3.0).
		if shared {
			for l in crate::locales::LOCALE_CODES {
				let dir = parent.join(format!("{OWN_FOLDER}_{l}"));
				if entries(&dir).is_some_and(|l| !l.is_empty()) && sibling_refusal(&dir, pack_id, "texts addon", "X-Polestar-Texts").is_none() {
					let _ = std::fs::remove_dir_all(&dir);
				}
			}
		}
		Ok(())
	}

	pub struct Built {
		pub project: Project,
		pub files: Option<Vec<(String, FileContent)>>,
	}

	/// How [`build_pack`] builds: the pack's drafts/** too, our guides read as context (another pack), and
	/// whether the files are laid out even with errors.
	pub struct BuildOpts<'a> {
		pub include_drafts: bool,
		pub context: Option<Context<'a>>,
		pub force: bool,
	}

	/// buildPack for a pack folder: compile (with our guides as context for another pack), the pack's
	/// translations (warnings), and, when `force` or there are no errors, the files. `extra` diagnostics
	/// (pack.json's) are appended.
	pub fn build_pack(root: &Path, pack_dir: &Path, manifest: &V, extra: Vec<crate::diag::Diag>, data: &Data, data_warnings: Diagnostics, opts: BuildOpts) -> Result<Built, String> {
		let force = opts.force;
		let mut project = compile_project(pack_dir, manifest, data, data_warnings, opts.include_drafts, opts.context);
		project.diag.list.extend(extra);
		let license = read_license(pack_dir, manifest, &mut project.diag);
		let mut translations = V::obj();
		if !project.diag.has_errors() || force {
			let got = crate::i18n_guides::pack_translations(pack_dir, manifest, &project.guides)?;
			translations = got.get("translations");
			for w in got.get("warnings").items() {
				project.diag.warn(&w.get("file").to_js_string(), 0.0, w.get("message").to_js_string(), None);
			}
		}
		let ok = !project.diag.has_errors();
		let files = if ok || force {
			let iface = core_interface(root)?;
			let images: Vec<(String, Vec<u8>)> = crate::images::image_files(&project.guides).into_iter().map(|(rel, abs): (String, String)| (rel, std::fs::read(&abs).unwrap_or_default())).collect();
			Some(build_pack_files(&project.guides, manifest, data, license.as_deref(), &translations, &project.retired, &iface, images))
		} else {
			None
		};
		Ok(Built { project, files })
	}
}
