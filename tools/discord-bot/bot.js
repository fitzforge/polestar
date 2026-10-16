#!/usr/bin/env node
'use strict';
// The Polestar bug bot: watches the Discord #bugs forum and files each new
// post as a GitHub issue (tools/discord-bot/README.md). Runs until stopped;
// settings come from the environment (.env.example).
//
//   node tools/discord-bot/bot.js            run
//   node tools/discord-bot/bot.js refresh    rewrite every filed issue from its post, then exit

const { botConfig } = require('./lib/config');
const { createCommands } = require('./lib/commands');
const { createDiscord } = require('./lib/discord');
const { createGateway } = require('./lib/gateway');
const { createGitHub, createMedia } = require('./lib/github');
const { createSync } = require('./lib/sync');

const stamp = () => new Date().toISOString();
const log = {
	info: (...a) => console.log(stamp(), ...a),
	warn: (...a) => console.warn(stamp(), 'warn:', ...a),
	error: (...a) => console.error(stamp(), 'error:', ...a),
};

async function main() {
	const config = botConfig();
	const discord = createDiscord({ token: config.discordToken });
	const github = createGitHub({ token: config.githubToken, repo: config.repo });
	const mediaGitHub = config.mediaRepo === config.repo && config.mediaToken === config.githubToken
		? github
		: createGitHub({ token: config.mediaToken, repo: config.mediaRepo });
	const media = createMedia({ github: mediaGitHub, branch: config.mediaBranch });
	const sync = createSync({ discord, github, media, config, log });
	const commands = createCommands({ discord, github, issueFor: sync.issueFor, log });

	const forum = await discord.getChannel(config.forumId);
	if (forum.type !== 15) throw new Error(`DISCORD_FORUM_ID ${config.forumId} is not a forum channel (#${forum.name})`);
	log.info(`watching #${forum.name}, filing to ${config.repo}, screenshots to ${config.mediaRepo}@${config.mediaBranch}`);
	await sync.loadIndex();
	if (process.argv[2] === 'refresh') {
		await sync.refresh();
		return;
	}

	const gateway = createGateway({
		token: config.discordToken,
		url: await discord.gatewayUrl(),
		// The admin commands (/close, /reopen) beside the filing.
		onDispatch(type, d) {
			if (type === 'READY' && d.application) commands.register(d.application.id, forum.guild_id);
			if (type === 'INTERACTION_CREATE') commands.handle(d).catch((err) => log.error('interaction:', err.message));
			return sync.dispatch(type, d);
		},
		onFatal(err) {
			log.error(err.message);
			process.exit(1);
		},
		log,
	});
	gateway.start();

	for (const signal of ['SIGINT', 'SIGTERM']) {
		process.on(signal, () => {
			log.info(`${signal}: stopping`);
			gateway.stop();
			setTimeout(() => process.exit(0), 500);
		});
	}
}

main().catch((err) => {
	log.error(err.message);
	process.exit(1);
});
