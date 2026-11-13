//! `forge guide renumber`: leveling guide ids in the order players get the guides.
//!
//! A guide's id is its path under guides/ (`forever/horde/02-the-barrens`), and saves, translations,
//! baked legs, fix records, the seed, tests and docs all name guides by it. Route rounds moved guides
//! along the route without renaming them, so the numbers stopped following the route and some names
//! stopped saying the zones. The renumber has two halves:
//!
//! - [`plan`]: the table, from the guides as they are: each faction's chain followed by `next` from its
//!   starts (a route choice's options in the order the guide writes them), numbered per folder in the order
//!   players reach the guides (`01-`, `02-`, ...), named after the guide's title (one zone: its name, `silverpine-forest`;
//!   several: their short names, `ashenvale-silverpine`). A guide keeps its folder.
//! - [`apply`]: one table applied to the checkout in one go. The guides move with their translations
//!   and seed copies (`git mv`); every reference in the checkout's text files is rewritten: `guide` and
//!   `next` lines, fix records, translations, legs, tests, docs, also a fragment such as
//!   `horde/02-the-barrens` or `02-the-barrens` where it names one guide (where two guides share it,
//!   the faction of the file, the line or the lines above tells which). guides/GENERATED.json and
//!   forge/seed/SEED.json follow (paths and hashes), and guides/renamed.json records each rename, which
//!   compiles into Polestar.RenameGuides: Polestar moves a save from the old ids to the new ones at login
//!   (Core/Guides.lua), the steps and their keys unchanged. A second run changes nothing; the dry run
//!   lists every change.
//!
//! The compiled addon files (Guides.lua, Legs.lua, Texts.lua) are rebuilt by `forge guide compile`
//! afterwards, not rewritten here; released history (CHANGELOG.md) keeps the names it shipped with.

use std::collections::{BTreeMap, HashMap, HashSet, VecDeque};
use std::path::{Path, PathBuf};

use regex::Regex;
use serde_json::{Map, Value};

/// The pack's record of renamed guide ids, old -> new (docs/PACK_FORMAT.md, "Renamed guides").
pub const RENAMED: &str = "guides/renamed.json";

// ---------------------------------------------------------------------------------------------------
// Ids and their fragments
// ---------------------------------------------------------------------------------------------------

/// A guide id: lower-case letters, digits, `_` and `-` in `/`-separated parts (retired.json's rule).
pub fn is_guide_id(s: &str) -> bool {
	!s.is_empty() && s.split('/').all(|p| !p.is_empty() && p.bytes().all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_' || b == b'-'))
}

fn is_band(part: &str) -> bool {
	let b = part.as_bytes();
	b.len() == 5 && b[2] == b'-' && b.iter().enumerate().all(|(i, c)| i == 2 || c.is_ascii_digit())
}

/// How a text names a guide: its whole id, the id without `forever/` (`horde/02-the-barrens`), the
/// band folder and name (`30-40/03-stranglethorn-vale`), or the name alone (`02-the-barrens`).
#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
enum Form {
	Full,
	Faction,
	Band,
	Base,
}

fn form(id: &str, f: Form) -> Option<String> {
	let parts: Vec<&str> = id.split('/').collect();
	let ours = parts.len() >= 3 && parts[0] == "forever";
	match f {
		Form::Full => Some(id.to_string()),
		Form::Faction if ours => Some(parts[1..].join("/")),
		Form::Band if ours && parts.len() == 4 && is_band(parts[2]) => Some(parts[2..].join("/")),
		Form::Base if ours => Some(parts[parts.len() - 1].to_string()),
		_ => None,
	}
}

const FORMS: [Form; 4] = [Form::Full, Form::Faction, Form::Band, Form::Base];

fn parent(id: &str) -> &str {
	id.rsplit_once('/').map_or("", |(p, _)| p)
}

#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
enum Side {
	Horde,
	Alliance,
}

fn side_of_id(id: &str) -> Option<Side> {
	if id.starts_with("forever/horde/") {
		Some(Side::Horde)
	} else if id.starts_with("forever/alliance/") {
		Some(Side::Alliance)
	} else {
		None
	}
}

// ---------------------------------------------------------------------------------------------------
// The plan
// ---------------------------------------------------------------------------------------------------

/// A guide's header, as far as the plan needs it.
#[derive(Clone, Debug, Default)]
struct Head {
	title: String,
	next: Vec<String>,
}

/// The header lines before the first step: `title`, and every `next` option in order (a route choice's
/// ids, a conditional option's id).
fn read_head(text: &str) -> Head {
	let mut h = Head::default();
	for line in text.lines() {
		let line = line.trim_end();
		if line.starts_with("step ") || line == "step" {
			break;
		}
		let value = |key: &str| line.strip_prefix(key).filter(|r| r.starts_with(' ')).map(|r| r.split(" --").next().unwrap_or("").trim().to_string());
		if let Some(t) = value("title") {
			h.title = t;
		} else if let Some(n) = value("next") {
			let n = n.split(" when ").next().unwrap_or("");
			h.next.extend(n.split(',').map(str::trim).filter(|s| !s.is_empty()).map(String::from));
		}
	}
	h
}

/// A guide's name without its number (`07b-the-dunes` -> `the-dunes`).
fn old_name(id: &str) -> &str {
	let base = id.rsplit('/').next().unwrap_or(id);
	let rest = base.trim_start_matches(|c: char| c.is_ascii_digit());
	let rest = rest.strip_prefix(|c: char| c.is_ascii_lowercase()).filter(|r| r.starts_with('-') && rest.len() < base.len()).unwrap_or(rest);
	rest.strip_prefix('-').unwrap_or(rest)
}

fn slug(s: &str) -> String {
	let mut out = String::new();
	for c in s.to_lowercase().chars() {
		if c.is_ascii_alphanumeric() {
			out.push(c);
		} else if !out.ends_with('-') && !out.is_empty() {
			out.push('-');
		}
	}
	out.trim_end_matches('-').to_string()
}

/// A zone's short name in a guide of several zones: no leading article and no trailing kind of place
/// (`Silverpine Forest` -> `silverpine`, `The Barrens` -> `barrens`, `Un'Goro Crater` -> `un-goro`).
fn short_zone(zone: &str) -> String {
	const KINDS: [&str; 9] = ["Forest", "Mountains", "Vale", "Marsh", "Highlands", "Foothills", "Crater", "City", "Glades"];
	let mut words: Vec<&str> = zone.split_whitespace().collect();
	if words.first().is_some_and(|w| w.eq_ignore_ascii_case("the")) {
		words.remove(0);
	}
	while words.len() > 1 && words.last().is_some_and(|w| KINDS.contains(w)) {
		words.pop();
	}
	slug(&words.join(" "))
}

/// The name a guide titled `title` goes by: one zone, its name (`silverpine-forest`); several, their
/// short names in the title's order (`ashenvale-silverpine`), both Plaguelands as `plaguelands`.
pub fn name_of(title: &str) -> String {
	let zones: Vec<&str> = title.split(", ").flat_map(|p| p.split(" & ")).map(str::trim).filter(|z| !z.is_empty()).collect();
	if zones.len() <= 1 {
		return slug(title);
	}
	let mut names: Vec<String> = zones.iter().map(|z| short_zone(z)).collect();
	if let (Some(w), Some(e)) = (names.iter().position(|n| n == "western-plaguelands"), names.iter().position(|n| n == "eastern-plaguelands")) {
		names[w.min(e)] = "plaguelands".into();
		names.remove(w.max(e));
	}
	let mut out: Vec<String> = Vec::new();
	for n in names {
		if !n.is_empty() && !out.contains(&n) {
			out.push(n);
		}
	}
	out.join("-")
}

/// A renumber table: (old id, new id) in route order, each faction's chains and what was left out.
#[derive(Debug, Default)]
pub struct Plan {
	pub renames: Vec<(String, String)>,
	/// Every leveling guide reached, in route order, with its new id (unchanged ones too).
	pub order: Vec<(String, String)>,
	pub warnings: Vec<String>,
}

/// The table for the checkout's leveling guides as they are now (see the module doc).
pub fn plan(checkout: &Path) -> Result<Plan, String> {
	let guides = checkout.join("guides");
	let mut heads: BTreeMap<String, Head> = BTreeMap::new();
	for rel in crate::generated::leveling_guides(&guides) {
		let text = std::fs::read_to_string(guides.join(&rel)).map_err(|e| format!("guides/{rel}: {e}"))?;
		heads.insert(rel.trim_end_matches(".guide").to_string(), read_head(&text));
	}
	if heads.is_empty() {
		return Err(format!("no leveling guides under {}/forever/{{horde,alliance}}", guides.display()));
	}
	let targets: HashSet<&str> = heads.values().flat_map(|h| h.next.iter().map(String::as_str)).collect();
	let mut out = Plan::default();
	for side in ["horde", "alliance"] {
		let prefix = format!("forever/{side}/");
		let mine: Vec<&String> = heads.keys().filter(|id| id.starts_with(&prefix)).collect();
		// From the starts (the faction's guides no guide hands over to), breadth first: each `next` option is
		// one hop on, in the order the guide writes them. A guide's place is its fewest hops from a start, and
		// guides as many hops on go in the order they are met: a route choice's other option right after the
		// first, both before what follows them. An option into another pack (an experimental zone) is no guide
		// of ours and is passed over.
		let mut seen: HashSet<String> = HashSet::new();
		let mut order: Vec<String> = Vec::new();
		let mut queue: VecDeque<String> = VecDeque::new();
		for id in mine.iter().filter(|id| !targets.contains(id.as_str())) {
			seen.insert(id.to_string());
			order.push(id.to_string());
			queue.push_back(id.to_string());
		}
		while let Some(id) = queue.pop_front() {
			for nx in &heads[&id].next {
				if nx.starts_with(&prefix) && heads.contains_key(nx) && seen.insert(nx.clone()) {
					order.push(nx.clone());
					queue.push_back(nx.clone());
				}
			}
		}
		for id in &mine {
			if !seen.contains(id.as_str()) {
				out.warnings.push(format!("{id}: no start's chain reaches it; it keeps its id"));
			}
		}
		// Per folder, in the order players reach the guides.
		let mut numbers: HashMap<String, usize> = HashMap::new();
		for id in order {
			let folder = parent(&id).to_string();
			let n = numbers.entry(folder.clone()).or_insert(0);
			*n += 1;
			let title = &heads[&id].title;
			let name = if title.is_empty() {
				out.warnings.push(format!("{id}: no title; named after its old name"));
				old_name(&id).to_string()
			} else {
				name_of(title)
			};
			let new = format!("{folder}/{:02}-{name}", *n);
			if new != id {
				out.renames.push((id.clone(), new.clone()));
			}
			out.order.push((id, new));
		}
	}
	let olds: HashSet<&str> = out.renames.iter().map(|(o, _)| o.as_str()).collect();
	let kept: HashSet<&str> = heads.keys().map(String::as_str).filter(|id| !olds.contains(id)).collect();
	let mut news: HashSet<&str> = HashSet::new();
	for (old, new) in &out.renames {
		if !news.insert(new) {
			return Err(format!("two guides would be named {new}"));
		}
		if kept.contains(new.as_str()) {
			return Err(format!("{old} would be named {new}, which another guide keeps"));
		}
		if olds.contains(new.as_str()) {
			return Err(format!("{old} would be named {new}, another guide's old id: a save under {new} could mean either; rename one of them by hand"));
		}
	}
	Ok(out)
}

// ---------------------------------------------------------------------------------------------------
// Table files
// ---------------------------------------------------------------------------------------------------

/// A table file: `{ "renames": { old: new, ... } }` (what `--plan --out` writes), or a plain
/// `{ old: new }` object as guides/renamed.json holds. -> pairs in file order.
pub fn load_map(path: &Path) -> Result<Vec<(String, String)>, String> {
	let text = std::fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
	let v: Value = serde_json::from_str(&text).map_err(|e| format!("{}: not JSON: {e}", path.display()))?;
	let obj = v.get("renames").unwrap_or(&v).as_object().ok_or_else(|| format!("{}: no table of renames (old id -> new id)", path.display()))?;
	let mut out = Vec::new();
	for (k, v) in obj {
		if k == "about" && v.is_string() && v.as_str().is_some_and(|s| !is_guide_id(s)) {
			continue;
		}
		let Some(new) = v.as_str() else { return Err(format!("{}: {k}: the new id is not a string", path.display())) };
		out.push((k.clone(), new.to_string()));
	}
	Ok(out)
}

/// The table as `--plan --out` writes it.
pub fn map_document(renames: &[(String, String)]) -> String {
	let mut m = Map::new();
	for (o, n) in renames {
		m.insert(o.clone(), Value::String(n.clone()));
	}
	let mut doc = Map::new();
	doc.insert(
		"about".into(),
		Value::String(
			"The leveling guides' new ids (forge guide renumber --plan): old id -> new id, each faction in route order, numbered per folder as players reach the guides and named after their titles. `forge guide renumber --map <this file>` applies it; Polestar moves a save from the old ids to the new ones (guides/renamed.json)."
				.into(),
		),
	);
	doc.insert("renames".into(), Value::Object(m));
	serde_json::to_string_pretty(&Value::Object(doc)).unwrap_or_default() + "\n"
}

// ---------------------------------------------------------------------------------------------------
// The checkout's files
// ---------------------------------------------------------------------------------------------------

fn git(dir: &Path, args: &[&str]) -> Result<Vec<u8>, String> {
	let o = std::process::Command::new("git").arg("-C").arg(dir).args(args).output().map_err(|e| format!("git {}: {e}", args.join(" ")))?;
	if !o.status.success() {
		return Err(format!("git {}: {}", args.join(" "), String::from_utf8_lossy(&o.stderr).trim()));
	}
	Ok(o.stdout)
}

fn is_git(dir: &Path) -> bool {
	git(dir, &["rev-parse", "--show-toplevel"]).ok().and_then(|o| String::from_utf8(o).ok()).is_some_and(|top| Path::new(top.trim()).canonicalize().ok() == dir.canonicalize().ok())
}

/// The checkout's files, relative with `/`: git's tracked files, or every file outside .git, target and
/// node_modules when the checkout is no git work tree.
fn checkout_files(dir: &Path, with_git: bool) -> Result<Vec<String>, String> {
	if with_git {
		let out = git(dir, &["ls-files", "-z"])?;
		let mut v: Vec<String> = out.split(|&b| b == 0).filter(|s| !s.is_empty()).map(|s| String::from_utf8_lossy(s).into_owned()).collect();
		v.retain(|p| std::fs::symlink_metadata(dir.join(p)).is_ok_and(|m| m.is_file()));
		v.sort();
		return Ok(v);
	}
	let mut out = Vec::new();
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		for e in std::fs::read_dir(&d).map_err(|e| format!("{}: {e}", d.display()))?.flatten() {
			let p = e.path();
			let name = e.file_name().to_string_lossy().into_owned();
			if p.is_dir() {
				if !matches!(name.as_str(), ".git" | "target" | "node_modules") {
					stack.push(p);
				}
			} else if let Ok(rel) = p.strip_prefix(dir) {
				out.push(rel.components().map(|c| c.as_os_str().to_string_lossy()).collect::<Vec<_>>().join("/"));
			}
		}
	}
	out.sort();
	Ok(out)
}

/// Files the rewrite leaves alone: what `forge guide compile` writes from the sources (rebuilt after
/// the renumber), the manifests [`apply`] rewrites itself, released history, and the records of the
/// renames.
fn left_alone(path: &str, map_file: Option<&str>) -> bool {
	if Some(path) == map_file || path == RENAMED || path == crate::generated::GENERATED || path == crate::generated::SEED_MANIFEST || path == "CHANGELOG.md" {
		return true;
	}
	if let Some(rest) = path.strip_prefix("addon/") {
		let (folder, file) = rest.split_once('/').unwrap_or((rest, ""));
		if folder == "Polestar_Guides" || folder.starts_with("Polestar_Guides_") || folder == "Polestar_Experimental" {
			return true;
		}
		// The translations' compiled guide texts (addon/Polestar_<locale>/Texts.lua).
		if file == "Texts.lua" && folder.len() == "Polestar_deDE".len() && folder.starts_with("Polestar_") {
			return true;
		}
	}
	false
}

// ---------------------------------------------------------------------------------------------------
// The rewrite
// ---------------------------------------------------------------------------------------------------

/// One rewritten reference.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Edit {
	pub file: String,
	pub line: usize,
	pub from: String,
	pub to: String,
	/// How a fragment two guides share was told apart ("the path", "the line", "line N"); "" for one
	/// that names a single guide.
	pub how: String,
}

/// A fragment two guides share that nothing told apart: left as it is.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Left {
	pub file: String,
	pub line: usize,
	pub text: String,
	pub candidates: Vec<String>,
}

/// What a run changed (or, dry, would change).
#[derive(Debug, Default)]
pub struct Report {
	/// Pairs already applied (old gone, new there).
	pub done: Vec<(String, String)>,
	pub moves: Vec<(String, String)>,
	pub edits: Vec<Edit>,
	pub left: Vec<Left>,
	/// Manifest files rewritten: (file, paths renamed, hashes updated).
	pub manifests: Vec<(String, usize, usize)>,
	/// guides/renamed.json's entries after the run, when the run changes it.
	pub renamed: Option<usize>,
}

impl Report {
	pub fn changes(&self) -> bool {
		!self.moves.is_empty() || !self.edits.is_empty() || !self.manifests.is_empty() || self.renamed.is_some()
	}
}

struct Matcher {
	re: Regex,
	/// A fragment as a text writes it -> its form, and whether it is written as in a regular expression
	/// literal (`forever\/horde\/...`).
	kinds: HashMap<String, (Form, bool)>,
	/// (form, text) -> every id of the universe with that fragment.
	cands: HashMap<(Form, String), Vec<String>>,
	map: HashMap<String, String>,
	/// A faction's words: its name, its races, a review's tag (`Rev15A2`, `RevH2`).
	strong: Regex,
	/// Its capitals: what a line names in passing, weaker than the words.
	weak: Regex,
	/// A leveling guide's step titles, in its own words (where a compiled title has a `{kind:id}` token).
	steps: HashMap<String, Vec<String>>,
	/// The quests a leveling guide's goals name.
	quests: HashMap<String, HashSet<u32>>,
}

impl Matcher {
	/// `guides`: the leveling guides' texts by id, for a line that names a step or quests.
	fn new(renames: &[(String, String)], universe: &HashSet<String>, guides: &HashMap<String, String>) -> Matcher {
		let mut kinds: HashMap<String, (Form, bool)> = HashMap::new();
		for (old, _) in renames {
			for f in FORMS {
				if let Some(s) = form(old, f) {
					if s.contains('/') {
						kinds.insert(s.replace('/', "\\/"), (f, true));
					}
					kinds.insert(s, (f, false));
				}
			}
		}
		let mut pats: Vec<&String> = kinds.keys().collect();
		pats.sort_by(|a, b| b.len().cmp(&a.len()).then(a.cmp(b)));
		let alt = pats.iter().map(|p| regex::escape(p)).collect::<Vec<_>>().join("|");
		let re = Regex::new(&format!("(?:{alt})")).expect("the fragments make a pattern");
		let mut cands: HashMap<(Form, String), Vec<String>> = HashMap::new();
		let mut ids: Vec<&String> = universe.iter().collect();
		ids.sort();
		for id in ids {
			for f in FORMS {
				if let Some(s) = form(id, f) {
					if kinds.get(&s) == Some(&(f, false)) {
						cands.entry((f, s)).or_default().push(id.clone());
					}
				}
			}
		}
		let strong = Regex::new(
			r"(?i:\b\w*(horde)\w*\b)|(?i:\b\w*(alliance)\w*\b)|\b(Orcs?|Trolls?|Tauren|Undead|Forsaken)\b|\b(Humans?|Dwarfs?|Dwarves|Gnomes?|Night Elf|Night Elves|\w*NightElf\w*)\b|\bRev\d*(?:-)?([AH])\d*\b",
		)
		.expect("faction words");
		let weak = Regex::new(r"\b(Orgrimmar|Thunder Bluff|Undercity)\b|\b(Stormwind|Ironforge|Darnassus)\b").expect("capitals");
		let steps = guides.iter().map(|(id, t)| (id.clone(), t.lines().filter_map(|l| l.strip_prefix("step ")).map(|l| l.trim().to_string()).collect())).collect();
		let goal = Regex::new(r"(?m)^\s+(?:accept|turnin|complete)\s+(\d+)|\bquest\s+(\d+)").expect("quest goals");
		let quests = guides
			.iter()
			.map(|(id, t)| (id.clone(), goal.captures_iter(t).filter_map(|c| c.get(1).or_else(|| c.get(2))?.as_str().parse().ok()).collect()))
			.collect();
		Matcher { re, kinds, cands, map: renames.iter().cloned().collect(), strong, weak, steps, quests }
	}

	/// The one of `cands` whose goals have every quest id `texts` name that any of them has (`Badlands Reagent
	/// Run (2500)` and `710` where both have 710 and one 2500). Issue numbers (`#957`) and dates are no quests.
	fn by_quests(&self, texts: &[&str], cands: &[String]) -> Option<String> {
		let noise = Regex::new(r"#\d+|\d{4}-\d\d-\d\d").ok()?;
		let num = Regex::new(r"\b\d{3,6}\b").ok()?;
		let named: HashSet<u32> = texts.iter().flat_map(|t| num.find_iter(&noise.replace_all(t, " ")).filter_map(|m| m.as_str().parse().ok()).collect::<Vec<u32>>()).collect();
		let hits: HashSet<u32> = cands.iter().filter_map(|id| self.quests.get(id)).flat_map(|q| q.intersection(&named).copied()).collect();
		if hits.is_empty() {
			return None;
		}
		let all: Vec<&String> = cands.iter().filter(|id| self.quests.get(*id).is_some_and(|q| hits.is_subset(q))).collect();
		(all.len() == 1).then(|| all[0].clone())
	}

	/// A line's faction words: (byte offset, side).
	fn sides(&self, line: &str) -> Vec<(usize, Side)> {
		self.strong
			.captures_iter(line)
			.map(|c| {
				let at = c.get(0).map_or(0, |m| m.start());
				let horde = c.get(1).is_some() || c.get(3).is_some() || c.get(5).is_some_and(|t| t.as_str() == "H");
				(at, if horde { Side::Horde } else { Side::Alliance })
			})
			.collect()
	}

	/// A line's capitals: (byte offset, side).
	fn capitals(&self, line: &str) -> Vec<(usize, Side)> {
		self.weak.captures_iter(line).map(|c| (c.get(0).map_or(0, |m| m.start()), if c.get(1).is_some() { Side::Horde } else { Side::Alliance })).collect()
	}

	/// The one of `cands` with a step titled as the line quotes it (`step "The {area:279} crater"`; a token stands
	/// for the name the guide writes there).
	fn by_step(&self, line: &str, cands: &[String]) -> Option<String> {
		let quoted = Regex::new(r#"step \\?"([^"\\]+)\\?""#).ok()?.captures(line)?.get(1)?.as_str().to_string();
		let parts: Vec<String> = Regex::new(r"\{[a-z]+:\d+\}").ok()?.split(&quoted).map(regex::escape).collect();
		let title = Regex::new(&format!("^{}$", parts.join(".+"))).ok()?;
		let hits: Vec<&String> = cands.iter().filter(|id| self.steps.get(*id).is_some_and(|ts| ts.iter().any(|t| title.is_match(t)))).collect();
		(hits.len() == 1).then(|| hits[0].clone())
	}

	/// Every fragment occurrence in `line`: (start, end, form, written as in a regular expression, text).
	fn occurrences<'a>(&self, line: &'a str) -> Vec<(usize, usize, Form, bool, &'a str)> {
		let id_char = |c: char| c.is_ascii_alphanumeric() || c == '_' || c == '-';
		let mut out = Vec::new();
		let mut at = 0;
		while let Some(m) = self.re.find_at(line, at) {
			let (s, e) = (m.start(), m.end());
			let (f, escaped) = self.kinds[m.as_str()];
			let before = line[..s].chars().next_back();
			let after = line[e..].chars().next();
			// A fragment inside a longer path is no reference of its own: after a `/` (an escaped one, `\/`,
			// as a regular expression writes it), only a whole id may start.
			let ok_before = match before {
				None => true,
				Some(c) if id_char(c) || c == '\\' => false,
				Some('/') if f != Form::Full => escaped && !line[..s - 1].ends_with('\\'),
				Some(_) => true,
			};
			if ok_before && !after.is_some_and(id_char) {
				out.push((s, e, f, escaped, m.as_str()));
				at = e;
			} else {
				at = s + line[s..].chars().next().map_or(1, char::len_utf8);
			}
		}
		out
	}
}

/// The source text of a file, split into lines with their endings kept.
fn split_lines(text: &str) -> Vec<&str> {
	text.split_inclusive('\n').collect()
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
	Code,
	Json,
	Prose,
	Other,
}

fn kind_of(path: &str) -> Kind {
	let ext = path.rsplit_once('.').map_or("", |(_, e)| e);
	match ext {
		"rs" | "js" | "mjs" | "cjs" | "ts" | "lua" | "py" | "sh" => Kind::Code,
		"json" | "jsonl" => Kind::Json,
		"md" | "txt" | "guide" => Kind::Prose,
		_ => Kind::Other,
	}
}

/// The faction a whole file is about: its path's `forever/<faction>/`, else a guide's `faction` header.
fn file_side(path: &str, text: &str) -> Option<Side> {
	if path.contains("forever/horde/") {
		return Some(Side::Horde);
	}
	if path.contains("forever/alliance/") {
		return Some(Side::Alliance);
	}
	if path.ends_with(".guide") {
		for line in text.lines() {
			if line.starts_with("step ") {
				break;
			}
			match line.trim() {
				"faction Horde" => return Some(Side::Horde),
				"faction Alliance" => return Some(Side::Alliance),
				_ => {}
			}
		}
	}
	None
}

/// A fragment passed to a helper (`before` ends with `H('`): the faction of that helper's definition further up
/// the file (`const H = (g) => \`forever/horde/${g}.guide\``), followed through a helper it calls itself
/// (`const g = (n) => goals(H(n))`). -> (side, the definition's line).
fn helper_side(m: &Matcher, above: &[&str], before: &str, depth: usize) -> Option<(Side, usize)> {
	let ident = |c: char| c.is_ascii_alphanumeric() || c == '_' || c == '$';
	let call = before.trim_end_matches(['\'', '"', '`']).strip_suffix('(')?;
	let name: String = call.chars().rev().take_while(|&c| ident(c)).collect::<Vec<_>>().into_iter().rev().collect();
	if name.is_empty() || name.chars().next().is_some_and(|c| c.is_ascii_digit()) || depth > 3 {
		return None;
	}
	let def = Regex::new(&format!(r"\b(?:const|let|var|function)\s+{}\b", regex::escape(&name))).ok()?;
	let (k, line) = above.iter().enumerate().rev().find(|(_, l)| def.is_match(l))?;
	if let Some(&(_, sd)) = m.sides(line).last() {
		return Some((sd, k + 1));
	}
	// The helpers its definition calls, each as if the fragment were passed to it.
	let calls = Regex::new(r"[A-Za-z_$][A-Za-z0-9_$]*\(").ok()?;
	let found = calls.find_iter(line).filter(|c| c.as_str().trim_end_matches('(') != name).find_map(|c| helper_side(m, &above[..k], &line[..c.end()], depth + 1));
	found
}

/// Rewrites `text` (the file at `path`, already at its new path): -> (new text, edits, left).
fn rewrite(m: &Matcher, path: &str, text: &str) -> (String, Vec<Edit>, Vec<Left>) {
	let lines = split_lines(text);
	let whole = file_side(path, text);
	let kind = kind_of(path);
	let mut out = String::with_capacity(text.len());
	let mut edits = Vec::new();
	let mut left = Vec::new();
	for (n, line) in lines.iter().enumerate() {
		let occ = m.occurrences(line);
		if occ.is_empty() {
			out.push_str(line);
			continue;
		}
		// Each occurrence's guide when it names one; the sides of those for the line's other fragments.
		let plain = |frag: &str, escaped: bool| if escaped { frag.replace("\\/", "/") } else { frag.to_string() };
		let single: Vec<Option<&String>> = occ.iter().map(|&(_, _, f, esc, s)| m.cands.get(&(f, plain(s, esc))).filter(|c| c.len() == 1).map(|c| &c[0])).collect();
		let words = m.sides(line);
		let capitals = m.capitals(line);
		let mut last = 0;
		for (i, &(s, e, f, escaped, frag)) in occ.iter().enumerate() {
			out.push_str(&line[last..s]);
			last = e;
			let cands = m.cands.get(&(f, plain(frag, escaped))).cloned().unwrap_or_default();
			let (id, how) = if cands.len() <= 1 {
				(cands.first().cloned(), String::new())
			} else {
				let pick = |side: Side| {
					let c: Vec<&String> = cands.iter().filter(|id| side_of_id(id) == Some(side)).collect();
					(c.len() == 1).then(|| c[0].clone())
				};
				// The faction word (or, failing one, capital) nearest before the fragment on its line, else after it.
				let nearest = |list: &[(usize, Side)]| -> Option<Side> {
					if let Some(&(_, sd)) = list.iter().rev().find(|(p, _)| *p < s) {
						return Some(sd);
					}
					list.iter().find(|(p, _)| *p >= e).map(|&(_, sd)| sd)
				};
				// The other guides the line names, when they are all one faction's.
				let by_others = || -> Option<Side> {
					let sides: HashSet<Option<Side>> = single.iter().enumerate().filter(|(j, _)| *j != i).filter_map(|(_, id)| id.map(|id| side_of_id(id))).collect();
					if sides.len() == 1 {
						return sides.into_iter().next().flatten();
					}
					None
				};
				// The lines around the fragment that still belong to its place in the file: up to its test's start
				// (code), its paragraph (prose), its JSON record (above and below it, by indentation).
				let scope = || -> Vec<usize> {
					let indent = |l: &str| l.len() - l.trim_start().len();
					let mut span = Vec::new();
					match kind {
						Kind::Code => {
							for k in (n.saturating_sub(60)..n).rev() {
								span.push(k);
								let t = lines[k].trim_start();
								if t.starts_with("test(") || t.starts_with("it(") || t.starts_with("describe(") || t.starts_with("#[test]") {
									break;
								}
							}
						}
						Kind::Prose => {
							for k in (n.saturating_sub(20)..n).rev() {
								if lines[k].trim().is_empty() {
									break;
								}
								span.push(k);
							}
						}
						Kind::Json => {
							let at = indent(line);
							for k in (n.saturating_sub(60)..n).rev() {
								span.push(k);
								if lines[k].trim() == "{" && indent(lines[k]) < at {
									break;
								}
							}
							for k in n + 1..lines.len().min(n + 61) {
								if indent(lines[k]) < at && !lines[k].trim().is_empty() {
									break;
								}
								span.push(k);
							}
						}
						Kind::Other => {}
					}
					span
				};
				// The nearest of those lines with a faction word, else with a capital.
				let near = |span: &[usize]| -> Option<(Side, usize)> {
					for look in [Matcher::sides, Matcher::capitals] {
						if let Some((k, sd)) = span.iter().find_map(|&k| look(m, lines[k]).last().map(|&(_, sd)| (k, sd))) {
							return Some((sd, k + 1));
						}
					}
					None
				};
				let mut found: Option<(String, String)> = None;
				if let Some(sd) = whole {
					found = pick(sd).map(|id| (id, "the path".to_string()));
				}
				if found.is_none() {
					found = nearest(&words).and_then(pick).map(|id| (id, "the line".to_string()));
				}
				if found.is_none() && kind == Kind::Code {
					found = helper_side(m, &lines[..n], &line[..s], 0).and_then(|(sd, at)| pick(sd).map(|id| (id, format!("line {at}"))));
				}
				if found.is_none() {
					found = by_others().and_then(pick).map(|id| (id, "the line".to_string()));
				}
				if found.is_none() {
					found = m.by_step(line, &cands).map(|id| (id, "the step it names".to_string()));
				}
				let span = scope();
				if found.is_none() {
					let mut texts: Vec<&str> = vec![line];
					if kind == Kind::Json {
						texts.extend(span.iter().map(|&k| lines[k]));
					}
					found = m.by_quests(&texts, &cands).map(|id| (id, "the quests it names".to_string()));
				}
				if found.is_none() {
					found = nearest(&capitals).and_then(pick).map(|id| (id, "the line".to_string()));
				}
				if found.is_none() {
					found = near(&span).and_then(|(sd, at)| pick(sd).map(|id| (id, format!("line {at}"))));
				}
				match found {
					Some((id, how)) => (Some(id), how),
					None => {
						left.push(Left { file: path.to_string(), line: n + 1, text: frag.to_string(), candidates: cands.clone() });
						(None, String::new())
					}
				}
			};
			let new = id.as_ref().and_then(|id| m.map.get(id)).and_then(|new| form(new, f)).map(|new| if escaped { new.replace('/', "\\/") } else { new });
			match new {
				Some(new) => {
					out.push_str(&new);
					edits.push(Edit { file: path.to_string(), line: n + 1, from: frag.to_string(), to: new, how });
				}
				None => out.push_str(frag),
			}
		}
		out.push_str(&line[last..]);
	}
	(out, edits, left)
}

// ---------------------------------------------------------------------------------------------------
// Apply
// ---------------------------------------------------------------------------------------------------

/// How [`apply`] runs.
#[derive(Debug, Default, Clone)]
pub struct Options {
	/// Report only: nothing is moved or written.
	pub dry_run: bool,
	/// Run even when `forge guide check-generated` fails before the renumber (its hashes would bless the
	/// hand edits).
	pub force: bool,
	/// The table's own file (relative to the checkout), which keeps the old ids.
	pub map_file: Option<String>,
}

fn sha256(bytes: &[u8]) -> String {
	use sha2::Digest;
	sha2::Sha256::digest(bytes).iter().map(|b| format!("{b:02x}")).collect()
}

fn read_json(path: &Path) -> Result<Option<Value>, String> {
	match std::fs::read_to_string(path) {
		Ok(t) => serde_json::from_str(&t).map(Some).map_err(|e| format!("{}: not JSON: {e}", path.display())),
		Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(None),
		Err(e) => Err(format!("{}: {e}", path.display())),
	}
}

fn pretty(v: &Value) -> String {
	serde_json::to_string_pretty(v).unwrap_or_default() + "\n"
}

/// The table checked against itself and the checkout. -> pairs still to do, pairs done.
fn check_table(checkout: &Path, renames: &[(String, String)], renamed: &BTreeMap<String, String>) -> Result<(Vec<(String, String)>, Vec<(String, String)>), String> {
	if renames.is_empty() {
		return Err("the table renames no guide".into());
	}
	let mut olds: HashSet<&str> = HashSet::new();
	let mut news: HashSet<&str> = HashSet::new();
	for (old, new) in renames {
		for id in [old, new] {
			if !is_guide_id(id) {
				return Err(format!("{id}: not a guide id (lower-case letters, digits, _ and - in /-separated parts)"));
			}
		}
		if old == new {
			return Err(format!("{old}: renamed to itself"));
		}
		if parent(old) != parent(new) {
			return Err(format!("{old} -> {new}: a renumber keeps a guide in its folder"));
		}
		if !olds.insert(old) {
			return Err(format!("{old}: renamed twice"));
		}
		if !news.insert(new) {
			return Err(format!("{new}: two guides renamed to it"));
		}
	}
	for (old, new) in renames {
		if olds.contains(new.as_str()) {
			return Err(format!("{old} -> {new}: {new} is another guide's old id, so a save under it could mean either"));
		}
		if renamed.contains_key(new) {
			return Err(format!("{old} -> {new}: {new} was renamed away before ({RENAMED}: {new} -> {}); pick another name", renamed[new]));
		}
	}
	let retired: Vec<String> = read_json(&checkout.join("guides/retired.json"))?.and_then(|v| serde_json::from_value(v).ok()).unwrap_or_default();
	let guide = |id: &str| checkout.join("guides").join(format!("{id}.guide")).is_file();
	let (mut todo, mut done) = (Vec::new(), Vec::new());
	for (old, new) in renames {
		if retired.contains(new) {
			return Err(format!("{old} -> {new}: {new} is in guides/retired.json; pick another name"));
		}
		match (guide(old), guide(new)) {
			(true, false) => todo.push((old.clone(), new.clone())),
			(false, true) => done.push((old.clone(), new.clone())),
			(true, true) => return Err(format!("{old} -> {new}: both guides exist")),
			(false, false) => return Err(format!("{old}: no such guide (guides/{old}.guide), nor {new}")),
		}
	}
	Ok((todo, done))
}

/// guides/renamed.json with `renames` added: an earlier rename to an id renamed now follows it to the
/// new id. -> the entries, sorted.
fn merge_renamed(before: &BTreeMap<String, String>, renames: &[(String, String)]) -> BTreeMap<String, String> {
	let now: HashMap<&str, &str> = renames.iter().map(|(o, n)| (o.as_str(), n.as_str())).collect();
	let mut out: BTreeMap<String, String> = BTreeMap::new();
	for (k, v) in before {
		let to = now.get(v.as_str()).map_or(v.as_str(), |n| n);
		if k != to {
			out.insert(k.clone(), to.to_string());
		}
	}
	for (o, n) in renames {
		out.insert(o.clone(), n.clone());
	}
	out
}

/// Applies `renames` to the checkout (see the module doc). Errors before anything is written.
pub fn apply(checkout: &Path, renames: &[(String, String)], opts: &Options) -> Result<Report, String> {
	let checkout = checkout.canonicalize().map_err(|e| format!("{}: {e}", checkout.display()))?;
	let renamed_path = checkout.join(RENAMED);
	let renamed_before: BTreeMap<String, String> = match read_json(&renamed_path)? {
		None => BTreeMap::new(),
		Some(v) => serde_json::from_value(v).map_err(|e| format!("{RENAMED}: not an object of old id -> new id: {e}"))?,
	};
	let (todo, done) = check_table(&checkout, renames, &renamed_before)?;
	if !opts.force {
		let bad = crate::generated::check(&checkout)?;
		if !bad.is_empty() {
			return Err(format!(
				"forge guide check-generated fails before the renumber ({}): the new hashes would bless those edits. Fix them first, or pass --force.",
				bad.join(", ")
			));
		}
	}
	let with_git = is_git(&checkout);
	let files = checkout_files(&checkout, with_git)?;
	let mut report = Report { done, ..Default::default() };

	// The moves: every file named after an old id (the guide, its translations, its seed copy, a fixture's).
	let todo_map: HashMap<&str, &str> = todo.iter().map(|(o, n)| (o.as_str(), n.as_str())).collect();
	let mut moved: HashMap<String, String> = HashMap::new(); // old path -> new path
	let existing: HashSet<&str> = files.iter().map(String::as_str).collect();
	for f in &files {
		for ext in [".guide", ".lua"] {
			let Some(stem) = f.strip_suffix(ext) else { continue };
			for (old, new) in &todo_map {
				if stem.ends_with(old) && stem[..stem.len() - old.len()].ends_with('/') {
					let to = format!("{}{new}{ext}", &stem[..stem.len() - old.len()]);
					if existing.contains(to.as_str()) || checkout.join(&to).exists() {
						return Err(format!("{f} -> {to}: {to} exists"));
					}
					moved.insert(f.clone(), to);
				}
			}
		}
	}
	let mut moves: Vec<(String, String)> = moved.iter().map(|(a, b)| (a.clone(), b.clone())).collect();
	moves.sort();
	report.moves = moves;

	// Every id a fragment could name: the pack's guides, retired ids, and both sides of the table.
	let mut universe: HashSet<String> = files.iter().filter_map(|f| f.strip_prefix("guides/").and_then(|r| r.strip_suffix(".guide"))).filter(|id| !id.starts_with("locales/")).map(String::from).collect();
	let retired: Vec<String> = read_json(&checkout.join("guides/retired.json"))?.and_then(|v| serde_json::from_value(v).ok()).unwrap_or_default();
	universe.extend(retired);
	// The table's old ids: a fragment of one names it even once its file is gone (a second run).
	universe.extend(renames.iter().map(|(o, _)| o.clone()));
	// The leveling guides' texts, for a line that names a step or quests.
	let guide_texts: HashMap<String, String> = universe
		.iter()
		.filter(|id| side_of_id(id).is_some())
		.filter_map(|id| std::fs::read_to_string(checkout.join("guides").join(format!("{id}.guide"))).ok().map(|t| (id.clone(), t)))
		.collect();
	let matcher = Matcher::new(renames, &universe, &guide_texts);

	// The rewrite, in memory: new path -> new text.
	let mut written: BTreeMap<String, String> = BTreeMap::new();
	for f in &files {
		if left_alone(f, opts.map_file.as_deref()) {
			continue;
		}
		let Ok(bytes) = std::fs::read(checkout.join(f)) else { continue };
		if bytes.contains(&0) {
			continue;
		}
		let Ok(text) = String::from_utf8(bytes) else { continue };
		let at = moved.get(f).cloned().unwrap_or_else(|| f.clone());
		if !matcher.re.is_match(&text) {
			continue;
		}
		let (new, edits, left) = rewrite(&matcher, &at, &text);
		report.edits.extend(edits);
		report.left.extend(left);
		if new != text {
			written.insert(at, new);
		}
	}

	// The manifests of the generated guides and the seed: paths renamed, hashes of what this run moved or rewrote.
	let mut manifests: Vec<(PathBuf, String)> = Vec::new();
	for (manifest, base) in [(crate::generated::GENERATED, "guides"), (crate::generated::SEED_MANIFEST, crate::generated::SEED_DIR)] {
		let path = checkout.join(manifest);
		let Some(mut doc) = read_json(&path)? else { continue };
		let Some(list) = doc.get("files").and_then(Value::as_object) else { continue };
		let (mut renamed_n, mut hashed) = (0, 0);
		let mut out: BTreeMap<String, Value> = BTreeMap::new();
		for (k, h) in list {
			let old_path = format!("{base}/{k}");
			let new_path = moved.get(&old_path).cloned().unwrap_or_else(|| old_path.clone());
			let key = new_path.strip_prefix(&format!("{base}/")).unwrap_or(k).to_string();
			if key != *k {
				renamed_n += 1;
			}
			let mut hash = h.clone();
			let text = written.get(&new_path).map(|t| t.as_bytes().to_vec());
			if text.is_some() || key != *k {
				let bytes = match text {
					Some(b) => b,
					None => std::fs::read(checkout.join(&old_path)).map_err(|e| format!("{old_path}: {e}"))?,
				};
				let now = sha256(&bytes);
				if h.as_str() != Some(now.as_str()) {
					hashed += 1;
					hash = Value::String(now);
				}
			}
			out.insert(key, hash);
		}
		if renamed_n + hashed > 0 {
			doc["files"] = Value::Object(out.into_iter().collect());
			manifests.push((path, pretty(&doc)));
			report.manifests.push((manifest.to_string(), renamed_n, hashed));
		}
	}

	// guides/renamed.json.
	let renamed_after = merge_renamed(&renamed_before, renames);
	let renamed_text = (renamed_after != renamed_before || !renamed_path.is_file()).then(|| pretty(&serde_json::to_value(&renamed_after).unwrap_or_default()));
	if renamed_text.is_some() {
		report.renamed = Some(renamed_after.len());
	}

	if opts.dry_run {
		return Ok(report);
	}
	for (from, to) in &report.moves {
		if let Some(d) = checkout.join(to).parent() {
			std::fs::create_dir_all(d).map_err(|e| format!("{}: {e}", d.display()))?;
		}
		if with_git {
			git(&checkout, &["mv", from, to])?;
		} else {
			std::fs::rename(checkout.join(from), checkout.join(to)).map_err(|e| format!("{from} -> {to}: {e}"))?;
		}
	}
	for (f, text) in &written {
		std::fs::write(checkout.join(f), text).map_err(|e| format!("{f}: {e}"))?;
	}
	for (path, text) in &manifests {
		std::fs::write(path, text).map_err(|e| format!("{}: {e}", path.display()))?;
	}
	if let Some(text) = renamed_text {
		std::fs::write(&renamed_path, text).map_err(|e| format!("{RENAMED}: {e}"))?;
		if with_git {
			git(&checkout, &["add", RENAMED])?;
		}
	}
	Ok(report)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn names_say_the_zones_of_the_title() {
		assert_eq!(name_of("Silverpine Forest"), "silverpine-forest");
		assert_eq!(name_of("The Barrens"), "the-barrens");
		assert_eq!(name_of("Un'Goro Crater"), "un-goro-crater");
		assert_eq!(name_of("Ashenvale & Silverpine Forest"), "ashenvale-silverpine");
		assert_eq!(name_of("The Barrens & Stonetalon Mountains"), "barrens-stonetalon");
		assert_eq!(name_of("Loch Modan, Redridge Mountains & Westfall"), "loch-modan-redridge-westfall");
		assert_eq!(name_of("Stranglethorn Vale, Dustwallow Marsh & Swamp of Sorrows"), "stranglethorn-dustwallow-swamp-of-sorrows");
		assert_eq!(name_of("Western Plaguelands, Eastern Plaguelands, Feralas, Un'Goro Crater & Silithus"), "plaguelands-feralas-un-goro-silithus");
		assert_eq!(name_of("Silithus, Felwood, Winterspring & the Plaguelands"), "silithus-felwood-winterspring-plaguelands");
		assert_eq!(name_of("Wetlands, Ashenvale, Ironforge & Stormwind City"), "wetlands-ashenvale-ironforge-stormwind");
	}

	#[test]
	fn a_header_s_next_options_in_order() {
		let h = read_head("guide a/b\ntitle Westfall\nnext a/c, a/d\nnext a/e when level 20 -- later\n\nstep One\nnext a/x\n");
		assert_eq!(h.title, "Westfall");
		assert_eq!(h.next, ["a/c", "a/d", "a/e"]);
	}

	fn matcher(renames: &[(&str, &str)], others: &[&str]) -> Matcher {
		let r: Vec<(String, String)> = renames.iter().map(|(a, b)| (a.to_string(), b.to_string())).collect();
		let mut u: HashSet<String> = others.iter().map(|s| s.to_string()).collect();
		for (a, b) in &r {
			u.insert(a.clone());
			u.insert(b.clone());
		}
		Matcher::new(&r, &u, &HashMap::new())
	}

	#[test]
	fn whole_ids_and_fragments_that_name_one_guide_are_rewritten_others_not() {
		let m = matcher(&[("forever/horde/04-oldvale", "forever/horde/05-newvale"), ("forever/alliance/03-shore", "forever/alliance/02-shore")], &["forever/alliance/03-shore-return"]);
		let text = "next forever/horde/04-oldvale\nsee guides/forever/horde/04-oldvale.guide:12, horde/04-oldvale and 04-oldvale' end\n\
			03-shore-return stays; xforever/horde/04-oldvale and a04-oldvale and forever/horde/orc/04-oldvale too\n";
		let (out, edits, left) = rewrite(&m, "notes.md", text);
		assert_eq!(
			out,
			"next forever/horde/05-newvale\nsee guides/forever/horde/05-newvale.guide:12, horde/05-newvale and 05-newvale' end\n\
			03-shore-return stays; xforever/horde/04-oldvale and a04-oldvale and forever/horde/orc/04-oldvale too\n"
		);
		assert_eq!(edits.len(), 4);
		assert!(left.is_empty());
		// As a regular expression literal writes it.
		let (out, _, _) = rewrite(&m, "tests/a.test.js", "assert.match(t, /Guide forever\\/horde\\/04-oldvale was refused/);\nmatch(/horde\\/04-oldvale$/)\n");
		assert_eq!(out, "assert.match(t, /Guide forever\\/horde\\/05-newvale was refused/);\nmatch(/horde\\/05-newvale$/)\n");
	}

	#[test]
	fn a_fragment_two_guides_share_goes_by_the_path_the_line_or_the_lines_above() {
		let m = matcher(
			&[("forever/alliance/30-40/06-dunes", "forever/alliance/30-40/07-dunes-flats")],
			&["forever/horde/30-40/06-dunes"],
		);
		// The path.
		let (out, e, _) = rewrite(&m, "guides/forever/alliance/30-40/05-x.guide", "# then 06-dunes\n");
		assert_eq!(out, "# then 07-dunes-flats\n");
		assert_eq!(e[0].how, "the path");
		let (out, _, _) = rewrite(&m, "guides/forever/horde/30-40/05-x.guide", "# then 06-dunes\n");
		assert_eq!(out, "# then 06-dunes\n", "the Horde guide of that name stays");
		// The line: the faction word before it, else after it.
		let (out, e, _) = rewrite(&m, "data/x.json", "\"why\": \"Horde 30-40/06-dunes, then Alliance 30-40/06-dunes\"\n");
		assert_eq!(out, "\"why\": \"Horde 30-40/06-dunes, then Alliance 30-40/07-dunes-flats\"\n");
		assert_eq!(e[0].how, "the line");
		let (out, _, _) = rewrite(&m, "data/x.json", "\"why\": \"30-40/06-dunes (Night Elves)\"\n");
		assert_eq!(out, "\"why\": \"30-40/07-dunes-flats (Night Elves)\"\n");
		// The lines above: a test's helper, a record's faction.
		let code = "test('x', () => {\n\tconst A = (g) => `forever/alliance/${g}.guide`;\n\tgoals(A('30-40/06-dunes'));\n});\ntest('y', () => {\n\tgoals(H('30-40/06-dunes'));\n});\n";
		let (out, e, left) = rewrite(&m, "tests/a.test.js", code);
		assert!(out.contains("goals(A('30-40/07-dunes-flats'))") && out.contains("goals(H('30-40/06-dunes'))"), "{out}");
		assert_eq!(e[0].how, "line 2");
		assert_eq!(left.len(), 1, "the second test names no faction: left as it is");
		// A review's tag, a capital, the rest of a JSON record, the step the line names.
		let (out, _, _) = rewrite(&m, "data/x.json", "\"why\": \"Rev15A2 c15 read: 30-40/06-dunes\"\n");
		assert_eq!(out, "\"why\": \"Rev15A2 c15 read: 30-40/07-dunes-flats\"\n");
		let (out, _, _) = rewrite(&m, "data/x.json", "\"why\": \"A Donation of Wool, Stormwind: 30-40/06-dunes\"\n");
		assert_eq!(out, "\"why\": \"A Donation of Wool, Stormwind: 30-40/07-dunes-flats\"\n");
		let (out, e, _) = rewrite(&m, "data/x.json", "\t{\n\t\t\"note\": \"06-dunes takes it\",\n\t\t\"ref\": \"a Night Elf took it\"\n\t},\n\t{\n\t\t\"note\": \"Horde\"\n\t}\n");
		assert!(out.contains("\"07-dunes-flats takes it\""), "{out}");
		assert_eq!(e[0].how, "line 3");
		let mut m3 = matcher(
			&[("forever/alliance/30-40/06-dunes", "forever/alliance/30-40/07-dunes-flats")],
			&["forever/horde/30-40/06-dunes"],
		);
		m3.steps.insert("forever/alliance/30-40/06-dunes".into(), vec!["Razormaw nests".into()]);
		m3.steps.insert("forever/horde/30-40/06-dunes".into(), vec!["The Dalaran crater".into()]);
		let notes = "\"note\": \"06-dunes, step \\\"Razormaw nests\\\"\"\n\"note\": \"06-dunes, step \\\"The {area:279} crater\\\"\"\n";
		let (out, e, _) = rewrite(&m3, "data/goal-heights.json", notes);
		assert_eq!(out, notes.replacen("06-dunes", "07-dunes-flats", 1), "the first is the Alliance guide's step, the second the Horde's");
		assert_eq!(e[0].how, "the step it names");
		// The quests a record names: only the Alliance guide has 2500.
		let mut m4 = matcher(&[("forever/alliance/30-40/06-dunes", "forever/alliance/30-40/07-dunes-flats")], &["forever/horde/30-40/06-dunes"]);
		m4.quests.insert("forever/alliance/30-40/06-dunes".into(), [710, 2500].into_iter().collect());
		m4.quests.insert("forever/horde/30-40/06-dunes".into(), [710].into_iter().collect());
		let rec = "\t\t{\n\t\t\t\"a\": [\n\t\t\t\t\"accept\",\n\t\t\t\t710\n\t\t\t],\n\t\t\t\"why\": \"Reagent Run (2500, #957) at 30-40/06-dunes\"\n\t\t}\n";
		let (out, e, _) = rewrite(&m4, "data/route-fixes.json", rec);
		assert!(out.contains("at 30-40/07-dunes-flats"), "{out}");
		assert_eq!(e[0].how, "the quests it names");
		// A helper's definition beats the other guides the line names (Horde's 07-oasis here).
		let m2 = matcher(
			&[("forever/alliance/30-40/06-dunes", "forever/alliance/30-40/07-dunes-flats"), ("forever/horde/07-oasis", "forever/horde/06-oasis")],
			&["forever/horde/30-40/06-dunes"],
		);
		let code = "const A = (g) => `forever/alliance/${g}.guide`;\nconst H = (g) => `forever/horde/${g}.guide`;\nconst g = (n) => goals(A(n));\nfor (const [f, q] of [[A('30-40/06-dunes'), 1], [H('07-oasis'), 2]]) {}\nconst x = g('30-40/06-dunes');\n";
		let (out, e, _) = rewrite(&m2, "tests/b.test.js", code);
		assert!(out.contains("[[A('30-40/07-dunes-flats'), 1], [H('06-oasis'), 2]]") && out.contains("g('30-40/07-dunes-flats')"), "{out}");
		assert_eq!((e[0].how.as_str(), e[2].how.as_str()), ("line 1", "line 1"), "{e:?}");
		let json = "\t{\n\t\t\"faction\": \"Alliance\",\n\t\t\"why\": \"06-dunes first\"\n\t},\n\t{\n\t\t\"why\": \"06-dunes again\"\n\t}\n";
		let (out, _, left) = rewrite(&m, "data/route-fixes.json", json);
		assert!(out.contains("\"07-dunes-flats first\"") && out.contains("\"06-dunes again\""), "{out}");
		assert_eq!(left[0].line, 6);
	}

	#[test]
	fn the_table_keeps_folders_and_never_reuses_an_old_id() {
		let dir = std::env::temp_dir().join(format!("forge-renumber-table-{}", std::process::id()));
		std::fs::create_dir_all(dir.join("guides/forever/horde")).unwrap();
		std::fs::write(dir.join("guides/forever/horde/02-a.guide"), "guide forever/horde/02-a\n").unwrap();
		std::fs::write(dir.join("guides/forever/horde/03-b.guide"), "guide forever/horde/03-b\n").unwrap();
		let t = |pairs: &[(&str, &str)]| check_table(&dir, &pairs.iter().map(|(a, b)| (a.to_string(), b.to_string())).collect::<Vec<_>>(), &BTreeMap::new());
		assert!(t(&[("forever/horde/02-a", "forever/horde/30-40/01-a")]).unwrap_err().contains("keeps a guide in its folder"));
		assert!(t(&[("forever/horde/02-a", "forever/horde/03-b"), ("forever/horde/03-b", "forever/horde/02-a")]).unwrap_err().contains("another guide's old id"));
		assert!(t(&[("forever/horde/02-a", "forever/horde/01-a"), ("forever/horde/03-b", "forever/horde/02-b")]).is_ok());
		assert!(t(&[("forever/horde/02-a", "forever/horde/01-x"), ("forever/horde/03-b", "forever/horde/01-x")]).unwrap_err().contains("two guides"));
		// A new name may be another folder's old name (the other faction's guide of that band and number): the
		// rewrite tells the two apart by faction.
		std::fs::create_dir_all(dir.join("guides/forever/horde/30-40")).unwrap();
		std::fs::write(dir.join("guides/forever/horde/30-40/01-z.guide"), "guide forever/horde/30-40/01-z\n").unwrap();
		assert!(t(&[("forever/horde/02-a", "forever/horde/01-z"), ("forever/horde/30-40/01-z", "forever/horde/30-40/02-z")]).is_ok());
		assert!(t(&[("forever/horde/02-a", "forever/horde/01-a"), ("forever/horde/09-c", "forever/horde/02-c")]).unwrap_err().contains("no such guide"));
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn a_route_choice_s_other_option_is_numbered_right_after_the_first() {
		let dir = std::env::temp_dir().join(format!("forge-renumber-choice-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		let g = |rel: &str, title: &str, next: &str| {
			let p = dir.join("guides/forever/horde").join(format!("{rel}.guide"));
			std::fs::create_dir_all(p.parent().unwrap()).unwrap();
			std::fs::write(p, format!("guide forever/horde/{rel}\ntitle {title}\n{next}\nstep One\n")).unwrap();
		};
		g("orc/01-valley", "Valley", "next forever/horde/05-a");
		g("05-a", "Aa", "next forever/horde/02-b, forever/horde/09-c\nnext polestar-experimental/x when level 20");
		g("02-b", "Bb", "next forever/horde/03-d");
		g("09-c", "Cc", "next forever/horde/03-d");
		g("03-d", "Dd", "");
		let p = plan(&dir).unwrap();
		let order: Vec<&str> = p.order.iter().map(|(_, n)| n.as_str()).collect();
		assert_eq!(order, ["forever/horde/orc/01-valley", "forever/horde/01-aa", "forever/horde/02-bb", "forever/horde/03-cc", "forever/horde/04-dd"]);
		assert!(p.warnings.is_empty(), "{:?}", p.warnings);
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn renamed_json_follows_an_earlier_rename_to_the_new_id() {
		let before: BTreeMap<String, String> = [("a/old".to_string(), "a/mid".to_string()), ("a/x".to_string(), "a/y".to_string())].into_iter().collect();
		let after = merge_renamed(&before, &[("a/mid".to_string(), "a/new".to_string())]);
		assert_eq!(after.into_iter().collect::<Vec<_>>(), [("a/mid".into(), "a/new".into()), ("a/old".into(), "a/new".into()), ("a/x".into(), "a/y".into())]);
	}
}
