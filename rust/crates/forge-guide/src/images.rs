//! Port of tools/lib/dsl/images.js.
//! Step pictures (docs/GUIDE_FORMAT.md, `image`): a TGA or BLP file in the
//! pack folder, shown in the step's tip area of the guide window.
//!
//! parse_image_path(text) -> Ok(ImagePath { path, ext }) | Err(ImageError { error, hint })
//!   the path rules (the runtime's in Core/Guides.lua, checkImage): inside the
//!   pack folder, folders and the name of letters, digits, `_` and `-`
//!   separated by `/`, a `.tga` or `.blp` extension or none. `path` has no
//!   extension; `ext` is the one written (lower case) or None.
//! check_images(guides, pack_dir, diag) — compile time, before the guides'
//!   texts are tokenised: finds each step's file in the pack folder (a warning
//!   when it is not there), fills in the size the author left out from the
//!   file's header, and warns about a size that is not a power of two.
//! image_files(guides) -> [(rel, abs)] — the files the addon folder carries,
//!   sorted by rel, each at its path in the pack folder.
//! The file-reading functions are behind the `native` feature.

#[cfg(feature = "native")]
use crate::diag::Diagnostics;
#[cfg(feature = "native")]
use crate::js::V;
#[cfg(feature = "native")]
use std::path::Path;

/// The texture files the client draws for an addon.
pub const IMAGE_EXTS: [&str; 2] = [".tga", ".blp"];
const EXAMPLE: &str = "image media/fargodeep-mine.tga";

#[derive(Clone, Debug, PartialEq)]
pub struct ImagePath {
	pub path: String,
	pub ext: Option<String>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct ImageError {
	pub error: String,
	pub hint: String,
}

fn segment_ok(p: &str) -> bool {
	!p.is_empty() && p.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_' || b == b'-')
}

pub fn parse_image_path(s: &str) -> Result<ImagePath, ImageError> {
	let shown = format!("image path \"{s}\"");
	let b = s.as_bytes();
	if b.first().is_some_and(|&c| c == b'\\' || c == b'/') || (b.len() >= 2 && b[0].is_ascii_alphabetic() && b[1] == b':') {
		return Err(ImageError { error: format!("{shown} is absolute"), hint: format!("write it from the pack folder: `{EXAMPLE}`") });
	}
	if s.contains('\\') {
		return Err(ImageError { error: format!("{shown} has a \\"), hint: format!("separate folders with /: `{EXAMPLE}`") });
	}
	let mut parts: Vec<String> = s.split('/').map(str::to_string).collect();
	if parts.iter().any(|p| p == ".." || p == ".") {
		return Err(ImageError { error: format!("{shown} leaves the pack folder"), hint: format!("put the picture inside the pack folder and write its path from there: `{EXAMPLE}`") });
	}
	let last = parts.last().unwrap().clone();
	let mut ext = None;
	if let Some(dot) = last.rfind('.') {
		let e = last[dot..].to_lowercase();
		if !IMAGE_EXTS.contains(&e.as_str()) {
			return Err(ImageError { error: format!("{shown}: the game draws .tga and .blp pictures, not {e}"), hint: "save the picture as a .tga file (or .blp)".into() });
		}
		*parts.last_mut().unwrap() = last[..dot].to_string();
		ext = Some(e);
	}
	if parts.iter().any(|p| !segment_ok(p)) {
		return Err(ImageError { error: format!("{shown} has a character the game's paths do not take"), hint: "name the folders and the file with letters, digits, _ and - only".into() });
	}
	Ok(ImagePath { path: parts.join("/"), ext })
}

/// "512x256" -> (w, h) | None.
pub fn parse_image_size(text: &str) -> Option<(f64, f64)> {
	let (a, b) = text.split_once('x')?;
	let dig = |s: &str| !s.is_empty() && s.bytes().all(|c| c.is_ascii_digit());
	if !dig(a) || !dig(b) {
		return None;
	}
	let w = crate::js::str_to_num(a);
	let h = crate::js::str_to_num(b);
	if w > 0.0 && h > 0.0 {
		Some((w, h))
	} else {
		None
	}
}

/// The file a step's picture names, found in the pack folder: the extension
/// written, else .tga, then .blp; the name as written, the extension in any
/// case. -> (absolute path, path relative to the pack folder with `/`) | None.
#[cfg(feature = "native")]
fn find_image(pack_dir: &Path, path: &str, ext: Option<&str>) -> Option<(String, String)> {
	let mut parts: Vec<&str> = path.split('/').collect();
	let name = parts.pop().unwrap();
	let mut dir = pack_dir.to_path_buf();
	for p in &parts {
		dir.push(p);
	}
	let rd = std::fs::read_dir(&dir).ok()?;
	// libuv's scandir sorts the names (strcmp order).
	let mut entries: Vec<(String, bool)> = Vec::new();
	for e in rd {
		let e = e.ok()?;
		let is_file = e.file_type().map(|t| t.is_file()).unwrap_or(false);
		entries.push((e.file_name().to_string_lossy().into_owned(), is_file));
	}
	entries.sort_by(|a, b| a.0.as_bytes().cmp(b.0.as_bytes()));
	let exts: Vec<&str> = match ext {
		Some(e) => vec![e],
		None => IMAGE_EXTS.to_vec(),
	};
	let nlen = name.encode_utf16().count();
	for ext in exts {
		let hit = entries.iter().find(|(n, f)| *f && n.encode_utf16().count() == nlen + ext.len() && n.starts_with(name) && n[name.len()..].to_lowercase() == ext);
		if let Some((n, _)) = hit {
			let abs = dir.join(n).to_string_lossy().into_owned();
			let mut rel: Vec<&str> = parts.clone();
			rel.push(n);
			return Some((abs, rel.join("/")));
		}
	}
	None
}

/// A TGA's or BLP's size from its header -> (w, h) | None. TGA: 16-bit
/// width and height at bytes 12 and 14; BLP1/BLP2: 32-bit at 12 and 16.
#[cfg(feature = "native")]
pub fn image_size(file: &Path) -> Option<(f64, f64)> {
	use std::io::Read;
	let mut f = std::fs::File::open(file).ok()?;
	let mut buf = [0u8; 20];
	let mut len = 0;
	while len < 20 {
		match f.read(&mut buf[len..]) {
			Ok(0) => break,
			Ok(n) => len += n,
			Err(_) => return None,
		}
	}
	let buf = &buf[..len];
	let magic = &buf[..len.min(4)];
	let (mut w, mut h) = (0u32, 0u32);
	if (magic == b"BLP1" || magic == b"BLP2") && buf.len() >= 20 {
		w = u32::from_le_bytes(buf[12..16].try_into().unwrap());
		h = u32::from_le_bytes(buf[16..20].try_into().unwrap());
	} else if file.extension().is_some_and(|e| e.to_string_lossy().to_lowercase() == "tga") && buf.len() >= 18 && [1u8, 2, 3, 9, 10, 11].contains(&buf[2]) {
		w = u16::from_le_bytes([buf[12], buf[13]]) as u32;
		h = u16::from_le_bytes([buf[14], buf[15]]) as u32;
	}
	if w > 0 && h > 0 {
		Some((w as f64, h as f64))
	} else {
		None
	}
}

#[cfg(feature = "native")]
/// `n > 0 && (n & (n - 1)) === 0` with JS's 32-bit `&`.
fn power_of_two(n: f64) -> bool {
	let i32_of = |x: f64| (x as i64) as i32;
	n > 0.0 && (i32_of(n) & i32_of(n - 1.0)) == 0
}

/// Each step's hidden `_imageSpec` ({ path, ext, line }) looked up in the pack
/// folder; sets the hidden `_imageFile` ({ abs, rel }) and fills `image.w/h`.
#[cfg(feature = "native")]
pub fn check_images(guides: &[V], pack_dir: &Path, diag: &mut Diagnostics) {
	for g in guides {
		let ast = g.hidden("_ast");
		// An absent file reads as no file (diag prints none).
		let file = if ast.truthy() { ast.get("file").as_str().unwrap_or("").to_string() } else { String::new() };
		for step in g.get("steps").items() {
			let spec = step.hidden("_imageSpec");
			let image = step.get("image");
			if !spec.truthy() || !image.truthy() {
				continue;
			}
			let path = spec.get("path").to_js_string();
			let ext = spec.get("ext");
			let ext = if ext.truthy() { Some(ext.to_js_string()) } else { None };
			let line = spec.get("line").num();
			let where_ = format!("{path}{}", ext.as_deref().unwrap_or(""));
			let Some((abs, rel)) = find_image(pack_dir, &path, ext.as_deref()) else {
				let tried = match &ext {
					Some(e) => format!("{path}{e}"),
					None => IMAGE_EXTS.iter().map(|e| format!("{path}{e}")).collect::<Vec<_>>().join(" or "),
				};
				diag.warn(
					&file,
					line,
					format!("image {where_}: the pack folder has no {tried}, so the step shows no picture"),
					Some("put the picture in the pack folder at that path (a .tga or .blp file), or fix the path".into()),
				);
				continue;
			};
			step.set_hidden("_imageFile", crate::obj! { "abs" => abs.as_str(), "rel" => rel.as_str() });
			let Some((w, h)) = image_size(Path::new(&abs)) else {
				if image.get("w").is_undef() {
					diag.warn(
						&file,
						line,
						format!("image {rel} is not a TGA or BLP picture Polestar can read the size of"),
						Some("save it as a .tga file, or give its size: `image <path> <width>x<height>`".into()),
					);
				}
				continue;
			};
			if !power_of_two(w) || !power_of_two(h) {
				diag.warn(
					&file,
					line,
					format!("image {rel} is {}x{}: the game may not draw a texture whose sides are not powers of two", crate::js::num_str(w), crate::js::num_str(h)),
					Some("save it at a size such as 512x256 or 512x512".into()),
				);
			}
			if image.get("w").is_undef() {
				image.set("w", w);
				image.set("h", h);
			}
		}
	}
}

/// The pictures' files, (rel, abs) sorted by rel (later steps win a rel).
#[cfg(feature = "native")]
pub fn image_files(guides: &[V]) -> Vec<(String, String)> {
	let mut out: Vec<(String, String)> = Vec::new();
	for g in guides {
		for step in g.get("steps").items() {
			let f = step.hidden("_imageFile");
			if f.truthy() {
				let rel = f.get("rel").to_js_string();
				let abs = f.get("abs").to_js_string();
				match out.iter_mut().find(|(r, _)| *r == rel) {
					Some(e) => e.1 = abs,
					None => out.push((rel, abs)),
				}
			}
		}
	}
	out.sort_by(|a, b| crate::js::cmp_utf16(&a.0, &b.0));
	out
}
