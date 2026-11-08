'use strict';
// A fake translation for the addon's tests: Lua for runAddon's `before` that
// makes GetLocale() return `locale` and fills Polestar.L with `strings`
// right after Core/Init.lua runs, before any file reads L at load. Code that
// looks a string up too early, or two meanings sharing one key, then shows in
// the test. The locale must be one
// Polestar does not ship (itIT: WoW: Forever has no Italian client), or the
// shipped file would load after these strings and replace them.
//
//   const { fakeLocale } = require('./helpers/locale');
//   runAddon({ before: fakeLocale('itIT', { 'Open settings': 'Apri le opzioni' }), ... });

const { LOCALES } = require('../../tools/lib/i18n/locales');

function luaString(s) {
	return '"' + String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n') + '"';
}

function fakeLocale(locale, strings) {
	if (LOCALES[locale]) throw new Error(`fakeLocale: Polestar ships ${locale} (tools/lib/i18n/locales.js); fake one it does not, such as itIT`);
	const fill = Object.entries(strings)
		.map(([k, v]) => `\t\tns.L[${luaString(k)}] = ${luaString(v)}`)
		.join('\n');
	return `function GetLocale() return ${luaString(locale)} end
do
	local load = loadfile
	function loadfile(file)
		local chunk, err = load(file)
		if not chunk or not file:match("[/\\\\]Polestar[/\\\\]Core[/\\\\]Init%.lua$") then return chunk, err end
		return function(name, ns)
			chunk(name, ns)
${fill}
		end
	end
end`;
}

module.exports = { fakeLocale };
