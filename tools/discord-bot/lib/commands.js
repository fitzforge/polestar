'use strict';
// Admin slash commands in the #bugs threads: /close with a reason and
// /reopen. They act on the thread's GitHub issue; discord-issue-sync.yml then
// tells the thread, sets its tag and locks or unlocks it, exactly as when the
// issue is closed or reopened on GitHub (lib/notify.js).
//
// Registered in the forum's server only, for Administrators
// (default_member_permissions). Every use is checked again here, since a
// server can loosen a command's permissions in its own settings.
//
//   const commands = createCommands({ discord, github, issueFor, log });
//   await commands.register(applicationId, guildId);   // on READY
//   await commands.handle(interaction);                 // on INTERACTION_CREATE

const ADMINISTRATOR = 1n << 3n;
const EPHEMERAL = 64;
const MAX_NOTE = 1000;

// How each reason closes the issue: GitHub's state_reason and the resolution
// label lib/notify.js words the thread's message by.
const REASONS = {
	fixed: { name: 'Fixed', stateReason: 'completed' },
	wontfix: { name: 'Won\u2019t fix', stateReason: 'not_planned', label: 'resolution:wontfix' },
	noaction: { name: 'No action needed', stateReason: 'not_planned', label: 'resolution:no-action' },
	noreproduce: { name: 'Can\u2019t reproduce', stateReason: 'not_planned', label: 'resolution:cannot-reproduce' },
	unresolved: { name: 'Not resolved', stateReason: 'not_planned', label: 'resolution:not-resolved' },
	duplicate: { name: 'Duplicate', stateReason: 'duplicate', label: 'resolution:duplicate' },
};
const RESOLUTION_LABELS = Object.values(REASONS).map((r) => r.label).filter(Boolean);

const LABEL_INFO = {
	'resolution:wontfix': { color: 'ffffff', description: 'Closed from Discord: not changing it' },
	'resolution:no-action': { color: 'ffffff', description: 'Closed from Discord: works as intended, nothing to change' },
	'resolution:cannot-reproduce': { color: 'ffffff', description: 'Closed from Discord: could not reproduce it' },
	'resolution:not-resolved': { color: 'ffffff', description: 'Closed from Discord without a fix' },
	'resolution:duplicate': { color: 'cfd3d7', description: 'Closed from Discord: already reported' },
};

const STRING = 3;
const INTEGER = 4;
const issueOption = { type: INTEGER, name: 'issue', description: 'The issue number, when not used in its #bugs thread', required: false, min_value: 1 };
const COMMANDS = [
	{
		name: 'close',
		description: 'Close this bug report and tell the reporter why',
		default_member_permissions: String(ADMINISTRATOR),
		contexts: [0],
		options: [
			{ type: STRING, name: 'reason', description: 'Why it closes', required: true, choices: Object.entries(REASONS).map(([value, r]) => ({ name: r.name, value })) },
			{ type: STRING, name: 'note', description: 'What to tell the reporter (quoted in the thread)', required: false, max_length: MAX_NOTE },
			{ type: INTEGER, name: 'duplicate_of', description: 'The issue it duplicates (Duplicate only)', required: false, min_value: 1 },
			issueOption,
		],
	},
	{
		name: 'reopen',
		description: 'Reopen this bug report and tell the reporter',
		default_member_permissions: String(ADMINISTRATOR),
		contexts: [0],
		options: [issueOption],
	},
];

function isAdmin(interaction) {
	const perms = interaction.member && interaction.member.permissions;
	if (perms === undefined || perms === null) return false;
	try {
		return (BigInt(perms) & ADMINISTRATOR) === ADMINISTRATOR;
	} catch {
		return false;
	}
}

function options(interaction) {
	const out = {};
	for (const o of (interaction.data && interaction.data.options) || []) out[o.name] = o.value;
	return out;
}

const link = (repo, n) => `[${repo}#${n}](<https://github.com/${repo}/issues/${n}>)`;

function createCommands({ discord, github, issueFor, log = console }) {
	const repo = github.repo;

	async function register(applicationId, guildId) {
		try {
			await discord.request('PUT', `/applications/${applicationId}/guilds/${guildId}/commands`, COMMANDS);
			log.info('slash commands registered: /close, /reopen');
		} catch (err) {
			const hint = err.status === 403 ? ' (invite the bot again with the applications.commands scope: tools/discord-bot/README.md)' : '';
			log.error(`slash commands not registered: ${err.message}${hint}`);
		}
	}

	// Which issue: the one given, else the one filed from this thread.
	async function target(interaction, opts) {
		if (opts.issue) return opts.issue;
		return issueFor(interaction.channel_id);
	}

	async function close(interaction, opts) {
		const reason = REASONS[opts.reason];
		if (!reason) return `Unknown reason "${opts.reason}".`;
		const n = await target(interaction, opts);
		if (!n) return 'This isn\u2019t a filed bug report. Use it in a #bugs thread, or give the issue number.';
		if (opts.reason === 'duplicate' && !opts.duplicate_of) return 'Give the issue it duplicates in `duplicate_of`.';
		if (opts.duplicate_of === n) return 'An issue can\u2019t duplicate itself.';
		const issue = await github.getIssue(n);
		if (issue.state === 'closed') return `${link(repo, n)} is already closed.`;

		// The note first: lib/notify.js quotes the last maintainer comment.
		// An administrator's words, taken as they are (they reach Discord as
		// written, so no HTML escaping).
		const note = opts.note ? String(opts.note).trim().slice(0, MAX_NOTE) : '';
		if (opts.reason === 'duplicate') await github.comment(n, `Duplicate of #${opts.duplicate_of}${note ? `\n\n${note}` : ''}`);
		else if (note) await github.comment(n, note);

		const had = (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));
		for (const old of had.filter((l) => RESOLUTION_LABELS.includes(l) && l !== reason.label)) await github.removeLabel(n, old);
		if (reason.label && !had.includes(reason.label)) {
			await github.ensureLabels([reason.label], (name) => LABEL_INFO[name]);
			await github.addLabels(n, [reason.label]);
		}
		await github.updateIssue(n, { state: 'closed', state_reason: reason.stateReason });
		return `Closed ${link(repo, n)} as **${reason.name}**. The reporter will be told in the thread.`;
	}

	async function reopen(interaction, opts) {
		const n = await target(interaction, opts);
		if (!n) return 'This isn\u2019t a filed bug report. Use it in a #bugs thread, or give the issue number.';
		const issue = await github.getIssue(n);
		if (issue.state === 'open') return `${link(repo, n)} is already open.`;
		const had = (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));
		for (const old of had.filter((l) => RESOLUTION_LABELS.includes(l))) await github.removeLabel(n, old);
		await github.updateIssue(n, { state: 'open' });
		return `Reopened ${link(repo, n)}. The thread will be unlocked and the reporter told.`;
	}

	// One interaction: answered at once (only the admin sees it), the work
	// done after, since GitHub may take longer than Discord's 3 seconds.
	async function handle(interaction) {
		if (interaction.type !== 2 || !interaction.data || !['close', 'reopen'].includes(interaction.data.name)) return;
		const callback = `/interactions/${interaction.id}/${interaction.token}/callback`;
		const none = { parse: [] };
		if (!isAdmin(interaction)) {
			await discord.request('POST', callback, { type: 4, data: { content: 'Only server administrators can close or reopen bug reports.', flags: EPHEMERAL, allowed_mentions: none } });
			return;
		}
		await discord.request('POST', callback, { type: 5, data: { flags: EPHEMERAL } });
		let content;
		try {
			const opts = options(interaction);
			content = interaction.data.name === 'close' ? await close(interaction, opts) : await reopen(interaction, opts);
		} catch (err) {
			log.error(`/${interaction.data.name}:`, err.message);
			content = `That didn\u2019t work: ${err.message}`;
		}
		await discord.request('PATCH', `/webhooks/${interaction.application_id}/${interaction.token}/messages/@original`, { content, allowed_mentions: none });
	}

	return { register, handle };
}

module.exports = { createCommands, COMMANDS, REASONS, RESOLUTION_LABELS, isAdmin };
