'use strict';
// Chat commands anyone can type in the Polestar Discord: `!bug` (or `!bugs`)
// answers with how to report a bug from the game. One answer per channel a
// minute, so a burst of them posts one. Never in the #bugs forum or its
// threads: everything written there is copied to the issue.
//
//   const chat = createChat({ discord, forumId, log });
//   chat.dispatch(type, d);   // every gateway event, beside the sync

const COOLDOWN_MS = 60 * 1000;
const COMMANDS = new Set(['!bug', '!bugs']);

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

function createChat({ discord, forumId, log = console, now = Date.now }) {
	const last = new Map(); // channel -> when it last got the answer
	const parents = new Map(); // channel -> its parent channel's id ('' for none)

	async function parentOf(channel) {
		if (!parents.has(channel)) {
			const c = await discord.getChannel(channel);
			parents.set(channel, c.parent_id || '');
		}
		return parents.get(channel);
	}

	async function message(d) {
		if (!d || !d.channel_id || (d.author && d.author.bot) || d.webhook_id) return false;
		if (!COMMANDS.has((d.content || '').trim().toLowerCase())) return false;
		if (d.channel_id === forumId || (await parentOf(d.channel_id)) === forumId) return false;
		const t = now();
		const prev = last.get(d.channel_id);
		if (prev !== undefined && t - prev < COOLDOWN_MS) return false;
		last.set(d.channel_id, t);
		await discord.send(d.channel_id, bugHelp(forumId));
		return true;
	}

	return {
		dispatch(type, d) {
			if (type !== 'MESSAGE_CREATE') return null;
			return message(d).catch((err) => {
				log.error('!bug:', err.message);
				return false;
			});
		},
	};
}

module.exports = { createChat, bugHelp, COOLDOWN_MS };
