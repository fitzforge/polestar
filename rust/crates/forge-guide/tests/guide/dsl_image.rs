//! A step's picture (docs/GUIDE_FORMAT.md, `image`): the compiler writes its path in the pack's addon folder
//! and its size, the pack's addon folder carries the file, and lint refuses a path outside the pack folder or
//! of a kind the game does not draw, and warns about a file it cannot find or use.

use crate::common;
use common::*;
use forge_guide::project::{build_pack, write_pack_dir, BuildOpts, FileContent};
use serde_json::json;
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

/// A TGA's or BLP2's header for a w x h picture (the pixels do not matter).
fn tga(w: u16, h: u16) -> Vec<u8> {
	let mut b = vec![0u8; 18 + 16];
	b[2] = 2;
	b[12..14].copy_from_slice(&w.to_le_bytes());
	b[14..16].copy_from_slice(&h.to_le_bytes());
	b[16] = 32;
	b
}

fn blp(w: u32, h: u32) -> Vec<u8> {
	let mut b = vec![0u8; 32];
	b[0..4].copy_from_slice(b"BLP2");
	b[4..8].copy_from_slice(&1u32.to_le_bytes());
	b[12..16].copy_from_slice(&w.to_le_bytes());
	b[16..20].copy_from_slice(&h.to_le_bytes());
	b
}

/// A pack folder holding `files` beside pack.json.
fn pack_dir(name: &str, files: &[(&str, Vec<u8>)]) -> PathBuf {
	let dir = scratch(&format!("image-{name}"));
	std::fs::write(dir.join("pack.json"), r#"{"id":"pix","title":"Pix","author":"Ann","version":"1.0.0","license":"CC0-1.0"}"#).unwrap();
	for (rel, content) in files {
		let p = dir.join(rel);
		std::fs::create_dir_all(p.parent().unwrap()).unwrap();
		std::fs::write(p, content).unwrap();
	}
	dir
}

const GUIDE: &str = "guide pix/a\ntitle Pix A\nfaction Alliance\nlevels 1-6\nzone Elwynn Forest\n\nstep Deputy Willem\n  tip The mine mouth is behind the farm.\n  image media/fargodeep-mine\n  accept 783\n\nstep Marshal McBride\n  image media/shots/gate.blp 1024x512\n  turnin 783\n\nstep No picture\n  tip Nothing to see.\n  level 2\n";

struct Built {
	folder: String,
	warnings: Vec<String>,
	files: Vec<(String, FileContent)>,
}

impl Built {
	fn text(&self, name: &str) -> String {
		match &self.files.iter().find(|(n, _)| n == name).unwrap().1 {
			FileContent::Text(t) => t.clone(),
			FileContent::Bytes(b) => String::from_utf8_lossy(b).into_owned(),
		}
	}
	fn bytes(&self) -> BTreeMap<String, Vec<u8>> {
		self.files
			.iter()
			.filter(|(n, _)| n.starts_with("media/"))
			.map(|(n, c)| {
				let b = match c {
					FileContent::Text(t) => t.clone().into_bytes(),
					FileContent::Bytes(b) => b.clone(),
				};
				(n.clone(), b)
			})
			.collect()
	}
}

fn build(dir: &Path) -> Built {
	let (manifest, diags) = forge_guide::manifest::read_manifest(dir, false);
	assert!(diags.is_empty(), "{diags:?}");
	let manifest = manifest.unwrap();
	let data = fixture_data();
	let b = build_pack(&repo(), dir, &manifest, Vec::new(), &data, forge_guide::diag::Diagnostics::new(), BuildOpts { include_drafts: false, context: None, force: false }).unwrap();
	assert!(b.project.diag.errors().is_empty(), "{:?}", b.project.diag.sorted());
	Built { folder: manifest.get("folder").to_js_string(), warnings: b.project.diag.warnings().iter().map(|w| w.message.clone()).collect(), files: b.files.unwrap() }
}

#[test]
fn a_step_picture_compiles_to_its_path_in_the_addon_folder_and_its_size_read_from_the_file_when_the_guide_gives_none() {
	let (cave, gate) = (tga(512, 256), blp(256, 128));
	let dir = pack_dir("compile", &[("guides/a.guide", GUIDE.as_bytes().to_vec()), ("media/fargodeep-mine.tga", cave.clone()), ("media/shots/gate.blp", gate.clone())]);
	let b = build(&dir);
	assert!(b.warnings.is_empty(), "{:?}", b.warnings);
	let lua = b.text("Guides.lua");
	assert_match(&lua, r#"note = "The mine mouth is behind the farm\.",\n\t+image = \{ file = "media\\\\fargodeep-mine", w = 512, h = 256 \},\n"#);
	// The size the guide gives wins over the file's (the shown aspect).
	assert_match(&lua, r#"image = \{ file = "media\\\\shots\\\\gate", w = 1024, h = 512 \},"#);
	assert_eq!(lua.matches("image = ").count(), 2, "a step without a picture has no image key");
	// The addon folder carries each file at its path in the pack folder.
	let media = b.bytes();
	assert_eq!(media["media/fargodeep-mine.tga"], cave);
	assert_eq!(media["media/shots/gate.blp"], gate);
	let out = scratch("image-out").join(&b.folder);
	write_pack_dir(&out, &b.files).unwrap();
	assert_eq!(std::fs::read(out.join("media/fargodeep-mine.tga")).unwrap(), cave);
	assert_eq!(std::fs::read(out.join("media/shots/gate.blp")).unwrap(), gate);
	assert!(out.join("Guides.lua").exists());
}

#[test]
fn without_the_extension_the_picture_is_the_tga_else_the_blp_whatever_the_extensions_case() {
	let guide = GUIDE.replace("media/shots/gate.blp 1024x512", "media/shots/gate");
	let dir = pack_dir("ext", &[("guides/a.guide", guide.into_bytes()), ("media/fargodeep-mine.TGA", tga(512, 512)), ("media/shots/gate.blp", blp(128, 64))]);
	let b = build(&dir);
	let lua = b.text("Guides.lua");
	assert_match(&lua, r#"image = \{ file = "media\\\\fargodeep-mine", w = 512, h = 512 \},"#);
	assert_match(&lua, r#"image = \{ file = "media\\\\shots\\\\gate", w = 128, h = 64 \},"#);
	assert_eq!(b.bytes().keys().collect::<Vec<_>>(), ["media/fargodeep-mine.TGA", "media/shots/gate.blp"]);
}

#[test]
fn lint_warns_about_a_picture_the_pack_folder_lacks_one_of_a_size_that_is_no_power_of_two_and_a_file_it_cannot_read() {
	let dir = pack_dir("lint", &[("media/odd.tga", tga(600, 400)), ("media/junk.tga", b"not a picture".to_vec())]);
	let text = guide_text(&["step A", "  image media/missing", "  level 2", "step B", "  image media/odd.tga", "  level 3", "step C", "  image media/junk", "  level 4"]);
	let r = compile_in(&text, &dir);
	assert!(r.errors.is_empty(), "{}", r.text);
	let at = |n: &str| format!("test.guide:{}", line_of(&text, n));
	assert_eq!(
		r.warnings,
		vec![
			format!("{}: image media/missing: the pack folder has no media/missing.tga or media/missing.blp, so the step shows no picture", at("image media/missing")),
			format!("{}: image media/odd.tga is 600x400: the game may not draw a texture whose sides are not powers of two", at("image media/odd.tga")),
			format!("{}: image media/junk.tga is not a TGA or BLP picture Polestar can read the size of", at("image media/junk")),
		]
	);
	// A missing file is shown as nothing: the step keeps its path, the addon folder no file.
	let steps = r.steps();
	assert_eq!(steps[0]["image"], json!({ "file": "media\\missing" }));
	assert_eq!(steps[1]["image"], json!({ "file": "media\\odd", "w": 600, "h": 400 }));
}

#[cfg(unix)]
#[test]
fn a_media_folder_linked_out_of_the_pack_folder_holds_no_picture() {
	let outside = scratch("image-outside");
	std::fs::write(outside.join("cave.tga"), tga(64, 64)).unwrap();
	let dir = pack_dir("linked", &[]);
	std::os::unix::fs::symlink(&outside, dir.join("media")).unwrap();
	let text = guide_text(&["step A", "  image media/cave", "  level 2"]);
	let r = compile_in(&text, &dir);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.warnings.len(), 1, "{:?}", r.warnings);
	assert!(r.warnings[0].contains("the pack folder has no media/cave.tga"), "{:?}", r.warnings);
	assert_eq!(r.steps()[0]["image"], json!({ "file": "media\\cave" }));
}

#[test]
fn lint_refuses_a_picture_outside_the_pack_folder_of_a_kind_the_game_does_not_draw_or_written_wrong() {
	let bad = [
		("image /media/cave.tga", r#"image path "/media/cave\.tga" is absolute"#),
		("image C:/shots/cave.tga", r#"image path "C:/shots/cave\.tga" is absolute"#),
		("image ../shared/cave.tga", r#"image path "\.\./shared/cave\.tga" leaves the pack folder"#),
		("image media/../../cave.tga", r"leaves the pack folder"),
		("image media\\cave.tga", r"has a \\"),
		("image media/cave.png", r"the game draws \.tga and \.blp pictures, not \.png"),
		("image media/cave.jpg 512x256", r"not \.jpg"),
		("image \"media/my cave.tga\"", r"has a character the game's paths do not take"),
		("image media/cave.tga 512", r#"malformed picture size "512""#),
		("image media/cave.tga 0x256", r#"malformed picture size "0x256""#),
		("image media/cave.tga 512x256 big", r#"unexpected "big" after the picture's size"#),
		("image", r"`image` needs the picture's path in the pack folder"),
		("image media/cave.tga -- the mine", r"notes \(` -- `\) are only allowed on goal lines"),
	];
	for (line, message) in bad {
		let r = compile(&guide_text(&["step A", &format!("  {line}"), "  level 2"]));
		assert!(r.errors.iter().any(|e| re(message).is_match(e)), "{line}: {:?}", r.errors);
	}
	let twice = compile(&guide_text(&["step A", "  image media/a.tga", "  image media/b.tga", "  level 2"]));
	assert_eq!(twice.errors, ["test.guide:9: duplicate `image` in step (first on line 8): a step shows one picture"]);
}

#[test]
fn a_guide_compiled_without_its_pack_folder_keeps_the_size_it_gives_and_checks_no_file() {
	let r = compile(&guide_text(&["step A", "  image media/cave.tga 512x256", "  level 2", "step B", "  image media/other", "  level 3"]));
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	let images: Vec<_> = r.steps().iter().map(|s| s["image"].clone()).collect();
	assert_eq!(images, [json!({ "file": "media\\cave", "w": 512, "h": 256 }), json!({ "file": "media\\other" })]);
}
