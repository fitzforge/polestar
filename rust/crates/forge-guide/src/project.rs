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

/// The pack check (`playtest --honest`, forge judge's report and route check, forge build's writer):
/// `sources` compiled, or their errors as `the pack has errors:` and the first five, one
/// `<file>:<line> <message>` a line.
pub fn compile_checked(sources: &[Source], data: &Data, opts: &CompileOpts) -> Result<Compiled, String> {
	let mut diag = Diagnostics::new();
	let compiled = compile_sources(sources, data, &mut diag, opts);
	if diag.has_errors() {
		let first: Vec<String> = diag.errors().iter().take(5).map(|d| format!("{}:{} {}", d.file.as_deref().unwrap_or(""), d.line, d.message)).collect();
		return Err(format!("the pack has errors:\n{}", first.join("\n")));
	}
	Ok(compiled)
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
/// build_pack_files to write into the race parts' Legs.lua. Returns the ids of the guides whose legs
/// are stale (baked, but their leg ends hash differently now), in the guides' order.
pub fn read_legs_text(text: Option<&str>, file: &str, guides: &[V], data: &Data, diag: &mut Diagnostics) -> Vec<String> {
	let mut stale = Vec::new();
	let Some(text) = text else { return stale };
	let doc = match crate::js::parse_json(text) {
		Ok(v) => v,
		Err(e) => {
			diag.error(file, 1.0, format!("legs.json is not JSON: {e}"), None);
			return stale;
		}
	};
	if !doc.truthy() || doc.get("schema").as_num() != Some(1.0) || !(doc.get("legs").is_object() || matches!(doc.get("legs"), V::Null)) || !doc.get("grid").is_str() {
		diag.error(file, 1.0, "legs.json is not a legs file of schema 1 (forge guide bake)", None);
		return stale;
	}
	let legs = doc.get("legs");
	for g in guides {
		let entry = legs.get(&g.get("id").to_js_string());
		if !entry.truthy() || legs_races(g).is_none() {
			continue;
		}
		if !entry.get("hash").strict_eq(&V::from(crate::bake::guide_hash(g, &data.map_frames))) {
			stale.push(g.get("id").to_js_string());
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
	if !stale.is_empty() {
		diag.warn(file, 1.0, format!("{} guide(s) changed since their legs were baked: they go without until `forge guide bake` runs again", stale.len()), None);
	}
	stale
}

/// The leveling guides (legs_races) legs.json's text holds no legs for, in the guides' order: never
/// baked, so they ship without legs. Empty without the file or with one read_legs_text refuses.
pub fn unbaked_legs(text: Option<&str>, guides: &[V]) -> Vec<String> {
	let Some(doc) = text.and_then(|t| crate::js::parse_json(t).ok()).filter(|d| d.get("schema").as_num() == Some(1.0)) else { return Vec::new() };
	let legs = doc.get("legs");
	guides.iter().filter(|g| legs_races(g).is_some() && !legs.get(&g.get("id").to_js_string()).truthy()).map(|g| g.get("id").to_js_string()).collect()
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

/// One of Polestar's own extra guide packs (docs/PACK_FORMAT.md, "Polestar's own extra packs"): built from its
/// folder in the checkout (pack.json and .guide files, checked as a community pack's, with our guides as
/// context) into an addon folder of Polestar's that ships in the release zip, with Polestar's TOC
/// ([`crate::emit::emit_toc`]): its title as written, the AddOns list in every client language, and
/// `## LoadOnDemand: 1`, so Polestar keeps it off until the player switches it on (Community guides) and loads
/// it then. Its id is reserved (format.rs RESERVED_IDS): only its own pack.json may give it (manifest.rs
/// read_extra_manifest), and in game only its own addon may register it.
pub struct OwnExtra {
	/// Its folder in the checkout.
	pub source: &'static str,
	/// Its pack id.
	pub id: &'static str,
	/// Its addon folder.
	pub folder: &'static str,
}

/// The extra packs: the experimental guides (Forever's new zones, alpha), never suggested in game.
pub static OWN_EXTRAS: [OwnExtra; 1] = [OwnExtra { source: "experimental", id: "polestar-experimental", folder: "Polestar_Experimental" }];

/// The extra pack whose addon folder is `folder`.
pub fn own_extra(folder: &str) -> Option<&'static OwnExtra> {
	OWN_EXTRAS.iter().find(|e| e.folder == folder)
}

/// The extra pack (OWN_EXTRAS) a guide id belongs to (`polestar-experimental/...`), if any.
pub fn extra_of(id: &str) -> Option<&'static str> {
	OWN_EXTRAS.iter().find(|e| id.strip_prefix(e.id).is_some_and(|rest| rest.starts_with('/'))).map(|e| e.id)
}

/// The keys of an experimental index entry ([`experimental_index`]), in the order Guides.lua writes them.
pub const INDEX_KEYS: [&str; 22] = [
	"id", "pack", "title", "faction", "races", "classes", "minLevel", "maxLevel", "topLevel", "zone", "zoneName", "pitch", "pros", "cons", "questIds", "joins", "start", "focus", "viaMap", "via",
	"names", "written",
];

/// A guide's `next` ids: its route choice's options, else its one `next`.
fn next_list(g: &V) -> Vec<String> {
	let nc = g.get("nextChoices");
	let list = if nc.truthy() {
		nc.items()
	} else if g.get("next").truthy() {
		vec![g.get("next")]
	} else {
		Vec::new()
	};
	list.iter().map(V::to_js_string).collect()
}

/// The index of Polestar's experimental guides our route choices offer (docs/PACK_FORMAT.md, "Polestar's own
/// extra packs"; Core/Guides.lua, Polestar.RegisterExperimental): for every guide of an extra pack that a
/// `next` line of `ours` names, in id order, its header as a guide registers it (its localised texts, with the
/// name tokens they use) and its route until it is back on ours ([`index_entry`]). `extras`: the extra packs'
/// guides, resolved and localised. Each such `next` line is checked: an id the extra pack lacks, another
/// faction's guide, or the first line (the route's default) is an error on our guide.
pub fn experimental_index(ours: &[V], extras: &[V], data: &Data, diag: &mut Diagnostics) -> Vec<V> {
	let by_id: rustc_hash::FxHashMap<String, &V> = extras.iter().map(|g| (g.get("id").to_js_string(), g)).collect();
	let mut offered: Vec<String> = Vec::new();
	for g in ours {
		let ast = g.hidden("_ast");
		let file = ast.get("file").to_js_string();
		let lines = ast.get("lines");
		let line_of = |to: &str| {
			let of = lines.get("nextOf");
			let l = if of.truthy() { of.get(to) } else { V::Undef };
			if l.truthy() {
				l.num()
			} else {
				lines.get("next").num()
			}
		};
		for (i, to) in next_list(g).iter().enumerate() {
			if extra_of(to).is_none() {
				continue;
			}
			let Some(other) = by_id.get(to) else {
				diag.error(&file, line_of(to), format!("`next` points to unknown guide \"{to}\""), Some("list guide ids with `polestar find --kind guide <text>`".into()));
				continue;
			};
			let (gf, of) = (g.get("faction"), other.get("faction"));
			if gf.truthy() && of.truthy() && !of.strict_eq(&gf) {
				diag.error(&file, line_of(to), format!("`next` offers {} guide \"{to}\" after a {} guide", of.to_js_string(), gf.to_js_string()), None);
				continue;
			}
			if i == 0 {
				diag.error(
					&file,
					line_of(to),
					format!("`next` offers the experimental guide \"{to}\" first: the first `next` line is the route's default, and an experimental guide is only ever chosen"),
					Some("put the `next` line of the guide the route goes on to first, and the experimental guide's after it".into()),
				);
				continue;
			}
			if !offered.contains(to) {
				offered.push(to.clone());
			}
		}
	}
	offered.sort_by(|a, b| crate::js::cmp_utf16(a, b));
	offered.iter().map(|id| index_entry(by_id[id], &by_id, data)).collect()
}

/// A point of a goal for the index: { map, x, y, f }.
fn index_point(goal: &V) -> V {
	let p = Obj::new();
	for k in ["map", "x", "y", "f"] {
		let v = goal.get(k);
		if !v.is_nullish() {
			p.set(k, v);
		}
	}
	V::Obj(p)
}

/// The zone a guide's first travel goes through, when it is not its own: the map of its first goal placed
/// somewhere (a flight's by its taxi node), before its first goal on its own zone's map. -> (uiMapID, name).
fn via_of(g: &V, data: &Data) -> Option<(V, V)> {
	let zone = g.get("zone");
	let nodes = data.flight_nodes().items();
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			let map = if goal.get("map").is_num() {
				goal.get("map")
			} else if goal.get("node").is_num() {
				nodes.iter().find(|n| n.get("id").strict_eq(&goal.get("node"))).map_or(V::Undef, |n| n.get("map"))
			} else {
				continue;
			};
			if !map.is_num() {
				continue;
			}
			if map.strict_eq(&zone) {
				return None;
			}
			let name = data.zone(&map).get("name");
			return name.is_str().then_some((map, name));
		}
	}
	None
}

/// One experimental guide's index entry: its header (title, faction, races, classes, levels, zone, pitch,
/// pros, cons, localised, with the `names` and `written` those texts use) and its route, walked through the
/// extra pack's `next` lines until they lead back to ours: the top level (`topLevel`), the quests its accepts
/// take (`questIds`, each once), our guides it rejoins (`joins`), where it starts (`start`: its first located
/// goal; `focus`: its first on its zone's map) and the zone its first travel goes through when that is not
/// its own (`viaMap`, `via`).
fn index_entry(g: &V, extras: &rustc_hash::FxHashMap<String, &V>, data: &Data) -> V {
	let loc = g.hidden("_localised");
	let text = if loc.truthy() { loc } else { g.clone() };
	let out = Obj::new();
	for k in ["id", "pack", "title", "faction", "races", "classes", "minLevel", "maxLevel"] {
		let v = text.get(k);
		if !v.is_nullish() {
			out.set(k, v);
		}
	}
	let mut top = g.get("maxLevel").as_num().unwrap_or(0.0);
	let mut quests: Vec<V> = Vec::new();
	let mut joins: Vec<String> = Vec::new();
	let mut seen: rustc_hash::FxHashSet<String> = rustc_hash::FxHashSet::default();
	let mut queue: std::collections::VecDeque<V> = std::collections::VecDeque::from([g.clone()]);
	// An `only` naming factions keeps a line from the other side: the route's quests are its faction's.
	let faction = g.get("faction");
	let theirs = |only: &V| faction.is_str() && only.get("factions").is_arr() && !only.get("factions").items().iter().any(|f| f.strict_eq(&faction));
	while let Some(cur) = queue.pop_front() {
		if !seen.insert(cur.get("id").to_js_string()) {
			continue;
		}
		top = top.max(cur.get("maxLevel").as_num().unwrap_or(0.0));
		for step in cur.get("steps").items().iter().filter(|s| !theirs(&s.get("only"))) {
			for goal in step.get("goals").items() {
				let q = goal.get("quest");
				if goal.get("t").as_str() == Some("accept") && q.is_num() && !theirs(&goal.get("only")) && !quests.iter().any(|x| x.strict_eq(&q)) {
					quests.push(q);
				}
			}
		}
		for to in next_list(&cur) {
			if let Some(n) = extras.get(&to) {
				queue.push_back((*n).clone());
			} else if extra_of(&to).is_none() && !joins.contains(&to) {
				joins.push(to);
			}
		}
	}
	if top > 0.0 {
		out.set("topLevel", top);
	}
	for k in ["zone", "zoneName", "pitch", "pros", "cons"] {
		let v = text.get(k);
		if !v.is_nullish() {
			out.set(k, v);
		}
	}
	out.set("questIds", quests);
	out.set("joins", joins.iter().map(|s| V::str(s)).collect::<Vec<V>>());
	let goals: Vec<V> = g.get("steps").items().iter().flat_map(|s| s.get("goals").items()).collect();
	let located = |goal: &&V| goal.get("map").is_num() && goal.get("x").is_num() && goal.get("y").is_num();
	if let Some(start) = goals.iter().find(located) {
		out.set("start", index_point(start));
	}
	if let Some(focus) = goals.iter().filter(located).find(|goal| goal.get("map").strict_eq(&g.get("zone"))) {
		out.set("focus", index_point(focus));
	}
	if let Some((map, name)) = via_of(g, data) {
		out.set("viaMap", map);
		out.set("via", name);
	}
	// The name tokens the header's texts use, and the author's words of those texts (`written`).
	let mut texts: Vec<String> = Vec::new();
	for k in ["title", "pitch"] {
		if let Some(s) = text.get(k).as_str() {
			texts.push(s.to_string());
		}
	}
	for k in ["pros", "cons"] {
		texts.extend(text.get(k).items().iter().filter_map(|v| v.as_str().map(str::to_string)));
	}
	let names = text.get("names");
	let used = Obj::new();
	for t in &texts {
		let mut rest = t.as_str();
		while let Some(open) = rest.find('{') {
			rest = &rest[open + 1..];
			let Some(close) = rest.find('}') else { break };
			let token = &rest[..close];
			if names.get(token).is_str() {
				used.set(token, names.get(token));
			}
			rest = &rest[close + 1..];
		}
	}
	if !used.is_empty() {
		out.set("names", V::Obj(used));
	}
	let written = text.get("written");
	let words = Obj::new();
	for t in &texts {
		if written.get(t).is_str() {
			words.set(t, written.get(t));
		}
	}
	if !words.is_empty() {
		out.set("written", V::Obj(words));
	}
	V::Obj(out)
}

/// Takes `manifest` (the extra's pack.json, read by manifest.rs read_extra_manifest: as a community pack's,
/// no folder of Polestar's, but its own reserved id) as extra pack `extra`'s and gives it the extra's
/// folder. Its pack.json must give the extra's id and Polestar as its author, and leave `folder` out. Err: why
/// not.
pub fn own_extra_manifest(extra: &OwnExtra, manifest: &V) -> Result<(), String> {
	let pack = format!("{}/pack.json", extra.source);
	let id = manifest.get("id").to_js_string();
	if id != extra.id {
		return Err(format!("{pack}: id is \"{id}\"; {} holds the pack \"{}\"", extra.folder, extra.id));
	}
	let author = manifest.get("author").to_js_string();
	if author != "Polestar" {
		return Err(format!("{pack}: author is \"{author}\"; {} is Polestar's own, author \"Polestar\"", extra.folder));
	}
	let named = manifest.get("folder").to_js_string();
	if named != crate::format::default_folder(manifest.get("title").as_str(), Some(&id)) {
		return Err(format!("{pack}: leave \"folder\" out (\"{named}\"): the build names the folder {}", extra.folder));
	}
	manifest.set("folder", extra.folder);
	Ok(())
}

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
/// pictures' bytes by pack-relative path (native callers read them with images::image_files). `offers`: our
/// pack's experimental index ([`experimental_index`]), written after its guides in Guides.lua, with the Era
/// frames of the maps its points are on in MapFrames.lua; empty for every other pack.
pub fn build_pack_files(
	guides: &[V],
	manifest: &V,
	data: &Data,
	license: Option<&str>,
	translations: &V,
	retired: &[String],
	offers: &[V],
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
	let frames = referenced_frames(guides, data);
	// The experimental index's points too: their routes' travel time and art focus are read before their
	// pack is in.
	for p in offers.iter().flat_map(|e| [e.get("start"), e.get("focus")]) {
		let k = p.get("map").to_js_string();
		let fr = if p.get("map").is_num() && !frames.get(&k).truthy() { data.era_frame(&p.get("map")) } else { V::Undef };
		if fr.truthy() {
			frames.set(&k, obj! { "c" => fr.get("c"), "left" => fr.get("left"), "right" => fr.get("right"), "top" => fr.get("top"), "bottom" => fr.get("bottom") });
		}
	}
	files.push(("MapFrames.lua".into(), t(crate::emit::emit_map_frames(&frames, &id))));
	let main_entries: Vec<V> = main.iter().map(entry).collect();
	let mut gl = crate::emit::emit_guides_with(&main_entries, false, ours);
	if !retired.is_empty() {
		gl.push_str(&crate::emit::emit_retired(&id, retired));
	}
	gl.push_str(&crate::emit::emit_experimental(offers));
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

	/// The pack check ([`compile_checked`]) on every guide of a folder, as `playtest --honest` and the
	/// report compile a whole pack.
	pub fn check_tree(dir: &Path, data: &Data) -> Result<(), String> {
		let shown = shown(dir);
		let sources: Vec<Source> = read_sources(dir, &find_guide_files(dir, false)).into_iter().map(|s| Source { file: format!("{shown}/{}", s.source), ..s }).collect();
		compile_checked(&sources, data, &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).map(|_| ())
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

	/// Polestar's own extra pack (OWN_EXTRAS) whose folder in checkout `root` is `dir`, if any (locate.js
	/// ownExtra): read with manifest.rs read_extra_manifest, built as Polestar's.
	pub fn own_extra_at(root: &Path, dir: &Path) -> Option<&'static OwnExtra> {
		OWN_EXTRAS.iter().find(|e| same_path(dir, &root.join(e.source)))
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
		/// Leveling guides whose baked legs are stale (read_legs_text): they ship without legs.
		pub stale_legs: Vec<String>,
		/// Leveling guides legs.json has no legs for (unbaked_legs): they ship without legs too.
		pub unbaked_legs: Vec<String>,
	}

	/// compileProject for a pack folder; `context`: our guides, read as context for another pack.
	pub fn compile_project(pack_dir: &Path, manifest: &V, data: &Data, mut diag: Diagnostics, include_drafts: bool, context: Option<Context>) -> Project {
		let sources = find_guide_files(pack_dir, include_drafts);
		let opts = CompileOpts { pack: manifest.get("id").as_str().map(str::to_string), author: manifest.get("author").as_str().map(str::to_string), context, pack_dir: Some(pack_dir.to_path_buf()) };
		let c = compile_sources(&read_sources(pack_dir, &sources), data, &mut diag, &opts);
		let retired_file = pack_dir.join("retired.json");
		let retired = read_retired_text(pack_text(pack_dir, "retired.json", &mut diag).as_deref(), &retired_file.to_string_lossy(), &c.guides, &mut diag);
		let legs_file = pack_dir.join("legs.json");
		let legs_text = pack_text(pack_dir, "legs.json", &mut diag);
		let stale_legs = read_legs_text(legs_text.as_deref(), &legs_file.to_string_lossy(), &c.guides, data, &mut diag);
		let unbaked_legs = unbaked_legs(legs_text.as_deref(), &c.guides);
		Project { guides: c.guides, diag, sources, retired, tokens: c.tokens, stale_legs, unbaked_legs }
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
		// Our pack's texts share the language folder with the game's names (`forge data names`) and the
		// interface strings: only the texts' own files are written or removed there, and the folder goes
		// once it holds neither.
		let shared = base == OWN_FOLDER;
		for folder in texts.iter().chain(parts.iter()).chain(factions.iter()) {
			let dir = parent.join(folder);
			let language = shared && texts.iter().any(|t| t == folder);
			match siblings.get(folder) {
				None if language => {
					if refusal(folder).is_none() {
						let _ = std::fs::remove_file(dir.join("Texts.lua"));
						if entries(&dir).is_some_and(|l| !l.iter().any(|e| e.file_name() == "Names.lua" || e.file_name() == crate::toc::INTERFACE_FILE)) {
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

	/// The guides of Polestar's own extra packs (OWN_EXTRAS) in checkout `root` (each one's folder with its
	/// pack.json), resolved with `data` and localised; their own diagnostics are their pack's lint's.
	pub fn read_extras(root: &Path, data: &Data) -> Vec<V> {
		let mut out = Vec::new();
		for e in &OWN_EXTRAS {
			let dir = root.join(e.source);
			if !dir.join("pack.json").is_file() {
				continue;
			}
			let sources = read_sources(&dir, &find_guide_files(&dir, false));
			let guides = resolve_sources(&sources, data, &mut Diagnostics::new(), Some(e.id), Some("Polestar"));
			localise(&guides, data, &mut Diagnostics::new());
			out.extend(guides);
		}
		out
	}

	/// buildPack for a pack folder: compile (with our guides as context for another pack), the pack's
	/// translations (warnings), and, when `force` or there are no errors, the files. `extra` diagnostics
	/// (pack.json's) are appended. Our pack also reads the extra packs' guides beside it (read_extras) for
	/// the experimental index its route choices need ([`experimental_index`]: its checks are our errors).
	pub fn build_pack(root: &Path, pack_dir: &Path, manifest: &V, extra: Vec<crate::diag::Diag>, data: &Data, data_warnings: Diagnostics, opts: BuildOpts) -> Result<Built, String> {
		let force = opts.force;
		let mut project = compile_project(pack_dir, manifest, data, data_warnings, opts.include_drafts, opts.context);
		project.diag.list.extend(extra);
		// Read only when a `next` line of ours names an extra pack's guide.
		let offering = manifest.get("id").as_str() == Some("guides") && project.guides.iter().any(|g| next_list(g).iter().any(|t| extra_of(t).is_some()));
		let offers = if offering { experimental_index(&project.guides, &read_extras(root, data), data, &mut project.diag) } else { Vec::new() };
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
			Some(build_pack_files(&project.guides, manifest, data, license.as_deref(), &translations, &project.retired, &offers, &iface, images))
		} else {
			None
		};
		Ok(Built { project, files })
	}
}
