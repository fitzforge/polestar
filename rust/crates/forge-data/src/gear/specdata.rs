//! tools/lib/gear/specdata.js: addon/Polestar/Gear/SpecData.lua, stat weight bands per spec and
//! level (Polestar's authored weights blended with wowsims) and racial gear traits (gear/racials.rs).

use std::path::Path;

use forge_guide::js::{cmp_utf16, json_quote, num_str, stringify, Arr, Obj, V};

use super::racials::Racials;
use super::wowsims::{Entry, Wowsims};
use crate::jsv::math_round;

struct Band {
	up_to: f64,
	sim: Option<f64>,
	alpha: f64,
}

const BANDS: [Band; 5] = [
	Band { up_to: 24.0, sim: None, alpha: 1.0 },
	Band { up_to: 39.0, sim: Some(25.0), alpha: 0.5 },
	Band { up_to: 49.0, sim: Some(40.0), alpha: 0.5 },
	Band { up_to: 59.0, sim: Some(50.0), alpha: 0.5 },
	Band { up_to: 60.0, sim: Some(60.0), alpha: 0.25 },
];

const STAT_KEYS: [&str; 31] = [
	"str",
	"agi",
	"sta",
	"int",
	"spi",
	"armor",
	"health",
	"mana",
	"ap",
	"rap",
	"sp",
	"spArcane",
	"spFire",
	"spFrost",
	"spHoly",
	"spNature",
	"spShadow",
	"heal",
	"crit",
	"hit",
	"spellCrit",
	"spellHit",
	"mp5",
	"hp5",
	"defense",
	"dodge",
	"parry",
	"block",
	"blockValue",
	"dps",
	"rdps",
];

fn phase_label(p: &str) -> &str {
	match p {
		"sod-p1" => "SoD phase 1",
		"sod-p2" => "SoD phase 2",
		"sod-p3" => "SoD phase 3",
		"sod-latest" => "SoD level 60",
		"era" => "Classic Era",
		_ => p,
	}
}

/// The authored tables, read by running Weights.lua itself: { weights, classes }.
pub fn authored_weights(weights_lua: &Path) -> Result<V, String> {
	let mut path = String::new();
	json_quote(&mut path, &weights_lua.to_string_lossy());
	crate::lua::lua_to_value(
		&[],
		"local ns = { Gear = {} }; __ns = ns",
		&format!("local chunk = assert(loadfile({path}))\nchunk(\"Polestar\", __ns)\nreturn {{ weights = __ns.Gear.WEIGHTS, classes = __ns.Gear.CLASSES }}"),
	)
}

fn sim_for(entries: Option<&[Entry]>, level: f64) -> Option<&Entry> {
	let at: Vec<&Entry> = entries.unwrap_or(&[]).iter().filter(|e| e.level == level).collect();
	if at.is_empty() {
		return None;
	}
	if level == 60.0 {
		return at.iter().find(|e| e.phase == "era" && e.origin == "era").or_else(|| at.iter().find(|e| e.phase == "era")).or(at.first()).copied();
	}
	Some(at[0])
}

fn round(n: f64) -> f64 {
	math_round(n * 1000.0) / 1000.0
}

/// `(x || 0)` for a weight.
fn or0(v: &V) -> f64 {
	if v.truthy() {
		v.num()
	} else {
		0.0
	}
}

fn blend(authored: &V, sim: &Entry, alpha: f64) -> Option<Obj> {
	let main = sim.normalized_to.as_str();
	let a_main = authored.get(main);
	let scale = if a_main.num() > 0.0 { a_main.num() / sim.weights.get(main).filter(|w| *w != 0.0 && !w.is_nan()).unwrap_or(1.0) } else { return None };
	if scale == 0.0 || scale.is_nan() {
		return None;
	}
	let mut keys: Vec<String> = authored.keys().iter().map(|k| k.to_string()).collect();
	for (k, _) in &sim.weights.0 {
		if !keys.contains(k) {
			keys.push(k.clone());
		}
	}
	keys.sort_by(|a, b| cmp_utf16(a, b));
	let out = Obj::new();
	for k in keys {
		if !STAT_KEYS.contains(&k.as_str()) {
			continue;
		}
		let s = sim.weights.get(&k).filter(|w| *w != 0.0 && !w.is_nan()).unwrap_or(0.0);
		let v = alpha * or0(&authored.get(&k)) + (1.0 - alpha) * s * scale;
		if v > 0.0 {
			out.set(&k, V::Num(round(v)));
		}
	}
	Some(out)
}

pub struct BandRec {
	pub up_to: f64,
	pub weights: Obj,
	pub source: String,
	pub label: String,
	pub note: String,
}

/// class -> spec -> bands, in the authored order (emission sorts).
pub type Bands = Vec<(String, Vec<(String, Vec<BandRec>)>)>;

/// weightBands(wowsims, authored) -> (bands, counts).
pub fn weight_bands(wowsims: Option<&Wowsims>, authored: &V) -> (Bands, V) {
	let mut out: Bands = Vec::new();
	let (mut specs_n, mut sim_bands, mut authored_only) = (0usize, 0usize, 0usize);
	let by_sim = Obj::new();
	for (cls, specs) in authored.get("weights").entries() {
		for (spec, base) in specs.entries() {
			let entries = wowsims.and_then(|w| w.entries(&cls, &spec));
			let mut list: Vec<BandRec> = Vec::new();
			for band in &BANDS {
				let sim = band.sim.and_then(|l| sim_for(entries, l));
				let w = sim.and_then(|s| blend(&base, s, band.alpha).map(|w| (s, w)));
				let rec = if let Some((sim, w)) = w {
					let phase = phase_label(sim.phase);
					let rec = BandRec {
						up_to: band.up_to,
						weights: w,
						source: format!("wowsims:{}@{}:{}", sim.repo, &sim.commit[..9], sim.file),
						label: format!("Polestar leveling {}% + wowsims {phase} {}%", num_str(math_round(band.alpha * 100.0)), num_str(math_round((1.0 - band.alpha) * 100.0))),
						note: if sim.rune_influenced() {
							"Simulated with Season of Discovery runes; Forever has none, so the sim share is directional.".into()
						} else {
							"Simulated for Classic Era; Forever may have retuned the class.".into()
						},
					};
					sim_bands += 1;
					let key = format!("{cls}.{spec}");
					let prev = by_sim.get(&key);
					let arr = Arr::from_vec(prev.items());
					arr.push(V::str(&format!("{}:{}", num_str(band.up_to), sim.phase)));
					by_sim.set(&key, V::Arr(arr));
					rec
				} else {
					let mut sorted: Vec<String> = base.keys().iter().map(|k| k.to_string()).collect();
					sorted.sort_by(|a, b| cmp_utf16(a, b));
					let w2 = Obj::new();
					for k in sorted {
						w2.set(&k, base.get(&k));
					}
					authored_only += 1;
					BandRec { up_to: band.up_to, weights: w2, source: "polestar".into(), label: "Polestar leveling".into(), note: "Authored from Classic stat formulas; no sim for this band.".into() }
				};
				match list.last_mut() {
					Some(prev) if prev.source == rec.source && stringify(&V::Obj(prev.weights.clone()), None) == stringify(&V::Obj(rec.weights.clone()), None) => prev.up_to = rec.up_to,
					_ => list.push(rec),
				}
			}
			let c = match out.iter_mut().position(|c| c.0 == *cls) {
				Some(i) => i,
				None => {
					out.push((cls.to_string(), Vec::new()));
					out.len() - 1
				}
			};
			out[c].1.push((spec.to_string(), list));
			specs_n += 1;
		}
	}
	let counts = Obj::new();
	counts.set("specs", V::Num(specs_n as f64));
	counts.set("simBands", V::Num(sim_bands as f64));
	counts.set("authoredOnly", V::Num(authored_only as f64));
	counts.set("bySim", V::Obj(by_sim));
	(out, V::Obj(counts))
}

fn lua(v: &V) -> String {
	match v {
		V::Null | V::Undef => "nil".into(),
		V::Num(n) => num_str(*n),
		V::Bool(b) => b.to_string(),
		V::Str(s) => {
			let mut q = String::new();
			json_quote(&mut q, s);
			q.replace("\\u00b7", "\\194\\183")
		}
		V::Arr(a) => format!("{{ {} }}", a.to_vec().iter().map(lua).collect::<Vec<_>>().join(", ")),
		V::Obj(o) => {
			let parts: Vec<String> = o
				.entries()
				.iter()
				.map(|(k, v)| {
					let ident = k.chars().next().is_some_and(|c| c.is_ascii_alphabetic() || c == '_') && k.chars().all(|c| c.is_ascii_alphanumeric() || c == '_');
					let key = if ident {
						k.to_string()
					} else if !k.is_empty() && k.bytes().all(|b| b.is_ascii_digit()) {
						format!("[{k}]")
					} else {
						let mut q = String::new();
						json_quote(&mut q, k);
						format!("[{q}]")
					};
					format!("{key} = {}", lua(v))
				})
				.collect();
			format!("{{ {} }}", parts.join(", "))
		}
	}
}

/// emitSpecData -> SpecData.lua text (`build`: the Forever build the racial traits come from).
pub fn emit_spec_data(bands: &Bands, rac: &Racials, wowsims_meta: bool, build: &str) -> String {
	let mut l: Vec<String> = vec![
		forge_guide::emit::header("lua", "forge data gear", "Polestar's leveling weights, wowsims and the Forever client's racial spells"),
		"-- Stat weight bands: Polestar's leveling weights (Weights.lua) blended with wowsims".into(),
		format!("-- simulations (MIT, https://github.com/wowsims; {}).", if wowsims_meta { "see each band's source" } else { "not available" }),
		format!("-- Racial gear traits: the Forever client's racial spells (build {build})."),
		"-- See THIRD_PARTY.md.".into(),
		String::new(),
		"local ADDON, ns = ...".into(),
		"local Gear = ns.Gear".into(),
		String::new(),
		"Gear.WEIGHT_BANDS = {".into(),
	];
	let mut classes: Vec<&(String, Vec<(String, Vec<BandRec>)>)> = bands.iter().collect();
	classes.sort_by(|a, b| cmp_utf16(&a.0, &b.0));
	for (cls, specs) in classes {
		l.push(format!("\t{cls} = {{"));
		let mut specs: Vec<&(String, Vec<BandRec>)> = specs.iter().collect();
		specs.sort_by(|a, b| cmp_utf16(&a.0, &b.0));
		for (spec, list) in specs {
			l.push(format!("\t\t{spec} = {{"));
			for b in list {
				l.push(format!("\t\t\t{{ upTo = {}, source = {}, label = {}, note = {},", num_str(b.up_to), lua(&V::str(&b.source)), lua(&V::str(&b.label)), lua(&V::str(&b.note))));
				l.push(format!("\t\t\t\tweights = {} }},", lua(&V::Obj(b.weights.clone()))));
			}
			l.push("\t\t},".into());
		}
		l.push("\t},".into());
	}
	l.push("}".into());
	l.push(String::new());
	l.push("-- Racial gear traits by race ID, each one spell: statMult (stat multipliers) or weaponCrit (percent".into());
	l.push("-- crit with these weapon subclasses), for the classes in classMask (none: every class).".into());
	l.push("Gear.RACIALS = {".into());
	for (race, traits) in rac {
		let list: Vec<String> = traits
			.iter()
			.map(|t| {
				let mut parts = vec![format!("name = {}", lua(&V::str(&t.name)))];
				if t.class_mask != 0 {
					parts.push(format!("classMask = {}", t.class_mask));
				}
				if let Some((pct, subs)) = &t.weapon_crit {
					let subs = subs.iter().map(|s| format!("[{s}] = true")).collect::<Vec<_>>().join(", ");
					parts.push(format!("weaponCrit = {{ pct = {}, subclasses = {{ {subs} }} }}", num_str(*pct)));
				}
				if !t.stat_mult.is_empty() {
					parts.push(format!("statMult = {{ {} }}", t.stat_mult.iter().map(|(k, m)| format!("{k} = {}", num_str(*m))).collect::<Vec<_>>().join(", ")));
				}
				format!("{{ {} }}", parts.join(", "))
			})
			.collect();
		l.push(format!("\t[{race}] = {{ {} }},", list.join(", ")));
	}
	l.push("}".into());
	l.push(String::new());
	l.join("\n")
}
