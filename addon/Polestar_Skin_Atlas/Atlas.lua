-- Atlas: the colours of Polestar's Atlas look, through the Skin API (docs/skins
-- in the Polestar repository). Tokens only: a warm gold accent and no section
-- lines in the guide window. The shape of the
-- look (the step on a rail, the cards above the window) is the Atlas layout
-- (addon/Polestar_Layout_Atlas), which any skin colours; this skin keeps the
-- look's own colours pickable, and wears any layout.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local CLEAR = "#00000000"

check("skin atlas", Theme.RegisterSkin("atlas", {
	api = 2,
	name = "Atlas",
	addon = ADDON,
	author = "TTik3r",
	desc = "One calm surface: a warm gold accent, no section lines.",
	base = "polestar",
	tokens = {
		accent = "#e6ba66",
		-- One surface from the title to the foot: no section lines.
		divider = CLEAR, separator = CLEAR, rowLine = CLEAR,
	},
}))
