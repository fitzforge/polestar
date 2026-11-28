//! A profession guide's materials on screen beyond its get steps (Core/Materials.lua and Engine.MaterialRows for the
//! counts and ways): the shopping list beside the Auction House with the guide's materials to buy and a search for
//! each and its heading in the client's language, end to end on the real addon in the stub world: a level 8 Human
//! Warrior with Tailoring 1 and no Skinning, on a Tailoring guide of two ranges. Nothing asks for a guide-wide way:
//! no card, no Materials window (0.4.4).

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
local w, E, M = stub.world, Polestar.Engine, Polestar.Materials
local ID = "test/tailoring"
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
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

// A guide's title may be in the client's language: the list's heading stays in capitals (Polestar.Upper), where
// Lua's upper() leaves accented letters small ("PREMIÈRE", not "PREMIèRE").
#[test]
fn the_shopping_list_heading_keeps_its_capitals_in_the_clients_language() {
	let world = WORLD.replace(r#"w.learnSkill(197, "Tailoring", 1, 75)"#, r#"w.learnSkill(197, "Портняжное дело", 1, 75)"#);
	let guide = GUIDE.replace(r#"title = "Tailoring 1-150""#, r#"title = "Couture, première étape 1-150""#);
	let out = run_in(&world, &guide, &["local selected = {}", AUCTION_HOUSE, "r.auction = PolestarAuctionBuys.MatHead:GetText()"].concat());
	assert_eq!(out["auction"], "MATERIALS FOR COUTURE, PREMIÈRE ÉTAPE 1-150");
}
