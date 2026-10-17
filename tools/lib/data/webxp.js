'use strict';
// Quest XP for quests QuestieDB's QuestXP table lacks (mostly Forever-only
// ones), from two public Forever databases (used with
// permission; results stay in data/, which is gitignored):
// - wowforevertalents.com: quest pages read from the Forever beta client's
//   quest cache ("Rewards ... XP 1,350"); its sitemap lists the pages.
// - foreverchanges.pro: /quest/<id> pages from Wowhead's Forever database:
//   the page's own Rewards block ("Experience: 550"), else the XP its quest
//   chain list shows for this quest (source tag "foreverchanges:xp-chain").
// The client-cache site wins when both have a value. Results are cached in
// <sources>/webxp/quest-xp.json ({ "<id>": { wft, fc, fcChain } }, null =
// looked up, no value), so later builds, and --offline builds, reuse them.

const fs = require('node:fs');
const path = require('node:path');

const WFT = 'https://wowforevertalents.com';
const FC = 'https://foreverchanges.pro';
const CONCURRENCY = 4;

function text(html) {
	return html.replace(/<script[\s\S]*?<\/script>/g, ' ').replace(/<[^>]*>/g, '|').replace(/&#x27;/g, "'").replace(/\s+/g, ' ');
}

function int(s) {
	const n = Number(String(s).replace(/,/g, ''));
	return Number.isInteger(n) && n > 0 ? n : null;
}

// wowforevertalents quest page -> xp | null
function parseWft(html) {
	const t = text(html);
	const i = t.indexOf('Rewards');
	const m = i >= 0 ? /\|\s*XP\s*\|?\s*([\d,]+)/.exec(t.slice(i)) || /\bXP\s+([\d,]+)/.exec(t.slice(i)) : null;
	return m ? int(m[1]) : null;
}

// foreverchanges quest page -> { xp, chain } | null: its own Rewards block,
// else the chain list's entry marked as this quest.
function parseFc(html) {
	const m = /Experience:[|\s]*([\d,]+)/.exec(text(html));
	if (m && int(m[1])) return { xp: int(m[1]), chain: false };
	const i = html.indexOf('class="qp-route-quest is-here"');
	if (i < 0) return null;
	const rest = html.slice(i + 1);
	const end = Math.min(...['class="qp-route-quest', '</li>'].map((s) => (rest.indexOf(s) < 0 ? Infinity : rest.indexOf(s))));
	const c = /qp-route-xp">([\d,]+) XP/.exec(rest.slice(0, end));
	return c && int(c[1]) ? { xp: int(c[1]), chain: true } : null;
}

// A page that never answers fails its lookup after `timeout` ms, so a site
// holding connections open cannot stall the build.
async function get(fetchImpl, url, timeout = 30000) {
	const res = await fetchImpl(url, { headers: { 'user-agent': 'Mozilla/5.0 (polestar-data-build)' }, signal: AbortSignal.timeout(timeout) });
	if (res.status === 404) return null;
	if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
	return res.text();
}

async function pool(items, fn) {
	let next = 0;
	const workers = Array.from({ length: Math.min(CONCURRENCY, items.length) }, async () => {
		while (next < items.length) {
			const item = items[next++];
			await fn(item);
		}
	});
	await Promise.all(workers);
}

// ids: quest ids wanting xp. -> { xp: Map<id, { xp, source }>, warnings, fetched }
async function loadWebXp({ sourcesDir, ids, offline = false, fetchImpl = globalThis.fetch, timeout, log = () => {} }) {
	const file = path.join(sourcesDir, 'webxp', 'quest-xp.json');
	const cache = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : {};
	const warnings = [];
	let fetched = 0;
	const todo = ids.filter((id) => !cache[id] || cache[id].wft === undefined || cache[id].fc === undefined);
	if (todo.length && !offline) {
		log(`looking up quest XP for ${todo.length} quests on wowforevertalents.com and foreverchanges.pro`);
		let wftPages = new Map();
		try {
			const sm = await get(fetchImpl, `${WFT}/sitemap-0.xml`, timeout);
			for (const m of (sm || '').matchAll(/<loc>(https:\/\/wowforevertalents\.com\/quests\/[a-z0-9-]*-(\d+)\/)<\/loc>/g)) wftPages.set(Number(m[2]), m[1]);
		} catch (err) {
			warnings.push(`wowforevertalents.com sitemap: ${err.message}`);
			wftPages = null;
		}
		let errors = 0;
		await pool(todo, async (id) => {
			const entry = { ...(cache[id] || {}) };
			try {
				if (entry.wft === undefined && wftPages) {
					const url = wftPages.get(id);
					entry.wft = url ? parseWft((await get(fetchImpl, url, timeout)) || '') : null;
				}
				if (entry.fc === undefined) {
					const html = await get(fetchImpl, `${FC}/quest/${id}`, timeout);
					const r = html ? parseFc(html) : null;
					entry.fc = r ? r.xp : null;
					if (r && r.chain) entry.fcChain = true;
				}
				fetched++;
			} catch (err) {
				errors++;
				if (errors <= 3) warnings.push(`quest ${id} XP lookup: ${err.message}`);
			}
			cache[id] = entry;
		});
		if (errors > 3) warnings.push(`${errors} quest XP lookups failed in all; rerun to retry them`);
		fs.mkdirSync(path.dirname(file), { recursive: true });
		const sorted = {};
		for (const k of Object.keys(cache).map(Number).sort((a, b) => a - b)) sorted[k] = cache[k];
		fs.writeFileSync(`${file}.tmp`, `${JSON.stringify(sorted, null, '\t')}\n`);
		fs.renameSync(`${file}.tmp`, file);
	}
	const xp = new Map();
	for (const id of ids) {
		const e = cache[id];
		if (!e) continue;
		if (e.wft) xp.set(id, { xp: e.wft, source: 'wowforevertalents:xp' });
		else if (e.fc) xp.set(id, { xp: e.fc, source: e.fcChain ? 'foreverchanges:xp-chain' : 'foreverchanges:xp' });
	}
	return { xp, warnings, fetched, file };
}

module.exports = { loadWebXp, parseWft, parseFc, WFT, FC };
