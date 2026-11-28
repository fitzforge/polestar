'use strict';
// Chat commands in the Polestar Discord.
//
// `!bug` (or `!bugs`), for anyone: how to report a bug from the game. Capped
// so it can't be spammed: a channel gets it at most once every 10 minutes, a
// person can call it once an hour, and the whole server gets at most 6
// answers an hour; past a cap the command is ignored silently. Never in the
// #bugs forum or its threads: everything written there is copied to the issue.
//
// The FAQ answers (lib/faq.js, faq/*.md), e.g. `!dungeons`: for anyone, the
// same caps as `!bug` (shared with it), never in #bugs, mentions off.
//
// `!report` and `!suggest`, for the maintainer (MAINTAINER_IDS) only, as a
// reply to someone's message anywhere: the bot files that player's messages
// as an issue (lib/sync.js fileChat) and answers next to their message with
// the link, then deletes the command when it may. Text after the command is
// the issue's title. Anyone else is told off, under the same caps as `!bug`,
// and nothing is filed.
//
// `!bug <text>` by the maintainer is `!report <text>`; for anyone else it is
// the plain `!bug` help (no filing, no telling-off).
//
// `!suggest` or `!report` inside a post of the suggestions forum
// (SUGGESTIONS_FORUM_ID), by the maintainer and with no reply needed, files
// the whole post, its first message and every reply (lib/sync.js fileIdea),
// as a suggestion or as a bug. A post filed already (either way) answers
// "Already filed as #N".
//
//   const chat = createChat({ discord, forumId, suggestionsForumId, maintainerIds, file: sync.fileChat, fileIdea: sync.fileIdea, repo, faq, log });
//   chat.dispatch(type, d);   // every gateway event, beside the sync

const HOUR_MS = 60 * 60 * 1000;
const LIMITS = { channelMs: 10 * 60 * 1000, userMs: HOUR_MS, perHour: 6 };
const COMMANDS = new Set(['!bug', '!bugs']);
const FILE_COMMAND = /^!(report|suggest)(?:\s+([\s\S]*))?$/i;
// `!bug` or `!bugs` with text after it.
const BUG_TEXT = /^!bugs?\s+(\S[\s\S]*)$/i;
const NAUGHTY = "Naughty naughty, you're not Master Fitz.";

// Whether a message is a `!report`, `!suggest` or `!bug <text>` command.
const isChatCommand = (content) => FILE_COMMAND.test(String(content || '').trim()) || BUG_TEXT.test(String(content || '').trim());

// The answer, in Discord's Markdown; <#id> shows as a link to the forum.
function bugHelp(forumId) {
	return [
		'**🐞 Found a bug or a wrong step? Here\'s how to report it**',
		'',
		'**1.** Make sure you\'re on the **latest Polestar**. Your bug might already be fixed!',
		'**2.** In game, click the **bug icon** in the guide window (next to Lookup), or type `/polestar report`',
		'**3.** Tell us **what went wrong** in a sentence or two. If a step points to the wrong place, use **Mark the right spot**',
		`**4.** Click **Copy report** and paste it in a new post in <#${forumId}>`,
		'',
		'That\'s it! The report already has your step, location, addons and version, so you only need screenshots when something looks wrong on screen. The bot files it for the developers and **replies in your thread when it\'s fixed** 🙏',
		'',
		'**Tips for a great report:**',
		'• What you expected vs what happened ("the NPC isn\'t here, he\'s inside the inn")',
		'• One problem per post',
		'• Mobs too strong or a quest too high for your level? Report it, we\'re fixing those right now',
		'',
		'Have GitHub? **Open on GitHub** in the same window works too.',
	].join('\n');
}

// The reply under the player's message once `!report`/`!suggest` filed it:
// [content, users to ping]. Newly filed: thanks, pinging them; filed before:
// where it is, pinging no one.
function filedReply(kind, repo, { number: n, thread, existing, reporter }) {
	const issue = `[#${n}](<https://github.com/${repo}/issues/${n}>)`;
	if (existing) return [`Already filed as [${repo}#${n}](<https://github.com/${repo}/issues/${n}>).` + (thread ? ` Follow-ups: <#${thread}>` : ''), []];
	const where = thread ? ` You can follow it and add details in <#${thread}>` : '';
	if (kind === 'suggestion') return [`Thanks <@${reporter}>! Your idea has been added as a suggestion: ${issue}.${where}${where ? '.' : ''}`, [reporter]];
	return [`Thanks <@${reporter}>! This has now been reported as a bug: ${issue}.${where}${where ? ", and we'll let you know there when it's fixed." : ''}`, [reporter]];
}

// The caps: take(channel, user) is true, and counts, when an answer may go out.
function createCaps(limits, now) {
	const lastInChannel = new Map(); // channel -> when it last got an answer
	const lastByUser = new Map(); // user -> when they last got an answer
	let answers = []; // when each answer went out, the last hour's
	return function take(channel, user) {
		const t = now();
		const recent = (map, key, ms) => map.has(key) && t - map.get(key) < ms;
		answers = answers.filter((at) => t - at < HOUR_MS);
		if (recent(lastInChannel, channel, limits.channelMs) || (user && recent(lastByUser, user, limits.userMs))
			|| answers.length >= limits.perHour) return false;
		lastInChannel.set(channel, t);
		if (user) lastByUser.set(user, t);
		answers.push(t);
		return true;
	};
}

function createChat({ discord, forumId, suggestionsForumId = null, maintainerIds = [], file = null, fileIdea = null, repo = 'fitzforge/polestar', faq = [], log = console, now = Date.now, limits = LIMITS }) {
	const maintainers = new Set(maintainerIds);
	const answers = new Map(faq.flatMap((e) => e.commands.map((c) => [c, e])));
	const takeHelp = createCaps(limits, now);
	const takeNaughty = createCaps(limits, now);
	const parents = new Map(); // channel -> its parent channel's id ('' for none)

	async function parentOf(channel) {
		if (!parents.has(channel)) {
			const c = await discord.getChannel(channel);
			parents.set(channel, c.parent_id || '');
		}
		return parents.get(channel);
	}

	// `text` answers `name`: the bug help or a FAQ answer, with its `image` ({ name, type, data }) if it has one.
	async function help(d, name, text, image = null) {
		if (d.channel_id === forumId || (await parentOf(d.channel_id)) === forumId) return false;
		const user = d.author && d.author.id;
		if (!takeHelp(d.channel_id, user)) {
			log.info(`${name} ignored (cap) in ${d.channel_id} from ${user || '?'}`);
			return false;
		}
		await discord.send(d.channel_id, text, [], [], image ? [image] : []);
		return true;
	}

	// `!report`/`!suggest`/`!bug <text>`: `kind` 'report' or 'suggestion', `title`
	// the text after it, `name` what was typed.
	async function fileCommand(d, kind, title, name = kind === 'suggestion' ? '!suggest' : '!report') {
		const user = d.author && d.author.id;
		if (!maintainers.has(user)) {
			if (!takeNaughty(d.channel_id, user)) {
				log.info(`${name} from ${user || '?'} ignored (not the maintainer, cap) in ${d.channel_id}`);
				return false;
			}
			log.info(`${name} from ${user || '?'} refused (not the maintainer) in ${d.channel_id}`);
			await discord.reply(d.channel_id, d.id, NAUGHTY);
			return true;
		}
		if (suggestionsForumId && fileIdea && (await parentOf(d.channel_id)) === suggestionsForumId) return filePost(d, kind, title, name);
		const ref = d.message_reference;
		if (!ref || !ref.message_id || (ref.type || 0) !== 0 || !file) {
			await discord.reply(d.channel_id, d.id, `Reply to the message you want filed with \`${name}\`, and a title after it if you like.`);
			return false;
		}
		const channel = ref.channel_id || d.channel_id;
		let result;
		try {
			result = await file(kind, { channel, message: ref.message_id, title: title.split('\n')[0] });
		} catch (err) {
			log.error(`${name}:`, err.message);
			await discord.reply(d.channel_id, d.id, `That didn\u2019t work: ${err.message}`);
			return false;
		}
		if (result.error) {
			await discord.reply(d.channel_id, d.id, result.error);
			return false;
		}
		// Next to the player's message: a thank-you that pings them (newly
		// filed), or where it is already (no ping); the command itself goes.
		await discord.reply(channel, ref.message_id, ...filedReply(kind, repo, result));
		await dropCommand(d, name);
		return true;
	}

	// The command goes when the bot may delete it (Manage Messages).
	async function dropCommand(d, name) {
		try {
			await discord.deleteMessage(d.channel_id, d.id);
		} catch (err) {
			if (err.status !== 403 && err.status !== 404) log.warn(`${name}: command not deleted: ${err.message}`);
		}
	}

	// `!suggest`/`!report` in a suggestions post: the whole post filed as a
	// suggestion or a bug. Newly filed, the bot's "Tracked as #N" in the post
	// is the answer (a bug also gets its thank-you under the first message);
	// filed before, it says so.
	async function filePost(d, kind, title, name) {
		let result;
		try {
			result = await fileIdea(d.channel_id, { kind, title: title.split('\n')[0] });
		} catch (err) {
			log.error(`${name}:`, err.message);
			await discord.reply(d.channel_id, d.id, `That didn\u2019t work: ${err.message}`);
			return false;
		}
		if (result.error) {
			await discord.reply(d.channel_id, d.id, result.error);
			return false;
		}
		if (result.existing) await discord.send(d.channel_id, filedReply(kind, repo, { ...result, thread: null })[0]);
		else if (kind === 'report' && result.reporter) await discord.reply(d.channel_id, d.channel_id, ...filedReply(kind, repo, { ...result, thread: null }));
		await dropCommand(d, name);
		return true;
	}

	async function message(d) {
		if (!d || !d.channel_id || (d.author && d.author.bot) || d.webhook_id) return false;
		const text = (d.content || '').trim();
		const command = text.match(FILE_COMMAND);
		if (command) return fileCommand(d, command[1].toLowerCase() === 'suggest' ? 'suggestion' : 'report', (command[2] || '').trim());
		// `!bug <text>`: the maintainer's is `!report <text>`; anyone's else the plain help.
		const bug = text.match(BUG_TEXT);
		if (bug && maintainers.has(d.author && d.author.id)) return fileCommand(d, 'report', bug[1].trim(), '!bug');
		const word = text.toLowerCase();
		if (!bug && answers.has(word)) return help(d, word, answers.get(word).text, answers.get(word).image);
		if (!bug && !COMMANDS.has(word)) return false;
		return help(d, '!bug', bugHelp(forumId));
	}

	return {
		dispatch(type, d) {
			if (type !== 'MESSAGE_CREATE') return null;
			return message(d).catch((err) => {
				log.error('chat command:', err.message);
				return false;
			});
		},
	};
}

module.exports = { createChat, bugHelp, filedReply, isChatCommand, LIMITS, NAUGHTY };
