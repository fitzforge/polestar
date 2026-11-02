//! The tray icon: the Polestar emblem, the status in its menu, and Open,
//! Pause/Resume and Quit. Closing the window only hides it; the client keeps
//! watching from here.

use std::sync::Arc;

use tauri::image::Image;
use tauri::menu::{Menu, MenuItem, PredefinedMenuItem};
use tauri::tray::{MouseButton, MouseButtonState, TrayIcon, TrayIconBuilder, TrayIconEvent};
use tauri::{AppHandle, Manager, Wry};

use crate::engine::{Engine, Snapshot};

pub struct Tray {
	status: MenuItem<Wry>,
	open: MenuItem<Wry>,
	pause: MenuItem<Wry>,
	quit: MenuItem<Wry>,
	icon: TrayIcon,
}

pub fn create(app: &AppHandle) -> tauri::Result<()> {
	let status = MenuItem::with_id(app, "status", t!("Starting"), false, None::<&str>)?;
	let open = MenuItem::with_id(app, "open", t!("Open Polestar Client"), true, None::<&str>)?;
	let pause = MenuItem::with_id(app, "pause", t!("Pause uploads"), true, None::<&str>)?;
	let quit = MenuItem::with_id(app, "quit", t!("Quit"), true, None::<&str>)?;
	let menu = Menu::with_items(app, &[&status, &PredefinedMenuItem::separator(app)?, &open, &pause, &PredefinedMenuItem::separator(app)?, &quit])?;
	let icon = TrayIconBuilder::with_id("main")
		.icon(Image::from_bytes(include_bytes!("../icons/tray.png"))?)
		.tooltip("Polestar Client")
		.menu(&menu)
		.show_menu_on_left_click(false)
		.on_menu_event(|app, event| match event.id().as_ref() {
			"open" => crate::launch::open(app),
			"pause" => {
				let engine = app.state::<Arc<Engine>>();
				let paused = engine.lock().settings.paused;
				let _ = engine.save_settings(|s| s.paused = !paused);
				engine.publish();
			}
			"quit" => app.exit(0),
			_ => {}
		})
		.on_tray_icon_event(|tray, event| {
			if let TrayIconEvent::Click { button: MouseButton::Left, button_state: MouseButtonState::Up, .. } = event {
				crate::launch::open(tray.app_handle());
			}
		})
		.build(app)?;
	app.manage(Tray { status, open, pause, quit, icon });
	Ok(())
}

/// Mirrors the status into the tray menu and tooltip, in the player's language (each snapshot,
/// so a change of language reaches the menu too).
pub fn update(app: &AppHandle, snapshot: &Snapshot) {
	let Some(tray) = app.try_state::<Tray>() else { return };
	let _ = tray.status.set_text(&snapshot.status.title);
	let _ = tray.open.set_text(t!("Open Polestar Client"));
	let _ = tray.pause.set_text(if snapshot.paused { t!("Resume uploads") } else { t!("Pause uploads") });
	let _ = tray.pause.set_enabled(snapshot.consent);
	let _ = tray.quit.set_text(t!("Quit"));
	let _ = tray.icon.set_tooltip(Some(t!("Polestar Client: {status}", status = snapshot.status.title)));
}

pub fn show_main(app: &AppHandle) {
	if let Some(window) = app.get_webview_window("main") {
		let _ = window.show();
		let _ = window.unminimize();
		let _ = window.set_focus();
	}
}
