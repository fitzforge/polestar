// What the program collects, in the words of docs/RECORDING.md ("What is
// never collected" is copied from it; keep the two in step).

export const SOURCE_URL = 'https://github.com/fitzforge/polestar';
export const CONTRACT_URL = 'https://github.com/fitzforge/polestar/blob/next/docs/RECORDING.md';
export const CLIENT_URL = 'https://github.com/fitzforge/polestar/tree/next/apps/client';

export const NEVER = [
	'Character names, realm names and account names',
	'Chat and whispers',
	'Guild and friends, and other players’ names',
	'Mail, auction and trade data',
	'Anything you type, other than /psrec mark notes and /psrec trail labels',
	'Anything from outside the game folder',
	'Any kind of record this version of the client doesn’t know: it can’t check those, so it leaves them out',
];

export const NEVER_NOTE =
	"In quest and gossip text, your character's name, race and class are swapped for placeholders: in the addon, and again here before anything leaves your PC.";

export const EXPLORER_NOTE =
	'In Forever’s new zones and dungeons the Recorder logs a little more about the game world while you record there, to map them: creatures seen and where, finer positions, the quest log’s map points, dungeon floors, boss pulls, the area each quest giver stands in and the objects you open. It says so in the game the first time and logs nothing more about you. Explorer mode in Settings, or /psrec explore off in the game, turns it off.';

export const COLLECTED = [
	{ glyph: 'icon-goto', text: 'Where you go and how: map positions, flights, boats, zones, deaths' },
	{ glyph: 'icon-accept', text: 'Quests: who offers them, objectives, progress, turn-ins, rewards and quest text' },
	{ glyph: 'icon-kill', text: 'Creatures you meet and kill, their levels, and what they drop' },
	{ glyph: 'icon-vendor', text: 'Vendors, trainers and flight masters, and what they offer' },
	{ glyph: 'icon-level', text: 'Your character’s race, class, level and faction, and the game’s version' },
	{ glyph: 'flag', text: 'Which Polestar guide step you were on' },
];
