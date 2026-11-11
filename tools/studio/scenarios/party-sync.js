'use strict';
// Party sync's lines (Quests/Party.lua, UI/PartyPanel.lua; #1617): a Tauren
// Hunter on the shipped Barrens guide in a party of three Polestar users,
// their messages sent through the addon channel (tests/lua/stub_party.lua)
// as the real encoders write them. Ana (Tauren Hunter 17, on Polestar 0.3.6)
// is on the step's quest with her own counts; Ben (Orc Warrior 8) lacks it
// (with a current Polestar_QuestDB loaded the line adds that he is below its
// level); Dee (Troll Shaman 18) handed it in already ("2D|"). The chat
// stand-in shows the once-a-session version note.

const MEMBERS = `local P, p = Polestar.Party, stub.party
Polestar.version = "0.3.7"
-- The first step from the one the play reached with an objective goal, and its quest: a fixed
-- step would break whenever the guide gains or loses a step before it.
local E = Polestar.Engine
local G = E.GetGuide()
local i, last = E.GetStepIndex(), G and #G.steps or 0
local q, oi
while i and i <= last and not q do
	local view = E.GetStepView(i)
	for _, g in ipairs(view and view.goals or {}) do
		if g.quest and g.oi then q, oi = g.quest, g.oi; break end
	end
	if not q then i = i + 1 end
end
assert(q, "no step from the one reached on has an objective goal")
if i ~= E.GetStepIndex() then E.Goto(i); stub.advance(1) end
p.join("Ana"); p.join("Ben"); p.join("Dee")
p.set("Ana", { level = 17, class = "HUNTER", classID = 3, race = "Tauren", raceID = 6 })
p.set("Ben", { level = 8, class = "WARRIOR", classID = 1, race = "Orc", raceID = 2 })
p.set("Dee", { level = 18, class = "SHAMAN", classID = 7, race = "Troll", raceID = 8 })
stub.advance(1)
local function say(who, text) p.receive(who .. "-TestRealm", text) end
say("Ana", "1H|0.3.6")
say("Ben", "1H|0.3.7")
say("Dee", "1H|0.3.7")
say("Ana", P.Encode({ { q = q, counts = { { 3, 8 }, { 1, 4 } } } }, true)[1])
say("Ana", P.EncodeUnit({ level = 17, xp = 62, class = 3, race = 6, version = "0.3.6" }))
say("Ben", P.Encode({ { q = 9999, counts = { { 0, 1 } } } }, true)[1])
say("Ben", P.EncodeUnit({ level = 8, xp = 15, class = 1, race = 2, version = "0.3.7" }))
say("Dee", P.Encode({ { q = 9998, counts = { { 2, 5 } } } }, true)[1])
say("Dee", P.EncodeUnit({ level = 18, xp = 5, class = 7, race = 8, version = "0.3.7" }))
say("Dee", P.EncodeDone({ q }))
stub.advance(3)
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
-- The panel beside the guide window, where a player would drag it.
PolestarPartyPanel:ClearAllPoints()
PolestarPartyPanel:SetPoint("TOPRIGHT", PolestarGuideFrame, "TOPLEFT", -12, 0)`;

module.exports = {
	title: 'Party sync: version note, "already done", class/race-locked members left out (#1617)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 38, hours: 1 },
	stubs: ['stub_party.lua'],
	settings: { 'behavior.offerClassQuests': false, 'party.panel': true },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarPartyPanel'],
	shots: {
		lines: {
			title: 'Under the quest goal: Ana\'s counts, "Not on this quest: Ben, Dee (already done)"; the party panel beside the window',
			lua: `${MEMBERS}\nstudio.chat(6)`,
		},
		chat: {
			title: 'The chat: "Ana is on Polestar 0.3.6: your guides can differ." and the party sync notice',
			capture: ['StudioChat'],
			lua: `${MEMBERS}\nstudio.chat(6)`,
		},
	},
};
