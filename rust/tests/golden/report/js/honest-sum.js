// node honest-sum.js <honest.json> <chain-guide-ids file|faction:race>: honest findings on a start's default chain, by rule (fail only)
process.env.POLESTAR_CAS='off';
const [jf, faction, race, tree] = process.argv.slice(2);
const JR=process.env.JUDGE_ROOT;
(async () => {
	const j = require(require('path').resolve(jf));
	const { walkChain } = require(JR + '/tools/lib/judge/walk');
	process.chdir(JR);
	const w = await walkChain({ guides: tree, faction, race, simDir: process.env.SIM, to: 61 });
	const ids = new Set(w.chain);
	const c = {}, o = {};
	for (const f of j.findings) if (f.severity === 'fail' && ids.has(f.guide)) {
		const mine = String(f.race || '').toLowerCase() === race.toLowerCase();
		(mine ? c : o)[f.rule] = ((mine ? c : o)[f.rule] || 0) + 1;
	}
	const sum = (x) => Object.values(x).reduce((a, b) => a + b, 0);
	if (process.env.JSON_OUT) require('fs').writeFileSync(process.env.JSON_OUT, JSON.stringify({ own: c, other: o }));
	console.log(faction, race, 'own race', JSON.stringify(c), sum(c), '| other races on these guides', JSON.stringify(o), sum(o));
})();
