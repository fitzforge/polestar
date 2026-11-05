import type { StatusKind } from './types';

/** Each status's glyph, colour token and the few words the sidebar's foot has
 * room for: success while all is well, the accent while sending, warning for
 * what needs the player. */
export const STATUS: Record<StatusKind, { glyph: string; color: string; short: string }> = {
	off: { glyph: 'record', color: 'var(--textMuted)', short: 'Sharing off' },
	watching: { glyph: 'record', color: 'var(--success)', short: 'Sharing on' },
	uploading: { glyph: 'qol-upgrade', color: 'var(--accent)', short: 'Sending' },
	waiting: { glyph: 'hourglass', color: 'var(--textDim)', short: 'Waiting for the game' },
	offline: { glyph: 'plug', color: 'var(--warning)', short: "Can't reach the server" },
	paused: { glyph: 'pause', color: 'var(--warning)', short: 'Uploads paused' },
	rejected: { glyph: 'info', color: 'var(--warning)', short: 'Some data turned away' },
	attention: { glyph: 'info', color: 'var(--warning)', short: 'Needs a look' },
};
