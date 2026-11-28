//! Class teleports in the planner, on the real addon and its own travel data (Nav/TravelData.lua) and the client's map
//! frames: a Mage's city teleports (Rune of Teleportation), a Druid's Teleport: Moonglade and a Shaman's Astral Recall.
//! Each trial puts the character at a place of the real map and asks the planner for the route to a place far away.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

/// Every map frame of data/forever as stub maps, or None without reference data.
pub fn maps() -> Option<String> {
	let data_dir = root().join("data/forever");
	if !data_dir.join("map-frames.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let mut maps = String::new();
	for era in ["forever", "era"] {
		for (id, f) in data.map_frames.get(era).as_obj().map(|o| o.entries()).unwrap_or_default() {
			let name = data.zones.get(&id).get("name").to_js_string();
			maps.push_str(&format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
				serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
				f.get("c").to_js_string(),
				f.get("left").to_js_string(),
				f.get("right").to_js_string(),
				f.get("top").to_js_string(),
				f.get("bottom").to_js_string()
			));
		}
	}
	Some(maps)
}

/// Lua helpers every trial uses (after login).
pub const HELPERS: &str = r#"
E, N = Polestar.Engine, Polestar.Nav
local w = stub.world
local RUNE = 17031
-- The flight masters the character knows: all of its faction's ("all"), or none.
function flights(mode)
	local f = Polestar.CharState().flags
	f.taxi, f.taxiSeen = {}, { [0] = true, [1] = true, [2991] = true }
	if mode == "all" then
		for _, n in ipairs(N.GetTravelData().taxi) do f.taxi[n.id] = true end
	end
end
-- The route from spec.from = { map, x, y } to spec.to as "kind|label" legs and its seconds (the first leg's, with the rest
-- after it). spec: spells = { id, ... } (the spell book), runes = n, flights = "all"|"none".
function trial(spec)
	w.spells = {}
	for _, id in ipairs(spec.spells or {}) do w.spells[id] = true end
	w.items[RUNE] = (spec.runes or 0) > 0 and spec.runes or nil
	flights(spec.flights or "all")
	w.moveTo(spec.from[1], spec.from[2], spec.from[3])
	N.SetTarget(spec.to[1], spec.to[2], spec.to[3], "Target")
	N.travel.Replan() -- a cooldown or a bag change has no event the plan waits for here
	local legs, ci = N.GetRoute()
	local out, spell = {}, nil
	for i = ci or 1, legs and #legs or 0 do
		local l = legs[i]
		out[#out + 1] = l.kind .. "|" .. l.label
		if l.kind == "teleport" and not spell then spell = l.spell end
	end
	local first = legs and legs[ci or 1]
	return { legs = out, seconds = first and math.floor(first.seconds + first.rest + 0.5) or nil, first = out[1] or false, spell = spell or false }
end
-- Where each class teleport of the travel data lands: spell -> { map, x, y }, read with every spell and rune at hand.
function landings(spells)
	w.spells = {}
	for _, id in ipairs(spells) do w.spells[id] = true end
	w.items[RUNE] = 9
	local out = {}
	for _, t in ipairs(Polestar.Transit.Teleports(0)) do out[t.spell] = { t.to.map, t.to.x, t.to.y, t.name } end
	return out
end

-- Every pair of `places` ({ name, map, x, y }), a Mage of the faction at a level with the spells of `book` (and one rune)
-- against the same Mage without a rune, without the spells (below the learn level) and the walk and ride of a
-- character with no teleports at all. Checks the planner's rules and reports what it chose:
--   used = the spell its route casts; forced[spell] = the way by that teleport (10 s cast, then the best way from its
--   landing); missed = a teleport way over 20% and 60 s faster than the way without teleports that is not taken;
--   bad = a teleport taken that is no faster than the way without.
function matrix(places, book)
	local lands = landings(book)
	local rows, violations, near, stats = {}, {}, {}, { pairs = 0, used = 0, missed = 0, bad = 0 }
	local forcedCache = {}
	local function forced(spell, to)
		local key = spell .. ">" .. to[1] .. ":" .. to[2] .. ":" .. to[3]
		if forcedCache[key] == nil then
			local l = lands[spell]
			local t = trial{ from = { l[1], l[2], l[3] }, to = to, spells = {}, runes = 0 }
			forcedCache[key] = t.seconds and t.seconds + 10 or false
		end
		return forcedCache[key]
	end
	for _, a in ipairs(places) do
		for _, b in ipairs(places) do
			if a ~= b then
				local from, to = { a[2], a[3], a[4] }, { b[2], b[3], b[4] }
				local chosen = trial{ from = from, to = to, spells = book, runes = 1 }
				local norune = trial{ from = from, to = to, spells = book, runes = 0 }
				local below = trial{ from = from, to = to, spells = {}, runes = 3 }
				local base = below.seconds or math.huge
				local used = chosen.spell
				local here = a[2]
				local function bad(why) violations[#violations + 1] = a[1] .. ">" .. b[1] .. ": " .. why end
				if norune.spell then bad("cast without a rune") end
				if below.spell then bad("cast without the spell") end
				if used and lands[used][1] == here then bad("cast to the place it stands in") end
				if used and chosen.first ~= "teleport|Cast " .. lands[used][4] then bad("the teleport is not the first leg: " .. tostring(chosen.first)) end
				if used and chosen.seconds and chosen.seconds > base then bad("a teleport slower than the way without it") ; stats.bad = stats.bad + 1 end
				if used and base < 90 then bad("a teleport over a short way (" .. base .. " s)") end
				local best, bestSpell = math.huge, nil
				for spell in pairs(lands) do
					if lands[spell][1] ~= here then
						local f = forced(spell, to)
						if f and f < best then best, bestSpell = f, spell end
					end
				end
				if not used and bestSpell and best < 0.8 * base and base - best > 60 then
					stats.missed = stats.missed + 1
					-- The planner weighs a teleport by its margin (60 s) in its own cost: a way that is 60 to 120 s faster
					-- is a close call it may take either way; over 120 s faster is a miss.
					if base - best > 120 then
						bad("MISSED: " .. lands[bestSpell][4] .. " " .. best .. " s against " .. tostring(chosen.seconds) .. " s")
					else
						stats.near = (stats.near or 0) + 1
						near[#near + 1] = a[1] .. ">" .. b[1] .. ": " .. lands[bestSpell][4] .. " " .. best .. " s against " .. tostring(chosen.seconds) .. " s"
					end
				end
				stats.pairs = stats.pairs + 1
				if used then stats.used = stats.used + 1 end
				local kinds = {}
				for _, l in ipairs(chosen.legs) do local k = l:match("^(%a+)|"); if kinds[#kinds] ~= k then kinds[#kinds + 1] = k end end
				rows[#rows + 1] = { a[1], b[1], used and lands[used][4] or "-", chosen.seconds or -1, base == math.huge and -1 or base, bestSpell and best ~= math.huge and best or -1, table.concat(kinds, " ") }
			end
		end
	end
	return { rows = rows, violations = violations, near = near, stats = stats }
end
"#;

/// The real addon: a `class` of `race` (`faction`) at `level`, in the world's maps; `script` runs after login.
pub fn run(faction: &str, race: &str, class: &str, level: u32, script: &str) -> Option<Value> {
	let maps = maps()?;
	let raceid = match race {
		"Human" => 1,
		"Orc" => 2,
		"NightElf" => 4,
		"Tauren" => 6,
		other => panic!("no race id for {other}"),
	};
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName, w.raceID, w.faction = \"{race}\", \"{race}\", {raceid}, \"{faction}\"\nw.class, w.className = \"{}\", \"{}\"\nw.level = {level}\nw.moveTo(1411, 51, 41)\n",
		class.to_uppercase(),
		class
	);
	let script = format!("stub.login()\nstub.fire(\"QUEST_LOG_UPDATE\")\n{HELPERS}\n{script}");
	let addons = vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["MapFrames.lua"])];
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons, script, ..Default::default() }).remove(0))
}

fn horde_mage(level: u32, script: &str) -> Option<Value> {
	run("Horde", "Orc", "Mage", level, script)
}
fn alliance_mage(level: u32, script: &str) -> Option<Value> {
	run("Alliance", "Human", "Mage", level, script)
}

/// Where a Mage learns its city teleports in Classic Era: the trainer's level for every one of them. A Mage below it
/// does not have the spell in the spell book, which is all the planner reads (Compat.IsSpellKnown).
const LEARN_LEVEL: u32 = 20;

/// The Mage's spell book at a level: the faction's three city teleports from the learn level, none before.
fn mage_book(faction: &str, level: u32) -> Vec<u32> {
	if level < LEARN_LEVEL {
		return vec![];
	}
	if faction == "Horde" {
		vec![3563, 3566, 3567]
	} else {
		vec![3561, 3562, 3565]
	}
}

fn lua_list(ids: &[u32]) -> String {
	format!("{{ {} }}", ids.iter().map(u32::to_string).collect::<Vec<_>>().join(", "))
}

// Places of the map: { name, uiMap, x, y }.
const ORG: &str = "{ 1454, 50, 60 }";
const DUROTAR: &str = "{ 1411, 51, 41 }";
const UNDERCITY: &str = "{ 1458, 66, 38 }";
const TIRISFAL: &str = "{ 1420, 60, 52 }";
const SILVERPINE: &str = "{ 1421, 45, 42 }";
const STORMWIND: &str = "{ 1453, 60, 60 }";
const ELWYNN: &str = "{ 1429, 42, 65 }";
const DARNASSUS: &str = "{ 1457, 35, 50 }";
const TELDRASSIL: &str = "{ 1438, 56, 57 }";

#[test]
fn case_1_a_horde_mage_with_a_rune_casts_teleport_undercity_first_from_orgrimmar_or_durotar_never_the_zeppelin() {
	let spells = lua_list(&mage_book("Horde", 50));
	let Some(out) = horde_mage(
		50,
		&format!(
			r#"
		local r = {{}}
		local spells = {spells}
		for fname, from in pairs({{ orgrimmar = {ORG}, durotar = {DUROTAR} }}) do
			for tname, to in pairs({{ undercity = {UNDERCITY}, tirisfal = {TIRISFAL}, silverpine = {SILVERPINE} }}) do
				r[fname .. ">" .. tname] = trial{{ from = from, to = to, spells = spells, runes = 1 }}
				r[fname .. ">" .. tname .. "/norune"] = trial{{ from = from, to = to, spells = spells, runes = 0 }}
			end
		end
		emit(r)"#
		),
	) else {
		return;
	};
	for (k, t) in out.as_object().unwrap().iter().filter(|(k, _)| !k.ends_with("/norune")) {
		assert_eq!(t["first"], "teleport|Cast Teleport: Undercity", "{k}: {t}");
		assert!(!t["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("zeppelin")), "{k}: no zeppelin leg: {t}");
		let slow = out[format!("{k}/norune").as_str()]["seconds"].as_u64().unwrap();
		assert!(t["seconds"].as_u64().unwrap() * 2 < slow, "{k}: the teleport route is the faster by far: {t} against {}", out[format!("{k}/norune").as_str()]);
	}
}

#[test]
fn case_2_without_a_rune_the_same_mage_takes_the_zeppelin_or_a_flight_and_never_a_teleport() {
	let spells = lua_list(&mage_book("Horde", 50));
	let Some(out) = horde_mage(
		50,
		&format!(
			r#"
		local r = {{}}
		local spells = {spells}
		for fname, from in pairs({{ orgrimmar = {ORG}, durotar = {DUROTAR} }}) do
			for tname, to in pairs({{ undercity = {UNDERCITY}, tirisfal = {TIRISFAL}, silverpine = {SILVERPINE} }}) do
				r[fname .. ">" .. tname] = trial{{ from = from, to = to, spells = spells, runes = 0 }}
			end
		end
		emit(r)"#
		),
	) else {
		return;
	};
	for (k, t) in out.as_object().unwrap() {
		let legs: Vec<&str> = t["legs"].as_array().unwrap().iter().map(|l| l.as_str().unwrap()).collect();
		assert!(!legs.iter().any(|l| l.starts_with("teleport")), "{k}: no rune, no teleport: {t}");
		assert!(legs.iter().any(|l| l.starts_with("zeppelin") || l.starts_with("fly")), "{k}: a zeppelin or a flight: {t}");
	}
}

#[test]
fn case_2_a_rune_seller_a_short_walk_away_is_offered_when_buying_one_saves_the_trip() {
	let spells = lua_list(&mage_book("Horde", 50));
	let Some(out) = horde_mage(
		50,
		&format!(
			r#"
		local r = {{}}
		local R = N.runeStop
		Polestar.Compat.GetUnitZone = function() return 1454 end
		local function seller(map, x, y)
			local c, wx, wy = Polestar.Compat.MapToWorld(map, x, y)
			return {{ id = 77, name = "Rune Seller", map = map, x = x, y = y, c = c, wx = wx, wy = wy }}
		end
		local sellers = {{ seller(1454, 52, 58) }}
		N.nearby.Sellers = function() return sellers end
		-- The Mage knows Teleport: Undercity and has no rune: the zeppelin route, and the seller's offer.
		local plan = trial{{ from = {ORG}, to = {UNDERCITY}, spells = {spells}, runes = 0 }}
		r.first = plan.first
		local o = R.Find()
		r.offer = o and {{ o.seller.name, o.saves >= 60, o.teleport and o.teleport.name or o.spell and o.spell.name or false }} or false
		-- The seller across the world (another zone): none.
		sellers = {{ seller(1411, 51, 41) }}
		r.farSeller = R.Find() == nil
		-- With a rune in the bags there is nothing to buy.
		sellers = {{ seller(1454, 52, 58) }}
		w.items[RUNE] = 1
		r.stocked = R.Find() == nil
		emit(r)"#
		),
	) else {
		return;
	};
	assert!(out["first"].as_str().unwrap().starts_with("walk"), "{out}");
	assert_eq!(out["offer"][0], "Rune Seller", "{out}");
	assert_eq!(out["offer"][1], true, "{out}");
	assert_eq!(out["farSeller"], true, "{out}");
	assert_eq!(out["stocked"], true, "{out}");
}

#[test]
fn case_3_an_alliance_mage_in_darnassus_or_teldrassil_casts_teleport_stormwind_instead_of_the_boat() {
	let spells = lua_list(&mage_book("Alliance", 50));
	let Some(out) = alliance_mage(
		50,
		&format!(
			r#"
		local r = {{}}
		local spells = {spells}
		for fname, from in pairs({{ darnassus = {DARNASSUS}, teldrassil = {TELDRASSIL} }}) do
			for tname, to in pairs({{ stormwind = {STORMWIND}, elwynn = {ELWYNN} }}) do
				r[fname .. ">" .. tname] = trial{{ from = from, to = to, spells = spells, runes = 1 }}
				r[fname .. ">" .. tname .. "/norune"] = trial{{ from = from, to = to, spells = spells, runes = 0 }}
			end
		end
		emit(r)"#
		),
	) else {
		return;
	};
	for (k, t) in out.as_object().unwrap() {
		if k.ends_with("/norune") {
			assert!(!t["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "{k}: {t}");
			continue;
		}
		let first = t["first"].as_str().unwrap();
		let to_stormwind = k.ends_with("stormwind");
		// Darnassus' own Teleport: Darnassus is never cast in Darnassus; the way to Stormwind is Teleport: Stormwind.
		assert_eq!(first, "teleport|Cast Teleport: Stormwind", "{k}: {t}");
		assert!(!t["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("boat")), "{k}: no boat: {t}");
		assert!(t["seconds"].as_u64().unwrap() < if to_stormwind { 120 } else { 400 }, "{k}: {t}");
	}
}

#[test]
fn case_4_a_mage_below_the_learn_level_is_never_offered_a_teleport() {
	let spells = lua_list(&mage_book("Horde", 19));
	assert!(spells == "{  }", "a Mage of 19 has none of them");
	let Some(out) = horde_mage(
		19,
		&format!(
			r#"
		local r = {{}}
		r.undercity = trial{{ from = {ORG}, to = {UNDERCITY}, spells = {spells}, runes = 5 }}
		w.spells = {{}}
		r.usable = #Polestar.Transit.Teleports(0)
		r.missing = #Polestar.Transit.MissingRunes()
		emit(r)"#
		),
	) else {
		return;
	};
	assert!(!out["undercity"]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "{out}");
	assert_eq!(out["usable"], 0, "{out}");
	assert_eq!(out["missing"], 0, "no rune stop for a spell the Mage lacks: {out}");
}

const HORDE_PLACES: &str = r#"{
	{ "Orgrimmar", 1454, 50, 60 }, { "Razor Hill", 1411, 51, 41 }, { "Undercity", 1458, 66, 38 }, { "Brill", 1420, 60, 52 },
	{ "Sepulcher", 1421, 45, 42 }, { "Thunder Bluff", 1456, 45, 55 }, { "Bloodhoof", 1412, 47, 60 }, { "Ratchet", 1413, 63, 38 },
	{ "Crossroads", 1413, 51, 30 }, { "Gadgetzan", 1446, 52, 28 }, { "Freewind Post", 1441, 46, 50 }, { "Camp Mojache", 1444, 75, 44 },
	{ "Everlook", 1452, 61, 38 }, { "Light's Hope", 1423, 81, 59 }, { "Tarren Mill", 1424, 62, 20 }, { "Booty Bay", 1434, 27, 77 },
	{ "Brackenwall", 1445, 36, 31 }, { "Zephras Isle", 2521, 50, 50 },
}"#;
const ALLIANCE_PLACES: &str = r#"{
	{ "Stormwind", 1453, 60, 60 }, { "Goldshire", 1429, 42, 65 }, { "Ironforge", 1455, 50, 50 }, { "Kharanos", 1426, 46, 53 },
	{ "Thelsamar", 1432, 35, 47 }, { "Darnassus", 1457, 35, 50 }, { "Dolanaar", 1438, 56, 57 }, { "Auberdine", 1439, 37, 41 },
	{ "Astranaar", 1440, 36, 49 }, { "Feathermoon", 1444, 31, 43 }, { "Everlook", 1452, 61, 38 }, { "Theramore", 1445, 66, 49 },
	{ "Gadgetzan", 1446, 52, 28 }, { "Booty Bay", 1434, 27, 77 }, { "Menethil", 1437, 10, 60 }, { "Southshore", 1424, 50, 57 },
	{ "Light's Hope", 1423, 81, 59 }, { "Sentinel Hill", 1436, 56, 52 }, { "Zephras Isle", 2521, 50, 50 },
}"#;

/// A Lua list as emitted: an array, or an empty object for an empty table.
fn list(v: &Value) -> Vec<&Value> {
	v.as_array().map(|a| a.iter().collect()).unwrap_or_default()
}

fn print_matrix(faction: &str, out: &Value) {
	println!("## {faction} matrix: {}", out["stats"]);
	println!("| from | to | teleport | chosen s | no-teleport s | best teleport way s | legs |");
	println!("|---|---|---|---|---|---|---|");
	for r in out["rows"].as_array().unwrap() {
		let r = r.as_array().unwrap();
		println!("| {} | {} | {} | {} | {} | {} | {} |", r[0].as_str().unwrap(), r[1].as_str().unwrap(), r[2].as_str().unwrap(), r[3], r[4], r[5], r[6].as_str().unwrap());
	}
	for v in list(&out["violations"]) {
		println!("VIOLATION {faction}: {}", v.as_str().unwrap());
	}
	for v in list(&out["near"]) {
		println!("NEAR {faction}: {}", v.as_str().unwrap());
	}
}

#[test]
fn matrix_horde_mage_every_teleport_known_or_not_with_and_without_a_rune_from_every_place_to_every_place() {
	let book = lua_list(&mage_book("Horde", 20));
	let Some(out) = horde_mage(60, &format!("emit(matrix({HORDE_PLACES}, {book}))")) else { return };
	print_matrix("Horde", &out);
	assert!(list(&out["violations"]).is_empty(), "{}", out["violations"]);
	assert!(out["stats"]["used"].as_u64().unwrap() > 20, "the teleports are used: {}", out["stats"]);
}

#[test]
fn matrix_alliance_mage_every_teleport_known_or_not_with_and_without_a_rune_from_every_place_to_every_place() {
	let book = lua_list(&mage_book("Alliance", 20));
	let Some(out) = alliance_mage(60, &format!("emit(matrix({ALLIANCE_PLACES}, {book}))")) else { return };
	print_matrix("Alliance", &out);
	assert!(list(&out["violations"]).is_empty(), "{}", out["violations"]);
	assert!(out["stats"]["used"].as_u64().unwrap() > 20, "the teleports are used: {}", out["stats"]);
}

/// The guide `id` of guides/ compiled now against data/forever (the committed Guides.lua is rebuilt at release, so it has
/// not the compiler's hidden vias of #4467 yet), as the Lua table that registers it.
fn compiled_guide(id: &str) -> String {
	let file = format!("{id}.guide");
	let text = std::fs::read_to_string(root().join("guides").join(&file)).unwrap_or_else(|e| panic!("{file}: {e}"));
	let data = forge_guide::data::load_data(&root().join("data/forever")).expect("data/forever");
	let c = forge_addontest::dsl::compile_with(&[(file.as_str(), text.as_str())], &data, None);
	// One guide alone: the cross-guide checks (a `next` or a feeder quest of another guide) report, the guide compiles.
	assert!(!c.guides.is_empty(), "{file}: {:?}", c.errors);
	let json = forge_addontest::dsl::plain(&c.guides[0]);
	forge_addontest::lua_value(&json)
}

/// A leveling guide of the shipped Horde route (compiled now, so its travel-only step is the hidden via the compiler writes):
/// that guide's step titled `via_title` between a first step at `at` (where the character stands, a quest taken) and a hand-in
/// at `dest`, for a Mage of 40 with `spells` and `runes` Runes of Teleportation.
/// -> { via (the step's index), title, travel, legs, waypoint = { map, x, via }, numbers }
fn via_in_horde_guide(id: &str, via_title: &str, at: (u32, f64, f64), dest: (u32, f64, f64), spells: &str, runes: u32) -> Value {
	let guide = compiled_guide(id);
	let before = format!(
		r#"local w = stub.world
for _, s in ipairs({spells}) do w.spells[s] = true end
if {runes} > 0 then w.addItem(17031, {runes}) end
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Orc", "Orc", "Horde", "MAGE", "Mage", 40
w.money = 500000"#
	);
	let maps = maps().unwrap_or_default();
	let script = format!(
		r#"{TEST_PACK}
{TEST_SOURCE}
E, N = Polestar.Engine, Polestar.Nav
local w = stub.world
{maps}
local real = {guide}
local via
for _, step in ipairs(real.steps) do if step.title == "{via_title}" and step.via and not via then via = step end end
Polestar.RegisterGuide({{ id = "test/via-real", pack = "test", title = "Via", minLevel = 1, maxLevel = 60, steps = {{
	{{ title = "Start", goals = {{ {{ t = "accept", quest = 9001, title = "Errand", npc = 1, npcName = "Giver", map = {amap}, x = {ax}, y = {ay} }} }} }},
	via,
	{{ title = "Hand in", goals = {{ {{ t = "turnin", quest = 9001, title = "Errand", npc = 2, npcName = "Taker", map = {dmap}, x = {dx}, y = {dy} }} }} }},
}} }})
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local f = Polestar.CharState().flags
f.taxi, f.taxiSeen = {{}}, {{ [0] = true, [1] = true }}
for _, n in ipairs(N.GetTravelData().taxi) do f.taxi[n.id] = true end
w.moveTo({amap}, {ax}, {ay})
w.accept(9001, {{}}, "Errand")
E.SetGuide("test/via-real"); stub.advance(1)
local s = E.GetStepIndex()
local v, wp = s and E.GetStepView(s), E.GetWaypoint()
local legs = {{}}
local route, ci = N.GetRoute()
for i = ci or 1, route and #route or 0 do legs[#legs + 1] = route[i].kind .. "|" .. route[i].label end
local numbers = {{}}
for i = 1, #E.GetGuide().steps do local n, hidden = E.StepNumber(i); numbers[i] = hidden and "-" or n end
emit({{ via = via and via.title or false, step = s or false, title = v and v.title or false, travel = v and v.travel or false, legs = legs,
	waypoint = {{ wp and wp.map or false, wp and wp.x or false, wp and wp.via or false }}, numbers = numbers }})
"#,
		amap = at.0,
		ax = at.1,
		ay = at.2,
		dmap = dest.0,
		dx = dest.1,
		dy = dest.2
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Nav/Nav.xml"]), Addon::files("Polestar_Guides", &["MapFrames.lua"])],
		script,
		..Default::default()
	})
	.remove(0)
}

#[test]
fn case_5_a_hidden_zeppelin_step_of_a_leveling_guide_is_dropped_and_the_live_steps_travel_line_casts_the_teleport() {
	for (id, via, at, dest, city, label) in [
		("forever/horde/03-silverpine-forest", "Zeppelin to Undercity", (1454, 50.0, 60.0), (1420, 60.0, 52.0), "Undercity", "zeppelin"),
		("forever/horde/06-hillsbrad-foothills", "Zeppelin to Orgrimmar", (1458, 66.0, 38.0), (1454, 45.3, 63.7), "Orgrimmar", "zeppelin"),
	] {
		if maps().is_none() {
			return;
		}
		let mage = via_in_horde_guide(id, via, at, dest, "{ 3563, 3567 }", 3);
		assert_eq!(mage["via"], via, "{id}: the real guide's step: {mage}");
		assert_eq!(mage["numbers"], serde_json::json!([1, "-", 2]), "{id}: the zeppelin step is hidden: {mage}");
		assert_eq!(mage["waypoint"][2], false, "{id}: the arrow leads to the work, no pull to the tower: {mage}");
		assert_eq!(mage["travel"], format!("Cast Teleport: {city}"), "{id}: the live step's travel line: {mage}");
		assert_eq!(mage["legs"][0], format!("teleport|Cast Teleport: {city}"), "{id}: {mage}");
		assert!(!mage["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with(label)), "{id}: no {label} leg: {mage}");
		let walker = via_in_horde_guide(id, via, at, dest, "{ 3563, 3567 }", 0);
		assert!(walker["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with(label)), "{id}: without a rune the {label}: {walker}");
		assert!(walker["travel"].as_str().is_some_and(|t| t.starts_with("Take the zeppelin")), "{id}: {walker}");
	}
}

#[test]
fn case_c_a_teleport_then_a_flight_is_chosen_when_it_beats_the_way_without_and_not_when_a_flight_alone_is_as_fast() {
	let book = lua_list(&mage_book("Horde", 50));
	let Some(out) = horde_mage(
		50,
		&format!(
			r#"
		local r = {{}}
		local book = {book}
		local gadgetzan, crossroads, freewind = {{ 1446, 52, 28 }}, {{ 1413, 51, 30 }}, {{ 1441, 46, 50 }}
		r.crossroads = trial{{ from = gadgetzan, to = crossroads, spells = book, runes = 1 }}
		r.crossroadsWithout = trial{{ from = gadgetzan, to = crossroads, spells = book, runes = 0 }}
		-- Tanaris to Thousand Needles: Freewind Post is a flight away, no teleport needed.
		r.freewind = trial{{ from = gadgetzan, to = freewind, spells = book, runes = 1 }}
		-- Undercity to Gadgetzan: Teleport: Thunder Bluff, then the flight on, against a zeppelin and the Barrens.
		r.undercity = trial{{ from = {{ 1458, 66, 38 }}, to = gadgetzan, spells = book, runes = 1 }}
		emit(r)"#
		),
	) else {
		return;
	};
	let kinds = |t: &Value| -> Vec<String> { t["legs"].as_array().unwrap().iter().map(|l| l.as_str().unwrap().split('|').next().unwrap().to_string()).collect() };
	let c = &out["crossroads"];
	assert_eq!(c["first"], "teleport|Cast Teleport: Orgrimmar", "{c}");
	assert!(kinds(c).contains(&"fly".to_string()), "the flight on from Orgrimmar: {c}");
	assert!(c["seconds"].as_u64().unwrap() * 10 < out["crossroadsWithout"]["seconds"].as_u64().unwrap() * 6, "the combination is far faster: {out}");
	assert!(!kinds(&out["freewind"]).contains(&"teleport".to_string()), "a flight alone is as fast: {}", out["freewind"]);
	let u = &out["undercity"];
	assert_eq!(u["first"], "teleport|Cast Teleport: Thunder Bluff", "{u}");
	assert!(kinds(u).contains(&"fly".to_string()), "{u}");
}

#[test]
fn case_6_a_druid_casts_teleport_moonglade_where_it_is_faster_never_in_moonglade_or_without_the_spell() {
	let Some(out) = run(
		"Horde",
		"Tauren",
		"Druid",
		40,
		r#"
		local r = {}
		local nighthaven = { 1450, 50, 60 }
		local winterspring = { 1452, 61, 38 }
		for name, from in pairs({ orgrimmar = { 1454, 50, 60 }, razorhill = { 1411, 51, 41 }, undercity = { 1458, 66, 38 }, mojache = { 1444, 75, 44 }, everlook = { 1452, 61, 38 } }) do
			r[name] = trial{ from = from, to = nighthaven, spells = { 18960 }, runes = 0 }
			r[name .. "/unknown"] = trial{ from = from, to = nighthaven, spells = {}, runes = 0 }
		end
		-- Winterspring's Everlook from Orgrimmar: Moonglade is a walk from it.
		r.everlookFromOrg = trial{ from = { 1454, 50, 60 }, to = winterspring, spells = { 18960 }, runes = 0 }
		r.everlookFromOrgUnknown = trial{ from = { 1454, 50, 60 }, to = winterspring, spells = {}, runes = 0 }
		-- Standing in Moonglade: never cast to the place it stands in.
		r.inMoonglade = trial{ from = nighthaven, to = { 1450, 56, 32 }, spells = { 18960 }, runes = 0 }
		r.leaving = trial{ from = nighthaven, to = { 1454, 50, 60 }, spells = { 18960 }, runes = 0 }
		emit(r)"#,
	) else {
		return;
	};
	let first = |k: &str| out[k]["first"].as_str().unwrap().to_string();
	for k in ["orgrimmar", "razorhill", "undercity", "mojache"] {
		assert_eq!(first(k), "teleport|Cast Teleport: Moonglade", "{k}: {}", out[k]);
		assert!(
			!out[format!("{k}/unknown")]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")),
			"{k}: without the spell: {}",
			out[format!("{k}/unknown").as_str()]
		);
		assert!(out[k]["seconds"].as_u64().unwrap() < out[format!("{k}/unknown").as_str()]["seconds"].as_u64().unwrap(), "{k}: faster than without: {out}");
	}
	// From Everlook it is cast only when it is the faster way (the flight is minutes).
	if first("everlook").starts_with("teleport") {
		assert!(out["everlook"]["seconds"].as_u64().unwrap() < out["everlook/unknown"]["seconds"].as_u64().unwrap(), "{out}");
	}
	assert!(!out["inMoonglade"]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "{}", out["inMoonglade"]);
	assert!(!out["leaving"]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "no teleport out of Moonglade to Orgrimmar: {}", out["leaving"]);
}

#[test]
fn case_6_a_shaman_casts_astral_recall_to_the_bind_point_when_the_hearthstone_is_away_or_cooling_down() {
	let Some(out) = run(
		"Horde",
		"Orc",
		"Shaman",
		40,
		r#"
		local r = {}
		w.bind("Razor Hill")
		stub.advance(10) -- a cooldown starts at a time above 0
		local tanaris, razor = { 1446, 52, 28 }, { 1411, 51, 41 }
		local function plan() return trial{ from = tanaris, to = razor, spells = { 556 }, runes = 0 } end
		local function cooling(on)
			local f = function(id) if on and id == 6948 then return GetTime(), 3600, 1 end return 0, 0, 1 end
			C_Container = C_Container or {}
			C_Container.GetItemCooldown = f
			if C_Item then C_Item.GetItemCooldown = f end
			GetItemCooldown = f
		end
		w.items[6948] = nil
		r.noStone = plan()
		w.items[6948] = 1
		cooling(true)
		r.stoneCooling = plan()
		cooling(false)
		r.stoneReady = plan()
		w.items[6948] = nil
		w.spells = {}
		r.noSpell = trial{ from = tanaris, to = razor, spells = {}, runes = 0 }
		r.nearBind = trial{ from = { 1411, 52, 41 }, to = razor, spells = { 556 }, runes = 0 }
		emit(r)"#,
	) else {
		return;
	};
	assert!(out["noStone"]["first"].as_str().unwrap().starts_with("teleport|Cast Astral Recall"), "{out}");
	assert_eq!(out["noStone"]["spell"], 556, "{out}");
	assert!(out["stoneCooling"]["first"].as_str().unwrap().starts_with("teleport|Cast Astral Recall"), "the Hearthstone cooling down: {out}");
	assert!(out["stoneReady"]["first"].as_str().unwrap().starts_with("hearth"), "both ready, the Hearthstone is used first: {out}");
	assert!(!out["noSpell"]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "{out}");
	assert!(!out["nearBind"]["legs"].as_array().unwrap().iter().any(|l| l.as_str().unwrap().starts_with("teleport")), "{out}");
}

/// The real addon with a shipped faction route loaded (addon/Polestar_Guides_<faction>) and a Mage in it.
fn with_shipped(faction: &str, level: u32, script: &str) -> Option<Value> {
	let maps = maps()?;
	let dir = forge_addontest::run::addons_dir();
	let (race, raceid, part) = if faction == "Horde" { ("Orc", 2, "Polestar_Guides_Horde") } else { ("Human", 1, "Polestar_Guides_Alliance") };
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName, w.raceID, w.faction = \"{race}\", \"{race}\", {raceid}, \"{faction}\"\nw.class, w.className = \"MAGE\", \"Mage\"\nw.level = {level}\nw.moveTo(1411, 51, 41)\n"
	);
	let script = format!("stub.login()\nstub.fire(\"QUEST_LOG_UPDATE\")\n{HELPERS}\n{script}");
	let addons = vec![Addon::name("Polestar"), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir(part, dir.join(part))];
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons, script, ..Default::default() }).remove(0))
}

/// The sweep over a faction's shipped leveling guides (levels 20 to 60) for a Mage with every city teleport of its faction and
/// a Rune of Teleportation: each step that goes to another zone from where the step before it ended (its last place),
/// planned with the teleports, without them (a character below the learn level), and the way by each teleport forced
/// (10 s cast, then the best way on from its landing). `flights`: "all" (every flight master of the faction known) or "none".
const SWEEP: &str = r#"
function sweep(book, flightsMode)
	local lands = landings(book)
	local G = Polestar.Guides
	local player = Polestar.Compat.GetPlayerInfo()
	local rows, cache = {}, {}
	local function cont(p) local c = Polestar.Compat.MapToWorld(p[1], p[2], p[3]) return c end
	local function plan(key, spec)
		if cache[key] == nil then cache[key] = trial(spec) end
		return cache[key]
	end
	local function name(m) return w.maps[m] and w.maps[m].name or tostring(m) end
	for _, h in ipairs(G.List()) do
		if h.category == "Leveling" and (h.maxLevel or 0) >= 20 and h.id:find("^forever/") then
			local g = G.Get(h.id)
			w.level = math.max(20, h.minLevel or 20)
			local last
			for si, step in ipairs(g.steps) do
				if G.Matches(step.only, player) then
					local first, final
					for _, goal in ipairs(step.goals) do
						if goal.map and goal.x and goal.y and G.Matches(goal.only, player) then
							local p = { goal.map, goal.x, goal.y }
							first = first or p
							final = p
						end
					end
					if first and last and first[1] ~= last[1] then
						local k = last[1] .. ":" .. last[2] .. ":" .. last[3] .. ">" .. first[1] .. ":" .. first[2] .. ":" .. first[3]
						local chosen = plan(k .. "/c", { from = last, to = first, spells = book, runes = 1, flights = flightsMode })
						local base = plan(k .. "/b", { from = last, to = first, spells = {}, runes = 0, flights = flightsMode })
						local best, bestSpell = math.huge, nil
						for spell, l in pairs(lands) do
							if l[1] ~= last[1] then
								local f = plan(spell .. ">" .. first[1] .. ":" .. first[2] .. ":" .. first[3], { from = l, to = first, spells = {}, runes = 0, flights = flightsMode })
								if f.seconds and f.seconds + 10 < best then best, bestSpell = f.seconds + 10, spell end
							end
						end
						rows[#rows + 1] = { h.id, si, step.title, name(last[1]), name(first[1]), cont(last) ~= cont(first) and "continent" or "zone",
							chosen.spell and lands[chosen.spell][4] or "-", chosen.seconds or -1, base.seconds or -1,
							bestSpell and best ~= math.huge and math.floor(best) or -1, bestSpell and lands[bestSpell][4] or "-", table.concat(chosen.legs, " / ") }
					end
					if final then last = final end
				end
			end
		end
	end
	return rows
end
"#;

fn sweep_rows(faction: &str, flights: &str) -> Option<Vec<Vec<Value>>> {
	let book = lua_list(&mage_book(faction, 20));
	let out = with_shipped(faction, 40, &format!("{SWEEP}\nemit(sweep({book}, \"{flights}\"))"))?;
	Some(list(&out).into_iter().map(|r| r.as_array().unwrap().clone()).collect())
}

/// What the sweep says: its rows as a table, and the counts. Row: guide, step, title, from, to, zone|continent, teleport used,
/// chosen s, no-teleport s, best forced s, its teleport, the legs.
fn sweep_report(faction: &str, flights: &str, rows: &[Vec<Value>]) -> (usize, usize, Vec<String>, Vec<String>) {
	let n = |v: &Value| v.as_i64().unwrap();
	let (mut used, mut missed, mut bad) = (0, vec![], vec![]);
	let mut saved = 0;
	let mut by_kind = [(0, 0), (0, 0)];
	println!("## {faction} sweep, flights {flights}: {} zone changes", rows.len());
	println!("| guide | step | title | from | to | kind | teleport | chosen s | no-teleport s | best teleport way s |");
	println!("|---|---|---|---|---|---|---|---|---|---|");
	for r in rows {
		let (chosen, base, best) = (n(&r[7]), n(&r[8]), n(&r[9]));
		let tele = r[6].as_str().unwrap() != "-";
		let k = (r[5].as_str().unwrap() == "continent") as usize;
		by_kind[k].0 += 1;
		if tele {
			used += 1;
			by_kind[k].1 += 1;
			saved += base - chosen;
			if base >= 0 && chosen > base {
				bad.push(format!(
					"{} #{} {}: {} -> {}: {} {} s against {} s without",
					r[0].as_str().unwrap(),
					r[1],
					r[2].as_str().unwrap(),
					r[3].as_str().unwrap(),
					r[4].as_str().unwrap(),
					r[6].as_str().unwrap(),
					chosen,
					base
				));
			}
		}
		let basis = if base < 0 { i64::MAX / 2 } else { base };
		if !tele && best >= 0 && (best as f64) < 0.8 * basis as f64 && basis - best > 60 {
			missed.push(format!(
				"{} #{} {}: {} -> {}: {} {} s against {} s ({} s faster)",
				r[0].as_str().unwrap(),
				r[1],
				r[2].as_str().unwrap(),
				r[3].as_str().unwrap(),
				r[4].as_str().unwrap(),
				r[10].as_str().unwrap(),
				best,
				chosen,
				chosen - best
			));
		}
		println!(
			"| {} | {} | {} | {} | {} | {} | {} | {} | {} | {} |",
			r[0].as_str().unwrap().trim_start_matches("forever/"),
			r[1],
			r[2].as_str().unwrap(),
			r[3].as_str().unwrap(),
			r[4].as_str().unwrap(),
			r[5].as_str().unwrap(),
			r[6].as_str().unwrap(),
			chosen,
			base,
			best
		);
	}
	println!(
		"SUMMARY {faction} {flights}: zone changes {}; teleport used {} ({:.1}%); continent changes {} (teleport {}); same-continent {} (teleport {}); MISSED {}; BAD {}; time saved {} min",
		rows.len(),
		used,
		100.0 * used as f64 / rows.len().max(1) as f64,
		by_kind[1].0,
		by_kind[1].1,
		by_kind[0].0,
		by_kind[0].1,
		missed.len(),
		bad.len(),
		saved / 60
	);
	for m in &missed {
		println!("MISSED {faction} {flights}: {m}");
	}
	for b in &bad {
		println!("BAD {faction} {flights}: {b}");
	}
	(rows.len(), used, missed, bad)
}

#[test]
fn sweep_horde_leveling_guides_a_mage_at_every_zone_change() {
	for flights in ["all", "none"] {
		let Some(rows) = sweep_rows("Horde", flights) else { return };
		let (total, used, _missed, bad) = sweep_report("Horde", flights, &rows);
		assert!(total > 100, "zone changes found: {total}");
		assert!(used > 0, "the teleports are used");
		assert!(bad.is_empty(), "{bad:?}");
	}
}

#[test]
fn sweep_alliance_leveling_guides_a_mage_at_every_zone_change() {
	for flights in ["all", "none"] {
		let Some(rows) = sweep_rows("Alliance", flights) else { return };
		let (total, used, _missed, bad) = sweep_report("Alliance", flights, &rows);
		assert!(total > 100, "zone changes found: {total}");
		assert!(used > 0, "the teleports are used");
		assert!(bad.is_empty(), "{bad:?}");
	}
}
