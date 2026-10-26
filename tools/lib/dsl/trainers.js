'use strict';
// Class trainers (data/forever/trainers.json), from three sources:
//   guide    every `train <npcId> only <Class>` goal (one class) under guides/
//            (the pack's guides: not Recorder drafts or dist/, see findGuideFiles)
//   record   recorded `trainer` events, tagged with the recording character's
//            class (npcs seen by exactly one class, never profession trainers)
//   curated  the name list below: capital and starting-town class trainers,
//            and a few untitled ones out in the world, resolved to npc ids by name on the expected map in npcs.json, so
//            every entry is verified against the data's spawns
//
// trainers.json = { "<npcId>": { id, name, classes: [classFile], sources: [...] } }
//
// Written for Polestar from general game knowledge (trainer names and where
// they stand); ids always come from npcs.json.

const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('./parse');
const { Diagnostics } = require('./diag');
const { findGuideFiles } = require('./project');
const { CLASS_FILES } = require('../game/races');

const SW = 1453;
const IF = 1455;
const DN = 1457;
const OG = 1454;
const TB = 1456;
const UC = 1458;
const ELWYNN = 1429;
const DUN_MOROGH = 1426;
const TELDRASSIL = 1438;
const DUROTAR = 1411;
const MULGORE = 1412;
const TIRISFAL = 1420;
const ZEPHRAS = 2521;
const BARRENS = 1413;

// [classFile, name, uiMapID]
const CURATED = [
	// Stormwind City
	['WARRIOR', 'Wu Shen', SW],
	['WARRIOR', 'Ilsa Corbin', SW],
	['PALADIN', 'Lord Grayson Shadowbreaker', SW],
	['PALADIN', 'Arthur the Faithful', SW],
	['PALADIN', 'Katherine the Pure', SW],
	['PRIEST', 'High Priestess Laurena', SW],
	['PRIEST', 'Brother Benjamin', SW],
	['PRIEST', 'Brother Joshua', SW],
	['ROGUE', 'Osborne the Night Man', SW],
	['MAGE', 'Jennea Cannon', SW],
	['MAGE', 'Elsharin', SW],
	['WARLOCK', 'Ursula Deline', SW],
	['WARLOCK', 'Demisette Cloyce', SW],
	['WARLOCK', 'Sandahl', SW],
	['HUNTER', 'Einris Brightspear', SW],
	['HUNTER', 'Ulfir Ironbeard', SW],
	['DRUID', 'Sheldras Moontree', SW],
	// Elwynn Forest: Northshire and Goldshire
	['WARRIOR', 'Llane Beshere', ELWYNN],
	['WARRIOR', 'Lyria Du Lac', ELWYNN],
	['PALADIN', 'Brother Sammuel', ELWYNN],
	['PALADIN', 'Brother Wilhelm', ELWYNN],
	['PRIEST', 'Priestess Anetta', ELWYNN],
	['PRIEST', 'Priestess Josetta', ELWYNN],
	['ROGUE', 'Jorik Kerridan', ELWYNN],
	['ROGUE', 'Keryn Sylvius', ELWYNN],
	['MAGE', 'Khelden Bremen', ELWYNN],
	['MAGE', 'Zaldimar Wefhellt', ELWYNN],
	['WARLOCK', 'Drusilla La Salle', ELWYNN],
	['WARLOCK', 'Maximillian Crowe', ELWYNN],
	// Ironforge
	['WARRIOR', 'Kelstrum Stonebreaker', IF],
	['WARRIOR', 'Bilban Tosslespanner', IF],
	['PALADIN', 'Brandur Ironhammer', IF],
	['PALADIN', 'Beldruk Doombrow', IF],
	['PALADIN', 'Valgar Highforge', IF],
	['PRIEST', 'High Priest Rohan', IF],
	['PRIEST', 'Braenna Flintcrag', IF],
	['PRIEST', 'Theodrus Frostbeard', IF],
	['ROGUE', 'Fenthwick', IF],
	['ROGUE', 'Hulfdan Blackbeard', IF],
	['ROGUE', 'Ormyr Flinteye', IF],
	['MAGE', 'Dink', IF],
	['MAGE', 'Bink', IF],
	['MAGE', 'Juli Stormkettle', IF],
	['WARLOCK', 'Alexander Calder', IF],
	['WARLOCK', 'Thistleheart', IF],
	['HUNTER', 'Daera Brightspear', IF],
	['HUNTER', 'Olmin Burningbeard', IF],
	['HUNTER', 'Regnus Thundergranite', IF],
	// Dun Morogh: Coldridge Valley and Kharanos
	['WARRIOR', 'Thran Khorman', DUN_MOROGH],
	['WARRIOR', 'Granis Swiftaxe', DUN_MOROGH],
	['PALADIN', 'Bromos Grummner', DUN_MOROGH],
	['PALADIN', 'Azar Stronghammer', DUN_MOROGH],
	['PRIEST', 'Branstock Khalder', DUN_MOROGH],
	['PRIEST', 'Maxan Anvol', DUN_MOROGH],
	['ROGUE', 'Solm Hargrin', DUN_MOROGH],
	['ROGUE', 'Hogral Bakkan', DUN_MOROGH],
	['HUNTER', 'Thorgas Grimson', DUN_MOROGH],
	['HUNTER', 'Grif Wildheart', DUN_MOROGH],
	['MAGE', 'Marryk Nurribit', DUN_MOROGH],
	['MAGE', 'Magis Sparkmantle', DUN_MOROGH],
	['WARLOCK', 'Alamar Grimm', DUN_MOROGH],
	['WARLOCK', 'Gimrizz Shadowcog', DUN_MOROGH],
	// Darnassus
	['WARRIOR', "Arias'ta Bladesinger", DN],
	['WARRIOR', 'Sildanair', DN],
	['WARRIOR', 'Darnath Bladesinger', DN],
	['HUNTER', 'Jocaste', DN],
	['HUNTER', 'Dorion', DN],
	['HUNTER', "Jeen'ra Nightrunner", DN],
	['ROGUE', 'Syurna', DN],
	['ROGUE', 'Anishar', DN],
	['ROGUE', 'Erion Shadewhisper', DN],
	['PRIEST', 'Jandria', DN],
	['PRIEST', 'Lariia', DN],
	['PRIEST', 'Astarii Starseeker', DN],
	['DRUID', 'Mathrengyl Bearwalker', DN],
	['DRUID', 'Denatharion', DN],
	['DRUID', 'Fylerian Nightwing', DN],
	// Teldrassil: Shadowglen and Dolanaar
	['WARRIOR', 'Alyissia', TELDRASSIL],
	['WARRIOR', 'Kyra Windblade', TELDRASSIL],
	['HUNTER', 'Ayanna Everstride', TELDRASSIL],
	['HUNTER', 'Dazalar', TELDRASSIL],
	['ROGUE', 'Frahun Shadewhisper', TELDRASSIL],
	['ROGUE', 'Jannok Breezesong', TELDRASSIL],
	['PRIEST', 'Shanda', TELDRASSIL],
	['PRIEST', 'Laurna Morninglight', TELDRASSIL],
	['DRUID', 'Mardant Strongoak', TELDRASSIL],
	['DRUID', 'Kal', TELDRASSIL],
	// Orgrimmar
	['WARRIOR', 'Sorek', OG],
	['WARRIOR', "Zel'mak", OG],
	['HUNTER', 'Ormak Grimshot', OG],
	['HUNTER', "Xor'juul", OG],
	['HUNTER', "Sian'dur", OG],
	['ROGUE', 'Ormok', OG],
	['ROGUE', 'Shenthul', OG],
	['ROGUE', 'Gest', OG],
	['SHAMAN', 'Kardris Dreamseeker', OG],
	['SHAMAN', 'Sagorne Creststrider', OG],
	['MAGE', 'Pephredo', OG],
	['MAGE', 'Deino', OG],
	['MAGE', "Uthel'nay", OG],
	['WARLOCK', 'Zevrost', OG],
	['WARLOCK', 'Mirket', OG],
	['WARLOCK', "Grol'dar", OG],
	['PRIEST', "Ur'kyo", OG],
	// Durotar: Valley of Trials and Razor Hill
	['WARRIOR', 'Frang', DUROTAR],
	['WARRIOR', 'Tarshaw Jaggedscar', DUROTAR],
	['HUNTER', "Jen'shan", DUROTAR],
	['HUNTER', 'Thotar', DUROTAR],
	['ROGUE', 'Rwag', DUROTAR],
	['ROGUE', 'Kaplak', DUROTAR],
	['SHAMAN', 'Shikrik', DUROTAR],
	['SHAMAN', 'Swart', DUROTAR],
	['WARLOCK', 'Nartok', DUROTAR],
	['WARLOCK', 'Dhugru Gorelust', DUROTAR],
	['PRIEST', "Ken'jai", DUROTAR],
	['PRIEST', "Tai'jin", DUROTAR],
	['MAGE', "Mai'ah", DUROTAR],
	['MAGE', "Un'Thuwa", DUROTAR],
	// Thunder Bluff
	['WARRIOR', 'Torm Ragetotem', TB],
	['WARRIOR', 'Ker Ragetotem', TB],
	['WARRIOR', 'Sark Ragetotem', TB],
	['HUNTER', 'Holt Thunderhorn', TB],
	['HUNTER', 'Urek Thunderhorn', TB],
	['HUNTER', 'Kary Thunderhorn', TB],
	['SHAMAN', 'Beram Skychaser', TB],
	['SHAMAN', 'Siln Skychaser', TB],
	['SHAMAN', 'Tigor Skychaser', TB],
	['DRUID', 'Turak Runetotem', TB],
	['DRUID', 'Sheal Runetotem', TB],
	['DRUID', 'Kym Wildmane', TB],
	['PRIEST', 'Miles Welsh', TB],
	['PRIEST', 'Malakai Cross', TB],
	['PRIEST', 'Father Cobb', TB],
	['MAGE', 'Archmage Shymm', TB],
	['MAGE', 'Ursyn Ghull', TB],
	['MAGE', 'Thurston Xane', TB],
	// Mulgore: Camp Narache and Bloodhoof Village
	['WARRIOR', 'Harutt Thunderhorn', MULGORE],
	['WARRIOR', 'Krang Stonehoof', MULGORE],
	['HUNTER', 'Lanka Farshot', MULGORE],
	['HUNTER', 'Yaw Sharpmane', MULGORE],
	['SHAMAN', 'Meela Dawnstrider', MULGORE],
	['SHAMAN', 'Narm Skychaser', MULGORE],
	['DRUID', 'Gart Mistrunner', MULGORE],
	['DRUID', 'Gennia Runetotem', MULGORE],
	// Undercity
	['WARRIOR', 'Christoph Walker', UC],
	['WARRIOR', 'Angela Curthas', UC],
	['WARRIOR', 'Baltus Fowler', UC],
	['PRIEST', 'Father Lankester', UC],
	['PRIEST', 'Father Lazarus', UC],
	['PRIEST', 'Aelthalyste', UC],
	['ROGUE', 'Carolyn Ward', UC],
	['ROGUE', 'Miles Dexter', UC],
	['ROGUE', 'Gregory Charles', UC],
	['MAGE', 'Kaelystia Hatebringer', UC],
	['MAGE', 'Pierce Shackleton', UC],
	['WARLOCK', 'Kaal Soulreaper', UC],
	['WARLOCK', 'Richard Kerwin', UC],
	['WARLOCK', 'Luther Pickman', UC],
	// Tirisfal Glades: Deathknell and Brill
	['WARRIOR', 'Dannal Stern', TIRISFAL],
	['WARRIOR', 'Austil de Mon', TIRISFAL],
	['MAGE', 'Isabella', TIRISFAL],
	['MAGE', 'Cain Firesong', TIRISFAL],
	['PRIEST', 'Dark Cleric Duesten', TIRISFAL],
	['PRIEST', 'Dark Cleric Beryl', TIRISFAL],
	['ROGUE', 'David Trias', TIRISFAL],
	['ROGUE', 'Marion Call', TIRISFAL],
	['WARLOCK', 'Maximillion', TIRISFAL],
	['WARLOCK', 'Rupert Boch', TIRISFAL],
	// Forever's new race/class pairs and Skyborne (npcs from QuestieDB's Forever
	// store, class from the NPC's <… Trainer> tag in Forever's quest data, 2026-10-12).
	['SHAMAN', 'Eldrun Stormbreaker', IF],
	['SHAMAN', 'Teo Hammerstorm', DUN_MOROGH],
	['SHAMAN', 'Ingrid Dunwald', DUN_MOROGH],
	['PALADIN', 'Garen Largo', UC],
	['PALADIN', 'Aramis Hammerhand', TIRISFAL],
	['PALADIN', 'Shari Stilwell', TIRISFAL],
	['PALADIN', 'Hilda the Breaker', TIRISFAL],
	['PALADIN', 'Alodan the Hopeful', TB],
	['HUNTER', 'Tordrin Sternblade', ELWYNN],
	['HUNTER', 'Josephine Carson', ELWYNN],
	// Capital and Mulgore class trainers the list above lacked: npcs.json's
	// <… Trainer> subName (pfQuest and QuestieDB's Forever store, 2026-10-15).
	['WARRIOR', 'Ander Germaine', SW],
	['DRUID', 'Theridran', SW],
	['DRUID', 'Maldryn', SW],
	['HUNTER', 'Thorfin Stoneshield', SW],
	['PRIEST', 'Nara Meideros', SW],
	['ROGUE', 'Lord Tony Romano', SW],
	['WARRIOR', 'Kelv Sternhammer', IF],
	['PRIEST', 'Toldren Deepiron', IF],
	['PRIEST', 'High Priestess Mims', IF],
	['MAGE', 'Nittlebur Sparkfizzle', IF],
	['WARLOCK', 'Briarthorn', IF],
	['PRIEST', 'Priestess Alathea', DN],
	['WARRIOR', 'Grezz Ragefist', OG],
	['SHAMAN', "Sian'tsu", OG],
	['MAGE', 'Enyo', OG],
	['PRIEST', "X'yera", OG],
	['MAGE', 'Anastasia Hartwell', UC],
	['SHAMAN', 'Palah Thunderhoof', MULGORE],
	['DRUID', 'Hana Lighthoof', MULGORE],
	// Zephras Isle (Skyborne): Thendal Grove, Shen'dar Village, Valanaar.
	['WARRIOR', 'Blademaster Ren', ZEPHRAS],
	['WARRIOR', 'Seena Skybreaker', ZEPHRAS],
	['WARRIOR', 'Corsan Earthrazer', ZEPHRAS],
	['HUNTER', "Tai'ree Farsight", ZEPHRAS],
	['HUNTER', "Quel'ana Quickgale", ZEPHRAS],
	['HUNTER', 'Elayaa Easewind', ZEPHRAS],
	['ROGUE', 'Akeri Duskblade', ZEPHRAS],
	['ROGUE', 'Eltheen Nightbreeze', ZEPHRAS],
	['ROGUE', 'Miriaan Mistblade', ZEPHRAS],
	['MAGE', 'Dorii Brightwhisper', ZEPHRAS],
	['MAGE', 'Anathamaas Aetherwind', ZEPHRAS],
	['MAGE', 'Shenaan Spellwind', ZEPHRAS],
	['SHAMAN', 'Windshaper Boro', ZEPHRAS],
	['SHAMAN', 'Sessaria Skystride', ZEPHRAS],
	['SHAMAN', 'Aarnor Galestrike', ZEPHRAS],
	['DRUID', 'Xyton Silverwind', ZEPHRAS],
	['DRUID', 'Lotheluum Starbreeze', ZEPHRAS],
	['DRUID', 'Naeluna Swiftmend', ZEPHRAS],
	// Trainers with no <… Trainer> tag, seen training in the game.
	['WARLOCK', 'Strahad Farsan', BARRENS],
];

function nameKey(s) {
	return String(s).trim().toLowerCase();
}

// Every npc id a profession lists (rank and profession trainers, book vendors, quest givers).
function professionNpcs(data) {
	const out = new Set();
	const add = (sides) => {
		for (const list of Object.values(sides || {})) for (const id of Array.isArray(list) ? list : []) out.add(Number(id));
	};
	for (const p of data.professions.values()) {
		add(p.trainers);
		for (const r of Array.isArray(p.ranks) ? p.ranks : []) {
			add(r.trainers);
			if (r.book) add(r.book.vendors);
			if (r.quest) add(r.quest.npcs);
		}
	}
	return out;
}

// -> { entries: Map<id, { id, name, classes:Set, sources:Set }>, unverified: [[class, name, map]] }
function curatedTrainers(data) {
	const byName = new Map();
	for (const n of Object.values(data.npcs)) {
		if (!n || !n.name) continue;
		const k = nameKey(n.name);
		if (!byName.has(k)) byName.set(k, []);
		byName.get(k).push(n);
	}
	const entries = new Map();
	const unverified = [];
	for (const [cls, name, map] of CURATED) {
		const hits = (byName.get(nameKey(name)) || []).filter((n) => n.spawns && n.spawns[map]).sort((a, b) => a.id - b.id);
		if (!hits.length) {
			unverified.push([cls, name, map]);
			continue;
		}
		add(entries, hits[0].id, hits[0].name, cls, 'curated');
	}
	return { entries, unverified };
}

function add(entries, id, name, cls, source) {
	if (!entries.has(id)) entries.set(id, { id, name, classes: new Set(), sources: new Set() });
	const e = entries.get(id);
	if (!e.name && name) e.name = name;
	e.classes.add(cls);
	e.sources.add(source);
}

function listFiles(dir, ext) {
	const out = [];
	if (!dir || !fs.existsSync(dir)) return out;
	const walk = (d) => {
		for (const e of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
			if (e.name.startsWith('.')) continue;
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.isFile() && e.name.endsWith(ext)) out.push(p);
		}
	};
	walk(dir);
	return out;
}

// Build the full trainer table. -> { trainers: {...json...}, report: { curated, guide, record, unverified } }
function buildTrainers({ data, guidesDir, recordingsDir }) {
	const { entries, unverified } = curatedTrainers(data);
	const counts = { curated: entries.size, guide: 0, record: 0 };

	// Guides: `train <npcId>` restricted (goal or step `only`) to exactly one class.
	for (const rel of guidesDir ? findGuideFiles(guidesDir) : []) {
		const file = path.join(guidesDir, rel);
		const ast = parseGuide(fs.readFileSync(file, 'utf8'), file, new Diagnostics());
		if (!ast) continue;
		for (const s of ast.steps) {
			for (const g of s.goals) {
				if (g.verb !== 'train' || g.npc === undefined) continue;
				const classes = (g.only && g.only.classes) || (s.only && s.only.classes) || ast.header.classes;
				if (!classes || classes.length !== 1) continue;
				const n = data.npc(g.npc);
				add(entries, g.npc, n && n.name ? n.name : g.npcName, classes[0], 'guide');
				counts.guide++;
			}
		}
	}

	// Recordings: trainer windows opened, by the character's class.
	const profession = professionNpcs(data);
	const seen = new Map(); // npc -> { name, classes:Set }
	for (const file of listFiles(recordingsDir, '.json')) {
		let rec;
		try {
			rec = JSON.parse(fs.readFileSync(file, 'utf8'));
		} catch {
			continue;
		}
		const cls = rec && rec.char && String(rec.char.class || '').toUpperCase();
		if (!CLASS_FILES.includes(cls) || !Array.isArray(rec.events)) continue;
		for (const ev of rec.events) {
			if (!ev || ev.e !== 'trainer' || !(Number(ev.npc) > 0)) continue;
			const id = Number(ev.npc);
			if (!seen.has(id)) seen.set(id, { name: ev.npcName, classes: new Set() });
			seen.get(id).classes.add(cls);
		}
	}
	for (const [id, s] of [...seen].sort((a, b) => a[0] - b[0])) {
		// Weapon masters and profession trainers open for any class; class trainers for one.
		if (s.classes.size !== 1 || profession.has(id)) continue;
		const n = data.npc(id);
		add(entries, id, n && n.name ? n.name : s.name, [...s.classes][0], 'record');
		counts.record++;
	}

	const trainers = {};
	for (const id of [...entries.keys()].sort((a, b) => a - b)) {
		const e = entries.get(id);
		trainers[id] = {
			id,
			name: e.name || null,
			classes: CLASS_FILES.filter((c) => e.classes.has(c)),
			sources: ['curated', 'guide', 'record'].filter((x) => e.sources.has(x)),
		};
	}
	return { trainers, report: { ...counts, unverified } };
}

module.exports = { CURATED, buildTrainers, curatedTrainers, professionNpcs };
