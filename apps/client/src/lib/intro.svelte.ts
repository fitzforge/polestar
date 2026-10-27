// The launch intro (docs/DESIGN.md, "Polestar Client" > The intro). Its first
// frame is static markup in index.html, so the window opens on it; this plays
// the rest: the night sky resolving from black, stars fading in, the guiding
// star igniting in a gold bloom, the Little Dipper drawing toward it, the
// wordmark settling under it, then the star gliding to its place in the app
// (the sidebar's emblem, or Setup's) as the app shows through.
//
// It plays in full (about 5.5 s, a calm hold on the finished sky before the
// hand-off) on every launch and every time the window comes back from the tray,
// while "Play the full intro every launch" is on (Settings > General, the
// default). Off, the first launch of a version still plays it in full, later
// launches a short version (at least 1.2 s), and a window back from the tray
// none. A click or any key skips it; reduced motion gets a still frame and a
// crossfade. Its mode and timings go to the log. Only
// transform and opacity move, on layers drawn once (the line drawing is the
// one exception: a stroke offset over a small area).

import { api } from './backend';

declare const __APP_VERSION__: string;

const FULL_KEY = 'polestar.introFull';
const SEEN_KEY = 'polestar.introSeen';
const EASE_OUT = 'cubic-bezier(0.23, 1, 0.32, 1)';
const EASE_MOVE = 'cubic-bezier(0.77, 0, 0.175, 1)';
const EASE_DAWN = 'cubic-bezier(0.4, 0, 0.2, 1)';

/** How smoothly the last intro played, for the frame-rate overlay. */
export interface IntroStats {
	mode: 'full' | 'short' | 'still';
	ms: number;
	fps: number;
	worst: number;
	dropped: number;
}

export const intro = $state({ full: localStorage.getItem(FULL_KEY) !== '0', stats: null as IntroStats | null });

export function setFullIntro(on: boolean): void {
	intro.full = on;
	localStorage.setItem(FULL_KEY, on ? '1' : '0');
}

let markReady: () => void = () => {};
const appReady = new Promise<void>((resolve) => (markReady = resolve));
/** The app has its first state on screen: the star has somewhere to land. */
export function appIsReady(): void {
	markReady();
}

/** Resolves once no intro is on screen: what a link opens waits for the intro to hand over
 * rather than cutting it short. */
export function afterIntro(): Promise<void> {
	const root = document.documentElement;
	if (!root.classList.contains('intro')) return Promise.resolve();
	return new Promise((resolve) => {
		const watch = new MutationObserver(() => {
			if (root.classList.contains('intro')) return;
			watch.disconnect();
			resolve();
		});
		watch.observe(root, { attributes: true, attributeFilter: ['class'] });
	});
}

const sleep = (ms: number) => new Promise<void>((resolve) => setTimeout(resolve, ms));

/** The Little Dipper, Polaris at (0, 0) on the emblem, its handle reaching up and left. */
const DIPPER: [number, number, number][] = [
	[0, 0, 0],
	[-62, -34, 1.6],
	[-118, -74, 1.7],
	[-170, -112, 1.9],
	[-238, -120, 1.8],
	[-252, -62, 2.3],
	[-190, -56, 2.4],
];
/** Drawn in this order, from the bowl along the handle to the guiding star. */
const SEGMENTS: [number, number][] = [
	[5, 6],
	[5, 4],
	[6, 3],
	[4, 3],
	[3, 2],
	[2, 1],
	[1, 0],
];
const SVG = 'http://www.w3.org/2000/svg';

/** The intro's first frame as the page loaded it, to play it again when the window comes back. */
const pristine = document.getElementById('intro')?.cloneNode(true) as HTMLElement | undefined;
let playing = false;
const log = (line: string) => void api.clientLog(`intro: ${line}`).catch(() => {});

function stars(ground: Element): HTMLElement[] {
	let seed = 11;
	const rand = () => ((seed = (seed * 16807) % 2147483647) - 1) / 2147483646;
	const layers: HTMLElement[] = [];
	for (let l = 0; l < 4; l++) {
		const layer = document.createElement('div');
		layer.className = 'i-layer';
		for (let n = 0; n < 20; n++) {
			const star = document.createElement('i');
			const size = 3 + Math.pow(rand(), 3) * 7;
			star.style.cssText = `left:${(rand() * 100).toFixed(2)}%;top:${(Math.pow(rand(), 1.25) * 100).toFixed(2)}%;width:${size.toFixed(1)}px;height:${size.toFixed(1)}px;opacity:${(0.35 + rand() * 0.65).toFixed(2)}`;
			layer.append(star);
		}
		ground.append(layer);
		layers.push(layer);
	}
	return layers;
}

function constellation(mark: Element): { svg: SVGSVGElement; dots: SVGElement[]; lines: SVGLineElement[] } {
	const svg = document.createElementNS(SVG, 'svg');
	svg.setAttribute('class', 'i-lines');
	svg.setAttribute('viewBox', '-320 -200 640 400');
	svg.innerHTML = '<defs><radialGradient id="i-halo"><stop offset="0" stop-color="#dbe6ff" stop-opacity="0.45"/><stop offset="1" stop-color="#dbe6ff" stop-opacity="0"/></radialGradient></defs>';
	const dots: SVGElement[] = [];
	for (const [x, y, r] of DIPPER.slice(1)) {
		const g = document.createElementNS(SVG, 'g');
		g.innerHTML = `<circle cx="${x}" cy="${y}" r="${r * 4}" fill="url(#i-halo)"/><circle cx="${x}" cy="${y}" r="${r}" fill="#fff"/>`;
		svg.append(g);
		dots.push(g);
	}
	const lines = SEGMENTS.map(([a, b]) => {
		const [x1, y1] = DIPPER[a];
		const [x2, y2] = DIPPER[b];
		const len = Math.hypot(x2 - x1, y2 - y1);
		const ux = (x2 - x1) / len;
		const uy = (y2 - y1) / len;
		// Lines stop short of each star, and well short of the emblem's ring.
		const start = 7;
		const end = b === 0 ? 40 : 7;
		const line = document.createElementNS(SVG, 'line');
		line.setAttribute('x1', String(x1 + ux * start));
		line.setAttribute('y1', String(y1 + uy * start));
		line.setAttribute('x2', String(x2 - ux * end));
		line.setAttribute('y2', String(y2 - uy * end));
		line.setAttribute('stroke', 'rgba(219, 230, 255, 0.34)');
		line.setAttribute('stroke-width', '1');
		line.setAttribute('stroke-linecap', 'round');
		const drawn = len - start - end;
		line.style.strokeDasharray = `${drawn}`;
		line.style.strokeDashoffset = `${drawn}`;
		line.dataset.length = String(drawn);
		svg.append(line);
		return line;
	});
	mark.prepend(svg);
	return { svg, dots, lines };
}

/** Frame times while the intro plays. */
function meter() {
	const frames: number[] = [];
	let last = performance.now();
	let raf = requestAnimationFrame(function tick(now) {
		frames.push(now - last);
		last = now;
		raf = requestAnimationFrame(tick);
	});
	return (mode: IntroStats['mode'], ms: number): IntroStats => {
		cancelAnimationFrame(raf);
		const body = frames.slice(1);
		const sorted = [...body].sort((a, b) => a - b);
		const typical = sorted[Math.floor(sorted.length / 2)] || 16.7;
		return {
			mode,
			ms: Math.round(ms),
			fps: Math.round((body.length * 1000) / Math.max(1, ms)),
			worst: Math.round(sorted[sorted.length - 1] ?? 0),
			dropped: body.filter((f) => f > typical * 1.5).length,
		};
	};
}

function end(root: HTMLElement): void {
	document.documentElement.classList.remove('intro');
	root.remove();
}

/** The launch: the window opens on the intro's first frame. */
export async function playIntro(): Promise<void> {
	const root = document.getElementById('intro');
	if (root) await run(root, 'launch');
}

/** The window is coming back from the tray: the intro again (while the player keeps it on),
 * then the window shows on its first frame. */
export async function replayIntro(): Promise<void> {
	const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
	if (playing || !pristine || !intro.full || reduce) {
		log(`back from the tray: no intro (${playing ? 'one is playing' : !intro.full ? 'full intro off' : reduce ? 'reduced motion' : 'no intro markup'})`);
		await api.windowReady().catch(() => {});
		return;
	}
	const root = pristine.cloneNode(true) as HTMLElement;
	document.body.prepend(root);
	document.documentElement.classList.add('intro');
	await run(root, 'reopen');
}

async function run(root: HTMLElement, why: 'launch' | 'reopen'): Promise<void> {
	playing = true;
	try {
		await sequence(root, why);
	} finally {
		playing = false;
	}
}

async function sequence(root: HTMLElement, why: 'launch' | 'reopen'): Promise<void> {
	// The window is shown now (it waited for this first frame); a launch into the tray shows nothing.
	const shown = await api.windowReady().catch((e) => {
		log(`window_ready failed: ${e}`);
		return true;
	});
	if (!shown) {
		log(`${why}: started into the tray, no intro`);
		return end(root);
	}

	const q = <T extends Element>(s: string) => root.querySelector(s) as T;
	const ground = q<HTMLElement>('.i-ground');
	const sky = q<HTMLElement>('.i-sky');
	const mark = q<HTMLElement>('.i-mark');
	const fly = q<HTMLElement>('.i-fly');
	const bloom = q<HTMLElement>('.i-bloom');
	const emblem = q<SVGSVGElement>('.i-emblem');
	const core = q<SVGPathElement>('.i-core');
	const word = q<HTMLElement>('.i-word');
	const tag = q<HTMLElement>('.i-tag');
	const layers = stars(ground);
	const { svg, dots, lines } = constellation(mark);
	svg.style.willChange = 'opacity';
	core.style.transformBox = 'fill-box';
	core.style.transformOrigin = 'center';

	// The window opens on the black first frame and holds it while the app does its heaviest work
	// (its first state, its first layout), at most half a second, so the intro's own frames do not
	// compete with it: the night resolves from that black.
	await Promise.race([appReady, sleep(500)]);
	await new Promise((resolve) => requestAnimationFrame(() => requestAnimationFrame(resolve)));

	const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
	const full = !reduce && (why === 'reopen' || intro.full || localStorage.getItem(SEEN_KEY) !== __APP_VERSION__);
	const mode: IntroStats['mode'] = reduce ? 'still' : full ? 'full' : 'short';
	const anims: Animation[] = [];
	const play = (el: Element, frames: Keyframe[], delay: number, duration: number, easing = EASE_OUT) => {
		anims.push(el.animate(frames, { delay, duration, easing, fill: 'both' }));
	};
	const started = performance.now();
	log(`${why}: ${mode}, playing ${Math.round(started)} ms after the page started`);
	const stop = meter();
	for (const el of [sky, fly, bloom, word, tag, ...layers]) el.style.willChange = 'transform, opacity';

	// t(full, short): when each moment comes in the two versions.
	const t = (long: number, short: number) => (full ? long : short);
	if (reduce) {
		for (const el of [sky, emblem, word, tag, ...layers, ...dots]) play(el, [{ opacity: 0 }, { opacity: 1 }], 0, 220);
		play(bloom, [{ opacity: 0 }, { opacity: 0.75 }], 0, 220);
		for (const line of lines) line.style.strokeDashoffset = '0';
	} else {
		play(sky, [{ opacity: 0 }, { opacity: 1 }], 0, t(1100, 350), EASE_DAWN);
		layers.forEach((layer, i) => play(layer, [{ opacity: 0 }, { opacity: 1 }], t(250 + i * 260, i * 60), t(900, 400), EASE_DAWN));
		dots.forEach((dot, i) => play(dot, [{ opacity: 0 }, { opacity: 1 }], t(900 + i * 60, 150), t(500, 300)));
		play(emblem, [{ opacity: 0, transform: 'scale(0.55) rotate(-14deg)' }, { opacity: 1, transform: 'scale(1) rotate(0deg)' }], t(1200, 120), t(700, 450));
		play(core, [{ opacity: 0, transform: 'scale(0.3)' }, { opacity: 1, transform: 'scale(1.45)', offset: 0.4 }, { opacity: 0.9, transform: 'scale(1)' }], t(1200, 120), t(900, 550));
		play(bloom, [{ opacity: 0, transform: 'scale(0.4)' }, { opacity: 1, transform: 'scale(1.12)', offset: 0.35 }, { opacity: 0.75, transform: 'scale(1)' }], t(1150, 100), t(1300, 700));
		if (full) {
			lines.forEach((line, i) => play(line, [{ strokeDashoffset: line.dataset.length }, { strokeDashoffset: '0' }], 1800 + i * 160, 220, 'cubic-bezier(0.3, 0, 0.3, 1)'));
		} else {
			// The short version has no time to draw them: they fade in whole (opacity, on the compositor).
			for (const line of lines) line.style.strokeDashoffset = '0';
			play(svg, [{ opacity: 0 }, { opacity: 1 }], 300, 380);
		}
		play(word, [{ opacity: 0, transform: 'translate3d(0, 10px, 0)' }, { opacity: 1, transform: 'translate3d(0, 0, 0)' }], t(2750, 380), t(650, 420));
		play(tag, [{ opacity: 0, transform: 'translate3d(0, 6px, 0)' }, { opacity: 1, transform: 'translate3d(0, 0, 0)' }], t(2950, 460), t(600, 400));
	}

	// A click or any key skips to the hand-off.
	let skip: () => void = () => {};
	const skipped = new Promise<void>((resolve) => (skip = resolve));
	const onSkip = (e: Event) => {
		e.stopPropagation();
		anims.forEach((a) => a.finish());
		skip();
	};
	root.addEventListener('pointerdown', onSkip);
	window.addEventListener('keydown', onSkip, { capture: true });

	// The full version holds the finished sky a while, the star's bloom breathing, before the hand-off.
	const calm = full ? bloom.animate([{ opacity: 0.75 }, { opacity: 0.95 }], { delay: 3300, duration: 1600, iterations: Infinity, direction: 'alternate', easing: 'ease-in-out' }) : null;
	await Promise.race([sleep(reduce ? 700 : t(5000, 1200)), skipped]);
	calm?.cancel();
	let ready = false;
	void appReady.then(() => (ready = true));
	await Promise.resolve();
	if (!ready) {
		// Still waiting for the app: the star breathes until it is there.
		const breathe = bloom.animate([{ opacity: 0.75 }, { opacity: 1 }], { duration: 1400, iterations: Infinity, direction: 'alternate', easing: 'ease-in-out' });
		await appReady;
		breathe.cancel();
	}
	anims.forEach((a) => a.finish());
	localStorage.setItem(SEEN_KEY, __APP_VERSION__);
	log(`${why}: hand-off ${Math.round(performance.now() - started)} ms in`);

	// The hand-off: the star glides to its place as the night lifts off the app.
	const target = document.querySelector('[data-intro-target]');
	const lift = (el: Element, duration: number) => el.animate([{ opacity: getComputedStyle(el).opacity }, { opacity: 0 }], { duration, easing: EASE_OUT, fill: 'forwards' }).finished;
	if (reduce || !target) {
		// A crossfade: the app's own emblem is already in place under it.
		document.documentElement.classList.remove('intro');
		await lift(root, 300);
	} else {
		const from = fly.getBoundingClientRect();
		const to = target.getBoundingClientRect();
		const flight = fly.animate(
			[{ transform: 'translate3d(0, 0, 0) scale(1)' }, { transform: `translate3d(${to.left - from.left}px, ${to.top - from.top}px, 0) scale(${to.width / from.width})` }],
			{ duration: 640, easing: EASE_MOVE, fill: 'forwards' },
		).finished;
		void lift(ground, 460);
		void lift(svg, 300);
		void lift(word, 300);
		void lift(tag, 300);
		void lift(bloom, 560);
		void lift(core, 420);
		await flight;
	}
	intro.stats = stop(mode, performance.now() - started);
	log(`${why}: done in ${intro.stats.ms} ms, ${intro.stats.fps} fps, worst frame ${intro.stats.worst} ms, ${intro.stats.dropped} dropped`);
	window.removeEventListener('keydown', onSkip, { capture: true });
	end(root);
}
