# polestar-ingest

The server side of Polestar's recording program. Polestar Client registers
with it for a token, then sends it the Recorder's chunks; it checks every
chunk with the recording library (`rust/crates/polestar-recording`), stores
it, and serves the totals, each contributor's own view and deletion, the
maintainer export that `forge record pull` reads, and moderation. What is
recorded and the API itself are specified in
[docs/RECORDING.md](../../docs/RECORDING.md).

## Trust model

All of this is public code. Nothing depends on the code, the client or the
protocol being secret: assume anyone can read it, change any file and write
their own client. What protects the data instead:

- **Tokens come from the server.** `POST /v1/register` hands out a
  challenge (signed with `INGEST_SECRET`, valid 10 minutes, spendable once);
  a client that finds a `solution` with SHA-256(`challenge:solution`)
  starting with `INGEST_POW_BITS` zero bits (default 22, about a second of
  one CPU core) gets a random 32-byte token. The server keeps only the
  token's SHA-256. Every other contributor route needs a registered token;
  an unknown one is answered `401 {"error":"unknown token"}`.
- **Registrations are scarce.** At most 3 a day per network (an IPv4
  address; an IPv6 /48 counts as one), and 10 register requests a minute.
  The counts are kept in the database, so a restart does not reset them.
- **Cohorts.** A contributor's cohort is the first 16 hex digits of an HMAC
  of its network under a key derived from `INGEST_SECRET` and the UTC month
  (`YYYY-MM`), so every registration from one network in one month shares
  it, whichever side of midnight it falls on. Only the cohort is stored with
  the contributor (never the address, and without the secret the database
  does not reveal the network). It is on every export line, so forge counts
  distinct cohorts, not contributors: several tokens from one place count
  once.
- **Every chunk is decoded and checked.** Malformed chunks are rejected. A
  chunk whose values could not come from a real session (`plausible` in the
  recording library: clock, seq, levels, kill XP, kill and loot rates, ids,
  movement speed) is stored marked suspect, answered as accepted, and left
  out of the export. Movement speed is measured on the canonical map sizes
  built into the library (`maps_table.rs`), never on sizes an uploader
  sends; maps not in it are not speed-checked.
- **The maintainer can block a contributor.** A blocked contributor's
  uploads are answered exactly like anyone's (accepted, duplicates answered
  `duplicate`, counted in its `/v1/me`), so it cannot tell. The block
  deletes the chunks it holds, and from then on only its seqs, installs,
  record counts and totals are kept; it is left out of the export and
  `/v1/stats`, and a tombstone tells forge to drop what it pulled before.
  `POST /v1/admin/contributors/{hash}/purge` deletes everything of a
  contributor, counters included.
- **Rows per contributor are bounded.** At most 5000 quest rows (quest ids
  from 1,000,000 up are not counted), 8 installs (chunks from a ninth are
  rejected), about 1000 remembered seqs per install, 30 days of per-day
  counts and one row per record kind. Suspect chunks add no quest or day
  rows. `/v1/stats` reads running totals, is rebuilt by one request at a
  time and serves the previous answer while it is rebuilt.
- **forge trusts no single contributor.** Export lines carry how long the
  contributor has been around, how many plausible chunks it sent and on how
  many distinct UTC days the server received them (`uploadDays`), and the
  data build needs several contributors to agree (docs/RECORDING.md,
  "Trust").

## Network

The server is never reachable directly:

- The container publishes no ports. It shares a private Compose network,
  marked internal, with one other container: the Cloudflare Tunnel
  (`cloudflared`). The server can reach nothing outside that network, and
  nothing outside it can reach the server.
- The tunnel connects out to Cloudflare; Cloudflare sends the public
  hostname's requests down it. The host's address is in no DNS record, and
  the host needs no inbound port for the service.
- The host's firewall should allow no inbound traffic except ssh, and
  nothing at all from the project network: Docker does not stop an internal
  network reaching the host's own ports through its gateway. The network's
  subnet is pinned in `compose.yaml` (172.24.0.0/16) so a host `INPUT` rule
  dropping new connections from it stays valid.
- Every `/v1` request must carry `CF-Connecting-IP`, which Cloudflare sets
  (and overwrites when a client sends its own); requests without it are
  refused with 403 unless `INGEST_ALLOW_DIRECT=1`, which is only for local
  development and tests. `/healthz` is the reverse: it is for the
  container's own healthcheck and answers 404 to any request carrying
  `CF-Connecting-IP`, so it is not reachable through the tunnel.

## What it stores

One SQLite file, `/data/ingest.sqlite` (WAL, incremental auto-vacuum,
`secure_delete` on, so deleted rows are overwritten). SQLite's temporary
files go to `/data` too (`SQLITE_TMPDIR`). The server is a buffer, not the
archive: the archive is the maintainer's `data/recordings`, which
`forge record pull` writes and then acknowledges.

- `contributors`: the SHA-256 of each token (the token itself is never
  stored), its cohort, when it registered (`first_seen`) and last uploaded,
  bytes sent today, and `blocked`.
- `chunks`: the chunk text as uploaded (minus unknown-kind records),
  zstd-compressed (level 9), its install id, seq and server epoch, when it
  arrived, the game build and client language from its `session` record,
  the uploader version, `flagged` when the build is older than
  `INGEST_MIN_BUILD` (or unknown), and `suspect` with the reasons when it
  failed a plausibility check. Deleted once acknowledged and older than
  `INGEST_RETAIN_DAYS` (see Retention).
- `totals`, `kinds`, `quests`, `days`: per contributor its chunk count (and
  how many passed the checks), bytes, first and last upload, distinct
  upload days, records by kind, quests seen (at most 5000) and chunks per
  day (30 days). `/v1/me`, `/v1/stats`, the export's `contributorChunks`
  and `uploadDays` and the admin list read these, so they stay right after
  chunks are pruned. `quest_counts` holds, per quest, how many unblocked
  contributors saw it, for the running distinct-quest total.
- `installs`, `seqs`: each install's highest seq (for the plausibility
  checks) and the seqs stored, so a chunk sent again after it was pruned is
  still answered `duplicate` and not stored twice. Seqs more than 1000 below
  their install's highest are forgotten once their chunk is gone (the addon
  never holds chunks that old).
- `settings`: the acknowledged export id, the distinct-quest total and the
  database's `instance` id (random, made once; on every export line, so
  forge restarts its cursor when the database is restored or replaced).
- `spent_challenges`: registration challenges already used, until they
  expire.
- `tombstones`: the 16-hex ids of deleted and blocked contributors, with
  when and why, for `GET /v1/export/tombstones`.
- `day_salt`, `registrations`: today's random salt, and per network (as the
  HMAC of its address or /48 under that salt) today's registration count.
  Both are deleted once the day is over, and never backed up.

Everything a contributor sent goes on `DELETE /v1/me`, counters included.

Client IP addresses are never written anywhere; only their salted HMACs
for the current UTC day and the monthly cohort HMAC, as above (the daily
one is also used, in memory, for the per-IP request limits).
No IP addresses, request bodies or headers are logged; the log holds
method, path and status.

## Rules

| | |
|---|---|
| Request body | at most 2 MiB (413), sent within 10 s (408); `/v1/register` at most 1 KiB |
| Per client IP | 120 requests a minute on `/v1` (429), 10 a minute on `/v1/register`, 10 unknown-token answers a minute, 3 registrations a UTC day (per network) |
| Per contributor | 30 requests a minute (429, in memory, only for registered tokens), 20 MiB a UTC day (429; checked on the declared size before the body is read, and again on the body; a body not sent within 10 s counts with its declared size, or 2 MiB), one upload in flight (429), at most 8 installs (chunks from a ninth are rejected) |
| Uploads | the body is read first; then at most 4 are decoded and stored at once, others answered `503` with `Retry-After: 30`; at most 256 chunks (400) |
| Chunks | at most 64 KiB of text and 4096 records, else rejected; decoded whole, any malformed record rejects the chunk, with the reason; the `chunk` record's seq must match the uploaded seq; uiMapIDs below 100000; at most 64 records of unknown kinds, which are dropped from the stored text; implausible ones are stored suspect |
| Storage | uploads answer `503 {"error":"server busy, try later"}` with `Retry-After: 3600` while the database is over `INGEST_MAX_DB_MB` or the data volume has under `INGEST_MIN_FREE_GB` free (Polestar Client retries with backoff); a warning is logged at most once an hour meanwhile |
| `/healthz` | `ok` when the database answers within 2 s, else 503; 404 with `CF-Connecting-IP` (through the tunnel) |
| `/v1/stats` | rebuilt at most once a minute, by one request at a time; a stale answer is served while it is rebuilt; blocked contributors left out |
| `/v1/export` | maintainer key; `after` (default 0), `limit` (default 500, at most 1000; a page also stops after 8 MiB of chunk text, always holding at least one line), `include=suspect` adds suspect chunks (with `suspect` and `suspectReasons`); NDJSON, streamed, adds `cohort`, `flagged`, `contributorSince`, `contributorChunks`, `uploadDays` and `instance` to the documented fields; blocked contributors' chunks are never exported |
| `POST /v1/export/ack` | maintainer key; `{ "upto": <export id> }`: the maintainer has stored every line up to there (clamped to the last chunk; never goes back). Prunes at once what is already past the retention; answers `{ "acked", "pruned", "held" }` |
| `/v1/export/tombstones` | maintainer key; `after` (unix seconds, default 0); NDJSON `{ "contributor", "at", "why" }`, `why` = `deleted` or `blocked`, oldest first: drop every chunk of that contributor |
| `/v1/admin/contributors` | maintainer key; every contributor: `hash`, `firstSeen`, `lastSeen`, `chunks`, `suspectChunks`, `blocked` |
| `GET /v1/admin/storage` | maintainer key; `dbBytes`, `maxDbBytes`, `freeBytes`, `minFreeBytes`, `uploadsRefused` (the reason, or null), `retainDays`, `acked`, `oldestUnackedAge` and `oldestAge` (seconds, null when none), `rows` per table |
| `POST /v1/admin/contributors/{hash}/block`, `/unblock` | maintainer key; `hash` = at least 16 hex digits of the contributor hash (the export shows 16); answers `{ "hash", "blocked" }`, 404 when none matches, 409 when several do. A block deletes the chunks held; an unblock does not bring them back |
| `POST /v1/admin/contributors/{hash}/purge` | maintainer key, `hash` as above; deletes the contributor's chunks, counters and row (its token stops working) and leaves a `deleted` tombstone; answers `{ "hash", "purged": true }` |
| `DELETE /v1/me` | deletes the contributor's chunks, counters and row (its token stops working) and leaves a tombstone; answers `{ "deleted": <chunks it sent> }` |
| `/v1/me`, `/v1/stats` | count every chunk received, pruned ones too |
| CORS | `tauri://localhost`, `http://tauri.localhost`, `https://tauri.localhost` |

The maintainer key goes in `Authorization: Bearer <INGEST_MAINTAINER_KEY>`
and is compared in constant time.

## Configuration (environment)

| Variable | Default | |
|---|---|---|
| `INGEST_MAINTAINER_KEY` | required | at least 32 characters (the deployment uses 32 random bytes in hex) |
| `INGEST_SECRET` | required | at least 32 characters; signs registration challenges (`deploy.sh` generates one) |
| `INGEST_POW_BITS` | `22` | proof-of-work difficulty, 1–40 |
| `INGEST_MIN_BUILD` | `0` | chunks from older game builds are stored flagged |
| `INGEST_ALLOW_DIRECT` | unset | `1` serves requests without `CF-Connecting-IP` (development only) |
| `INGEST_DB` | `/data/ingest.sqlite` | |
| `INGEST_ADDR` | `0.0.0.0:8080` | |
| `INGEST_RETAIN_DAYS` | `14` | acknowledged chunks are deleted this many days after they arrived |
| `INGEST_MAX_DB_MB` | `20480` | uploads get 503 while the database is larger |
| `INGEST_MIN_FREE_GB` | `25` | uploads get 503 while the data volume has less free space |
| `INGEST_BACKUP_MOUNT` | named volume `backup` | compose only: the host folder mounted at `/backup` for backups |
| `RUST_LOG` | `info,tower_http=info` | |

## Retention and housekeeping

- `forge record pull` archives the export, writes its sessions and saves its
  state, and only then sends `POST /v1/export/ack` with the last id it
  pulled. A chunk is deleted once its id is acknowledged **and** it arrived
  more than `INGEST_RETAIN_DAYS` ago. Chunks the pull skips (suspect, from
  blocked contributors) go with the ack too: the server holds nothing
  forever.
- Every hour the server prunes (in batches of 2000, letting go of the
  database in between), deletes expired challenges, old salts and day
  counts and old seqs, gives free pages back (`incremental_vacuum`) and
  truncates the WAL (`wal_checkpoint(TRUNCATE)`); the first pass runs at
  start-up.
- An older database is migrated on start: text compressed in batches,
  counters filled, quest rows trimmed to their caps, blocked contributors'
  held rows deleted, then one `VACUUM` to switch on incremental
  auto-vacuum. The data volume needs free space of about twice the
  database for it.

## Develop

```sh
cd services/ingest
cargo test --profile quick
cargo clippy --all-targets -- -D warnings
INGEST_MAINTAINER_KEY=$(openssl rand -hex 32) INGEST_SECRET=$(openssl rand -hex 32) INGEST_ALLOW_DIRECT=1 \
	INGEST_DB=/tmp/ingest.sqlite INGEST_ADDR=127.0.0.1:8080 cargo run
```

It is its own Cargo project (own `Cargo.lock`, empty `[workspace]`), so the
forge workspace never builds it.

## Deploy

On a Docker host reachable over ssh:

```sh
services/ingest/deploy.sh <ssh-target> [remote-dir] [git-ref]
# or: INGEST_HOST=<ssh-target> INGEST_DIR=<remote-dir> services/ingest/deploy.sh
```

This sends the committed `services/ingest` and
`rust/crates/polestar-recording` to `remote-dir` (default `polestar-ingest`
in the ssh user's home) and runs `docker compose up -d --build` there. The
host needs `remote-dir/.env` (chmod 600) first:

```sh
INGEST_MAINTAINER_KEY=<openssl rand -hex 32>
INGEST_MIN_BUILD=70532
TUNNEL_TOKEN=<from Cloudflare Zero Trust>
COMPOSE_PROFILES=tunnel
```

`deploy.sh` adds `INGEST_SECRET` when it is missing. Changing
`INGEST_SECRET` voids challenges handed out before and gives networks new
cohorts from then on (contributors keep the cohort they have); tokens stay
valid.

The container (Compose project `polestar-ingest`) runs read-only as a
non-root user (uid 65532) with a 512 MiB memory cap and no swap beyond it,
at most 64 processes, and keeps its database in the named volume
`polestar-ingest_data`. Its healthcheck is the binary itself
(`polestar-ingest healthcheck`). The tunnel runs as uid 65533, with 128 MiB
and at most 32 processes.

The recording server's public hostname, `data.polestar.guide`, comes
through the Cloudflare Tunnel (the `tunnel` service in `compose.yaml`). In
Cloudflare Zero Trust create a tunnel, give it the public hostname
`data.polestar.guide` → `http://polestar-ingest:8080`, and put its token in
`.env` as `TUNNEL_TOKEN`. The tunnel's metrics listen on its own loopback
only (`--metrics 127.0.0.1:20241`). The images are pinned by digest
(`Dockerfile`, `compose.yaml`); update them on purpose.

To try the server from the host without the tunnel, run a client on the
project network and send the header Cloudflare would:

```sh
docker run --rm --network polestar-ingest_default curlimages/curl \
	-s -H 'CF-Connecting-IP: 192.0.2.1' http://polestar-ingest:8080/v1/stats
```

## Backups

`polestar-ingest backup <path>` writes a consistent copy of the live
database (SQLite's online backup) to `<path>`, gzipped and mode 600, and
keeps the newest 7 `ingest-*.sqlite.gz` in that folder. The copy leaves out
`day_salt`, `registrations` and the instance id, and is compacted
(`VACUUM INTO`), so no deleted row survives in it. It refuses to start
without room for two copies of the database plus 256 MiB in that folder.
`backup.sh`, run on the host from the deploying user's crontab, does it
nightly into the `/backup` mount (`INGEST_BACKUP_MOUNT`), fetches it with
`docker cp`, checks it, encrypts it with gpg (AES256, the passphrase in
`BACKUP_PASSPHRASE_FILE`, required), uploads it with rclone when
`BACKUP_REMOTE` is set (`rclone copyto`, a new object per night, never
overwritten), and keeps 7 locally (`BACKUP_DIR`, default
`~/backups/polestar`). The script deletes nothing remotely: the bucket
expires objects with a lifecycle rule (30 days) and an object lock (14 days)
keeps them from being deleted or overwritten before, even with the
uploader's key. The plain copy in the mount is
removed however the script ends, and it stops when either folder has less
than `BACKUP_MIN_FREE_MB` (default 1024) free beyond the backup. Its
settings go in the deploy folder's `.env`:

```sh
INGEST_BACKUP_MOUNT=/home/<user>/backups/polestar/incoming
BACKUP_PASSPHRASE_FILE=<path>     # required
BACKUP_REMOTE=<remote:bucket/dir> # optional
BACKUP_MIN_FREE_MB=1024           # optional
```

**Retention:** local backups hold up to 7 days of the database, remote ones
30. A contributor who deletes its data (or is purged) is gone from the live
database at once, from the local backups 7 days later and from the remote
ones 30 days later. Both are encrypted.

The mount folder must be writable by the server's uid (65532) and nobody
else, e.g. `mkdir -p ~/backups/polestar/incoming && chmod 700
~/backups/polestar ~/backups/polestar/incoming && setfacl -m u:65532:rwx
~/backups/polestar/incoming`. Cron:

```sh
45 3 * * * $HOME/polestar-ingest/services/ingest/backup.sh >> $HOME/backups/polestar/backup.log 2>&1
```

To restore: decrypt (`gpg -d`), `gunzip`, stop the container and put the
file in the `data` volume as `ingest.sqlite` (with no `-wal`/`-shm` beside
it). It starts as a new instance, so the next `forge record pull` starts
from the first export id again.
