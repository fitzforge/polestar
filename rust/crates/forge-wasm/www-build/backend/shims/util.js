// node:util for the browser planner's worker: what the planner's code uses.

export function isDeepStrictEqual(a, b) {
	if (Object.is(a, b)) return true;
	if (typeof a !== 'object' || typeof b !== 'object' || a === null || b === null) return false;
	if (Object.getPrototypeOf(a) !== Object.getPrototypeOf(b)) return false;
	if (Array.isArray(a)) {
		if (a.length !== b.length) return false;
		for (let i = 0; i < a.length; i++) if (!isDeepStrictEqual(a[i], b[i])) return false;
		return true;
	}
	const ka = Object.keys(a);
	const kb = Object.keys(b);
	if (ka.length !== kb.length) return false;
	for (const k of ka) if (!Object.hasOwn(b, k) || !isDeepStrictEqual(a[k], b[k])) return false;
	return true;
}

export function inspect(v) {
	try {
		return JSON.stringify(v);
	} catch {
		return String(v);
	}
}

export function format(f, ...args) {
	let i = 0;
	return String(f).replace(/%[sdjo]/g, () => String(args[i++])) + (i < args.length ? ' ' + args.slice(i).join(' ') : '');
}

export const types = { isRegExp: (v) => v instanceof RegExp, isDate: (v) => v instanceof Date };
export const promisify = (fn) => (...a) => new Promise((res, rej) => fn(...a, (e, v) => (e ? rej(e) : res(v))));

export default { isDeepStrictEqual, inspect, format, types, promisify };
