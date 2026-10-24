// node -r pin-date.js: `new Date()` (no arguments) is BUILT_AT, so report.json's builtAt is pinned.
'use strict';
const BUILT_AT = process.env.BUILT_AT || '2026-10-22T00:00:00.000Z';
const Real = Date;
globalThis.Date = class extends Real {
	constructor(...a) {
		super(...(a.length ? a : [BUILT_AT]));
	}
	static now() {
		return Real.now();
	}
};
