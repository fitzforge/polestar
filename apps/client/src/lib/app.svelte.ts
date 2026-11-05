// The window's shared state: the backend's latest snapshot, the page on
// screen (and which way the last move went, for the page transition), a
// clock for "4 min ago", and the polestar:// link waiting for its sheet.

import { api } from './backend';
import { fault } from './fault';
import { afterIntro, appIsReady } from './intro.svelte';
import { tick } from 'svelte';
import type { PackLink, Snapshot } from './types';

/** The pages in sidebar order, top to bottom. */
export const SCREENS = ['addons', 'community', 'activity', 'home', 'sending', 'settings'] as const;
export type Screen = (typeof SCREENS)[number];

export const app = $state({
	snapshot: null as Snapshot | null,
	screen: 'addons' as Screen,
	/** 1 when the last move went down the sidebar, -1 up. */
	dir: 1,
	now: Date.now(),
	/** A polestar://install link the Community page asks about (never a silent install). */
	link: null as PackLink | null,
});

export function go(screen: Screen): void {
	if (screen === app.screen) return;
	app.dir = SCREENS.indexOf(screen) > SCREENS.indexOf(app.screen) ? 1 : -1;
	app.screen = screen;
}

/** How long the first snapshot may take before the window says so instead of staying empty. */
const FIRST_ANSWER_MS = 10_000;

let linkSeen = 0;
/** A new link opens the Community page on its pack once the intro has handed over (and once
 * the first-run setup is behind the player: until then it waits). A link to the pack whose
 * sheet is already open only counts as seen. */
async function takeLink(s: Snapshot): Promise<void> {
	const link = s.community.link;
	if (!link || !s.setupDone || link.seq <= linkSeen) return;
	linkSeen = link.seq;
	if (app.link && !link.error && app.link.pack === link.pack) {
		await api.packLinkDone(link.seq).catch(() => {});
		return;
	}
	await afterIntro();
	go('community');
	app.link = link;
	await api.packLinkDone(link.seq).catch(() => {});
}

function receive(s: Snapshot): void {
	app.snapshot = s;
	void takeLink(s);
}

export async function start(): Promise<void> {
	const late = setTimeout(
		() => app.snapshot || fault('Polestar Client is not answering', `The window asked the background service for its state ${FIRST_ANSWER_MS / 1000} seconds ago and has had no answer.`),
		FIRST_ANSWER_MS,
	);
	await api.onSnapshot(receive);
	const first = await api.snapshot();
	if (!app.snapshot) receive(first);
	clearTimeout(late);
	await tick();
	appIsReady();
	setInterval(() => (app.now = Date.now()), 1000);
}
