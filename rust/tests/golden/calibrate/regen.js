// JS reference for forge sim calibrate: calibrate.js's own fits on the same worlds, written as
// saveParamsFile would (fit.at pinned).
const fs = require('node:fs');
const path = require('node:path');
const R = process.argv[2];
const S = process.argv[3];
const fdj = process.argv[4] || null;
if (!R || !S) throw new Error('usage: regen.js <JS checkout> <root holding sim/ and recordings/> [<ForeverDungeonJournal dir>]');
const c = require(`${R}/tools/lib/sim/calibrate.js`);
const { PRIORS } = require(`${R}/tools/lib/sim/params.js`);
const worlds = ['horde', 'alliance'].map((f) => JSON.parse(fs.readFileSync(path.join(S, 'sim', `world-${f}.json`), 'utf8')));
const file = fdj ? path.join(fdj, 'Data', 'QuestRewards.lua') : null;
const xp = file && fs.existsSync(file) ? c.parseForeverXp(fs.readFileSync(file, 'utf8')) : new Map();
const qx = c.questXpFits(worlds, xp);
const rec = c.recordingFits(path.join(S, 'recordings'));
const doc = { calibrated: {} };
const fit = { at: '2026-10-22T00:00:00.000Z', sources: {} };
fit.sources.questXp = { questsJsonXp: qx.est ? qx.est.n : 0, forever: { file, values: qx.foreverTotal, matched: qx.foreverRows.length } };
if (qx.est) doc.calibrated.questEstScale = { mean: qx.est.mean, sd: Math.max(qx.est.sd, 0.03) };
if (qx.forever) doc.calibrated.questXpScale = { mean: qx.forever.mean, sd: Math.max(qx.forever.sd, 0.03) };
fit.questXp = { est: qx.est, forever: qx.forever };
fit.sources.recordings = { sessions: rec.sessions, levels: rec.levels || 0 };
if (rec.killSec1 != null && rec.killSec60 != null && rec.killSec1 > 0 && rec.killSec60 > 0) {
	doc.calibrated.killSec1 = { mean: rec.killSec1, sd: PRIORS.killSec1[1] / 2 };
	doc.calibrated.killSec60 = { mean: rec.killSec60, sd: PRIORS.killSec60[1] / 2 };
}
const priors = {};
for (const [k, [mean, sd, lo, hi, desc]] of Object.entries(PRIORS)) priors[k] = { mean, sd, lo, hi, desc };
process.stdout.write(`${JSON.stringify({ schema: 1, priors, calibrated: doc.calibrated, fit }, null, '\t')}\n`);
