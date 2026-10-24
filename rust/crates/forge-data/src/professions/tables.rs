//! The client tables `profession build` reads (port of tools/lib/professions/tables.js, offline):
//! the Forever client's (wago.tools `wow_classic_beta` 1.60+, cached under
//! <sources>/wago/<build>/<Table>.csv), a table it lacks among SpellTotems,
//! SpellCastingRequirements and SpellFocusObject read whole from the newest cached Classic Era
//! build, and Era's rows filling the spells and items Forever's have none of (`fillFromEra`).
//!
//! Rows are parsed straight into typed records holding only the columns extract.js reads:
//! numbers as `Number(cell)` (NaN for a column the table lacks), so the `int(...)` and
//! `Number(...)` of the JS stay exact, Forever's and Era's rows side by side.

use std::path::Path;

use forge_guide::js::str_to_num;
use rustc_hash::FxHashSet;

use crate::jsv::math_round;

/// `int(v)` of extract.js: `Number(v)` truncated, 0 when not finite.
pub fn int(x: f64) -> i64 {
	if x.is_finite() {
		x.trunc() as i64
	} else {
		0
	}
}

/// A `Set` key for a number (SameValueZero: one NaN, -0 = 0).
pub fn nk(x: f64) -> u64 {
	if x.is_nan() {
		f64::NAN.to_bits()
	} else if x == 0.0 {
		0
	} else {
		x.to_bits()
	}
}

/// One CSV row, the record's wanted columns by position.
pub struct Cells<'a> {
	idx: &'a [Option<usize>],
	fields: &'a [Vec<u8>],
}

impl<'a> Cells<'a> {
	/// The cell of wanted column `i` (`row.col`; None = undefined).
	pub fn get(&self, i: usize) -> Option<&'a str> {
		self.idx[i].map(|j| std::str::from_utf8(&self.fields[j]).unwrap_or(""))
	}
	/// `Number(row.col)`.
	pub fn num(&self, i: usize) -> f64 {
		self.get(i).map(str_to_num).unwrap_or(f64::NAN)
	}
	pub fn int(&self, i: usize) -> i64 {
		int(self.num(i))
	}
	pub fn text(&self, i: usize) -> Option<String> {
		self.get(i).map(str::to_string)
	}
}

/// A client-table record: the columns it reads, and how a row becomes one.
pub trait Rec: Sized {
	const COLS: &'static [&'static str];
	fn from(c: &Cells) -> Self;
}

/// tools/lib/data/csv.js parseCsv, keeping `T`'s columns of each row.
pub fn parse<T: Rec>(text: &str) -> Result<Vec<T>, String> {
	let b = text.strip_prefix('\u{feff}').unwrap_or(text).as_bytes();
	let mut fields: Vec<Vec<u8>> = vec![Vec::new()];
	let mut n = 0usize;
	let mut quoted = false;
	let mut header: Option<(Vec<Option<usize>>, usize)> = None;
	let mut row_no = 0usize;
	let mut out = Vec::new();
	let mut end_row = |fields: &[Vec<u8>], count: usize| -> Result<(), String> {
		match &header {
			None => {
				let names: Vec<&[u8]> = fields[..count].iter().map(Vec::as_slice).collect();
				// Rows are objects keyed by the header: a repeated name keeps its last column.
				let idx = T::COLS.iter().map(|c| names.iter().rposition(|h| *h == c.as_bytes())).collect();
				header = Some((idx, count));
			}
			Some((idx, len)) => {
				let r = row_no;
				row_no += 1;
				if count == 1 && fields[0].is_empty() {
					return Ok(());
				}
				if count != *len {
					return Err(format!("CSV: row {} has {count} fields, header has {len}", r + 2));
				}
				out.push(T::from(&Cells { idx, fields: &fields[..count] }));
			}
		}
		Ok(())
	};
	let mut i = 0;
	while i < b.len() {
		let c = b[i];
		i += 1;
		if quoted {
			if c == b'"' {
				if b.get(i) == Some(&b'"') {
					fields[n].push(b'"');
					i += 1;
				} else {
					quoted = false;
				}
			} else {
				fields[n].push(c);
			}
			continue;
		}
		match c {
			b'"' if fields[n].is_empty() => quoted = true,
			b',' => {
				n += 1;
				if fields.len() <= n {
					fields.push(Vec::new());
				} else {
					fields[n].clear();
				}
			}
			b'\n' | b'\r' => {
				end_row(&fields, n + 1)?;
				n = 0;
				fields[0].clear();
				if c == b'\r' && b.get(i) == Some(&b'\n') {
					i += 1;
				}
			}
			_ => fields[n].push(c),
		}
	}
	if quoted {
		return Err("CSV: unterminated quoted field".into());
	}
	if !fields[n].is_empty() || n > 0 {
		end_row(&fields, n + 1)?;
	}
	Ok(out)
}

pub struct SkillLine {
	pub id: i64,
	pub name: Option<String>,
}
impl Rec for SkillLine {
	const COLS: &'static [&'static str] = &["ID", "DisplayName_lang"];
	fn from(c: &Cells) -> Self {
		SkillLine { id: c.int(0), name: c.text(1) }
	}
}

pub struct Ability {
	pub skill_line: i64,
	/// `Number(row.Spell)` (Era's rows: which spells are Season of Discovery's).
	pub spell_n: f64,
	pub spell: i64,
	pub acquire: i64,
	pub low: i64,
	pub high: i64,
	pub min_rank: i64,
	pub ups: i64,
	/// `int(row.RaceMasks_0 ?? row.RaceMask_0)`.
	pub race: i64,
	pub class: i64,
}
impl Rec for Ability {
	const COLS: &'static [&'static str] =
		&["SkillLine", "Spell", "AcquireMethod", "TrivialSkillLineRankLow", "TrivialSkillLineRankHigh", "MinSkillLineRank", "NumSkillUps", "RaceMasks_0", "RaceMask_0", "ClassMask"];
	fn from(c: &Cells) -> Self {
		let spell_n = c.num(1);
		let race = if c.get(7).is_some() { c.int(7) } else { c.int(8) };
		Ability { skill_line: c.int(0), spell_n, spell: int(spell_n), acquire: c.int(2), low: c.int(3), high: c.int(4), min_rank: c.int(5), ups: c.int(6), race, class: c.int(9) }
	}
}

pub struct SpellName {
	pub id_n: f64,
	pub name: Option<String>,
}
impl Rec for SpellName {
	const COLS: &'static [&'static str] = &["ID", "Name_lang"];
	fn from(c: &Cells) -> Self {
		SpellName { id_n: c.num(0), name: c.text(1) }
	}
}

pub struct SpellEffect {
	pub spell_n: f64,
	pub difficulty: i64,
	pub index: i64,
	pub effect: i64,
	pub item_type: i64,
	/// basePoints(e): EffectBasePoints (Era), else Math.round(EffectBasePointsF) - 1 (Forever).
	pub base_points: f64,
	pub trigger: i64,
	pub misc0: i64,
}
impl Rec for SpellEffect {
	const COLS: &'static [&'static str] = &["SpellID", "DifficultyID", "EffectIndex", "Effect", "EffectItemType", "EffectBasePoints", "EffectBasePointsF", "EffectTriggerSpell", "EffectMiscValue_0"];
	fn from(c: &Cells) -> Self {
		let base_points = match c.get(5) {
			Some(s) if !s.is_empty() => int(str_to_num(s)) as f64,
			_ => {
				let f = c.num(6);
				math_round(if f.is_nan() { 0.0 } else { f }) - 1.0
			}
		};
		SpellEffect { spell_n: c.num(0), difficulty: c.int(1), index: c.int(2), effect: c.int(3), item_type: c.int(4), base_points, trigger: c.int(7), misc0: c.int(8) }
	}
}

pub struct SpellReagents {
	pub spell_n: f64,
	pub reagent: [i64; 8],
	pub count: [i64; 8],
}
impl Rec for SpellReagents {
	const COLS: &'static [&'static str] = &[
		"SpellID",
		"Reagent_0",
		"Reagent_1",
		"Reagent_2",
		"Reagent_3",
		"Reagent_4",
		"Reagent_5",
		"Reagent_6",
		"Reagent_7",
		"ReagentCount_0",
		"ReagentCount_1",
		"ReagentCount_2",
		"ReagentCount_3",
		"ReagentCount_4",
		"ReagentCount_5",
		"ReagentCount_6",
		"ReagentCount_7",
	];
	fn from(c: &Cells) -> Self {
		SpellReagents { spell_n: c.num(0), reagent: std::array::from_fn(|i| c.int(1 + i)), count: std::array::from_fn(|i| c.int(9 + i)) }
	}
}

pub struct SpellTotems {
	pub spell_n: f64,
	pub totem: [i64; 2],
	pub category: [i64; 2],
}
impl Rec for SpellTotems {
	const COLS: &'static [&'static str] = &["SpellID", "Totem_0", "Totem_1", "RequiredTotemCategoryID_0", "RequiredTotemCategoryID_1"];
	fn from(c: &Cells) -> Self {
		SpellTotems { spell_n: c.num(0), totem: [c.int(1), c.int(2)], category: [c.int(3), c.int(4)] }
	}
}

pub struct SpellCasting {
	pub spell_n: f64,
	pub focus: i64,
}
impl Rec for SpellCasting {
	const COLS: &'static [&'static str] = &["SpellID", "RequiresSpellFocus"];
	fn from(c: &Cells) -> Self {
		SpellCasting { spell_n: c.num(0), focus: c.int(1) }
	}
}

pub struct SpellFocus {
	pub id_n: f64,
	pub name: Option<String>,
}
impl Rec for SpellFocus {
	const COLS: &'static [&'static str] = &["ID", "Name_lang"];
	fn from(c: &Cells) -> Self {
		SpellFocus { id_n: c.num(0), name: c.text(1) }
	}
}

pub struct ItemSparse {
	pub id_n: f64,
	pub display: Option<String>,
	pub buy: i64,
	pub sell: i64,
	pub stack: i64,
	pub quality: i64,
	pub req_rank: i64,
	pub ability: i64,
	pub faction: i64,
	pub min_rep: i64,
	pub bonding: i64,
	pub totem_category: i64,
}
impl Rec for ItemSparse {
	const COLS: &'static [&'static str] =
		&["ID", "Display_lang", "BuyPrice", "SellPrice", "VendorStackCount", "OverallQualityID", "RequiredSkillRank", "RequiredAbility", "MinFactionID", "MinReputation", "Bonding", "TotemCategoryID"];
	fn from(c: &Cells) -> Self {
		ItemSparse {
			id_n: c.num(0),
			display: c.text(1),
			buy: c.int(2),
			sell: c.int(3),
			stack: c.int(4),
			quality: c.int(5),
			req_rank: c.int(6),
			ability: c.int(7),
			faction: c.int(8),
			min_rep: c.int(9),
			bonding: c.int(10),
			totem_category: c.int(11),
		}
	}
}

pub struct Item {
	pub id_n: f64,
	pub class: i64,
}
impl Rec for Item {
	const COLS: &'static [&'static str] = &["ID", "ClassID"];
	fn from(c: &Cells) -> Self {
		Item { id_n: c.num(0), class: c.int(1) }
	}
}

pub struct ItemEffect {
	pub id: i64,
	pub spell: i64,
	pub trigger_type: i64,
	/// `Number(row.ParentItemID)` (Era names the item here; Forever has no such column).
	pub parent_n: f64,
}
impl Rec for ItemEffect {
	const COLS: &'static [&'static str] = &["ID", "SpellID", "TriggerType", "ParentItemID"];
	fn from(c: &Cells) -> Self {
		ItemEffect { id: c.int(0), spell: c.int(1), trigger_type: c.int(2), parent_n: c.num(3) }
	}
}

pub struct ItemXItemEffect {
	pub effect: i64,
	pub item_n: f64,
}
impl Rec for ItemXItemEffect {
	const COLS: &'static [&'static str] = &["ItemEffectID", "ItemID"];
	fn from(c: &Cells) -> Self {
		ItemXItemEffect { effect: c.int(0), item_n: c.num(1) }
	}
}

/// The tables extract.js reads, Era's rows filled in.
pub struct Tables {
	pub skill_line: Vec<SkillLine>,
	pub abilities: Vec<Ability>,
	pub spell_name: Vec<SpellName>,
	pub effects: Vec<SpellEffect>,
	pub reagents: Vec<SpellReagents>,
	pub totems: Vec<SpellTotems>,
	pub casting: Vec<SpellCasting>,
	pub focus: Vec<SpellFocus>,
	pub sparse: Vec<ItemSparse>,
	pub item: Vec<Item>,
	pub item_effect: Vec<ItemEffect>,
	pub item_x: Vec<ItemXItemEffect>,
}

pub struct Loaded {
	pub build: String,
	pub era_build: String,
	pub tables: Tables,
	/// `Number(Spell)` of Era's SkillLineAbility rows from SOD_SPELL_MIN (nk keys).
	pub season: FxHashSet<u64>,
	pub warnings: Vec<String>,
}

/// Forever's own tables: TABLES less the ones that may come whole from Era (SpellTotems,
/// SpellCastingRequirements, SpellFocusObject).
pub const OWN: [&str; 9] = ["SkillLine", "SkillLineAbility", "SpellName", "SpellEffect", "SpellReagents", "ItemSparse", "Item", "ItemEffect", "ItemXItemEffect"];
/// What `eraFill` reads from Era: ERA_ROWS + SkillLineAbility.
pub const ERA_NEEDED: [&str; 10] = ["SpellEffect", "SpellReagents", "SpellTotems", "SpellCastingRequirements", "SpellName", "ItemSparse", "Item", "SpellFocusObject", "ItemEffect", "SkillLineAbility"];

fn is_build(b: &str) -> bool {
	let mut parts = 0;
	for p in b.split('.') {
		if p.is_empty() || !p.bytes().all(|c| c.is_ascii_digit()) {
			return false;
		}
		parts += 1;
	}
	parts >= 2
}

/// /^1\.6\d\./
fn forever_family(b: &str) -> bool {
	let x = b.as_bytes();
	x.len() >= 5 && x.starts_with(b"1.6") && x[3].is_ascii_digit() && x[4] == b'.'
}

/// /^1\.1[0-5]\./
fn era_family(b: &str) -> bool {
	let x = b.as_bytes();
	x.len() >= 5 && x.starts_with(b"1.1") && (b'0'..=b'5').contains(&x[3]) && x[4] == b'.'
}

/// wago.js newestCachedBuild: the newest cached build of the family holding every one of `tables`.
fn newest_cached(root: &Path, family: fn(&str) -> bool, tables: &[&str]) -> Option<String> {
	let mut builds: Vec<String> = std::fs::read_dir(root)
		.ok()?
		.flatten()
		.map(|e| e.file_name().to_string_lossy().into_owned())
		.filter(|b| is_build(b) && family(b) && tables.iter().all(|t| root.join(b).join(format!("{t}.csv")).exists()))
		.collect();
	builds.sort_by(|a, b| crate::tables::compare_versions(a, b));
	builds.pop()
}

/// The cached <root>/<build>/<table>.csv (wago.js cachedTable, offline).
fn cached(root: &Path, build: &str, table: &str) -> Result<String, String> {
	let file = root.join(build).join(format!("{table}.csv"));
	if !file.exists() {
		return Err(format!("--offline: missing cached {}", super::cwd_relative(&file)));
	}
	std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))
}

fn read<T: Rec>(root: &Path, build: &str, table: &str) -> Result<Vec<T>, String> {
	parse(&cached(root, build, table)?).map_err(|e| format!("{table} {build}: {e}"))
}

/// Forever's rows, plus Era's that `keep` (the spells or ids Forever's have none of).
fn fill<T>(mut own: Vec<T>, era: Vec<T>, keep: impl Fn(&T) -> bool) -> Vec<T> {
	own.extend(era.into_iter().filter(keep));
	own
}

/// loadTables({ product: 'forever', eraFill: true, offline: true }): `build` the Forever wago
/// build (default: the newest cached one holding its own tables).
pub fn load(sources: &Path, build: Option<&str>) -> Result<Loaded, String> {
	let root = sources.join("wago");
	let fb = match build {
		Some(b) => b.to_string(),
		None => newest_cached(&root, forever_family, &OWN).ok_or_else(|| format!("--offline: no cached wago.tools build under {} (wow_classic_beta)", super::absolute(&root).display()))?,
	};
	let mut warnings = Vec::new();
	let mut era: Option<String> = None;
	let era_build = |era: &mut Option<String>| -> Result<String, String> {
		if era.is_none() {
			*era = Some(newest_cached(&root, era_family, &ERA_NEEDED).ok_or_else(|| format!("--offline: no cached wago.tools build under {} (wow_classic_era)", super::absolute(&root).display()))?);
		}
		Ok(era.clone().unwrap())
	};
	let mut whole: Vec<&str> = Vec::new();
	// A table Forever's build lacks among SpellTotems, SpellCastingRequirements and
	// SpellFocusObject comes whole from Era.
	macro_rules! fallback {
		($t:ty, $name:expr) => {
			match cached(&root, &fb, $name) {
				Ok(text) => parse::<$t>(&text).map_err(|e| format!("{} {fb}: {e}", $name))?,
				Err(e) => {
					let b = era_build(&mut era)?;
					let rows = read::<$t>(&root, &b, $name)?;
					whole.push($name);
					warnings.push(format!("{}: no Forever {fb} table ({e}); read Classic Era {b}", $name));
					rows
				}
			}
		};
	}
	let skill_line = read::<SkillLine>(&root, &fb, "SkillLine")?;
	let abilities = read::<Ability>(&root, &fb, "SkillLineAbility")?;
	let spell_name = read::<SpellName>(&root, &fb, "SpellName")?;
	let effects = read::<SpellEffect>(&root, &fb, "SpellEffect")?;
	let reagents = read::<SpellReagents>(&root, &fb, "SpellReagents")?;
	let totems = fallback!(SpellTotems, "SpellTotems");
	let casting = fallback!(SpellCasting, "SpellCastingRequirements");
	let focus = fallback!(SpellFocus, "SpellFocusObject");
	let sparse = read::<ItemSparse>(&root, &fb, "ItemSparse")?;
	let item = read::<Item>(&root, &fb, "Item")?;
	let item_effect = read::<ItemEffect>(&root, &fb, "ItemEffect")?;
	let item_x = read::<ItemXItemEffect>(&root, &fb, "ItemXItemEffect")?;

	// eraFill: Era's rows, in TABLES order, of the tables not already read whole from Era.
	let eb = era_build(&mut era)?;
	let own = |t: &str| !whole.contains(&t);
	let era_abilities = read::<Ability>(&root, &eb, "SkillLineAbility")?;
	let era_names = read::<SpellName>(&root, &eb, "SpellName")?;
	let era_effects = read::<SpellEffect>(&root, &eb, "SpellEffect")?;
	let era_reagents = read::<SpellReagents>(&root, &eb, "SpellReagents")?;
	let era_totems = if own("SpellTotems") { Some(read::<SpellTotems>(&root, &eb, "SpellTotems")?) } else { None };
	let era_casting = if own("SpellCastingRequirements") { Some(read::<SpellCasting>(&root, &eb, "SpellCastingRequirements")?) } else { None };
	let era_focus = if own("SpellFocusObject") { Some(read::<SpellFocus>(&root, &eb, "SpellFocusObject")?) } else { None };
	let era_sparse = read::<ItemSparse>(&root, &eb, "ItemSparse")?;
	let era_item = read::<Item>(&root, &eb, "Item")?;
	let era_item_effect = read::<ItemEffect>(&root, &eb, "ItemEffect")?;

	let season = era_abilities.iter().filter(|r| r.spell_n >= super::extract::SOD_SPELL_MIN as f64).map(|r| nk(r.spell_n)).collect();

	// fillFromEra: per spell (a spell Forever's SpellEffect has is wholly Forever's) and per id.
	let spells: FxHashSet<u64> = effects.iter().map(|r| nk(r.spell_n)).collect();
	let effects = fill(effects, era_effects, |r| !spells.contains(&nk(r.spell_n)));
	let reagents = fill(reagents, era_reagents, |r| !spells.contains(&nk(r.spell_n)));
	let totems = match era_totems {
		Some(e) => fill(totems, e, |r| !spells.contains(&nk(r.spell_n))),
		None => totems,
	};
	let casting = match era_casting {
		Some(e) => fill(casting, e, |r| !spells.contains(&nk(r.spell_n))),
		None => casting,
	};
	let ids: FxHashSet<u64> = spell_name.iter().map(|r| nk(r.id_n)).collect();
	let spell_name = fill(spell_name, era_names, |r| !ids.contains(&nk(r.id_n)));
	let ids: FxHashSet<u64> = sparse.iter().map(|r| nk(r.id_n)).collect();
	let sparse = fill(sparse, era_sparse, |r| !ids.contains(&nk(r.id_n)));
	let ids: FxHashSet<u64> = item.iter().map(|r| nk(r.id_n)).collect();
	let item = fill(item, era_item, |r| !ids.contains(&nk(r.id_n)));
	let focus = match era_focus {
		Some(e) => {
			let ids: FxHashSet<u64> = focus.iter().map(|r| nk(r.id_n)).collect();
			fill(focus, e, |r| !ids.contains(&nk(r.id_n)))
		}
		None => focus,
	};
	let linked: FxHashSet<u64> = item_x.iter().map(|r| nk(r.item_n)).collect();
	let item_effect = fill(item_effect, era_item_effect, |r| r.parent_n > 0.0 && !linked.contains(&nk(r.parent_n)));

	Ok(Loaded { build: fb, era_build: eb, tables: Tables { skill_line, abilities, spell_name, effects, reagents, totems, casting, focus, sparse, item, item_effect, item_x }, season, warnings })
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn csv_columns_and_absent() {
		let rows: Vec<ItemEffect> = parse("\u{feff}ID,SpellID,TriggerType\r\n7,\"1,2\",6\n\n8,483,0").unwrap();
		assert_eq!(rows.len(), 2);
		assert_eq!(rows[0].id, 7);
		assert_eq!(rows[0].spell, 0); // Number("1,2") is NaN -> int 0
		assert!(rows[0].parent_n.is_nan());
		assert_eq!(rows[1].spell, 483);
		assert!(parse::<Item>("ID,ClassID\n1\n").is_err());
		assert!(parse::<Item>("ID,ClassID\n\"1,9\n").is_err());
	}

	#[test]
	fn base_points() {
		let era: Vec<SpellEffect> = parse("SpellID,EffectBasePoints,EffectBasePointsF\n1,4,9\n2,,2.6").unwrap();
		assert_eq!(era[0].base_points, 4.0);
		assert_eq!(era[1].base_points, 2.0);
		let forever: Vec<SpellEffect> = parse("SpellID,EffectBasePointsF\n1,\n").unwrap();
		assert_eq!(forever[0].base_points, -1.0);
	}

	#[test]
	fn families() {
		assert!(forever_family("1.60.1.70450") && !forever_family("1.15.9.1"));
		assert!(era_family("1.15.9.70003") && !era_family("1.16.0.1") && !era_family("5.5.1.1"));
		assert!(is_build("1.2") && !is_build("1") && !is_build("1..2"));
	}
}
