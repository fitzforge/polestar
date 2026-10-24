// JS reference world: node jsworld.js <faction>  (the JS reference checkout, scratch sim dir $POLESTAR_JSREF/simdir, CAS off)
process.env.POLESTAR_CAS = 'off';
process.env.POLESTAR_CAS_SKIP = 'walks';
const ROOT = process.env.POLESTAR_JS;
const REF = process.env.POLESTAR_JSREF;
if (!ROOT || !REF || !process.argv[2]) {
	console.error('usage: POLESTAR_JS=<checkout whose tools/ and data/ are the JS reference> POLESTAR_JSREF=<scratch dir> node jsworld.js <faction>');
	process.exit(2);
}
process.chdir(ROOT);
const path = require('node:path');
const sim = require(ROOT + '/tools/lib/sim');
const { getWorld } = require(ROOT + '/tools/lib/sim/world');
const { loadQuestXp } = require(ROOT + '/tools/lib/game/xp');
const faction = process.argv[2];
(async () => {
	const t0 = Date.now();
	const sourcesDir = path.join(ROOT, 'data', 'sources');
	const questXp = await loadQuestXp({ sourcesDir, offline: true });
	const t1 = Date.now();
	const w = getWorld({ dataDir: path.join(ROOT, 'data', 'forever'), sourcesDir, simDir: path.join(REF, 'simdir'), faction, rebuild: true, questXp, log: console.error });
	console.error(`world ${faction}: build ${((Date.now() - t1) / 1000).toFixed(1)} s (questXp ${((t1 - t0) / 1000).toFixed(1)} s), ${w.points.length} points, ${w.quests.length} quests, peak RSS ${(process.resourceUsage().maxRSS / 1024).toFixed(0)} MB`);
})().catch((e) => { console.error(e.stack); process.exitCode = 1; });
