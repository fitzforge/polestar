//! A race's lead-in merged into the shared guide it hands over to ([`merge_lead_ins`]):
//! `forge guide publish` ([`crate::generated::publish`]) writes the Orcs' and Trolls' own part
//! of the Barrens as the first steps of the shared Barrens guide, each `only` its races, rather
//! than as guides of their own. Every other race starts that guide at its first shared step,
//! which gets a `label` the lead-in's open `along` lists end at.

use forge_guide::conditions::same_race;
use forge_guide::races::RACES;

/// `^step\b`.
fn is_step(l: &str) -> bool {
	l.starts_with("step") && !l[4..].chars().next().is_some_and(|c| c.is_alphanumeric() || c == '_')
}

/// Where a line's code ends: before the white space ahead of its ` -- ` comment, else its end.
fn code_end(l: &str) -> usize {
	let at = l.find(" -- ").or_else(|| l.ends_with(" --").then(|| l.len() - 3)).unwrap_or(l.len());
	l[..at].trim_end().len()
}

fn is_goal(l: &str) -> bool {
	l.starts_with([' ', '\t']) && l.split_whitespace().next().is_some_and(|w| forge_guide::parse::VERBS.contains(&w))
}

fn is_race(t: &str) -> bool {
	RACES.iter().any(|r| r.name.eq_ignore_ascii_case(t) || r.file.eq_ignore_ascii_case(t))
}

/// A step: the comment and blank lines above it, its `step` line, its own `only` list (an `only`
/// line before its first goal) and its other lines.
#[derive(Clone)]
struct Step {
	pre: Vec<String>,
	head: String,
	only: Option<String>,
	lines: Vec<String>,
}

/// A guide's header lines (before the first step) and steps.
fn parse(text: &str) -> (Vec<&str>, Vec<Step>) {
	let lines: Vec<&str> = text.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l)).unwrap_or(lines.len());
	let mut steps: Vec<Step> = Vec::new();
	let mut pre: Vec<String> = Vec::new();
	for &l in &lines[first..] {
		if is_step(l) {
			steps.push(Step { pre: std::mem::take(&mut pre), head: l.to_string(), only: None, lines: Vec::new() });
			continue;
		}
		let Some(st) = steps.last_mut().filter(|_| l.starts_with([' ', '\t']) && !l.trim().is_empty()) else {
			pre.push(l.to_string());
			continue;
		};
		if st.only.is_none() && !st.lines.iter().any(|x| is_goal(x)) {
			if let Some(o) = l[..code_end(l)].trim().strip_prefix("only ") {
				st.only = Some(o.trim().to_string());
				continue;
			}
		}
		st.lines.push(l.to_string());
	}
	(lines[..first].to_vec(), steps)
}

/// The longest common subsequence of `a` and `b` under `eq`, as index pairs.
fn lcs<T, U>(a: &[T], b: &[U], eq: impl Fn(&T, &U) -> bool) -> Vec<(usize, usize)> {
	let (n, m) = (a.len(), b.len());
	let mut t = vec![vec![0u32; m + 1]; n + 1];
	for i in (0..n).rev() {
		for j in (0..m).rev() {
			t[i][j] = if eq(&a[i], &b[j]) { t[i + 1][j + 1] + 1 } else { t[i + 1][j].max(t[i][j + 1]) };
		}
	}
	let (mut i, mut j, mut out) = (0, 0, Vec::new());
	while i < n && j < m {
		if eq(&a[i], &b[j]) {
			out.push((i, j));
			(i, j) = (i + 1, j + 1);
		} else if t[i + 1][j] >= t[i][j + 1] {
			i += 1;
		} else {
			j += 1;
		}
	}
	out
}

/// A merged lead-in step: who plays it, and who each of its lines is for.
#[derive(Clone)]
struct Merged {
	step: Step,
	races: Vec<String>,
	line_races: Vec<Vec<String>>,
}

impl Merged {
	fn new(step: Step, races: &[String]) -> Self {
		Merged { line_races: vec![races.to_vec(); step.lines.len()], races: races.to_vec(), step }
	}

	/// Another race's copy of the step: lines both have are theirs; its goals this one lacks are
	/// its own (`only <race>`); its other lines this one lacks (another wording of a tip) go.
	fn add(&mut self, other: &Step, races: &[String]) {
		let pairs = lcs(&self.step.lines, &other.lines, |a, b| a == b);
		let (mut lines, mut line_races) = (Vec::new(), Vec::new());
		let (mut i, mut j) = (0, 0);
		for &(pi, pj) in pairs.iter().chain(std::iter::once(&(self.step.lines.len(), other.lines.len()))) {
			lines.extend_from_slice(&self.step.lines[i..pi]);
			line_races.extend_from_slice(&self.line_races[i..pi]);
			for l in other.lines[j..pj].iter().filter(|l| is_goal(l)) {
				lines.push(l.clone());
				line_races.push(races.to_vec());
			}
			if pi < self.step.lines.len() {
				lines.push(self.step.lines[pi].clone());
				let mut r = self.line_races[pi].clone();
				r.extend_from_slice(races);
				line_races.push(r);
			}
			(i, j) = (pi + 1, pj + 1);
		}
		self.step.lines = lines;
		self.line_races = line_races;
		self.races.extend_from_slice(races);
	}
}

/// An `only` list for `races`: the list's races those of them it names (all of them when it
/// names none), then its other words (classes, negations).
fn only_list(list: Option<&str>, races: &[String]) -> String {
	let toks: Vec<&str> = list.map_or_else(Vec::new, |l| l.split(',').map(str::trim).filter(|t| !t.is_empty()).collect());
	let named: Vec<&str> = toks.iter().copied().filter(|t| is_race(t)).collect();
	let mut out: Vec<String> = races.iter().filter(|r| named.is_empty() || named.iter().any(|n| same_race(n, r))).cloned().collect();
	if out.is_empty() {
		out = races.to_vec();
	}
	out.extend(toks.iter().filter(|t| !is_race(t)).map(|t| t.to_string()));
	out.join(",")
}

/// A goal line for `races` alone: its own `only` list narrowed to them, else `only <races>`.
fn line_for(l: &str, races: &[String]) -> String {
	let end = code_end(l);
	let (code, rest) = l.split_at(end);
	match code.rfind(" only ").filter(|&k| !code[k + 6..].trim().contains(char::is_whitespace)) {
		Some(k) => format!("{} only {}{rest}", &code[..k], only_list(Some(code[k + 6..].trim()), races)),
		None => format!("{code} only {}{rest}", only_list(None, races)),
	}
}

fn same_set(a: &[String], b: &[String]) -> bool {
	a.iter().all(|x| b.contains(x)) && b.iter().all(|x| a.contains(x))
}

fn header_value<'a>(header: &[&'a str], key: &str) -> Option<&'a str> {
	header.iter().find_map(|l| l.strip_prefix(key).and_then(|r| r.strip_prefix(' '))).map(str::trim)
}

fn levels(header: &[&str]) -> Option<(u32, u32)> {
	let (a, b) = header_value(header, "levels")?.split_once('-')?;
	Some((a.trim().parse().ok()?, b.trim().parse().ok()?))
}

/// A label for a step titled `title` (`The Crossroads` -> `crossroads`), not one of `taken`.
fn label_for(title: &str, taken: &[String]) -> String {
	let t = title.trim();
	let t = t.strip_prefix("The ").unwrap_or(t);
	let mut base = String::new();
	for c in t.chars() {
		if c.is_ascii_alphanumeric() {
			base.push(c.to_ascii_lowercase());
		} else if !base.is_empty() && !base.ends_with('-') && c != '\'' {
			base.push('-');
		}
	}
	let base = match base.trim_end_matches('-') {
		"" => "shared-start".to_string(),
		b => b.to_string(),
	};
	let mut name = base.clone();
	let mut n = 2;
	while taken.contains(&name) {
		name = format!("{base}-{n}");
		n += 1;
	}
	name
}

/// The shared guide `shared` with the lead-ins `leads` ((their races, their text), in the
/// faction's start order) merged in before its first step:
///
/// - the lead-ins' steps first, in their order: a step of several of them (the same title and
///   `only`) is one step, its goals that not all of them have `only` theirs, its other lines the
///   first one's; each step `only` its races (`only Orc,Troll`, `only Orc,Troll,Warrior`, `only
///   Troll` for one race's own);
/// - the shared guide's first step gets a `label` (its own when it has one), and the lead-ins'
///   open `along` lists end there (`along until crossroads`); it says its zone when it did not;
/// - the header's `levels` span the lead-ins' too; the lead-ins' headers and the comments above
///   their first steps go (their `next` was this guide).
///
/// None when the shared guide has no step.
pub fn merge_lead_ins(shared: &str, leads: &[(Vec<String>, String)]) -> Option<String> {
	let lines: Vec<&str> = shared.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l))?;
	let first_end = (first + 1..lines.len()).find(|&k| !(lines[k].starts_with([' ', '\t']) && !lines[k].trim().is_empty())).unwrap_or(lines.len());
	let first_body = &lines[first + 1..first_end];
	let label_of = |l: &str| l[..code_end(l)].trim().strip_prefix("label ").map(|x| x.trim().to_string());
	// (Every label of the guides, for a new one's name.)
	let taken: Vec<String> = lines.iter().copied().chain(leads.iter().flat_map(|(_, t)| t.split('\n'))).filter(|l| l.starts_with([' ', '\t'])).filter_map(label_of).collect();
	let own_label = first_body.iter().find_map(|l| label_of(l));
	let label = own_label.clone().unwrap_or_else(|| label_for(lines[first].strip_prefix("step").unwrap_or(""), &taken));
	let mut merged: Vec<Merged> = Vec::new();
	let mut all_races: Vec<String> = Vec::new();
	let mut lv = levels(&lines[..first]);
	for (races, text) in leads {
		all_races.extend(races.iter().cloned());
		let (head, steps) = parse(text);
		if let Some((a, b)) = levels(&head) {
			lv = Some(lv.map_or((a, b), |(x, y)| (x.min(a), y.max(b))));
		}
		if merged.is_empty() {
			merged = steps.into_iter().map(|s| Merged::new(s, races)).collect();
			continue;
		}
		let pairs = lcs(&merged, &steps, |m, s| m.step.head == s.head && m.step.only == s.only);
		let mut out: Vec<Merged> = Vec::new();
		let (mut i, mut j) = (0, 0);
		for &(pi, pj) in pairs.iter().chain(std::iter::once(&(merged.len(), steps.len()))) {
			out.extend_from_slice(&merged[i..pi]);
			out.extend(steps[j..pj].iter().map(|s| Merged::new(s.clone(), races)));
			if pi < merged.len() {
				let mut m = merged[pi].clone();
				m.add(&steps[pj], races);
				out.push(m);
			}
			(i, j) = (pi + 1, pj + 1);
		}
		merged = out;
	}
	let mut out: Vec<String> = Vec::with_capacity(lines.len() + merged.len() * 8);
	for &l in &lines[..first] {
		out.push(match lv {
			Some((a, b)) if l.starts_with("levels ") => format!("levels {a}-{b}"),
			_ => l.to_string(),
		});
	}
	let who = match all_races.split_last() {
		Some((last, [])) => last.clone(),
		Some((last, rest)) => format!("{} and {last}", rest.join(", ")),
		None => String::new(),
	};
	out.push(format!("# {who}: their own steps first (`only` their races), merged from their lead-in guides."));
	out.push(format!("# Every race of the faction starts at the step labelled `{label}`."));
	out.push("# The lead-in guides' former ids are in guides/retired.json.".into());
	for m in &merged {
		if !m.step.pre.first().is_some_and(|l| l.trim().is_empty()) {
			out.push(String::new());
		}
		out.extend(m.step.pre.iter().cloned());
		out.push(m.step.head.clone());
		out.push(format!("  only {}", only_list(m.step.only.as_deref(), &m.races)));
		for (l, rs) in m.step.lines.iter().zip(&m.line_races) {
			let l = if l[..code_end(l)].trim() == "along" { format!("{}along until {label}{}", &l[..l.len() - l.trim_start().len()], &l[code_end(l)..]) } else { l.clone() };
			out.push(if is_goal(&l) && !same_set(rs, &m.races) { line_for(&l, rs) } else { l });
		}
	}
	out.push(String::new());
	out.push(lines[first].to_string());
	if own_label.is_none() {
		out.push(format!("  label {label}"));
	}
	let has_zone = first_body.iter().any(|l| l.trim_start().starts_with("zone "));
	if let Some(z) = header_value(&lines[..first], "zone").filter(|z| !z.is_empty() && !has_zone) {
		out.push(format!("  zone {z}"));
	}
	out.extend(lines[first + 1..].iter().map(|l| l.to_string()));
	Some(out.join("\n"))
}

#[cfg(test)]
mod tests {
	use super::*;

	fn s(xs: &[&str]) -> Vec<String> {
		xs.iter().map(|x| x.to_string()).collect()
	}

	#[test]
	fn a_goal_line_for_some_races_says_them() {
		let r = s(&["Orc"]);
		assert_eq!(line_for("  turnin 842", &r), "  turnin 842 only Orc");
		assert_eq!(line_for("  accept 867                          -- Darsok", &r), "  accept 867 only Orc                          -- Darsok");
		assert_eq!(line_for("  collect 6652 quest 1525.2 only Shaman", &r), "  collect 6652 quest 1525.2 only Orc,Shaman");
		assert_eq!(only_list(Some("Orc,Troll,Shaman"), &s(&["Orc", "Troll"])), "Orc,Troll,Shaman");
		assert_eq!(only_list(Some("Warrior,Shaman"), &s(&["Orc", "Troll"])), "Orc,Troll,Warrior,Shaman");
		assert_eq!(only_list(Some("Orc,Troll,Shaman"), &s(&["Troll"])), "Troll,Shaman");
		assert_eq!(label_for(" The Crossroads", &[]), "crossroads");
		assert_eq!(label_for(" Thun'grim Firegaze", &s(&["thungrim-firegaze"])), "thungrim-firegaze-2");
	}
}
