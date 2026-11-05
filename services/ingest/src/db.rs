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
//! itself is never stored. No IP address is ever written here. A contributor's cohort is a
//! keyed hash of its network under a monthly key derived from the server secret, so the
//! database alone does not reveal the network. The registration cap needs to recognise a network
//! for one UTC day: it keeps only an HMAC of it under that day's random salt, and the salt and
//! those HMACs are deleted when the day is over (and left out of backups).
//!
//! Rows per contributor are bounded: at most [`MAX_QUESTS`] quest rows, [`MAX_INSTALLS`]
//! installs (each with about [`SEQ_MEMORY`] seqs), 30 days of per-day counts and one row per
//! record kind. Suspect chunks add no quest or day rows. A blocked contributor's chunks, quests
//! and days are deleted; from then on only its seqs, installs, kinds and totals are kept, so the
//! server answers it exactly as before.

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
CREATE TABLE IF NOT EXISTS quest_counts (
	quest INTEGER PRIMARY KEY,
	n INTEGER NOT NULL
);
DROP TABLE IF EXISTS install_maps;
";

/// Columns added after the first deployment: (table, column, declaration).
const ADDED_COLUMNS: [(&str, &str, &str); 7] = [
	("contributors", "blocked", "INTEGER NOT NULL DEFAULT 0"),
	("contributors", "cohort", "TEXT"),
	("chunks", "epoch", "INTEGER"),
	("chunks", "suspect", "INTEGER NOT NULL DEFAULT 0"),
	("chunks", "reasons", "TEXT"),
	("totals", "upload_days", "INTEGER NOT NULL DEFAULT 0"),
	("totals", "quests", "INTEGER NOT NULL DEFAULT 0"),
];

/// `PRAGMA user_version` of this schema: 2 has compressed text and the counter tables, 3 the
/// bounded per-contributor rows, running totals and registrations without cohorts.
const VERSION: i64 = 3;

/// Quest rows kept per contributor (for `/v1/stats` `quests`).
pub const MAX_QUESTS: i64 = 5000;
/// Installs one contributor may upload from; chunks from more are rejected.
pub const MAX_INSTALLS: i64 = 8;
/// Rows rewritten per statement while migrating chunk text.
const MIGRATE_BATCH: i64 = 500;

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
	/// The contributor's cohort's bytes for today would pass the cohort's daily cap; nothing
	/// was stored.
	OverCohortCap,
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

/// [`Db::storage`].
#[derive(Debug)]
pub struct Storage {
	pub db_bytes: u64,
	pub acked: i64,
	pub oldest_unacked_age: Option<i64>,
	pub oldest_age: Option<i64>,
	pub rows: BTreeMap<&'static str, u64>,
}

/// The tables keyed by contributor that go with it on delete.
const PER_CONTRIBUTOR: [&str; 6] = ["chunks", "totals", "kinds", "days", "installs", "seqs"];

/// A counter in `settings`, by `delta`.
fn bump(tx: &Connection, key: &str, delta: i64) -> rusqlite::Result<()> {
	if delta != 0 {
		tx.execute("INSERT INTO settings (key, value) VALUES (?1, ?2) ON CONFLICT (key) DO UPDATE SET value = value + ?2", params![key, delta])?;
	}
	Ok(())
}

/// Deletes a contributor's quest rows, keeping `quest_counts` and the distinct-quest total right.
fn drop_quests(tx: &Connection, contributor: &str) -> rusqlite::Result<()> {
	tx.execute("UPDATE quest_counts SET n = n - 1 WHERE quest IN (SELECT quest FROM quests WHERE contributor = ?1)", [contributor])?;
	let gone = tx.execute("DELETE FROM quest_counts WHERE n <= 0", [])?;
	bump(tx, "quests", -(gone as i64))?;
	tx.execute("DELETE FROM quests WHERE contributor = ?1", [contributor])?;
	tx.execute("UPDATE totals SET quests = 0 WHERE contributor = ?1", [contributor])?;
	Ok(())
}

/// What a block deletes: the chunks held and the rows that only the stats and the export use.
fn drop_held(tx: &Connection, contributor: &str) -> rusqlite::Result<()> {
	tx.execute("DELETE FROM chunks WHERE contributor = ?1", [contributor])?;
	tx.execute("DELETE FROM days WHERE contributor = ?1", [contributor])?;
	drop_quests(tx, contributor)
}

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
		// Deleted chunks, salts and contributors are overwritten, not left in free pages.
		conn.pragma_update(None, "secure_delete", "ON")?;
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
		if version < 2 {
			db.migrate_to_2()?;
		}
		if version < 3 {
			db.migrate_to_3()?;
		}
		// The database's id, made once (a restored backup has none, so it gets a new one).
		let mut id = [0u8; 8];
		getrandom::fill(&mut id).map_err(|e| rusqlite::Error::ToSqlConversionFailure(e.to_string().into()))?;
		db.conn.execute("INSERT OR IGNORE INTO settings (key, value) VALUES ('instance', ?1)", [i64::from_be_bytes(id)])?;
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
			// In batches, so a large old database is never held in memory at once.
			let mut read = tx.prepare("SELECT id, text FROM chunks WHERE id > ?1 AND typeof(text) = 'text' ORDER BY id LIMIT ?2")?;
			let mut write = tx.prepare("UPDATE chunks SET text = ?2 WHERE id = ?1")?;
			let mut after = i64::MIN;
			loop {
				let rows = read.query_map(params![after, MIGRATE_BATCH], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?)))?.collect::<rusqlite::Result<Vec<_>>>()?;
				let Some(&(last, _)) = rows.last() else { break };
				for (id, text) in rows {
					write.execute(params![id, compress(&text)])?;
				}
				after = last;
			}
		}
		tx.pragma_update(None, "user_version", 2)?;
		tx.commit()
	}

	/// Version 3: registrations without cohorts, quest rows within their caps, blocked
	/// contributors' held rows deleted, and the running totals filled.
	fn migrate_to_3(&mut self) -> rusqlite::Result<()> {
		let tx = self.conn.transaction()?;
		tx.execute_batch(&format!(
			"DROP TABLE registrations;
			 CREATE TABLE registrations (day INTEGER NOT NULL, network TEXT NOT NULL, n INTEGER NOT NULL, PRIMARY KEY (day, network)) WITHOUT ROWID;
			 DELETE FROM quests WHERE quest >= {max_id};
			 DELETE FROM quests WHERE (contributor, quest) IN
				(SELECT contributor, quest FROM (SELECT contributor, quest, ROW_NUMBER() OVER (PARTITION BY contributor ORDER BY quest) AS rn FROM quests) WHERE rn > {MAX_QUESTS});
			 DELETE FROM chunks WHERE contributor IN (SELECT hash FROM contributors WHERE blocked = 1);
			 DELETE FROM quests WHERE contributor IN (SELECT hash FROM contributors WHERE blocked = 1);
			 DELETE FROM days WHERE contributor IN (SELECT hash FROM contributors WHERE blocked = 1);
			 UPDATE totals SET upload_days = (SELECT COUNT(*) FROM days d WHERE d.contributor = totals.contributor),
				quests = (SELECT COUNT(*) FROM quests q WHERE q.contributor = totals.contributor);
			 DELETE FROM quest_counts;
			 INSERT INTO quest_counts (quest, n) SELECT quest, COUNT(*) FROM quests GROUP BY quest;
			 INSERT OR REPLACE INTO settings (key, value) SELECT 'quests', COUNT(*) FROM quest_counts;",
			max_id = polestar_recording::plausible::MAX_ID,
		))?;
		tx.pragma_update(None, "user_version", VERSION)?;
		tx.commit()
	}

	/// The database's id ([`ExportLine::instance`]), 16 hex digits.
	pub fn instance(&self) -> rusqlite::Result<String> {
		let id: i64 = self.conn.query_row("SELECT value FROM settings WHERE key = 'instance'", [], |r| r.get(0))?;
		Ok(format!("{:016x}", id as u64))
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

	/// Spends `challenge` (valid until `expires`) and creates the contributor `hash` in `cohort`,
	/// unless one of `networks` (today's HMAC of a network, with its cap) already registered its
	/// cap of contributors today. Each network's count goes up by one.
	#[allow(clippy::too_many_arguments)]
	pub fn register(&mut self, hash: &str, challenge: &str, expires: i64, now: i64, networks: &[(&str, u32)], cohort: &str) -> rusqlite::Result<Registration> {
		let today = now.div_euclid(DAY);
		let tx = self.conn.transaction()?;
		for &(network, cap) in networks {
			let n: u32 = tx.query_row("SELECT n FROM registrations WHERE day = ?1 AND network = ?2", params![today, network], |r| r.get(0)).optional()?.unwrap_or(0);
			if n >= cap {
				return Ok(Registration::OverCap);
			}
		}
		tx.execute("DELETE FROM spent_challenges WHERE expires < ?1", [now])?;
		if tx.execute("INSERT OR IGNORE INTO spent_challenges (challenge, expires) VALUES (?1, ?2)", params![challenge, expires])? == 0 {
			return Ok(Registration::Spent);
		}
		for &(network, _) in networks {
			tx.execute("INSERT INTO registrations (day, network, n) VALUES (?1, ?2, 1) ON CONFLICT (day, network) DO UPDATE SET n = n + 1", params![today, network])?;
		}
		tx.execute("INSERT INTO contributors (hash, first_seen, last_seen, bytes_today, day, cohort) VALUES (?1, ?2, ?2, 0, ?3, ?4)", params![hash, now, today, cohort])?;
		tx.commit()?;
		Ok(Registration::Done(cohort.to_owned()))
	}

	/// Counts `bytes` against the contributor's daily cap without storing anything (a body that
	/// never arrived in time).
	pub fn charge(&mut self, contributor: &str, bytes: u64, now: i64) -> rusqlite::Result<()> {
		let today = now.div_euclid(DAY);
		self.conn.execute(
			"UPDATE contributors SET bytes_today = (CASE WHEN day = ?3 THEN bytes_today ELSE 0 END) + ?2, day = ?3 WHERE hash = ?1",
			params![contributor, bytes.min(i64::MAX as u64) as i64, today],
		)?;
		Ok(())
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
	/// `daily_cap` bytes today, or its cohort (every contributor registered from its network
	/// this month) past `cohort_cap`. A blocked contributor gets the same answers as anyone, but
	/// only its seqs, installs, kinds and totals are kept. Suspect chunks add no quest or day
	/// rows. Chunks from an install beyond the contributor's [`MAX_INSTALLS`] are rejected.
	pub fn upload(&mut self, upload: Upload, prepared: Vec<Prepared>, daily_cap: u64, cohort_cap: u64) -> rusqlite::Result<UploadOutcome> {
		let Upload { contributor, install, uploader, body_len, now } = upload;
		let today = now.div_euclid(DAY);
		let tx = self.conn.transaction()?;
		let row: Option<(i64, i64, bool, Option<String>)> =
			tx.query_row("SELECT bytes_today, day, blocked, cohort FROM contributors WHERE hash = ?1", [contributor], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?, r.get(3)?))).optional()?;
		let Some((bytes, day, blocked, cohort)) = row else { return Ok(UploadOutcome::Unknown) };
		let used = if day == today { bytes.max(0) as u64 } else { 0 };
		if used.saturating_add(body_len) > daily_cap {
			return Ok(UploadOutcome::OverDailyCap);
		}
		if let Some(cohort) = cohort {
			let others: i64 = tx.query_row(
				"SELECT COALESCE(SUM(bytes_today), 0) FROM contributors WHERE cohort = ?1 AND day = ?2 AND hash != ?3",
				params![cohort, today, contributor],
				|r| r.get(0),
			)?;
			if (others.max(0) as u64).saturating_add(used).saturating_add(body_len) > cohort_cap {
				return Ok(UploadOutcome::OverCohortCap);
			}
		}
		tx.execute("UPDATE contributors SET last_seen = ?2, bytes_today = ?3, day = ?4 WHERE hash = ?1", params![contributor, now, (used + body_len) as i64, today])?;

		let mut response = UploadResponse { accepted: Vec::new(), duplicate: Vec::new(), rejected: Vec::new() };
		let known_install: bool = tx.query_row("SELECT COUNT(*) > 0 FROM installs WHERE contributor = ?1 AND install = ?2", [contributor, install], |r| r.get(0))?;
		let installs: i64 = tx.query_row("SELECT COUNT(*) FROM installs WHERE contributor = ?1", [contributor], |r| r.get(0))?;
		if !known_install && installs >= MAX_INSTALLS {
			for p in prepared {
				response.rejected.push(match p {
					Prepared::Rejected(r) => r,
					Prepared::Ok(chunk) => Rejected { seq: chunk.seq, reason: format!("more than {MAX_INSTALLS} installs sent with this token") },
				});
			}
			tx.commit()?;
			return Ok(UploadOutcome::Done(response));
		}
		let mut quest_room = MAX_QUESTS - tx.query_row("SELECT quests FROM totals WHERE contributor = ?1", [contributor], |r| r.get::<_, i64>(0)).optional()?.unwrap_or(0);
		let (mut quests_added, mut quests_new, mut new_days) = (0i64, 0i64, 0i64);
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
			let mut quest_first = tx.prepare("INSERT OR IGNORE INTO quest_counts (quest, n) VALUES (?1, 0)")?;
			let mut quest_count = tx.prepare("UPDATE quest_counts SET n = n + 1 WHERE quest = ?1")?;
			let mut day_first = tx.prepare("INSERT OR IGNORE INTO days (contributor, day, chunks) VALUES (?1, ?2, 0)")?;
			let mut day_count = tx.prepare("UPDATE days SET chunks = chunks + 1 WHERE contributor = ?1 AND day = ?2")?;
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
				if !blocked {
					insert_chunk.execute(params![
						contributor,
						install,
						chunk.seq as i64,
						now,
						chunk.build,
						chunk.locale,
						uploader,
						chunk.ztext,
						chunk.flagged,
						chunk.epoch,
						reasons.is_some(),
						reasons
					])?;
				}
				total.execute(params![contributor, reasons.is_none(), chunk.text_len as i64, now])?;
				for (k, n) in &chunk.kinds {
					kind.execute(params![contributor, k, *n as i64])?;
				}
				if !blocked && reasons.is_none() {
					for q in &chunk.quests {
						if quest_room <= 0 {
							break;
						}
						if quest.execute(params![contributor, q])? > 0 {
							quest_room -= 1;
							quests_added += 1;
							quests_new += quest_first.execute([q])? as i64;
							quest_count.execute([q])?;
						}
					}
					new_days += day_first.execute(params![contributor, today])? as i64;
					day_count.execute(params![contributor, today])?;
				}
				highest.execute(params![contributor, install, chunk.seq as i64, chunk.epoch])?;
				response.accepted.push(chunk.seq);
			}
		}
		tx.execute("UPDATE totals SET quests = quests + ?2, upload_days = upload_days + ?3 WHERE contributor = ?1", params![contributor, quests_added, new_days])?;
		bump(&tx, "quests", quests_new)?;
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

	/// Deletes every chunk, count and the contributor row, leaving a `deleted` tombstone;
	/// returns how many chunks it had sent.
	pub fn delete_contributor(&mut self, contributor: &str, now: i64) -> rusqlite::Result<u64> {
		let tx = self.conn.transaction()?;
		let n: i64 = tx.query_row("SELECT chunks FROM totals WHERE contributor = ?1", [contributor], |r| r.get(0)).optional()?.unwrap_or(0);
		drop_quests(&tx, contributor)?;
		for table in PER_CONTRIBUTOR {
			tx.execute(&format!("DELETE FROM {table} WHERE contributor = ?1"), [contributor])?;
		}
		tx.execute("DELETE FROM contributors WHERE hash = ?1", [contributor])?;
		tx.execute("INSERT INTO tombstones (contributor, at, why) VALUES (substr(?1, 1, 16), ?2, 'deleted')", params![contributor, now])?;
		tx.commit()?;
		Ok(n as u64)
	}

	/// Public totals, blocked contributors left out. `last30` covers the 30 UTC days ending
	/// today, days without chunks left out. `quests` is a running total, not a count.
	pub fn stats(&self, now: i64) -> rusqlite::Result<Stats> {
		const OPEN: &str = "contributor NOT IN (SELECT hash FROM contributors WHERE blocked = 1)";
		let (contributors, chunks): (i64, i64) =
			self.conn.query_row(&format!("SELECT COUNT(*), COALESCE(SUM(chunks), 0) FROM totals WHERE chunks > 0 AND {OPEN}"), [], |r| Ok((r.get(0)?, r.get(1)?)))?;
		let mut stmt = self.conn.prepare(&format!("SELECT kind, SUM(n) FROM kinds WHERE {OPEN} GROUP BY kind"))?;
		let records = stmt.query_map([], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)? as u64)))?.collect::<rusqlite::Result<BTreeMap<_, _>>>()?;
		let quests: i64 = self.conn.query_row("SELECT value FROM settings WHERE key = 'quests'", [], |r| r.get(0)).optional()?.unwrap_or(0);
		let since = now.div_euclid(DAY) - (STATS_DAYS - 1);
		let mut stmt = self.conn.prepare("SELECT day, SUM(chunks), COUNT(*) FROM days WHERE day >= ?1 GROUP BY day ORDER BY day")?;
		let last30 = stmt
			.query_map([since], |r| Ok(StatsDay { day: civil_date(r.get(0)?), chunks: r.get::<_, i64>(1)? as u64, contributors: r.get::<_, i64>(2)? as u64 }))?
			.collect::<rusqlite::Result<Vec<_>>>()?;
		Ok(Stats { contributors: contributors as u64, chunks: chunks as u64, records, quests: quests.max(0) as u64, last30 })
	}

	/// Chunks with `id > after`, oldest first, at most `limit` and (after the first) at most
	/// [`EXPORT_MAX_BYTES`] of text. Blocked contributors' chunks are left out, and suspect ones
	/// unless `suspect`.
	pub fn export(&self, after: i64, limit: u32, suspect: bool) -> rusqlite::Result<Vec<ExportLine>> {
		let instance = self.instance()?;
		let mut stmt = self.conn.prepare(
			"SELECT ch.id, ch.contributor, ch.install, ch.seq, ch.received, ch.text, ch.flagged, ch.suspect, ch.reasons, co.first_seen,
				COALESCE(co.cohort, substr(co.hash, 1, 16)), COALESCE(t.plausible, 0), COALESCE(t.upload_days, 0)
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
				upload_days: r.get::<_, i64>(12)?.max(0) as u64,
				instance: instance.clone(),
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

	/// Size, the acknowledged id, the ages (seconds at `now`) of the oldest chunk not yet
	/// acknowledged and of the oldest held, and the row counts of the tables that grow.
	pub fn storage(&self, now: i64) -> rusqlite::Result<Storage> {
		let acked: i64 = self.conn.query_row("SELECT value FROM settings WHERE key = 'acked'", [], |r| r.get(0)).optional()?.unwrap_or(0);
		let (unacked, oldest): (Option<i64>, Option<i64>) =
			self.conn.query_row("SELECT MIN(CASE WHEN id > ?1 THEN received END), MIN(received) FROM chunks", [acked], |r| Ok((r.get(0)?, r.get(1)?)))?;
		let age = |t: Option<i64>| t.map(|t| (now - t).max(0));
		let (oldest_unacked_age, oldest_age) = (age(unacked), age(oldest));
		let mut rows = BTreeMap::new();
		for table in ["contributors", "chunks", "seqs", "installs", "kinds", "quests", "quest_counts", "days", "tombstones", "spent_challenges", "registrations"] {
			rows.insert(table, self.conn.query_row(&format!("SELECT COUNT(*) FROM {table}"), [], |r| r.get::<_, i64>(0))? as u64);
		}
		Ok(Storage { db_bytes: self.size_bytes()?, acked, oldest_unacked_age, oldest_age, rows })
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

	/// The one contributor whose hash starts with `prefix` (lowercase hex).
	fn find(&self, prefix: &str) -> rusqlite::Result<Result<String, Moderation>> {
		let mut stmt = self.conn.prepare("SELECT hash FROM contributors WHERE substr(hash, 1, length(?1)) = ?1 LIMIT 2")?;
		let mut hashes = stmt.query_map([prefix], |r| r.get::<_, String>(0))?.collect::<rusqlite::Result<Vec<_>>>()?;
		Ok(match hashes.len() {
			0 => Err(Moderation::NotFound),
			1 => Ok(hashes.remove(0)),
			_ => Err(Moderation::Ambiguous),
		})
	}

	/// Blocks or unblocks the one contributor whose hash starts with `prefix` (lowercase hex). A
	/// block leaves a tombstone and deletes the contributor's held chunks, quests and days
	/// ([`Db::upload`] keeps no more of them); an unblock does not bring them back.
	pub fn set_blocked(&mut self, prefix: &str, blocked: bool, now: i64) -> rusqlite::Result<Moderation> {
		let hash = match self.find(prefix)? {
			Ok(hash) => hash,
			Err(m) => return Ok(m),
		};
		let tx = self.conn.transaction()?;
		if tx.execute("UPDATE contributors SET blocked = ?2 WHERE hash = ?1 AND blocked != ?2", params![hash, blocked])? > 0 {
			if blocked {
				drop_held(&tx, &hash)?;
				tx.execute("INSERT INTO tombstones (contributor, at, why) VALUES (substr(?1, 1, 16), ?2, 'blocked')", params![hash, now])?;
			} else {
				// Unblocked: a fresh pull must not purge it again. `deleted` ones stay.
				tx.execute("DELETE FROM tombstones WHERE contributor = substr(?1, 1, 16) AND why = 'blocked'", [&hash])?;
			}
		}
		tx.commit()?;
		Ok(Moderation::Done(hash))
	}

	/// Deletes everything of the one contributor whose hash starts with `prefix`, counters
	/// included, as [`Db::delete_contributor`] (a `deleted` tombstone); its token is unknown
	/// from then on.
	pub fn purge(&mut self, prefix: &str, now: i64) -> rusqlite::Result<Moderation> {
		let hash = match self.find(prefix)? {
			Ok(hash) => hash,
			Err(m) => return Ok(m),
		};
		self.delete_contributor(&hash, now)?;
		Ok(Moderation::Done(hash))
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
		// More than one migration batch of plain text.
		for seq in 2..=(MIGRATE_BATCH * 2 + 7) {
			conn.execute("INSERT INTO chunks (contributor, install, seq, received, uploader, text) VALUES ('abc', 'i', ?1, 5, 'u', 'more')", [seq]).unwrap();
		}
		let db = Db::init(conn).unwrap();
		assert_eq!(db.contributor("abc").unwrap(), Some(false));
		assert_eq!(db.install_context("abc", "i", 0).unwrap().unwrap().highest, Some((MIGRATE_BATCH as u64 * 2 + 7, 0)));
		let line = &db.export(0, 10, false).unwrap()[0];
		assert_eq!((line.contributor_chunks, line.cohort.as_str(), line.text.as_str(), line.upload_days), (MIGRATE_BATCH as u64 * 2 + 7, "abc", "t", 1));
		assert_eq!(line.instance.len(), 16);
		let plain: i64 = db.conn.query_row("SELECT COUNT(*) FROM chunks WHERE typeof(text) != 'blob'", [], |r| r.get(0)).unwrap();
		assert_eq!(plain, 0, "every batch compressed");
		// Migrated: compressed, counted, incremental.
		let kind: String = db.conn.query_row("SELECT typeof(text) FROM chunks", [], |r| r.get(0)).unwrap();
		assert_eq!(kind, "blob");
		assert_eq!(db.me("abc").unwrap().chunks, MIGRATE_BATCH as u64 * 2 + 7);
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

	const NOW: i64 = 1_793_000_000;

	fn chunk(seq: u64, quests: impl IntoIterator<Item = u32>, suspect: bool) -> Prepared {
		let text = format!("chunk\t0\t{seq}\t{NOW}\tc0ffee1234\n");
		Prepared::Ok(Box::new(NewChunk {
			seq,
			epoch: NOW,
			ztext: compress(&text),
			text_len: text.len(),
			build: Some(70532),
			locale: None,
			flagged: false,
			suspect: if suspect { vec!["odd".to_owned()] } else { Vec::new() },
			kinds: BTreeMap::from([("accept".to_owned(), 1)]),
			quests: quests.into_iter().collect(),
		}))
	}

	fn db_with(contributors: &[&str]) -> Db {
		let mut db = Db::open_in_memory().unwrap();
		for (i, c) in contributors.iter().enumerate() {
			assert_eq!(db.register(c, &format!("ch{i}"), NOW + 600, NOW, &[(&format!("net{i}"), 3)], "0123456789abcdef").unwrap(), Registration::Done("0123456789abcdef".to_owned()));
		}
		db
	}

	fn send(db: &mut Db, contributor: &str, install: &str, now: i64, chunks: Vec<Prepared>) -> UploadResponse {
		match db.upload(Upload { contributor, install, uploader: "t", body_len: 10, now }, chunks, u64::MAX, u64::MAX).unwrap() {
			UploadOutcome::Done(r) => r,
			other => panic!("{other:?}"),
		}
	}

	fn count(db: &Db, sql: &str) -> i64 {
		db.conn.query_row(sql, [], |r| r.get(0)).unwrap()
	}

	#[test]
	fn a_cohort_shares_one_daily_byte_cap() {
		let mut db = db_with(&["a", "b", "c"]);
		db.conn.execute("UPDATE contributors SET cohort = 'other' WHERE hash = 'c'", []).unwrap();
		let up = |db: &mut Db, who: &str, now: i64| match db.upload(Upload { contributor: who, install: "i", uploader: "t", body_len: 10, now }, vec![], 100, 15).unwrap() {
			UploadOutcome::Done(_) => "done",
			UploadOutcome::OverCohortCap => "cohort",
			other => panic!("{other:?}"),
		};
		assert_eq!(up(&mut db, "a", NOW), "done");
		assert_eq!(up(&mut db, "b", NOW), "cohort", "a's bytes count against b, in the same cohort");
		assert_eq!(up(&mut db, "c", NOW), "done", "another cohort is unaffected");
		assert_eq!(up(&mut db, "b", NOW + DAY), "done", "a new day");
	}

	#[test]
	fn a_registration_counts_against_every_network_it_is_in() {
		let mut db = Db::open_in_memory().unwrap();
		let reg = |db: &mut Db, i: u32, nets: &[(&str, u32)]| db.register(&format!("h{i}"), &format!("ch{i}"), NOW + 600, NOW, nets, "c").unwrap();
		assert!(matches!(reg(&mut db, 0, &[("a48", 3), ("wide", 2)]), Registration::Done(_)));
		assert!(matches!(reg(&mut db, 1, &[("b48", 3), ("wide", 2)]), Registration::Done(_)));
		assert_eq!(reg(&mut db, 2, &[("c48", 3), ("wide", 2)]), Registration::OverCap, "the wide network is full");
		assert_eq!(db.registrations(NOW.div_euclid(DAY), "c48").unwrap(), 0, "a refused registration counts nowhere");
		assert!(matches!(reg(&mut db, 3, &[("c48", 3)]), Registration::Done(_)));
	}

	#[test]
	fn upload_days_count_distinct_server_days_of_plausible_chunks() {
		let mut db = db_with(&["a"]);
		send(&mut db, "a", "i", NOW, vec![chunk(1, [], false), chunk(2, [], false)]);
		send(&mut db, "a", "i", NOW + 60, vec![chunk(3, [], false)]);
		// Only a suspect chunk on the next day: no upload day.
		send(&mut db, "a", "i", NOW + DAY, vec![chunk(4, [], true)]);
		assert_eq!(db.export(0, 10, false).unwrap()[0].upload_days, 1);
		send(&mut db, "a", "i", NOW + 2 * DAY, vec![chunk(5, [], false)]);
		let lines = db.export(0, 10, true).unwrap();
		assert!(lines.iter().all(|l| l.upload_days == 2 && l.instance == lines[0].instance), "{lines:?}");
		// Days kept for the stats expire; the running count does not.
		db.housekeeping(NOW + 40 * DAY).unwrap();
		assert_eq!(count(&db, "SELECT COUNT(*) FROM days"), 0);
		assert_eq!(db.export(0, 10, false).unwrap()[0].upload_days, 2);
	}

	#[test]
	fn quest_rows_are_capped_and_the_distinct_total_runs() {
		let mut db = db_with(&["a", "b"]);
		// Over the cap in one upload: the first MAX_QUESTS distinct ids are kept.
		send(&mut db, "a", "i", NOW, vec![chunk(1, 1..=(MAX_QUESTS as u32 + 100), false)]);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'a'"), MAX_QUESTS);
		send(&mut db, "a", "i", NOW, vec![chunk(2, [999_000], false)]);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'a'"), MAX_QUESTS);
		// Suspect chunks add none.
		send(&mut db, "b", "i", NOW, vec![chunk(1, [7, 9], true)]);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'b'"), 0);
		send(&mut db, "b", "i", NOW, vec![chunk(2, [1, 2, 900_001], false)]);
		assert_eq!(db.stats(NOW).unwrap().quests, MAX_QUESTS as u64 + 1);
		// Blocking b takes its quests out of the total, and only the one only b had.
		assert_eq!(db.set_blocked("b", true, NOW).unwrap(), Moderation::Done("b".to_owned()));
		assert_eq!(db.stats(NOW).unwrap().quests, MAX_QUESTS as u64);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'b'"), 0);
		// Deleting a empties it.
		db.delete_contributor("a", NOW).unwrap();
		assert_eq!((db.stats(NOW).unwrap().quests, count(&db, "SELECT COUNT(*) FROM quest_counts")), (0, 0));
	}

	#[test]
	fn installs_per_contributor_are_capped() {
		let mut db = db_with(&["a"]);
		for i in 0..MAX_INSTALLS {
			assert_eq!(send(&mut db, "a", &format!("install{i}"), NOW, vec![chunk(1, [], false)]).accepted, [1]);
		}
		let r = send(&mut db, "a", "one-more", NOW, vec![chunk(1, [], false), chunk(2, [], false)]);
		assert_eq!((r.accepted.len(), r.rejected.iter().map(|r| r.seq).collect::<Vec<_>>()), (0, vec![1, 2]));
		assert!(r.rejected[0].reason.contains("installs"), "{r:?}");
		// A known install goes on.
		assert_eq!(send(&mut db, "a", "install0", NOW, vec![chunk(2, [], false)]).accepted, [2]);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM seqs WHERE install = 'one-more'"), 0);
	}

	#[test]
	fn a_blocked_contributor_is_answered_the_same_and_holds_nothing() {
		let mut db = db_with(&["a"]);
		send(&mut db, "a", "i", NOW, vec![chunk(1, [5], false)]);
		db.set_blocked("a", true, NOW).unwrap();
		assert_eq!(count(&db, "SELECT COUNT(*) FROM chunks"), 0, "held chunks deleted");
		let r = send(&mut db, "a", "i", NOW, vec![chunk(1, [6], false), chunk(2, [6], false)]);
		assert_eq!((r.accepted, r.duplicate), (vec![2], vec![1]));
		assert_eq!(count(&db, "SELECT COUNT(*) FROM chunks") + count(&db, "SELECT COUNT(*) FROM quests") + count(&db, "SELECT COUNT(*) FROM days"), 0);
		let me = db.me("a").unwrap();
		assert_eq!((me.chunks, me.records["accept"]), (2, 2));
	}

	#[test]
	fn purge_deletes_everything_and_leaves_a_deleted_tombstone() {
		let mut db = db_with(&["aaaa", "aaab"]);
		send(&mut db, "aaaa", "i", NOW, vec![chunk(1, [5], false)]);
		assert_eq!(db.purge("aaa", NOW).unwrap(), Moderation::Ambiguous);
		assert_eq!(db.purge("ffff", NOW).unwrap(), Moderation::NotFound);
		assert_eq!(db.purge("aaaa", NOW).unwrap(), Moderation::Done("aaaa".to_owned()));
		assert_eq!(db.contributor("aaaa").unwrap(), None);
		for table in PER_CONTRIBUTOR.iter().chain(&["quests"]) {
			assert_eq!(count(&db, &format!("SELECT COUNT(*) FROM {table} WHERE contributor = 'aaaa'")), 0, "{table}");
		}
		assert_eq!(db.tombstones(0).unwrap().iter().map(|t| (t.contributor.as_str(), t.why.as_str())).collect::<Vec<_>>(), [("aaaa", "deleted")]);
	}

	#[test]
	fn version_2_databases_get_bounded_rows_and_running_totals() {
		let mut db = db_with(&["a", "b"]);
		send(&mut db, "b", "i", NOW, vec![chunk(1, [], false)]);
		let instance = db.instance().unwrap();
		db.conn
			.execute_batch(&format!(
				"DROP TABLE registrations;
				 CREATE TABLE registrations (day INTEGER NOT NULL, network TEXT NOT NULL, n INTEGER NOT NULL, cohort TEXT NOT NULL, PRIMARY KEY (day, network)) WITHOUT ROWID;
				 INSERT INTO registrations VALUES (1, 'x', 1, 'c');
				 WITH RECURSIVE q(n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM q WHERE n < {})
					INSERT INTO quests (contributor, quest) SELECT 'a', n FROM q;
				 INSERT INTO quests VALUES ('a', 2000000), ('b', 1);
				 UPDATE contributors SET blocked = 1 WHERE hash = 'b';
				 DELETE FROM settings WHERE key = 'quests';
				 PRAGMA user_version = 2;",
				MAX_QUESTS + 50
			))
			.unwrap();
		let db = Db::init(db.conn).unwrap();
		assert_eq!(count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'a'"), MAX_QUESTS);
		assert_eq!(count(&db, "SELECT MAX(quest) FROM quests"), MAX_QUESTS);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM chunks WHERE contributor = 'b'") + count(&db, "SELECT COUNT(*) FROM quests WHERE contributor = 'b'"), 0);
		assert_eq!(db.stats(NOW).unwrap().quests, MAX_QUESTS as u64);
		assert_eq!(count(&db, "SELECT COUNT(*) FROM pragma_table_info('registrations') WHERE name = 'cohort'"), 0);
		assert_eq!(db.instance().unwrap(), instance, "the instance id stays");
	}
}
