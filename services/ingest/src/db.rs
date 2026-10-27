//! The SQLite store: contributors, chunks and what the chunks hold.
//!
//! A contributor is the SHA-256 of a token the server handed out at registration; the token
//! itself is never stored. Per chunk the server keeps the text as uploaded plus the counts it
//! needs for `/v1/me` and `/v1/stats`, so neither has to decode chunks again. Deleting a
//! contributor's chunks deletes those counts with them (foreign keys with `ON DELETE CASCADE`).
//! No IP address is ever written here. The registration cap and cohorts need to recognise a
//! network for one UTC day: they keep only an HMAC of it under that day's random salt, and the
//! salt and those HMACs are deleted when the day is over.

use std::collections::{BTreeMap, BTreeSet, HashMap};
use std::path::Path;

use polestar_recording::api::{AdminContributor, ExportLine, MeResponse, Rejected, Stats, StatsDay, Tombstone, UploadResponse};
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
CREATE TABLE IF NOT EXISTS chunk_kinds (
	chunk INTEGER NOT NULL REFERENCES chunks (id) ON DELETE CASCADE,
	kind TEXT NOT NULL,
	n INTEGER NOT NULL,
	PRIMARY KEY (chunk, kind)
) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS chunk_quests (
	chunk INTEGER NOT NULL REFERENCES chunks (id) ON DELETE CASCADE,
	quest INTEGER NOT NULL,
	PRIMARY KEY (chunk, quest)
) WITHOUT ROWID;
CREATE INDEX IF NOT EXISTS chunk_quests_quest ON chunk_quests (quest);
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

/// Largest export page, in bytes of chunk text.
pub const EXPORT_MAX_BYTES: usize = 8 * 1024 * 1024;

const DAY: i64 = 86_400;

/// A chunk that decoded cleanly and is ready to store.
#[derive(Debug, Clone)]
pub struct NewChunk {
	pub seq: u64,
	/// The chunk's server epoch.
	pub epoch: i64,
	pub text: String,
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
		conn.execute_batch(SCHEMA)?;
		for (table, column, decl) in ADDED_COLUMNS {
			let has: bool = conn.query_row(&format!("SELECT COUNT(*) > 0 FROM pragma_table_info('{table}') WHERE name = ?1"), [column], |r| r.get(0))?;
			if !has {
				conn.execute_batch(&format!("ALTER TABLE {table} ADD COLUMN {column} {decl}"))?;
			}
		}
		Ok(Db { conn })
	}

	/// A cheap query, for the health check.
	pub fn ping(&self) -> rusqlite::Result<()> {
		self.conn.query_row("SELECT 1", [], |_| Ok(()))
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
		let highest = self
			.conn
			.query_row("SELECT seq, COALESCE(epoch, 0) FROM chunks WHERE contributor = ?1 AND install = ?2 ORDER BY seq DESC LIMIT 1", [contributor, install], |r| {
				Ok((r.get::<_, i64>(0)? as u64, r.get(1)?))
			})
			.optional()?;
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
			let mut insert_chunk = tx.prepare(
				"INSERT OR IGNORE INTO chunks (contributor, install, seq, received, build, locale, uploader, text, flagged, epoch, suspect, reasons)
				 VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12)",
			)?;
			let mut insert_kind = tx.prepare("INSERT INTO chunk_kinds (chunk, kind, n) VALUES (?1, ?2, ?3)")?;
			let mut insert_quest = tx.prepare("INSERT INTO chunk_quests (chunk, quest) VALUES (?1, ?2)")?;
			for p in prepared {
				let chunk = match p {
					Prepared::Rejected(r) => {
						response.rejected.push(r);
						continue;
					}
					Prepared::Ok(chunk) => chunk,
				};
				let reasons = (!chunk.suspect.is_empty()).then(|| chunk.suspect.join("\n"));
				let changed = insert_chunk.execute(params![
					contributor,
					install,
					chunk.seq as i64,
					now,
					chunk.build,
					chunk.locale,
					uploader,
					chunk.text,
					chunk.flagged,
					chunk.epoch,
					reasons.is_some(),
					reasons
				])?;
				if changed == 0 {
					response.duplicate.push(chunk.seq);
					continue;
				}
				let id = tx.last_insert_rowid();
				for (kind, n) in &chunk.kinds {
					insert_kind.execute(params![id, kind, *n as i64])?;
				}
				for quest in &chunk.quests {
					insert_quest.execute(params![id, quest])?;
				}
				response.accepted.push(chunk.seq);
			}
		}
		tx.commit()?;
		Ok(UploadOutcome::Done(response))
	}

	/// Everything the server holds from one contributor, as counts.
	pub fn me(&self, contributor: &str) -> rusqlite::Result<MeResponse> {
		let (chunks, first, last): (i64, Option<i64>, Option<i64>) =
			self.conn.query_row("SELECT COUNT(*), MIN(received), MAX(received) FROM chunks WHERE contributor = ?1", [contributor], |r| Ok((r.get(0)?, r.get(1)?, r.get(2)?)))?;
		let mut stmt = self.conn.prepare("SELECT k.kind, SUM(k.n) FROM chunk_kinds k JOIN chunks c ON c.id = k.chunk WHERE c.contributor = ?1 GROUP BY k.kind")?;
		let records = stmt.query_map([contributor], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)? as u64)))?.collect::<rusqlite::Result<BTreeMap<_, _>>>()?;
		Ok(MeResponse { chunks: chunks as u64, records, first_upload: first, last_upload: last })
	}

	/// Deletes every chunk and the contributor row, leaving a tombstone; returns how many chunks
	/// went.
	pub fn delete_contributor(&mut self, contributor: &str, now: i64) -> rusqlite::Result<u64> {
		let tx = self.conn.transaction()?;
		let n = tx.execute("DELETE FROM chunks WHERE contributor = ?1", [contributor])?;
		tx.execute("DELETE FROM contributors WHERE hash = ?1", [contributor])?;
		tx.execute("INSERT INTO tombstones (contributor, at, why) VALUES (substr(?1, 1, 16), ?2, 'deleted')", params![contributor, now])?;
		tx.commit()?;
		Ok(n as u64)
	}

	/// Public totals, blocked contributors left out. `last30` covers the 30 UTC days ending
	/// today, days without chunks left out.
	pub fn stats(&self, now: i64) -> rusqlite::Result<Stats> {
		const OPEN: &str = "c.contributor NOT IN (SELECT hash FROM contributors WHERE blocked = 1)";
		let (contributors, chunks): (i64, i64) = self.conn.query_row(&format!("SELECT COUNT(DISTINCT c.contributor), COUNT(*) FROM chunks c WHERE {OPEN}"), [], |r| Ok((r.get(0)?, r.get(1)?)))?;
		let mut stmt = self.conn.prepare(&format!("SELECT k.kind, SUM(k.n) FROM chunk_kinds k JOIN chunks c ON c.id = k.chunk WHERE {OPEN} GROUP BY k.kind"))?;
		let records = stmt.query_map([], |r| Ok((r.get::<_, String>(0)?, r.get::<_, i64>(1)? as u64)))?.collect::<rusqlite::Result<BTreeMap<_, _>>>()?;
		let quests: i64 = self.conn.query_row(&format!("SELECT COUNT(DISTINCT q.quest) FROM chunk_quests q JOIN chunks c ON c.id = q.chunk WHERE {OPEN}"), [], |r| r.get(0))?;
		let since = (now.div_euclid(DAY) - 29) * DAY;
		let mut stmt = self.conn.prepare(&format!("SELECT c.received / 86400 AS d, COUNT(*), COUNT(DISTINCT c.contributor) FROM chunks c WHERE c.received >= ?1 AND {OPEN} GROUP BY d ORDER BY d"))?;
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
				COALESCE(co.cohort, substr(co.hash, 1, 16))
			 FROM chunks ch JOIN contributors co ON co.hash = ch.contributor
			 WHERE ch.id > ?1 AND co.blocked = 0 AND (?3 OR ch.suspect = 0)
			 ORDER BY ch.id LIMIT ?2",
		)?;
		let rows = stmt.query_map(params![after, limit, suspect], |r| {
			let reasons: Option<String> = r.get(8)?;
			Ok((
				r.get::<_, String>(1)?,
				ExportLine {
					id: r.get(0)?,
					contributor: String::new(),
					cohort: r.get(10)?,
					install: r.get(2)?,
					seq: r.get::<_, i64>(3)? as u64,
					received: r.get(4)?,
					text: r.get(5)?,
					flagged: r.get(6)?,
					contributor_since: r.get(9)?,
					contributor_chunks: 0,
					suspect: r.get(7)?,
					suspect_reasons: reasons.map(|s| s.lines().map(str::to_owned).collect()).unwrap_or_default(),
				},
			))
		})?;
		let mut bytes = 0;
		let mut page = Vec::new();
		for row in rows {
			let row = row?;
			bytes += row.1.text.len();
			if bytes > EXPORT_MAX_BYTES && !page.is_empty() {
				break;
			}
			page.push(row);
		}
		let rows = page;
		// Each contributor's chunks that passed the plausibility checks, counted once per page.
		let mut counts: HashMap<String, u64> = HashMap::new();
		let mut count = self.conn.prepare("SELECT COUNT(*) FROM chunks WHERE contributor = ?1 AND suspect = 0")?;
		let mut out = Vec::with_capacity(rows.len());
		for (contributor, mut line) in rows {
			line.contributor_chunks = match counts.get(&contributor) {
				Some(n) => *n,
				None => {
					let n = count.query_row([&contributor], |r| r.get::<_, i64>(0))? as u64;
					counts.insert(contributor.clone(), n);
					n
				}
			};
			line.contributor = contributor.chars().take(16).collect();
			out.push(line);
		}
		Ok(out)
	}

	/// Every contributor with its chunk counts, oldest first.
	pub fn contributors(&self) -> rusqlite::Result<Vec<AdminContributor>> {
		let mut stmt = self.conn.prepare(
			"SELECT co.hash, co.first_seen, co.last_seen, co.blocked, COUNT(ch.id), COALESCE(SUM(ch.suspect), 0)
			 FROM contributors co LEFT JOIN chunks ch ON ch.contributor = co.hash
			 GROUP BY co.hash ORDER BY co.first_seen, co.hash",
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
		assert_eq!((line.contributor_chunks, line.cohort.as_str()), (1, "abc"));
	}
}
