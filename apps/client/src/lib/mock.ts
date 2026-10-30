// DEV ONLY: answers the backend's commands when the page runs in a plain
// browser under `vite dev`, so every screen can be looked at without Tauri.
// backend.ts imports this only behind `import.meta.env.DEV`, so production
// builds never contain it. Pick a state with `?state=`:
//   setup (default: one install found), setup-none, setup-problem,
//   setup-saved (the saved folder broke; other installs found), setup-two,
//   setup-scanning, optin, home, registering, uploading, offline, paused,
//   attention, empty, running, community-off (no signing key pinned),
//   community-link (a polestar://install link waiting), community-bad-link,
//   custom (a custom community site and recording server),
//   recorder-update (an old-format file; a newer Recorder is published),
//   recorder-reload (an old-format file; the latest Recorder is installed but
//   hasn't run yet), recorder-next (an old-format file; no published Recorder
//   records the new format yet)

import type { ActivityEntry, Pack, Preview, Product, Snapshot, Summary } from './types';

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

const params = new URLSearchParams(location.search);
const scene = params.get('state') ?? 'setup';
const now = Date.now();
const MIN = 60_000;
/** A placeholder for the backend's DEFAULT_SERVER (src-tauri/src/store.rs), which holds the real address. */
const MOCK_SERVER = 'https://data.polestar.guide';

const week: Summary = {
	chunks: 46,
	records: 5212,
	byKind: { pos: 3120, unit: 610, kill: 412, loot: 288, accept: 31, turnin: 27, offer: 64, vendor: 9, trainer: 3 },
	skippedUnknown: 0,
	questsAccepted: 31,
	questsTurnedIn: 27,
	quests: 38,
	kills: 412,
	lootWindows: 288,
	uniqueCreatures: 74,
	vendors: 9,
	trainers: 3,
	flightmasters: 4,
	deaths: 2,
	distanceYards: 41_830,
	first: now / 1000 - 5 * 86400,
	last: now / 1000 - 3600,
	seconds: 9 * 3600 + 25 * 60,
	characters: [
		{ charId: 'a8k2m0q1z9', race: 'Orc', class: 'WARRIOR', faction: 'Horde', levelMin: 18, levelMax: 23, chunks: 30 },
		{ charId: 'p3x7c2v6b1', race: 'Scourge', class: 'PRIEST', faction: 'Horde', levelMin: 9, levelMax: 11, chunks: 16 },
	],
};

const base: Snapshot = {
	version: '0.1.0',
	setupDone: true,
	consent: true,
	paused: false,
	serverUrl: MOCK_SERVER,
	defaultServerUrl: MOCK_SERVER,
	dataDir: '/home/player/.local/share/gg.polestar.client',
	game: {
		found: true,
		scanned: true,
		root: '/home/player/Games/wow-forever/drive_c/Program Files (x86)/World of Warcraft',
		dir: '/home/player/Games/wow-forever/drive_c/Program Files (x86)/World of Warcraft/_forever_',
		gameVersion: '1.15.7.61582',
		chosen: null,
		problem: null,
		candidates: [{ root: '/home/player/Games/wow-forever/drive_c/Program Files (x86)/World of Warcraft', dir: '/home/player/Games/wow-forever/drive_c/Program Files (x86)/World of Warcraft/_forever_', client: '_forever_', version: '1.15.7.61582', accounts: 2, addonVersion: '0.3.0' }],
		addon: { installed: true, version: '0.3.0', latest: '0.3.0', updateAvailable: false },
		accounts: [
			{ name: 'WOW1', hasFile: true, recording: true, pending: 0, characters: 3, problem: null },
			{ name: 'WOW2', hasFile: false, recording: null, pending: 0, characters: 1, problem: null },
		],
		running: false,
	},
	status: { kind: 'watching', title: 'Sharing on', detail: 'New play is sent a few seconds after you log out or type /reload.', action: null, lastUpload: now - 4 * MIN, nextRetry: null },
	pending: 0,
	week,
	addons: {
		checkedAt: now - 12 * MIN,
		checking: false,
		error: null,
		channel: 'stable',
		autoCheck: true,
		autoInstall: false,
		gameFound: true,
		gameRunning: scene === 'running',
		products: [
			{
				id: 'polestar',
				name: 'Polestar',
				blurb: 'Leveling guides, the arrow, Lookup, Dungeons and Rares',
				installed: '0.2.6',
				latest: { version: '0.2.7', tag: 'v0.2.7', title: 'Polestar 0.2.7', pageUrl: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.7', publishedAt: new Date(now - 2 * 86_400_000).toISOString(), prerelease: false },
				status: 'update',
				busy: null,
				progress: null,
			},
			{
				id: 'recorder',
				name: 'Polestar Recorder',
				blurb: 'Records your play for the recording program (off until you turn it on)',
				installed: '0.3.0',
				latest: { version: '0.3.0', tag: 'v0.2.7', title: 'Polestar 0.2.7', pageUrl: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.7', publishedAt: new Date(now - 2 * 86_400_000).toISOString(), prerelease: false },
				status: 'upToDate',
				busy: null,
				progress: null,
			},
			{
				id: 'libforeverdata',
				name: 'LibForeverData',
				blurb: "WoW: Forever's quests, NPCs and items as a library for other addons",
				installed: null,
				latest: { version: '1.2026.10.1', tag: 'lib-v1.2026.10.1', title: 'LibForeverData 1.2026.10.1', pageUrl: 'https://github.com/fitzforge/polestar/releases/tag/lib-v1.2026.10.1', publishedAt: new Date(now - 9 * 86_400_000).toISOString(), prerelease: false },
				status: 'install',
				busy: null,
				progress: null,
			},
		],
	},
	community: {
		available: scene !== 'community-off',
		site: 'polestar.guide',
		base: 'https://polestar.guide',
		defaultBase: 'https://polestar.guide',
		telemetry: false,
		autoUpdate: false,
		checkedAt: now - 20 * MIN,
		checking: false,
		error: null,
		gameFound: true,
		gameRunning: scene === 'running',
		packs: scene === 'community-off' ? [] : mockPacks(),
		link: scene === 'community-link' ? { seq: 1, pack: 'emberway', error: null } : scene === 'community-bad-link' ? { seq: 1, pack: null, error: '"Ember_Way" isn\'t a guide name: they are 2 to 32 lowercase letters, digits and dashes. Copy the link from the guide\'s page on polestar.guide again.' } : null,
	},
	update: null,
	custom: { community: null, server: null },
};

function mockPacks(): Pack[] {
	const pack = (id: string, title: string, author: string, version: string | null, size: number, extra: Partial<Pack> = {}): Pack => ({
		id,
		title,
		author,
		version,
		installed: null,
		status: 'install',
		blocked: null,
		size,
		folders: [`PolestarPack_${id}`],
		homepage: null,
		changelog: 'First release.',
		official: false,
		busy: null,
		progress: null,
		revoked: null,
		changes: null,
		publisher: author,
		reviewed: false,
		published: now - 3 * 86_400_000,
		...extra,
	});
	return [
		pack('lightforge', 'Lightforge Leveling', 'Brannis', '1.2.0', 9671, { installed: '1.1.0', status: 'update', reviewed: true, changelog: '## 1.2.0\n\n- Westfall: the Defias loop now ends at Sentinel Hill.\n- Fewer runs back to Goldshire.' }),
		pack('wayfarer', "Wayfarer's Atlas", 'Odile', '1.0.0', 7330, { installed: '1.0.0', status: 'upToDate', homepage: 'https://example.org/wayfarer', folders: ['PolestarPack_wayfarer', 'PolestarPack_wayfarer_deDE'] }),
		pack('stonetalon', 'Stonetalon Shortcuts', 'Rhea', '2.0.0', 8120, {
			installed: '1.4.0',
			status: 'update',
			publisher: 'rhea-guides',
			folders: ['PolestarPack_stonetalon', 'PolestarPack_stonetalon_maps'],
			changes: { replaced: false, publisher: { from: 'Rhea', to: 'rhea-guides' }, added: ['PolestarPack_stonetalon_maps'], removed: [] },
		}),
		pack('barrens-run', 'Barrens Run', 'Quill', '3.0.0', 11_040, {
			installed: '1.3.2',
			status: 'replaced',
			publisher: 'quickpath',
			changes: { replaced: true, publisher: { from: 'Grell', to: 'quickpath' }, added: [], removed: [] },
		}),
		pack('moonrise', 'Moonrise Questing', 'Selka', null, 0, {
			installed: '0.9.0',
			status: 'disabled',
			size: null,
			changelog: null,
			revoked: { reason: 'This version sends players into an unwinnable escort loop.', at: now - 2 * 60 * MIN, action: 'disable' },
		}),
		pack('ashfall', 'Ashfall Dailies', 'Varn', '1.1.0', 6400, {
			installed: '1.0.0',
			status: 'removed',
			revoked: { reason: 'Taken down: it copied another guide without permission.', at: now - 26 * 60 * MIN, action: 'remove' },
		}),
		pack('durotar-dash', 'Durotar Dash', 'Tester', '1.0.0', 10_311),
		pack('emberway', 'Emberway Routes', 'Ashka', '1.0.0', 10_251, { official: true, reviewed: true }),
		pack('hearthside', 'Hearthside Professions', 'Mira', '1.0.0', 12_169, { blocked: 'Needs Polestar 0.2.8 or newer; you have 0.2.6. Update it on the Addons page.' }),
		pack('ironvault', 'Ironvault Dungeons', 'Kel', '1.0.0', 6958),
	];
}

function initial(): Snapshot {
	const s: Snapshot = structuredClone(base);
	switch (scene) {
		case 'setup':
		case 'setup-none':
		case 'setup-problem':
		case 'setup-saved':
		case 'setup-two':
		case 'setup-scanning':
		case 'optin':
			s.consent = false;
			s.setupDone = scene === 'optin';
			s.status = { ...s.status, kind: 'off', title: 'Sharing is off', detail: "Nothing is sent. Opt in under Recording to help improve Polestar's guides.", lastUpload: null };
			s.week = null;
			if (scene === 'optin') {
				s.addons.products[1] = { ...s.addons.products[1], installed: null, status: 'install' };
			}
			if (scene === 'setup-two' || scene === 'setup-saved') {
				const root = s.game.candidates[0].root;
				s.game.candidates.push({ root, dir: `${root}/_classic_beta_`, client: '_classic_beta_', version: '1.15.8.62001', accounts: 0, addonVersion: null });
			}
			if (scene === 'setup-none' || scene === 'setup-problem' || scene === 'setup-saved' || scene === 'setup-scanning') {
				s.game = { ...s.game, found: false, root: null, dir: null, gameVersion: null, candidates: scene === 'setup-saved' ? s.game.candidates : [], addon: null, accounts: [] };
			}
			if (scene === 'setup-scanning') s.game.scanned = false;
			if (scene === 'setup-problem') {
				s.game.problem = {
					path: 'C:\\Program Files (x86)\\World of Warcraft\\_classic_era_',
					message: 'This is the Classic Era client (_classic_era_), not WoW: Forever. Pick the World of Warcraft folder that holds _forever_, or its _forever_ folder.',
				};
			}
			if (scene === 'setup-saved') {
				s.game.problem = { path: '/home/player/Old Games/World of Warcraft', message: 'This folder no longer exists.' };
			}
			break;
		case 'uploading':
			s.status = { ...s.status, kind: 'uploading', title: 'Sending', detail: 'Sending your latest play.' };
			s.pending = 12;
			break;
		case 'registering':
			s.status = { ...s.status, kind: 'uploading', title: 'Setting up', detail: 'Setting up this PC with the Polestar server. It takes a few seconds, once.', lastUpload: null };
			s.week = null;
			s.pending = 12;
			break;
		case 'offline':
			s.status = { ...s.status, kind: 'offline', title: "Can't reach the server", detail: "Can't reach the recording server. Check your internet connection.", action: 'retry', nextRetry: now + 40_000, lastUpload: now - 3 * 60 * MIN };
			s.pending = 12;
			s.game.accounts[0].pending = 12;
			break;
		case 'paused':
			s.paused = true;
			s.status = { ...s.status, kind: 'paused', title: 'Uploads paused', detail: 'Your play waits on this PC until you resume. The Recorder keeps recording in the game.', action: 'resume' };
			s.pending = 12;
			s.game.accounts[0].pending = 12;
			break;
		case 'attention':
			s.game.addon = { installed: false, version: null, latest: '0.3.0', updateAvailable: false };
			s.status = { ...s.status, kind: 'attention', title: 'The Recorder addon is not installed', detail: 'Install it, then log in to the game. While sharing is on, the Recorder records by itself.', action: 'install' };
			break;
		case 'recorder-update':
			s.game.addon = { installed: true, version: '0.2.6', latest: '0.3.0', updateAvailable: true };
			s.status = { ...s.status, kind: 'attention', title: 'The Recorder is out of date', detail: 'Update it so it records in the format the server reads.', action: 'update' };
			break;
		case 'recorder-reload':
			s.status = { ...s.status, kind: 'waiting', title: 'Waiting for the new Recorder to run', detail: 'Log in (or /reload) with the Recorder on to start recording in the new format.', action: null };
			break;
		case 'recorder-next':
			s.game.addon = { installed: true, version: '0.2.6', latest: '0.2.6', updateAvailable: false };
			s.status = { ...s.status, kind: 'attention', title: 'The Recorder is out of date', detail: 'It records in an older format the server no longer reads. The new Recorder comes with the next Polestar update.', action: null };
			break;
		case 'empty':
			s.week = null;
			s.status = { ...s.status, lastUpload: null };
			break;
		case 'custom':
			s.custom = { community: 'https://guides.example.net', server: 'https://data.example.net:8443' };
			s.community.base = 'https://guides.example.net';
			s.community.site = 'guides.example.net';
			s.serverUrl = 'https://data.example.net:8443';
			break;
		case 'home':
		default:
			s.pending = 12;
			s.game.accounts[0].pending = 12;
	}
	return s;
}

let snapshot = initial();
const listeners = new Set<(s: Snapshot) => void>();
const emit = () => listeners.forEach((l) => l(structuredClone(snapshot)));

const activity: ActivityEntry[] =
	scene === 'empty'
		? []
		: [
				{ kind: 'upload', at: now - 4 * MIN, account: 'WOW1', chunks: 9, records: 1043, bytes: 61_420, accepted: [31, 32, 33, 34, 35, 36, 37, 38, 39], duplicate: [], rejected: [], message: null },
				{ kind: 'upload', at: now - 3 * 60 * MIN, account: 'WOW1', chunks: 6, records: 702, bytes: 40_210, accepted: [25, 26, 27, 28, 29], duplicate: [], rejected: [{ seq: 30, reason: 'record 14 (loot): items is not a list of itemId:count' }], message: null },
				{ kind: 'failed', at: now - 3 * 60 * MIN - 9 * MIN, account: 'WOW1', chunks: 6, records: 702, bytes: 40_210, accepted: [], duplicate: [], rejected: [], message: 'Can\'t reach the recording server. Check your internet connection.' },
				{ kind: 'update', at: now - 20 * 60 * MIN, account: '', chunks: 0, records: 0, bytes: 0, accepted: [], duplicate: [], rejected: [], message: null, product: 'Polestar Recorder', version: '0.3.0' },
				{ kind: 'install', at: now - 22 * 60 * MIN, account: '', chunks: 0, records: 0, bytes: 0, accepted: [], duplicate: [], rejected: [], message: 'Downloading Polestar-0.2.7.zip failed: connection reset by peer', product: 'Polestar', version: '0.2.7' },
				{ kind: 'disabled', at: now - 2 * 60 * MIN, account: '', chunks: 0, records: 0, bytes: 0, accepted: [], duplicate: [], rejected: [], message: 'This version sends players into an unwinnable escort loop.', product: 'Moonrise Questing', version: '0.9.0' },
				{ kind: 'restored', at: now - 2 * 60 * MIN + 30_000, account: '', chunks: 0, records: 0, bytes: 0, accepted: [], duplicate: [], rejected: [], message: 'Moonrise Questing 0.9.0 is still turned off by polestar.guide, so it stays off.', product: 'Moonrise Questing', version: '0.9.0' },
				{ kind: 'removed', at: now - 26 * 60 * MIN + 60_000, account: '', chunks: 0, records: 0, bytes: 0, accepted: [], duplicate: [], rejected: [], message: 'Taken down: it copied another guide without permission.', product: 'Ashfall Dailies', version: '1.0.0' },
				{ kind: 'upload', at: now - 26 * 60 * MIN, account: 'WOW1', chunks: 14, records: 1820, bytes: 98_011, accepted: [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22], duplicate: [23, 24], rejected: [], message: null },
				{ kind: 'upload', at: now - 3 * 24 * 60 * MIN, account: 'WOW1', chunks: 10, records: 1647, bytes: 84_930, accepted: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], duplicate: [], rejected: [], message: null },
			];

function preview(): Preview {
	if (snapshot.pending === 0) return { chunks: 0, bytes: 0, requests: 0, summary: null, records: [], totalRecords: 0, problems: [], json: '[]' };
	const t0 = Math.floor(now / 1000) - 1800;
	const kinds: [string, [string, string][]][] = [
		['session', [['charId', 'a8k2m0q1z9'], ['race', 'Orc'], ['class', 'WARRIOR'], ['faction', 'Horde'], ['sex', '2'], ['level', '23'], ['locale', 'enUS'], ['build', '61582'], ['interface', '11507'], ['region', '3'], ['ruleset', ''], ['recorderVersion', '0.3.0'], ['polestarVersion', '0.2.6'], ['packs', 'guide:barrens-19-24']]],
		['pos', [['map', '1413'], ['x', '5132'], ['y', '3388'], ['flags', '1'], ['speed', '140']]],
		['unit', [['npcId', '3425'], ['level', '17'], ['cls', 'n'], ['react', 'h'], ['map', '1413'], ['x', '5208'], ['y', '3412'], ['src', 'p']]],
		['kill', [['npcId', '3425'], ['level', '17'], ['cls', 'n'], ['map', '1413'], ['x', '5214'], ['y', '3420'], ['xp', '168'], ['rested', ''], ['tapped', '0'], ['q', '']]],
		['loot', [['srcKind', 'c'], ['srcId', '3425'], ['map', '1413'], ['x', '5214'], ['y', '3420'], ['gather', ''], ['items', '5085:1;2318:1'], ['wanted', '821:1']]],
		['accept', [['q', '855'], ['npcKind', 'c'], ['npcId', '3389'], ['map', '1413'], ['x', '5232'], ['y', '3060'], ['level', '23'], ['rewardXp', '1550'], ['rewardMoney', '1200'], ['items', ''], ['choices', '5321:1;5322:1']]],
		['text', [['q', '855'], ['title', 'Centaur Bracers'], ['objectiveText', 'Bring 15 Centaur Ear to Regthar Deathgate.'], ['detailText', 'The Kolkar grow bold, $N. Bring me proof of their fall.']]],
		['vendor', [['npcId', '3480'], ['map', '1413'], ['x', '5191'], ['y', '3017'], ['items', '4470:38:1:-1;159:5:1:-1;4540:25:1:-1']]],
	];
	const records = Array.from({ length: 340 }, (_, i) => {
		const [kind, fields] = kinds[i === 0 ? 0 : 1 + (i % (kinds.length - 1))];
		return { seq: 40 + Math.floor(i / 30), kind, t: t0 + i * 5, fields };
	});
	const request = {
		uploader: '0.1.0',
		install: 'k3j9x0q2m7ab',
		chunks: [{ seq: 40, text: 'chunk\t0\t40\t1761562800\ta8k2m0q1z9\nsession\t0\ta8k2m0q1z9\tOrc\tWARRIOR\tHorde\t2\t23\tenUS\t61582\t11507\t3\t\t0.3.0\t0.2.6\tguide:barrens-19-24\npos\t12\t1413\t5132\t3388\t1\t140\n…' }],
	};
	return {
		chunks: snapshot.pending,
		bytes: 73_204,
		requests: 1,
		summary: { ...week, chunks: 12, records: 1288, questsAccepted: 6, questsTurnedIn: 5, kills: 94, lootWindows: 61, uniqueCreatures: 18, vendors: 2, trainers: 1, distanceYards: 6_120, seconds: 3 * 3600 + 5 * 60, characters: [week.characters[0]] },
		records,
		totalRecords: 1288,
		problems: [],
		json: JSON.stringify([request], null, 2),
	};
}

const commands: Record<string, (args: Record<string, unknown>) => unknown> = {
	snapshot: () => structuredClone(snapshot),
	rescan: () => undefined,
	choose_folder: (a) => ({ path: a.path, problem: null }),
	pick_folder: () =>
		scene === 'setup-problem'
			? { path: 'C:\\Games\\Downloads', problem: "This folder isn't World of Warcraft: there is no Wow.exe, _forever_ or _classic_ folder in it." }
			: null,
	check_addons: async () => {
		snapshot.addons.checking = true;
		emit();
		await sleep(900);
		snapshot.addons.checking = false;
		snapshot.addons.checkedAt = Date.now();
		emit();
	},
	addon_action: async (a) => {
		const p = snapshot.addons.products.find((x) => x.id === a.id)!;
		p.busy = a.action as Product['busy'];
		if (a.action === 'uninstall') {
			p.progress = { phase: 'remove', done: 0, total: null };
			emit();
			await sleep(700);
		} else {
			const total = 9_400_000;
			for (let done = 0; done <= total; done += total / 12) {
				p.progress = { phase: 'download', done, total };
				emit();
				await sleep(140);
			}
			for (const phase of ['verify', 'install'] as const) {
				p.progress = { phase, done: 0, total: null };
				emit();
				await sleep(500);
			}
		}
		p.busy = null;
		p.progress = null;
		if (a.action === 'uninstall') {
			p.installed = null;
			p.status = 'install';
		} else {
			p.installed = p.latest!.version;
			p.status = 'upToDate';
		}
		emit();
		return a.action === 'uninstall' ? `${p.name} removed.` : `${p.name} ${p.installed} installed. Restart the game (or /reload) to load it.`;
	},
	update_all: () => commands.addon_action({ id: 'polestar', action: 'update' }),
	check_packs: async () => {
		snapshot.community.checking = true;
		emit();
		await sleep(700);
		snapshot.community.checking = false;
		snapshot.community.checkedAt = Date.now();
		emit();
	},
	pack_action: async (a) => {
		const p = snapshot.community.packs.find((x) => x.id === a.id)!;
		if (a.action === 'update' && p.changes && !a.confirm) {
			throw `${p.title} ${p.version} isn't a routine update; confirm it first.`;
		}
		if (a.action === 'discard') {
			snapshot.community.packs = snapshot.community.packs
				.map((x) => (x.id === p.id ? { ...x, installed: null, status: 'install' as const, revoked: null } : x))
				.filter((x) => x.id !== p.id || x.version !== null);
			emit();
			return p.status === 'removed' ? `Dismissed the notice for ${p.title}.` : `Deleted the kept copy of ${p.title}.`;
		}
		p.busy = a.action as Pack['busy'];
		if (a.action === 'uninstall' || a.action === 'restore') {
			p.progress = { phase: a.action === 'restore' ? 'install' : 'remove', done: 0, total: null };
			emit();
			await sleep(600);
		} else {
			const total = p.size ?? 10_000;
			for (let done = 0; done <= total; done += total / 8) {
				p.progress = { phase: 'download', done, total };
				emit();
				await sleep(120);
			}
			for (const phase of ['verify', 'install'] as const) {
				p.progress = { phase, done: 0, total: null };
				emit();
				await sleep(400);
			}
		}
		p.busy = null;
		p.progress = null;
		if (a.action === 'restore') {
			p.status = p.version && p.version !== p.installed ? 'update' : 'upToDate';
			p.revoked = null;
			emit();
			return `${p.title} ${p.installed} restored. Restart the game (or /reload) to load it.`;
		}
		p.installed = a.action === 'uninstall' ? null : p.version;
		p.status = a.action === 'uninstall' ? 'install' : 'upToDate';
		p.revoked = null;
		p.changes = null;
		emit();
		return a.action === 'uninstall' ? `${p.title} removed.` : `${p.title} ${p.version} installed. Restart the game (or /reload) to load it.`;
	},
	set_pack_auto_update: (a) => {
		snapshot.community.autoUpdate = a.enabled as boolean;
		emit();
	},
	set_pack_telemetry: (a) => {
		snapshot.community.telemetry = a.enabled as boolean;
		emit();
	},
	set_packs_url: (a) => a.url,
	pack_link_done: () => {
		snapshot.community.link = null;
		emit();
	},
	changelog: (a) => ({
		name: snapshot.addons.products.find((x) => x.id === a.id)!.name,
		title: 'Polestar 0.2.7',
		version: '0.2.7',
		publishedAt: new Date(now - 2 * 86_400_000).toISOString(),
		pageUrl: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.7',
		body: "## For players\n\n- The Barrens: **Lost in Battle** now waits for Mankrik's wife, so the route no longer walks past her.\n- The arrow takes the Crossroads flight when it saves more than a minute.\n- Lookup shows each rare's respawn window (thanks Tom).\n\n## Install\n\nDownload `Polestar-0.2.7.zip` below, or let [Polestar Client](https://github.com/fitzforge/polestar/tree/next/apps/client) do it.\n\n<script>alert(1)</script>",
	}),
	set_addon_prefs: (a) => {
		Object.assign(snapshot.addons, Object.fromEntries(Object.entries(a).filter(([, v]) => v !== undefined)));
		emit();
	},
	finish_setup: () => {
		snapshot.setupDone = true;
		emit();
	},
	set_sharing: (a) => {
		snapshot = a.enabled ? { ...structuredClone(base), pending: 0 } : { ...snapshot, consent: false, status: { ...snapshot.status, kind: 'off', title: 'Sharing is off', detail: '', action: null } };
		emit();
	},
	set_paused: (a) => {
		snapshot.paused = a.paused as boolean;
		snapshot.status = a.paused
			? { ...snapshot.status, kind: 'paused', title: 'Uploads paused', detail: 'Your play waits on this PC until you resume. The Recorder keeps recording in the game.', action: 'resume' }
			: structuredClone(base.status);
		emit();
	},
	get_autostart: () => false,
	set_autostart: () => undefined,
	set_server_url: (a) => a.url,
	delete_server_data: () => undefined,
	activity: () => activity,
	preview: () => preview(),
	retry_now: () => undefined,
	open_data_folder: () => undefined,
	open_link: (a) => void window.open(a.url as string, '_blank'),
	check_update: () => null,
	install_update: () => undefined,
	diagnostics: () => ({ renderer: 'browser (vite dev, mock backend)', frameMeter: params.has('meter') }),
	window_ready: () => true,
	client_log: (a) => void console.debug(a.line),
};

export const bridge = {
	async invoke<T>(cmd: string, args: Record<string, unknown> = {}): Promise<T> {
		const command = commands[cmd];
		if (!command) throw `mock: no command ${cmd}`;
		return command(args) as T;
	},
	async listen<T>(event: string, handler: (payload: T) => void): Promise<() => void> {
		if (event !== 'snapshot') return () => {};
		const l = handler as unknown as (s: Snapshot) => void;
		listeners.add(l);
		return () => listeners.delete(l);
	},
};
