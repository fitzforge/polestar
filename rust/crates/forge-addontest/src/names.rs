//! A language folder (Polestar_<locale>) holding only a Names.lua as `forge data names` writes it, built
//! from a few names, for the addon's tests (tests/helpers/names.js): the stubbed client loads it when
//! Polestar asks (C_AddOns.LoadAddOn), the way the game loads a load-on-demand addon, and counts every
//! language folder it is asked for in `__namesLoads`.
//!
//! ```no_run
//! let pack = forge_addontest::names::names_pack("frFR", &[("npc", &[(448, "Lardeur")])]);
//! // before: format!("function GetLocale() return \"frFR\" end\n{}", pack.stub_lua)
//! ```

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
	let lua = forge_data::names::names_lua(locale, &built, "the test's names").unwrap();
	let names_lua = dir.join("Names.lua");
	std::fs::write(&names_lua, lua).unwrap();
	let stub_lua = format!(
		r#"__namesLoads = 0
do
  local __load = C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if type(name) == "string" and name:find("^Polestar_%l%l%u%u$") then __namesLoads = __namesLoads + 1 end
    if name ~= {} then return __load(name) end
    if not stub.addonsLoaded[name] then
      dofile({})
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end"#,
		lua_string(&name),
		lua_string(&names_lua.to_string_lossy())
	);
	NamesPack { dir, stub_lua, tmp }
}
