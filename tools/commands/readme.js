'use strict';
// readme brand|charts: the README's art in docs/assets (tools/readme/).

const { parseArgs } = require('node:util');

const usage = `usage: node tools/polestar.js readme brand
       node tools/polestar.js readme charts --check <dir|file> --base <dir|file> [options]

brand: rewrites docs/assets/{banner-dark,banner-light,emblem,logo,download,avatar}.svg,
drawn in code from the emblem geometry and the wordmark fonts, and with
rsvg-convert (librsvg) installed the CurseForge listing's PNGs in
docs/curseforge/images (the avatar, the banner and the chart); without it,
prints the rsvg-convert commands to run. charts re-exports its PNG.

charts: rewrites docs/assets/charts/starts.svg, hours to 60 and hours of
grinding per start, from two route checks (\`forge judge check\`'s
check.json): the guides being shipped against an earlier set, played by the
same checker.

  --check <dir|file>   the check of the guides being shipped: check.json, or
                       the folder \`forge judge check --out\` wrote it to
  --base <dir|file>    the check of the earlier guides (the README uses the
                       last release's)
  --label <text>       how the chart names the guides being shipped
                       (default "These guides")
  --base-label <text>  how it names the earlier ones (default "Earlier guides")`;

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
			options: { check: { type: 'string' }, base: { type: 'string' }, label: { type: 'string' }, 'base-label': { type: 'string' } },
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
		if (!values.check || !values.base) return fail('charts needs --check <dir|file> and --base <dir|file>');
		require('../readme/charts').write(values);
		return 0;
	}
	return fail(sub ? `unknown subcommand "${sub}"` : 'missing subcommand');
}

module.exports = { name: 'readme', summary: "Redraw the README's art: brand (docs/assets) and charts (docs/assets/charts)", usage, run };
