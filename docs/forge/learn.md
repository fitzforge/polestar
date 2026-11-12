# What players' recordings teach: `forge record learn`

Players' Recorder sessions ([RECORDING.md](../RECORDING.md)) know things about the quests Forever
added that no other source has yet: where an objective is actually done, which quest a giver wants
handed in first, from which level it offers a quest. `forge record learn` reads the maintainer's
recordings archive and writes what it learned, fact by fact with how many players back it, into a
committed snapshot that the Codex and the data build read. The archive itself (private, hundreds of
MB) never leaves the maintainer's PC: every machine builds the same data from the snapshot, and a
snapshot PR's diff is its review.

```sh
forge record learn                    # the archive at ~/work/maintainer/recordings
forge record learn --data <out>/data/forever --verdicts <verdict.json> --archive <dir>
```

Today it learns for the quests Forever added only (`--scope forever-new`, the default and only
scope): their objective spots, prerequisites and minimum levels. Givers, NPCs, drops and paths
follow.

## Inputs

| Input | Default | What it gives |
|---|---|---|
| `--archive` | `~/work/maintainer/recordings` | the re-sessioned sessions (`forge record pull` / `resession`) and the archive's `config.json` (`exclude`, `minBuild`, the establishment thresholds, `minVoters`) |
| `--verdicts` | `~/work/maintainer/ingest-audit/verdict.json` when present | IngestAudit's verdict: contributors marked `exclude` or `suspect`, who is the same person, re-rolled character ids |
| `--data` | `data/forever` | the current data the facts are compared with (quests, NPC/object spawns, item drops, zones, map frames) |
| corrections | `forever-db/corrections` | the fields facts never override |
| `--sources` | `data/sources` | the client quest tables that say which quests are new in Forever (`forge data newquests`'s rule; `--offline`: cached only) |

The archive is read one session at a time (about 2,000 sessions, a few minutes, well under 1 GB),
so run it as a light job.

## Who counts

- A session counts when its player is established (the data build's rule, `recordings.rs`
  `establish`): first seen at least 3 days before its newest upload, 20 chunks on 3 server-counted
  upload days, real play. `local` and `sent-*` count outright, `anon-*` never.
- Contributors the archive's `config.json` `exclude` lists, or the verdicts mark `exclude` or
  `suspect`, never count and play no part in anything.
- A voter is the server's cohort (one network a month), merged with every contributor the verdicts
  say is the same person (a shared install, character or cohort). It gives one vote per fact.
- A character id re-used for another race or class (the verdicts' `rerolled`) is kept apart per
  race and class, and neither's race or class is trusted.

## What it learns

**Objective spots.** Each `progress` record (an objective line ticking) is a point, except on a
boat, lift or flight. Per voter, its points within 60 yd of each other are one cluster, standing at
their median. A voter's cluster more than 200 yd from every other voter's is noise (once three
voters ticked the line). The voters' clusters within 60 yd of each other form a spot; a voter more
than max(40 yd, 3 × MAD) from the voters' median there is set aside, and the spot is the median of
the rest, its radius the 80th percentile distance of their points. A spot only one voter backs is
dropped when another has three or more. Lines are the game's own (the `objectives` record at the
accept); they map onto our data's objectives in order when the game's list has as many lines, each
of a fitting type.

**Prerequisites, exclusive groups and minimum levels**, from givers' windows (`offer` records), by
the rules of the offer audit that fixed #1132 (`learn/offers.rs`):
- A refusal counts only from a giver's quest list: a quest the NPC starts that the list leaves out,
  not in the log, not done. A window within 1.5 s of a quest-detail window of the same NPC shows one
  quest and is never a refusal; a quest handed in less than 2 s before a window is unknown for it (the
  client's lists lag); a refusal within 30 s of an offer of the same quest at the same level, nothing
  handed in between, is void, and so is one of a quest already closed (a quest of its exclusive group
  or a follow-up done).
- Most recorders follow our guides, so what they did in order (co-occurrence) says nothing. A
  prerequisite is learned only when refusal-backed: never offered without it; refused without it by
  a character later offered the quest once it was handed in; and a clean unlock (nothing else that
  explains it handed in, same level), an unlock within 5 s of that hand-in, or present in every
  same-level unlock of two characters. Offered without it contradicts it: with that unlock evidence
  too, the prerequisite is a conflict.
- Minimum level: the lowest offered level bounds it from above, the highest level refused with every
  required quest done (below that) from below. It is learned when the two meet; when the bounds only
  show our data's level is wrong, the report lists it with the bounds. A quest that also needs a
  profession skill learns no level (a refusal there may be the skill).
- Exclusive groups: our data's are confirmed (refused once a member was done, otherwise qualified)
  or contradicted (offered, or done, with a member done).

## Trust: trusted, gap, conflict, stale

Every fact is learned per voter, then combined over voters (never pooled counts):

| Status | When | Used by |
|---|---|---|
| `trusted` | enough counted voters agree (an objective spot, or a change to a value our data has: 3; a refusal-backed prerequisite, exclusive group or level our data lacks or agrees with: 2; a vouched voter always), and at least ⅔ of the counted voters with evidence either way agree | the Codex, the data build (prerequisites and levels), and so the public database |
| `gap` | fewer counted voters: a provisional fact | the Codex (marked `provisional`), guides; never the public database |
| `conflict` | the ⅔ rule fails, or a prerequisite was both unlocked and offered without | nobody; listed |
| `stale` | seen only on an older client build while 3 counted voters recorded the quest on the newest build without confirming it | like a gap |

A fact no counted voter backs is left out.

## Outputs

`data/recorded/quests.json` (commit it), one quest per line:

```json
"91234": { "zone": 2521, "list": ["monster", "item"],
  "objectives": [{ "line": 1, "type": "monster", "count": 8,
    "at": { "value": [{ "map": 2521, "x": 41.2, "y": 63.05, "r": 34, "voters": 5, "counted": 4 }],
            "voters": 5, "counted": 4, "status": "trusted", "builds": [70790, 70862], "beats": null } }],
  "pre": [{ "value": 91230, "voters": 3, "counted": 2, "status": "trusted", "builds": [70862, 70862], "beats": "questie-forever" }],
  "minLevel": { "value": 12, "bounds": [12, 12], "voters": 2, "counted": 2, "status": "trusted", ... } }
```

Fields: `objectives[].at` (spots, best-backed first, `r` in yards), `pre` (refusal-backed
prerequisites), `notPre` (our data's prerequisites players were offered the quest without),
`preAny` / `notPreAny` (our data's any-of group, confirmed or contradicted), `excl` / `notExcl`,
`minLevel` (`value` null when the bounds don't pin it). Each fact: `value`, `voters` (all players
who recorded it), `counted` (counted voters behind it), `status`, `builds` (first and last client
build it was seen on), `beats` (the source it agreed with or replaced). `list` is the game's own
objective list. No contributor, cohort or character id is in it: counts only.

`data/recorded/meta.json`: the archive's revision (a hash of its session files), sessions used and
left out, voters and counted voters, people merged, the verdicts' date, the data build, every
threshold, and counts per fact kind and status.

`data/local/recorded/report.md` (local): what changed since the last snapshot, every fact against our
data by class, the facts that disagree with a correction first, then per zone the counts and
readiness (the share of the zone's Forever-new quests with every objective line located on trusted
evidence and no prerequisite or level conflict), and every fact that is not a confirmation.
`conflicts.json` (local): the same facts as data.

| Class | Meaning | What happens |
|---|---|---|
| new | our data has nothing | applied (trusted), or provisional (gap) |
| confirms | the same value | nothing changes |
| replaces | trusted, disagrees with a non-correction source | applied |
| vs-correction | disagrees with a correction | the correction stands; listed first |
| conflict | voters disagree | nothing applied |
| stale | seen only on an older build | demoted |
| pending | disagrees with our data below the override quorum | nothing applied; listed |

## Who reads it

- `forge data codex`: a quest's prerequisites (Lookup's chains: "Needs", "Leads to") take the
  trusted and provisional `pre`, `notPre` and `notPreAny`; an objective takes its line's best spot
  (`map`, `x`, `y`; `provisional: true` for a gap fact, which never replaces a point our data has).
- `forge data build`: trusted `pre`, `notPre`, `notPreAny` and pinned trusted `minLevel` only, tagged
  `recorder:pre` / `recorder:minLevel`, then the corrections again.
- Both skip any field a correction sets: corrections are the last word.

The data build still reads `data/recordings/` for everything else (titles, givers, objectives
lists, spawns, drops); `data/codex/recorded.json` still holds the Codex's recorded drops, vendors
and rewards (`forge data codex --recordings`, which counts people by the rules under "Who counts"
above, verdicts and one vote per person included). They fold into this snapshot as the learned
layer grows. The prerequisite-order check in `tests/guides-reported.test.js` takes this snapshot's
trusted, provisional and stale `pre` facts too (`tools/lib/route/prereq-order.js`).
