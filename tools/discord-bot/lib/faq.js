'use strict';
// The FAQ answers: one Markdown file per answer in tools/discord-bot/faq/.
// The first line lists the commands that give it, the rest is the text as
// Discord shows it:
//
//   Commands: !dungeons, !dung
//
//   **Are dungeons in the guide?** ...
//
// An answer may carry a picture: a second header line `Image: media/pray.png`
// (a png, jpg, gif or webp under faq/) attaches it to the reply; the text
// after it may then be empty or one short line.
//
// A file that is not shaped like that stops the bot at start with a line
// naming the file and the problem.

const fs = require('node:fs');
const path = require('node:path');

const MAX_TEXT = 2000;
const IMAGE_TYPES = { '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.gif': 'image/gif', '.webp': 'image/webp' };
const MAX_IMAGE = 8 * 1024 * 1024; // Discord's attachment limit for a bot without boosts
const COMMAND = /^![a-z0-9]{1,32}$/;
// Commands the bot already answers itself.
const TAKEN = new Set(['!bug', '!bugs', '!report', '!suggest']);

function parseFaq(name, source) {
	const fail = (why) => { throw new Error(`faq/${name}: ${why}`); };
	const m = String(source).replace(/\r\n/g, '\n').match(/^Commands:[ \t]*(.*)(?:\n+Image:[ \t]*(.*))?(?:\n+([\s\S]*))?$/);
	if (!m) fail('the first line must be "Commands: !one, !two", then the text');
	const commands = m[1].split(',').map((c) => c.trim().toLowerCase()).filter(Boolean);
	if (!commands.length) fail('no commands on the first line');
	for (const c of commands) {
		if (!COMMAND.test(c)) fail(`"${c}" is not a command (an ! and letters or digits, like !dungeons)`);
		if (TAKEN.has(c)) fail(`${c} is already used by the bot`);
	}
	const image = (m[2] || '').trim();
	if (m[2] !== undefined && !image) fail('"Image:" needs a file, like "Image: media/pray.png"');
	const text = (m[3] || '').trim();
	if (!text && !image) fail('no text after the Commands line');
	if (text.length > MAX_TEXT) fail(`the text is ${text.length} characters; Discord allows ${MAX_TEXT}`);
	return image ? { commands, text, image } : { commands, text };
}

// The picture a file names, as { name, type, data } for the attachment.
function loadImage(dir, file, rel) {
	const full = path.resolve(dir, rel);
	if (path.relative(dir, full).startsWith('..') || path.isAbsolute(path.relative(dir, full))) throw new Error(`faq/${file}: the image ${rel} is outside faq/`);
	const type = IMAGE_TYPES[path.extname(full).toLowerCase()];
	if (!type) throw new Error(`faq/${file}: the image ${rel} must be a png, jpg, gif or webp`);
	let data;
	try {
		data = fs.readFileSync(full);
	} catch {
		throw new Error(`faq/${file}: the image ${rel} was not found`);
	}
	if (data.length > MAX_IMAGE) throw new Error(`faq/${file}: the image ${rel} is ${data.length} bytes; the limit is ${MAX_IMAGE}`);
	return { name: path.basename(full), type, data };
}

// Every answer in `dir`, as [{ file, commands, text }]; throws on the first bad file
// a missing image, or a command two files both claim.
function loadFaq(dir) {
	const seen = new Map();
	return fs.readdirSync(dir).filter((f) => f.endsWith('.md')).sort().map((file) => {
		const entry = { file, ...parseFaq(file, fs.readFileSync(path.join(dir, file), 'utf8')) };
		if (entry.image) entry.image = loadImage(dir, file, entry.image);
		for (const c of entry.commands) {
			if (seen.has(c)) throw new Error(`faq/${file}: ${c} is also in faq/${seen.get(c)}`);
			seen.set(c, file);
		}
		return entry;
	});
}

module.exports = { loadFaq, parseFaq, FAQ_DIR: path.join(__dirname, '..', 'faq'), MAX_TEXT };
