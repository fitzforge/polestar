-- Polestar_Looks (load on demand): what the game's looks bring besides their
-- painters (GameSkins.lua), loaded with them before Theme.SkinKey names one
-- of them: their sizes and type ladder (Theme.Metric, Theme.FontSpec), and
-- their own waypoint arrow and map pins in the client's own art. The arrow
-- and the pins read them as they read a registered skin's (Skin API 2's
-- arrow and pin parts, the skin's media: Theme.SkinMedia): one lookup of the
-- skin in use's parts, nothing keyed by look in their code.

local ns = Polestar
local Theme = ns and ns.Theme
local I = ns and ns.ThemeInternal
if not (Theme and I and Theme.METRICS) then return end

-- The client's sizes (the Settings panel's rows and controls, the 14-high
-- status bar); WoW Forever's guide window keeps its rows and the lit goal
-- clear of its bronze border (#306), its tab strip is 30 high so the
-- Settings tab outlines stand clear of the window's edge (#312, GameSkins'
-- tabClear), and a tab's close button and text stay inside its outline, 5
-- in from the tab's sides (guideTabInset: GameSkins' tabGap). A tab's title
-- ends 6 clear of its close (guideTabClosePad: the room kept right of the
-- text for the close, 3 in from the tab's side, and the gap): the red
-- button's 14 in WoW Forever and Classic, Blizzard's 9-unit glyph. Classic's
-- red button rests at full strength (guideTabCloseRest), as the game draws
-- it; faded it went to mud.
local GAME_ROLES = { hero = { "semibold", 24 } }
local GAME_METRICS = {
	row = 28, menuRow = 22, menuPad = 6, menuWidth = 260, servicesWidth = 290,
	buttonH = 22, buttonPad = 14, dropdownW = 170, dropdownH = 24, chevron = 10, chevronInset = 6,
	sliderW = 120, valueW = 56, checkbox = 18,
	shellW = 930, shellH = 690, shellSidebar = 200, shellTabs = 32, shellPad = 28, shellFooter = 56,
	pickerW = 1100, pickerH = 640, pickerDetail = 380, pickerSidebar = 230,
	guidePad = 12, guideIconGap = 9, guideTabs = 28, guideNav = 32, guideNavBtn = 20, guideNavIcon = 12,
	guideIconBtnW = 20, guideIconBtnH = 20, guideIcon = 11, guideRow = 22, guideCheck = 15,
	guideProgress = 14, guideGrip = 8, guideFoot = 28, guideUpRow = 20, guideUpToggle = 26, guideNavGap = 4,
	guideTabClosePad = 24,
}
local METRICS = Theme.METRICS
for _, k in ipairs({ "forever", "blizzard", "classic" }) do
	METRICS[k] = GAME_METRICS
	I.SKIN_ROLES[k] = GAME_ROLES
end
METRICS.forever = setmetatable({ guidePad = 18, guideLitInset = 10, guideRowPad = 4, guideCheckIn = 10, guideCheckMiddle = true, guideTabs = 30,
	guideTabInset = 5 }, { __index = GAME_METRICS })
METRICS.blizzard = setmetatable({ guideTabClosePad = 22 }, { __index = GAME_METRICS })
METRICS.classic = setmetatable({ guideTabCloseRest = 1 }, { __index = GAME_METRICS })

-- Each game look's waypoint arrow and map pins: its dart and the medallion
-- under the map pins' glyphs (while the map icons follow the skin), mostly
-- the client's own art ("atlas:<name>": an atlas as the client draws it,
-- Theme.SetArt). A dart of the client's (dartArt) shows in the art's own
-- colours while far, tinted up close and when the player picks an arrow
-- colour, with no Polestar edge round it. WoW Forever: its quest arrow and
-- the campaign quest's shield. Classic: the world map's arrow (the vanilla
-- silver arrow, at 64 px the client's sharpest) and the minimap's dark
-- disc. Blizzard: Polestar's own dart in the accent, the damage meter's
-- light grey (the client has no crisp neutral arrow; its navigation arrow
-- is 22 by 18), edged in the meter's black (dartEdgeTint) in place of
-- Hearth's brown, and the quest marker. Every dart is square art
-- pointing straight up, as Polestar's: it turns about its centre by
-- the heading alone. The client's art sits in a margin of its own (its
-- outline and shadow, which read as ground), so a part is drawn dartScale
-- or medallionScale times its square: what shows of it is then Polestar's
-- size (a dart's picture is 0.82 of its square tall, a medallion the whole
-- of it).
local PARTS = {
	forever = { dart = "atlas:Minimap-QuestArrow", dartArt = true, dartScale = 1.3,
		medallion = "atlas:UI-QuestPoiCampaign-QuestNumber", medallionScale = 1.35 },
	blizzard = { dart = Theme.Media("dart"), dartEdgeTint = { 0.08, 0.08, 0.08 }, medallion = "atlas:UI-QuestPoi-QuestNumber", medallionScale = 1.55 },
	classic = { dart = "atlas:UI-WorldMapArrow", dartArt = true, dartScale = 1.1, medallion = "Interface\\Minimap\\UI-Minimap-Background" },
}
for id, media in pairs(PARTS) do
	local s = I.SKINS[id]
	if s then s.media = media end
end
