// The planner page's API in the browser build: the same exports as tools/planner/public/api.js, answered
// by the backend worker (backend.js: the planner's commands over forge-wasm and the static bundle)
// instead of the Node server. The guide set is the page's `?set=` (default v1).

export class ApiError extends Error {
	constructor(message, code) {
		super(message);
		this.code = code || null;
	}
}

const params = new URLSearchParams(location.search);
export const SET = params.get('set') || 'v1';
const worker = new Worker(new URL('./backend.js', import.meta.url), { type: 'module' });
const pending = new Map();
const listeners = new Set();
let seq = 0;
let readyInfo = null;
let failed = null;
let readyResolve;
const readyPromise = new Promise((r) => (readyResolve = r));

// Downloads the backend hands over (pack_compile's addon zip, changes_export).
function download(d) {
	if (!d || !d.url) return;
	const a = document.createElement('a');
	a.href = d.url;
	a.download = d.name || 'download';
	document.body.append(a);
	a.click();
	a.remove();
}

worker.onmessage = (ev) => {
	const m = ev.data || {};
	if (m.type === 'result') {
		const p = pending.get(m.id);
		if (!p) return;
		pending.delete(m.id);
		if (m.ok) {
			if (m.result && m.result.download) download(m.result.download);
			p.resolve(m.result);
		} else p.reject(new ApiError(m.error || `${p.name} failed`, m.code || null));
	} else if (m.type === 'event') {
		for (const l of listeners) l(m.name, m.data || {});
	} else if (m.type === 'progress') {
		for (const l of listeners) l('progress', { text: m.text });
	} else if (m.type === 'ready') {
		readyInfo = m.info;
		readyResolve(m.info);
		for (const l of listeners) l('ready', m.info);
	} else if (m.type === 'failed') {
		failed = m.error;
		for (const l of listeners) l('failed', { error: m.error });
		for (const p of pending.values()) p.reject(new ApiError(`the planner could not load: ${m.error}`, 'offline'));
		pending.clear();
	}
};
worker.onerror = (e) => {
	failed = e.message || 'the backend worker failed';
	for (const l of listeners) l('failed', { error: failed });
};
worker.postMessage({ type: 'init', set: SET });

function call(msg, name) {
	if (failed) return Promise.reject(new ApiError(`the planner could not load: ${failed}`, 'offline'));
	const id = ++seq;
	return new Promise((resolve, reject) => {
		pending.set(id, { resolve, reject, name });
		worker.postMessage({ ...msg, id });
	});
}

export function cmd(name, args = {}) {
	return call({ type: 'cmd', name, args }, name);
}

export function commands() {
	return call({ type: 'describe' }, 'commands');
}

// The backend's events, raw ('ready', 'progress', 'hours', 'failed' and the planner's own).
export function onBackend(fn) {
	listeners.add(fn);
	if (readyInfo) fn('ready', readyInfo);
	return () => listeners.delete(fn);
}
export const ready = () => readyPromise;

const EVENTS = ['hello', 'changed', 'diagnostics', 'routing', 'focus', 'seek', 'play'];

// handlers: { status(connected), hello(d), changed(d), ... } as the Node page's EventSource gave them.
export function events(handlers) {
	const off = onBackend((name, data) => {
		if (name === 'ready') {
			handlers.status && handlers.status(true);
			handlers.hello && handlers.hello({ version: data.version, packs: data.packs });
		} else if (name === 'failed') handlers.status && handlers.status(false);
		else if (EVENTS.includes(name) && handlers[name]) handlers[name](data);
	});
	return off;
}

// The page reports what it shows (view_state) at most every 500 ms.
let viewTimer = null;
let viewPending = null;
export function reportView(state) {
	viewPending = state;
	if (viewTimer) return;
	viewTimer = setTimeout(() => {
		viewTimer = null;
		worker.postMessage({ type: 'view', state: viewPending });
	}, 500);
}
