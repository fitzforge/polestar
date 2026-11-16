-- env: ui
-- The Alerts & toasts page's Class quest card tab (Polestar_Options/UI/Looks/Toasts.lua; UI/ClassCard.lua) on the
-- live guide window, as class-quests.rs has it: a level 20 Night Elf Druid on Darkshore's step with the Cat Form
-- chain's accept (The Great Cat Spirit), whose card shows over the step's goals; the first time a chain's card shows
-- (its record cleared, the step drawn again), its shine and its chime. The client's gradient on a texture, which the
-- stub lacks, is kept to be read.
local CC
local function F() return CC.frame end
local function size(fs) return (select(2, fs:GetFont())) end
local function G(t, f) f.t = t; return f end
local DRUID = { classes = { "DRUID" } }
-- The card shown for the first time on this character (its record cleared, the step drawn again): the shine crossing
-- it, the sounds it played.
local function firstTime()
	Polestar.CharState().classCardSeen = nil
	local sounds = #stub.sounds
	uistub.setStep(1)
	local out = { shine = F().Shine:IsShown(), sounds = #stub.sounds - sounds }
	stub.advance(1)
	return out
end
return {
	setup = function()
		CC = Polestar.UI.ClassCard
		local M = stub.Methods
		if not rawget(M, "SetGradient") then
			M.SetGradient = function(self, orient, a, b) self.gradient = { orient, { a:GetRGBA() }, { b:GetRGBA() } } end
		end
		uistub.guides["test/darkshore"] = { id = "test/darkshore", pack = "guides", title = "Darkshore", faction = "Alliance", minLevel = 16, maxLevel = 21,
			category = "Leveling", zone = 1439, zoneName = "Darkshore", author = "Polestar", version = 1, steps = {
			{ title = "Mathrengyl Bearwalker", only = DRUID, goals = {
				G("accept", { verb = "Accept", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98393, npc = 4217, npcName = "Mathrengyl Bearwalker", minLevel = 20, map = 1457, x = 35.4, y = 8.4, status = "active" }),
			} },
			{ title = "Dendrite Starblaze", only = DRUID, goals = {
				G("turnin", { verb = "Turn in", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98393, npc = 11802, npcName = "Dendrite Starblaze", map = 1450, x = 56.2, y = 30.6, status = "pending" }),
				G("accept", { verb = "Accept", subject = "The Great Cat Spirit", subjectKind = "quest", quest = 98394, npc = 11802, npcName = "Dendrite Starblaze", minLevel = 20, map = 1450, x = 56.2, y = 30.6, status = "pending" }),
			} },
		} }
		uistub.player.class, uistub.player.race, uistub.player.level = "DRUID", "NightElf", 20
		uistub.setGuide("test/darkshore", 1)
		stub.advance(1)
	end,
	settle = 0.2,
	probes = {
		["toasts.classcard.glow"] = function() return F().Glow.gradient or false end,
		["toasts.classcard.stripe"] = function() local s = F().Stripe; return { s:IsShown(), s:GetWidth() } end,
		["toasts.classcard.titleSize"] = function() return size(F().Title) end,
		["toasts.classcard.bodySize"] = function() return size(F().Head) end,
		["toasts.classcard.note"] = function() return F().Only:IsShown() end,
		["toasts.classcard.shine"] = function() return firstTime().shine end,
		["ui.classCardSound"] = function() return firstTime().sounds end,
	},
}
