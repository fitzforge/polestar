//! The route fixes: `data/route-fixes.json` in the checkout, read at run time (never built into
//! the binary, so a prebuilt `forge` applies the checkout's fixes). `deliberate` holds v1's
//! deliberate orders (player-report fixes every cut keeps), `overrides` the maintainer's include,
//! skip, revert and pairs. `$POLESTAR_ROUTE_FIXES` names another file.
//!
//! A program loads the file once ([`load`], or [`set`] for a caller with no file system); every
//! later [`get`] returns it. Without either, [`get`] looks for `$POLESTAR_ROUTE_FIXES`, then for
//! `data/route-fixes.json` in the folders above the current one.

use std::path::{Path, PathBuf};
use std::sync::{Arc, RwLock};

use serde_json::Value;

/// The file's place in a checkout.
pub const FILE: &str = "data/route-fixes.json";
/// The environment variable that names another file.
pub const ENV: &str = "POLESTAR_ROUTE_FIXES";

static DOC: RwLock<Option<(Arc<Value>, PathBuf)>> = RwLock::new(None);

/// Parses a route fixes document: an object with `deliberate` and `overrides` objects.
pub fn parse(bytes: &[u8], label: &str) -> Result<Value, String> {
	let v: Value = serde_json::from_slice(bytes).map_err(|e| format!("{label}: {e}"))?;
	if !v["deliberate"].is_object() || !v["overrides"].is_object() {
		return Err(format!("{label}: not a route fixes file (it needs a \"deliberate\" and an \"overrides\" object)"));
	}
	Ok(v)
}

/// Reads `path` and makes it the route fixes every later [`get`] returns.
pub fn load(path: &Path) -> Result<Arc<Value>, String> {
	let bytes = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
	let doc = Arc::new(parse(&bytes, &path.display().to_string())?);
	*DOC.write().unwrap_or_else(|e| e.into_inner()) = Some((doc.clone(), path.to_path_buf()));
	Ok(doc)
}

/// Makes `doc` the route fixes (for callers that hold the document, not a file).
pub fn set(doc: Value) {
	*DOC.write().unwrap_or_else(|e| e.into_inner()) = Some((Arc::new(doc), PathBuf::from("(given)")));
}

/// The file a program uses when it names none: `$POLESTAR_ROUTE_FIXES`, else `<root>/data/route-fixes.json`
/// for each of `roots` that has one, else the nearest `data/route-fixes.json` above the current folder.
pub fn find(roots: &[&Path]) -> Option<PathBuf> {
	if let Some(p) = std::env::var_os(ENV) {
		return Some(PathBuf::from(p));
	}
	if let Some(p) = roots.iter().map(|r| r.join(FILE)).find(|p| p.is_file()) {
		return Some(p);
	}
	std::env::current_dir().ok()?.ancestors().map(|d| d.join(FILE)).find(|p| p.is_file())
}

/// Loads the file [`find`] names for `roots`.
pub fn load_for(roots: &[&Path]) -> Result<Arc<Value>, String> {
	let p = find(roots).ok_or_else(|| format!("no {FILE} in {} or above the current folder, and no ${ENV}", roots.iter().map(|r| r.display().to_string()).collect::<Vec<_>>().join(", ")))?;
	load(&p)
}

/// The route fixes in use (loaded once; see the module).
pub fn get() -> Arc<Value> {
	if let Some((d, _)) = DOC.read().unwrap_or_else(|e| e.into_inner()).as_ref() {
		return d.clone();
	}
	load_for(&[]).unwrap_or_else(|e| panic!("route fixes: {e}"))
}

/// The file the route fixes in use came from.
pub fn path() -> Option<PathBuf> {
	DOC.read().unwrap_or_else(|e| e.into_inner()).as_ref().map(|(_, p)| p.clone())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn the_checkout_file_is_a_route_fixes_file() {
		let p = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").join(FILE);
		let v = parse(&std::fs::read(&p).expect("data/route-fixes.json"), FILE).expect("parses");
		assert!(v["deliberate"]["pairs"].as_array().is_some_and(|a| !a.is_empty()), "deliberate pairs");
		assert!(v["overrides"]["include"].is_array(), "overrides include");
	}

	#[test]
	fn another_document_is_refused() {
		assert!(parse(br#"{ "include": [], "skip": [] }"#, "old").is_err(), "a bare overrides file");
		assert!(parse(b"[", "broken").is_err(), "not JSON");
	}
}
