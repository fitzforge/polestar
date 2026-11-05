// Diagnostics the player can turn on: the frame-rate overlay (Ctrl+Shift+F,
// or Settings > About), kept across launches on this PC.

const KEY = 'polestar.frameMeter';

export const diagnostics = $state({ frames: localStorage.getItem(KEY) === '1' });

export function showFrames(on: boolean): void {
	diagnostics.frames = on;
	localStorage.setItem(KEY, on ? '1' : '0');
}
