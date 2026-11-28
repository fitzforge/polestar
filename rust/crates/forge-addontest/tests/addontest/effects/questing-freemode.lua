-- env: world
-- codex: free-mode.json
-- The Questing page's Free mode section (Polestar_Options/Quests/Options.lua; Polestar_FreeMode/Free.lua) on the
-- Free mode fixture (free-mode.rs): a level 20 human holding Gnoll Trouble (100 yd east, 1,200 XP), Boar Hunt (400 yd
-- west, 2,400 XP) and Gnoll Ears (6 Gnoll Ears at 8%). What each row changes is what Free mode's tab lists.
local w, E
local function free() return Polestar.Free end
-- Free mode's steps as its tab holds them: each step's title, and each collect's note.
local function steps()
	local out = {}
	for i = 1, E.GetStepCount() do
		local v = E.GetStepView(i)
		local notes = {}
		for _, g in ipairs(v.goals) do
			if g.note then notes[#notes + 1] = g.note end
			if g.rewards and g.rewards.xp then notes[#notes + 1] = g.rewards.xp .. " XP" end
		end
		out[#out + 1] = v.title .. (#notes > 0 and (" (" .. table.concat(notes, "; ") .. ")") or "")
	end
	return table.concat(out, " / ")
end
local function on()
	if not free().IsOn() then free().Start() end
	stub.advance(1)
end
return {
	setup = function()
		w = stub.world
		E = Polestar.Engine
		w.addMap(9001, { name = "Hale's Reach", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
		w.addMap(9002, { name = "Merrow Fields", c = 0, left = -1000, right = -3000, top = 1000, bottom = -1000 })
		w.setLevel(20)
		w.moveTo(9001, 50, 50)
		w.accept(7001, { { text = "Ridge Gnoll slain: 0/5", required = 5 } }, "Gnoll Trouble")
		w.accept(7002, { { text = "Boar Tusk: 0/4", required = 4, type = "item" } }, "Boar Hunt")
		w.accept(7005, { { text = "Gnoll Ear: 0/6", required = 6, type = "item" } }, "Gnoll Ears")
		stub.advance(1)
	end,
	probes = {
		-- The order: balanced (the gnolls, then the boars), nearest first (the gnolls, then their ears) or the most
		-- XP a minute first (the boars).
		["free.pick"] = { prepare = on, probe = steps },
		-- Far from every quest (Merrow Fields' far corner, over 2,800 yd off: more than 300 s), the zone hint comes first.
		["free.hints"] = { prepare = function()
			w.moveTo(9002, 98, 98)
			on()
			free().Plan(true)
			stub.advance(1)
		end, cleanup = function()
			-- Back at the camp; moving plans nothing by itself, so the next probe starts from a plan made here.
			w.moveTo(9001, 50, 50)
			free().Plan(true)
			stub.advance(1)
		end, probe = function()
			free().Plan(true)
			stub.advance(1)
			return steps()
		end },
		-- The hand-ins' XP and the Gnoll Ears' low drop rate.
		["free.details"] = { prepare = on, probe = steps },
		-- The section's Open button opens the main window on Free mode's Main page, where Free mode is turned on and
		-- off; opening it turns nothing on.
		["Questing:Free mode"] = { press = true, prepare = function()
			if free().IsOn() then free().Stop() end
			if PolestarPicker then PolestarPicker:Hide() end
			-- The pages load with the mode (Free.Load); start from another page than Main.
			assert(free().Load())
			free().Page.SetPage("about")
			stub.advance(0.5)
		end, probe = function()
			local win = PolestarPicker
			local section = win and win:IsShown() and Polestar.UI.Picker.Section() or "closed"
			if section ~= "closed" then
				assert(section == "FreeMode", "the window opens on " .. tostring(section) .. ", not Free mode")
				assert(free().Page.Current() == "main", "Free mode opens on its " .. tostring(free().Page.Current()) .. " page, not Main")
				assert(not free().IsOn(), "opening Free mode's page turned it on")
			end
			return section .. " / " .. tostring(free().Page.Current()) .. " / " .. (free().IsOn() and "on" or "off")
		end },
	},
}
