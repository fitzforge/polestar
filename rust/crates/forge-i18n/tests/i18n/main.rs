//! The forge-i18n tests, one binary: the interface translations (keys, format check, sync, reader,
//! glossary, shipped files), the addon in its languages, the AddOns list texts and `i18n leaks`.
mod addon;
mod files;
mod leaks;
mod state;
mod toc;

use std::path::{Path, PathBuf};

/// The checkout.
pub fn root() -> &'static Path {
	forge_addontest::run::root()
}

/// addon/Polestar.
pub fn polestar() -> PathBuf {
	root().join("addon/Polestar")
}

/// The locales with a file in addon/Polestar/Locales.
pub fn shipped() -> Vec<String> {
	forge_guide::locales::LOCALE_CODES.iter().filter(|l| polestar().join("Locales").join(format!("{l}.lua")).exists()).map(|l| l.to_string()).collect()
}

pub fn write(dir: &Path, rel: &str, text: &str) -> PathBuf {
	let p = dir.join(rel);
	std::fs::create_dir_all(p.parent().unwrap()).unwrap();
	std::fs::write(&p, text).unwrap();
	p
}

/// A small addon: its code with keys in two files and one in a comment.
pub fn mini_addon() -> forge_addontest::tmp::TempDir {
	let t = forge_addontest::tmp::TempDir::new("polestar-i18n-");
	std::fs::create_dir_all(t.path().join("Locales")).unwrap();
	write(t.path(), "Main.lua", "local L = Polestar.L\nprint(L[\"Hello %s\"], L[\"Bye\"], L[\"New in Main\"], Polestar.LC(\"slot\", \"Back\"))\n-- L[\"In a comment\"]\n");
	write(t.path(), "UI/Window.lua", "local L = Polestar.L\nprint(L[\"Close the window\"])\n");
	t
}
