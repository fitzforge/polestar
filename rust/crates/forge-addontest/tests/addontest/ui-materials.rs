//! Gather, buy or mix on screen (addon/Polestar/UI/Materials.lua; Core/Materials.lua and Engine.MaterialRows for
//! the counts and ways): the card a profession guide shows once, its answers in order (Mix, Gather, Buy, then
//! Later), the Materials window and the guide window's menu, end to end on the real addon in the stub world: a level
//! 8 Human Warrior (below the class quest card's levels) with Tailoring 1 and no Skinning, on a Tailoring guide of
//! two ranges.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1453, { name = "Stormwind City", c = 0, left = 1000, right = 0, top = 0, bottom = -1000 })
w.level = 8
w.zone, w.subzone = "Stormwind City", ""
w.moveTo(1453, 60, 70)
w.learnSkill(197, "Tailoring", 1, 75)
"#;

// Tailoring 1-75 buys Linen Cloth and Light Leather or gathers them (the cloth from mobs of level 5-15, the leather
// with Skinning 1); 75-150 buys or gathers Wool Cloth (mobs of level 15-30).
const GUIDE: &str = r#"
local auctioneer = { { npc = 8719, npcName = "Auctioneer Fitch", map = 1453, x = 61.2, y = 70.6, faction = "A" } }
Polestar.RegisterGuide({
	id = "test/tailoring", pack = "test", title = "Tailoring 1-150", category = "Professions", minLevel = 1, maxLevel = 60,
	sections = { { skill = "Tailoring", skillLine = 197, from = 1, to = 75 }, { skill = "Tailoring", skillLine = 197, from = 75, to = 150 } },
	steps = {
		{ title = "Auction House", section = 1, goals = {
			{ t = "auction", item = 2589, itemName = "Linen Cloth", count = 40, candidates = auctioneer },
			{ t = "auction", item = 2318, itemName = "Light Leather", count = 10, candidates = auctioneer },
		} },
		{ title = "Linen Cloth", section = 1, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 40, gather = { min = 5, max = 15 } } } },
		{ title = "Light Leather", section = 1, goals = { { t = "collect", item = 2318, itemName = "Light Leather", count = 10, map = 1429, x = 40, y = 60,
			gather = { skill = "Skinning", skillLine = 393, rank = 1 } } } },
		{ title = "Linen Cloak", section = 1, goals = { { t = "craft", spell = 2387, spellName = "Linen Cloak", item = 2570, itemName = "Linen Cloak",
			skillLine = 197, untilSkill = 75, yellow = 50, grey = 75, reagents = { { item = 2589, itemName = "Linen Cloth", count = 2 } } } } },
		{ title = "Auction House", section = 2, goals = { { t = "auction", item = 2592, itemName = "Wool Cloth", count = 50, candidates = auctioneer } } },
		{ title = "Wool Cloth", section = 2, goals = { { t = "collect", item = 2592, itemName = "Wool Cloth", count = 50, gather = { min = 15, max = 30 } } } },
	},
})
"#;

const HELPERS: &str = r#"
local w, E, M, MA, CT = stub.world, Polestar.Engine, Polestar.Materials, Polestar.UI.Materials, Polestar.UI.ClassToast
local ID = "test/tailoring"
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
-- The card on screen: its words and answers.
local function card()
	local m = CT.current
	if not m then return false end
	return { kind = m.kind, head = m.head, title = m.title, giver = m.giver, route = m.route,
		answers = { m.act and m.act.label or false, m.more and m.more.label or false, m.off and m.off.label or false, m.later and m.later.label or false } }
end
-- The window's rows: name, second line, the way lit (gather | buy), Gather and Buy on or off.
local function rows()
	local out = {}
	for _, r in ipairs(PolestarMaterials.rows) do
		if r:IsShown() then
			out[#out + 1] = { plain(r.Name:GetText()), plain(r.Sub:GetText()), r.Gather.psPrimary and "gather" or (r.Buy.psPrimary and "buy" or "-"),
				r.Gather:IsEnabled() and true or false, r.Buy:IsEnabled() and true or false }
		end
	end
	return out
end
local function heads()
	local out = {}
	for _, h in ipairs(PolestarMaterials.heads) do if h:IsShown() then out[#out + 1] = plain(h:GetText()) end end
	return out
end
local function modes()
	local out = {}
	for _, m in ipairs({ "gather", "buy", "mix" }) do if PolestarMaterials.Modes[m].psPrimary then out[#out + 1] = m end end
	return out
end
r = {}
"#;

fn run(script: &str) -> Value {
	run_in(WORLD, GUIDE, script)
}

fn run_in(world: &str, guide: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/tailoring" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, guide, "stub.login()", "stub.advance(1)", HELPERS, script, "emit(r)"].join("\n"),
		..Default::default()
	})
	.remove(0)
}

// The game's Auction House window (Blizzard_AuctionHouseUI) and its buy view, opened.
const AUCTION_HOUSE: &str = r#"
		AuctionHouseFrame = CreateFrame("Frame", "AuctionHouseFrame", UIParent)
		AuctionHouseFrame:SetSize(800, 600)
		function AuctionHouseFrame:SelectBrowseResult(result) selected[#selected + 1] = result.itemKey.itemID end
		function AuctionHouseFrame:TriggerEvent() end
		C_AuctionHouse = { MakeItemKey = function(id) return { itemID = id } end, GetItemKeyInfo = function() return { isCommodity = true } end }
		AuctionHouseFrame:Show()
		stub.fire("AUCTION_HOUSE_SHOW"); stub.advance(0.5)
"#;

#[test]
fn a_profession_guide_asks_once_on_a_card_and_its_answers_mix_gather_and_buy_come_before_later() {
	let out = run(r#"
		r.before = card()
		stub.advance(4)
		r.card = card()
		-- The buttons in order: Mix (the action), Gather, Buy right after it, then Later.
		local f = CT.frame
		local function rel(b) local _, to = b:GetPoint(1); return to end
		r.order = { rel(f.Off) == f.More, rel(f.Later) == f.Off or rel(f.Later) == f }
		-- Mix: answered, the card goes and the window opens.
		CT.Act(); stub.advance(0.5)
		r.mix = { card(), M.Mode(ID), M.Asks(ID), PolestarMaterials:IsShown() }
		"#);
	assert_eq!(out["before"], json!(false), "not before the guide's catch-up");
	assert_eq!(
		out["card"],
		json!({ "kind": "materials", "head": "MATERIALS  \u{b7}  TAILORING 1-150", "title": "How do you want to get them?",
			"giver": "The rest of the guide takes 40 Linen Cloth, 10 Light Leather and 50 Wool Cloth.",
			"route": "Mix gathers Linen Cloth and buys Light Leather and Wool Cloth.",
			"answers": ["Mix", "Gather", "Buy", "Later"] })
	);
	assert_eq!(out["order"], json!([true, true]));
	assert_eq!(out["mix"], json!([false, "mix", false, true]));
}

#[test]
fn the_window_lists_each_material_of_the_ranges_ahead_with_its_way_a_pick_moves_it_and_a_right_click_takes_it_back() {
	let out = run(r#"
		MA.Show(); stub.advance(0.5)
		r.title = PolestarMaterials.Title:GetText()
		r.modes = modes()
		r.heads = heads()
		r.rows = rows()
		r.total = plain(PolestarMaterials.Total:GetText())
		r.export = PolestarMaterials.Export.Label:GetText()
		-- Buy on the cloth: the player's pick, the guide now Mix with it.
		PolestarMaterials.rows[1].Buy:Click(); stub.advance(0.5)
		r.picked = { rows()[1], M.Mode(ID, 2589) }
		-- A right-click: back to Mix's own way.
		local row1 = PolestarMaterials.rows[1]
		row1:GetScript("OnClick")(row1, "RightButton"); stub.advance(0.5)
		r.back = rows()[1]
		-- Buy all, then this range only.
		PolestarMaterials.Modes.buy:Click(); stub.advance(0.5)
		r.buyAll = { modes(), rows()[1][3] }
		PolestarMaterials.Scope:Click(); stub.advance(0.5)
		r.range = { PolestarMaterials.Scope.Label:GetText(), heads(), #rows() }
		"#);
	assert_eq!(out["title"], "Materials: Tailoring 1-150");
	assert_eq!(out["modes"], json!(["mix"]), "no answer yet: Mix");
	assert_eq!(out["heads"], json!(["TAILORING 1-75  \u{b7}  your skill 1", "TAILORING 75-150  \u{b7}  your skill 1"]));
	assert_eq!(
		out["rows"],
		json!([
			["Linen Cloth", "40 still to get  \u{b7}  Mobs of level 5-15", "gather", true, true],
			["Light Leather", "10 still to get  \u{b7}  Needs Skinning 1", "buy", false, true],
			["Wool Cloth", "50 still to get  \u{b7}  Drops from level 15", "buy", true, true],
		]),
		"a profession the character lacks leaves no gathering; mobs above its level are its choice"
	);
	assert!(out["total"].as_str().unwrap().starts_with("No prices yet: a search at the Auction House prices what it finds.  \u{b7}  You have "), "{}", out["total"]);
	assert_eq!(out["export"], "Copy list");
	assert_eq!(out["picked"], json!([["Linen Cloth", "40 still to get  \u{b7}  Your choice", "buy", true, true], "mix", true, "buy"]));
	assert_eq!(out["back"], json!(["Linen Cloth", "40 still to get  \u{b7}  Mobs of level 5-15", "gather", true, true]));
	assert_eq!(out["buyAll"], json!([["buy"], "buy"]));
	assert_eq!(out["range"], json!(["This range", ["TAILORING 1-75  \u{b7}  your skill 1"], 2]));
}

#[test]
fn later_keeps_mix_and_asks_no_more_a_guide_switch_asks_again_and_the_menu_changes_the_way() {
	let out = run(r#"
		stub.advance(4)
		-- Another guide running takes the card away unanswered: the guide asks again when it runs.
		Polestar.RegisterGuide({ id = "test/other", pack = "test", title = "Other", minLevel = 1, maxLevel = 60,
			steps = { { title = "Somewhere", goals = { { t = "goto", map = 1453, x = 50, y = 50 } } } } })
		E.SetGuide("test/other"); stub.advance(0.5)
		r.switched = { card(), M.Asks(ID) }
		E.SetGuide(ID); stub.advance(4.5)
		r.again = card() and true or false
		CT.Later(); stub.advance(0.5)
		r.later = { card(), M.Mode(ID), M.Asks(ID), MA.Check(ID) }
		-- The menu: the three ways, Mix checked; Gather materials answers Gather all.
		local items = MA.MenuItems()
		r.menu = {}
		for _, it in ipairs(items) do r.menu[#r.menu + 1] = it.separator and "-" or { it.text, it.checked and true or false } end
		items[1].onClick(); stub.advance(0.5)
		r.gather = { M.Mode(ID) }
		"#);
	assert_eq!(out["switched"], json!([false, true]));
	assert_eq!(out["again"], json!(true));
	assert_eq!(out["later"], json!([false, "mix", false, false]));
	assert_eq!(out["menu"], json!([["Gather materials", false], ["Buy materials", false], ["Mix: choose per material", true], "-"]));
	assert_eq!(out["gather"], json!(["gather", true]));
}

#[test]
fn at_the_auction_house_the_list_opens_beside_it_with_the_guides_materials_to_buy_and_a_search_for_each() {
	let out = run(&[
		"local selected = {}",
		AUCTION_HOUSE,
		r#"
		local F = PolestarAuctionBuys
		local _, to = F:GetPoint(1)
		r.docked = { F:IsShown(), to == AuctionHouseFrame }
		r.head = F.MatHead:GetText()
		r.rows = {}
		for _, row in ipairs(F.mrows) do
			if row:IsShown() then r.rows[#r.rows + 1] = { plain(row.Title:GetText()), plain(row.Why:GetText()), row.Search:IsShown() } end
		end
		F.mrows[2].Search:Click(); stub.advance(0.5)
		r.selected = selected
		AuctionHouseFrame:Hide()
		stub.fire("AUCTION_HOUSE_CLOSED"); stub.advance(0.5)
		r.closed = F:IsShown()
		"#,
	]
	.concat());
	assert_eq!(out["docked"], json!([true, true]), "beside the game's window");
	assert_eq!(out["head"], "MATERIALS FOR TAILORING 1-150");
	assert_eq!(out["rows"], json!([["10 Light Leather", "Tailoring 1-75", true], ["50 Wool Cloth", "Tailoring 75-150", true]]));
	assert_eq!(out["selected"], json!([2592]), "Search opens the game's own buy view of the item");
	assert_eq!(out["closed"], json!(false), "it goes with the Auction House");
}

// A client in another language names the skill its own way, and a guide's title may be in it: the headings stay in
// capitals (Polestar.Upper), where Lua's upper() leaves accented and Cyrillic letters small ("ПОРТНЯЖНОЕ ДЕЛО", not
// "Портняжное дело"; "PREMIÈRE", not "PREMIèRE").
#[test]
fn the_headings_keep_their_capitals_in_the_clients_language() {
	let world = WORLD.replace(r#"w.learnSkill(197, "Tailoring", 1, 75)"#, r#"w.learnSkill(197, "Портняжное дело", 1, 75)"#);
	let guide = GUIDE.replace(r#"title = "Tailoring 1-150""#, r#"title = "Couture, première étape 1-150""#);
	let out = run_in(
		&world,
		&guide,
		&[
			r#"
		stub.advance(4)
		r.card = CT.current and CT.current.head
		MA.Show(); stub.advance(0.5)
		r.heads = heads()
		local selected = {}"#,
			AUCTION_HOUSE,
			"r.auction = PolestarAuctionBuys.MatHead:GetText()",
		]
		.concat(),
	);
	assert_eq!(out["card"], "MATERIALS  \u{b7}  COUTURE, PREMIÈRE ÉTAPE 1-150");
	assert_eq!(out["heads"], json!(["ПОРТНЯЖНОЕ ДЕЛО 1-75  \u{b7}  your skill 1", "ПОРТНЯЖНОЕ ДЕЛО 75-150  \u{b7}  your skill 1"]));
	assert_eq!(out["auction"], "MATERIALS FOR COUTURE, PREMIÈRE ÉTAPE 1-150");
}
