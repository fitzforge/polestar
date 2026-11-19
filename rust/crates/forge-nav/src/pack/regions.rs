//! Integrity of an imported regional map pack. Data and XML are pinned byte-for-byte. The release
//! versioner and translator may change only display metadata in a TOC without changing its loader hash.
use super::{sha256, toc_files, PARTS};
use serde_json::{Map, Value};
use std::collections::BTreeSet;
use std::path::Path;

fn display_header(line: &str) -> bool {
	let Some((key, _)) = line.strip_prefix("## ").and_then(|s| s.split_once(':')) else { return false };
	if matches!(key, "Title" | "Notes" | "Version") {
		return true;
	}
	let Some((kind, locale)) = key.split_once('-') else { return false };
	matches!(kind, "Title" | "Notes") && matches!(locale.as_bytes(), [b'a'..=b'z', b'a'..=b'z', b'A'..=b'Z', b'A'..=b'Z'])
}

fn loader_hash(key: &str, bytes: &[u8]) -> Option<String> {
	if !key.ends_with(".toc") {
		return Some(sha256(bytes));
	}
	let text = std::str::from_utf8(bytes).ok()?;
	Some(sha256(text.split('\n').filter(|l| !display_header(l)).collect::<Vec<_>>().join("\n").as_bytes()))
}

pub(super) fn check<'a>(addon: &Path, doc: &'a Value, files: &Map<String, Value>, problems: &mut Vec<String>) -> BTreeSet<&'a str> {
	let parent = addon.parent().unwrap_or(Path::new("."));
	let mut regions = BTreeSet::new();
	if let Some(list) = doc["regions"].as_array() {
		for item in list {
			match item.as_str().filter(|name| forge_guide::toc::nav_region(name).is_some()) {
				Some(name) if regions.insert(name) => (),
				_ => problems.push("invalid or duplicate region in PACK.json".into()),
			}
		}
	} else if doc.get("regions").is_some() || doc.get("import").is_some() {
		problems.push("PACK.json lacks a regions array".into());
	}
	for entry in std::fs::read_dir(parent).into_iter().flatten().flatten() {
		let name = entry.file_name();
		if let Some(name) = name.to_str().filter(|n| n.starts_with("Polestar_Nav_R")) {
			if !regions.contains(name) {
				problems.push(format!("{name} is not listed in PACK.json"));
			}
		}
	}
	if regions.is_empty() && doc.get("regions").is_none() && doc.get("loaders").is_none() {
		return regions;
	}
	let mut expected = BTreeSet::from(["Nav/Nav.xml".to_string(), "Polestar_Nav/Polestar_Nav.toc".to_string()]);
	for (_, part) in PARTS {
		if files.keys().any(|f| f.split_once('/').is_some_and(|(dir, _)| dir == part)) {
			expected.insert(format!("{part}/{part}.toc"));
		}
	}
	for &region in &regions {
		let toc = format!("{region}.toc");
		expected.insert(format!("{region}/{toc}"));
		if !files.contains_key(&format!("{region}/Pages.lua")) {
			problems.push(format!("{region}/Pages.lua lacks a data hash"));
		}
		let dir = parent.join(region);
		let text = std::fs::read_to_string(dir.join(&toc)).unwrap_or_default();
		let (map, _, _) = forge_guide::toc::nav_region(region).unwrap();
		let dependency = match map {
			"0" => "Polestar_Nav_EK",
			"1" => "Polestar_Nav_Kalimdor",
			_ => "Polestar_Nav",
		};
		if toc_files(&text) != ["Pages.lua"] || !text.lines().any(|l| l.strip_prefix("## Dependencies: ") == Some(dependency)) || !text.lines().any(|l| l == "## LoadOnDemand: 1") {
			problems.push(format!("{region}/{toc} is not a regional page loader"));
		}
		for entry in std::fs::read_dir(dir).into_iter().flatten().flatten() {
			let name = entry.file_name();
			if name != toc.as_str() && name != "Pages.lua" {
				problems.push(format!("{region}/{} is not a packed file", name.to_string_lossy()));
			}
		}
	}
	let loaders = doc["loaders"].as_object();
	for key in &expected {
		let path = if key.starts_with("Nav/") { addon.join(key) } else { parent.join(key) };
		let digest = std::fs::read(path).ok().and_then(|b| loader_hash(key, &b));
		if digest.is_none() || digest.as_deref() != loaders.and_then(|m| m.get(key)).and_then(Value::as_str) {
			problems.push(format!("{key} loader differs from PACK.json"));
		}
	}
	if let Some(loaders) = loaders {
		problems.extend(loaders.keys().filter(|k| !expected.contains(*k)).map(|k| format!("{k} is not a packed loader")));
	}
	regions
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn toc_hash_ignores_display_edits_but_not_execution_order_or_dependencies() {
		let a = "## Interface: 16001\n## Version: 1\n## Title-frFR: A\n## Notes: X\n## Dependencies: Polestar_Nav\n## LoadOnDemand: 1\nA.lua\nB.lua\n";
		let hash = |s: &str| loader_hash("region.toc", s.as_bytes());
		assert_eq!(hash(a), hash(&a.replace("Version: 1", "Version: 2").replace("Title-frFR: A", "Title-frFR: B\n## Notes-deDE: Y").replace("Notes: X", "Notes: Z")));
		for (from, to) in [("A.lua\nB.lua", "B.lua\nA.lua"), ("A.lua", "C.lua"), ("Dependencies: Polestar_Nav", "Dependencies: Polestar"), ("LoadOnDemand: 1", "LoadOnDemand: 0"), ("16001", "16002")] {
			assert_ne!(hash(a), hash(&a.replace(from, to)));
		}
	}
}
