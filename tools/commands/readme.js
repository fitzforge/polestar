'use strict';
// readme brand|charts: the README's art in docs/assets (tools/readme/).

const { parseArgs } = require('node:util');

const usage = `usage: node tools/polestar.js readme brand
       node tools/polestar.js readme charts --draft <dir|git rev> [options]

brand: rewrites docs/assets/{banner-dark,banner-light,emblem,logo,download,avatar}.svg,
drawn in code from the emblem geometry and the wordmark fonts, and with
rsvg-convert (librsvg) installed the CurseForge listing's PNGs in
docs/curseforge/images (the avatar, the banner and the charts); without it,
prints the rsvg-convert commands to run. charts re-exports its two PNGs.

charts: rewrites docs/assets/charts/{levels,starts}.svg. Scores the guides
under the simulator's model (as \`sim compare\` does) against an earlier set
of them; the best route found and the consensus route are drawn when such
results from the retired \`sim run\`/\`sim consensus\` are in --sim, searched
on the world being scored.

  --draft <dir|rev>    the earlier guides: a guides folder, or a git revision
                       whose guides/ is used. The README's charts use v0.1.0,
                       the first release.
  --draft-label <text> how the charts name them (default: "Polestar <x.y.z>"
                       for a release tag vX.Y.Z, else "Earlier guides")
  --sim <dir>          sim world and params, plus results/consensus left by the
                       retired \`sim run\`/\`sim consensus\`
                       (default data/sim)
  --guides <dir>       the guides to score (default guides/)`;

function fail(msg) {
	console.error(`${msg}\n\n${usage}`);
	return 2;
}

async function run(argv) {
	let values;
	let positionals;
	try {
		({ values, positionals } = parseArgs({
			args: argv,
			options: { draft: { type: 'string' }, 'draft-label': { type: 'string' }, sim: { type: 'string' }, guides: { type: 'string' } },
			allowPositionals: true,
			strict: true,
		}));
	} catch (err) {
		return fail(err.message);
	}
	const [sub, ...extra] = positionals;
	if (extra.length) return fail(`unexpected argument "${extra[0]}"`);
	if (sub === 'brand') {
		if (Object.keys(values).length) return fail('brand takes no options');
		require('../readme/brand').write();
		return 0;
	}
	if (sub === 'charts') {
		if (!values.draft) return fail('charts needs --draft <dir|git rev>');
		await require('../readme/charts').write(values);
		return 0;
	}
	return fail(sub ? `unknown subcommand "${sub}"` : 'missing subcommand');
}

module.exports = { name: 'readme', summary: "Redraw the README's art: brand (docs/assets) and charts (docs/assets/charts)", usage, run };
