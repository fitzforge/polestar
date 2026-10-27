//! The Addons page's backend: checking GitHub for Polestar's addons,
//! installing, updating, repairing and removing them, announcing updates in
//! the tray and (when the player asked for it) installing them unattended.
//! Every change lands in the Activity log.

use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use serde::Serialize;
use tauri_plugin_notification::NotificationExt;

use crate::addons::{self, Product, Release, PRODUCTS};
use crate::engine::{now_ms, Catalog, Engine, State};
use crate::store::{ActivityEntry, ActivityKind, Channel};

/// How often a download's progress reaches the window.
const PROGRESS_EVERY: Duration = Duration::from_millis(100);

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct AddonsView {
	pub checked_at: Option<i64>,
	pub checking: bool,
	pub error: Option<String>,
	pub channel: Channel,
	pub auto_check: bool,
	pub auto_install: bool,
	pub game_found: bool,
	pub game_running: bool,
	pub products: Vec<ProductView>,
}

#[derive(Serialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct ProductView {
	pub id: &'static str,
	pub name: &'static str,
	pub blurb: &'static str,
	pub installed: Option<String>,
	pub latest: Option<Release>,
	/// `noGame`, `unknown` (not checked yet), `unavailable` (no release
	/// published), `install`, `update` or `upToDate`.
	pub status: &'static str,
	/// What is being done to it right now (`install`, `update`, `repair`, `uninstall`).
	pub busy: Option<&'static str>,
	/// How far that has got.
	pub progress: Option<addons::Progress>,
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Changelog {
	pub name: &'static str,
	pub title: String,
	pub version: String,
	pub published_at: Option<String>,
	pub body: String,
	pub page_url: String,
}

pub fn view(state: &State) -> AddonsView {
	let addons_dir = state.install.as_ref().map(|i| i.addons_dir());
	let products = PRODUCTS
		.iter()
		.map(|p| {
			let installed = addons_dir.as_deref().and_then(|d| addons::installed_version(d, p));
			let latest = state.catalog.as_ref().and_then(|c| c.latest(p.id)).cloned();
			let status = match (&addons_dir, &state.catalog, &latest, &installed) {
				(None, ..) => "noGame",
				(_, None, _, _) => "unknown",
				(_, Some(_), None, _) => "unavailable",
				(_, _, Some(_), None) => "install",
				(_, _, Some(l), Some(have)) if addons::newer(&l.version, have) => "update",
				_ => "upToDate",
			};
			ProductView { id: p.id, name: p.name, blurb: p.blurb, installed, latest, status, busy: state.busy.get(p.id).copied(), progress: state.addon_progress.get(p.id).copied() }
		})
		.collect();
	AddonsView {
		checked_at: state.catalog.as_ref().map(|c| c.at),
		checking: state.checking,
		error: state.catalog_error.clone(),
		channel: state.settings.channel,
		auto_check: state.settings.auto_check,
		auto_install: state.settings.auto_install,
		game_found: addons_dir.is_some(),
		game_running: state.game_running,
		products,
	}
}

impl Engine {
	/// Looks for the newest releases. In the background (the 6-hourly check)
	/// it announces new updates in the tray and installs them when the player
	/// turned that on and the game is closed.
	pub async fn check_addons(self: &Arc<Self>, background: bool) {
		self.fetch_catalog().await;
		if !background {
			return;
		}
		let (updates, auto_install, running) = {
			let state = self.lock();
			let updates: Vec<(&'static str, &'static str, String)> = view(&state).products.into_iter().filter(|p| p.status == "update").filter_map(|p| p.latest.map(|l| (p.id, p.name, l.version))).collect();
			(updates, state.settings.auto_install, state.game_running)
		};
		if updates.is_empty() {
			return;
		}
		if auto_install && !running {
			for (id, ..) in &updates {
				let _ = self.addon_action(id, "update").await;
			}
			return;
		}
		let fresh: Vec<String> = {
			let mut state = self.lock();
			updates.iter().map(|(_, name, v)| format!("{name} {v}")).filter(|key| state.notified.insert(key.clone())).collect()
		};
		if !fresh.is_empty() {
			let _ = self.app().notification().builder().title("Polestar addon updates").body(format!("{} ready to install. Open Polestar Client to update.", fresh.join(", "))).show();
		}
	}

	/// Reads the newest releases from GitHub into the catalog.
	async fn fetch_catalog(&self) {
		let beta = {
			let mut state = self.lock();
			if state.checking {
				return;
			}
			state.checking = true;
			state.settings.channel == Channel::Beta
		};
		self.publish();
		let result = addons::releases(&self.http, beta).await;
		{
			let mut state = self.lock();
			state.checking = false;
			match result {
				Ok(releases) => {
					state.catalog = Some(Catalog { at: now_ms(), releases });
					state.catalog_error = None;
				}
				Err(e) => state.catalog_error = Some(e),
			}
		}
		self.publish();
	}

	/// Installs, updates, repairs or removes one product. Returns what was done.
	pub async fn addon_action(self: &Arc<Self>, id: &str, action: &'static str) -> Result<String, String> {
		let product: &'static Product = addons::product(id).ok_or("No such addon.")?;
		if self.lock().catalog.is_none() && action != "uninstall" {
			self.fetch_catalog().await;
		}
		let (dir, release) = {
			let mut state = self.lock();
			let dir = state.install.as_ref().map(|i| i.addons_dir()).ok_or("Find the game folder first (Settings > Game).")?;
			if state.busy.contains_key(product.id) {
				return Err(format!("{} is busy already.", product.name));
			}
			let release = match action {
				"uninstall" => None,
				_ => {
					let catalog = state.catalog.as_ref().ok_or_else(|| state.catalog_error.clone().unwrap_or_else(|| "Could not check GitHub.".to_owned()))?;
					let releases = catalog.releases.get(product.id).ok_or_else(|| format!("No {} release has been published yet.", product.name))?;
					// Repair re-installs the version that is there, when it is still published.
					let installed = addons::installed_version(&dir, product);
					let chosen = (action == "repair").then(|| releases.iter().find(|r| Some(&r.version) == installed.as_ref())).flatten();
					Some(chosen.unwrap_or(&releases[0]).clone())
				}
			};
			state.busy.insert(product.id, action);
			(dir, release)
		};
		self.publish();
		let before = addons::installed_version(&dir, product);
		// Progress goes to the window at most every PROGRESS_EVERY, and at once when the phase changes.
		let last = Mutex::new((Instant::now(), ""));
		let report = |p: addons::Progress| {
			self.lock().addon_progress.insert(product.id, p);
			let mut last = last.lock().unwrap_or_else(|e| e.into_inner());
			if last.1 != p.phase || last.0.elapsed() >= PROGRESS_EVERY {
				*last = (Instant::now(), p.phase);
				drop(last);
				self.publish();
			}
		};
		let result = match &release {
			Some(release) => addons::install(&self.http, product, release, &dir, &report).await.map(|_| release.version.clone()),
			None => {
				report(addons::Progress::step("remove"));
				let dir = dir.clone();
				tauri::async_runtime::spawn_blocking(move || addons::uninstall(product, &dir)).await.map_err(|e| e.to_string()).and_then(|r| r).map(|_| String::new())
			}
		};
		{
			let mut state = self.lock();
			state.busy.remove(product.id);
			state.addon_progress.remove(product.id);
		}
		let kind = match action {
			"uninstall" => ActivityKind::Uninstall,
			"repair" => ActivityKind::Repair,
			_ if before.is_some() => ActivityKind::Update,
			_ => ActivityKind::Install,
		};
		let _ = self.store.push_activity(ActivityEntry {
			kind,
			at: now_ms(),
			product: Some(product.name.to_owned()),
			version: release.as_ref().map(|r| r.version.clone()).or(before),
			message: result.as_ref().err().cloned(),
			..Default::default()
		});
		if product.id == "recorder" && action != "uninstall" && result.is_ok() {
			// The release ships an empty Ack.lua; put back what the server confirmed.
			self.rewrite_ack();
		}
		self.rescan();
		self.publish();
		result.map(|version| match action {
			"uninstall" => format!("{} removed.", product.name),
			"repair" => format!("{} {version} re-installed.", product.name),
			_ => format!("{} {version} installed. Restart the game (or /reload) to load it.", product.name),
		})
	}

	/// Updates every installed product that has a newer release, then every community pack
	/// with a newer version the game can take (the Addons badge counts both).
	pub async fn update_all(self: &Arc<Self>) -> Result<String, String> {
		let (ids, packs) = {
			let state = self.lock();
			let ids: Vec<&'static str> = view(&state).products.into_iter().filter(|p| p.status == "update").map(|p| p.id).collect();
			(ids, crate::community::updates(&state))
		};
		if ids.is_empty() && packs.is_empty() {
			return Ok("Everything is up to date.".to_owned());
		}
		let mut done = Vec::new();
		let mut failed = Vec::new();
		for id in ids {
			match self.addon_action(id, "update").await {
				Ok(text) => done.push(text),
				Err(e) => failed.push(e),
			}
		}
		for (id, ..) in packs {
			match self.pack_action(&id, "update").await {
				Ok(text) => done.push(text),
				Err(e) => failed.push(e),
			}
		}
		if failed.is_empty() {
			Ok(done.join(" "))
		} else {
			Err(failed.join(" "))
		}
	}

	/// The release notes of a product's newest release.
	pub fn changelog(&self, id: &str) -> Result<Changelog, String> {
		let product = addons::product(id).ok_or("No such addon.")?;
		let state = self.lock();
		let release = state.catalog.as_ref().and_then(|c| c.latest(id)).ok_or("Check for updates first.")?;
		Ok(Changelog {
			name: product.name,
			title: release.title.clone(),
			version: release.version.clone(),
			published_at: release.published_at.clone(),
			body: release.body.clone(),
			page_url: release.page_url.clone(),
		})
	}
}
