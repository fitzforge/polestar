-- Next (spec 5.1): `next <guide>`, the guide that follows, picked from the
-- installed guides. Picking several makes a route choice (first = default).

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local ipairs, tostring = ipairs, tostring

S.Tools.Register({
	key = "next", label = "Next guide", icon = "guides", kit = "core", belt = false,
	tip = "The guide that follows this one (pick again to add a route choice).",
	run = function()
		local d = S.Model.Current()
		if not d then return UI.Say(L["Start or open a guide first."], "warning") end
		local G = P.Guides
		local items = {}
		local ok, list = pcall(G and G.List or function() return {} end)
		for _, g in ipairs(ok and list or {}) do
			if g.id and g.id ~= d.header.id then
				items[#items + 1] = { text = g.title or g.id, sub = g.id, value = g.id, icon = UI.Theme.Media("guides") }
			end
		end
		items[#items + 1] = { text = L["No next guide"], value = false }
		UI.Pick({ title = L["Next guide"], items = items, onPick = function(it)
			if not it.value then
				S.Model.SetHeader("next", nil)
				return UI.Say(L["No next guide."], "success")
			end
			local nexts = UI.Copy(d.header.next) or {}
			for _, id in ipairs(nexts) do if id == it.value then return end end
			nexts[#nexts + 1] = it.value
			S.Model.SetHeader("next", nexts)
			UI.Say(L["Next: "] .. table.concat(nexts, ", "), "success")
		end })
	end,
})
