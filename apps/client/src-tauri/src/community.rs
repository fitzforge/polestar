//! The Community page's backend: the community site's signed pack index
//! (checked with the addon updates every 6 hours, by ETag), installing,
//! updating, removing and restoring packs, `polestar://install?pack=<id>`
//! links, and (when the player opted in) counting installs on the site. Every
//! change lands in the Activity log. The rules themselves are in packs.rs.
//!
//! Each accepted index pins the installed packs that have no pin yet, then
//! applies the site's `revoked` list: a pulled pack is turned off (its folders
//! kept in the data folder) or removed, with a notification and the reason on
//! the page. Pack updates install by themselves only with "Update guides
//! automatically" on, and only routine ones a day old (packs.rs
//! `auto_update_ok`); any other update waits for the player, and one that
//! changes the pack, its publisher or its folders needs their confirm.

use std::collections::BTreeMap;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use serde::Serialize;
use tauri_plugin_notification::NotificationExt;

use crate::addons::{self, Progress};
use crate::engine::{now_ms, Engine, State};
use crate::packs::{self, Changes, Entry, Fetched, Index, Installed, Pin, RevokeAction};
use crate::store::{ActivityEntry, ActivityKind, PackState, Pulled, SavedIndex, Store};

const PROGRESS_EVERY: Duration = Duration::from_millis(100);
/// At most one install sheet this often, however many links a page fires.
const LINK_EVERY: Duration = Duration::from_secs(3);

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
	/// The pins and the pulled packs (community.json), written through.
	pub local: PackState,
	busy: BTreeMap<String, &'static str>,
	progress: BTreeMap<String, Progress>,
	/// The last `polestar://` link, until the page has opened it.
	link: Option<LinkView>,
	link_seq: u64,
	/// When the last link was let through.
	link_at: Option<Instant>,
}

impl Packs {
	/// At start: the last index accepted from `base`, while it still verifies and has not expired.
	pub fn load(store: &Store, base: &str) -> Packs {
		let mut packs = Packs { base: base.to_owned(), local: store.pack_state(), ..Packs::default() };
		if let Some(saved) = store.pack_index(base) {
			match packs::verify_index(saved.body.as_bytes(), saved.sig.as_bytes(), &packs::keys(), base, now_ms(), Some(saved.generated)) {
				Ok(index) => {
					packs.index = Some(index);
					packs.etag = saved.etag;
				}
				Err(e) => eprintln!("The saved community index is not used: {e}"),
			}
		}
		packs
	}

	/// The index, when it is the configured site's.
	fn index_for(&self, base: &str) -> Option<&Index> {
		self.index.as_ref().filter(|_| self.base == base)
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
	/// "Update guides automatically".
	pub auto_update: bool,
	pub checked_at: Option<i64>,
	pub checking: bool,
	pub error: Option<String>,
	pub game_found: bool,
	pub game_running: bool,
	/// Installed (and pulled) packs first, then the ones that can be installed; each by title.
	pub packs: Vec<PackView>,
	pub link: Option<LinkView>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct PackView {
	pub id: String,
	pub title: String,
	pub author: String,
	/// The version the index offers (none for a pack it no longer lists, or only lists pulled).
	pub version: Option<String>,
	pub installed: Option<String>,
	/// `install`, `update`, `upToDate`, `unlisted` (installed, no longer in the index), `noGame`,
	/// `replaced` (the index's pack under this id is another one), `disabled` (pulled by the site,
	/// its folders kept out of AddOns) or `removed` (pulled and deleted).
	pub status: &'static str,
	/// Why it can't be installed or updated in this game now.
	pub blocked: Option<String>,
	pub size: Option<u64>,
	/// The folders it has, or will create.
	pub folders: Vec<String>,
	pub homepage: Option<String>,
	pub changelog: Option<String>,
	pub official: bool,
	/// The index's publisher handle, whether a moderator reviewed this version, when it came out.
	pub publisher: Option<String>,
	pub reviewed: bool,
	pub published: Option<i64>,
	/// What the update changes against the install (`update`, `replaced`): the player confirms it.
	pub changes: Option<Changes>,
	/// Why the site pulled it.
	pub revoked: Option<RevokedView>,
	pub busy: Option<&'static str>,
	pub progress: Option<Progress>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct RevokedView {
	pub reason: String,
	pub at: i64,
	pub action: RevokeAction,
}

/// The game's TOC Interface and the installed Polestar's version: what packs are checked against.
fn game(state: &State) -> (Option<u32>, Option<String>) {
	let interface = state.install.as_ref().and_then(|i| i.version.as_deref()).and_then(packs::interface_of);
	let polestar = state.install.as_ref().and_then(|i| addons::product("polestar").and_then(|p| addons::installed_version(&i.addons_dir(), p)));
	(interface, polestar)
}

/// Why `entry` can't go in: the site pulled that version, or the game or Polestar don't fit.
fn why_blocked(index: &Index, entry: &Entry, site: &str, interface: Option<u32>, polestar: Option<&str>) -> Option<String> {
	match index.revocation(&entry.id, entry.uid.as_deref(), Some(&entry.version)) {
		Some((r, _)) => Some(format!("{site} pulled this version: {}", r.reason)),
		None => packs::blocked(entry, interface, polestar),
	}
}

pub fn view(state: &State) -> CommunityView {
	let base = state.settings.packs_url.clone();
	let site = packs::host(&base);
	let p = &state.packs;
	let (interface, polestar) = game(state);
	let game_found = state.install.is_some();
	let index = p.index_for(&base);
	let blocked = |e: &Entry| index.and_then(|i| why_blocked(i, e, &site, interface, polestar.as_deref()));
	let publisher = |e: Option<&Entry>| e.and_then(|e| e.publisher.as_ref().and_then(|p| p.handle.clone()));
	let mut installed: Vec<PackView> = Vec::new();
	let mut available: Vec<PackView> = Vec::new();
	for have in &p.installed {
		let entry = index.and_then(|i| i.get(&have.id));
		let pin = p.local.pins.get(&have.id);
		let changes = entry.zip(pin).map(|(e, pin)| packs::changes(pin, e)).filter(Changes::any);
		let status = match (entry, &have.version) {
			(None, _) => "unlisted",
			_ if changes.as_ref().is_some_and(|c| c.replaced) => "replaced",
			(Some(e), Some(v)) if !addons::newer(&e.version, v) => "upToDate",
			_ => "update",
		};
		let offered = matches!(status, "update" | "replaced");
		let revoked = index.and_then(|i| i.revocation(&have.id, pin.and_then(|p| p.uid.as_deref()), have.version.as_deref()).map(|(r, action)| RevokedView { reason: r.reason.clone(), at: i.generated, action }));
		installed.push(PackView {
			id: have.id.clone(),
			title: entry.map(|e| e.title.clone()).or_else(|| have.title.clone()).unwrap_or_else(|| have.id.clone()),
			author: entry.map(|e| e.author.clone()).or_else(|| have.author.clone()).unwrap_or_default(),
			version: entry.map(|e| e.version.clone()),
			installed: have.version.clone(),
			status,
			blocked: entry.filter(|_| offered).and_then(blocked),
			size: entry.map(|e| e.download.size),
			folders: have.folders.clone(),
			homepage: entry.and_then(|e| e.homepage.clone()),
			changelog: entry.map(|e| e.changelog.clone()),
			official: entry.is_some_and(|e| e.official),
			publisher: publisher(entry),
			reviewed: entry.is_some_and(|e| e.reviewed),
			published: entry.and_then(Entry::published_at),
			changes: changes.filter(|_| offered),
			revoked,
			busy: p.busy.get(&have.id).copied(),
			progress: p.progress.get(&have.id).copied(),
		});
	}
	for (id, pulled) in &p.local.pulled {
		if p.installed.iter().any(|h| &h.id == id) {
			continue;
		}
		// A version the site offers and doesn't pull can be installed in its place.
		let entry = index.and_then(|i| i.get(id).filter(|e| i.revocation(id, e.uid.as_deref(), Some(&e.version)).is_none()));
		installed.push(PackView {
			id: id.clone(),
			title: pulled.title.clone(),
			author: entry.map(|e| e.author.clone()).unwrap_or_default(),
			version: entry.map(|e| e.version.clone()),
			installed: pulled.version.clone(),
			status: if pulled.action == RevokeAction::Disable { "disabled" } else { "removed" },
			blocked: entry.filter(|_| game_found).and_then(blocked),
			size: entry.map(|e| e.download.size),
			folders: pulled.folders.clone(),
			homepage: entry.and_then(|e| e.homepage.clone()),
			changelog: entry.map(|e| e.changelog.clone()),
			official: entry.is_some_and(|e| e.official),
			publisher: publisher(entry),
			reviewed: entry.is_some_and(|e| e.reviewed),
			published: entry.and_then(Entry::published_at),
			changes: None,
			revoked: Some(RevokedView { reason: pulled.reason.clone(), at: pulled.at, action: pulled.action }),
			busy: p.busy.get(id).copied(),
			progress: p.progress.get(id).copied(),
		});
	}
	for e in index.map(|i| i.packs.as_slice()).unwrap_or_default() {
		if p.installed.iter().any(|h| h.id == e.id) || p.local.pulled.contains_key(&e.id) {
			continue;
		}
		available.push(PackView {
			id: e.id.clone(),
			title: e.title.clone(),
			author: e.author.clone(),
			version: Some(e.version.clone()),
			installed: None,
			status: if game_found { "install" } else { "noGame" },
			blocked: game_found.then(|| blocked(e)).flatten(),
			size: Some(e.download.size),
			folders: e.addon.clone(),
			homepage: e.homepage.clone(),
			changelog: Some(e.changelog.clone()),
			official: e.official,
			publisher: publisher(Some(e)),
			reviewed: e.reviewed,
			published: e.published_at(),
			changes: None,
			revoked: None,
			busy: p.busy.get(&e.id).copied(),
			progress: p.progress.get(&e.id).copied(),
		});
	}
	let by_title = |a: &PackView, b: &PackView| a.title.to_lowercase().cmp(&b.title.to_lowercase());
	installed.sort_by(by_title);
	available.sort_by(by_title);
	installed.extend(available);
	CommunityView {
		available: !packs::keys().is_empty(),
		site,
		default_base: packs::DEFAULT_BASE.to_owned(),
		telemetry: state.settings.pack_telemetry,
		auto_update: state.settings.auto_update_packs,
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

/// Routine updates the game can take: one click each, and what "Update all" installs.
pub fn updates(state: &State) -> Vec<(String, String, String)> {
	view(state).packs.into_iter().filter(|p| p.status == "update" && p.blocked.is_none() && p.changes.is_none()).map(|p| (p.id, p.title, p.version.unwrap_or_default())).collect()
}

/// Every update the game can take, and whether it may install by itself at `now`.
fn pending(state: &State, now: i64) -> Vec<(String, String, String, bool)> {
	let index = state.packs.index_for(&state.settings.packs_url);
	view(state)
		.packs
		.into_iter()
		.filter(|p| matches!(p.status, "update" | "replaced") && p.blocked.is_none())
		.map(|p| {
			let auto = index.and_then(|i| i.get(&p.id)).is_some_and(|e| packs::auto_update_ok(state.packs.local.pins.get(&p.id), e, now).is_ok());
			(p.id, p.title, p.version.unwrap_or_default(), auto)
		})
		.collect()
}

/// May a `polestar://` link through now (`since_last`: since the last one let through)? Not
/// within [`LINK_EVERY`] of it, nor one for the pack whose sheet is still waiting to open.
fn admit_link(since_last: Option<Duration>, waiting: Option<&str>, pack: Option<&str>) -> bool {
	since_last.is_none_or(|d| d >= LINK_EVERY) && !(pack.is_some() && waiting == pack)
}

impl Engine {
	/// Re-reads which packs are in AddOns.
	pub fn refresh_packs(&self) {
		let dir = self.lock().install.as_ref().map(|i| i.addons_dir());
		let installed = dir.map(|d| packs::installed(&d)).unwrap_or_default();
		self.lock().packs.installed = installed;
	}

	fn save_pack_state(&self, local: &PackState) {
		if let Err(e) = self.store.save_pack_state(local) {
			eprintln!("Could not keep community.json: {e}");
		}
	}

	/// Fetches the index (by ETag) and checks it, then pins and applies its revocations. In the
	/// background (the 6-hourly check) it announces pack updates in the tray, or installs the
	/// routine ones when the player turned that on and the game is closed.
	pub async fn check_packs(self: &Arc<Self>, background: bool) {
		let (base, etag, last) = {
			let mut state = self.lock();
			let base = state.settings.packs_url.clone();
			if state.packs.base != base {
				let keep = std::mem::take(&mut state.packs);
				state.packs = Packs::load(&self.store, &base);
				state.packs.link = keep.link;
				state.packs.link_seq = keep.link_seq;
				state.packs.link_at = keep.link_at;
				state.packs.installed = keep.installed;
			}
			if state.packs.checking || packs::keys().is_empty() {
				return;
			}
			state.packs.checking = true;
			let etag = state.packs.index.as_ref().and(state.packs.etag.clone());
			let last = self.store.pack_index(&base).map(|s| s.generated);
			(base, etag, last)
		};
		self.publish();
		let result = match packs::fetch_index(&self.packs_http, &base, etag.as_deref()).await {
			Ok(Fetched::NotModified) => Ok(None),
			Ok(Fetched::New { body, sig, etag }) => packs::verify_index(&body, &sig, &packs::keys(), &base, now_ms(), last).and_then(|index| {
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
		self.sync_packs().await;
		self.publish();
		if !background {
			return;
		}
		let (pending, auto, running) = {
			let state = self.lock();
			(pending(&state, now_ms()), state.settings.auto_update_packs, state.game_running)
		};
		let mut announce = Vec::new();
		for (id, title, version, ok) in pending {
			if auto && ok && !running {
				let _ = self.pack_action(&id, "update", false).await;
			} else {
				announce.push((id, title, version));
			}
		}
		let fresh: Vec<String> = {
			let mut state = self.lock();
			announce.iter().filter(|(id, _, v)| state.notified.insert(format!("pack:{id} {v}"))).map(|(_, title, v)| format!("{title} {v}")).collect()
		};
		if !fresh.is_empty() {
			let _ = self.app().notification().builder().title("Community Guide updates").body(format!("{} ready to install. Open Polestar Client to update.", fresh.join(", "))).show();
		}
	}

	/// With the index in hand: pins the installed packs that have none (or lack the index's uid or
	/// publisher yet), then turns off or removes every installed pack the index's `revoked` list
	/// covers. That happens while the game runs too (it read the files at login): the player is
	/// told to /reload.
	async fn sync_packs(self: &Arc<Self>) {
		let (dir, pulls) = {
			let mut state = self.lock();
			let Some(dir) = state.install.as_ref().map(|i| i.addons_dir()) else { return };
			let state = &mut *state;
			let packs = &mut state.packs;
			let Some(index) = packs.index.as_ref().filter(|_| packs.base == state.settings.packs_url) else { return };
			let mut local = packs.local.clone();
			for have in &packs.installed {
				let pin = Pin::adopt(local.pins.get(&have.id), index.get(&have.id), have);
				local.pins.insert(have.id.clone(), pin);
			}
			let now = now_ms();
			let pulls: Vec<(String, Pulled)> = packs
				.installed
				.iter()
				.filter(|h| !packs.busy.contains_key(&h.id))
				.filter_map(|have| {
					let uid = local.pins.get(&have.id).and_then(|p| p.uid.clone());
					let (r, action) = index.revocation(&have.id, uid.as_deref(), have.version.as_deref())?;
					let title = index.get(&have.id).map(|e| e.title.clone()).or_else(|| have.title.clone()).unwrap_or_else(|| have.id.clone());
					Some((have.id.clone(), Pulled { title, version: have.version.clone(), uid, folders: have.folders.clone(), reason: r.reason.clone(), action, at: now }))
				})
				.collect();
			if local != packs.local {
				self.save_pack_state(&local);
				packs.local = local;
			}
			for (id, _) in &pulls {
				packs.busy.insert(id.clone(), "uninstall");
			}
			(dir, pulls)
		};
		if pulls.is_empty() {
			return;
		}
		self.publish();
		let site = packs::host(&self.lock().settings.packs_url);
		for (id, pulled) in pulls {
			let (addons, kept, pack, action) = (dir.clone(), self.store.disabled_dir(&id), id.clone(), pulled.action);
			let result = tauri::async_runtime::spawn_blocking(move || match action {
				RevokeAction::Disable => packs::disable(&pack, &addons, &kept),
				RevokeAction::Remove => packs::uninstall(&pack, &addons),
			})
			.await
			.map_err(|e| e.to_string())
			.and_then(|r| r);
			{
				let mut state = self.lock();
				state.packs.busy.remove(&id);
				if result.is_ok() {
					let local = &mut state.packs.local;
					if action == RevokeAction::Remove {
						local.pins.remove(&id);
					}
					local.pulled.insert(id.clone(), pulled.clone());
					let local = local.clone();
					self.save_pack_state(&local);
				}
			}
			let version = pulled.version.clone().unwrap_or_default();
			let (verb, kind) = match action {
				RevokeAction::Disable => ("turned off", ActivityKind::Disabled),
				RevokeAction::Remove => ("removed", ActivityKind::Removed),
			};
			let message = match &result {
				Ok(_) => pulled.reason.clone(),
				Err(e) => format!("{} Polestar Client could not do it: {e} It tries again at the next check.", pulled.reason),
			};
			let _ = self.store.push_activity(ActivityEntry { kind, at: now_ms(), product: Some(pulled.title.clone()), version: pulled.version.clone(), message: Some(message), ..Default::default() });
			let first = self.lock().notified.insert(format!("pulled:{id} {version}"));
			if result.is_ok() || first {
				let body = match &result {
					Ok(_) => format!("{} {version}: {} Restart the game (or /reload) if it is running.", pulled.title, pulled.reason),
					Err(_) => format!("{} {version}: {} Polestar Client could not take it out of AddOns yet; see Activity.", pulled.title, pulled.reason),
				};
				let _ = self.app().notification().builder().title(format!("{site} {verb} a Community Guide")).body(body).show();
			}
		}
		self.refresh_packs();
		self.publish();
	}

	/// Installs, updates, removes, restores or discards one pack. An update that changes the
	/// pack, its publisher or its folders goes ahead only with `confirm`. Returns what was done.
	pub async fn pack_action(self: &Arc<Self>, id: &str, action: &'static str, confirm: bool) -> Result<String, String> {
		if !packs::valid_id(id) {
			return Err("No such guide.".to_owned());
		}
		if matches!(action, "restore" | "discard") {
			return self.pulled_action(id, action).await;
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
					let site = packs::host(&state.settings.packs_url);
					let index = state.packs.index_for(&state.settings.packs_url);
					let entry = index.and_then(|i| i.get(id)).cloned().ok_or_else(|| format!("{id} isn't in the community index. Check for updates, or look for it on {site}."))?;
					let (interface, polestar) = game(&state);
					if let Some(why) = index.and_then(|i| why_blocked(i, &entry, &site, interface, polestar.as_deref())) {
						return Err(format!("{} can't be installed: {why}", entry.title));
					}
					if let (Some(_), Some(pin)) = (&have, state.packs.local.pins.get(id)) {
						let changes = packs::changes(pin, &entry);
						if changes.any() && !confirm {
							return Err(changes.describe(&entry.title));
						}
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
			Some(entry) => packs::install(&self.packs_http, entry, &dir, &report).await,
			None => {
				report(Progress::step("remove"));
				let (dir, id) = (dir.clone(), id.to_owned());
				tauri::async_runtime::spawn_blocking(move || packs::uninstall(&id, &dir)).await.map_err(|e| e.to_string()).and_then(|r| r)
			}
		};
		let cleared = {
			let mut state = self.lock();
			state.packs.busy.remove(id);
			state.packs.progress.remove(id);
			let mut cleared = false;
			if let Ok(folders) = &result {
				let local = &mut state.packs.local;
				match &entry {
					Some(e) => {
						local.pins.insert(id.to_owned(), Pin::of(e, folders));
						cleared = local.pulled.remove(id).is_some();
					}
					None => {
						local.pins.remove(id);
					}
				}
				let local = local.clone();
				self.save_pack_state(&local);
			}
			cleared
		};
		if cleared {
			let _ = std::fs::remove_dir_all(self.store.disabled_dir(id));
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
		if let (Ok(_), Some(entry)) = (&result, &entry) {
			let (telemetry, base) = {
				let state = self.lock();
				(state.settings.pack_telemetry, state.settings.packs_url.clone())
			};
			if telemetry {
				let (http, id, version) = (self.packs_http.clone(), id.to_owned(), entry.version.clone());
				tauri::async_runtime::spawn(async move { packs::report_install(&http, &base, &id, &version).await });
			}
		}
		self.publish();
		result.map(|_| match &entry {
			None => format!("{title} removed."),
			Some(e) => format!("{title} {} installed. Restart the game (or /reload) to load it.", e.version),
		})
	}

	/// `restore` puts a turned-off pack back (refused while the site still pulls it); `discard`
	/// forgets a pulled pack and deletes the copy kept of it.
	async fn pulled_action(self: &Arc<Self>, id: &str, action: &'static str) -> Result<String, String> {
		let (dir, pulled) = {
			let state = self.lock();
			let pulled = state.packs.local.pulled.get(id).cloned().ok_or("That guide wasn't pulled by the site.")?;
			if state.packs.busy.contains_key(id) {
				return Err("That guide is busy already.".to_owned());
			}
			if action == "restore" {
				if pulled.action != RevokeAction::Disable {
					return Err(format!("{} was removed, so there is no copy to restore.", pulled.title));
				}
				let site = packs::host(&state.settings.packs_url);
				let index = state.packs.index_for(&state.settings.packs_url).ok_or_else(|| format!("Check for updates first: a guide {site} pulled comes back only once the site no longer pulls it."))?;
				if let Some((r, _)) = index.revocation(id, pulled.uid.as_deref(), pulled.version.as_deref()) {
					return Err(format!("{site} still pulls {} {}: {}", pulled.title, pulled.version.as_deref().unwrap_or(""), r.reason));
				}
			}
			(state.install.as_ref().map(|i| i.addons_dir()), pulled)
		};
		let kept = self.store.disabled_dir(id);
		if action == "discard" {
			if kept.exists() {
				std::fs::remove_dir_all(&kept).map_err(|e| format!("Could not delete {}: {e}", kept.display()))?;
			}
			{
				let mut state = self.lock();
				let local = &mut state.packs.local;
				local.pulled.remove(id);
				local.pins.remove(id);
				let local = local.clone();
				self.save_pack_state(&local);
			}
			self.publish();
			return Ok(match pulled.action {
				RevokeAction::Disable => format!("The copy kept of {} is deleted.", pulled.title),
				RevokeAction::Remove => format!("{} is off the list.", pulled.title),
			});
		}
		let dir = dir.ok_or("Find the game folder first (Settings > Game).")?;
		let (pack, addons, from) = (id.to_owned(), dir, kept);
		let result = tauri::async_runtime::spawn_blocking(move || packs::restore(&pack, &addons, &from)).await.map_err(|e| e.to_string()).and_then(|r| r);
		if result.is_ok() {
			let mut state = self.lock();
			state.packs.local.pulled.remove(id);
			let local = state.packs.local.clone();
			self.save_pack_state(&local);
		}
		let _ = self.store.push_activity(ActivityEntry { kind: ActivityKind::Restored, at: now_ms(), product: Some(pulled.title.clone()), version: pulled.version.clone(), message: result.as_ref().err().cloned(), ..Default::default() });
		self.refresh_packs();
		self.publish();
		result.map(|_| format!("{} {} is back. Restart the game (or /reload) to load it.", pulled.title, pulled.version.as_deref().unwrap_or("")))
	}

	/// A `polestar://` link (from the browser, through the system): the page opens it on the
	/// Community page and asks before anything is installed. One every few seconds at most;
	/// a repeat of the one still waiting is dropped.
	pub fn open_link(self: &Arc<Self>, link: &str) {
		let parsed = packs::parse_link(link);
		eprintln!("Polestar Client: link {link:?} -> {parsed:?}");
		let need_index = {
			let mut state = self.lock();
			let pack = parsed.as_ref().ok().map(String::as_str);
			let waiting = state.packs.link.as_ref().and_then(|l| l.pack.as_deref());
			if !admit_link(state.packs.link_at.map(|t| t.elapsed()), waiting, pack) {
				eprintln!("Polestar Client: link ignored (too soon after the last one, or the same one again)");
				return;
			}
			state.packs.link_at = Some(Instant::now());
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

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn links_are_coalesced() {
		// The first link, and one a while after the last.
		assert!(admit_link(None, None, Some("emberway")));
		assert!(admit_link(Some(Duration::from_secs(4)), None, Some("emberway")));
		// A burst: one sheet per few seconds.
		assert!(!admit_link(Some(Duration::from_millis(500)), None, Some("wayfarer")));
		// The same pack again while its sheet is still waiting.
		assert!(!admit_link(Some(Duration::from_secs(10)), Some("emberway"), Some("emberway")));
		assert!(admit_link(Some(Duration::from_secs(10)), Some("emberway"), Some("wayfarer")));
	}
}
