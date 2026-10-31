//! Port of tools/lib/pack/manifest.js.
//!
//! pack.json: a guide pack's manifest. read_manifest reads and validates it
//! (native only); validate_manifest checks an already parsed object.
//! Diagnostics carry a 1-based line: the line of the key in pack.json when it
//! can be found, else 1.

use crate::diag::Diag;
use crate::emit::is_js_space;
use crate::format::{is_folder, is_pack_id, RESERVED_IDS};
use crate::js::{json_quote, V};

const REQUIRED: [&str; 5] = ["id", "title", "author", "version", "license"];
const KEYS: [&str; 9] = ["id", "title", "author", "version", "license", "website", "source", "notes", "folder"];

fn max_length(key: &str) -> Option<usize> {
	Some(match key {
		"title" | "author" | "license" => 64,
		"website" | "source" | "notes" => 200,
		_ => return None,
	})
}

/// Shown to players: a `|` there starts an escape sequence in the game's text.
const DISPLAYED: [&str; 6] = ["title", "author", "license", "website", "source", "notes"];
const ID_HINT: &str = "pick an id like `<author>-<name>`, e.g. \"joe-routes\"";
/// Polestar shows author text as written (every `|` escaped), so escape codes
/// do not work; guide lint (validate.rs) gives the same hint.
pub const PIPE_HINT: &str = "drop the `|`: Polestar shows it as written, so colour and link codes like `|cff` do not work";

/// A value for each key, for the hints.
fn example_value(key: &str) -> &'static str {
	match key {
		"id" => "joe-routes",
		"title" => "Joe's Routes",
		"author" => "Joe",
		"version" => "1.0.0",
		"license" => "CC-BY-4.0",
		"website" => "https://github.com/joe/joe-routes",
		"source" => "https://github.com/joe/joe-routes",
		"notes" => "Leveling routes for Elwynn Forest and Westfall",
		"folder" => "PolestarPack_JoesRoutes",
		_ => unreachable!(),
	}
}

fn example(key: &str) -> String {
	let mut v = String::new();
	json_quote(&mut v, example_value(key));
	format!("\"{key}\": {v}")
}

/// VERSION_RE: /^[0-9A-Za-z][0-9A-Za-z.+-]{0,31}$/
fn is_version(s: &str) -> bool {
	let b = s.as_bytes();
	(1..=32).contains(&b.len()) && b[0].is_ascii_alphanumeric() && b[1..].iter().all(|c| c.is_ascii_alphanumeric() || matches!(c, b'.' | b'+' | b'-'))
}

/// CONTROL_RE: /[\u0000-\u001f\u007f]/
fn has_control(s: &str) -> bool {
	s.chars().any(|c| (c as u32) < 0x20 || c as u32 == 0x7f)
}

/// OUR_FOLDER_RE: /^polestar($|_)/i
fn is_our_folder(s: &str) -> bool {
	s.len() >= 8 && s.as_bytes()[..8].eq_ignore_ascii_case(b"polestar") && (s.len() == 8 || s.as_bytes()[8] == b'_')
}

/// 1-based line of `"key":` in the JSON text, else 1.
fn key_line(text: Option<&str>, key: &str) -> f64 {
	let Some(text) = text.filter(|t| !t.is_empty()) else { return 1.0 };
	let needle = format!("\"{key}\"");
	let mut from = 0;
	while let Some(i) = text[from..].find(&needle) {
		let at = from + i;
		let rest = text[at + needle.len()..].trim_start_matches(is_js_space);
		if rest.starts_with(':') {
			return (text[..at].matches('\n').count() + 1) as f64;
		}
		from = at + 1;
	}
	1.0
}

/// `official`, `text`: the JS options (text: pack.json's source, for lines).
pub fn validate_manifest(obj: &V, file: &str, official: bool, text: Option<&str>) -> Vec<Diag> {
	let mut diags = Vec::new();
	let mut add = |severity: &'static str, key: Option<&str>, message: String, hint: String| {
		diags.push(Diag { severity, file: Some(file.to_string()), line: key.map_or(1.0, |k| key_line(text, k)), message, hint: Some(hint) });
	};
	let Some(o) = obj.as_obj() else {
		add("error", None, "pack.json must hold one JSON object".into(), "write `{ \"id\": \"...\", \"title\": \"...\", \"author\": \"...\", \"version\": \"...\", \"license\": \"...\" }`".into());
		return diags;
	};
	for key in o.keys() {
		if !KEYS.contains(&&*key) {
			add("warning", Some(&key), format!("unknown key `{key}` (ignored)"), format!("pack.json takes {}", KEYS.map(|k| format!("`{k}`")).join(", ")));
		}
	}
	for key in KEYS {
		let v = o.get(key);
		if v.is_nullish() || v.as_str() == Some("") {
			if REQUIRED.contains(&key) {
				add("error", Some(key), format!("missing `{key}`"), format!("add {} (with your own value) to pack.json", example(key)));
			}
			continue;
		}
		let Some(v) = v.as_str() else {
			add("error", Some(key), format!("`{key}` must be a string"), format!("write the value in quotes, like {}", example(key)));
			continue;
		};
		if has_control(v) {
			add("error", Some(key), format!("`{key}` contains control characters (line breaks, tabs or other invisible characters)"), format!("keep `{key}` on one line without control characters"));
			continue;
		}
		if let Some(max) = max_length(key) {
			let len = v.encode_utf16().count();
			if len > max {
				add("error", Some(key), format!("`{key}` is {len} characters long; at most {max} fit"), format!("shorten `{key}` to {max} characters or fewer"));
				continue;
			}
		}
		if DISPLAYED.contains(&key) && v.contains('|') {
			add("warning", Some(key), format!("`{key}` contains \"|\", which prints literally in game"), PIPE_HINT.into());
		}
		match key {
			"id" => {
				if !is_pack_id(v) {
					add("error", Some(key), format!("pack id \"{v}\" is malformed: 2 to 32 lowercase letters, digits and dashes, starting with a letter or digit"), ID_HINT.into());
				} else if RESERVED_IDS.contains(&v) && !(official && v == "guides") {
					add("error", Some(key), format!("pack id \"{v}\" is reserved for Polestar ({} are)", RESERVED_IDS.map(|r| format!("\"{r}\"")).join(", ")), ID_HINT.into());
				}
			}
			"version" => {
				if !is_version(v) {
					add(
						"error",
						Some(key),
						format!("version \"{v}\" is malformed: one word of letters, digits, \".\", \"+\" and \"-\", at most 32 characters"),
						"write a version like \"1.2.0\"".into(),
					);
				}
			}
			"website" => {
				if !(v.starts_with("https://") || v.starts_with("http://")) {
					add("error", Some(key), format!("website \"{v}\" must start with https:// or http://"), "write the full address, like \"https://github.com/you/your-pack\"".into());
				}
			}
			"folder" => {
				if !is_folder(v) {
					add(
						"error",
						Some(key),
						format!("folder \"{v}\" is malformed: 1 to 64 letters, digits, \"_\" and \"-\""),
						"pick a folder like \"PolestarPack_JoesRoutes\", or leave `folder` out for the default".into(),
					);
				} else if is_our_folder(v) && !(official && v == "Polestar_Guides") {
					add(
						"error",
						Some(key),
						format!("folder \"{v}\" looks like one of Polestar's own addons"),
						"pick a folder that does not start with \"Polestar_\", like \"PolestarPack_JoesRoutes\"".into(),
					);
				}
			}
			_ => {}
		}
	}
	diags
}

/// `path.resolve(p)` against the working directory, lexically normalised.
#[cfg(feature = "native")]
fn resolve(p: &std::path::Path) -> std::path::PathBuf {
	use std::path::Component;
	let joined = std::env::current_dir().unwrap_or_default().join(p);
	let mut out = std::path::PathBuf::new();
	for c in joined.components() {
		match c {
			Component::CurDir => {}
			Component::ParentDir => {
				out.pop();
			}
			c => out.push(c),
		}
	}
	out
}

/// Shows a path the way diagnostics do: relative to the working directory when inside it.
#[cfg(feature = "native")]
fn shown(p: &std::path::Path) -> String {
	let abs = resolve(p);
	let cwd = resolve(std::path::Path::new("."));
	match abs.strip_prefix(&cwd) {
		Ok(rel) => rel.components().map(|c| c.as_os_str().to_string_lossy().into_owned()).collect::<Vec<_>>().join("/"),
		Err(_) => p.to_string_lossy().into_owned(),
	}
}

/// A file the pack folder itself holds (pack.json, LICENSE, retired.json, legs.json): Ok(Some(text)),
/// Ok(None) when there is none (or it cannot be read), or Err when it is a link, not a plain file,
/// or lies outside the folder once links are resolved: a pack handed over as a repository or an
/// archive must not pull another file of the machine (a token, a key) into the build or its
/// messages. (pack/manifest.js readPackFile)
#[cfg(feature = "native")]
pub fn read_pack_file(dir: &std::path::Path, name: &str) -> Result<Option<String>, String> {
	let file = dir.join(name);
	let Ok(meta) = std::fs::symlink_metadata(&file) else { return Ok(None) };
	if !meta.file_type().is_file() {
		return Err(format!("{name} is a link or not a plain file; Polestar reads only a plain file in the pack folder"));
	}
	let (Ok(root), Ok(real)) = (std::fs::canonicalize(dir), std::fs::canonicalize(&file)) else { return Ok(None) };
	if real.strip_prefix(&root).ok() != Some(std::path::Path::new(name)) {
		return Err(format!("{name} lies outside the pack folder; Polestar reads only a plain file in the pack folder"));
	}
	Ok(std::fs::read_to_string(&file).ok())
}

/// -> (manifest, diags); manifest is None when there are errors.
/// Not exact: a JSON syntax error's `(…)` detail is this crate's parser message, not V8's.
#[cfg(feature = "native")]
pub fn read_manifest(dir: &std::path::Path, official: bool) -> (Option<V>, Vec<Diag>) {
	let abs = dir.join("pack.json");
	let file = shown(&abs);
	let err = |message: String, hint: &str| Diag { severity: "error", file: Some(file.clone()), line: 1.0, message, hint: Some(hint.into()) };
	let mut text = match read_pack_file(dir, "pack.json") {
		Ok(Some(t)) => t,
		Ok(None) => {
			let d = shown(dir);
			let d = if d.is_empty() { ".".to_string() } else { d };
			return (None, vec![err(format!("no pack.json in {d}"), "create pack.json with id, title, author, version and license")]);
		}
		Err(e) => return (None, vec![err(e, "make pack.json a plain file of the pack folder")]),
	};
	// Editors on Windows may save a byte order mark; JSON.parse rejects it.
	if text.starts_with('\u{feff}') {
		text.drain(..'\u{feff}'.len_utf8());
	}
	let obj = match crate::js::parse_json(&text) {
		Ok(v) => v,
		Err(e) => return (None, vec![err(format!("pack.json is not valid JSON ({e})"), "check for a missing value, quote or comma; JSON allows no trailing commas or comments")]),
	};
	let diags = validate_manifest(&obj, &file, official, Some(&text));
	if diags.iter().any(|d| d.severity == "error") {
		return (None, diags);
	}
	let manifest = V::obj();
	for key in KEYS {
		if let Some(s) = obj.get(key).as_str().filter(|s| !s.is_empty()) {
			manifest.set(key, s);
		}
	}
	if !manifest.get("folder").truthy() {
		let folder = crate::format::default_folder(manifest.get("title").as_str(), manifest.get("id").as_str());
		manifest.set("folder", folder);
	}
	(Some(manifest), diags)
}
