'use strict';
// What a walking step costs on each kind of ground, for each faction: the
// packer's copy of the router's table (addon/Polestar_Nav/Routing/Costs.lua),
// which prices the walking maps' graph edges (pack.js) as the router prices
// its grid steps. Tune the two together; tests/navmesh-pack.test.js checks
// they agree. The slope bands are the packer's alone: they choose a node's
// class from the grid's tslope (the steepest terrain triangle under it).
//
//   mult(classByte, profile) -> the multiplier of a step into a node of that class
//   profile(faction) -> 'Alliance' | 'Horde' | null

const CLASS = { NORMAL: 0, ROAD: 1, GENTLE: 2, STEEP: 3, INDOOR: 4, CITY: 5 };
const HUB_ALLIANCE = 8; // inside an Alliance hub: hostile to Horde players
const HUB_HORDE = 16; // inside a Horde hub: hostile to Alliance players
// By base class: normal, road, gentle slope, steep slope, indoor, indoor city; classes 6 and 7 cost as normal ground.
const MULT = [1.0, 0.8, 1.3, 2.5, 2.0, 1.0];
const HUB = 20; // a hostile hub, on top of its base class
const MIN = Math.min(...MULT);
// tslope bands (degrees): gentle from GENTLE, steep from STEEP (over 50 the grid's face rule closes what it can).
const SLOPE = { GENTLE: 30, STEEP: 40 };
// The profiles a graph edge is priced for, in record order (Routing/PathGrid.lua adjacent): Alliance, Horde, none.
const PROFILES = ['Alliance', 'Horde', null];

const profile = (faction) => (faction === 'Alliance' || faction === 'Horde' ? faction : null);

function mult(classByte, prof) {
	const m = MULT[classByte & 7] ?? 1.0;
	const hostile = (prof === 'Horde' && classByte & HUB_ALLIANCE) || (prof === 'Alliance' && classByte & HUB_HORDE);
	return hostile ? m * HUB : m;
}

module.exports = { CLASS, HUB_ALLIANCE, HUB_HORDE, MULT, HUB, MIN, SLOPE, PROFILES, profile, mult };
