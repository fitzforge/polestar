'use strict';
// Gear advice saying what it scored with (#2035), in every look at the game's
// UI scales 0.64, 1.0 and 1.5. A Troll Warrior at 22, 13 points in Arms, hands
// in Free From the Hold (898) in Ratchet; its reward choices are leather boots,
// mail gauntlets and a third piece, and nothing is worn in those slots:
//   <look>-<scale>        the guide window's reward pick under the turn-in,
//                         hovered: the item's tooltip with Gear's lines (the
//                         upgrade line, the best pick, "Scored for Arms, from
//                         your talents") and what a click does
//   <look>-panel-<scale>  the game's reward panel with the upgrade arrows and
//                         the line beside its Rewards heading, hovered
// The looks are the built-in six, Halo and the skin addons in the download
// (skins.js's list, without its variants), each put on as skins.js does.
//
// Stand-ins, said on the render: the talent tree (13 points in Arms on the
// active spec group's config, as Forever's talent frame shows it), the item
// tooltip's post-call (the client runs Gear's lines after SetHyperlink; the
// studio's tooltip runs them here), and the reward panel (QuestInfoRewardsFrame
// as Mainline QuestInfo.xml lays it out: 285 wide, the Rewards heading, the
// choose line, LargeItemButton choices, on a parchment ground in its dark text).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];
const QUEST = 898;
const CHOICES = [5311, 5312, 270011];

// The talent tree, the turn-in step and the tooltip's post-call.
const SETUP = `C_SpecializationInfo = C_SpecializationInfo or {}
C_SpecializationInfo.IsInitialized = function() return true end
C_SpecializationInfo.GetActiveSpecGroup = function() return 1 end
C_SpecializationInfo.GetCombatConfigIDForSpecGroup = function(g) return g == 1 and 7 or nil end
C_Traits = C_Traits or {}
C_Traits.GetConfigInfo = function(c) if c == 7 then return { ID = 7, treeIDs = { 1117 } } end end
C_Traits.GetTreeNodes = function(t) return t == 1117 and { 1, 2, 3 } or {} end
C_Traits.GetNodeInfo = function(_, id) return { ID = id, posX = id * 4000, ranksPurchased = id == 1 and 13 or 0, groupIDs = { 500 + id } } end
C_Traits.GetGroupDisplayInfoByTreeID = function(t)
	if t ~= 1117 then return {} end
	return { { groupID = 501, orderIndex = 0, displayName = "Arms" }, { groupID = 502, orderIndex = 1, displayName = "Fury" },
		{ groupID = 503, orderIndex = 2, displayName = "Protection" } }
end
Polestar.Gear.Invalidate("spec")
local set = GameTooltip.SetHyperlink
GameTooltip.SetHyperlink = function(self, l)
	local r = set(self, l)
	for _, line in ipairs(Polestar.Gear.TooltipLines(l)) do Polestar.Hooks.AddLine(self, unpack(line, 1, 8)) end
	return r
end
Polestar.RegisterPack({ addon = "Polestar_Studio", id = "studio", format = 1, title = "Studio", author = "Studio", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "studio/gear", pack = "studio", title = "The Barrens", minLevel = 20, maxLevel = 24, steps = {
	{ title = "Ratchet", goals = { { t = "turnin", quest = ${QUEST}, title = "Free From the Hold", npc = 3339,
		npcName = "Captain Thalo'thas Brightsun", map = 1413, x = 62.29, y = 39.03 } } },
} })
stub.world.onQuest(${QUEST}, { { required = 1, fulfilled = 1 } }, "Free From the Hold")
Polestar.Engine.SetGuide("studio/gear")
stub.advance(1)`;

const luaScale = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The reward pick under the turn-in, hovered.
const PICK = `Polestar.Fire("STEP_UPDATED")
stub.advance(0.5)
local pick
for _, r in ipairs(Polestar.UI.GuideFrame.rows) do
	if r:IsShown() and r.psGearPick and r.psGearPick:IsShown() then pick = r.psGearPick end
end
assert(pick, "no reward pick under the turn-in")
studio.hover(pick)
studio.label("Stand-ins: the talent tree (13 Arms), the tooltip's post-call", 24, 24)
return GameTooltip.lines`;

// The reward panel: Mainline QuestInfoRewardsFrame's layout over a parchment
// ground, the quest's choices on LargeItemButtons, then QoL's marks.
const PANEL = `if PolestarGuideFrame then PolestarGuideFrame:Hide() end
if PolestarNavArrow then PolestarNavArrow:Hide() end
local CHOICES = { ${CHOICES.join(', ')} }
local panel = CreateFrame("Frame", "StudioRewards", UIParent)
panel:SetSize(318, 210)
panel:SetPoint("CENTER", UIParent, "CENTER", -160, 40)
local ground = panel:CreateTexture(nil, "BACKGROUND")
ground:SetAllPoints()
ground:SetColorTexture(0.86, 0.79, 0.64, 1)
local f = CreateFrame("Frame", "QuestInfoRewardsFrame", panel)
f:SetSize(285, 10)
f:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -14)
f.Header = f:CreateFontString(nil, "ARTWORK")
f.Header:SetFont(STANDARD_TEXT_FONT, 18, "")
f.Header:SetTextColor(0.18, 0.1, 0.03)
f.Header:SetText(QUEST_REWARDS or "Rewards")
f.Header:SetJustifyH("LEFT")
f.Header:SetSize(285, 22)
f.Header:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
f.ItemChooseText = f:CreateFontString(nil, "ARTWORK")
f.ItemChooseText:SetFont(STANDARD_TEXT_FONT, 13, "")
f.ItemChooseText:SetTextColor(0.18, 0.1, 0.03)
f.ItemChooseText:SetText(REWARD_CHOICES or "You will be able to choose one of these rewards:")
f.ItemChooseText:SetJustifyH("LEFT")
f.ItemChooseText:SetSize(285, 30)
f.ItemChooseText:SetPoint("TOPLEFT", f.Header, "BOTTOMLEFT", 0, -10)
f.RewardButtons = {}
for i, id in ipairs(CHOICES) do
	local b = CreateFrame("Button", nil, f)
	b:SetSize(147, 41)
	b:SetPoint("TOPLEFT", f.ItemChooseText, "BOTTOMLEFT", ((i - 1) % 2) * 148, -6 - math.floor((i - 1) / 2) * 44)
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetSize(39, 39)
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Icon:SetTexture(C_Item.GetItemIconByID(id) or 134400)
	b.Name = b:CreateFontString(nil, "ARTWORK")
	b.Name:SetFont(STANDARD_TEXT_FONT, 12, "")
	b.Name:SetTextColor(0.18, 0.1, 0.03)
	b.Name:SetPoint("LEFT", b.Icon, "RIGHT", 6, 0)
	b.Name:SetWidth(98)
	b.Name:SetText(C_Item.GetItemNameByID(id) or ("Item " .. id))
	b.type, b.objectType = "choice", "item"
	b:SetID(i)
	f.RewardButtons[i] = b
end
QuestInfoFrame = QuestInfoFrame or CreateFrame("Frame", "QuestInfoFrame", UIParent)
QuestInfoFrame.rewardsFrame, QuestInfoFrame.questLog = f, nil
function GetNumQuestChoices() return #CHOICES end
function GetQuestItemInfo(kind, i)
	local id = kind == "choice" and CHOICES[i]
	if id then return C_Item.GetItemNameByID(id), C_Item.GetItemIconByID(id), 1, 2, true, id end
end
function GetQuestItemLink(kind, i)
	local id = kind == "choice" and CHOICES[i]
	return id and select(2, C_Item.GetItemInfo(id)) or nil
end
Polestar.QoL.Rewards.Mark()
stub.advance(0.3)
local line = Polestar.QoL.Rewards.ScoredLine()
assert(line and line:IsShown(), "no line beside the Rewards heading")
studio.hover(line)
studio.label("Stand-ins: the reward panel, the talent tree (13 Arms)", 24, 24)
return { line = line.Text:GetText(), tip = GameTooltip.lines }`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}`] = {
			title: `${name} at UI scale ${scale}: the turn-in's reward pick hovered, with what Gear scored it for`,
			capture: ['PolestarGuideFrame', 'GameTooltip'],
			lua: `${base}\n${luaScale(scale)}\n${PICK}`,
		};
		shots[`${name}-panel-${scale}`] = {
			title: `${name} at UI scale ${scale}: the reward panel's line beside its Rewards heading, hovered`,
			capture: ['StudioRewards', 'GameTooltip'],
			lua: `${base}\n${luaScale(scale)}\n${PANEL}`,
		};
	}
}

module.exports = {
	title: 'Gear advice says what it scored with (#2035): the reward pick and the reward panel in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Troll', cls: 'WARRIOR', faction: 'Horde', level: 22, money: 4200 },
	place: { map: 1413, x: 62.29, y: 39.03, zone: 'The Barrens', subzone: 'Ratchet' },
	settings: {},
	data: { items: CHOICES },
	stubs: skins.stubs,
	art: skins.art,
	setup: SETUP,
	capture: ['PolestarGuideFrame', 'GameTooltip'],
	pad: 32,
	LOOKS,
	shots,
};
