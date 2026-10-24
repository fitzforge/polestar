//! FORGE_GIT_HASH for `forge --version`: $FORGE_GIT_HASH when set (release builds), else the
//! checkout's short commit, else empty (a source tree without git).
use std::process::Command;

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
}
