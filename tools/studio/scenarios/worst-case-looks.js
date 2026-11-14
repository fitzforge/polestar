'use strict';
// The worst cases in every look at UI scales 0.64, 1.0 and 1.5, on a
// 1920x1080 screen: Make room in your quest log with the 25-quest log of a
// character who installed Polestar at 34, its first row pointed at (its name
// is cut: the tooltip has it whole); Characters with the account's worst
// snapshots; Options > Profiles, its In use chip on the profile's picture
// (worst-case.js's pieces). The looks are skins.js's, each put on as
// skins.js puts it. Shots: <look>-room-<scale>, <look>-alts-<scale>,
// <look>-profiles-<scale> (studio worst-case-looks/hearth-room-1.0 ...).

const skins = require('./skins');
const { screen, fill, log34, ALTS } = require('./worst-case').lua;

const SCALES = ['0.64', '1.0', '1.5'];

const ROOM = `${fill(log34)}
Polestar.UI.ShowQuestRoom()
stub.advance(0.5)
local F = PolestarQuestRoom
stub.RunScript(F.rows[1], "OnEnter")
return { height = F:GetHeight(), top = F:GetTop(), bottom = F:GetBottom(), screen = UIParent:GetHeight() }`;

const PROFILES = `Polestar.UI.ShowOptions("profiles")
stub.advance(0.5)
return { shown = PolestarOptions:IsShown(), height = PolestarOptions:GetHeight(), screen = UIParent:GetHeight() }`;

const SURFACES = {
	room: { what: 'Make room with 25 quests', lua: ROOM, capture: ['PolestarQuestRoom', 'GameTooltip'] },
	alts: { what: 'Characters, the worst of each field', lua: ALTS, capture: ['PolestarPicker'] },
	profiles: { what: 'Options > Profiles', lua: PROFILES, capture: ['PolestarOptions'] },
};

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(skins.SKINS)) {
	for (const [key, s] of Object.entries(SURFACES)) {
		for (const scale of SCALES) {
			shots[`${name}-${key}-${scale}`] = {
				title: `${name}: ${s.what} at UI scale ${scale}`,
				capture: s.capture,
				lua: `${skins.pick(id, folder, variant)}\n${screen(1920, 1080, Number(scale))}\n${s.lua}`,
			};
		}
	}
}

module.exports = {
	title: "The worst cases' Quest room, Characters and Profiles in every look at UI scales 0.64, 1.0 and 1.5",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 34, money: 412345 },
	place: { map: 1443, x: 66.2, y: 6.6, zone: 'Desolace', subzone: "Nijel's Point" },
	guide: { id: 'forever/alliance/30-40/02-desolace' },
	settings: { 'behavior.offerClassQuests': false },
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarQuestRoom', 'GameTooltip'],
	shots,
};
