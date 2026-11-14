// Whether the window is in sight (lib/still.ts), from the page and the Tauri window. Out of sight,
// `still` on <html> pauses every animation (app.css) and the 1-second clock skips (app.svelte.ts);
// each return to sight counts in `wakes`, which replays the band's twinkle and the status light's
// breaths for a while (Band.svelte, Beacon.svelte).

import { Stillness } from './still';

export const sight = $state({ still: false, wakes: 0 });

/** Starts watching; `onWake` runs each time the window comes back into sight. */
export async function watchSight(onWake: () => void): Promise<void> {
	const stillness = new Stillness((still) => {
		document.documentElement.classList.toggle('still', still);
		sight.still = still;
		if (!still) {
			sight.wakes++;
			onWake();
		}
	});
	const page = () => stillness.update({ pageHidden: document.hidden });
	document.addEventListener('visibilitychange', page);
	page();
	if (!('__TAURI_INTERNALS__' in window)) return;
	// The webview isn't told when its window is minimized (#1801: the animations kept running), so
	// the window says itself. Hiding to the tray takes the focus away first; the window is asked
	// whether it is still visible then. Loaded only inside Tauri, as TitleBar.svelte and backend.ts
	// do (`vite dev` in a browser has no window API).
	const { getCurrentWindow } = await import('@tauri-apps/api/window');
	const win = getCurrentWindow();
	const look = async (focused?: boolean) => {
		const [visible, minimized, isFocused] = await Promise.all([win.isVisible(), win.isMinimized(), focused ?? win.isFocused()]);
		stillness.update({ windowHidden: !visible, minimized, focused: isFocused });
	};
	const quietly = (p: Promise<void>) => void p.catch((e) => console.error('sight', e));
	await win.onFocusChanged(({ payload }) => quietly(look(payload)));
	await win.onResized(() => quietly(look()));
	await look();
}
