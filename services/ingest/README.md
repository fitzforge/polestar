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
- **Cohorts.** The first registration of a network on a UTC day gets a
  random 16-hex cohort id; the network's other registrations that day share
  it. The cohort is stored with the contributor (never the address) and is
  on every export line, so forge counts distinct cohorts, not contributors:
  several tokens from one place count once.
- **Every chunk is decoded and checked.** Malformed chunks are rejected. A
  chunk whose values could not come from a real session (`plausible` in the
  recording library: clock, seq, levels, kill XP, kill and loot rates, ids,
  movement speed) is stored marked suspect, answered as accepted, and left
  out of the export. Movement speed is measured on the canonical map sizes
  built into the library (`maps_table.rs`), never on sizes an uploader
  sends; maps not in it are not speed-checked.
- **The maintainer can block a contributor.** A blocked contributor's
  uploads are handled exactly like anyone's (stored, duplicates answered
  `duplicate`, counted in its `/v1/me`), so it cannot tell; its chunks are
  left out of the export and `/v1/stats`, and a tombstone tells forge to
  drop what it pulled before.
- **forge trusts no single contributor.** Export lines carry how long the
  contributor has been around and how many plausible chunks it sent, and the
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
  development and tests. `/healthz` (the container's own healthcheck) is
  exempt.

## What it stores

One SQLite file, `/data/ingest.sqlite` (WAL):

- `contributors`: the SHA-256 of each token (the token itself is never
  stored), when it registered (`first_seen`) and last uploaded, bytes sent
  today, and `blocked`.
- `chunks`: the chunk text as uploaded, its install id, seq and server
  epoch, when it arrived, the game build and client language from its
  `session` record, the uploader version, `flagged` when the build is older
  than `INGEST_MIN_BUILD` (or unknown), and `suspect` with the reasons when
  it failed a plausibility check. `(contributor, install, seq)` is unique,
  so a chunk sent twice is answered `duplicate` and stored once.
- `chunk_kinds`, `chunk_quests`: record counts by kind and the quest ids per
  chunk, for `/v1/me` and `/v1/stats`. They go with their chunk on delete.
- `spent_challenges`: registration challenges already used, until they
  expire.
- `tombstones`: the 16-hex ids of deleted and blocked contributors, with
  when and why, for `GET /v1/export/tombstones`.
- `day_salt`, `registrations`: today's random salt, and per network (as the
  HMAC of its address or /48 under that salt) today's registration count
  and cohort. Both are deleted once the day is over.

Client IP addresses are never written anywhere; only their salted HMACs
for the current UTC day, as above (also used, in memory, for the per-IP
request limits).
No IP addresses, request bodies or headers are logged; the log holds
method, path and status.

## Rules

| | |
|---|---|
| Request body | at most 2 MiB (413), sent within 10 s (408); `/v1/register` at most 1 KiB |
| Per client IP | 120 requests a minute on `/v1` (429), 10 a minute on `/v1/register`, 10 unknown-token answers a minute, 3 registrations a UTC day (per network) |
| Per contributor | 30 requests a minute (429, in memory, only for registered tokens), 20 MiB a UTC day (429; checked on the declared size before the body is read, and again on the body) |
| Uploads | at most 4 handled at once (others wait); at most 256 chunks (400) |
| Chunks | at most 64 KiB of text and 4096 records, else rejected; decoded whole, any malformed record rejects the chunk, with the reason; the `chunk` record's seq must match the uploaded seq; uiMapIDs below 100000; at most 64 records of unknown kinds, which are dropped from the stored text; implausible ones are stored suspect |
| `/healthz` | `ok` when the database answers within 2 s, else 503 |
| `/v1/stats` | computed at most once a minute; blocked contributors left out |
| `/v1/export` | maintainer key; `after` (default 0), `limit` (default 500, at most 1000; a page also stops after 8 MiB of chunk text, always holding at least one line), `include=suspect` adds suspect chunks (with `suspect` and `suspectReasons`); NDJSON, streamed, adds `cohort`, `flagged`, `contributorSince` and `contributorChunks` to the documented fields; blocked contributors' chunks are never exported |
| `/v1/export/tombstones` | maintainer key; `after` (unix seconds, default 0); NDJSON `{ "contributor", "at", "why" }`, `why` = `deleted` or `blocked`, oldest first: drop every chunk of that contributor |
| `/v1/admin/contributors` | maintainer key; every contributor: `hash`, `firstSeen`, `lastSeen`, `chunks`, `suspectChunks`, `blocked` |
| `POST /v1/admin/contributors/{hash}/block`, `/unblock` | maintainer key; `hash` = at least 16 hex digits of the contributor hash (the export shows 16); answers `{ "hash", "blocked" }`, 404 when none matches, 409 when several do |
| `DELETE /v1/me` | deletes the contributor's chunks and row (its token stops working) and leaves a tombstone; answers `{ "deleted": <chunks> }` |
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
| `RUST_LOG` | `info,tower_http=info` | |

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
`INGEST_SECRET` only voids challenges handed out before; tokens stay valid.

The container (Compose project `polestar-ingest`) runs read-only as a
non-root user with a 512 MiB memory cap and keeps its database in the named
volume `polestar-ingest_data`. Its healthcheck is the binary itself
(`polestar-ingest healthcheck`).

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

Back up by copying the volume's `ingest.sqlite` with `sqlite3 .backup` (or
stop the container and copy the file with its `-wal`).
