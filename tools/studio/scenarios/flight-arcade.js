'use strict';
// Freedoom Arcade on a flight (Maps/Arcade.lua) in every look at the game's UI
// scales 0.64, 1.0 and 1.5: the flight timer on a flight to Ratchet with the
// card under it asking "Do you want to play Doom while waiting?" (Play, Not
// now, Don't ask again), the timer with the row a "Not now" leaves
// (Play Freedoom Arcade), and the game's window from Polestar_Arcade, loaded
// as the first Play loads it, on its menu (its title in the theme's type, the
// look's frame round the game). At 1.0 also the settings window on
// Integrations, its Freedoom Arcade section. The looks are the built-in six
// and the skin addons in the download with the variants skins.js shows, each
// picked as skins.js picks it.
//
// Shots: <look>-<scale>-ask, <look>-<scale>-row, <look>-<scale>-window and
// <look>-1.0-settings (studio flight-arcade/hearth-0.64-ask ...).
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null], ...skins.SKINS };

const SCALES = ['0.64', '1.0', '1.5'];

const SCALE = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end`;

// The arrow and the guide window stay out of the frame.
const ALONE = `if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end`;

// The flight timer 4:12 from Ratchet, a quarter of the way, with the card in `mode` under it.
const TIMER = (mode) => `${ALONE}
local f = PolestarFlightTimer
f.Place()
f.Dest:SetText("Ratchet")
f.Time:SetText("4:12")
Polestar.Widgets.SetProgress(f.Progress, 0.25)
f:Show()
Polestar.Arcade.ShowCard(${JSON.stringify(mode)})
stub.advance(0.5)
assert(PolestarArcadeOffer and PolestarArcadeOffer:IsShown(), "no card")`;

// The game's window, opened as Play opens it: Polestar_Arcade loaded on demand, on its menu.
const WINDOW = `${ALONE}
assert(Polestar.Arcade.Open(), "the game did not open")
stub.advance(0.5)
local D = FreedoomArcade
D.G.OpenMenu()
D.G.menuReturn = "title"
stub.advance(1)
assert(Polestar_ArcadeFrame and Polestar_ArcadeFrame:IsShown() and PolestarArcadeFrame, "no window")`;

const SETTINGS = `${ALONE}
Polestar.UI.ShowOptions("integrations")
stub.advance(1)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}-ask`] = { title: `${name} at UI scale ${scale}: the flight timer and the card asking to play`, capture: ['PolestarFlightTimer', 'PolestarArcadeOffer'], pad: 24, lua: `${base}\n${SCALE(scale)}\n${TIMER('ask')}` };
		shots[`${name}-${scale}-row`] = { title: `${name} at UI scale ${scale}: the flight timer and its Play Freedoom Arcade row`, capture: ['PolestarFlightTimer', 'PolestarArcadeOffer'], pad: 24, lua: `${base}\n${SCALE(scale)}\n${TIMER('row')}` };
		shots[`${name}-${scale}-window`] = { title: `${name} at UI scale ${scale}: Freedoom Arcade's window on its menu`, capture: ['PolestarArcadeFrame'], pad: 16, lua: `${base}\n${SCALE(scale)}\n${WINDOW}` };
	}
	shots[`${name}-1.0-settings`] = { title: `${name} at UI scale 1.0: Integrations, the Freedoom Arcade section`, capture: ['PolestarOptions'], lua: `${base}\n${SCALE('1.0')}\n${SETTINGS}` };
}

module.exports = {
	title: 'Freedoom Arcade on a flight: the card and the row under the flight timer and the game\'s window in every look at UI scales 0.64, 1.0 and 1.5, and its setting under Integrations',
	character: { race: 'Orc', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 51.5, y: 30.3, zone: 'The Barrens', subzone: 'The Crossroads' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false, 'nav.arrow': false },
	window: [1920, 1080],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarFlightTimer'],
	LOOKS,
	shots,
};
