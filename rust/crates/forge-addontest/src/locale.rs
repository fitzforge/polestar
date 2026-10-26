//! A fake translation and the local reference data some tests read.

use crate::run::{lua_string, root};
use std::path::PathBuf;

/// Lua for `before` that makes GetLocale() return `locale` and fills Polestar.L with `strings` right after
/// Core/Init.lua runs, where a locale file (Locales/<locale>.lua) loads in the client. The locale must be one
/// Polestar does not ship (itIT: WoW: Forever has no Italian client), or the shipped file would replace them.
pub fn fake_locale(locale: &str, strings: &[(&str, &str)]) -> String {
	assert!(forge_guide::locales::locale(locale).is_none(), "fake_locale: Polestar ships {locale}; fake one it does not, such as itIT");
	let fill = strings.iter().map(|(k, v)| format!("\t\tns.L[{}] = {}", lua_string(k), lua_string(v))).collect::<Vec<_>>().join("\n");
	format!(
		r#"function GetLocale() return {loc} end
do
	local load = loadfile
	function loadfile(file)
		local chunk, err = load(file)
		if not chunk or not file:match("[/\\]Polestar[/\\]Core[/\\]Init%.lua$") then return chunk, err end
		return function(name, ns)
			chunk(name, ns)
{fill}
		end
	end
end"#,
		loc = lua_string(locale)
	)
}

/// data/forever: the local reference data (a fresh clone has none).
pub fn data_dir() -> PathBuf {
	root().join("data/forever")
}

/// None when data/forever holds every file, else the skip reason naming the missing ones. A test that needs
/// them returns early (printing the reason) when this is Some.
pub fn needs(files: &[&str]) -> Option<String> {
	let missing: Vec<&str> = files.iter().copied().filter(|f| !data_dir().join(f).exists()).collect();
	if missing.is_empty() {
		None
	} else {
		Some(format!("reference data not built: data/forever has no {}", missing.join(", ")))
	}
}

/// Returns from the test (printing why) when data/forever lacks any of the files.
#[macro_export]
macro_rules! needs {
	($($f:expr),+ $(,)?) => {
		if let Some(why) = $crate::locale::needs(&[$($f),+]) {
			eprintln!("skipped: {why}");
			return;
		}
	};
}
