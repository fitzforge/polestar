'use strict';
// The `section <Profession> <from>-<to>` lines of a generated profession guide
// (docs/GUIDE_FORMAT.md, "Sections"): the skill ranges the guide window shows
// as headings, and from which the engine starts the guide where the player's
// skill is. Applied to a rendered guide's text, so every generator (and a hand
// edit of a committed guide, maintainer tooling) writes the same lines.
//
// byBanners(text, skill): a section under each rank or band banner that names
// a range ("# ---- Journeyman (75-150)", "# ---- Mining 1-65"). A banner
// without one (Apprentice, Expert Fishing, Artisan Cooking: Clamlette
// Surprise) leads into the next range: its steps (learning the profession, a
// rank's book or quest) are under the section that needs them, so a player
// whose skill passed the range before still gets them. For guides whose
// materials are bought or gathered per bracket (the crafting guides) or whose
// steps run per zone (gathering, fishing, cooking).
//
// byBands(text, skill): a section per crafting band, from the steps' `craft
// … until` targets: a step with a target ends a band (steps with the same
// target, one per race or zone, share it), the steps before it without one
// (its materials, a rank, a recipe, a rank's quest gated by `skill`) lead
// into it, and steps after the last target join the last band. For a guide
// whose every band gathers its own materials (First Aid: "First Aid 1-40",
// cloth then bandages).

const BANNER_RE = /^# -{10,} (.*)$/;
const RANGE_RE = /(\d+)-(\d+)\)?$/;
const SECTION_RE = /^section /;

function lines(text) {
	return text.split('\n').filter((l) => !SECTION_RE.test(l));
}

function byBanners(text, skill) {
	const out = [];
	let pending = null; // where a rangeless banner's section goes
	for (const l of lines(text)) {
		out.push(l);
		const b = BANNER_RE.exec(l);
		if (!b) continue;
		const m = RANGE_RE.exec(b[1]);
		if (!m) {
			if (pending === null) pending = out.length;
			continue;
		}
		const sec = `section ${skill} ${m[1]}-${m[2]}`;
		if (pending === null) out.push(sec);
		else out.splice(pending, 0, sec);
		pending = null;
	}
	return out.join('\n');
}

// The skill a step's crafts reach (`craft … until N`), or null.
function targetOf(stepLines) {
	let t = null;
	for (const l of stepLines) {
		const m = /^  craft \d+(?: "[^"]*")? until (\d+)\b/.exec(l);
		if (m) t = Math.max(t || 0, Number(m[1]));
	}
	return t;
}

function byBands(text, skill) {
	const all = lines(text);
	// Steps: index of the `step` line and the step's lines.
	const steps = [];
	all.forEach((l, i) => {
		if (/^step /.test(l)) steps.push({ at: i, lines: [] });
		else if (steps.length && /^\s/.test(l)) steps[steps.length - 1].lines.push(l);
	});
	const starts = new Map(); // line index -> section line
	let from = 1;
	let lead = null; // first step of the band being gathered
	let last = null; // target of the band before
	for (let i = 0; i < steps.length; i++) {
		const t = targetOf(steps[i].lines);
		if (lead === null) lead = i;
		if (t === null || t <= from) continue;
		// Steps with the same target after this one (other races or zones) are in the band too.
		let j = i;
		while (j + 1 < steps.length && targetOf(steps[j + 1].lines) === t) j++;
		starts.set(steps[lead].at, `section ${skill} ${from}-${t}`);
		from = t;
		last = t;
		lead = null;
		i = j;
	}
	if (last === null) return all.join('\n');
	const out = [];
	all.forEach((l, i) => {
		if (starts.has(i)) out.push(starts.get(i), '');
		out.push(l);
	});
	return out.join('\n');
}

module.exports = { byBanners, byBands };
