//! What a world is built from, one digest per input (port of world.js worldInputs,
//! gridFingerprint, handoverKey and inputsHash): the builder version, the walking grid, every
//! data/forever file the builder reads (by content; never meta.json), the handover rules, the
//! gameobject facts and the client instance tables. Digests are SHA-1 hex like the JS ones, so
//! `dataHash` equals the JS world's.

use crate::json::{num, stringify};
use forge_core::ContentHasher;
use serde_json::{json, Value};

/// world.js WORLD_DATA_FILES.
pub const WORLD_DATA_FILES: [&str; 13] = ["quests", "npcs", "objects", "items", "zones", "map-frames", "travel", "trainers", "dungeons", "training", "races", "mechanics", "spawnz"];

/// handoverKey(rules): the handover rules' [id, quest, objective, item, npc], sorted by id.
pub fn handover_key(rules: &[Value]) -> String {
	let mut rows: Vec<(String, Value)> = rules
		.iter()
		.filter(|r| r.get("kind").and_then(Value::as_str) == Some("handover"))
		.map(|r| {
			let id = crate::json::js_str(r.get("id"));
			let n = |k: &str| crate::json::jnum(num(r.get(k)));
			(id.clone(), json!([id, n("quest"), n("objective"), n("item"), n("npc")]))
		})
		.collect();
	rows.sort_by(|a, b| a.0.encode_utf16().cmp(b.0.encode_utf16()));
	stringify(&Value::Array(rows.into_iter().map(|r| r.1).collect()))
}

/// inputsHash: sha1 of `${k}:${v}\n` over the inputs in order.
pub fn inputs_hash(inputs: &[(String, String)]) -> String {
	let mut h = ContentHasher::new();
	for (k, v) in inputs {
		h.update(format!("{k}:{v}\n").as_bytes());
	}
	h.hex()
}

#[cfg(feature = "native")]
pub use native::*;

#[cfg(feature = "native")]
mod native {
	use super::*;
	use forge_core::content_key;
	use std::path::Path;

	fn file_hash(p: &Path) -> Option<String> {
		std::fs::read(p).ok().map(|b| content_key(&b))
	}

	/// gridFingerprint(dir): index.json's bytes, then every tiles/ and graph/ file's relative
	/// name and size, sorted (readdirSync recursive). None without index.json.
	pub fn grid_fingerprint(dir: &Path) -> Option<String> {
		let index = std::fs::read(dir.join("index.json")).ok()?;
		let mut h = ContentHasher::new();
		h.update(&index);
		for sub in ["tiles", "graph"] {
			let root = dir.join(sub);
			if !root.exists() {
				continue;
			}
			let mut files: Vec<(String, std::fs::Metadata)> = Vec::new();
			let mut stack = vec![root.clone()];
			while let Some(d) = stack.pop() {
				for e in std::fs::read_dir(&d).ok()?.flatten() {
					let p = e.path();
					let rel = p.strip_prefix(&root).ok()?.to_string_lossy().into_owned();
					let md = std::fs::metadata(&p).ok()?;
					if md.is_dir() {
						stack.push(p.clone());
					}
					files.push((rel, md));
				}
			}
			files.sort_by(|a, b| a.0.encode_utf16().cmp(b.0.encode_utf16()));
			for (f, md) in files {
				if md.is_file() {
					h.update(format!("{sub}/{f}:{}\n", md.len()).as_bytes());
				}
			}
		}
		Some(h.hex())
	}

	/// worldInputs(dataDir, sourcesDir, rulesFile, gridDir) of a repository checkout.
	/// The grid: $POLESTAR_GRID, else data/local/nav4 (nav/router.js GRID_DIR).
	pub fn world_inputs(root: &Path) -> Result<Vec<(String, String)>, crate::data::Error> {
		let data = root.join("data/forever");
		let sources = root.join("data/sources");
		let grid = std::env::var_os("POLESTAR_GRID").map(std::path::PathBuf::from).unwrap_or_else(|| root.join("data/local/nav4"));
		let mut out = vec![("builder".to_string(), crate::BUILDER_VERSION.to_string()), ("grid".to_string(), grid_fingerprint(&grid).unwrap_or_else(|| "-".into()))];
		for f in WORLD_DATA_FILES {
			let name = format!("{f}.json");
			out.push((name.clone(), file_hash(&data.join(&name)).unwrap_or_else(|| "-".into())));
		}
		let rules_doc: Value = serde_json::from_slice(&std::fs::read(root.join("data/rules.json"))?)?;
		let rules = rules_doc.get("rules").and_then(Value::as_array).cloned().unwrap_or_default();
		out.push(("handover".into(), content_key(handover_key(&rules).as_bytes())));
		let facts = sources.join(format!("cmangos/{}/gameobject_facts.json", crate::data::CMANGOS_REV12));
		out.push(("objects".into(), file_hash(&facts).unwrap_or_else(|| "-".into())));
		let src = crate::data::DirSource::repo(root);
		let areas = match crate::data::forever_build(&src) {
			Some(b) => {
				let dir = sources.join("wago").join(&b);
				let h = |f: &str| file_hash(&dir.join(f)).unwrap_or_default();
				format!("{b}:{}:{}", h("Map.csv"), h("AreaTable.csv"))
			}
			None => "-".into(),
		};
		out.push(("areas".into(), areas));
		Ok(out)
	}
}
