//! The launch test: `POLESTAR_SMOKE=<seconds>` starts the client as usual, but in a fresh data
//! folder of its own, without the update check and without registering itself with the desktop.
//! It exits 1 as soon as the window shows its fault page (the page reports it with `smoke_fault`)
//! and 0 after the given seconds when the page reached its first frame and showed no fault (1 if
//! it never did). CI runs it on every Linux build (apps/client/README.md, "Developing").

use std::path::PathBuf;
use std::sync::LazyLock;
use std::sync::atomic::{AtomicBool, Ordering};
use std::time::Duration;

use tauri::AppHandle;

const VAR: &str = "POLESTAR_SMOKE";

static SECONDS: LazyLock<Option<u64>> = LazyLock::new(|| std::env::var(VAR).ok().and_then(|v| v.trim().parse().ok()).filter(|&s| s > 0));
/// The page asked for its window (`window_ready`): it loaded and drew its first frame.
static PAGE: AtomicBool = AtomicBool::new(false);

/// How long the launch test lasts, when this start is one.
fn seconds() -> Option<u64> {
	*SECONDS
}

pub fn active() -> bool {
	seconds().is_some()
}

/// The test's own data folder, empty at the start: no saved consent, game folder or token, so
/// nothing is uploaded or installed, and the player's own data is never touched.
pub fn data_dir() -> PathBuf {
	std::env::temp_dir().join(format!("polestar-smoke-{}", std::process::id()))
}

pub fn page_ready() {
	PAGE.store(true, Ordering::SeqCst);
}

/// Ends the test after its seconds unless a fault ended it first.
pub fn start(app: &AppHandle) {
	let Some(seconds) = seconds() else { return };
	eprintln!("Polestar Client smoke test: {seconds}s, data in {}", data_dir().display());
	let app = app.clone();
	tauri::async_runtime::spawn(async move {
		tokio::time::sleep(Duration::from_secs(seconds)).await;
		if PAGE.load(Ordering::SeqCst) {
			eprintln!("Polestar Client smoke test: passed (the window loaded and showed no fault in {seconds}s)");
			finish(&app, 0);
		} else {
			eprintln!("Polestar Client smoke test: FAILED: the page never drew its first frame in {seconds}s");
			finish(&app, 1);
		}
	});
}

/// The window showed its fault page.
pub fn fault(app: &AppHandle, title: &str, details: &str) {
	if !active() {
		return;
	}
	let details: String = details.chars().take(4000).collect();
	eprintln!("Polestar Client smoke test: FAILED: the window showed its fault page\n{title}\n{details}");
	finish(app, 1);
}

fn finish(app: &AppHandle, code: i32) {
	let _ = std::fs::remove_dir_all(data_dir());
	app.exit(code);
}
