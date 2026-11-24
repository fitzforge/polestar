import type { Snapshot } from './types';

/** Addon updates: the Addons sidebar badge. */
export function addonUpdateCount(s: Snapshot): number {
	return s.addons.products.filter((p) => p.status === 'update').length;
}

/** Community guide updates the game can take, routine, waiting for confirmation or replaced (as community::pending
 *  announces them): the Community Guides sidebar badge. */
export function guideUpdateCount(s: Snapshot): number {
	return s.community.packs.filter((p) => (p.status === 'update' || p.status === 'replaced') && !p.blocked).length;
}

/** Routine community guide updates: the ones manager::update_all installs with the addons. */
function routineGuideCount(s: Snapshot): number {
	return s.community.packs.filter((p) => p.status === 'update' && !p.blocked && !p.changes).length;
}

/** Updates manager::update_all can install. Changed publishers or folders need separate confirmation. */
export function updateAllCount(s: Snapshot): number {
	return addonUpdateCount(s) + routineGuideCount(s);
}

const updates = (n: number, what: string) => `${n} ${what} ${n === 1 ? 'update' : 'updates'}`;

/** The Update all button's tooltip: what it installs, community guides included (#3832). */
export function updateAllTitle(s: Snapshot): string {
	const addons = addonUpdateCount(s);
	const routine = routineGuideCount(s);
	const parts = [addons && updates(addons, 'addon'), routine && updates(routine, 'community guide')].filter(Boolean);
	const held = guideUpdateCount(s) - routine;
	const wait = held > 0 ? ` ${updates(held, 'community guide')} ${held === 1 ? 'asks' : 'ask'} first: open Community Guides.` : '';
	return `Installs ${parts.join(' and ')}.${wait}`;
}
