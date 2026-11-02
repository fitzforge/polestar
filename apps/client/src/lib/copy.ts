// What the program collects, in the words of docs/RECORDING.md ("What is
// never collected" is copied from it; keep the two in step). The texts are English:
// show them through t().

import { msg } from './i18n.svelte';

export const SOURCE_URL = 'https://github.com/fitzforge/polestar';
export const CONTRACT_URL = 'https://github.com/fitzforge/polestar/blob/next/docs/RECORDING.md';
export const CLIENT_URL = 'https://github.com/fitzforge/polestar/tree/next/apps/client';

export const NEVER = [
	msg('Character names, realm names and account names'),
	msg('Chat and whispers'),
	msg('Guild and friends, and other players’ names'),
	msg('Mail, auction and trade data'),
	msg('Anything you type, other than /psrec mark notes and /psrec trail labels'),
	msg('Anything from outside the game folder'),
	msg('Any kind of record this version of the client doesn’t know: it can’t check those, so it leaves them out'),
];

export const NEVER_NOTE = msg(
	"In quest and gossip text, your character's name, race and class are swapped for placeholders: in the addon, and again here before anything leaves your PC.",
);

export const COLLECTED = [
	{ glyph: 'icon-goto', text: msg('Where you go and how: map positions, flights, boats, zones, deaths') },
	{ glyph: 'icon-accept', text: msg('Quests: who offers them, objectives, progress, turn-ins, rewards and quest text') },
	{ glyph: 'icon-kill', text: msg('Creatures you meet and kill, their levels, and what they drop') },
	{ glyph: 'icon-vendor', text: msg('Vendors, trainers and flight masters, and what they offer') },
	{ glyph: 'icon-level', text: msg('Your character’s race, class, level and faction, and the game’s version') },
	{ glyph: 'flag', text: msg('Which Polestar guide step you were on') },
];
