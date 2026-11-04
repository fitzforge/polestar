//! `bundle --root <checkout> --sim <sim dir> --out <dir> --set <name>=<pack dir> [--set ...]`: the data
//! files the browser planner fetches (www/bundle/), gzipped (the page inflates them with
//! DecompressionStream):
//! - `data.json.gz`: the reference data (`<root>/data/forever`) as { file: text }, read by the guide
//!   compiler (WASM) and the planner's JS alike;
//! - `instances.json.gz`, `areas.json.gz`: the compiler's client tables (from `<root>/data/sources`);
//! - `spell-names.json.gz`: the spell names the compiler's texts read from the client's SpellName table;
//! - `repo.json.gz`: the other files the planner's JS reads, by checkout path ({ path: text }: package.json,
//!   the core TOC, the QuestXP table);
//! - `set-<name>.json.gz`: a guide pack { files: [[rel, text]], pack: { manifest, legs, retired, license,
//!   iface } }, and `set-<name>-translations.json.gz` its translations as pack_translations reads them
//!   natively (fetched for pack_compile only);
//! - `world-<faction>.json.gz` (fetched when a start of that faction is played), `params.json`;
//! - `manifest.json`: sets, file sizes, sources.

use std::io::Write;
use std::path::{Path, PathBuf};

use forge_guide::data::{FILES, OPTIONAL};
use forge_guide::js::stringify;

fn gz(out: &Path, name: &str, bytes: &[u8]) -> Result<(String, usize, usize), String> {
	let file = out.join(format!("{name}.gz"));
	let mut enc = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::best());
	enc.write_all(bytes).map_err(|e| e.to_string())?;
	let z = enc.finish().map_err(|e| e.to_string())?;
	std::fs::write(&file, &z).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok((format!("{name}.gz"), bytes.len(), z.len()))
}

fn main() {
	if let Err(e) = run() {
		eprintln!("bundle: {e}");
		std::process::exit(2);
	}
}

const USAGE: &str = "usage: bundle --root <checkout> --sim <sim dir> --out <dir> --set <name>=<pack dir> [--set ...]";

fn run() -> Result<(), String> {
	let (mut root, mut sim, mut out, mut sets) = (None, None, None, Vec::new());
	let mut it = std::env::args().skip(1);
	while let Some(a) = it.next() {
		let v = it.next().ok_or_else(|| format!("{a} needs a value\n{USAGE}"))?;
		match a.as_str() {
			"--root" => root = Some(PathBuf::from(v)),
			"--sim" => sim = Some(PathBuf::from(v)),
			"--out" => out = Some(PathBuf::from(v)),
			"--set" => {
				let (n, d) = v.split_once('=').ok_or_else(|| format!("--set {v}: want <name>=<pack dir>"))?;
				sets.push((n.to_string(), PathBuf::from(d)));
			}
			_ => return Err(format!("unknown option {a}\n{USAGE}")),
		}
	}
	let (Some(root), Some(sim), Some(out)) = (root, sim, out) else { return Err(USAGE.into()) };
	if sets.is_empty() {
		return Err(format!("no --set\n{USAGE}"));
	}
	std::fs::create_dir_all(&out).map_err(|e| e.to_string())?;
	let data_dir = root.join("data/forever");
	let sources = root.join("data/sources");
	let mut written = Vec::new();

	let mut texts = serde_json::Map::new();
	for name in FILES.iter().chain(OPTIONAL.iter()) {
		if let Ok(t) = std::fs::read_to_string(data_dir.join(format!("{name}.json"))) {
			texts.insert(name.to_string(), serde_json::Value::String(t));
		}
	}
	written.push(gz(&out, "data.json", serde_json::Value::Object(texts).to_string().as_bytes())?);
	written.push(gz(&out, "instances.json", stringify(&forge_guide::solo::load_instances(&sources), None).as_bytes())?);
	written.push(gz(&out, "areas.json", stringify(&forge_guide::areas::load_areas(&sources), None).as_bytes())?);

	let toc = "addon/Polestar/Polestar.toc";
	let mut repo = serde_json::Map::new();
	for rel in ["package.json", toc] {
		let t = std::fs::read_to_string(root.join(rel)).map_err(|e| format!("{}: {e}", root.join(rel).display()))?;
		repo.insert(rel.into(), t.into());
	}
	let wago = sources.join("wago");
	let mut builds: Vec<String> = std::fs::read_dir(&wago).map(|rd| rd.flatten().map(|d| d.file_name().to_string_lossy().into_owned()).collect()).unwrap_or_default();
	builds.sort();
	for b in &builds {
		if let Ok(t) = std::fs::read_to_string(wago.join(b).join("QuestXP.csv")) {
			repo.insert(format!("data/sources/wago/{b}/QuestXP.csv"), t.into());
		}
	}
	written.push(gz(&out, "repo.json", serde_json::Value::Object(repo).to_string().as_bytes())?);
	let iface = forge_guide::project::core_interface(&root)?;

	let data = forge_guide::project::load_project_data(&data_dir, &mut forge_guide::diag::Diagnostics::new())?;
	let spells: Vec<serde_json::Value> = forge_guide::tokens::read_spell_names(&data).into_iter().map(|(n, id)| serde_json::json!([n, id])).collect();
	written.push(gz(&out, "spell-names.json", serde_json::Value::Array(spells).to_string().as_bytes())?);
	let mut set_names = Vec::new();
	for (name, dir) in &sets {
		let rels = forge_guide::project::find_guide_files(dir, false);
		let files: Vec<(String, String)> = rels.iter().map(|r| (r.clone(), std::fs::read_to_string(dir.join(r)).unwrap_or_default())).collect();
		let read = |f: &str| std::fs::read_to_string(dir.join(f)).ok();
		let manifest_text = read("pack.json").ok_or_else(|| format!("{}: no pack.json", dir.display()))?;
		let manifest = forge_guide::js::parse_json(&manifest_text).map_err(|e| format!("{}/pack.json: {e}", dir.display()))?;
		let project = forge_guide::project::compile_project(dir, &manifest, &data, forge_guide::diag::Diagnostics::new(), false, None);
		let tr = forge_guide::i18n_guides::pack_translations(dir, &manifest, &project.guides)?;
		let doc = serde_json::json!({
			"files": files,
			"pack": {
				"manifest": manifest_text, "legs": read("legs.json"), "retired": read("retired.json"), "license": read("LICENSE"),
				"iface": iface,
			},
		});
		written.push(gz(&out, &format!("set-{name}.json"), doc.to_string().as_bytes())?);
		written.push(gz(&out, &format!("set-{name}-translations.json"), stringify(&tr.get("translations"), None).as_bytes())?);
		set_names.push(serde_json::json!({ "name": name, "dir": dir, "guides": project.guides.len(), "title": manifest.get("title").as_str() }));
	}

	for f in ["horde", "alliance"] {
		let w = std::fs::read(sim.join(format!("world-{f}.json"))).map_err(|e| format!("{}: {e}", sim.join(format!("world-{f}.json")).display()))?;
		written.push(gz(&out, &format!("world-{f}.json"), &w)?);
	}
	let params = std::fs::read_to_string(sim.join("params.json")).unwrap_or_default();
	std::fs::write(out.join("params.json"), &params).map_err(|e| e.to_string())?;

	let manifest = serde_json::json!({
		"root": root, "sim": sim, "sets": set_names,
		"files": written.iter().map(|(n, raw, z)| serde_json::json!({ "name": n, "bytes": raw, "gz": z })).collect::<Vec<_>>(),
	});
	std::fs::write(out.join("manifest.json"), serde_json::to_string_pretty(&manifest).unwrap()).map_err(|e| e.to_string())?;
	for (n, raw, z) in &written {
		println!("{n}: {raw} bytes, {z} gzipped");
	}
	Ok(())
}
