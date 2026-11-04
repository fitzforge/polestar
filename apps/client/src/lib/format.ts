// Turning the backend's numbers and client tokens into words.

export function ago(ms: number, now: number): string {
	const s = Math.max(0, Math.round((now - ms) / 1000));
	if (s < 45) return 'just now';
	const m = Math.round(s / 60);
	if (m < 60) return `${m} min ago`;
	const h = Math.round(m / 60);
	if (h < 24) return `${h} h ago`;
	const d = Math.round(h / 24);
	return d === 1 ? 'yesterday' : `${d} days ago`;
}

export function bytes(n: number): string {
	if (n < 1024) return `${n} B`;
	if (n < 1024 * 1024) return `${(n / 1024).toFixed(n < 10 * 1024 ? 1 : 0)} KB`;
	return `${(n / 1024 / 1024).toFixed(1)} MB`;
}

export function count(n: number): string {
	return n.toLocaleString('en-US');
}

/** Yards to miles past a mile, as players think of distance. */
export function distance(yards: number): string {
	if (yards < 1760) return `${count(Math.round(yards))} yd`;
	return `${(yards / 1760).toFixed(yards < 17600 ? 1 : 0)} miles`;
}

export function duration(seconds: number): string {
	const m = Math.round(seconds / 60);
	if (m < 60) return `${m} min`;
	const h = Math.floor(m / 60);
	return m % 60 ? `${h} h ${m % 60} min` : `${h} h`;
}

const day = new Intl.DateTimeFormat('en-GB', { weekday: 'short', day: 'numeric', month: 'short' });
const clock = new Intl.DateTimeFormat('en-GB', { hour: '2-digit', minute: '2-digit' });
const clockSeconds = new Intl.DateTimeFormat('en-GB', { hour: '2-digit', minute: '2-digit', second: '2-digit' });

/** "Today 14:02", "Yesterday 09:10", "Mon 3 Nov 18:40". */
export function when(ms: number, now: number): string {
	const date = new Date(ms);
	const today = new Date(now);
	const days = Math.round((new Date(today.toDateString()).getTime() - new Date(date.toDateString()).getTime()) / 86_400_000);
	const prefix = days === 0 ? 'Today' : days === 1 ? 'Yesterday' : day.format(date);
	return `${prefix} ${clock.format(date)}`;
}

export function time(epochSeconds: number): string {
	return clockSeconds.format(new Date(epochSeconds * 1000));
}

// The client's file tokens (UnitRace / UnitClass second returns) as players say them.
const RACES: Record<string, string> = {
	Human: 'Human',
	Dwarf: 'Dwarf',
	NightElf: 'Night Elf',
	Gnome: 'Gnome',
	Orc: 'Orc',
	Scourge: 'Undead',
	Tauren: 'Tauren',
	Troll: 'Troll',
	BloodElf: 'Blood Elf',
	Draenei: 'Draenei',
};

export function race(token: string): string {
	return RACES[token] ?? token.replace(/([a-z])([A-Z])/g, '$1 $2');
}

export function className(token: string): string {
	return token ? token.charAt(0) + token.slice(1).toLowerCase() : token;
}

export function plural(n: number, one: string, many: string): string {
	return `${count(n)} ${n === 1 ? one : many}`;
}

/** A path for a `.path` box (direction: rtl, so a long path loses its start, not its end):
 * left-to-right marks on both ends keep its leading slash or drive letter and a trailing
 * `_` or `\` in place. */
export function ltr(path: string): string {
	return `\u200e${path}\u200e`;
}
