'use strict';
// What the exploration guides cover and in which order (general game
// knowledge: zone neighbours, roads, towns; for Forever's new zones, the
// ways in Blizzard and the guide sites describe: the Riverglades off the
// southern Badlands, northern Redridge and the Tanaris ship, Shen'dralas
// through the Valley of Bones, Hyjal through Darkwhisper Gorge, the Zephras
// Isle skyboats; the crossings in data/crossings.json). Coordinates never
// come from here: every point is an overlay centre from the Forever client's
// map tables (areas.js), every flight master a TaxiNodes row
// (data/forever/travel.json). The generator fails when a name below does not
// match those tables.
//
// Bands follow the areas' own ExplorationLevel (median per zone): Eastern
// Kingdoms 1-30 is Elwynn ... Hillsbrad (medians 7-26), 30-45 Alterac ...
// Swamp of Sorrows (33-40), 45-60 the rest; Kalimdor 1-30 Durotar ...
// Thousand Needles, 30-45 Desolace, Feralas, Dustwallow Marsh, 45-60 Tanaris
// onwards. Moonglade's single area is level 15 but sits behind Felwood, so it
// goes with 45-60. Inside a band the zones run from low to high where the
// travel allows (Duskwood's areas are 24-30, so it follows Redridge; the
// Hinterlands and Searing Gorge come before Deadwind Pass and the Blasted
// Lands), and the other faction's starting zones come late, when their guards
// and players are less of a threat.
//
// A route is per faction (`Alliance` / `Horde`) where the two travel
// differently enough to want another zone order, else `both` with
// per-faction travel lines.
//
// Guide fields: `legacy: false` leaves out the world-map Legacy Challenge
// note; `comments` are lines for the guide's header comment (open questions:
// `INGAME: ...`).
//
// Visit fields:
//   zone     zone map name (zones.json)
//   travel   how to get there: text, or { Alliance, Horde, both }
//   from     where the zone's tour starts when the player does not walk in
//            from the previous zone: { taxi: '<TaxiNodes short name>' },
//            { stop: '<transport stop name>' } or { area: '<area name>' }
//            (that area is visited first)
//   exit     { area: '<area name>' }: visited last, where the road to the
//            next zone leaves
//   tip      extra zone tip

const GUIDES = [
	{
		id: 'eastern-kingdoms-1-30',
		title: 'Exploration: Eastern Kingdoms 1-30',
		continent: 'Eastern Kingdoms',
		levels: [1, 30],
		next: 'eastern-kingdoms-30-45',
		intro: {
			both: 'Discovering an area gives experience scaled to its level, so this runs alongside leveling.',
			Alliance: 'Alliance starts in Elwynn Forest; dwarves and gnomes can begin at the Dun Morogh step.',
			Horde: 'Horde starts in Tirisfal Glades; orcs, trolls and tauren arrive by zeppelin from Orgrimmar.',
		},
		routes: {
			Alliance: {
				start: { area: 'Northshire Valley' },
				visits: [
					{ zone: 'Elwynn Forest', exit: { area: 'Stormwind City' }, travel: 'Northshire Valley opens onto Elwynn Forest; Goldshire is south down the road.' },
					{
						zone: 'Dun Morogh',
						from: { taxi: 'Ironforge' },
						travel: "Take the Deeprun Tram from Stormwind's Dwarven District to Ironforge, then leave the city through its gates.",
					},
					{ zone: 'Loch Modan', exit: { area: 'Thelsamar' }, travel: 'Leave Dun Morogh east through the South Gate tunnel; it opens into Loch Modan by the dwarf king statues of the Valley of Kings.' },
					{
						zone: 'Westfall',
						from: { taxi: 'Stormwind' },
						travel:
							"Fly from Thelsamar to Stormwind if you have its flight path; otherwise ride back to Ironforge and take the Deeprun Tram. Walk west out of Elwynn Forest past the Westbrook Garrison into Westfall.",
					},
					{
						zone: 'Redridge Mountains',
						exit: { area: 'Three Corners' },
						travel: "Go back east through Elwynn Forest: the road past the Eastvale Logging Camp enters Redridge at Three Corners, where the roads from Elwynn Forest and Duskwood meet.",
					},
					{
						zone: 'Duskwood',
						exit: { area: 'Darkshire' },
						travel: 'From Three Corners take the road south into Duskwood; Darkshire is east along its main road. Most of Duskwood is level 24-30: come with Redridge behind you.',
					},
					{
						zone: 'Wetlands',
						from: { area: 'Thelgen Rock' },
						exit: { area: 'Menethil Harbor' },
						travel: 'Fly from Darkshire to Thelsamar in Loch Modan and ride north through the Dun Algaz pass into the Wetlands.',
					},
					{ zone: 'Hillsbrad Foothills', from: { stop: 'Southshore' }, travel: 'Take the boat from Menethil Harbor to Southshore.' },
					{ zone: 'Silverpine Forest', travel: 'Follow the road west from Hillsbrad past Southpoint Tower into Silverpine Forest, Horde country with Horde guards at the Sepulcher.' },
					{ zone: 'Tirisfal Glades', travel: "Silverpine's road north leads into Tirisfal Glades. Brill, Deathknell and the Undercity ruins are Horde ground." },
				],
			},
			Horde: {
				start: { area: 'Deathknell' },
				visits: [
					{ zone: 'Tirisfal Glades', travel: "Deathknell opens onto Tirisfal Glades; Brill is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the Undercity." },
					{ zone: 'Silverpine Forest', exit: { area: 'The Greymane Wall' }, travel: 'Silverpine Forest is south of Tirisfal Glades: follow the road south from Brill.' },
					{
						zone: 'Hillsbrad Foothills',
						exit: { area: 'Durnholde Keep' },
						travel: 'At the south end of Silverpine the road turns east into Hillsbrad Foothills by Southpoint Tower. Tarren Mill in the north-east is the Horde town; Southshore is Alliance.',
					},
					{
						zone: 'Wetlands',
						from: { area: 'Dun Modr' },
						travel:
							"Walk east from Hillsbrad into the Arathi Highlands (level 30+ creatures off the road), south to the Thandol Span bridge, and across it into the Wetlands. Menethil Harbor is an Alliance town.",
					},
					{ zone: 'Loch Modan', exit: { area: 'North Gate Pass' }, travel: 'The Dun Algaz pass in south-eastern Wetlands leads down into Loch Modan by Algaz Station.' },
					{ zone: 'Dun Morogh', travel: "From Algaz Station take the North Gate Pass tunnel west into Dun Morogh. Kharanos and Ironforge's gates are Alliance ground." },
					{
						zone: 'Duskwood',
						from: { stop: "Grom'gol" },
						travel:
							"Hearth or fly back to the Undercity (or go to Orgrimmar), take the zeppelin to Grom'gol Base Camp in Stranglethorn Vale and walk north along the road into Duskwood. Northern Stranglethorn is level 30+ off the road.",
					},
					{ zone: 'Westfall', travel: 'Westfall borders Duskwood to the west. Sentinel Hill is an Alliance town.' },
					{ zone: 'Elwynn Forest', travel: "Elwynn Forest is north of Westfall and Duskwood. Goldshire, Northshire Valley and Stormwind's gates are Alliance ground with guards." },
					{ zone: 'Redridge Mountains', travel: 'Go east through Elwynn Forest to Three Corners, where Redridge starts. Lakeshire is an Alliance town.' },
				],
			},
		},
	},
	{
		id: 'eastern-kingdoms-30-45',
		title: 'Exploration: Eastern Kingdoms 30-45',
		continent: 'Eastern Kingdoms',
		levels: [30, 45],
		next: 'eastern-kingdoms-45-60',
		intro: { both: 'Starts in the Alterac Mountains, north of Hillsbrad Foothills, and ends in Stranglethorn Vale.' },
		routes: {
			both: {
				start: { area: "Corrahn's Dagger" },
				visits: [
					{
						zone: 'Alterac Mountains',
						travel: {
							Alliance: 'Fly to Southshore in Hillsbrad Foothills and walk north into the Alterac Mountains.',
							Horde: 'Fly to Tarren Mill in Hillsbrad Foothills and walk north into the Alterac Mountains.',
						},
					},
					{
						zone: 'Arathi Highlands',
						exit: { area: 'Thandol Span' },
						travel: {
							both: 'The Arathi Highlands lie east of the Alterac Mountains and Hillsbrad Foothills.',
							Alliance: 'Refuge Pointe in the middle is the Alliance town; Hammerfall in the east is Horde.',
							Horde: 'Hammerfall in the east is the Horde town; Refuge Pointe in the middle is Alliance.',
						},
					},
					{
						zone: 'Badlands',
						exit: { area: "Agmond's End" },
						travel: {
							both: 'Cross the Thandol Span south into the Wetlands, go through the Dun Algaz pass into Loch Modan and take the road south out of Loch Modan into the Badlands.',
							Alliance: 'Faster: fly to Thelsamar in Loch Modan.',
							Horde: 'Kargath in the west is the Horde town.',
						},
					},
					{
						zone: 'Riverglades',
						from: { area: "Twilight's Shroud" },
						travel:
							"From the south of the Badlands, past Agmond's End, a way leads down into the Riverglades by Twilight's Shroud. (The Riverglades also open off northern Redridge through Blackrock Pass, and a ship runs from Steamwheedle Port in Tanaris to Powderfuse Port, the neutral goblin port on its coast.) Krol'dok Stronghold is an ogre clan's outdoor dungeon.",
						tip: "Flight paths: Farholde Keep in the south-east (Alliance), Rog'mar in the middle (Horde).",
					},
					{
						zone: 'Swamp of Sorrows',
						exit: { area: 'Misty Valley' },
						travel: {
							both: "The Swamp of Sorrows lies south of the Riverglades: swim south from Wheeler's Grange, or walk through Redridge Pass, south of the Bristle Hills.",
							Horde: 'Stonard is the Horde town.',
						},
					},
					{
						zone: 'Stranglethorn Vale',
						from: { area: 'Rebel Camp' },
						travel: {
							both: 'Ride west out of the Swamp of Sorrows through Deadwind Pass (level 50+ creatures off the road) into Duskwood and take the road south into northern Stranglethorn Vale.',
							Horde: "Or take the zeppelin from Orgrimmar or the Undercity to Grom'gol Base Camp.",
						},
						tip: 'Booty Bay at the southern tip is a neutral goblin port with a boat to Ratchet.',
					},
				],
			},
		},
	},
	{
		id: 'eastern-kingdoms-45-60',
		title: 'Exploration: Eastern Kingdoms 45-60',
		continent: 'Eastern Kingdoms',
		levels: [45, 60],
		intro: { both: 'Starts in the Hinterlands, north-east of Hillsbrad Foothills. The last area of this guide completes the Eastern Kingdoms map.' },
		routes: {
			both: {
				start: { taxi: 'Aerie Peak' },
				visits: [
					{
						zone: 'The Hinterlands',
						travel: {
							Alliance: 'Fly to Aerie Peak if you have it; otherwise fly to Southshore and walk north-east from Hillsbrad Foothills into the Hinterlands.',
							Horde: 'Fly to Revantusk Village if you have it; otherwise fly to Tarren Mill and walk east from Hillsbrad Foothills into the Hinterlands.',
						},
					},
					{
						zone: 'Searing Gorge',
						from: { area: 'Grimesilt Dig Site' },
						exit: { area: 'The Sea of Cinders' },
						travel: {
							both: 'The way in on foot is from the western Badlands: the path by Kargath climbs west into the Searing Gorge.',
							Alliance: 'Fly to Thelsamar and ride south through Loch Modan into the Badlands, then west to Kargath (Horde guards).',
							Horde: 'Fly to Kargath in the Badlands.',
						},
					},
					{
						zone: 'Burning Steppes',
						from: { area: 'Blackrock Mountain' },
						exit: { area: 'Blackrock Pass' },
						travel: "Cross Blackrock Mountain from the south of the Searing Gorge into the Burning Steppes: stay on the chain path inside, past the dungeon entrances. Morgan's Vigil (Alliance) is in the east.",
					},
					{
						zone: 'Deadwind Pass',
						travel: 'Take the pass south from the Burning Steppes into the Redridge Mountains, follow the road south-west through Three Corners into Duskwood and east past Darkshire into Deadwind Pass.',
					},
					{
						zone: 'Blasted Lands',
						travel: 'Ride east out of Deadwind Pass into the Swamp of Sorrows and take the road south into the Blasted Lands; Nethergarde Keep (Alliance) stands just inside.',
					},
					{
						zone: 'Western Plaguelands',
						from: { taxi: 'Chillwind Camp' },
						travel: {
							Alliance: 'Fly to Chillwind Camp if you have it; otherwise fly to Southshore and ride north through the Alterac Mountains to Chillwind Camp in southern Western Plaguelands.',
							Horde: 'Fly to Tarren Mill and ride north through the Alterac Mountains into southern Western Plaguelands, or go east from Tirisfal Glades past The Bulwark.',
						},
					},
					{
						zone: 'Eastern Plaguelands',
						travel: "Eastern Plaguelands lie east of Western Plaguelands, across the Thondroril River. Light's Hope Chapel in the east has flight masters for both factions.",
					},
				],
			},
		},
	},
	{
		id: 'kalimdor-1-30',
		title: 'Exploration: Kalimdor 1-30',
		continent: 'Kalimdor',
		levels: [1, 30],
		next: 'kalimdor-30-45',
		intro: {
			both: 'Discovering an area gives experience scaled to its level, so this runs alongside leveling.',
			Alliance: 'Alliance starts on Teldrassil; humans, dwarves and gnomes arrive by boat at Auberdine and can begin at the Darkshore step.',
			Horde: 'Horde starts in Durotar; tauren can begin at the Mulgore step, undead arrive by zeppelin at Orgrimmar.',
		},
		routes: {
			Alliance: {
				start: { area: 'Shadowglen' },
				visits: [
					{ zone: 'Teldrassil', travel: 'Shadowglen opens onto Teldrassil; Dolanaar is south along the road. Rut\'theran Village, at the foot of the tree, is reached through the portal in Darnassus.' },
					{ zone: 'Darkshore', from: { stop: 'Auberdine' }, travel: "Take the boat from Rut'theran Village to Auberdine." },
					{ zone: 'Ashenvale', travel: "Follow Darkshore's coast road south into Ashenvale. Astranaar is the Alliance town." },
					{ zone: 'Stonetalon Mountains', exit: { area: 'Camp Aparaje' }, travel: 'The Stonetalon Mountains border Ashenvale to the south-west; Stonetalon Peak in the north is the Alliance flight point.' },
					{
						zone: 'The Barrens',
						from: { area: "Honor's Stand" },
						travel: "The road east out of south-eastern Stonetalon comes down into the Barrens at Honor's Stand. The Crossroads and Camp Taurajo are Horde towns; Ratchet is a neutral port.",
					},
					{ zone: 'Durotar', travel: 'Cross the Southfury River east from the northern Barrens into Durotar: Horde country, with guards at Razor Hill, Sen\'jin Village and Orgrimmar.' },
					{
						zone: 'Mulgore',
						from: { taxi: 'Camp Taurajo' },
						exit: { area: 'The Rolling Plains' },
						travel: 'Go back west across the Barrens; the road west from Camp Taurajo climbs through the only pass into Mulgore, tauren country with guards at Bloodhoof Village and Thunder Bluff.',
					},
					{ zone: 'Thousand Needles', from: { area: 'The Great Lift' }, travel: 'Leave Mulgore by the same pass and ride south through the Barrens to the Great Lift down into Thousand Needles. Freewind Post is a Horde town.' },
				],
			},
			Horde: {
				start: { area: 'Valley of Trials' },
				visits: [
					{ zone: 'Durotar', travel: 'The Valley of Trials opens onto Durotar; Razor Hill is north along the road.' },
					{ zone: 'The Barrens', exit: { area: 'Camp Taurajo' }, travel: 'Cross the Southfury River bridges west out of Durotar into the Barrens. Northwatch Hold in the east is an Alliance fort.' },
					{ zone: 'Mulgore', exit: { area: 'The Rolling Plains' }, travel: 'The road west from Camp Taurajo climbs through the only pass into Mulgore.' },
					{ zone: 'Stonetalon Mountains', travel: "Leave Mulgore by the same pass, ride north through the Barrens and west at Honor's Stand into the Stonetalon Mountains. Sun Rock Retreat is the Horde town; Stonetalon Peak in the north is Alliance." },
					{ zone: 'Ashenvale', travel: "The Talondeep Path tunnel in eastern Stonetalon leads north into Ashenvale. Splintertree Post and Zoram'gar Outpost are Horde; Astranaar is Alliance." },
					{ zone: 'Darkshore', travel: "Follow Ashenvale's road north-west to the coast and into Darkshore, Alliance country with guards at Auberdine." },
					{
						zone: 'Teldrassil',
						from: { stop: "Rut'theran Village" },
						travel: "Take the boat from Auberdine to Rut'theran Village. Teldrassil is night elf country: Dolanaar and Shadowglen have guards, and Darnassus is reached only through the portal in Rut'theran Village.",
					},
					{ zone: 'Thousand Needles', from: { area: 'The Great Lift' }, travel: 'Fly to Camp Taurajo and walk south through the Barrens to the Great Lift down into Thousand Needles.' },
				],
			},
		},
	},
	{
		id: 'kalimdor-30-45',
		title: 'Exploration: Kalimdor 30-45',
		continent: 'Kalimdor',
		levels: [30, 45],
		next: 'kalimdor-45-60',
		intro: { both: 'Picks up west of the Barrens, in Desolace, and ends in Dustwallow Marsh.' },
		routes: {
			both: {
				start: { area: 'Tethris Aran' },
				visits: [
					{
						zone: 'Desolace',
						travel: {
							Alliance: "Fly to Stonetalon Peak (or to Nijel's Point if you have it) and take the road south-west out of the Stonetalon Mountains into Desolace; Nijel's Point in the north is the Alliance town.",
							Horde: 'Fly to Sun Rock Retreat and take the road south-west into Desolace; Shadowprey Village on the west coast is the Horde town.',
						},
					},
					{
						zone: "Shen'dralas",
						from: { area: 'Valley of Bones' },
						travel: "Shen'dralas, the ruins between Desolace and Mulgore, is entered from southern Desolace through the Valley of Bones.",
					},
					{
						zone: 'Feralas',
						travel: {
							both: 'Go back into southern Desolace; the road continues south into Feralas.',
							Alliance: 'Feathermoon Stronghold on Sardor Isle is the Alliance town (boat from the Forgotten Coast).',
							Horde: 'Camp Mojache in the east is the Horde town.',
						},
					},
					{
						zone: 'Dustwallow Marsh',
						travel: {
							Alliance: 'Fly to Theramore (or take the boat from Menethil Harbor); Theramore Isle is the Alliance town.',
							Horde: 'Dustwallow Marsh is east of the southern Barrens; Brackenwall Village in the north-west is the Horde town.',
						},
					},
				],
			},
		},
	},
	{
		id: 'kalimdor-45-60',
		title: 'Exploration: Kalimdor 45-60',
		continent: 'Kalimdor',
		levels: [45, 60],
		intro: { both: 'Starts in Tanaris, south of Dustwallow Marsh. The last area of this guide completes the Kalimdor map.' },
		routes: {
			both: {
				start: { taxi: 'Gadgetzan' },
				visits: [
					{ zone: 'Tanaris', exit: { area: 'Thistleshrub Valley' }, travel: 'Tanaris is south of Dustwallow Marsh and Thousand Needles. Gadgetzan is a neutral goblin town.' },
					{ zone: "Un'Goro Crater", travel: "From western Tanaris take the path down into Un'Goro Crater. Marshal's Refuge in the north is a neutral camp." },
					{ zone: 'Silithus', travel: "Silithus is west of Un'Goro Crater, through the pass in its north-west. Cenarion Hold is neutral." },
					{
						zone: 'Azshara',
						from: { area: 'Haldarr Encampment' },
						travel: {
							Alliance: 'Fly to Talrendis Point if you have it, otherwise to Astranaar, and walk east out of Ashenvale into Azshara.',
							Horde: 'Fly to Valormok if you have it, otherwise to Splintertree Post, and walk east out of Ashenvale into Azshara.',
						},
					},
					{ zone: 'Felwood', exit: { area: 'Felpaw Village' }, travel: 'Felwood is north of Ashenvale.' },
					{ zone: 'Moonglade', travel: "Take the Timbermaw Hold tunnel in northern Felwood through to Moonglade (druids: Teleport: Moonglade). Nighthaven is neutral." },
					{ zone: 'Winterspring', travel: 'The other exit of the Timbermaw Hold tunnel leads into Winterspring. Everlook is a neutral goblin town with flight masters for both factions.' },
					{
						zone: 'Mount Hyjal',
						travel: "Mount Hyjal is reached from Winterspring through Darkwhisper Gorge in the south. It is Forever's endgame leveling zone.",
						tip: 'Its creatures are level 54-60.',
					},
				],
			},
		},
	},
	{
		id: 'zephras-isle',
		title: 'Exploration: Zephras Isle',
		continent: 'Zephras Isle',
		levels: [1, 12],
		legacy: false,
		comments: [
			'INGAME: does Zephras Isle count towards the world-map Legacy Challenge? Beta write-ups list it among the',
			'new areas of the map, while the challenge list itself names the zones of the Eastern Kingdoms and Kalimdor',
			"(Explore Azeroth); the client parents the isle's map to Azeroth, on no continent. Until it is settled the",
			'guide does not claim it counts.',
		],
		intro: { both: 'Zephras Isle is the Skyborne starting island, a world of its own in Skywall; anyone may visit.' },
		routes: {
			both: {
				start: { area: 'Valanaar' },
				visits: [
					{
						zone: 'Zephras Isle',
						travel: {
							both: 'Skyborne start here. Everyone else takes a skyboat, about every five minutes; either faction may take either one.',
							Alliance: 'The skyboat leaves the north side of Dalaran in the Alterac Mountains (another flies from north of Thunder Bluff).',
							Horde: 'The skyboat leaves the cliffs south of Skywatcher Plateau, north of Thunder Bluff (another flies from Dalaran).',
						},
					},
				],
			},
		},
	},
];

// Towns with guards of one faction. The other faction only needs to touch an
// area's edge for the discovery, so its goal says so. Names as AreaTable has them.
const TOWNS = {
	Horde: [
		'Valley of Trials',
		"Sen'jin Village",
		'Razor Hill',
		'Orgrimmar',
		'Bloodhoof Village',
		'Thunder Bluff',
		'The Crossroads',
		'Camp Taurajo',
		'Deathknell',
		'Brill',
		'Ruins of Lordaeron',
		'The Sepulcher',
		'Tarren Mill',
		'Hammerfall',
		'Kargath',
		"Grom'gol Base Camp",
		'Stonard',
		'Sun Rock Retreat',
		"Malaka'jin",
		'Freewind Post',
		'Shadowprey Village',
		'Camp Mojache',
		'Brackenwall Village',
		'Valormok',
	],
	Alliance: [
		'Northshire Valley',
		'Goldshire',
		'Stormwind City',
		'Coldridge Valley',
		'Kharanos',
		'Gates of Ironforge',
		'Thelsamar',
		'Sentinel Hill',
		'Lakeshire',
		'Darkshire',
		'Menethil Harbor',
		'Southshore',
		'Refuge Pointe',
		'Aerie Peak',
		'Nethergarde Keep',
		"Morgan's Vigil",
		'Shadowglen',
		'Dolanaar',
		'Darnassus',
		"Rut'theran Village",
		'Auberdine',
		'Astranaar',
		'Theramore Isle',
		"Nijel's Point",
		'Stonetalon Peak',
		'Sardor Isle',
		'Talonbranch Glade',
	],
};

// Areas with a hazard beyond their level (general game knowledge).
const CAUTIONS = {
	'Stromgarde Keep': 'elite Syndicate and ogres inside the walls: the discovery triggers at the gate',
	"Mosh'Ogg Ogre Mound": 'elite ogres: discover it from the edge',
	'Gurubashi Arena': 'free-for-all PvP inside the arena ring',
	"Jintha'Alor": 'elite trolls on the upper terraces: discover it from the bottom',
	'Blackrock Stronghold': 'elite Blackrock orcs: discover it from the edge',
	'Grim Batol': 'the discovery triggers at the Dragonmaw Gates: do not go into Grim Batol itself',
	'Karazhan': 'high-level undead around the tower: discover it from the road',
};

// Zone maps that are a world of their own, on no continent (UiMap names):
// each gets explored like a continent.
const ISLANDS = ['Zephras Isle'];

const LEGACY_NOTE =
	'Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point).';

module.exports = { GUIDES, TOWNS, CAUTIONS, ISLANDS, LEGACY_NOTE };
