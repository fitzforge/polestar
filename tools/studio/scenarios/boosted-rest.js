'use strict';
// Boosted Rest on the guide window's XP line and in the party panel
// (QoL/Rest.lua, UI/GuideFrame.lua, UI/PartyPanel.lua; #1624): a Tauren
// Hunter on the shipped Barrens guide sat by a campfire (Boosted Rest, 42
// minutes left) and carries the Cozy Sleeping Bag (12 minutes of its
// cooldown left, then ready); Ana in the party sends her own Boosted Rest
// ("2B|", 25 minutes) through the addon channel.

const REST = 1229451; // Boosted Rest
const BAG = 211527; // Cozy Sleeping Bag

const PARTY = `local P, p = Polestar.Party, stub.party
Polestar.version = "0.3.7"
p.join("Ana"); p.join("Dee")
p.set("Ana", { level = 17, class = "HUNTER", classID = 3, race = "Tauren", raceID = 6 })
p.set("Dee", { level = 18, class = "SHAMAN", classID = 7, race = "Troll", raceID = 8 })
stub.advance(1)
local function say(who, text) p.receive(who .. "-TestRealm", text) end
say("Ana", "1H|0.3.7"); say("Dee", "1H|0.3.7")
say("Ana", P.Encode({}, true)[1]); say("Dee", P.Encode({}, true)[1])
say("Ana", P.EncodeUnit({ level = 17, xp = 62, class = 3, race = 6, version = "0.3.7" }))
say("Dee", P.EncodeUnit({ level = 18, xp = 5, class = 7, race = 8, version = "0.3.7" }))
say("Ana", P.EncodeRest(25 * 60))
say("Dee", P.EncodeRest(nil))
stub.advance(2)`;

module.exports = {
	title: 'Boosted Rest status, the sleeping bag cooldown, the party\'s Boosted Rest (#1624)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 55, hours: 1.5 },
	stubs: ['stub_party.lua'],
	data: { spells: [REST], items: [BAG] },
	bags: [[BAG, 1]],
	settings: { 'behavior.offerClassQuests': false, 'party.panel': true },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarPartyPanel'],
	shots: {
		resting: {
			title: 'Boosted Rest (42m) and the sleeping bag (12m) on their own line under the XP line, a "Behind by" note on the line above',
			capture: ['PolestarGuideFrame'],
			lua: `studio.aura(${REST}, 42 * 60)
studio.cooldown(${BAG}, 12 * 60, 3600)`,
		},
		'resting-on-pace': {
			title: 'The same at level 20, on the guide\'s pace ("On pace for level 21.5")',
			capture: ['PolestarGuideFrame'],
			lua: `studio.ding(20)
studio.clearHeadsUps()
studio.aura(${REST}, 42 * 60)
studio.cooldown(${BAG}, 12 * 60, 3600)`,
		},
		'resting-wide': {
			title: 'The same on a window widened to 820',
			capture: ['PolestarGuideFrame'],
			lua: `studio.ding(20)
studio.clearHeadsUps()
Polestar.Set("ui.width", 820)
Polestar.Set("ui.pos", { 1060, 690 })
studio.aura(${REST}, 42 * 60)
studio.cooldown(${BAG}, 12 * 60, 3600)`,
		},
		'bag-ready': {
			title: 'At level 20, Boosted Rest over and the sleeping bag ready: "Boosted Rest: off · Sleeping bag ready"',
			capture: ['PolestarGuideFrame'],
			lua: `studio.ding(20)
studio.clearHeadsUps()
studio.aura(${REST}, nil)
stub.advance(1)`,
		},
		party: {
			title: 'The party panel: Ana\'s Boosted Rest ("Boosted Rest 25m"), Dee without',
			capture: ['PolestarPartyPanel'],
			lua: PARTY,
		},
	},
};
