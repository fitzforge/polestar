'use strict';
// Two travel surfaces of 0.4.0 in every look and at the UI scales asked for
// (UIParent's scale), a Tauren Hunter at 18 at the Crossroads:
//   <look>-<scale>-pull     a timed delivery the route would hand in too late
//                           (to Camp Taurajo first, then Ratchet: about 13
//                           minutes, the timer 5): the arrow leads to the
//                           hand-in and While you're here says why ("go now,
//                           the route gets there too late")
//   <look>-<scale>-offwalk  80 yd off the walk with nothing in sight: the
//                           minimap's route line starts at the player and
//                           runs to where the arrow points
// Studio shot names: travel-surfaces/<look>-<scale>-<shot>.

const { SKINS, pick } = require('./skins');

const LOOKS = Object.keys(SKINS);
const SCALES = { '064': 0.64, '100': 1, '150': 1.5 };

const SCALE = (s) => `UIParent:SetScale(${s})
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// A guide of three steps: the delivery taken at the Crossroads (a 5-minute
// limit), a walk to Camp Taurajo, the hand-in at Ratchet.
const PULL = `Polestar.RegisterPack({ addon = "Polestar_Studio", id = "studio", format = 1, title = "Studio", author = "Studio", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "studio")
Polestar.RegisterGuide({ id = "studio/pull", pack = "studio", title = "The Barrens", minLevel = 10, maxLevel = 25, steps = {
	{ title = "The Crossroads", goals = {
		{ t = "accept", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 3429, npcName = "Thork", limit = 300, map = 1413, x = 51.5, y = 30.3 },
	} },
	{ title = "Camp Taurajo", goals = { { t = "goto", map = 1413, x = 44.6, y = 58.9, label = "Camp Taurajo" } } },
	{ title = "Ratchet", goals = {
		{ t = "turnin", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 3453, npcName = "Wharfmaster Dizzywig", map = 1413, x = 63.1, y = 37.2 },
	} },
} })
local E, w = Polestar.Engine, stub.world
E.SetGuide("studio/pull")
stub.advance(1)
C_QuestLog.GetTimeAllowed = function() return 0, 0 end
w.accept(3364, {}, "Scalding Mornbrew Delivery")
for _ = 1, 8 do stub.advance(1) end
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The walk 80 yd beside the player, the arrow aiming at it 20 yd on (a corner
// of the walk there), the walk running on past it.
const OFFWALK = `local N = Polestar.Nav
local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
local geom = { legs = { { kind = "walk", pts = { { c, px - 200, py + 80 }, { c, px + 20, py + 80 }, { c, px + 120, py + 140 } }, current = true } } }
N.GetRouteGeometry = function() return geom end
N.walk.SightAim = function() return nil end
N.walk.LastAim = function() return c, px + 20, py + 80 end
Polestar.Fire("NAV_ROUTE_GEOMETRY")
stub.advance(1)`;

const shots = {};
for (const look of LOOKS) {
	const [id, folder, variant] = SKINS[look];
	const base = pick(id, folder, variant);
	for (const [tag, s] of Object.entries(SCALES)) {
		shots[`${look}-${tag}-pull`] = {
			title: `${look} at ${s}: a timed hand-in pulled forward, While you're here saying why`,
			capture: ['PolestarGuideFrame', 'PolestarNavArrow'],
			lua: `${base}\n${SCALE(s)}\n${PULL}`,
		};
		shots[`${look}-${tag}-offwalk`] = {
			title: `${look} at ${s}: 80 yd off the walk, the minimap's line from the player to the arrow's aim`,
			capture: ['Minimap'],
			pad: 20,
			lua: `${base}\n${SCALE(s)}\n${OFFWALK}`,
		};
	}
}

module.exports = {
	title: 'Travel in 0.4.0: a timed hand-in pulled forward, the minimap line off the walk',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 0 },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	stubs: require('./skins').stubs,
	capture: ['PolestarGuideFrame'],
	shots,
};
