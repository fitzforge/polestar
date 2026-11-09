-- Reputation / achievement toolkit (spec 5.2): `rep <faction> <Standing>`
-- from a faction picker, `achieve <id> ["Name"] [criteria n]`, and
-- `explore x,y` where the author stands.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, tostring, tonumber = ipairs, tostring, tonumber

S.Tools.Register({
	key = "rep", label = "Reputation goal", icon = "icon-rep", kit = "reputation",
	tip = "Done when the faction reaches a standing.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which faction?"], hint = L["Type part of its name."], items = UI.Factions, onPick = function(f)
			local items = {}
			for n, st in ipairs(UI.STANDINGS) do items[n] = { text = L[st], value = n } end
			UI.Pick({ title = f.text, items = items, onPick = function(st)
				local n = st.value
				local src = { verb = "rep", args = { tostring(f.value), UI.STANDINGS[n] }, mods = {} }
				UI.Add(src, { t = "rep", faction = f.value, factionName = f.text, standing = n })
			end })
		end })
	end,
})

local function achievementName(id)
	if GetAchievementInfo then
		local ok, _, name = pcall(GetAchievementInfo, id)
		if ok and type(name) == "string" and name ~= "" then return name end
	end
	return nil
end

local function addAchievement(id, name, criteria)
	local src = { verb = "achieve", args = { tostring(id), UI.Token(name) }, mods = {} }
	local out = { t = "achieve", achievement = id, achievementName = name }
	if criteria then
		src.mods[1] = { "criteria", tostring(criteria) }
		out.criteria = criteria
	end
	UI.Add(src, out)
end

S.Tools.Register({
	key = "achieve", label = "Achievement goal", icon = "check", kit = "reputation",
	tip = "Done when the achievement (or one of its criteria) is earned: achieve <id> [criteria n].",
	run = function()
		if not UI.Ready() then return end
		UI.Prompt({ title = L["Achievement"], label = L["Its id, and a criteria number if only one is meant: 1234 or 1234 2."], onAccept = function(text)
			local id, crit = text:match("^%s*(%d+)%s*(%d*)%s*$")
			id, crit = tonumber(id), tonumber(crit)
			if not id then
				UI.Say(L["An achievement id is a number."], "warning")
				return
			end
			local name = achievementName(id)
			if name then
				addAchievement(id, name, crit)
			else
				UI.Prompt({ title = L["Achievement"], label = L["The game does not name it: type its name."], onAccept = function(n)
					n = S.OneLine(n)
					if n == "" then return end
					addAchievement(id, n, crit)
				end })
			end
		end })
	end,
})

S.Tools.Register({
	key = "explore", label = "Explore here", icon = "flag", kit = "reputation", belt = false,
	tip = "Done when the place where you stand is discovered.",
	run = function()
		if not UI.Ready() then return end
		local pos = UI.Here()
		if not pos then
			UI.Say(L["The game gives no position here (inside an instance?)."], "warning")
			return
		end
		local x, y = S.Round2(pos.x), S.Round2(pos.y)
		local src = { verb = "explore", args = { S.XY(x, y) }, mods = { { "map", tostring(pos.map) }, { "frame", "live" } } }
		UI.Add(src, { t = "explore", map = pos.map, x = x, y = y })
	end,
})
