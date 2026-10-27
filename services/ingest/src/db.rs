//! The SQLite store: contributors, chunks and what the chunks hold.
//!
//! The server is a buffer, not the archive: the archive is the maintainer's copy that
//! `forge record pull` writes. Chunk text is stored zstd-compressed. Once the maintainer has
//! acknowledged a pull (`POST /v1/export/ack`), chunks up to that export id are deleted when
//! they are older than the retention period. What `/v1/me`, `/v1/stats` and the export's
//! contributor figures need is kept in small counter tables, updated when a chunk is stored, so
//! they stay right after pruning; `seqs` remembers which (install, seq) were stored, so a
//! re-upload of a pruned chunk is still answered `duplicate`.
//!
//! A contributor is the SHA-256 of a token the server handed out at registration; the token
//! itself is never stored. No IP address is ever written here. The registration cap and
//! cohorts need to recognise a network for one UTC day: they keep only an HMAC of it under that
//! day's random salt, and the salt and those HMACs are deleted when the day is over.

use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;

use polestar_recording::api::{AdminContributor, ExportLine, MeResponse, Rejected, Stats, StatsDay, Tombstone, UploadResponse};
use rusqlite::types::ValueRef;
use rusqlite::{params, Connection, OptionalExtension};

const SCHEMA: &str = "
CREATE TABLE IF NOT EXISTS contributors (
	hash TEXT PRIMARY KEY,
	first_seen INTEGER NOT NULL,
	last_seen INTEGER NOT NULL,
	bytes_today INTEGER NOT NULL DEFAULT 0,
	day INTEGER NOT NULL,
	blocked INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS chunks (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	contributor TEXT NOT NULL,
	install TEXT NOT NULL,
	seq INTEGER NOT NULL,
	received INTEGER NOT NULL,
	build INTEGER,
	locale TEXT,
	uploader TEXT NOT NULL,
	text TEXT NOT NULL,
	flagged INTEGER NOT NULL DEFAULT 0,
	epoch INTEGER,
	suspect INTEGER NOT NULL DEFAULT 0,
	reasons TEXT,
	UNIQUE (contributor, install, seq)
);
CREATE INDEX IF NOT EXISTS chunks_received ON chunks (received);
CREATE TABLE IF NOT EXISTS spent_challenges (
	challenge TEXT PRIMARY KEY,
	expires INTEGER NOT NULL
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS day_salt (
	day INTEGER PRIMARY KEY,
	salt BLOB NOT NULL
);
CREATE TABLE IF NOT EXISTS registrations (
	day INTEGER NOT NULL,
	network TEXT NOT NULL,
	n INTEGER NOT NULL,
	cohort TEXT NOT NULL,
	PRIMARY KEY (day, network)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS tombstones (
	contributor TEXT NOT NULL,
	at INTEGER NOT NULL,
	why TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS tombstones_at ON tombstones (at);
CREATE TABLE IF NOT EXISTS settings (
	key TEXT PRIMARY KEY,
	value INTEGER NOT NULL
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS totals (
	contributor TEXT PRIMARY KEY,
	chunks INTEGER NOT NULL,
	plausible INTEGER NOT NULL,
	bytes INTEGER NOT NULL,
	first_upload INTEGER NOT NULL,
	last_upload INTEGER NOT NULL
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS kinds (
	contributor TEXT NOT NULL,
	kind TEXT NOT NULL,
	n INTEGER NOT NULL,
	PRIMARY KEY (contributor, kind)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS quests (
	contributor TEXT NOT NULL,
	quest INTEGER NOT NULL,
	PRIMARY KEY (contributor, quest)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS days (
	contributor TEXT NOT NULL,
	day INTEGER NOT NULL,
	chunks INTEGER NOT NULL,
	PRIMARY KEY (contributor, day)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS installs (
	contributor TEXT NOT NULL,
	install TEXT NOT NULL,
	seq INTEGER NOT NULL,
	epoch INTEGER NOT NULL,
	PRIMARY KEY (contributor, install)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS seqs (
	contributor TEXT NOT NULL,
	install TEXT NOT NULL,
	seq INTEGER NOT NULL,
	PRIMARY KEY (contributor, install, seq)
) WITHOUT ROWID;
DROP TABLE IF EXISTS install_maps;
";

/// Columns added after the first deployment: (table, column, declaration).
const ADDED_COLUMNS: [(&str, &str, &str); 5] = [
	("contributors", "blocked", "INTEGER NOT NULL DEFAULT 0"),
	("contributors", "cohort", "TEXT"),
	("chunks", "epoch", "INTEGER"),
	("chunks", "suspect", "INTEGER NOT NULL DEFAULT 0"),
	("chunks", "reasons", "TEXT"),
];

/// `PRAGMA user_version` of this schema: 2 has compressed text and the counter tables.
const VERSION: i64 = 2;

/// Largest export page, in bytes of chunk text.
pub const EXPORT_MAX_BYTES: usize = 8 * 1024 * 1024;
/// zstd level for chunk text.
pub const ZSTD_LEVEL: i32 = 9;
/// Chunks deleted per prune batch (the database lock is let go between batches).
pub const PRUNE_BATCH: usize = 2000;
/// How many seqs below an install's highest stay remembered after their chunk is pruned. The
/// addon keeps far fewer chunks than this (see `plausible::SEQ_WINDOW`), so an older one cannot
/// be sent again by an honest client.
pub const SEQ_MEMORY: i64 = 1000;
/// Days of per-day counts kept, for `/v1/stats` `last30`.
const STATS_DAYS: i64 = 30;

const DAY: i64 = 86_400;

/// zstd-compressed chunk text.
pub fn compress(text: &str) -> Vec<u8> {
	// Compressing into memory cannot fail but for allocation; fall back to a raw frame never.
	zstd::bulk::compress(text.as_bytes(), ZSTD_LEVEL).expect("zstd compresses any input")
}

/// Chunk text as stored: zstd (a blob) or, from before compression, plain text.
fn stored_text(v: ValueRef<'_>) -> rusqlite::Result<String> {
	match v {
		ValueRef::Blob(b) => {
			let bytes = zstd::stream::decode_all(b).map_err(|e| rusqlite::Error::FromSqlConversionFailure(0, rusqlite::types::Type::Blob, Box::new(e)))?;
			String::from_utf8(bytes).map_err(|e| rusqlite::Error::FromSqlConversionFailure(0, rusqlite::types::Type::Blob, Box::new(e)))
		}
		ValueRef::Text(t) => Ok(String::from_utf8_lossy(t).into_owned()),
		_ => Ok(String::new()),
	}
}

/// A chunk that decoded cleanly and is ready to store.
#[derive(Debug, Clone)]
pub struct NewChunk {
	pub seq: u64,
	/// The chunk's server epoch.
	pub epoch: i64,
	/// The text, zstd-compressed ([`compress`]).
	pub ztext: Vec<u8>,
	/// The text's length uncompressed.
	pub text_len: usize,
	pub build: Option<u32>,
	pub locale: Option<String>,
	pub flagged: bool,
	/// Plausibility issues; any makes the chunk suspect.
	pub suspect: Vec<String>,
	pub kinds: BTreeMap<String, u64>,
	pub quests: BTreeSet<u32>,
}

/// One chunk of an upload after decoding: stored, or rejected with a reason.
#[derive(Debug, Clone)]
pub enum Prepared {
	Ok(Box<NewChunk>),
	Rejected(Rejected),
}

/// What an upload did.
#[derive(Debug)]
pub enum UploadOutcome {
	Done(UploadResponse),
	/// The contributor's bytes for today would pass the daily cap; nothing was stored.
	OverDailyCap,
	/// No such contributor (never registered, or deleted).
	Unknown,
}

/// Who sent an upload, and when.
#[derive(Debug, Clone, Copy)]
pub struct Upload<'a> {
	/// Hex SHA-256 of the uploader's token.
	pub contributor: &'a str,
	pub install: &'a str,
	pub uploader: &'a str,
	/// Request body size, counted against the daily cap whether the chunks are new or not.
	pub body_len: u64,
	/// Unix seconds.
	pub now: i64,
}

/// What the server knows about one install of one contributor before an upload.
#[derive(Debug, Default)]
pub struct InstallContext {
	/// Bytes the contributor sent today.
	pub used_today: u64,
	/// The highest seq stored and that chunk's epoch (0 when unknown).
	pub highest: Option<(u64, i64)>,
}

/// What a registration did.
#[derive(Debug, PartialEq, Eq)]
pub enum Registration {
	/// The contributor was made, in this cohort.
	Done(String),
	/// The challenge was already spent.
	Spent,
	/// The network has had its registrations for today.
	OverCap,
}

/// What a block or unblock found.
#[derive(Debug, PartialEq, Eq)]
pub enum Moderation {
	/// The full hash of the one contributor changed.
	Done(String),
	NotFound,
	/// The prefix matches more than one contributor.
	Ambiguous,
}

pub struct Db {
	conn: Connection,
}

/// The tables keyed by contributor that go with it on delete.
const PER_CONTRIBUTOR: [&str; 7] = ["chunks", "totals", "kinds", "quests", "days", "installs", "seqs"];

impl Db {
	pub fn open(path: &Path) -> rusqlite::Result<Db> {
		let conn = Connection::open(path)?;
		conn.pragma_update(None, "journal_mode", "WAL")?;
		conn.pragma_update(None, "synchronous", "NORMAL")?;
		Db::init(conn)
	}

	pub fn open_in_memory() -> rusqlite::Result<Db> {
		Db::init(Connection::open_in_memory()?)
	}

	fn init(conn: Connection) -> rusqlite::Result<Db> {
		conn.pragma_update(None, "foreign_keys", "ON")?;
		conn.busy_timeout(std::time::Duration::from_secs(5))?;
		// Before the first table, so a new database is incremental from the start.
		conn.pragma_update(None, "auto_vacuum", "INCREMENTAL")?;
		conn.execute_batch(SCHEMA)?;
		for (table, column, decl) in ADDED_COLUMNS {
			let has: bool = conn.query_row(&format!("SELECT COUNT(*) > 0 FROM pragma_table_info('{table}') WHERE name = ?1"), [column], |r| r.get(0))?;
			if !has {
				conn.execute_batch(&format!("ALTER TABLE {table} ADD COLUMN {column} {decl}"))?;
			}
		}
		let mut db = Db { conn };
		let version: i64 = db.conn.pragma_query_value(None, "user_version", |r| r.get(0))?;
		if version < VERSION {
			db.migrate_to_2()?;
		}
		// An older database is not incremental until a VACUUM rewrites it (once).
		let auto_vacuum: i64 = db.conn.pragma_query_value(None, "auto_vacuum", |r| r.get(0))?;
		if auto_vacuum != 2 {
			db.conn.execute_batch("VACUUM")?;
		}
		Ok(db)
	}

	/// Version 2: chunk text compressed, counters filled from the chunks held, per-chunk count
	/// tables dropped.
	fn migrate_to_2(&mut self) -> rusqlite::Result<()> {
		let tx = self.conn.transaction()?;
		tx.execute_batch(
			"CREATE TABLE IF NOT EXISTS chunk_kinds (chunk INTEGER NOT NULL, kind TEXT NOT NULL, n INTEGER NOT NULL, PRIMARY KEY (chunk, kind)) WITHOUT ROWID;
			 CREATE TABLE IF NOT EXISTS chunk_quests (chunk INTEGER NOT NULL, quest INTEGER NOT NULL, PRIMARY KEY (chunk, quest)) WITHOUT ROWID;
			 INSERT OR REPLACE INTO totals (contributor, chunks, plausible, bytes, first_upload, last_upload)
				SELECT contributor, COUNT(*), SUM(suspect = 0), SUM(length(CAST(text AS BLOB))), MIN(received), MAX(received) FROM chunks GROUP BY contributor;
			 INSERT OR REPLACE INTO kinds (contributor, kind, n)
				SELECT c.contributor, k.kind, SUM(k.n) FROM chunk_kinds k JOIN chunks c ON c.id = k.chunk GROUP BY c.contributor, k.kind;
			 INSERT OR IGNORE INTO quests (contributor, quest) SELECT DISTINCT c.contributor, q.quest FROM chunk_quests q JOIN chunks c ON c.id = q.chunk;
			 INSERT OR REPLACE INTO days (contributor, day, chunks) SELECT contributor, received / 86400, COUNT(*) FROM chunks GROUP BY contributor, received / 86400;
			 INSERT OR REPLACE INTO installs (contributor, install, seq, epoch)
				SELECT contributor, install, MAX(seq), 0 FROM chunks GROUP BY contributor, install;
			 UPDATE installs SET epoch = COALESCE((SELECT c.epoch FROM chunks c WHERE c.contributor = installs.contributor AND c.install = installs.install AND c.seq = installs.seq), 0);
			 INSERT OR IGNORE INTO seqs (contributor, install, seq) SELECT contributor, install, seq FROM chunks;
			 DROP TABLE chunk_kinds;
			 DROP TABLE chunk_quests;",
		)?;
		{
			let mut read = tx.prepare("SELECT id, text FROM chunks WHERE typeof(text) = 'text'")?;
			let mut write = tx.prepare("UPDATE chunks SET text = ?2 WHERE id = ?1")?;
			let rows = read.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?)))?.collect::<rusqlite::Result<Vec<_>>>()?;
			for (id, text) in rows {
				write.execute(params![id, compress(&text)])?;
			}
		}
		tx.pragma_update(None, "user_version", VERSION)?;
		tx.commit()
	}

	/// A cheap query, for the health check.
	pub fn ping(&self) -> rusqlite::Result<()> {
		self.conn.query_row("SELECT 1", [], |_| Ok(()))
	}

	/// The database's size in bytes (its pages, free ones included).
	pub fn size_bytes(&self) -> rusqlite::Result<u64> {
		let pages: i64 = self.conn.pragma_query_value(None, "page_count", |r| r.get(0))?;
		let size: i64 = self.conn.pragma_query_value(None, "page_size", |r| r.get(0))?;
		Ok((pages.max(0) as u64).saturating_mul(size.max(0) as u64))
	}

	/// Whether a contributor exists: None when not, else whether it is blocked.
	pub fn contributor(&self, hash: &str) -> rusqlite::Result<Option<bool>> {
		self.conn.query_row("SELECT blocked FROM contributors WHERE hash = ?1", [hash], |r| r.get(0)).optional()
	}

	/// The salt for day `today`, made from `fresh` when the day has none yet. Salts and
	/// registration counts of earlier days are deleted.
	pub fn day_salt(&mut self, today: i64, fresh: [u8; 32]) -> rusqlite::Result<[u8; 32]> {
		let tx = self.conn.transaction()?;
		tx.execute("DELETE FROM day_salt WHERE day < ?1", [today])?;
		tx.execute("DELETE FROM registrations WHERE day < ?1", [today])?;
		tx.execute("INSERT OR IGNORE INTO day_salt (day, salt) VALUES (?1, ?2)", params![today, fresh.as_slice()])?;
		let salt: Vec<u8> = tx.query_row("SELECT salt FROM day_salt WHERE day = ?1", [today], |r| r.get(0))?;
		tx.commit()?;
		Ok(salt.try_into().unwrap_or(fresh))
	}

	/// Registrations from `network` (today's HMAC of it) on day `today`.
	pub fn registrations(&self, today: i64, network: &str) -> rusqlite::Result<u32> {
		Ok(self.conn.query_row("SELECT n FROM registrations WHERE day = ?1 AND network = ?2", params![today, network], |r| r.get(0)).optional()?.unwrap_or(0))
	}

	/// Spends `challenge` (valid until `expires`) and creates the contributor `hash`, unless
	/// `network` already registered `cap` contributors today. The network's first registration
	/// of the day makes its cohort from `fresh_cohort`; later ones join it.
	#[allow(clippy::too_many_arguments)]
	pub fn register(&mut self, hash: &str, challenge: &str, expires: i64, now: i64, network: &str, fresh_cohort: &str, cap: u32) -> rusqlite::Result<Registration> {
		let today = now.div_euclid(DAY);
		let tx = self.conn.transaction()?;
		let (n, cohort): (u32, Option<String>) = tx
			.query_row("SELECT n, cohort FROM registrations WHERE day = ?1 AND network = ?2", params![today, network], |r| Ok((r.get(0)?, r.get(1)?)))
			.optional()?
			.map_or((0, None), |(n, c)| (n, Some(c)));
		if n >= cap {
			return Ok(Registration::OverCap);
		}
		tx.execute("DELETE FROM spent_challenges WHERE expires < ?1", [now])?;
		if tx.execute("INSERT OR IGNORE INTO spent_challenges (challenge, expires) VALUES (?1, ?2)", params![challenge, expires])? == 0 {
			return Ok(Registration::Spent);
		}
		let cohort = cohort.unwrap_or_else(|| fresh_cohort.to_owned());
		tx.execute("INSERT INTO registrations (day, network, n, cohort) VALUES (?1, ?2, 1, ?3) ON CONFLICT (day, network) DO UPDATE SET n = n + 1", params![today, network, cohort])?;
		tx.execute("INSERT INTO contributors (hash, first_seen, last_seen, bytes_today, day, cohort) VALUES (?1, ?2, ?2, 0, ?3, ?4)", params![hash, now, today, cohort])?;
		tx.commit()?;
		Ok(Registration::Done(cohort))
	}

	/// The contributor's bytes today and the install's highest stored chunk; None when there is
	/// no such contributor.
	pub fn install_context(&self, contributor: &str, install: &str, now: i64) -> rusqlite::Result<Option<InstallContext>> {
		let row: Option<(i64, i64)> = self.conn.query_row("SELECT bytes_today, day FROM contributors WHERE hash = ?1", [contributor], |r| Ok((r.get(0)?, r.get(1)?))).optional()?;
		let Some((bytes, day)) = row else { return Ok(None) };
		let used_today = if day == now.div_euclid(DAY) { bytes.max(0) as u64 } else { 0 };
		let highest =
			self.conn.query_row("SELECT seq, epoch FROM installs WHERE contributor = ?1 AND install = ?2", [contributor, install], |r| Ok((r.get::<_, i64>(0)? as u64, r.get(1)?))).optional()?;
		Ok(Some(InstallContext { used_today, highest }))
	}

	/// Stores an upload's chunks in one transaction, unless it would take the contributor past
	/// `daily_cap` bytes today. A blocked contributor's chunks are stored like anyone's (so the
	/// answers are the same); the export and the stats leave them out.
	pub fn upload(&mut self, upload: Upload, prepared: Vec<Prepared>, daily_cap: u64) -> rusqlite::Result<UploadOutcome> {
		let Upload { contributor, install, uploader, body_len, now } = upload;
		let today = now.div_euclid(DAY);
		let tx = self.conn.transaction()?;
		let row: Option<(i64, i64)> = tx.query_row("SELECT bytes_today, day FROM contributors WHERE hash = ?1", [contributor], |r| Ok((r.get(0)?, r.get(1)?))).optional()?;
		let Some((bytes, day)) = row else { return Ok(UploadOutcome::Unknown) };
		let used = if day == today { bytes.max(0) as u64 } else { 0 };
		if used.saturating_add(body_len) > daily_cap {
			return Ok(UploadOutcome::OverDailyCap);
		}
		tx.execute("UPDATE contributors SET last_seen = ?2, bytes_today = ?3, day = ?4 WHERE hash = ?1", params![contributor, now, (used + body_len) as i64, today])?;

		let mut response = UploadResponse { accepted: Vec::new(), duplicate: Vec::new(), rejected: Vec::new() };
		{
			let mut seen = tx.prepare("INSERT OR IGNORE INTO seqs (contributor, install, seq) VALUES (?1, ?2, ?3)")?;
			let mut insert_chunk = tx.prepare(
				"INSERT INTO chunks (contributor, install, seq, received, build, locale, uploader, text, flagged, epoch, suspect, reasons)
				 VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12)",
			)?;
			let mut total = tx.prepare(
				"INSERT INTO totals (contributor, chunks, plausible, bytes, first_upload, last_upload) VALUES (?1, 1, ?2, ?3, ?4, ?4)
				 ON CONFLICT (contributor) DO UPDATE SET chunks = chunks + 1, plausible = plausible + ?2, bytes = bytes + ?3, last_upload = ?4",
			)?;
			let mut kind = tx.prepare("INSERT INTO kinds (contributor, kind, n) VALUES (?1, ?2, ?3) ON CONFLICT (contributor, kind) DO UPDATE SET n = n + ?3")?;
			let mut quest = tx.prepare("INSERT OR IGNORE INTO quests (contributor, quest) VALUES (?1, ?2)")?;
			let mut day_count = tx.prepare("INSERT INTO days (contributor, day, chunks) VALUES (?1, ?2, 1) ON CONFLICT (contributor, day) DO UPDATE SET chunks = chunks + 1")?;
			let mut highest = tx.prepare(
				"INSERT INTO installs (contributor, install, seq, epoch) VALUES (?1, ?2, ?3, ?4)
				 ON CONFLICT (contributor, install) DO UPDATE SET seq = ?3, epoch = ?4 WHERE ?3 > seq",
			)?;
			for p in prepared {
				let chunk = match p {
					Prepared::Rejected(r) => {
						response.rejected.push(r);
						continue;
					}
					Prepared::Ok(chunk) => chunk,
				};
				// Also when its chunk was pruned since.
				if seen.execute(params![contributor, install, chunk.seq as i64])? == 0 {
					response.duplicate.push(chunk.seq);
					continue;
				}
				let reasons = (!chunk.suspect.is_empty()).then(|| chunk.suspect.join("\n"));
				insert_chunk.execute(params![contributor, install, chunk.seq as i64, now, chunk.build, chunk.locale, uploader, chunk.ztext, chunk.flagged, chunk.epoch, reasons.is_some(), reasons])?;
				total.execute(params![contributor, reasons.is_none(), chunk.text_len as i64, now])?;
				for (k, n) in &chunk.kinds {
					kind.execute(params![contributor, k, *n as i64])?;
				}
				for q in &chunk.quests {
					quest.execute(params![contributor, q])?;
				}
				day_count.execute(params![contributor, today])?;
				highest.execute(params![contributor, install, chunk.seq as i64, chunk.epoch])?;
				response.accepted.push(chunk.seq);
			}
		}
		tx.commit()?;
		Ok(UploadOutcome::Done(response))
	}

	/// Everything the server received from one contributor, as counts (pruned chunks included).
	pub fn me(&self, contributor: &str) -> rusqlite::Result<MeResponse> {
		let (chunks, first, last): (i64, Option<i64>, Option<i64>) = self
			.conn
			.query_row("SELECT chunks, first_upload, last_upload FROM totals WHERE contributor = ?1", [contributor], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?)))
			.optional()?
			.unwrap_or((0, None, None));
		let mut stmt = self.conn.prepare("SELECT kind, n FROM kinds WHERE contributor = ?1")?;
		let records = stmt.query_map([contributor], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)? as u64)))?.collect::<rusqlite::Result<BTreeMap<_, _>>>()?;
		Ok(MeResponse { chunks: chunks as u64, records, first_upload: first, last_upload: last })
	}

	/// Deletes every chunk, count and the contributor row, leaving a tombstone; returns how many
	/// chunks it had sent.
	pub fn delete_contributor(&mut self, contributor: &str, now: i64) -> rusqlite::Result<u64> {
		let tx = self.conn.transaction()?;
		let n: i64 = tx.query_row("SELECT chunks FROM totals WHERE contributor = ?1", [contributor], |r| r.get(0)).optional()?.unwrap_or(0);
		for table in PER_CONTRIBUTOR {
			tx.execute(&format!("DELETE FROM {table} WHERE contributor = ?1"), [contributor])?;
		}
		tx.execute("DELETE FROM contributors WHERE hash = ?1", [contributor])?;
		tx.execute("INSERT INTO tombstones (contributor, at, why) VALUES (substr(?1, 1, 16), ?2, 'deleted')", params![contributor, now])?;
		tx.commit()?;
		Ok(n as u64)
	}

	/// Public totals, blocked contributors left out. `last30` covers the 30 UTC days ending
	/// today, days without chunks left out.
	pub fn stats(&self, now: i64) -> rusqlite::Result<Stats> {
		const OPEN: &str = "contributor NOT IN (SELECT hash FROM contributors WHERE blocked = 1)";
		let (contributors, chunks): (i64, i64) =
			self.conn.query_row(&format!("SELECT COUNT(*), COALESCE(SUM(chunks), 0) FROM totals WHERE chunks > 0 AND {OPEN}"), [], |r| Ok((r.get(0)?, r.get(1)?)))?;
		let mut stmt = self.conn.prepare(&format!("SELECT kind, SUM(n) FROM kinds WHERE {OPEN} GROUP BY kind"))?;
		let records = stmt.query_map([], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)? as u64)))?.collect::<rusqlite::Result<BTreeMap<_, _>>>()?;
		let quests: i64 = self.conn.query_row(&format!("SELECT COUNT(DISTINCT quest) FROM quests WHERE {OPEN}"), [], |r| r.get(0))?;
		let since = now.div_euclid(DAY) - (STATS_DAYS - 1);
		let mut stmt = self.conn.prepare(&format!("SELECT day, SUM(chunks), COUNT(*) FROM days WHERE day >= ?1 AND {OPEN} GROUP BY day ORDER BY day"))?;
		let last30 = stmt
			.query_map([since], |r| Ok(StatsDay { day: civil_date(r.get(0)?), chunks: r.get::<_, i64>(1)? as u64, contributors: r.get::<_, i64>(2)? as u64 }))?
			.collect::<rusqlite::Result<Vec<_>>>()?;
		Ok(Stats { contributors: contributors as u64, chunks: chunks as u64, records, quests: quests as u64, last30 })
	}

	/// Chunks with `id > after`, oldest first, at most `limit` and (after the first) at most
	/// [`EXPORT_MAX_BYTES`] of text. Blocked contributors' chunks are left out, and suspect ones
	/// unless `suspect`.
	pub fn export(&self, after: i64, limit: u32, suspect: bool) -> rusqlite::Result<Vec<ExportLine>> {
		let mut stmt = self.conn.prepare(
			"SELECT ch.id, ch.contributor, ch.install, ch.seq, ch.received, ch.text, ch.flagged, ch.suspect, ch.reasons, co.first_seen,
				COALESCE(co.cohort, substr(co.hash, 1, 16)), COALESCE(t.plausible, 0)
			 FROM chunks ch JOIN contributors co ON co.hash = ch.contributor LEFT JOIN totals t ON t.contributor = ch.contributor
			 WHERE ch.id > ?1 AND co.blocked = 0 AND (?3 OR ch.suspect = 0)
			 ORDER BY ch.id LIMIT ?2",
		)?;
		let rows = stmt.query_map(params![after, limit, suspect], |r| {
			let reasons: Option<String> = r.get(8)?;
			let contributor: String = r.get(1)?;
			Ok(ExportLine {
				id: r.get(0)?,
				contributor: contributor.chars().take(16).collect(),
				cohort: r.get(10)?,
				install: r.get(2)?,
				seq: r.get::<_, i64>(3)? as u64,
				received: r.get(4)?,
				text: stored_text(r.get_ref(5)?)?,
				flagged: r.get(6)?,
				contributor_since: r.get(9)?,
				contributor_chunks: r.get::<_, i64>(11)? as u64,
				suspect: r.get(7)?,
				suspect_reasons: reasons.map(|s| s.lines().map(str::to_owned).collect()).unwrap_or_default(),
			})
		})?;
		let mut bytes = 0;
		let mut page = Vec::new();
		for row in rows {
			let row = row?;
			bytes += row.text.len();
			if bytes > EXPORT_MAX_BYTES && !page.is_empty() {
				break;
			}
			page.push(row);
		}
		Ok(page)
	}

	/// Records that the maintainer has stored every export line up to `upto` (clamped to the
	/// highest chunk id there is); returns the acknowledged id.
	pub fn ack(&mut self, upto: i64) -> rusqlite::Result<i64> {
		let tx = self.conn.transaction()?;
		let highest: i64 = tx.query_row("SELECT COALESCE(MAX(seq), 0) FROM sqlite_sequence WHERE name = 'chunks'", [], |r| r.get(0)).optional()?.unwrap_or(0);
		let acked = upto.clamp(0, highest);
		tx.execute("INSERT INTO settings (key, value) VALUES ('acked', ?1) ON CONFLICT (key) DO UPDATE SET value = MAX(value, ?1)", [acked])?;
		let acked: i64 = tx.query_row("SELECT value FROM settings WHERE key = 'acked'", [], |r| r.get(0))?;
		tx.commit()?;
		Ok(acked)
	}

	/// Deletes up to [`PRUNE_BATCH`] chunks that are acknowledged and were received before
	/// `before` (unix seconds); returns how many went.
	pub fn prune_batch(&mut self, before: i64) -> rusqlite::Result<usize> {
		let acked: i64 = self.conn.query_row("SELECT value FROM settings WHERE key = 'acked'", [], |r| r.get(0)).optional()?.unwrap_or(0);
		self.conn.execute("DELETE FROM chunks WHERE id IN (SELECT id FROM chunks WHERE id <= ?1 AND received < ?2 ORDER BY id LIMIT ?3)", params![acked, before, PRUNE_BATCH as i64])
	}

	/// Housekeeping after pruning: expired challenges, salts and old per-day counts deleted, seqs
	/// far below their install's highest forgotten once their chunk is gone, free pages given back
	/// and the WAL truncated.
	pub fn housekeeping(&mut self, now: i64) -> rusqlite::Result<()> {
		let today = now.div_euclid(DAY);
		let tx = self.conn.transaction()?;
		tx.execute("DELETE FROM spent_challenges WHERE expires < ?1", [now])?;
		tx.execute("DELETE FROM day_salt WHERE day < ?1", [today])?;
		tx.execute("DELETE FROM registrations WHERE day < ?1", [today])?;
		tx.execute("DELETE FROM days WHERE day < ?1", [today - STATS_DAYS])?;
		tx.execute(
			"DELETE FROM seqs WHERE seq < (SELECT i.seq FROM installs i WHERE i.contributor = seqs.contributor AND i.install = seqs.install) - ?1
				AND NOT EXISTS (SELECT 1 FROM chunks c WHERE c.contributor = seqs.contributor AND c.install = seqs.install AND c.seq = seqs.seq)",
			[SEQ_MEMORY],
		)?;
		tx.commit()?;
		self.conn.execute_batch("PRAGMA incremental_vacuum;")?;
		self.conn.query_row("PRAGMA wal_checkpoint(TRUNCATE)", [], |_| Ok(()))
	}

	/// Chunks held now (not pruned).
	pub fn chunks_held(&self) -> rusqlite::Result<u64> {
		Ok(self.conn.query_row("SELECT COUNT(*) FROM chunks", [], |r| r.get::<_, i64>(0))? as u64)
	}

	/// Every contributor with its chunk counts (pruned chunks included), oldest first.
	pub fn contributors(&self) -> rusqlite::Result<Vec<AdminContributor>> {
		let mut stmt = self.conn.prepare(
			"SELECT co.hash, co.first_seen, co.last_seen, co.blocked, COALESCE(t.chunks, 0), COALESCE(t.chunks - t.plausible, 0)
			 FROM contributors co LEFT JOIN totals t ON t.contributor = co.hash
			 ORDER BY co.first_seen, co.hash",
		)?;
		let rows = stmt.query_map([], |r| {
			Ok(AdminContributor { hash: r.get(0)?, first_seen: r.get(1)?, last_seen: r.get(2)?, blocked: r.get(3)?, chunks: r.get::<_, i64>(4)? as u64, suspect_chunks: r.get::<_, i64>(5)? as u64 })
		})?;
		rows.collect()
	}

	/// Tombstones recorded after `after` (unix seconds), oldest first.
	pub fn tombstones(&self, after: i64) -> rusqlite::Result<Vec<Tombstone>> {
		let mut stmt = self.conn.prepare("SELECT contributor, at, why FROM tombstones WHERE at > ?1 ORDER BY at, rowid")?;
		let rows = stmt.query_map([after], |r| Ok(Tombstone { contributor: r.get(0)?, at: r.get(1)?, why: r.get(2)? }))?;
		rows.collect()
	}

	/// Blocks or unblocks the one contributor whose hash starts with `prefix` (lowercase hex). A
	/// block leaves a tombstone.
	pub fn set_blocked(&mut self, prefix: &str, blocked: bool, now: i64) -> rusqlite::Result<Moderation> {
		let mut stmt = self.conn.prepare("SELECT hash FROM contributors WHERE substr(hash, 1, length(?1)) = ?1 LIMIT 2")?;
		let hashes = stmt.query_map([prefix], |r| r.get::<_, String>(0))?.collect::<rusqlite::Result<Vec<_>>>()?;
		drop(stmt);
		match hashes.as_slice() {
			[] => Ok(Moderation::NotFound),
			[hash] => {
				let tx = self.conn.transaction()?;
				if tx.execute("UPDATE contributors SET blocked = ?2 WHERE hash = ?1 AND blocked != ?2", params![hash, blocked])? > 0 {
					if blocked {
						tx.execute("INSERT INTO tombstones (contributor, at, why) VALUES (substr(?1, 1, 16), ?2, 'blocked')", params![hash, now])?;
					} else {
						// Unblocked: a fresh pull must not purge it again. `deleted` ones stay.
						tx.execute("DELETE FROM tombstones WHERE contributor = substr(?1, 1, 16) AND why = 'blocked'", [hash])?;
					}
				}
				tx.commit()?;
				Ok(Moderation::Done(hash.clone()))
			}
			_ => Ok(Moderation::Ambiguous),
		}
	}
}

/// `YYYY-MM-DD` of a day number since 1970-01-01 (proleptic Gregorian, H. Hinnant's civil_from_days).
pub fn civil_date(days: i64) -> String {
	let z = days + 719_468;
	let era = z.div_euclid(146_097);
	let doe = z - era * 146_097;
	let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = yoe + era * 400 + i64::from(m <= 2);
	format!("{y:04}-{m:02}-{d:02}")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn civil_dates() {
		assert_eq!(civil_date(0), "1970-01-01");
		assert_eq!(civil_date(11_016), "2000-02-29");
		assert_eq!(civil_date(20_753), "2026-10-27");
	}

	#[test]
	fn adds_new_columns_to_an_old_database() {
		let conn = Connection::open_in_memory().unwrap();
		conn.execute_batch(
			"CREATE TABLE contributors (hash TEXT PRIMARY KEY, first_seen INTEGER NOT NULL, last_seen INTEGER NOT NULL, bytes_today INTEGER NOT NULL DEFAULT 0, day INTEGER NOT NULL);
			 CREATE TABLE chunks (id INTEGER PRIMARY KEY AUTOINCREMENT, contributor TEXT NOT NULL, install TEXT NOT NULL, seq INTEGER NOT NULL, received INTEGER NOT NULL,
				build INTEGER, locale TEXT, uploader TEXT NOT NULL, text TEXT NOT NULL, flagged INTEGER NOT NULL DEFAULT 0, UNIQUE (contributor, install, seq));
			 INSERT INTO contributors VALUES ('abc', 1, 2, 0, 0);
			 INSERT INTO chunks (contributor, install, seq, received, uploader, text) VALUES ('abc', 'i', 1, 5, 'u', 't');",
		)
		.unwrap();
		let db = Db::init(conn).unwrap();
		assert_eq!(db.contributor("abc").unwrap(), Some(false));
		assert_eq!(db.install_context("abc", "i", 0).unwrap().unwrap().highest, Some((1, 0)));
		let line = &db.export(0, 10, false).unwrap()[0];
		assert_eq!((line.contributor_chunks, line.cohort.as_str(), line.text.as_str()), (1, "abc", "t"));
		// Migrated: compressed, counted, incremental.
		let kind: String = db.conn.query_row("SELECT typeof(text) FROM chunks", [], |r| r.get(0)).unwrap();
		assert_eq!(kind, "blob");
		assert_eq!(db.me("abc").unwrap().chunks, 1);
		let auto_vacuum: i64 = db.conn.pragma_query_value(None, "auto_vacuum", |r| r.get(0)).unwrap();
		assert_eq!(auto_vacuum, 2);
	}

	#[test]
	fn text_round_trips_compressed() {
		let text = "chunk\t0\t1\t1793000000\tabcdefghij\n".repeat(200);
		let z = compress(&text);
		assert!(z.len() * 10 < text.len(), "{} -> {}", text.len(), z.len());
		assert_eq!(stored_text(ValueRef::Blob(&z)).unwrap(), text);
		assert_eq!(stored_text(ValueRef::Text(b"plain")).unwrap(), "plain");
	}
}
