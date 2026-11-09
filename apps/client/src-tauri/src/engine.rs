//! The client's heart: finds the game, watches each WoW account's
//! `SavedVariables/Polestar_Recorder.lua`, uploads new chunks, writes the
//! addon's ack file and publishes a status snapshot to the window and tray.
//!
//! One background task owns the loop (`run`); commands from the window read
//! and change the shared [`State`] under a short lock and wake the loop.

use std::collections::{BTreeMap, BTreeSet};
use std::fs;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex, MutexGuard};
use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

use polestar_recording::{ack, api, install, record, scrub, summary, sv};
use serde::Serialize;
use sha2::{Digest, Sha256};
use tauri::{AppHandle, Emitter};
use tokio::sync::Notify;

use crate::addons;
use crate::net::Family;
use crate::register;
use crate::store::{ActivityEntry, ActivityKind, Progress, Rejection, SentChunk, Settings, Store};
use crate::update::Available;

/// How often the SavedVariables files are looked at.
const POLL: Duration = Duration::from_secs(5);
/// A changed file is read once it has been still for this long (the game
/// writes it in one go at logout or /reload, but a sync tool may not).
const DEBOUNCE: Duration = Duration::from_secs(3);
/// The server's limit for one request body.
const MAX_BODY: usize = api::MAX_UPLOAD_BYTES;
const RESCAN: Duration = Duration::from_secs(60);
const PROCESS_CHECK: Duration = Duration::from_secs(15);
const BACKOFF_MIN: u64 = 5;
const BACKOFF_MAX: u64 = 300;
/// The longest a 503's `Retry-After` is waited out.
const RETRY_AFTER_503_MAX: u64 = 24 * 3600;
/// The most of a server answer read (the answers are a few KB of JSON at most).
const MAX_ANSWER: usize = 64 * 1024;
/// After the server refuses a request outright, try again this rarely on its own.
const REFUSED_RETRY: u64 = 30 * 60;
/// How long the "server turned some data away" status stays up.
const REJECTED_SHOWN_MS: i64 = 24 * 3600 * 1000;
/// How often addon updates are looked for when that is on.
const ADDON_CHECK: Duration = Duration::from_secs(6 * 3600);
/// The 401 answer to a token the server does not know (deleted, or never registered).
pub const UNKNOWN_TOKEN: &str = "unknown token";

pub fn now_ms() -> i64 {
	SystemTime::now().duration_since(UNIX_EPOCH).map(|d| d.as_millis() as i64).unwrap_or(0)
}

/// One WoW account folder and what was last read from its file.
struct Account {
	folder_name: String,
	sv_path: PathBuf,
	char_names: Vec<String>,
	seen: Option<(SystemTime, u64)>,
	hash: Option<[u8; 32]>,
	changed_at: Option<Instant>,
	sv: Option<Arc<sv::SavedVars>>,
	error: Option<sv::Error>,
}

impl Account {
	fn new(account: &install::Account) -> Account {
		Account {
			folder_name: account.folder_name.clone(),
			sv_path: account.sv_path.clone(),
			char_names: account.char_names.clone(),
			seen: None,
			hash: None,
			changed_at: None,
			sv: None,
			error: None,
		}
	}
}

#[derive(Clone, Debug)]
enum Failure {
	/// No answer, or a server error: try again with backoff.
	Offline { message: String, attempts: u32, retry_at: i64 },
	/// The server answered and refused the request as a whole.
	Refused { message: String, retry_at: i64 },
}

impl Failure {
	fn retry_at(&self) -> i64 {
		match self {
			Failure::Offline { retry_at, .. } | Failure::Refused { retry_at, .. } => *retry_at,
		}
	}
}

/// Why one request to the server did not give its answer.
enum Failed {
	/// No answer, or one that could not be read.
	Offline(String),
	/// A non-success status, its `Retry-After` and the server's message.
	Status(reqwest::StatusCode, Option<u64>, String),
}

pub struct State {
	pub settings: Settings,
	progress: Progress,
	candidates: Vec<install::Install>,
	pub(crate) install: Option<install::Install>,
	/// The chosen folder and why it is not usable.
	problem: Option<(PathBuf, install::FolderProblem)>,
	/// The first scan for the game has finished.
	scanned: bool,
	accounts: Vec<Account>,
	pub(crate) game_running: bool,
	uploading: Option<usize>,
	/// Getting a token from the server (solving its proof of work).
	registering: bool,
	failure: Option<Failure>,
	rejected: Option<(i64, Vec<Rejection>)>,
	last_upload: Option<i64>,
	week: Option<serde_json::Value>,
	week_dirty: bool,
	/// The newest release of each addon, from the last check.
	pub catalog: Option<Catalog>,
	pub catalog_error: Option<String>,
	pub checking: bool,
	/// Addon operations under way: product id -> what ("install", "update", …).
	pub busy: BTreeMap<&'static str, &'static str>,
	/// How far each of those has got.
	pub addon_progress: BTreeMap<&'static str, addons::Progress>,
	/// Updates already announced in the tray (`<product> <version>`).
	pub notified: BTreeSet<String>,
	pub update: Option<Available>,
	/// The community packs: the site's index, what is installed, actions under way, the last link.
	pub packs: crate::community::Packs,
	rescan: bool,
	last_emitted: String,
	/// Chunks over the server's caps, logged once each and never sent.
	skipped: BTreeSet<(String, u64)>,
}

pub struct Engine {
	app: AppHandle,
	pub store: Store,
	/// The HTTP clients and the connection fallback ladder (net.rs).
	pub net: crate::net::Net,
	state: Mutex<State>,
	kick: Notify,
}

impl Engine {
	pub fn new(app: AppHandle, store: Store) -> Result<Arc<Engine>, String> {
		let net = crate::net::Net::new();
		let activity = store.activity();
		let last_upload = activity.iter().find(|a| matches!(a.kind, ActivityKind::Upload)).map(|a| a.at);
		let rejected = activity.first().filter(|a| matches!(a.kind, ActivityKind::Upload) && !a.rejected.is_empty()).map(|a| (a.at, a.rejected.clone()));
		let settings = store.settings();
		let packs = crate::community::Packs::load(&store, &settings.packs_url);
		let state = State {
			settings,
			progress: store.progress(),
			candidates: Vec::new(),
			install: None,
			problem: None,
			scanned: false,
			accounts: Vec::new(),
			game_running: false,
			uploading: None,
			registering: false,
			failure: None,
			rejected,
			last_upload,
			week: None,
			week_dirty: true,
			catalog: None,
			catalog_error: None,
			checking: false,
			busy: BTreeMap::new(),
			addon_progress: BTreeMap::new(),
			notified: BTreeSet::new(),
			update: None,
			packs,
			rescan: true,
			last_emitted: String::new(),
			skipped: BTreeSet::new(),
		};
		Ok(Arc::new(Engine { app, store, net, state: Mutex::new(state), kick: Notify::new() }))
	}

	/// The client for addon releases, update checks and other plain requests, on the rung in use.
	pub fn http(&self) -> reqwest::Client {
		self.net.client(Family::Api)
	}

	/// For the community site: redirects only within its origin (packs.rs `redirect_policy`).
	pub fn packs_http(&self) -> reqwest::Client {
		self.net.client(Family::Packs)
	}

	pub fn app(&self) -> &AppHandle {
		&self.app
	}

	pub fn lock(&self) -> MutexGuard<'_, State> {
		self.state.lock().unwrap_or_else(|e| e.into_inner())
	}

	/// Wakes the loop now (after a setting changed, or for "Try again").
	pub fn wake(&self) {
		self.kick.notify_one();
	}

	/// Forgets the cached install so the next tick finds the game again.
	pub fn rescan(&self) {
		self.lock().rescan = true;
		self.wake();
	}

	/// The server address in use, without a trailing slash (the key of its token).
	pub fn server(&self) -> String {
		self.lock().settings.server_url.trim_end_matches('/').to_owned()
	}

	/// Changes and saves the settings, then tells the Recorder whether the player shares.
	pub fn save_settings(&self, change: impl FnOnce(&mut Settings)) -> Result<(), String> {
		let mut state = self.lock();
		change(&mut state.settings);
		self.store.save_settings(&state.settings).map_err(|e| format!("Could not save settings: {e}"))?;
		drop(state);
		self.sync_share();
		self.wake();
		Ok(())
	}

	/// Clears a backoff so the next tick tries straight away.
	pub fn retry_now(&self) {
		self.lock().failure = None;
		self.wake();
	}

	/// The loop: never returns.
	pub async fn run(self: Arc<Engine>) {
		let mut processes = sysinfo::System::new();
		let mut last_process_check: Option<Instant> = None;
		let mut last_scan: Option<Instant> = None;
		let mut last_addon_check: Option<Instant> = None;
		loop {
			if last_process_check.is_none_or(|t| t.elapsed() >= PROCESS_CHECK) {
				let running = game_running(&mut processes);
				self.lock().game_running = running;
				last_process_check = Some(Instant::now());
			}
			let force = std::mem::take(&mut self.lock().rescan);
			if force || last_scan.is_none_or(|t| t.elapsed() >= RESCAN) {
				self.scan().await;
				self.sync_share();
				self.refresh_packs();
				// Before any upload (which can take a while): the window shows what was found now.
				self.publish();
				last_scan = Some(Instant::now());
			}
			let (auto, poll) = {
				let state = self.lock();
				let auto = state.settings.auto_check;
				(auto, crate::community::background_poll(auto, state.packs.installed.len()))
			};
			if (auto || poll.is_some()) && last_addon_check.is_none_or(|t| t.elapsed() >= ADDON_CHECK) {
				last_addon_check = Some(Instant::now());
				let engine = Arc::clone(&self);
				tauri::async_runtime::spawn(async move {
					if auto {
						engine.check_addons(true).await;
					}
					if let Some(updates) = poll {
						engine.check_packs(updates).await;
					}
				});
			}
			let soon = self.poll_files();
			self.default_share();
			self.refresh_week();
			self.upload_pending().await;
			self.publish();
			let wait = if soon { DEBOUNCE } else { POLL };
			let _ = tokio::time::timeout(wait, self.kick.notified()).await;
		}
	}

	/// Finds the game: the folder the player chose, else the first detected install.
	async fn scan(&self) {
		let folder = self.lock().settings.wow_folder.clone();
		let (candidates, chosen) = tauri::async_runtime::spawn_blocking(move || {
			let candidates = install::find_installs();
			let chosen = folder.map(|f| install::check_folder(&f).map_err(|p| (f, p)));
			(candidates, chosen)
		})
		.await
		.unwrap_or_default();
		let mut state = self.lock();
		let (install, problem) = match chosen {
			Some(Ok(install)) => (Some(install), None),
			Some(Err(problem)) => (None, Some(problem)),
			None => (candidates.first().cloned(), None),
		};
		// Keep what was read from files that are still there.
		let old: BTreeMap<PathBuf, Account> = state.accounts.drain(..).map(|a| (a.sv_path.clone(), a)).collect();
		let mut old = old;
		state.accounts = install
			.as_ref()
			.map(|i| {
				i.accounts
					.iter()
					.map(|a| {
						let mut account = old.remove(&a.sv_path).unwrap_or_else(|| Account::new(a));
						account.char_names = a.char_names.clone();
						account
					})
					.collect()
			})
			.unwrap_or_default();
		state.candidates = candidates;
		state.install = install;
		state.problem = problem;
		state.scanned = true;
	}

	/// Reads changed files once they have been still for [`DEBOUNCE`].
	/// Returns true while a change is waiting to settle.
	fn poll_files(&self) -> bool {
		let mut state = self.lock();
		let mut waiting = false;
		let mut changed = false;
		for account in &mut state.accounts {
			let meta = fs::metadata(&account.sv_path).ok();
			let seen = meta.as_ref().map(|m| (m.modified().unwrap_or(UNIX_EPOCH), m.len()));
			let Some(seen) = seen else {
				if account.sv.is_some() || account.error.is_some() || account.seen.is_some() {
					*account = Account { char_names: std::mem::take(&mut account.char_names), ..Account::new_empty(&account.folder_name, &account.sv_path) };
					changed = true;
				}
				continue;
			};
			if account.seen != Some(seen) {
				account.seen = Some(seen);
				account.changed_at = Some(Instant::now());
			}
			let Some(at) = account.changed_at else { continue };
			if at.elapsed() < DEBOUNCE && account.hash.is_some() {
				waiting = true;
				continue;
			}
			account.changed_at = None;
			let Ok(bytes) = fs::read(&account.sv_path) else { continue };
			let hash: [u8; 32] = Sha256::digest(&bytes).into();
			if account.hash == Some(hash) {
				continue;
			}
			account.hash = Some(hash);
			let text = String::from_utf8_lossy(&bytes);
			match sv::parse(&text) {
				Ok(vars) => {
					account.sv = Some(Arc::new(vars));
					account.error = None;
				}
				Err(e) => {
					account.sv = None;
					account.error = Some(e);
				}
			}
			changed = true;
		}
		drop(state);
		if changed {
			self.wake();
		}
		waiting
	}

	/// Recomputes this week's contribution from the local cache of accepted chunks.
	fn refresh_week(&self) {
		if !std::mem::take(&mut self.lock().week_dirty) {
			return;
		}
		let now = now_ms();
		let week_ago = now - 7 * 24 * 3600 * 1000;
		let chunks: Vec<record::Chunk> = self.store.sent(now).iter().filter(|c| c.at >= week_ago).filter_map(|c| record::decode_chunk(&c.text).ok()).collect();
		let maps = self.maps();
		let week = (!chunks.is_empty()).then(|| serde_json::to_value(summary::summarize_with_maps(&chunks, &maps)).unwrap_or_default());
		self.lock().week = week;
	}

	/// Every map the Recorder has described, from all accounts (for distances).
	fn maps(&self) -> BTreeMap<u32, String> {
		let state = self.lock();
		state.accounts.iter().filter_map(|a| a.sv.as_deref()).flat_map(|v| v.maps.iter().map(|(k, v)| (*k, v.clone()))).collect()
	}

	/// The chunks each account would send next, scrubbed, in request-sized batches.
	pub fn pending(&self) -> Vec<Batch> {
		let mut state = self.lock();
		let state = &mut *state;
		let mut batches = Vec::new();
		for account in &state.accounts {
			let Some(vars) = &account.sv else { continue };
			let done = state.progress.get(&vars.install).map(|p| p.uploaded).unwrap_or(0);
			let mut batch = Batch::new(account, &vars.install);
			for (&seq, text) in vars.chunks.range(done + 1..) {
				let text = match prepare_chunk(text, &account.char_names) {
					Ok(text) => text,
					Err(why) => {
						if state.skipped.insert((vars.install.clone(), seq)) {
							eprintln!("not sending chunk {seq} of {}: {why}", vars.install);
						}
						continue;
					}
				};
				let size = serde_json::to_string(&text).map(|s| s.len()).unwrap_or(text.len()) + 32;
				if (batch.size + size > MAX_BODY - 1024 || batch.chunks.len() >= api::MAX_UPLOAD_CHUNKS) && !batch.chunks.is_empty() {
					batches.push(std::mem::replace(&mut batch, Batch::new(account, &vars.install)));
				}
				batch.size += size;
				batch.chunks.push(api::UploadChunk { seq, text });
			}
			if !batch.chunks.is_empty() {
				batches.push(batch);
			}
		}
		batches
	}

	async fn upload_pending(&self) {
		{
			let state = self.lock();
			let blocked = state.failure.as_ref().is_some_and(|f| f.retry_at() > now_ms());
			if !state.settings.consent || state.settings.paused || blocked || state.install.is_none() {
				return;
			}
		}
		let batches = self.pending();
		if batches.is_empty() {
			return;
		}
		let server = self.server();
		let token = match self.store.token(&server) {
			Some(token) => token,
			None => match self.register(&server).await {
				Some(token) => token,
				None => return,
			},
		};
		let total: usize = batches.iter().map(|b| b.chunks.len()).sum();
		self.lock().uploading = Some(total);
		self.publish();
		for batch in batches {
			if !self.send(batch, &server, &token).await {
				break;
			}
		}
		self.lock().uploading = None;
	}

	/// Gets this PC a token from `server` (the first upload, or after the server forgot the
	/// last one): asks for a challenge, solves its proof of work on every core and keeps the
	/// token the server answers with. None when uploading has to wait; the failure says why.
	async fn register(&self, server: &str) -> Option<String> {
		self.lock().registering = true;
		self.publish();
		let token = self.solve_registration(server).await;
		self.lock().registering = false;
		token
	}

	/// A challenge that expired or was used while this PC solved it is fetched again straight
	/// away, up to [`register::TRIES`] challenges in a row; then the usual backoff.
	async fn solve_registration(&self, server: &str) -> Option<String> {
		let url = format!("{server}/v1/register");
		let hex = |s: &str, len: usize| s.len() == len && s.bytes().all(|b| b.is_ascii_hexdigit());
		let mut tries = 0;
		let answer: api::RegisterResponse = loop {
			tries += 1;
			let challenge: api::RegisterChallenge = match self.post_json(&url, &serde_json::json!({})).await {
				Ok(c) => c,
				Err(f) => return self.record(f),
			};
			if !hex(&challenge.challenge, 32) || challenge.difficulty > register::MAX_DIFFICULTY {
				self.refuse(format!("The server asked for a setup this client does not do (a {}-bit proof of work).", challenge.difficulty));
				return None;
			}
			let (text, bits) = (challenge.challenge.clone(), challenge.difficulty);
			let solution = match tauri::async_runtime::spawn_blocking(move || register::solve(&text, bits)).await {
				Ok(n) => n,
				Err(e) => {
					self.refuse(format!("Setting up failed: {e}"));
					return None;
				}
			};
			match self.post_json(&url, &api::RegisterSolution { challenge: challenge.challenge, solution: solution.to_string() }).await {
				Ok(a) => break a,
				Err(Failed::Status(status, _, message)) if tries < register::TRIES && register::stale(status.as_u16(), &message) => continue,
				Err(f) => return self.record(f),
			}
		};
		if !hex(&answer.token, 64) {
			self.refuse("The server's token could not be read.".to_owned());
			return None;
		}
		if let Err(e) = self.store.save_token(server, &answer.token) {
			self.refuse(format!("Could not keep the token in {}: {e}", self.store.dir.display()));
			return None;
		}
		Some(answer.token)
	}

	/// POSTs `body` as JSON and reads the JSON answer.
	async fn post_json<T: serde::de::DeserializeOwned>(&self, url: &str, body: &impl Serialize) -> Result<T, Failed> {
		let body = bytes::Bytes::from(serde_json::to_vec(body).map_err(|e| Failed::Offline(e.to_string()))?);
		let response = self.net.send(Family::Api, |c| c.post(url).header("Content-Type", "application/json").body(body.clone())).await.map_err(|e| Failed::Offline(describe_reqwest(&e)))?;
		let status = response.status();
		if !status.is_success() {
			let retry_after = retry_after(&response);
			let message = server_message(response).await.unwrap_or_else(|| not_from_server(status));
			return Err(Failed::Status(status, retry_after, message));
		}
		read_answer(response).await.map_err(Failed::Offline)
	}

	/// Records a failed request (see [`Engine::fail_status`]); None, for the caller to return.
	fn record<T>(&self, failed: Failed) -> Option<T> {
		match failed {
			Failed::Offline(message) => self.fail_offline(message, None),
			Failed::Status(status, retry_after, message) => {
				self.fail_status(status, retry_after, message);
			}
		}
		None
	}

	/// Sends one request; false when the rest should wait (offline, refused, a new token needed).
	async fn send(&self, batch: Batch, server: &str, token: &str) -> bool {
		let request = api::UploadRequest { uploader: env!("CARGO_PKG_VERSION").to_owned(), install: batch.install.clone(), chunks: batch.chunks };
		let body = match serde_json::to_vec(&request) {
			Ok(body) => bytes::Bytes::from(body),
			Err(e) => {
				eprintln!("could not encode upload: {e}");
				return false;
			}
		};
		let bytes = body.len() as u64;
		let records = request.chunks.iter().map(|c| c.text.lines().count().saturating_sub(1) as u32).sum();
		let max_seq = request.chunks.iter().map(|c| c.seq).max().unwrap_or(0);
		let url = format!("{server}/v1/upload");
		let result = self.net.send(Family::Api, |c| c.post(&url).bearer_auth(token).header("Content-Type", "application/json").body(body.clone())).await;
		let now = now_ms();
		let response = match result {
			Ok(r) => r,
			Err(e) => {
				self.fail_offline(describe_reqwest(&e), None);
				return false;
			}
		};
		let status = response.status();
		if !status.is_success() {
			let retry_after = retry_after(&response);
			let message = server_message(response).await;
			if status == reqwest::StatusCode::UNAUTHORIZED && message.as_deref() == Some(UNKNOWN_TOKEN) {
				// The server no longer knows this token: the next tick registers again.
				if let Err(e) = self.store.drop_token(server) {
					eprintln!("could not forget the token: {e}");
				}
				self.wake();
				return false;
			}
			let message = message.unwrap_or_else(|| not_from_server(status));
			if self.fail_status(status, retry_after, message.clone()) {
				let _ = self.store.push_activity(ActivityEntry {
					kind: ActivityKind::Failed,
					at: now,
					account: batch.account,
					chunks: request.chunks.len() as u32,
					records,
					bytes,
					message: Some(message),
					..Default::default()
				});
			}
			return false;
		}
		let answer: api::UploadResponse = match read_answer(response).await {
			Ok(a) => a,
			Err(e) => {
				self.fail_offline(e, None);
				return false;
			}
		};
		let rejected: Vec<Rejection> = answer.rejected.iter().map(|r| Rejection { seq: r.seq, reason: r.reason.clone() }).collect();
		let confirmed = confirmed_ack(&request.chunks, &answer.accepted, &answer.duplicate);
		let sent: Vec<SentChunk> = request
			.chunks
			.iter()
			.filter(|c| answer.accepted.contains(&c.seq))
			.map(|c| SentChunk { at: now, install: request.install.clone(), seq: c.seq, text: c.text.clone() })
			.collect();
		if let Err(e) = self.store.push_sent(&sent, now) {
			eprintln!("could not keep the week's chunks: {e}");
		}
		let mut state = self.lock();
		let progress = state.progress.entry(request.install.clone()).or_default();
		progress.uploaded = progress.uploaded.max(max_seq);
		if let Some(c) = confirmed {
			progress.acked = progress.acked.max(c);
		}
		progress.last_at = now;
		let acked = progress.acked;
		let _ = self.store.save_progress(&state.progress);
		state.failure = None;
		state.last_upload = Some(now);
		state.week_dirty = true;
		state.rejected = (!rejected.is_empty()).then(|| (now, rejected.clone()));
		let addon_dir = state.install.as_ref().and_then(|i| i.addon_dir.clone());
		let share = sharing(&state.settings);
		drop(state);
		if let (Some(dir), true) = (addon_dir, acked > 0) {
			if let Err(e) = ack::write(&dir, &request.install, acked, share) {
				eprintln!("could not write Ack.lua: {e}");
			}
		}
		let _ = self.store.push_activity(ActivityEntry {
			kind: ActivityKind::Upload,
			at: now,
			account: batch.account,
			chunks: request.chunks.len() as u32,
			records,
			bytes,
			accepted: answer.accepted,
			duplicate: answer.duplicate,
			rejected,
			..Default::default()
		});
		true
	}

	fn fail_offline(&self, message: String, retry_after: Option<u64>) {
		// Also on stderr: a player running the client from a terminal can quote it.
		eprintln!("upload: {message}");
		let mut state = self.lock();
		let attempts = match &state.failure {
			Some(Failure::Offline { attempts, .. }) => attempts + 1,
			_ => 0,
		};
		let backoff = backoff_secs(attempts, retry_after);
		state.failure = Some(Failure::Offline { message, attempts, retry_at: now_ms().saturating_add(backoff as i64 * 1000) });
	}

	/// Records a non-success answer: a server error or 429 is retried with backoff, anything
	/// else is refused. Returns whether it was refused.
	fn fail_status(&self, status: reqwest::StatusCode, retry_after: Option<u64>, message: String) -> bool {
		if is_temporary(status) {
			self.fail_offline(message, retry_after);
			false
		} else {
			self.refuse(message);
			true
		}
	}

	fn refuse(&self, message: String) {
		self.lock().failure = Some(Failure::Refused { message, retry_at: now_ms() + REFUSED_RETRY as i64 * 1000 });
	}

	/// Writes Ack.lua again for every install the server confirmed chunks of
	/// (after the Recorder was reinstalled, which ships it empty), and the share
	/// flag. `ack::write` merges each install into the file's per-install map.
	pub fn rewrite_ack(&self) {
		let state = self.lock();
		let Some(dir) = state.install.as_ref().map(|i| i.addons_dir().join(install::ADDON)) else { return };
		let acks: Vec<(String, u64)> = state.progress.iter().filter(|(_, p)| p.acked > 0).map(|(i, p)| (i.clone(), p.acked)).collect();
		let share = sharing(&state.settings);
		drop(state);
		if !dir.is_dir() {
			return;
		}
		for (install, upto) in acks {
			if let Err(e) = ack::write(&dir, &install, upto, share) {
				eprintln!("could not write Ack.lua: {e}");
			}
		}
		self.sync_share();
	}

	/// Sharing is on by default: turns it on, as Start sharing does, for a player who never chose
	/// ([`share_by_default`]); the window's notice then says what is shared, with Stop sharing.
	/// Called right after `poll_files`, so every account's file has been looked at.
	fn default_share(&self) {
		let state = self.lock();
		let on = share_by_default(&state.settings, state.install.is_some(), &state.accounts);
		drop(state);
		if !on {
			return;
		}
		let result = self.save_settings(|s| {
			s.consent = true;
			s.ever_shared = true;
			s.consent_at = Some(now_ms());
			s.paused = false;
		});
		match result {
			Ok(()) => eprintln!("sharing is on by default (never chosen, no /psrec off)"),
			Err(e) => eprintln!("{e}"),
		}
	}

	/// Puts the share flag in Ack.lua when the file does not say it already: the Recorder records
	/// while the player shares (docs/RECORDING.md "Ack file"). Called when the settings change
	/// and after every look for the game (which also catches a Recorder reinstalled by hand).
	fn sync_share(&self) {
		let state = self.lock();
		let Some(dir) = state.install.as_ref().map(|i| i.addons_dir().join(install::ADDON)) else { return };
		let Some(share) = sharing(&state.settings) else { return };
		drop(state);
		if !dir.is_dir() {
			return;
		}
		if ack::read_share(&dir) != Some(share) {
			if let Err(e) = ack::write_share(&dir, share) {
				eprintln!("could not write Ack.lua: {e}");
			}
		}
	}

	/// After the player deleted their data from `server`: its token dropped (the
	/// next upload registers anew), no week cache, uploads paused. Progress
	/// stays, so chunks the server held are never sent again.
	pub fn forget_server_data(&self, server: &str) -> Result<(), String> {
		self.store.drop_token(server).map_err(|e| format!("Could not forget the token: {e}"))?;
		let _ = self.store.clear_sent();
		let _ = self.store.push_activity(ActivityEntry { kind: ActivityKind::Deleted, at: now_ms(), ..Default::default() });
		{
			let mut state = self.lock();
			state.week_dirty = true;
			state.rejected = None;
			state.last_upload = None;
			state.failure = None;
		}
		self.save_settings(|s| s.paused = true)
	}

	/// Emits the snapshot to the window and the tray when it changed.
	pub fn publish(&self) {
		let snapshot = self.snapshot();
		let json = serde_json::to_string(&snapshot).unwrap_or_default();
		{
			let mut state = self.lock();
			if state.last_emitted == json {
				return;
			}
			state.last_emitted = json;
		}
		crate::tray::update(&self.app, &snapshot);
		let _ = self.app.emit("snapshot", &snapshot);
	}

	pub fn snapshot(&self) -> Snapshot {
		let state = self.lock();
		let now = now_ms();
		let recorder_latest = state.catalog.as_ref().and_then(|c| c.latest("recorder")).map(|r| r.version.clone());
		let addon = state.install.as_ref().map(|i| AddonView {
			installed: i.addon_dir.is_some(),
			version: i.addon_version.clone(),
			latest: recorder_latest.clone(),
			update_available: match (&i.addon_version, &recorder_latest) {
				(Some(have), Some(latest)) => addons::newer(latest, have),
				(None, Some(_)) => i.addon_dir.is_some(),
				_ => false,
			},
		});
		let accounts: Vec<AccountView> = state
			.accounts
			.iter()
			.map(|a| {
				let vars = a.sv.as_deref();
				let done = vars.and_then(|v| state.progress.get(&v.install)).map(|p| p.uploaded).unwrap_or(0);
				AccountView {
					name: a.folder_name.clone(),
					has_file: a.seen.is_some(),
					recording: vars.map(|v| v.enabled),
					pending: vars.map(|v| v.chunks.range(done + 1..).count() as u64).unwrap_or(0),
					characters: a.char_names.len(),
					problem: a.error.as_ref().filter(|e| !matches!(e, sv::Error::Missing)).map(|e| e.to_string()),
				}
			})
			.collect();
		let game = GameView {
			found: state.install.is_some(),
			scanned: state.scanned,
			root: state.install.as_ref().map(|i| i.root.display().to_string()),
			dir: state.install.as_ref().map(|i| i.flavor_dir.display().to_string()),
			game_version: state.install.as_ref().and_then(|i| i.version.clone()),
			chosen: state.settings.wow_folder.as_ref().map(|p| p.display().to_string()),
			problem: state.problem.as_ref().map(|(path, p)| FolderProblemView { path: path.display().to_string(), message: p.to_string() }),
			candidates: state
				.candidates
				.iter()
				.map(|i| CandidateView {
					root: i.root.display().to_string(),
					dir: i.flavor_dir.display().to_string(),
					client: i.flavor_dir.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default(),
					version: i.version.clone(),
					accounts: i.accounts.len(),
					addon_version: i.addon_version.clone(),
				})
				.collect(),
			addon,
			accounts,
			running: state.game_running,
		};
		let pending: u64 = game.accounts.iter().map(|a| a.pending).sum();
		let mut status = status(&state, &game, pending, now);
		// Which way of connecting is in use, while uploads go through.
		if let (Some(note), None, true) = (self.net.note(), &state.failure, state.settings.consent) {
			status.detail = format!("{} {note}", status.detail);
		}
		Snapshot {
			version: env!("CARGO_PKG_VERSION").to_owned(),
			setup_done: state.settings.setup_done || state.settings.consent,
			consent: state.settings.consent,
			share_notice: state.settings.consent && !state.settings.share_notice_seen,
			paused: state.settings.paused,
			server_url: state.settings.server_url.clone(),
			default_server_url: crate::store::DEFAULT_SERVER.to_owned(),
			custom: CustomSites {
				community: custom_site(&state.settings.packs_url, crate::packs::DEFAULT_BASE),
				server: custom_site(&state.settings.server_url, crate::store::DEFAULT_SERVER),
			},
			data_dir: self.store.dir.display().to_string(),
			game,
			status,
			pending,
			week: state.week.clone(),
			addons: crate::manager::view(&state),
			community: crate::community::view(&state),
			update: state.update.as_ref().map(|u| u.version.clone()),
		}
	}

	/// What the next upload holds: its summary, its records and the exact request bodies.
	pub fn preview(&self) -> Preview {
		let batches = self.pending();
		let reading = read_chunks(batches.iter().flat_map(|b| &b.chunks), "would be turned away");
		let requests: Vec<api::UploadRequest> =
			batches.iter().map(|b| api::UploadRequest { uploader: env!("CARGO_PKG_VERSION").to_owned(), install: b.install.clone(), chunks: b.chunks.clone() }).collect();
		let json = serde_json::to_string_pretty(&requests).unwrap_or_default();
		Preview {
			chunks: batches.iter().map(|b| b.chunks.len()).sum(),
			bytes: requests.iter().map(|r| serde_json::to_vec(r).map(|v| v.len()).unwrap_or(0)).sum(),
			requests: requests.len(),
			summary: (!reading.decoded.is_empty()).then(|| serde_json::to_value(summary::summarize_with_maps(&reading.decoded, &self.maps())).unwrap_or_default()),
			records: reading.rows,
			total_records: reading.total_records,
			problems: reading.problems,
			json,
		}
	}

	/// The uploads the server accepted that this PC still keeps (`sent.jsonl`: the last 8 days), newest first.
	pub fn sent_uploads(&self) -> Vec<SentUpload> {
		sent_uploads_of(&self.store.sent(now_ms()))
	}

	/// One of those uploads, for the window to show as it shows the next one. Its chunks are the
	/// text that left this PC. `json` leaves out the request's `uploader`, which isn't kept.
	pub fn sent_upload(&self, at: i64, install: &str) -> Preview {
		let chunks: Vec<api::UploadChunk> =
			self.store.sent(now_ms()).into_iter().filter(|c| c.at == at && c.install == install).map(|c| api::UploadChunk { seq: c.seq, text: c.text }).collect();
		let reading = read_chunks(chunks.iter(), "can't be read by this version");
		let bytes = request_bytes(install, &chunks);
		let json = serde_json::to_string_pretty(&serde_json::json!({ "install": install, "chunks": chunks })).unwrap_or_default();
		Preview {
			chunks: chunks.len(),
			bytes,
			requests: 1,
			summary: (!reading.decoded.is_empty()).then(|| serde_json::to_value(summary::summarize_with_maps(&reading.decoded, &self.maps())).unwrap_or_default()),
			records: reading.rows,
			total_records: reading.total_records,
			problems: reading.problems,
			json,
		}
	}
}

const PREVIEW_ROWS: usize = 5000;

/// Chunks read back into what `Preview` shows. `verdict` ends the line for a chunk that doesn't decode.
struct Reading {
	decoded: Vec<record::Chunk>,
	rows: Vec<RecordRow>,
	total_records: usize,
	problems: Vec<String>,
}

fn read_chunks<'a>(chunks: impl Iterator<Item = &'a api::UploadChunk>, verdict: &str) -> Reading {
	let mut reading = Reading { decoded: Vec::new(), rows: Vec::new(), total_records: 0, problems: Vec::new() };
	for chunk in chunks {
		match record::decode_chunk(&chunk.text) {
			Ok(decoded) => {
				reading.total_records += decoded.records.len();
				for r in &decoded.records {
					if reading.rows.len() < PREVIEW_ROWS {
						reading.rows.push(RecordRow { seq: chunk.seq, kind: r.kind.to_string(), t: r.t, fields: r.kind.field_names().into_iter().map(str::to_owned).zip(r.fields.iter().cloned()).collect() });
					}
				}
				reading.decoded.push(decoded);
			}
			Err(e) => reading.problems.push(format!("Chunk {} {verdict}: {e}", chunk.seq)),
		}
	}
	reading
}

/// Kept chunks as uploads, newest first: the chunks of one request share their `at` and `install`.
fn sent_uploads_of(chunks: &[SentChunk]) -> Vec<SentUpload> {
	let mut groups: BTreeMap<(std::cmp::Reverse<i64>, &str), Vec<&SentChunk>> = BTreeMap::new();
	for c in chunks {
		groups.entry((std::cmp::Reverse(c.at), &c.install)).or_default().push(c);
	}
	groups
		.into_iter()
		.map(|((at, install), group)| {
			let body: Vec<api::UploadChunk> = group.iter().map(|c| api::UploadChunk { seq: c.seq, text: c.text.clone() }).collect();
			SentUpload {
				at: at.0,
				install: install.to_owned(),
				chunks: group.len(),
				bytes: request_bytes(install, &body),
				// The first line of a chunk is its header; every other line is one record.
				records: group.iter().map(|c| c.text.lines().filter(|l| !l.is_empty()).count().saturating_sub(1)).sum(),
			}
		})
		.collect()
}

/// The size of the request body that carried these chunks, the size Activity gives the same upload.
/// The `uploader` it held isn't kept, so this client's version stands in for it.
fn request_bytes(install: &str, chunks: &[api::UploadChunk]) -> usize {
	serde_json::to_vec(&api::UploadRequest { uploader: env!("CARGO_PKG_VERSION").to_owned(), install: install.to_owned(), chunks: chunks.to_vec() }).map(|v| v.len()).unwrap_or(0)
}

impl Account {
	fn new_empty(folder_name: &str, sv_path: &Path) -> Account {
		Account { folder_name: folder_name.to_owned(), sv_path: sv_path.to_owned(), char_names: Vec::new(), seen: None, hash: None, changed_at: None, sv: None, error: None }
	}
}

pub struct Batch {
	account: String,
	install: String,
	size: usize,
	chunks: Vec<api::UploadChunk>,
}

impl Batch {
	fn new(account: &Account, install: &str) -> Batch {
		Batch { account: account.folder_name.clone(), install: install.to_owned(), size: 256, chunks: Vec::new() }
	}
}

/// What went wrong with a request that got no answer, with the underlying cause (a DNS failure,
/// a refused or reset connection, a TLS failure) and what to try. The server answers every request
/// it gets, so a connect failure is between this PC and the server: a firewall or antivirus
/// blocking Polestar Client, a VPN or proxy, or the network. Players saw only "check your
/// internet connection" while their browser was online.
pub(crate) fn describe_reqwest(e: &reqwest::Error) -> String {
	let cause = root_cause(e);
	if crate::net::clock_wrong(e) {
		crate::net::clock_message(now_ms() / 1000)
	} else if e.is_timeout() {
		"The server took too long to answer.".to_owned()
	} else if e.is_connect() {
		let check = e.url().map(|u| format!("{}/v1/stats", u.origin().ascii_serialization())).unwrap_or_else(|| "the recording server's address".to_owned());
		format!("Can't reach the recording server from this PC ({cause}). If your browser opens {check}, a firewall, antivirus, VPN or proxy is probably blocking Polestar Client: allow it there.")
	} else {
		format!("The request did not get through ({cause}).")
	}
}

/// A non-success answer without the recording server's `{"error": ...}`: it came from something
/// between this PC and the server (a proxy, a VPN, a network filter, the server's front end).
pub(crate) fn not_from_server(status: reqwest::StatusCode) -> String {
	format!("The answer was {status}, not from the recording server itself: a proxy, VPN or network filter on the way may be blocking it, or the server's front end is briefly down. Polestar Client keeps trying.")
}

/// The innermost error of a chain: "dns error: …", "Connection refused", "invalid peer certificate".
fn root_cause(e: &(dyn std::error::Error + 'static)) -> String {
	let mut inner: &(dyn std::error::Error + 'static) = e;
	while let Some(next) = inner.source() {
		inner = next;
	}
	inner.to_string()
}

/// The server's `{"error": ...}`, from at most [`MAX_ANSWER`] bytes of its answer.
pub(crate) async fn server_message(response: reqwest::Response) -> Option<String> {
	let value: serde_json::Value = serde_json::from_slice(&crate::packs::read_capped(response, MAX_ANSWER).await.ok()?).ok()?;
	value.get("error")?.as_str().map(str::to_owned)
}

/// A JSON answer, from at most [`MAX_ANSWER`] bytes.
async fn read_answer<T: serde::de::DeserializeOwned>(response: reqwest::Response) -> Result<T, String> {
	let body = crate::packs::read_capped(response, MAX_ANSWER).await.map_err(|e| format!("The server's answer could not be read: {e}"))?;
	serde_json::from_slice(&body).map_err(|e| format!("The server's answer could not be read: {e}"))
}

/// The `Retry-After` of a 429 or 503, in seconds, at most [`BACKOFF_MAX`] (a day for a 503).
fn retry_after(response: &reqwest::Response) -> Option<u64> {
	let value = response.headers().get("retry-after").and_then(|v| v.to_str().ok()).and_then(|v| v.trim().parse::<u64>().ok());
	clamp_retry_after(value, response.status())
}

fn clamp_retry_after(value: Option<u64>, status: reqwest::StatusCode) -> Option<u64> {
	let max = if status == reqwest::StatusCode::SERVICE_UNAVAILABLE { RETRY_AFTER_503_MAX } else { BACKOFF_MAX };
	value.map(|v| v.min(max))
}

/// The wait before try `attempts + 1`: doubling from [`BACKOFF_MIN`] up to [`BACKOFF_MAX`], or the
/// server's (clamped) `Retry-After` when longer.
fn backoff_secs(attempts: u32, retry_after: Option<u64>) -> u64 {
	(BACKOFF_MIN << attempts.min(10)).min(BACKOFF_MAX).max(retry_after.unwrap_or(0).min(RETRY_AFTER_503_MAX))
}

/// What Ack.lua tells the Recorder: nothing (`None`) until sharing has been on once, so a
/// `/psrec on` of someone whose client never shared stays theirs; then whether they share and
/// have not paused uploads. (`consent` covers settings saved before `ever_shared` existed.)
fn sharing(settings: &Settings) -> Option<bool> {
	(settings.ever_shared || settings.consent).then_some(settings.consent && !settings.paused)
}

/// Whether sharing turns on by default now: the player never chose (sharing was never on, so
/// they never stopped it either), the game is found (setup done, an install) and no account's
/// Recorder was turned off with `/psrec off` (its `optout`). Every account's file must have been
/// looked at (`poll_files`): none there, read, holding nothing yet, or schema 1 (from before
/// `/psrec off` was an opt-out); a file that can't be read waits, since its opt-out is unknown.
fn share_by_default(settings: &Settings, found: bool, accounts: &[Account]) -> bool {
	if settings.consent || settings.ever_shared || !settings.setup_done || !found {
		return false;
	}
	accounts.iter().all(|a| match (&a.sv, &a.error) {
		(Some(vars), _) => !vars.optout,
		(None, Some(sv::Error::Missing | sv::Error::OldSchema)) => true,
		(None, Some(_)) => false,
		// Not read: no file when last looked at, or one that could not be read yet.
		(None, None) => a.seen.is_none(),
	})
}

/// `address`'s host when it is not `default` (both normalized): the banner names it.
fn custom_site(address: &str, default: &str) -> Option<String> {
	let norm = |u: &str| crate::packs::normalize_base(u).unwrap_or_else(|| u.to_owned());
	(norm(address) != norm(default)).then(|| crate::packs::host(address))
}

/// The last Recorder release that records schema 1; every later one records schema 2.
const LAST_SCHEMA1_RECORDER: &str = "0.2.6";

/// What Status says (kind, title, detail, action) while an account's file is still schema 1,
/// given the Recorder installed and the latest one published (`None`: not known yet). It offers
/// an update only when the published one records schema 2 and is newer than the one installed.
fn old_recorder(installed: Option<&str>, latest: Option<&str>) -> (&'static str, &'static str, &'static str, Option<&'static str>) {
	let records_schema2 = |v: &str| addons::newer(v, LAST_SCHEMA1_RECORDER);
	match latest {
		Some(l) if records_schema2(l) && installed.is_none_or(|have| addons::newer(l, have)) => ("attention", "The Recorder is out of date", "Update it so it records in the format the server reads.", Some("update")),
		_ if installed.is_some_and(records_schema2) => ("waiting", "Waiting for the new Recorder to run", "Log in (or /reload) with the Recorder on to start recording in the new format.", None),
		Some(_) => ("attention", "The Recorder is out of date", "It records in an older format the server no longer reads. The new Recorder comes with the next Polestar update.", None),
		None => ("attention", "The Recorder is out of date", "It records in an older format the server no longer reads. Check for addon updates to get the new one.", None),
	}
}

/// The game's own executables (WoW: Forever runs as Wow.exe). Matched whole, so another program
/// whose name starts with "wow", such as WowUp-CF.exe, is not the game.
const GAME_EXES: &[&str] = &["wow.exe", "wowt.exe", "wowb.exe", "wowclassic.exe", "wowclassict.exe", "wowclassicb.exe"];

/// Is World of Warcraft running? (Under Wine the game shows up as its .exe.)
fn game_running(system: &mut sysinfo::System) -> bool {
	use sysinfo::{ProcessRefreshKind, ProcessesToUpdate};
	system.refresh_processes_specifics(ProcessesToUpdate::All, true, ProcessRefreshKind::nothing());
	system.processes().values().any(|p| is_game_process(&p.name().to_string_lossy()))
}

fn is_game_process(name: &str) -> bool {
	let name = name.to_ascii_lowercase();
	GAME_EXES.contains(&name.as_str()) || name.starts_with("world of warcraft")
}

fn status(state: &State, game: &GameView, pending: u64, now: i64) -> StatusView {
	let make = |kind: &str, title: &str, detail: String, action: Option<&str>| StatusView {
		kind: kind.to_owned(),
		title: title.to_owned(),
		detail,
		action: action.map(str::to_owned),
		last_upload: state.last_upload,
		next_retry: None,
	};
	if !state.settings.consent {
		return make("off", "Sharing is off", "Nothing is sent. Start sharing under Recording to help improve Polestar's guides.".into(), None);
	}
	if state.settings.paused {
		let detail = if pending > 0 { "Your new play waits on this PC until you resume. The Recorder keeps recording in the game." } else { "Nothing is sent until you resume. The Recorder keeps recording in the game." };
		return make("paused", "Uploads paused", detail.into(), Some("resume"));
	}
	if let Some((path, problem)) = &state.problem {
		return make("attention", "Your WoW folder needs a look", format!("{}: {problem}", path.display()), Some("locate"));
	}
	let Some(addon) = &game.addon else {
		return make("attention", "World of Warcraft: Forever not found", "Show Polestar Client where the game is installed.".into(), Some("locate"));
	};
	if !addon.installed {
		return make("attention", "The Recorder addon is not installed", "Install it, then log in to the game. While sharing is on, the Recorder records by itself.".into(), Some("install"));
	}
	if state.accounts.iter().any(|a| matches!(a.error, Some(sv::Error::OldSchema))) {
		let (kind, title, detail, action) = old_recorder(addon.version.as_deref(), addon.latest.as_deref());
		return make(kind, title, detail.into(), action);
	}
	if let Some(a) = state.accounts.iter().find(|a| a.error.as_ref().is_some_and(|e| !matches!(e, sv::Error::Missing))) {
		return make("attention", "The Recorder's file can't be read", format!("{}: {}", a.folder_name, a.error.as_ref().map(|e| e.to_string()).unwrap_or_default()), None);
	}
	if let Some(Failure::Refused { message, .. }) = &state.failure {
		return make("attention", "The server turned the upload away", message.clone(), Some("retry"));
	}
	if state.registering {
		return make("uploading", "Setting up", "Setting up this PC with the Polestar server. It takes a few seconds, once.".into(), None);
	}
	if let Some(n) = state.uploading {
		return make("uploading", "Sending", format!("Sending your latest play ({n} {}).", plural(n as u64, "part", "parts")), None);
	}
	if let Some(Failure::Offline { message, retry_at, .. }) = &state.failure {
		let mut view = make("offline", "Can't reach the server", message.clone(), Some("retry"));
		view.next_retry = Some(*retry_at);
		return view;
	}
	let files: Vec<&sv::SavedVars> = state.accounts.iter().filter_map(|a| a.sv.as_deref()).collect();
	if game.accounts.is_empty() {
		return make("waiting", "Waiting for your first login", "Log in to WoW: Forever once so the game makes your account folder.".into(), None);
	}
	if files.is_empty() {
		return make("waiting", "Waiting for the first recording", "Log in to the game: the Recorder records while sharing is on. The game saves the recording when you log out or type /reload.".into(), None);
	}
	if files.iter().all(|f| !f.enabled) && pending == 0 {
		// The game writes the Recorder's on/off state only at a logout or /reload, so this is the
		// state then: a /psrec on since shows only after the next one (#1453).
		let detail = if state.game_running {
			"The game tells Polestar Client only when you log out or type /reload. Turned it on since (/psrec on)? Type /reload in the game and what's recorded is sent."
		} else {
			"It turns on at your next login (or /reload) while sharing is on, unless you turned it off with /psrec off: then type /psrec on, and /reload to send what's recorded."
		};
		return make("attention", "Off in the game as of your last logout or /reload", detail.into(), None);
	}
	if let Some((at, rejected)) = &state.rejected {
		if now - at < REJECTED_SHOWN_MS {
			let reason = rejected.first().map(|r| r.reason.clone()).unwrap_or_default();
			let n = rejected.len() as u64;
			return make("rejected", "Some data was skipped", format!("The server couldn't read {n} {} of your last upload and skipped {} ({reason}). Everything else arrived; there is nothing for you to do.", plural(n, "part", "parts"), if n == 1 { "it" } else { "them" }), None);
		}
	}
	if state.game_running {
		return make("waiting", "Waiting for the game to save", "WoW writes the recording only when you log out or type /reload. It is sent a few seconds after that.".into(), None);
	}
	make("watching", "Sharing on", "New play is sent a few seconds after you log out or type /reload.".into(), None)
}

fn plural<'a>(n: u64, one: &'a str, many: &'a str) -> &'a str {
	if n == 1 {
		one
	} else {
		many
	}
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct Snapshot {
	pub version: String,
	/// The first-run setup (finding the game) is behind the player.
	pub setup_done: bool,
	/// The player shares their play (on by default unless they stopped it).
	pub consent: bool,
	/// Sharing is on and the notice saying what it sends has not been read yet.
	pub share_notice: bool,
	pub paused: bool,
	pub server_url: String,
	pub default_server_url: String,
	pub data_dir: String,
	pub game: GameView,
	pub status: StatusView,
	pub pending: u64,
	pub week: Option<serde_json::Value>,
	pub addons: crate::manager::AddonsView,
	pub community: crate::community::CommunityView,
	pub update: Option<String>,
	/// The community site and recording server, when either is not the default: a banner says so.
	pub custom: CustomSites,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct CustomSites {
	pub community: Option<String>,
	pub server: Option<String>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct GameView {
	pub found: bool,
	/// The first look for the game has finished (until then, "not found" means "not looked yet").
	pub scanned: bool,
	pub root: Option<String>,
	/// The client folder in use (`<root>/_forever_`); one root can hold more than one.
	pub dir: Option<String>,
	pub game_version: Option<String>,
	pub chosen: Option<String>,
	pub problem: Option<FolderProblemView>,
	pub candidates: Vec<CandidateView>,
	pub addon: Option<AddonView>,
	pub accounts: Vec<AccountView>,
	pub running: bool,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct FolderProblemView {
	pub path: String,
	pub message: String,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct CandidateView {
	pub root: String,
	/// The client folder, unique per candidate: what choosing it saves.
	pub dir: String,
	/// The client folder's name (`_forever_`).
	pub client: String,
	pub version: Option<String>,
	pub accounts: usize,
	pub addon_version: Option<String>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct AddonView {
	pub installed: bool,
	pub version: Option<String>,
	pub latest: Option<String>,
	pub update_available: bool,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct AccountView {
	/// The account folder's name: shown here, never uploaded.
	pub name: String,
	pub has_file: bool,
	pub recording: Option<bool>,
	pub pending: u64,
	pub characters: usize,
	pub problem: Option<String>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct StatusView {
	pub kind: String,
	pub title: String,
	pub detail: String,
	pub action: Option<String>,
	pub last_upload: Option<i64>,
	pub next_retry: Option<i64>,
}

/// The last addon check: when, and every release of each product, newest first.
pub struct Catalog {
	pub at: i64,
	pub releases: BTreeMap<&'static str, Vec<addons::Release>>,
}

impl Catalog {
	pub fn latest(&self, id: &str) -> Option<&addons::Release> {
		self.releases.get(id).and_then(|r| r.first())
	}
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RecordRow {
	pub seq: u64,
	pub kind: String,
	/// Epoch seconds.
	pub t: f64,
	/// (field name, value) in the record's order.
	pub fields: Vec<(String, String)>,
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Preview {
	pub chunks: usize,
	pub bytes: usize,
	pub requests: usize,
	pub summary: Option<serde_json::Value>,
	pub records: Vec<RecordRow>,
	pub total_records: usize,
	pub problems: Vec<String>,
	pub json: String,
}

/// An upload the server accepted, without its contents (`Engine::sent_upload` reads those).
#[derive(Serialize, Debug, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct SentUpload {
	/// Epoch milliseconds, as in `ActivityEntry`.
	pub at: i64,
	pub install: String,
	pub chunks: usize,
	pub bytes: usize,
	pub records: usize,
}

/// A chunk as it leaves the PC: only lines of record kinds this client knows (each
/// scrubbed of the account's character names); unknown kinds never leave. An error
/// when it is over the server's caps (bytes or records): such a chunk is never sent,
/// and never cut short either.
fn prepare_chunk(text: &str, names: &[String]) -> Result<String, String> {
	let mut lines = text.split('\n');
	let head = lines.next().unwrap_or("");
	let mut known = vec![head];
	known.extend(lines.filter(|l| l.split('\t').next().and_then(record::Kind::parse).is_some()));
	let records = known.len() - 1;
	let text = scrub::scrub_chunk(&known.join("\n"), names);
	if text.len() > api::MAX_CHUNK_BYTES {
		return Err(format!("it is {} bytes, over the {} a chunk may hold", text.len(), api::MAX_CHUNK_BYTES));
	}
	if records > api::MAX_CHUNK_RECORDS {
		return Err(format!("it holds {records} records, over the {} a chunk may hold", api::MAX_CHUNK_RECORDS));
	}
	Ok(text)
}

/// The highest seq the server confirmed holding (accepted or duplicate) among the
/// seqs this request sent; anything else in its answer is ignored.
fn confirmed_ack(sent: &[api::UploadChunk], accepted: &[u64], duplicate: &[u64]) -> Option<u64> {
	let highest = sent.iter().map(|c| c.seq).max()?;
	accepted.iter().chain(duplicate).copied().filter(|s| *s <= highest && sent.iter().any(|c| c.seq == *s)).max()
}

/// Statuses that mean "try again later" (normal backoff) rather than a refusal.
fn is_temporary(status: reqwest::StatusCode) -> bool {
	status.is_server_error() || status == reqwest::StatusCode::TOO_MANY_REQUESTS || status == reqwest::StatusCode::REQUEST_TIMEOUT
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn only_the_game_counts_as_the_game() {
		for name in ["Wow.exe", "WowClassic.exe", "WowT.exe", "World of Warcraft"] {
			assert!(is_game_process(name), "{name}");
		}
		// Addon managers and other tools named after the game are not the game.
		for name in ["WowUp-CF.exe", "WowUp.exe", "wowup.exe", "Battle.net.exe", "polestar-client.exe"] {
			assert!(!is_game_process(name), "{name}");
		}
	}

	#[test]
	fn kept_chunks_group_into_uploads_newest_first() {
		let chunk = |at, install: &str, seq, text: &str| SentChunk { at, install: install.to_owned(), seq, text: text.to_owned() };
		let chunks = [
			chunk(100, "a", 1, "chunk\t0\t1\nxp\t0\nkill\t1"),
			chunk(100, "a", 2, "chunk\t0\t2\nxp\t2\n"),
			chunk(100, "b", 1, "chunk\t0\t1"),
			chunk(200, "a", 3, "chunk\t0\t3\nxp\t3"),
		];
		let body = |of: &[&SentChunk]| of.iter().map(|c| api::UploadChunk { seq: c.seq, text: c.text.clone() }).collect::<Vec<_>>();
		let upload = |at, install: &str, of: &[&SentChunk], records| SentUpload { at, install: install.to_owned(), chunks: of.len(), bytes: request_bytes(install, &body(of)), records };
		assert_eq!(
			sent_uploads_of(&chunks),
			[
				upload(200, "a", &[&chunks[3]], 1),
				// Two chunks of one request are one upload, and neither header counts as a record.
				upload(100, "a", &[&chunks[0], &chunks[1]], 3),
				// The same moment from another Recorder install is another upload.
				upload(100, "b", &[&chunks[2]], 0),
			]
		);
		assert_eq!(sent_uploads_of(&[]), []);
	}

	#[test]
	fn timeouts_and_unavailable_are_temporary() {
		use reqwest::StatusCode as S;
		for s in [S::REQUEST_TIMEOUT, S::SERVICE_UNAVAILABLE, S::TOO_MANY_REQUESTS, S::BAD_GATEWAY] {
			assert!(is_temporary(s), "{s}");
		}
		for s in [S::BAD_REQUEST, S::FORBIDDEN, S::PAYLOAD_TOO_LARGE] {
			assert!(!is_temporary(s), "{s}");
		}
	}

	#[test]
	fn retry_after_is_clamped() {
		use reqwest::StatusCode as S;
		// A hostile Retry-After can't stall uploads for years (or overflow the retry time).
		assert_eq!(clamp_retry_after(Some(u64::MAX), S::TOO_MANY_REQUESTS), Some(BACKOFF_MAX));
		assert_eq!(clamp_retry_after(Some(u64::MAX), S::SERVICE_UNAVAILABLE), Some(24 * 3600));
		assert_eq!(clamp_retry_after(Some(60), S::TOO_MANY_REQUESTS), Some(60));
		assert_eq!(clamp_retry_after(None, S::SERVICE_UNAVAILABLE), None);
		assert_eq!(backoff_secs(0, Some(u64::MAX)), 24 * 3600);
		assert_eq!(backoff_secs(0, None), BACKOFF_MIN);
		assert_eq!(backoff_secs(20, None), BACKOFF_MAX);
		assert!(now_ms().saturating_add(backoff_secs(u32::MAX, Some(u64::MAX)) as i64 * 1000) > now_ms());
	}

	#[test]
	fn unknown_kinds_never_leave_and_caps_hold() {
		let head = "chunk\t0\t38\t1700000000\tabcdefghij";
		let text = format!("{head}\nfuturekind\t3\tsecret Bob\n");
		let out = prepare_chunk(&text, &[]).unwrap();
		assert!(!out.contains("futurekind") && !out.contains("Bob"), "{out}");
		assert!(out.starts_with(head));
		let big = format!("{head}\n{}", "x".repeat(api::MAX_CHUNK_BYTES));
		// Unknown filler is dropped, so it fits; a known kind of that size does not.
		assert!(prepare_chunk(&big, &[]).is_ok());
		let kind = record::Kind::ALL.iter().find(|k| !matches!(k, record::Kind::Chunk)).unwrap().as_str();
		let big = format!("{head}\n{kind}\t0\t{}", "x".repeat(api::MAX_CHUNK_BYTES));
		assert!(prepare_chunk(&big, &[]).is_err());
		let many = format!("{head}\n{}", format!("{kind}\t0\n").repeat(api::MAX_CHUNK_RECORDS + 1));
		assert!(prepare_chunk(&many, &[]).is_err());
	}

	#[test]
	fn gathers_groups_spawns_fails_and_refusals_leave_as_written() {
		let lines = [
			"chunk\t0\t38\t1700000000\tabcdefghij",
			"group\t1\t2\t0",
			"spawn\t2\t1501\t000043F59F\t1420\t3100\t6700",
			"loot\t3\to\t1617\t1420\t3110\t6710\th\t765:2\t",
			"gather\t3\t1617\t1420\t3110\t6710\th\t182\t57",
			"fail\t4\t5821\t1420\t3120\t6720",
			"refuse\t5\t1420\t3120\t6720\tc\t1568\tERR_QUEST_NEED_PREREQS",
		];
		let text = lines.join("\n");
		assert_eq!(prepare_chunk(&text, &["Testchar".to_owned()]).unwrap(), text);
	}

	#[test]
	fn ack_covers_only_what_was_sent() {
		let sent: Vec<api::UploadChunk> = [3, 4, 5].iter().map(|&seq| api::UploadChunk { seq, text: String::new() }).collect();
		assert_eq!(confirmed_ack(&sent, &[3, 4], &[5]), Some(5));
		assert_eq!(confirmed_ack(&sent, &[3, u64::MAX], &[]), Some(3));
		assert_eq!(confirmed_ack(&sent, &[9], &[2]), None);
		assert_eq!(confirmed_ack(&[], &[1], &[]), None);
	}

	#[test]
	fn a_request_that_gets_no_answer_says_why_and_what_to_try() {
		// Port 9 on this machine: nothing listens, the connection is refused. 0.1.4 said only
		// "Check your internet connection", which a player whose browser was online could not act on.
		let _ = rustls::crypto::ring::default_provider().install_default();
		let e = tauri::async_runtime::block_on(async { reqwest::Client::new().get("http://127.0.0.1:9/v1/upload").send().await.unwrap_err() });
		let text = describe_reqwest(&e);
		assert!(text.contains("Can't reach the recording server from this PC (") && text.to_lowercase().contains("refused"), "{text}");
		assert!(text.contains("http://127.0.0.1:9/v1/stats") && text.contains("firewall, antivirus, VPN or proxy"), "{text}");
		assert!(not_from_server(reqwest::StatusCode::FORBIDDEN).starts_with("The answer was 403 Forbidden, not from the recording server itself"));
	}

	#[test]
	fn no_share_flag_until_the_player_has_shared() {
		let at = |consent, paused, ever_shared| sharing(&Settings { consent, paused, ever_shared, ..Settings::default() });
		// Never shared: the Recorder is left to /psrec.
		assert_eq!(at(false, false, false), None);
		assert_eq!(at(true, false, true), Some(true));
		assert_eq!(at(true, true, true), Some(false));
		// Stopped sharing after having shared: off.
		assert_eq!(at(false, false, true), Some(false));
		// Consent saved before ever_shared existed counts.
		assert_eq!(at(true, false, false), Some(true));
	}

	/// An account folder as `poll_files` leaves it: no file, a file read, or one it can't read.
	fn account(sv: Option<sv::SavedVars>, error: Option<sv::Error>) -> Account {
		let seen = (sv.is_some() || error.is_some()).then_some((UNIX_EPOCH, 1));
		Account { sv: sv.map(Arc::new), error, seen, ..Account::new_empty("WOW1", Path::new("Polestar_Recorder.lua")) }
	}

	fn recording(optout: bool) -> Option<sv::SavedVars> {
		Some(sv::SavedVars { schema: 2, enabled: !optout, optout, ..Default::default() })
	}

	#[test]
	fn sharing_is_on_by_default_for_a_player_who_never_chose() {
		let never = Settings { setup_done: true, ..Settings::default() };
		// A new install with the game found: no files yet, a first recording, or one from before
		// the recording program.
		assert!(share_by_default(&never, true, &[]));
		assert!(share_by_default(&never, true, &[account(None, None)]));
		assert!(share_by_default(&never, true, &[account(recording(false), None), account(None, Some(sv::Error::Missing))]));
		assert!(share_by_default(&never, true, &[account(None, Some(sv::Error::OldSchema))]));
		// Not before the game is found and set up.
		assert!(!share_by_default(&Settings::default(), true, &[]));
		assert!(!share_by_default(&never, false, &[]));
		// Already sharing: nothing to turn on.
		assert!(!share_by_default(&Settings { consent: true, ever_shared: true, ..never.clone() }, true, &[]));
	}

	#[test]
	fn sharing_stays_off_for_every_opt_out() {
		let never = Settings { setup_done: true, ..Settings::default() };
		// Stopped sharing in the client (sharing was on before): never turned back on.
		let stopped = Settings { ever_shared: true, ..never.clone() };
		assert!(!share_by_default(&stopped, true, &[]));
		assert!(!share_by_default(&Settings { paused: true, ..stopped }, true, &[account(recording(false), None)]));
		// /psrec off on any account of this game.
		assert!(!share_by_default(&never, true, &[account(recording(true), None)]));
		assert!(!share_by_default(&never, true, &[account(recording(false), None), account(recording(true), None)]));
		// A file that can't be read (its opt-out unknown), or that could not be read yet: wait.
		assert!(!share_by_default(&never, true, &[account(None, Some(sv::Error::Field("chunks")))]));
		let unread = Account { seen: Some((UNIX_EPOCH, 1)), ..account(None, None) };
		assert!(!share_by_default(&never, true, &[unread]));
	}

	#[test]
	fn old_recorder_offers_only_a_newer_release() {
		let action = |have, latest| old_recorder(have, latest).3;
		// Published newer than installed (or nothing readable installed): update.
		assert_eq!(action(Some("0.2.6"), Some("0.3.0")), Some("update"));
		assert_eq!(action(None, Some("0.3.0")), Some("update"));
		// The latest is installed already: play with it, nothing to install.
		assert_eq!(old_recorder(Some("0.3.0"), Some("0.3.0")), ("waiting", "Waiting for the new Recorder to run", "Log in (or /reload) with the Recorder on to start recording in the new format.", None));
		assert_eq!(action(Some("0.3.1"), Some("0.3.0")), None);
		// No published release records schema 2 yet: never reinstall the same old one.
		let (_, _, detail, action) = old_recorder(Some("0.2.6"), Some("0.2.6"));
		assert!(detail.contains("next Polestar update") && action.is_none(), "{detail}");
		assert_eq!(old_recorder(Some("0.2.5"), Some("0.2.6")).3, None);
		assert_eq!(old_recorder(Some("0.2.6"), None).3, None);
	}
}
