//! The leveling guides' titles as published are the writer's (src/titles.rs): its title pass over
//! each generated guide, from the seed's title, gives the title the guide has. A title edited by hand
//! in the published guide alone, or a seed title the writer would reorder or cut, fails here before a
//! build changes it under the players.

use forge_writer::titles::guide_titles;
use std::collections::{BTreeMap, BTreeSet};
use std::path::{Path, PathBuf};

fn root() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..")
}

fn title(text: &str) -> Option<&str> {
	text.lines().take_while(|l| !l.starts_with("step ")).find_map(|l| l.strip_prefix("title ")).map(str::trim)
}

/// `text` with its header's title set to `t`.
fn retitled(text: &str, t: &str) -> String {
	let mut done = false;
	text.split('\n')
		.map(|l| {
			if !done && l.starts_with("title ") {
				done = true;
				format!("title {t}")
			} else {
				l.to_string()
			}
		})
		.collect::<Vec<_>>()
		.join("\n")
}

#[test]
fn every_generated_guide_s_title_is_the_writer_s() {
	let root = root();
	let manifest: serde_json::Value = serde_json::from_slice(&std::fs::read(root.join("guides/GENERATED.json")).unwrap()).unwrap();
	let files: Vec<String> = manifest["files"].as_object().unwrap().keys().filter(|f| f.ends_with(".guide")).cloned().collect();
	assert!(files.len() > 50, "the generated leveling guides: {}", files.len());
	let texts: BTreeMap<&String, String> = files.iter().map(|f| (f, std::fs::read_to_string(root.join("guides").join(f)).unwrap())).collect();
	// The zones: every name a guide's `zone` line gives (the build asks the data; the guides name the same zones).
	let zones: BTreeSet<String> = texts.values().flat_map(|t| t.lines().filter_map(|l| l.trim_start().strip_prefix("zone ").map(|z| z.trim().to_lowercase()))).collect();
	let is_zone = |z: &str| zones.contains(&z.to_lowercase());
	let mut wrong = Vec::new();
	for (rel, text) in &texts {
		let published = title(text).unwrap_or_else(|| panic!("{rel}: no title"));
		// The seed's title, where the guide has a seed of its own (a race's copy of a shared start has none).
		let seed = std::fs::read_to_string(root.join("forge/seed/guides").join(rel)).ok();
		let from = seed.as_deref().and_then(title).unwrap_or(published);
		let mut tree = BTreeMap::from([((*rel).clone(), retitled(text, from))]);
		guide_titles(&mut tree, &[(*rel).clone()], &is_zone);
		let written = title(&tree[*rel]).unwrap().to_string();
		if written != published {
			wrong.push(format!("{rel}: published \"{published}\", the writer gives \"{written}\" (from \"{from}\")"));
		}
	}
	assert!(wrong.is_empty(), "titles the writer would change (docs/forge/writer.md, \"Guide titles\"):\n{}", wrong.join("\n"));
}
