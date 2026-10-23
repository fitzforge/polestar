'use strict';
// Pawn scale import (addon/Polestar/Gear/Pawn.lua, PawnStats.lua): the string
// parser, the stat mapping, the saved scales and how a chosen scale scores.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ADDON = { name: 'Polestar', files: ['Core/Core.xml', 'Gear/Gear.xml'] };

const FIXTURE = `{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
}`;

function run(script, { cls = 'WARRIOR', className = 'Warrior', classID = 1, level = 30 } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_gear.lua'],
		before: `w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "${cls}", "${className}", ${classID}, ${level}
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde"`,
		addons: [ADDON],
		login: true,
		script: `G = Polestar.Gear
Polestar.ItemDB.Register({ schema = 1, build = "test" }, ${FIXTURE})
${script}`,
	}).emitted;
}

// The parser's result for one string: { name, stats, order, meta, skipped } or { err }.
function parse(str) {
	const [r] = run(`
		local p, err = G.Pawn.Parse(${JSON.stringify(str)})
		if not p then emit({ err = err }) else emit({ name = p.name or false, stats = p.stats, order = p.order, meta = p.meta, skipped = p.skipped }) end
	`);
	return r;
}

test('parses a standard string: name, metadata apart from stats', () => {
	const r = parse('( Pawn: v1: "Warrior: Arms": Class=Warrior, Spec=1, Strength=2.0, Agility=1.1, Stamina=0.5 )');
	assert.equal(r.name, 'Warrior: Arms');
	assert.deepEqual(r.stats, { Strength: 2, Agility: 1.1, Stamina: 0.5 });
	assert.deepEqual(r.order, ['Strength', 'Agility', 'Stamina']);
	assert.deepEqual(r.meta, { Class: 'Warrior', Spec: 1 });
});

test('tolerates spaces, no parentheses, no version, single quotes, case', () => {
	for (const s of [
		'(Pawn:v1:"X":Strength=1,Agility=2)',
		'  (  pawn :  V1 :  "X"  :  Strength = 1 ,  Agility =  2  )  ',
		'Pawn: v1: "X": Strength=1, Agility=2',
		'( Pawn: "X": Strength=1, Agility=2 )',
		"( Pawn: v1: 'X': Strength=1, Agility=2 )",
	]) {
		const r = parse(s);
		assert.equal(r.name, 'X', s);
		assert.deepEqual(r.stats, { Strength: 1, Agility: 2 }, s);
	}
});

test('numbers: 1, 1.5, .5, 1., negatives and a plus sign', () => {
	const r = parse('( Pawn: v1: "N": A=1, B=1.5, C=.5, D=-2, E=-.25, F=+3, G=1. , H=0 )');
	assert.deepEqual(r.stats, { A: 1, B: 1.5, C: 0.5, D: -2, E: -0.25, F: 3, G: 1, H: 0 });
});

test('a missing name parses with none; hex and words are not numbers', () => {
	let r = parse('( Pawn: v1: Strength=1 )');
	assert.equal(r.name, false);
	assert.deepEqual(r.stats, { Strength: 1 });
	r = parse('( Pawn: v1: "N": Strength=0x10, Agility=two, Stamina=1 )');
	assert.deepEqual(r.stats, { Stamina: 1 });
	assert.equal(r.meta.Strength, '0x10');
});

test('a number so long it reads as infinity is no weight, in a string or typed in the details', () => {
	const big = '9'.repeat(400);
	const r = parse(`( Pawn: v1: "N": Strength=${big}, Agility=-${big}, Stamina=1 )`);
	assert.deepEqual(r.stats, { Stamina: 1 });
	const [out] = run(`
		local _, res = G.Scales.Import('( Pawn: v1: "T": Class=Warrior, Strength=2 )')
		local ok, err = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", "${big}")
		local okInf, errInf = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", math.huge)
		local okNan = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", 0 / 0)
		emit({ ok = ok, err = err, okInf = okInf, errInf = errInf, okNan = okNan, str = res.scale.weights.str, number = G.Pawn.Number("${big}") or false })
	`);
	assert.deepEqual(out, { ok: false, err: 'number', okInf: false, errInf: 'number', okNan: false, str: 2, number: false });
});

test("Pawn's X marker skips a stat; a repeated key keeps its last value", () => {
	const r = parse('( Pawn: v1: "N": Strength=1, Agility=X, Strength=3 )');
	assert.deepEqual(r.stats, { Strength: 3 });
	assert.deepEqual(r.skipped, ['Agility']);
	assert.deepEqual(r.order, ['Strength']);
});

test('refuses garbage, empty text, a newer version, a string with no stats', () => {
	assert.equal(parse('').err, 'empty');
	assert.equal(parse('   ').err, 'empty');
	assert.equal(parse('Strength=1, Agility=2').err, 'notpawn');
	assert.equal(parse('hello world').err, 'notpawn');
	assert.equal(parse('( Pawn: v2: "N": Strength=1 )').err, 'version');
	assert.equal(parse('( Pawn: v1: "N": Class=Warrior )').err, 'nostats');
	assert.equal(parse('( Pawn: v1: "N": )').err, 'nostats');
	assert.equal(parse('( Pawn: v1: "N": ' + 'Strength=1,'.repeat(1000) + ' )').err, 'toolong');
});

test('a long paste of mostly spaces is refused at once, not after seconds of trimming', () => {
	const [r] = run(`
		local t0 = os.clock()
		local _, long = G.Pawn.Parse("x" .. string.rep(" ", 100000) .. "x")
		local _, gap = G.Pawn.Parse("( Pawn: v1: Strength=1" .. string.rep(" ", 5900) .. ", Agility=2 )")
		emit({ long = long, gap = gap or false, secs = os.clock() - t0 })
	`);
	assert.equal(r.long, 'toolong');
	assert.equal(r.gap, false);
	assert.ok(r.secs < 0.2, `took ${r.secs}s`);
});

function weights(str) {
	const [r] = run(`
		local p = G.Pawn.Parse(${JSON.stringify(str)})
		local w, mapped, ignored = G.Pawn.Weights(p)
		emit({ w = w, mapped = mapped, ignored = ignored })
	`);
	return r;
}

test('stat mapping: names to Polestar keys, case-insensitive', () => {
	const r = weights('( Pawn: v1: "N": strength=1, AGILITY=2, Stamina=3, Intellect=4, Spirit=5, Armor=6, Health=7, Mana=8, Hp5=9, Mp5=10, Ap=11, Rap=12, ' +
		'SpellDamage=13, ArcaneSpellDamage=14, FireSpellDamage=15, FrostSpellDamage=16, HolySpellDamage=17, NatureSpellDamage=18, ShadowSpellDamage=19, Healing=20, ' +
		'CritRating=21, HitRating=22, SpellCritRating=23, SpellHitRating=24, DefenseRating=25, DodgeRating=26, ParryRating=27, BlockRating=28, BlockValue=29 )');
	assert.deepEqual(r.w, {
		str: 1, agi: 2, sta: 3, int: 4, spi: 5, armor: 6, health: 7, mana: 8, hp5: 9, mp5: 10, ap: 11, rap: 12,
		sp: 13, spArcane: 14, spFire: 15, spFrost: 16, spHoly: 17, spNature: 18, spShadow: 19, heal: 20,
		crit: 21, hit: 22, spellCrit: 23, spellHit: 24, defense: 25, dodge: 26, parry: 27, block: 28, blockValue: 29,
	});
	assert.equal(r.mapped, 29);
	assert.equal(Object.keys(r.ignored).length, 0);
});

test('Dps covers both weapon slots until MeleeDps or RangedDps say otherwise', () => {
	assert.deepEqual(weights('( Pawn: v1: "N": Dps=5 )').w, { dps: 5, rdps: 5 });
	assert.deepEqual(weights('( Pawn: v1: "N": Dps=5, RangedDps=1 )').w, { dps: 5, rdps: 1 });
	assert.deepEqual(weights('( Pawn: v1: "N": RangedDps=1, MeleeDps=7, Dps=5 )').w, { dps: 7, rdps: 1 });
});

test('unmapped Pawn stats are ignored and named, in order', () => {
	const r = weights('( Pawn: v1: "N": Strength=1, FireResist=2, Speed=3, IsMace=1, HasteRating=4, Agility=X, FeralAp=1 )');
	assert.deepEqual(r.w, { str: 1 });
	assert.equal(r.mapped, 1);
	assert.deepEqual(r.ignored, ['FireResist', 'Speed', 'IsMace', 'HasteRating', 'FeralAp', 'Agility']);
});

test('import stores a scale per class; the same name updates it', () => {
	const [first, second, list, other] = run(`
		local ok, res = G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Resist=1 )')
		emit({ ok = ok, name = res.scale.name, class = res.class, mapped = res.mapped, ignored = res.ignored, updated = res.updated, summary = G.Scales.Summary(res), id = res.scale.id })
		local ok2, res2 = G.Scales.Import('( Pawn: v1: "tank": Strength=3 )', "WARRIOR")
		emit({ ok = ok2, updated = res2.updated, id = res2.scale.id, str = res2.scale.weights.str })
		emit(#G.Scales.List("WARRIOR"))
		emit(#G.Scales.List("MAGE"))
	`);
	assert.equal(first.ok, true);
	assert.equal(first.name, 'Tank');
	assert.equal(first.class, 'WARRIOR');
	assert.equal(first.mapped, 1);
	assert.deepEqual(first.ignored, ['Resist']);
	assert.equal(first.updated, false);
	assert.equal(first.summary, "Imported 'Tank': 1 stats, 1 ignored: Resist");
	assert.deepEqual(second, { ok: true, updated: true, id: first.id, str: 3 });
	assert.equal(list, 1);
	assert.equal(other, 0);
});

test('a string naming another class is kept for that class; unknown classes and numeric ids', () => {
	const [mage, bad, byId] = run(`
		local _, a = G.Scales.Import('( Pawn: v1: "Frost": Class=Mage, SpellDamage=1 )')
		emit(a.class)
		emit({ G.Scales.Import('( Pawn: v1: "K": Class=DeathKnight, Strength=1 )') })
		local _, c = G.Scales.Import('( Pawn: v1: "P": Class=2, Strength=1 )')
		emit(c.class)
	`);
	assert.equal(mage, 'MAGE');
	assert.deepEqual(bad, [false, 'class']);
	assert.equal(byId, 'PALADIN');
});

test('a string with no name gets a numbered default; errors come back as text', () => {
	const [a, b, err] = run(`
		local _, x = G.Scales.Import('( Pawn: v1: Strength=1 )', "WARRIOR")
		local _, y = G.Scales.Import('( Pawn: v1: Strength=2 )', "WARRIOR")
		emit(x.scale.name); emit(y.scale.name)
		emit(G.Scales.ErrorText("notpawn"))
	`);
	assert.equal(a, 'Pawn scale');
	assert.equal(b, 'Pawn scale 2');
	assert.match(err, /not a Pawn string/);
});

test('names lose chat escapes and are cut; rename refuses empty and taken names', () => {
	const [name, empty, taken, ok, renamed, gone] = run(`
		local _, x = G.Scales.Import('( Pawn: v1: "|cffff0000Red|r ${'x'.repeat(60)}": Strength=1 )', "WARRIOR")
		local _, y = G.Scales.Import('( Pawn: v1: "Other": Strength=1 )', "WARRIOR")
		emit(x.scale.name)
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "  ") })
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "other") })
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "Fresh") })
		emit(G.Scales.Get("WARRIOR", x.scale.id).name)
		emit({ G.Scales.Rename("WARRIOR", "nope", "Z") })
	`);
	assert.ok(name.length <= 40);
	assert.ok(!name.includes('|'));
	assert.deepEqual(empty, [false, 'name']);
	assert.deepEqual(taken, [false, 'taken']);
	assert.deepEqual(ok, [true]);
	assert.equal(renamed, 'Fresh');
	assert.deepEqual(gone, [false, 'gone']);
});

test('export returns the string as imported; a class holds at most 20 scales', () => {
	const [out, full] = run(`
		local s = '( Pawn: v1: "E": Strength=1 )'
		local _, r = G.Scales.Import(s, "WARRIOR")
		emit(G.Scales.Export("WARRIOR", r.scale.id) == s)
		local last
		for i = 1, 25 do last = { G.Scales.Import('( Pawn: v1: "S' .. i .. '": Strength=1 )', "WARRIOR") } end
		emit({ last[1], last[2], #G.Scales.List("WARRIOR") })
	`);
	assert.equal(out, true);
	assert.deepEqual(full, [false, 'full', 20]);
});

const HEAD = `g.defineItem("item:9001", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 15, stats = { ITEM_MOD_STRENGTH_SHORT = 5, ITEM_MOD_STAMINA_SHORT = 3 } })`;

test('a chosen custom scale replaces the built-in weights and reports source "custom"', () => {
	const [before, after, score, builtin, deleted] = run(`
		${HEAD}
		emit({ G.GetSpec() })
		local _, r = G.Scales.Import('( Pawn: v1: "Mine": Strength=10, Stamina=1 )', "WARRIOR")
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
		emit({ G.GetSpec() })
		emit({ G.ScoreItem("item:9001"), G.GetWeightsInfo().source, G.GetWeights().str })
		Polestar.Set("gear.spec.WARRIOR", "arms")
		emit(G.ScoreItem("item:9001") ~= 53)
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
		G.Scales.Delete("WARRIOR", r.scale.id)
		emit({ G.GetSpec() })
	`);
	assert.notEqual(before[2], 'custom');
	assert.ok(after[0].startsWith('custom:'));
	assert.equal(after[1], 'Custom: Mine');
	assert.equal(after[2], 'custom');
	assert.deepEqual(score, [53, 'custom', 10]);
	assert.equal(builtin, true);
	assert.notEqual(deleted[2], 'custom', 'deleting the chosen scale goes back to Automatic');
});

test('a scale in another size scores in proportion, so upgrade percents match', () => {
	const [a, b] = run(`
		${HEAD}
		local function score(str)
			local _, r = G.Scales.Import(str, "WARRIOR")
			Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
			return G.CompareToEquipped("item:9001").score
		end
		emit(score('( Pawn: v1: "A": Strength=1, Stamina=0.5 )') * 10)
		emit(score('( Pawn: v1: "B": Strength=10, Stamina=5 )'))
	`);
	assert.equal(a, b);
});

test('/polestar gear import <string> imports for your class', () => {
	const [n] = run(`
		SlashCmdList.POLESTAR('gear import ( Pawn: v1: "Cmd": Strength=1 )')
		emit(#G.Scales.List("WARRIOR"))
	`);
	assert.equal(n, 1);
});

// The windows (UI/GearScales.lua), over the UI stub with the Gear module.
function runUI(script) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_world.lua', 'stub_gear.lua'],
		before: 'w = stub.world; w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30',
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'UI/UI.xml'] }],
		login: true,
		script,
	}).emitted;
}

test('rename, import and delete refresh the options rows, so the dropdown shows the new name at once', () => {
	const [calls] = runUI(`
		local G = Polestar.Gear
		local n = 0
		local real = Polestar.Widgets.RefreshAll
		Polestar.Widgets.RefreshAll = function() n = n + 1; return real() end
		local _, r = G.Scales.Import('( Pawn: v1: "A": Strength=1 )', "WARRIOR")
		local afterImport = n
		G.Scales.Rename("WARRIOR", r.scale.id, "B")
		local afterRename = n
		G.Scales.Delete("WARRIOR", r.scale.id)
		emit({ afterImport, afterRename, n })
	`);
	assert.deepEqual(calls, [1, 2, 3]);
});

// What the manager window's rows say, as plain data.
const ROWS = `
local function shown()
	local out = {}
	for _, row in ipairs(Polestar.UI.ScalesView.rows) do
		if row:IsShown() then
			out[#out + 1] = { title = row.Title:GetText(), meta = row.Meta:GetText(), tag = row.Tag:GetText(),
				use = row.Use:IsShown() and row.Use.Label:GetText() or false, body = row.Body:IsShown() and row.Body:GetText() or false,
				reset = row.Reset:IsShown(), lines = {} }
			for _, line in ipairs(row.Lines) do
				if line:IsShown() then out[#out].lines[#out[#out].lines + 1] = line.Label:GetText() .. "=" .. line.Box:GetText() end
			end
		end
	end
	return out
end`;

test('scales keep the Pawn stats they left out, and All lists every class, the player\'s first', () => {
	const [list, ignored] = runUI(`
		local G = Polestar.Gear
		G.Scales.Import('( Pawn: v1: "M": Class=Mage, SpellDamage=1, FireResist=1 )')
		G.Scales.Import('( Pawn: v1: "Z": Class=Warrior, Strength=1 )')
		G.Scales.Import('( Pawn: v1: "A": Class=Warrior, Strength=1, Speed=2 )')
		local names = {}
		for _, e in ipairs(G.Scales.All("WARRIOR")) do names[#names + 1] = e.class .. ":" .. e.scale.name end
		emit(names)
		emit(G.Scales.All("WARRIOR")[2].scale.ignored)
	`);
	assert.deepEqual(list, ['WARRIOR:Z', 'WARRIOR:A', 'MAGE:M']);
	assert.deepEqual(ignored, ['Speed'], 'A left Speed out');
});

test('the manager window: import chooses the scale and lists it; a bad string says why and adds nothing', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local V = UI.ScalesView.frame
		V.Paste:SetText("not a pawn string")
		V.Ok:Click()
		local bad = { V.Status:GetText(), #shown() }
		V.Paste:SetText('( Pawn: v1: "Tank": Class=Warrior, Strength=2, FireResist=1 )')
		V.Ok:Click()
		emit({ bad = bad, good = V.Status:GetText(), spec = { G.GetSpec() }, box = V.Paste:GetText(), rows = shown() })
	`);
	assert.match(out.bad[0], /not a Pawn string/);
	assert.equal(out.bad[1], 0);
	assert.equal(out.good, "Imported 'Tank': 1 stats, 1 ignored: FireResist");
	assert.equal(out.spec[2], 'custom');
	assert.equal(out.box, '');
	assert.equal(out.rows.length, 1);
	assert.equal(out.rows[0].title, 'Tank');
	assert.equal(out.rows[0].tag, 'In use');
	assert.equal(out.rows[0].use, 'Stop using');
});

test('the manager window lists every class; Use is only for your class, and a scale for another class can be deleted from here', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Mine": Class=Warrior, Strength=1 )')
		G.Scales.Import('( Pawn: v1: "Theirs": Class=Druid, Agility=1 )')
		UI.ShowScales()
		local before = shown()
		local rows = UI.ScalesView.rows
		-- the Druid row's Use is hidden; delete it (two clicks: the confirm)
		rows[2].Delete:Click(); rows[2].Delete:Click()
		emit({ before = before, after = shown(), druids = #G.Scales.List("DRUID") })
	`);
	assert.equal(out.before.length, 2);
	assert.equal(out.before[0].title, 'Mine');
	assert.equal(out.before[0].use, 'Use');
	assert.equal(out.before[1].title, 'Theirs');
	assert.equal(out.before[1].use, false);
	assert.equal(out.druids, 0);
	assert.equal(out.after.length, 1);
});

test('the manager window: Use and Stop using switch the weights; Details shows what the scale kept and left out', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1, Dps=3 )')
		UI.ShowScales()
		local row = UI.ScalesView.rows[1]
		local off = { G.GetSpec() }
		row.Use:Click()
		local on = { G.GetSpec() }
		row.Use:Click()
		local back = { G.GetSpec() }
		row.Details:Click()
		emit({ off = off[3], on = on[3], back = back[3], row = shown()[1] })
	`);
	assert.notEqual(out.off, 'custom');
	assert.equal(out.on, 'custom');
	assert.equal(out.back, out.off);
	assert.deepEqual(out.row.lines, ['Strength=2', 'Stamina=0.5', 'Weapon DPS (melee)=3', 'Weapon DPS (ranged)=3']);
	assert.equal(out.row.body, 'Ignored: FireResist');
	assert.equal(out.row.reset, false);
});

test('the manager window: Rename takes the name through the box, refuses an empty one, and the list shows it', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Old": Class=Warrior, Strength=1 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		UI.ScalesView.rows[1].Rename:Click()
		local prefilled = V.Name:GetText()
		V.Name:SetText("")
		V.Ok:Click()
		local refused = V.Status:GetText()
		V.Name:SetText("New")
		V.Ok:Click()
		emit({ prefilled = prefilled, refused = refused, title = shown()[1].title, backToImport = V.Paste:IsShown() })
	`);
	assert.equal(out.prefilled, 'Old');
	assert.equal(out.refused, 'Give the scale a name.');
	assert.equal(out.title, 'New');
	assert.equal(out.backToImport, true);
});

test('/polestar gear import and gear scales open the manager', () => {
	const [out] = runUI(`
		SlashCmdList.POLESTAR("gear scales")
		local first = PolestarScales:IsShown()
		PolestarScales:Hide()
		SlashCmdList.POLESTAR("gear import")
		emit({ first, PolestarScales:IsShown() })
	`);
	assert.deepEqual(out, [true, true]);
});

const OPEN = `
local UI, G = Polestar.UI, Polestar.Gear
local _, r = G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1 )')
Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
UI.ShowScales()
local row = UI.ScalesView.rows[1]
row.Details:Click()
local function line(name)
	for _, l in ipairs(row.Lines) do if l:IsShown() and l.Label:GetText() == name then return l end end
end
local function type_(l, text) l.Box:SetFocus(); l.Box:SetText(text); l.Box:GetScript("OnEnterPressed")(l.Box); l.Box:GetScript("OnEditFocusLost")(l.Box) end`;

test('editing a weight in the details: it applies at once, marks the scale edited, rebuilds the export string and offers a reset', () => {
	const [out] = runUI(`${ROWS}${OPEN}
		type_(line("Strength"), "5")
		local w = G.GetWeights()
		emit({ str = w.str, edited = r.scale.edited, source = G.Scales.Export("WARRIOR", r.scale.id), original = r.scale.original,
			row = shown()[1] })
	`);
	assert.equal(out.str, 5);
	assert.equal(out.edited, true);
	assert.equal(out.source, '( Pawn: v1: "Tank": Class=Warrior, Stamina=0.5, Strength=5 )');
	assert.equal(out.original, '( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1 )');
	assert.equal(out.row.reset, true);
	assert.match(out.row.body, /Edited/);
	assert.ok(out.row.lines.includes('Strength=5'));
});

test('editing: text that is not a number puts the old value back; removing a weight drops its line; Reset returns to the string as imported', () => {
	const [out] = runUI(`${ROWS}${OPEN}
		type_(line("Strength"), "lots")
		local keptWeight, keptBox = G.GetWeights().str, line("Strength").Box:GetText()
		line("Stamina").Remove:Click()
		local staAfter, staLine = G.GetWeights().sta, line("Stamina")
		type_(line("Strength"), "9")
		local nine = G.GetWeights().str
		row.Reset:Click()
		emit({ keptWeight = keptWeight, keptBox = keptBox, staGone = staAfter == nil, lineGone = staLine == nil, nine = nine,
			str = G.GetWeights().str, sta = G.GetWeights().sta, edited = r.scale.edited or false, ignored = shown()[1].body })
	`);
	assert.equal(out.keptWeight, 2);
	assert.equal(out.keptBox, '2');
	assert.equal(out.staGone, true);
	assert.equal(out.lineGone, true);
	assert.equal(out.nine, 9);
	assert.equal(out.str, 2, 'Reset: the imported Strength');
	assert.equal(out.sta, 0.5, 'Reset: the removed Stamina is back');
	assert.equal(out.edited, false);
	assert.equal(out.ignored, 'Ignored: FireResist');
});

test('SetWeight refuses a stat Polestar does not score and a value that is not a number; a string number is read as one', () => {
	const [badStat, badNumber, stringNumber, gone, value] = runUI(`
		local G = Polestar.Gear
		local _, r = G.Scales.Import('( Pawn: v1: "T": Class=Warrior, Strength=2 )')
		local id = r.scale.id
		emit({ G.Scales.SetWeight("WARRIOR", id, "nonsense", 1) })
		emit({ G.Scales.SetWeight("WARRIOR", id, "str", "x") })
		emit({ G.Scales.SetWeight("WARRIOR", id, "str", " -1.5 ") })
		emit({ G.Scales.SetWeight("WARRIOR", "nope", "str", 1) })
		emit(G.Scales.Get("WARRIOR", id).weights.str)
	`);
	assert.deepEqual(badStat, [false, 'stat']);
	assert.deepEqual(badNumber, [false, 'number']);
	assert.deepEqual(stringNumber, [true]);
	assert.deepEqual(gone, [false, 'gone']);
	assert.equal(value, -1.5);
});

test('Pawn.Build writes a string Parse and Weights read back to the same weights', () => {
	const [out] = run(`
		local w = { str = 1, agi = 0.65, sta = 0.5, dps = 6.5, rdps = 0.5, crit = 11, spFire = 0.25, blockValue = 0.05 }
		local s = G.Pawn.Build('A "quoted" name', "WARRIOR", w)
		local p = G.Pawn.Parse(s)
		local back = G.Pawn.Weights(p)
		local same = true
		for k, v in pairs(w) do if back[k] ~= v then same = false end end
		emit({ s = s, same = same, name = p.name })
	`);
	assert.equal(out.same, true);
	assert.equal(out.name, "A 'quoted' name");
	assert.match(out.s, /^\( Pawn: v1: "A 'quoted' name": Class=Warrior, /);
});

test('Pawn.Build rounds positive and negative weights to the nearest thousandth, with ties away from zero', () => {
	const cases = [
		[0, 0], [1, 1], [-1, -1], [0.1, 0.1], [-0.1, -0.1],
		[1.234, 1.234], [-1.234, -1.234],
		[1.2344, 1.234], [-1.2344, -1.234],
		[1.2345, 1.235], [-1.2345, -1.235],
		[1.2346, 1.235], [-1.2346, -1.235],
		[0.0004, 0], [-0.0004, 0],
		[0.0005, 0.001], [-0.0005, -0.001],
		[0.0006, 0.001], [-0.0006, -0.001],
	];
	const [weights] = run(`
		local out = {}
		for _, value in ipairs({ ${cases.map(([value]) => value).join(', ')} }) do
			local source = G.Pawn.Build("Rounded", "WARRIOR", { str = value })
			local parsed = assert(G.Pawn.Parse(source))
			out[#out + 1] = G.Pawn.Weights(parsed).str
		end
		emit(out)
	`);
	for (let i = 0; i < cases.length; i++) {
		assert.equal(weights[i], cases[i][1], `weight ${cases[i][0]}`);
	}
});

test('editing a scale preserves negative weights through repeated export and import', () => {
	const rounds = run(`
		local _, r = G.Scales.Import('( Pawn: v1: "Penalties": Class=Warrior, Strength=-1, Agility=-0.1, Stamina=-1.234, CritRating=0 )')
		for i = 1, 3 do
			-- Changing another stat rebuilds the whole export string.
			assert(G.Scales.SetWeight("WARRIOR", r.scale.id, "dps", i))
			local source = G.Scales.Export("WARRIOR", r.scale.id)
			local ok, imported = G.Scales.Import(source)
			assert(ok)
			r = imported
			emit(r.scale.weights)
		end
	`);
	assert.deepEqual(rounds, [1, 2, 3].map((dps) => ({ str: -1, agi: -0.1, sta: -1.234, crit: 0, dps })));
});

test('removing a stat keeps the other negative weights in the exported scale', () => {
	const [weights] = run(`
		local _, r = G.Scales.Import('( Pawn: v1: "Penalties": Class=Warrior, Strength=-1, Agility=-0.1, Stamina=2 )')
		assert(G.Scales.RemoveWeight("WARRIOR", r.scale.id, "sta"))
		local ok, imported = G.Scales.Import(G.Scales.Export("WARRIOR", r.scale.id))
		assert(ok)
		emit(imported.scale.weights)
	`);
	assert.deepEqual(weights, { str: -1, agi: -0.1 });
});

test('Copy a built-in spec: a new scale holds that spec\'s weights at your level, named as a copy, ready to edit', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local ok, res = G.Scales.CopyBuiltin("WARRIOR", "arms")
		local builtin = G.WeightsFor("WARRIOR", "arms", G.GetPlayer().level)
		local same = true
		for k, v in pairs(builtin) do if res.scale.weights[k] ~= v then same = false end end
		local ok2, res2 = G.Scales.CopyBuiltin("WARRIOR", "arms")
		emit({ ok = ok, name = res.scale.name, same = same, edited = res.scale.edited or false, second = res2.scale.name })
		G.Scales.SetWeight("WARRIOR", res.scale.id, "dps", 9)
		emit({ builtinDps = G.WeightsFor("WARRIOR", "arms", G.GetPlayer().level).dps, copyDps = res.scale.weights.dps })
	`);
	assert.equal(out.ok, true);
	assert.equal(out.name, 'Arms (copy)');
	assert.equal(out.same, true);
	assert.equal(out.edited, false);
	assert.equal(out.second, 'Arms (copy) 2');
});

test('the Copy a built-in spec button lists your class\'s specs and opens the new scale\'s details', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local items
		Polestar.Widgets.ShowMenu = function(anchor, list) items = list end
		UI.ScalesView.frame.Copy:Click()
		local names = {}
		for _, it in ipairs(items) do names[#names + 1] = it.text end
		items[3].onClick()
		emit({ names = names, rows = #shown(), lines = #shown()[1].lines > 0, status = UI.ScalesView.frame.Status:GetText() })
	`);
	assert.deepEqual(out.names, ['Arms', 'Fury', 'Protection (tank)']);
	assert.equal(out.rows, 1);
	assert.equal(out.lines, true);
	assert.match(out.status, /Copied Protection \(tank\) \(copy\)/);
});

test('the window can be resized by its grip: bounds, the corner anchor kept, the list following the width, the size remembered', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		local before = { V:GetWidth(), V:GetHeight(), UI.ScalesView.rows[1]:GetWidth() }
		V.Grip:GetScript("OnMouseDown")(V.Grip)
		local sizing = V.sizing
		V:SetSize(800, 720)
		V:GetScript("OnSizeChanged")(V, 800, 720)
		V.Grip:GetScript("OnMouseUp")(V.Grip)
		local row = UI.ScalesView.rows[1]
		emit({ resizable = V:IsResizable(), bounds = V.resizeBounds, sizing = sizing, stopped = V.sizing == false, before = before,
			after = { V:GetWidth(), V:GetHeight(), row:GetWidth() }, saved = Polestar.DB().gearScalesWindow })
	`);
	assert.equal(out.resizable, true);
	assert.deepEqual(out.bounds, [480, 460, 1100, 1400]);
	assert.equal(out.sizing, true, 'the grip starts sizing');
	assert.equal(out.stopped, true, 'letting go stops it');
	assert.deepEqual(out.before, [560, 640, 560 - 48 - 12]);
	assert.deepEqual(out.after, [800, 720, 800 - 48 - 12], 'the rows are as wide as the list now');
	assert.deepEqual(out.saved, { w: 800, h: 720 });
});

test('the window opens at the size it was left at, inside the limits', () => {
	const sizes = (saved) => runUI(`
		local UI = Polestar.UI
		Polestar.DB().gearScalesWindow = ${saved}
		UI.ShowScales()
		emit({ UI.ScalesView.frame:GetSize() })
	`)[0];
	assert.deepEqual(sizes('{ w = 700, h = 600 }'), [700, 600]);
	assert.deepEqual(sizes('{ w = 100, h = 100 }'), [480, 460], 'never smaller than the least');
	assert.deepEqual(sizes('{ w = 5000, h = 5000 }'), [1100, 1060], 'nor bigger than the limit or the screen');
	assert.deepEqual(sizes('"junk"'), [560, 640], 'a bad value is the default');
});

test('the input area keeps its height while a scale is renamed, so the list stays where it is', () => {
	const [out] = runUI(`${ROWS}
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Old": Class=Warrior, Strength=1 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		local importing = { V.Input:GetHeight(), V.Paste:IsShown(), V.Name:IsShown() }
		UI.ScalesView.rows[1].Rename:Click()
		emit({ importing = importing, renaming = { V.Input:GetHeight(), V.Paste:IsShown(), V.Name:IsShown() } })
	`);
	assert.deepEqual(out.importing, [80, true, false]);
	assert.deepEqual(out.renaming, [80, false, true]);
});
