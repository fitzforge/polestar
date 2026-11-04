// The route planner's code as a hash, for the routes stage's search key (lib.rs: routes_search_key):
// forge-sim and the workspace crates it is built from, so a change to the writer, the judge or forge
// itself leaves the finished searches in place, and a change to the planner searches again.
// Shared by build.rs (include!, which hashes the checkout at build time into FORGE_PLANNER_HASH)
// and the library (planner_src, tested on a made-up workspace).

/// A crate and the workspace crates it is built from: its `[dependencies]` with a `path` (not its
/// dev or build dependencies), transitively; their folders, sorted.
pub fn path_closure(crate_dir: &std::path::Path) -> Vec<std::path::PathBuf> {
	let mut seen: Vec<std::path::PathBuf> = Vec::new();
	let mut todo = vec![crate_dir.to_path_buf()];
	while let Some(d) = todo.pop() {
		let d = std::fs::canonicalize(&d).unwrap_or(d);
		if seen.contains(&d) {
			continue;
		}
		let manifest = std::fs::read_to_string(d.join("Cargo.toml")).unwrap_or_default();
		let mut deps = false;
		for line in manifest.lines().map(str::trim) {
			if line.starts_with('[') {
				deps = line == "[dependencies]";
				continue;
			}
			if !deps {
				continue;
			}
			let Some(rest) = line.split("path = \"").nth(1) else { continue };
			let Some(rel) = rest.split('"').next() else { continue };
			todo.push(d.join(rel));
		}
		seen.push(d);
	}
	seen.sort();
	seen
}

/// The files a crate's build reads: its Cargo.toml, build.rs and everything under src/.
pub fn crate_files(crate_dir: &std::path::Path) -> Vec<std::path::PathBuf> {
	let mut out: Vec<std::path::PathBuf> = ["Cargo.toml", "build.rs"].iter().map(|f| crate_dir.join(f)).filter(|p| p.is_file()).collect();
	let mut stack = vec![crate_dir.join("src")];
	while let Some(d) = stack.pop() {
		let Ok(rd) = std::fs::read_dir(&d) else { continue };
		for e in rd.flatten() {
			let p = e.path();
			if p.is_dir() {
				stack.push(p);
			} else {
				out.push(p);
			}
		}
	}
	out.sort();
	out
}

/// BLAKE3 (hex) of the crates' files: per crate its folder name, then each file's path in it and bytes.
pub fn sources_hash(crates: &[std::path::PathBuf]) -> String {
	let mut h = blake3::Hasher::new();
	for c in crates {
		h.update(c.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default().as_bytes());
		h.update(b"\0c");
		for f in crate_files(c) {
			h.update(f.strip_prefix(c).unwrap_or(&f).to_string_lossy().replace('\\', "/").as_bytes());
			h.update(b"\0");
			let b = std::fs::read(&f).unwrap_or_default();
			h.update(&(b.len() as u64).to_le_bytes());
			h.update(&b);
		}
	}
	h.finalize().to_hex().to_string()
}
