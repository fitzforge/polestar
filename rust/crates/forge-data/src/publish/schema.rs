//! The release's clean schema: one definition per table, written out as JSON Schema 2020-12
//! (`schema/<table>.schema.json`) and used to validate every row.

use serde_json::{json, Map, Value};

/// Bumped only when a field changes meaning or is removed.
pub const SCHEMA_VERSION: i64 = 1;

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Ty {
	/// A whole number at or above the minimum.
	Int(i64),
	/// One of these whole numbers.
	IntOf(&'static [i64]),
	Num,
	Str,
	Bool,
	OneOf(&'static [&'static str]),
	/// `{map, x, y}` in world yards.
	Place,
	/// Any JSON object (our own parameter words).
	Object,
}

pub struct Col {
	pub name: &'static str,
	pub ty: Ty,
	pub required: bool,
	pub about: &'static str,
}

pub struct TableDef {
	pub name: &'static str,
	pub about: &'static str,
	/// The columns that identify a row.
	pub key: &'static [&'static str],
	pub cols: &'static [Col],
	/// Our own layer (CC BY 4.0) rather than the source-backed tier (GPL-3.0).
	pub own_layer: bool,
}

const fn c(name: &'static str, ty: Ty, required: bool, about: &'static str) -> Col {
	Col { name, ty, required, about }
}

const ENT: &[&str] = &["npc", "object", "item"];

pub const TABLES: &[TableDef] = &[
	TableDef {
		name: "quest",
		about: "One row per quest id.",
		key: &["id"],
		own_layer: false,
		cols: &[
			c("id", Ty::Int(1), true, "client quest id"),
			c("title", Ty::Str, false, "quest title"),
			c("level", Ty::Int(1), false, "quest level"),
			c("min_level", Ty::Int(1), false, "minimum character level"),
			c("races", Ty::Int(0), false, "client race bitmask; 0 = every race"),
			c("classes", Ty::Int(0), false, "client class bitmask; 0 = every class"),
			c("side", Ty::IntOf(&[0, 1, 2]), false, "0 both, 1 Alliance, 2 Horde"),
			c("xp", Ty::Int(1), false, "turn-in experience at the quest's level"),
			c("money_copper", Ty::Int(1), false, "money reward in copper"),
			c("type", Ty::Int(0), false, "client QuestInfo id"),
			c("zone_area", Ty::Int(1), false, "client AreaTable id of the quest's zone"),
			c("repeatable", Ty::Bool, false, "the quest can be done again"),
		],
	},
	TableDef {
		name: "quest_start",
		about: "What offers a quest.",
		key: &["quest", "kind", "id"],
		own_layer: false,
		cols: &[c("quest", Ty::Int(1), true, "quest id"), c("kind", Ty::OneOf(ENT), true, "npc, object or item"), c("id", Ty::Int(1), true, "npc, object or item id")],
	},
	TableDef {
		name: "quest_end",
		about: "Where a quest is turned in.",
		key: &["quest", "kind", "id"],
		own_layer: false,
		cols: &[c("quest", Ty::Int(1), true, "quest id"), c("kind", Ty::OneOf(&["npc", "object"]), true, "npc or object"), c("id", Ty::Int(1), true, "npc or object id")],
	},
	TableDef {
		name: "quest_objective",
		about: "A quest's objectives in order.",
		key: &["quest", "n"],
		own_layer: false,
		cols: &[
			c("quest", Ty::Int(1), true, "quest id"),
			c("n", Ty::Int(1), true, "position, from 1"),
			c("kind", Ty::OneOf(&["kill", "item", "object", "event", "talk"]), true, "what the objective asks"),
			c("target", Ty::Int(1), false, "npc, item or object id"),
			c("count", Ty::Int(1), false, "how many"),
		],
	},
	TableDef {
		name: "quest_prereq",
		about: "Quests that open a quest.",
		key: &["quest", "pre"],
		own_layer: false,
		cols: &[
			c("quest", Ty::Int(1), true, "quest id"),
			c("pre", Ty::Int(1), true, "the earlier quest"),
			c("mode", Ty::OneOf(&["all", "any"]), true, "all: every such quest is needed; any: one of them"),
			c("breadcrumb", Ty::Bool, false, "the earlier quest only leads to this one"),
		],
	},
	TableDef {
		name: "quest_reward",
		about: "Items, item choices and reputation a quest gives.",
		key: &["quest", "kind", "id"],
		own_layer: false,
		cols: &[
			c("quest", Ty::Int(1), true, "quest id"),
			c("kind", Ty::OneOf(&["item", "choice", "rep"]), true, "item, choice or rep"),
			c("id", Ty::Int(1), true, "item id or client Faction id"),
			c("count", Ty::Int(i64::MIN), false, "items given, or reputation points"),
		],
	},
	TableDef {
		name: "npc",
		about: "One row per creature id.",
		key: &["id"],
		own_layer: false,
		cols: &[
			c("id", Ty::Int(1), true, "client creature id"),
			c("name", Ty::Str, false, "name"),
			c("subname", Ty::Str, false, "title under the name"),
			c("level_min", Ty::Int(1), false, "lowest level"),
			c("level_max", Ty::Int(1), false, "highest level"),
			c("faction_template", Ty::Int(0), false, "client FactionTemplate id"),
			c("rank", Ty::Int(0), false, "0 normal, 1 elite, 2 rare elite, 3 boss, 4 rare"),
		],
	},
	TableDef {
		name: "object",
		about: "One row per game object id.",
		key: &["id"],
		own_layer: false,
		cols: &[c("id", Ty::Int(1), true, "client game object id"), c("name", Ty::Str, false, "name"), c("type", Ty::Int(0), false, "client game object type")],
	},
	TableDef {
		name: "spawn",
		about: "Spawn points in world yards on the continent or instance map.",
		key: &["kind", "id", "map", "n"],
		own_layer: false,
		cols: &[
			c("kind", Ty::OneOf(&["npc", "object"]), true, "npc or object"),
			c("id", Ty::Int(1), true, "npc or object id"),
			c("map", Ty::Int(0), true, "client Map id"),
			c("n", Ty::Int(1), true, "point number on that map, from 1"),
			c("x", Ty::Num, true, "world x (north), 0.5 yd"),
			c("y", Ty::Num, true, "world y (west), 0.5 yd"),
			c("z", Ty::Num, false, "height, 0.1 yd"),
		],
	},
	TableDef {
		name: "item",
		about: "One row per item id.",
		key: &["id"],
		own_layer: false,
		cols: &[c("id", Ty::Int(1), true, "client item id"), c("name", Ty::Str, false, "name"), c("quest_item", Ty::Bool, false, "a quest item")],
	},
	TableDef {
		name: "item_source",
		about: "Where a quest-relevant item comes from.",
		key: &["item", "kind", "id"],
		own_layer: false,
		cols: &[
			c("item", Ty::Int(1), true, "item id"),
			c("kind", Ty::OneOf(ENT), true, "npc, object or item (a container)"),
			c("id", Ty::Int(1), true, "npc, object or container item id"),
			c("chance", Ty::Num, false, "designed loot chance in percent, 0.1"),
		],
	},
	TableDef {
		name: "ui_map",
		about: "The in-game map frames: where each client UiMap lies in world yards, for turning world yards into map percent.",
		key: &["ui_map"],
		own_layer: false,
		cols: &[
			c("ui_map", Ty::Int(1), true, "client UiMap id"),
			c("map", Ty::Int(0), true, "client Map id (continent or instance) the frame lies on"),
			c("left", Ty::Num, true, "world y at the map's left edge (x = 0%)"),
			c("right", Ty::Num, true, "world y at the map's right edge (x = 100%)"),
			c("top", Ty::Num, true, "world x at the map's top edge (y = 0%)"),
			c("bottom", Ty::Num, true, "world x at the map's bottom edge (y = 100%)"),
		],
	},
	TableDef {
		name: "mechanic",
		about: "How a quest plays out beyond its objectives, in our own words.",
		key: &["quest", "kind"],
		own_layer: true,
		cols: &[c("quest", Ty::Int(1), true, "quest id"), c("kind", Ty::Str, true, "mechanic kind"), c("params", Ty::Object, true, "the mechanic's parameters")],
	},
	TableDef {
		name: "step",
		about: "Ordered quest steps from structured data, in our own words.",
		key: &["quest", "n"],
		own_layer: true,
		cols: &[
			c("quest", Ty::Int(1), true, "quest id"),
			c("n", Ty::Int(1), true, "step number (display order only)"),
			c("id", Ty::Str, true, "stable id <quest>:s:<hash>: kept when the wording or the order changes; note fixes name it"),
			c("action", Ty::Str, true, "what to do"),
			c("target_kind", Ty::Str, false, "npc, object, item or area"),
			c("target", Ty::Int(1), false, "target id"),
			c("count", Ty::Int(1), false, "how many"),
			c("place", Ty::Place, false, "where, in world yards"),
			c("text", Ty::Str, false, "the step in our words"),
			c("confidence", Ty::OneOf(&["unconfirmed"]), false, "unconfirmed: a community note rewritten as a neutral fact, not yet confirmed from game data"),
		],
	},
	TableDef {
		name: "note",
		about: "Quest notes (timers, spawns, dangers, requirements, tips), in our own words.",
		key: &["quest", "id"],
		own_layer: true,
		cols: &[
			c("quest", Ty::Int(1), true, "quest id"),
			c("id", Ty::Str, true, "stable id <quest>:n:<hash>: kept when the wording or the order changes; note fixes name it"),
			c("kind", Ty::OneOf(&["timer", "spawn", "danger", "requirement", "tip"]), true, "what the note is about"),
			c("text", Ty::Str, true, "the note in our words"),
			c("place", Ty::Place, false, "where, in world yards"),
			c("confidence", Ty::OneOf(&["unconfirmed"]), false, "unconfirmed: a community note rewritten as a neutral fact, not yet confirmed from game data"),
		],
	},
];

pub fn table(name: &str) -> Option<&'static TableDef> {
	TABLES.iter().find(|t| t.name == name)
}

/// The row's key: its key columns' values joined by ':'.
pub fn key_of(def: &TableDef, row: &Map<String, Value>) -> String {
	def.key.iter().map(|k| row.get(*k).map(plain).unwrap_or_default()).collect::<Vec<_>>().join(":")
}

/// A value as plain text (strings unquoted).
pub fn plain(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		v => v.to_string(),
	}
}

fn col_schema(ty: Ty, about: &str) -> Value {
	let mut s = match ty {
		Ty::Int(min) if min == i64::MIN => json!({"type": "integer"}),
		Ty::Int(min) => json!({"type": "integer", "minimum": min}),
		Ty::IntOf(v) => json!({"type": "integer", "enum": v}),
		Ty::Num => json!({"type": "number"}),
		Ty::Str => json!({"type": "string", "minLength": 1}),
		Ty::Bool => json!({"type": "boolean"}),
		Ty::OneOf(v) => json!({"type": "string", "enum": v}),
		Ty::Place => json!({
			"type": "object",
			"additionalProperties": false,
			"required": ["map", "x", "y"],
			"properties": {"map": {"type": "integer", "minimum": 0}, "x": {"type": "number"}, "y": {"type": "number"}}
		}),
		Ty::Object => json!({"type": "object"}),
	};
	s.as_object_mut().unwrap().insert("description".into(), Value::String(about.into()));
	s
}

/// The table's JSON Schema (2020-12).
pub fn json_schema(def: &TableDef) -> Value {
	let mut props = Map::new();
	for c in def.cols {
		props.insert(c.name.into(), col_schema(c.ty, c.about));
	}
	let required: Vec<&str> = def.cols.iter().filter(|c| c.required).map(|c| c.name).collect();
	json!({
		"$schema": "https://json-schema.org/draft/2020-12/schema",
		"$id": format!("schema/{}.schema.json", def.name),
		"title": def.name,
		"description": def.about,
		"type": "object",
		"additionalProperties": false,
		"required": required,
		"properties": props,
	})
}

fn int_of(v: &Value) -> Option<i64> {
	v.as_i64().or_else(|| v.as_u64().and_then(|u| i64::try_from(u).ok()))
}

fn check_ty(ty: Ty, v: &Value) -> Result<(), String> {
	let ok = match ty {
		Ty::Int(min) => int_of(v).is_some_and(|n| n >= min),
		Ty::IntOf(set) => int_of(v).is_some_and(|n| set.contains(&n)),
		Ty::Num => v.is_number(),
		Ty::Str => v.as_str().is_some_and(|s| !s.is_empty()),
		Ty::Bool => v.is_boolean(),
		Ty::OneOf(set) => v.as_str().is_some_and(|s| set.contains(&s)),
		Ty::Object => v.is_object(),
		Ty::Place => {
			return match v.as_object() {
				Some(o) if o.len() == 3 => {
					if o.get("map").and_then(int_of).is_some_and(|m| m >= 0) && o.get("x").is_some_and(Value::is_number) && o.get("y").is_some_and(Value::is_number) {
						Ok(())
					} else {
						Err(format!("bad place {v}"))
					}
				}
				_ => Err(format!("bad place {v}")),
			}
		}
	};
	if ok {
		Ok(())
	} else {
		Err(format!("{v} is not {ty:?}"))
	}
}

/// Validates a row against its table's schema (the same rules the JSON Schema states).
pub fn validate(def: &TableDef, row: &Value) -> Result<(), String> {
	let o = row.as_object().ok_or("row is not an object")?;
	for (k, v) in o {
		let col = def.cols.iter().find(|c| c.name == k).ok_or_else(|| format!("unknown field {k}"))?;
		check_ty(col.ty, v).map_err(|e| format!("{k}: {e}"))?;
	}
	for c in def.cols.iter().filter(|c| c.required) {
		if !o.contains_key(c.name) {
			return Err(format!("missing {}", c.name));
		}
	}
	Ok(())
}
