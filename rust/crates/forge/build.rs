//! FORGE_GIT_HASH for `forge --version`: $FORGE_GIT_HASH when set (release builds), else the
//! checkout's short commit, else empty (a source tree without git).
//!
//! FORGE_PLANNER_HASH for the routes stage's search key: a hash of the route planner's sources
//! (forge-sim and the workspace crates it is built from; src/planner_src.rs).
//!
//! FORGE_RECORDING_HASH for `forge record`'s archive stamps: a hash of the recordings normaliser's
//! sources (polestar-recording and src/cli/record.rs), so a change to either sessions every archive
//! again and any other change leaves them as they are.
use std::process::Command;

include!("src/planner_src.rs");

fn git(args: &[&str]) -> Option<String> {
	let out = Command::new("git").args(args).output().ok()?;
	out.status.success().then(|| String::from_utf8_lossy(&out.stdout).trim().to_string()).filter(|s| !s.is_empty())
}

fn main() {
	println!("cargo:rerun-if-env-changed=FORGE_GIT_HASH");
	for path in ["HEAD", "packed-refs"].iter().filter_map(|p| git(&["rev-parse", "--git-path", p])) {
		println!("cargo:rerun-if-changed={path}");
	}
	if let Some(p) = git(&["symbolic-ref", "-q", "HEAD"]).and_then(|r| git(&["rev-parse", "--git-path", &r])) {
		println!("cargo:rerun-if-changed={p}");
	}
	let hash = std::env::var("FORGE_GIT_HASH").ok().filter(|h| !h.is_empty()).or_else(|| git(&["rev-parse", "--short=9", "HEAD"])).unwrap_or_default();
	println!("cargo:rustc-env=FORGE_GIT_HASH={hash}");
	let sim = std::path::Path::new(&std::env::var("CARGO_MANIFEST_DIR").unwrap_or_default()).join("../forge-sim");
	let crates = path_closure(&sim);
	for c in &crates {
		for f in ["Cargo.toml", "build.rs", "src"] {
			println!("cargo:rerun-if-changed={}", c.join(f).display());
		}
	}
	println!("cargo:rustc-env=FORGE_PLANNER_HASH={}", sources_hash(&crates));
	let manifest = std::path::PathBuf::from(std::env::var("CARGO_MANIFEST_DIR").unwrap_or_default());
	let recording = manifest.join("../polestar-recording");
	let cli = manifest.join("src/cli/record.rs");
	for f in [recording.join("Cargo.toml"), recording.join("src"), cli.clone()] {
		println!("cargo:rerun-if-changed={}", f.display());
	}
	let mut h = blake3::Hasher::new();
	h.update(sources_hash(&[recording]).as_bytes());
	h.update(&std::fs::read(&cli).unwrap_or_default());
	println!("cargo:rustc-env=FORGE_RECORDING_HASH={}", h.finalize().to_hex());
}
