//! `forge record import|pull`: the Recorder's chunks (docs/RECORDING.md) -> data/recordings, read
//! by the data build, the travel build, the trainer list, the calibration and the route report.
//!
//! Every chunk is archived per contributor as `raw/<contributor>/<install>/<seq>.txt` (with
//! `install.json` beside it: the contributor that owns the folder, the install's map table and, for
//! pulled chunks, when the server received each), so one contributor's chunks never land in, or
//! overwrite, another's even when both claim the same install id. Then every (contributor, install)
//! that got a new chunk is normalised again from its whole archive into `<session>.json` files
//! (polestar-recording's normalize; the session id names the install, and the contributor when it
//! is not `local`); a session file of that archive the new normalisation no longer has (two
//! sessions joined by a late chunk) is removed. A pulled session's header also carries `received`
//! (the latest the server received one of its chunks), its contributor's `contributorSince`,
//! `contributorChunks`, `uploadDays` and `cohort` (from `raw/contributors.json`, the export's
//! figures), which the data build's trust reads (forge-data recordings.rs `establish`).
//! Contributors the server tombstones (deleted or blocked), and server contributors first seen over
//! `expireDays` (config.json, default 30) days ago that never became established, are moved to
//! `raw/.purged/<UTC date>/` (deleted after 30 days) and their sessions removed on pull. A
//! contributor's archive is capped at `maxContributorMB` (config.json, default 200): chunks past it
//! are skipped. State and archive files are written whole (a temp file, then renamed).
//!
//! Contributors: `local` (this PC's own installs), `sent-<name>` (a file a player sent in that the
//! maintainer vouches for under a name he chooses: trusted like his own), `anon-<16 hex digits of
//! the install id's SHA-256>` (a sent-in file nobody vouches for: kept for the record report and
//! the calibration; the data build takes nothing from it), and the server's 16 hex digits.

use std::collections::{BTreeMap, BTreeSet};
use std::io::Read;
use std::path::{Path, PathBuf};

use polestar_recording::api::{ExportLine, Tombstone};
use polestar_recording::normalize::{self, Source};
use polestar_recording::{install, record, scrub, sv};
use serde::Serialize;
use serde_json::Value;
use sha2::{Digest, Sha256};

use super::{check_args, usage, Fail};

pub const USAGE: &str = "usage: forge record import [--wtf <path>] [--vouch <name> | --anonymize] [--root <checkout>] [--out <dir>]
       forge record pull [--server <url>] [--key-file <path>] [--root <checkout>] [--out <dir>]

import: read the Recorder's file (WTF/Account/<account>/SavedVariables/Polestar_Recorder.lua) of every
account of every WoW: Forever install found (or of --wtf: a WTF folder, a game folder or its _forever_
folder, or a Polestar_Recorder.lua a player sent in, or the folder holding it; $POLESTAR_WTF does the
same), archive its chunks in <out>/raw/<contributor>/<install>/ and write the sessions as
<out>/<session>.json. The contributor is `local` (this PC's own installs). A Polestar_Recorder.lua that
is not inside this PC's own game folders is a file someone sent in and needs one of:
  --vouch <name>  you vouch for the sender: the contributor is `sent-<name>` (a-z, 0-9 and -, up to 32,
                  your choice, never taken from the file), trusted like your own recordings;
  --anonymize     the contributor is `anon-<16 hex digits of the install id's SHA-256>`: kept for the
                  record report and the calibration; the data build takes nothing from it.
Character names of the account are replaced with $N in every text.

pull: the server's export (GET /v1/export) after the last line pulled (<out>/.pull-state.json), page by
page until one comes back empty, archived and normalised the same way under each line's contributor;
each session's header records when the server received it and the contributor's first-seen time, chunk
count, upload days and registration cohort. When the server's database changed (restored or recreated:
its export carries another instance id), the pull starts over from the first line. Then the server's
tombstones (GET /v1/export/tombstones: contributors deleted or blocked) since the last pull are purged,
and so are server contributors first seen over expireDays (<out>/config.json, default 30) days ago that
never became established: their archives move to <out>/raw/.purged/<date>/ (deleted after 30 days) and
their sessions are removed. A contributor's archive holds at most maxContributorMB (<out>/config.json,
default 200) MB; chunks past it are skipped and reported. Last, with all of it on disk, the pull is
acknowledged (POST /v1/export/ack): the server deletes the chunks up to there once they are past its
retention period (the server is a buffer; this folder is the archive). --server: the recording server's
base URL, https:// (http:// only for localhost; default: $POLESTAR_INGEST_URL, else the public recording
server); --key-file: the maintainer key (default <root>/data/local/ingest/maintainer.key). Lines the
server flagged (a build it does not accept) or found suspect are skipped, and so are malformed ones and
ones whose install folder another contributor owns.

--out: the recordings folder (default <root>/data/recordings); --root: the Polestar checkout (default:
the one above the current folder). A recordings folder of the older layout (raw/<install>/) is moved to
raw/<contributor>/<install>/ and its sessions rewritten first.";

pub fn main() {
	super::exit("record", run());
}

/// An option's value (`--k v` or `--k=v`).
fn opt(args: &[String], k: &str) -> Option<String> {
	let mut it = args.iter();
	while let Some(a) = it.next() {
		if a == k {
			return it.next().cloned();
		}
		if let Some(v) = a.strip_prefix(k).and_then(|r| r.strip_prefix('=')) {
			return Some(v.to_string());
		}
	}
	None
}

fn root(args: &[String]) -> Result<PathBuf, Fail> {
	match opt(args, "--root") {
		Some(r) => Ok(std::path::absolute(&r).unwrap_or_else(|_| PathBuf::from(r))),
		None => forge::find_checkout(&std::env::current_dir().map_err(|e| e.to_string())?).ok_or_else(|| usage("no checkout above the current folder; pass --root or --out")),
	}
}

fn out_dir(args: &[String]) -> Result<PathBuf, Fail> {
	match opt(args, "--out") {
		Some(o) => Ok(std::path::absolute(&o).unwrap_or_else(|_| PathBuf::from(o))),
		None => Ok(root(args)?.join("data").join("recordings")),
	}
}

fn run() -> Result<(), Fail> {
	let a: Vec<String> = super::args().skip(1).collect();
	let Some((sub, rest)) = a.split_first() else { return Err(usage("a subcommand: import or pull")) };
	match sub.as_str() {
		"import" => {
			check_args(rest, &["--wtf", "--vouch", "--root", "--out"], &["--anonymize"], 0).map_err(usage)?;
			let wtf = opt(rest, "--wtf").or_else(|| std::env::var("POLESTAR_WTF").ok().filter(|s| !s.is_empty()));
			let who = match (opt(rest, "--vouch"), rest.iter().any(|x| x == "--anonymize")) {
				(Some(_), true) => return Err(usage("--vouch and --anonymize exclude each other")),
				(Some(n), false) if valid_vouch(&n) => Who::Vouch(n),
				(Some(n), false) => return Err(usage(format!("--vouch {n}: a name of a-z, 0-9 and - (up to 32, starting with a letter or digit)"))),
				(None, true) => Who::Anon,
				(None, false) => Who::Local,
			};
			let out = out_dir(rest)?;
			migrate(&out)?;
			import(&out, wtf.as_deref().map(Path::new), &who)
		}
		"pull" => {
			check_args(rest, &["--server", "--key-file", "--root", "--out"], &[], 0).map_err(usage)?;
			let out = out_dir(rest)?;
			let key_file = match opt(rest, "--key-file") {
				Some(k) => PathBuf::from(k),
				None => root(rest)?.join("data").join("local").join("ingest").join("maintainer.key"),
			};
			migrate(&out)?;
			pull(&out, opt(rest, "--server"), &key_file)
		}
		x => Err(usage(format!("unknown subcommand {x}: import or pull"))),
	}
}

// ---- archive

/// An archive: (contributor, install).
type Key = (String, String);

#[derive(Default, Serialize, serde::Deserialize)]
struct InstallMeta {
	/// The contributor that owns the folder (always the folder above it).
	contributor: String,
	/// uiMapID -> the `map` record's fields from `id` on.
	#[serde(default)]
	maps: BTreeMap<u32, String>,
	/// seq -> when the server received the chunk (unix seconds; pulled chunks only).
	#[serde(default, skip_serializing_if = "BTreeMap::is_empty")]
	received: BTreeMap<u64, i64>,
}

/// What the server's export said of a contributor: first seen (unix seconds, the earliest
/// figure), chunks held and upload days (the largest) and its registration cohort (the latest).
#[derive(Default, Clone, Serialize, serde::Deserialize)]
struct ContributorMeta {
	since: i64,
	chunks: u64,
	#[serde(default, rename = "uploadDays")]
	upload_days: u64,
	#[serde(default, skip_serializing_if = "String::is_empty")]
	cohort: String,
}

/// Writes `file` whole or not at all: a temp file in the same folder, renamed over it.
fn write_atomic(file: &Path, data: &[u8]) -> Result<(), String> {
	let name = file.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
	let tmp = file.with_file_name(format!(".{name}.tmp"));
	std::fs::write(&tmp, data).and_then(|()| std::fs::rename(&tmp, file)).map_err(|e| {
		let _ = std::fs::remove_file(&tmp);
		format!("{}: {e}", file.display())
	})
}

/// A JSON file: the default when it does not exist, an error naming it when it does not parse.
fn read_json<T: serde::de::DeserializeOwned + Default>(file: &Path) -> Result<T, String> {
	match std::fs::read_to_string(file) {
		Ok(t) => serde_json::from_str(&t).map_err(|e| format!("{}: {e}", file.display())),
		Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(T::default()),
		Err(e) => Err(format!("{}: {e}", file.display())),
	}
}

fn read_contributors(out: &Path) -> Result<BTreeMap<String, ContributorMeta>, String> {
	read_json(&out.join("raw").join("contributors.json"))
}

fn write_contributors(out: &Path, c: &BTreeMap<String, ContributorMeta>) -> Result<(), String> {
	std::fs::create_dir_all(out.join("raw")).map_err(|e| format!("{}: {e}", out.display()))?;
	write_atomic(&out.join("raw").join("contributors.json"), (serde_json::to_string_pretty(c).map_err(|e| e.to_string())? + "\n").as_bytes())
}

fn raw_dir(out: &Path, contributor: &str, install: &str) -> PathBuf {
	out.join("raw").join(contributor).join(install)
}

/// The archive's install.json; None when there is none.
fn read_meta(out: &Path, contributor: &str, install: &str) -> Result<Option<InstallMeta>, String> {
	read_json(&raw_dir(out, contributor, install).join("install.json"))
}

fn write_meta(out: &Path, contributor: &str, install: &str, meta: &InstallMeta) -> Result<(), String> {
	write_atomic(&raw_dir(out, contributor, install).join("install.json"), (serde_json::to_string_pretty(meta).map_err(|e| e.to_string())? + "\n").as_bytes())
}

/// Opens the contributor's archive of the install and merges its maps. False (nothing written)
/// when the folder's install.json names another contributor: a folder only ever holds its owner's.
fn archive_meta(out: &Path, contributor: &str, install: &str, maps: &BTreeMap<u32, String>) -> Result<bool, String> {
	let dir = raw_dir(out, contributor, install);
	std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let existing = read_meta(out, contributor, install)?;
	if existing.as_ref().is_some_and(|m| m.contributor != contributor) {
		return Ok(false);
	}
	let fresh = existing.is_none();
	let mut meta = existing.unwrap_or_else(|| InstallMeta { contributor: contributor.to_string(), ..InstallMeta::default() });
	let mut changed = fresh;
	for (k, v) in maps {
		if meta.maps.get(k) != Some(v) {
			meta.maps.insert(*k, v.clone());
			changed = true;
		}
	}
	if changed {
		write_meta(out, contributor, install, &meta)?;
	}
	Ok(true)
}

/// Archives one chunk in its contributor's folder: written when new, or when this copy is longer
/// (the addon refreshes an open chunk; a later copy holds more). Returns whether it changed.
fn archive_chunk(out: &Path, contributor: &str, install: &str, seq: u64, text: &str) -> Result<bool, String> {
	let file = raw_dir(out, contributor, install).join(format!("{seq}.txt"));
	if let Ok(old) = std::fs::read_to_string(&file) {
		if old.len() >= text.len() {
			return Ok(false);
		}
	}
	write_atomic(&file, text.as_bytes())?;
	Ok(true)
}

/// An archive, decoded (chunks that do not decode are reported and left out).
fn load_source(out: &Path, contributor: &str, install: &str) -> Result<Source, String> {
	let dir = raw_dir(out, contributor, install);
	let meta = read_meta(out, contributor, install)?.ok_or_else(|| format!("{}: no install.json", dir.display()))?;
	let mut chunks = Vec::new();
	let rd = std::fs::read_dir(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let mut files: Vec<(u64, PathBuf)> = rd.flatten().filter_map(|e| Some((e.file_name().to_str()?.strip_suffix(".txt")?.parse().ok()?, e.path()))).collect();
	files.sort();
	for (seq, f) in files {
		let text = std::fs::read_to_string(&f).map_err(|e| format!("{}: {e}", f.display()))?;
		match record::decode_chunk(&text) {
			Ok(c) => chunks.push(c),
			Err(e) => eprintln!("warning: {contributor}/{install} chunk {seq}: {e}; left out"),
		}
	}
	Ok(Source { contributor: contributor.to_string(), install: install.to_string(), chunks, maps: meta.maps })
}

#[derive(Default)]
struct Written {
	new: usize,
	updated: usize,
	unchanged: usize,
	removed: usize,
}

fn pretty(v: &Value) -> String {
	let mut buf = Vec::new();
	let mut ser = serde_json::Serializer::with_formatter(&mut buf, serde_json::ser::PrettyFormatter::with_indent(b"\t"));
	v.serialize(&mut ser).expect("JSON values serialize");
	String::from_utf8(buf).expect("JSON is UTF-8") + "\n"
}

/// Session files in `out`: (file name, contributor, install) of every schema 2 session.
fn session_files(out: &Path) -> Vec<(String, String, String)> {
	let Ok(rd) = std::fs::read_dir(out) else { return Vec::new() };
	let mut list = Vec::new();
	for e in rd.flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		if !name.ends_with(".json") || name.starts_with('.') || name == "config.json" {
			continue;
		}
		let Some(v) = std::fs::read_to_string(e.path()).ok().and_then(|t| serde_json::from_str::<Value>(&t).ok()) else { continue };
		if v["schema"] == 2 {
			if let Some(i) = v["install"].as_str() {
				list.push((name, v["contributor"].as_str().unwrap_or("local").to_string(), i.to_string()));
			}
		}
	}
	list
}

/// Removes the session files `gone` says to; returns how many.
fn remove_sessions(out: &Path, gone: impl Fn(&str, &str) -> bool) -> Result<usize, String> {
	let mut n = 0;
	for (name, contributor, install) in session_files(out) {
		if gone(&contributor, &install) {
			std::fs::remove_file(out.join(&name)).map_err(|e| format!("{name}: {e}"))?;
			n += 1;
		}
	}
	Ok(n)
}

/// Normalises the archives again and writes their sessions, a pulled session's header with
/// `received` and its contributor's `contributorSince`, `contributorChunks`, `uploadDays` and `cohort`.
fn write_sessions(out: &Path, keys: &BTreeSet<Key>) -> Result<Written, String> {
	let mut sources = Vec::new();
	let mut received: BTreeMap<&Key, BTreeMap<u64, i64>> = BTreeMap::new();
	for k in keys {
		sources.push(load_source(out, &k.0, &k.1)?);
		received.insert(k, read_meta(out, &k.0, &k.1)?.map(|m| m.received).unwrap_or_default());
	}
	let contributors = read_contributors(out)?;
	let mut w = Written::default();
	let mut keep = BTreeSet::new();
	for mut s in normalize::sessions(&sources) {
		let key = (s["contributor"].as_str().unwrap_or_default().to_string(), s["install"].as_str().unwrap_or_default().to_string());
		let at = received.get(&key).and_then(|r| s["chunks"].as_array()?.iter().filter_map(|c| r.get(&c.as_u64()?)).max().copied());
		let who = contributors.get(&key.0).cloned();
		if let Some(h) = s.as_object_mut() {
			if let Some(at) = at {
				h.insert("received".into(), at.into());
			}
			if let Some(c) = who {
				h.insert("contributorSince".into(), c.since.into());
				h.insert("contributorChunks".into(), c.chunks.into());
				h.insert("uploadDays".into(), c.upload_days.into());
				if is_contributor(&c.cohort) {
					h.insert("cohort".into(), c.cohort.into());
				}
			}
		}
		let id = s["session"].as_str().unwrap_or_default().to_string();
		let name = format!("{id}.json");
		let file = out.join(&name);
		let text = pretty(&s);
		match std::fs::read_to_string(&file) {
			Ok(old) if old == text => w.unchanged += 1,
			Ok(_) => {
				std::fs::write(&file, text).map_err(|e| format!("{}: {e}", file.display()))?;
				w.updated += 1;
			}
			Err(_) => {
				std::fs::write(&file, text).map_err(|e| format!("{}: {e}", file.display()))?;
				w.new += 1;
			}
		}
		keep.insert(name);
	}
	for (name, contributor, install) in session_files(out) {
		if keys.contains(&(contributor, install)) && !keep.contains(&name) {
			std::fs::remove_file(out.join(&name)).map_err(|e| format!("{name}: {e}"))?;
			w.removed += 1;
		}
	}
	Ok(w)
}

fn report(out: &Path, archived: usize, w: &Written) {
	println!(
		"{} chunk(s) archived; sessions in {}: {} new, {} updated, {} unchanged{}",
		archived,
		out.display(),
		w.new,
		w.updated,
		w.unchanged,
		if w.removed > 0 { format!(", {} replaced by joined sessions", w.removed) } else { String::new() }
	);
}

// ---- migration

/// The older layout, `raw/<install>/` with the contributor in install.json, moved to
/// `raw/<contributor>/<install>/`; a `sent-<16 hex>` contributor (the old --anonymize) becomes
/// `anon-<16 hex>`, since a sent-in file now counts only when vouched for. The moved archives'
/// sessions are written again under their new ids.
fn migrate(out: &Path) -> Result<(), Fail> {
	let raw = out.join("raw");
	let Ok(rd) = std::fs::read_dir(&raw) else { return Ok(()) };
	let mut old: BTreeSet<Key> = BTreeSet::new();
	let mut moved: BTreeSet<Key> = BTreeSet::new();
	for e in rd.flatten() {
		let install = e.file_name().to_string_lossy().into_owned();
		// Dot folders (raw/.purged) are no archive.
		if install.starts_with('.') {
			continue;
		}
		if !sv::valid_install(&install) || !e.path().is_dir() {
			continue;
		}
		let file = e.path().join("install.json");
		let Some(mut meta) = std::fs::read_to_string(&file).ok().and_then(|t| serde_json::from_str::<InstallMeta>(&t).ok()) else {
			eprintln!("warning: {}: no readable install.json; left in place", e.path().display());
			continue;
		};
		let was = meta.contributor.clone();
		let now = match was.strip_prefix("sent-") {
			Some(h) if is_contributor(h) => format!("anon-{h}"),
			_ if was == "local" || is_contributor(&was) => was.clone(),
			_ => {
				eprintln!("warning: {}: contributor {was:?} is no known kind; left in place", e.path().display());
				continue;
			}
		};
		let to = raw_dir(out, &now, &install);
		if to.exists() {
			eprintln!("warning: {} and {} both exist; {} left in place", e.path().display(), to.display(), e.path().display());
			continue;
		}
		std::fs::create_dir_all(raw.join(&now)).map_err(|e| format!("{}: {e}", raw.display()))?;
		std::fs::rename(e.path(), &to).map_err(|x| format!("{} -> {}: {x}", e.path().display(), to.display()))?;
		if now != was {
			meta.contributor = now.clone();
			write_meta(out, &now, &install, &meta)?;
		}
		old.insert((was, install.clone()));
		moved.insert((now, install));
	}
	if moved.is_empty() {
		return Ok(());
	}
	remove_sessions(out, |c, i| old.contains(&(c.to_string(), i.to_string())))?;
	let w = write_sessions(out, &moved)?;
	println!("{} archive(s) moved to raw/<contributor>/<install>/; {} session(s) written again", moved.len(), w.new + w.updated + w.unchanged);
	Ok(())
}

// ---- import

/// Whose an imported file is.
enum Who {
	/// This PC's own installs.
	Local,
	/// A sent-in file the maintainer vouches for, under the name he chose.
	Vouch(String),
	/// A sent-in file nobody vouches for.
	Anon,
}

fn valid_vouch(n: &str) -> bool {
	(1..=32).contains(&n.len()) && n.bytes().all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'-') && !n.starts_with('-')
}

fn sha16(s: &str) -> String {
	Sha256::digest(s.as_bytes()).iter().take(8).map(|b| format!("{b:02x}")).collect()
}

/// The accounts to read, the folders searched, and the loose file when --wtf names a
/// Polestar_Recorder.lua (or the folder holding it) rather than a WTF or game folder.
fn accounts_of(wtf: Option<&Path>) -> Result<(Vec<install::Account>, Vec<String>, Option<PathBuf>), Fail> {
	if let Some(dir) = wtf {
		// A file a player sent in: the file itself, or a folder holding it.
		let loose = if dir.is_file() { Some(dir.to_path_buf()) } else { Some(dir.join(sv::FILE_NAME)).filter(|f| f.is_file()) };
		if let Some(file) = loose {
			return Ok((vec![install::Account { folder_name: String::new(), sv_path: file.clone(), char_names: Vec::new() }], vec![dir.display().to_string()], Some(file)));
		}
		if dir.join("Account").is_dir() {
			return Ok((install::accounts_in_wtf(dir), vec![dir.display().to_string()], None));
		}
		let i = install::check_folder(dir).map_err(|e| Fail::Run(format!("--wtf: {e}")))?;
		return Ok((i.accounts, vec![i.flavor_dir.join("WTF").display().to_string()], None));
	}
	let installs = install::find_installs();
	let searched = installs.iter().map(|i| i.flavor_dir.join("WTF").display().to_string()).collect();
	Ok((installs.into_iter().flat_map(|i| i.accounts).collect(), searched, None))
}

/// Whether a file lies inside one of this PC's own Forever installs.
fn in_own_install(file: &Path) -> bool {
	let Ok(file) = std::fs::canonicalize(file) else { return false };
	install::find_installs().iter().any(|i| std::fs::canonicalize(&i.flavor_dir).is_ok_and(|d| file.starts_with(d)))
}

fn import(out: &Path, wtf: Option<&Path>, who: &Who) -> Result<(), Fail> {
	let (accounts, searched, loose) = accounts_of(wtf)?;
	if let (Some(file), Who::Local) = (&loose, who) {
		if !in_own_install(file) {
			return Err(usage(format!(
				"{} is not inside this PC's own game folders, so someone sent it in: pass --vouch <name> to count it as that player's, or --anonymize to let it only fill gaps",
				file.display()
			)));
		}
	}
	let files: Vec<&install::Account> = accounts.iter().filter(|a| a.sv_path.is_file()).collect();
	if files.is_empty() {
		let where_ = if searched.is_empty() { "no WoW: Forever install found".to_string() } else { format!("searched {}", searched.join(", ")) };
		return Err(Fail::Run(format!("no {} found ({where_}); pass --wtf <dir>", sv::FILE_NAME)));
	}
	std::fs::create_dir_all(out).map_err(|e| format!("{}: {e}", out.display()))?;
	let mut touched = BTreeSet::new();
	let mut archived = 0;
	for a in files {
		let text = std::fs::read_to_string(&a.sv_path).map_err(|e| format!("{}: {e}", a.sv_path.display()))?;
		let db = match sv::parse(&text) {
			Ok(db) => db,
			Err(sv::Error::Missing) => continue,
			Err(e) => {
				eprintln!("warning: {}: {e}", a.sv_path.display());
				continue;
			}
		};
		let contributor = match who {
			Who::Local => "local".to_string(),
			Who::Vouch(n) => format!("sent-{n}"),
			Who::Anon => format!("anon-{}", sha16(&db.install)),
		};
		if !archive_meta(out, &contributor, &db.install, &db.maps)? {
			eprintln!("warning: {}: {} is not {contributor}'s; skipped", a.sv_path.display(), raw_dir(out, &contributor, &db.install).display());
			continue;
		}
		let mut n = 0;
		for (seq, chunk) in &db.chunks {
			let text = scrub::scrub_chunk(chunk, &a.char_names);
			if let Err(e) = record::decode_chunk(&text) {
				eprintln!("warning: {} chunk {seq}: {e} (archived, left out of the sessions)", a.sv_path.display());
			}
			if archive_chunk(out, &contributor, &db.install, *seq, &text)? {
				n += 1;
			}
		}
		println!("{}: {} chunk(s), {n} new or longer ({contributor})", a.sv_path.display(), db.chunks.len());
		archived += n;
		touched.insert((contributor, db.install));
	}
	let w = write_sessions(out, &touched)?;
	report(out, archived, &w);
	Ok(())
}

// ---- pull

const PAGE: usize = 1000;
/// The most an export page's body may hold (the server caps a page at 8 MiB).
const PAGE_BYTES: u64 = 16 << 20;
/// The most a tombstone or acknowledgement answer may hold.
const SMALL_BYTES: u64 = 1 << 20;
/// Days a purged contributor's archive stays in raw/.purged.
const PURGED_DAYS: i64 = 30;
/// The public recording server (docs/RECORDING.md "Upload API"): the one place forge names it.
const DEFAULT_SERVER: &str = "https://data.polestar.guide";

#[derive(Default, Serialize, serde::Deserialize)]
struct PullState {
	#[serde(default)]
	server: Option<String>,
	#[serde(default)]
	after: i64,
	/// The latest tombstone purged (unix seconds).
	#[serde(default)]
	tombstones: i64,
	/// The server database's id the cursors belong to.
	#[serde(default, skip_serializing_if = "String::is_empty")]
	instance: String,
}

fn is_contributor(s: &str) -> bool {
	s.len() == 16 && s.bytes().all(|b| b.is_ascii_hexdigit() && !b.is_ascii_uppercase())
}

/// A pull's tally.
#[derive(Default)]
struct Tally {
	archived: usize,
	lines: usize,
	flagged: usize,
	suspect: usize,
	bad: usize,
	touched: BTreeSet<Key>,
	/// The most bytes one contributor's archive may hold; 0: no cap.
	cap: u64,
	/// Bytes each contributor's archive holds (measured when first needed).
	sizes: BTreeMap<String, u64>,
	/// Chunks skipped per contributor for the cap.
	capped: BTreeMap<String, usize>,
}

/// The bytes of the files under `dir`.
fn dir_size(dir: &Path) -> u64 {
	let Ok(rd) = std::fs::read_dir(dir) else { return 0 };
	rd.flatten().map(|e| if e.path().is_dir() { dir_size(&e.path()) } else { e.metadata().map(|m| m.len()).unwrap_or(0) }).sum()
}

/// Archives one export page (NDJSON), advancing `state.after`; returns its line count.
fn take_page(out: &Path, body: &str, state: &mut PullState, contributors: &mut BTreeMap<String, ContributorMeta>, t: &mut Tally) -> Result<usize, String> {
	let mut page = 0;
	// archive -> seq -> received, written to install.json once per page
	let mut received: BTreeMap<Key, BTreeMap<u64, i64>> = BTreeMap::new();
	for line in body.lines().filter(|l| !l.trim().is_empty()) {
		page += 1;
		let l: ExportLine = serde_json::from_str(line).map_err(|e| format!("line {page}: {e}"))?;
		state.after = state.after.max(l.id);
		t.lines += 1;
		if l.flagged {
			t.flagged += 1;
			continue;
		}
		if l.suspect {
			t.suspect += 1;
			continue;
		}
		// Both name folders and files: only the forms the server makes.
		if !sv::valid_install(&l.install) || !is_contributor(&l.contributor) || l.seq == 0 || !(l.cohort.is_empty() || is_contributor(&l.cohort)) {
			t.bad += 1;
			continue;
		}
		if !archive_meta(out, &l.contributor, &l.install, &BTreeMap::new())? {
			t.bad += 1;
			continue;
		}
		let c = contributors.entry(l.contributor.clone()).or_default();
		if l.contributor_since > 0 {
			c.since = if c.since > 0 { c.since.min(l.contributor_since) } else { l.contributor_since };
		}
		c.chunks = c.chunks.max(l.contributor_chunks);
		c.upload_days = c.upload_days.max(l.upload_days);
		if !l.cohort.is_empty() {
			c.cohort = l.cohort.clone();
		}
		let file = raw_dir(out, &l.contributor, &l.install).join(format!("{}.txt", l.seq));
		let old = std::fs::metadata(&file).map(|m| m.len()).unwrap_or(0);
		let new = l.text.len() as u64;
		if t.cap > 0 && new > old {
			let used = *t.sizes.entry(l.contributor.clone()).or_insert_with(|| dir_size(&out.join("raw").join(&l.contributor)));
			if used + new - old > t.cap {
				*t.capped.entry(l.contributor.clone()).or_default() += 1;
				continue;
			}
		}
		if archive_chunk(out, &l.contributor, &l.install, l.seq, &l.text)? {
			t.archived += 1;
			if let Some(used) = t.sizes.get_mut(&l.contributor) {
				*used += new - old;
			}
		}
		let key = (l.contributor.clone(), l.install.clone());
		let at = received.entry(key.clone()).or_default().entry(l.seq).or_insert(l.received);
		*at = (*at).max(l.received);
		t.touched.insert(key);
	}
	for ((contributor, install), seqs) in received {
		let mut meta = read_meta(out, &contributor, &install)?.ok_or_else(|| format!("{}: no install.json", raw_dir(out, &contributor, &install).display()))?;
		for (seq, at) in seqs {
			let old = meta.received.entry(seq).or_insert(at);
			*old = (*old).max(at);
		}
		write_meta(out, &contributor, &install, &meta)?;
	}
	Ok(page)
}

/// The instance id an export page's first line carries ("" when none or no lines).
fn page_instance(body: &str) -> String {
	body.lines().find(|l| !l.trim().is_empty()).and_then(|l| serde_json::from_str::<ExportLine>(l).ok()).map(|l| l.instance).unwrap_or_default()
}

/// Pulls export pages until one comes back empty (the server caps a page's bytes, so a short page
/// is not the last), saving the state and contributors after each. `fetch(after, limit)` answers
/// a page. When the server's database changed (another instance id) the cursors start over.
fn drain(out: &Path, state: &mut PullState, contributors: &mut BTreeMap<String, ContributorMeta>, t: &mut Tally, mut fetch: impl FnMut(i64, usize) -> Result<String, String>) -> Result<(), String> {
	let state_file = out.join(".pull-state.json");
	let mut restarted = false;
	let mut first = true;
	loop {
		let body = fetch(state.after, PAGE)?;
		// Nothing after the cursor: a database restored with fewer lines says the same, so the
		// first line's instance is asked for.
		let probe = first && body.trim().is_empty() && state.after > 0 && !state.instance.is_empty();
		first = false;
		let instance = if probe { page_instance(&fetch(0, 1)?) } else { page_instance(&body) };
		if !instance.is_empty() && instance != state.instance {
			let changed = !state.instance.is_empty();
			state.instance = instance;
			if changed {
				if restarted {
					return Err("the server's database changed twice during one pull; pull again".into());
				}
				println!("the server's database changed (restored or recreated): pulling from the start");
				state.after = 0;
				state.tombstones = 0;
				restarted = true;
				save_state(&state_file, state)?;
				continue;
			}
		}
		if probe {
			save_state(&state_file, state)?;
			return Ok(());
		}
		let after = state.after;
		let page = take_page(out, &body, state, contributors, t).map_err(|e| format!("export after {after}: {e}"))?;
		write_contributors(out, contributors)?;
		save_state(&state_file, state)?;
		if page == 0 {
			return Ok(());
		}
	}
}

/// Moves the contributors' archives to raw/.purged/<UTC date>/ and removes their sessions.
fn quarantine(out: &Path, gone: &BTreeSet<String>, now: i64) -> Result<(), String> {
	let day = out.join("raw").join(".purged").join(ymd(now));
	for c in gone {
		let dir = out.join("raw").join(c);
		if !dir.exists() {
			continue;
		}
		std::fs::create_dir_all(&day).map_err(|e| format!("{}: {e}", day.display()))?;
		let mut to = day.join(c);
		let mut n = 2;
		while to.exists() {
			to = day.join(format!("{c}-{n}"));
			n += 1;
		}
		std::fs::rename(&dir, &to).map_err(|e| format!("{} -> {}: {e}", dir.display(), to.display()))?;
	}
	remove_sessions(out, |c, _| gone.contains(c))?;
	Ok(())
}

/// Deletes raw/.purged/<date>/ folders over [`PURGED_DAYS`] old.
fn prune_purged(out: &Path, now: i64) -> Result<(), String> {
	let Ok(rd) = std::fs::read_dir(out.join("raw").join(".purged")) else { return Ok(()) };
	for e in rd.flatten() {
		if days_of(&e.file_name().to_string_lossy()).is_some_and(|d| d < now.div_euclid(86400) - PURGED_DAYS) {
			std::fs::remove_dir_all(e.path()).map_err(|x| format!("{}: {x}", e.path().display()))?;
		}
	}
	Ok(())
}

/// The UTC date of unix seconds, YYYY-MM-DD.
fn ymd(secs: i64) -> String {
	let z = secs.div_euclid(86400) + 719_468;
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

/// Days since 1970-01-01 of a YYYY-MM-DD date.
fn days_of(date: &str) -> Option<i64> {
	let b = date.as_bytes();
	if b.len() != 10 || b[4] != b'-' || b[7] != b'-' {
		return None;
	}
	let (y, m, d): (i64, i64, i64) = (date[..4].parse().ok()?, date[5..7].parse().ok()?, date[8..].parse().ok()?);
	if !(1..=12).contains(&m) || !(1..=31).contains(&d) {
		return None;
	}
	let y = if m <= 2 { y - 1 } else { y };
	let era = y.div_euclid(400);
	let yoe = y - era * 400;
	let doy = (153 * (if m > 2 { m - 3 } else { m + 9 }) + 2) / 5 + d - 1;
	Some(era * 146_097 + yoe * 365 + yoe / 4 - yoe / 100 + doy - 719_468)
}

/// Purges the contributors of a tombstone page (NDJSON): their archives (to raw/.purged),
/// sessions and figures. Advances `state.tombstones`; returns the contributors purged.
fn purge(out: &Path, body: &str, state: &mut PullState, contributors: &mut BTreeMap<String, ContributorMeta>, now: i64) -> Result<BTreeSet<String>, String> {
	let mut gone = BTreeSet::new();
	for (n, line) in body.lines().filter(|l| !l.trim().is_empty()).enumerate() {
		let t: Tombstone = serde_json::from_str(line).map_err(|e| format!("tombstone line {}: {e}", n + 1))?;
		state.tombstones = state.tombstones.max(t.at);
		if is_contributor(&t.contributor) {
			gone.insert(t.contributor);
		}
	}
	quarantine(out, &gone, now)?;
	for c in &gone {
		contributors.remove(c);
	}
	Ok(gone)
}

/// Server contributors first seen over `days` days ago none of whose sessions counts (forge-data
/// `establish`): quarantined like tombstoned ones. Returns them.
fn expire(out: &Path, contributors: &mut BTreeMap<String, ContributorMeta>, now: i64, days: u64) -> Result<BTreeSet<String>, String> {
	let limit = i64::try_from(days.saturating_mul(86400)).unwrap_or(i64::MAX);
	let old: BTreeSet<String> = contributors.iter().filter(|(c, m)| is_contributor(c) && m.since > 0 && now - m.since > limit).map(|(c, _)| c.clone()).collect();
	if old.is_empty() {
		return Ok(old);
	}
	let of: BTreeMap<String, String> = session_files(out).into_iter().map(|(n, c, _)| (n, c)).collect();
	let established: BTreeSet<String> = forge_data::recordings::read_recordings(out)?.into_iter().filter(|r| r.counts).filter_map(|r| of.get(&r.file).cloned()).collect();
	let gone: BTreeSet<String> = old.difference(&established).cloned().collect();
	quarantine(out, &gone, now)?;
	for c in &gone {
		contributors.remove(c);
	}
	Ok(gone)
}

/// config.json's `expireDays` (default 30) and `maxContributorMB` (default 200).
fn pull_config(out: &Path) -> Result<(u64, u64), String> {
	let file = out.join("config.json");
	let v: Value = read_json(&file)?;
	let num = |k: &str, d: u64| match &v[k] {
		Value::Null => Ok(d),
		x => x.as_u64().ok_or_else(|| format!("{}: {k}: expected a whole number", file.display())),
	};
	Ok((num("expireDays", 30)?, num("maxContributorMB", 200)?))
}

/// The maintainer key travels with every request: https only, but for a server on this PC.
fn check_server(server: &str) -> Result<(), String> {
	let lower = server.to_ascii_lowercase();
	if let Some(rest) = lower.strip_prefix("http://") {
		let hp = rest.split(['/', '?', '#']).next().unwrap_or("");
		let hp = hp.rsplit('@').next().unwrap_or("");
		let host = if hp.starts_with('[') { hp.split_inclusive(']').next().unwrap_or("") } else { hp.split(':').next().unwrap_or("") };
		if matches!(host, "localhost" | "127.0.0.1" | "[::1]") {
			return Ok(());
		}
		return Err(format!("{server}: http:// would send the maintainer key unencrypted; use https:// (http:// is only for localhost)"));
	}
	if lower.starts_with("https://") {
		Ok(())
	} else {
		Err(format!("{server}: not an https:// URL"))
	}
}

fn agent() -> ureq::Agent {
	ureq::Agent::config_builder().timeout_connect(Some(std::time::Duration::from_secs(20))).timeout_global(Some(std::time::Duration::from_secs(300))).build().into()
}

/// A body of at most `limit` bytes; more is an error.
fn read_limited(r: impl Read, limit: u64, url: &str) -> Result<String, String> {
	let mut buf = Vec::new();
	r.take(limit + 1).read_to_end(&mut buf).map_err(|e| format!("{url}: {e}"))?;
	if buf.len() as u64 > limit {
		return Err(format!("{url}: the answer is over {limit} bytes; refused"));
	}
	String::from_utf8(buf).map_err(|e| format!("{url}: {e}"))
}

fn http_error(url: &str, e: ureq::Error) -> String {
	match e {
		ureq::Error::StatusCode(401 | 403) => format!("{url}: the server refused the maintainer key"),
		e => format!("{url}: {e}"),
	}
}

/// GET with the maintainer key; the body (at most `limit` bytes).
fn get(agent: &ureq::Agent, url: &str, key: &str, limit: u64) -> Result<String, String> {
	let resp = agent.get(url).header("Authorization", &format!("Bearer {key}")).call().map_err(|e| http_error(url, e))?;
	read_limited(resp.into_body().into_reader(), limit, url)
}

/// POST a JSON body with the maintainer key; the answer's body (at most `limit` bytes).
fn post_json(agent: &ureq::Agent, url: &str, key: &str, body: &str, limit: u64) -> Result<String, String> {
	let resp = agent.post(url).header("Authorization", &format!("Bearer {key}")).content_type("application/json").send(body).map_err(|e| http_error(url, e))?;
	read_limited(resp.into_body().into_reader(), limit, url)
}

fn save_state(file: &Path, state: &PullState) -> Result<(), String> {
	write_atomic(file, (serde_json::to_string_pretty(state).map_err(|e| e.to_string())? + "\n").as_bytes())
}

fn unix_now() -> i64 {
	std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_secs() as i64).unwrap_or(0)
}

fn pull(out: &Path, server: Option<String>, key_file: &Path) -> Result<(), Fail> {
	let state_file = out.join(".pull-state.json");
	let mut state: PullState = read_json(&state_file)?;
	let server = server.or_else(|| std::env::var("POLESTAR_INGEST_URL").ok().filter(|s| !s.is_empty())).unwrap_or_else(|| DEFAULT_SERVER.to_string());
	let server = server.trim_end_matches('/').trim_end_matches("/v1").to_string();
	check_server(&server)?;
	if state.server.as_deref().is_some_and(|s| s != server) {
		// Another server: its line ids and tombstones are not this one's.
		state.after = 0;
		state.tombstones = 0;
		state.instance.clear();
	}
	state.server = Some(server.clone());
	let (expire_days, max_mb) = pull_config(out)?;
	let key = std::fs::read_to_string(key_file).map_err(|e| format!("{}: {e} (the maintainer key; --key-file)", key_file.display()))?;
	let key = key.trim();
	std::fs::create_dir_all(out).map_err(|e| format!("{}: {e}", out.display()))?;
	let mut contributors = read_contributors(out)?;
	let mut t = Tally { cap: max_mb.saturating_mul(1 << 20), ..Tally::default() };
	let agent = agent();
	drain(out, &mut state, &mut contributors, &mut t, |after, limit| get(&agent, &format!("{server}/v1/export?after={after}&limit={limit}"), key, PAGE_BYTES))?;
	let now = unix_now();
	// One second back: a tombstone in the same second as the last one purged is not missed (a
	// purge again is harmless).
	let url = format!("{server}/v1/export/tombstones?after={}", (state.tombstones - 1).max(0));
	let body = get(&agent, &url, key, SMALL_BYTES)?;
	let gone = purge(out, &body, &mut state, &mut contributors, now).map_err(|e| format!("{url}: {e}"))?;
	t.touched.retain(|(c, _)| !gone.contains(c));
	write_contributors(out, &contributors)?;
	save_state(&state_file, &state)?;
	let skipped = |n: usize, what: &str| if n > 0 { format!(", {n} {what} skipped") } else { String::new() };
	println!(
		"{} line(s) pulled from {server}{}{}{}{}",
		t.lines,
		skipped(t.flagged, "flagged"),
		skipped(t.suspect, "suspect"),
		skipped(t.bad, "malformed or not their install's"),
		if gone.is_empty() { String::new() } else { format!("; {} deleted or blocked contributor(s) purged", gone.len()) }
	);
	let w = write_sessions(out, &t.touched)?;
	report(out, t.archived, &w);
	for (c, n) in &t.capped {
		println!("{c}: {n} chunk(s) skipped: its archive would pass maxContributorMB ({max_mb} MB)");
	}
	let expired = expire(out, &mut contributors, now, expire_days)?;
	if !expired.is_empty() {
		write_contributors(out, &contributors)?;
		println!("{} contributor(s) first seen over {expire_days} days ago and never established moved to raw/.purged: {}", expired.len(), expired.iter().cloned().collect::<Vec<_>>().join(", "));
	}
	prune_purged(out, now)?;
	// Only now, with every line archived, every session written and the state saved: the server
	// may delete what it holds up to here once it is past its retention.
	if state.after > 0 {
		let url = format!("{server}/v1/export/ack");
		let answer = post_json(&agent, &url, key, &serde_json::json!({ "upto": state.after }).to_string(), SMALL_BYTES)
			.map_err(|e| format!("everything pulled is stored, but the acknowledgement failed ({e}); pull again to send it"))?;
		let acked = serde_json::from_str::<Value>(&answer).ok().and_then(|v| v["acked"].as_i64()).unwrap_or(state.after);
		println!("acknowledged export lines up to {acked}: the server deletes them after its retention period");
	}
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	fn scratch(name: &str) -> PathBuf {
		let d = std::env::temp_dir().join(format!("forge-record-{name}-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&d);
		std::fs::create_dir_all(&d).unwrap();
		d
	}

	const VICTIM: &str = "1111111111111111";
	const ATTACKER: &str = "2222222222222222";
	const INSTALL: &str = "victiminstal";

	/// A chunk of `char000001` at `epoch`, with `n` positions.
	fn chunk(seq: u64, epoch: i64, n: usize) -> String {
		let mut s = format!("chunk\t0\t{seq}\t{epoch}\tchar000001\nsession\t0\tchar000001\tHuman\tWARRIOR\tAlliance\t2\t1\tenUS\t70338\t16001\t3\t\t0.1.0\t\t\n");
		for i in 0..n {
			s += &format!("pos\t{i}\t1429\t5000\t5000\t0\t0\n");
		}
		s
	}

	fn line(id: i64, contributor: &str, cohort: &str, seq: u64, text: &str) -> String {
		line_of(id, contributor, cohort, seq, text, 40, "")
	}

	fn line_of(id: i64, contributor: &str, cohort: &str, seq: u64, text: &str, chunks: u64, instance: &str) -> String {
		serde_json::to_string(&ExportLine {
			id,
			contributor: contributor.into(),
			cohort: cohort.into(),
			install: INSTALL.into(),
			seq,
			received: 1_800_000_000,
			text: text.into(),
			flagged: false,
			contributor_since: 1_790_000_000,
			contributor_chunks: chunks,
			upload_days: chunks / 4,
			instance: instance.into(),
			suspect: false,
			suspect_reasons: Vec::new(),
		})
		.unwrap()
	}

	fn sessions(out: &Path) -> Vec<Value> {
		let mut v: Vec<(String, Value)> = session_files(out).into_iter().map(|(n, _, _)| (n.clone(), serde_json::from_str(&std::fs::read_to_string(out.join(n)).unwrap()).unwrap())).collect();
		v.sort_by(|a, b| a.0.cmp(&b.0));
		v.into_iter().map(|x| x.1).collect()
	}

	fn pull_page(out: &Path, body: &str) -> Tally {
		let (mut state, mut contributors, mut t) = (PullState::default(), read_contributors(out).unwrap(), Tally::default());
		take_page(out, body, &mut state, &mut contributors, &mut t).unwrap();
		write_contributors(out, &contributors).unwrap();
		write_sessions(out, &t.touched).unwrap();
		t
	}

	#[test]
	fn an_attacker_claiming_a_victims_install_cannot_touch_its_archive_or_sessions() {
		let out = scratch("separate");
		let victim = chunk(1, 1_799_990_000, 2);
		pull_page(&out, &line(1, VICTIM, "aaaaaaaaaaaaaaaa", 1, &victim));
		// The same install id, the same seq, a longer text, the same character and start time.
		let longer = chunk(1, 1_799_990_000, 9);
		let t = pull_page(&out, &format!("{}\n{}", line(2, ATTACKER, "bbbbbbbbbbbbbbbb", 1, &longer), line(3, ATTACKER, "bbbbbbbbbbbbbbbb", 2, &chunk(2, 1_799_990_100, 1))));
		assert_eq!(t.archived, 2);
		assert_eq!(std::fs::read_to_string(raw_dir(&out, VICTIM, INSTALL).join("1.txt")).unwrap(), victim, "the victim's chunk is untouched");
		assert!(!raw_dir(&out, VICTIM, INSTALL).join("2.txt").exists());
		assert_eq!(std::fs::read_to_string(raw_dir(&out, ATTACKER, INSTALL).join("1.txt")).unwrap(), longer);
		let s = sessions(&out);
		assert_eq!(s.len(), 2, "two sessions, never one overwriting the other");
		let of = |c: &str| s.iter().find(|x| x["contributor"] == c).unwrap();
		assert_eq!(of(VICTIM)["chunks"], serde_json::json!([1]));
		assert_eq!(of(VICTIM)["session"], format!("20270115T051320Z-{VICTIM}-{INSTALL}-char000001"));
		assert_eq!(of(VICTIM)["cohort"], "aaaaaaaaaaaaaaaa");
		assert_eq!(of(ATTACKER)["chunks"], serde_json::json!([1, 2]));
		// A folder whose install.json names someone else is never written to: the line is bad.
		let mut meta = read_meta(&out, ATTACKER, INSTALL).unwrap().unwrap();
		meta.contributor = VICTIM.into();
		write_meta(&out, ATTACKER, INSTALL, &meta).unwrap();
		let t = pull_page(&out, &line(4, ATTACKER, "", 3, &chunk(3, 1_799_990_200, 1)));
		assert_eq!((t.bad, t.archived), (1, 0));
		assert!(!raw_dir(&out, ATTACKER, INSTALL).join("3.txt").exists());
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn tombstones_purge_the_contributors_archives_and_sessions() {
		let out = scratch("tombstones");
		pull_page(&out, &format!("{}\n{}", line(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2)), line(2, ATTACKER, "", 1, &chunk(1, 1_799_990_000, 3))));
		assert_eq!(sessions(&out).len(), 2);
		let (mut state, mut contributors) = (PullState::default(), read_contributors(&out).unwrap());
		let body = serde_json::to_string(&Tombstone { contributor: ATTACKER.into(), at: 1_800_000_500, why: "blocked".into() }).unwrap();
		let now = 1_800_001_000;
		let gone = purge(&out, &body, &mut state, &mut contributors, now).unwrap();
		assert_eq!(gone.into_iter().collect::<Vec<_>>(), vec![ATTACKER.to_string()]);
		assert_eq!(state.tombstones, 1_800_000_500);
		assert!(!out.join("raw").join(ATTACKER).exists() && raw_dir(&out, VICTIM, INSTALL).join("1.txt").exists());
		let purged = out.join("raw").join(".purged").join(ymd(now));
		assert!(purged.join(ATTACKER).join(INSTALL).join("1.txt").is_file(), "moved, not deleted");
		assert!(!contributors.contains_key(ATTACKER) && contributors.contains_key(VICTIM));
		let s = sessions(&out);
		assert_eq!((s.len(), s[0]["contributor"].as_str()), (1, Some(VICTIM)));
		// raw/.purged is no archive to migrate.
		migrate(&out).unwrap();
		assert!(purged.join(ATTACKER).is_dir());
		// Purged folders over 30 days old are deleted; younger ones stay.
		let old = out.join("raw").join(".purged").join(ymd(now - 31 * 86400));
		let young = out.join("raw").join(".purged").join(ymd(now - 29 * 86400));
		std::fs::create_dir_all(old.join(ATTACKER)).unwrap();
		std::fs::create_dir_all(&young).unwrap();
		prune_purged(&out, now).unwrap();
		assert!(!old.exists() && young.is_dir() && purged.is_dir());
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn dates_round_trip() {
		assert_eq!(ymd(0), "1970-01-01");
		assert_eq!(ymd(1_800_000_000), "2027-01-15");
		for d in [-800_000, -1, 0, 59, 60, 10_957, 20_000, 800_000] {
			assert_eq!(days_of(&ymd(d * 86400)), Some(d), "{d}");
		}
		assert_eq!(days_of("contributor1"), None);
	}

	#[test]
	fn the_header_carries_upload_days() {
		let out = scratch("upload-days");
		pull_page(&out, &line_of(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2), 40, ""));
		assert_eq!(sessions(&out)[0]["uploadDays"], 10);
		assert_eq!(read_contributors(&out).unwrap()[VICTIM].upload_days, 10);
		// The largest seen is kept.
		pull_page(&out, &line_of(2, VICTIM, "", 2, &chunk(2, 1_799_990_100, 2), 8, ""));
		assert_eq!(read_contributors(&out).unwrap()[VICTIM].upload_days, 10);
		std::fs::remove_dir_all(&out).unwrap();
	}

	/// `drain` over canned pages: after -> body (limit 1 asks for the first line only).
	fn drain_pages(out: &Path, state: &mut PullState, pages: &[(i64, String)]) -> (Tally, Vec<i64>) {
		let (mut contributors, mut t, mut asked) = (BTreeMap::new(), Tally::default(), Vec::new());
		drain(out, state, &mut contributors, &mut t, |after, limit| {
			asked.push(after);
			let body = pages.iter().find(|p| p.0 == after).map(|p| p.1.clone()).unwrap_or_default();
			Ok(if limit == 1 { body.lines().next().unwrap_or("").to_string() } else { body })
		})
		.unwrap();
		(t, asked)
	}

	#[test]
	fn a_short_page_is_not_the_last() {
		let out = scratch("drain");
		let c = |s| chunk(s, 1_799_990_000 + s as i64 * 100, 1);
		let pages = [(0, format!("{}\n{}\n", line(1, VICTIM, "", 1, &c(1)), line(2, VICTIM, "", 2, &c(2)))), (2, line(3, VICTIM, "", 3, &c(3)))];
		let mut state = PullState::default();
		let (t, asked) = drain_pages(&out, &mut state, &pages);
		assert_eq!((state.after, t.archived, asked), (3, 3, vec![0, 2, 3]));
		let saved: PullState = read_json(&out.join(".pull-state.json")).unwrap();
		assert_eq!(saved.after, 3);
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn another_server_database_starts_the_pull_over() {
		let out = scratch("instance");
		let c = |s| chunk(s, 1_799_990_000 + s as i64 * 100, 1);
		// The first pull records the instance.
		let mut state = PullState::default();
		drain_pages(&out, &mut state, &[(0, line_of(1, VICTIM, "", 1, &c(1), 40, "aaaa"))]);
		assert_eq!((state.after, state.instance.as_str()), (1, "aaaa"));
		// A page from another instance: the cursors reset and the pull starts from the first line.
		let mut state = PullState { after: 10, tombstones: 99, instance: "aaaa".into(), ..PullState::default() };
		let fresh = format!("{}\n{}\n", line_of(1, VICTIM, "", 1, &c(1), 40, "bbbb"), line_of(2, VICTIM, "", 2, &c(2), 40, "bbbb"));
		let (_, asked) = drain_pages(&out, &mut state, &[(10, line_of(11, VICTIM, "", 5, &c(5), 40, "bbbb")), (0, fresh.clone())]);
		assert_eq!((state.after, state.tombstones, state.instance.as_str(), asked), (2, 0, "bbbb", vec![10, 0, 2]));
		assert!(!raw_dir(&out, VICTIM, INSTALL).join("5.txt").exists(), "the stale page is not taken");
		// Nothing after the cursor, but the server's first line is of another instance: restored with fewer lines.
		let mut state = PullState { after: 10, instance: "aaaa".into(), ..PullState::default() };
		let (_, asked) = drain_pages(&out, &mut state, &[(0, fresh)]);
		assert_eq!((state.after, state.instance.as_str(), asked), (2, "bbbb", vec![10, 0, 0, 2]));
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn old_contributors_never_established_expire() {
		let out = scratch("expire");
		std::fs::write(
			out.join("config.json"),
			r#"{"minContributorDays":0,"minContributorChunks":30,"minContributorPlayDays":0,"minContributorHours":0,"minContributorPos":0,"minContributorKills":0}"#,
		)
		.unwrap();
		pull_page(&out, &format!("{}\n{}", line_of(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2), 40, ""), line_of(2, ATTACKER, "", 1, &chunk(1, 1_799_990_000, 3), 10, "")));
		let mut contributors = read_contributors(&out).unwrap();
		// Not yet old enough: nothing expires.
		assert!(expire(&out, &mut contributors, 1_790_000_000 + 29 * 86400, 30).unwrap().is_empty());
		let now = 1_790_000_000 + 31 * 86400;
		let gone = expire(&out, &mut contributors, now, 30).unwrap();
		assert_eq!(gone.into_iter().collect::<Vec<_>>(), vec![ATTACKER.to_string()]);
		assert!(out.join("raw").join(".purged").join(ymd(now)).join(ATTACKER).is_dir());
		assert!(!out.join("raw").join(ATTACKER).exists() && raw_dir(&out, VICTIM, INSTALL).join("1.txt").is_file());
		assert!(!contributors.contains_key(ATTACKER) && contributors.contains_key(VICTIM));
		assert_eq!(sessions(&out).len(), 1);
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn the_archive_cap_skips_and_counts() {
		let out = scratch("cap");
		pull_page(&out, &line(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2)));
		let used = dir_size(&out.join("raw").join(VICTIM));
		let (mut state, mut contributors) = (PullState::default(), read_contributors(&out).unwrap());
		let mut t = Tally { cap: used + 5, ..Tally::default() };
		take_page(&out, &format!("{}\n{}", line(2, VICTIM, "", 2, &chunk(2, 1_799_990_100, 2)), line(3, VICTIM, "", 3, &chunk(3, 1_799_990_200, 2))), &mut state, &mut contributors, &mut t).unwrap();
		assert_eq!((t.archived, t.capped.get(VICTIM).copied()), (0, Some(2)));
		assert!(!raw_dir(&out, VICTIM, INSTALL).join("2.txt").exists());
		std::fs::remove_dir_all(&out).unwrap();
	}

	fn tmp_files(dir: &Path) -> Vec<PathBuf> {
		std::fs::read_dir(dir)
			.unwrap()
			.flatten()
			.flat_map(|e| {
				if e.path().is_dir() {
					tmp_files(&e.path())
				} else if e.file_name().to_string_lossy().ends_with(".tmp") {
					vec![e.path()]
				} else {
					vec![]
				}
			})
			.collect()
	}

	#[test]
	fn writes_are_whole_and_corrupt_state_is_an_error() {
		let out = scratch("atomic");
		let mut state = PullState::default();
		drain_pages(&out, &mut state, &[(0, line(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2)))]);
		assert!(out.join(".pull-state.json").is_file() && out.join("raw").join("contributors.json").is_file());
		assert!(tmp_files(&out).is_empty(), "{:?}", tmp_files(&out));
		std::fs::write(out.join("raw").join("contributors.json"), "{ not json").unwrap();
		assert!(read_contributors(&out).err().unwrap().contains("contributors.json"));
		std::fs::write(raw_dir(&out, VICTIM, INSTALL).join("install.json"), "[").unwrap();
		assert!(read_meta(&out, VICTIM, INSTALL).err().unwrap().contains("install.json"));
		std::fs::write(out.join(".pull-state.json"), "nope").unwrap();
		let key = out.join("maintainer.key");
		std::fs::write(&key, "k").unwrap();
		let e = pull(&out, Some("http://127.0.0.1:9".into()), &key).unwrap_err();
		assert!(format!("{e:?}").contains(".pull-state.json"), "{e:?}");
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn plain_http_only_for_localhost() {
		for ok in ["https://example.org", "http://localhost:8080", "http://127.0.0.1:1", "http://[::1]:5", "HTTP://LOCALHOST"] {
			assert!(check_server(ok).is_ok(), "{ok}");
		}
		for bad in ["http://example.org", "http://localhost.example.org", "http://127.0.0.1.example.org", "http://localhost@example.org", "ftp://localhost", "example.org"] {
			assert!(check_server(bad).is_err(), "{bad}");
		}
	}

	#[test]
	fn oversized_bodies_are_refused() {
		assert_eq!(read_limited(&b"0123456789"[..], 10, "u").unwrap(), "0123456789");
		assert!(read_limited(&b"0123456789!"[..], 10, "u").unwrap_err().contains("over 10 bytes"));
	}

	#[test]
	fn the_older_layout_moves_under_its_contributor() {
		let out = scratch("migrate");
		for (install, contributor) in [("localinstal1", "local"), ("sentinstall1", "sent-0123456789abcdef"), ("pulledinsta1", VICTIM)] {
			let dir = out.join("raw").join(install);
			std::fs::create_dir_all(&dir).unwrap();
			std::fs::write(dir.join("install.json"), format!(r#"{{"contributor":"{contributor}","maps":{{}}}}"#)).unwrap();
			std::fs::write(dir.join("1.txt"), chunk(1, 1_799_990_000, 1)).unwrap();
			// The session under its old id.
			std::fs::write(out.join(format!("20270115T051320Z-char000001-{install}.json")), format!(r#"{{"schema":2,"contributor":"{contributor}","install":"{install}","events":[]}}"#)).unwrap();
		}
		migrate(&out).unwrap();
		for (c, i) in [("local", "localinstal1"), ("anon-0123456789abcdef", "sentinstall1"), (VICTIM, "pulledinsta1")] {
			assert!(raw_dir(&out, c, i).join("1.txt").is_file(), "{c}/{i}");
			assert_eq!(read_meta(&out, c, i).unwrap().unwrap().contributor, c);
		}
		let mut names: Vec<String> = session_files(&out).into_iter().map(|(n, _, _)| n).collect();
		names.sort();
		assert_eq!(
			names,
			vec![
				format!("20270115T051320Z-{VICTIM}-pulledinsta1-char000001.json"),
				"20270115T051320Z-anon-0123456789abcdef-sentinstall1-char000001.json".to_string(),
				"20270115T051320Z-localinstal1-char000001.json".to_string(),
			]
		);
		std::fs::remove_dir_all(&out).unwrap();
	}

	#[test]
	fn vouch_names_are_simple() {
		for ok in ["alice", "bob-2", "x"] {
			assert!(valid_vouch(ok), "{ok}");
		}
		for bad in ["", "-a", "Alice", "a/b", "a.b", &"a".repeat(33)] {
			assert!(!valid_vouch(bad), "{bad}");
		}
	}

	/// A one-thread HTTP server for `pull`: `export` answers `GET /v1/export?after=0`, every other
	/// export and tombstone request is empty, and each `POST /v1/export/ack` body is recorded
	/// together with whether the pulled session was on disk when it came.
	fn fake_server(out: PathBuf, export: String) -> (String, std::sync::Arc<std::sync::Mutex<Vec<(String, bool)>>>) {
		use std::io::{BufRead, BufReader, Write};
		let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
		let url = format!("http://{}", listener.local_addr().unwrap());
		let acks = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
		let seen = acks.clone();
		std::thread::spawn(move || {
			for stream in listener.incoming() {
				let mut stream = stream.unwrap();
				let mut reader = BufReader::new(stream.try_clone().unwrap());
				let mut request = String::new();
				reader.read_line(&mut request).unwrap();
				let mut length = 0;
				loop {
					let mut h = String::new();
					reader.read_line(&mut h).unwrap();
					if h.trim().is_empty() {
						break;
					}
					if let Some(v) = h.to_ascii_lowercase().strip_prefix("content-length:") {
						length = v.trim().parse().unwrap();
					}
				}
				let mut body = vec![0; length];
				std::io::Read::read_exact(&mut reader, &mut body).unwrap();
				let path = request.split(' ').nth(1).unwrap_or("").to_owned();
				let answer = if path.starts_with("/v1/export/ack") {
					seen.lock().unwrap().push((String::from_utf8(body).unwrap(), !session_files(&out).is_empty() && out.join(".pull-state.json").exists()));
					r#"{"acked":2,"pruned":0,"held":2}"#.to_owned()
				} else if path.starts_with("/v1/export?after=0&") {
					export.clone()
				} else {
					String::new()
				};
				let _ = write!(stream, "HTTP/1.1 200 OK\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{answer}", answer.len());
			}
		});
		(url, acks)
	}

	#[test]
	fn pull_acknowledges_only_once_everything_is_on_disk() {
		let out = scratch("ack");
		let key = out.join("maintainer.key");
		std::fs::write(&key, "k".repeat(64)).unwrap();
		// The test contributor's first-seen time is fixed; it must not expire as the clock runs on.
		std::fs::write(out.join("config.json"), r#"{"expireDays":1000000}"#).unwrap();
		let export = format!("{}\n{}\n", line(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2)), line(2, VICTIM, "", 2, &chunk(2, 1_799_990_100, 2)));
		let (url, acks) = fake_server(out.clone(), export);
		pull(&out, Some(url), &key).unwrap();
		assert_eq!(*acks.lock().unwrap(), [(r#"{"upto":2}"#.to_owned(), true)]);

		// A pull that fails part way acknowledges nothing.
		let out = scratch("ack-failed");
		std::fs::write(&key, "k".repeat(64)).unwrap();
		let (url, acks) = fake_server(out.clone(), format!("{}\nnot json\n", line(1, VICTIM, "", 1, &chunk(1, 1_799_990_000, 2))));
		assert!(pull(&out, Some(url), &key).is_err());
		assert!(acks.lock().unwrap().is_empty());
	}
}
