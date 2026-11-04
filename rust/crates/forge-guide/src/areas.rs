//! Port of tools/lib/data/areas.js, data/csv.js.
//! The client's AreaTable as `data build` caches it (<sources>/wago/<newest Forever build>/AreaTable.csv),
//! and RFC 4180 CSV parsing. `load_areas` -> V { build, byId: id -> area, byName: lowercased name -> [area] }
//! (JS Maps as objects keyed by String(key)) or Null; area = { id, name, c, parent }.

#[cfg(feature = "native")]
use crate::js::num_str;
use crate::js::V;
use crate::obj;

/// `parseRows(text)`: rows of fields; Err = the JS throw message.
pub fn parse_rows(text: &str) -> Result<Vec<Vec<String>>, String> {
	let mut rows = Vec::new();
	let mut row: Vec<String> = Vec::new();
	let mut field = String::new();
	let mut quoted = false;
	let chars: Vec<char> = text.chars().collect();
	let n = chars.len();
	let mut i = 0;
	if n > 0 && chars[0] == '\u{feff}' {
		i = 1;
	}
	while i < n {
		let c = chars[i];
		if quoted {
			if c == '"' {
				if chars.get(i + 1) == Some(&'"') {
					field.push('"');
					i += 2;
					continue;
				}
				quoted = false;
				i += 1;
				continue;
			}
			field.push(c);
			i += 1;
			continue;
		}
		if c == '"' && field.is_empty() {
			quoted = true;
			i += 1;
		} else if c == ',' {
			row.push(std::mem::take(&mut field));
			i += 1;
		} else if c == '\n' || c == '\r' {
			row.push(std::mem::take(&mut field));
			rows.push(std::mem::take(&mut row));
			i += if c == '\r' && chars.get(i + 1) == Some(&'\n') { 2 } else { 1 };
		} else {
			field.push(c);
			i += 1;
		}
	}
	if quoted {
		return Err("CSV: unterminated quoted field".into());
	}
	if !field.is_empty() || !row.is_empty() {
		row.push(field);
		rows.push(row);
	}
	Ok(rows)
}

/// `parseCsv(text)`: one object per data row keyed by header name, values as strings.
pub fn parse_csv(text: &str) -> Result<Vec<V>, String> {
	let rows = parse_rows(text)?;
	if rows.is_empty() {
		return Ok(Vec::new());
	}
	let header = &rows[0];
	let mut out = Vec::new();
	for (r, row) in rows.iter().enumerate().skip(1) {
		if row.len() == 1 && row[0].is_empty() {
			continue;
		}
		if row.len() != header.len() {
			return Err(format!("CSV: row {} has {} fields, header has {}", r + 1, row.len(), header.len()));
		}
		let o = obj! {};
		for (c, h) in header.iter().enumerate() {
			o.set(h, row[c].as_str());
		}
		out.push(o.into());
	}
	Ok(out)
}

#[cfg(feature = "native")]
const COLUMNS: [&str; 4] = ["ID", "AreaName_lang", "ContinentID", "ParentAreaID"];
const MAX_HOPS: usize = 8;

/// wago.js `compareVersions`.
pub fn compare_versions(a: &str, b: &str) -> std::cmp::Ordering {
	let pa: Vec<f64> = a.split('.').map(crate::js::str_to_num).collect();
	let pb: Vec<f64> = b.split('.').map(crate::js::str_to_num).collect();
	let or0 = |v: &Vec<f64>, i: usize| v.get(i).copied().filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(0.0);
	for i in 0..pa.len().max(pb.len()) {
		let d = or0(&pa, i) - or0(&pb, i);
		if d != 0.0 && !d.is_nan() {
			return d.partial_cmp(&0.0).unwrap();
		}
	}
	std::cmp::Ordering::Equal
}

#[cfg(feature = "native")]
/// BUILD_RE `^\d+(\.\d+)+$`.
fn is_build(b: &str) -> bool {
	let parts: Vec<&str> = b.split('.').collect();
	parts.len() >= 2 && parts.iter().all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_digit()))
}

/// PRODUCTS.forever.family `^1\.6\d\.`.
pub fn is_forever_family(b: &str) -> bool {
	let s = b.as_bytes();
	s.len() >= 5 && &s[..3] == b"1.6" && s[3].is_ascii_digit() && s[4] == b'.'
}

#[cfg(feature = "native")]
fn area_build(sources_dir: &std::path::Path) -> Option<String> {
	let root = sources_dir.join("wago");
	let rd = std::fs::read_dir(&root).ok()?;
	let mut builds: Vec<String> =
		rd.filter_map(|e| e.ok().map(|e| e.file_name().to_string_lossy().into_owned())).filter(|b| is_build(b) && is_forever_family(b) && root.join(b).join("AreaTable.csv").exists()).collect();
	builds.sort_by(|a, b| compare_versions(a, b));
	builds.pop()
}

/// `loadAreas(sourcesDir)` (native): Null without a cached AreaTable. Panics like the JS throws on a
/// malformed table.
#[cfg(feature = "native")]
pub fn load_areas(sources_dir: &std::path::Path) -> V {
	let Some(build) = area_build(sources_dir) else { return V::Null };
	let file = sources_dir.join("wago").join(&build).join("AreaTable.csv");
	let text = std::fs::read_to_string(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()));
	let rows = parse_csv(&text).unwrap_or_else(|e| panic!("{e}"));
	let missing: Vec<&str> = if rows.is_empty() { COLUMNS.to_vec() } else { COLUMNS.iter().copied().filter(|c| !rows[0].has(c)).collect() };
	if !missing.is_empty() {
		panic!("{}: AreaTable lacks column(s) {}", file.display(), missing.join(", "));
	}
	let by_id = obj! {};
	let by_name = obj! {};
	for r in &rows {
		let name_v = r.get("AreaName_lang");
		let name = if name_v.truthy() { name_v.to_js_string() } else { String::new() };
		let parent = r.get("ParentAreaID").num();
		let id = r.get("ID").num();
		let area: V = obj! { "id" => id, "name" => name.as_str(), "c" => r.get("ContinentID").num(), "parent" => if parent != 0.0 && !parent.is_nan() { parent } else { 0.0 } }.into();
		if !crate::js::is_integer(id) || name.is_empty() {
			continue;
		}
		by_id.set(&num_str(id), area.clone());
		let key = name.to_lowercase();
		if !by_name.has(&key) {
			by_name.set(&key, V::arr());
		}
		by_name.get(&key).push(area);
	}
	obj! { "build" => build, "byId" => by_id, "byName" => by_name }.into()
}

/// Whether area `id` is the area `zone` or lies in it (its ParentAreaID chain).
fn within(areas: &V, id: &V, zone: &V) -> bool {
	let by_id = areas.get("byId");
	let mut a = by_id.get(&id.to_js_string());
	let mut hops = 0;
	while a.truthy() && hops < MAX_HOPS {
		if a.get("id").strict_eq(zone) {
			return true;
		}
		let p = a.get("parent");
		a = if p.truthy() { by_id.get(&p.to_js_string()) } else { V::Null };
		hops += 1;
	}
	false
}

/// `areaNamed(areas, name, zone)`: the one area a place name stands for, or Null.
pub fn area_named(areas: &V, name: &V, zone: &V) -> V {
	let Some(name) = name.as_str() else { return V::Null };
	if !areas.truthy() {
		return V::Null;
	}
	let found = areas.get("byName").get(&name.trim().to_lowercase());
	let mut list: Vec<V> = found.items();
	if zone.truthy() {
		let in_zone: Vec<V> = list.iter().filter(|a| within(areas, &a.get("id"), zone)).cloned().collect();
		if !in_zone.is_empty() {
			list = in_zone;
		}
	}
	if list.len() > 1 {
		list.retain(|a| matches!(a.get("c").as_num(), Some(c) if c == 0.0 || c == 1.0));
	}
	if list.len() == 1 {
		list.pop().unwrap()
	} else {
		V::Null
	}
}
