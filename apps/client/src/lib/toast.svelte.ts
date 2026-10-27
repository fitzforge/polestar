// Toasts: the outcome of an action that finished away from where it started
// (an install, a save), said once at the foot of the window and gone again.

export type ToastKind = 'success' | 'warning' | 'info';
export interface Toast {
	id: number;
	kind: ToastKind;
	text: string;
}

let next = 1;
export const toasts = $state<Toast[]>([]);
const timers = new Map<number, number>();

/** How long a toast stays: long enough to read it twice. */
const life = (text: string) => Math.min(9000, 3200 + text.length * 45);

export function toast(text: string, kind: ToastKind = 'success'): void {
	if (!text) return;
	const id = next++;
	toasts.push({ id, kind, text });
	if (toasts.length > 3) dismiss(toasts[0].id);
	schedule(id, text);
}

function schedule(id: number, text: string) {
	timers.set(id, window.setTimeout(() => dismiss(id), life(text)));
}

export function dismiss(id: number): void {
	clearTimeout(timers.get(id));
	timers.delete(id);
	const i = toasts.findIndex((t) => t.id === id);
	if (i >= 0) toasts.splice(i, 1);
}

/** Holding the pointer over the toasts keeps them. */
export function hold(on: boolean): void {
	for (const t of toasts) {
		clearTimeout(timers.get(t.id));
		if (!on) schedule(t.id, t.text);
	}
}
