//! Codex packs for the addon's tests: a codex object (the data/forever/codex JSON shape, e.g.
//! tests/fixtures/codex/sample.json) written as a loadable Polestar_Codex pack by forge-data's pack writer.
//!
//! ```no_run
//! use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts};
//! let pack = write_codex_pack(&sample_codex(), &CodexOpts::default());
//! // RunAddon { before: pack.stub_lua.clone(), addons: vec!["Polestar".into()], .. }
//! ```
//!
//! `load_lua` dofiles the pack directly (run it after Polestar has loaded); `stub_lua` makes the stubbed
//! client load it when asked (C_AddOns.LoadAddOn), the way the game does.

use crate::run::{lua_string, root};
use crate::tmp::TempDir;
use forge_data::codex::pack::{emit_pack, pack_order, PackCodex, ADDON};
use forge_guide::js::V;
use serde_json::Value;
use std::path::PathBuf;

/// tests/fixtures/codex/sample.json.
pub fn sample_path() -> PathBuf {
	root().join("tests/fixtures/codex/sample.json")
}

/// The sample codex (tests/fixtures/codex/sample.json) as JSON.
pub fn sample_codex() -> Value {
	fixture("sample.json")
}

/// A tests/fixtures/codex JSON file.
pub fn fixture(name: &str) -> Value {
	let file = root().join("tests/fixtures/codex").join(name);
	serde_json::from_str(&std::fs::read_to_string(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()))).unwrap()
}

/// emitPack's options: version, build, extra files (name, Lua text) loaded last.
pub struct CodexOpts {
	pub version: String,
	pub build: Option<String>,
	pub extra_files: Vec<(String, String)>,
}

impl Default for CodexOpts {
	fn default() -> Self {
		CodexOpts { version: "0.0.0-test".into(), build: Some("1.60.1.70338".into()), extra_files: Vec::new() }
	}
}

/// A written codex pack: its folder, files (absolute, TOC order), and Lua loading it.
pub struct CodexPack {
	pub dir: PathBuf,
	pub files: Vec<PathBuf>,
	pub load_lua: String,
	pub stub_lua: String,
	pub tmp: TempDir,
}

/// Writes `codex` as a Polestar_Codex pack into a temp folder (removed with the returned pack).
pub fn write_codex_pack(codex: &Value, opts: &CodexOpts) -> CodexPack {
	let c = forge_guide::js::parse_json(&codex.to_string()).expect("codex JSON");
	let part = |k: &str| {
		let v = c.get(k);
		if v.truthy() {
			v
		} else {
			V::obj()
		}
	};
	let (items, npcs, objects, quests, instances, zones, factions, spells, meta, frames) =
		(part("items"), part("npcs"), part("objects"), part("quests"), part("instances"), part("zones"), part("factions"), part("spells"), part("meta"), part("frames"));
	let build = opts.build.as_deref().map_or(V::Null, V::str);
	let out = emit_pack(
		&PackCodex { items: &items, npcs: &npcs, objects: &objects, quests: &quests, instances: &instances, zones: &zones, factions: &factions, spells: &spells, meta: &meta, frames: &frames },
		&opts.version,
		&build,
		&opts.extra_files,
	)
	.unwrap_or_else(|e| panic!("{e}"));
	let tmp = TempDir::new("polestar-codex-");
	let dir = tmp.path().join(ADDON);
	std::fs::create_dir_all(&dir).unwrap();
	for (rel, text) in &out {
		std::fs::write(dir.join(rel), text).unwrap();
	}
	let files: Vec<PathBuf> = pack_order(&out).iter().map(|f| dir.join(f)).collect();
	let list = format!("{{ {} }}", files.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", "));
	let load_lua = format!("for _, f in ipairs({list}) do dofile(f) end");
	let stub_lua = format!(
		"do
  local __codexFiles = {list}
  local __load = C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if name ~= {addon} then return __load(name) end
    if not stub.addonsLoaded[name] then
      for _, f in ipairs(__codexFiles) do dofile(f) end
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end",
		addon = lua_string(ADDON)
	);
	CodexPack { dir, files, load_lua, stub_lua, tmp }
}
