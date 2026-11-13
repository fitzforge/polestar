//! Materials gathered or bought (docs/GUIDE_FORMAT.md, "Materials"; addon/Polestar/Core/Materials.lua and the
//! Engine's Own.materialApplies): an item a profession guide both gathers (`collect … gather`) and buys (`auction`)
//! takes one way at a time, and only that way's goals apply. Mix, the way before an answer, gathers what the
//! character can at its level and with its professions and buys the rest; Gather all and Buy all clear the picks; a
//! pick takes the route back to the Auction House step or on to the gather steps; a Self-Found character gathers
//! everything. The bags, the bank (a snapshot away from it), the mail and the purchases on their way count, and the
//! arrow fetches what waits in the mail or the bank; other characters' counts show, and count only when switched on.
//! Prices are for the count still to buy, from the player's own searches, else Auctionator's.
//! Real Core manifest, stub world (a level 10 Human Warrior).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const CORE: &[&str] = &["Core/Core.xml"];
const WITH_ALTS: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Alts/Alts.xml"];
const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Tailoring 1-75: the Auction House step buys what the gather steps after it gather.
const GUIDE: &str = r#"
local auctioneer = { { npc = 8719, npcName = "Auctioneer Fitch", map = 1453, x = 61.2, y = 70.6, faction = "A" } }
Polestar.RegisterGuide({
	id = "test/tailoring", pack = "test", title = "Tailoring 1-75", category = "Professions", minLevel = 1, maxLevel = 60,
	sections = { { skill = "Tailoring", skillLine = 197, from = 1, to = 75 } },
	steps = {
		{ title = "Learn Tailoring", section = 1, goals = { { t = "train", skill = "Tailoring", skillLine = 197, rank = 1, rankMax = 75 } } },
		{ title = "Auction House", section = 1, goals = {
			{ t = "auction", item = 2589, itemName = "Linen Cloth", count = 40, candidates = auctioneer },
			{ t = "auction", item = 2318, itemName = "Light Leather", count = 10, candidates = auctioneer },
		} },
		{ title = "Linen Cloth", section = 1, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 40, gather = { min = 5, max = 15 } } } },
		{ title = "Light Leather", section = 1, goals = { { t = "collect", item = 2318, itemName = "Light Leather", count = 10, map = 1429, x = 40, y = 60,
			gather = { skill = "Skinning", skillLine = 393, rank = 1 } } } },
		{ title = "Linen Cloak", section = 1, goals = { { t = "craft", spell = 2387, spellName = "Linen Cloak", item = 2570, itemName = "Linen Cloak",
			skillLine = 197, untilSkill = 75, yellow = 50, grey = 75, reagents = { { item = 2589, itemName = "Linen Cloth", count = 2 } } } } },
	},
})
"#;

fn run(files: &[&str], saved: &str, script: &str) -> Value {
	let mut stubs = vec!["stub_world.lua"];
	if files.contains(&"UI/UI.xml") {
		stubs.push("stub_ui.lua");
	}
	emitted(&RunAddon {
		stubs,
		before: "stub.world.level = 10\n".into(),
		addons: vec![Addon::files("Polestar", files)],
		saved: if saved.is_empty() { Vec::new() } else { vec![("Polestar".into(), saved.into())] },
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
E, M, w, ID = Polestar.Engine, Polestar.Materials, stub.world, "test/tailoring"
function flush() stub.advance(1.1) end
-- The live step and its goals for this character: "text cur/max".
function open()
	local at = E.GetLiveStep()
	local v = at and E.GetStepView(at)
	local out = {{}}
	for _, g in ipairs(v and v.goals or {{}}) do
		if g.status ~= "na" then out[#out + 1] = g.text .. (g.progress and (" " .. g.progress.cur .. "/" .. g.progress.max) or "") end
	end
	return {{ at = at or false, open = out }}
end
-- Goal g of step s as the window reads it.
function goal(s, g)
	local gv = E.GetStepView(s).goals[g]
	local m = gv.materials
	return {{ status = gv.status, text = gv.text, detail = gv.detail or false, npc = gv.npcName or false, at = gv.map and {{ gv.map, gv.x, gv.y }} or false,
		bank = m and m.bank or false, mail = m and m.mail or false, toGet = m and m.toGet or false, alts = m and m.alts or false, price = m and m.price or false }}
end
stub.login(); flush()
E.SetGuide(ID); flush()
w.learnSkill(197, "Tailoring", 1, 75); flush()
r = {{}}
{script}
emit(r)"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn each_material_takes_one_way_and_the_route_follows_a_pick_the_mode_the_level_and_self_found() {
	let out = run(
		CORE,
		"",
		r#"
		r.asks = M.Asks(ID)
		r.mix = open()
		r.leatherWhy = E.GetStepView(4).why or false
		w.learnSkill(393, "Skinning", 1, 75); flush()
		r.skinner = open()
		r.ahWhy = E.GetStepView(2).why or false
		M.SetWay(ID, 2589, "buy"); flush()
		r.picked = open()
		r.pick = { M.Mode(ID, 2589) }
		r.asked = M.Asks(ID)
		M.SetMode(ID, "gather"); flush()
		r.gatherAll = open()
		r.cleared = { M.Mode(ID, 2589) }
		M.SetMode(ID, "buy"); flush()
		r.buyAll = open()
		M.SetMode(ID, "mix"); flush()
		w.setLevel(2); flush()
		r.low = { open(), E.GetStepView(3).why or false }
		w.setLevel(20); flush()
		r.within = open()
		w.setLevel(21); flush()
		r.past = { open(), E.GetStepView(3).why or false }
		local P = Polestar.Compat.GetPlayerInfo()
		r.noGather = { M.Way({ id = "x/buy", steps = { { goals = { { t = "auction", item = 1 } } } } }, 1, P) }
		r.noBuy = { M.Way({ id = "x/gather", steps = { { goals = { { t = "collect", item = 2, gather = true } } } } }, 2, P) }
		C_PlayerInfo = C_PlayerInfo or {}
		C_PlayerInfo.IsSelfFoundActive = function() return true end
		M.SetMode(ID, "buy"); flush()
		r.selfFound = { open(), E.GetStepView(2).why or false }
		"#,
	);
	assert_eq!(out["asks"], true, "no answer yet, and Options' default asks");
	// Mix: Linen Cloth drops at the character's level (gathered); Light Leather takes Skinning (bought).
	assert_eq!(out["mix"], json!({ "at": 2, "open": ["Buy Light Leather 0/10"] }));
	assert_eq!(out["leatherWhy"], "Bought at the Auction House: needs Skinning 1");
	// Skinning learned: the leather is gathered too, and the Auction House step passes.
	assert_eq!(out["skinner"], json!({ "at": 3, "open": ["Collect Linen Cloth 0/40"] }));
	assert_eq!(out["ahWhy"], "Gathering this yourself");
	// Buy instead on the Linen Cloth step: back to the Auction House step.
	assert_eq!(out["picked"], json!({ "at": 2, "open": ["Buy Linen Cloth 0/40"] }));
	assert_eq!(out["pick"], json!(["mix", true, "buy"]));
	assert_eq!(out["asked"], false, "a pick answers the guide");
	assert_eq!(out["gatherAll"], json!({ "at": 3, "open": ["Collect Linen Cloth 0/40"] }));
	assert_eq!(out["cleared"], json!(["gather", true]), "Gather all clears the picks");
	assert_eq!(out["buyAll"], json!({ "at": 2, "open": ["Buy Linen Cloth 0/40", "Buy Light Leather 0/10"] }));
	// Mix by level: Linen Cloth's humanoids are level 5-15.
	assert_eq!(out["low"], json!([{ "at": 2, "open": ["Buy Linen Cloth 0/40"] }, "Bought at the Auction House: it drops from level 5"]));
	assert_eq!(out["past"], json!([{ "at": 2, "open": ["Buy Linen Cloth 0/40"] }, "Bought at the Auction House: you're past its levels"]));
	assert_eq!(out["within"], json!({ "at": 3, "open": ["Collect Linen Cloth 0/40"] }));
	assert_eq!(out["noGather"], json!(["buy", "noGather"]));
	assert_eq!(out["noBuy"], json!(["gather", "noBuy"]));
	// Self-Found: no Auction House, even in Buy all.
	assert_eq!(out["selfFound"], json!([{ "at": 3, "open": ["Collect Linen Cloth 0/40"] }, "No Auction House for self-found characters"]));
}

#[test]
fn the_bank_the_mail_and_purchases_count_the_arrow_fetches_what_waits_and_other_characters_count_when_asked() {
	let out = run(
		WITH_ALTS,
		r#"PolestarDB = { schema = 1, alts = { chars = {
			["Kaelia-Test Realm"] = { key = "Kaelia-Test Realm", name = "Kaelia", realm = "Test Realm", faction = "Alliance", level = 30, seen = 1, mats = { [2589] = 120 } },
			["Grom-Test Realm"] = { key = "Grom-Test Realm", name = "Grom", realm = "Test Realm", faction = "Horde", level = 30, seen = 1, mats = { [2589] = 50 } },
		} } }"#,
		r#"
		local bank, inbox = {}, {}
		local bags = C_Item.GetItemCount
		C_Item.GetItemCount = function(id, withBank) return bags(id) + (withBank and bank[id] or 0) end
		function GetInboxNumItems() return #inbox, #inbox end
		function GetInboxHeaderInfo(i) return nil, nil, "Auction House", "Auction won", 0, 0, 30, #inbox[i] end
		function GetInboxItem(i, a) local it = inbox[i][a]; if it then return "item", it[1], nil, it[2] end end
		M.Nearest = function(kind)
			if kind == "bank" then return { id = 2455, name = "Olivia Burnside", map = 1453, x = 57.4, y = 72.6 } end
			return { id = 143981, name = "Mailbox", map = 1453, x = 60.1, y = 70.2 }
		end
		M.SetMode(ID, "buy"); flush()
		r.alts = goal(2, 1)
		Polestar.Set("professions.altMaterials", true); flush()
		r.counted = goal(2, 1)
		Polestar.Set("professions.altMaterials", false); flush()
		-- 4 Light Leather in the bags and 6 in the bank make the 10.
		w.addItem(2318, 4); bank[2318] = 6
		stub.fire("BANKFRAME_OPENED"); stub.fire("BANKFRAME_CLOSED"); bank[2318] = nil; flush()
		r.bank = goal(2, 2)
		bank[2318] = 6
		stub.fire("BANKFRAME_OPENED"); bank[2318] = nil; w.addItem(2318, 6); stub.fire("PLAYERBANKSLOTS_CHANGED"); stub.fire("BANKFRAME_CLOSED"); flush()
		r.withdrawn = goal(2, 2)
		-- 15 Linen Cloth in the mail, then 25 bought.
		inbox = { { { 2589, 15 } } }; stub.fire("MAIL_INBOX_UPDATE"); flush()
		r.mail = goal(2, 1)
		stub.fire("COMMODITY_PURCHASED", 2589, 25); flush()
		r.bought = goal(2, 1)
		inbox = { { { 2589, 40 } } }; stub.fire("MAIL_INBOX_UPDATE"); flush()
		r.arrived = goal(2, 1)
		inbox = {}; w.addItem(2589, 40); stub.fire("MAIL_INBOX_UPDATE"); flush()
		r.taken = { E.GetLiveStep(), goal(2, 1).status }
		w.removeItem(2589); flush()
		r.latched = { E.GetLiveStep(), goal(2, 1).status }
		r.own = { leather = (M.OwnCounts() or {})[2318] or false, linen = (M.OwnCounts() or {})[2589] or false }
		"#,
	);
	let auctioneer = json!([1453, 61.2, 70.6]);
	let kaelia = json!([{ "name": "Kaelia", "count": 120 }]);
	assert_eq!(
		out["alts"],
		json!({ "status": "active", "text": "Buy Linen Cloth", "detail": "at the Auction House", "npc": "Auctioneer Fitch", "at": auctioneer,
			"bank": 0, "mail": 0, "toGet": 40, "alts": kaelia, "price": false }),
		"another character of this realm and faction holds 120: shown, not counted; the Horde one is left out"
	);
	assert_eq!(out["counted"]["toGet"], 0, "counted once switched on");
	assert_eq!(out["counted"]["text"], "Buy Linen Cloth", "the arrow never sends the player to another character");
	assert_eq!(
		out["bank"],
		json!({ "status": "active", "text": "Take Light Leather", "detail": "from your bank", "npc": "Olivia Burnside", "at": [1453, 57.4, 72.6],
			"bank": 6, "mail": 0, "toGet": 0, "alts": {}, "price": false }),
		"the bank as at the last visit, away from it"
	);
	// Taken from the bank: the bags hold the 10, the goal is done and reads as it is written.
	assert_eq!(out["withdrawn"]["status"], "done");
	assert_eq!(out["withdrawn"]["text"], "Buy 10 Light Leather");
	assert_eq!(out["withdrawn"]["detail"], "at the Auction House");
	assert_eq!(
		out["mail"],
		json!({ "status": "active", "text": "Buy Linen Cloth", "detail": "at the Auction House", "npc": "Auctioneer Fitch", "at": auctioneer,
			"bank": 0, "mail": 15, "toGet": 25, "alts": kaelia, "price": false })
	);
	let mailbox = json!({ "status": "active", "text": "Take Linen Cloth", "detail": "from your mail", "npc": false, "at": [1453, 60.1, 70.2],
		"bank": 0, "mail": 40, "toGet": 0, "alts": kaelia, "price": false });
	assert_eq!(out["bought"], mailbox, "the purchase is on its way by mail: nothing left to buy");
	assert_eq!(out["arrived"], mailbox, "the inbox now lists it");
	// Taken from the mail: the step is done and the route goes on to the crafts (Buy all: the gather steps pass).
	assert_eq!(out["taken"], json!([5, "done"]));
	assert_eq!(out["latched"], json!([5, "done"]), "crafting the cloth away never reopens the step");
	assert_eq!(out["own"], json!({ "leather": 10, "linen": false }));
}

#[test]
fn an_item_no_profession_guide_has_counts_its_mail_its_purchases_and_the_bank_the_client_reports() {
	// Materials.Have is the one count of what the character holds: the auction house buys (Quests/AuctionBuys.lua)
	// read it for quest items, which no profession guide tracks.
	let out = run(
		CORE,
		"",
		r#"
		local bank, inbox = {}, {}
		local bags = C_Item.GetItemCount
		C_Item.GetItemCount = function(id, withBank) return bags(id) + (withBank and bank[id] or 0) end
		function GetInboxNumItems() return #inbox, #inbox end
		function GetInboxHeaderInfo(i) return nil, nil, "Auction House", "Auction won", 0, 0, 30, #inbox[i] end
		function GetInboxItem(i, a) local it = inbox[i][a]; if it then return "item", it[1], nil, it[2] end end
		w.addItem(5000, 3)
		stub.fire("BANKFRAME_OPENED"); stub.fire("BANKFRAME_CLOSED"); flush()
		-- The snapshot holds no item 5000: the client's count. A tracked material keeps the snapshot's.
		bank[5000], bank[2318] = 2, 7
		r.bank = { M.Have(5000) }
		r.tracked = { M.Have(2318) }
		inbox = { { { 5000, 4 } } }; stub.fire("MAIL_INBOX_UPDATE")
		stub.fire("COMMODITY_PURCHASED", 5000, 5); flush()
		r.all = { M.Have(5000) }
		"#,
	);
	assert_eq!(out["bank"], json!([5, { "bags": 3, "bank": 2, "mail": 0, "coming": 0, "alts": {}, "altsCounted": false }]));
	assert_eq!(out["tracked"], json!([0, { "bags": 0, "bank": 0, "mail": 0, "coming": 0, "alts": {}, "altsCounted": false }]), "the bank held none at the visit");
	assert_eq!(out["all"], json!([14, { "bags": 3, "bank": 2, "mail": 4, "coming": 5, "alts": {}, "altsCounted": false }]), "4 in the mail, 5 bought on their way");
}

#[test]
fn prices_are_for_the_count_cheapest_first_auctionator_fills_in_and_counts_shrink_with_the_skill() {
	let out = run(
		WITH_UI,
		"",
		r#"
		M.SetMode(ID, "buy"); flush()
		M.NoteSearch(2318, { { price = 150, quantity = 100 }, { price = 100, quantity = 3 } })
		r.leather = { M.Price(2318, 10) }
		r.few = { M.Price(2318, 200) }
		Auctionator = { API = { v1 = {
			GetAuctionPriceByItemID = function(caller, id) if caller == "Polestar" and id == 2589 then return 25 end end,
			GetAuctionAgeByItemID = function() return 2 end,
		} } }
		r.linen = { M.Price(2589, 40) }
		E.RequestUpdate(); flush()
		r.view = { goal(2, 1).price, goal(2, 2).price }
		r.line = Polestar.UI.MaterialsLine({ t = "auction", materials = { bank = 40, mail = 0, alts = {}, toGet = 47, price = 8700, age = 4 * 86400, listed = 30 } })
		r.gather = Polestar.UI.MaterialsLine({ t = "collect", materials = { bank = 0, mail = 5, alts = { { name = "Kaelia", count = 120 } }, toGet = 0 } }) or false
		w.skillUp(197, 10); flush()
		r.shrunk = open()
		"#,
	);
	assert_eq!(out["leather"], json!([1350, { "each": 100, "age": 0, "source": "search" }]), "3 at 1s, then 7 at 1s 50c");
	assert_eq!(out["few"], json!([15300, { "each": 100, "age": 0, "source": "search", "short": 97 }]), "only 103 listed");
	assert_eq!(out["linen"], json!([1000, { "each": 25, "age": 172800, "source": "auctionator" }]));
	assert_eq!(out["view"], json!([1000, 1350]), "each goal priced for what it still has to buy");
	assert_eq!(out["line"], "40 in your bank  \u{b7}  47 to buy  \u{b7}  \u{2248} 87s (only 30 listed) (old price)");
	assert_eq!(out["gather"], "5 in your mail  \u{b7}  Kaelia has 120");
	// Skill 10: the 9 Linen Cloaks made from 1 took 18 cloth.
	assert_eq!(out["shrunk"], json!({ "at": 2, "open": ["Buy Linen Cloth 0/22", "Buy Light Leather 0/10"] }));
}
