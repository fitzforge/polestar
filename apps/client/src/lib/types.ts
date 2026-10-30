// The shapes the Rust backend sends (src-tauri/src/engine.rs, store.rs).

export type StatusKind = 'off' | 'watching' | 'uploading' | 'waiting' | 'offline' | 'paused' | 'rejected' | 'attention';
export type StatusAction = 'retry' | 'resume' | 'install' | 'update' | 'locate';

export interface Status {
	kind: StatusKind;
	title: string;
	detail: string;
	action: StatusAction | null;
	lastUpload: number | null;
	nextRetry: number | null;
}

export interface Addon {
	installed: boolean;
	version: string | null;
	latest: string | null;
	updateAvailable: boolean;
}

export interface Account {
	/** The WoW account folder's name: shown on this PC only. */
	name: string;
	hasFile: boolean;
	recording: boolean | null;
	pending: number;
	characters: number;
	problem: string | null;
}

export interface Candidate {
	root: string;
	/** The client folder (`<root>/_forever_`): unique per candidate, what choosing it saves. */
	dir: string;
	/** The client folder's name (`_forever_`, `_classic_beta_`). */
	client: string;
	version: string | null;
	accounts: number;
	addonVersion: string | null;
}

export interface Game {
	found: boolean;
	/** The first look for the game has finished. */
	scanned: boolean;
	root: string | null;
	/** The client folder in use. */
	dir: string | null;
	gameVersion: string | null;
	chosen: string | null;
	problem: { path: string; message: string } | null;
	candidates: Candidate[];
	addon: Addon | null;
	accounts: Account[];
	running: boolean;
}

export interface CharacterSummary {
	charId: string;
	race: string;
	class: string;
	faction: string;
	levelMin: number | null;
	levelMax: number | null;
	chunks: number;
}

/** polestar-recording's summary::Summary. */
export interface Summary {
	chunks: number;
	records: number;
	byKind: Record<string, number>;
	skippedUnknown: number;
	questsAccepted: number;
	questsTurnedIn: number;
	quests: number;
	kills: number;
	lootWindows: number;
	uniqueCreatures: number;
	vendors: number;
	trainers: number;
	flightmasters: number;
	deaths: number;
	distanceYards: number;
	first: number | null;
	last: number | null;
	seconds: number;
	characters: CharacterSummary[];
}

/** An addon release on GitHub (src-tauri/src/addons.rs Release). */
export interface Release {
	version: string;
	tag: string;
	title: string;
	pageUrl: string;
	publishedAt: string | null;
	prerelease: boolean;
}

export type ProductStatus = 'noGame' | 'unknown' | 'unavailable' | 'install' | 'update' | 'upToDate';
export type AddonAction = 'install' | 'update' | 'repair' | 'uninstall';

export interface Product {
	id: string;
	name: string;
	blurb: string;
	installed: string | null;
	latest: Release | null;
	status: ProductStatus;
	busy: AddonAction | null;
	/** How far the action under way has got (src-tauri/src/addons.rs Progress). */
	progress: Progress | null;
}

/** `download` counts bytes (`total` when the server gave a length); the other phases have no count. */
export interface Progress {
	phase: 'download' | 'verify' | 'install' | 'remove';
	done: number;
	total: number | null;
}

export type Channel = 'stable' | 'beta';

export interface Addons {
	checkedAt: number | null;
	checking: boolean;
	error: string | null;
	channel: Channel;
	autoCheck: boolean;
	autoInstall: boolean;
	gameFound: boolean;
	gameRunning: boolean;
	products: Product[];
}

export interface Changelog {
	name: string;
	title: string;
	version: string;
	publishedAt: string | null;
	body: string;
	pageUrl: string;
	/** The footer link's words; "Open the release on GitHub" when absent. */
	pageLabel?: string;
}

/** A community pack (src-tauri/src/community.rs PackView). */
export type PackStatus = 'install' | 'update' | 'upToDate' | 'unlisted' | 'noGame' | 'replaced' | 'disabled' | 'removed';
export type PackAction = 'install' | 'update' | 'uninstall' | 'restore' | 'discard';

/** The community site turned the installed version off, or removed it. */
export interface PackRevoked {
	reason: string;
	at: number;
	action: 'disable' | 'remove';
}

/** What makes an update not routine; it needs `confirm: true`. */
export interface PackChanges {
	/** The pack under this id is a different guide. */
	replaced: boolean;
	/** Publisher handles. */
	publisher: { from: string | null; to: string | null } | null;
	added: string[];
	removed: string[];
}

export interface Pack {
	id: string;
	title: string;
	author: string;
	/** The version the index offers; null for a pack it no longer lists. */
	version: string | null;
	installed: string | null;
	status: PackStatus;
	/** Why it can't be installed or updated in this game now. */
	blocked: string | null;
	size: number | null;
	/** The folders it has, or will create. */
	folders: string[];
	homepage: string | null;
	changelog: string | null;
	official: boolean;
	busy: PackAction | null;
	progress: Progress | null;
	revoked: PackRevoked | null;
	/** null = a routine update: one click. */
	changes: PackChanges | null;
	/** The index's publisher handle. */
	publisher: string | null;
	reviewed: boolean;
	/** When this version became available, epoch ms. */
	published: number | null;
}

/** The last polestar:// link, until the page has opened it. */
export interface PackLink {
	seq: number;
	pack: string | null;
	error: string | null;
}

export interface Community {
	/** A signing key is pinned for this site; without one there are no community packs. */
	available: boolean;
	/** The site, as `polestar.guide`. */
	site: string;
	base: string;
	defaultBase: string;
	telemetry: boolean;
	checkedAt: number | null;
	checking: boolean;
	error: string | null;
	gameFound: boolean;
	gameRunning: boolean;
	/** Install routine pack updates by themselves. */
	autoUpdate: boolean;
	/** Installed packs first, then the others; each by title. */
	packs: Pack[];
	link: PackLink | null;
}

export interface Snapshot {
	version: string;
	/** The first-run setup (finding the game) is done. */
	setupDone: boolean;
	/** The player opted in to the recording program. */
	consent: boolean;
	paused: boolean;
	serverUrl: string;
	defaultServerUrl: string;
	dataDir: string;
	game: Game;
	status: Status;
	pending: number;
	week: Summary | null;
	addons: Addons;
	community: Community;
	update: string | null;
	/** The community site and recording server, when not the default. */
	custom: { community: string | null; server: string | null };
}

export interface Rejection {
	seq: number;
	reason: string;
}

export interface ActivityEntry {
	kind: 'upload' | 'failed' | 'deleted' | 'install' | 'update' | 'repair' | 'uninstall' | 'disabled' | 'removed' | 'restored';
	at: number;
	account: string;
	chunks: number;
	records: number;
	bytes: number;
	accepted: number[];
	duplicate: number[];
	rejected: Rejection[];
	message: string | null;
	product?: string | null;
	version?: string | null;
}

export interface RecordRow {
	seq: number;
	kind: string;
	t: number;
	fields: [string, string][];
}

export interface Preview {
	chunks: number;
	bytes: number;
	requests: number;
	summary: Summary | null;
	records: RecordRow[];
	totalRecords: number;
	problems: string[];
	json: string;
}

export interface FolderCheck {
	path: string;
	problem: string | null;
}
