//! Client tables for the build: cached wago.tools CSVs (port of tools/lib/data/wago.js, offline:
//! the newest cached build of the product holding its tables), or the installed client read by
//! forge-gamedata, rows in the same CSV text form.

use std::path::{Path, PathBuf};

use crate::jsv::{Row, Rows};

pub struct Product {
	pub key: &'static str,
	family: fn(&str) -> bool,
	pub tables: &'static [&'static str],
	pub optional: &'static [&'static str],
}

fn era_family(b: &str) -> bool {
	b.starts_with("1.1") && b.as_bytes().get(3).is_some_and(|c| (b'0'..=b'5').contains(c)) && b.as_bytes().get(4) == Some(&b'.')
}

fn forever_family(b: &str) -> bool {
	b.starts_with("1.6") && b.as_bytes().get(3).is_some_and(u8::is_ascii_digit) && b.as_bytes().get(4) == Some(&b'.')
}

pub const ERA: Product = Product { key: "wow_classic_era", family: era_family, tables: &["UiMap", "UiMapAssignment", "AreaTable", "Faction"], optional: &[] };
pub const FOREVER: Product = Product {
	key: "wow_classic_beta",
	family: forever_family,
	tables: &["UiMap", "UiMapAssignment", "AreaTable"],
	optional: &["ChrRaces", "ChrClasses", "CharBaseInfo", "Faction", "Map", "ItemSparse"],
};
/// sim-v2 also reads Item (mount vendors) and SpellName (training's spell names).
pub const FOREVER_SIM: Product = Product {
	key: "wow_classic_beta",
	family: forever_family,
	tables: &["UiMap", "UiMapAssignment", "AreaTable"],
	optional: &["ChrRaces", "ChrClasses", "CharBaseInfo", "Faction", "Map", "ItemSparse", "Item", "SpellName"],
};

impl Product {
	/// Whether `b` is one of the product's builds (Era 1.10-1.15, Forever 1.60+).
	pub fn in_family(&self, b: &str) -> bool {
		(self.family)(b)
	}
}

/// A build version names a cache folder: digits and dots only.
pub fn is_build(b: &str) -> bool {
	let parts: Vec<&str> = b.split('.').collect();
	parts.len() >= 2 && parts.iter().all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_digit()))
}

pub fn compare_versions(a: &str, b: &str) -> std::cmp::Ordering {
	let pa: Vec<f64> = a.split('.').map(|x| x.parse().unwrap_or(f64::NAN)).collect();
	let pb: Vec<f64> = b.split('.').map(|x| x.parse().unwrap_or(f64::NAN)).collect();
	for i in 0..pa.len().max(pb.len()) {
		let d = pa.get(i).copied().unwrap_or(0.0) - pb.get(i).copied().unwrap_or(0.0);
		if d != 0.0 && !d.is_nan() {
			return d.partial_cmp(&0.0).unwrap();
		}
	}
	std::cmp::Ordering::Equal
}

pub fn table_url(table: &str, build: &str) -> String {
	format!("https://wago.tools/db2/{table}/csv?build={build}")
}

/// The newest cached build of the product holding every one of its tables.
pub fn newest_cached_build(sources: &Path, p: &Product) -> Option<String> {
	newest_cached_holding(sources, p, p.tables)
}

/// The newest cached build of the product holding every one of `tables`.
pub fn newest_cached_holding(sources: &Path, p: &Product, tables: &[&str]) -> Option<String> {
	let root = sources.join("wago");
	let mut builds: Vec<String> = std::fs::read_dir(&root)
		.ok()?
		.flatten()
		.map(|e| e.file_name().to_string_lossy().to_string())
		.filter(|b| is_build(b) && (p.family)(b) && tables.iter().all(|t| root.join(b).join(format!("{t}.csv")).exists()))
		.collect();
	builds.sort_by(|a, b| compare_versions(a, b));
	builds.pop()
}

/// RFC 4180 CSV (tools/lib/data/csv.js parseCsv): rows keyed by the header.
pub fn parse_csv(text: &str) -> Result<Rows, String> {
	let mut rows: Vec<Vec<String>> = Vec::new();
	let (mut row, mut field, mut quoted) = (Vec::new(), String::new(), false);
	let text = text.strip_prefix('\u{feff}').unwrap_or(text);
	let mut it = text.chars().peekable();
	while let Some(c) = it.next() {
		if quoted {
			if c == '"' {
				if it.peek() == Some(&'"') {
					field.push('"');
					it.next();
				} else {
					quoted = false;
				}
			} else {
				field.push(c);
			}
			continue;
		}
		match c {
			'"' if field.is_empty() => quoted = true,
			',' => row.push(std::mem::take(&mut field)),
			'\n' | '\r' => {
				row.push(std::mem::take(&mut field));
				rows.push(std::mem::take(&mut row));
				if c == '\r' && it.peek() == Some(&'\n') {
					it.next();
				}
			}
			c => field.push(c),
		}
	}
	if quoted {
		return Err("CSV: unterminated quoted field".into());
	}
	if !field.is_empty() || !row.is_empty() {
		row.push(field);
		rows.push(row);
	}
	let mut it = rows.into_iter();
	let Some(header) = it.next() else { return Ok(Vec::new()) };
	let mut out = Vec::new();
	for (r, row) in it.enumerate() {
		if row.len() == 1 && row[0].is_empty() {
			continue;
		}
		if row.len() != header.len() {
			return Err(format!("CSV: row {} has {} fields, header has {}", r + 2, row.len(), header.len()));
		}
		out.push(header.iter().cloned().zip(row).collect::<Row>());
	}
	Ok(out)
}

/// Where a product's tables come from.
pub enum Source {
	/// data/sources/wago/<build>/<Table>.csv.
	Wago,
	/// The installed client (forge-gamedata): its folder, product code and WoWDBDefs checkout.
	Client { wow: PathBuf, product: String, defs: PathBuf },
}

pub struct Loaded {
	pub build: String,
	pub product: String,
	pub tables: Vec<(&'static str, Rows)>,
	/// wago.tools URLs of the tables read (wago) or their names (client), in load order.
	pub urls: Vec<String>,
	pub from_client: bool,
	pub warnings: Vec<String>,
}

impl Loaded {
	pub fn get(&self, t: &str) -> Option<&Rows> {
		self.tables.iter().find(|(n, _)| *n == t).map(|(_, r)| r)
	}
}

fn client_rows(c: &forge_gamedata::Client, table: &str) -> Result<Rows, String> {
	Ok(table_rows(&c.table(table, "enUS")?))
}

/// A decoded table's rows in the CSV text form (`Index` read as `_Index`).
pub(crate) fn table_rows(t: &forge_gamedata::Table) -> Rows {
	let names: Vec<String> = t.columns.iter().map(|c| if c.name == "Index" { "_Index".to_string() } else { c.name.clone() }).collect();
	let mut out = Vec::with_capacity(t.rows());
	let mut buf = Vec::new();
	for r in 0..t.rows() {
		let mut row = Row::default();
		for (i, v) in t.row(r).iter().enumerate() {
			buf.clear();
			match v {
				forge_gamedata::Value::Str(..) => buf.extend_from_slice(t.str(v).unwrap_or_default()),
				_ => forge_gamedata::csv::put_value(&mut buf, t, v),
			}
			row.insert(names[i].clone(), String::from_utf8_lossy(&buf).into_owned());
		}
		out.push(row);
	}
	out
}

/// The product's tables (`build`: a wago build to read; client: must be the installed one).
pub fn load(sources: &Path, p: &Product, build: Option<&str>, src: &Source, log: &dyn Fn(&str)) -> Result<Loaded, String> {
	match src {
		Source::Wago => {
			let chosen = match build {
				Some(b) => b.to_string(),
				None => newest_cached_build(sources, p).ok_or_else(|| format!("--offline: no cached wago.tools build under {} ({})", sources.join("wago").display(), p.key))?,
			};
			let mut tables = Vec::new();
			let mut urls = Vec::new();
			let mut warnings = Vec::new();
			let read = |t: &str| -> Result<Rows, String> {
				let file = sources.join("wago").join(&chosen).join(format!("{t}.csv"));
				let text = std::fs::read_to_string(&file).map_err(|_| format!("--offline: missing cached {}", file.display()))?;
				parse_csv(&text)
			};
			for &t in p.tables {
				tables.push((t, read(t)?));
				urls.push(table_url(t, &chosen));
			}
			for &t in p.optional {
				match read(t) {
					Ok(r) => {
						tables.push((t, r));
						urls.push(table_url(t, &chosen));
					}
					Err(e) => warnings.push(format!("wago.tools {} {chosen}: no {t} ({e})", p.key)),
				}
			}
			Ok(Loaded { build: chosen, product: p.key.to_string(), tables, urls, from_client: false, warnings })
		}
		Source::Client { wow, product, defs } => {
			let c = forge_gamedata::Client::open(wow, product, defs)?;
			let installed = c.storage.version.clone();
			if let Some(b) = build {
				if b != installed {
					return Err(format!("--forever-build {b}: the installed {product} is {installed}"));
				}
			}
			log(&format!("reading {product} {installed} client tables from {}", wow.display()));
			let mut tables = Vec::new();
			let mut urls = Vec::new();
			let mut warnings = Vec::new();
			for &t in p.tables {
				tables.push((t, client_rows(&c, t)?));
				urls.push(t.to_string());
			}
			for &t in p.optional {
				match client_rows(&c, t) {
					Ok(r) => {
						tables.push((t, r));
						urls.push(t.to_string());
					}
					Err(e) => warnings.push(format!("{product} {installed}: no {t} ({e})")),
				}
			}
			Ok(Loaded { build: installed, product: product.clone(), tables, urls, from_client: true, warnings })
		}
	}
}
