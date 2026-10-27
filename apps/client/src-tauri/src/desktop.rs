//! Linux desktop integration for the AppImage. On Wayland the taskbar finds a
//! window's icon through the desktop entry named after its app id
//! (`polestar-client`, the binary's name); an AppImage that was only
//! downloaded has none, so the taskbar shows the compositor's generic icon.
//! Run from an AppImage, the client writes its own entry and icon into the
//! user's data folder, and keeps the entry pointing at wherever the AppImage
//! now lives. Entries it did not write are never touched.
//!
//! The entry also handles `polestar://` links (polestar.guide's "Install with
//! Polestar Client"): it lists `x-scheme-handler/polestar`, and the client
//! becomes that scheme's default in `mimeapps.list` unless the player already
//! picked another program for it.

use std::fs;
use std::path::{Path, PathBuf};

const APP_ID: &str = "polestar-client";
const MARK: &str = "X-Polestar-Client-AppImage=true";
const ICON: &[u8] = include_bytes!("../icons/128x128@2x.png");
const SCHEME: &str = "x-scheme-handler/polestar";
const DEFAULTS: &str = "[Default Applications]";

pub fn integrate() {
	let Some(appimage) = std::env::var_os("APPIMAGE").map(PathBuf::from) else { return };
	let Some(data) = xdg_dir("XDG_DATA_HOME", ".local/share") else { return };
	match write(&data, &appimage) {
		Ok(true) => {
			if let Some(config) = xdg_dir("XDG_CONFIG_HOME", ".config") {
				if let Err(e) = claim_scheme(&config) {
					eprintln!("could not make Polestar Client open polestar:// links: {e}");
				}
			}
		}
		Ok(false) => {}
		Err(e) => eprintln!("could not add Polestar Client to the desktop: {e}"),
	}
}

fn xdg_dir(var: &str, fallback: &str) -> Option<PathBuf> {
	std::env::var_os(var).map(PathBuf::from).filter(|p| p.is_absolute()).or_else(|| dirs_home().map(|h| h.join(fallback)))
}

fn dirs_home() -> Option<PathBuf> {
	std::env::var_os("HOME").map(PathBuf::from).filter(|p| p.is_absolute())
}

/// Writes the entry and icon; false when an entry of that name is someone else's.
fn write(data: &Path, appimage: &Path) -> std::io::Result<bool> {
	let icon = data.join("icons/hicolor/256x256/apps").join(format!("{APP_ID}.png"));
	let entry = data.join("applications").join(format!("{APP_ID}.desktop"));
	if let Ok(existing) = fs::read_to_string(&entry) {
		if !existing.contains(MARK) {
			return Ok(false);
		}
	}
	if fs::read(&icon).ok().as_deref() != Some(ICON) {
		fs::create_dir_all(icon.parent().unwrap_or(data))?;
		fs::write(&icon, ICON)?;
	}
	let Some(text) = desktop_entry(appimage, &icon) else {
		return Err(std::io::Error::new(std::io::ErrorKind::InvalidInput, "the AppImage's path holds control characters; not writing a desktop entry for it"));
	};
	if fs::read_to_string(&entry).ok().as_deref() != Some(text.as_str()) {
		fs::create_dir_all(entry.parent().unwrap_or(data))?;
		fs::write(&entry, text)?;
	}
	Ok(true)
}

/// The entry's text; `None` when a path holds a control character (a line break would add keys).
fn desktop_entry(appimage: &Path, icon: &Path) -> Option<String> {
	let path = appimage.display().to_string();
	let icon = icon.display().to_string();
	if path.chars().chain(icon.chars()).any(char::is_control) {
		return None;
	}
	// Exec quoting (Desktop Entry spec): a path with anything but plain characters goes in double
	// quotes, with `"`, `` ` ``, `$` and `\` backslash-escaped; `%` is doubled. The value is then a
	// string, so each backslash is escaped again (`$` becomes `\\$`, `\` becomes `\\\\`). A plain
	// path stays bare: xdg-open outside a desktop environment takes the first word as is.
	let plain = path.chars().all(|c| c.is_ascii_alphanumeric() || matches!(c, '/' | '.' | '_' | '-' | '+' | ',' | '@'));
	let exec = if plain {
		path
	} else {
		let mut quoted = String::from("\"");
		for c in path.chars() {
			match c {
				'"' | '`' | '$' => {
					quoted.push_str("\\\\");
					quoted.push(c);
				}
				'\\' => quoted.push_str("\\\\\\\\"),
				'%' => quoted.push_str("%%"),
				c => quoted.push(c),
			}
		}
		quoted.push('"');
		quoted
	};
	let icon = icon.replace('\\', "\\\\");
	Some(format!(
		"[Desktop Entry]\nType=Application\nName=Polestar Client\nComment=Installs Polestar's addons and shares your Polestar Recorder data\nExec={exec} %u\nIcon={icon}\nStartupWMClass={APP_ID}\nCategories=Game;Utility;\nMimeType={SCHEME};\nTerminal=false\n{MARK}\n"
	))
}

/// Makes the entry the default for `polestar://` in `mimeapps.list`, unless a default is set
/// already (ours, or one the player chose).
fn claim_scheme(config: &Path) -> std::io::Result<()> {
	let path = config.join("mimeapps.list");
	let text = fs::read_to_string(&path).unwrap_or_default();
	if let Some(updated) = with_default(&text) {
		fs::create_dir_all(config)?;
		fs::write(&path, updated)?;
	}
	Ok(())
}

/// `text` with our entry as the scheme's default; `None` when it has a default already.
fn with_default(text: &str) -> Option<String> {
	let line = format!("{SCHEME}={APP_ID}.desktop;");
	let mut out: Vec<&str> = Vec::new();
	let mut in_defaults = false;
	let mut added = false;
	for l in text.lines() {
		let trimmed = l.trim();
		if trimmed.starts_with('[') {
			if in_defaults && !added {
				out.push(&line);
				added = true;
			}
			in_defaults = trimmed == DEFAULTS;
		} else if in_defaults && trimmed.split_once('=').is_some_and(|(k, v)| k.trim() == SCHEME && !v.trim().is_empty()) {
			return None;
		}
		out.push(l);
	}
	if !added {
		if in_defaults {
			out.push(&line);
		} else {
			if out.last().is_some_and(|l| !l.trim().is_empty()) {
				out.push("");
			}
			out.push(DEFAULTS);
			out.push(&line);
		}
	}
	Some(out.join("\n") + "\n")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn writes_its_entry_and_follows_the_appimage() {
		let data = std::env::temp_dir().join(format!("polestar-desktop-{}", std::process::id()));
		let _ = fs::remove_dir_all(&data);
		assert!(write(&data, Path::new("/home/p/Apps/Polestar Client.AppImage")).unwrap());
		let entry = data.join("applications/polestar-client.desktop");
		let text = fs::read_to_string(&entry).unwrap();
		assert!(text.contains("Exec=\"/home/p/Apps/Polestar Client.AppImage\" %u"));
		assert!(text.contains("MimeType=x-scheme-handler/polestar;"));
		assert!(text.contains(&format!("Icon={}", data.join("icons/hicolor/256x256/apps/polestar-client.png").display())));
		write(&data, Path::new("/opt/apps/Polestar-0.2.AppImage")).unwrap();
		assert!(fs::read_to_string(&entry).unwrap().contains("Exec=/opt/apps/Polestar-0.2.AppImage %u"));
		write(&data, Path::new("/opt/$odd/Polestar.AppImage")).unwrap();
		assert!(fs::read_to_string(&entry).unwrap().contains("Exec=\"/opt/\\\\$odd/Polestar.AppImage\" %u"));
		write(&data, Path::new("/opt/a\\b 100%/P.AppImage")).unwrap();
		assert!(fs::read_to_string(&entry).unwrap().contains("Exec=\"/opt/a\\\\\\\\b 100%%/P.AppImage\" %u"));
		// A line break in the path would add keys: nothing is written.
		let before = fs::read_to_string(&entry).unwrap();
		assert!(write(&data, Path::new("/opt/x\nMimeType=text/html;\n/P.AppImage")).is_err());
		assert_eq!(fs::read_to_string(&entry).unwrap(), before);
		// Someone else's entry of that name stays as it is.
		fs::write(&entry, "[Desktop Entry]\nName=Mine\n").unwrap();
		assert!(!write(&data, Path::new("/x.AppImage")).unwrap());
		assert_eq!(fs::read_to_string(&entry).unwrap(), "[Desktop Entry]\nName=Mine\n");
		let _ = fs::remove_dir_all(&data);
	}

	#[test]
	fn claims_the_scheme_only_when_nobody_has() {
		let ours = "x-scheme-handler/polestar=polestar-client.desktop;";
		assert_eq!(with_default("").unwrap(), format!("[Default Applications]\n{ours}\n"));
		assert_eq!(
			with_default("[Added Associations]\ntext/plain=kate.desktop;\n").unwrap(),
			format!("[Added Associations]\ntext/plain=kate.desktop;\n\n[Default Applications]\n{ours}\n")
		);
		assert_eq!(
			with_default("[Default Applications]\ntext/html=firefox.desktop;\n[Added Associations]\nx=y\n").unwrap(),
			format!("[Default Applications]\ntext/html=firefox.desktop;\n{ours}\n[Added Associations]\nx=y\n")
		);
		assert_eq!(with_default("[Default Applications]\nx-scheme-handler/polestar=other.desktop;\n"), None);
		assert_eq!(with_default(&format!("[Default Applications]\n{ours}\n")), None);
	}
}
