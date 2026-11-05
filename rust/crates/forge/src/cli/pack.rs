//! `forge release pack`: the release archives. In the checkout: dist/Polestar-<version>.zip (Polestar,
//! Polestar_Guides, Polestar_Nav, the Codex and the built data addons) and
//! dist/Polestar_Recorder-<version>.zip, each with the GPL in its first folder (and the players'
//! README.txt in Polestar/), plus dist/SHA256SUMS for both. Given another pack (a folder argument,
//! --pack, or the nearest pack.json): <pack>/dist/<folder>-<version>.zip holding its built addon folder.

use super::release::{checkout, opt, positional};
use forge_guide::data::Data;
use forge_guide::diag::{Diag, Diagnostics};
use forge_guide::js::V;
use forge_guide::project::{build_pack, find_guide_files, find_pack_dir, load_project_data, no_reference_data, read_sources, same_path, BuildOpts, Context, FileContent};
use forge_release::addons::{codex_refusal, guide_notice_refusal, notice_refusal, release_addons, retired_addons, toc_version, CODEX, RECORDER};
use forge_release::pack::{archive_entries, pack_entries, readme, sha256_hex};
use forge_release::zip::{write_zip, Entry};
use forge_release::{plural, shown};
use std::path::{Path, PathBuf};

pub const USAGE: &str = "usage: forge release pack [<dir>] [options]

In the checkout: compiles our guides into addon/Polestar_Guides, then writes dist/Polestar-<version>.zip
(Polestar, Polestar_Guides with its faction parts and race parts, Polestar_Nav, Polestar_QuestDB and
Polestar_ItemDB when built, Polestar_Codex, and the language folders Polestar_<locale>: our guides' texts
and the game's names),
dist/Polestar_Recorder-<version>.zip and dist/SHA256SUMS (the format `sha256sum -c` reads), the version
taken from package.json. Polestar/ in the zip also carries LICENSE and README.txt (install steps),
Polestar_Recorder/ the LICENSE. The Codex must be built first (forge data codex) from release-safe inputs:
pack stops on a missing Codex or a local-extras one.

Given another pack (<dir>, --pack, or run inside one): builds it with our guides as context, then writes
<pack>/dist/<folder>-<version>.zip holding its addon folder (and its texts addons and race parts), the
version taken from its pack.json.

Both are byte for byte reproducible: the same sources give the same archives on every machine. Without
reference data (forge data build) pack stops with one error; another pack can be built without it with
--no-data.

options:
  <dir>, --pack <dir>   the pack folder, holding pack.json (default: the nearest pack.json, else our guides)
  --root <dir>          the Polestar checkout (default: the one above here, else above the forge binary)
  --data <dir>          reference data (default <root>/data/forever/)
  --context <dir>       our guides, read as context for another pack (default <root>/guides/)
  --context-data <dir>  reference data for the context (default <root>/data/forever/)
  --guides <dir>        our guide sources (default <root>/guides/; not with a pack folder)
  --addons <dir>        the addon folders (default <root>/addon/)
  --dist <dir>          the output folder (default <root>/dist/, <pack>/dist/ for another pack)
  --no-data             another pack only: build it without reference data (every quest title, NPC name
                        and place given in the guide)";

const VALUES: [&str; 8] = ["--pack", "--root", "--data", "--context", "--context-data", "--guides", "--addons", "--dist"];

fn print_errors(diags: &[Diag]) {
	for d in diags.iter().filter(|d| d.severity != "warning") {
		eprintln!("{}", forge_guide::diag::format(d));
	}
}

fn bytes(c: &FileContent) -> Vec<u8> {
	match c {
		FileContent::Text(t) => t.clone().into_bytes(),
		FileContent::Bytes(b) => b.clone(),
	}
}

fn io(p: &Path) -> impl Fn(std::io::Error) -> String + '_ {
	move |e| format!("{}: {e}", p.display())
}

pub fn run(args: &[String]) -> Result<(), super::Fail> {
	super::check_args(args, &VALUES, &["--no-data"], usize::MAX).map_err(super::usage)?;
	let cwd = std::env::current_dir().unwrap_or_default();
	let at = |p: String| forge_release::absolute(Path::new(&p));
	let named = positional(args, &VALUES);
	if named.len() > 1 {
		return Err(super::usage(format!("one pack folder only, got {}: {}", named.len(), named.iter().map(|p| format!("\"{p}\"")).collect::<Vec<_>>().join(" "))));
	}
	let pack_arg = match (named.first(), opt(args, "--pack")) {
		(Some(p), Some(q)) => return Err(super::usage(format!("the pack folder is named twice (\"{p}\" and --pack {q}); give it once"))),
		(p, q) => p.cloned().or(q),
	};
	if let Some(p) = &pack_arg {
		if !at(p.clone()).join("pack.json").exists() {
			return Err(super::usage(format!("no pack.json in {p}")));
		}
	}
	if opt(args, "--guides").is_some() && pack_arg.is_some() {
		return Err(super::usage("--guides and a pack folder cannot be used together"));
	}
	let no_data = args.iter().any(|a| a == "--no-data");
	if no_data {
		if let Some(k) = ["--data", "--context-data"].into_iter().find(|k| opt(args, k).is_some()) {
			return Err(super::usage(format!("--no-data and {k} cannot be used together")));
		}
	}
	for k in ["--context", "--context-data"] {
		if let Some(v) = opt(args, k) {
			if !at(v.clone()).is_dir() {
				return Err(super::usage(format!("{k} {v} is not a folder")));
			}
		}
	}
	let root = checkout(opt(args, "--root"))?;
	let official_dir = root.join("guides");
	let other = if opt(args, "--guides").is_some() {
		None
	} else {
		let dir = pack_arg.map(at).or_else(|| find_pack_dir(&cwd)).unwrap_or_else(|| official_dir.clone());
		(!same_path(&dir, &official_dir)).then_some(dir)
	};
	let data_dir = opt(args, "--data").map_or_else(|| root.join("data/forever"), at);
	match other {
		Some(pack_dir) => pack_other(args, &root, &pack_dir, &data_dir, no_data),
		None if no_data => Err(super::usage("--no-data builds a community addon; our release needs the reference data")),
		None => pack_release(args, &root, &data_dir),
	}
}

/// Our release: dist/Polestar-<version>.zip, dist/Polestar_Recorder-<version>.zip, dist/SHA256SUMS.
fn pack_release(args: &[String], root: &Path, data_dir: &Path) -> Result<(), super::Fail> {
	let at = |p: String| forge_release::absolute(Path::new(&p));
	let guides = opt(args, "--guides").map_or_else(|| root.join("guides"), at);
	let addons = opt(args, "--addons").map_or_else(|| root.join("addon"), at);
	let dist = opt(args, "--dist").map_or_else(|| root.join("dist"), at);
	let (manifest, diags) = forge_guide::manifest::read_manifest(&root.join("guides"), true);
	for d in &diags {
		eprintln!("{}", forge_guide::diag::format(d));
	}
	let manifest = manifest.filter(V::truthy).ok_or("guides/pack.json is invalid")?;
	let version = forge_release::version::package_version(root)?;
	let folder = manifest.get("folder").to_js_string();
	let said = manifest.get("version").to_js_string();
	if said != version {
		eprintln!("warning: guides/pack.json says version {said}, package.json says {version}");
	}
	let product = release_addons(&addons);
	// The Codex is part of Polestar (Lookup, Dungeons, Rares): built from release-safe inputs, or no release.
	if let Some(why) = codex_refusal(&addons.join(CODEX)) {
		return Err(format!("{CODEX} {why}").into());
	}
	if let Some(why) = notice_refusal(&addons, &product.names) {
		return Err(why.into());
	}
	for n in &product.skipped {
		println!("note: {n} not built (no {n}/{n}.toc); leaving it out of the zip");
	}
	for n in retired_addons(&addons) {
		println!("note: {n} is left from before 0.3.0 (the language folders replaced it); leaving it out of the zip: delete it");
	}
	let license_file = root.join("LICENSE");
	let license = std::fs::read(&license_file).map_err(io(&license_file))?;
	let recorder = vec![RECORDER.to_string()];
	for names in [&product.names, &recorder] {
		// Our guide pack's TOC is generated below.
		for n in names.iter().filter(|n| **n != folder) {
			let toc = addons.join(n).join(format!("{n}.toc"));
			if !toc.exists() {
				return Err(format!("missing {}", toc.display()).into());
			}
			let v = toc_version(&addons.join(n), n);
			if v.as_deref() != Some(version.as_str()) {
				eprintln!("warning: {n}.toc says version {}, package.json says {version}", v.as_deref().unwrap_or("null"));
			}
		}
	}

	// Our guides, built in memory (manifest diagnostics were printed above), written to addon/<folder>.
	if let Some(missing) = no_reference_data(data_dir, None, false) {
		print_errors(&missing.sorted());
		return Err("no reference data".into());
	}
	let mut data_diag = Diagnostics::new();
	let data = load_project_data(data_dir, &mut data_diag)?;
	let built = build_pack(root, &guides, &manifest, Vec::new(), &data, data_diag, BuildOpts { include_drafts: false, context: None, force: false })?;
	let diag = built.project.diag;
	print_errors(&diag.sorted());
	let Some(files) = built.files.filter(|_| !diag.has_errors()) else {
		return Err(format!("{} in guides (forge guide lint for details)", plural(diag.errors().len(), "error")).into());
	};
	forge_guide::project::write_pack_dir(&addons.join(&folder), &files)?;
	// The folders again: the build writes our pack's parts (its faction parts, format 8).
	let product = release_addons(&addons);
	if let Some(why) = guide_notice_refusal(&addons, &product.names) {
		return Err(why.into());
	}

	let gpl = Entry::file("LICENSE", license);
	let archives = [
		(format!("Polestar-{version}.zip"), &product.names, vec![("Polestar", vec![gpl.clone(), Entry::file("README.txt", readme(&version, &product.names))])]),
		(format!("Polestar_Recorder-{version}.zip"), &recorder, vec![(RECORDER, vec![gpl])]),
	];
	let mut sums = String::new();
	for (file, names, extras) in &archives {
		let out = dist.join(file);
		write_zip(&out, &archive_entries(&addons, names, extras)?)?;
		sums.push_str(&format!("{}  {file}\n", sha256_hex(&std::fs::read(&out).map_err(io(&out))?)));
		println!("wrote {}", shown(&out));
	}
	let sums_file = dist.join("SHA256SUMS");
	std::fs::write(&sums_file, sums).map_err(io(&sums_file))?;
	println!("wrote {}", shown(&sums_file));
	println!("{}: {}", folder, plural(built.project.guides.len(), "guide"));
	Ok(())
}

/// Another pack: <dist>/<folder>-<version>.zip from its build, in memory.
fn pack_other(args: &[String], root: &Path, pack_dir: &Path, data_dir: &Path, no_data: bool) -> Result<(), super::Fail> {
	let at = |p: String| forge_release::absolute(Path::new(&p));
	let (manifest, extra) = forge_guide::manifest::read_manifest(pack_dir, false);
	let Some(manifest) = manifest.filter(V::truthy) else {
		print_errors(&extra);
		return Err(format!("{} in pack.json", plural(extra.iter().filter(|d| d.severity == "error").count(), "error")).into());
	};
	let context_dir = opt(args, "--context").map_or_else(|| root.join("guides"), at);
	let context_data_dir = opt(args, "--context-data").map_or_else(|| root.join("data/forever"), at);
	let mut data_diag = Diagnostics::new();
	let (data, context_data) = if no_data {
		(Data::empty(), Some(Data::empty()))
	} else {
		if let Some(missing) = no_reference_data(data_dir, Some(&context_data_dir), true) {
			print_errors(&missing.sorted());
			return Err("no reference data".into());
		}
		let data = load_project_data(data_dir, &mut data_diag)?;
		let context_data = if same_path(&context_data_dir, data_dir) { None } else { Some(load_project_data(&context_data_dir, &mut data_diag)?) };
		(data, context_data)
	};
	let context = Context { sources: read_sources(&context_dir, &find_guide_files(&context_dir, false)), data: context_data.as_ref().unwrap_or(&data) };
	let built = build_pack(root, pack_dir, &manifest, extra, &data, data_diag, BuildOpts { include_drafts: false, context: Some(context), force: false })?;
	let diag = built.project.diag;
	print_errors(&diag.sorted());
	let Some(files) = built.files.filter(|_| !diag.has_errors()) else {
		return Err(format!("{} (forge guide lint for details)", plural(diag.errors().len(), "error")).into());
	};
	let folder = manifest.get("folder").to_js_string();
	if !forge_guide::format::is_folder(&folder) {
		return Err(format!("refusing the pack folder {folder:?}: not a plain folder name").into());
	}
	let dist: PathBuf = opt(args, "--dist").map_or_else(|| pack_dir.join("dist"), at);
	let out = dist.join(format!("{folder}-{}.zip", manifest.get("version").to_js_string()));
	let files: Vec<(String, Vec<u8>)> = files.iter().map(|(n, c)| (n.clone(), bytes(c))).collect();
	write_zip(&out, &pack_entries(&folder, &files))?;
	println!("wrote {} ({})", shown(&out), plural(built.project.guides.len(), "guide"));
	Ok(())
}
