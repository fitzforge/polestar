//! Port of tools/lib/dsl/trainers.js (the part compile needs: CURATED, curatedTrainers).
//! Class trainers from the curated name list: capital and starting-town class trainers, and a few untitled
//! ones out in the world, resolved to npc ids by name on the expected map in npcs.json. `trainers build`
//! (guide and recorded sources, writing trainers.json) is a tool command, not part of the compiler.

use crate::data::Data;
use crate::js::V;
use crate::obj;

const SW: u32 = 1453;
const IF: u32 = 1455;
const DN: u32 = 1457;
const OG: u32 = 1454;
const TB: u32 = 1456;
const UC: u32 = 1458;
const ELWYNN: u32 = 1429;
const DUN_MOROGH: u32 = 1426;
const TELDRASSIL: u32 = 1438;
const DUROTAR: u32 = 1411;
const MULGORE: u32 = 1412;
const TIRISFAL: u32 = 1420;
const ZEPHRAS: u32 = 2521;
const BARRENS: u32 = 1413;

/// [classFile, name, uiMapID]
pub const CURATED: &[(&str, &str, u32)] = &[
	// Stormwind City
	("WARRIOR", "Wu Shen", SW),
	("WARRIOR", "Ilsa Corbin", SW),
	("PALADIN", "Lord Grayson Shadowbreaker", SW),
	("PALADIN", "Arthur the Faithful", SW),
	("PALADIN", "Katherine the Pure", SW),
	("PRIEST", "High Priestess Laurena", SW),
	("PRIEST", "Brother Benjamin", SW),
	("PRIEST", "Brother Joshua", SW),
	("ROGUE", "Osborne the Night Man", SW),
	("MAGE", "Jennea Cannon", SW),
	("MAGE", "Elsharin", SW),
	("WARLOCK", "Ursula Deline", SW),
	("WARLOCK", "Demisette Cloyce", SW),
	("WARLOCK", "Sandahl", SW),
	("HUNTER", "Einris Brightspear", SW),
	("HUNTER", "Ulfir Ironbeard", SW),
	("DRUID", "Sheldras Moontree", SW),
	// Elwynn Forest: Northshire and Goldshire
	("WARRIOR", "Llane Beshere", ELWYNN),
	("WARRIOR", "Lyria Du Lac", ELWYNN),
	("PALADIN", "Brother Sammuel", ELWYNN),
	("PALADIN", "Brother Wilhelm", ELWYNN),
	("PRIEST", "Priestess Anetta", ELWYNN),
	("PRIEST", "Priestess Josetta", ELWYNN),
	("ROGUE", "Jorik Kerridan", ELWYNN),
	("ROGUE", "Keryn Sylvius", ELWYNN),
	("MAGE", "Khelden Bremen", ELWYNN),
	("MAGE", "Zaldimar Wefhellt", ELWYNN),
	("WARLOCK", "Drusilla La Salle", ELWYNN),
	("WARLOCK", "Maximillian Crowe", ELWYNN),
	// Ironforge
	("WARRIOR", "Kelstrum Stonebreaker", IF),
	("WARRIOR", "Bilban Tosslespanner", IF),
	("PALADIN", "Brandur Ironhammer", IF),
	("PALADIN", "Beldruk Doombrow", IF),
	("PALADIN", "Valgar Highforge", IF),
	("PRIEST", "High Priest Rohan", IF),
	("PRIEST", "Braenna Flintcrag", IF),
	("PRIEST", "Theodrus Frostbeard", IF),
	("ROGUE", "Fenthwick", IF),
	("ROGUE", "Hulfdan Blackbeard", IF),
	("ROGUE", "Ormyr Flinteye", IF),
	("MAGE", "Dink", IF),
	("MAGE", "Bink", IF),
	("MAGE", "Juli Stormkettle", IF),
	("WARLOCK", "Alexander Calder", IF),
	("WARLOCK", "Thistleheart", IF),
	("HUNTER", "Daera Brightspear", IF),
	("HUNTER", "Olmin Burningbeard", IF),
	("HUNTER", "Regnus Thundergranite", IF),
	// Dun Morogh: Coldridge Valley and Kharanos
	("WARRIOR", "Thran Khorman", DUN_MOROGH),
	("WARRIOR", "Granis Swiftaxe", DUN_MOROGH),
	("PALADIN", "Bromos Grummner", DUN_MOROGH),
	("PALADIN", "Azar Stronghammer", DUN_MOROGH),
	("PRIEST", "Branstock Khalder", DUN_MOROGH),
	("PRIEST", "Maxan Anvol", DUN_MOROGH),
	("ROGUE", "Solm Hargrin", DUN_MOROGH),
	("ROGUE", "Hogral Bakkan", DUN_MOROGH),
	("HUNTER", "Thorgas Grimson", DUN_MOROGH),
	("HUNTER", "Grif Wildheart", DUN_MOROGH),
	("MAGE", "Marryk Nurribit", DUN_MOROGH),
	("MAGE", "Magis Sparkmantle", DUN_MOROGH),
	("WARLOCK", "Alamar Grimm", DUN_MOROGH),
	("WARLOCK", "Gimrizz Shadowcog", DUN_MOROGH),
	// Darnassus
	("WARRIOR", "Arias'ta Bladesinger", DN),
	("WARRIOR", "Sildanair", DN),
	("WARRIOR", "Darnath Bladesinger", DN),
	("HUNTER", "Jocaste", DN),
	("HUNTER", "Dorion", DN),
	("HUNTER", "Jeen'ra Nightrunner", DN),
	("ROGUE", "Syurna", DN),
	("ROGUE", "Anishar", DN),
	("ROGUE", "Erion Shadewhisper", DN),
	("PRIEST", "Jandria", DN),
	("PRIEST", "Lariia", DN),
	("PRIEST", "Astarii Starseeker", DN),
	("DRUID", "Mathrengyl Bearwalker", DN),
	("DRUID", "Denatharion", DN),
	("DRUID", "Fylerian Nightwing", DN),
	// Teldrassil: Shadowglen and Dolanaar
	("WARRIOR", "Alyissia", TELDRASSIL),
	("WARRIOR", "Kyra Windblade", TELDRASSIL),
	("HUNTER", "Ayanna Everstride", TELDRASSIL),
	("HUNTER", "Dazalar", TELDRASSIL),
	("ROGUE", "Frahun Shadewhisper", TELDRASSIL),
	("ROGUE", "Jannok Breezesong", TELDRASSIL),
	("PRIEST", "Shanda", TELDRASSIL),
	("PRIEST", "Laurna Morninglight", TELDRASSIL),
	("DRUID", "Mardant Strongoak", TELDRASSIL),
	("DRUID", "Kal", TELDRASSIL),
	// Orgrimmar
	("WARRIOR", "Sorek", OG),
	("WARRIOR", "Zel'mak", OG),
	("HUNTER", "Ormak Grimshot", OG),
	("HUNTER", "Xor'juul", OG),
	("HUNTER", "Sian'dur", OG),
	("ROGUE", "Ormok", OG),
	("ROGUE", "Shenthul", OG),
	("ROGUE", "Gest", OG),
	("SHAMAN", "Kardris Dreamseeker", OG),
	("SHAMAN", "Sagorne Creststrider", OG),
	("MAGE", "Pephredo", OG),
	("MAGE", "Deino", OG),
	("MAGE", "Uthel'nay", OG),
	("WARLOCK", "Zevrost", OG),
	("WARLOCK", "Mirket", OG),
	("WARLOCK", "Grol'dar", OG),
	("PRIEST", "Ur'kyo", OG),
	// Durotar: Valley of Trials and Razor Hill
	("WARRIOR", "Frang", DUROTAR),
	("WARRIOR", "Tarshaw Jaggedscar", DUROTAR),
	("HUNTER", "Jen'shan", DUROTAR),
	("HUNTER", "Thotar", DUROTAR),
	("ROGUE", "Rwag", DUROTAR),
	("ROGUE", "Kaplak", DUROTAR),
	("SHAMAN", "Shikrik", DUROTAR),
	("SHAMAN", "Swart", DUROTAR),
	("WARLOCK", "Nartok", DUROTAR),
	("WARLOCK", "Dhugru Gorelust", DUROTAR),
	("PRIEST", "Ken'jai", DUROTAR),
	("PRIEST", "Tai'jin", DUROTAR),
	("MAGE", "Mai'ah", DUROTAR),
	("MAGE", "Un'Thuwa", DUROTAR),
	// Thunder Bluff
	("WARRIOR", "Torm Ragetotem", TB),
	("WARRIOR", "Ker Ragetotem", TB),
	("WARRIOR", "Sark Ragetotem", TB),
	("HUNTER", "Holt Thunderhorn", TB),
	("HUNTER", "Urek Thunderhorn", TB),
	("HUNTER", "Kary Thunderhorn", TB),
	("SHAMAN", "Beram Skychaser", TB),
	("SHAMAN", "Siln Skychaser", TB),
	("SHAMAN", "Tigor Skychaser", TB),
	("DRUID", "Turak Runetotem", TB),
	("DRUID", "Sheal Runetotem", TB),
	("DRUID", "Kym Wildmane", TB),
	("PRIEST", "Miles Welsh", TB),
	("PRIEST", "Malakai Cross", TB),
	("PRIEST", "Father Cobb", TB),
	("MAGE", "Archmage Shymm", TB),
	("MAGE", "Ursyn Ghull", TB),
	("MAGE", "Thurston Xane", TB),
	// Mulgore: Camp Narache and Bloodhoof Village
	("WARRIOR", "Harutt Thunderhorn", MULGORE),
	("WARRIOR", "Krang Stonehoof", MULGORE),
	("HUNTER", "Lanka Farshot", MULGORE),
	("HUNTER", "Yaw Sharpmane", MULGORE),
	("SHAMAN", "Meela Dawnstrider", MULGORE),
	("SHAMAN", "Narm Skychaser", MULGORE),
	("DRUID", "Gart Mistrunner", MULGORE),
	("DRUID", "Gennia Runetotem", MULGORE),
	// Undercity
	("WARRIOR", "Christoph Walker", UC),
	("WARRIOR", "Angela Curthas", UC),
	("WARRIOR", "Baltus Fowler", UC),
	("PRIEST", "Father Lankester", UC),
	("PRIEST", "Father Lazarus", UC),
	("PRIEST", "Aelthalyste", UC),
	("ROGUE", "Carolyn Ward", UC),
	("ROGUE", "Miles Dexter", UC),
	("ROGUE", "Gregory Charles", UC),
	("MAGE", "Kaelystia Hatebringer", UC),
	("MAGE", "Pierce Shackleton", UC),
	("WARLOCK", "Kaal Soulreaper", UC),
	("WARLOCK", "Richard Kerwin", UC),
	("WARLOCK", "Luther Pickman", UC),
	// Tirisfal Glades: Deathknell and Brill
	("WARRIOR", "Dannal Stern", TIRISFAL),
	("WARRIOR", "Austil de Mon", TIRISFAL),
	("MAGE", "Isabella", TIRISFAL),
	("MAGE", "Cain Firesong", TIRISFAL),
	("PRIEST", "Dark Cleric Duesten", TIRISFAL),
	("PRIEST", "Dark Cleric Beryl", TIRISFAL),
	("ROGUE", "David Trias", TIRISFAL),
	("ROGUE", "Marion Call", TIRISFAL),
	("WARLOCK", "Maximillion", TIRISFAL),
	("WARLOCK", "Rupert Boch", TIRISFAL),
	// Forever's new race/class pairs and Skyborne (npcs from QuestieDB's Forever
	// store, class from the NPC's <… Trainer> tag in the web facts, 2026-10-12).
	("SHAMAN", "Eldrun Stormbreaker", IF),
	("SHAMAN", "Teo Hammerstorm", DUN_MOROGH),
	("SHAMAN", "Ingrid Dunwald", DUN_MOROGH),
	("PALADIN", "Garen Largo", UC),
	("PALADIN", "Aramis Hammerhand", TIRISFAL),
	("PALADIN", "Shari Stilwell", TIRISFAL),
	("PALADIN", "Hilda the Breaker", TIRISFAL),
	("PALADIN", "Alodan the Hopeful", TB),
	("HUNTER", "Tordrin Sternblade", ELWYNN),
	("HUNTER", "Josephine Carson", ELWYNN),
	// Capital and Mulgore class trainers the list above lacked: npcs.json's
	// <… Trainer> subName (pfQuest and QuestieDB's Forever store, 2026-10-15).
	("WARRIOR", "Ander Germaine", SW),
	("DRUID", "Theridran", SW),
	("DRUID", "Maldryn", SW),
	("HUNTER", "Thorfin Stoneshield", SW),
	("PRIEST", "Nara Meideros", SW),
	("ROGUE", "Lord Tony Romano", SW),
	("WARRIOR", "Kelv Sternhammer", IF),
	("PRIEST", "Toldren Deepiron", IF),
	("PRIEST", "High Priestess Mims", IF),
	("MAGE", "Nittlebur Sparkfizzle", IF),
	("WARLOCK", "Briarthorn", IF),
	("PRIEST", "Priestess Alathea", DN),
	("WARRIOR", "Grezz Ragefist", OG),
	("SHAMAN", "Sian'tsu", OG),
	("MAGE", "Enyo", OG),
	("PRIEST", "X'yera", OG),
	("MAGE", "Anastasia Hartwell", UC),
	("SHAMAN", "Palah Thunderhoof", MULGORE),
	("DRUID", "Hana Lighthoof", MULGORE),
	// Zephras Isle (Skyborne): Thendal Grove, Shen'dar Village, Valanaar.
	("WARRIOR", "Blademaster Ren", ZEPHRAS),
	("WARRIOR", "Seena Skybreaker", ZEPHRAS),
	("WARRIOR", "Corsan Earthrazer", ZEPHRAS),
	("HUNTER", "Tai'ree Farsight", ZEPHRAS),
	("HUNTER", "Quel'ana Quickgale", ZEPHRAS),
	("HUNTER", "Elayaa Easewind", ZEPHRAS),
	("ROGUE", "Akeri Duskblade", ZEPHRAS),
	("ROGUE", "Eltheen Nightbreeze", ZEPHRAS),
	("ROGUE", "Miriaan Mistblade", ZEPHRAS),
	("MAGE", "Dorii Brightwhisper", ZEPHRAS),
	("MAGE", "Anathamaas Aetherwind", ZEPHRAS),
	("MAGE", "Shenaan Spellwind", ZEPHRAS),
	("SHAMAN", "Windshaper Boro", ZEPHRAS),
	("SHAMAN", "Sessaria Skystride", ZEPHRAS),
	("SHAMAN", "Aarnor Galestrike", ZEPHRAS),
	("DRUID", "Xyton Silverwind", ZEPHRAS),
	("DRUID", "Lotheluum Starbreeze", ZEPHRAS),
	("DRUID", "Naeluna Swiftmend", ZEPHRAS),
	// Trainers with no <… Trainer> tag, seen training in the game.
	("WARLOCK", "Strahad Farsan", BARRENS),
];

fn name_key(s: &V) -> String {
	s.to_js_string().trim().to_lowercase()
}

/// One curated trainer: { id, name, classes (Set order), sources (Set order) }.
pub struct TrainerEntry {
	pub id: V,
	pub name: V,
	pub classes: Vec<String>,
	pub sources: Vec<String>,
}

/// `curatedTrainers(data)`: entries in Map insertion order, and the unverified [class, name, map] rows.
pub fn curated_trainers(data: &Data) -> (Vec<TrainerEntry>, Vec<(&'static str, &'static str, u32)>) {
	let mut by_name: Vec<(String, Vec<V>)> = Vec::new();
	let mut index: rustc_hash::FxHashMap<String, usize> = Default::default();
	for n in data.npcs.values() {
		if !n.truthy() || !n.get("name").truthy() {
			continue;
		}
		let k = name_key(&n.get("name"));
		match index.get(&k) {
			Some(&i) => by_name[i].1.push(n),
			None => {
				index.insert(k.clone(), by_name.len());
				by_name.push((k, vec![n]));
			}
		}
	}
	let mut entries: Vec<TrainerEntry> = Vec::new();
	let mut unverified = Vec::new();
	for &(cls, name, map) in CURATED {
		let mut hits: Vec<V> = index
			.get(&name_key(&V::str(name)))
			.map(|&i| by_name[i].1.clone())
			.unwrap_or_default()
			.into_iter()
			.filter(|n| n.get("spawns").truthy() && n.get("spawns").get(&map.to_string()).truthy())
			.collect();
		hits.sort_by(|a, b| {
			let d = a.get("id").num() - b.get("id").num();
			if d < 0.0 {
				std::cmp::Ordering::Less
			} else if d > 0.0 {
				std::cmp::Ordering::Greater
			} else {
				std::cmp::Ordering::Equal
			}
		});
		if hits.is_empty() {
			unverified.push((cls, name, map));
			continue;
		}
		add(&mut entries, hits[0].get("id"), hits[0].get("name"), cls, "curated");
	}
	(entries, unverified)
}

fn add(entries: &mut Vec<TrainerEntry>, id: V, name: V, cls: &str, source: &str) {
	let i = match entries.iter().position(|e| e.id.strict_eq(&id)) {
		Some(i) => i,
		None => {
			entries.push(TrainerEntry { id, name: V::Undef, classes: Vec::new(), sources: Vec::new() });
			entries.len() - 1
		}
	};
	let e = &mut entries[i];
	if !e.name.truthy() && name.truthy() {
		e.name = name;
	}
	if !e.classes.iter().any(|c| c == cls) {
		e.classes.push(cls.to_string());
	}
	if !e.sources.iter().any(|s| s == source) {
		e.sources.push(source.to_string());
	}
}

/// `[...curatedTrainers(data).entries.values()].map((e) => ({ id: e.id, classes: [...e.classes] }))`.
pub fn curated_trainer_list(data: &Data) -> Vec<V> {
	curated_trainers(data)
		.0
		.into_iter()
		.map(|e| {
			let classes: Vec<V> = e.classes.iter().map(|c| V::str(c)).collect();
			obj! { "id" => e.id, "classes" => classes }.into()
		})
		.collect()
}
