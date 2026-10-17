'use strict';
// Blizzard DB2 rows (tables.js) + reference data -> professions.json
// (schema: docs/ARCHITECTURE.md, Toolchain -> Reference data).
//
// What the client tables give, and what they do not:
//   - A recipe is a SkillLineAbility row of a profession skill line whose spell
//     creates an item (SpellEffect 24) or enchants one (SpellEffect 53).
//   - yellow = TrivialSkillLineRankLow, grey = TrivialSkillLineRankHigh, and
//     green = floor((yellow + grey) / 2), the client's own formula.
//   - The orange threshold (the skill a trainer asks for) is trainer data on
//     the server and is not in the client. Recipe items carry it
//     (ItemSparse.RequiredSkillRank); recipes known with the skill
//     (AcquireMethod 1) are 1. For other trainer recipes it is estimated as
//     yellow (marked learnedAtEstimated): Classic trainers teach many utility
//     recipes only at their yellow skill (Iron Buckle 150, Heavy Blasting
//     Powder 125, Bolt of Mageweave 175, Cured Thick Hide 200 where yellow =
//     grey), and every known real value is at or below yellow, so a guide
//     never sends the player to learn a recipe the trainer does not offer yet.
//   - AcquireMethod 3 is a spell nobody learns: Forever retired Alchemy's
//     healing potions (2330, 2337, ...) this way and teaches them in First
//     Aid under new spell ids. Those rows are left out ("retired").
//   - Season of Discovery content ships in the same client. It is left out:
//     spell ids from 400000 that the Classic Era client's SkillLineAbility
//     lists too (`season`; Forever's own recipes, past 1,000,000, it does
//     not), else every spell id 400000-999999; and recipes whose created item
//     is missing from items.json.

const PROFESSIONS = {
	171: 'primary', 164: 'primary', 333: 'primary', 202: 'primary', 165: 'primary', 197: 'primary',
	182: 'gathering', 186: 'gathering', 393: 'gathering',
	185: 'secondary', 129: 'secondary', 356: 'secondary',
};

const SOD_SPELL_MIN = 400000;
const FOREVER_SPELL_MIN = 1000000;
const ESTIMATE_GAP = 0;

// Specialization recipes that trainers teach without a recipe item (game
// knowledge: the Gnomish/Goblin Engineering trainer lists of patch 1.x).
const GOBLIN_ENGINEER = 20222;
const GNOMISH_ENGINEER = 20219;
const SPECIALIZATION = {
	12715: GOBLIN_ENGINEER, 12716: GOBLIN_ENGINEER, 12717: GOBLIN_ENGINEER, 12718: GOBLIN_ENGINEER,
	12720: GOBLIN_ENGINEER, 12722: GOBLIN_ENGINEER, 12755: GOBLIN_ENGINEER, 12758: GOBLIN_ENGINEER,
	12760: GOBLIN_ENGINEER, 12908: GOBLIN_ENGINEER, 13240: GOBLIN_ENGINEER, 23078: GOBLIN_ENGINEER, 23489: GOBLIN_ENGINEER,
	12759: GNOMISH_ENGINEER, 12897: GNOMISH_ENGINEER, 12899: GNOMISH_ENGINEER, 12902: GNOMISH_ENGINEER,
	12903: GNOMISH_ENGINEER, 12904: GNOMISH_ENGINEER, 12905: GNOMISH_ENGINEER, 12906: GNOMISH_ENGINEER,
	12907: GNOMISH_ENGINEER, 23129: GNOMISH_ENGINEER, 23486: GNOMISH_ENGINEER,
};

const int = (v) => {
	const n = Number(v);
	return Number.isFinite(n) ? Math.trunc(n) : 0;
};

function groupBy(rows, key) {
	const m = new Map();
	for (const r of rows || []) {
		const k = int(r[key]);
		if (!m.has(k)) m.set(k, []);
		m.get(k).push(r);
	}
	return m;
}

function byId(rows) {
	const m = new Map();
	for (const r of rows || []) m.set(int(r.ID), r);
	return m;
}

// An effect's base points as the Era client stores them (EffectBasePoints,
// one less than the value with EffectDieSides 1). The Forever client keeps
// only the value, EffectBasePointsF.
function basePoints(e) {
	if (e.EffectBasePoints != null && e.EffectBasePoints !== '') return int(e.EffectBasePoints);
	return Math.round(Number(e.EffectBasePointsF) || 0) - 1;
}

// Indexes over the raw tables shared by every profession.
function indexTables(t) {
	const spellName = new Map((t.SpellName || []).map((r) => [int(r.ID), r.Name_lang]));
	const effects = new Map();
	const learns = new Map(); // teaching spell -> [learned spells] (Effect 36)
	for (const r of t.SpellEffect || []) {
		if (int(r.DifficultyID) !== 0) continue;
		const s = int(r.SpellID);
		if (!effects.has(s)) effects.set(s, []);
		effects.get(s).push(r);
		if (int(r.Effect) === 36 && int(r.EffectTriggerSpell) > 0) {
			if (!learns.has(s)) learns.set(s, []);
			learns.get(s).push(int(r.EffectTriggerSpell));
		}
	}
	for (const list of effects.values()) list.sort((a, b) => int(a.EffectIndex) - int(b.EffectIndex));
	// learned spell -> items that teach it. An item effect with TriggerType 6
	// teaches its SpellID itself (Forever's recipe items); any other casts a
	// teaching spell (Effect 36, the Era client's). The Era client's ItemEffect
	// names the item (ParentItemID), Forever's links them in ItemXItemEffect.
	const effectItems = groupBy(t.ItemXItemEffect, 'ItemEffectID');
	const taughtBy = new Map();
	for (const r of t.ItemEffect || []) {
		const parents = int(r.ParentItemID) ? [int(r.ParentItemID)] : (effectItems.get(int(r.ID)) || []).map((x) => int(x.ItemID));
		const learned = int(r.TriggerType) === 6 ? [int(r.SpellID)] : learns.get(int(r.SpellID)) || [];
		for (const s of learned) {
			if (!taughtBy.has(s)) taughtBy.set(s, []);
			taughtBy.get(s).push(...parents);
		}
	}
	// Tool category (SpellTotems.RequiredTotemCategoryID, how Forever names a
	// recipe's tool) -> the items of that category (ItemSparse.TotemCategoryID), by id.
	const toolItems = new Map();
	for (const r of t.ItemSparse || []) {
		const cat = int(r.TotemCategoryID);
		if (!cat) continue;
		if (!toolItems.has(cat)) toolItems.set(cat, []);
		toolItems.get(cat).push(int(r.ID));
	}
	for (const list of toolItems.values()) list.sort((a, b) => a - b);
	return {
		spellName,
		effects,
		taughtBy,
		reagents: new Map((t.SpellReagents || []).map((r) => [int(r.SpellID), r])),
		totems: new Map((t.SpellTotems || []).map((r) => [int(r.SpellID), r])),
		toolItems,
		casting: new Map((t.SpellCastingRequirements || []).map((r) => [int(r.SpellID), r])),
		focus: new Map((t.SpellFocusObject || []).map((r) => [int(r.ID), r.Name_lang])),
		sparse: byId(t.ItemSparse),
		item: byId(t.Item),
		skillLine: byId(t.SkillLine),
		abilities: groupBy(t.SkillLineAbility, 'SkillLine'),
	};
}

// Recipe items (Item ClassID 9) whose use teaches `spell`, in items.json only.
function recipeItemsFor(ix, spell, items) {
	const out = [];
	for (const id of ix.taughtBy.get(spell) || []) {
		const it = ix.item.get(id);
		if (!it || int(it.ClassID) !== 9 || !items[id] || out.includes(id)) continue;
		out.push(id);
	}
	return out.sort((a, b) => a - b);
}

function sourceOf(it) {
	if (!it) return null;
	if ((it.vendors || []).length) return 'vendor';
	const d = it.drops || {};
	if (Object.keys(d.npc || {}).length || Object.keys(d.object || {}).length) return 'drop';
	return 'item';
}

function itemPrice(ix, id) {
	const s = ix.sparse.get(id);
	if (!s) return null;
	return { buy: int(s.BuyPrice), buyCount: Math.max(1, int(s.VendorStackCount)), sell: int(s.SellPrice), quality: int(s.OverallQualityID) };
}

function extractRecipe(ix, row, ctx) {
	const spell = int(row.Spell);
	const effects = ix.effects.get(spell) || [];
	const create = effects.find((e) => int(e.Effect) === 24 && int(e.EffectItemType) > 0);
	const enchant = effects.find((e) => int(e.Effect) === 53);
	if (!create && !enchant) return { skip: 'not a recipe' };
	if (int(row.AcquireMethod) === 3) return { skip: 'retired' };
	if (spell >= SOD_SPELL_MIN && (ctx.season ? ctx.season.has(spell) : spell < FOREVER_SPELL_MIN)) return { skip: 'season' };
	const made = create ? int(create.EffectItemType) : null;
	if (made && !ctx.items[made]) return { skip: 'season' };
	const yellow = int(row.TrivialSkillLineRankLow);
	const grey = int(row.TrivialSkillLineRankHigh);
	const recipeItems = recipeItemsFor(ix, spell, ctx.items);
	const r = { spell, name: ix.spellName.get(spell) || `Spell ${spell}` };
	if (made) {
		r.item = made;
		r.itemCount = Math.max(1, basePoints(create) + 1);
	}
	if (enchant) r.enchant = true;
	const rg = ix.reagents.get(spell);
	r.reagents = [];
	if (rg) {
		for (let i = 0; i < 8; i++) {
			const item = int(rg[`Reagent_${i}`]);
			const count = int(rg[`ReagentCount_${i}`]);
			if (item > 0 && count > 0) r.reagents.push({ item, count });
		}
	}
	// Prefer a recipe item someone sells, then one that drops, then the lowest id.
	const rank = (id) => ({ vendor: 0, drop: 1, item: 2 })[sourceOf(ctx.items[id])];
	const recipeItem = recipeItems.slice().sort((a, b) => rank(a) - rank(b) || a - b)[0];
	const auto = int(row.AcquireMethod) === 1;
	if (recipeItem) {
		const s = ix.sparse.get(recipeItem);
		const req = s ? int(s.RequiredSkillRank) : 0;
		r.learnedAt = Math.max(1, req);
		r.source = sourceOf(ctx.items[recipeItem]);
		r.recipeItem = recipeItem;
		if (r.source === 'vendor') r.cost = s ? int(s.BuyPrice) : 0;
		const ability = s ? int(s.RequiredAbility) : 0;
		if (ability) r.requires = ability;
		// Reputation vendors: ItemSparse MinFactionID + MinReputation (standing 0-7, 4 = Friendly).
		const faction = s ? int(s.MinFactionID) : 0;
		if (faction > 0) r.reputation = { faction, standing: int(s.MinReputation) + 1 };
	} else {
		r.source = 'trainer';
		if (auto) {
			r.learnedAt = 1;
			r.cost = 0;
		} else if (int(row.MinSkillLineRank) > 1) {
			r.learnedAt = int(row.MinSkillLineRank);
		} else if (yellow > 0) {
			r.learnedAt = Math.max(1, yellow - ESTIMATE_GAP);
			r.learnedAtEstimated = true;
		} else {
			r.learnedAt = 1;
			r.learnedAtEstimated = true;
		}
	}
	if (SPECIALIZATION[spell]) r.requires = SPECIALIZATION[spell];
	if (grey > 0) {
		r.yellow = yellow > 0 ? yellow : r.learnedAt;
		r.grey = grey;
		r.green = Math.floor((r.yellow + grey) / 2);
	} else {
		r.yellow = null;
		r.green = null;
		r.grey = null;
	}
	const ups = int(row.NumSkillUps);
	if (ups > 1) r.skillUps = ups;
	// A tool is an item (Totem_0..1, the Era client) or a tool category
	// (Forever): its first item in items.json, which is the plain tool
	// (category 162 -> Blacksmith Hammer 5956, not the Arcanite one).
	const tot = ix.totems.get(spell);
	if (tot) {
		const tools = [int(tot.Totem_0), int(tot.Totem_1)].filter((x) => x > 0);
		for (const cat of [int(tot.RequiredTotemCategoryID_0), int(tot.RequiredTotemCategoryID_1)]) {
			const list = (cat > 0 && ix.toolItems.get(cat)) || [];
			const id = list.find((x) => ctx.items[x]) || list[0];
			if (id && !tools.includes(id)) tools.push(id);
		}
		if (tools.length) r.tools = tools;
	}
	const cast = ix.casting.get(spell);
	if (cast && int(cast.RequiresSpellFocus) > 0) r.focus = ix.focus.get(int(cast.RequiresSpellFocus)) || `focus ${int(cast.RequiresSpellFocus)}`;
	// The low 32 race bits, unsigned (Forever's RaceMasks_0 is a signed int32).
	const race = int(row.RaceMasks_0 ?? row.RaceMask_0) >>> 0;
	if (race) r.races = race;
	const cls = int(row.ClassMask);
	if (cls) r.classes = cls;
	return { recipe: r };
}

// Rank spells: abilities whose spell has a skill effect (118) for this line;
// EffectBasePoints is the tier index (0 Apprentice .. 3 Artisan).
function rankSpells(ix, skillLine) {
	const out = [];
	for (const row of ix.abilities.get(skillLine) || []) {
		const spell = int(row.Spell);
		const e = (ix.effects.get(spell) || []).find((x) => int(x.Effect) === 118 && int(x.EffectMiscValue_0) === skillLine);
		if (!e) continue;
		const tier = basePoints(e);
		if (out[tier] === undefined || spell < out[tier]) out[tier] = spell;
	}
	return out;
}

// Every item a recipe needs or teaches, with what the data says about where
// it comes from. `stock` (item -> Map(npc -> limit)) marks limited vendors.
function materialInfo(ix, id, ctx, madeBy) {
	const it = ctx.items[id] || null;
	const price = itemPrice(ix, id);
	const m = { name: (it && it.name) || (ix.sparse.get(id) || {}).Display_lang || `Item ${id}` };
	if (price) Object.assign(m, price);
	// Bonding 1 binds when picked up: nobody can sell it on the Auction House.
	// Forever made many vendor recipes so (Holy Protection Potion, issue #315).
	if (int((ix.sparse.get(id) || {}).Bonding) === 1) m.bop = true;
	const vendors = { Alliance: [], Horde: [] };
	const limited = { Alliance: [], Horde: [] };
	const limits = ctx.stock.get(id);
	for (const v of (it && it.vendors) || []) {
		const npc = ctx.npcs[v];
		if (!npc) continue;
		const f = npc.faction == null ? 'AH' : String(npc.faction) || 'AH';
		const lim = limits && limits.has(v) ? limits.get(v) : 0;
		for (const [side, code] of [['Alliance', 'A'], ['Horde', 'H']]) {
			if (!(f.includes(code) || f === 'AH')) continue;
			(lim > 0 ? limited : vendors)[side].push(v);
		}
	}
	for (const s of ['Alliance', 'Horde']) {
		vendors[s].sort((a, b) => a - b);
		limited[s].sort((a, b) => a - b);
	}
	if (vendors.Alliance.length || vendors.Horde.length) m.vendors = vendors;
	if (limited.Alliance.length || limited.Horde.length) m.limitedVendors = limited;
	const made = madeBy.get(id);
	if (made && made.length) m.madeBy = made;
	const d = (it && it.drops) || {};
	const gather = {};
	for (const [oid, chance] of Object.entries(d.object || {})) {
		const o = ctx.objects[oid];
		const roles = (o && o.roles) || [];
		for (const role of ['herb', 'mine', 'fishing']) {
			if (roles.includes(role)) (gather[role] = gather[role] || []).push([Number(oid), chance]);
		}
	}
	for (const k of Object.keys(gather)) gather[k] = gather[k].sort((a, b) => b[1] - a[1] || a[0] - b[0]).slice(0, 3).map((x) => x[0]);
	if (Object.keys(gather).length) m.gather = gather;
	const drops = Object.entries(d.npc || {})
		.map(([n, c]) => [Number(n), Number(c)])
		.filter(([n]) => ctx.npcs[n])
		.sort((a, b) => b[1] - a[1] || a[0] - b[0]);
	if (drops.length) {
		m.dropCount = drops.length;
		m.drops = drops.slice(0, 3).map(([n, c]) => ({ npc: n, chance: c }));
	}
	return m;
}

// -> { professions, report: { [id]: { recipes, skipped: { reason: n } } }, warnings }
// season: Set of Season of Discovery spell ids (see the top), else the id range decides.
function extractProfessions(tables, { items = {}, npcs = {}, objects = {}, stock = new Map(), trainers = () => null, season = null } = {}) {
	const ix = indexTables(tables);
	const ctx = { items, npcs, objects, stock, season };
	const out = {};
	const report = {};
	const warnings = [];
	const madeBy = new Map(); // item -> [{ skillLine, spell }]
	const all = [];
	for (const idStr of Object.keys(PROFESSIONS)) {
		const id = Number(idStr);
		const line = ix.skillLine.get(id);
		if (!line) {
			warnings.push(`SkillLine ${id} missing from the client tables`);
			continue;
		}
		const recipes = [];
		const skipped = {};
		const seen = new Set();
		for (const row of ix.abilities.get(id) || []) {
			const res = extractRecipe(ix, row, ctx);
			if (res.skip) {
				if (res.skip !== 'not a recipe') skipped[res.skip] = (skipped[res.skip] || 0) + 1;
				continue;
			}
			if (seen.has(res.recipe.spell)) continue;
			seen.add(res.recipe.spell);
			recipes.push(res.recipe);
		}
		recipes.sort((a, b) => a.learnedAt - b.learnedAt || (a.yellow || 0) - (b.yellow || 0) || a.spell - b.spell);
		for (const r of recipes) {
			if (!r.item) continue;
			if (!madeBy.has(r.item)) madeBy.set(r.item, []);
			madeBy.get(r.item).push({ skillLine: id, spell: r.spell });
		}
		const kind = PROFESSIONS[id];
		const tr = trainers(id, kind) || {};
		for (const w of tr.warnings || []) warnings.push(w);
		const spells = rankSpells(ix, id);
		const ranks = (tr.ranks || []).map((rk, i) => (spells[i] ? { ...rk, spell: spells[i] } : rk));
		const prof = { id, name: String(line.DisplayName_lang).trim(), kind, ranks, trainers: tr.trainers || { Alliance: [], Horde: [] } };
		if (tr.main && Object.keys(tr.main).length) prof.mainTrainer = tr.main;
		prof.recipes = recipes;
		out[id] = prof;
		all.push(prof);
		report[id] = { name: prof.name, recipes: recipes.length, skipped };
	}
	// Materials: reagents, tools and recipe items of every profession.
	for (const prof of all) {
		const ids = new Set();
		for (const r of prof.recipes) {
			for (const g of r.reagents) ids.add(g.item);
			for (const t of r.tools || []) ids.add(t);
			if (r.recipeItem) ids.add(r.recipeItem);
		}
		for (const rank of prof.ranks) if (rank.book) ids.add(rank.book.item);
		const materials = {};
		for (const id of [...ids].sort((a, b) => a - b)) materials[id] = materialInfo(ix, id, ctx, madeBy);
		prof.materials = materials;
	}
	return { professions: out, report, warnings };
}

module.exports = { extractProfessions, indexTables, PROFESSIONS, ESTIMATE_GAP, SOD_SPELL_MIN, FOREVER_SPELL_MIN };
