//! Class trainers (port of tools/lib/dsl/trainers.js buildTrainers and tools/commands/trainers.js):
//! data/forever/trainers.json from the curated name list (resolved against npcs.json), every
//! `train <npcId> only <Class>` goal under guides/, and recorded trainer visits; plus
//! addon/Polestar/Core/ClassTrainers.lua.

use std::path::Path;

use forge_guide::data::Data;
use forge_guide::js::{stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};

/// [classFile, name, uiMapID] (tools/lib/dsl/trainers.js CURATED, same order).
const CURATED: &[(&str, &str, i64)] = &[
	("WARRIOR", "Wu Shen", 1453),
	("WARRIOR", "Ilsa Corbin", 1453),
	("PALADIN", "Lord Grayson Shadowbreaker", 1453),
	("PALADIN", "Arthur the Faithful", 1453),
	("PALADIN", "Katherine the Pure", 1453),
	("PRIEST", "High Priestess Laurena", 1453),
	("PRIEST", "Brother Benjamin", 1453),
	("PRIEST", "Brother Joshua", 1453),
	("ROGUE", "Osborne the Night Man", 1453),
	("MAGE", "Jennea Cannon", 1453),
	("MAGE", "Elsharin", 1453),
	("WARLOCK", "Ursula Deline", 1453),
	("WARLOCK", "Demisette Cloyce", 1453),
	("WARLOCK", "Sandahl", 1453),
	("HUNTER", "Einris Brightspear", 1453),
	("HUNTER", "Ulfir Ironbeard", 1453),
	("DRUID", "Sheldras Moontree", 1453),
	("WARRIOR", "Llane Beshere", 1429),
	("WARRIOR", "Lyria Du Lac", 1429),
	("PALADIN", "Brother Sammuel", 1429),
	("PALADIN", "Brother Wilhelm", 1429),
	("PRIEST", "Priestess Anetta", 1429),
	("PRIEST", "Priestess Josetta", 1429),
	("ROGUE", "Jorik Kerridan", 1429),
	("ROGUE", "Keryn Sylvius", 1429),
	("MAGE", "Khelden Bremen", 1429),
	("MAGE", "Zaldimar Wefhellt", 1429),
	("WARLOCK", "Drusilla La Salle", 1429),
	("WARLOCK", "Maximillian Crowe", 1429),
	("WARRIOR", "Kelstrum Stonebreaker", 1455),
	("WARRIOR", "Bilban Tosslespanner", 1455),
	("PALADIN", "Brandur Ironhammer", 1455),
	("PALADIN", "Beldruk Doombrow", 1455),
	("PALADIN", "Valgar Highforge", 1455),
	("PRIEST", "High Priest Rohan", 1455),
	("PRIEST", "Braenna Flintcrag", 1455),
	("PRIEST", "Theodrus Frostbeard", 1455),
	("ROGUE", "Fenthwick", 1455),
	("ROGUE", "Hulfdan Blackbeard", 1455),
	("ROGUE", "Ormyr Flinteye", 1455),
	("MAGE", "Dink", 1455),
	("MAGE", "Bink", 1455),
	("MAGE", "Juli Stormkettle", 1455),
	("WARLOCK", "Alexander Calder", 1455),
	("WARLOCK", "Thistleheart", 1455),
	("HUNTER", "Daera Brightspear", 1455),
	("HUNTER", "Olmin Burningbeard", 1455),
	("HUNTER", "Regnus Thundergranite", 1455),
	("WARRIOR", "Thran Khorman", 1426),
	("WARRIOR", "Granis Swiftaxe", 1426),
	("PALADIN", "Bromos Grummner", 1426),
	("PALADIN", "Azar Stronghammer", 1426),
	("PRIEST", "Branstock Khalder", 1426),
	("PRIEST", "Maxan Anvol", 1426),
	("ROGUE", "Solm Hargrin", 1426),
	("ROGUE", "Hogral Bakkan", 1426),
	("HUNTER", "Thorgas Grimson", 1426),
	("HUNTER", "Grif Wildheart", 1426),
	("MAGE", "Marryk Nurribit", 1426),
	("MAGE", "Magis Sparkmantle", 1426),
	("WARLOCK", "Alamar Grimm", 1426),
	("WARLOCK", "Gimrizz Shadowcog", 1426),
	("WARRIOR", "Arias'ta Bladesinger", 1457),
	("WARRIOR", "Sildanair", 1457),
	("WARRIOR", "Darnath Bladesinger", 1457),
	("HUNTER", "Jocaste", 1457),
	("HUNTER", "Dorion", 1457),
	("HUNTER", "Jeen'ra Nightrunner", 1457),
	("ROGUE", "Syurna", 1457),
	("ROGUE", "Anishar", 1457),
	("ROGUE", "Erion Shadewhisper", 1457),
	("PRIEST", "Jandria", 1457),
	("PRIEST", "Lariia", 1457),
	("PRIEST", "Astarii Starseeker", 1457),
	("DRUID", "Mathrengyl Bearwalker", 1457),
	("DRUID", "Denatharion", 1457),
	("DRUID", "Fylerian Nightwing", 1457),
	("WARRIOR", "Alyissia", 1438),
	("WARRIOR", "Kyra Windblade", 1438),
	("HUNTER", "Ayanna Everstride", 1438),
	("HUNTER", "Dazalar", 1438),
	("ROGUE", "Frahun Shadewhisper", 1438),
	("ROGUE", "Jannok Breezesong", 1438),
	("PRIEST", "Shanda", 1438),
	("PRIEST", "Laurna Morninglight", 1438),
	("DRUID", "Mardant Strongoak", 1438),
	("DRUID", "Kal", 1438),
	("WARRIOR", "Sorek", 1454),
	("WARRIOR", "Zel'mak", 1454),
	("HUNTER", "Ormak Grimshot", 1454),
	("HUNTER", "Xor'juul", 1454),
	("HUNTER", "Sian'dur", 1454),
	("ROGUE", "Ormok", 1454),
	("ROGUE", "Shenthul", 1454),
	("ROGUE", "Gest", 1454),
	("SHAMAN", "Kardris Dreamseeker", 1454),
	("SHAMAN", "Sagorne Creststrider", 1454),
	("MAGE", "Pephredo", 1454),
	("MAGE", "Deino", 1454),
	("MAGE", "Uthel'nay", 1454),
	("WARLOCK", "Zevrost", 1454),
	("WARLOCK", "Mirket", 1454),
	("WARLOCK", "Grol'dar", 1454),
	("PRIEST", "Ur'kyo", 1454),
	("WARRIOR", "Frang", 1411),
	("WARRIOR", "Tarshaw Jaggedscar", 1411),
	("HUNTER", "Jen'shan", 1411),
	("HUNTER", "Thotar", 1411),
	("ROGUE", "Rwag", 1411),
	("ROGUE", "Kaplak", 1411),
	("SHAMAN", "Shikrik", 1411),
	("SHAMAN", "Swart", 1411),
	("WARLOCK", "Nartok", 1411),
	("WARLOCK", "Dhugru Gorelust", 1411),
	("PRIEST", "Ken'jai", 1411),
	("PRIEST", "Tai'jin", 1411),
	("MAGE", "Mai'ah", 1411),
	("MAGE", "Un'Thuwa", 1411),
	("WARRIOR", "Torm Ragetotem", 1456),
	("WARRIOR", "Ker Ragetotem", 1456),
	("WARRIOR", "Sark Ragetotem", 1456),
	("HUNTER", "Holt Thunderhorn", 1456),
	("HUNTER", "Urek Thunderhorn", 1456),
	("HUNTER", "Kary Thunderhorn", 1456),
	("SHAMAN", "Beram Skychaser", 1456),
	("SHAMAN", "Siln Skychaser", 1456),
	("SHAMAN", "Tigor Skychaser", 1456),
	("DRUID", "Turak Runetotem", 1456),
	("DRUID", "Sheal Runetotem", 1456),
	("DRUID", "Kym Wildmane", 1456),
	("PRIEST", "Miles Welsh", 1456),
	("PRIEST", "Malakai Cross", 1456),
	("PRIEST", "Father Cobb", 1456),
	("MAGE", "Archmage Shymm", 1456),
	("MAGE", "Ursyn Ghull", 1456),
	("MAGE", "Thurston Xane", 1456),
	("WARRIOR", "Harutt Thunderhorn", 1412),
	("WARRIOR", "Krang Stonehoof", 1412),
	("HUNTER", "Lanka Farshot", 1412),
	("HUNTER", "Yaw Sharpmane", 1412),
	("SHAMAN", "Meela Dawnstrider", 1412),
	("SHAMAN", "Narm Skychaser", 1412),
	("DRUID", "Gart Mistrunner", 1412),
	("DRUID", "Gennia Runetotem", 1412),
	("WARRIOR", "Christoph Walker", 1458),
	("WARRIOR", "Angela Curthas", 1458),
	("WARRIOR", "Baltus Fowler", 1458),
	("PRIEST", "Father Lankester", 1458),
	("PRIEST", "Father Lazarus", 1458),
	("PRIEST", "Aelthalyste", 1458),
	("ROGUE", "Carolyn Ward", 1458),
	("ROGUE", "Miles Dexter", 1458),
	("ROGUE", "Gregory Charles", 1458),
	("MAGE", "Kaelystia Hatebringer", 1458),
	("MAGE", "Pierce Shackleton", 1458),
	("WARLOCK", "Kaal Soulreaper", 1458),
	("WARLOCK", "Richard Kerwin", 1458),
	("WARLOCK", "Luther Pickman", 1458),
	("WARRIOR", "Dannal Stern", 1420),
	("WARRIOR", "Austil de Mon", 1420),
	("MAGE", "Isabella", 1420),
	("MAGE", "Cain Firesong", 1420),
	("PRIEST", "Dark Cleric Duesten", 1420),
	("PRIEST", "Dark Cleric Beryl", 1420),
	("ROGUE", "David Trias", 1420),
	("ROGUE", "Marion Call", 1420),
	("WARLOCK", "Maximillion", 1420),
	("WARLOCK", "Rupert Boch", 1420),
	("SHAMAN", "Eldrun Stormbreaker", 1455),
	("SHAMAN", "Teo Hammerstorm", 1426),
	("SHAMAN", "Ingrid Dunwald", 1426),
	("PALADIN", "Garen Largo", 1458),
	("PALADIN", "Aramis Hammerhand", 1420),
	("PALADIN", "Shari Stilwell", 1420),
	("PALADIN", "Hilda the Breaker", 1420),
	("PALADIN", "Alodan the Hopeful", 1456),
	("HUNTER", "Tordrin Sternblade", 1429),
	("HUNTER", "Josephine Carson", 1429),
	("WARRIOR", "Ander Germaine", 1453),
	("DRUID", "Theridran", 1453),
	("DRUID", "Maldryn", 1453),
	("HUNTER", "Thorfin Stoneshield", 1453),
	("PRIEST", "Nara Meideros", 1453),
	("ROGUE", "Lord Tony Romano", 1453),
	("WARRIOR", "Kelv Sternhammer", 1455),
	("PRIEST", "Toldren Deepiron", 1455),
	("PRIEST", "High Priestess Mims", 1455),
	("MAGE", "Nittlebur Sparkfizzle", 1455),
	("WARLOCK", "Briarthorn", 1455),
	("PRIEST", "Priestess Alathea", 1457),
	("WARRIOR", "Grezz Ragefist", 1454),
	("SHAMAN", "Sian'tsu", 1454),
	("MAGE", "Enyo", 1454),
	("PRIEST", "X'yera", 1454),
	("MAGE", "Anastasia Hartwell", 1458),
	("SHAMAN", "Palah Thunderhoof", 1412),
	("DRUID", "Hana Lighthoof", 1412),
	("WARRIOR", "Blademaster Ren", 2521),
	("WARRIOR", "Seena Skybreaker", 2521),
	("WARRIOR", "Corsan Earthrazer", 2521),
	("HUNTER", "Tai'ree Farsight", 2521),
	("HUNTER", "Quel'ana Quickgale", 2521),
	("HUNTER", "Elayaa Easewind", 2521),
	("ROGUE", "Akeri Duskblade", 2521),
	("ROGUE", "Eltheen Nightbreeze", 2521),
	("ROGUE", "Miriaan Mistblade", 2521),
	("MAGE", "Dorii Brightwhisper", 2521),
	("MAGE", "Anathamaas Aetherwind", 2521),
	("MAGE", "Shenaan Spellwind", 2521),
	("SHAMAN", "Windshaper Boro", 2521),
	("SHAMAN", "Sessaria Skystride", 2521),
	("SHAMAN", "Aarnor Galestrike", 2521),
	("DRUID", "Xyton Silverwind", 2521),
	("DRUID", "Lotheluum Starbreeze", 2521),
	("DRUID", "Naeluna Swiftmend", 2521),
	("WARLOCK", "Strahad Farsan", 1413),
];

const CLASS_FILES: [&str; 9] = ["WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"];

struct Entry {
	name: V,
	classes: IndexSet<String>,
	sources: IndexSet<&'static str>,
}

fn add(entries: &mut IndexMap<i64, Entry>, id: i64, name: V, cls: &str, source: &'static str) {
	let e = entries.entry(id).or_insert_with(|| Entry { name: V::Null, classes: IndexSet::new(), sources: IndexSet::new() });
	if !e.name.truthy() && name.truthy() {
		e.name = name;
	}
	e.classes.insert(cls.to_string());
	e.sources.insert(source);
}

fn name_key(s: &str) -> String {
	s.trim_matches(|c: char| c.is_whitespace() || c == '\u{feff}').to_lowercase()
}

/// Every npc a profession lists (trainers, book vendors, quest givers).
fn profession_npcs(data: &Data) -> IndexSet<i64> {
	let mut out = IndexSet::new();
	let mut add = |sides: &V| {
		for list in sides.values() {
			if list.is_arr() {
				for id in list.items() {
					out.insert(id.num() as i64);
				}
			}
		}
	};
	for p in data.professions.values() {
		add(&p.get("trainers"));
		for r in p.get("ranks").items() {
			add(&r.get("trainers"));
			if r.get("book").truthy() {
				add(&r.get("book").get("vendors"));
			}
			if r.get("quest").truthy() {
				add(&r.get("quest").get("npcs"));
			}
		}
	}
	out
}

pub struct Report {
	pub curated: usize,
	pub guide: usize,
	pub record: usize,
	pub unverified: Vec<(String, String, i64)>,
}

fn list_files(dir: &Path, ext: &str) -> Vec<std::path::PathBuf> {
	let mut out = Vec::new();
	fn walk(d: &Path, ext: &str, out: &mut Vec<std::path::PathBuf>) {
		let Ok(rd) = std::fs::read_dir(d) else { return };
		let mut es: Vec<_> = rd.flatten().collect();
		es.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.file_name().to_string_lossy(), &b.file_name().to_string_lossy()));
		for e in es {
			let name = e.file_name().to_string_lossy().to_string();
			if name.starts_with('.') {
				continue;
			}
			let p = e.path();
			let ft = e.file_type();
			if ft.as_ref().is_ok_and(|t| t.is_dir()) {
				walk(&p, ext, out);
			} else if ft.as_ref().is_ok_and(|t| t.is_file()) && name.ends_with(ext) {
				out.push(p);
			}
		}
	}
	if dir.exists() {
		walk(dir, ext, &mut out);
	}
	out
}

/// trainers.json's object and the counts.
pub fn build_trainers(data: &Data, guides: Option<&Path>, recordings: &Path) -> (Obj, Report) {
	let mut by_name: IndexMap<String, Vec<V>> = IndexMap::new();
	for n in data.npcs.values() {
		if !n.truthy() || !n.get("name").truthy() {
			continue;
		}
		by_name.entry(name_key(&n.get("name").to_js_string())).or_default().push(n);
	}
	let mut entries: IndexMap<i64, Entry> = IndexMap::new();
	let mut unverified = Vec::new();
	for &(cls, name, map) in CURATED {
		let mut hits: Vec<V> = by_name.get(&name_key(name)).cloned().unwrap_or_default().into_iter().filter(|n| n.get("spawns").truthy() && n.get("spawns").get(&map.to_string()).truthy()).collect();
		hits.sort_by(|a, b| a.get("id").num().partial_cmp(&b.get("id").num()).unwrap());
		let Some(h) = hits.first() else {
			unverified.push((cls.to_string(), name.to_string(), map));
			continue;
		};
		add(&mut entries, h.get("id").num() as i64, h.get("name"), cls, "curated");
	}
	let curated = entries.len();
	let mut guide = 0;
	if let Some(dir) = guides {
		for rel in forge_guide::project::find_guide_files(dir, false) {
			let file = dir.join(&rel);
			let Ok(text) = std::fs::read_to_string(&file) else { continue };
			let mut diag = forge_guide::diag::Diagnostics::new();
			let ast = forge_guide::parse::parse_guide(&text, &file.to_string_lossy(), &mut diag);
			if !ast.truthy() {
				continue;
			}
			let hc = ast.get("header").get("classes");
			for st in ast.get("steps").items() {
				for g in st.get("goals").items() {
					if g.get("verb").as_str() != Some("train") || g.get("npc").is_undef() {
						continue;
					}
					let gc = g.get("only").get("classes");
					let sc = st.get("only").get("classes");
					let classes = if gc.truthy() {
						gc
					} else if sc.truthy() {
						sc
					} else {
						hc.clone()
					};
					if !classes.truthy() || classes.len() != 1 {
						continue;
					}
					let n = data.npc(&g.get("npc"));
					let name = if n.truthy() && n.get("name").truthy() { n.get("name") } else { g.get("npcName") };
					add(&mut entries, g.get("npc").num() as i64, name, &classes.at(0).to_js_string(), "guide");
					guide += 1;
				}
			}
		}
	}
	let profession = profession_npcs(data);
	let mut seen: IndexMap<i64, (V, IndexSet<String>)> = IndexMap::new();
	for file in list_files(recordings, ".json") {
		let Ok(text) = std::fs::read_to_string(&file) else { continue };
		let Ok(rec) = forge_guide::js::parse_json(&text) else { continue };
		let ch = rec.get("char");
		let cls = if rec.truthy() && ch.truthy() {
			let c = ch.get("class");
			(if c.truthy() { c.to_js_string() } else { String::new() }).to_uppercase()
		} else {
			String::new()
		};
		if !CLASS_FILES.contains(&cls.as_str()) || !rec.get("events").is_arr() {
			continue;
		}
		for ev in rec.get("events").items() {
			if !ev.truthy() || ev.get("e").as_str() != Some("trainer") || !(ev.get("npc").num() > 0.0) {
				continue;
			}
			let id = ev.get("npc").num() as i64;
			seen.entry(id).or_insert_with(|| (ev.get("npcName"), IndexSet::new())).1.insert(cls.clone());
		}
	}
	let mut record = 0;
	let mut ids: Vec<i64> = seen.keys().copied().collect();
	ids.sort();
	for id in ids {
		let (name, classes) = &seen[&id];
		if classes.len() != 1 || profession.contains(&id) {
			continue;
		}
		let n = data.npc(&V::Num(id as f64));
		let nm = if n.truthy() && n.get("name").truthy() { n.get("name") } else { name.clone() };
		add(&mut entries, id, nm, &classes[0], "record");
		record += 1;
	}
	let out = Obj::new();
	let mut keys: Vec<i64> = entries.keys().copied().collect();
	keys.sort();
	for id in keys {
		let e = &entries[&id];
		let o = Obj::new();
		o.set("id", id as f64);
		o.set("name", if e.name.truthy() { e.name.clone() } else { V::Null });
		o.set("classes", V::from(CLASS_FILES.iter().filter(|c| e.classes.contains(**c)).map(|c| V::str(c)).collect::<Vec<_>>()));
		o.set("sources", V::from(["curated", "guide", "record"].iter().filter(|x| e.sources.contains(**x)).map(|c| V::str(c)).collect::<Vec<_>>()));
		out.set(&id.to_string(), o);
	}
	(out, Report { curated, guide, record, unverified })
}

/// trainers.json's text.
pub fn trainers_json(t: &Obj) -> String {
	format!("{}\n", stringify(&V::Obj(t.clone()), Some("\t")))
}

/// Core/ClassTrainers.lua (tools/commands/trainers.js classTrainersLua): one trainer per town and
/// class with their frames, and every class trainer's id by class.
pub fn class_trainers_lua(data: &Data, trainers: &Obj) -> (String, usize, usize) {
	let entries: Vec<V> = trainers
		.values()
		.iter()
		.map(|t| {
			let o = Obj::new();
			o.set("npc", t.get("id"));
			o.set("classes", t.get("classes"));
			V::Obj(o)
		})
		.collect();
	let opts = Obj::new();
	opts.set("sides", V::from(vec![V::str("Alliance"), V::str("Horde")]));
	opts.set("ref", V::Null);
	let res = forge_guide::candidates::build_candidates(data, &entries, &V::Obj(opts));
	let candidates = res.get("candidates").items();
	let frames = Obj::new();
	for c in &candidates {
		let fr = data.era_frame(&c.get("map"));
		if fr.truthy() {
			let o = Obj::new();
			for k in ["c", "left", "right", "top", "bottom"] {
				o.set(k, fr.get(k));
			}
			frames.set(&c.get("map").to_js_string(), o);
		}
	}
	let mut sorted = candidates.clone();
	sorted.sort_by(|a, b| {
		let d = a.get("npc").num() - b.get("npc").num();
		let d = if d != 0.0 { d } else { a.get("map").num() - b.get("map").num() };
		d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
	});
	let by_class = Obj::new();
	for t in trainers.values() {
		for c in t.get("classes").items() {
			let k = c.to_js_string();
			if !by_class.has(&k) {
				by_class.set(&k, V::arr());
			}
			by_class.get(&k).push(t.get("id"));
		}
	}
	for (k, v) in by_class.entries() {
		let mut items = v.items();
		items.sort_by(|a, b| a.num().partial_cmp(&b.num()).unwrap());
		by_class.set(&k, V::from(items));
	}
	let lua = forge_guide::emit::emit_class_trainers(&sorted, &V::Obj(frames), &V::Obj(by_class));
	(lua, sorted.len(), trainers.len())
}

/// `trainers build`: (trainers.json text, Core/ClassTrainers.lua text, report) from data/forever
/// (`data`, after `build` wrote npcs.json and the rest), the guide pack and the recordings.
pub fn run(data_dir: &Path, guides: Option<&Path>, recordings: &Path) -> Result<(String, String, Report), String> {
	let data = forge_guide::data::load_data(data_dir)?;
	let (t, report) = build_trainers(&data, guides, recordings);
	let (lua, _, _) = class_trainers_lua(&data, &t);
	Ok((trainers_json(&t), lua, report))
}
