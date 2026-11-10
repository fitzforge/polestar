# Recording (schema 2): what the Recorder collects and how it travels

This is the contract between the four parts of Polestar's recording program,
and the public statement of what it collects. Everything here is open source
in this repository.

| Part | Where | Job |
|---|---|---|
| Recorder addon | `addon/Polestar_Recorder/` | Writes compact records into `PolestarRecorderDB` while the player plays: off until `/psrec on` or Polestar Client's share flag, which is on by default in the client (see "Ack file"). |
| Recording library | `rust/crates/polestar-recording/` | Reads the SavedVariables file, decodes and validates records, finds WoW installs, scrubs text, writes the ack file, summarises. Shared by the three below. |
| Polestar Client | `apps/client/` (Tauri) | Desktop app for Windows, macOS and Linux: finds the game, installs the Recorder, uploads new chunks, shows exactly what was sent. |
| Ingest server | `services/ingest/` | Receives uploads, validates them with the library, stores them, serves stats, deletion and the maintainer export. |
| forge | `forge record import`, `forge record pull`, `forge record resession`, `forge record learn` | Turns local files or the server export into `data/recordings/<session>.json` for the data build (`resession` rewrites them all from the archived chunks after a forge update). `import` marks this PC's own installs' contributor `local`. A file someone sent in needs `import --vouch <name>` (contributor `sent-<name>`, a name the maintainer chooses; trusted like the maintainer's own) or `import --anonymize` (contributor `anon-<16 hex>`; never used for the data). `learn` turns the archive into the committed snapshot `data/recorded/` (counts of players only; [forge/learn.md](forge/learn.md)). |

## What is never collected

Character names, realm names, account names, chat, whispers, guild, friends,
other players' names, who is in the player's group (only how many), mail,
auction or trade data, the text of the game's messages (only the constant
name of a refusal, see `refuse`), the server, instance and zone parts of
creature GUIDs, the player's typed text other than `/psrec mark` notes and
`/psrec trail` labels, and anything from outside the game folder.
Quest and gossip text has the player's name replaced with `$N` (and race and
class) in the addon, and again in Polestar Client. Explorer mode (below) adds
game data only: nothing on this list, and nothing more about the player than
the records above already hold.

## SavedVariables (`PolestarRecorderDB`, per account)

```lua
PolestarRecorderDB = {
	schema = 2,
	enabled = true,            -- recording on (/psrec on, or Polestar Client's share flag); nothing is written while false
	optout = true,             -- only after /psrec off: the client's share flag does not turn recording on; /psrec on clears it
	exploreOff = true,         -- only after /psrec explore off: explorer mode stays off (see "Explorer mode"); /psrec explore on clears it
	exploreSaid = true,        -- explorer mode's one-time chat note was shown
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
entry per install, because several WoW accounts share one AddOns folder,
then whether the player shares and whether explorer mode may work:

```lua
PolestarRecorderAck = { ["k3j9x0q2m7ab"] = 37 }
PolestarRecorderShare = true
PolestarRecorderExplore = true
```

The release zip ships it as `PolestarRecorderAck = nil` with no share flag;
Polestar Client merges its entry into whatever the file holds. A lost ack
only means a chunk is uploaded twice; the server ignores a repeated
`(install, seq)`.

`PolestarRecorderShare` is written only once sharing has been on in Polestar
Client at least once (before that the file has no flag, so a `/psrec on` of
someone whose client never shared is left alone). Sharing is on by default in
the client: once it has found the game, a player who never chose shares, as
if they had pressed Start sharing, unless an account's `PolestarRecorderDB`
says `optout` (`/psrec off`), and a notice in the client says once what is
shared, with Stop sharing. A player who stopped sharing in the client stays
off; it never turns back on by itself. From then on the flag is `true` while
sharing is on and uploads are not paused, `false` otherwise; the client
writes it whenever that changes and with every ack. At login the Recorder
reads it: `true` turns recording on (saying so once in chat) unless `optout`
is set, `false` turns it off (without setting `optout`), and no flag leaves
`enabled` as the player set it. So the client's sharing is enough;
`/psrec off` stays the player's last word until `/psrec on`. The Recorder's
own default does not change: installed without Polestar Client (no flag), it
stays off until `/psrec on`.

`PolestarRecorderExplore = false` keeps explorer mode off (as `/psrec explore
off` does, without setting `exploreOff`); `true` or no flag leaves it to the
player (on unless they typed `/psrec explore off`). `/psrec explore on`
overrides a `false` flag for the session. Polestar Client writes it only
once its explorer toggle has been used.

### Client info (written by Polestar Client)

`Interface/AddOns/Polestar/ClientInfo.lua`, loaded first by Polestar's TOC
(the main addon's folder, not the Recorder's: the update card is
Polestar's). After each check for addon updates, after it installs or
updates Polestar (whose release ships the file as `PolestarClientInfo =
nil`) and after each look for the game, Polestar Client writes the newest
Polestar releases it found:

```lua
PolestarClientInfo = {
	latest = "0.3.7",
	released = 1794312000,
	checked = 1794400000,
	releases = { "0.3.7", "0.3.6", "0.3.5" },
}
```

`latest` is the newest release, `released` when GitHub published it and
`checked` when the client looked (Unix seconds), `releases` up to 20
release versions, newest first. Only releases count, never pre-releases,
whichever update channel the client is on, and only versions of digits and
dots. The game reads addon files only when it loads them (login, `/reload`)
and never writes them, so the client writes this one at any time, atomically
(a temporary file, then a rename), and only when its text changes. The
client checks GitHub's release list every 6 hours while **Check for
updates** is on (and whenever the Addons page checks); the file is never
older than its last check.

The addon (`Core/Update.lua`, docs/ARCHITECTURE.md "Update notices") trusts
it before any other player's version: `latest` newer than the running build
shows the update card; `releases` counts how many releases behind it is; a
check newer than a party or guild member's sighting overrules that member's
higher number; a check from the last 7 days that finds nothing newer keeps
the "this Polestar is 3 weeks old" line away. Its presence alone says the
client is installed, and the card then says the client can update
Polestar.

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
  (`session.locale`). At most 4,000 bytes per text field, and no control
  characters. Quest titles (`text`), objectives (`objectives`) and zone names
  (`zone`) also have no `|` (the game's escape character) and at most 255
  characters (100 for zone names). The frFR client's kill objectives end in a
  `|4personnage tué:personnages tués;` grammar escape, which the Recorder
  drops since 0.3.6; readers drop it from older uploads too (with the count
  before it, and no-break spaces read as spaces). Readers empty a name that
  still breaks the rule and keep the record. A control character still makes
  the chunk invalid.
- `npcKind`: `c` creature, `o` game object, `i` item, `p` player (never
  stored beyond the kind), empty unknown.
- `spawnUid`: 1–16 hex digits (`0-9`, `A-F`); `error`: a game constant's
  name, 1–64 of `A-Z`, `0-9` and `_`.
- Unknown record kinds are skipped by readers (forward compatible). A known
  kind with a malformed or extra field makes the whole chunk invalid; missing
  trailing optional fields read as empty (the addon always writes them all).
  So a record gains information as a new kind, never as a new field: an older
  server or Polestar Client drops the new kind and keeps the chunk.

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
| `group` | size, raid (1/0) | at session start and whenever it changes: `size` 0 solo, the other party members (1–4) in a party, the raid's size (the player included) in a raid. Readers carry it onto the `kill`, `xp`, `progress` and `turnin` records after it. Never who is in the group |
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
| `turnin` | q, npcKind, npcId, P, level, xp, money, chosenItem | quest handed in (`xp`, `money` actually paid; `money` is negative for a quest that costs money to hand in, e.g. -300 for 3 silver) |
| `abandon` | q | quest abandoned |
| `fail` | q, P | a quest in the log turns failed (its timer ran out, the escort died), as the client flags it (`C_QuestLog.IsFailed`); once per failure, never for a quest already failed at login |
| `gossip` | npcKind, npcId, P, optionId, optionText | a gossip option is chosen |
| `refuse` | P, targetKind, targetId, error | the game refuses something for a requirement (level, item, quest, skill, reputation, a lock): `error` is the game's constant name for the message (`ERR_QUEST_NEED_PREREQS`, from `GetGameMessageInfo`), never its text; the target is the NPC being talked to, else the creature or object targeted, when known. Only `ERR_QUEST_*`, `ERR_USE_LOCKED*`, `ERR_USE_CANT_OPEN`, `ERR_NOT_ENOUGH_MONEY`, `SPELL_FAILED_REAGENTS` and names with `LEVEL`, `SKILL`, `REQUIRE` or `REPUTATION`; the same one once a minute, at most 10 a minute |
| `cast` | spellId, itemId, P, targetKind, targetId | the player uses a quest or usable item, or casts a spell that is not on the action bars' class spellbook (quest spells, summons); never combat rotation spells |
| `escort` | q, on (1/0), P | an escort or event quest starts (timer or follower appears) and ends |

Fights and loot

| Kind | Fields | When |
|---|---|---|
| `kill` | npcId, level, cls, P, xp, rested, tapped, q | a creature the player or pet killed (`PARTY_KILL`, `UNIT_DIED` when readable, else the XP line). `cls` `n` normal, `e` elite, `r` rare, `R` rare elite, `b` boss; `xp`/`rested` from the XP message (client format strings, any language); `tapped` 1 when another player had the tag; `q` = `questId:index` when an objective ticked within 3 s |
| `spawn` | npcId, spawnUid, P | right after a `kill`, when the creature's GUID has one: `spawnUid` is the GUID's last part only (`Creature-0-…-<npcId>-<spawnUid>`, 1–16 hex digits), never the server, instance or zone parts. The same spawn killed again tells how long it takes to come back |
| `loot` | srcKind, srcId, P, gather, items, wanted | a loot window, one per source. `gather` `h` herb, `m` mine, `s` skin, `f` fish (a catch from a fishing pool has the pool as `o`/srcId; from open water the bobber is left out and `srcKind`/`srcId` are empty), empty corpse/chest; `items` = `itemId:count` (empty = nothing); `wanted` = `questId:index` of every item objective open at that moment (the drop-chance denominator) |
| `gather` | objectId, P, how, skillLineId, rank | a world object gathered with a skill, right after its `loot` (which has the items): `how` `h` herb (Herbalism 182), `m` ore (Mining 186), `f` fishing pool (Fishing 356), `l` lock picked (Lockpicking 633); `rank` = the player's rank in that skill then (the node needs at most that). Once per object per 5 minutes (a pool gives many catches), at most 20 a minute |
| `unit` | npcId, level, cls, react, P, src | a creature seen on a nameplate, target or mouseover: once per (npcId, level) per session, and once per 100 yd per npcId per session. `react` `h` hostile, `n` neutral, `f` friendly; `src` `p` plate, `t` target, `m` mouseover |
| `rare` | npcId, level, cls, P, src | a rare or rare elite sighted (`src` `v` vignette, `p` plate, `t` target, `m` mouseover) |
| `treasure` | objectId, P | a treasure vignette |
| `enter` | instanceId, instanceType, difficulty, P | entering an instance (P = last outdoor position) |
| `encounter` | encounterId, ok (1/0), difficulty, size | `ENCOUNTER_END` (its start is `engage`, in explorer mode) |

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

Explorer mode (only in Forever's new places; see "Explorer mode")

| Kind | Fields | When |
|---|---|---|
| `unitx` | npcId, spawnUid, P | a creature seen on a nameplate, target or mouseover, with its GUID's spawn part (`spawnUid`, as `spawn` carries it: never the server, instance or zone parts); once per spawn per 30 yd it moved (once per session inside a new dungeon, where P is empty) |
| `poi` | q, done (1/0), P | the quest log's own map point for a quest in the log (`C_QuestLog.GetQuestsOnMap` on the player's map): `P` is the quest's point, not the player's; `done` 1 when the quest is ready to hand in (the point is then where it is handed in). Once per quest, map and `done` per session |
| `imap` | instanceId, uiMapId, groupId, floor | inside a new dungeon, whenever its uiMapID changes (the client gives no position there): `groupId` the map group (`C_Map.GetMapGroupID`), `floor` that map's `relativeHeightIndex` in the group |
| `engage` | encounterId, difficulty, size | `ENCOUNTER_START` (the `encounter` record is its end: boss order and time per boss) |
| `where` | npcKind, npcId, subzoneText, indoors (1/0) | an `offer`, `accept` or `turnin` window: the subzone text there (`GetSubZoneText`) and whether the player stood indoors; once per NPC or object per session |
| `open` | spellId, P, targetKind, targetId | the player opened a world object (an "Opening" cast: the client's lock-opening spells, by id or by that name in the client's language), at the player's position; the target is the object the client names as the soft-interact target, when it does (only `o`/`c`). At most 20 a minute |

## Explorer mode

Explorer mode makes the Recorder note more about the places Forever made
new, for the zones and dungeons no other source covers yet. It works by
itself while recording is on and the player is in one of those places, and
nowhere else.

- **Where** (`Explore.lua`, `NEW_PLACES`, the one list it goes by): the new
  zones by uiMapID and every map inside them (2521 and 2665 Zephras Isle,
  2548 Riverglades, 2652 Shen'dralas, 2482 Mount Hyjal, 2524 Darkspear
  Islands), the new instances and separate maps by the map id
  `GetInstanceInfo` gives (Zephras Isle 2991, Hyjal Crater 2995, Darkspear
  Islands 2997, The Hall of Thanes 3065, Ruins of Lordaeron 2999, Excavation
  Site: Wetlands 2998, City of Dalaran 2959, The Drowned City 2970,
  Krol'dok Stronghold 3039, Alcaz Prison 2994, Blackmaw Hold 2974, The
  Shaper's Terrace 3001, Manor Mistmantle 3109), and 200 yards around the
  dungeon doors that stand in older zones (Hall of Thanes, Ruins of
  Lordaeron, Excavation Site: Wetlands, City of Dalaran). Ids from the
  70862 client's Map and UiMap tables (`data/forever` zones.json,
  dungeons.json). The raids of Mount Hyjal have no map ids yet.
- **What, there**: `unit` once per 30 yards per creature (not 100), `pos`
  every 10 yards at most once a second (not 25 yards and 2 seconds), each
  creature spawn seen (`unitx`), and `poi`, `imap`, `engage`, `where` and
  `open` (table above). Elsewhere the Recorder records as it always did.
- **Saying so.** The first time it works on an account, the Recorder says
  once in chat: "Polestar Recorder: recording more detail here to map this
  new zone (/psrec explore off to stop)" (`exploreSaid`).
- **Turning it off.** `/psrec explore off` (kept until `/psrec explore on`;
  `/psrec explore` toggles; `/psrec status` shows it), or Polestar Client's
  explorer flag (`PolestarRecorderExplore = false`, see "Ack file").
- **Privacy.** Only game data: creatures, objects, quests, maps, subzone
  names, boss pulls. Nothing more about the player than recording already
  holds (the position and the indoors flag `pos` carries), and nothing on
  the "never collected" list: never a player's GUID, name, chat, guild or
  group member (`open` drops a soft-interact target that is a player).
- **Cost** (`rust/crates/forge-addontest/tests/addontest/recorder-perf.rs`).
  A busy hour of questing in a new zone (25 creatures on nameplates a
  minute) stores about 133 KiB instead of 55 KiB for a usual hour elsewhere:
  the 4 MiB store holds over 25 hours of it, a day of it is under 4 MiB of
  the server's 20 MiB per contributor, and its largest chunk is about 12 KiB
  and 330 records (the server takes 64 KiB and 4,096). What it remembers for
  a session stays bounded (one number per spawn, at most 1,000 spawns, then
  it starts over). The Recorder's CPU budgets, in the test's reference
  units, hold with it working.
- **Compatibility.** Each addition is a new record kind, so a reader that
  does not know it skips it. Two older readers matter: a Polestar Client
  built before these kinds leaves them out of the upload (it sends only the
  kinds its library knows), and an ingest server before them drops them
  from the stored chunk, but rejects a chunk holding more than 64 records of
  kinds it does not know (a busy explorer chunk easily holds more `unitx`).
  So the server learns the kinds first, then a Polestar Client that knows
  them, and only then does explorer mode data reach the archive.

## Upload API (`https://data.polestar.guide/v1`)

The server is reachable only through a Cloudflare Tunnel: it opens no ports
and its address never appears in DNS.

Polestar Client registers once: it asks for a challenge, spends a few
seconds of CPU on a proof of work, and receives a token, which it keeps on
the PC. The server stores only the token's SHA-256, and calls it the
contributor. Each network (an IPv4 address or an IPv6 /48) can register at
most 3 times a UTC day (and one IPv6 /32 at most 20 times), and every registration from one network on one day
shares a random cohort id. The server keeps only a keyed hash of the
network, with a salt made for that day, and deletes both when the day ends.

| Request | Body / answer |
|---|---|
| `POST /v1/register` | `{}` → `{ "challenge" (32 hex), "difficulty" (22), "expires" }`; then `{ "challenge", "solution" (u64 decimal) }` (SHA-256 of `challenge:solution` has `difficulty` leading zero bits) → `{ "token" (64 hex) }`. A challenge lasts 10 minutes and works once. With the maintainer key as the bearer on both requests, the token is a test identity: no network's daily count, blocked from the start (never exported or in `/v1/stats`). |
| `POST /v1/upload` (`Authorization: Bearer <token>`) | `{ "uploader": "0.1.0", "install": "<addon install id>", "chunks": [ { "seq": 38, "text": "..." } ] }`. Answer `{ "accepted": [38], "duplicate": [], "rejected": [ { "seq": 39, "reason": "..." } ] }`. Each chunk is decoded with the library; a chunk with any malformed record, or whose `chunk` record names another seq, is rejected whole. An unknown token gets 401 and registers again. |
| `GET /v1/me` (bearer) | `{ "chunks", "records": { kind: n }, "first_upload", "last_upload" }` (unix seconds): what the server holds from this token. |
| `DELETE /v1/me` (bearer) | deletes everything the server holds from this token, counts included; answers `{ "deleted": <chunks> }`. A tombstone then removes it from the maintainer's copies on their next pull. |
| `GET /v1/stats` | public totals: contributors, chunks, records by kind, quests seen, last 30 days, and the last 30 days' rejected chunks by reason class (`rejects`: `{day, reason, chunks}`, the reason without what was sent) (cached 60 s). |
| `GET /v1/export?after=<id>&limit=<n>[&include=suspect]` (maintainer key) | NDJSON, one line per chunk: `{ "id", "contributor" (token hash, 16 hex), "cohort" (16 hex), "contributorSince", "contributorChunks" (chunks that passed the checks), "install", "seq", "received", "flagged", "text" }`; with `include=suspect` also suspect chunks, with `suspect` and `suspectReasons`. `after` defaults to 0, `limit` to 500 (at most 1000); a page also stops after 8 MiB of chunk text (always at least one line). |
| `GET /v1/export/tombstones?after=<unix>` (maintainer key) | NDJSON `{ "contributor", "at", "why": "deleted" \| "blocked" }`, oldest first; `forge record pull` purges those contributors' chunks and sessions. |
| `POST /v1/export/ack` `{ "upto": <id> }` (maintainer key) | every export line up to `<id>` is safely stored; answers `{ "acked", "pruned", "held" }`. |
| `GET /v1/admin/storage` (maintainer key) | database size and cap, free disk and floor, the oldest unacknowledged chunk's age, row counts. |
| `GET /v1/admin/contributors`, `POST /v1/admin/contributors/<hash>/block`, `/unblock` (maintainer key) | moderation. A blocked contributor's uploads are handled like anyone's but never exported or counted in the stats. |
| `GET /healthz` | `ok` (503 when the database is stuck) |

Limits: a body is at most 2 MiB and must arrive within 10 seconds; at most 32
bodies are read and 4 uploads processed at once (more get 503 and
`Retry-After`). An upload holds at most 256 chunks; a chunk
is at most 64 KiB of text and 4,096 records (Polestar Client skips a bigger
chunk rather than cutting it). Records of unknown kinds are dropped from the
stored chunk (Polestar Client leaves them out before sending); more than 64
reject the chunk. uiMapIDs are below 100,000. 20 MiB per contributor per UTC
day (checked before the body is read, and counted on every byte received)
and 60 MiB per cohort,
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
most 40 of the player's own kills (and their `spawn` records; kills another
player had tagged don't count) a minute, 60 loot windows, 30 `gather`, 30
`refuse` and 30 `open` records a minute, groups of at most 40, ids below 1,000,000, and no
movement faster than 100 yards a second between positions on one map twice
in a row or more than twice in a chunk (one such jump is a teleport the game
makes: the spirit healer after a release, a portal; map sizes from the game's
own map data, never from the upload). At startup the server checks the
suspect chunks it holds again under the current rules; one flagged only for
speed or kill rate that passes now is stored as plausible and exported.

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
  for) are trusted outright; `anon-*` (a sent-in file nobody vouched for),
  contributors not yet established and contributors the maintainer's audit
  excluded (`config.json` `exclude`) are not used at all. A voter counts once
  per fact, however many installs, tokens or sessions it has. Every value a
  recording sets goes through the same rule: a value another source already
  has (a quest's title, level, objectives, giver or ender, rewards, XP, an
  NPC's name, rank or level, a spawn, a learned path, a trainer's list, a
  drop chance) changes only on the evidence of 3 distinct counted voters
  (for a drop chance, each with 10 kills of their own), or of `local` or
  `sent-*`; one counted voter fills only gaps no other source has. Nothing
  a recording says overrides one of Polestar's own corrections
  (`forever-db/corrections`): the build keeps the corrected value and lists
  the disagreement for review.
  Objectives are added or reordered only on trusted evidence, except by the
  game's own objective list: the `objectives` record at the accept, the lines
  the game reveals later and what ticked each line (kill credits, a window
  opened with an NPC where and when a line ticked) set a quest's objective
  count, order and talks from one counted voter, since the list is the
  client's own; voters whose lists disagree leave the data's objectives, and
  the build lists the quest. New quests,
  NPCs, objects, items, factions and zones come only from `local` or
  `sent-*`, and map frames only from `local` (for maps the game's own data
  lacks). Numbers several voters recorded are the median of each voter's own
  value, never a pooled total. Each field is labelled by where it came from:
  recorded on trusted evidence, or a gap one voter filled (which the public
  database never publishes on its own). Text from a non-English client never
  overwrites English names.
- **In the learned layer** (`forge record learn`, [forge/learn.md](forge/learn.md)).
  The same voters and the same establishment rule, plus the maintainer's
  audit: contributors it marks exclude or suspect never count, contributors
  it finds to be one person (a shared install, character or cohort) vote
  once, and a character id re-used for another race or class has neither
  trusted. For the quests Forever added it learns where objectives are done
  (each voter's tick spots, then spots several voters share) and
  prerequisites and minimum levels from givers' refusals and unlocks only,
  never from what players merely did in order (most follow our guides). A
  fact replaces another source's value only when 3 counted voters back it
  and at least two thirds of the counted voters with evidence either way
  agree; a refusal-backed prerequisite or level needs 2. A fact one voter
  recorded is provisional: the Codex and guides may use it, the public
  database never does. Corrections still win. The committed snapshot
  (`data/recorded/`) holds counts of voters only, never who they are.
- **What the server keeps.** Rows per contributor are capped: 5,000 quests,
  8 installs, about 1,000 remembered seqs per install, and 30 days of
  per-day counts. Backups are encrypted, hold neither the day's network salt
  nor registration counts, and are kept 7 days on the server and 30 days
  off-site (locked against deletion for the first 14); deleted data is gone
  from every backup 30 days after deletion.
