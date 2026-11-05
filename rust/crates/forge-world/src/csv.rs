//! RFC-4180 CSV (port of tools/lib/data/csv.js): quoted fields, doubled quotes, embedded
//! newlines, CRLF, a header row; rows keyed by header name.

use rustc_hash::FxHashMap;

pub fn parse_rows(text: &str) -> Result<Vec<Vec<String>>, String> {
	let mut rows = Vec::new();
	let mut row: Vec<String> = Vec::new();
	let mut field = String::new();
	let mut quoted = false;
	let text = text.strip_prefix('\u{feff}').unwrap_or(text);
	let mut it = text.chars().peekable();
	while let Some(c) = it.next() {
		if quoted {
			if c == '"' {
				if it.peek() == Some(&'"') {
					field.push('"');
					it.next();
					continue;
				}
				quoted = false;
				continue;
			}
			field.push(c);
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
			_ => field.push(c),
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

pub fn parse_csv(text: &str) -> Result<Vec<FxHashMap<String, String>>, String> {
	let rows = parse_rows(text)?;
	let Some(header) = rows.first() else { return Ok(Vec::new()) };
	let mut out = Vec::with_capacity(rows.len());
	for (r, row) in rows.iter().enumerate().skip(1) {
		if row.len() == 1 && row[0].is_empty() {
			continue;
		}
		if row.len() != header.len() {
			return Err(format!("CSV: row {} has {} fields, header has {}", r + 1, row.len(), header.len()));
		}
		out.push(header.iter().cloned().zip(row.iter().cloned()).collect());
	}
	Ok(out)
}
