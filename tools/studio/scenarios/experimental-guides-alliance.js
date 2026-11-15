'use strict';
// experimental-guides.js for the Alliance: a Human Warrior at Thelsamar. The guide menu's Leveling 30-40 and
// 40-50 with Riverglades (39-43) and Shen'dralas (43-45), and 50-60 with Mount Hyjal (57-59); Choose your path
// at the end of the Badlands (Thelsamar, about 39: Desolace or the Riverglades) and of the Badlands &
// Hinterlands guide (about 43: Feralas or Shen'dralas).

module.exports = require('./experimental-guides').make({
	title: "Experimental guides with ours (Alliance): the guide menu's Leveling bands with Riverglades, Shen'dralas and Mount Hyjal, and Choose your path at Thelsamar and after the Badlands & Hinterlands",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 39, money: 412000 },
	place: { map: 1432, x: 35.0, y: 47.0, zone: 'Loch Modan', subzone: 'Thelsamar' },
	menus: {
		'menu-3040-4050': {
			title: "Leveling, Alliance 30-40 and 40-50: Riverglades (39-43) and Shen'dralas (43-45) among our guides, Riverglades selected",
			filter: 'Alliance', open: ['Leveling/Alliance/30', 'Leveling/Alliance/40'], select: 'polestar-experimental/riverglades-alliance-1',
		},
		'menu-5060': {
			title: 'Leveling, Alliance 50-60: Mount Hyjal (57-59) among our guides, selected',
			filter: 'Alliance', open: ['Leveling/Alliance/50'], select: 'polestar-experimental/hyjal-1',
		},
	},
	choices: {
		'choice-badlands': { title: 'Choose your path at the end of the Badlands (Thelsamar, level 39): Desolace or the Riverglades', from: 'forever/alliance/30-40/06-badlands', level: 39 },
		'choice-hinterlands': { title: "Choose your path at the end of the Badlands & Hinterlands (level 43): Feralas or Shen'dralas", from: 'forever/alliance/40-50/02-badlands', level: 43 },
	},
});
