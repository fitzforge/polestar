// The client's languages and which one a system's preferences mean. Plain TypeScript (no
// runes), so tests/client-i18n.test.js can load it with Node.

/** The game's locale codes, as Polestar's addon uses them (docs/TRANSLATING.md). */
export type Locale = 'enUS' | 'deDE' | 'esES' | 'esMX' | 'frFR' | 'koKR' | 'ptBR' | 'ruRU' | 'zhCN' | 'zhTW';
/** Settings > Language: 'auto' follows the system. */
export type LanguageChoice = 'auto' | Locale;

/** Each language in its own name, for the Language menu, and the tag Intl formats with. */
export const LANGUAGES: { code: Locale; name: string; tag: string }[] = [
	{ code: 'enUS', name: 'English', tag: 'en-US' },
	{ code: 'deDE', name: 'Deutsch', tag: 'de-DE' },
	{ code: 'esES', name: 'Español (España)', tag: 'es-ES' },
	{ code: 'esMX', name: 'Español (Latinoamérica)', tag: 'es-MX' },
	{ code: 'frFR', name: 'Français', tag: 'fr-FR' },
	{ code: 'ptBR', name: 'Português (Brasil)', tag: 'pt-BR' },
	{ code: 'ruRU', name: 'Русский', tag: 'ru-RU' },
	{ code: 'koKR', name: '한국어', tag: 'ko-KR' },
	{ code: 'zhCN', name: '简体中文', tag: 'zh-CN' },
	{ code: 'zhTW', name: '繁體中文', tag: 'zh-TW' },
];

/** The client's language for the system's preferred languages (navigator.languages): the first
 * one the client has; Spanish of the Americas reads Latin American Spanish, of Spain (or plain
 * es) Spain's; Chinese of Taiwan, Hong Kong and Macau, or written Hant, the traditional script. */
export function detect(preferred: readonly string[]): Locale {
	for (const raw of preferred) {
		let l: Intl.Locale;
		try {
			l = new Intl.Locale(raw);
		} catch {
			continue;
		}
		const region = l.region ?? '';
		switch (l.language) {
			case 'en':
				return 'enUS';
			case 'de':
				return 'deDE';
			case 'fr':
				return 'frFR';
			case 'pt':
				return 'ptBR';
			case 'ko':
				return 'koKR';
			case 'ru':
				return 'ruRU';
			case 'es':
				return region === '' || region === 'ES' ? 'esES' : 'esMX';
			case 'zh': {
				const script = l.script ?? (['TW', 'HK', 'MO'].includes(region) ? 'Hant' : 'Hans');
				return script === 'Hant' ? 'zhTW' : 'zhCN';
			}
		}
	}
	return 'enUS';
}

