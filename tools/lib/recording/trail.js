'use strict';
// A session's position trails (/psrec trail, addon/Polestar_Recorder/Trail.lua):
// the `trail` samples between each `trail_start` and its `trail_stop`, for
// `record trail`. A trail with no stop (the stop was capped, or the client
// crashed) ends at the next start or the session's end; samples before any
// start (the start was capped) form a trail with no label.

const FLAGS = ['mounted', 'swimming', 'falling', 'indoors', 'onTaxi'];
const FIELDS = ['map', 'x', 'y', 'wx', 'wy', 'wz', 'facing', 'speed'];

function point(ev) {
	const p = { t: ev.t };
	for (const k of FIELDS) p[k] = typeof ev[k] === 'number' ? ev[k] : null;
	for (const k of FLAGS) p[k] = ev[k] === true;
	return p;
}

// session (data/recordings/<session>.json) -> [{ label, start, end, reason, points }]
function trailsOf(session) {
	const out = [];
	let cur = null;
	const open = (label, t) => {
		cur = { label, start: t, end: t, reason: null, points: [] };
		out.push(cur);
	};
	for (const ev of session.events || []) {
		if (ev.e === 'trail_start') open(typeof ev.label === 'string' ? ev.label : null, ev.t);
		else if (ev.e === 'trail') {
			if (!cur) open(null, ev.t);
			cur.points.push(point(ev));
			cur.end = ev.t;
		} else if (ev.e === 'trail_stop' && cur) {
			cur.end = ev.t;
			cur.reason = typeof ev.reason === 'string' ? ev.reason : null;
			cur = null;
		}
	}
	return out;
}

module.exports = { trailsOf };
