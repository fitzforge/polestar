//! The planner's hours (what the browser runs: guides compiled one by one, as on load and edits) against
//! `forge-judge`'s native walk (`report`'s rows): hours to 30 and 60 and the end level equal for the base
//! (v1) Orc and Human and two written routes, from the same files the bundle carries; and the addon files
//! the browser's pack_compile zips equal the native compile's.
//!
//! Inputs (local, not in the repository): `POLESTAR_SEED` (a checkout with guides/ and data/forever,
//! data/sources), `POLESTAR_SIM` (world-{horde,alliance}.json and params.json), and optionally
//! `POLESTAR_WRITTEN_ORC` / `POLESTAR_WRITTEN_HUMAN` (written guide trees).
//!
//! POLESTAR_SEED=... POLESTAR_SIM=... cargo test --release -p forge-wasm --features native --test parity -- --ignored --nocapture

#![cfg(feature = "native")]

use forge_judge::levels::SimLevels;
use forge_judge::walk::{judge_walk, JudgeOpts};
use forge_wasm::{Character, Pack, Planner};
use rustc_hash::FxHashMap;
use std::path::{Path, PathBuf};

fn var(k: &str) -> PathBuf {
	PathBuf::from(std::env::var(k).unwrap_or_else(|_| panic!("set {k} (see the module comment)")))
}

fn planner(guides: &Path) -> Planner {
	let (seed, sim) = (var("POLESTAR_SEED"), var("POLESTAR_SIM"));
	let data = seed.join("data/forever");
	let mut texts = FxHashMap::default();
	for n in forge_guide::data::FILES.iter().chain(forge_guide::data::OPTIONAL.iter()) {
		if let Ok(t) = std::fs::read_to_string(data.join(format!("{n}.json"))) {
			texts.insert(n.to_string(), t);
		}
	}
	let src = seed.join("data/sources");
	let s = |v: forge_guide::js::V| forge_guide::js::stringify(&v, None);
	let mut p = Planner::new(&texts, &s(forge_guide::solo::load_instances(&src)), &s(forge_guide::areas::load_areas(&src))).unwrap();
	let rels = forge_guide::project::find_guide_files(guides, false);
	let read = |f: &str| std::fs::read_to_string(guides.join(f)).ok();
	p.set_pack(Pack { manifest: read("pack.json").unwrap(), legs: read("legs.json"), retired: read("retired.json"), license: read("LICENSE"), translations: None, iface: String::new() }).unwrap();
	let files: Vec<(String, String, String)> = rels.iter().map(|r| (r.clone(), format!("guides/{r}"), std::fs::read_to_string(guides.join(r)).unwrap())).collect();
	p.set_guides(&files);
	let params = std::fs::read_to_string(sim.join("params.json")).ok();
	for f in ["Horde", "Alliance"] {
		p.set_world(f, &std::fs::read(sim.join(format!("world-{}.json", f.to_lowercase()))).unwrap(), params.as_deref()).unwrap();
	}
	p
}

fn native(guides: &Path, faction: &str, race: &str, to: f64) -> (f64, f64) {
	let (seed, sim) = (var("POLESTAR_SEED"), var("POLESTAR_SIM"));
	let world = forge_sim::load_world(&sim, forge_core::Faction::parse(faction).unwrap()).unwrap();
	let params: Option<serde_json::Value> = std::fs::read(sim.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
	let lv = SimLevels::new(&world, race, params.as_ref()).unwrap();
	let mut o = JudgeOpts::new(guides, faction, race, None, &seed);
	o.data_dir = seed.join("data/forever");
	o.to = to;
	let j = judge_walk(&o, &lv).unwrap();
	(j.walk.hours, j.walk.end_level)
}

#[test]
#[ignore = "needs POLESTAR_SEED and POLESTAR_SIM (local inputs)"]
fn planner_hours_equal_the_native_judge() {
	let seed = var("POLESTAR_SEED");
	let written = |k: &str| std::env::var(k).map(PathBuf::from).unwrap_or_default();
	for (name, guides, faction, race) in [
		("v1 Orc", seed.join("guides"), "Horde", "Orc"),
		("v1 Human", seed.join("guides"), "Alliance", "Human"),
		("written Orc", written("POLESTAR_WRITTEN_ORC"), "Horde", "Orc"),
		("written Human", written("POLESTAR_WRITTEN_HUMAN"), "Alliance", "Human"),
	] {
		let g = guides.as_path();
		if !g.join("forever").is_dir() {
			eprintln!("planner parity {name}: no guides, skipped");
			continue;
		}
		let t = planner(g).hours(&Character { faction: faction.into(), race: race.into(), cls: None }, None).unwrap();
		let (h30, _) = native(g, faction, race, 30.0);
		let (h60, end) = native(g, faction, race, 61.0);
		eprintln!("planner parity {name}: planner {:?} / {:?} h (level {:?}); native {h30:?} / {h60:?} h (level {end:?})", t.hours30.unwrap_or(f64::NAN), t.hours60, t.end_level);
		assert_eq!(t.hours30, Some(h30), "{name} hours to 30");
		assert_eq!(t.hours60, h60, "{name} hours to 60");
		assert_eq!(t.end_level, end, "{name} end level");
	}
}

/// The addon files the browser's pack_compile zips equal the native compile's (`build_pack`), for v1.
#[test]
#[ignore = "needs POLESTAR_SEED and POLESTAR_SIM (local inputs)"]
fn pack_files_equal_the_native_compile() {
	let seed = var("POLESTAR_SEED");
	let guides = seed.join("guides");
	let mut p = planner(&guides);
	let data_dir = seed.join("data/forever");
	let data = forge_guide::project::load_project_data(&data_dir, &mut forge_guide::diag::Diagnostics::new()).unwrap();
	let manifest = forge_guide::js::parse_json(&std::fs::read_to_string(guides.join("pack.json")).unwrap()).unwrap();
	let built = forge_guide::project::build_pack(&seed, &guides, &manifest, Vec::new(), &data, forge_guide::diag::Diagnostics::new(), false).unwrap();
	let project = forge_guide::project::compile_project(&guides, &manifest, &data, forge_guide::diag::Diagnostics::new(), false, None);
	let tr = forge_guide::i18n_guides::pack_translations(&guides, &manifest, &project.guides).unwrap();
	let read = |f: &str| std::fs::read_to_string(guides.join(f)).ok();
	p.set_pack(Pack {
		manifest: read("pack.json").unwrap(),
		legs: read("legs.json"),
		retired: read("retired.json"),
		license: read("LICENSE"),
		translations: Some(forge_guide::js::stringify(&tr.get("translations"), None)),
		iface: forge_guide::project::core_interface(&seed).unwrap(),
	})
	.unwrap();
	let spells: Vec<serde_json::Value> = forge_guide::tokens::read_spell_names(&data).into_iter().map(|(n, id)| serde_json::json!([n, id])).collect();
	p.set_spell_names(&serde_json::Value::Array(spells).to_string()).unwrap();
	let (ours, diags) = p.pack_files();
	let ours = ours.unwrap_or_else(|| panic!("browser compile failed: {:?}", diags.iter().filter(|d| d.severity == "error").map(|d| &d.message).collect::<Vec<_>>()));
	let native = built.files.expect("native compile failed");
	let key = |f: &[(String, forge_guide::project::FileContent)]| -> Vec<(String, Vec<u8>)> {
		f.iter()
			.map(|(n, c)| {
				(
					n.clone(),
					match c {
						forge_guide::project::FileContent::Text(t) => t.clone().into_bytes(),
						forge_guide::project::FileContent::Bytes(b) => b.clone(),
					},
				)
			})
			.collect()
	};
	let (a, b) = (key(&ours), key(&native));
	eprintln!(
		"pack parity: {} files browser, {} native; {} errors, {} warnings",
		a.len(),
		b.len(),
		diags.iter().filter(|d| d.severity == "error").count(),
		diags.iter().filter(|d| d.severity != "error").count()
	);
	assert_eq!(a.iter().map(|x| &x.0).collect::<Vec<_>>(), b.iter().map(|x| &x.0).collect::<Vec<_>>(), "file names");
	for (x, y) in a.iter().zip(&b) {
		if x.1 != y.1 {
			let at = x.1.iter().zip(&y.1).position(|(p, q)| p != q).unwrap_or(0);
			let ctx = |v: &[u8]| String::from_utf8_lossy(&v[at.saturating_sub(150)..(at + 150).min(v.len())]).into_owned();
			panic!("{} differs at byte {at}:\n browser: {}\n native:  {}", x.0, ctx(&x.1), ctx(&y.1));
		}
	}
}
