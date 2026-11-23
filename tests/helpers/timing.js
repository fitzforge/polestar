'use strict';
// Timing budgets: a figure read off a clock (os.clock's CPU time, a wall clock) held to a budget set on a quiet
// machine. GitHub's shared runners are neither quiet nor alike, so CI sets POLESTAR_TIMING_BUDGETS=warn: there a
// figure over its budget prints a warning annotation and the test goes on. Anywhere else (unset, or any other
// value) it fails the test as assert.ok does, and the release gate runs them that way, alone on a quiet machine
// (docs/RELEASING.md, step 3). Everything else a timing test checks stays a plain assertion. forge-addontest's
// assert_timing! (rust/crates/forge-addontest/src/timing.rs) is the same rule.

const assert = require('node:assert/strict');

const ENV = 'POLESTAR_TIMING_BUDGETS';

// An annotation's message on one line (GitHub's workflow command escapes).
const escape = (s) => String(s).replace(/%/g, '%25').replace(/\r/g, '%0D').replace(/\n/g, '%0A');

// Nothing when `within`; over budget, a failed assertion, or with POLESTAR_TIMING_BUDGETS=warn (`env`) the
// warning annotation, printed and returned.
function assertTiming(within, message, env = process.env) {
	if (within) return null;
	if (env[ENV] !== 'warn') assert.fail(message);
	const line = `::warning title=Timing budget (${ENV}=warn)::${escape(message)}`;
	console.log(line);
	return line;
}

module.exports = { assertTiming, ENV };
