//! Port of tools/lib/pack/format.js.
//!
//! The guide pack contract shared by the compiler, lint and the pack commands.

use crate::emit::header;
use crate::js::V;

// The pack format the compiler writes, and the first Polestar version that
// reads each format (written into the TOC as X-Polestar-Needs). Format 2
// adds `group` (docs/PACK_FORMAT.md, "Format 2"); format 4 adds a step's
// `when`, `label` and `along`, a level goal's `frac` and a `next` option's
// `when` (`nextWhen`); format 5 adds the `money`, `task`, `enter`, `cast`, `abandon`, `destroy` and `die` goals, the
// `money`, `dungeon`, `upgrade`, `done`, `skill`, `cooldown`, `group` and `knows` when predicates and a step's `skipto`; a pack is written in the first format its guides
// need (format_for): a pack without any stays readable by Polestar 0.2.5.
pub const FORMAT: u32 = 3;
pub const WHEN_FORMAT: u32 = 4;
pub const MONEY_TASK_FORMAT: u32 = 5;
/// Format 6 (read, no longer written): a guide's baked legs inline (`legs`). Format 7: baked legs
/// in the race parts' Legs.lua (Polestar.RegisterLegs; legs.json, forge guide bake).
pub const LEGS_FORMAT: u32 = 7;
/// Format 8: Polestar's own pack written for memory (project.rs build_pack_files): a goal's spawn
/// spots as one string (`spotsPacked`) and the guides of each faction in a part of their own.
pub const PACKED_FORMAT: u32 = 8;

/// NEEDS[format]: the first Polestar version that reads it (`undefined` -> None).
pub fn needs(format: u32) -> Option<&'static str> {
	Some(match format {
		1 => "0.1.0",
		2 => "0.2.4",
		3 => "0.2.5",
		4 => "0.2.6",
		5..=8 => "0.3.0",
		_ => return None,
	})
}

/// A step with `label` or `along` (an older Polestar would stop at an along step).
fn uses_along(s: &V) -> bool {
	!s.get("label").is_undef() || !s.get("along").is_undef()
}

/// A `level` goal with `frac` (a point inside the level) needs format 4:
/// an older Polestar would count it done at the start of the level.
fn uses_level_frac(g: &V) -> bool {
	g.get("steps").items().iter().any(|s| s.get("goals").items().iter().any(|goal| goal.get("t").as_str() == Some("level") && goal.get("frac").truthy()))
}

// The `money`, `task`, `enter`, `cast`, `abandon`, `destroy` and `die` goals, the `money`, `dungeon`, `upgrade`, `done`,
// `skill`, `cooldown`, `group` and `knows` when predicates (on a step or a `next` option) and a
// step's `skipto` need format 5: a 0.2.6 client would accept a format-4 pack
// but refuse these with "unknown verb" or "bad when" rather than "needs
// Polestar 0.3.0", and would never take a `skipto` jump.
const MONEY_TASK_VERBS: [&str; 7] = ["money", "task", "enter", "cast", "abandon", "destroy", "die"];
const FORMAT5_WHEN: [&str; 8] = ["money", "dungeon", "upgrade", "done", "skill", "cooldown", "group", "knows"];

fn in_set(set: &[&str], v: &V) -> bool {
	v.as_str().is_some_and(|s| set.contains(&s))
}

fn needs5(list: &V) -> bool {
	list.items().iter().any(|p| in_set(&FORMAT5_WHEN, &p.get("k")))
}

fn uses_money_task(g: &V) -> bool {
	g.get("steps")
		.items()
		.iter()
		.any(|s| s.get("goals").items().iter().any(|goal| in_set(&MONEY_TASK_VERBS, &goal.get("t"))) || needs5(&s.get("when")) || s.get("skipto").as_arr().is_some_and(|a| !a.is_empty()))
		|| g.get("nextWhen").values().iter().any(needs5)
}

fn has_keys(v: &V) -> bool {
	v.truthy() && !v.keys().is_empty()
}

/// The format a pack's compiled guides need: MONEY_TASK_FORMAT when a guide
/// uses money/task/enter/cast/abandon/destroy goals, a money, dungeon, upgrade, done, skill, cooldown, group or knows when predicate or a
/// `skipto`, WHEN_FORMAT when a step
/// has `when`, `label` or `along`, a level goal has `frac`, or a `next`
/// option has `when` (`nextWhen`), else FORMAT. A pack with baked legs is
/// LEGS_FORMAT (project.rs build_pack_files).
pub fn format_for(guides: &[V]) -> u32 {
	if guides.iter().any(uses_money_task) {
		return MONEY_TASK_FORMAT;
	}
	let uses = guides.iter().any(|g| g.get("steps").items().iter().any(|s| s.get("when").as_arr().is_some_and(|a| !a.is_empty()) || uses_along(s)));
	if uses || guides.iter().any(uses_level_frac) {
		return WHEN_FORMAT;
	}
	let next_when = guides.iter().any(|g| has_keys(&g.get("nextWhen")));
	if next_when {
		return WHEN_FORMAT;
	}
	FORMAT
}

/// PACK_ID_RE: /^[a-z0-9][a-z0-9-]{1,31}$/
pub fn is_pack_id(s: &str) -> bool {
	let b = s.as_bytes();
	(2..=32).contains(&b.len()) && (b[0].is_ascii_lowercase() || b[0].is_ascii_digit()) && b[1..].iter().all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || *c == b'-')
}

/// FOLDER_RE: /^[A-Za-z0-9_-]{1,64}$/
pub fn is_folder(s: &str) -> bool {
	(1..=64).contains(&s.len()) && s.bytes().all(|c| c.is_ascii_alphanumeric() || c == b'_' || c == b'-')
}

/// RESERVED_IDS, in its insertion order.
pub const RESERVED_IDS: [&str; 6] = ["guides", "forever", "lookup", "draft", "polestar", "imported"];

/// The command that builds a pack folder, named in every file it writes.
pub const COMPILE_COMMAND: &str = "forge guide compile";

/// A folder we generated says so in its TOC (and the old layout in Pack.xml):
/// only such a folder is ever replaced by compile, install or dev.
pub const GENERATED_MARKER: &str = "Generated by `forge guide compile`";
/// The marker of folders the JS compiler built: released packs and installed folders carry it.
pub const LEGACY_GENERATED_MARKER: &str = "Generated by `node tools/polestar.js compile`";

/// Whether a TOC's (or Pack.xml's) text carries the marker, new or legacy.
pub fn is_generated(text: &str) -> bool {
	text.contains(GENERATED_MARKER) || text.contains(LEGACY_GENERATED_MARKER)
}

/// TOC_MARKER: the TOC's comment line carrying the marker.
pub fn toc_marker() -> String {
	header("guide", COMPILE_COMMAND, "pack.json and the .guide files")
}

/// What a community addon's TOC Title starts with, so the AddOns list reads it
/// as one (Core/Guides.lua drops it again for the Community guides page).
/// Community addons built before the rename carry the legacy prefix.
pub const TOC_TITLE_PREFIX: &str = "Polestar Community: ";
pub const LEGACY_TOC_TITLE_PREFIX: &str = "Polestar Pack: ";

/// Our pack `guides` owns forever/ and draft/; every other pack owns `<id>/`.
pub fn owns_guide_id(pack_id: &str, guide_id: &str) -> bool {
	if pack_id == "guides" {
		return guide_id.starts_with("forever/") || guide_id.starts_with("draft/");
	}
	guide_id.starts_with(&format!("{pack_id}/"))
}

/// "Joe's Routes" -> "PolestarPack_JoesRoutes"; a title with no letters or
/// digits falls back to the id ("joe-routes" -> "PolestarPack_JoeRoutes").
/// `None` stands for a missing value (`String(s || '')`).
pub fn default_folder(title: Option<&str>, id: Option<&str>) -> String {
	let camel = |s: Option<&str>| -> String {
		let s = s.unwrap_or("").replace(['\'', '\u{2019}'], "");
		s.split(|c: char| !c.is_ascii_alphanumeric())
			.filter(|w| !w.is_empty())
			.map(|w| {
				let mut c = w.chars();
				let first = c.next().unwrap();
				format!("{}{}", first.to_ascii_uppercase(), c.as_str())
			})
			.collect()
	};
	let mut name = camel(title);
	if name.is_empty() {
		name = camel(id);
	}
	// ASCII only, so a byte slice is the JS UTF-16 slice.
	let mut out = format!("PolestarPack_{name}");
	out.truncate(64);
	out
}

/// The line `new` writes into LICENSE for a licence it has no text for; lint
/// warns while the pack's LICENSE still holds it.
pub const LICENSE_PLACEHOLDER: &str = "replace this line with the full text of that licence";

pub fn placeholder_license(license: &str) -> String {
	format!("Licensed under {license}: {LICENSE_PLACEHOLDER}.\n")
}
