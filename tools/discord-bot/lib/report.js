'use strict';
// A #bugs forum post read back into the parts of the report the addon wrote
// (addon/Polestar/UI/Report.lua, R.Text): the player's words, then the
// details in a code block, one line each, parts joined by " · ".
//
// The labels in the report are translated (L["Guide: %s (%s)"], ...), so
// nothing here matches their words: the details block is found by its first
// line's shape (a version, then the game locale as the last part) and every
// field by its position and its numbers. A post without a report still
// parses: all of it is the description and `details` is null.

const zlib = require('node:zlib');

const SEP = ' \u00b7 ';

const LOCALE = /^([a-z]{2}[A-Z]{2}|\?)$/;
const VERSION = /(\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?|dev)(?:\s+(\S.*))?$/;
// zhCN and zhTW write full-width colons and brackets (：（）) in their labels,
// so every colon and bracket here takes either width.
const GUIDE_ID = /[(（]([a-z0-9_-]+(?:\/[a-z0-9_.-]+)+)[)）]/i;
const POSITION = /map (\d+) @(-?[\d.]+),(-?[\d.]+)/;
const ERROR_LINE = /^\s+(\d+)x (.*)$/;
const FENCE = /(^|\n)(`{3,})[^\n`]*\n([\s\S]*?)\n?\2(?=\n|$)/g;

// The Settings section (Report.lua, settingsSection), at the end of the
// details: its first line, found by its English words after the translated
// label ("Settings: profile Raid (character) · 23 changed", or "Settings:
// all defaults"); the list (key=value for a switch, else key=default->value,
// joined by spaces); the looks line; "+N more #<Adler-32 of them all, one a
// line>"; and the packed line, the settings the list leaves out one a line in
// the import strings' envelope, !PSR1!<Adler-32>!<base64 of zlib>: with the
// list, every setting.
const SETTINGS_HEAD = /[:：]\s*(?:profile (.+) \((character|class|account)\) · )?(?:all defaults|(\d+) changed)$/;
const SETTING = /^([A-Za-z][\w-]*(?:\.[\w-]+)+)=(\S+)$/;
const SETTINGS_MORE = /^\+(\d+) more #([0-9a-f]{8})$/;
const SETTINGS_PACKED = /^!PSR1!([0-9a-f]{8})!([A-Za-z0-9+/]+={0,2})$/;
const TO = '->';
// What a packed line may unfold to at most: the bytes of every setting a
// profile holds are a few kilobytes.
const PACKED_MAX = 64 * 1024;

// Where a label's colon is in `s`, from `from` on: -1 when there is none.
function colonAt(s, from = 0) {
	const at = s.slice(from).search(/[:：]/);
	return at === -1 ? -1 : from + at;
}

// Is this the report's first line: "Polestar 0.2.3 Beta · client 1.60.1 (70425) · enUS"?
function isVersionsLine(line) {
	const parts = line.split(SEP);
	return parts.length >= 3 && LOCALE.test(parts[parts.length - 1].trim()) && VERSION.test(parts[0].trim());
}

// The description without the report's bold lead-in ("**What went wrong:** ").
function cleanDescription(text) {
	return text.replace(/^\s*\*\*[^*\n]{1,60}[:：]\*\*\s*/, '').trim();
}

function parseVersions(line, out) {
	const parts = line.split(SEP).map((p) => p.trim());
	const v = parts[0].match(VERSION);
	out.version = v[1];
	if (v[2]) out.stage = v[2].trim();
	const client = parts[1].match(/(\d+(?:\.\d+)+)\s*[(（](\d+)[)）]/);
	if (client) {
		out.client = client[1];
		out.build = client[2];
	}
	out.locale = parts[parts.length - 1];
}

// The details lines, in the order R.Details writes them: versions,
// character, guide (or none), step (or none), goals, arrow, where, packs,
// errors, the quest log, the Settings section. Lines Report.lua leaves out
// shift the rest, so each is found by its shape relative to the guide line,
// and the Settings section by its first line's words.
function parseDetails(lines) {
	const out = { lines };
	parseVersions(lines[0], out);
	let i = 1;
	const guideAt = lines.findIndex((l) => GUIDE_ID.test(l));
	if (guideAt > 1) {
		out.character = lines[1];
		i = guideAt;
	} else if (guideAt === -1 && lines[1] && lines[1].split(SEP).length === 3 && !POSITION.test(lines[1])) {
		out.character = lines[1];
		i = 2;
	}
	if (guideAt !== -1) {
		const g = lines[guideAt];
		out.guideId = g.match(GUIDE_ID)[1];
		const parts = g.split(SEP);
		const head = parts[0];
		const title = head.slice(colonAt(head) + 1, Math.max(head.lastIndexOf('('), head.lastIndexOf('（'))).trim();
		if (title) out.guideTitle = title;
		if (parts.length > 1) out.pack = parts.slice(1).join(SEP).replace(/^\S+\s+/, '');
		i = guideAt + 1;
		const step = lines[i] || '';
		const nums = step.split(SEP)[0].match(/\d+/g);
		if (nums && nums.length >= 2) {
			const parts2 = step.split(SEP);
			out.step = Number(nums[0]);
			out.stepCount = Number(nums[1]);
			const colon = colonAt(parts2[0], parts2[0].indexOf(nums[1]));
			if (colon !== -1) out.stepTitle = parts2[0].slice(colon + 1).trim();
			for (const p of parts2.slice(1)) {
				const live = p.match(/\d+/);
				if (live) out.liveStep = Number(live[0]);
			}
		}
		i += 1;
	} else {
		// "Guide: none open"
		i += 1;
	}
	while (i < lines.length && (/^\[[^\]]*\]/.test(lines[i]) || /^\.\.\. /.test(lines[i]))) i += 1;
	out.arrow = lines[i];
	out.where = lines[i + 1];
	if (out.where) {
		const pos = out.where.match(POSITION);
		if (pos) out.map = Number(pos[1]);
		const head = out.where.split(SEP)[0];
		const zone = head.slice(colonAt(head) + 1).trim();
		if (zone) out.zone = zone;
	}
	// "Routes: balanced · real paths off": its label is in the client's
	// language, its words are not (Report.lua routesLine), so the style word
	// after the colon finds it. Older reports have no such line.
	const routes = (lines[i + 2] || '').match(/[:：]\s*((?:fastest|balanced|roads)\b.*)$/);
	if (routes) out.routes = routes[1].trim();
	out.errors = [];
	for (const l of lines) {
		const e = l.match(ERROR_LINE);
		if (e) out.errors.push({ count: Number(e[1]), message: e[2] });
	}
	parseSettings(lines, out);
	return out;
}

// Adler-32 of a buffer as 8 hex digits, as the addon writes it (Core/Import.lua).
function adler32(buf) {
	let a = 1;
	let b = 0;
	for (const x of buf) {
		a = (a + x) % 65521;
		b = (b + a) % 65521;
	}
	return b.toString(16).padStart(4, '0') + a.toString(16).padStart(4, '0');
}

// One setting as the list writes it -> { key, value, default } or null. A
// switch (on/off) has the other one as its default.
function parseSetting(token) {
	const m = token.match(SETTING);
	if (!m) return null;
	const [, key, rest] = m;
	const at = rest.indexOf(TO);
	if (at !== -1) return { key, value: rest.slice(at + TO.length), default: rest.slice(0, at) };
	if (rest === 'on' || rest === 'off') return { key, value: rest, default: rest === 'on' ? 'off' : 'on' };
	return { key, value: rest, default: null };
}

// The packed line's settings as written, one a line, or null when it does not
// unfold to lines whose Adler-32 is `sum`.
function unpack(sum, body) {
	if (body.length > PACKED_MAX * 2) return null;
	let raw;
	try {
		raw = zlib.inflateSync(Buffer.from(body, 'base64'), { maxOutputLength: PACKED_MAX });
	} catch {
		return null;
	}
	return adler32(raw) === sum ? raw.toString('utf8').split('\n') : null;
}

// out.settings = { count, profile?, source?, entries: [{ key, value, default }],
// looks?, more?, hash?, unfolded?, damaged? }: the list as shown or, when a
// packed line carries the rest and the list with it has the Adler-32 after
// "+N more", every setting (`unfolded`; `damaged` when a packed line is there
// and does not unfold). Reports from before the section have none.
function parseSettings(lines, out) {
	let at = -1;
	let head = null;
	for (let i = lines.length - 1; i > 0 && at === -1; i--) {
		if (/^[\s[>]/.test(lines[i])) continue;
		head = lines[i].match(SETTINGS_HEAD);
		if (head) at = i;
	}
	if (at === -1) return;
	const s = { count: head[3] ? Number(head[3]) : 0, entries: [] };
	if (head[1]) {
		s.profile = head[1];
		s.source = head[2];
	}
	const listed = [];
	let i = at + 1;
	for (; i < lines.length; i++) {
		const tokens = lines[i].split(' ');
		if (!tokens.every((t) => parseSetting(t))) break;
		listed.push(...tokens);
	}
	s.entries = listed.map(parseSetting);
	if (i < lines.length && lines[i].startsWith('looks: ')) s.looks = lines[i++].slice('looks: '.length);
	const more = i < lines.length && lines[i].match(SETTINGS_MORE);
	if (more) {
		s.more = Number(more[1]);
		s.hash = more[2];
		i++;
	}
	const packed = i < lines.length && lines[i].match(SETTINGS_PACKED);
	if (packed) {
		const rest = unpack(packed[1], packed[2]);
		const all = rest && [...listed, ...rest];
		const entries = all && all.map(parseSetting);
		if (entries && entries.every(Boolean) && s.hash && adler32(Buffer.from(all.join('\n'), 'utf8')) === s.hash) {
			s.entries = entries;
			s.unfolded = true;
		} else {
			s.damaged = true;
		}
	}
	out.settings = s;
}

// { description, details, block } from a message's content. `block` is the
// details code block as posted (for quoting it whole), `details` its fields.
function parseReport(content) {
	// The game's copy box can leave NULs and other control characters after the report.
	const text = String(content || '').replace(/\r\n/g, '\n').replace(/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/g, '');
	FENCE.lastIndex = 0;
	let m;
	while ((m = FENCE.exec(text))) {
		const body = m[3].replace(/^\n+/, '');
		const lines = body.split('\n').map((l) => l.replace(/\s+$/, '')).filter((l) => l !== '');
		if (!lines.length || !isVersionsLine(lines[0])) continue;
		const start = m.index + m[1].length;
		const before = text.slice(0, start);
		const after = text.slice(start + m[0].length - m[1].length);
		const description = [cleanDescription(before), after.trim()].filter(Boolean).join('\n\n');
		return { description, details: parseDetails(lines), block: lines.join('\n') };
	}
	return { description: cleanDescription(text), details: null, block: null };
}

module.exports = { parseReport, parseSetting, adler32, SEP };
