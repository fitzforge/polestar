//! A language folder (Polestar_<locale>) holding only a Names.lua as `forge data names` writes it, built
//! from a few names, and with subzone names a Subzones.lua as `forge data subzones` writes it, for the
//! addon's tests (tests/helpers/names.js): the stubbed client loads it when Polestar asks
//! (C_AddOns.LoadAddOn), the way the game loads a load-on-demand addon, and counts every language folder
//! it is asked for in `__namesLoads`.
//!
//! ```no_run
//! let pack = forge_addontest::names::names_pack("frFR", &[("npc", &[(448, "Lardeur")])]);
//! // before: format!("function GetLocale() return \"frFR\" end\n{}", pack.stub_lua)
//! ```

use std::collections::BTreeMap;
use std::path::PathBuf;

use crate::lua_string;
use crate::tmp::TempDir;

/// A names addon in a temp folder (removed when dropped; keep it alive while Lua reads it).
pub struct NamesPack {
	pub dir: PathBuf,
	/// Lua replacing C_AddOns.LoadAddOn so that it loads this pack and counts names-pack loads.
	pub stub_lua: String,
	pub tmp: TempDir,
}

/// The pack of `locale` holding `names`: (kind, [(id, name)]) of the pack's kinds (forge_data::names::PACK_KINDS).
pub fn names_pack(locale: &str, names: &[(&str, &[(i64, &str)])]) -> NamesPack {
	language_pack(locale, names, &[])
}

/// The pack of `locale` holding `names` (as names_pack) and, when any, the walking maps' areas named in
/// that language, `subzones` (WMOAreaTable row id, name: forge_data::subzones's Subzones.lua).
pub fn language_pack(locale: &str, names: &[(&str, &[(i64, &str)])], subzones: &[(i64, &str)]) -> NamesPack {
	let name = forge_guide::toc::language_addon(locale);
	let tmp = TempDir::new("polestar-names-");
	let dir = tmp.path().join(&name);
	std::fs::create_dir_all(&dir).unwrap();
	// Names.lua as forge data names writes it (forge_data::names::names_lua).
	let mut built = forge_data::names::Built::default();
	for (kind, entries) in names {
		let k = forge_data::names::PACK_KINDS.iter().position(|x| x == kind).unwrap_or_else(|| panic!("names_pack: no pack kind {kind}"));
		built.names[k].extend(entries.iter().map(|(id, n)| (*id, n.to_string())));
	}
	let mut files = vec![dir.join("Names.lua")];
	std::fs::write(&files[0], forge_data::names::names_lua(locale, &built, "the test's names").unwrap()).unwrap();
	// Subzones.lua as forge data subzones writes it, loaded after Names.lua (the TOC's order).
	if !subzones.is_empty() {
		let areas: BTreeMap<i64, String> = subzones.iter().map(|(id, n)| (*id, n.to_string())).collect();
		files.push(dir.join(forge_data::subzones::FILE));
		std::fs::write(&files[1], forge_data::subzones::subzones_lua(locale, &areas, "the test's subzone names").unwrap()).unwrap();
	}
	let load: String = files.iter().map(|f| format!("      dofile({})\n", lua_string(&f.to_string_lossy()))).collect();
	let stub_lua = format!(
		r#"__namesLoads = 0
do
  local __load = C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if type(name) == "string" and name:find("^Polestar_%l%l%u%u$") then __namesLoads = __namesLoads + 1 end
    if name ~= {} then return __load(name) end
    if not stub.addonsLoaded[name] then
{load}      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end"#,
		lua_string(&name),
	);
	NamesPack { dir, stub_lua, tmp }
}
