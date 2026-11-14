//! The Guiding Stars page's names (addon/Polestar/Core/Credits.lua): the supporters, kept by hand in
//! data/credits.json in rank order (highest Ko-fi total first; amounts are never stored), the
//! contributors, counted from the repository's pull requests on GitHub: the merged ones, and the closed
//! ones whose commits were folded into the release (cherry-picked with their authorship kept), the bug
//! reporters, counted from its issues (see [`useful_report`] for which reports count), the translators,
//! from forge-guide's LOCALES (one source with the locale tooling), and the people whose idea shipped
//! though someone else built it, kept by hand in data/credits.json `ideas`.

use serde_json::Value;
use std::path::Path;
use unicode_normalization::UnicodeNormalization;

pub const SOURCE: &str = "data/credits.json";
pub const OUT: &str = "addon/Polestar/Core/Credits.lua";
pub const REPO: &str = "fitzforge/polestar";
/// How many bug reporters the page lists, so the three columns stay a readable length.
pub const REPORTERS_SHOWN: usize = 40;

/// data/credits.json: `supporters` (names, rank order), `exclude` (logins and names left out: the
/// maintainer, and anyone who asked not to be listed), `names` (login or name -> the name shown),
/// `ideas` (`{ "name": login or name, "ref": pull request or issue number }`, in the order they shipped).
pub struct Source {
	pub supporters: Vec<String>,
	pub exclude: Vec<String>,
	pub names: Vec<(String, String)>,
	pub ideas: Vec<Idea>,
}

/// Someone whose idea shipped: their login or name and the pull request or issue that proposed it.
#[derive(Clone, Debug, PartialEq)]
pub struct Idea {
	pub name: String,
	pub reference: u64,
}

pub fn read_source(file: &Path) -> Result<Source, String> {
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let doc: Value = serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let strings = |key: &str| -> Result<Vec<String>, String> {
		doc.get(key)
			.and_then(Value::as_array)
			.map_or(Ok(Vec::new()), |a| a.iter().map(|v| v.as_str().map(str::to_string).ok_or_else(|| format!("{}: \"{key}\" holds a non-string", file.display()))).collect())
	};
	let supporters = strings("supporters")?;
	if supporters.iter().any(|s| s.trim().is_empty()) {
		return Err(format!("{}: every supporter is a non-empty name", file.display()));
	}
	let names = doc.get("names").and_then(Value::as_object).map(|o| o.iter().filter_map(|(k, v)| Some((k.clone(), v.as_str()?.to_string()))).collect()).unwrap_or_default();
	let ideas = doc.get("ideas").and_then(Value::as_array).map_or(Ok(Vec::new()), |a| {
		a.iter()
			.map(|v| {
				let name = v.get("name").and_then(Value::as_str).map(str::trim).filter(|n| !n.is_empty());
				let reference = v.get("ref").and_then(Value::as_u64).filter(|&n| n > 0);
				match (name, reference) {
					(Some(name), Some(reference)) => Ok(Idea { name: name.to_string(), reference }),
					_ => Err(format!("{}: every idea is {{ \"name\": a non-empty name, \"ref\": its pull request or issue number }}", file.display())),
				}
			})
			.collect()
	})?;
	Ok(Source { supporters, exclude: strings("exclude")?, names, ideas })
}

/// One merged pull request: its author's login and when it merged (ISO time).
#[derive(Clone, Debug)]
pub struct Merged {
	pub login: Option<String>,
	pub merged_at: Option<String>,
}

/// Every merged pull request of `repo`, through the GitHub CLI (`gh`, logged in).
pub fn fetch_merged(repo: &str) -> Result<Vec<Merged>, String> {
	let out = std::process::Command::new("gh")
		.args(["pr", "list", "--repo", repo, "--state", "merged", "--limit", "5000", "--json", "author,mergedAt"])
		.output()
		.map_err(|e| format!("gh (the GitHub CLI) could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("gh pr list failed: {}", String::from_utf8_lossy(&out.stderr).trim()));
	}
	parse_merged(&String::from_utf8_lossy(&out.stdout))
}

/// `gh pr list --json author,mergedAt` output.
pub fn parse_merged(json: &str) -> Result<Vec<Merged>, String> {
	let doc: Value = serde_json::from_str(json).map_err(|e| format!("gh pr list: {e}"))?;
	let list = doc.as_array().ok_or("gh pr list: not a list")?;
	Ok(list
		.iter()
		.map(|pr| Merged { login: pr.pointer("/author/login").and_then(Value::as_str).map(str::to_string), merged_at: pr.get("mergedAt").and_then(Value::as_str).map(str::to_string) })
		.collect())
}

/// A pull request closed without merging: its author, when it closed, and its commits as
/// (author email, headline). GitHub cuts a long headline and ends it with "…".
#[derive(Clone, Debug)]
pub struct Closed {
	pub login: Option<String>,
	pub closed_at: Option<String>,
	pub commits: Vec<(String, String)>,
}

/// The closed, unmerged pull requests of `repo` by authors other than `exclude` (and bots), each with
/// its commits, through the GitHub CLI.
pub fn fetch_closed(repo: &str, exclude: &[String]) -> Result<Vec<Closed>, String> {
	let gh = |args: &[&str]| -> Result<Value, String> {
		let out = std::process::Command::new("gh").args(args).output().map_err(|e| format!("gh (the GitHub CLI) could not run: {e}"))?;
		if !out.status.success() {
			return Err(format!("gh {} failed: {}", args[..2].join(" "), String::from_utf8_lossy(&out.stderr).trim()));
		}
		serde_json::from_slice(&out.stdout).map_err(|e| format!("gh {}: {e}", args[..2].join(" ")))
	};
	let skip: Vec<String> = exclude.iter().map(|l| l.to_lowercase()).collect();
	let list = gh(&["pr", "list", "--repo", repo, "--state", "closed", "--limit", "5000", "--json", "number,author,mergedAt,closedAt"])?;
	let mut out = Vec::new();
	for pr in list.as_array().ok_or("gh pr list: not a list")? {
		let login = pr.pointer("/author/login").and_then(Value::as_str).map(str::to_string);
		let unmerged = pr.get("mergedAt").is_none_or(Value::is_null);
		let counted = login.as_deref().is_some_and(|l| !l.is_empty() && !skip.contains(&l.to_lowercase()) && !l.starts_with("app/") && !l.ends_with("[bot]"));
		let Some(number) = pr.get("number").and_then(Value::as_u64) else { continue };
		if !unmerged || !counted {
			continue;
		}
		let view = gh(&["pr", "view", &number.to_string(), "--repo", repo, "--json", "commits"])?;
		out.push(Closed { login, closed_at: pr.get("closedAt").and_then(Value::as_str).map(str::to_string), commits: parse_commits(&view) });
	}
	Ok(out)
}

/// `gh pr view --json commits` output -> (author email, headline), one pair per commit author.
pub fn parse_commits(view: &Value) -> Vec<(String, String)> {
	let mut out = Vec::new();
	for c in view.get("commits").and_then(Value::as_array).into_iter().flatten() {
		let head = c.get("messageHeadline").and_then(Value::as_str).unwrap_or("").to_string();
		for a in c.get("authors").and_then(Value::as_array).into_iter().flatten() {
			if let Some(email) = a.get("email").and_then(Value::as_str).filter(|e| !e.is_empty()) {
				out.push((email.to_lowercase(), head.clone()));
			}
		}
	}
	out
}

/// The release ref's commits as (author email, subject): `git log --format=%ae%x1f%s <rev>` in `root`.
pub fn ref_commits(root: &Path, rev: &str) -> Result<Vec<(String, String)>, String> {
	let out = std::process::Command::new("git").arg("-C").arg(root).args(["log", "--format=%ae%x1f%s", rev]).output().map_err(|e| format!("git could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("git log {rev} failed: {}", String::from_utf8_lossy(&out.stderr).trim()));
	}
	Ok(String::from_utf8_lossy(&out.stdout).lines().filter_map(|l| l.split_once('\u{1f}')).map(|(e, s)| (e.to_lowercase(), s.to_string())).collect())
}

/// The closed pull requests whose work is on the release ref: one of their commits was folded in
/// with its authorship kept (same author email, and the ref's subject starts with the PR commit's
/// headline, "…" cut off). Each counts as one pull request, at its closing time.
pub fn folded(closed: &[Closed], on_ref: &[(String, String)]) -> Vec<Merged> {
	closed
		.iter()
		.filter(|pr| {
			pr.commits.iter().any(|(email, head)| {
				let head = head.trim_end_matches('…').trim_end();
				!head.is_empty() && on_ref.iter().any(|(e, s)| e == email && s.starts_with(head))
			})
		})
		.map(|pr| Merged { login: pr.login.clone(), merged_at: pr.closed_at.clone() })
		.collect()
}

/// An open pull request: its author and its head commit.
#[derive(Clone, Debug)]
pub struct Open {
	pub login: Option<String>,
	pub head: String,
}

/// The open pull requests of `repo` by authors other than `exclude` (and bots), with their head
/// commits, through the GitHub CLI.
pub fn fetch_open(repo: &str, exclude: &[String]) -> Result<Vec<Open>, String> {
	let out = std::process::Command::new("gh")
		.args(["pr", "list", "--repo", repo, "--state", "open", "--limit", "5000", "--json", "author,headRefOid"])
		.output()
		.map_err(|e| format!("gh (the GitHub CLI) could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("gh pr list failed: {}", String::from_utf8_lossy(&out.stderr).trim()));
	}
	let doc: Value = serde_json::from_slice(&out.stdout).map_err(|e| format!("gh pr list: {e}"))?;
	let skip: Vec<String> = exclude.iter().map(|l| l.to_lowercase()).collect();
	Ok(doc
		.as_array()
		.ok_or("gh pr list: not a list")?
		.iter()
		.filter_map(|pr| {
			let login = pr.pointer("/author/login").and_then(Value::as_str)?;
			let head = pr.get("headRefOid").and_then(Value::as_str)?;
			let counted = !login.is_empty() && !skip.contains(&login.to_lowercase()) && !login.starts_with("app/") && !login.ends_with("[bot]");
			counted.then(|| Open { login: Some(login.to_string()), head: head.to_lowercase() })
		})
		.collect())
}

/// The release ref's commits as (commit id, committer date): `git log --format=%H%x1f%cI <rev>` in `root`.
pub fn ref_ids(root: &Path, rev: &str) -> Result<Vec<(String, String)>, String> {
	let out = std::process::Command::new("git").arg("-C").arg(root).args(["log", "--format=%H%x1f%cI", rev]).output().map_err(|e| format!("git could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("git log {rev} failed: {}", String::from_utf8_lossy(&out.stderr).trim()));
	}
	Ok(String::from_utf8_lossy(&out.stdout).lines().filter_map(|l| l.split_once('\u{1f}')).map(|(id, at)| (id.to_lowercase(), at.to_string())).collect())
}

/// The open pull requests folded into the release ref at their exact head: the head commit is on the
/// ref (an integration branch merges it before the release reaches the branch that marks the pull
/// request merged). Each counts as one pull request, at its head commit's date.
pub fn folded_open(open: &[Open], on_ref: &[(String, String)]) -> Vec<Merged> {
	let at: std::collections::HashMap<&str, &str> = on_ref.iter().map(|(id, at)| (id.as_str(), at.as_str())).collect();
	open.iter().filter_map(|pr| at.get(pr.head.as_str()).map(|t| Merged { login: pr.login.clone(), merged_at: Some(t.to_string()) })).collect()
}

/// Contributors by merged or folded pull requests, most first; a tie goes to whoever merged first. Bots
/// and excluded logins are left out; `names` maps a login to the name shown. -> (name, pull requests).
pub fn rank_contributors(prs: &[Merged], src: &Source) -> Vec<(String, usize)> {
	let skip: Vec<String> = src.exclude.iter().map(|l| l.to_lowercase()).collect();
	// login, count, first merge; in order of first appearance.
	let mut by: Vec<(String, usize, Option<String>)> = Vec::new();
	for pr in prs {
		let Some(login) = pr.login.as_deref().filter(|l| !l.is_empty()) else { continue };
		if skip.contains(&login.to_lowercase()) || login.starts_with("app/") || login.ends_with("[bot]") {
			continue;
		}
		let i = by.iter().position(|c| c.0 == login).unwrap_or_else(|| {
			by.push((login.to_string(), 0, pr.merged_at.clone()));
			by.len() - 1
		});
		let c = &mut by[i];
		c.1 += 1;
		if let Some(m) = &pr.merged_at {
			if c.2.as_ref().is_none_or(|f| m < f) {
				c.2 = Some(m.clone());
			}
		}
	}
	let first = |c: &(String, usize, Option<String>)| c.2.clone().unwrap_or_else(|| "undefined".into());
	by.sort_by(|a, b| b.1.cmp(&a.1).then_with(|| first(a).cmp(&first(b))));
	by.into_iter().map(|(login, n, _)| (src.names.iter().find(|(l, _)| *l == login).map_or(login.clone(), |(_, name)| name.clone()), n)).collect()
}

/// One issue on GitHub: who filed it, what it says, and how it ended.
#[derive(Clone, Debug, Default)]
pub struct Issue {
	pub author: Option<String>,
	pub body: String,
	pub created_at: Option<String>,
	/// OPEN or CLOSED.
	pub state: String,
	/// COMPLETED, NOT_PLANNED, DUPLICATE or REOPENED; None while it never closed.
	pub state_reason: Option<String>,
	pub labels: Vec<String>,
	/// The pull requests that closed it.
	pub closing_prs: usize,
	/// The comments by the repository's owner, members and collaborators.
	pub maintainer_comments: Vec<String>,
}

const ISSUE_FIELDS: &str = "author,body,createdAt,state,stateReason,labels,closedByPullRequestsReferences,comments";

/// Every issue of `repo`, open or closed, through the GitHub CLI (`gh`, logged in).
pub fn fetch_issues(repo: &str) -> Result<Vec<Issue>, String> {
	let out = std::process::Command::new("gh")
		.args(["issue", "list", "--repo", repo, "--state", "all", "--limit", "20000", "--json", ISSUE_FIELDS])
		.output()
		.map_err(|e| format!("gh (the GitHub CLI) could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("gh issue list failed: {}", String::from_utf8_lossy(&out.stderr).trim()));
	}
	parse_issues(&String::from_utf8_lossy(&out.stdout))
}

/// `gh issue list --json author,body,createdAt,state,stateReason,labels,closedByPullRequestsReferences,comments` output.
pub fn parse_issues(json: &str) -> Result<Vec<Issue>, String> {
	let doc: Value = serde_json::from_str(json).map_err(|e| format!("gh issue list: {e}"))?;
	let list = doc.as_array().ok_or("gh issue list: not a list")?;
	let text = |v: &Value, key: &str| v.get(key).and_then(Value::as_str).map(str::to_string);
	let maintainer = |c: &&Value| matches!(c.get("authorAssociation").and_then(Value::as_str), Some("OWNER" | "MEMBER" | "COLLABORATOR"));
	Ok(list
		.iter()
		.map(|i| Issue {
			author: i.pointer("/author/login").and_then(Value::as_str).map(str::to_string),
			body: text(i, "body").unwrap_or_default(),
			created_at: text(i, "createdAt"),
			state: text(i, "state").unwrap_or_default(),
			state_reason: text(i, "stateReason").filter(|r| !r.is_empty()),
			labels: i.get("labels").and_then(Value::as_array).map(|a| a.iter().filter_map(|l| text(l, "name")).collect()).unwrap_or_default(),
			closing_prs: i.get("closedByPullRequestsReferences").and_then(Value::as_array).map_or(0, Vec::len),
			maintainer_comments: i.get("comments").and_then(Value::as_array).map(|a| a.iter().filter(maintainer).filter_map(|c| text(c, "body")).collect()).unwrap_or_default(),
		})
		.collect())
}

/// Undoes the Discord bot's escaping of a name in a Markdown table cell (tools/discord-bot/lib/issue.js:
/// `inert` and `cell`).
fn unescape_cell(s: &str) -> String {
	s.replace("\\|", "|").replace("@\u{200d}", "@").replace("#\u{200d}", "#").replace("&lt;", "<").replace("&gt;", ">").replace("&amp;", "&")
}

/// Who reported an issue: the Discord name in the bot's first line ("**Reported by <name> on
/// [Discord](...)**"), else the GitHub login that opened it. The Discord name is folded to NFKC, so
/// styled letters (𝔄𝔫𝔫𝔦𝔢) come out as the plain ones the game's fonts draw (Annie).
pub fn reporter(issue: &Issue) -> Option<String> {
	let first = issue.body.lines().next().unwrap_or_default().trim();
	if let Some(rest) = first.strip_prefix("**Reported by ") {
		if let Some(at) = rest.find(" on [Discord](") {
			return Some(unescape_cell(&rest[..at]).nfkc().collect::<String>().trim().to_string());
		}
	}
	issue.author.clone()
}

/// A maintainer's comment saying the bug is fixed ("Fixed in 0.3.5", "This is already fixed"), and
/// not that it isn't ("not fixed", "isn't fixed yet").
fn says_fixed(comment: &str) -> bool {
	let lower = comment.to_lowercase();
	let negation = |w: &str| matches!(w, "not" | "never") || w.ends_with("n't") || w.ends_with("n’t");
	lower.match_indices("fixed").any(|(at, _)| {
		let whole = !lower[..at].ends_with(char::is_alphanumeric) && !lower[at + 5..].starts_with(char::is_alphanumeric);
		let mut before = lower[..at].split_whitespace().rev();
		let negated = match before.next() {
			Some("yet") => before.next().is_some_and(negation),
			Some(w) => negation(w),
			None => false,
		};
		whole && !negated
	})
}

/// Whether an issue counts toward its reporter on the Guiding Stars page: a bug report that helped.
///
/// - Only bug reports: an issue labelled `enhancement` (a feature request) counts only if it is also
///   labelled `bug`.
/// - Never: closed as a duplicate or as not planned, or labelled `duplicate`, `invalid`, `wontfix` or
///   `resolution:*` (no action, cannot reproduce), or still labelled `needs-info` or `stale` (waiting
///   on the reporter).
/// - Otherwise it counts when it is labelled `confirmed` (reproduced and checked: a real bug) or
///   `fix-merged`, or it was closed as completed by a fix: a pull request that closed it, a
///   `released:*` label (the fix shipped), or a maintainer's comment saying it is fixed.
pub fn useful_report(issue: &Issue) -> bool {
	let has = |l: &str| issue.labels.iter().any(|x| x == l);
	let has_prefix = |p: &str| issue.labels.iter().any(|x| x.starts_with(p));
	if has("enhancement") && !has("bug") {
		return false;
	}
	if matches!(issue.state_reason.as_deref(), Some("DUPLICATE" | "NOT_PLANNED")) || ["duplicate", "invalid", "wontfix", "needs-info", "stale"].iter().any(|l| has(l)) || has_prefix("resolution:") {
		return false;
	}
	if has("confirmed") || has("fix-merged") {
		return true;
	}
	issue.state == "CLOSED" && issue.state_reason.as_deref() == Some("COMPLETED") && (issue.closing_prs > 0 || has_prefix("released:") || issue.maintainer_comments.iter().any(|c| says_fixed(c)))
}

/// Bug reporters by useful reports ([`useful_report`]), most first; a tie goes to whoever reported
/// first. At most `cap` of them. Bots, names without a letter or digit, and the logins and names in
/// `exclude` are left out; `names` maps a login or Discord name to the name shown, and the same name
/// in another case is one person. -> (name, reports).
pub fn rank_reporters(issues: &[Issue], src: &Source, cap: usize) -> Vec<(String, usize)> {
	let skip: Vec<String> = src.exclude.iter().map(|l| l.to_lowercase()).collect();
	// shown name, count, first report; in order of first appearance.
	let mut by: Vec<(String, usize, Option<String>)> = Vec::new();
	for issue in issues.iter().filter(|i| useful_report(i)) {
		let Some(raw) = reporter(issue).filter(|r| r.chars().any(char::is_alphanumeric)) else { continue };
		if raw.starts_with("app/") || raw.ends_with("[bot]") {
			continue;
		}
		let name = src.names.iter().find(|(l, _)| *l == raw).map_or(raw.clone(), |(_, n)| n.clone());
		if skip.contains(&raw.to_lowercase()) || skip.contains(&name.to_lowercase()) {
			continue;
		}
		let i = by.iter().position(|c| c.0.to_lowercase() == name.to_lowercase()).unwrap_or_else(|| {
			by.push((name.clone(), 0, issue.created_at.clone()));
			by.len() - 1
		});
		let c = &mut by[i];
		c.1 += 1;
		if let Some(at) = &issue.created_at {
			if c.2.as_ref().is_none_or(|f| at < f) {
				c.2 = Some(at.clone());
			}
		}
	}
	let first = |c: &(String, usize, Option<String>)| c.2.clone().unwrap_or_else(|| "undefined".into());
	by.sort_by(|a, b| b.1.cmp(&a.1).then_with(|| first(a).cmp(&first(b))));
	by.into_iter().take(cap).map(|(name, n, _)| (name, n)).collect()
}

/// `names`' shown name for a login or name; `None` when `exclude` leaves it out.
fn shown(src: &Source, raw: &str) -> Option<String> {
	let name = src.names.iter().find(|(l, _)| *l == raw).map_or(raw, |(_, n)| n.as_str());
	let skip = |s: &str| src.exclude.iter().any(|e| e.to_lowercase() == s.to_lowercase());
	(!skip(raw) && !skip(name)).then(|| name.to_string())
}

/// The translators, from LOCALES (`translators` per locale, in its order): (name shown, locale code,
/// language in English: the interface key the page shows it through). `exclude` and `names` apply.
pub fn translators(src: &Source) -> Vec<(String, &'static str, &'static str)> {
	forge_guide::locales::LOCALES.iter().flat_map(|l| l.translators.iter().filter_map(move |t| Some((shown(src, t)?, l.code, l.language)))).collect()
}

/// The ideas that shipped, in data/credits.json's order: (name shown, pull request or issue number).
/// `exclude` and `names` apply.
pub fn ideas(src: &Source) -> Vec<(String, u64)> {
	src.ideas.iter().filter_map(|i| Some((shown(src, &i.name)?, i.reference))).collect()
}

fn lua_string(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

/// Core/Credits.lua.
pub fn render(supporters: &[String], contributors: &[(String, usize)], reporters: &[(String, usize)], translators: &[(String, &str, &str)], ideas: &[(String, u64)]) -> String {
	let mut out = vec![
		"-- Generated by `forge release credits` from data/credits.json, the repository's merged and folded pull requests and its issues, and the locales' translators. Do not edit: rebuild with that command.".to_string(),
		String::new(),
		"local _, ns = ...".into(),
		String::new(),
		"ns.Credits = {".into(),
		"\t-- Supporters, highest total first.".into(),
		"\tsupporters = {".into(),
	];
	out.extend(supporters.iter().map(|s| format!("\t\t{},", lua_string(s))));
	out.extend(["\t},".to_string(), "\t-- GitHub contributors by merged or folded pull requests, most first.".into(), "\tcontributors = {".into()]);
	out.extend(contributors.iter().map(|(name, prs)| format!("\t\t{{ name = {}, prs = {prs} }},", lua_string(name))));
	out.extend(["\t},".to_string(), format!("\t-- Bug reporters by confirmed or fixed reports, most first (the top {REPORTERS_SHOWN})."), "\tbugReporters = {".into()]);
	out.extend(reporters.iter().map(|(name, n)| format!("\t\t{{ name = {}, reports = {n} }},", lua_string(name))));
	out.extend(["\t},".to_string(), "\t-- Translators by language (the locales' translators); `language` is the interface key shown.".into(), "\ttranslators = {".into()]);
	out.extend(translators.iter().map(|(name, code, language)| format!("\t\t{{ name = {}, locale = {}, language = {} }},", lua_string(name), lua_string(code), lua_string(language))));
	out.extend(["\t},".to_string(), "\t-- Ideas that shipped though someone else built them, in the order they shipped: who, and the pull request or issue.".into(), "\tideas = {".into()]);
	out.extend(ideas.iter().map(|(name, r)| format!("\t\t{{ name = {}, ref = {r} }},", lua_string(name))));
	out.extend(["\t},".to_string(), "}".into(), String::new()]);
	out.join("\n")
}

#[cfg(test)]
mod tests {
	use super::*;

	fn pr(login: &str, at: &str) -> Merged {
		Merged { login: Some(login.into()), merged_at: Some(at.into()) }
	}

	#[test]
	fn a_closed_pull_request_counts_when_its_commit_was_folded_in_with_its_authorship() {
		let closed = |login: &str, at: &str, commits: &[(&str, &str)]| Closed {
			login: Some(login.into()),
			closed_at: Some(at.into()),
			commits: commits.iter().map(|(e, h)| (e.to_string(), h.to_string())).collect(),
		};
		let prs = [
			// folded: same email, the ref's subject starts with the cut headline
			closed("ann", "2026-11-08T10:00:00Z", &[("ann@x.org", "Translations: Brazilian Portuguese guide texts for the Horde leveling…")]),
			// folded under a reworded subject on a later commit of the same PR
			closed("bob", "2026-11-08T11:00:00Z", &[("bob@x.org", "WIP"), ("bob@x.org", "Pace line: at a guide's end")]),
			// closed, never landed
			closed("cid", "2026-11-08T12:00:00Z", &[("cid@x.org", "Something we did not take")]),
			// same headline, but the maintainer wrote it (authorship not kept): not the PR author's
			closed("dee", "2026-11-08T13:00:00Z", &[("dee@x.org", "Gear: tools")]),
		];
		let on_ref = [
			("ann@x.org".to_string(), "Translations: Brazilian Portuguese guide texts for the Horde leveling guides".to_string()),
			("bob@x.org".to_string(), "Pace line: at a guide's end, the level the route gets you to".to_string()),
			("owner@x.org".to_string(), "Gear: tools".to_string()),
		];
		let got = folded(&prs, &on_ref);
		assert_eq!(got.iter().map(|m| m.login.clone().unwrap()).collect::<Vec<_>>(), ["ann", "bob"]);
		assert_eq!(got[0].merged_at.as_deref(), Some("2026-11-08T10:00:00Z"));
		// folded pull requests rank with the merged ones
		let all = [pr("bob", "2026-10-01T00:00:00Z")].into_iter().chain(got).collect::<Vec<_>>();
		let src = Source { supporters: vec![], exclude: vec![], names: vec![], ideas: vec![] };
		assert_eq!(rank_contributors(&all, &src), [("bob".to_string(), 2), ("ann".into(), 1)]);
	}

	#[test]
	fn an_open_pull_request_counts_when_its_head_commit_is_on_the_release_ref() {
		let open = |login: &str, head: &str| Open { login: Some(login.into()), head: head.into() };
		let prs = [
			// folded: the integration branch merged its exact head
			open("ann", "aaaa"),
			// open, its head not on the ref (a later push, or never folded)
			open("bob", "bbbb"),
			// a second open pull request of the same author, folded too
			open("ann", "cccc"),
		];
		let on_ref = [
			("aaaa".to_string(), "2026-11-09T10:00:00+01:00".to_string()),
			("cccc".to_string(), "2026-11-10T10:00:00+01:00".to_string()),
			("dddd".to_string(), "2026-11-08T10:00:00+01:00".to_string()),
		];
		let got = folded_open(&prs, &on_ref);
		assert_eq!(got.iter().map(|m| m.login.clone().unwrap()).collect::<Vec<_>>(), ["ann", "ann"]);
		assert_eq!(got[0].merged_at.as_deref(), Some("2026-11-09T10:00:00+01:00"));
		// they rank with the merged ones
		let all = [pr("bob", "2026-10-01T00:00:00Z")].into_iter().chain(got).collect::<Vec<_>>();
		let src = Source { supporters: vec![], exclude: vec![], names: vec![], ideas: vec![] };
		assert_eq!(rank_contributors(&all, &src), [("ann".to_string(), 2), ("bob".into(), 1)]);
	}

	#[test]
	fn gh_commits_parse_one_pair_per_author() {
		let view: Value = serde_json::from_str(r#"{"commits":[{"messageHeadline":"Fix","authors":[{"email":"A@x.org"},{"email":"b@x.org"},{"email":""}]}]}"#).unwrap();
		assert_eq!(parse_commits(&view), [("a@x.org".to_string(), "Fix".to_string()), ("b@x.org".into(), "Fix".into())]);
	}

	#[test]
	fn contributors_rank_by_merged_prs_ties_to_the_first_merge_without_bots_or_excluded_logins() {
		let prs = [
			pr("late", "2026-10-05T00:00:00Z"),
			pr("late", "2026-10-06T00:00:00Z"),
			pr("early", "2026-10-01T00:00:00Z"),
			pr("early", "2026-10-09T00:00:00Z"),
			pr("most", "2026-10-08T00:00:00Z"),
			pr("most", "2026-10-08T00:00:00Z"),
			pr("most", "2026-10-08T00:00:00Z"),
			pr("app/github-actions", "2026-10-01T00:00:00Z"),
			pr("dependabot[bot]", "2026-10-01T00:00:00Z"),
			pr("Owner", "2026-10-01T00:00:00Z"),
		];
		let src = Source { supporters: vec![], exclude: vec!["owner".into()], names: vec![("most".into(), "Most Of All".into())], ideas: vec![] };
		assert_eq!(rank_contributors(&prs, &src), [("Most Of All".to_string(), 3), ("early".into(), 2), ("late".into(), 2)]);
	}

	#[test]
	fn names_with_quotes_backslashes_and_newlines_load_back_unchanged_in_lua() {
		let odd: Vec<String> = ["Say \"hi\"", "back\\slash", "two\nlines", "pipe|name"].iter().map(|s| s.to_string()).collect();
		let lua_text = render(&odd, &[("q\"uote".into(), 1)], &[("大地瓜 | x".into(), 4)], &[("山猫".into(), "zhCN", "Chinese (simplified)")], &[("Say \"idea\"".into(), 1012)]);
		let lua = mlua::Lua::new();
		let ns = lua.create_table().unwrap();
		lua.load(&lua_text).call::<()>((mlua::Nil, ns.clone())).unwrap();
		let credits: mlua::Table = ns.get("Credits").unwrap();
		let supporters: Vec<String> = credits.get::<mlua::Table>("supporters").unwrap().sequence_values::<String>().map(Result::unwrap).collect();
		assert_eq!(supporters, odd);
		let first: mlua::Table = credits.get::<mlua::Table>("contributors").unwrap().get(1).unwrap();
		assert_eq!(first.get::<String>("name").unwrap(), "q\"uote");
		assert_eq!(first.get::<i64>("prs").unwrap(), 1);
		let reporter: mlua::Table = credits.get::<mlua::Table>("bugReporters").unwrap().get(1).unwrap();
		assert_eq!(reporter.get::<String>("name").unwrap(), "大地瓜 | x");
		assert_eq!(reporter.get::<i64>("reports").unwrap(), 4);
		let translator: mlua::Table = credits.get::<mlua::Table>("translators").unwrap().get(1).unwrap();
		assert_eq!(translator.get::<String>("name").unwrap(), "山猫");
		assert_eq!(translator.get::<String>("locale").unwrap(), "zhCN");
		assert_eq!(translator.get::<String>("language").unwrap(), "Chinese (simplified)");
		let idea: mlua::Table = credits.get::<mlua::Table>("ideas").unwrap().get(1).unwrap();
		assert_eq!(idea.get::<String>("name").unwrap(), "Say \"idea\"");
		assert_eq!(idea.get::<i64>("ref").unwrap(), 1012);
	}

	#[test]
	fn ideas_load_from_credits_json_in_order_and_a_broken_one_is_refused() {
		let dir = std::env::temp_dir().join(format!("forge-credits-ideas-{}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		let file = dir.join("credits.json");
		std::fs::write(&file, r#"{"supporters":[],"exclude":["Gone"],"names":{"volvik":"CDVolvik"},"ideas":[{"name":"volvik","ref":1012},{"name":"Ann","ref":7},{"name":"gone","ref":9}]}"#).unwrap();
		let src = read_source(&file).unwrap();
		assert_eq!(src.ideas, [Idea { name: "volvik".into(), reference: 1012 }, Idea { name: "Ann".into(), reference: 7 }, Idea { name: "gone".into(), reference: 9 }]);
		// `names` maps the login, `exclude` leaves one out (any case), the order stays.
		assert_eq!(ideas(&src), [("CDVolvik".to_string(), 1012), ("Ann".into(), 7)]);
		for broken in [r#"{"ideas":[{"name":"Ann"}]}"#, r#"{"ideas":[{"name":" ","ref":3}]}"#, r##"{"ideas":[{"name":"Ann","ref":"#3"}]}"##, r#"{"ideas":[{"name":"Ann","ref":0}]}"#] {
			std::fs::write(&file, broken).unwrap();
			assert!(read_source(&file).is_err(), "{broken}");
		}
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn the_shipped_credits_json_credits_the_ideas_the_changelog_credits_in_the_order_they_shipped() {
		// The changelog's "idea by" credits: PRDesrochers on #293 (0.2.6), aronjanosch's #954 (0.3.3),
		// CDVolvik's target portraits #1012 (0.3.6), IgorMagals's #724 (0.3.7), petllama's Freedoom Arcade on flights
		// #2228 (0.4.0).
		let src = read_source(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").join(SOURCE)).unwrap();
		let want = [("PRDesrochers", 293), ("aronjanosch", 954), ("CDVolvik", 1012), ("IgorMagals", 724), ("petllama", 2228)].map(|(n, r)| (n.to_string(), r));
		assert_eq!(ideas(&src), want, "{:?}", src.ideas);
	}

	#[test]
	fn translators_come_from_the_locales_in_their_order_with_their_language() {
		let all = translators(&src(&[], &[]));
		// Every LOCALES translator, in its order, beside its locale's language.
		let want: Vec<(String, &str, &str)> = forge_guide::locales::LOCALES.iter().flat_map(|l| l.translators.iter().map(|t| (t.to_string(), l.code, l.language))).collect();
		assert_eq!(all, want);
		assert!(all.contains(&("山猫".to_string(), "zhCN", "Chinese (simplified)")));
		assert!(all.contains(&("CDVolvik".to_string(), "esMX", "Spanish (Latin America)")));
		// `exclude` and `names` apply as on the other lists.
		let mapped = translators(&src(&["yendi"], &[("julen92", "Julen")]));
		assert!(!mapped.iter().any(|t| t.0 == "Yendi"));
		assert!(mapped.contains(&("Julen".to_string(), "esES", "Spanish (Spain)")));
	}

	#[test]
	fn gh_output_parses() {
		let got = parse_merged(r#"[{"author":{"login":"ann"},"mergedAt":"2026-10-01T00:00:00Z"},{"author":null,"mergedAt":null}]"#).unwrap();
		assert_eq!(got[0].login.as_deref(), Some("ann"));
		assert!(got[1].login.is_none());
	}

	/// A Discord report as the bot files it, under the maintainer's account.
	fn discord(name: &str, at: &str, labels: &[&str]) -> Issue {
		Issue {
			author: Some("fitzforge".into()),
			body: format!("**Reported by {name} on [Discord](https://discord.com/channels/1/2)** · Questing\n\n> the arrow points the wrong way"),
			created_at: Some(at.into()),
			state: "OPEN".into(),
			labels: labels.iter().map(|l| l.to_string()).collect(),
			..Default::default()
		}
	}

	/// An issue opened on GitHub by `login`.
	fn github(login: &str, at: &str, labels: &[&str]) -> Issue {
		Issue {
			author: Some(login.into()),
			body: "### What went wrong\n\nIt broke.".into(),
			created_at: Some(at.into()),
			state: "OPEN".into(),
			labels: labels.iter().map(|l| l.to_string()).collect(),
			..Default::default()
		}
	}

	fn closed(mut i: Issue, reason: &str) -> Issue {
		i.state = "CLOSED".into();
		i.state_reason = Some(reason.into());
		i
	}

	fn src(exclude: &[&str], names: &[(&str, &str)]) -> Source {
		Source { supporters: vec![], exclude: exclude.iter().map(|s| s.to_string()).collect(), names: names.iter().map(|(a, b)| (a.to_string(), b.to_string())).collect(), ideas: vec![] }
	}

	#[test]
	fn the_reporter_is_the_bots_discord_name_unescaped_else_the_author() {
		assert_eq!(reporter(&discord("Pynte", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("Pynte"));
		// The bot escapes a pipe for its table cell, and @ and # so they don't ping or link.
		assert_eq!(reporter(&discord("Tazul \\| Robin", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("Tazul | Robin"));
		assert_eq!(reporter(&discord("@\u{200d}me &amp; #\u{200d}1 &lt;3", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("@me & #1 <3"));
		// Styled letters fold to the plain ones the game's fonts have.
		assert_eq!(reporter(&discord("𝔄𝔫𝔫𝔦𝔢", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("Annie"));
		assert_eq!(reporter(&discord("大地瓜", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("大地瓜"));
		assert_eq!(reporter(&github("thmastin", "2026-10-01T00:00:00Z", &[])).as_deref(), Some("thmastin"));
		// A maintainer's own issue that only mentions Discord in its text is the maintainer's.
		let mut own = github("fitzforge", "2026-10-01T00:00:00Z", &[]);
		own.body = "Reported on Discord by someone: the panel never shows.".into();
		assert_eq!(reporter(&own).as_deref(), Some("fitzforge"));
	}

	#[test]
	fn a_report_counts_when_confirmed_or_closed_by_a_fix() {
		let at = "2026-10-01T00:00:00Z";
		assert!(useful_report(&discord("a", at, &["bug", "confirmed"])));
		assert!(useful_report(&discord("a", at, &["bug", "fix-merged"])));
		assert!(!useful_report(&discord("a", at, &["bug", "triage"])), "open and unconfirmed");
		let mut by_pr = closed(discord("a", at, &["bug"]), "COMPLETED");
		assert!(!useful_report(&by_pr), "closed as completed with no fix shown");
		by_pr.closing_prs = 1;
		assert!(useful_report(&by_pr));
		assert!(useful_report(&closed(discord("a", at, &["bug", "released:v0.3.4"]), "COMPLETED")));
		let mut said = closed(discord("a", at, &["bug"]), "COMPLETED");
		said.maintainer_comments = vec!["Thanks! This is fixed in 0.3.5.".into()];
		assert!(useful_report(&said));
		for not_yet in ["This isn't fixed yet, reopening later.", "Not fixed: it works as intended.", "It's not yet fixed.", "Unfixed for now", "fixedness"] {
			said.maintainer_comments = vec![not_yet.into()];
			assert!(!useful_report(&said), "{not_yet}");
		}
	}

	#[test]
	fn duplicates_rejections_feature_requests_and_needs_info_never_count() {
		let at = "2026-10-01T00:00:00Z";
		let mut dup = closed(discord("a", at, &["bug", "confirmed"]), "DUPLICATE");
		dup.closing_prs = 1;
		assert!(!useful_report(&dup), "closed as a duplicate");
		assert!(!useful_report(&closed(discord("a", at, &["bug", "duplicate"]), "NOT_PLANNED")));
		assert!(!useful_report(&closed(discord("a", at, &["bug", "duplicate"]), "COMPLETED")), "the duplicate label");
		assert!(!useful_report(&closed(discord("a", at, &["bug", "resolution:no-action"]), "NOT_PLANNED")));
		assert!(!useful_report(&closed(discord("a", at, &["bug", "resolution:cannot-reproduce", "released:v0.3.4"]), "COMPLETED")));
		assert!(!useful_report(&closed(discord("a", at, &["invalid", "fix-merged"]), "COMPLETED")));
		assert!(!useful_report(&discord("a", at, &["bug", "confirmed", "needs-info"])), "still waiting on the reporter");
		assert!(!useful_report(&discord("a", at, &["bug", "needs-info", "stale"])));
		assert!(!useful_report(&github("ann", at, &["enhancement", "fix-merged"])), "a feature request");
		assert!(useful_report(&github("ann", at, &["bug", "enhancement", "confirmed"])));
	}

	#[test]
	fn reporters_rank_by_useful_reports_ties_to_the_first_report_without_bots_or_excluded_names() {
		let ok = &["bug", "confirmed"];
		let issues = [
			discord("Late", "2026-10-05T00:00:00Z", ok),
			discord("Late", "2026-10-06T00:00:00Z", ok),
			github("early", "2026-10-01T00:00:00Z", ok),
			github("early", "2026-10-09T00:00:00Z", ok),
			discord("Most", "2026-10-08T00:00:00Z", ok),
			github("most", "2026-10-08T01:00:00Z", ok), // the same name in another case: one person
			discord("Aka", "2026-10-08T02:00:00Z", ok), // mapped onto Most's name
			discord("Most", "2026-10-08T03:00:00Z", &["bug", "duplicate"]),
			discord("Most", "2026-10-08T03:00:00Z", &["bug", "needs-info"]),
			discord("Lone", "2026-10-02T00:00:00Z", &["bug", "triage"]), // never confirmed: not listed
			github("dependabot[bot]", "2026-10-01T00:00:00Z", ok),
			github("app/polestar-bot", "2026-10-01T00:00:00Z", ok),
			github("fitzforge", "2026-10-01T00:00:00Z", ok),          // the maintainer's own issue
			discord("Fitz \\| Polestar", "2026-10-01T00:00:00Z", ok), // the maintainer on Discord
			discord("Private", "2026-10-01T00:00:00Z", ok),           // asked to be left out
			discord("᲼", "2026-10-01T00:00:00Z", ok),                 // a blank-looking name
			discord("Once", "2026-10-03T00:00:00Z", ok),
		];
		let s = src(&["FitzForge", "fitz | polestar", "private"], &[("Aka", "Most"), ("Once", "Once Upon")]);
		assert_eq!(rank_reporters(&issues, &s, 40), [("Most".to_string(), 3), ("early".into(), 2), ("Late".into(), 2), ("Once Upon".into(), 1)]);
		assert_eq!(rank_reporters(&issues, &s, 2), [("Most".to_string(), 3), ("early".into(), 2)], "capped");
		// An exclude entry can name the shown name too.
		let by_shown = src(&["fitzforge", "fitz | polestar", "private", "once upon"], &[("Once", "Once Upon")]);
		assert!(!rank_reporters(&issues, &by_shown, 40).iter().any(|(n, _)| n == "Once Upon"));
	}

	#[test]
	fn gh_issue_output_parses() {
		let got = parse_issues(
			r#"[{"author":{"login":"ann"},"body":"x","createdAt":"2026-10-01T00:00:00Z","state":"CLOSED","stateReason":"COMPLETED",
			"labels":[{"name":"bug"}],"closedByPullRequestsReferences":[{"number":5}],
			"comments":[{"author":{"login":"fitzforge"},"authorAssociation":"OWNER","body":"Fixed."},{"author":{"login":"ann"},"authorAssociation":"NONE","body":"fixed?"}]},
			{"author":null,"body":"","createdAt":"2026-10-02T00:00:00Z","state":"OPEN","stateReason":"","labels":[],"closedByPullRequestsReferences":[],"comments":[]}]"#,
		)
		.unwrap();
		assert_eq!(got[0].author.as_deref(), Some("ann"));
		assert_eq!((got[0].state.as_str(), got[0].state_reason.as_deref(), got[0].closing_prs), ("CLOSED", Some("COMPLETED"), 1));
		assert_eq!(got[0].labels, ["bug"]);
		assert_eq!(got[0].maintainer_comments, ["Fixed."]);
		assert!(got[1].author.is_none() && got[1].state_reason.is_none());
	}
}
