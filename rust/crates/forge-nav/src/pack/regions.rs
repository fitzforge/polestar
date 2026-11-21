//! Integrity of an imported walking pack (tools/lib/nav/import-regions.js): each region's pages are one string in
//! its continent's part, so the pack's loaders (Nav.xml and the TOCs) are pinned in PACK.json. The release versioner
//! and translator may change only display metadata in a TOC without changing its loader hash.
use super::{sha256, PARTS};
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

pub(super) fn check(addon: &Path, doc: &Value, files: &Map<String, Value>, problems: &mut Vec<String>) {
	let parent = addon.parent().unwrap_or(Path::new("."));
	// 0.4.2 shipped each region as an addon of its own; their pages are in the parts now.
	let mut leftovers: Vec<String> = std::fs::read_dir(parent).into_iter().flatten().flatten().filter_map(|e| e.file_name().into_string().ok()).filter(|n| n.starts_with("Polestar_Nav_R")).collect();
	leftovers.sort();
	problems.extend(leftovers.into_iter().map(|name| format!("{name} is left from 0.4.2's regional addons: delete it")));
	if doc.get("regions").is_some() {
		problems.push("PACK.json lists regional addons: rerun tools/lib/nav/import-regions.js".into());
	}
	let Some(loaders) = doc["loaders"].as_object() else { return };
	let mut expected = BTreeSet::from(["Nav/Nav.xml".to_string(), "Polestar_Nav/Polestar_Nav.toc".to_string()]);
	for (_, part) in PARTS {
		if files.keys().any(|f| f.split_once('/').is_some_and(|(dir, _)| dir == part)) {
			expected.insert(format!("{part}/{part}.toc"));
		}
	}
	for key in &expected {
		let path = if key.starts_with("Nav/") { addon.join(key) } else { parent.join(key) };
		let digest = std::fs::read(path).ok().and_then(|b| loader_hash(key, &b));
		if digest.is_none() || digest.as_deref() != loaders.get(key).and_then(Value::as_str) {
			problems.push(format!("{key} loader differs from PACK.json"));
		}
	}
	problems.extend(loaders.keys().filter(|k| !expected.contains(*k)).map(|k| format!("{k} is not a packed loader")));
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
