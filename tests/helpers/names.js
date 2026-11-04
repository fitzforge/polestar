'use strict';
// A language folder (Polestar_<locale>) holding only a Names.lua, as
// `forge data names` writes it, built from a few names, for the addon's
// tests: the stubbed client loads it when Polestar asks (C_AddOns.LoadAddOn),
// the way the game loads a load-on-demand addon, and counts every language
// folder it is asked for in __namesLoads.
//
//   const { namesPack } = require('./helpers/names');
//   const pack = namesPack('frFR', { npc: { 448: 'Lardeur' }, quest: { 176: '...' } });
//   runAddon({ before: `function GetLocale() return "frFR" end\n${pack.stubLua}`, ... });

const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./tmp');
const { languageAddon } = require('../../tools/lib/i18n/toc');

const { luaString } = require('../../tools/lib/i18n/files');

// The pack's Names.lua in the shape `forge data names` writes (LuaChunks:
// one chunk per kind here, of "<id>\t<name>" lines, the separators as %XX):
// names = { kind: { id: name } }.
const field = (s) => String(s).replace(/[%;,:|\t\n\r]/g, (c) => `%${c.charCodeAt(0).toString(16).toUpperCase().padStart(2, '0')}`);
function longString(text) {
	let eq = '';
	while (text.includes(`]${eq}]`) || text.endsWith(`]${eq}`)) eq += '=';
	return `[${eq}[\n${text}]${eq}]`;
}
function namesLua(locale, names) {
	const lines = [
		'local N = Polestar and Polestar.Names',
		'if not (N and N.AddChunk) then return end',
		`local function R(kind, lo, hi, text) N.AddChunk(${luaString(locale)}, kind, lo, hi, text) end`,
	];
	for (const [kind, byId] of Object.entries(names)) {
		const entries = Object.entries(byId).map(([i, x]) => [Number(i), x]).sort((a, b) => a[0] - b[0]);
		if (!entries.length) continue;
		const text = `${entries.map(([id, n]) => `\n${id}\t${field(n)}`).join('')}\n`;
		lines.push(`R(${luaString(kind)}, ${entries[0][0]}, ${entries[entries.length - 1][0]}, ${longString(text)})`);
	}
	return `${lines.join('\n')}\n`;
}

function namesPack(locale, names) {
	const files = { 'Names.lua': namesLua(locale, names) };
	const name = languageAddon(locale);
	const dir = path.join(tmpdir('polestar-names-'), name);
	fs.mkdirSync(dir);
	for (const [f, text] of Object.entries(files)) fs.writeFileSync(path.join(dir, f), text);
	const stubLua = `__namesLoads = 0
do
  local __load = C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if type(name) == "string" and name:find("^Polestar_%l%l%u%u$") then __namesLoads = __namesLoads + 1 end
    if name ~= ${JSON.stringify(name)} then return __load(name) end
    if not stub.addonsLoaded[name] then
      dofile(${JSON.stringify(path.join(dir, 'Names.lua'))})
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end`;
	return { dir, files, stubLua };
}

module.exports = { namesPack };
