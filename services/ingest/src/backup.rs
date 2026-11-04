//! `polestar-ingest backup <path>`: a consistent copy of the live database (SQLite's online
//! backup, safe while the server writes), gzipped to `<path>`. The copy leaves out today's
//! network salt and registration counts (with the salt, an IPv4 address could be recovered from
//! its HMAC by trying them all) and the database's instance id (a restored backup is a new
//! instance), and is compacted, so deleted rows are not left in free pages. The newest [`KEEP`]
//! backups in that folder (`ingest-*.sqlite.gz`) are kept, older ones deleted. Every file is
//! created mode 600.

use std::fs::{self, File};
use std::io::BufWriter;
use std::path::{Path, PathBuf};
use std::time::Duration;

use flate2::write::GzEncoder;
use flate2::Compression;
use rusqlite::Connection;

/// Backups kept in the folder.
pub const KEEP: usize = 7;
/// Free space kept on the backup folder's filesystem beyond what a backup needs.
pub const MARGIN_BYTES: u64 = 256 * 1024 * 1024;

fn is_backup(name: &str) -> bool {
	name.starts_with("ingest-") && name.ends_with(".sqlite.gz")
}

/// The database's size on disk, its WAL included.
fn db_bytes(db: &Path) -> u64 {
	let wal = db.with_file_name(format!("{}-wal", db.file_name().and_then(|n| n.to_str()).unwrap_or_default()));
	[db, wal.as_path()].iter().filter_map(|p| fs::metadata(p).ok()).map(|m| m.len()).sum()
}

/// Backs up the database at `db` to `dest` (gzip), then keeps the newest [`KEEP`] backups of
/// `dest`'s folder (by name: the dates sort). Refuses to start without room for two copies of
/// the database (the online copy and the compacted one) plus [`MARGIN_BYTES`]. Returns the
/// file's size.
pub fn backup(db: &Path, dest: &Path) -> Result<u64, String> {
	let name = dest.file_name().and_then(|n| n.to_str()).ok_or_else(|| format!("{}: not a file name", dest.display()))?;
	let dir = dest.parent().filter(|p| !p.as_os_str().is_empty()).unwrap_or(Path::new("."));
	let need = db_bytes(db).saturating_mul(2).saturating_add(MARGIN_BYTES);
	if let Some(free) = crate::free_bytes(dir) {
		if free < need {
			return Err(format!("{}: {} MiB free, a backup needs {} MiB", dir.display(), free >> 20, need >> 20));
		}
	}
	let tmp_db = dir.join(format!(".{name}.sqlite-tmp"));
	let tmp_clean = dir.join(format!(".{name}.sqlite-clean"));
	let tmp_gz = dir.join(format!(".{name}.tmp"));
	let result = (|| -> Result<u64, String> {
		for tmp in [&tmp_db, &tmp_clean] {
			let _ = fs::remove_file(tmp);
			// Made empty here, so SQLite opens a file that is already mode 600.
			create(tmp)?;
		}
		{
			let src = Connection::open(db).map_err(|e| format!("{}: {e}", db.display()))?;
			let mut out = Connection::open(&tmp_db).map_err(|e| format!("{}: {e}", tmp_db.display()))?;
			let b = rusqlite::backup::Backup::new(&src, &mut out).map_err(|e| e.to_string())?;
			b.run_to_completion(1024, Duration::from_millis(2), None).map_err(|e| format!("backup: {e}"))?;
		}
		{
			let copy = Connection::open(&tmp_db).map_err(|e| format!("{}: {e}", tmp_db.display()))?;
			copy.execute_batch("DELETE FROM day_salt; DELETE FROM registrations; DELETE FROM settings WHERE key = 'instance';").map_err(|e| format!("scrub: {e}"))?;
			// A fresh file with no free pages, so nothing deleted survives in the copy.
			copy.execute("VACUUM INTO ?1", [tmp_clean.to_str().ok_or("backup path is not UTF-8")?]).map_err(|e| format!("vacuum: {e}"))?;
		}
		let _ = fs::remove_file(&tmp_db);
		let mut input = File::open(&tmp_clean).map_err(|e| e.to_string())?;
		let file = create(&tmp_gz)?;
		let mut gz = GzEncoder::new(BufWriter::new(file), Compression::new(6));
		std::io::copy(&mut input, &mut gz).map_err(|e| format!("{}: {e}", tmp_gz.display()))?;
		let file = gz.finish().and_then(|w| w.into_inner().map_err(|e| e.into_error())).map_err(|e| format!("{}: {e}", tmp_gz.display()))?;
		file.sync_all().map_err(|e| e.to_string())?;
		fs::rename(&tmp_gz, dest).map_err(|e| format!("{}: {e}", dest.display()))?;
		Ok(fs::metadata(dest).map_err(|e| e.to_string())?.len())
	})();
	for tmp in [&tmp_db, &tmp_clean, &tmp_gz] {
		let _ = fs::remove_file(tmp);
	}
	let size = result?;
	prune(dir)?;
	Ok(size)
}

/// A new file, mode 600: only the server's uid reads it; the host user fetches it with
/// `docker cp` (backup.sh).
fn create(path: &Path) -> Result<File, String> {
	let mut options = fs::OpenOptions::new();
	options.write(true).create_new(true);
	#[cfg(unix)]
	std::os::unix::fs::OpenOptionsExt::mode(&mut options, 0o600);
	options.open(path).map_err(|e| format!("{}: {e}", path.display()))
}

fn prune(dir: &Path) -> Result<(), String> {
	let mut backups: Vec<PathBuf> =
		fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?.filter_map(|e| e.ok()).filter(|e| e.file_name().to_str().is_some_and(is_backup)).map(|e| e.path()).collect();
	backups.sort();
	let old = backups.len().saturating_sub(KEEP);
	for path in &backups[..old] {
		fs::remove_file(path).map_err(|e| format!("{}: {e}", path.display()))?;
	}
	Ok(())
}
