//! A start that finds an older copy of the client still running (Linux). A package upgrade
//! (`apt install ./Polestar.Client_<version>_amd64.deb`, or rpm) puts the new binary in place of
//! the old one, but a client running in the tray keeps running the old one, and starting the
//! client again hands over to it (the single-instance check): the player installs 0.1.3 and still
//! sees 0.1.2. So a running client whose own file was replaced does not take that hand-over: it
//! quits, and on exit starts the new file in its place with the new start's arguments.
//!
//! Linux names a running binary whose file was replaced or deleted `<path> (deleted)` in
//! `/proc/<pid>/exe`. An AppImage runs from its own mount, which no upgrade replaces (its
//! updater restarts it itself).

use std::path::Path;
use std::sync::Mutex;

use tauri::{AppHandle, Manager};

/// The arguments of the start this client quit for, kept until it exits.
#[derive(Default)]
pub struct Relaunch(Mutex<Option<Vec<String>>>);

/// For a second start: true when this client was replaced on disk and is quitting so the new one
/// starts instead (`on_exit`); false when the running client should take the start as usual.
pub fn take_over(app: &AppHandle, args: &[String]) -> bool {
	if !replaced(Path::new("/proc/self/exe")) {
		return false;
	}
	// The path it started from (cached before main ran) is where an upgrade puts the new file.
	// Gone (the package was removed and this start is another copy): the running client stays.
	if !tauri::process::current_binary(&app.env()).is_ok_and(|exe| exe.is_file()) {
		return false;
	}
	let Some(state) = app.try_state::<Relaunch>() else { return false };
	*state.0.lock().unwrap() = Some(args.to_vec());
	app.exit(0);
	true
}

/// On exit, after the plugins have let go of the single-instance name: starts the new file when a
/// second start was handed over to it.
pub fn on_exit(app: &AppHandle) {
	let Some(state) = app.try_state::<Relaunch>() else { return };
	let Some(args) = state.0.lock().unwrap().take() else { return };
	let started = tauri::process::current_binary(&app.env()).and_then(|exe| std::process::Command::new(exe).args(args.iter().skip(1)).spawn());
	if let Err(e) = started {
		eprintln!("could not start the updated Polestar Client: {e}");
	}
}

/// Whether the binary behind a `/proc/<pid>/exe` link was replaced or deleted since it started.
fn replaced(exe_link: &Path) -> bool {
	use std::os::unix::ffi::OsStrExt;
	std::fs::read_link(exe_link).is_ok_and(|exe| exe.as_os_str().as_bytes().ends_with(b" (deleted)"))
}

#[cfg(test)]
mod tests {
	use super::*;
	use std::fs;
	use std::path::PathBuf;

	/// What dpkg does to a running client: the new file is written beside it and renamed over it.
	#[test]
	fn sees_its_file_replaced_by_an_upgrade() {
		let dir = std::env::temp_dir().join(format!("polestar-relaunch-{}", std::process::id()));
		let _ = fs::remove_dir_all(&dir);
		fs::create_dir_all(&dir).unwrap();
		let exe = dir.join("sleep");
		fs::copy("/bin/sleep", &exe).unwrap();
		let mut running = std::process::Command::new(&exe).arg("30").spawn().unwrap();
		let link = PathBuf::from(format!("/proc/{}/exe", running.id()));
		assert!(!replaced(&link));
		fs::copy("/bin/sleep", dir.join("sleep.dpkg-new")).unwrap();
		fs::rename(dir.join("sleep.dpkg-new"), &exe).unwrap();
		assert!(replaced(&link));
		let _ = running.kill();
		let _ = running.wait();
		let _ = fs::remove_dir_all(&dir);
		// The test binary itself is where it was built.
		assert!(!replaced(Path::new("/proc/self/exe")));
	}
}
