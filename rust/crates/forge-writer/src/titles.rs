//! Guide titles, on the guides as written: a leveling guide's title names the zones it quests in.
//! The seed's title is a list of places ("Wetlands, Hillsbrad Foothills, Ironforge & Stormwind
//! City"); the writer keeps its order and its words and leaves out the places the guide does not
//! really quest in:
//! - the capitals, unless the guide is only a capital;
//! - a zone with few of the guide's quest goals: under `SMALL_SHARE_PCT`% of them and at most
//!   `SMALL_MAX` ("Arathi Highlands, Badlands & The Barrens", one goal in the Barrens: "Arathi
//!   Highlands & Badlands"). Never every zone: then the one with most goals stays.

use std::collections::BTreeMap;

use crate::apply::quest_of;
use crate::guide::is_goal;
use crate::jsre::{is_step, split_comment, trim};
use crate::re;

/// The capital cities: a stop for training and hand-ins, not where a guide quests.
pub const CAPITALS: [&str; 6] = ["Orgrimmar", "Undercity", "Thunder Bluff", "Stormwind City", "Ironforge", "Darnassus"];
/// A zone with under this share of the guide's quest goals (percent) …
const SMALL_SHARE_PCT: usize = 5;
/// … and at most this many is no zone the guide quests in.
const SMALL_MAX: usize = 3;

/// Retitles the guides `written` of `tree` (file -> text) by the rules above. `is_zone`: whether a
/// title's part is a zone's name (the other parts, "the Plaguelands", stay as they are).
pub fn guide_titles(tree: &mut BTreeMap<String, String>, written: &[String], is_zone: &dyn Fn(&str) -> bool) {
	let mut titled: Vec<(String, String)> = Vec::new();
	for rel in written {
		let Some(text) = tree.get(rel) else { continue };
		let Some(old) = header_value(text, "title") else { continue };
		let new = zone_title(old, text, is_zone);
		if new != old {
			let mut done = false;
			let out = text
				.split('\n')
				.map(|l| {
					if !done && l.starts_with("title ") {
						done = true;
						format!("title {new}")
					} else {
						l.to_string()
					}
				})
				.collect::<Vec<_>>()
				.join("\n");
			titled.push((rel.clone(), out));
		}
	}
	tree.extend(titled);
}

/// The header lines: those before the first step.
fn header(text: &str) -> impl Iterator<Item = &str> {
	text.split('\n').take_while(|l| !is_step(l))
}

fn header_value<'a>(text: &'a str, key: &str) -> Option<&'a str> {
	header(text).find_map(|l| l.strip_prefix(key).and_then(|r| r.strip_prefix(' '))).map(trim)
}

/// `title`'s places less the capitals and the zones the guide has few quest goals in.
fn zone_title(title: &str, text: &str, is_zone: &dyn Fn(&str) -> bool) -> String {
	let parts: Vec<&str> = re!(r", | & ").split(title).collect();
	let mut keep: Vec<&str> = parts.iter().copied().filter(|p| !CAPITALS.contains(p)).collect();
	if keep.is_empty() {
		keep = parts.clone();
	}
	let (by_zone, total) = quest_goals(text);
	let n = |p: &str| by_zone.get(p).copied().unwrap_or(0);
	let small = |p: &str| n(p) * 100 < SMALL_SHARE_PCT * total && n(p) <= SMALL_MAX;
	let zones: Vec<&str> = keep.iter().copied().filter(|p| is_zone(p)).collect();
	let mut out: Vec<&str> = keep.iter().copied().filter(|p| !(is_zone(p) && small(p))).collect();
	if !zones.is_empty() && !out.iter().any(|p| is_zone(p)) {
		// (Never every zone: the one with most goals, the first of them on a tie.)
		let best = zones.iter().copied().rev().max_by_key(|p| n(p)).unwrap();
		out = keep.iter().copied().filter(|p| !is_zone(p) || *p == best).collect();
	}
	if out == parts {
		return title.to_string();
	}
	match out.split_last() {
		Some((last, [])) => last.to_string(),
		Some((last, rest)) => format!("{} & {last}", rest.join(", ")),
		None => title.to_string(),
	}
}

/// The guide's quest goals (lines that accept, hand in or work a quest) by the zone they are in
/// (the header's `zone`, then each step's), and their number.
fn quest_goals(text: &str) -> (BTreeMap<String, usize>, usize) {
	let mut zone: Option<String> = None;
	let mut by_zone: BTreeMap<String, usize> = BTreeMap::new();
	let mut total = 0;
	for l in text.split('\n') {
		let code = split_comment(l).0;
		if let Some(z) = l.strip_prefix("zone ") {
			zone = Some(trim(z).to_string());
		} else if let Some(m) = re!(r"^\s+zone\s+(.+?)\s*$").captures(code) {
			zone = Some(m[1].to_string());
		} else if is_goal(code) && quest_of(code).is_some() {
			total += 1;
			if let Some(z) = &zone {
				*by_zone.entry(z.clone()).or_default() += 1;
			}
		}
	}
	(by_zone, total)
}

#[cfg(test)]
mod tests {
	use super::*;

	const ZONES: [&str; 13] = [
		"Wetlands",
		"Hillsbrad Foothills",
		"Arathi Highlands",
		"Badlands",
		"The Barrens",
		"Burning Steppes",
		"Azshara",
		"Blasted Lands",
		"Winterspring",
		"Feralas",
		"Silithus",
		"Un'Goro Crater",
		"Eastern Plaguelands",
	];

	fn is_zone(z: &str) -> bool {
		ZONES.contains(&z) || CAPITALS.contains(&z)
	}

	/// A guide titled `title` with `n` quest goals in each zone of `goals`, the first the header's.
	fn guide(id: &str, title: &str, head: &[&str], goals: &[(&str, usize)]) -> String {
		let mut l = vec![format!("guide {id}"), format!("title {title}")];
		l.extend(head.iter().map(|h| h.to_string()));
		l.push(format!("zone {}", goals.first().map_or("Durotar", |g| g.0)));
		let mut q = 100;
		for (z, n) in goals {
			l.push(String::new());
			l.push(format!("step {z}"));
			l.push(format!("  zone {z}"));
			for _ in 0..*n {
				q += 1;
				l.push(format!("  accept {q}"));
			}
			l.push("  goto 50,50 \"Somewhere\"".into());
		}
		l.join("\n")
	}

	fn titled(tree: &[(&str, String)], rel: &str) -> String {
		let mut t: BTreeMap<String, String> = tree.iter().map(|(r, x)| (r.to_string(), x.clone())).collect();
		let written: Vec<String> = t.keys().cloned().collect();
		guide_titles(&mut t, &written, &is_zone);
		header_value(&t[rel], "title").unwrap().to_string()
	}

	fn one(title: &str, goals: &[(&str, usize)]) -> String {
		titled(&[("g.guide", guide("forever/g", title, &["faction Horde"], goals))], "g.guide")
	}

	#[test]
	fn a_title_leaves_the_capitals_out_unless_the_guide_is_only_one() {
		// (Shipped: the Alliance's 30-40 Hillsbrad Foothills, the Horde's Silverpine Forest and Azshara.)
		assert_eq!(
			one("Wetlands, Hillsbrad Foothills, Ironforge & Stormwind City", &[("Wetlands", 28), ("Hillsbrad Foothills", 35), ("Ironforge", 26), ("Stormwind City", 1)]),
			"Wetlands & Hillsbrad Foothills"
		);
		assert_eq!(one("Silverpine Forest & Orgrimmar", &[("Silverpine Forest", 64), ("Orgrimmar", 24)]), "Silverpine Forest");
		assert_eq!(one("Azshara, The Barrens & Undercity", &[("Azshara", 14), ("Undercity", 14), ("The Barrens", 10)]), "Azshara & The Barrens");
		assert_eq!(one("Orgrimmar", &[("Orgrimmar", 12)]), "Orgrimmar");
		assert_eq!(one("Orgrimmar & Undercity", &[("Orgrimmar", 12), ("Undercity", 4)]), "Orgrimmar & Undercity");
	}

	#[test]
	fn a_title_leaves_out_a_zone_with_under_5_percent_and_at_most_3_of_the_quest_goals() {
		assert_eq!(one("Arathi Highlands, Badlands & The Barrens", &[("Arathi Highlands", 64), ("Badlands", 31), ("The Barrens", 1)]), "Arathi Highlands & Badlands");
		// (3 of 77: under 5%, and 3.)
		assert_eq!(one("Burning Steppes, Azshara & Blasted Lands", &[("Burning Steppes", 29), ("Azshara", 34), ("Blasted Lands", 3), ("Teldrassil", 11)]), "Burning Steppes & Azshara");
		assert_eq!(one("Winterspring & Feralas", &[("Winterspring", 37), ("Thunder Bluff", 16), ("Orgrimmar", 6), ("Feralas", 2)]), "Winterspring");
		// (None in Silithus and Un'Goro Crater.)
		assert_eq!(one("Silithus, Un'Goro Crater & Eastern Plaguelands", &[("Stormwind City", 12), ("Ironforge", 10), ("Eastern Plaguelands", 9), ("The Barrens", 2)]), "Eastern Plaguelands");
		// Kept: 11 of 236 is under 5% but more than 3 (Western Plaguelands' Feralas); 3 of 60 is not
		// under 5%; 10 of 49 (the Horde's Azshara's Barrens).
		assert_eq!(one("Badlands & Feralas", &[("Badlands", 225), ("Feralas", 11)]), "Badlands & Feralas");
		assert_eq!(one("Badlands & Feralas", &[("Badlands", 57), ("Feralas", 3)]), "Badlands & Feralas");
		assert_eq!(one("Azshara & The Barrens", &[("Azshara", 39), ("The Barrens", 10)]), "Azshara & The Barrens");
		// Never every zone: the one with most goals; a part that is no zone stays.
		assert_eq!(one("Silithus & Un'Goro Crater", &[("Stormwind City", 60), ("Un'Goro Crater", 1)]), "Un'Goro Crater");
		assert_eq!(one("Silithus, Feralas & the Plaguelands", &[("Silithus", 60), ("Feralas", 1)]), "Silithus & the Plaguelands");
		// (Nothing left out: the title as it was.)
		assert_eq!(one("Badlands, Feralas", &[("Badlands", 10), ("Feralas", 10)]), "Badlands, Feralas");
	}
}
