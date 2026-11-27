-- env: world stub_party.lua stub_groupfinder.lua stub_gamepad.lua
-- The Group Finder page (Polestar_Options/Quests/GroupFinder.lua; Polestar/Quests/GroupFinder.lua and the folder
-- Polestar_GroupFinder, loaded with the settings) on the whole addon in Elwynn Forest, on Kobold Camp Cleanup
-- (0/10), as tests/group-finder.test.js plays it: players who run Polestar search on its hidden channel
-- (stub_groupfinder.lua), each check with a name of its own so no answer waits on an earlier one. Read: who the
-- finder lists, what it whispers and says (stub_party.lua's sent and chat), the panel and the message box.
local w, p, g, GF, ns
local n = 0
local ON = { ["groupFinder.enabled"] = true }
local function with(t)
	local out = { ["groupFinder.enabled"] = true }
	for k, v in pairs(t or {}) do out[k] = v end
	return out
end
-- A search from a new player on quest 7: listed? `flags` (faction, auto-group), `size` (their group), `lang`.
local function heard(flags, size, lang)
	n = n + 1
	local name = "Seeker" .. n .. "-TestRealm"
	g.search(name, string.format("S|%06x|1429|490|430|5|MAGE|%d|%s|%s|7:k@3/10", 0x100000 + n, size or 0, flags or "A", lang or "e"))
	stub.advance(3)
	return name
end
local function listed(name)
	for _, f in ipairs(GF.Found()) do if f == name then return true end end
	return false
end
-- The addon messages whispered to `name`, the last one's text.
local function whispered(name)
	local k, last = 0, false
	for _, m in ipairs(p.sent) do
		if m.prefix == "PSGF" and m.chatType == "WHISPER" and m.target == name then k, last = k + 1, m.text end
	end
	return k, last
end
local function lastChat(chatType)
	for i = #p.chat, 1, -1 do if p.chat[i].chatType == chatType then return p.chat[i].text end end
	return false
end
local function chats(chatType)
	local k = 0
	for _, c in ipairs(p.chat) do if c.chatType == chatType then k = k + 1 end end
	return k
end
-- A language's row: a player whose game is in it is listed.
local function language(letter)
	return function() return listed(heard("A", 0, letter)) end
end
-- The message box offered now: its mode, its main button, the line it would say.
local function box(kind)
	local B = ns.PartyBox
	B.ResetHello()
	if kind == "goodbye" then B.ShowGoodbye() else B.ShowHello() end
	local f = B.Frame()
	local out = { mode = B.Mode() or false }
	if f and f:IsShown() then
		out.main = f.main:GetText()
		out.said = f.preview:GetText()
		out.height = math.floor(f:GetHeight() + 0.5)
	end
	B.Other()
	return out
end
-- Invite (or Ask, for a player in a group) clicked on a new player's row: the whispers it says.
local function invite(size)
	local name = heard("A", size or 0)
	local before = chats("WHISPER")
	ns.Widgets.Invite(ns.Matcher.Get(name))
	return { said = chats("WHISPER") - before, text = chats("WHISPER") > before and lastChat("WHISPER") or false }
end
-- Announce clicked, past its minute: where it went and what it said.
local function announce()
	stub.advance(61)
	local before = #p.chat
	ns.Announce.Send()
	local c = #p.chat > before and p.chat[#p.chat]
	return c and { chatType = c.chatType, text = c.text } or false
end
local function bound(action)
	return { bind = "F9", probe = function() return Polestar.Gamepad.KeyText(action) or false end }
end
return {
	setup = function()
		w, p, g, GF = stub.world, stub.party, stub.groupfinder, Polestar.GroupFinder
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48.5, 42.5)
		w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
		assert(GF.Load())
		ns = GF.Private
		-- The guide's live step on quest 7, and the arrow 50 yd from it (Nearby.lua reads both).
		ns.PolestarStepQuests = function() return { 7 } end
		Polestar.Nav.GetDistance = function() return 50 end
		stub.advance(1)
	end,
	settle = 0.5,
	probes = {
		["groupFinder.enabled"] = function() return listed(heard()) end,
		["groupFinder.autoReply"] = { with = ON, probe = function() return (whispered(heard())) > 0 end },
		["groupFinder.autoGroup"] = { with = ON, probe = function() return (whispered(heard("gA"))) > 0 end },
		["groupFinder.shareCoords"] = { with = with({ ["groupFinder.autoReply"] = true }), probe = function()
			local _, text = whispered(heard())
			return text and text:match("^R|%x+|%d+|(%d*)|") ~= "" or false
		end },
		["groupFinder.openNear"] = { with = ON, probe = function()
			ns.UI.Hide()
			ns.Nearby.Reset()
			ns.Nearby.Check()
			local shown = ns.UI.IsShown()
			ns.UI.Hide()
			return shown
		end },
		["groupFinder.autoRetry"] = { with = ON, probe = function()
			stub.advance(11)
			local function searches()
				local k = 0
				for _, m in ipairs(p.sent) do if m.prefix == "PSGF" and m.chatType == "CHANNEL" and m.text:sub(1, 1) == "S" then k = k + 1 end end
				return k
			end
			local before = searches()
			GF.Search()
			stub.advance(21)
			local asked = searches() - before
			ns.Comm.StopSearch()
			return asked
		end },
		["groupFinder.acceptAll"] = { with = ON, probe = language("r") },
		["groupFinder.langs.e"] = { with = ON, probe = language("e") },
		["groupFinder.langs.f"] = { with = ON, probe = language("f") },
		["groupFinder.langs.d"] = { with = ON, probe = language("d") },
		["groupFinder.langs.s"] = { with = ON, probe = language("s") },
		["groupFinder.langs.i"] = { with = ON, probe = language("i") },
		["groupFinder.langs.p"] = { with = ON, probe = language("p") },
		["groupFinder.langs.r"] = { with = ON, probe = language("r") },
		["groupFinder.langs.k"] = { with = ON, probe = language("k") },
		["groupFinder.langs.c"] = { with = ON, probe = language("c") },
		["groupFinder.langs.t"] = { with = ON, probe = language("t") },
		["groupFinder.partyBox"] = { with = ON, probe = function() return box("hello").mode end },
		["groupFinder.partyBoxStyle"] = { with = ON, value = "compact", probe = function() return box("hello").height or false end },
		["groupFinder.helloOn"] = { with = ON, probe = function() return box("hello").mode end },
		["groupFinder.helloMsg"] = { with = ON, value = "Yo {quests}", probe = function() return box("hello").said or false end },
		["groupFinder.goodbyeOn"] = { with = ON, probe = function() return box("goodbye").main or false end },
		["groupFinder.leaveMsg"] = { with = ON, value = "Bye {quests}", probe = function() return box("goodbye").said or false end },
		["groupFinder.announceOn"] = { with = ON, probe = function()
			ns.UI.Show()
			ns.UI.Refresh()
			local shown = ns.UI.AnnounceButton():IsShown()
			ns.UI.Hide()
			return shown
		end },
		["groupFinder.announceMsg"] = { with = ON, value = "Need help on {quests}", probe = announce },
		["groupFinder.announceTo"] = { with = ON, value = "SAY", probe = announce },
		["groupFinder.inviteOn"] = { with = ON, probe = function() return invite().said end },
		["groupFinder.inviteMsg"] = { with = ON, value = "Hey, {quests}?", probe = function() return invite().text end },
		["groupFinder.askOn"] = { with = ON, probe = function() return invite(2).said end },
		["groupFinder.askMsg"] = { with = ON, value = "Room for me? {quests}", probe = function() return invite(2).text end },
		["action:POLESTAR_GF_SEARCH"] = bound("POLESTAR_GF_SEARCH"),
		["action:POLESTAR_GF_PANEL"] = bound("POLESTAR_GF_PANEL"),
		["action:POLESTAR_GF_HELLO"] = bound("POLESTAR_GF_HELLO"),
		["action:POLESTAR_GF_GOODBYE"] = bound("POLESTAR_GF_GOODBYE"),
		["action:POLESTAR_GF_ANNOUNCE"] = bound("POLESTAR_GF_ANNOUNCE"),
	},
}
