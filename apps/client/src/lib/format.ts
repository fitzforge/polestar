// Turning the backend's numbers and client tokens into words, in the language on screen.

import { locale, msg, t, tag, tn } from './i18n.svelte';

export function ago(ms: number, now: number): string {
	const s = Math.max(0, Math.round((now - ms) / 1000));
	if (s < 45) return t('just now');
	const m = Math.round(s / 60);
	if (m < 60) return t('{count} min ago', { count: m });
	const h = Math.round(m / 60);
	if (h < 24) return t('{count} h ago', { count: h });
	const d = Math.round(h / 24);
	return d === 1 ? t('yesterday') : tn('{count} day ago', '{count} days ago', d);
}

const fixed = (n: number, digits: number) => n.toLocaleString(tag(), { minimumFractionDigits: digits, maximumFractionDigits: digits });

export function bytes(n: number): string {
	if (n < 1024) return t('{size} B', { size: count(n) });
	if (n < 1024 * 1024) return t('{size} KB', { size: fixed(n / 1024, n < 10 * 1024 ? 1 : 0) });
	return t('{size} MB', { size: fixed(n / 1024 / 1024, 1) });
}

export function count(n: number): string {
	return n.toLocaleString(tag());
}

/** Yards to miles past a mile, as players think of distance. */
export function distance(yards: number): string {
	if (yards < 1760) return tn('{count} yd', '{count} yd', Math.round(yards));
	const miles = yards / 1760;
	const digits = yards < 17600 ? 1 : 0;
	return tn('{count} mile', '{count} miles', Number(miles.toFixed(digits)), { count: fixed(miles, digits) });
}

export function duration(seconds: number): string {
	const m = Math.round(seconds / 60);
	if (m < 60) return t('{minutes} min', { minutes: m });
	const h = Math.floor(m / 60);
	return m % 60 ? t('{hours} h {minutes} min', { hours: h, minutes: m % 60 }) : t('{hours} h', { hours: h });
}

// English keeps the 24-hour clock and "Mon 3 Nov" it always had; other languages write dates
// their own way.
const dateTag = () => (locale() === 'enUS' ? 'en-GB' : tag());
const formats = new Map<string, Intl.DateTimeFormat>();
function format(kind: 'day' | 'clock' | 'clockSeconds'): Intl.DateTimeFormat {
	const key = `${dateTag()} ${kind}`;
	let f = formats.get(key);
	if (!f) {
		const options: Intl.DateTimeFormatOptions =
			kind === 'day' ? { weekday: 'short', day: 'numeric', month: 'short' } : kind === 'clock' ? { hour: '2-digit', minute: '2-digit' } : { hour: '2-digit', minute: '2-digit', second: '2-digit' };
		f = new Intl.DateTimeFormat(dateTag(), options);
		formats.set(key, f);
	}
	return f;
}

/** "Today 14:02", "Yesterday 09:10", "Mon 3 Nov 18:40". */
export function when(ms: number, now: number): string {
	const date = new Date(ms);
	const today = new Date(now);
	const days = Math.round((new Date(today.toDateString()).getTime() - new Date(date.toDateString()).getTime()) / 86_400_000);
	const time = format('clock').format(date);
	if (days === 0) return t('Today {time}', { time });
	if (days === 1) return t('Yesterday {time}', { time });
	return t('{day} {time}', { day: format('day').format(date), time });
}

export function time(epochSeconds: number): string {
	return format('clockSeconds').format(new Date(epochSeconds * 1000));
}

/** A date alone, as "3 Nov 2026" (or the language's own way). */
export function date(ms: number | Date, options: Intl.DateTimeFormatOptions = { day: 'numeric', month: 'short', year: 'numeric' }): string {
	return new Intl.DateTimeFormat(dateTag(), options).format(ms);
}

// The client's file tokens (UnitRace / UnitClass second returns) as players say them; in another
// language, as that language's game client names them.
const RACES: Record<string, string> = {
	Human: msg('Human'),
	Dwarf: msg('Dwarf'),
	NightElf: msg('Night Elf'),
	Gnome: msg('Gnome'),
	Orc: msg('Orc'),
	Scourge: msg('Undead'),
	Tauren: msg('Tauren'),
	Troll: msg('Troll'),
	BloodElf: msg('Blood Elf'),
	Draenei: msg('Draenei'),
};

const CLASSES: Record<string, string> = {
	WARRIOR: msg('Warrior'),
	PALADIN: msg('Paladin'),
	HUNTER: msg('Hunter'),
	ROGUE: msg('Rogue'),
	PRIEST: msg('Priest'),
	SHAMAN: msg('Shaman'),
	MAGE: msg('Mage'),
	WARLOCK: msg('Warlock'),
	DRUID: msg('Druid'),
	DEATHKNIGHT: msg('Death Knight'),
};

export function race(token: string): string {
	return RACES[token] ? t(RACES[token]) : token.replace(/([a-z])([A-Z])/g, '$1 $2');
}

export function className(token: string): string {
	if (CLASSES[token]) return t(CLASSES[token]);
	return token ? token.charAt(0) + token.slice(1).toLowerCase() : token;
}

/** A path for a `.path` box (direction: rtl, so a long path loses its start, not its end):
 * left-to-right marks on both ends keep its leading slash or drive letter and a trailing
 * `_` or `\` in place. */
export function ltr(path: string): string {
	return `\u200e${path}\u200e`;
}
