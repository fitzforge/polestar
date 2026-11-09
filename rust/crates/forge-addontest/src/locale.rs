//! A fake translation and the local reference data some tests read.

use crate::run::{lua_string, root};
use std::path::PathBuf;

/// Lua for `before` that makes GetLocale() return `locale` and fills Polestar.L with `strings` when Polestar
/// asks for the language folder (C_AddOns.LoadAddOn("Polestar_<locale>"), from Core/Locale.lua), the way the
/// client runs the folder's Interface.lua: a file that reads L at load before Locale.lua reads English here
/// as in the game. The locale must be one Polestar does not ship (itIT: WoW: Forever has no Italian client).
/// A test that loads only part of Core/Core.xml calls C_AddOns.LoadAddOn("Polestar_" .. GetLocale()) itself.
pub fn fake_locale(locale: &str, strings: &[(&str, &str)]) -> String {
	assert!(forge_guide::locales::locale(locale).is_none(), "fake_locale: Polestar ships {locale}; fake one it does not, such as itIT");
	let fill = strings.iter().map(|(k, v)| format!("\t\t\tL[{}] = {}", lua_string(k), lua_string(v))).collect::<Vec<_>>().join("\n");
	format!(
		r#"function GetLocale() return {loc} end
do
	local load = C_AddOns.LoadAddOn
	function C_AddOns.LoadAddOn(name)
		if name ~= {name} then return load(name) end
		if not stub.addonsLoaded[name] then
			local L = Polestar.L
{fill}
			stub.addonLoaded(name)
		end
		return true
	end
	LoadAddOn = C_AddOns.LoadAddOn
end"#,
		loc = lua_string(locale),
		name = lua_string(&forge_guide::toc::language_addon(locale))
	)
}

/// Lua for `before`: the client loads the shipped interface strings of `locale` (Interface.lua in
/// addon/Polestar_<locale>) when Polestar asks for the language folder (C_AddOns.LoadAddOn, from
/// Core/Locale.lua), as the game loads a load-on-demand addon. Only the strings: the folder's names and
/// guide texts stay out (tests about those build their own, names::names_pack). GetLocale() is the
/// caller's.
pub fn shipped_strings(locale: &str) -> String {
	let name = forge_guide::toc::language_addon(locale);
	let file = root().join("addon").join(&name).join(forge_guide::toc::INTERFACE_FILE);
	format!(
		r#"do
	local load = C_AddOns.LoadAddOn
	function C_AddOns.LoadAddOn(name)
		if name ~= {name} then return load(name) end
		if not stub.addonsLoaded[name] then
			dofile({file})
			stub.addonLoaded(name)
		end
		return true
	end
	LoadAddOn = C_AddOns.LoadAddOn
end"#,
		name = lua_string(&name),
		file = lua_string(&file.to_string_lossy())
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
