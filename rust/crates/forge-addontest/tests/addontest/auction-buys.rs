//! Auction house buys (addon/Polestar/Quests/AuctionBuys.lua, UI/AuctionBuys.lua): the quest items a guide or the
//! quest log needs that an auction house can sell (tradeable, sold by no merchant, a long farm or dropped by
//! nothing), the guide's card when it opens, the reminder in a town with an auction house, the list window, the
//! guide window's menu entry and the setting. The whole addon on the stub world, a quest database built from
//! tests/fixtures/questdb with this file's quests and items, and a Codex with Orgrimmar's and Stormwind's
//! auctioneers standing in for Polestar_Codex.

use forge_addontest::questdb::{build_db, data_with, QuestDb};
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK};
use serde_json::{json, Map, Value};

// The quests of the test guide (and one only in the log), their items and who drops or sells them.
fn db() -> QuestDb {
	let data = data_with(|raw| {
		let quests = raw.get_mut("quests.json").unwrap().as_object_mut().unwrap();
		let quest = |id: i64, title: &str, item: i64, count: i64| {
			json!({ "id": id, "title": title, "level": 40, "minLevel": 30, "races": null, "classes": null,
				"start": { "npc": [100], "object": [], "item": [] }, "end": { "npc": [100], "object": [] },
				"pre": [], "excl": [], "next": null, "objectives": [{ "type": "item", "id": item, "count": count, "text": title }],
				"objectiveText": "", "zone": 1411, "xp": null, "skill": null, "event": null, "source": ["fixture"] })
		};
		for (id, title, item, count) in [
			(9001, "Caught!", 4306, 15),
			(9002, "Thirsty Work", 159, 5),
			(9003, "Boar Meat", 769, 4),
			(9004, "Brutal Armor", 3575, 10),
			(9005, "Keepsake", 9999, 2),
			(9006, "Token Run", 9998, 3),
			(9007, "Ice Cold Milk", 1179, 10),
			(9008, "Briarthorn Bundle", 2450, 6),
			(9009, "Spider Silk", 4000, 10),
			(9010, "A Tailor's Request", 4306, 5),
		] {
			quests.insert(id.to_string(), quest(id, title, item, count));
		}
		let npcs = raw.get_mut("npcs.json").unwrap().as_object_mut().unwrap();
		let npc = |id: i64, name: &str| json!({ "id": id, "name": name, "level": 40, "levelMax": null, "faction": null, "spawns": { "1411": { "f": "e", "pts": [[50, 50]] } } });
		for (id, name) in [(100, "Test Giver"), (3, "Test Vendor"), (113, "Boar"), (5839, "Dark Iron Geologist")] {
			npcs.insert(id.to_string(), npc(id, name));
		}
		for id in 201..=209 {
			npcs.insert(id.to_string(), npc(id, &format!("Spider {id}")));
		}
		let objects = raw.get_mut("objects.json").unwrap().as_object_mut().unwrap();
		objects.insert("3000".into(), json!({ "id": 3000, "name": "Briarthorn", "spawns": { "1411": { "f": "e", "pts": [[30, 30]] } } }));
		let items = raw.get_mut("items.json").unwrap().as_object_mut().unwrap();
		let item = |id: i64, name: &str, npc: Value, object: Value, vendors: Value| {
			json!({ "id": id, "name": name, "drops": { "npc": npc, "object": object }, "vendors": vendors })
		};
		let mut spiders = Map::new();
		for id in 201..=208 {
			spiders.insert(id.to_string(), json!(40));
		}
		for (id, v) in [
			(4306, item(4306, "Silk Cloth", json!({ "5839": 9.88 }), json!({}), json!([]))),
			// The guide buys the water from its own vendor; the quest data knows none.
			(159, item(159, "Refreshing Spring Water", json!({ "113": 1 }), json!({}), json!([]))),
			(769, item(769, "Chunk of Boar Meat", json!({ "113": 80 }), json!({}), json!([]))),
			(3575, item(3575, "Iron Bar", json!({}), json!({}), json!([]))),
			(9999, item(9999, "Bound Keepsake", json!({ "113": 5 }), json!({}), json!([]))),
			(9998, item(9998, "Quest Token", json!({ "113": 5 }), json!({}), json!([]))),
			// A vendor sells the milk: never the auction house, however rare the drop.
			(1179, item(1179, "Ice Cold Milk", json!({ "113": 2 }), json!({}), json!([3]))),
			(2450, item(2450, "Briarthorn", json!({}), json!({ "3000": 100 }), json!([]))),
			(4000, item(4000, "Spider Silk", Value::Object(spiders), json!({}), json!([]))),
		] {
			items.insert(id.to_string(), v);
		}
	});
	build_db(data.path())
}

// The world: Durotar and Orgrimmar, Elwynn Forest and Stormwind City (their real map frames), an Orc Warrior in
// Durotar far from any auction house, and what the client knows of the items.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -3680.601, right = -5083.206, top = 2273.877, bottom = 1338.461, parent = 1411 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1535.417, right = -1935.417, top = -7939.583, bottom = -10254.166 })
w.addMap(1453, { name = "Stormwind City", c = 0, left = 1380.971, right = 36.701, top = -8278.851, bottom = -9175.205, parent = 1429 })
w.faction, w.race, w.raceName, w.raceID, w.class, w.className, w.classID, w.level = "Horde", "Orc", "Orc", 2, "WARRIOR", "Warrior", 1, 40
w.moveTo(1411, 52, 44)
w.zone, w.subzone = "Durotar", ""
for id, it in pairs({
	[4306] = { name = "Silk Cloth", classID = 7, subclassID = 5 },
	[159] = { name = "Refreshing Spring Water", classID = 0, subclassID = 5 },
	[769] = { name = "Chunk of Boar Meat", classID = 7, subclassID = 8 },
	[3575] = { name = "Iron Bar", classID = 7, subclassID = 7 },
	[9999] = { name = "Bound Keepsake", classID = 15, subclassID = 0, bind = 1 },
	[9998] = { name = "Quest Token", classID = 12, subclassID = 0, bind = 4 },
	[1179] = { name = "Ice Cold Milk", classID = 0, subclassID = 5 },
	[2450] = { name = "Briarthorn", classID = 7, subclassID = 9 },
	[4000] = { name = "Spider Silk", classID = 7, subclassID = 5 },
}) do w.itemInfo[id] = it end
"#;

// A guide for both sides: the accepts, then a collect for each quest (the water bought from the guide's own vendor
// first), then the hand-ins.
const GUIDE: &str = r#"
local function accept(q, title) return { t = "accept", quest = q, title = title, npc = 100, npcName = "Test Giver", map = 1411, x = 50, y = 50 } end
local function turnin(q, title) return { t = "turnin", quest = q, title = title, npc = 100, npcName = "Test Giver", map = 1411, x = 50, y = 50 } end
local boar = { { npc = 113, npcName = "Boar" } }
Polestar.RegisterGuide({
	id = "test/ah", pack = "test", title = "Errands", minLevel = 30, maxLevel = 45, zone = 1411,
	steps = {
		{ title = "The quests", goals = {
			accept(9001, "Caught!"), accept(9002, "Thirsty Work"), accept(9003, "Boar Meat"), accept(9004, "Brutal Armor"),
			accept(9005, "Keepsake"), accept(9006, "Token Run"), accept(9007, "Ice Cold Milk"),
		} },
		{ title = "What they need", goals = {
			{ t = "collect", quest = 9001, title = "Caught!", item = 4306, itemName = "Silk Cloth", count = 15, oi = 1, map = 1411, x = 60, y = 60,
				fromNpcs = { { npc = 5839, npcName = "Dark Iron Geologist" } } },
			{ t = "buy", item = 159, itemName = "Refreshing Spring Water", count = 5, npc = 3, npcName = "Test Vendor", map = 1411, x = 10, y = 10 },
			{ t = "collect", quest = 9002, title = "Thirsty Work", item = 159, itemName = "Refreshing Spring Water", count = 5, oi = 1 },
			{ t = "collect", quest = 9003, title = "Boar Meat", item = 769, itemName = "Chunk of Boar Meat", count = 4, oi = 1, map = 1411, x = 40, y = 40, fromNpcs = boar },
			{ t = "collect", quest = 9004, title = "Brutal Armor", item = 3575, itemName = "Iron Bar", count = 10, oi = 1 },
			{ t = "collect", quest = 9005, title = "Keepsake", item = 9999, itemName = "Bound Keepsake", count = 2, oi = 1, map = 1411, x = 40, y = 40, fromNpcs = boar },
			{ t = "collect", quest = 9006, title = "Token Run", item = 9998, itemName = "Quest Token", count = 3, oi = 1, map = 1411, x = 40, y = 40, fromNpcs = boar },
			{ t = "collect", quest = 9007, title = "Ice Cold Milk", item = 1179, itemName = "Ice Cold Milk", count = 10, oi = 1, map = 1411, x = 40, y = 40, fromNpcs = boar },
		} },
		{ title = "Hand them in", goals = {
			turnin(9001, "Caught!"), turnin(9002, "Thirsty Work"), turnin(9003, "Boar Meat"), turnin(9004, "Brutal Armor"),
			turnin(9005, "Keepsake"), turnin(9006, "Token Run"), turnin(9007, "Ice Cold Milk"),
		} },
	},
})
"#;

// After the login: the Codex stand-in (the auctioneers by role, a vendor so Nearby services trusts it, the Iron Bar
// a profession makes; not loaded until something loads it), and helpers.
const PRELUDE: &str = r#"
local w = stub.world
local X = Polestar.Codex
local codexLoaded = false
local NPCS = {
	[8673] = { id = 8673, name = "Auctioneer Thathung", faction = "H", roles = { "auctioneer" }, spawns = { { map = 1454, x = 55.9, y = 62.7 } } },
	[8719] = { id = 8719, name = "Auctioneer Fitch", faction = "A", roles = { "auctioneer" }, spawns = { { map = 1453, x = 61.2, y = 71.3 } } },
	[3] = { id = 3, name = "Test Vendor", faction = "AH", roles = { "vendor" }, spawns = { { map = 1411, x = 10, y = 10 } } },
}
local ITEMS = { [3575] = { id = 3575, name = "Iron Bar", sources = { { type = "craft", spell = 3307, skillLine = 186, skill = 125 } } } }
X.IsLoaded = function() return codexLoaded end
X.Load = function() codexLoaded = true; return true end
X.WithRole = function(role)
	local out = {}
	for id, n in pairs(NPCS) do
		for _, r in ipairs(n.roles) do if r == role then out[#out + 1] = id end end
	end
	table.sort(out)
	return out
end
X.Npc = function(id) return NPCS[id] end
X.Item = function(id) return ITEMS[id] end
E, AB, AU, CT = Polestar.Engine, Polestar.AuctionBuys, Polestar.UI.AuctionBuys, Polestar.UI.ClassToast
function card()
	local m = CT.current
	if not m then return false end
	local row = {}
	for i, s in ipairs(m.spells or {}) do row[i] = s.item .. "x" .. (s.count or 1) end
	return { kind = m.kind, head = m.head, title = m.title, lines = m.giver, route = m.route, row = row,
		act = m.act and m.act.label or false, more = m.more and m.more.label or false, later = m.later and m.later.label or false,
		shown = CT.frame ~= nil and CT.frame:IsShown() }
end
function names(scope)
	local out = {}
	for i, e in ipairs(AB.List(scope)) do out[i] = e.name .. "=" .. e.need .. ":" .. e.why end
	return out
end
function acceptAll()
	for _, q in ipairs({ 9001, 9002, 9003, 9004, 9005, 9006, 9007 }) do w.accept(q, { { type = "item", required = 1 } }) end
	stub.advance(1)
end
function enterTown(map, x, y, zone, sub)
	w.resting = true
	w.moveTo(map, x, y)
	w.setZone(zone, sub)
	stub.advance(1)
end
function leaveTown()
	w.resting = false
	w.moveTo(1411, 52, 44)
	w.setZone("Durotar", "")
	stub.advance(1)
end
"#;

fn run_with(db: &QuestDb, before: &str, saved: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!("stub.quests.dbFiles = {}\n{WORLD}\n{before}", db.lua_files()),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), saved.into())],
		script: format!("{TEST_PACK}\n{GUIDE}\nstub.login()\nstub.advance(0.5)\n{PRELUDE}\n{script}"),
		..Default::default()
	})
}

fn run(db: &QuestDb, script: &str) -> Vec<Value> {
	run_with(db, "", "", script)
}

// ---------------------------------------------------------------------------
// The guide's card
// ---------------------------------------------------------------------------

// Opening the guide: once its catch-up has placed the live step, the card lists the Silk Cloth (15 to find at about
// one in ten: some 152 kills) and the Iron Bars (nothing drops them; a profession makes them), with their counts and
// quests and the items' icons. Not the water the guide buys from its vendor, the milk a vendor sells, the boar meat
// the boars drop four in five, the keepsake that binds when picked up or the quest token. Got it dismisses it, and
// it never shows again for this guide on this character.
#[test]
fn opening_a_guide_lists_its_auction_house_buys_on_a_card_once() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(1)
emit(card())
stub.advance(4)
emit(card())
emit(names("guide"))
CT.Later()
E.SetGuide(nil)
stub.advance(1)
E.SetGuide("test/ah")
stub.advance(5)
emit(card())
"#,
	);
	assert_eq!(out[0], json!(false), "not before the guide's catch-up has placed the live step");
	assert_eq!(
		out[1],
		json!({
			"kind": "auctionGuide", "head": "AUCTION HOUSE", "title": "Auction house buys for this guide",
			"lines": "15 Silk Cloth for Caught!\n10 Iron Bar for Brutal Armor",
			"route": "No vendor sells these, and farming them is slow or not possible.",
			"row": ["4306x15", "3575x10"], "act": "See the list", "more": false, "later": "Got it", "shown": true,
		})
	);
	assert_eq!(out[2], json!(["Silk Cloth=15:farm", "Iron Bar=10:made"]));
	assert_eq!(out[3], json!(false), "told once per guide");
}

// Neither a merchant the guide buys from (the water: its `buy` goal) nor one the quest data names (the milk) is ever
// passed over for the auction house, however slow the drop: Restock and the guide's own buying cover those.
#[test]
fn an_item_a_merchant_sells_is_never_an_auction_house_buy() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(5)
local water, milk = AB.Judge(159, 5, nil, nil), AB.Judge(159, 5, nil, { [159] = true })
emit({ water = water, waterBought = milk, milk = AB.Judge(1179, 10, nil, nil) })
local listed = {}
for _, e in ipairs(AB.List("all")) do listed[#listed + 1] = e.item end
emit(listed)
"#,
	);
	assert_eq!(out[0], json!({ "water": "farm", "waterBought": false, "milk": false }), "the water alone is a long farm; bought by the guide, it is not listed");
	assert_eq!(out[1], json!([4306, 3575]));
}

// ---------------------------------------------------------------------------
// The rule
// ---------------------------------------------------------------------------

// The farm's length: count / chance, listed from 20 kills on. A goal naming creatures past the database's eight best
// droppers counts at most the eighth's chance (40%: ten Spider Silk is 25 kills, six is 15). A chance the data does
// not know is never listed. Herbs from nodes are listed for a character without Herbalism and not for an herbalist
// picking six. A goal standing at an auctioneer is the guide sending the player there. What the bags and the bank
// hold comes off the count.
#[test]
fn the_rule_long_farms_the_droppers_bound_gathering_skills_and_bags_and_bank() {
	let db = db();
	let out = run(
		&db,
		r#"
local past = { fromNpcs = { { npc = 209 } } }
local ten, tenKills = AB.Judge(4000, 10, past)
local six = AB.Judge(4000, 6, past)
local unknown = AB.Judge(4306, 15, { fromNpcs = { { npc = 6 } } })
local herb, _, herbSkill = AB.Judge(2450, 6, nil)
w.learnSkill(182, "Herbalism", 1, 75)
local herbalist = AB.Judge(2450, 6, nil)
local atAH = AB.Judge(3575, 10, { map = 1454, x = 55.9, y = 62.7 })
emit({ ten = ten, tenKills = tenKills, six = six, unknown = unknown, herb = herb, herbSkill = herbSkill, herbalist = herbalist, atAH = atAH })
E.SetGuide("test/ah")
stub.advance(5)
w.addItem(4306, 4)
w.bank[4306] = 6
w.addItem(3575, 10)
stub.advance(1)
emit(names("guide"))
"#,
	);
	assert_eq!(out[0], json!({ "ten": "farm", "tenKills": 25, "six": false, "unknown": false, "herb": "gather", "herbSkill": 182, "herbalist": false, "atAH": "ah" }));
	assert_eq!(out[1], json!(["Silk Cloth=5:farm"]), "4 in the bags and 6 in the bank; the Iron Bars all in the bags");
}

// An item the client has not loaded yet is asked for and listed once it arrives.
#[test]
fn an_item_the_client_has_not_loaded_is_listed_once_it_arrives() {
	let db = db();
	let out = run(
		&db,
		r#"
w.itemInfo[4306].uncached = true
E.SetGuide("test/ah")
stub.advance(5)
emit({ card = card() and card().lines or false, asked = w.itemRequests[#w.itemRequests] })
w.itemArrives(4306)
stub.advance(1)
emit(card() and card().lines or false)
"#,
	);
	assert_eq!(out[0], json!({ "card": "10 Iron Bar for Brutal Armor", "asked": 4306 }));
	assert_eq!(out[1], json!("15 Silk Cloth for Caught!\n10 Iron Bar for Brutal Armor"), "the card shown follows the list");
}

// ---------------------------------------------------------------------------
// The reminder
// ---------------------------------------------------------------------------

// In Orgrimmar near the auction house, with the quests taken: the card lists what they still need, the quest only in
// the log adding its five Silk Cloth, and Show me the auctioneer points the arrow at Auctioneer Thathung. Once per
// visit: another part of town says nothing; out of town and back again, it does.
#[test]
fn in_orgrimmar_the_reminder_lists_what_the_quests_still_need_once_per_visit() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(5)
CT.Later()
acceptAll()
w.accept(9010, { { type = "item", required = 5 } }, "A Tailor's Request")
stub.advance(1)
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit(card())
CT.Act()
stub.advance(0.5)
local t = Polestar.Nav.GetTarget and Polestar.Nav.GetTarget()
emit({ target = t and t.label or false, card = card() })
enterTown(1454, 50, 70, "Orgrimmar", "Valley of Strength")
emit(card())
leaveTown()
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit(card() and card().kind or false)
"#,
	);
	assert_eq!(
		out[0],
		json!({
			"kind": "auctionTown", "head": "AUCTION HOUSE", "title": "2 quest items to buy in Orgrimmar",
			"lines": "20 Silk Cloth for Caught!, A Tailor's Request\n10 Iron Bar for Brutal Armor",
			"route": "No vendor sells these, and farming them is slow or not possible.",
			"row": ["4306x20", "3575x10"], "act": "Show me the auctioneer", "more": "See the list", "later": false, "shown": true,
		})
	);
	assert_eq!(out[1], json!({ "target": "Auctioneer Thathung", "card": false }));
	assert_eq!(out[2], json!(false), "once per visit");
	assert_eq!(out[3], json!("auctionTown"), "a new visit");
}

// With everything in the bags there is nothing to buy: no reminder.
#[test]
fn no_reminder_once_the_items_are_in_the_bags() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(5)
CT.Later()
acceptAll()
w.addItem(4306, 15)
w.addItem(3575, 10)
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit({ card = card(), list = names("all") })
"#,
	);
	assert_eq!(out[0], json!({ "card": false, "list": {} }), "an empty Lua list emits as an empty object");
}

// An Alliance character in Stormwind gets the reminder at Stormwind's auction house; in Orgrimmar, whose auctioneers
// are the Horde's, none.
#[test]
fn stormwind_reminds_an_alliance_character_and_orgrimmar_does_not() {
	let db = db();
	let out = run_with(
		&db,
		r#"local w = stub.world; w.faction, w.race, w.raceName, w.raceID = "Alliance", "Human", "Human", 1"#,
		"",
		r#"
E.SetGuide("test/ah")
stub.advance(5)
CT.Later()
acceptAll()
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit(card())
leaveTown()
enterTown(1453, 60, 70, "Stormwind City", "Trade District")
emit(card() and card().title or false)
"#,
	);
	assert_eq!(out[0], json!(false));
	assert_eq!(out[1], json!("2 quest items to buy in Stormwind City"));
}

// Never in combat (it waits for the fight to end), in an instance, or while the step's escort runs.
#[test]
fn the_reminder_waits_out_combat_and_stays_quiet_in_instances_and_escorts() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(5)
CT.Later()
acceptAll()
local escort = true
E.EscortRunning = function() return escort end
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
local during = card()
escort = false
stub.inCombat = true
enterTown(1454, 55, 65, "Orgrimmar", "The Drag")
local fighting = card()
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(1)
local after = card() and card().kind or false
CT.Later()
leaveTown()
w.inInstance = true
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit({ escort = during, combat = fighting, after = after, instance = card() })
"#,
	);
	assert_eq!(out[0], json!({ "escort": false, "combat": false, "after": "auctionTown", "instance": false }));
}

// ---------------------------------------------------------------------------
// The list, the menu, the setting, the gamepad
// ---------------------------------------------------------------------------

// The guide window's menu offers the list while there is something to buy; the window names each item with what is
// still needed, its quests, why it is listed and what the bags and the bank hold.
#[test]
fn the_guide_menu_opens_the_list_of_items_with_their_quests_and_why() {
	let db = db();
	let out = run(
		&db,
		r#"
E.SetGuide("test/ah")
stub.advance(5)
CT.Later()
w.bank[4306] = 3
stub.advance(1)
local item = AU.MenuItem()
emit(item and item.text or false)
item.onClick()
stub.advance(0.5)
local F = PolestarAuctionBuys
local rows = {}
for i, r in ipairs(F.rows) do if r:IsShown() then rows[i] = r.Title:GetText() .. " | " .. r.Why:GetText() end end
emit({ shown = F:IsShown(), title = F.Title:GetText(), rows = rows, go = F.Go:IsShown() })
"#,
	);
	assert_eq!(out[0], json!("Auction house buys (2)"));
	assert_eq!(
		out[1],
		json!({
			"shown": true, "title": "Auction house buys",
			"rows": ["12 Silk Cloth | For Caught!  ·  About 152 kills to farm  ·  3 in your bags and bank", "10 Iron Bar | For Brutal Armor  ·  Crafted: nothing drops it"],
			"go": true,
		})
	);
}

// Off: no card when the guide opens, no reminder in town, no menu entry, an empty list.
#[test]
fn with_the_setting_off_nothing_shows() {
	let db = db();
	let out = run_with(
		&db,
		"",
		"PolestarDB = { schema = 1, settings = { qol = { auctionBuys = false } } }",
		r#"
E.SetGuide("test/ah")
stub.advance(5)
local opened = card()
acceptAll()
enterTown(1454, 54, 66, "Orgrimmar", "The Drag")
emit({ opened = opened, town = card(), menu = AU.MenuItem() or false, list = #names("all") })
"#,
	);
	assert_eq!(out[0], json!({ "opened": false, "town": false, "menu": false, "list": 0 }));
}

// The gamepad: the card shows on its own, so it leaves the buttons to the game until the focus binding gives it the
// gamepad; B is Later. The list, opened from the guide window's menu, takes the gamepad as it opens: the D-pad walks
// its item icons and its button, B closes it.
#[test]
fn the_card_waits_for_the_focus_binding_and_the_list_takes_the_gamepad() {
	let db = db();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua", "stub_gamepad.lua"],
		before: format!("stub.quests.dbFiles = {}\n{WORLD}", db.lua_files()),
		addons: vec![Addon::name("Polestar")],
		script: format!(
			"{TEST_PACK}\n{GUIDE}\nstub.login()\nstub.advance(0.5)\n{PRELUDE}\n{}",
			r#"
local G = Polestar.Gamepad
Polestar.Set("gamepad.withMouse", true)
E.SetGuide("test/ah")
stub.advance(5)
local shown = card() and card().kind or false
local before = { entry = G.entry ~= nil, a = stub.press("PAD1") }
G.ToggleFocus()
stub.advance(0.1)
local took = G.entry ~= nil and G.entry.frame == CT.frame
stub.press("PAD2")
stub.advance(0.6)
emit({ shown = shown, before = before, took = took, after = card() })
AU.MenuItem().onClick()
stub.advance(0.5)
local F = PolestarAuctionBuys
local holds = G.entry ~= nil and G.entry.frame == F
local seen = {}
for _ = 1, 4 do
	local w = G.Focused(F)
	seen[#seen + 1] = w == F.Go and "go" or (w and w.psItem and ("item " .. w.psItem)) or (w == F.Close and "close") or "?"
	stub.press("PADDDOWN")
end
stub.press("PAD2")
emit({ holds = holds, seen = seen, closed = not F:IsShown() })
"#
		),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "shown": "auctionGuide", "before": { "entry": false, "a": "game" }, "took": true, "after": false }));
	assert_eq!(out[1]["holds"], json!(true));
	let seen = out[1]["seen"].as_array().unwrap();
	assert!(seen.iter().any(|v| v == "item 4306") && seen.iter().any(|v| v == "go"), "{seen:?}");
	assert_eq!(out[1]["closed"], json!(true));
}
