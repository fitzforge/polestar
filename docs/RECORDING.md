# Recording (schema 2): what the Recorder collects and how it travels

This is the contract between the four parts of Polestar's recording program,
and the public statement of what it collects. Everything here is open source
in this repository.

| Part | Where | Job |
|---|---|---|
| Recorder addon | `addon/Polestar_Recorder/` | Writes compact records into `PolestarRecorderDB` while the player plays (opt-in). |
| Recording library | `rust/crates/polestar-recording/` | Reads the SavedVariables file, decodes and validates records, finds WoW installs, scrubs text, writes the ack file, summarises. Shared by the three below. |
| Polestar Client | `apps/client/` (Tauri) | Desktop app for Windows, macOS and Linux: finds the game, installs the Recorder, uploads new chunks, shows exactly what was sent. |
| Ingest server | `services/ingest/` | Receives uploads, validates them with the library, stores them, serves stats, deletion and the maintainer export. |
| forge | `forge record import`, `forge record pull` | Turns local files or the server export into `data/recordings/<session>.json` for the data build. `import` marks this PC's own installs' contributor `local`. A file someone sent in needs `import --vouch <name>` (contributor `sent-<name>`, a name the maintainer chooses; it counts as one more player) or `import --anonymize` (contributor `anon-<16 hex>`; it only fills gaps). |

## What is never collected

Character names, realm names, account names, chat, whispers, guild, friends,
other players' names, mail, auction or trade data, the player's typed text
other than `/psrec mark` notes and `/psrec trail` labels, and anything from
outside the game folder.
Quest and gossip text has the player's name replaced with `$N` (and race and
class with `$R`, `$C`) in the addon, and again in Polestar Client.

## SavedVariables (`PolestarRecorderDB`, per account)

```lua
PolestarRecorderDB = {
	schema = 2,
	enabled = true,            -- recording on (/psrec on); nothing is written while false
	install = "k3j9x0q2m7ab",  -- 12 random base-36 characters, made once per WoW account folder
	seq = 41,                  -- last chunk number used
	acked = 37,                -- highest chunk Polestar Client confirmed (from Ack.lua), kept for display
	chunks = { [38] = "...", [39] = "...", [40] = "...", [41] = "..." },
	maps = { [1429] = "1429\t3\t1415\t0\t-7939.6\t1535.4\t-10135.2\t-2141.6", ... }, -- see `map` record
}
```

Per character (`PolestarRecorderCharDB`, SavedVariablesPerCharacter):
`{ id = "<10 random base-36 characters>", textSeen = { [questID] = true } }`.
The character id lets records from one character be followed across sessions
without its name.

### Chunks

- A chunk is one Lua string: records separated by `\n`. A record is fields
  separated by `\t`. The first field is the record kind, the second `dt`.
- The first record of every chunk is `chunk`, which sets the clock:
  `chunk  <dt=0>  <seq>  <serverEpoch>  <charId>`. Every later `dt` is
  tenths of a second since that epoch (integer).
- A chunk closes after 5 minutes or 16 KiB, at logout, and on a character
  change. It is written into `chunks[seq]` when it closes and refreshed
  every 60 seconds out of combat (so a `/reload` or crash loses at most a
  minute). The open chunk is always the highest `seq`.
- The addon keeps at most 4 MiB of chunks; the oldest unacknowledged ones go
  first and a `dropped` record counts them.
- At login the addon deletes every chunk with
  `seq <= PolestarRecorderAck[PolestarRecorderDB.install]`.

### Ack file (written by Polestar Client)

`Interface/AddOns/Polestar_Recorder/Ack.lua`, loaded first by the TOC. One
entry per install, because several WoW accounts share one AddOns folder:

```lua
PolestarRecorderAck = { ["k3j9x0q2m7ab"] = 37 }
```

The release zip ships it as `PolestarRecorderAck = nil`; Polestar Client
merges its entry into whatever the file holds. A lost ack only means a chunk
is uploaded twice; the server ignores a repeated `(install, seq)`.

### Field encoding

- Integers in decimal. Empty field = unknown or not applicable.
- `P` = three fields `map x y`: `C_Map` uiMapID and the player's position
  in hundredths of a percent (integers 0–10000, about 0.3 yd on a zone).
  Empty when the client gives no position (instances).
- Lists inside a field: items separated by `;`, parts of an item by `:`
  (`12345:2;6789:1`).
- Text fields (titles, names, objective text, notes) have `\t`, `\n`, `;`
  and `:` replaced with spaces only where the field is a list; free text
  fields only lose `\t` and `\n`. Text is in the client's language
  (`session.locale`). At most 4,000 bytes per text field.
- `npcKind`: `c` creature, `o` game object, `i` item, `p` player (never
  stored beyond the kind), empty unknown.
- Unknown record kinds are skipped by readers (forward compatible). A known
  kind with a malformed or extra field makes the whole chunk invalid; missing
  trailing optional fields read as empty (the addon always writes them all).

### Record kinds

Context

| Kind | Fields after `dt` | When |
|---|---|---|
| `chunk` | seq, serverEpoch, charId | first record of each chunk |
| `session` | charId, race, class, faction, sex, level, locale, build, interface, region, ruleset, recorderVersion, polestarVersion, packs | login, reload, every new chunk's second record. `race`/`class` are the client's file tokens (`Scourge`, `WARRIOR`); `faction` `Horde`/`Alliance`; `build` the build number only (`70532`); `region` from `GetCurrentRegion`; `ruleset` flags `h` hardcore, `p` PvP joined (the client has no API for RP realms); `packs` = `id:version;...` of Polestar guide packs loaded, plus `guide:<id>` of the active guide |
| `map` | id, type, parent, continent, top, left, bottom, right | once per install per map seen (also kept in `maps`) |
| `level` | level, P, playedSeconds | level up |
| `xp` | xp, xpMax, rested | every 5 minutes and at level up |
| `dropped` | count | after chunks were dropped for size |
| `mark` | P, text | `/psrec mark <text>` |

Movement

| Kind | Fields | When |
|---|---|---|
| `pos` | P, flags, speed | 25 yd and 2 s since the last, or 4 yd and 20 s; every 1 yd/0.25 s while `/psrec trail` is on. `flags` bits: 1 mounted, 2 swimming, 4 indoors, 8 flying, 16 falling, 32 dead or ghost, 64 trail sample. `speed` = yards/s ×10 when readable |
| `zone` | P, zoneText, subzoneText | map or zone text changes |
| `ride` | on (1/0), P | moved while the player's own speed is 0 (boat, zeppelin, lift, tram) and when it stops |
| `taxi` | fromNode, toNode | flight takeoff (`UnitOnTaxi` confirmed); nodes are taxi node ids |
| `land` | node, seconds, P | flight landing |
| `death` | P, killerNpc, killerLevel | death; killer = the last hostile creature that targeted or hit the player within 10 s, when readable |
| `revive` | P, how (`s` spirit healer, `c` corpse, `r` resurrected) | alive again |
| `combat` | on (1/0), P | entering and leaving combat |
| `afk` | on (1/0) | AFK flag changes |
| `rest` | kind (`f` food, `d` drink, `b` both), seconds | an eat/drink aura ends |

Quests

| Kind | Fields | When |
|---|---|---|
| `offer` | npcKind, npcId, P, available, active, log, done, notOffered | a gossip, quest greeting or quest detail window opens. `available`/`active` = quest ids shown; `log` = quest ids in the log; `done`/`notOffered` = among the quests Polestar's data says this NPC starts (when Polestar is loaded), those flagged completed and those neither offered, in the log, nor completed |
| `detail` | q, npcKind, npcId, P, startItem | quest detail shown |
| `text` | q, title, objectiveText, detailText | first time this character sees a quest's text (`textSeen`) |
| `accept` | q, npcKind, npcId, P, level, rewardXp, rewardMoney, items, choices | quest accepted. `items`/`choices` = `itemId:count` |
| `objectives` | q, list | at accept: `type:required:text` per objective (type `monster`, `item`, `object`, `event`, `reputation`, `log`) |
| `progress` | q, index, cur, max, P | an objective count changes |
| `complete` | q | all objectives done |
| `turnin` | q, npcKind, npcId, P, level, xp, money, chosenItem | quest handed in (`xp`, `money` actually paid) |
| `abandon` | q | quest abandoned |
| `gossip` | npcKind, npcId, P, optionId, optionText | a gossip option is chosen |
| `cast` | spellId, itemId, P, targetKind, targetId | the player uses a quest or usable item, or casts a spell that is not on the action bars' class spellbook (quest spells, summons); never combat rotation spells |
| `escort` | q, on (1/0), P | an escort or event quest starts (timer or follower appears) and ends |

Fights and loot

| Kind | Fields | When |
|---|---|---|
| `kill` | npcId, level, cls, P, xp, rested, tapped, q | a creature the player or pet killed (`PARTY_KILL`, `UNIT_DIED` when readable, else the XP line). `cls` `n` normal, `e` elite, `r` rare, `R` rare elite, `b` boss; `xp`/`rested` from the XP message (client format strings, any language); `tapped` 1 when another player had the tag; `q` = `questId:index` when an objective ticked within 3 s |
| `loot` | srcKind, srcId, P, gather, items, wanted | a loot window, one per source. `gather` `h` herb, `m` mine, `s` skin, `f` fish (fishing has an empty `srcKind`/`srcId`), empty corpse/chest; `items` = `itemId:count` (empty = nothing); `wanted` = `questId:index` of every item objective open at that moment (the drop-chance denominator) |
| `unit` | npcId, level, cls, react, P, src | a creature seen on a nameplate, target or mouseover: once per (npcId, level) per session, and once per 100 yd per npcId per session. `react` `h` hostile, `n` neutral, `f` friendly; `src` `p` plate, `t` target, `m` mouseover |
| `rare` | npcId, level, cls, P, src | a rare or rare elite sighted (`src` `v` vignette, `p` plate, `t` target, `m` mouseover) |
| `treasure` | objectId, P | a treasure vignette |
| `enter` | instanceId, instanceType, difficulty, P | entering an instance (P = last outdoor position) |
| `encounter` | encounterId, ok (1/0), difficulty, size | `ENCOUNTER_END` |

Services

| Kind | Fields | When |
|---|---|---|
| `trainer` | npcId, P, services | trainer window: `spellId:cost:reqLevel:state` per service (`state` `a` available, `u` not yet, `k` known); spellId 0 + name when the client gives no id |
| `vendor` | npcId, P, items | merchant window: `itemId:price:stack:qty` (`qty` -1 = unlimited) |
| `flightmaster` | npcId, P, node, known | taxi map opened: this node and the ids of every node this character knows |
| `bind` | npcId, P | hearthstone bound |
| `rep`, `skill`, `explore`, `learn`, `craft`, `achieve` | as schema 1, numeric ids first: `rep` factionId, standing, value, delta; `skill` skillLineId, rank, max; `explore` areaId, xp, P; `learn` spellId; `craft` recipeSpellId, itemId, count (only from the trade skill window); `achieve` id | |

Guide

| Kind | Fields | When |
|---|---|---|
| `step` | guide, step, reason, P | Polestar's step or guide changes (`reason` `next`, `skip`, `back`, `auto` (also at login and reload), `pick`, `done`) |

## Upload API (`https://data.polestar.guide/v1`)

The server is reachable only through a Cloudflare Tunnel: it opens no ports
and its address never appears in DNS.

Polestar Client registers once: it asks for a challenge, spends a few
seconds of CPU on a proof of work, and receives a token, which it keeps on
the PC. The server stores only the token's SHA-256, and calls it the
contributor. Each network (an IPv4 address or an IPv6 /48) can register at
most 3 times a UTC day, and every registration from one network on one day
shares a random cohort id. The server keeps only a keyed hash of the
network, with a salt made for that day, and deletes both when the day ends.

| Request | Body / answer |
|---|---|
| `POST /v1/register` | `{}` → `{ "challenge" (32 hex), "difficulty" (22), "expires" }`; then `{ "challenge", "solution" (u64 decimal) }` (SHA-256 of `challenge:solution` has `difficulty` leading zero bits) → `{ "token" (64 hex) }`. A challenge lasts 10 minutes and works once. |
| `POST /v1/upload` (`Authorization: Bearer <token>`) | `{ "uploader": "0.1.0", "install": "<addon install id>", "chunks": [ { "seq": 38, "text": "..." } ] }`. Answer `{ "accepted": [38], "duplicate": [], "rejected": [ { "seq": 39, "reason": "..." } ] }`. Each chunk is decoded with the library; a chunk with any malformed record, or whose `chunk` record names another seq, is rejected whole. An unknown token gets 401 and registers again. |
| `GET /v1/me` (bearer) | `{ "chunks", "records": { kind: n }, "first_upload", "last_upload" }` (unix seconds): what the server holds from this token. |
| `DELETE /v1/me` (bearer) | deletes everything the server holds from this token, counts included; answers `{ "deleted": <chunks> }`. A tombstone then removes it from the maintainer's copies on their next pull. |
| `GET /v1/stats` | public totals: contributors, chunks, records by kind, quests seen, last 30 days (cached 60 s). |
| `GET /v1/export?after=<id>&limit=<n>[&include=suspect]` (maintainer key) | NDJSON, one line per chunk: `{ "id", "contributor" (token hash, 16 hex), "cohort" (16 hex), "contributorSince", "contributorChunks" (chunks that passed the checks), "install", "seq", "received", "flagged", "text" }`; with `include=suspect` also suspect chunks, with `suspect` and `suspectReasons`. `after` defaults to 0, `limit` to 500 (at most 1000); a page also stops after 8 MiB of chunk text (always at least one line). |
| `GET /v1/export/tombstones?after=<unix>` (maintainer key) | NDJSON `{ "contributor", "at", "why": "deleted" \| "blocked" }`, oldest first; `forge record pull` purges those contributors' chunks and sessions. |
| `POST /v1/export/ack` `{ "upto": <id> }` (maintainer key) | every export line up to `<id>` is safely stored; answers `{ "acked", "pruned", "held" }`. |
| `GET /v1/admin/storage` (maintainer key) | database size and cap, free disk and floor, the oldest unacknowledged chunk's age, row counts. |
| `GET /v1/admin/contributors`, `POST /v1/admin/contributors/<hash>/block`, `/unblock` (maintainer key) | moderation. A blocked contributor's uploads are handled like anyone's but never exported or counted in the stats. |
| `GET /healthz` | `ok` (503 when the database is stuck) |

Limits: a body is at most 2 MiB and must arrive within 10 seconds; at most 4
uploads are processed at once. An upload holds at most 256 chunks; a chunk
is at most 64 KiB of text and 4,096 records (Polestar Client skips a bigger
chunk rather than cutting it). Records of unknown kinds are dropped from the
stored chunk (Polestar Client leaves them out before sending); more than 64
reject the chunk. uiMapIDs are below 100,000. 20 MiB per contributor per UTC
day (checked before the body is read, and counted on every byte received),
30 requests per minute per contributor, 120 per network, 10 a minute on
`/v1/register`, 10 unknown-token answers a minute per network. Requests that
did not come through the tunnel are refused. Chunks from builds older than
the server's minimum build are stored with `flagged`, and forge skips them.

The server is a buffer, not the archive: `forge record pull` stores the
export in `data/recordings`, then acknowledges it. Acknowledged chunks are
deleted from the server 14 days after they arrived (stored compressed until
then); the server keeps only counts (for `/v1/me` and `/v1/stats`) and which
seqs it has seen, so a chunk sent again is still answered `duplicate`. When
the database reaches its size cap (20 GiB) or its disk has under 25 GiB free,
uploads are answered `503 {"error":"server busy, try later"}` with
`Retry-After`; Polestar Client keeps the chunks and retries later.

The plausibility checks: clock within the last 30 days and at most 10
minutes ahead, a chunk spans at most 2 hours, seq within 400 of the
install's highest, levels 1–60, kill XP within what the level allows, at
most 40 kills and 60 loot windows a minute, ids below 1,000,000, and at most
100 yards a second between positions on one map (map sizes from the game's
own map data, never from the upload).

## Trust

Everything here is open source and anyone can edit their own file or write
their own client, so nothing trusts a single upload.

- **At the server.** Every chunk is decoded strictly and checked for things
  play can't produce: timestamps in the future or long past, time running
  backwards, impossible movement speed between positions, kill XP beyond what
  the level allows, more kills or loot windows a minute than a player can
  manage, ids out of range, text with control characters or game markup. A
  chunk that fails is kept aside as suspect and left out of the export. A
  contributor the maintainer blocks is answered like anyone else, but its
  held chunks are deleted and nothing it sends is used; the maintainer can
  also purge a contributor completely. Deleting your data, or being blocked,
  also removes it from the maintainer's copy at the next `forge record pull`.
- **Server-side signals.** Every export line carries `cohort`, `uploadDays`
  and `instance`. `cohort` is a keyed hash of the network (IPv4 address or
  IPv6 /48) the contributor registered from, under a key that changes each
  UTC month, so tokens registered from one place in one month count as one
  voter. `uploadDays` is the number of distinct UTC days on which the server
  received plausible chunks from the contributor, counted by the server, not
  claimed by the client. `instance` identifies the server's database; when
  it changes (a restore or a new database), `forge record pull` starts again
  from the first export id.
- **In the data build.** A voter is a cohort (data pulled before cohorts
  existed counts per contributor, resolved across all its sessions). A
  contributor counts only once established: `uploadDays` at least 3, at
  least 20 chunks sent, and sessions with real play (positions and kills).
  `local` (the maintainer's own) and `sent-*` (a file the maintainer vouched
  for) always count; `anon-*` (a sent-in file nobody vouched for) never
  does. A voter counts once per fact, however many installs, tokens or
  sessions it has. Every value a recording sets goes through the same rule:
  a value another source already has (a quest's title, objectives, giver or
  ender, rewards, XP, a spawn, a learned path, a trainer's list, a drop
  chance) changes only on the evidence of 3 distinct counted voters (for a
  drop chance, each with 10 kills of their own), or of `local`; a single or
  new voter only fills gaps no other source has. New quests, NPCs, items and
  factions, and map frames, come only from the maintainer's own or vouched
  recordings. Numbers several voters recorded are the median of each voter's
  own value, never a pooled total. A field is labelled as recorded only when
  it came from that trusted evidence. Text from a non-English client never
  overwrites English names.
- **What the server keeps.** Rows per contributor are capped: 5,000 quests,
  8 installs, about 1,000 remembered seqs per install, and 30 days of
  per-day counts. Backups are encrypted, hold neither the day's network salt
  nor registration counts, and are kept 7 days on the server and 30 days
  off-site (locked against deletion for the first 14); deleted data is gone
  from every backup 30 days after deletion.
