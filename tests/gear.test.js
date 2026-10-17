'use strict';
// Polestar.Gear (addon/Polestar/Gear): item stats from ItemDB and the client,
// leveling weights, scoring and comparison across slot types, spec detection,
// the tooltip line (also on quest reward choices) and the options page.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');

const ADDON = { name: 'Polestar', files: ['Core/Core.xml', 'Gear/Gear.xml'] };

// Fixture item entries in the generated format (see tools/lib/itemdb/stats.js).
const FIXTURE = `{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
	[9003] = "1 45 40 3 4 4 str15 sta10 armor400",
	[9004] = "1 20 15 2 4 1 int10 spi5 armor30",
	[9005] = "1 35 30 2 4 4 str8 sta8 armor300",
	[9006] = "1 25 20 2 4 3 str10 sta4 armor170 crit1",
	[9010] = "11 20 15 2 4 0 sta5",
	[9011] = "11 20 15 2 4 0 sta2",
	[9012] = "11 20 15 2 4 0 sta4",
	[9013] = "11 25 20 3 4 0 sta6 uniq1",
	[9020] = "12 30 25 3 4 0 ap20",
	[9030] = "13 20 15 2 2 7 str2 dmin10 dmax20 speed2000",
	[9031] = "14 20 15 2 4 6 sta3 armor500",
	[9032] = "17 22 17 2 2 8 str10 dmin40 dmax60 speed3000",
	[9033] = "13 22 17 2 2 7 agi3 dmin12 dmax22 speed1800",
	[9040] = "16 20 15 2 4 1 sta3",
	[9050] = "7 76 60 4 4 1 sta16 int21 spi21 armor101 heal46 mpr7 cls16",
}`;

// Troll by default: a race with no gear trait (racials have their own tests).
function run(script, { cls = 'WARRIOR', className = 'Warrior', classID = 1, level = 30, race = 'Troll', raceID = 8, faction = 'Horde', before = '', login = true } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_gear.lua'],
		before: `w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "${cls}", "${className}", ${classID}, ${level}
w.race, w.raceName, w.raceID, w.faction = "${race}", "${race}", ${raceID}, "${faction}"
${before}`,
		addons: [ADDON],
		login,
		script: `G = Polestar.Gear
Polestar.ItemDB.Register({ schema = 1, build = "test" }, ${FIXTURE})
${script}`,
	}).emitted;
}

const r1 = (n) => Math.round(n * 10) / 10;

test('ItemDB parses entries: header fields, stat tokens, weapon DPS, class mask, unique, mp5 alias', () => {
	const [sword, legs, ring, missing] = run(`
		emit(Polestar.ItemDB.Get(9032)); emit(Polestar.ItemDB.Get(9050)); emit(Polestar.ItemDB.Get(9013)); emit(Polestar.ItemDB.Get(1) == nil)
	`);
	assert.deepEqual(
		{ inv: sword.inv, ilvl: sword.ilvl, req: sword.req, quality: sword.quality, class: sword.class, subclass: sword.subclass, speed: sword.speed },
		{ inv: 17, ilvl: 22, req: 17, quality: 2, class: 2, subclass: 8, speed: 3000 },
	);
	assert.deepEqual(sword.stats, { str: 10, dps: 16.7 });
	assert.deepEqual(legs.stats, { sta: 16, int: 21, spi: 21, armor: 101, heal: 46, mp5: 7 });
	assert.equal(legs.allow, 16);
	assert.equal(ring.unique, true);
	assert.equal(missing, true);
});

test('client stats win over ItemDB for base stats; ItemDB fills equip bonuses the client left out', () => {
	const [withClient, clientOnly, unknown] = run(`
		g.defineItem("item:9006", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 20,
			stats = { ITEM_MOD_STRENGTH_SHORT = 12, ITEM_MOD_STAMINA_SHORT = 4, RESISTANCE0_NAME = 170 } })
		g.defineItem("item:7777", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 2, minLevel = 10,
			stats = { ITEM_MOD_STRENGTH_SHORT = 3 } })
		emit(G.GetItemInfo("item:9006").stats)
		emit({ G.GetItemInfo("item:7777").stats, G.GetItemInfo("item:7777").inv, G.ScoreItem("item:7777") })
		emit(G.ScoreItem("item:5555") == nil)
	`);
	assert.deepEqual(withClient, { str: 12, sta: 4, armor: 170, crit: 1 });
	assert.deepEqual(clientOnly, [{ str: 3 }, 1, 3]);
	assert.equal(unknown, true);
});

test('the class weight table: nine classes, three specs each, known stat keys, sane priorities', () => {
	const [t] = run(`emit({ classes = G.CLASSES, weights = G.WEIGHTS, keys = G.STAT_KEYS, prof = G.PROFICIENCY })`);
	const keys = new Set(t.keys);
	const classes = Object.keys(t.classes).sort();
	assert.deepEqual(classes, ['DRUID', 'HUNTER', 'MAGE', 'PALADIN', 'PRIEST', 'ROGUE', 'SHAMAN', 'WARLOCK', 'WARRIOR']);
	for (const c of classes) {
		const meta = t.classes[c];
		assert.equal(meta.specs.length, 3, c);
		assert.ok(meta.specs.some((s) => s.key === meta.default), `${c} default spec`);
		assert.ok(t.prof[c], `${c} proficiencies`);
		for (const s of meta.specs) {
			const w = t.weights[c][s.key];
			assert.ok(w, `${c}.${s.key} has weights`);
			for (const [k, v] of Object.entries(w)) {
				assert.ok(keys.has(k), `${c}.${s.key}: unknown stat ${k}`);
				assert.ok(typeof v === 'number' && v >= 0, `${c}.${s.key}.${k} = ${v}`);
			}
		}
	}
	const W = t.weights;
	assert.ok(W.WARRIOR.arms.str > W.WARRIOR.arms.int || !W.WARRIOR.arms.int);
	assert.ok(W.WARRIOR.protection.sta >= W.WARRIOR.protection.str && W.WARRIOR.protection.defense > 0);
	assert.ok(W.MAGE.frost.int > (W.MAGE.frost.str || 0) && W.MAGE.frost.spFrost > 0);
	assert.ok(W.HUNTER.marksmanship.rdps > W.HUNTER.marksmanship.dps);
	assert.ok(W.PRIEST.holy.heal > W.PRIEST.holy.sp && W.PRIEST.shadow.sp > W.PRIEST.shadow.heal);
	assert.ok(!W.DRUID.feral.dps, 'feral forms ignore weapon DPS');
	assert.ok(W.ROGUE.combat.agi >= W.ROGUE.combat.str);
});

test('single slots: upgrade, downgrade, empty slot, equipped item', () => {
	const [up, down, empty, worn] = run(`
		g.equip(1, "item:9001")
		emit(G.CompareToEquipped("item:9002"))
		emit(G.CompareToEquipped("item:9004"))
		emit({ G.IsUpgrade("item:9040") })
		emit(G.CompareToEquipped("item:9001"))
	`);
	// Arms: str 1, sta 0.5, armor 0.02, spi 0.1
	assert.equal(r1(up.old), 9.5);
	assert.equal(r1(up.new), 15.4);
	assert.equal(up.slot, 1);
	assert.equal(r1(up.pct), 62.1);
	assert.equal(r1(down.new), 1.1);
	assert.ok(down.pct < 0);
	assert.deepEqual([empty[0], r1(empty[1])], [true, 1.5]); // cloak into an empty back slot: no percentage
	assert.equal(empty[2], undefined);
	assert.equal(worn.equipped, true);
});

test('rings replace the weaker ring; a unique ring only its own copy; trinkets fill an empty slot', () => {
	const [ring, unique, trinket] = run(`
		g.equip(11, "item:9010"); g.equip(12, "item:9011")
		emit(G.CompareToEquipped("item:9012"))
		g.equip(11, "item:9013:0"); g.equip(12, "item:9010")
		emit(G.CompareToEquipped("item:9013"))
		emit(G.CompareToEquipped("item:9020"))
	`);
	assert.equal(ring.slot, 12);
	assert.deepEqual([ring.old, ring.new, r1(ring.pct)], [1, 2, 100]);
	assert.equal(unique.slot, 11);
	assert.equal(unique.delta, 0);
	assert.equal(trinket.empty, true);
	assert.equal(trinket.delta, 10); // 20 attack power x 0.5
	assert.equal(trinket.pct, undefined);
});

test('a two-hander is weighed against main hand + off hand, and a one-hander against a two-hander with the best bag off-hand', () => {
	const [twoHand, upgrade, oneHand, oneHandNoBag] = run(`
		g.equip(16, "item:9030"); g.equip(17, "item:9031")
		emit(G.CompareToEquipped("item:9032"))
		emit({ G.IsUpgrade("item:9032") })
		g.equip(17, nil); g.equip(16, "item:9032"); g.bag(0, 3, "item:9031")
		emit(G.CompareToEquipped("item:9033"))
		g.bag(0, 3, nil)
		emit(G.CompareToEquipped("item:9033"))
	`);
	// MH 9030: 2 str + 7.5 dps x 7 = 54.5; shield 9031: 3 sta x 0.5 + 500 armor x 0.02 = 11.5
	assert.equal(r1(twoHand.old), 66);
	// 2H 9032: 10 str + 16.7 dps x 7 = 126.9
	assert.equal(r1(twoHand.new), 126.9);
	assert.equal(twoHand.slot, 16);
	assert.equal(upgrade[0], true);
	assert.equal(r1(upgrade[2]), 92.3);
	// 1H 9033: 3 agi x 0.6 + 9.4 dps x 7 = 67.6, plus the shield from the bags
	assert.equal(r1(oneHand.old), 126.9);
	assert.equal(r1(oneHand.new), 79.1);
	assert.equal(r1(oneHandNoBag.new), 67.6);
});

test('dual wielders try a one-hander in the off hand at half weapon DPS', () => {
	const [dw, noDw] = run(`
		Polestar.Set("gear.spec.WARRIOR", "fury")
		g.equip(16, "item:9030")
		emit(G.CompareToEquipped("item:9033"))
		w.level = 12; w.setLevel(12)
		emit(G.CompareToEquipped("item:9033"))
	`);
	// Fury: off hand empty -> 3 agi x 0.65 + 9.4 x 6.5 x 0.5 = 32.5 beats the main-hand gain (63.05 - 50.75)
	assert.equal(dw.slot, 17);
	assert.equal(dw.empty, true);
	assert.equal(r1(dw.new), 32.5);
	assert.equal(noDw.slot, 16); // no Dual Wield before level 20
	assert.equal(r1(noDw.delta), 12.3);
});

test('proficiency and level: plate waits for 40, cloth-only classes cannot wear it, class-restricted items', () => {
	const [plate, mage, priestOnly] = [
		run(`g.equip(1, "item:9001"); local up = G.IsUpgrade("item:9005"); local r = G.CompareToEquipped("item:9005")
			emit({ up = up, minLevel = r.minLevel, usable = r.usable, delta = r.delta })`)[0],
		run(`emit({ G.ScoreItem("item:9003") == nil, G.CompareToEquipped("item:9003").reason, G.IsUpgrade("item:9003") })`,
			{ cls: 'MAGE', className: 'Mage', classID: 8 })[0],
		run(`emit({ G.ScoreItem("item:9050") == nil, G.CompareToEquipped("item:9050").reason })`)[0],
	];
	assert.equal(plate.usable, true);
	assert.equal(plate.minLevel, 40);
	assert.ok(plate.delta > 0);
	assert.equal(plate.up, false);
	assert.deepEqual(mage, [true, 'armor', false]);
	assert.deepEqual(priestOnly, [true, 'class']);
	const [priest] = run(`emit(G.ScoreItem("item:9050") ~= nil)`, { cls: 'PRIEST', className: 'Priest', classID: 5, level: 60 });
	assert.equal(priest, true);
});

// #107: rogues can train swords, but only from a weapon master.
test('a weapon the class can train but the character has not learned is no upgrade until the skill is learned', () => {
	const [r] = run(`
		w.learnSkill(173, "Daggers", 1, 150)
		local before = G.CompareToEquipped("item:9030")
		local b = { up = G.IsUpgrade("item:9030"), usable = before.usable, reason = before.reason }
		w.learnSkill(43, "Swords", 1, 150)
		local after = G.CompareToEquipped("item:9030")
		emit({ before = b, after = { up = G.IsUpgrade("item:9030"), usable = after.usable, reason = after.reason } })
	`, { cls: 'ROGUE', className: 'Rogue', classID: 4 });
	assert.deepEqual(r.before, { up: false, usable: false, reason: 'skill' });
	assert.equal(r.after.usable, true);
	assert.equal(r.after.up, true);
	assert.equal(r.after.reason, undefined);
});

test('without weapon skill data the class weapon list decides, as before', () => {
	const [r] = run(`local c = G.CompareToEquipped("item:9030"); emit({ G.IsUpgrade("item:9030"), c.usable })`,
		{ cls: 'ROGUE', className: 'Rogue', classID: 4 });
	assert.deepEqual(r, [true, true]);
});

test('spec: automatic from the talent spread, the chosen primary tree, the class default before any point, a chosen spec wins', () => {
	const [none, primary, talents, chosen, back] = run(`
		emit({ G.GetSpec() })
		g.specSelection, g.primary = true, 2
		g.setSpecs({ { "Arms", 0 }, { "Fury", 0 }, { "Protection", 0 } })
		emit({ G.GetSpec() })
		g.setSpecs({ { "Arms", 5 }, { "Fury", 21 }, { "Protection", 0 } })
		g.primary = 1
		emit({ G.GetSpec() })
		Polestar.Set("gear.spec.WARRIOR", "protection")
		emit({ G.GetSpec() })
		Polestar.Set("gear.spec.WARRIOR", "auto")
		emit({ G.GetSpec() })
	`);
	assert.deepEqual(none, ['arms', 'Arms', 'default']);
	assert.deepEqual(primary, ['fury', 'Fury', 'talents']);
	assert.deepEqual(talents, ['fury', 'Fury', 'talents']);
	assert.deepEqual(chosen, ['protection', 'Protection (tank)', 'setting']);
	assert.deepEqual(back, ['fury', 'Fury', 'talents']);
});

test('tooltip line: upgrade and downgrade percentages, empty slot, later level; skipped for secret links and other tooltips', () => {
	const [up, down, empty, later, secret, shopping, off, colors] = run(`
		g.equip(1, "item:9001")
		emit(g.showTooltip(GameTooltip, "item:9002"))
		emit(g.showTooltip(GameTooltip, "item:9004"))
		emit(g.showTooltip(ItemRefTooltip, "item:9040"))
		emit(g.showTooltip(GameTooltip, "item:9005"))
		g.secret["item:9002"] = true
		emit(g.showTooltip(GameTooltip, "item:9002"))
		g.secret["item:9002"] = nil
		emit(g.showTooltip(ShoppingTooltip1, "item:9002"))
		Polestar.Set("gear.tooltip", false)
		emit(g.showTooltip(GameTooltip, "item:9002"))
		Polestar.Set("gear.tooltip", true)
		g.showTooltip(GameTooltip, "item:9002")
		local up = GameTooltip.colors[1]
		g.showTooltip(GameTooltip, "item:9004")
		emit({ up, GameTooltip.colors[1] })
	`);
	// The slot it replaces follows the gain; an empty slot needs no name.
	assert.deepEqual(up, ['Polestar · Arms | +62% upgrade · Head']);
	assert.deepEqual(down, ['Polestar · Arms | -88% downgrade · Head']);
	assert.deepEqual(empty, ['Polestar · Arms | upgrade (empty slot)']);
	assert.deepEqual(later, ['Polestar · Arms | +89% upgrade at level 40 · Head']);
	assert.deepEqual(secret, {});
	assert.deepEqual(shopping, {});
	assert.deepEqual(off, {});
	assert.ok(colors[0][1] > colors[0][0], 'upgrade is green');
	assert.ok(colors[1][0] > colors[1][1], 'downgrade is red');
});

test('tooltip line: the slot is the client\'s own word (BACKSLOT, CHESTSLOT), apart from the Back button and the boss chest', () => {
	const [back, chest] = run(
		`
		Polestar.ItemDB.Register(nil, { [9041] = "16 25 20 2 4 1 sta8", [9060] = "5 20 15 2 4 3 str5 sta3 armor200", [9061] = "5 25 20 2 4 3 str10 sta4 armor260" })
		g.equip(15, "item:9040")
		g.equip(5, "item:9060")
		emit(g.showTooltip(GameTooltip, "item:9041"))
		emit(g.showTooltip(GameTooltip, "item:9061"))
	`,
		{ before: `${fakeLocale('itIT', { Back: 'Atrás', Chest: 'Cofre', 'boss: Chest': 'Arca' })}\nBACKSLOT, CHESTSLOT = "Espalda", "Pecho"` },
	);
	assert.match(back[0], /^Polestar · Arms \| .*upgrade · Espalda$/);
	assert.match(chest[0], /^Polestar · Arms \| .*upgrade · Pecho$/);
});

test('quest reward tooltips: hovering a choice (SetQuestItem, SetQuestLogItem) shows the % upgrade line, also before its link is cached', () => {
	const [hover, log, uncached, off] = run(`
		g.equip(1, "item:9001")
		g.rewards({ "item:9004", "item:9002" })
		emit({ GameTooltip:SetQuestItem("choice", 1), GameTooltip:SetQuestItem("choice", 2) })
		emit(GameTooltip:SetQuestLogItem("choice", 2))
		g.rewards({ "item:9004", "item:9002" }, { uncached = true })
		emit(GameTooltip:SetQuestItem("choice", 2))
		Polestar.Set("gear.tooltip", false)
		emit(GameTooltip:SetQuestItem("choice", 2))
	`);
	assert.deepEqual(hover, [['Polestar · Arms | -88% downgrade · Head'], ['Polestar · Arms | +62% upgrade · Head']]);
	assert.deepEqual(log, ['Polestar · Arms | +62% upgrade · Head']);
	assert.deepEqual(uncached, ['Polestar · Arms | +62% upgrade · Head']);
	assert.deepEqual(off, {});
});

test('options: the gear advice on Questing with the class spec dropdown, registered once', () => {
	const [defs] = run(
		`
		local seen = {}
		Polestar.RegisterOptions = function(def) seen[#seen + 1] = def end
		stub.login()
		local out = {}
		for _, def in ipairs(seen) do
			local keys = {}
			for _, c in ipairs(def.controls) do keys[#keys + 1] = c.key .. "=" .. c.kind .. ":" .. (c.help and "help" or "nohelp") end
			out[#out + 1] = { page = def.page, section = def.section, keys = keys,
				choices = def.controls[2].choices and #def.controls[2].choices or 0 }
		end
		emit(out)
	`,
		{ login: false },
	);
	assert.equal(defs.length, 2);
	assert.ok(defs.every((d) => d.page === 'Questing'));
	assert.deepEqual(defs[0].keys, [
		'gear.enabled=toggle:help',
		'gear.spec.WARRIOR=dropdown:help',
		'gear.tooltip=toggle:help',
		'gear.bagArrows=toggle:help',
		'gear.rewards=toggle:help',
		'gear.pickTooltip=toggle:help',
	]);
	assert.equal(defs[0].choices, 4); // Automatic + three warrior specs
	assert.deepEqual(defs[1].keys, ['gear.minUpgrade=slider:help', 'gear.useBags=toggle:help']);
});

test('gains read in whole percents, and in words past doubling', () => {
	const [out] = run(`
		local G = Polestar.Gear
		local function t(p) local s, big = G.GainText(p); return { s, big } end
		emit({ t(62.14), t(-88.4), t(0.2), t(-0.3), t(99.4), t(100), t(625) })`);
	assert.deepEqual(out, [['+62%', false], ['-88%', false], ['+<1%', false], ['-<1%', false], ['+99%', false], ['big upgrade', true], ['big upgrade', true]]);
});
