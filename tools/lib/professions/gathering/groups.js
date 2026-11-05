'use strict';
// Who goes where early on. Gathering guides branch by starting area for the
// first bands, by continent for the middle ones, and by faction after that.

const RACE_GROUPS = {
	Alliance: [
		{ key: 'human', races: ['Human'], start: [1429], next: [1436], c: 0 },
		{ key: 'dwarf-gnome', races: ['Dwarf', 'Gnome'], start: [1426], next: [1432], c: 0 },
		{ key: 'nightelf', races: ['NightElf'], start: [1438], next: [1439], c: 1 },
		// Skyborne start on Zephras Isle (both sides) and go on to Westfall or The Barrens.
		{ key: 'skyborne-a', races: ['Skyborne'], start: [2521], next: [1436], c: 0 },
	],
	Horde: [
		{ key: 'orc-troll', races: ['Orc', 'Troll'], start: [1411], next: [1413], c: 1 },
		{ key: 'tauren', races: ['Tauren'], start: [1412], next: [1413], c: 1 },
		{ key: 'undead', races: ['Undead'], start: [1420], next: [1421], c: 0 },
		{ key: 'skyborne-h', races: ['Skyborne'], start: [2521], next: [1413], c: 1 },
	],
};

const REGIONS = {
	Alliance: [
		{ key: 'alliance-ek', races: ['Human', 'Dwarf', 'Gnome', 'Skyborne'], c: 0 },
		{ key: 'alliance-kalimdor', races: ['NightElf'], c: 1 },
	],
	Horde: [
		{ key: 'horde-kalimdor', races: ['Orc', 'Troll', 'Tauren', 'Skyborne'], c: 1 },
		{ key: 'horde-ek', races: ['Undead'], c: 0 },
	],
};

const SIDE = { Alliance: 'A', Horde: 'H' };

// Races of both sides: an `only` naming one also names the side (`only Human,Skyborne,Alliance`).
const TWO_SIDED = new Set(['Skyborne']);

// The `only` condition for races of one or both factions.
function raceCondition(races, factions) {
	const list = [...new Set(races)];
	const side = factions.length === 1 && list.some((r) => TWO_SIDED.has(r)) ? [factions[0]] : [];
	return [...list, ...side].join(',');
}

// Highest zone minimum level worth sending a character with skill `s` to
// (skill outpaces level: 65 -> 20, 125 -> 30, 200 -> 43, 260 -> 53).
function maxZoneLevel(s) {
	return Math.floor(s / 6) + 10;
}

module.exports = { RACE_GROUPS, REGIONS, SIDE, TWO_SIDED, raceCondition, maxZoneLevel };
