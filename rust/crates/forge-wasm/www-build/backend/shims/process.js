// `process` for the browser planner's worker (esbuild inject): the checkout is /repo.
export const process = {
	env: {},
	pid: 1,
	platform: 'linux',
	argv: [],
	version: 'v22.0.0',
	versions: {},
	cwd: () => '/repo',
	exitCode: 0,
	hrtime: Object.assign(() => [0, 0], { bigint: () => BigInt(Math.round(performance.now() * 1e6)) }),
	memoryUsage: () => ({ rss: 0, heapUsed: 0 }),
	nextTick: (fn, ...a) => queueMicrotask(() => fn(...a)),
	on() {},
	emitWarning() {},
	stdout: { write() {} },
	stderr: { write() {} },
};

// Node timers have unref()/ref() (the planner's code calls them): browser timer ids wrapped.
const wrap = (set, clear) => {
	const make = (...a) => {
		const id = set(...a);
		return { id, unref() { return this; }, ref() { return this; }, hasRef: () => true, [Symbol.toPrimitive]: () => id };
	};
	const stop = (t) => clear(t && typeof t === 'object' ? t.id : t);
	return [make, stop];
};
[globalThis.setTimeout, globalThis.clearTimeout] = wrap(globalThis.setTimeout.bind(globalThis), globalThis.clearTimeout.bind(globalThis));
[globalThis.setInterval, globalThis.clearInterval] = wrap(globalThis.setInterval.bind(globalThis), globalThis.clearInterval.bind(globalThis));
