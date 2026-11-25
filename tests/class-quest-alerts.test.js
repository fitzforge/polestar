'use strict';
// Which class quest chains Polestar alerts for (#3925; Fitz, 24 Nov 2026: "a
// rule on what is worth alerting for and what's not", a hand-written list, no
// gear scoring). data/codex/class-quests.json names, for every Class guide,
// why the class quest banner (QoL/ClassQuests.lua), the level-up heads-up
// (UI/ClassToast.lua) and the class card (UI/ClassCard.lua) speak up for it:
// a spell, an ability, a mount, a key, an unlock, or an item chain on the
// hand-picked worth-it list (the Whirlwind Axe). Every other chain is
// optional: no alert, listed in the guide menu under its class's optional
// class quests with its reward named, never a leveling guide's feeder
// (engine-feeders.rs). `classquests build` writes Core/ClassQuestList.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const CQ = require('../tools/commands/classquests');

const ROOT = path.join(__dirname, '..');
const LIST = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'codex', 'class-quests.json'), 'utf8'));
const GUIDES = CQ.classGuides(path.join(ROOT, 'guides'));
const ROBE = 'forever/class/warlock/enchanted-gold-bloodrobe';
const WHIRLWIND = 'forever/class/warrior/whirlwind-weapon';

// A guide id without its folder: "enchanted-gold-bloodrobe", "alliance/paladin-warhorse".
const short = (id) => id.replace(/^forever\/(class\/[a-z]+\/|collectibles\/mounts\/)/, '');

// Per class, what is alerted and what is optional. A change here is a change to what players are told about:
// Fitz picks the worth-it list.
const PINNED = {
	DRUID: { prompted: ['aquatic-form', 'bear-form', 'cat-form', 'cure-poison'], optional: ['bloodpetal-poison'] },
	HUNTER: { prompted: ['taming-the-beast-alliance', 'taming-the-beast-horde'], optional: ['rhokdelar', 'the-hunters-charm'] },
	MAGE: {
		prompted: ['arcane-refreshment', 'celestial-orb', 'polymorph-pig', 'teleports-alliance', 'teleports-horde'],
		optional: ['astral-knot-garment', 'atiesh', 'destroy-morphaz', 'ju-ju-heaps', 'mages-wand', 'manaweave-robe', 'nether-lace-garment', 'spellfire-robes', 'staff-or-orb-alliance'],
	},
	PALADIN: {
		prompted: ['alliance/paladin-charger', 'alliance/paladin-warhorse', 'horde/paladin-warhorse', 'lumina-windsinger', 'tome-of-divinity', 'tyrs-watch', 'verigans-fist'],
		optional: ['cloak-of-the-divine-storm', 'holy-mightstone'],
	},
	PRIEST: {
		prompted: ['confounding-flash-and-contingency-plan', 'desperate-prayer-and-chastise', 'divine-grace-and-feedback', 'hex-of-weakness-and-shadowguard', 'starshards-and-elunes-grace', 'touch-of-weakness-and-dark-sacrifice'],
		optional: ['benediction', 'blood-of-morphaz', 'priest-robes-alliance', 'priest-robes-horde'],
	},
	ROGUE: {
		prompted: ['poisons-alliance', 'poisons-horde', 'ravenholdt'],
		optional: ['blade-of-cunning-alliance', 'blade-of-cunning-horde', 'certificate-of-thievery', 'plundering-the-plunderers', 'the-azure-key', 'the-eye-of-bhossca', 'the-horn-of-xelthos'],
	},
	SHAMAN: {
		prompted: ['call-of-air-alliance', 'call-of-air-horde', 'call-of-earth-alliance', 'call-of-earth-horde', 'call-of-fire-alliance', 'call-of-fire-horde', 'call-of-water-alliance', 'call-of-water-horde'],
		optional: ['darkreaver', 'spirit-totem'],
	},
	WARLOCK: {
		prompted: ['felhunter-alliance', 'felhunter-horde', 'imp-alliance', 'imp-horde', 'incubus-alliance', 'incubus-horde', 'neutral/warlock-dreadsteed', 'neutral/warlock-felsteed', 'voidwalker-alliance', 'voidwalker-horde'],
		optional: ['dread-mage-hat', 'enchanted-gold-bloodrobe', 'impsys-request', 'orb-of-orahil', 'orb-of-soranruk', 'shard-of-the-green-flame', 'tome-of-sacrifice'],
	},
	WARRIOR: { prompted: ['haggards-weapons', 'heirloom-weapon', 'whirlwind-weapon'], optional: ['brutal-armor', 'fire-hardened-armor', 'quelserrar', 'voodoo-feathers'] },
};

// The hand-picked item chains worth the trip while leveling (24 Nov 2026, from public class guides and players'
// threads, checked against our recordings): no level 60 raid chain. Verigan's Fist, Call of Air and Whirlwind
// Weapon are alerted for their spell or stance anyway; the rest are item-only, prompted as "worth".
const WORTH = [
	'forever/class/mage/celestial-orb',
	'forever/class/paladin/lumina-windsinger',
	'forever/class/paladin/verigans-fist',
	'forever/class/shaman/call-of-air-alliance',
	'forever/class/shaman/call-of-air-horde',
	WHIRLWIND,
];

test('the committed list is the one data/codex/class-quests.json and the guides build (classquests check)', () => {
	const lua = CQ.toLua(CQ.buildClassQuestList(LIST, GUIDES));
	assert.equal(fs.readFileSync(path.join(ROOT, 'addon', 'Polestar', 'Core', 'ClassQuestList.lua'), 'utf8'), lua, 'run node tools/polestar.js classquests build');
});

test('per class: the chains alerted for and the optional ones, every Class guide in one of them', () => {
	const prompt = new Map(LIST.guides.map((r) => [r.guide, r.prompt]));
	const got = {};
	for (const g of GUIDES) {
		// Its class folder (Atiesh is for four classes; it sits with the Mage's), or a class mount's name.
		const m = g.id.match(/^forever\/class\/([a-z]+)\//) || g.id.match(/\/([a-z]+)-[a-z]+$/);
		assert.ok(m, g.id);
		const cls = m[1].toUpperCase();
		assert.ok(g.classes.includes(cls), `${g.id}: for ${cls}`);
		const c = (got[cls] = got[cls] || { prompted: [], optional: [] });
		c[prompt.get(g.id) === 'optional' ? 'optional' : 'prompted'].push(short(g.id));
	}
	for (const c of Object.values(got)) for (const l of Object.values(c)) l.sort();
	assert.deepEqual(got, PINNED);
});

test('the Enchanted Gold Bloodrobe is optional; the Whirlwind Axe is alerted for and on the worth-it list', () => {
	const row = (id) => LIST.guides.find((r) => r.guide === id);
	assert.equal(row(ROBE).prompt, 'optional');
	assert.equal(row(ROBE).worth, undefined);
	assert.notEqual(row(WHIRLWIND).prompt, 'optional');
	assert.equal(row(WHIRLWIND).worth, true);
	const { prompt, optional } = CQ.buildClassQuestList(LIST, GUIDES);
	assert.equal(prompt[ROBE], 'optional');
	assert.equal(prompt[WHIRLWIND], 'ability');
	// The robe's quests are optional ones (Components for the Enchanted Gold Bloodrobe, The Completed Robe); the
	// Whirlwind chain's are not (The Islander, Whirlwind Weapon).
	for (const q of [4781, 4786]) assert.equal(optional[q], ROBE, `${q}`);
	for (const q of [1718, 1792]) assert.equal(optional[q], undefined, `${q}`);
});

test('the worth-it list: each chain with a one-line reason, no level 60 raid chain', () => {
	const worth = LIST.guides.filter((r) => r.worth);
	assert.deepEqual(worth.map((r) => r.guide).sort(), WORTH);
	for (const r of worth) assert.match(r.reason, /^[^\n]{20,200}$/, r.guide);
	assert.deepEqual(LIST.guides.filter((r) => r.prompt === 'worth').map((r) => r.guide).sort(), WORTH.filter((id) => !/verigans|call-of-air|whirlwind/.test(id)), 'an item-only chain on the list is prompted as "worth"');
	assert.equal(LIST.guides.find((r) => r.guide === 'forever/class/hunter/rhokdelar').prompt, 'optional', "Rhok'delar is a level 60 raid chain");
});

test('a quest a prompted guide also takes is never optional', () => {
	const { prompt, optional } = CQ.buildClassQuestList(LIST, GUIDES);
	for (const g of GUIDES) if (prompt[g.id] !== 'optional') for (const q of g.quests) assert.equal(optional[q], undefined, `${g.id} takes ${q}`);
});

test('the list refuses a Class guide it misses, a row for no guide, an unknown prompt, and a worth-it row without its reason', () => {
	const guides = [{ id: 'g/a', file: 'a.guide', classes: ['MAGE'], quests: [1] }];
	const ok = { guide: 'g/a', prompt: 'spell', reward: 'A spell' };
	assert.deepEqual(CQ.buildClassQuestList({ guides: [ok] }, guides), { prompt: { 'g/a': 'spell' }, optional: {} });
	assert.throws(() => CQ.buildClassQuestList({ guides: [] }, guides), /g\/a \(a\.guide\): a Class guide/);
	assert.throws(() => CQ.buildClassQuestList({ guides: [ok, { ...ok, guide: 'g/b' }] }, guides), /g\/b: listed, but no Class guide/);
	assert.throws(() => CQ.buildClassQuestList({ guides: [{ ...ok, prompt: 'gear' }] }, guides), /prompt "gear"/);
	assert.throws(() => CQ.buildClassQuestList({ guides: [{ ...ok, prompt: 'worth' }] }, guides), /worth: true and a one-line reason/);
	assert.throws(() => CQ.buildClassQuestList({ guides: [{ ...ok, prompt: 'optional', worth: true, reason: 'A fine sword.' }] }, guides), /never optional/);
	assert.throws(() => CQ.buildClassQuestList({ guides: [{ ...ok, reward: '' }] }, guides), /no reward named/);
});

// ---------------------------------------------------------------------------
// In the addon, with the shipped guides
// ---------------------------------------------------------------------------

// One character per class and side, as players start them.
const SIDES = {
	Alliance: [['WARRIOR', 'Human'], ['PALADIN', 'Human'], ['HUNTER', 'Dwarf'], ['ROGUE', 'Human'], ['PRIEST', 'Human'], ['SHAMAN', 'Dwarf'], ['MAGE', 'Human'], ['WARLOCK', 'Human'], ['DRUID', 'NightElf']],
	Horde: [['WARRIOR', 'Orc'], ['PALADIN', 'Scourge'], ['HUNTER', 'Orc'], ['ROGUE', 'Orc'], ['PRIEST', 'Troll'], ['SHAMAN', 'Orc'], ['MAGE', 'Scourge'], ['WARLOCK', 'Orc'], ['DRUID', 'Tauren']],
};

const lua = (list) => `{ ${list.map(([c, r]) => `{ "${c}", "${r}" }`).join(', ')} }`;

function shipped(faction, script) {
	const [c, r] = SIDES[faction][0];
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `local w = stub.world\nw.race, w.raceName, w.class, w.className, w.faction, w.level = "${r}", "${r}", "${c}", "${c}", "${faction}", 60`,
		addons: ['Polestar', 'Polestar_Guides', `Polestar_Guides_${faction}`],
		saved: { Polestar: 'PolestarCharDB = { schema = 1 }' },
		login: true,
		script,
	}).emitted[0];
}

// The level-up heads-up's scene per class: every chain it would tell a level 60 character of (Candidates "any",
// nothing learned or done yet), by Class guide; then the same with no list, which adds the optional chains back.
function headsUp(faction) {
	return shipped(faction, `
local CT, w = Polestar.UI.ClassToast, stub.world
local function scene(class, race)
	w.class, w.race, w.raceName = class, race, race
	Polestar.CharState().classToastSeen = nil
	local ids, seen = {}, {}
	for _, q in ipairs(CT.Candidates(60, "any")) do
		local id = CT.ClassGuide(q) or ("quest " .. q)
		if not seen[id] then seen[id] = true; ids[#ids + 1] = id end
	end
	table.sort(ids)
	return ids
end
local out = {}
for _, cr in ipairs(${lua(SIDES[faction])}) do
	local list = Polestar.ClassQuestList
	local on = scene(cr[1], cr[2])
	Polestar.ClassQuestList = nil
	local off = scene(cr[1], cr[2])
	Polestar.ClassQuestList = list
	out[cr[1]] = { on = on, off = off }
end
emit(out)`);
}

const HEADS_UP = {
	Alliance: {
		DRUID: { on: ['aquatic-form', 'bear-form', 'cat-form', 'cure-poison'], dropped: ['bloodpetal-poison'] },
		HUNTER: { on: ['taming-the-beast-alliance'], dropped: ['rhokdelar', 'the-hunters-charm'] },
		MAGE: { on: ['arcane-refreshment', 'celestial-orb', 'polymorph-pig'], dropped: ['astral-knot-garment', 'destroy-morphaz', 'mages-wand', 'manaweave-robe', 'quest 82084', 'staff-or-orb-alliance'] },
		PALADIN: { on: ['alliance/paladin-charger', 'alliance/paladin-warhorse', 'tome-of-divinity', 'verigans-fist'], dropped: ['cloak-of-the-divine-storm', 'holy-mightstone'] },
		PRIEST: { on: ['divine-grace-and-feedback'], dropped: ['benediction', 'blood-of-morphaz', 'priest-robes-alliance'] },
		ROGUE: { on: ['poisons-alliance'], dropped: ['blade-of-cunning-alliance', 'certificate-of-thievery', 'the-azure-key'] },
		SHAMAN: { on: ['call-of-air-alliance', 'call-of-fire-alliance', 'call-of-water-alliance'], dropped: [] },
		WARLOCK: {
			on: ['felhunter-alliance', 'incubus-alliance', 'neutral/warlock-dreadsteed', 'neutral/warlock-felsteed', 'voidwalker-alliance'],
			dropped: ['dread-mage-hat', 'enchanted-gold-bloodrobe', 'impsys-request', 'orb-of-orahil', 'orb-of-soranruk', 'shard-of-the-green-flame', 'tome-of-sacrifice'],
		},
		WARRIOR: { on: ['haggards-weapons', 'whirlwind-weapon'], dropped: ['fire-hardened-armor', 'voodoo-feathers'] },
	},
	Horde: {
		DRUID: { on: ['aquatic-form', 'bear-form', 'cat-form', 'cure-poison'], dropped: ['bloodpetal-poison'] },
		HUNTER: { on: ['taming-the-beast-horde'], dropped: ['rhokdelar', 'the-hunters-charm'] },
		MAGE: { on: ['arcane-refreshment', 'celestial-orb', 'polymorph-pig'], dropped: ['destroy-morphaz', 'ju-ju-heaps', 'mages-wand', 'nether-lace-garment', 'quest 82084', 'spellfire-robes'] },
		PALADIN: { on: ['horde/paladin-warhorse', 'lumina-windsinger'], dropped: [] },
		PRIEST: { on: ['hex-of-weakness-and-shadowguard'], dropped: ['benediction', 'blood-of-morphaz', 'priest-robes-horde'] },
		ROGUE: { on: ['poisons-horde'], dropped: ['blade-of-cunning-horde', 'plundering-the-plunderers', 'the-azure-key'] },
		SHAMAN: { on: ['call-of-air-horde', 'call-of-earth-horde', 'call-of-fire-horde', 'call-of-water-horde'], dropped: ['darkreaver', 'spirit-totem'] },
		WARLOCK: {
			on: ['felhunter-horde', 'incubus-horde', 'neutral/warlock-dreadsteed', 'neutral/warlock-felsteed', 'voidwalker-horde'],
			dropped: ['enchanted-gold-bloodrobe', 'impsys-request', 'orb-of-orahil', 'orb-of-soranruk', 'shard-of-the-green-flame', 'tome-of-sacrifice'],
		},
		WARRIOR: { on: ['heirloom-weapon', 'whirlwind-weapon'], dropped: ['brutal-armor', 'voodoo-feathers'] },
	},
};

for (const faction of Object.keys(SIDES)) {
	test(`the level-up heads-up per class (${faction}): spells, abilities, mounts and the worth-it chains; never an optional one`, () => {
		const out = headsUp(faction);
		const got = {};
		for (const [c, v] of Object.entries(out)) {
			const on = v.on.map(short).sort();
			got[c] = { on, dropped: v.off.map(short).filter((id) => !on.includes(id)).sort() };
			for (const id of on) assert.ok(PINNED[c].prompted.includes(id), `${faction} ${c}: ${id} is alerted for`);
			// A chain with no Class guide ("quest <id>", e.g. 82084's Personal Spellbook) drops out when it gives only an item.
			for (const id of got[c].dropped) assert.ok(PINNED[c].optional.includes(id) || /^quest \d+$/.test(id), `${faction} ${c}: only an optional chain drops out (${id})`);
		}
		assert.deepEqual(got, HEADS_UP[faction]);
	});
}

test('the class quest banner never offers the robe; it offers the Whirlwind chain; the #3845 cap still holds', () => {
	const out = shipped('Horde', `
local CQ, w = Polestar.QoL.ClassQuests, stub.world
local function ready(id)
	for _, g in ipairs(CQ.Ready()) do if g.id == id then return true end end
	return false
end
local r = {}
-- An Orc Warlock at 39: the robe's chain is open (31-38) and nothing of it is done.
w.class, w.race, w.raceName = "WARLOCK", "Orc", "Orc"
stub.world.setLevel(39); stub.advance(2)
r.robe = ready("${ROBE}")
r.robePrompted = CQ.Prompted("${ROBE}")
-- The same chain were it on the list: offered, so the list is what holds it back.
local optionalGuide = Polestar.ClassQuestList.OptionalGuide
Polestar.ClassQuestList.OptionalGuide = function(id) return id ~= "${ROBE}" and optionalGuide(id) end
r.robeIfWorth = ready("${ROBE}")
Polestar.ClassQuestList.OptionalGuide = optionalGuide
-- An Orc Warrior: the Whirlwind chain (30-40) at 38, two below its level-40 elites (ELITE_MARGIN); at 46, past
-- 40 + 5 with Berserker Stance known, the cap.
w.class, w.race, w.raceName = "WARRIOR", "Orc", "Orc"
stub.world.setLevel(38); stub.advance(2)
r.whirlwind = ready("${WHIRLWIND}")
stub.world.learnSpell(2458)
stub.world.setLevel(46); stub.advance(2)
r.whirlwindAt46 = ready("${WHIRLWIND}")
emit(r)`);
	assert.deepEqual(out, { robe: false, robePrompted: false, robeIfWorth: true, whirlwind: true, whirlwindAt46: false });
});

test('the class card: none over an optional chain\'s accept in a leveling guide, its line a row; in its own Class guide, the card', () => {
	const out = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()
stub.login()
local CC = Polestar.UI.ClassCard
local function G(t, f) f.t = t; return f end
local function accept(q, title, npc) return G("accept", { verb = "Accept", subject = title, subjectKind = "quest", quest = q, npcName = npc, map = 1413, x = 50, y = 50, status = "active" }) end
local function guide(id, category, q, title, npc)
	uistub.guides[id] = { id = id, pack = "guides", title = title, category = category, faction = "Horde", minLevel = 20, maxLevel = 40,
		zone = 1413, zoneName = "The Barrens", author = "Polestar", version = 1, steps = { { title = npc, goals = { accept(q, title, npc) } } } }
end
-- The Barrens' Warrior steps: Brutal Armor's first quest (1823, optional) and The Islander (1718, Whirlwind).
guide("test/barrens-brutal", "Leveling", 1823, "Speak with Ruga", "Sorek")
guide("test/barrens-whirlwind", "Leveling", 1718, "The Islander", "Sorek")
guide("${'forever/class/warrior/brutal-armor'}", "Class", 1823, "Speak with Ruga", "Sorek")
uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "WARRIOR", "Orc", "Horde", 30
local r = {}
for _, id in ipairs({ "test/barrens-brutal", "test/barrens-whirlwind", "forever/class/warrior/brutal-armor" }) do
	uistub.setGuide(id, 1)
	r[id] = CC.frame ~= nil and CC.frame:IsShown() or false
end
r.optional = { brutal = CC.OptionalChain(1823), islander = CC.OptionalChain(1718) }
emit(r)`,
	}).emitted[0];
	assert.deepEqual(out, {
		'test/barrens-brutal': false,
		'test/barrens-whirlwind': true,
		'forever/class/warrior/brutal-armor': true,
		optional: { brutal: true, islander: false },
	});
});

test('the guide menu lists a class\'s optional chains in a folder after its own, each naming its reward', () => {
	const out = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()
stub.login()
local P = Polestar.UI.Picker
local function class(id, title, reward)
	uistub.guides[id] = { id = id, pack = "guides", title = title, category = "Class", folder = "Mage", classes = { "MAGE" }, minLevel = 26, maxLevel = 40,
		zone = 1413, zoneName = "The Barrens", author = "Polestar", version = 1, reward = reward, steps = { { title = "A", goals = { { t = "note", text = "x" } } } } }
	table.insert(uistub.order, id)
end
class("forever/class/mage/celestial-orb", "Celestial Orb", { { item = 7515, itemName = "Celestial Orb", choice = true }, { item = 9517, itemName = "Celestial Stave", choice = true } })
class("forever/class/mage/astral-knot-garment", "Astral Knot Garment", { { item = 7511, itemName = "Astral Knot Robe", choice = true }, { item = 9516, itemName = "Astral Knot Blouse", choice = true } })
class("forever/class/mage/destroy-morphaz", "Destroy Morphaz", { { text = "Experience" } })
uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "MAGE", "Human", "Alliance", 30
local out = {}
for _, e in ipairs(P.Entries("", "Class")) do
	out[#out + 1] = e.kind == "folder" and ("[" .. e.text .. " " .. e.count .. "]") or e.guide.title
end
local G = Polestar.Guides
emit({ list = out, reward = { garment = P.OptionalReward(G.Get("forever/class/mage/astral-knot-garment")), morphaz = P.OptionalReward(G.Get("forever/class/mage/destroy-morphaz")),
	orb = P.OptionalReward(G.Get("forever/class/mage/celestial-orb")) or false } })`,
	}).emitted[0];
	assert.deepEqual(out.list, ['[Mage 1]', 'Celestial Orb', '[Mage: optional class quests 2]', 'Astral Knot Garment', 'Destroy Morphaz']);
	assert.deepEqual(out.reward, { garment: 'Astral Knot Robe or Blouse', morphaz: 'Experience', orb: false });
});
