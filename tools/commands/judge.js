'use strict';
// `polestar judge`: retired; the judge is `forge judge` (docs/forge/judge.md).

const usage = 'polestar judge was retired: use forge judge <pack dir> --faction F --race R [--class C] [--to N] [--sim DIR] [--json] (docs/forge/judge.md; no --radius, --json prints to stdout)';

const run = () => {
	console.error(usage);
	return 2;
};

module.exports = { name: 'judge', summary: 'retired: use forge judge', usage, run };
