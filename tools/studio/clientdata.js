'use strict';
// Client data the test stub lacks, from the Forever client's own tables
// (wago.tools CSV exports of build art.BUILD): what C_Spell and C_Item answer
// in game, so the studio's stub (client.lua) can show real names, ranks,
// icons, costs and the game's spell tooltip lines.
//
// Tables come from data/sources/wago/<build> (forge data sources), else the
// art cache's tables/<build>/ (fetched from wago.tools once).
//
//   await spell(id) -> { id, name, sub, icon, desc, cost, range, cast, cooldown } | null
//   await item(id)  -> { id, name, quality, icon, level, minLevel, sell, classID, startsQuest } | null
//   await luaData({ spells: [...], items: [...] }) -> Lua source setting STUDIO_DATA
//   await zoneArt() -> { maps: { [uiMapID]: { artID, layer, textures } }, files: [fileID, ...] }
//     every zone painting of the client (the art cache's maps.json entries)
//   classSpells(addonDir, cls) -> { [level]: [ { id, cost, rank, prev, races, level } ] }  (QoL/ClassSpells.lua)

const fs = require('node:fs');
const path = require('node:path');

const { SOURCES } = require('../lib/paths');
const { parseCsv } = require('../lib/data/csv');
const { tableUrl } = require('../lib/data/wago');
const art = require('./art');
const { luaValue: lua } = require('../lib/playtest');

const tables = new Map();

async function table(name) {
	if (tables.has(name)) return tables.get(name);
	const local = path.join(SOURCES, 'wago', art.BUILD, `${name}.csv`);
	const cached = path.join(art.dir(), 'tables', art.BUILD, `${name}.csv`);
	let text;
	if (fs.existsSync(local)) text = fs.readFileSync(local, 'utf8');
	else if (fs.existsSync(cached)) text = fs.readFileSync(cached, 'utf8');
	else {
		const res = await fetch(tableUrl(name, art.BUILD), { headers: { 'user-agent': 'polestar-studio' } });
		if (!res.ok) throw new Error(`studio: ${name}.csv: HTTP ${res.status}`);
		text = await res.text();
		fs.mkdirSync(path.dirname(cached), { recursive: true });
		fs.writeFileSync(cached, text);
	}
	const rows = parseCsv(text);
	const t = { byId: new Map(), bySpell: new Map() };
	for (const r of rows) {
		t.byId.set(Number(r.ID), r);
		if (r.SpellID !== undefined) {
			const id = Number(r.SpellID);
			if (!t.bySpell.has(id)) t.bySpell.set(id, []);
			t.bySpell.get(id).push(r);
		}
	}
	tables.set(name, t);
	return t;
}

const secs = (ms) => {
	const s = ms / 1000;
	if (s >= 60 && s % 60 === 0) return `${s / 60} min`;
	return `${Number.isInteger(s) ? s : s.toFixed(1)} sec`;
};

const POWER = { 0: 'Mana', 1: 'Rage', 2: 'Focus', 3: 'Energy' };

async function spell(id) {
	const name = (await table('SpellName')).byId.get(id)?.Name_lang;
	if (!name) return null;
	const sp = (await table('Spell')).byId.get(id) || {};
	const misc = ((await table('SpellMisc')).bySpell.get(id) || [])[0] || {};
	const effects = ((await table('SpellEffect')).bySpell.get(id) || []);
	const eff = (n) => effects.find((e) => Number(e.EffectIndex) === n - 1) || {};
	const dur = (await table('SpellDuration')).byId.get(Number(misc.DurationIndex));
	const durMs = dur ? Number(dur.Duration) : 0;
	const base = (n) => Math.abs(Math.round(Number(eff(n).EffectBasePointsF || 0)));
	// The tooltip's $-tokens: $s/$m/$b points, $o over the duration, $t period, $x targets, $d duration.
	const desc = (sp.Description_lang || '')
		.replace(/\$l([^:;]+):([^;]+);/g, (_, one, many) => many)
		.replace(/\$(\d+)?([sombtxd])(\d)?/g, (m, mul, k, n) => {
			const i = Number(n || 1);
			switch (k) {
				case 's': case 'm': case 'b': return String(base(i));
				case 'o': {
					const period = Number(eff(i).EffectAuraPeriod || 0);
					return String(period ? Math.round(base(i) * durMs / period) : base(i));
				}
				case 't': return String(Number(eff(i).EffectAuraPeriod || 0) / 1000);
				case 'x': return String(Number(eff(i).EffectChainTargets || 0));
				case 'd': return durMs ? secs(durMs) : '';
				default: return m;
			}
		});
	const cast = (await table('SpellCastTimes')).byId.get(Number(misc.CastingTimeIndex));
	const castMs = cast ? Number(cast.Base) : 0;
	const range = (await table('SpellRange')).byId.get(Number(misc.RangeIndex));
	let rangeText = null;
	if (range) {
		const max = Number(range.RangeMax_0), min = Number(range.RangeMin_0);
		if (max > 5) rangeText = min > 0 ? `${Math.round(min)}-${Math.round(max)} yd range` : `${Math.round(max)} yd range`;
		else if (/melee/i.test(range.DisplayName_lang || '')) rangeText = 'Melee Range';
	}
	const power = ((await table('SpellPower')).bySpell.get(id) || [])[0];
	let cost = null;
	if (power) {
		const type = Number(power.PowerType);
		const amount = Number(power.ManaCost) / (type === 1 ? 10 : 1);
		if (amount > 0) cost = `${amount} ${POWER[type] || 'Mana'}`;
		else if (Number(power.PowerCostPct) > 0) cost = `${Math.round(Number(power.PowerCostPct))}% of base mana`;
	}
	const cd = ((await table('SpellCooldowns')).bySpell.get(id) || [])[0];
	const cdMs = cd ? Math.max(Number(cd.RecoveryTime), Number(cd.CategoryRecoveryTime)) : 0;
	const passive = Number(misc.Attributes_0 || 0) & 0x40;
	return {
		id, name, sub: sp.NameSubtext_lang || '', icon: Number(misc.SpellIconFileDataID) || 134400, desc,
		cost, range: rangeText, cast: passive ? 'Passive' : castMs > 0 ? `${secs(castMs)} cast` : 'Instant',
		cooldown: cdMs > 1500 ? `${secs(cdMs)} cooldown` : null,
	};
}

async function item(id) {
	const sp = (await table('ItemSparse')).byId.get(id);
	if (!sp) return null;
	const it = (await table('Item')).byId.get(id) || {};
	return {
		id, name: sp.Display_lang, quality: Number(sp.OverallQualityID) || 1, icon: Number(it.IconFileDataID) || 134400,
		level: Number(sp.ItemLevel) || 1, minLevel: Number(sp.RequiredLevel) || 0, sell: Number(sp.SellPrice) || 0,
		classID: Number(it.ClassID) || 0, subclassID: Number(it.SubclassID) || 0, startsQuest: Number(sp.StartQuestID) || 0, bonding: Number(sp.Bonding) || 0,
		desc: sp.Description_lang || '',
	};
}

// -> { lua, icons: [fileID, ...] } for the spells and items asked (unknown ones left out).
async function luaData({ spells = [], items = [] }) {
	const S = {}, I = {}, icons = [];
	for (const id of new Set(spells)) {
		const s = await spell(id);
		if (s) { S[id] = s; icons.push(s.icon); }
	}
	for (const id of new Set(items)) {
		const i = await item(id);
		if (i) { I[id] = i; icons.push(i.icon); }
	}
	return { lua: `STUDIO_DATA = { spells = ${lua(S)}, items = ${lua(I)} }\n`, icons };
}

function classSpells(addonDir, cls) {
	const file = path.join(addonDir, 'Polestar', 'QoL', 'ClassSpells.lua');
	if (!fs.existsSync(file)) return {};
	const text = fs.readFileSync(file, 'utf8');
	const m = text.match(new RegExp(`${cls} = "([^"]+)"`));
	const out = {};
	if (!m) return out;
	for (const part of m[1].split(';')) {
		const [l, rest] = part.split('=');
		out[l] = rest.split(',').map((s) => {
			const [id, cost, rank, prev, races] = s.split(':').map(Number);
			return { id, cost, rank, prev: prev || 0, races: races || 0, level: Number(l) };
		});
	}
	return out;
}

// Every zone painting the client has, from its map tables, as C_Map answers
// them in game (GetMapArtLayers' layer 1, GetMapArtLayerTextures, GetMapArtID;
// the lowest phase's art) and as the art cache's maps.json holds them, with
// the files they draw: the base tiles and every overlay tile (UI.ZoneArt's
// full reveal). read(name) -> the table's rows (default: the client's tables).
async function zoneArt(read = async (name) => [...(await table(name)).byId.values()]) {
	const n = Number;
	const artOf = new Map();
	for (const r of [...(await read('UiMapXMapArt'))].sort((a, b) => n(a.PhaseID) - n(b.PhaseID) || n(a.ID) - n(b.ID))) {
		if (!artOf.has(n(r.UiMapID))) artOf.set(n(r.UiMapID), n(r.UiMapArtID));
	}
	const styleOf = new Map((await read('UiMapArt')).map((r) => [n(r.ID), n(r.UiMapArtStyleID)]));
	const layerOf = new Map((await read('UiMapArtStyleLayer')).filter((r) => n(r.LayerIndex) === 0).map((r) => [n(r.UiMapArtStyleID), r]));
	const tilesOf = new Map();
	for (const r of await read('UiMapArtTile')) {
		if (n(r.LayerIndex) !== 0) continue;
		if (!tilesOf.has(n(r.UiMapArtID))) tilesOf.set(n(r.UiMapArtID), []);
		tilesOf.get(n(r.UiMapArtID)).push(r);
	}
	const overlayArt = new Map((await read('WorldMapOverlay')).map((r) => [n(r.ID), n(r.UiMapArtID)]));
	const overlayFiles = new Map();
	for (const r of await read('WorldMapOverlayTile')) {
		const a = overlayArt.get(n(r.WorldMapOverlayID));
		if (a === undefined) continue;
		if (!overlayFiles.has(a)) overlayFiles.set(a, []);
		overlayFiles.get(a).push(n(r.FileDataID));
	}
	const maps = {}, files = new Set();
	for (const [id, artID] of artOf) {
		const L = layerOf.get(styleOf.get(artID)), tiles = tilesOf.get(artID);
		if (!L || !tiles) continue;
		const layer = { layerWidth: n(L.LayerWidth), layerHeight: n(L.LayerHeight), tileWidth: n(L.TileWidth), tileHeight: n(L.TileHeight) };
		const cols = Math.ceil(layer.layerWidth / layer.tileWidth);
		const textures = [];
		for (const t of tiles) textures[n(t.RowIndex) * cols + n(t.ColIndex)] = n(t.FileDataID);
		maps[id] = { artID, layer, textures };
		for (const f of [...textures, ...(overlayFiles.get(artID) || [])]) if (f) files.add(f);
	}
	return { maps, files: [...files] };
}

module.exports = { spell, item, luaData, classSpells, zoneArt };
