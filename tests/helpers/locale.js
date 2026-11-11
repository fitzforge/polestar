'use strict';
// A fake translation for the addon's tests: Lua for runAddon's `before` that
// makes GetLocale() return `locale` and fills Polestar.L with `strings` when
// Polestar asks for the language folder (C_AddOns.LoadAddOn("Polestar_<locale>"),
// from Core/Locale.lua), the way the client runs the folder's Interface.lua.
// Code that looks a string up before Locale.lua, or two meanings sharing one
// key, then shows in the test. The locale must be one Polestar does not ship
// (itIT: WoW: Forever has no Italian client). A test that loads only part of
// Core/Core.xml calls C_AddOns.LoadAddOn("Polestar_" .. GetLocale()) itself.
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
		.map(([k, v]) => `\t\t\tL[${luaString(k)}] = ${luaString(v)}`)
		.join('\n');
	return `function GetLocale() return ${luaString(locale)} end
do
	local load = C_AddOns.LoadAddOn
	function C_AddOns.LoadAddOn(name)
		if name ~= ${luaString(`Polestar_${locale}`)} then return load(name) end
		if not stub.addonsLoaded[name] then
			local L = Polestar.L
${fill}
			stub.addonLoaded(name)
		end
		return true
	end
	LoadAddOn = C_AddOns.LoadAddOn
end`;
}

module.exports = { fakeLocale };
