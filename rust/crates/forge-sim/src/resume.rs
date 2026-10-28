//! Resumable route searches: `forge build`'s routes stage and `forge sim route` checkpoint their
//! searches, so a killed run (out of memory, a reboot) resumes where it was instead of from the seed.
//!
//! One directory per run, for one key (forge build: the routes stage key, which names the inputs and
//! the forge binary; `forge sim route`: its arguments, inputs and binary). A directory holding another
//! key's checkpoints is emptied when opened, and every file carries the key again, so no checkpoint
//! of other inputs is read. Per search unit (a start's own route, a faction's shared tail) the parts:
//! - `free`: the free search's members at a meeting (FreeCk), saved every `every` and after the last
//!   round; resumed members play on exactly as the uninterrupted search's would (a member is its
//!   order, generator and counters: its runs are replayed from the order, as each kept move made them);
//! - `descent`: the edits the descent kept so far (DescentCk), replayed on resume (one exact replay
//!   each, no estimates) and checked against the hours each reached;
//! - `done`: the finished search (the order and edit list the route is finished and written from).
//!
//! Files are written whole (a temporary file synced, then renamed), so a kill mid-write leaves the
//! previous checkpoint.

use crate::order::Order;
use crate::search::Stats;
use crate::Step;
use serde::de::DeserializeOwned;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::hash::{Hash, Hasher};
use std::io::Write;
use std::path::{Path, PathBuf};
use std::sync::Mutex;
use std::time::Duration;

/// Seconds between a search's checkpoints.
pub const EVERY_SEC: u64 = 120;
/// The key file of a checkpoint directory.
const KEY_FILE: &str = "KEY";
/// The parts of a unit.
pub const FREE: &str = "free";
pub const DESCENT: &str = "descent";
pub const DONE: &str = "done";

/// A run's checkpoints: `dir`, for `key`.
pub struct Resume {
	dir: PathBuf,
	key: String,
	/// Time between a search's checkpoints (EVERY_SEC; tests: zero, every meeting and edit).
	pub every: Duration,
	notes: Mutex<Vec<String>>,
}

impl Resume {
	/// The checkpoints under `dir` for `key`; a directory holding another key's is emptied first.
	pub fn open(dir: &Path, key: &str) -> Result<Resume, String> {
		let kf = dir.join(KEY_FILE);
		if std::fs::read_to_string(&kf).ok().as_deref().map(str::trim) != Some(key) {
			if dir.exists() {
				std::fs::remove_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
			}
			std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
			std::fs::write(&kf, key).map_err(|e| format!("{}: {e}", kf.display()))?;
		}
		Ok(Resume { dir: dir.to_path_buf(), key: key.to_string(), every: Duration::from_secs(EVERY_SEC), notes: Mutex::new(Vec::new()) })
	}

	pub fn dir(&self) -> &Path {
		&self.dir
	}

	/// A search unit's checkpoints (`name`: a start, `own-<start>`, `shared-<faction>`).
	pub fn unit(&self, name: &str) -> Unit<'_> {
		Unit { r: self, name: name.to_string() }
	}

	/// What was resumed, in the order it was (each also on stderr when it happens).
	pub fn notes(&self) -> Vec<String> {
		self.notes.lock().map(|n| n.clone()).unwrap_or_default()
	}

	/// The run finished: its checkpoints go.
	pub fn clear(&self) -> Result<(), String> {
		match std::fs::remove_dir_all(&self.dir) {
			Ok(()) => Ok(()),
			Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(()),
			Err(e) => Err(format!("{}: {e}", self.dir.display())),
		}
	}
}

/// One search unit's checkpoints.
pub struct Unit<'a> {
	r: &'a Resume,
	pub name: String,
}

#[derive(Serialize, Deserialize)]
struct File<T> {
	key: String,
	unit: String,
	part: String,
	data: T,
}

impl Unit<'_> {
	fn path(&self, part: &str) -> PathBuf {
		self.r.dir.join(format!("{}.{part}.json", self.name))
	}

	pub fn every(&self) -> Duration {
		self.r.every
	}

	/// A part saved under this run's key (None: none, another key's, or unreadable).
	pub fn load<T: DeserializeOwned>(&self, part: &str) -> Option<T> {
		let b = std::fs::read(self.path(part)).ok()?;
		let f: File<T> = serde_json::from_slice(&b).ok()?;
		(f.key == self.r.key && f.unit == self.name && f.part == part).then_some(f.data)
	}

	/// Save a part (a checkpoint that cannot be written costs only the resume: a warning).
	pub fn save<T: Serialize>(&self, part: &str, data: &T) {
		let p = self.path(part);
		let tmp = p.with_extension("json.tmp");
		let doc = File { key: self.r.key.clone(), unit: self.name.clone(), part: part.to_string(), data };
		let res = (|| -> std::io::Result<()> {
			let mut f = std::fs::File::create(&tmp)?;
			serde_json::to_writer(&mut f, &doc).map_err(std::io::Error::other)?;
			f.flush()?;
			f.sync_all()?;
			std::fs::rename(&tmp, &p)
		})();
		if let Err(e) = res {
			eprintln!("warning: checkpoint {}: {e}", p.display());
		}
	}

	/// Note a resume (stderr and Resume::notes).
	pub fn note(&self, s: String) {
		eprintln!("{s}");
		if let Ok(mut n) = self.r.notes.lock() {
			n.push(s);
		}
	}
}

/// An order as saved: its steps as [kind, q, task, pt] and their origins.
#[derive(Clone, Serialize, Deserialize)]
pub struct OrderCk {
	steps: Vec<(u8, u32, i32, u32)>,
	origin: Vec<i64>,
}

impl From<&Order> for OrderCk {
	fn from(o: &Order) -> OrderCk {
		OrderCk { steps: o.steps.iter().map(|s| (s.kind, s.q, s.task, s.pt)).collect(), origin: o.origin.clone() }
	}
}

impl From<OrderCk> for Order {
	fn from(o: OrderCk) -> Order {
		Order { steps: o.steps.into_iter().map(|(kind, q, task, pt)| Step { kind, q, task, pt }).collect(), origin: o.origin }
	}
}

/// What a checkpoint was made from: the seed order and the settings that shape the search (a
/// mismatch means another search; the key covers this in a build, the check is belt and braces).
pub fn fit(seed: &Order, settings: &[u64]) -> u64 {
	let mut h = rustc_hash::FxHasher::default();
	seed.steps.hash(&mut h);
	seed.origin.hash(&mut h);
	settings.hash(&mut h);
	h.finish()
}

/// The free search at a meeting: rounds played, the distinct orders, and per member its order's
/// index, generator state and counters.
#[derive(Serialize, Deserialize)]
pub struct FreeCk {
	pub fit: u64,
	pub round: u64,
	pub orders: Vec<OrderCk>,
	pub members: Vec<(usize, u64, Stats)>,
}

/// One kept edit of the descent: its candidate's index among the candidates of the order before it,
/// its exact gain, and the hours to 60 after it (the replay's check).
#[derive(Clone, Serialize, Deserialize)]
pub struct Pick {
	pub cand: usize,
	pub gain: f64,
	pub hours: f64,
}

/// The descent so far: its edits, and whether it ended (no edit left that saves enough).
#[derive(Serialize, Deserialize)]
pub struct DescentCk {
	pub fit: u64,
	pub picks: Vec<Pick>,
	pub ended: bool,
}

/// A finished search: the order and edit list the route is finished from (route::finish), the
/// pickup pass's refusals, the free search's counters and the search's seconds.
#[derive(Serialize, Deserialize)]
pub struct DoneCk {
	pub best: OrderCk,
	pub edits: Value,
	pub refused: Vec<(u32, String)>,
	pub stats: Stats,
	pub seconds: f64,
}
