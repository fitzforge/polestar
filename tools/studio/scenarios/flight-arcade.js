'use strict';
// Taxi HUD shortcuts, the two game windows and the Flight Arcade settings.
// Example: studio flight-arcade/hearth-0.64-shortcuts.
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

const TIMER = `${ALONE}
local f = PolestarFlightTimer
f.Place()
f.Dest:SetText("Ratchet")
f.Time:SetText("4:12")
Polestar.Widgets.SetProgress(f.Progress, 0.25)
f:Show()
stub.addons[#stub.addons + 1] = { name = "Polestar_Arcade", reason = "DEMAND_LOADED" }
Polestar.Compat.IsOnTaxi = function() return true end
Polestar.Fire("FLIGHT_STARTED")
Polestar.Arcade.Tick()
assert(PolestarFlightArcade and PolestarFlightArcade:IsShown(), "no shortcuts")`;

// The game's window, opened as Play opens it: Polestar_Arcade loaded on demand, on its menu.
const WINDOW = `${ALONE}
assert(Polestar.Arcade.Open(), "the game did not open")
stub.advance(0.5)
local D = FreedoomArcade
D.G.OpenMenu()
D.G.menuReturn = "title"
stub.advance(1)
assert(Polestar_ArcadeFrame and Polestar_ArcadeFrame:IsShown() and PolestarArcadeFrame, "no window")`;

const JEWELS = `${ALONE}
math.randomseed(1)
assert(Polestar.Arcade.Open("jewels"), "Sky Jewels did not open")`;

const SETTINGS = `${ALONE}
Polestar.UI.ShowOptions("integrations")
stub.advance(1)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}-shortcuts`] = { title: `${name} at UI scale ${scale}: the flight timer and its arcade shortcuts`, capture: ['PolestarFlightTimer', 'PolestarFlightArcade'], pad: 24, lua: `${base}\n${SCALE(scale)}\n${TIMER}` };
		shots[`${name}-${scale}-jewels`] = { title: `${name} at UI scale ${scale}: Sky Jewels`, capture: ['PolestarSkyJewels'], pad: 16, lua: `${base}\n${SCALE(scale)}\n${JEWELS}` };
		shots[`${name}-${scale}-window`] = { title: `${name} at UI scale ${scale}: Freedoom Arcade's window on its menu`, capture: ['PolestarArcadeFrame'], pad: 16, lua: `${base}\n${SCALE(scale)}\n${WINDOW}` };
	}
	shots[`${name}-1.0-settings`] = { title: `${name} at UI scale 1.0: the Flight Arcade section`, capture: ['PolestarOptions'], lua: `${base}\n${SCALE('1.0')}\n${SETTINGS}` };
}

module.exports = {
	title: 'Flight Arcade shortcuts, game windows and settings in every look',
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
