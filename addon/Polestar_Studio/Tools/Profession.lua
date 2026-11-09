-- Profession toolkit (spec 5.2): train a profession and rank (or at the
-- trainer whose window is open), a skill target, learn and craft a recipe
-- (Codex spells), and `buy … nearest` for materials.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, pairs, tonumber, tostring = ipairs, pairs, tonumber, tostring

local RANKS = { "Apprentice", "Journeyman", "Expert", "Artisan" }

-- { { name, line } } sorted by name, from Polestar's skill lines.
local function professions()
	local P = S.P()
	local lines = P and P.Compat and P.Compat.SKILL_LINES or {}
	local out = {}
	for key, line in pairs(lines) do
		local name = key:gsub("(%a)(%a*)", function(a, b) return a:upper() .. b end)
		if P.Compat.GetSkillLineName then
			local ok, n = pcall(P.Compat.GetSkillLineName, line)
			if ok and type(n) == "string" and n ~= "" then name = n end
		end
		out[#out + 1] = { name = name, line = line }
	end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

local function pickProfession(title, onPick)
	local items = {}
	for _, p in ipairs(professions()) do items[#items + 1] = { text = p.name, value = p } end
	UI.Pick({ title = title, items = items, onPick = function(it) onPick(it.value) end })
end

-- Spells by name (Codex), for recipe pickers.
local function spellItems(q)
	local out = {}
	local X = S.Resolve.Codex()
	local id = tonumber(q)
	if id then
		local rec = X and X.Spell and X.Spell(id)
		if rec then out[1] = { text = rec.name or tostring(id), sub = tostring(id), value = rec } end
		return out
	end
	if not (X and X.Each) or #q < 2 then return out end
	X.Each("spell", function(sid, name)
		if name and name:lower():find(q, 1, true) then
			out[#out + 1] = { text = name, sub = tostring(sid), value = { id = sid, name = name } }
		end
		return #out < 60
	end)
	return out
end

local function pickSpell(title, onPick)
	UI.Pick({ title = title, hint = L["Type part of the recipe's name, or its spell id."], items = spellItems, onPick = function(it)
		local X = S.Resolve.Codex()
		local rec = X and X.Spell and X.Spell(it.value.id) or it.value
		onPick(rec)
	end })
end

-- A recipe goal (learn | craft) for spell rec, count for craft.
local function recipeGoal(verb, rec, count)
	local args = { tostring(rec.id) }
	local out = { t = verb, spell = rec.id, spellName = rec.name }
	if not out.spellName then return nil, L["Polestar does not know that spell's name."] end
	local mods = {}
	if verb == "craft" then
		if type(rec.item) == "number" then out.item = rec.item end
		if count and count > 0 then
			out.count = count
			mods[1] = { "count", "x" .. count }
		end
	end
	return { verb = verb, args = args, mods = mods }, out
end

S.Tools.Register({
	key = "train", label = "Train a profession", icon = "icon-skill", kit = "profession",
	tip = "At the trainer whose window is open, or a profession and rank (the nearest trainer).",
	run = function()
		if not UI.Ready() then return end
		local it = S.Resolve.Interaction()
		if it and it.kind == "npc" and TrainerFrame and TrainerFrame:IsShown() then
			UI.Resolve("Train")
			return
		end
		pickProfession(L["Which profession?"], function(p)
			local items = {}
			for r, n in ipairs(RANKS) do items[r] = { text = L[n], value = n } end
			UI.Pick({ title = p.name, items = items, onPick = function(rk)
				UI.Resolve("Train", p.name .. " " .. rk.value)
			end })
		end)
	end,
})

S.Tools.Register({
	key = "trainclass", label = "Train class skills", icon = "icon-skill", kit = "profession", belt = false,
	tip = "The nearest trainer of the guide's class (or yours).",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Train", "class")
	end,
})

S.Tools.Register({
	key = "skill", label = "Skill target", icon = "hourglass", kit = "profession",
	tip = "Done when the profession reaches a rank: skill <Profession> <N>.",
	run = function()
		if not UI.Ready() then return end
		pickProfession(L["Which profession?"], function(p)
			UI.Prompt({ title = p.name, label = L["Skill to reach (1-300)."], onAccept = function(text)
				local n = tonumber(text)
				if not n or n < 1 then
					UI.Say(L["A skill rank is a number."], "warning")
					return
				end
				n = math.floor(n)
				local src = { verb = "skill", args = { UI.Token(p.name), tostring(n) }, mods = {} }
				UI.Add(src, { t = "skill", skill = p.name, skillLine = p.line, level = n })
			end })
		end)
	end,
})

S.Tools.Register({
	key = "learn", label = "Learn a recipe", icon = "plus", kit = "profession",
	tip = "Done when the recipe is known.",
	run = function()
		if not UI.Ready() then return end
		pickSpell(L["Which recipe?"], function(rec)
			UI.Add(recipeGoal("learn", rec))
		end)
	end,
})

S.Tools.Register({
	key = "craft", label = "Craft", icon = "check", kit = "profession",
	tip = "Craft a recipe a number of times.",
	run = function()
		if not UI.Ready() then return end
		pickSpell(L["Which recipe?"], function(rec)
			UI.Prompt({ title = rec.name or "", label = L["How many?"], default = "1", onAccept = function(text)
				UI.Add(recipeGoal("craft", rec, math.floor(tonumber(text) or 1)))
			end })
		end)
	end,
})

S.Tools.Register({
	key = "buynearest", label = "Buy at the nearest vendor", icon = "icon-vendor", kit = "profession",
	tip = "buy <item> xN nearest: Polestar picks the closest vendor selling it.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which item?"], hint = L["Type part of its name."], items = function(q)
			local out = {}
			for _, r in ipairs(UI.SearchCodex("item", q, 60)) do out[#out + 1] = { text = r.name, sub = tostring(r.id), value = r.id } end
			return out
		end, onPick = function(it)
			UI.Prompt({ title = it.text, label = L["How many?"], default = "1", onAccept = function(text)
				UI.Resolve("Buy", it.value, tonumber(text) or 1, true)
			end })
		end })
	end,
})
