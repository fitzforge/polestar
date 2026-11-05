//! Quest databases for the tests: `forge data questdb` (forge_data::questdb) built from tests/fixtures/questdb,
//! or from a copy of it edited by the test, into a temp folder; the Lua files a test loads, in the TOC's order.

use std::path::{Path, PathBuf};

use crate::run::root;
use crate::tmp::TempDir;

/// The fixture data (quests.json, npcs.json, objects.json, items.json, map-frames.json, meta.json).
pub fn fixture_dir() -> PathBuf {
	root().join("tests/fixtures/questdb")
}

/// The data files of the Polestar_QuestDB addon, in the TOC's order.
pub const FILES: [&str; 5] = ["MapFrames.lua", "Quests.lua", "Npcs.lua", "Objects.lua", "Items.lua"];

/// A built quest database in a temp folder (removed when dropped).
pub struct QuestDb {
	pub dir: TempDir,
	pub out: forge_data::questdb::Output,
}

impl QuestDb {
	/// The Lua files to load, in the TOC's order (absolute paths).
	pub fn files(&self) -> Vec<PathBuf> {
		FILES.iter().map(|f| self.dir.path().join(f)).collect()
	}
	/// `{ "<file>", ... }` for Lua (stub.quests.dbFiles and the like).
	pub fn lua_files(&self) -> String {
		format!("{{ {} }}", self.files().iter().map(|f| crate::lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", "))
	}
}

/// Builds the database of `data` (a folder laid out as tests/fixtures/questdb) with the default options.
pub fn build_db(data: &Path) -> QuestDb {
	build_db_with(data, &forge_data::questdb::Options::default())
}

pub fn build_db_with(data: &Path, o: &forge_data::questdb::Options) -> QuestDb {
	let out = forge_data::questdb::build(data, root(), o).unwrap_or_else(|e| panic!("questdb build: {e}"));
	let dir = TempDir::new("polestar-questdb-");
	forge_data::questdb::write(&out, dir.path()).unwrap_or_else(|e| panic!("questdb write: {e}"));
	QuestDb { dir, out }
}

/// A copy of tests/fixtures/questdb whose JSON files `edit` changes (file name -> parsed JSON), for
/// [`build_db`]; the folder is removed when dropped.
pub fn data_with(edit: impl FnOnce(&mut std::collections::BTreeMap<String, serde_json::Value>)) -> TempDir {
	let mut raw = std::collections::BTreeMap::new();
	for e in std::fs::read_dir(fixture_dir()).unwrap() {
		let p = e.unwrap().path();
		if p.extension().is_some_and(|x| x == "json") {
			let v: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&p).unwrap()).unwrap();
			raw.insert(p.file_name().unwrap().to_string_lossy().into_owned(), v);
		}
	}
	edit(&mut raw);
	let dir = TempDir::new("polestar-questdb-data-");
	for (name, v) in raw {
		std::fs::write(dir.path().join(name), serde_json::to_string(&v).unwrap()).unwrap();
	}
	dir
}

/// Lua for a test script: `AddRecords(kind, { [id] = { field, ... }, ... })` registers hand-written records
/// with Polestar.QuestDB in the database's layout (one chunk of `forge data questdb` payload lines: fields
/// by ";", nil empty, "'" and the escaped text for a string, "{" and the elements by "," for a list).
pub const ADD_RECORDS_LUA: &str = r#"
local function questdbField(v)
	if v == nil then return "" end
	if type(v) == "number" then return tostring(v) end
	if type(v) == "string" then return "'" .. v:gsub("[%%;,:|\t\n\r]", function(c) return string.format("%%%02X", c:byte()) end) end
	local parts = {}
	for i = 1, table.maxn(v) do parts[i] = v[i] == nil and "" or tostring(v[i]) end
	return "{" .. table.concat(parts, ",")
end
function AddRecords(kind, recs)
	local ids = {}
	for id in pairs(recs) do ids[#ids + 1] = id end
	table.sort(ids)
	local lines = { "" }
	for _, id in ipairs(ids) do
		local r, fields = recs[id], {}
		for i = 1, table.maxn(r) do fields[i] = questdbField(r[i]) end
		lines[#lines + 1] = id .. "\t" .. table.concat(fields, ";")
	end
	lines[#lines + 1] = ""
	Polestar.QuestDB.AddChunk(kind, ids[1], ids[#ids], table.concat(lines, "\n"))
end
"#;
