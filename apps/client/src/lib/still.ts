// When the window is out of sight, Polestar Client's loops hold still (#1801): the status light's
// turning arc, the spinners and progress sweeps, the 1-second clock that refreshes "2 minutes ago".
// WebView2 keeps a minimized window's page running and compositing, so a loop that never stops
// kept a player's GPU busy beside the game. Out of sight means: the page hidden, the window hidden
// (in the tray) or minimized, at once; or the window not focused for STILL_AFTER_BLUR_MS (behind
// the game, on another screen). Back in sight, everything carries on.

/** How long the window may sit unfocused, but visible, before its loops hold still. */
export const STILL_AFTER_BLUR_MS = 20_000;

export interface Sight {
	/** The page itself is hidden (`document.hidden`). */
	pageHidden: boolean;
	/** The window is hidden: closed to the tray, or started into it. */
	windowHidden: boolean;
	minimized: boolean;
	focused: boolean;
}

export interface Timers {
	now(): number;
	set(fn: () => void, ms: number): unknown;
	clear(handle: unknown): void;
}

const realTimers: Timers = { now: () => Date.now(), set: (fn, ms) => setTimeout(fn, ms), clear: (h) => clearTimeout(h as number) };

/** Tracks the window's sight and says, through `apply`, whenever the loops should hold still or
 * carry on (only on a change). */
export class Stillness {
	sight: Sight = { pageHidden: false, windowHidden: false, minimized: false, focused: true };
	still = false;
	#apply: (still: boolean) => void;
	#timers: Timers;
	#blurredAt: number | null = null;
	#timer: unknown = null;

	constructor(apply: (still: boolean) => void, timers: Timers = realTimers) {
		this.#apply = apply;
		this.#timers = timers;
	}

	update(change: Partial<Sight>): void {
		const wasFocused = this.sight.focused;
		this.sight = { ...this.sight, ...change };
		if (this.sight.focused) this.#blurredAt = null;
		else if (wasFocused || this.#blurredAt === null) this.#blurredAt = this.#timers.now();
		this.#settle();
	}

	#settle(): void {
		if (this.#timer !== null) {
			this.#timers.clear(this.#timer);
			this.#timer = null;
		}
		const { pageHidden, windowHidden, minimized, focused } = this.sight;
		let still = pageHidden || windowHidden || minimized;
		if (!still && !focused && this.#blurredAt !== null) {
			const left = this.#blurredAt + STILL_AFTER_BLUR_MS - this.#timers.now();
			if (left <= 0) still = true;
			else this.#timer = this.#timers.set(() => ((this.#timer = null), this.#settle()), left);
		}
		if (still !== this.still) {
			this.still = still;
			this.#apply(still);
		}
	}
}
