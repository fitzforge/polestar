//! The planner's Rust half in the browser (Forge): the guide compiler (per guide as the planner edits, the
//! pack lint, the addon files) and the simulator's hours for a start (forge-judge's walk with
//! forge-sim's evaluator, `SimLevels`), from the files the page fetches (no server beyond static
//! hosting). The browser planner (www-build/) runs the planner's commands in a worker over this.
//!
//! ```ignore
//! let mut p = Planner::new(&data_texts, &instances_json, &areas_json)?;
//! p.set_pack(&Pack { manifest, legs, retired, license, translations, iface })?;
//! let (guide, diags) = p.compile_guide("forever/horde/01-durotar.guide", "guides/forever/horde/01-durotar.guide", &text);
//! p.set_world("Horde", &world_bytes, Some(&params_json))?;
//! let h = p.hours(&Character { faction: "Horde".into(), race: "Orc".into(), cls: None }, None)?;
//! ```

use forge_core::frames::Projector;
use forge_core::MapFrames;
use forge_guide::data::Data;
use forge_guide::diag::{Diag, Diagnostics};
use forge_guide::js::{cmp_utf16, parse_json, stringify, V};
use forge_guide::project::{build_pack_files, compile_sources, read_legs_text, read_retired_text, CompileOpts, FileContent, Source};
use forge_judge::levels::SimLevels;
use forge_judge::walk::{background, walk_chain, Chain, Ctx, WalkGoal};
use rustc_hash::FxHashMap;
use serde::Serialize;
use serde_json::{json, Value};

#[cfg(target_arch = "wasm32")]
mod bindings;

/// The character a start is played by.
#[derive(Clone, Debug)]
pub struct Character {
	pub faction: String,
	pub race: String,
	pub cls: Option<String>,
}

/// The pack's files besides its guides (texts as on disk; None: absent).
#[derive(Clone, Debug, Default)]
pub struct Pack {
	/// pack.json.
	pub manifest: String,
	pub legs: Option<String>,
	pub retired: Option<String>,
	pub license: Option<String>,
	/// The pack's translations as `pack_translations` read them natively when the bundle was made
	/// ({ <locale>: { pack, guides } }; "{}": none).
	pub translations: Option<String>,
	/// The core TOC's `## Interface:` value.
	pub iface: String,
}

struct Entry {
	/// Pack-relative path (the compiler's `source`).
	source: String,
	/// The path diagnostics name.
	file: String,
	text: String,
	guide: Option<V>,
}

pub struct Planner {
	data: Data,
	frames: MapFrames,
	files: Vec<Entry>,
	pack: Pack,
	manifest: V,
	worlds: FxHashMap<String, (forge_world::World, Option<Value>)>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct GuideSpan {
	pub id: String,
	pub start: f64,
	pub end: f64,
	pub level_start: f64,
	pub level_end: f64,
	pub goals: usize,
}

/// The simulator's hours for a start (`forge judge report`'s numbers).
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Hours {
	pub character: Value,
	pub chain: Vec<String>,
	/// Hours to level 30 as `report` counts them (the walk cut at the first goal begun at 30 or above).
	pub hours30: Option<f64>,
	pub hours60: f64,
	pub end_level: f64,
	pub goals: usize,
	pub skipped: usize,
	pub quests_done: usize,
	pub zone_changes: usize,
	pub continent_changes: usize,
	/// Per guide of the chain, in walk order.
	pub guides: Vec<GuideSpan>,
}

/// A diagnostic as the planner shows it.
pub fn diag_json(d: &Diag) -> Value {
	let mut o = json!({ "file": d.file, "line": d.line, "severity": d.severity, "message": d.message });
	if let Some(h) = &d.hint {
		o["hint"] = json!(h);
	}
	o
}

/// The compiler's hidden (non-enumerable) properties the planner's JS reads (tools/lib/dsl: `_ast`,
/// `_line`, ...), written as keys "\u0000<name>" so the page can define them non-enumerable again.
const HIDDEN: [&str; 8] = ["_ast", "_line", "_only", "_plurals", "_localised", "_imageFile", "_imageSpec", "spans"];

/// JSON.stringify with the hidden properties (see HIDDEN).
pub fn to_json_hidden(v: &V) -> String {
	let mut out = String::new();
	write_hidden(&mut out, v);
	out
}

fn write_hidden(out: &mut String, v: &V) {
	match v {
		V::Arr(a) => {
			out.push('[');
			for (i, x) in a.to_vec().iter().enumerate() {
				if i > 0 {
					out.push(',');
				}
				if x.is_undef() {
					out.push_str("null");
				} else {
					write_hidden(out, x);
				}
			}
			out.push(']');
		}
		V::Obj(o) => {
			out.push('{');
			let mut any = false;
			let mut key = |out: &mut String, k: &str, x: &V| {
				if any {
					out.push(',');
				}
				any = true;
				out.push_str(&stringify(&V::Str(k.into()), None));
				out.push(':');
				write_hidden(out, x);
			};
			for (k, x) in o.entries() {
				if !x.is_undef() {
					key(out, &k, &x);
				}
			}
			for h in HIDDEN {
				let x = o.hidden(h);
				if !x.is_undef() {
					key(out, &format!("\u{0}{h}"), &x);
				}
			}
			out.push('}');
		}
		_ => out.push_str(&stringify(v, None)),
	}
}

/// forge-guide tokens.rs's memo key for the spell names.
const SPELL_NAMES_MEMO: &str = "tokens.spellNames";

/// Hours at the walk cut at `to` (the first goal begun at level `to` or above; the hours of the goal before).
fn hours_at(goals: &[WalkGoal], to: f64) -> Option<f64> {
	let cut = goals.iter().position(|g| g.lvl >= to)?;
	Some(goals[..cut].last().map_or(0.0, |g| g.time_after / 3600.0))
}

impl Planner {
	/// `texts`: the reference data files by name (`quests`, `npcs`, `map-frames`, ...: the JSON texts);
	/// `instances`, `areas`: the compiler's client tables as JSON ("" or "null" when absent).
	pub fn new(texts: &FxHashMap<String, String>, instances: &str, areas: &str) -> Result<Planner, String> {
		let parse = |s: &str, what: &str| -> Result<V, String> {
			if s.trim().is_empty() {
				Ok(V::Null)
			} else {
				parse_json(s).map_err(|e| format!("{what}: {e}"))
			}
		};
		let data = Data::from_texts(texts, parse(instances, "instances.json")?, parse(areas, "areas.json")?, None)?;
		let frames = MapFrames::from_json(texts.get("map-frames").map_or("{}", String::as_str).as_bytes()).map_err(|e| format!("map-frames.json: {e}"))?;
		Ok(Planner { data, frames, files: Vec::new(), pack: Pack::default(), manifest: V::obj(), worlds: FxHashMap::default() })
	}

	/// The spell names the compiler's texts read from the client's SpellName table (native only:
	/// `tokens::read_spell_names`), as the bundle exported them: JSON [[name, id], ...].
	pub fn set_spell_names(&mut self, json: &str) -> Result<(), String> {
		let v = parse_json(json).map_err(|e| format!("spell names: {e}"))?;
		self.data.memo.borrow_mut().insert(SPELL_NAMES_MEMO, v);
		Ok(())
	}

	/// The pack's own files (its id and author name the guides' pack, as compile_project does).
	pub fn set_pack(&mut self, pack: Pack) -> Result<(), String> {
		self.manifest = parse_json(&pack.manifest).map_err(|e| format!("pack.json: {e}"))?;
		self.pack = pack;
		Ok(())
	}

	fn opts(&self) -> CompileOpts<'static> {
		CompileOpts { pack: self.manifest.get("id").as_str().map(str::to_string), author: self.manifest.get("author").as_str().map(str::to_string), context: None, pack_dir: None }
	}

	/// Compile one guide file (`source`: pack-relative path; `file`: the path diagnostics name) as the
	/// planner does on load and on every edit (parse and resolve, the pack's id and author), and keep it
	/// for the hours, the lint and the addon files. -> (the guide, None without a guide id; its diagnostics).
	pub fn compile_guide(&mut self, source: &str, file: &str, text: &str) -> (Option<V>, Vec<Diag>) {
		let mut diag = Diagnostics::new();
		let o = self.opts();
		let ast = forge_guide::parse::parse_guide(text, file, &mut diag);
		let guide = if ast.truthy() && ast.get("id").truthy() {
			ast.set("source", source);
			Some(forge_guide::resolve::resolve_guide(&ast, &self.data, &mut diag, o.pack.as_deref(), o.author.as_deref()))
		} else {
			None
		};
		let e = Entry { source: source.to_string(), file: file.to_string(), text: text.to_string(), guide: guide.clone() };
		match self.files.binary_search_by(|x| cmp_utf16(&x.source, source)) {
			Ok(i) => self.files[i] = e,
			Err(i) => self.files.insert(i, e),
		}
		(guide, diag.sorted())
	}

	/// A guide file deleted.
	pub fn remove_guide(&mut self, source: &str) {
		self.files.retain(|e| e.source != source);
	}

	/// Every kept guide file compiled at once (load).
	pub fn set_guides(&mut self, files: &[(String, String, String)]) -> usize {
		self.files.clear();
		for (source, file, text) in files {
			self.compile_guide(source, file, text);
		}
		self.files.iter().filter(|e| e.guide.is_some()).count()
	}

	fn sources(&self) -> Vec<Source> {
		self.files.iter().map(|e| Source { source: e.source.clone(), file: e.file.clone(), text: e.text.clone() }).collect()
	}

	/// The pack compiled as `compile_project` does (every guide, cross-guide checks, retired.json, legs.json).
	fn project(&self) -> (Vec<V>, Diagnostics, Vec<String>) {
		let mut diag = Diagnostics::new();
		let c = compile_sources(&self.sources(), &self.data, &mut diag, &self.opts());
		let retired = read_retired_text(self.pack.retired.as_deref(), "retired.json", &c.guides, &mut diag);
		read_legs_text(self.pack.legs.as_deref(), "legs.json", &c.guides, &self.data, &mut diag);
		(c.guides, diag, retired)
	}

	/// The pack's lint (the planner's full compile check: build_pack without the files).
	pub fn lint(&self) -> Vec<Diag> {
		let (_, mut diag, _) = self.project();
		self.license_warning(&mut diag);
		diag.sorted()
	}

	fn license_warning(&self, diag: &mut Diagnostics) {
		let Some(text) = &self.pack.license else { return };
		if let Some(at) = text.split('\n').map(|l| l.strip_suffix('\r').unwrap_or(l)).position(|l| l.contains(forge_guide::format::LICENSE_PLACEHOLDER)) {
			diag.warn(
				"LICENSE",
				(at + 1) as f64,
				"LICENSE still holds the placeholder line `polestar new` writes, not the licence text",
				Some(format!("replace the line with the full text of the {} licence: the built addon ships LICENSE as LICENSE.txt", self.manifest.get("license"))),
			);
		}
	}

	/// The addon folder (`build_pack`): its files when the pack compiles without errors, and the
	/// diagnostics. Pictures are not bundled: a guide naming one is an error here.
	pub fn pack_files(&self) -> (Option<Vec<(String, FileContent)>>, Vec<Diag>) {
		let (guides, mut diag, retired) = self.project();
		self.license_warning(&mut diag);
		for g in &guides {
			for st in g.get("steps").items() {
				if st.get("image").truthy() {
					diag.error(&g.hidden("_ast").get("file").to_js_string(), st.hidden("_line").num(), "pictures are not in the browser bundle; compile this pack with `polestar compile`", None);
				}
			}
		}
		if diag.has_errors() {
			return (None, diag.sorted());
		}
		let translations = self.pack.translations.as_deref().and_then(|t| parse_json(t).ok()).unwrap_or_else(V::obj);
		let files = build_pack_files(&guides, &self.manifest, &self.data, self.pack.license.as_deref(), &translations, &retired, &self.pack.iface, Vec::new());
		(Some(files), diag.sorted())
	}

	/// The faction's sim world (`world-<faction>.json`) and the sim's params (`params.json`).
	pub fn set_world(&mut self, faction: &str, world: &[u8], params: Option<&str>) -> Result<(), String> {
		let w = forge_world::World::from_json(world)?;
		let p = match params {
			Some(t) if !t.trim().is_empty() => Some(serde_json::from_str::<Value>(t).map_err(|e| format!("params.json: {e}"))?),
			_ => None,
		};
		self.worlds.insert(faction.to_string(), (w, p));
		Ok(())
	}

	pub fn has_world(&self, faction: &str) -> bool {
		self.worlds.contains_key(faction)
	}

	/// The start's hours to 60 with the simulator's levels: its chain (`chain`: these guide ids, else the
	/// pack's default route for the character) walked as `forge judge report` walks it.
	pub fn hours(&self, ch: &Character, chain: Option<Vec<String>>) -> Result<Hours, String> {
		let (world, params) = self.worlds.get(&ch.faction).ok_or_else(|| format!("no world for {} loaded", ch.faction))?;
		let lv = SimLevels::new(world, &ch.race, params.as_ref())?;
		let ctx = Ctx::new(&ch.faction, &ch.race, ch.cls.as_deref())?;
		let proj = Projector::new(&self.frames);
		let guides: Vec<V> = self.files.iter().filter_map(|e| e.guide.clone()).collect();
		read_legs_text(self.pack.legs.as_deref(), "legs.json", &guides, &self.data, &mut Diagnostics::new());
		let file_of = |g: &V| g.hidden("_ast").get("file").to_js_string();
		let walk = walk_chain(&guides, &file_of, chain.map_or(Chain::Routes, Chain::Ids), &ctx, &proj, &lv, 61.0)?;
		let bg = background(&walk.goals);
		let mut spans: Vec<GuideSpan> = Vec::new();
		for g in &walk.goals {
			match spans.last_mut() {
				Some(s) if s.id == g.guide => {
					s.end = g.time_after;
					s.level_end = g.lvl_after;
					s.goals += 1;
				}
				_ => spans.push(GuideSpan { id: g.guide.clone(), start: g.time, end: g.time_after, level_start: g.lvl, level_end: g.lvl_after, goals: 1 }),
			}
		}
		Ok(Hours {
			character: json!({ "faction": ch.faction, "race": ch.race, "cls": ch.cls }),
			hours30: hours_at(&walk.goals, 30.0),
			hours60: walk.hours,
			end_level: walk.end_level,
			goals: walk.goals.len(),
			skipped: walk.skipped,
			quests_done: bg.quests_done,
			zone_changes: bg.zone_changes,
			continent_changes: bg.continent_changes,
			chain: walk.chain,
			guides: spans,
		})
	}
}
