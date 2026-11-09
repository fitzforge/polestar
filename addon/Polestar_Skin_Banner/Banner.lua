-- Banner: your faction's colours, through Polestar's Skin API
-- (docs/SKINS-API.md in the Polestar repository). For the Horde, rust red
-- on blackened iron; for the Alliance, burnished gold on royal blue. The
-- header band is woven cloth in the faction's dye (Media/weave.tga, the
-- shape of Polestar's own band with a twill for its colour), with no
-- emblem on it: the colours are the banner. One skin, "Banner", wears the
-- player's own side; both colour schemes are registered, so either side's
-- grounds can be worn with Polestar's skin.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a skin that chooses its scheme by the character (UnitFactionGroup),
--     and registers LATE when the game cannot say yet: a saved choice of
--     "banner" waits as Polestar and is applied the moment it registers;
--   * `media.band`: the band's own texture, tinted with the scheme's `sky`
--     like Polestar's, so the player's ground colour and brightness still
--     reach it; the stars turned off through the `star` token.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local SIDES = {
	Horde = {
		scheme = "banner-horde", name = "Banner: Horde", desc = "Rust red on blackened iron.",
		accent = "#e8603a",
		tokens = {
			bg = "#16100ef7", panel = "#1c1512fa", panelAlt = "#28201c", sidebar = "#0e0a09", footer = "#110c0a", sky = "#4a1f14",
			text = "#f6efe8", textDim = "#cbbfb5", textMuted = "#a0938a",
			ink = "#f0e0d0", star = "#ffffff00", shade = "#050302", scrim = "#0a0605", onAccent = "#16100e", shadow = "#050302b3",
		},
	},
	Alliance = {
		scheme = "banner-alliance", name = "Banner: Alliance", desc = "Burnished gold on royal blue.",
		accent = "#d9b45a",
		tokens = {
			bg = "#0c1326f7", panel = "#101a33fa", panelAlt = "#182446", sidebar = "#070c19", footer = "#090f1f", sky = "#182e66",
			text = "#f3f5fc", textDim = "#c0c9e4", textMuted = "#96a2c6",
			ink = "#e8ecff", star = "#ffffff00", shade = "#02040c", scrim = "#050913", onAccent = "#0c1326", shadow = "#02040cb3",
		},
	},
}

for _, side in pairs(SIDES) do
	check("scheme " .. side.scheme, Theme.RegisterScheme(side.scheme, {
		api = 1, name = side.name, addon = ADDON, author = "Polestar", version = "1.0", desc = side.desc,
		tokens = side.tokens, accent = side.accent,
		washes = { border = 0.12, divider = 0.1, selected = 0.12, hover = 0.07 },
	}))
end

local PRESET = {
	["ui.band"] = true, ["ui.haze"] = false, ["ui.shadow"] = true, ["ui.rim"] = true,
	["nav.lineStyle"] = "line", ["nav.routeChevrons"] = true,
}

local function registerSkin(faction)
	local side = SIDES[faction]
	local spec = {
		api = 1,
		name = "Banner",
		addon = ADDON,
		author = "Polestar",
		version = "1.0",
		desc = ("Your faction's colours: %s A woven band in the faction's dye."):format(side.desc),
		base = "polestar",
		scheme = side.scheme,
		tokens = { accent = side.accent },
		media = { band = MEDIA .. "weave" },
		arrow = "3d",
		mapIcons = "polestar",
	}
	if Theme.HasCapability("preset") then spec.preset = PRESET end
	check("skin banner", Theme.RegisterSkin("banner", spec))
end

-- The character's side is known at load in the game; where it is not (an
-- unusual load order, a test client), register once the player is in.
local faction = UnitFactionGroup and UnitFactionGroup("player")
if SIDES[faction] then
	registerSkin(faction)
else
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_LOGIN")
	f:SetScript("OnEvent", function(self)
		self:UnregisterAllEvents()
		local side = UnitFactionGroup and UnitFactionGroup("player")
		registerSkin(SIDES[side] and side or "Alliance")
	end)
end
