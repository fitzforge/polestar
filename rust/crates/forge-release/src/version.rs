//! The release version: kept in package.json, in our guides' pack manifest (guides/pack.json: compile
//! writes its version into Polestar_Guides.toc) and in the `## Version` line of every addon TOC.

use std::path::{Path, PathBuf};
use std::sync::LazyLock;

static JSON_VERSION: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r#"(?m)^(\s*"version"\s*:\s*)"[^"]*""#).unwrap());
static TOC_VERSION: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"(?m)^## Version:[^\S\r\n]*(\S*)").unwrap());

/// The files that carry the version under a checkout.
pub struct Files {
	pub package: PathBuf,
	/// guides/pack.json, when the checkout has one.
	pub manifest: Option<PathBuf>,
	/// `<addons>/<Name>/<Name>.toc` of every folder that has one (hidden folders skipped), sorted.
	pub tocs: Vec<PathBuf>,
}

pub fn files(root: &Path, addons: &Path) -> Files {
	let manifest = Some(root.join("guides/pack.json")).filter(|f| f.exists());
	let mut tocs: Vec<PathBuf> = std::fs::read_dir(addons)
		.into_iter()
		.flatten()
		.flatten()
		.filter(|d| d.file_type().is_ok_and(|t| t.is_dir()))
		.map(|d| d.file_name().to_string_lossy().into_owned())
		.filter(|n| !n.starts_with('.'))
		.map(|n| addons.join(&n).join(format!("{n}.toc")))
		.filter(|f| f.exists())
		.collect();
	tocs.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.to_string_lossy(), &b.to_string_lossy()));
	Files { package: root.join("package.json"), manifest, tocs }
}

fn read(file: &Path) -> Result<String, String> {
	std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))
}

/// The `"version"` of a JSON file (package.json, pack.json); None when it has none.
fn json_version(file: &Path) -> Result<Option<serde_json::Value>, String> {
	let doc: serde_json::Value = serde_json::from_str(&read(file)?).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(doc.get("version").cloned())
}

/// package.json's version under `root`.
pub fn package_version(root: &Path) -> Result<String, String> {
	let file = root.join("package.json");
	match json_version(&file)? {
		Some(serde_json::Value::String(v)) => Ok(v),
		_ => Err(format!("{}: no \"version\" field", file.display())),
	}
}

/// A TOC's `## Version:` value ("" for a line without one); None without the line.
pub fn toc_version(text: &str) -> Option<String> {
	TOC_VERSION.captures(text).map(|c| c[1].to_string())
}

/// The version (package.json's) and every file that disagrees with it, with what it says instead:
/// `version X`, `no "version" field` or `no ## Version line`.
pub fn check(f: &Files) -> Result<(String, Vec<(PathBuf, String)>), String> {
	let version = package_version(f.package.parent().unwrap_or(Path::new(".")))?;
	let mut wrong = Vec::new();
	if let Some(m) = &f.manifest {
		match json_version(m)? {
			Some(serde_json::Value::String(v)) if v == version => {}
			None => wrong.push((m.clone(), "no \"version\" field".into())),
			Some(v) => wrong.push((m.clone(), format!("version {}", v.as_str().map(str::to_string).unwrap_or_else(|| v.to_string())))),
		}
	}
	for toc in &f.tocs {
		match toc_version(&read(toc)?) {
			Some(v) if v == version => {}
			Some(v) => wrong.push((toc.clone(), format!("version {v}"))),
			None => wrong.push((toc.clone(), "no ## Version line".into())),
		}
	}
	Ok((version, wrong))
}

/// Sets `version` in every file, changing nothing else in them. Err: the files that have no version to
/// set (and nothing is written), or a read/write failure.
pub fn set(f: &Files, version: &str) -> Result<(), Vec<(PathBuf, String)>> {
	let one = |p: &Path, e: String| vec![(p.to_path_buf(), e)];
	let pkg = read(&f.package).map_err(|e| one(&f.package, e))?;
	if !JSON_VERSION.is_match(&pkg) {
		return Err(one(&f.package, "no \"version\" field".into()));
	}
	let man = match &f.manifest {
		Some(m) => {
			let text = read(m).map_err(|e| one(m, e))?;
			if !JSON_VERSION.is_match(&text) {
				return Err(one(m, "no \"version\" field".into()));
			}
			Some((m, text))
		}
		None => None,
	};
	let mut tocs = Vec::new();
	let mut missing = Vec::new();
	for t in &f.tocs {
		let text = read(t).map_err(|e| one(t, e))?;
		if toc_version(&text).is_none() {
			missing.push((t.clone(), "no ## Version line".into()));
		}
		tocs.push((t, text));
	}
	if !missing.is_empty() {
		return Err(missing);
	}
	let json = |text: &str| JSON_VERSION.replacen(text, 1, |c: &regex::Captures| format!("{}\"{version}\"", &c[1])).into_owned();
	let write = |p: &Path, text: String| std::fs::write(p, text).map_err(|e| one(p, e.to_string()));
	write(&f.package, json(&pkg))?;
	if let Some((m, text)) = man {
		write(m, json(&text))?;
	}
	for (t, text) in tocs {
		let line = format!("## Version: {version}");
		write(t, TOC_VERSION.replacen(&text, 1, regex::NoExpand(&line)).into_owned())?;
	}
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn toc_versions() {
		assert_eq!(toc_version("## Interface: 16001\n## Version: 0.2.0\nMain.lua\n").as_deref(), Some("0.2.0"));
		assert_eq!(toc_version("## Version:\nMain.lua\n").as_deref(), Some(""));
		assert_eq!(toc_version("## Interface: 16001\n").as_deref(), None);
	}
}
