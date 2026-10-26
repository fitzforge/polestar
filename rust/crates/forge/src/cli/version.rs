//! `forge release version`: the release version, kept in package.json, in our guides' pack manifest
//! (guides/pack.json: compile writes its version into Polestar_Guides.toc) and in the `## Version` line
//! of every addon TOC. Without an argument it prints the version and any file that disagrees; with one
//! it sets them all.

use super::release::{checkout, opt, positional};
use std::path::Path;

pub const USAGE: &str = "usage: forge release version [<x.y.z>] [options]

Without a version, prints package.json's version and names guides/pack.json or any addon TOC whose
version differs (exit 1 if one does). With one, writes it to package.json, to guides/pack.json (compile
takes Polestar_Guides' version from it) and to the ## Version line of every addon/<Name>/<Name>.toc
present, changing nothing else in them; nothing is written when one of them has no version to set.
Data addons built later take the version from package.json. Versions are x.y.z, or x.y.z-<pre> for a
release candidate.

options:
  --root <dir>     the checkout holding package.json (default: the one above here, else above the forge binary)
  --addons <dir>   the addon folder (default <root>/addon/)";

const VALUES: [&str; 2] = ["--root", "--addons"];

pub fn run(args: &[String]) -> Result<(), super::Fail> {
	super::check_args(args, &VALUES, &[], 1).map_err(|e| super::usage(if e.starts_with("unexpected argument") { "one version at most".into() } else { e }))?;
	let root = checkout(opt(args, "--root"))?;
	let addons = opt(args, "--addons").map_or_else(|| root.join("addon"), |a| forge_release::absolute(Path::new(&a)));
	let files = forge_release::version::files(&root, &addons);
	let Some(version) = positional(args, &VALUES).pop() else {
		let (version, wrong) = forge_release::version::check(&files)?;
		println!("{version}");
		for (file, what) in &wrong {
			eprintln!("{}: {what}", forge_release::shown(file));
		}
		return if wrong.is_empty() { Ok(()) } else { Err(format!("{} with another version than package.json's", forge_release::plural(wrong.len(), "file")).into()) };
	};
	if !forge_release::is_version(&version) {
		return Err(super::usage(format!("\"{version}\" is not a version (x.y.z or x.y.z-pre)")));
	}
	if let Err(faults) = forge_release::version::set(&files, &version) {
		let lines: Vec<String> = faults.iter().map(|(f, what)| format!("{}: {what}", forge_release::shown(f))).collect();
		return Err(format!("nothing written:\n{}", lines.join("\n")).into());
	}
	let n = files.tocs.len();
	println!("version {version}: package.json, {}{n} addon TOC{}", if files.manifest.is_some() { "guides/pack.json and " } else { "" }, if n == 1 { "" } else { "s" });
	Ok(())
}
