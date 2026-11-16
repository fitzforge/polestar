'use strict';
// Gather, buy or mix (UI/Materials.lua, Core/Materials.lua) and While you're here's gathering spots (Core/Gather.lua)
// in every look at the game's UI scales 0.64, 1.0 and 1.5: the card a profession guide shows once, the Materials
// window, the shopping list beside the Auction House with the guide's materials (each with its Search), a gathering
// spot line with its tracking chip, and the Guide page's Professions tab. A level 22 Human Warrior with Tailoring 112
// and Herbalism 70 (no Skinning) by Goldshire, on a Tailoring guide registered here: 75-150 buys or gathers Wool
// Cloth (140 in the bags) and Silk Cloth, 150-225 Silk and Mageweave Cloth, 225-300 Rugged Leather.
// The looks are the built-in six and the skin addons in the download (skins.js's list, without its variants), each
// picked as skins.js picks it. Shots: <look>-<surface>-<scale> (studio materials/hearth-window-0.64 ...), surface
// card | window | shop | gather | options.
//
// The UI scale: UIParent at that scale, its size in UI units the screen's 1920 x 1080 over it, as the client has it.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];

const SCALE = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end`;

// The guide and the character's professions, bags and a price seen at the Auction House.
const SETUP = `Polestar.RegisterPack({ addon = "Polestar_Studio", id = "studio", format = 1, title = "Studio", author = "Polestar", version = "1", license = "MIT" })
local ah = { { npc = 8719, npcName = "Auctioneer Fitch", map = 1453, x = 61.2, y = 70.6, faction = "A" } }
local function sec(n, from, to) return { skill = "Tailoring", skillLine = 197, from = from, to = to } end
Polestar.RegisterGuide({
	id = "studio/tailoring", pack = "studio", title = "Tailoring 1-300", category = "Professions", minLevel = 5, maxLevel = 60,
	sections = { sec(1, 75, 150), sec(2, 150, 225), sec(3, 225, 300) },
	steps = {
		{ title = "Auction House", section = 1, goals = {
			{ t = "auction", item = 2592, itemName = "Wool Cloth", count = 227, candidates = ah },
			{ t = "auction", item = 4306, itemName = "Silk Cloth", count = 204, candidates = ah } } },
		{ title = "Wool Cloth", section = 1, goals = { { t = "collect", item = 2592, itemName = "Wool Cloth", count = 227, gather = { min = 15, max = 30 } } } },
		{ title = "Silk Cloth", section = 1, goals = { { t = "collect", item = 4306, itemName = "Silk Cloth", count = 204, gather = { min = 25, max = 45 } } } },
		{ title = "Auction House", section = 2, goals = {
			{ t = "auction", item = 4306, itemName = "Silk Cloth", count = 264, candidates = ah },
			{ t = "auction", item = 4338, itemName = "Mageweave Cloth", count = 900, candidates = ah } } },
		{ title = "Silk Cloth", section = 2, goals = { { t = "collect", item = 4306, itemName = "Silk Cloth", count = 264, gather = { min = 25, max = 45 } } } },
		{ title = "Mageweave Cloth", section = 2, goals = { { t = "collect", item = 4338, itemName = "Mageweave Cloth", count = 900, gather = { min = 35, max = 50 } } } },
		{ title = "Auction House", section = 3, goals = { { t = "auction", item = 8170, itemName = "Rugged Leather", count = 340, candidates = ah } } },
		{ title = "Rugged Leather", section = 3, goals = { { t = "collect", item = 8170, itemName = "Rugged Leather", count = 340, map = 1423, x = 50, y = 50,
			gather = { skill = "Skinning", skillLine = 393, rank = 200 } } } },
	},
})
local w = stub.world
w.learnSkill(197, "Tailoring", 112, 150)
w.learnSkill(182, "Herbalism", 70, 150)
w.addItem(2592, 140)
Polestar.Materials.NoteSearch(4306, { { price = 2000, quantity = 150 }, { price = 2500, quantity = 300 } })
Polestar.Engine.SetGuide("studio/tailoring")
stub.advance(3)`;

// The card, the guide opened afresh (never answered).
const CARD = `${SETUP}
Polestar.CharState().materials = nil
studio.clearHeadsUps()
Polestar.UI.Materials.Check("studio/tailoring")
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local m = Polestar.UI.ClassToast.current
return m and m.route`;

// The window, from the card's Mix (or the guide window's menu).
const WINDOW = `${SETUP}
if PolestarNavArrow then PolestarNavArrow:Hide() end
Polestar.UI.Materials.Show()
stub.advance(0.5)
return PolestarMaterials.Total:GetText()`;

// At the Auction House: the game's window (no art of its own here) with the list beside it.
const SHOP = `${SETUP}
if PolestarNavArrow then PolestarNavArrow:Hide() end
AuctionHouseFrame = AuctionHouseFrame or CreateFrame("Frame", "AuctionHouseFrame", UIParent)
AuctionHouseFrame:SetSize(800, 538)
AuctionHouseFrame:ClearAllPoints()
AuctionHouseFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 40, -120)
AuctionHouseFrame.SelectBrowseResult = AuctionHouseFrame.SelectBrowseResult or function() end
C_AuctionHouse = C_AuctionHouse or {}
C_AuctionHouse.MakeItemKey = C_AuctionHouse.MakeItemKey or function(id) return { itemID = id } end
AuctionHouseFrame:Show()
stub.fire("AUCTION_HOUSE_SHOW")
stub.advance(0.5)
return PolestarAuctionBuys and PolestarAuctionBuys:IsShown()`;

// A Briarthorn spot 40 yd off, Find Herbs on: the While you're here line with its chip.
const GATHER = `${SETUP}
C_Minimap = C_Minimap or {}
C_Minimap.GetNumTrackingTypes = function() return 1 end
C_Minimap.GetTrackingInfo = function() return { name = "Find Herbs", active = true, spellID = 2383 } end
local B = "0123456789ABCDEFGHIJKLMNOPQRSTUVWYabcdefghijklmnopqrstuvwy+/"
local function enc(v)
	local n = math.floor(v / 100 * 3599 + 0.5)
	local a, b = math.floor(n / 60), n % 60
	return B:sub(a + 1, a + 1) .. B:sub(b + 1, b + 1)
end
local map, x, y = Polestar.Compat.GetPlayerMapPosition()
Polestar.Gather.Register({ kinds = { { "Briarthorn", 182, 70, 1621 } }, maps = { [map] = "e;1:" .. enc(x + 1.2) .. enc(y) } })
stub.fire("SKILL_LINES_CHANGED")
-- While you're here reads the quest log once the client has filled it (QUEST_LOG_UPDATE after login).
stub.fire("QUEST_LOG_UPDATE")
Polestar.Set("behavior.whileHereGather", true)
stub.advance(1.5)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local v = Polestar.Engine.GetWhileHereList()[1]
return v and v.hereText or ("none: " .. tostring(Polestar.Engine.WhileHereState().why))`;

// The Guide page's Professions tab.
const OPTIONS = `Polestar.UI.ShowOptions("guide")
Polestar.UI.Options.Select("guide", "Professions")
stub.advance(0.5)
return true`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		const at = `${name} at UI scale ${scale}`;
		shots[`${name}-card-${scale}`] = { title: `${at}: the card`, capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${base}\n${SCALE(scale)}\n${CARD}` };
		shots[`${name}-window-${scale}`] = { title: `${at}: the Materials window`, capture: ['PolestarMaterials'], lua: `${base}\n${SCALE(scale)}\n${WINDOW}` };
		shots[`${name}-shop-${scale}`] = { title: `${at}: the shopping list at the Auction House`, capture: ['PolestarAuctionBuys'], lua: `${base}\n${SCALE(scale)}\n${SHOP}` };
		shots[`${name}-gather-${scale}`] = { title: `${at}: a gathering spot line`, capture: ['PolestarGuideFrame'], lua: `${base}\n${SCALE(scale)}\n${GATHER}` };
		shots[`${name}-options-${scale}`] = { title: `${at}: Guide > Professions`, capture: ['PolestarOptions'], lua: `${base}\n${SCALE(scale)}\n${OPTIONS}` };
	}
}

module.exports = {
	title: 'Gather, buy or mix and gathering spots: the card, the Materials window, the shopping list, a While you\'re here line and the Professions tab, in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 22, money: 315000 },
	place: { map: 1429, x: 42.2, y: 65.8, zone: 'Elwynn Forest', subzone: 'Goldshire' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	// The items the shots show (the client data the studio loads for them: a name, an icon).
	data: { items: [2592, 4306, 4338, 8170] },
	window: [1440, 690],
	// skins.js's: the client's map tree (a skin may read the continent) and Waymark's pictures.
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame', 'PolestarClassToast'],
	LOOKS,
	shots,
};
