//! `polestar-ingest backup <path>`: a consistent copy of the live database (SQLite's online
//! backup, safe while the server writes), gzipped to `<path>`. The newest [`KEEP`] backups in
//! that folder (`ingest-*.sqlite.gz`) are kept, older ones deleted.

use std::fs::{self, File};
use std::io::BufWriter;
use std::path::{Path, PathBuf};
use std::time::Duration;

use flate2::write::GzEncoder;
use flate2::Compression;
use rusqlite::Connection;

/// Backups kept in the folder.
pub const KEEP: usize = 7;

fn is_backup(name: &str) -> bool {
	name.starts_with("ingest-") && name.ends_with(".sqlite.gz")
}

/// Backs up the database at `db` to `dest` (gzip), then keeps the newest [`KEEP`] backups of
/// `dest`'s folder (by name: the dates sort). Returns the file's size.
pub fn backup(db: &Path, dest: &Path) -> Result<u64, String> {
	let name = dest.file_name().and_then(|n| n.to_str()).ok_or_else(|| format!("{}: not a file name", dest.display()))?;
	let dir = dest.parent().filter(|p| !p.as_os_str().is_empty()).unwrap_or(Path::new("."));
	let tmp_db = dir.join(format!(".{name}.sqlite-tmp"));
	let tmp_gz = dir.join(format!(".{name}.tmp"));
	let result = (|| -> Result<u64, String> {
		let _ = fs::remove_file(&tmp_db);
		{
			let src = Connection::open(db).map_err(|e| format!("{}: {e}", db.display()))?;
			let mut out = Connection::open(&tmp_db).map_err(|e| format!("{}: {e}", tmp_db.display()))?;
			let b = rusqlite::backup::Backup::new(&src, &mut out).map_err(|e| e.to_string())?;
			b.run_to_completion(1024, Duration::from_millis(2), None).map_err(|e| format!("backup: {e}"))?;
		}
		let mut input = File::open(&tmp_db).map_err(|e| e.to_string())?;
		let file = create(&tmp_gz)?;
		let mut gz = GzEncoder::new(BufWriter::new(file), Compression::new(6));
		std::io::copy(&mut input, &mut gz).map_err(|e| format!("{}: {e}", tmp_gz.display()))?;
		let file = gz.finish().and_then(|w| w.into_inner().map_err(|e| e.into_error())).map_err(|e| format!("{}: {e}", tmp_gz.display()))?;
		file.sync_all().map_err(|e| e.to_string())?;
		fs::rename(&tmp_gz, dest).map_err(|e| format!("{}: {e}", dest.display()))?;
		Ok(fs::metadata(dest).map_err(|e| e.to_string())?.len())
	})();
	let _ = fs::remove_file(&tmp_db);
	let _ = fs::remove_file(&tmp_gz);
	let size = result?;
	prune(dir)?;
	Ok(size)
}

/// A new file, readable by others only as far as its folder lets them: the backup folder is
/// the host user's (mode 700, with an ACL for the server's uid), who encrypts and ships it.
fn create(path: &Path) -> Result<File, String> {
	let mut options = fs::OpenOptions::new();
	options.write(true).create_new(true);
	#[cfg(unix)]
	std::os::unix::fs::OpenOptionsExt::mode(&mut options, 0o644);
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
