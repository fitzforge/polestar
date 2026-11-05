//! When the main window shows. The page opens on the intro's first frame and
//! asks for the window then (`window_ready`), so the window never shows a
//! blank frame or content before the intro. That holds for the launch and for
//! every time the window comes back from the tray (the tray's Open, a click on
//! the tray icon, starting the client again while it runs): the page is told
//! `opening`, sets up the intro, and asks to be shown. If the page never asks,
//! the window shows anyway after a moment.

use std::sync::atomic::{AtomicBool, Ordering};
use std::time::Duration;

use tauri::{AppHandle, Emitter, Manager};

use crate::tray;

/// The launch's window shows after this if the page has not asked for it.
const LAUNCH_FALLBACK: Duration = Duration::from_secs(4);
/// A window coming back from the tray shows after this if the page has not asked for it.
const REOPEN_FALLBACK: Duration = Duration::from_millis(700);

pub struct Launch {
	/// Started into the tray (`--hidden`): the launch shows no window.
	hidden: bool,
	/// The launch's window has been shown (or skipped, when hidden).
	launched: AtomicBool,
	/// A window coming back from the tray is waiting for the page.
	reopening: AtomicBool,
}

impl Launch {
	pub fn new(hidden: bool) -> Launch {
		Launch { hidden, launched: AtomicBool::new(false), reopening: AtomicBool::new(false) }
	}

	/// The page has its first frame. Shows the window when it is waiting; false when this
	/// launch stays in the tray (the page then skips the intro).
	pub fn ready(&self, app: &AppHandle) -> bool {
		if self.reopening.swap(false, Ordering::SeqCst) {
			show(app, "back from the tray");
			return true;
		}
		if self.launched.swap(true, Ordering::SeqCst) {
			return true;
		}
		if self.hidden {
			eprintln!("Polestar Client: started into the tray");
			return false;
		}
		show(app, "launch");
		true
	}
}

fn show(app: &AppHandle, why: &str) {
	eprintln!("Polestar Client: window shown ({why})");
	tray::show_main(app);
}

/// Shows the launch's window after a while if the page never asks.
pub fn fallback(app: &AppHandle) {
	let app = app.clone();
	tauri::async_runtime::spawn(async move {
		tokio::time::sleep(LAUNCH_FALLBACK).await;
		let launch = app.state::<Launch>();
		if !launch.hidden && !launch.launched.swap(true, Ordering::SeqCst) {
			show(&app, "launch, the page did not answer");
		}
	});
}

/// Brings the window up: at once when it is on screen, else through the page's intro.
pub fn open(app: &AppHandle) {
	let Some(window) = app.get_webview_window("main") else { return };
	if window.is_visible().unwrap_or(true) {
		tray::show_main(app);
		return;
	}
	let launch = app.state::<Launch>();
	launch.launched.store(true, Ordering::SeqCst);
	launch.reopening.store(true, Ordering::SeqCst);
	let _ = window.emit("opening", ());
	let app = app.clone();
	tauri::async_runtime::spawn(async move {
		tokio::time::sleep(REOPEN_FALLBACK).await;
		if app.state::<Launch>().reopening.swap(false, Ordering::SeqCst) {
			show(&app, "back from the tray, the page did not answer");
		}
	});
}
