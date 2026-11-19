'use strict';
// playtest --level-offset and flow-diff --level-offset: the simulated player as a
// character N levels ahead of (N < 0: behind) the level the plain play gives it.
// It starts each guide at the guide's minimum level + N (never below 1, never
// over 60), and every level the simulation raises it to (a level goal, an accept
// waiting for a level) becomes that level + N, or stays where it is when higher.
// A character behind is raised to the level itself: a level goal or a waiting
// accept holds the step until the character has it.
//
// It is Lua for a play's `before` (tools/lib/playtest.js playOptions), run once
// the play has set the guide's level: it wraps the stub world's setLevel, so it
// works with any tree's SIMULATE (flow-diff plays older trees with their own).

// The Lua for offset n (a whole number), a prefix for `before`; '' for 0.
function levelOffsetLua(n) {
	if (!n) return '';
	return `do -- --level-offset ${n}
	local w, off = stub.world, ${n}
	w.level = math.min(60, math.max(1, w.level + off))
	local setLevel = w.setLevel
	w.setLevel = function(level) setLevel(math.min(60, math.max(w.level, level + math.max(off, 0)))) end
end
`;
}

// --level-offset's value: a whole number, or { error }.
function parseLevelOffset(v) {
	if (v == null) return 0;
	const n = Number(v);
	return /^[+-]?\d+$/.test(String(v).trim()) && Number.isSafeInteger(n) ? n : { error: `--level-offset takes a whole number of levels (got "${v}")` };
}

module.exports = { levelOffsetLua, parseLevelOffset };
