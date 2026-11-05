'use strict';
// Header comment shared by every generated profession guide.

const ERA_NOTE = [
	'Spawns come from the reference data: the Era baseline (pfQuest) plus the',
	"node spawns Forever's beta sniffs add (Zephras Isle, the starting-area Poor",
	'Copper Veins and herbs: the Forever TrinityCore world DB); trainer learn skills',
	"and prices from Forever's sniffed trainer lists; recipes and their skill colours",
	'from the Forever client tables (`forge data professions`).',
	"ASSUMED: past level 30 (the beta's cap) Forever's spawns are Classic's; nothing",
	'confirms them yet. In-game check: refine with Polestar_Recorder sessions.',
	"ASSUMED: rank level gates are Classic's (Journeyman 10, Expert 20, Artisan 35);",
	"Forever's sniffed trainer lists show none (the gate sits on the rank spell, a",
	'table we lack); only Journeyman Fishing is sniffed at level 10. In-game check:',
	'the level a trainer asks for each rank.',
	'Waypoints are Era-frame (`coords era`); the engine converts them where Forever',
	'changed a map frame, and a map without an Era frame (Zephras Isle) compiles live.',
];

// Mining, Herbalism and Skinning: ERA_NOTE with what Forever's trainer lists
// say about rank levels in place of the Classic-gates assumption.
const GATHERING_NOTE = [
	...ERA_NOTE.slice(0, 7),
	"Ranks ask no character level: Forever's sniffed trainer lists carry none for",
	'Herbalism, Mining or Skinning, and level 10 for Journeyman crafting and Fishing.',
	'INGAME: does a gathering trainer ask a level for Expert or Artisan? (our data:',
	'none; one web guide: Expert 10, Artisan 25).',
	...ERA_NOTE.slice(-2),
];

module.exports = { ERA_NOTE, GATHERING_NOTE };
