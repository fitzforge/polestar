import type { Snapshot } from './types';

/** Updates manager::update_all can install. Changed publishers or folders need separate confirmation. */
export function updateAllCount(s: Snapshot): number {
	const addons = s.addons.products.filter((p) => p.status === 'update').length;
	const packs = s.community.packs.filter((p) => p.status === 'update' && !p.blocked && !p.changes).length;
	return addons + packs;
}
