//! Release notes from CHANGELOG.md: a version's section in the three forms a release is announced in
//! (docs/RELEASING.md, steps 8 to 10). GitHub's notes carry the players' and guide authors' entries,
//! CurseForge's the players' only, and Discord's are split into posts under Discord's message limit.
//! The intro is the maintainer's to write: each form carries a placeholder for it ([`PLACEHOLDER`]),
//! which must be replaced before publishing.

use std::sync::LazyLock;

const REPO: &str = "https://github.com/fitzforge/polestar";
const CURSEFORGE: &str = "https://www.curseforge.com/wow/addons/polestar-guides";
const DISCORD: &str = "https://discord.gg/polestar";
/// Discord's message limit for accounts without Nitro.
pub const DISCORD_LIMIT: usize = 2000;
pub const PLACEHOLDER: &str = "[[REPLACE";

const MONTHS: [&str; 12] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

fn re(p: &str) -> regex::Regex {
	regex::Regex::new(p).unwrap()
}

static ITEM: LazyLock<regex::Regex> = LazyLock::new(|| re(r"^\s*(?:[-*+]|\d+\.)\s"));
static FENCE: LazyLock<regex::Regex> = LazyLock::new(|| re(r"^\s*```"));

fn lines(text: &str) -> Vec<&str> {
	text.split('\n').map(|l| l.strip_suffix('\r').unwrap_or(l)).collect()
}

/// Wrapped text with each paragraph and list item on one line; fenced code and blank lines kept, runs
/// of blank lines made one.
pub fn join_lines(text: &str) -> String {
	let mut out: Vec<String> = Vec::new();
	let mut cur: Option<String> = None;
	let mut fence = false;
	for line in lines(text) {
		if FENCE.is_match(line) {
			out.extend(cur.take());
			fence = !fence;
			out.push(line.to_string());
		} else if fence {
			out.push(line.to_string());
		} else if line.trim().is_empty() {
			out.extend(cur.take());
			if out.last().is_some_and(|l| !l.is_empty()) {
				out.push(String::new());
			}
		} else if ITEM.is_match(line) || line.starts_with('#') || cur.is_none() {
			out.extend(cur.take());
			cur = Some(line.trim_end().to_string());
		} else if let Some(c) = cur.as_mut() {
			c.push(' ');
			c.push_str(line.trim());
		}
	}
	out.extend(cur);
	let start = out.iter().position(|l| !l.is_empty()).unwrap_or(out.len());
	let end = out.iter().rposition(|l| !l.is_empty()).map_or(start, |i| i + 1);
	out[start..end.max(start)].join("\n")
}

/// A version's section of the changelog, each part its text joined ([`join_lines`]), "" when absent.
#[derive(Clone, Debug, Default)]
pub struct Release {
	pub version: String,
	pub date: String,
	pub players: String,
	pub authors: String,
	pub contributors: String,
	pub forge: String,
}

/// The `## <version> (<date>)` section; None when the changelog has none.
pub fn release_section(changelog: &str, version: &str) -> Option<Release> {
	let all = lines(changelog);
	let head = re(&format!(r"^## {} \((\d{{4}}-\d{{2}}-\d{{2}})\)\s*$", regex::escape(version)));
	let start = all.iter().position(|l| head.is_match(l))?;
	let end = all.iter().enumerate().skip(start + 1).find(|(_, l)| l.starts_with("## ")).map_or(all.len(), |(i, _)| i);
	static SUB: LazyLock<regex::Regex> = LazyLock::new(|| re(r"^### (.+?)\s*$"));
	let mut parts: [Vec<&str>; 4] = Default::default();
	let mut part: Option<usize> = None;
	for line in &all[start + 1..end] {
		if let Some(m) = SUB.captures(line) {
			part = ["For players", "For guide authors", "For contributors", "Forge"].iter().position(|h| *h == &m[1]);
		} else if let Some(p) = part {
			parts[p].push(line);
		}
	}
	let date = head.captures(all[start]).map(|c| c[1].to_string()).unwrap_or_default();
	let [players, authors, contributors, forge] = parts.map(|p| join_lines(&p.join("\n")));
	Some(Release { version: version.to_string(), date, players, authors, contributors, forge })
}

/// A name's sort key: accents and case ignored (`localeCompare` with base sensitivity, for names).
fn base_key(s: &str) -> String {
	use unicode_normalization::UnicodeNormalization;
	s.nfkd().filter(|c| !('\u{300}'..='\u{36f}').contains(c)).flat_map(char::to_lowercase).collect()
}

/// The names thanked in the entries ("(thanks A, B and C)"), sorted, once each.
pub fn thanked(text: &str) -> Vec<String> {
	static THANKS: LazyLock<regex::Regex> = LazyLock::new(|| re(r"\(thanks ([^)]+)\)"));
	static SPLIT: LazyLock<regex::Regex> = LazyLock::new(|| re(r",\s*|\s+and\s+"));
	let mut names: Vec<String> = Vec::new();
	for m in THANKS.captures_iter(text) {
		for n in SPLIT.split(&m[1]) {
			let n = n.trim();
			if !n.is_empty() && !names.iter().any(|x| x == n) {
				names.push(n.to_string());
			}
		}
	}
	names.sort_by(|a, b| base_key(a).cmp(&base_key(b)).then_with(|| a.cmp(b)));
	names
}

fn long_date(iso: &str) -> String {
	let p: Vec<usize> = iso.split('-').map(|x| x.parse().unwrap_or(0)).collect();
	format!("{} {}, {}", MONTHS.get(p[1].wrapping_sub(1)).copied().unwrap_or("?"), p[2], p[0])
}

fn intro(version: &str) -> String {
	format!("{PLACEHOLDER}: the intro, what {version} brings players, in a bold first sentence and a short paragraph or two.]]")
}

fn thanks(rel: &Release) -> String {
	let names = thanked(&[rel.players.as_str(), &rel.authors, &rel.contributors, &rel.forge].join("\n"));
	let named = if names.is_empty() { String::new() } else { format!("{} and ", names.join(", ")) };
	format!("Thank you to {named}everyone posting in #bugs.")
}

fn changelog_link(version: &str) -> String {
	format!("{REPO}/blob/v{version}/CHANGELOG.md")
}

fn beta() -> String {
	format!("Polestar is still a beta. If something's off, tell us on [Discord]({DISCORD}) or [GitHub Issues]({REPO}/issues).")
}

/// The GitHub release's notes: the players' and guide authors' entries.
pub fn github(rel: &Release) -> String {
	let v = &rel.version;
	let mut out = vec![
		intro(v),
		String::new(),
		beta(),
		String::new(),
		"## Install or update".into(),
		String::new(),
		format!("- **With the CurseForge app:** update [Polestar Guides]({CURSEFORGE})."),
		format!("- **By hand:** download `Polestar-{v}.zip` below (not \"Source code\"). Delete every old `Polestar` folder from `World of Warcraft/_classic_beta_/Interface/AddOns/` (`_forever_` from launch), then unzip this one there."),
		"- **Then quit the game completely and start it again** if the release adds an addon folder: a `/reload` doesn't load new addon folders.".into(),
		String::new(),
		format!("`Polestar_Recorder-{v}.zip` is optional. `SHA256SUMS` holds the checksums."),
	];
	for (text, heading) in [(&rel.players, "## For players"), (&rel.authors, "## For guide authors")] {
		if !text.is_empty() {
			out.extend([String::new(), heading.into(), String::new(), text.clone()]);
		}
	}
	out.extend([String::new(), "## Thank you".into(), String::new(), thanks(rel), String::new(), format!("Every change is in the [full changelog]({}).", changelog_link(v)), String::new()]);
	out.join("\n")
}

/// The CurseForge file's notes: the players' entries.
pub fn curseforge(rel: &Release) -> String {
	let v = &rel.version;
	let mut out = vec![
		format!("# Polestar {v}"),
		String::new(),
		intro(v),
		String::new(),
		beta(),
		String::new(),
		"## Updating".into(),
		String::new(),
		"Quit the game completely and start it again after updating if the release adds an addon folder: a `/reload` doesn't load new addon folders.".into(),
	];
	if !rel.players.is_empty() {
		out.extend([String::new(), "## For players".into(), String::new(), rel.players.clone()]);
	}
	out.extend([String::new(), "## Thank you".into(), String::new(), thanks(rel), String::new(), format!("Every change is in the [full changelog]({}).", changelog_link(v)), String::new()]);
	out.join("\n")
}

/// Links Discord would unfurl into embeds, wrapped in <> so it doesn't.
fn discord_links(text: &str) -> String {
	static LINK: LazyLock<regex::Regex> = LazyLock::new(|| re(r"\]\((https?://[^)\s]+)\)"));
	LINK.replace_all(text, "](<$1>)").into_owned()
}

fn chars(s: &str) -> usize {
	s.chars().count()
}

/// Pieces of an item no longer than `limit` characters, cut after a sentence where one fits, else at a
/// space.
fn split_long(text: &str, limit: usize) -> Vec<String> {
	static LISTED: LazyLock<regex::Regex> = LazyLock::new(|| re(r"^\s*[-*]"));
	let mut out = Vec::new();
	let mut rest = text.to_string();
	while chars(&rest) > limit {
		let head_len = rest.char_indices().nth(limit).map_or(rest.len(), |(i, _)| i);
		let head = &rest[..head_len];
		let sentence = [". ", ": ", "; "].iter().filter_map(|s| head.rfind(s)).max();
		let cut = match sentence {
			Some(i) => i + 1,
			None => head.rfind(' ').filter(|&i| i > 0).unwrap_or(head_len),
		};
		out.push(rest[..cut].trim_end().to_string());
		let next = rest[cut..].trim_start().to_string();
		rest = if LISTED.is_match(&next) { next } else { format!("  {next}") };
	}
	out.push(rest);
	out
}

/// Posts from sections (heading, blocks), each post at most `limit` characters; a section that runs on
/// into a new post repeats its heading.
fn pack(sections: &[(&str, Vec<String>)], limit: usize) -> Vec<String> {
	let mut posts = Vec::new();
	let mut cur = String::new();
	for (heading, blocks) in sections {
		let mut open = false;
		for piece in blocks.iter().flat_map(|b| split_long(b, limit - chars(heading) - 20)) {
			let add = if open { format!("\n{piece}") } else { format!("{}{heading}\n{piece}", if cur.is_empty() { "" } else { "\n\n" }) };
			if !cur.is_empty() && chars(&cur) + chars(&add) > limit {
				posts.push(std::mem::replace(&mut cur, format!("{heading} (continued)\n{piece}")));
			} else {
				cur.push_str(&add);
			}
			open = true;
		}
	}
	if !cur.is_empty() {
		posts.push(cur);
	}
	posts
}

/// A changelog part's top-level items with their sub-items, as blocks.
fn items(text: &str) -> Vec<String> {
	let mut blocks: Vec<String> = Vec::new();
	for line in text.split('\n') {
		if line.trim().is_empty() {
			continue;
		}
		match blocks.last_mut() {
			Some(b) if line.starts_with(char::is_whitespace) => {
				b.push('\n');
				b.push_str(line);
			}
			_ => blocks.push(line.to_string()),
		}
	}
	blocks
}

/// The Discord announcement's posts: the intro and how to update, the players' entries, the thanks.
pub fn discord_posts(rel: &Release) -> Vec<String> {
	let v = &rel.version;
	let tag = format!("{REPO}/releases/tag/v{v}");
	let first = [
		format!("# Polestar {v} Patch Notes"),
		format!("-# {}", long_date(&rel.date)),
		String::new(),
		intro(v),
		String::new(),
		"## How to update".into(),
		format!("- **CurseForge app:** update [Polestar Guides](<{CURSEFORGE}>)."),
		format!("- **By hand:** download `Polestar-{v}.zip` from the [GitHub release](<{tag}>) (not \"Source code\"). Delete every old `Polestar` folder from your AddOns folder, then unzip the new one there."),
		"- **Restart the game fully** if the release adds an addon folder: a `/reload` won't load it.".into(),
		String::new(),
		"Full patch notes below.".into(),
	]
	.join("\n");
	let body = if rel.players.is_empty() { Vec::new() } else { pack(&[("## For players", items(&discord_links(&rel.players)))], DISCORD_LIMIT) };
	let last = ["## Thank you".to_string(), thanks(rel), String::new(), format!("**Download:** <{tag}> or the CurseForge app"), format!("**Full changelog:** <{}>", changelog_link(v))].join("\n");
	let mut posts = vec![first];
	posts.extend(body);
	posts.push(last);
	posts
}

/// A count with en-US digit grouping (2,000).
fn grouped(n: usize) -> String {
	let s = n.to_string();
	let mut out = String::new();
	for (i, c) in s.chars().enumerate() {
		if i > 0 && (s.len() - i).is_multiple_of(3) {
			out.push(',');
		}
		out.push(c);
	}
	out
}

/// The Discord announcement file: the posts, each between START and END lines with its length.
pub fn discord(rel: &Release) -> String {
	let posts = discord_posts(rel);
	let n = posts.len();
	let bar = "====================";
	let mut out = vec![
		format!("Polestar {} - Discord announcement, {n} post{}", rel.version, if n == 1 { "" } else { "s" }),
		"Post them in order, one message each. Copy only the text between the START and END lines.".into(),
		format!("Every post is under the {}-character limit for accounts without Nitro.", grouped(DISCORD_LIMIT)),
	];
	for (i, p) in posts.iter().enumerate() {
		out.extend([String::new(), format!("{bar} POST {} of {n} - START ({} characters) {bar}", i + 1, grouped(chars(p))), p.clone(), format!("{bar} POST {} of {n} - END {bar}", i + 1)]);
	}
	out.join("\n") + "\n"
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn join_lines_puts_each_item_and_paragraph_on_one_line() {
		assert_eq!(join_lines("- a\n  b\n  - c\n    d\n\n\npara\ngraph\n"), "- a b\n  - c d\n\npara graph");
		assert_eq!(join_lines("```\nx\n  y\n```"), "```\nx\n  y\n```");
	}

	#[test]
	fn discord_posts_stay_under_the_limit() {
		let mut long: Vec<String> = (0..60).map(|i| format!("- Entry {i} {}", "word ".repeat(60))).collect();
		long.push(format!("- One huge entry. {}", "Sentence here. ".repeat(300)));
		let rel = release_section(&format!("## 2.0.0 (2026-01-02)\n\n### For players\n\n{}\n", long.join("\n")), "2.0.0").unwrap();
		let posts = discord_posts(&rel);
		assert!(posts.len() > 3);
		for p in &posts {
			assert!(chars(p) <= DISCORD_LIMIT, "{}", chars(p));
		}
	}

	#[test]
	fn thanked_names_sort_once_each_ignoring_case() {
		assert_eq!(thanked("- A (thanks bo and Ann). - B (thanks Cy, Ann)."), ["Ann", "bo", "Cy"]);
	}

	#[test]
	fn counts_group_like_en_us() {
		assert_eq!(grouped(2000), "2,000");
		assert_eq!(grouped(999), "999");
		assert_eq!(grouped(1_234_567), "1,234,567");
		assert_eq!(long_date("2026-10-02"), "October 2, 2026");
	}
}
