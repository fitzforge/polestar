'use strict';
// experimental-guides.js for the Alliance: a Human Warrior at level 58 in the Western Plaguelands. The guide menu's
// Leveling 50-60 with Mount Hyjal (57-59), and Choose your path at the end of the Western Plaguelands guide (about 58:
// Silithus or Mount Hyjal). The Riverglades and Shen'dralas are part of the Alliance route (40-50/01b-riverglades,
// 40-50/shendralas), so no card offers them.

module.exports = require('./experimental-guides').make({
	title: "Experimental guides with ours (Alliance): the guide menu's Leveling 50-60 with Mount Hyjal, and Choose your path after the Western Plaguelands",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 58, money: 412000 },
	place: { map: 1422, x: 42.9, y: 84.5, zone: 'Western Plaguelands', subzone: 'Chillwind Camp' },
	menus: {
		'menu-5060': {
			title: 'Leveling, Alliance 50-60: Mount Hyjal (57-59) among our guides, selected',
			open: ['Leveling/Alliance/50'], select: 'polestar-experimental/hyjal-1',
		},
	},
	choices: {
		'choice-wpl': { title: 'Choose your path at the end of the Western Plaguelands guide (level 58): Silithus or Mount Hyjal', from: 'forever/alliance/50-60/04-western-plaguelands', level: 58 },
	},
});
