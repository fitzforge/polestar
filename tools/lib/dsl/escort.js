'use strict';
// Escort quests (docs/GUIDE_FORMAT.md, "Escort quests"): the compiled
// `escort` of a goal, which the guide window shows as "Escort: if the NPC is
// not there, wait for it to respawn" under the quest's accept and objectives.
// Someone else on the escort takes the NPC away until it respawns.
//
// isEscort(quest) — whether a quests.json record is an escort quest.
// escortOf(goal, data) — the goal's compiled `escort` (true | undefined).

const ESCORT = /escort/i;

function says(text) {
	return typeof text === 'string' && ESCORT.test(text);
}

// The quest's own words say so: an event objective ("Escort Miran to the
// excavation site") or the quest log's objective text ("Escort the captive
// fire elemental out of Dun Modr", Forever's own quests with no objectives).
// A quests.json `escort` (corrections.json) wins: an escort worded as
// "Protect Volcor until you reach the road", or a quest whose objective was
// copied from the escort after it (Lost! 4492).
function isEscort(q) {
	if (!q) return false;
	if (typeof q.escort === 'boolean') return q.escort;
	return (q.objectives || []).some((o) => o.type === 'event' && says(o.text)) || says(q.objectiveText);
}

// The accept, the complete and the objective goals of an escort quest; not
// its turn-in, where the walk is over.
function escortOf(goal, data) {
	if (goal.quest === undefined || goal.t === 'turnin') return undefined;
	return isEscort(data.quest(goal.quest)) || undefined;
}

module.exports = { isEscort, escortOf };
