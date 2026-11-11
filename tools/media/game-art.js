'use strict';
// Where the client keeps the retail art of the atlases the Blizzard skin draws
// (Polestar.Theme, "Skins"): addon/Polestar_Looks/GameArt.lua, in the part
// that holds the game looks (loaded on demand: it reads Polestar's namespace
// through the Polestar global).
//
// The Forever client swaps many atlas names for its own art (the "-c60"
// members of an atlas element), so SetAtlas draws Forever's bronze there. The
// retail sheets still ship with the client; the Blizzard skin draws them by
// file and texture coordinates instead, read here from the client's tables
// (UiTextureAtlasElement, UiTextureAtlasMember, UiTextureAtlas on wago.tools,
// cached under data/sources/wago/<build>/). Nothing of the art itself is
// copied: the table holds file IDs and coordinates only. The 1x member wins
// over the 2x one; sizes are the art's own at 1x.

const fs = require('node:fs');
const path = require('node:path');
const { SOURCES } = require('../lib/paths');
const { pickBuild, cachedTable, fetchText } = require('../lib/data/wago');

// The client tables this reads (and caches under data/sources/wago/<build>/).
const TABLES = ['UiTextureAtlas', 'UiTextureAtlasElement', 'UiTextureAtlasMember', 'UiTextureAtlasElementSliceData'];

// The atlas elements the Blizzard skin draws (Theme/Kits.lua names them).
const ELEMENTS = [
	'UI-Frame-Metal-CornerTopLeft', 'UI-Frame-Metal-CornerTopRight', 'UI-Frame-Metal-CornerBottomLeft',
	'UI-Frame-Metal-CornerBottomRight', '_UI-Frame-Metal-EdgeTop', '_UI-Frame-Metal-EdgeBottom',
	'!UI-Frame-Metal-EdgeLeft', '!UI-Frame-Metal-EdgeRight',
	'Tooltip-NineSlice-CornerTopLeft', 'Tooltip-NineSlice-CornerTopRight', 'Tooltip-NineSlice-CornerBottomLeft',
	'Tooltip-NineSlice-CornerBottomRight', '_Tooltip-NineSlice-EdgeTop', '_Tooltip-NineSlice-EdgeBottom',
	'!Tooltip-NineSlice-EdgeLeft', '!Tooltip-NineSlice-EdgeRight', 'Tooltip-NineSlice-Center',
	'Options_Tab_Left', 'Options_Tab_Middle', 'Options_Tab_Right',
	'Options_Tab_Active_Left', 'Options_Tab_Active_Middle', 'Options_Tab_Active_Right', 'Options_HorizontalDivider',
	'checkbox-minimal', 'checkmark-minimal',
	'Minimal_SliderBar_Left', '_Minimal_SliderBar_Middle', 'Minimal_SliderBar_Right', 'Minimal_SliderBar_Button',
	'common-dropdown-a-button', 'common-dropdown-a-button-hover', 'common-dropdown-a-button-pressed',
	'common-search-border-left', 'common-search-border-middle', 'common-search-border-right',
	'128-RedButton-Left', '_128-RedButton-Center', '128-RedButton-Right',
	'128-RedButton-Left-Pressed', '_128-RedButton-Center-Pressed', '128-RedButton-Right-Pressed',
	'128-RedButton-Left-Disabled', '_128-RedButton-Center-Disabled', '128-RedButton-Right-Disabled',
	'128-RedButton-Highlight', 'RedButton-Exit', 'RedButton-exit-pressed',
	'common-button-tertiary-square-normal', 'common-button-tertiary-square-hover', 'common-button-tertiary-square-depressed-normal',
	'UI-QuestTracker-Primary-Objective-Header',
	'ui-damagemeters-header-bar', 'ui-damagemeters-bar-shadowbg', 'ui-damagemeters-bar-shadowedge',
	// The Settings panel's parts (SettingsPanel, its category list and rows).
	'Options_List_Active', 'Options_List_Hover', 'RedButton-Highlight', '_UI-Frame-TopTileStreaks',
	'UI-Frame-InnerTopLeft', 'UI-Frame-InnerTopRight', 'UI-Frame-InnerBotLeftCorner', 'UI-Frame-InnerBotRight',
	'_UI-Frame-InnerTopTile', '_UI-Frame-InnerBotTile', '!UI-Frame-InnerLeftTile', '!UI-Frame-InnerRightTile',
	'Minimal_SliderBar_Button_Left', 'Minimal_SliderBar_Button_Right',
	'common-dropdown-c-button', 'common-dropdown-c-button-hover-1', 'common-dropdown-c-button-hover-arrow', 'common-dropdown-bg',
	'minimal-scrollbar-track-top', '!minimal-scrollbar-track-middle', 'minimal-scrollbar-track-bottom',
	'minimal-scrollbar-small-thumb-top', 'minimal-scrollbar-small-thumb-middle', 'minimal-scrollbar-small-thumb-bottom',
	'minimal-scrollbar-arrow-top', 'minimal-scrollbar-arrow-bottom',
	// The small windows' frames: SimplePanelTemplate's thin metal (one corner
	// and two edges, mirrored as NineSliceUtil mirrors them) round the guide
	// window, the alert toasts' frame round the toasts and cards; the objective
	// tracker's check mark and secondary header.
	'UI-Frame-SimpleMetal-CornerTopLeft', '_UI-Frame-SimpleMetal-EdgeTop', '!UI-Frame-SimpleMetal-EdgeLeft',
	'Toast-NineSlice-CornerTopLeft', 'Toast-NineSlice-CornerTopRight', 'Toast-NineSlice-CornerBottomLeft',
	'Toast-NineSlice-CornerBottomRight', '_Toast-NineSlice-EdgeTop', '_Toast-NineSlice-EdgeBottom',
	'!Toast-NineSlice-EdgeLeft', '!Toast-NineSlice-EdgeRight',
	'UI-QuestTracker-Secondary-Objective-Header', 'UI-QuestTracker-Tracker-Check',
];

// Relative to the addon folder the generator is given (addon/Polestar).
const OUT = path.join('..', 'Polestar_Looks', 'GameArt.lua');

const round = (n) => Math.round(n * 1e7) / 1e7;

// rows of the three tables -> { [element]: { file, w, h, l, r, t, b } }
function retailArt(tables, elements = ELEMENTS) {
	const byId = new Map(tables.UiTextureAtlas.map((a) => [String(a.ID), a]));
	const elementId = new Map(tables.UiTextureAtlasElement.map((e) => [String(e.Name).toLowerCase(), String(e.ID)]));
	const members = new Map();
	for (const m of tables.UiTextureAtlasMember) {
		const k = String(m.UiTextureAtlasElementID);
		if (!members.has(k)) members.set(k, []);
		members.get(k).push(m);
	}
	const out = {};
	for (const name of elements) {
		const id = elementId.get(name.toLowerCase());
		if (!id) throw new Error(`game-art: no atlas element "${name}"`);
		const retail = (members.get(id) || []).filter((m) => !/c60/i.test(m.CommittedName));
		if (!retail.length) throw new Error(`game-art: "${name}" has no retail member`);
		const one = retail.find((m) => !/-2x$/i.test(m.CommittedName)) || retail[0];
		const scale = /-2x$/i.test(one.CommittedName) ? 0.5 : 1;
		const atlas = byId.get(String(one.UiTextureAtlasID));
		const W = Number(atlas.AtlasWidth), H = Number(atlas.AtlasHeight);
		out[name] = {
			file: Number(atlas.FileDataID),
			w: Number(one.Width) * scale,
			h: Number(one.Height) * scale,
			l: round(Number(one.CommittedLeft) / W),
			r: round(Number(one.CommittedRight) / W),
			t: round(Number(one.CommittedTop) / H),
			b: round(Number(one.CommittedBottom) / H),
		};
	}
	return out;
}

// The nine-slice margins the client applies when it draws an atlas
// (UiTextureAtlasElementSliceData): the skins cut those atlases themselves,
// as they draw them by file and coordinates. -> { [element]: { l, t, r, b } }
function sliceData(tables, elements) {
	const elementId = new Map(tables.UiTextureAtlasElement.map((e) => [String(e.Name).toLowerCase(), String(e.ID)]));
	const slices = new Map(tables.UiTextureAtlasElementSliceData.map((s) => [String(s.UiTextureAtlasElementID), s]));
	const out = {};
	for (const name of elements) {
		const s = slices.get(elementId.get(name.toLowerCase()));
		if (s) out[name] = { l: Number(s.Left), t: Number(s.Top), r: Number(s.Right), b: Number(s.Bottom) };
	}
	return out;
}

// The atlases the skins draw sliced (retail and Forever alike).
const SLICED = [
	'common-dropdown-bg', 'common-dropdown-c-button', 'common-dropdown-c-button-hover-1',
	'common-button-list-small', 'common-button-list-small-hover', 'common-button-list-small-selected',
	'Legacy-Progressbar-Frame', 'UI-HUD-ActionBar-Frame',
];

function toLua(art, build, slices = {}) {
	const lines = [
		'-- Generated by `node tools/polestar.js media game-art` (tools/media/game-art.js)',
		`-- from the WoW Forever client's atlas tables, build ${build}. Do not edit.`,
		'-- The retail art of the atlases the Blizzard skin draws: file ID, size at',
		'-- 1x, texture coordinates (left, right, top, bottom).',
		'',
		'local ns = Polestar',
		'ns.GameArt = {',
	];
	for (const name of Object.keys(art).sort()) {
		const a = art[name];
		lines.push(`\t["${name}"] = { ${a.file}, ${a.w}, ${a.h}, ${a.l}, ${a.r}, ${a.t}, ${a.b} },`);
	}
	lines.push('}', '', '-- The nine-slice margins (left, top, right, bottom) the client cuts these', '-- atlases at.', 'ns.GameArtSlice = {');
	for (const name of Object.keys(slices).sort()) {
		const s = slices[name];
		lines.push(`\t["${name}"] = { ${s.l}, ${s.t}, ${s.r}, ${s.b} },`);
	}
	lines.push('}', '');
	return lines.join('\n');
}

// offline: no request to wago.tools; the newest cached Forever build holding
// every one of TABLES. Online, that build is also the fallback when
// wago.tools' build list is unreachable. sourcesDir, fetchImpl: for tests.
async function generate(addonRoot, { offline = false, sourcesDir = SOURCES, fetchImpl = globalThis.fetch } = {}) {
	const { build, warnings } = await pickBuild({ sourcesDir, product: 'forever', tables: TABLES, offline, fetchImpl });
	for (const w of warnings) console.warn(`game-art: ${w}`);
	const get = (url) => fetchText(fetchImpl, url, { userAgent: 'polestar-media' });
	const tables = {};
	for (const t of TABLES) tables[t] = await cachedTable({ sourcesDir, build, table: t, offline, get });
	const file = path.join(addonRoot, OUT);
	fs.writeFileSync(file, toLua(retailArt(tables), build, sliceData(tables, SLICED)));
	return [file];
}

module.exports = { name: 'game-art', generate, retailArt, sliceData, toLua, ELEMENTS, SLICED, TABLES };
