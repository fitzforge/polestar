'use strict';
// new: start a guide pack in a folder from tools/templates/pack/.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { parseArgs } = require('../lib/cli');
const { validateManifest } = require('../lib/pack/manifest');
const { defaultFolder, placeholderLicense } = require('../lib/pack/format');

const { ROOT } = require('../lib/paths');
const TEMPLATE = path.join(ROOT, 'tools', 'templates', 'pack');
// The pack authors' skill, copied as is into the folders coding tools read a
// project's skills from: .agents/skills (most of them) and .claude/skills.
const SKILL = path.join(ROOT, 'skills', 'polestar-guide-pack');
const SKILL_DIRS = [path.join('.agents', 'skills'), path.join('.claude', 'skills')];
// Files that need Polestar's repository URL; skipped without one.
const NEEDS_REPO = [path.join('.github', 'workflows', 'pack.yml'), path.join('.devcontainer', 'devcontainer.json')];
const KEYS = ['id', 'title', 'author', 'license', 'folder', 'year', 'repo'];
const LICENSE_NAMES = {
	'CC-BY-4.0': 'Creative Commons Attribution 4.0 International',
	'CC0-1.0': 'CC0 1.0 Universal',
};
const LICENSE_LINKS = {
	'CC-BY-4.0': 'https://creativecommons.org/licenses/by/4.0/legalcode',
	'CC0-1.0': 'https://creativecommons.org/publicdomain/zero/1.0/legalcode',
};

const usage = `usage: node tools/polestar.js new [dir] [options]

Starts a pack in [dir] (default: the current folder), which must be
empty or missing (run it before \`git init\`: a folder holding .git is not
empty): pack.json, an example guide, README.md, LICENSE, .gitignore, VS Code
tasks, AGENTS.md / CLAUDE.md for AI assistants, the polestar-guide-pack skill
(skills/ in this clone) in .agents/skills/ and .claude/skills/, and a GitHub
workflow and a dev container that install Polestar from this clone's origin
remote. The origin must be an http(s) or SSH URL; it is written as https,
without a user name, password, query or fragment. With no origin, or any
other kind, those two are left out.
Asks for each value not given, unless --yes accepts the defaults; without a
terminal to ask in, it writes nothing and exits 1 unless --yes or all four
values are given.

options:
  --id <id>             pack id, e.g. joe-routes (default: from the folder name)
  --title <text>        pack title (default: from the id)
  --author <name>       author (default: git config user.name)
  --license <spdx>      licence, e.g. CC-BY-4.0, CC0-1.0, MIT, GPL-3.0-only
                        (default CC-BY-4.0)
  --yes                 accept the defaults for every value not given`;

function git(args, cwd) {
	const r = spawnSync('git', args, { cwd, encoding: 'utf8' });
	return r.status === 0 ? r.stdout.trim() : '';
}

// Polestar's public repository: the origin of this clone. POLESTAR_ORIGIN_URL
// overrides it (empty = none), for tests.
function repoUrl() {
	if (process.env.POLESTAR_ORIGIN_URL !== undefined) return process.env.POLESTAR_ORIGIN_URL.trim();
	return git(['remote', 'get-url', 'origin'], ROOT);
}

// The origin as a public https URL a runner or Codespace can clone without a
// key: SSH and http forms become https; user info (credentials), query and
// fragment are dropped. null when it is not an http(s) or SSH URL, or when
// it holds a character the shell would read inside double quotes ($, `, \).
function publicUrl(origin) {
	let url = origin.trim();
	const scp = /^[^@/\s]+@([^:/\s]+):(?!\/)(.+)$/.exec(url);
	if (scp) url = `https://${scp[1]}/${scp[2]}`;
	let u;
	try {
		u = new URL(url);
	} catch {
		return null;
	}
	if (u.protocol === 'ssh:' || u.protocol === 'git+ssh:') u = new URL(`https://${u.hostname}${u.pathname}`);
	else if (u.protocol === 'http:') u = new URL(`https://${u.host}${u.pathname}`);
	if (u.protocol !== 'https:') return null;
	u.username = '';
	u.password = '';
	u.search = '';
	u.hash = '';
	const out = u.toString();
	return /^[A-Za-z0-9._~:/%@+!,;=*'()[\]&-]+$/.test(out) ? out : null;
}

// Known SPDX ids in their canonical case.
const SPDX = ['MIT', 'CC-BY-4.0', 'CC0-1.0', 'GPL-3.0-only'];
const canonicalLicense = (s) => SPDX.find((x) => x.toLowerCase() === String(s).trim().toLowerCase()) || String(s).trim();

function defaults(dir, given) {
	const id =
		given.id ||
		path
			.basename(dir)
			.toLowerCase()
			.replace(/[^a-z0-9-]+/g, '-')
			.replace(/^-+|-+$/g, '')
			.slice(0, 32) ||
		'my-guides';
	const title = given.title || id.split('-').filter(Boolean).map((w) => w[0].toUpperCase() + w.slice(1)).join(' ');
	return { id, title, author: given.author || git(['config', 'user.name'], process.cwd()) || 'Me', license: given.license || 'CC-BY-4.0' };
}

async function ask(values, given) {
	const readline = require('node:readline/promises');
	const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
	// End of input before an answer: give up instead of waiting forever.
	const closed = new Promise((_, reject) => rl.once('close', () => reject(new Error('input ended before every value was given'))));
	closed.catch(() => {});
	try {
		for (const [key, label] of [
			['id', 'Pack id (lowercase letters, digits, -)'],
			['title', 'Title'],
			['author', 'Author'],
			['license', 'Licence (SPDX id, e.g. CC-BY-4.0, CC0-1.0, MIT)'],
		]) {
			if (given[key]) continue;
			const answer = (await Promise.race([rl.question(`${label} [${values[key]}]: `), closed])).trim();
			if (answer) values[key] = answer;
			if (key === 'id' && !given.title && answer) values.title = defaults('', { id: answer }).title;
		}
	} finally {
		rl.close();
	}
	return values;
}

// The GNU GPL version 3 text, from its heading on, as our LICENSE carries it.
function gplText() {
	const text = fs.readFileSync(path.join(ROOT, 'LICENSE'), 'utf8');
	const at = text.search(/^[ \t]*GNU GENERAL PUBLIC LICENSE[ \t]*$/m);
	if (at < 0) throw new Error('LICENSE does not hold the GNU General Public License text');
	return text.slice(at);
}

function licenseText(values) {
	const { license, author, year } = values;
	if (license === 'GPL-3.0-only')
		return `${values.title}
Copyright (c) ${year} ${author}

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, version 3.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License below for more
details.

--------------------------------------------------------------------------------

${gplText()}`;
	if (license === 'MIT')
		return `MIT License

Copyright (c) ${year} ${author}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
`;
	if (LICENSE_LINKS[license]) return `${values.title} by ${author} (${year}) is licensed under ${LICENSE_NAMES[license]} (${license}):\n${LICENSE_LINKS[license]}\n`;
	return placeholderLicense(license);
}

// Template files, relative paths, sorted.
function templateFiles(dir = TEMPLATE, rel = '') {
	const out = [];
	for (const e of fs.readdirSync(dir, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
		const r = path.join(rel, e.name);
		if (e.isDirectory()) out.push(...templateFiles(path.join(dir, e.name), r));
		else out.push(r);
	}
	return out;
}

function fill(text, values, json) {
	return text.replace(new RegExp(`\\{\\{(${KEYS.join('|')})\\}\\}`, 'g'), (_, k) => (json ? JSON.stringify(String(values[k])).slice(1, -1) : String(values[k])));
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--yes'], options: ['--id', '--title', '--author', '--license'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	if (error || positional.length > 1) {
		console.error(`${error || 'at most one folder'}\n\n${usage}`);
		return 2;
	}
	const dir = path.resolve(positional[0] || '.');
	if (fs.existsSync(dir) && (!fs.statSync(dir).isDirectory() || fs.readdirSync(dir).length > 0)) {
		console.error(`new: ${dir} is not an empty folder; pick a new or empty one`);
		return 1;
	}
	const given = { id: opts.id, title: opts.title, author: opts.author, license: opts.license };
	if (given.license) given.license = canonicalLicense(given.license);
	let values = defaults(dir, given);
	const missing = ['id', 'title', 'author', 'license'].some((k) => !given[k]);
	if (!opts.yes && missing) {
		const how = 'pass --id, --title, --author and --license, or --yes to accept the defaults';
		if (!process.stdin.isTTY) {
			console.error(`new: no terminal to ask in; ${how}`);
			return 1;
		}
		try {
			values = await ask(values, given);
		} catch (err) {
			console.error(`new: ${err.message}; ${how}`);
			return 1;
		}
		values.license = canonicalLicense(values.license);
	}
	const manifest = { id: values.id, title: values.title, author: values.author, version: '0.1.0', license: values.license };
	const problems = validateManifest(manifest, 'pack.json').filter((d) => d.severity === 'error');
	if (problems.length) {
		for (const d of problems) console.error(`new: ${d.message}${d.hint ? ` (${d.hint})` : ''}`);
		return 1;
	}
	values.folder = defaultFolder(values.title, values.id);
	values.year = String(new Date().getFullYear());
	const origin = repoUrl();
	values.repo = origin ? publicUrl(origin) : '';

	const files = templateFiles().filter((f) => values.repo || !NEEDS_REPO.includes(f));
	for (const f of files) {
		const text = fill(fs.readFileSync(path.join(TEMPLATE, f), 'utf8'), values, f.endsWith('.json'));
		fs.mkdirSync(path.dirname(path.join(dir, f)), { recursive: true });
		fs.writeFileSync(path.join(dir, f), text);
	}
	for (const into of SKILL_DIRS) fs.cpSync(SKILL, path.join(dir, into, path.basename(SKILL)), { recursive: true });
	fs.writeFileSync(path.join(dir, 'LICENSE'), licenseText(values));
	console.log(`new: wrote the pack "${values.id}" to ${dir}`);
	if (origin && !values.repo) {
		console.log('note: skipped .github/workflows/pack.yml and .devcontainer/: the origin remote of this Polestar clone is not an http(s) or SSH URL a runner could clone, so they would not know where to install Polestar from');
	} else if (!values.repo) {
		console.log(
			'note: skipped .github/workflows/pack.yml and .devcontainer/: this Polestar clone has no origin remote (`git remote get-url origin`), so they would not know where to install Polestar from',
		);
	}
	console.log('next: cd into it, then `polestar lint` and `polestar playtest`; start from guides/example.guide');
	return 0;
}

module.exports = { name: 'new', summary: 'Start a pack in a new folder from the template', usage, run };
