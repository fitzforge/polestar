'use strict';
// The languages of Polestar's interface (docs/TRANSLATING.md): the client
// locales WoW: Forever ships besides English. Each has one file,
// addon/Polestar/Locales/<locale>.lua, loaded by Core/Core.xml once it
// exists. `status`: "reviewed" when a native speaker wrote or checked it
// (tooling never fills or rewrites its translations; `i18n sync` only adds
// the new keys commented out), "ai" when a machine made it (Options' About
// says so on that client: ns.AI_LOCALES in Core/Init.lua, kept equal to this
// list by tests/i18n.test.js). enUS and enGB read the English keys. Adapted
// from Ding! by Yendi (@moust4ki), GPL-3.0:
// https://github.com/moust4ki/DingGuideWoWForever

const LOCALES = {
	deDE: { language: 'German', status: 'reviewed', translators: ['thecodingcortex'] },
	esES: { language: 'Spanish (Spain)', status: 'reviewed', translators: ['julen92'] },
	esMX: { language: 'Spanish (Latin America)', status: 'reviewed', translators: ['CDVolvik'] },
	frFR: { language: 'French', status: 'reviewed', translators: ['Yendi'] },
	koKR: { language: 'Korean', status: 'ai', translators: [] },
	ptBR: { language: 'Portuguese (Brazil)', status: 'ai', translators: [] },
	ruRU: { language: 'Russian', status: 'ai', translators: [] },
	zhCN: { language: 'Chinese (simplified)', status: 'ai', translators: [] },
	zhTW: { language: 'Chinese (traditional)', status: 'ai', translators: [] },
};

const LOCALE_CODES = Object.keys(LOCALES);

function checkLocale(locale) {
	if (!LOCALES[locale]) throw new Error(`unknown locale "${locale}": one of ${LOCALE_CODES.join(', ')}`);
	return locale;
}

module.exports = { LOCALES, LOCALE_CODES, checkLocale };
