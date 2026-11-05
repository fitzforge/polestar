// The motion system (docs/DESIGN.md, "Polestar Client" > Motion). Every
// transition here moves only transform and opacity, enters with the strong
// ease-out, and under reduced motion keeps a short fade without movement.
// Nothing here animates a filter, a shadow, a clip or a size: on WebKitGTK
// those repaint every frame.

import type { TransitionConfig } from 'svelte/transition';

const media = typeof matchMedia === 'function' ? matchMedia('(prefers-reduced-motion: reduce)') : null;
export const reduced = (): boolean => media?.matches ?? false;

/** The --ease curve (cubic-bezier(0.23, 1, 0.32, 1)) as a JS easing: a quint out. */
export const ease = (t: number): number => 1 - Math.pow(1 - t, 5);

/** Stagger for rows entering together: 30ms apart, capped so a long list never waits. */
export const stagger = (i: number): number => (reduced() ? 0 : Math.min(i, 8) * 30);

/** A thing settling in: up from `y` px as it fades in. */
export function rise(_node: Element, { y = 6, delay = 0, duration = 220 }: { y?: number; delay?: number; duration?: number } = {}): TransitionConfig {
	if (reduced()) return { delay: 0, duration: 120, css: (t) => `opacity: ${t}` };
	return { delay, duration, easing: ease, css: (t, u) => `opacity: ${t}; transform: translate3d(0, ${u * y}px, 0)` };
}

/** While a page changes, the band's twinkle and other loops hold still, so the
 * page's own layer is the only thing the compositor moves. */
let settle: number | undefined;
function moving(ms: number) {
	document.documentElement.classList.add('moving');
	clearTimeout(settle);
	settle = window.setTimeout(() => document.documentElement.classList.remove('moving'), ms);
}

/** Pages: only the incoming page moves. It rises 10px from the side of the
 * sidebar it was picked on (`dir` 1 = further down the list, -1 = further up)
 * as it fades in over 200ms; the old page is gone at once, so two full pages
 * never composite together. */
export function page(_node: Element, { dir = 1 }: { dir?: number }): TransitionConfig {
	if (reduced()) return { duration: 120, css: (t) => `opacity: ${t}` };
	moving(240);
	return { duration: 200, easing: ease, css: (t, u) => `opacity: ${t}; transform: translate3d(0, ${dir * u * 10}px, 0)` };
}

/** A popup menu: grows 4px down from its trigger as it fades in. */
export function drop(_node: Element, { duration = 150 }: { duration?: number } = {}): TransitionConfig {
	if (reduced()) return { duration: 80, css: (t) => `opacity: ${t}` };
	return { duration, easing: ease, css: (t, u) => `opacity: ${t}; transform: translate3d(0, ${-u * 4}px, 0) scale(${0.98 + t * 0.02})` };
}

/** A drawer from the right edge. */
export function drawer(_node: Element, { duration = 260 }: { duration?: number } = {}): TransitionConfig {
	if (reduced()) return { duration: 120, css: (t) => `opacity: ${t}` };
	return { duration, easing: ease, css: (t, u) => `transform: translate3d(${u * 100}%, 0, 0); opacity: ${Math.min(1, t * 3)}` };
}

/** Fading only (scrims, swaps in place). */
export function fade(_node: Element, { duration = 180, delay = 0 }: { duration?: number; delay?: number } = {}): TransitionConfig {
	return { delay, duration: reduced() ? Math.min(duration, 120) : duration, easing: ease, css: (t) => `opacity: ${t}` };
}

/** A label swapping for another in place (Check for updates → Checked): a short rise-fade. */
export function swap(_node: Element, { duration = 160 }: { duration?: number } = {}): TransitionConfig {
	if (reduced()) return { duration: 100, css: (t) => `opacity: ${t}` };
	return { duration, easing: ease, css: (t, u) => `opacity: ${t}; transform: translate3d(0, ${u * 3}px, 0)` };
}
