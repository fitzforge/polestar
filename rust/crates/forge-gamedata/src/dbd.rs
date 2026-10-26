//! WoWDBDefs `.dbd` table definitions (github.com/wowdev/WoWDBDefs, `definitions/`, CC BY-SA
//! 4.0), read at runtime from a local checkout; none are shipped with this crate.
//!
//! A file is a `COLUMNS` block (`type[<Foreign::Key>] Name[?]`) and then definition blocks:
//! `LAYOUT`/`BUILD`/`COMMENT` lines, then one line per field in record order,
//! `[$annotations$]Name[<size>][[array]][ // comment]`, with `u` in the size for unsigned.

use std::path::Path;

use rustc_hash::FxHashMap;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
	Int,
	Float,
	String,
	LocString,
}

/// One field of a definition, in record order.
#[derive(Clone, Debug)]
pub struct Field {
	pub name: String,
	pub kind: Kind,
	/// Bits of an int (8/16/32/64); 32 for floats and string offsets.
	pub bits: u32,
	pub signed: bool,
	/// Array length (1 for a scalar).
	pub array: usize,
	/// `$id$`: the record's ID.
	pub id: bool,
	/// `$noninline$`: not stored in the record (the ID list or relationship data holds it).
	pub noninline: bool,
	/// `$relation$`: the foreign key the relationship data holds.
	pub relation: bool,
}

/// One version range of a table's layout.
#[derive(Clone, Debug, Default)]
pub struct Definition {
	pub layouts: Vec<u32>,
	pub builds: Vec<Build>,
	pub ranges: Vec<(Build, Build)>,
	pub fields: Vec<Field>,
}

/// A client build `major.minor.patch.build`, ordered.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Build(pub [u32; 4]);

impl Build {
	pub fn parse(s: &str) -> Option<Build> {
		let mut p = s.trim().split('.').map(|x| x.parse::<u32>().ok());
		let b = Build([p.next()??, p.next()??, p.next()??, p.next()??]);
		p.next().is_none().then_some(b)
	}
}

impl std::fmt::Display for Build {
	fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
		let [a, b, c, d] = self.0;
		write!(f, "{a}.{b}.{c}.{d}")
	}
}

impl Definition {
	pub fn has_build(&self, b: Build) -> bool {
		self.builds.contains(&b) || self.ranges.iter().any(|(lo, hi)| *lo <= b && b <= *hi)
	}
}

/// A parsed `.dbd` file.
#[derive(Clone, Debug)]
pub struct Dbd {
	pub definitions: Vec<Definition>,
}

impl Dbd {
	pub fn load(dir: &Path, table: &str) -> Result<Dbd, String> {
		let file = dir.join(format!("{table}.dbd"));
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e} (WoWDBDefs definitions: --defs <WoWDBDefs>/definitions)", file.display()))?;
		Dbd::parse(&text).map_err(|e| format!("{}: {e}", file.display()))
	}

	pub fn parse(text: &str) -> Result<Dbd, String> {
		let mut columns: FxHashMap<String, Kind> = FxHashMap::default();
		let mut definitions = Vec::new();
		let mut cur: Option<Definition> = None;
		let mut in_columns = false;
		for (n, raw) in text.lines().enumerate() {
			let line = raw.trim_end();
			let err = |m: &str| format!("line {}: {m}: {line:?}", n + 1);
			if line.is_empty() {
				in_columns = false;
				if let Some(d) = cur.take() {
					definitions.push(d);
				}
				continue;
			}
			if line == "COLUMNS" {
				in_columns = true;
				continue;
			}
			if in_columns {
				let body = line.split("//").next().unwrap_or("").trim();
				let (ty, name) = body.split_once(' ').ok_or_else(|| err("bad column"))?;
				let base = ty.split('<').next().unwrap_or(ty);
				let kind = match base {
					"int" => Kind::Int,
					"float" => Kind::Float,
					"string" => Kind::String,
					"locstring" => Kind::LocString,
					_ => return Err(err("unknown column type")),
				};
				columns.insert(name.trim().trim_end_matches('?').to_string(), kind);
				continue;
			}
			let d = cur.get_or_insert_with(Definition::default);
			if let Some(rest) = line.strip_prefix("LAYOUT ") {
				for h in rest.split(',') {
					d.layouts.push(u32::from_str_radix(h.trim(), 16).map_err(|_| err("bad layout hash"))?);
				}
			} else if let Some(rest) = line.strip_prefix("BUILD ") {
				for b in rest.split(',') {
					match b.split_once('-') {
						Some((lo, hi)) => d.ranges.push((Build::parse(lo).ok_or_else(|| err("bad build"))?, Build::parse(hi).ok_or_else(|| err("bad build"))?)),
						None => d.builds.push(Build::parse(b).ok_or_else(|| err("bad build"))?),
					}
				}
			} else if line.starts_with("COMMENT") {
			} else {
				d.fields.push(parse_field(line, &columns).map_err(|m| err(&m))?);
			}
		}
		if let Some(d) = cur.take() {
			definitions.push(d);
		}
		Ok(Dbd { definitions })
	}

	/// The definition for a file with `layout` hash in `build`: the one listing both, else the
	/// only one listing the layout, else the one listing the build.
	pub fn select(&self, layout: u32, build: Option<Build>) -> Option<&Definition> {
		let by_layout: Vec<&Definition> = self.definitions.iter().filter(|d| d.layouts.contains(&layout)).collect();
		if let Some(b) = build {
			if let Some(d) = by_layout.iter().find(|d| d.has_build(b)) {
				return Some(d);
			}
		}
		if let Some(d) = by_layout.last() {
			return Some(d);
		}
		build.and_then(|b| self.for_build(b))
	}

	/// The definition listing `build`, for data that carries no layout hash (hotfix rows).
	pub fn for_build(&self, build: Build) -> Option<&Definition> {
		self.definitions.iter().find(|d| d.has_build(build))
	}
}

fn parse_field(line: &str, columns: &FxHashMap<String, Kind>) -> Result<Field, String> {
	let mut s = line.split("//").next().unwrap_or("").trim();
	let mut annotations: Vec<&str> = Vec::new();
	if let Some(rest) = s.strip_prefix('$') {
		let (a, r) = rest.split_once('$').ok_or("unclosed annotation")?;
		annotations = a.split(',').map(str::trim).collect();
		s = r;
	}
	let mut array = 1usize;
	if let Some(open) = s.find('[') {
		let close = s.find(']').ok_or("unclosed array")?;
		array = s[open + 1..close].parse().map_err(|_| "bad array length")?;
		s = &s[..open];
	}
	let mut bits = 0u32;
	let mut signed = true;
	if let Some(open) = s.find('<') {
		let size = s[open + 1..].trim_end_matches('>');
		let num = match size.strip_prefix('u') {
			Some(n) => {
				signed = false;
				n
			}
			None => size,
		};
		bits = num.parse().map_err(|_| "bad size")?;
		s = &s[..open];
	}
	let name = s.trim().to_string();
	let kind = *columns.get(&name).ok_or_else(|| format!("field {name} is not in COLUMNS"))?;
	if kind != Kind::Int || bits == 0 {
		bits = 32;
	}
	Ok(Field { name, kind, bits, signed, array, id: annotations.contains(&"id"), noninline: annotations.contains(&"noninline"), relation: annotations.contains(&"relation") })
}

/// `tableName` -> `db2FileDataID` from WoWDBDefs' `manifest.json` (the checkout root's).
pub fn manifest(path: &Path) -> Result<FxHashMap<String, u32>, String> {
	let bytes = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
	let v: serde_json::Value = serde_json::from_slice(&bytes).map_err(|e| format!("{}: {e}", path.display()))?;
	let list = v.as_array().ok_or_else(|| format!("{}: not a list", path.display()))?;
	Ok(list.iter().filter_map(|t| Some((t["tableName"].as_str()?.to_string(), t["db2FileDataID"].as_u64()? as u32))).collect())
}

/// Table hash -> `tableName` from WoWDBDefs' `manifest.json` (its `tableHash`, hex), for the
/// tables that list one.
pub fn table_hashes(path: &Path) -> Result<FxHashMap<u32, String>, String> {
	let bytes = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
	let v: serde_json::Value = serde_json::from_slice(&bytes).map_err(|e| format!("{}: {e}", path.display()))?;
	let list = v.as_array().ok_or_else(|| format!("{}: not a list", path.display()))?;
	Ok(list.iter().filter_map(|t| Some((u32::from_str_radix(t["tableHash"].as_str()?, 16).ok()?, t["tableName"].as_str()?.to_string()))).collect())
}

#[cfg(test)]
mod tests {
	use super::*;

	const DBD: &str = "COLUMNS\nint ID\nlocstring Name_lang\nint<Map::ID> MapID\nfloat Pos\nint Field_1?\n\nLAYOUT 0000AAAA\nBUILD 1.13.2.30073-1.13.2.31650\nint Old\n\nLAYOUT 9995B797, 1234ABCD\nBUILD 1.60.1.70338, 1.60.1.70450\nCOMMENT x\n$noninline,id$ID<32>\nName_lang\nMapID<u16>\nPos[3] // xyz\nField_1<8>\n$noninline,relation$MapID<32>\n";

	#[test]
	fn parses_and_selects() {
		let d = Dbd::parse(&DBD.replace("int Old", "ID<32>")).unwrap();
		assert_eq!(d.definitions.len(), 2);
		let b = Build::parse("1.60.1.70450").unwrap();
		let def = d.select(0x9995b797, Some(b)).unwrap();
		let f = &def.fields;
		assert_eq!(f.len(), 6);
		assert!(f[0].id && f[0].noninline && f[0].bits == 32);
		assert_eq!((f[1].kind, f[2].bits, f[2].signed), (Kind::LocString, 16, false));
		assert_eq!((f[3].kind, f[3].array), (Kind::Float, 3));
		assert_eq!((f[4].name.as_str(), f[4].bits, f[4].signed), ("Field_1", 8, true));
		assert!(f[5].relation && f[5].noninline);
		assert!(d.definitions[0].has_build(Build::parse("1.13.2.31000").unwrap()));
		assert!(d.select(0xdead, Some(b)).is_some());
		assert!(d.select(0xdead, None).is_none());
	}
}
