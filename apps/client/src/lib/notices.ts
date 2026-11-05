// What the window says over every page, whatever page is on screen: a Client
// update waiting (the banner across the top) and, once, what sharing sends
// (the notice at the foot of the main column). tests/client-notices.test.js.

import type { Snapshot } from './types';

/** The Client version waiting to be installed, while there is one: the update banner offers it. */
export function updateBanner(s: Snapshot | null): string | null {
	return s?.update || null;
}

/** The sharing notice: once the game is found, while sharing is on and the player has not read it. */
export function shareNotice(s: Snapshot | null): boolean {
	return !!s && s.setupDone && s.consent && s.shareNotice;
}

/** A Client release's page on GitHub, with its notes. */
export function releaseUrl(version: string): string {
	return `https://github.com/fitzforge/polestar/releases/tag/client-v${encodeURIComponent(version)}`;
}
