'use strict';
// The prerequisites that actually block a quest, from a quests.json record.
//
// QuestieDB splits prerequisites into preAll (every one turned in) and preAny
// (one of them suffices); pfQuest's `pre` is any-of and, after the QuestieDB
// merge, also lists breadcrumbs (6061 Taming the Beast: pre 6065-6067, its
// three class breadcrumbs). None of these ever block:
// - a breadcrumb: an id in the quest's `breadcrumbs`, or whose `breadcrumbFor`
//   is this quest. It only points the player at the quest, so an any-of group
//   holding one is optional as a whole (788 Cutting Teeth: pre 787 or its
//   breadcrumb 4641); in an all-of group only the breadcrumb itself drops;
// - the quest itself and any quest exclusive with it (either side's `excl`):
//   QuestieDB lists 1516 Call of Earth's race variants 1516/1519/92466 as its
//   own preAny, and 1688 Surena Caledon's `pre` holds 1715, which excludes 1688;
// - the quest's `parent`, as a quest to turn in: a child quest is taken while
//   the parent is in the log, not after turning it in (813 Finding the
//   Antidote, parent 812; 535 Valik, offered only with 533 Infiltration in
//   the log). The parent comes back as `parent` instead;
// - a quest nobody can start (in data with no giver, object or item): 786
//   Thwarting Kolkar Aggression's pfQuest `pre` 785 has no giver anywhere.
//
// -> { all: [ids], any: [ids], parent?: id }: every id in `all` must be turned
// in, one of `any` when it is non-empty, and `parent`, when there is one, must
// be in the quest log (taken, not handed in yet): the quest's parent, unless
// nobody can start it or it is the quest itself or exclusive with it.

function ids(v) {
	return Array.isArray(v) ? v.map(Number).filter((n) => Number.isInteger(n) && n > 0) : [];
}

function startable(q) {
	const s = q.start || {};
	return ids(s.npc).length > 0 || ids(s.object).length > 0 || ids(s.item).length > 0;
}

// quest: the quests.json record; questOf(id) -> another record or null.
function blockingPrereqs(quest, questOf = () => null) {
	if (!quest) return { all: [], any: [] };
	const id = Number(quest.id);
	const crumbs = new Set(ids(quest.breadcrumbs));
	const isCrumb = (p) => {
		if (crumbs.has(p)) return true;
		const pq = questOf(p);
		return !!pq && Number(pq.breadcrumbFor) === id;
	};
	const never = new Set([id, ...ids(quest.excl)]);
	if (Number(quest.parent) > 0) never.add(Number(quest.parent));
	const blocks = (p) => {
		if (never.has(p) || isCrumb(p)) return false;
		const pq = questOf(p);
		if (!pq) return true;
		return !ids(pq.excl).includes(id) && startable(pq);
	};
	const hasSplit = Array.isArray(quest.preAll) || Array.isArray(quest.preAny);
	const all = hasSplit ? ids(quest.preAll).filter(blocks) : [];
	const anyGroup = hasSplit ? ids(quest.preAny) : ids(quest.pre);
	const any = anyGroup.some(isCrumb) ? [] : anyGroup.filter(blocks);
	const out = { all, any };
	const parent = Number(quest.parent);
	if (Number.isInteger(parent) && parent > 0 && parent !== id && !ids(quest.excl).includes(parent)) {
		const pq = questOf(parent);
		if (!pq || (!ids(pq.excl).includes(id) && startable(pq))) out.parent = parent;
	}
	return out;
}

// The quests that close quest `id` for good once taken or done: the quest a
// breadcrumb leads to and its exclusive group (`excl`: another race's or
// class's version of the same chain). A breadcrumb leads to its own
// `breadcrumbFor`, and to every quest listing it in `breadcrumbs`
// (corrections.json gives 92458 Heart of Disruption its breadcrumb 92432 An
// Alarming Request, which names no `breadcrumbFor`). quests: id -> record
// (quests.json). -> [ids], without the quest itself.
const leadsToIndex = new WeakMap();
function leadsTo(quests, id) {
	let index = leadsToIndex.get(quests);
	if (!index) {
		index = new Map();
		for (const [tid, t] of Object.entries(quests)) {
			for (const c of ids(t && t.breadcrumbs)) {
				if (!index.has(c)) index.set(c, []);
				index.get(c).push(Number(tid));
			}
		}
		leadsToIndex.set(quests, index);
	}
	return index.get(id) || [];
}

function closedByOf(id, quests = {}) {
	id = Number(id);
	const quest = quests[id] || {};
	const out = [];
	for (const c of [Number(quest.breadcrumbFor), ...leadsTo(quests, id), ...ids(quest.excl)]) {
		if (Number.isInteger(c) && c > 0 && c !== id && !out.includes(c)) out.push(c);
	}
	return out;
}

module.exports = { blockingPrereqs, closedByOf };
