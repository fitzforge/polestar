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

/** Updates manager::update_all can install. Changed publishers or folders need separate confirmation. */
export function updateAllCount(s: Snapshot): number {
	const packs = s.community.packs.filter((p) => p.status === 'update' && !p.blocked && !p.changes).length;
	return addonUpdateCount(s) + packs;
}
