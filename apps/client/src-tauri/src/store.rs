//! What the client keeps on this PC, all in the app data directory:
//!
//! - `tokens.json`: per server address, the token that server gave this PC
//!   when it registered (64 hex digits), readable only by this user (0600 on
//!   Unix). A token is sent only to the server that made it, as the bearer
//!   on its requests; the server stores only its SHA-256.
//! - `settings.json`: setup, recording consent, pause, the WoW folder, the
//!   server address, the addon update options, the community packs site and
//!   whether installs are counted there.
//! - `progress.json`: per Recorder install id, the last chunk uploaded and
//!   the highest chunk the server confirmed.
//! - `activity.json`: the last 500 uploads, newest first.
//! - `sent.jsonl`: the chunks the server accepted in the last 8 days, so the
//!   Home page can say what this week's play contributed.
//! - `packs.json`: per community site (its normalized address), the last pack
//!   index accepted (its bytes, signature and ETag), so the Community page
//!   works offline and an older index is never accepted after a newer one.
//! - `community.json`: per installed community pack, what it was installed as
//!   (its uid, publisher and folders: updates are compared against it), and the
//!   packs the site pulled (turned off, with their folders kept in
//!   `disabled/<id>/`, or removed), with the site's reason.

use std::collections::BTreeMap;
use std::fs;
use std::io::{self, Write};
use std::path::{Path, PathBuf};

use serde::{de::DeserializeOwned, Deserialize, Serialize};

/// The recording server: the one place the client names its address.
pub const DEFAULT_SERVER: &str = "https://data.polestar.guide";
const ACTIVITY_MAX: usize = 500;
/// How long accepted chunks stay in the local week cache.
pub const SENT_KEEP_MS: i64 = 8 * 24 * 3600 * 1000;

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(rename_all = "camelCase", default)]
pub struct Settings {
	/// The first-run setup (finding the game) is done.
	pub setup_done: bool,
	/// The player opted in to the recording program; nothing uploads before.
	pub consent: bool,
	/// When they agreed, in epoch milliseconds.
	pub consent_at: Option<i64>,
	pub paused: bool,
	/// The WoW folder the player picked or confirmed; `None` = auto-detect.
	pub wow_folder: Option<PathBuf>,
	pub server_url: String,
	/// Addon updates: pre-releases too ("beta") or only releases ("stable").
	pub channel: Channel,
	/// Look for addon updates every 6 hours (and say so in the tray).
	pub auto_check: bool,
	/// Install addon updates as soon as they are found (while the game is closed). Polestar's
	/// own addons only: community packs have `auto_update_packs`.
	pub auto_install: bool,
	/// Install routine community pack updates by themselves (packs.rs `auto_update_ok`).
	pub auto_update_packs: bool,
	/// The community packs site (polestar.guide; a developer's own in Settings > Advanced).
	pub packs_url: String,
	/// Tell the packs site which pack was installed (opt-in): the pack and version, nothing else.
	pub pack_telemetry: bool,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, Default, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub enum Channel {
	#[default]
	Stable,
	Beta,
}

/// The last pack index accepted from one site.
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
#[serde(rename_all = "camelCase")]
pub struct SavedIndex {
	/// The index's `generated`, epoch milliseconds: nothing older is accepted after it.
	pub generated: i64,
	pub etag: Option<String>,
	pub body: String,
	pub sig: String,
}

/// What the client keeps about community packs between runs.
#[derive(Serialize, Deserialize, Clone, Debug, Default, PartialEq)]
#[serde(rename_all = "camelCase", default)]
pub struct PackState {
	/// Per installed pack id: what it was installed as.
	pub pins: BTreeMap<String, crate::packs::Pin>,
	/// Per pack id: a pack the site pulled.
	pub pulled: BTreeMap<String, Pulled>,
}

/// A pack the site's `revoked` list turned off or removed.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
#[serde(rename_all = "camelCase")]
pub struct Pulled {
	pub title: String,
	pub version: Option<String>,
	pub uid: Option<String>,
	pub folders: Vec<String>,
	pub reason: String,
	pub action: crate::packs::RevokeAction,
	/// When, epoch milliseconds.
	pub at: i64,
}

impl Default for Settings {
	fn default() -> Self {
		Settings {
			setup_done: false,
			consent: false,
			consent_at: None,
			paused: false,
			wow_folder: None,
			server_url: DEFAULT_SERVER.to_owned(),
			channel: Channel::Stable,
			auto_check: true,
			auto_install: false,
			auto_update_packs: false,
			packs_url: crate::packs::DEFAULT_BASE.to_owned(),
			pack_telemetry: false,
		}
	}
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, Default, PartialEq, Eq)]
#[serde(rename_all = "camelCase", default)]
pub struct InstallProgress {
	/// Highest chunk sent (accepted, duplicate or rejected: none is sent again).
	pub uploaded: u64,
	/// Highest chunk the server accepted or already had; what Ack.lua says.
	pub acked: u64,
	/// When this install last uploaded, epoch milliseconds.
	pub last_at: i64,
}

pub type Progress = BTreeMap<String, InstallProgress>;

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(rename_all = "camelCase")]
pub struct Rejection {
	pub seq: u64,
	pub reason: String,
}

#[derive(Serialize, Deserialize, Clone, Copy, Debug, Default, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub enum ActivityKind {
	/// A request the server answered.
	#[default]
	Upload,
	/// A request that failed before the server could answer chunk by chunk.
	Failed,
	/// The player deleted their data from the server.
	Deleted,
	/// An addon was installed, updated, repaired or removed (`message` set when it failed).
	Install,
	Update,
	Repair,
	Uninstall,
	/// A community pack the site pulled was turned off (moved out of AddOns) or removed; `message`
	/// is the site's reason (and why it failed, when it did).
	Disabled,
	Removed,
	/// A turned-off pack was put back (`message` set when it failed).
	Restored,
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
#[serde(rename_all = "camelCase")]
pub struct ActivityEntry {
	pub kind: ActivityKind,
	/// Epoch milliseconds.
	pub at: i64,
	/// The WoW account folder's name: shown on this PC only, never uploaded.
	#[serde(default)]
	pub account: String,
	#[serde(default)]
	pub chunks: u32,
	#[serde(default)]
	pub records: u32,
	/// Request body size in bytes.
	#[serde(default)]
	pub bytes: u64,
	#[serde(default)]
	pub accepted: Vec<u64>,
	#[serde(default)]
	pub duplicate: Vec<u64>,
	#[serde(default)]
	pub rejected: Vec<Rejection>,
	#[serde(default)]
	pub message: Option<String>,
	/// The addon, for installs, updates, repairs and removals.
	#[serde(default)]
	pub product: Option<String>,
	#[serde(default)]
	pub version: Option<String>,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct SentChunk {
	pub at: i64,
	pub install: String,
	pub seq: u64,
	pub text: String,
}

#[derive(Clone)]
pub struct Store {
	pub dir: PathBuf,
}

impl Store {
	pub fn open(dir: PathBuf) -> io::Result<Store> {
		fs::create_dir_all(&dir)?;
		Ok(Store { dir })
	}

	fn path(&self, name: &str) -> PathBuf {
		self.dir.join(name)
	}

	/// The token the server at `server` gave this PC, if it has one.
	pub fn token(&self, server: &str) -> Option<String> {
		self.tokens().remove(server).filter(|t| is_token(t))
	}

	/// Keeps the token the server at `server` answered a solved challenge with.
	pub fn save_token(&self, server: &str, token: &str) -> io::Result<()> {
		let mut all = self.tokens();
		all.insert(server.to_owned(), token.to_owned());
		write_json(&self.path("tokens.json"), &all)
	}

	/// Forgets the token of `server` (after the player deleted their data, or the server no
	/// longer knows it): the next upload registers again.
	pub fn drop_token(&self, server: &str) -> io::Result<()> {
		let mut all = self.tokens();
		if all.remove(server).is_none() {
			return Ok(());
		}
		write_json(&self.path("tokens.json"), &all)
	}

	fn tokens(&self) -> BTreeMap<String, String> {
		read_json(&self.path("tokens.json")).unwrap_or_default()
	}

	/// The settings, with the community site in its one spelling ([`crate::packs::normalize_base`]).
	pub fn settings(&self) -> Settings {
		let mut settings: Settings = read_json(&self.path("settings.json")).unwrap_or_default();
		if let Some(base) = crate::packs::normalize_base(&settings.packs_url) {
			settings.packs_url = base;
		}
		settings
	}

	pub fn save_settings(&self, settings: &Settings) -> io::Result<()> {
		write_json(&self.path("settings.json"), settings)
	}

	pub fn progress(&self) -> Progress {
		read_json(&self.path("progress.json")).unwrap_or_default()
	}

	pub fn save_progress(&self, progress: &Progress) -> io::Result<()> {
		write_json(&self.path("progress.json"), progress)
	}

	pub fn activity(&self) -> Vec<ActivityEntry> {
		read_json(&self.path("activity.json")).unwrap_or_default()
	}

	pub fn push_activity(&self, entry: ActivityEntry) -> io::Result<()> {
		let mut all = self.activity();
		all.insert(0, entry);
		all.truncate(ACTIVITY_MAX);
		write_json(&self.path("activity.json"), &all)
	}

	/// Accepted chunks from the last 8 days.
	pub fn sent(&self, now: i64) -> Vec<SentChunk> {
		let Ok(text) = fs::read_to_string(self.path("sent.jsonl")) else { return Vec::new() };
		text.lines().filter_map(|line| serde_json::from_str::<SentChunk>(line).ok()).filter(|c| now - c.at < SENT_KEEP_MS).collect()
	}

	/// Adds accepted chunks to the week cache, dropping lines older than 8 days.
	pub fn push_sent(&self, chunks: &[SentChunk], now: i64) -> io::Result<()> {
		let mut keep = self.sent(now);
		keep.extend_from_slice(chunks);
		let mut out = Vec::new();
		for chunk in &keep {
			serde_json::to_writer(&mut out, chunk)?;
			out.push(b'\n');
		}
		write_private(&self.path("sent.jsonl"), &out)
	}

	pub fn clear_sent(&self) -> io::Result<()> {
		match fs::remove_file(self.path("sent.jsonl")) {
			Err(e) if e.kind() != io::ErrorKind::NotFound => Err(e),
			_ => Ok(()),
		}
	}

	/// The last pack index accepted from `base`. Keys are compared normalized, so `https://x/` and
	/// `https://X` are one site; of several spellings kept by an older client, the newest stands.
	pub fn pack_index(&self, base: &str) -> Option<SavedIndex> {
		let key = crate::packs::normalize_base(base)?;
		let all = read_json::<BTreeMap<String, SavedIndex>>(&self.path("packs.json"))?;
		all.into_iter().filter(|(k, _)| crate::packs::normalize_base(k).as_deref() == Some(key.as_str())).map(|(_, v)| v).max_by_key(|v| v.generated)
	}

	pub fn save_pack_index(&self, base: &str, saved: SavedIndex) -> io::Result<()> {
		let key = crate::packs::normalize_base(base).unwrap_or_else(|| base.to_owned());
		let mut all: BTreeMap<String, SavedIndex> = read_json(&self.path("packs.json")).unwrap_or_default();
		all.retain(|k, _| crate::packs::normalize_base(k).as_deref() != Some(key.as_str()));
		all.insert(key, saved);
		write_json(&self.path("packs.json"), &all)
	}

	pub fn pack_state(&self) -> PackState {
		read_json(&self.path("community.json")).unwrap_or_default()
	}

	pub fn save_pack_state(&self, state: &PackState) -> io::Result<()> {
		write_json(&self.path("community.json"), state)
	}

	/// Where a turned-off pack's folders are kept.
	pub fn disabled_dir(&self, id: &str) -> PathBuf {
		self.dir.join("disabled").join(id)
	}
}

fn is_token(text: &str) -> bool {
	text.len() == 64 && text.bytes().all(|b| b.is_ascii_hexdigit())
}

fn read_json<T: DeserializeOwned>(path: &Path) -> Option<T> {
	let text = fs::read_to_string(path).ok()?;
	serde_json::from_str(&text).ok()
}

fn write_json<T: Serialize>(path: &Path, value: &T) -> io::Result<()> {
	let bytes = serde_json::to_vec_pretty(value)?;
	write_private(path, &bytes)
}

/// Writes through a temporary file and a rename, readable by this user only.
fn write_private(path: &Path, bytes: &[u8]) -> io::Result<()> {
	let tmp = path.with_extension("tmp");
	{
		let mut options = fs::OpenOptions::new();
		options.write(true).create(true).truncate(true);
		#[cfg(unix)]
		{
			use std::os::unix::fs::OpenOptionsExt;
			options.mode(0o600);
		}
		let mut file = options.open(&tmp)?;
		file.write_all(bytes)?;
		file.sync_all()?;
	}
	fs::rename(&tmp, path)
}
