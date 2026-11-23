'use strict';
// experimental-guides.js for the Alliance: a Human Warrior at level 58 in the Western Plaguelands. Mount Hyjal is part
// of both routes since 0.4.3 (forever/50-60/mount-hyjal, after the Western Plaguelands guide), so the guide menu's
// Leveling 50-60 shows it as a route guide, without the Forever mark or the Experimental chip, and no card offers it.

module.exports = require('./experimental-guides').make({
	title: "Mount Hyjal in the Alliance route: the guide menu's Leveling 50-60 with Mount Hyjal as a route guide (no Forever mark, no Experimental chip)",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 58, money: 412000 },
	place: { map: 1422, x: 42.9, y: 84.5, zone: 'Western Plaguelands', subzone: 'Chillwind Camp' },
	menus: {
		'menu-5060': {
			title: "Leveling, Alliance 50-60: Mount Hyjal (57-59) among the route's guides, selected",
			open: ['Leveling/Alliance/50'], select: 'forever/50-60/mount-hyjal', tip: false,
		},
	},
	choices: {},
});
