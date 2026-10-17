# Working in this pack

This folder is a pack, the source of a community addon for Polestar:
`pack.json` describes it and
`guides/*.guide` hold its guides, written in Polestar's guide format
(docs/GUIDE_CHEATSHEET.md on one page, docs/GUIDE_FORMAT.md in full, in
Polestar's source). Every guide id starts with `{{id}}/`. The `polestar`
command comes from a Polestar clone (`npm link` in it); run it from this
folder.

Before writing or fixing a guide, read the polestar-guide-pack skill in
`.agents/skills/polestar-guide-pack/SKILL.md` (the same files are in
`.claude/skills/`): the workflow from `polestar new` to `polestar pack`, and
the guide format on one page in its `references/guide-format.md`.

## Never guess an id, a name or a coordinate

Quest, NPC, object and item ids, guide ids, inn and flight point names and
coordinates come from Polestar's reference data. Look up every one before
you write it:

    polestar find "Westfall Stew" --json
    polestar find 36 --json
    polestar find westfall --kind guide --json
    polestar find --kind flight --faction Alliance --json

Use the ids, names, zones and coordinates the results give (each result's
`line` is a guide line ready to paste). When nothing matches, say so instead
of inventing a value.

## Check until both pass

After every change, repeat until both pass:

    polestar lint --format json
    polestar playtest

`lint` prints one JSON document: `ok`, the counts, and each problem with its
file, line, severity, message and, when there is one, a hint. Fix every
error and every warning, or tell the author why a warning stays: `ok` only
means no errors, and a wrong objective number (`quest 788.2` for a quest
with one objective) is a warning that playtest does not catch. `playtest`
plays each guide to the end in the real addon and names the step where a
guide gets stuck. Then `polestar install` copies the pack into the game to
try it, and `polestar pack` writes the release zip to `dist/`.

## Only the author's own material

Write guides from the author's own material: their notes, routes they played
(`polestar record`), guides they wrote. Never copy text, step lists or
routes from other guides, websites or addons, and never copy Polestar's own
guide text: a `next` line may hand over to one of Polestar's guides instead.
