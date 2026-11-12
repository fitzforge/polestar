'use strict';
// Hiding Polestar from the minimap button (Core/Init.lua ns.SetHidden,
// Maps/MinimapButton.lua): a Tauren Hunter on the shipped Barrens guide, 38
// steps in, the arrow on a goal at Ratchet, route lines on the world map and the
// minimap. World shots: the screen with the minimap (the playground's
// stand-in disc) and Polestar's window, arrow and buttons; map shots: the
// world map open on the Barrens (zone art from the local art cache). Frames
// show and hide their children as the client does (stub.cascadeVisibility).

const SETUP = `stub.cascadeVisibility = true`;
const MAP = 'play.openMap(1413)\nstub.advance(0.5)';
const HIDE = 'Polestar.SetHidden(true)\nstub.advance(0.5)';
const SHOW = 'Polestar.SetHidden(false)\nstub.advance(0.5)';
const MENU = 'Polestar.Maps.ShowMenu(PolestarMinimapButton)\nstub.advance(0.3)';
const WORLD = ['PolestarGuideFrame', 'Minimap', 'PolestarMinimapButton', 'PolestarArrow', 'PolestarTargetButton', 'PolestarQuestItemButton', 'PolestarMenu', 'GameTooltip'];

module.exports = {
	title: 'Hide Polestar from the minimap button (hide-all)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 38, hours: 1 },
	settings: { 'behavior.offerClassQuests': false },
	setup: SETUP,
	window: [1440, 690],
	capture: WORLD,
	pad: 32,
	shots: {
		'1-before-world': { title: 'Before: the window, the arrow, the buttons, the minimap\'s drawings', lua: '' },
		'1-before-map': { title: 'Before: the world map, the route and the pins', capture: ['WorldMapFrame'], lua: MAP },
		'2-hidden-world': { title: 'Hidden: only the minimap button, dimmed', lua: HIDE },
		'2-hidden-map': { title: 'Hidden: the world map with nothing of Polestar\'s', capture: ['WorldMapFrame'], lua: `${HIDE}\n${MAP}` },
		'2-hidden-hover': {
			title: 'Hidden, the button hovered: "Polestar is hidden: click to show"',
			capture: ['Minimap', 'PolestarMinimapButton', 'GameTooltip'],
			lua: `${HIDE}\nstudio.hover(PolestarMinimapButton)`,
		},
		'3-after-world': { title: 'Shown again: everything back', lua: `${HIDE}\n${SHOW}` },
		'3-after-map': { title: 'Shown again: the world map', capture: ['WorldMapFrame'], lua: `${HIDE}\n${SHOW}\n${MAP}` },
		'4-menu-shown': {
			title: 'The right-click menu, shown',
			capture: ['Minimap', 'PolestarMinimapButton', 'PolestarMenu'],
			lua: MENU,
		},
		'4-menu-hidden': {
			title: 'The menu while hidden ("Show Polestar"), Keep the arrow ticked',
			capture: ['Minimap', 'PolestarMinimapButton', 'PolestarMenu'],
			lua: `Polestar.SetHideKeepsArrow(true)\n${HIDE}\n${MENU}`,
		},
		'5-hidden-keep-arrow': {
			title: 'Hidden with the arrow kept: the arrow and the dimmed button',
			lua: `Polestar.SetHideKeepsArrow(true)\n${HIDE}`,
		},
	},
};
