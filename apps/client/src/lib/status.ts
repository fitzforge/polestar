import { msg } from './i18n.svelte';
import type { StatusKind } from './types';

/** Each status's glyph, colour token and the few words the sidebar's foot has
 * room for: success while all is well, the accent while sending, warning for
 * what needs the player. `short` is English: show it through t(). */
export const STATUS: Record<StatusKind, { glyph: string; color: string; short: string }> = {
	off: { glyph: 'record', color: 'var(--textMuted)', short: msg('Sharing off') },
	watching: { glyph: 'record', color: 'var(--success)', short: msg('Sharing on') },
	uploading: { glyph: 'qol-upgrade', color: 'var(--accent)', short: msg('Sending') },
	waiting: { glyph: 'hourglass', color: 'var(--textDim)', short: msg('Waiting for the game') },
	offline: { glyph: 'plug', color: 'var(--warning)', short: msg("Can't reach the server") },
	paused: { glyph: 'pause', color: 'var(--warning)', short: msg('Uploads paused') },
	rejected: { glyph: 'info', color: 'var(--warning)', short: msg('Some data turned away') },
	attention: { glyph: 'info', color: 'var(--warning)', short: msg('Needs a look') },
};
