'use strict';
// A session's position trails (/psrec trail, addon/Polestar_Recorder/Trail.lua),
// for `record trail`. In a schema 2 session (docs/RECORDING.md) a trail is the
// `pos` events with the trail flag (`trail: true`, flag 64) between a `mark`
// "trail on: <label>" and its "trail off: <label> (<n> points, <yd> yd,
// <reason>)". A trail with no "trail off" (the client crashed) ends at the
// next "trail on" or its last sample; samples before any "trail on" form a
// trail with no label.

const FLAGS = ['mounted', 'swimming', 'falling', 'indoors', 'flying'];
const FIELDS = ['map', 'x', 'y', 'speed'];

function point(ev) {
	const p = { t: ev.t };
	for (const k of FIELDS) p[k] = typeof ev[k] === 'number' ? ev[k] : null;
	for (const k of FLAGS) p[k] = ev[k] === true;
	return p;
}

const ON = /^trail on: (.*)$/;
const OFF = /^trail off: .*\(.*, ([^,()]+)\)$/;

// session (data/recordings/<session>.json) -> [{ label, start, end, reason, points }]
function trailsOf(session) {
	const out = [];
	let cur = null;
	const open = (label, t) => {
		cur = { label, start: t, end: t, reason: null, points: [] };
		out.push(cur);
	};
	for (const ev of session.events || []) {
		const text = ev.e === 'mark' && typeof ev.text === 'string' ? ev.text : null;
		if (text && ON.test(text)) open(text.match(ON)[1], ev.t);
		else if (ev.e === 'pos' && ev.trail === true) {
			if (!cur) open(null, ev.t);
			cur.points.push(point(ev));
			cur.end = ev.t;
		} else if (text && cur && text.startsWith('trail off: ')) {
			cur.end = ev.t;
			const m = text.match(OFF);
			cur.reason = m ? m[1].trim() : null;
			cur = null;
		}
	}
	return out;
}

module.exports = { trailsOf };
