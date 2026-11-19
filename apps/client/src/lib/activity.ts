import type { ActivityEntry } from './types';

/** First upload from the same account after a failed entry. Activity is ordered newest first. */
export function sentAgainAt(entries: ActivityEntry[] | null, i: number): number | null {
	if (!entries || !entries[i].account) return null;
	for (let j = i - 1; j >= 0; j--) if (entries[j].kind === 'upload' && entries[j].account === entries[i].account) return entries[j].at;
	return null;
}
