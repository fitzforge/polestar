'use strict';
// The middle dot "·" between counts and in notes (#4015), in every look, on
// a Russian client (render with --locale ruRU): the guide window on Westfall
// with Up next open ("Up next · 3 steps") and the step list's rows ("17 ·
// ..."). Shots: <look>-skin (the skin's face; on a Russian client Fira
// Sans, which has the dot) and <look>-game (the game font picked: the
// Russian client font has no dot, so Polestar draws "-").
// The looks are skins.js's (the built-in ones and our skins), each picked as
// skins.js picks it.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

// The Russian client's own font, as the client names it.
const CLIENT_FONT = 'STANDARD_TEXT_FONT = "Fonts\\\\FRIZQT___CYR.TTF"';

const SHOW = `Polestar.Set("ui.upcoming", 3)
Polestar.Set("ui.upcomingOpen", true)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(1)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	shots[`${name}-skin`] = { title: `${name}: the skin's face (the dot drawn)`, lua: `${CLIENT_FONT}\n${base}\n${SHOW}` };
	shots[`${name}-game`] = { title: `${name}: the game font picked (no dot in it: "-")`, lua: `${CLIENT_FONT}\n${base}\nPolestar.Set("ui.font", "game")\n${SHOW}` };
}

module.exports = {
	title: 'The middle dot in every look on a Russian client: the skin\'s face and the game font picked (#4015)',
	character: { race: 'Human', cls: 'MAGE', faction: 'Alliance', level: 13, money: 4200 },
	place: { map: 1436, x: 53.8, y: 32.4, zone: 'Westfall', subzone: 'The Jansen Stead' },
	guide: { id: 'forever/alliance/02-westfall', play: 16 },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	LOOKS,
	shots,
};
