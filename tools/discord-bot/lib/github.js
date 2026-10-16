'use strict';
// GitHub's REST API, the calls the bot and the Actions make: issues, their
// comments and labels, and files on the media branch. Waits out rate limits
// and retries server errors; anything else throws with GitHub's message.

const API = process.env.GITHUB_API_URL || 'https://api.github.com';

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

class GitHubError extends Error {
	constructor(status, body, what) {
		super(`GitHub ${what}: ${status} ${body && body.message ? body.message : ''}`.trim());
		this.status = status;
	}
}

function createGitHub({ token, repo, api = API, fetch: fetchImpl = fetch }) {
	if (!token) throw new Error('GITHUB_TOKEN is not set');
	if (!/^[\w.-]+\/[\w.-]+$/.test(repo || '')) throw new Error(`not a repository: ${repo}`);

	async function request(method, path, body, attempt = 0) {
		const res = await fetchImpl(api + path, {
			method,
			headers: {
				Authorization: `Bearer ${token}`,
				Accept: 'application/vnd.github+json',
				'X-GitHub-Api-Version': '2022-11-28',
				'User-Agent': 'polestar-bot',
				'Content-Type': 'application/json',
			},
			body: body === undefined ? undefined : JSON.stringify(body),
		});
		if (res.status === 204) return null;
		const data = await res.json().catch(() => null);
		const limited = res.status === 429 || (res.status === 403 && (res.headers.get('retry-after') || res.headers.get('x-ratelimit-remaining') === '0'));
		if (limited && attempt < 3) {
			const reset = Number(res.headers.get('x-ratelimit-reset')) * 1000 - Date.now();
			await sleep(Math.min(120000, Number(res.headers.get('retry-after')) * 1000 || reset || 60000));
			return request(method, path, body, attempt + 1);
		}
		if (res.status >= 500 && attempt < 3) {
			await sleep(1000 * 2 ** attempt);
			return request(method, path, body, attempt + 1);
		}
		if (!res.ok) throw new GitHubError(res.status, data, `${method} ${path}`);
		return data;
	}

	const r = `/repos/${repo}`;
	const labelsKnown = new Set();

	// Pages of a list, up to `max` items.
	async function list(path, max = 300) {
		const out = [];
		const sep = path.includes('?') ? '&' : '?';
		for (let page = 1; out.length < max; page++) {
			const items = await request('GET', `${path}${sep}per_page=100&page=${page}`);
			out.push(...items);
			if (items.length < 100) break;
		}
		return out.slice(0, max);
	}

	return {
		repo,
		request,
		list,
		getIssue: (n) => request('GET', `${r}/issues/${n}`),
		createIssue: (fields) => request('POST', `${r}/issues`, fields),
		updateIssue: (n, fields) => request('PATCH', `${r}/issues/${n}`, fields),
		comment: (n, body) => request('POST', `${r}/issues/${n}/comments`, { body }),
		comments: (n) => list(`${r}/issues/${n}/comments`),
		addLabels: (n, labels) => request('POST', `${r}/issues/${n}/labels`, { labels }),
		// Gone already is fine (404).
		removeLabel: (n, name) => request('DELETE', `${r}/issues/${n}/labels/${encodeURIComponent(name)}`).catch((err) => {
			if (err.status !== 404) throw err;
		}),
		releases: () => list(`${r}/releases`, 100),
		// Issues (not pull requests) carrying a label, newest first.
		issuesLabelled: async (label, { state = 'all', since, max = 300 } = {}) => {
			let q = `${r}/issues?labels=${encodeURIComponent(label)}&state=${state}&sort=created&direction=desc`;
			if (since) q += `&since=${encodeURIComponent(since)}`;
			return (await list(q, max)).filter((i) => !i.pull_request);
		},
		// Creates each label missing from the repository, with infoFor(name)'s colour and description.
		async ensureLabels(names, infoFor) {
			for (const name of names) {
				if (labelsKnown.has(name)) continue;
				try {
					await request('GET', `${r}/labels/${encodeURIComponent(name)}`);
				} catch (err) {
					if (err.status !== 404) throw err;
					const info = infoFor(name);
					try {
						await request('POST', `${r}/labels`, { name, color: info.color, description: info.description.slice(0, 100) });
					} catch (e) {
						if (e.status !== 422) throw e; // made meanwhile
					}
				}
				labelsKnown.add(name);
			}
		},
	};
}

// The media branch: an orphan branch holding the screenshots, one commit per
// file. Writes go one at a time (the contents API rejects a commit whose
// branch moved underneath it) and a file already there is not written again.
function createMedia({ github, repo = github.repo, branch, fetch: fetchImpl = fetch, maxBytes = 20 * 1024 * 1024 }) {
	const r = `/repos/${repo}`;
	let ready = null;
	let queue = Promise.resolve();

	function ensureBranch() {
		if (!ready) {
			ready = (async () => {
				try {
					await github.request('GET', `${r}/git/ref/heads/${branch}`);
					return;
				} catch (err) {
					if (err.status !== 404) throw err;
				}
				const readme = 'Screenshots copied from the Polestar Discord #bugs forum by tools/discord-bot, so the\n' +
					'issues keep them after Discord\'s links expire. Nothing here is built or released.\n';
				const tree = await github.request('POST', `${r}/git/trees`, {
					tree: [{ path: 'README.md', mode: '100644', type: 'blob', content: readme }],
				});
				const commit = await github.request('POST', `${r}/git/commits`, { message: 'Media: start the bug screenshots branch', tree: tree.sha, parents: [] });
				await github.request('POST', `${r}/git/refs`, { ref: `refs/heads/${branch}`, sha: commit.sha });
			})().catch((err) => {
				ready = null;
				throw err;
			});
		}
		return ready;
	}

	const encodePath = (p) => p.split('/').map(encodeURIComponent).join('/');
	const rawUrl = (p) => `https://raw.githubusercontent.com/${repo}/${branch}/${encodePath(p)}`;

	async function put(path, bytes, message) {
		await ensureBranch();
		const at = `${r}/contents/${encodePath(path)}`;
		try {
			await github.request('GET', `${at}?ref=${branch}`);
			return; // already copied
		} catch (err) {
			if (err.status !== 404) throw err;
		}
		for (let attempt = 0; ; attempt++) {
			try {
				await github.request('PUT', at, { message, content: Buffer.from(bytes).toString('base64'), branch });
				return;
			} catch (err) {
				if (err.status !== 409 || attempt >= 3) throw err;
			}
		}
	}

	// Copies a Discord attachment and returns its permanent URL, or null when
	// it is too big or cannot be fetched (the caller links Discord instead).
	function copy(path, attachment, message) {
		const job = queue.then(async () => {
			if (attachment.size > maxBytes) return null;
			const res = await fetchImpl(attachment.url);
			if (!res.ok) return null;
			const bytes = new Uint8Array(await res.arrayBuffer());
			await put(path, bytes, message);
			return rawUrl(path);
		});
		queue = job.catch(() => {});
		return job;
	}

	return { copy, rawUrl, ensureBranch };
}

module.exports = { createGitHub, createMedia, GitHubError };
