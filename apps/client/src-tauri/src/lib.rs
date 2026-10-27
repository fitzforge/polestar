//! Polestar Client: finds World of Warcraft: Forever, installs the Polestar
//! Recorder, and with the player's consent uploads what it records to the
//! recording server (docs/RECORDING.md is the contract). It also installs and
//! updates community guide packs from polestar.guide, and opens the site's
//! `polestar://install?pack=<id>` links.

mod addons;
mod commands;
mod community;
#[cfg(target_os = "linux")]
mod desktop;
mod engine;
mod launch;
mod manager;
mod packs;
mod register;
pub mod render;
mod store;
mod tray;
mod update;
mod window;

use std::sync::Arc;
use std::time::Duration;

use tauri::plugin::{Plugin, TauriPlugin};
use tauri::{AppHandle, Manager, RunEvent, Runtime, WindowEvent};
use tauri_plugin_autostart::MacosLauncher;

use crate::engine::Engine;
use crate::store::Store;

/// Passed by the autostart entry: start in the tray, not on screen.
const HIDDEN_ARG: &str = "--hidden";
const UPDATE_CHECK: Duration = Duration::from_secs(6 * 3600);
/// The single-instance plugin, made unable to stop the start. It hands a second start over to the
/// running client; when that hand-over fails (on Linux a stale D-Bus name left by a client that
/// was killed answers "NoReply"), the plugin errors out of its setup and Tauri would panic. Then
/// this client simply starts as the only one.
struct SingleInstance<R: Runtime>(TauriPlugin<R>);

impl<R: Runtime> Plugin<R> for SingleInstance<R> {
	fn name(&self) -> &'static str {
		self.0.name()
	}

	fn initialize(&mut self, app: &AppHandle<R>, config: serde_json::Value) -> Result<(), Box<dyn std::error::Error>> {
		if let Err(e) = self.0.initialize(app, config) {
			eprintln!("Starting without the single-instance check: {e}");
		}
		Ok(())
	}

	fn on_event(&mut self, app: &AppHandle<R>, event: &RunEvent) {
		self.0.on_event(app, event);
	}
}

/// Hands the `polestar://` links among a start's arguments to the engine (Linux and Windows
/// start the client with the link; a second start forwards its arguments to the running one).
fn open_links(app: &AppHandle, args: &[String]) {
	let Some(engine) = app.try_state::<Arc<Engine>>() else { return };
	for link in args.iter().skip(1).filter(|a| a.starts_with("polestar:")) {
		engine.open_link(link);
	}
}

/// The link this start was opened with, and on macOS (where links arrive as events, not
/// arguments) every link from now on. On Windows the client also registers the scheme for
/// itself, for a copy that was not installed by the installer (which registers it too).
fn links(app: &AppHandle) {
	#[cfg(not(target_os = "macos"))]
	open_links(app, &std::env::args().collect::<Vec<_>>());
	#[cfg(target_os = "macos")]
	{
		use tauri_plugin_deep_link::DeepLinkExt;
		let handle = app.clone();
		app.deep_link().on_open_url(move |event| {
			launch::open(&handle);
			if let Some(engine) = handle.try_state::<Arc<Engine>>() {
				for url in event.urls() {
					engine.open_link(url.as_str());
				}
			}
		});
		if let (Ok(Some(urls)), Some(engine)) = (app.deep_link().get_current(), app.try_state::<Arc<Engine>>()) {
			for url in urls {
				engine.open_link(url.as_str());
			}
		}
	}
	#[cfg(windows)]
	{
		use tauri_plugin_deep_link::DeepLinkExt;
		if let Err(e) = app.deep_link().register("polestar") {
			eprintln!("Could not register polestar:// links: {e}");
		}
	}
}

pub fn run() {
	// reqwest and the updater use rustls with ring.
	let _ = rustls::crypto::ring::default_provider().install_default();
	let hidden = std::env::args().any(|a| a == HIDDEN_ARG);
	tauri::Builder::default()
		// Before anything else, so the page can ask for its window the moment it loads.
		.manage(launch::Launch::new(hidden))
		.plugin(SingleInstance(tauri_plugin_single_instance::init(|app, args, _cwd| {
			launch::open(app);
			open_links(app, &args);
		})))
		.plugin(tauri_plugin_deep_link::init())
		.plugin(tauri_plugin_autostart::init(MacosLauncher::LaunchAgent, Some(vec![HIDDEN_ARG])))
		.plugin(tauri_plugin_dialog::init())
		.plugin(tauri_plugin_opener::init())
		.plugin(tauri_plugin_updater::Builder::new().build())
		.plugin(tauri_plugin_notification::init())
		.setup(|app| {
			#[cfg(target_os = "linux")]
			desktop::integrate();
			window::setup(app.handle());
			// Composite on the GPU always (some distributions build WebKitGTK to decide per page).
			#[cfg(target_os = "linux")]
			if let Some(window) = app.get_webview_window("main") {
				let _ = window.with_webview(|webview| {
					use webkit2gtk::{HardwareAccelerationPolicy, SettingsExt, WebViewExt};
					if let Some(settings) = webview.inner().settings() {
						settings.set_hardware_acceleration_policy(HardwareAccelerationPolicy::Always);
					}
				});
			}
			let dir = app.path().app_data_dir()?;
			let store = Store::open(dir)?;
			let engine = Engine::new(app.handle().clone(), store)?;
			app.manage(Arc::clone(&engine));
			tray::create(app.handle())?;
			tauri::async_runtime::spawn(Arc::clone(&engine).run());
			let handle = app.handle().clone();
			tauri::async_runtime::spawn(async move {
				tokio::time::sleep(Duration::from_secs(20)).await;
				loop {
					let engine = handle.state::<Arc<Engine>>();
					if let Ok(available) = update::check(&handle, &engine.http).await {
						engine.lock().update = available;
						engine.publish();
					}
					tokio::time::sleep(UPDATE_CHECK).await;
				}
			});
			launch::fallback(app.handle());
			links(app.handle());
			Ok(())
		})
		.on_window_event(|window, event| {
			// Closing the window keeps the client running in the tray.
			if let WindowEvent::CloseRequested { api, .. } = event {
				api.prevent_close();
				let _ = window.hide();
			}
		})
		.invoke_handler(tauri::generate_handler![
			commands::snapshot,
			commands::rescan,
			commands::choose_folder,
			commands::pick_folder,
			commands::check_addons,
			commands::addon_action,
			commands::update_all,
			commands::changelog,
			commands::check_packs,
			commands::pack_action,
			commands::set_pack_telemetry,
			commands::set_packs_url,
			commands::pack_link_done,
			commands::set_addon_prefs,
			commands::finish_setup,
			commands::set_sharing,
			commands::set_paused,
			commands::get_autostart,
			commands::set_autostart,
			commands::set_server_url,
			commands::delete_server_data,
			commands::activity,
			commands::preview,
			commands::retry_now,
			commands::open_data_folder,
			commands::open_link,
			commands::check_update,
			commands::install_update,
			commands::diagnostics,
			commands::window_ready,
			commands::client_log,
		])
		.run(tauri::generate_context!())
		.expect("Polestar Client could not start");
}
