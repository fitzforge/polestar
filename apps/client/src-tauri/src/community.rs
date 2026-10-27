//! The Community page's backend: the community site's signed pack index
//! (checked with the addon updates every 6 hours, by ETag), installing,
//! updating and removing packs, `polestar://install?pack=<id>` links, and
//! (when the player opted in) counting installs on the site. Every change
//! lands in the Activity log. The rules themselves are in packs.rs.

use std::collections::BTreeMap;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use serde::Serialize;
use tauri_plugin_notification::NotificationExt;

use crate::addons::{self, Progress};
use crate::engine::{now_ms, Engine, State};
use crate::packs::{self, Fetched, Index, Installed};
use crate::store::{ActivityEntry, ActivityKind, SavedIndex, Store};

const PROGRESS_EVERY: Duration = Duration::from_millis(100);

/// The community packs as the engine holds them.
#[derive(Default)]
pub struct Packs {
	/// The site the index below came from.
	base: String,
	pub index: Option<Index>,
	etag: Option<String>,
	checked_at: Option<i64>,
	checking: bool,
	error: Option<String>,
	/// What is in AddOns now (re-read with every scan for the game and after every change).
	pub installed: Vec<Installed>,
	busy: BTreeMap<String, &'static str>,
	progress: BTreeMap<String, Progress>,
	/// The last `polestar://` link, until the page has opened it.
	link: Option<LinkView>,
	link_seq: u64,
}

impl Packs {
	/// At start: the last index accepted from `base`, while it still verifies and has not expired.
	pub fn load(store: &Store, base: &str) -> Packs {
		let mut packs = Packs { base: base.to_owned(), ..Packs::default() };
		if let Some(saved) = store.pack_index(base) {
			match packs::verify_index(saved.body.as_bytes(), saved.sig.as_bytes(), &packs::keys_for(base), base, now_ms(), Some(saved.generated)) {
				Ok(index) => {
					packs.index = Some(index);
					packs.etag = saved.etag;
				}
				Err(e) => eprintln!("The saved community index is not used: {e}"),
			}
		}
		packs
	}
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct LinkView {
	pub seq: u64,
	/// The pack the link asks for, when it names a valid one.
	pub pack: Option<String>,
	/// Why the link can't be used.
	pub error: Option<String>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct CommunityView {
	/// A signing key is pinned for this site: without one there are no community packs.
	pub available: bool,
	/// The site, as `polestar.guide`.
	pub site: String,
	pub base: String,
	pub default_base: String,
	pub telemetry: bool,
	pub checked_at: Option<i64>,
	pub checking: bool,
	pub error: Option<String>,
	pub game_found: bool,
	pub game_running: bool,
	/// Installed packs first, then the ones that can be installed; each by title.
	pub packs: Vec<PackView>,
	pub link: Option<LinkView>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct PackView {
	pub id: String,
	pub title: String,
	pub author: String,
	/// The version the index offers (none for a pack it no longer lists).
	pub version: Option<String>,
	pub installed: Option<String>,
	/// `install`, `update`, `upToDate`, `unlisted` (installed, no longer in the index) or `noGame`.
	pub status: &'static str,
	/// Why it can't be installed or updated in this game now.
	pub blocked: Option<String>,
	pub size: Option<u64>,
	/// The folders it has, or will create.
	pub folders: Vec<String>,
	pub homepage: Option<String>,
	pub changelog: Option<String>,
	pub official: bool,
	pub busy: Option<&'static str>,
	pub progress: Option<Progress>,
}

/// The game's TOC Interface and the installed Polestar's version: what packs are checked against.
fn game(state: &State) -> (Option<u32>, Option<String>) {
	let interface = state.install.as_ref().and_then(|i| i.version.as_deref()).and_then(packs::interface_of);
	let polestar = state.install.as_ref().and_then(|i| addons::product("polestar").and_then(|p| addons::installed_version(&i.addons_dir(), p)));
	(interface, polestar)
}

pub fn view(state: &State) -> CommunityView {
	let base = state.settings.packs_url.clone();
	let p = &state.packs;
	let (interface, polestar) = game(state);
	let game_found = state.install.is_some();
	let index = p.index.as_ref().filter(|_| p.base == base);
	let mut installed: Vec<PackView> = Vec::new();
	let mut available: Vec<PackView> = Vec::new();
	for have in &p.installed {
		let entry = index.and_then(|i| i.get(&have.id));
		let status = match (entry, &have.version) {
			(None, _) => "unlisted",
			(Some(e), Some(v)) if !addons::newer(&e.version, v) => "upToDate",
			_ => "update",
		};
		installed.push(PackView {
			id: have.id.clone(),
			title: entry.map(|e| e.title.clone()).or_else(|| have.title.clone()).unwrap_or_else(|| have.id.clone()),
			author: entry.map(|e| e.author.clone()).or_else(|| have.author.clone()).unwrap_or_default(),
			version: entry.map(|e| e.version.clone()),
			installed: have.version.clone(),
			status,
			blocked: entry.filter(|_| status == "update").and_then(|e| packs::blocked(e, interface, polestar.as_deref())),
			size: entry.map(|e| e.download.size),
			folders: have.folders.clone(),
			homepage: entry.and_then(|e| e.homepage.clone()),
			changelog: entry.map(|e| e.changelog.clone()),
			official: entry.is_some_and(|e| e.official),
			busy: p.busy.get(&have.id).copied(),
			progress: p.progress.get(&have.id).copied(),
		});
	}
	for e in index.map(|i| i.packs.as_slice()).unwrap_or_default() {
		if p.installed.iter().any(|h| h.id == e.id) {
			continue;
		}
		available.push(PackView {
			id: e.id.clone(),
			title: e.title.clone(),
			author: e.author.clone(),
			version: Some(e.version.clone()),
			installed: None,
			status: if game_found { "install" } else { "noGame" },
			blocked: game_found.then(|| packs::blocked(e, interface, polestar.as_deref())).flatten(),
			size: Some(e.download.size),
			folders: e.addon.clone(),
			homepage: e.homepage.clone(),
			changelog: Some(e.changelog.clone()),
			official: e.official,
			busy: p.busy.get(&e.id).copied(),
			progress: p.progress.get(&e.id).copied(),
		});
	}
	let by_title = |a: &PackView, b: &PackView| a.title.to_lowercase().cmp(&b.title.to_lowercase());
	installed.sort_by(by_title);
	available.sort_by(by_title);
	installed.extend(available);
	CommunityView {
		available: !packs::keys_for(&base).is_empty(),
		site: packs::host(&base),
		default_base: packs::DEFAULT_BASE.to_owned(),
		telemetry: state.settings.pack_telemetry,
		checked_at: p.checked_at.filter(|_| p.base == base),
		checking: p.checking,
		error: p.error.clone().filter(|_| p.base == base),
		game_found,
		game_running: state.game_running,
		packs: installed,
		link: p.link.clone(),
		base,
	}
}

/// Installed packs with a newer version the game can take.
pub fn updates(state: &State) -> Vec<(String, String, String)> {
	view(state).packs.into_iter().filter(|p| p.status == "update" && p.blocked.is_none()).map(|p| (p.id, p.title, p.version.unwrap_or_default())).collect()
}

impl Engine {
	/// Re-reads which packs are in AddOns.
	pub fn refresh_packs(&self) {
		let dir = self.lock().install.as_ref().map(|i| i.addons_dir());
		let installed = dir.map(|d| packs::installed(&d)).unwrap_or_default();
		self.lock().packs.installed = installed;
	}

	/// Fetches the index (by ETag) and checks it. In the background (the 6-hourly check) it
	/// announces pack updates in the tray, or installs them when the player turned that on and
	/// the game is closed.
	pub async fn check_packs(self: &Arc<Self>, background: bool) {
		let (base, etag, last) = {
			let mut state = self.lock();
			let base = state.settings.packs_url.clone();
			if state.packs.base != base {
				let keep = std::mem::take(&mut state.packs);
				state.packs = Packs::load(&self.store, &base);
				state.packs.link = keep.link;
				state.packs.link_seq = keep.link_seq;
				state.packs.installed = keep.installed;
			}
			if state.packs.checking || packs::keys_for(&base).is_empty() {
				return;
			}
			state.packs.checking = true;
			let etag = state.packs.index.as_ref().and(state.packs.etag.clone());
			let last = self.store.pack_index(&base).map(|s| s.generated);
			(base, etag, last)
		};
		self.publish();
		let result = match packs::fetch_index(&self.http, &base, etag.as_deref()).await {
			Ok(Fetched::NotModified) => Ok(None),
			Ok(Fetched::New { body, sig, etag }) => packs::verify_index(&body, &sig, &packs::keys_for(&base), &base, now_ms(), last).and_then(|index| {
				let saved = SavedIndex { generated: index.generated, etag: etag.clone(), body: String::from_utf8(body).map_err(|_| "The community index is not text.".to_owned())?, sig: String::from_utf8_lossy(&sig).into_owned() };
				if let Err(e) = self.store.save_pack_index(&base, saved) {
					eprintln!("Could not keep the community index: {e}");
				}
				Ok(Some((index, etag)))
			}),
			Err(e) => Err(e),
		};
		{
			let mut state = self.lock();
			let packs = &mut state.packs;
			packs.checking = false;
			if packs.base == base {
				match result {
					Ok(Some((index, etag))) => {
						packs.index = Some(index);
						packs.etag = etag;
						packs.error = None;
						packs.checked_at = Some(now_ms());
					}
					Ok(None) => {
						packs.error = packs.index.as_ref().filter(|i| now_ms() >= i.expires).map(|_| "The community index has expired: polestar.guide hasn't renewed it. Try again later.".to_owned());
						if packs.error.is_some() {
							packs.index = None;
						}
						packs.checked_at = Some(now_ms());
					}
					Err(e) => packs.error = Some(e),
				}
			}
		}
		self.refresh_packs();
		self.publish();
		if !background {
			return;
		}
		let (updates, auto_install, running) = {
			let state = self.lock();
			(updates(&state), state.settings.auto_install, state.game_running)
		};
		if updates.is_empty() {
			return;
		}
		if auto_install && !running {
			for (id, ..) in &updates {
				let _ = self.pack_action(id, "update").await;
			}
			return;
		}
		let fresh: Vec<String> = {
			let mut state = self.lock();
			updates.iter().filter(|(id, _, v)| state.notified.insert(format!("pack:{id} {v}"))).map(|(_, title, v)| format!("{title} {v}")).collect()
		};
		if !fresh.is_empty() {
			let _ = self.app().notification().builder().title("Community Guide updates").body(format!("{} ready to install. Open Polestar Client to update.", fresh.join(", "))).show();
		}
	}

	/// Installs, updates or removes one pack. Returns what was done.
	pub async fn pack_action(self: &Arc<Self>, id: &str, action: &'static str) -> Result<String, String> {
		if !packs::valid_id(id) {
			return Err("No such guide.".to_owned());
		}
		let (dir, entry, title, before) = {
			let mut state = self.lock();
			let dir = state.install.as_ref().map(|i| i.addons_dir()).ok_or("Find the game folder first (Settings > Game).")?;
			if state.packs.busy.contains_key(id) {
				return Err("That guide is busy already.".to_owned());
			}
			let have = state.packs.installed.iter().find(|p| p.id == id).cloned();
			let entry = match action {
				"uninstall" => None,
				_ => {
					let index = state.packs.index.as_ref().filter(|_| state.packs.base == state.settings.packs_url);
					let entry = index.and_then(|i| i.get(id)).cloned().ok_or_else(|| format!("{id} isn't in the community index. Check for updates, or look for it on {}.", packs::host(&state.settings.packs_url)))?;
					let (interface, polestar) = game(&state);
					if let Some(why) = packs::blocked(&entry, interface, polestar.as_deref()) {
						return Err(format!("{} can't be installed: {why}", entry.title));
					}
					Some(entry)
				}
			};
			if action == "uninstall" && have.is_none() {
				return Err("That guide isn't installed.".to_owned());
			}
			let title = entry.as_ref().map(|e| e.title.clone()).or_else(|| have.as_ref().and_then(|h| h.title.clone())).unwrap_or_else(|| id.to_owned());
			state.packs.busy.insert(id.to_owned(), action);
			(dir, entry, title, have.and_then(|h| h.version))
		};
		self.publish();
		let last = Mutex::new((Instant::now(), ""));
		let report = |p: Progress| {
			self.lock().packs.progress.insert(id.to_owned(), p);
			let mut last = last.lock().unwrap_or_else(|e| e.into_inner());
			if last.1 != p.phase || last.0.elapsed() >= PROGRESS_EVERY {
				*last = (Instant::now(), p.phase);
				drop(last);
				self.publish();
			}
		};
		let result = match &entry {
			Some(entry) => packs::install(&self.http, entry, &dir, &report).await.map(|_| entry.version.clone()),
			None => {
				report(Progress::step("remove"));
				let (dir, id) = (dir.clone(), id.to_owned());
				tauri::async_runtime::spawn_blocking(move || packs::uninstall(&id, &dir)).await.map_err(|e| e.to_string()).and_then(|r| r).map(|_| String::new())
			}
		};
		{
			let mut state = self.lock();
			state.packs.busy.remove(id);
			state.packs.progress.remove(id);
		}
		self.refresh_packs();
		let kind = match action {
			"uninstall" => ActivityKind::Uninstall,
			_ if before.is_some() => ActivityKind::Update,
			_ => ActivityKind::Install,
		};
		let _ = self.store.push_activity(ActivityEntry {
			kind,
			at: now_ms(),
			product: Some(title.clone()),
			version: entry.as_ref().map(|e| e.version.clone()).or(before),
			message: result.as_ref().err().cloned(),
			..Default::default()
		});
		if let (Ok(version), Some(_)) = (&result, &entry) {
			let (telemetry, base) = {
				let state = self.lock();
				(state.settings.pack_telemetry, state.settings.packs_url.clone())
			};
			if telemetry {
				let (http, id, version) = (self.http.clone(), id.to_owned(), version.clone());
				tauri::async_runtime::spawn(async move { packs::report_install(&http, &base, &id, &version).await });
			}
		}
		self.publish();
		result.map(|version| match action {
			"uninstall" => format!("{title} removed."),
			_ => format!("{title} {version} installed. Restart the game (or /reload) to load it."),
		})
	}

	/// A `polestar://` link (from the browser, through the system): the page opens it on the
	/// Community page and asks before anything is installed.
	pub fn open_link(self: &Arc<Self>, link: &str) {
		let parsed = packs::parse_link(link);
		eprintln!("Polestar Client: link {link:?} -> {parsed:?}");
		let need_index = {
			let mut state = self.lock();
			state.packs.link_seq += 1;
			let seq = state.packs.link_seq;
			let (pack, error) = match parsed {
				Ok(pack) => (Some(pack), None),
				Err(e) => (None, Some(e)),
			};
			let need = pack.is_some() && state.packs.index.is_none();
			state.packs.link = Some(LinkView { seq, pack, error });
			need
		};
		self.publish();
		if need_index {
			let engine = Arc::clone(self);
			tauri::async_runtime::spawn(async move { engine.check_packs(false).await });
		}
	}

	/// The page has opened link `seq`.
	pub fn link_done(&self, seq: u64) {
		let mut state = self.lock();
		if state.packs.link.as_ref().is_some_and(|l| l.seq == seq) {
			state.packs.link = None;
		}
	}
}
