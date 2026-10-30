//! What the window can ask of the backend.

use std::path::PathBuf;
use std::sync::Arc;

use polestar_recording::install;
use serde::Serialize;
use tauri::{AppHandle, State};
use tauri_plugin_autostart::ManagerExt as _;
use tauri_plugin_dialog::DialogExt;
use tauri_plugin_opener::OpenerExt;

use crate::engine::{now_ms, Engine, Preview, Snapshot, UNKNOWN_TOKEN};
use crate::manager::Changelog;
use crate::store::{ActivityEntry, Channel, DEFAULT_SERVER};

type Engine_<'a> = State<'a, Arc<Engine>>;

#[tauri::command]
pub fn snapshot(engine: Engine_) -> Snapshot {
	engine.snapshot()
}

#[tauri::command]
pub fn rescan(engine: Engine_) {
	engine.rescan();
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct FolderCheck {
	pub path: String,
	/// None when the folder is a WoW: Forever install (and is now the one used).
	pub problem: Option<String>,
}

fn use_folder(engine: &Engine, path: PathBuf) -> Result<FolderCheck, String> {
	let shown = path.display().to_string();
	match install::check_folder(&path) {
		Ok(found) => {
			// The client folder, not the WoW root: a root can hold more than one Forever client.
			engine.save_settings(|s| s.wow_folder = Some(found.flavor_dir.clone()))?;
			engine.rescan();
			Ok(FolderCheck { path: shown, problem: None })
		}
		Err(problem) => Ok(FolderCheck { path: shown, problem: Some(problem.to_string()) }),
	}
}

/// Uses one of the detected installs.
#[tauri::command]
pub async fn choose_folder(engine: Engine_<'_>, path: String) -> Result<FolderCheck, String> {
	use_folder(&engine, PathBuf::from(path))
}

/// The native folder picker; `None` when the player cancelled.
#[tauri::command]
pub async fn pick_folder(app: AppHandle, engine: Engine_<'_>) -> Result<Option<FolderCheck>, String> {
	let picked = app.dialog().file().set_title("Locate your World of Warcraft folder").blocking_pick_folder();
	let Some(picked) = picked else { return Ok(None) };
	let path = picked.into_path().map_err(|e| e.to_string())?;
	use_folder(&engine, path).map(Some)
}

/// Looks for the newest addon releases on GitHub.
#[tauri::command]
pub async fn check_addons(engine: Engine_<'_>) -> Result<(), String> {
	let engine = Arc::clone(&engine);
	engine.check_addons(false).await;
	let error = engine.lock().catalog_error.clone();
	error.map_or(Ok(()), Err)
}

/// `install`, `update`, `repair` or `uninstall` one addon.
#[tauri::command]
pub async fn addon_action(engine: Engine_<'_>, id: String, action: String) -> Result<String, String> {
	let action = match action.as_str() {
		"install" => "install",
		"update" => "update",
		"repair" => "repair",
		"uninstall" => "uninstall",
		_ => return Err(format!("Unknown action {action}.")),
	};
	Arc::clone(&engine).addon_action(&id, action).await
}

#[tauri::command]
pub async fn update_all(engine: Engine_<'_>) -> Result<String, String> {
	Arc::clone(&engine).update_all().await
}

/// Fetches the community pack index (by ETag) and checks its signature.
#[tauri::command]
pub async fn check_packs(engine: Engine_<'_>) -> Result<(), String> {
	let engine = Arc::clone(&engine);
	engine.check_packs(false).await;
	let error = crate::community::view(&engine.lock()).error;
	error.map_or(Ok(()), Err)
}

/// `install`, `update`, `uninstall`, `restore` (a pack the site turned off, once it no longer
/// pulls it) or `discard` (forget a pulled pack) one community pack. An update that changes the
/// pack, its publisher or its folders needs `confirm`.
#[tauri::command]
pub async fn pack_action(engine: Engine_<'_>, id: String, action: String, confirm: Option<bool>) -> Result<String, String> {
	let action = match action.as_str() {
		"install" => "install",
		"update" => "update",
		"uninstall" => "uninstall",
		"restore" => "restore",
		"discard" => "discard",
		_ => return Err(format!("Unknown action {action}.")),
	};
	Arc::clone(&engine).pack_action(&id, action, confirm.unwrap_or(false)).await
}

/// Counting installs on the community site (opt-in).
#[tauri::command]
pub fn set_pack_telemetry(engine: Engine_, enabled: bool) -> Result<(), String> {
	engine.save_settings(|s| s.pack_telemetry = enabled)?;
	engine.publish();
	Ok(())
}

/// "Update guides automatically": routine community pack updates, a day after they came out.
#[tauri::command]
pub fn set_pack_auto_update(engine: Engine_, enabled: bool) -> Result<(), String> {
	engine.save_settings(|s| s.auto_update_packs = enabled)?;
	engine.publish();
	Ok(())
}

/// Sets the community site (debug builds only, for developing the site); an empty one puts
/// polestar.guide back. A release build only ever uses polestar.guide.
#[tauri::command]
pub async fn set_packs_url(engine: Engine_<'_>, url: String) -> Result<String, String> {
	if !cfg!(debug_assertions) {
		return Err("Community Guides always come from polestar.guide.".to_owned());
	}
	let url = web_address(&url, crate::packs::DEFAULT_BASE)?;
	engine.save_settings(|s| s.packs_url = url.clone())?;
	Arc::clone(&engine).check_packs(false).await;
	engine.publish();
	Ok(url)
}

/// The page has opened the `polestar://` link numbered `seq`.
#[tauri::command]
pub fn pack_link_done(engine: Engine_, seq: u64) {
	engine.link_done(seq);
	engine.publish();
}

#[tauri::command]
pub fn changelog(engine: Engine_, id: String) -> Result<Changelog, String> {
	engine.changelog(&id)
}

/// The Addons settings; a channel change looks for updates again.
#[tauri::command]
pub async fn set_addon_prefs(engine: Engine_<'_>, channel: Option<Channel>, auto_check: Option<bool>, auto_install: Option<bool>) -> Result<(), String> {
	let changed_channel = channel.is_some_and(|c| c != engine.lock().settings.channel);
	engine.save_settings(|s| {
		if let Some(c) = channel {
			s.channel = c;
		}
		if let Some(v) = auto_check {
			s.auto_check = v;
		}
		if let Some(v) = auto_install {
			s.auto_install = v;
		}
	})?;
	if changed_channel {
		Arc::clone(&engine).check_addons(false).await;
	}
	engine.publish();
	Ok(())
}

/// Setup's "Continue": the game is found; the Addons page is ready to use.
/// Recording stays off until the player opts in from the Recording section.
#[tauri::command]
pub fn finish_setup(engine: Engine_) -> Result<(), String> {
	engine.save_settings(|s| s.setup_done = true)?;
	engine.publish();
	Ok(())
}

/// The Recording opt-in's "Start sharing" (true) and Settings' "Stop sharing" (false).
#[tauri::command]
pub fn set_sharing(engine: Engine_, enabled: bool) -> Result<(), String> {
	engine.save_settings(|s| {
		s.consent = enabled;
		s.consent_at = enabled.then(now_ms);
		s.paused = false;
	})?;
	engine.publish();
	Ok(())
}

#[tauri::command]
pub fn set_paused(engine: Engine_, paused: bool) -> Result<(), String> {
	engine.save_settings(|s| s.paused = paused)?;
	engine.publish();
	Ok(())
}

#[tauri::command]
pub fn get_autostart(app: AppHandle) -> bool {
	app.autolaunch().is_enabled().unwrap_or(false)
}

#[tauri::command]
pub fn set_autostart(app: AppHandle, enabled: bool) -> Result<(), String> {
	let manager = app.autolaunch();
	let result = if enabled { manager.enable() } else { manager.disable() };
	result.map_err(|e| format!("Could not change starting with your computer: {e}"))
}

/// An address the player typed: https, or http for something on this PC; empty is `default`.
/// Kept in one spelling (packs.rs `normalize_base`), so it compares equal however it was typed.
fn web_address(url: &str, default: &str) -> Result<String, String> {
	let url = url.trim();
	let url = if url.is_empty() { default } else { url };
	let parsed = tauri::Url::parse(url).map_err(|_| "That is not a web address.".to_owned())?;
	if parsed.scheme() != "https" && !(parsed.scheme() == "http" && crate::packs::is_local(url)) {
		return Err("Use an https:// address (http:// only for a server on this PC).".to_owned());
	}
	crate::packs::normalize_base(url).ok_or_else(|| "That is not a web address.".to_owned())
}

/// Sets the recording server (debug builds only, for developing the server); an empty one puts
/// the default back. A release build only ever sends to [`DEFAULT_SERVER`].
#[tauri::command]
pub fn set_server_url(engine: Engine_, url: String) -> Result<String, String> {
	if !cfg!(debug_assertions) {
		return Err(format!("Recordings always go to {DEFAULT_SERVER}."));
	}
	let url = web_address(&url, DEFAULT_SERVER)?;
	engine.save_settings(|s| s.server_url = url.clone())?;
	engine.retry_now();
	engine.publish();
	Ok(url)
}

/// DELETE /v1/me, then this server's token is dropped. Without a token, or with one the server
/// does not know, the server holds nothing from this PC: only the local side is cleared.
#[tauri::command]
pub async fn delete_server_data(engine: Engine_<'_>) -> Result<(), String> {
	let server = engine.server();
	if let Some(token) = engine.store.token(&server) {
		let response = engine.http.delete(format!("{server}/v1/me")).bearer_auth(token).send().await.map_err(|e| format!("Could not reach the server, nothing was deleted: {e}"))?;
		let status = response.status();
		if !status.is_success() {
			let message = crate::engine::server_message(response).await;
			if !(status == reqwest::StatusCode::UNAUTHORIZED && message.as_deref() == Some(UNKNOWN_TOKEN)) {
				return Err(format!("The server did not delete your data ({}).", message.unwrap_or_else(|| status.to_string())));
			}
		}
	}
	engine.forget_server_data(&server)?;
	engine.publish();
	Ok(())
}

#[tauri::command]
pub fn activity(engine: Engine_) -> Vec<ActivityEntry> {
	engine.store.activity()
}

#[tauri::command]
pub async fn preview(engine: Engine_<'_>) -> Result<Preview, String> {
	let engine = Arc::clone(&engine);
	tauri::async_runtime::spawn_blocking(move || engine.preview()).await.map_err(|e| e.to_string())
}

#[tauri::command]
pub fn retry_now(engine: Engine_) {
	engine.retry_now();
}

#[tauri::command]
pub fn open_data_folder(app: AppHandle, engine: Engine_) -> Result<(), String> {
	app.opener().open_path(engine.store.dir.display().to_string(), None::<&str>).map_err(|e| e.to_string())
}

/// Opens a web address in the browser (https only: the project's pages and
/// the links in release notes; http for a community site on this PC).
#[tauri::command]
pub fn open_link(app: AppHandle, url: String) -> Result<(), String> {
	if !url.starts_with("https://") && !(url.starts_with("http://") && crate::packs::is_local(&url)) {
		return Err("Only https:// links open from here.".to_owned());
	}
	app.opener().open_url(url, None::<&str>).map_err(|e| e.to_string())
}

#[tauri::command]
pub async fn check_update(app: AppHandle, engine: Engine_<'_>) -> Result<Option<String>, String> {
	let available = crate::update::check(&app, &engine.http).await?;
	let version = available.as_ref().map(|a| a.version.clone());
	engine.lock().update = available;
	engine.publish();
	Ok(version)
}

#[tauri::command]
pub async fn install_update(app: AppHandle, engine: Engine_<'_>) -> Result<(), String> {
	let available = engine.lock().update.clone().ok_or("No update is waiting.")?;
	crate::update::install(&app, available).await
}

/// What the frame-rate overlay shows: how the window is drawn (render.rs), and whether
/// `POLESTAR_FRAME_METER=1` asked for the overlay from the start.
#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Diagnostics {
	pub renderer: String,
	pub frame_meter: bool,
}

#[tauri::command]
pub fn diagnostics() -> Diagnostics {
	Diagnostics { renderer: crate::render::describe(), frame_meter: std::env::var_os("POLESTAR_FRAME_METER").is_some_and(|v| v != "0") }
}

/// The page has its first frame (the intro): show the window now. False when this launch
/// stays in the tray, so the page skips the intro.
#[tauri::command]
pub fn window_ready(app: AppHandle, launch: State<'_, crate::launch::Launch>) -> bool {
	launch.ready(&app)
}

/// A line from the page for the log (the intro's mode and timings), on stderr.
#[tauri::command]
pub fn client_log(line: String) {
	eprintln!("Polestar Client: {}", line.chars().take(300).collect::<String>());
}
