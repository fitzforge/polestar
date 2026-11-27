//! The release's contributors: the GitHub logins a release's notes tag in their `## Contributors`
//! section (GitHub shows everyone mentioned in a release's notes as a contributor on it). One source
//! with the Guiding Stars page ([`crate::credits`]: its pull request, issue, translator and idea rules),
//! cut down to THIS release: the commits in `<previous release tag>...<release ref>` (a hotfix branch's
//! picks included: commits whose change the previous release already had are left out).
//!
//! A login is tagged for:
//!
//! - the author of a pull request merged into the range (a commit of the range, or the commit it was
//!   cherry-picked from, belongs to it), of a closed one whose commit was folded into the range with its
//!   authorship kept, and of an open one whose head commit is in the range;
//! - a `Co-authored-by` trailer of a commit of the range that GitHub resolves to an account (a person's
//!   own commits are their pull requests; a tool's no-reply trailer, such as an assistant's, is no one);
//! - the reporter of an issue the release closes whose report counts ([`credits::useful_report`]): one a
//!   pull request of the range closed, one a commit of the range names (`(#123)`, `Fixes #123`), or one
//!   an open pull request folded into the range closes. A report the Discord bot relayed counts only
//!   when data/credits.json `github` maps its Discord name to a login; otherwise it stays on the
//!   Guiding Stars page only;
//! - a translator is tagged as any author is, through their pull request or co-authored commit: a
//!   locale file that changed without them (new keys synced by the maintainer) tags no one;
//! - someone whose idea (data/credits.json `ideas`) shipped: its pull request or issue is in the range.
//!
//! Never the maintainer, a bot, or anyone `exclude` leaves out. An idea's name counts only when it is a
//! login GitHub knows from the repository (a pull request or issue author there): a tag notifies
//! whoever holds it, so a name that merely looks like a login is never tagged.

use crate::credits::{self, Closed, Issue, Merged, Open, Source};
use serde_json::Value;
use std::collections::{BTreeMap, HashMap, HashSet};
use std::path::Path;
use std::sync::LazyLock;

/// One commit of the release's range.
#[derive(Clone, Debug, Default)]
pub struct Commit {
	pub sha: String,
	/// A merge commit (more than one parent): it carries no work of its own.
	pub merge: bool,
	/// The author's email, lower case.
	pub email: String,
	/// The committer date (ISO).
	pub date: String,
	pub subject: String,
	pub body: String,
}

/// What GitHub knows of a commit: the accounts behind its `Co-authored-by` trailers (not the git
/// author, who has the pull request), and the pull requests it belongs to (merged ones only).
#[derive(Clone, Debug, Default)]
pub struct CommitInfo {
	pub co_authors: Vec<String>,
	pub prs: Vec<Merged>,
}

fn git(root: &Path, args: &[&str]) -> Result<String, String> {
	let out = std::process::Command::new("git").arg("-C").arg(root).args(args).output().map_err(|e| format!("git could not run: {e}"))?;
	if !out.status.success() {
		return Err(format!("git {} failed: {}", args.join(" "), String::from_utf8_lossy(&out.stderr).trim()));
	}
	Ok(String::from_utf8_lossy(&out.stdout).into_owned())
}

/// A release version's numbers (`x.y.z` and the hotfix, 0 without one); None for a pre-release.
fn numbers(v: &str) -> Option<[u64; 4]> {
	static RE: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"^(\d+)\.(\d+)\.(\d+)(?:\.(\d+))?$").unwrap());
	let c = RE.captures(v)?;
	let n = |i: usize| c.get(i).map_or(Ok(0), |m| m.as_str().parse::<u64>()).ok();
	Some([n(1)?, n(2)?, n(3)?, n(4)?])
}

/// The newest release tag (`v<x.y.z[.hotfix]>`, no pre-release) below `version`: what this release
/// follows, so a hotfix of an older line (0.3.7.1 after 0.4.0) follows its own line's last release.
pub fn previous_tag(root: &Path, version: &str) -> Result<String, String> {
	let base = version.split('-').next().unwrap_or(version);
	let this = numbers(base).ok_or_else(|| format!("\"{version}\" is not a version"))?;
	let tags = git(root, &["tag", "--list", "v*"])?;
	tags.lines()
		.filter_map(|t| Some((numbers(t.strip_prefix('v')?)?, t)))
		.filter(|(n, _)| *n < this)
		.max()
		.map(|(_, t)| t.to_string())
		.ok_or_else(|| format!("no release tag below {version}: pass --since <tag>"))
}

/// Whether `rev` names a commit in `root`.
pub fn has_rev(root: &Path, rev: &str) -> bool {
	git(root, &["rev-parse", "--verify", "--quiet", &format!("{rev}^{{commit}}")]).is_ok()
}

/// Who made a commit and when, with its subject: what a cherry-pick keeps, under a new id.
type PickKey = (String, String, String);

/// `git log <args>` as commits with their [`PickKey`], newest first.
fn log(root: &Path, args: &[&str]) -> Result<Vec<(Commit, PickKey)>, String> {
	let mut full = vec!["log", "--format=%H%x1f%P%x1f%ae%x1f%aI%x1f%cI%x1f%s%x1f%b%x1e"];
	full.extend_from_slice(args);
	Ok(git(root, &full)?
		.split('\u{1e}')
		.filter_map(|rec| {
			let mut f = rec.trim_start_matches('\n').splitn(7, '\u{1f}');
			let sha = f.next().filter(|s| !s.is_empty())?;
			let merge = f.next()?.split_whitespace().count() > 1;
			let (email, authored) = (f.next()?.to_lowercase(), f.next()?.to_string());
			let commit = Commit { sha: sha.to_lowercase(), merge, email, date: f.next()?.to_string(), subject: f.next()?.to_string(), body: f.next().unwrap_or_default().to_string() };
			let key = (commit.email.clone(), authored, commit.subject.clone());
			Some((commit, key))
		})
		.collect())
}

/// The release before `since` when `since` is a hotfix tag (`vX.Y.Z.N`, N above 0): `prior..since` is
/// then the hotfix's picks. None for any other `since`: a release's own commits are never in the
/// range after it.
pub fn prior_of(root: &Path, since: &str) -> Option<String> {
	let version = since.strip_prefix('v')?;
	if numbers(version)?[3] == 0 {
		return None;
	}
	previous_tag(root, version).ok()
}

/// The commits of `since...until` that only `until` has, newest first, without what the previous
/// release already carried under another id (a hotfix's pick of a commit on `next`, or the other way
/// round):
///
/// - `git log --right-only --cherry-pick` drops a commit whose change a commit only `since` has also
///   makes (a hotfix branch that was never merged back);
/// - once the hotfix is merged back, `since` is an ancestor of `until` and that leaves nothing to compare
///   with, so `prior` ([`prior_of`]) names the picks: the commits of `prior..since`. A commit of the
///   range with the same author, author date and subject as one of them is that pick's original
///   (`git cherry-pick` keeps all three).
pub fn range_commits(root: &Path, since: &str, until: &str, prior: Option<&str>) -> Result<Vec<Commit>, String> {
	let new = log(root, &["--right-only", "--cherry-pick", &format!("{since}...{until}")])?;
	let picked: HashSet<PickKey> = match prior {
		Some(p) => log(root, &["--no-merges", &format!("{p}..{since}")])?.into_iter().map(|(_, k)| k).collect(),
		None => HashSet::new(),
	};
	Ok(new.into_iter().filter(|(c, k)| c.merge || !picked.contains(k)).map(|(c, _)| c).collect())
}

/// The previous hotfix's picks: the commits of `prior..since` ([`prior_of`]), no merges.
pub fn picks(root: &Path, prior: &str, since: &str) -> Result<Vec<Commit>, String> {
	Ok(log(root, &["--no-merges", &format!("{prior}..{since}")])?.into_iter().map(|(c, _)| c).collect())
}

/// The commit `git cherry-pick -x` recorded in a message ("(cherry picked from commit <sha>)").
pub fn cherry_source(body: &str) -> Option<String> {
	static RE: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"\(cherry picked from commit ([0-9a-fA-F]{40})\)").unwrap());
	RE.captures(body).map(|c| c[1].to_lowercase())
}

/// The issue and pull request numbers a commit names: every `#123` of its subject ("... (#4157)",
/// "(#3923, #3708)") and those after a closing keyword in its body ("Fixes #12", "Closes #3, #4").
pub fn refs(subject: &str, body: &str) -> Vec<u64> {
	static NUM: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"#(\d+)").unwrap());
	static KEYWORD: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"(?i)\b(?:fix(?:es|ed)?|close[sd]?|resolve[sd]?):?\s+(#\d+(?:\s*(?:,|and)\s*#\d+)*)").unwrap());
	let numbers = |text: &str| -> Vec<u64> { NUM.captures_iter(text).filter_map(|c| c[1].parse().ok()).collect() };
	let mut out = numbers(subject);
	out.extend(KEYWORD.captures_iter(body).flat_map(|c| numbers(&c[1])));
	out
}

/// `gh api graphql` for the commits' accounts and pull requests, in batches.
pub fn fetch_commit_info(repo: &str, shas: &[String]) -> Result<HashMap<String, CommitInfo>, String> {
	let (owner, name) = repo.split_once('/').ok_or_else(|| format!("\"{repo}\" is not owner/name"))?;
	let mut out = HashMap::new();
	for batch in shas.chunks(40) {
		let query = commit_query(owner, name, batch);
		let run = std::process::Command::new("gh").args(["api", "graphql", "-f"]).arg(format!("query={query}")).output().map_err(|e| format!("gh (the GitHub CLI) could not run: {e}"))?;
		if !run.status.success() {
			return Err(format!("gh api graphql failed: {}", String::from_utf8_lossy(&run.stderr).trim()));
		}
		let doc: Value = serde_json::from_slice(&run.stdout).map_err(|e| format!("gh api graphql: {e}"))?;
		out.extend(parse_commit_info(&doc, batch)?);
	}
	Ok(out)
}

/// The GraphQL query for `shas`: alias `c<i>` per commit.
pub fn commit_query(owner: &str, name: &str, shas: &[String]) -> String {
	let fields = "... on Commit { authors(first: 10) { nodes { email user { login } } } associatedPullRequests(first: 5) { nodes { number state mergedAt author { __typename login } } } }";
	let objects: String = shas.iter().enumerate().map(|(i, sha)| format!(" c{i}: object(oid: \"{sha}\") {{ {fields} }}")).collect();
	format!("query {{ repository(owner: \"{owner}\", name: \"{name}\") {{{objects} }} }}")
}

/// `gh api graphql` output for [`commit_query`] -> per sha. A bot's login gets `app/` in front, as `gh`
/// lists them, so it is never counted.
pub fn parse_commit_info(doc: &Value, shas: &[String]) -> Result<HashMap<String, CommitInfo>, String> {
	if let Some(errors) = doc.get("errors") {
		return Err(format!("gh api graphql: {errors}"));
	}
	let repo = doc.pointer("/data/repository").ok_or("gh api graphql: no repository in the answer")?;
	let nodes = |v: &Value, key: &str| v.get(key).and_then(|x| x.get("nodes")).and_then(Value::as_array).cloned().unwrap_or_default();
	let mut out = HashMap::new();
	for (i, sha) in shas.iter().enumerate() {
		let Some(commit) = repo.get(format!("c{i}")).filter(|c| !c.is_null()) else { continue };
		// The git author comes first in `authors`; a no-reply address that isn't GitHub's own is a tool's
		// (an assistant's trailer resolves to an account of its own).
		let tool = |a: &Value| {
			a.get("email")
				.and_then(Value::as_str)
				.is_some_and(|e| matches!(e.rsplit_once('@'), Some((l, d)) if l.to_lowercase().replace('-', "").ends_with("noreply") && d != "users.noreply.github.com"))
		};
		let co_authors = nodes(commit, "authors").iter().skip(1).filter(|a| !tool(a)).filter_map(|a| a.pointer("/user/login").and_then(Value::as_str).map(str::to_string)).collect();
		let prs = nodes(commit, "associatedPullRequests")
			.iter()
			.filter(|p| p.get("state").and_then(Value::as_str) == Some("MERGED"))
			.map(|p| {
				let login =
					p.pointer("/author/login").and_then(Value::as_str).map(|l| if p.pointer("/author/__typename").and_then(Value::as_str) == Some("Bot") { format!("app/{l}") } else { l.to_string() });
				Merged { number: p.get("number").and_then(Value::as_u64), login, merged_at: p.get("mergedAt").and_then(Value::as_str).map(str::to_string) }
			})
			.collect();
		out.insert(sha.clone(), CommitInfo { co_authors, prs });
	}
	Ok(out)
}

/// data/credits.json `github`: Discord name -> GitHub login, for players whose Discord reports the bot
/// relays and who told us their login. Names are matched ignoring case.
pub fn read_relayed(file: &Path) -> Result<Vec<(String, String)>, String> {
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let doc: Value = serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let Some(map) = doc.get("github") else { return Ok(Vec::new()) };
	let map = map.as_object().ok_or_else(|| format!("{}: \"github\" is an object of Discord name -> GitHub login", file.display()))?;
	static LOGIN: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"^[A-Za-z0-9][A-Za-z0-9_-]*$").unwrap());
	map.iter()
		.map(|(name, login)| match login.as_str() {
			Some(l) if LOGIN.is_match(l) => Ok((name.clone(), l.to_string())),
			_ => Err(format!("{}: \"github\" maps \"{name}\" to a login without @ or spaces", file.display())),
		})
		.collect()
}

/// One tagged login and what it is tagged for.
#[derive(Clone, Debug, PartialEq)]
pub struct Credit {
	pub login: String,
	pub why: Vec<String>,
}

/// Everything [`credits_for`] reads.
pub struct Input<'a> {
	pub src: &'a Source,
	/// data/credits.json `github` ([`read_relayed`]).
	pub relayed: &'a [(String, String)],
	/// The range's commits ([`range_commits`]).
	pub commits: &'a [Commit],
	/// What GitHub knows of those commits and of the commits `cherry-pick -x` took them from.
	pub info: &'a HashMap<String, CommitInfo>,
	/// The closed and open pull requests folded into the range ([`credits::folded`], [`credits::folded_open`]).
	pub folded: &'a [Merged],
	/// Every issue; `fixed_on_ref` set for those an open pull request of the range closes.
	pub issues: &'a [Issue],
	/// Every login GitHub knows from the repository's pull requests and issues.
	pub known: &'a [String],
	/// The previous release's picks, when it was a hotfix ([`picks`]): what it fixed and thanked is not
	/// this release's, whatever pull request it came with (a maintainer's batch pull request gives a
	/// hotfix a few commits and the next release the rest).
	pub picks: &'a [Commit],
}

/// An idea's name as a login GitHub knows: the name itself, else a login `names` shows as it; None when
/// no known login matches.
fn known_login(src: &Source, known: &[String], raw: &str) -> Option<String> {
	let shown_as: Vec<&str> = src.names.iter().filter(|(_, n)| n.to_lowercase() == raw.to_lowercase()).map(|(l, _)| l.as_str()).collect();
	std::iter::once(raw).chain(shown_as).find_map(|c| known.iter().find(|k| k.to_lowercase() == c.to_lowercase()).cloned())
}

/// The logins to tag, alphabetical ignoring case, each with what it is tagged for.
pub fn credits_for(i: &Input) -> Vec<Credit> {
	let mut by: BTreeMap<String, Credit> = BTreeMap::new();
	let mut add = |raw: &str, why: String| {
		if raw.is_empty() || raw.starts_with("app/") || raw.ends_with("[bot]") || credits::shown(i.src, raw).is_none() {
			return;
		}
		let c = by.entry(raw.to_lowercase()).or_insert_with(|| Credit { login: raw.to_string(), why: Vec::new() });
		if !c.why.contains(&why) {
			c.why.push(why);
		}
	};

	// Pull requests: those GitHub ties to a commit of the range that carries work (a merge commit
	// doesn't: a pull request whose own commits the previous release already had, picked into a hotfix,
	// still has its merge commit here), or to the one it was picked from, and the folded ones.
	let mut prs: Vec<&Merged> = Vec::new();
	for c in i.commits.iter().filter(|c| !c.merge) {
		let own = i.info.get(&c.sha);
		let picked = cherry_source(&c.body).and_then(|s| i.info.get(&s));
		for p in own.into_iter().chain(picked).flat_map(|x| &x.prs) {
			if !prs.iter().any(|q| q.number == p.number) {
				prs.push(p);
			}
		}
		for login in own.into_iter().flat_map(|x| &x.co_authors) {
			add(login, "co-author".into());
		}
	}
	for p in i.folded {
		if !prs.iter().any(|q| q.number == p.number) {
			prs.push(p);
		}
	}
	for p in &prs {
		if let (Some(login), Some(n)) = (&p.login, p.number) {
			add(login, format!("PR #{n}"));
		}
	}
	let pr_numbers: HashSet<u64> = prs.iter().filter_map(|p| p.number).collect();

	// Issues the release closes.
	let named: HashSet<u64> = i.commits.iter().filter(|c| !c.merge).flat_map(|c| refs(&c.subject, &c.body)).collect();
	let shipped: HashSet<u64> = i.picks.iter().flat_map(|c| refs(&c.subject, &c.body)).collect();
	let shipped_prs: HashSet<u64> = i
		.picks
		.iter()
		.flat_map(|c| {
			let picked = cherry_source(&c.body).and_then(|s| i.info.get(&s));
			i.info.get(&c.sha).into_iter().chain(picked).flat_map(|x| &x.prs).filter_map(|p| p.number)
		})
		.collect();
	let closes = |x: &Issue| {
		(x.state == "CLOSED" || x.fixed_on_ref)
			&& !shipped.contains(&x.number)
			&& (x.fixed_on_ref || named.contains(&x.number) || x.closed_by.iter().any(|n| pr_numbers.contains(n) && !shipped_prs.contains(n)))
	};
	let closed: HashSet<u64> = i.issues.iter().filter(|x| closes(x)).map(|x| x.number).collect();
	for issue in i.issues.iter().filter(|x| closed.contains(&x.number) && credits::useful_report(x)) {
		let login = match credits::relay_name(issue) {
			Some(name) => i.relayed.iter().find(|(d, _)| d.to_lowercase() == name.to_lowercase()).map(|(_, l)| l.clone()),
			None => issue.author.clone(),
		};
		if let Some(login) = login {
			add(&login, format!("reported #{}", issue.number));
		}
	}

	// Ideas that shipped.
	for idea in &i.src.ideas {
		if pr_numbers.contains(&idea.reference) || closed.contains(&idea.reference) {
			if let Some(login) = known_login(i.src, i.known, &idea.name) {
				add(&login, format!("idea #{}", idea.reference));
			}
		}
	}
	by.into_values().collect()
}

/// A release's contributors and where they came from.
pub struct Collected {
	pub since: String,
	pub until: String,
	pub commits: usize,
	pub credits: Vec<Credit>,
}

/// The contributors of `version` in the checkout `root`, through git and the GitHub CLI (`gh`, logged
/// in): from `since` (default: the previous release tag, [`previous_tag`]) to `until` (default: the
/// tag `v<version>` when it exists, else HEAD).
pub fn collect(root: &Path, version: &str, since: Option<&str>, until: Option<&str>) -> Result<Collected, String> {
	let file = root.join(credits::SOURCE);
	let src = credits::read_source(&file)?;
	let relayed = read_relayed(&file)?;
	let since = match since {
		Some(s) => s.to_string(),
		None => previous_tag(root, version)?,
	};
	let until = match until {
		Some(u) => u.to_string(),
		None if has_rev(root, &format!("v{version}")) => format!("v{version}"),
		None => "HEAD".to_string(),
	};
	let prior = prior_of(root, &since);
	let commits = range_commits(root, &since, &until, prior.as_deref())?;
	let picks = match &prior {
		Some(p) => picks(root, p, &since)?,
		None => Vec::new(),
	};
	let on_ref: Vec<(String, String)> = commits.iter().map(|c| (c.sha.clone(), c.date.clone())).collect();
	let subjects: Vec<(String, String)> = commits.iter().map(|c| (c.email.clone(), c.subject.clone())).collect();

	let merged = credits::fetch_merged(credits::REPO)?;
	let closed: Vec<Closed> = credits::fetch_closed(credits::REPO, &src.exclude)?;
	let open: Vec<Open> = credits::fetch_open(credits::REPO)?;
	let mut folded = credits::folded(&closed, &subjects);
	folded.extend(credits::folded_open(&open, &on_ref));
	let fixed = credits::fixed_on_ref(&open, &on_ref);
	let mut issues = credits::fetch_issues(credits::REPO)?;
	for issue in issues.iter_mut().filter(|x| fixed.contains(&x.number)) {
		issue.fixed_on_ref = true;
	}
	let mut known: Vec<String> = merged
		.iter()
		.map(|m| m.login.clone())
		.chain(closed.iter().map(|c| c.login.clone()))
		.chain(open.iter().map(|o| o.login.clone()))
		.chain(issues.iter().map(|x| x.author.clone()))
		.flatten()
		.collect();
	known.sort_by_key(|k| k.to_lowercase());
	known.dedup_by_key(|k| k.to_lowercase());

	let mut shas: Vec<String> = commits.iter().chain(&picks).flat_map(|c| std::iter::once(c.sha.clone()).chain(cherry_source(&c.body))).collect();
	shas.sort();
	shas.dedup();
	let info = fetch_commit_info(credits::REPO, &shas)?;
	let credits = credits_for(&Input { src: &src, relayed: &relayed, commits: &commits, info: &info, folded: &folded, issues: &issues, known: &known, picks: &picks });
	Ok(Collected { since, until, commits: commits.len(), credits })
}

#[cfg(test)]
mod tests {
	use super::*;

	fn src(exclude: &[&str], names: &[(&str, &str)], ideas: &[(&str, u64)]) -> Source {
		Source {
			supporters: vec![],
			exclude: exclude.iter().map(|s| s.to_string()).collect(),
			names: names.iter().map(|(a, b)| (a.to_string(), b.to_string())).collect(),
			ideas: ideas.iter().map(|(n, r)| credits::Idea { name: n.to_string(), reference: *r }).collect(),
		}
	}

	fn commit(sha: &str, subject: &str, body: &str) -> Commit {
		Commit { sha: sha.into(), merge: false, email: "x@x.org".into(), date: "2026-11-20T00:00:00Z".into(), subject: subject.into(), body: body.into() }
	}

	fn pr(number: u64, login: &str) -> Merged {
		Merged { number: Some(number), login: Some(login.into()), merged_at: Some("2026-11-20T00:00:00Z".into()) }
	}

	fn ci(co_authors: &[&str], prs: &[Merged]) -> CommitInfo {
		CommitInfo { co_authors: co_authors.iter().map(|a| a.to_string()).collect(), prs: prs.to_vec() }
	}

	fn issue(number: u64, author: &str, labels: &[&str], closed_by: &[u64]) -> Issue {
		Issue {
			number,
			author: Some(author.into()),
			body: "It broke.".into(),
			state: "CLOSED".into(),
			state_reason: Some("COMPLETED".into()),
			labels: labels.iter().map(|l| l.to_string()).collect(),
			closed_by: closed_by.to_vec(),
			..Default::default()
		}
	}

	/// A Discord report the bot filed under the maintainer's account.
	fn relayed_issue(number: u64, name: &str, closed_by: &[u64]) -> Issue {
		let mut i = issue(number, "fitzforge", &["bug", "confirmed"], closed_by);
		i.body = format!("**Reported by {name} on [Discord](https://discord.com/channels/1/2)**\n\n> it broke");
		i
	}

	fn run(src: &Source, relayed: &[(&str, &str)], commits: &[Commit], info: &[(&str, CommitInfo)], folded: &[Merged], issues: &[Issue], known: &[&str]) -> Vec<String> {
		let info: HashMap<String, CommitInfo> = info.iter().map(|(s, i)| (s.to_string(), i.clone())).collect();
		let relayed: Vec<(String, String)> = relayed.iter().map(|(a, b)| (a.to_string(), b.to_string())).collect();
		let known: Vec<String> = known.iter().map(|k| k.to_string()).collect();
		credits_for(&Input { src, relayed: &relayed, commits, info: &info, folded, issues, known: &known, picks: &[] }).into_iter().map(|c| c.login).collect()
	}

	#[test]
	fn pull_request_authors_of_the_range_are_tagged_once_in_alphabetical_order_ignoring_case() {
		let commits = [commit("c3", "Fix three (#12)", ""), commit("c2", "Fix two (#11)", ""), commit("c1", "Fix one (#10)", "")];
		let info = [("c3", ci(&[], &[pr(12, "zed")])), ("c2", ci(&[], &[pr(11, "ann"), pr(13, "ann")])), ("c1", ci(&[], &[pr(10, "Bob")]))];
		let got = run(&src(&[], &[], &[]), &[], &commits, &info, &[], &[], &[]);
		assert_eq!(got, ["ann", "Bob", "zed"]);
		// a commit that GitHub ties to the same pull request twice names it once
		let twice: HashMap<String, CommitInfo> = [("c3".to_string(), ci(&[], &[pr(12, "zed"), pr(12, "zed")]))].into_iter().collect();
		let src = src(&[], &[], &[]);
		let again = credits_for(&Input { src: &src, relayed: &[], commits: &commits[..1], info: &twice, folded: &[], issues: &[], known: &[], picks: &[] });
		assert_eq!(again, [Credit { login: "zed".into(), why: vec!["PR #12".into()] }]);
	}

	#[test]
	fn the_maintainer_bots_and_excluded_names_are_never_tagged() {
		let commits = [commit("c1", "x", "")];
		let info = [("c1", ci(&["fitzforge", "Fitz-Alt", "cid"], &[pr(1, "fitzforge"), pr(2, "app/dependabot"), pr(3, "renovate[bot]"), pr(4, "Twerk"), pr(5, "dee")]))];
		// `exclude` holds logins and shown names: Twerk is shown as Twerkjob.
		let got = run(&src(&["fitzforge", "Twerkjob", "fitz-alt"], &[("Twerk", "Twerkjob")], &[]), &[], &commits, &info, &[], &[], &[]);
		assert_eq!(got, ["cid", "dee"]);
	}

	#[test]
	fn co_authors_count_where_github_resolves_them_and_the_author_login_is_the_one_tagged() {
		// GitHub lists a commit's author and each Co-authored-by trailer with an account; one without an
		// account has no login and is not in the list.
		let commits = [commit("c1", "Guide fix", "Co-authored-by: Cy <cy@x.org>\nCo-authored-by: Stranger <s@x.org>")];
		let info = [("c1", ci(&["fitzforge", "cy"], &[]))];
		assert_eq!(run(&src(&["fitzforge"], &[], &[]), &[], &commits, &info, &[], &[], &[]), ["cy"]);
	}

	#[test]
	fn a_hotfix_picks_pull_request_and_issues_count_through_the_commit_it_was_picked_from() {
		// c9 is the pick on the hotfix branch: its own id has no pull request, the commit it was
		// cherry-picked from (-x) does; its subject names the issue it fixes.
		let source = "a".repeat(40);
		let commits = [commit("c9", "Atlas: the heads-up card goes under the window (#4212)", &format!("Body.\n\n(cherry picked from commit {source})"))];
		let info = [(source.as_str(), ci(&[], &[pr(4300, "Kite")]))];
		let issues = [issue(4212, "Sumi", &["bug", "confirmed"], &[]), issue(4213, "other", &["bug", "confirmed"], &[])];
		let got = run(&src(&[], &[], &[]), &[], &commits, &info, &[], &issues, &[]);
		assert_eq!(got, ["Kite", "Sumi"]);
	}

	#[test]
	fn folded_closed_and_open_pull_requests_count() {
		let folded = [pr(20, "Ann"), Merged { number: Some(21), login: Some("bob".into()), merged_at: None }];
		assert_eq!(run(&src(&[], &[], &[]), &[], &[], &[], &folded, &[], &[]), ["Ann", "bob"]);
	}

	#[test]
	fn issue_reporters_count_when_the_release_closes_the_issue_and_the_report_counts() {
		let commits = [commit("c1", "Fix", "Closes #3, #4")];
		let info = [("c1", ci(&[], &[pr(10, "dev")]))];
		let mut open_fixed = issue(7, "gail", &["bug"], &[]);
		open_fixed.state = "OPEN".into();
		open_fixed.state_reason = None;
		open_fixed.fixed_on_ref = true;
		let mut still_open = issue(8, "hal", &["bug", "confirmed"], &[10]);
		still_open.state = "OPEN".into();
		still_open.state_reason = None;
		let issues = [
			// closed by a pull request of the range
			issue(1, "ann", &["bug"], &[10]),
			// closed by a pull request of another release
			issue(2, "bob", &["bug"], &[99]),
			// named by a commit's closing keyword
			issue(3, "cid", &["bug", "confirmed"], &[]),
			issue(4, "dee", &["bug", "confirmed"], &[]),
			// closed by the range's pull request, but the report doesn't count: a feature request
			issue(5, "eve", &["enhancement"], &[10]),
			// and a duplicate
			{
				let mut d = issue(6, "fay", &["bug"], &[10]);
				d.state_reason = Some("DUPLICATE".into());
				d
			},
			open_fixed,
			// still open: not closed by the release, even with a pull request linked
			still_open,
		];
		let got = run(&src(&[], &[], &[]), &[], &commits, &info, &[], &issues, &[]);
		assert_eq!(got, ["ann", "cid", "dee", "dev", "gail"]);
	}

	#[test]
	fn a_relayed_discord_report_is_tagged_only_through_a_github_login_it_names() {
		let commits = [commit("c1", "Fix (#1, #2)", "")];
		let issues = [relayed_issue(1, "Rook", &[]), relayed_issue(2, "Pip", &[])];
		// Pip told us their login; Rook never did, so the report stays on the Guiding Stars page.
		let got = run(&src(&["fitzforge"], &[], &[]), &[("pip", "PipGH")], &commits, &[], &[], &issues, &[]);
		assert_eq!(got, ["PipGH"]);
		// the maintainer's account, which files the relayed issues, is never the reporter
		assert!(!run(&src(&["fitzforge"], &[], &[]), &[], &commits, &[], &[], &issues, &[]).contains(&"fitzforge".to_string()));
	}

	#[test]
	fn shipped_ideas_count_only_as_logins_github_knows() {
		let commits = [commit("c1", "Idea shipped", "")];
		let info = [("c1", ci(&[], &[pr(50, "builder")]))];
		let ideas = [("Dreamer", 50), ("dreamer2", 51), ("Nobody", 50), ("林", 50)];
		// "Nobody" isn't a login GitHub knows from the repository; idea 51 is not in the range; 林 is the
		// name `names` shows for the login LinGH.
		let got = run(&src(&[], &[("LinGH", "林")], &ideas), &[], &commits, &info, &[], &[], &["dreamer", "Dreamer2", "builder", "LinGH"]);
		assert_eq!(got, ["builder", "dreamer", "LinGH"]);
		// an excluded name stays out
		assert_eq!(run(&src(&["Dreamer"], &[], &ideas), &[], &commits, &info, &[], &[], &["dreamer"]), ["builder"]);
	}

	#[test]
	fn a_translator_is_tagged_through_their_pull_request_once_and_never_for_a_locale_file_they_did_not_touch() {
		// LinGH (shown as 林, a translator) has a pull request in the range; Hans (another language's
		// translator) has none, though the range may have synced new keys into that language's file.
		let commits = [commit("c1", "Chinese: the new keys", "")];
		let info = [("c1", ci(&[], &[pr(60, "LinGH")]))];
		let got = run(&src(&[], &[("LinGH", "林")], &[]), &[], &commits, &info, &[], &[], &["LinGH", "Hans"]);
		assert_eq!(got, ["LinGH"]);
	}

	#[test]
	fn commit_references_and_cherry_sources_parse() {
		assert_eq!(refs("Lookup: Kodo Roundup is a use (#4188), and Get the Scoop (#4046)", ""), [4188, 4046]);
		assert_eq!(refs("Tailoring (#3923, #3708)", "Fixes #12, #13 and #14.\nSee #99."), [3923, 3708, 12, 13, 14]);
		assert_eq!(refs("x", "closes: #5\nresolved #6"), [5, 6]);
		assert!(refs("x", "other/repo#5 mentions").is_empty());
		let sha = "0123456789abcdef0123456789abcdef01234567";
		assert_eq!(cherry_source(&format!("Fix\n\n(cherry picked from commit {sha})")).as_deref(), Some(sha));
		assert_eq!(cherry_source("(cherry picked from commit abc123)"), None);
	}

	#[test]
	fn graphql_output_parses_with_merged_pull_requests_only_and_bots_marked() {
		let shas = ["aaaa".to_string(), "bbbb".to_string(), "cccc".to_string()];
		let doc: Value = serde_json::from_str(
			r#"{"data":{"repository":{
				"c0":{"authors":{"nodes":[{"email":"ann@x.org","user":{"login":"ann"}},{"email":"s@x.org","user":null},{"email":"1+cy@users.noreply.github.com","user":{"login":"cy"}},
					{"email":"noreply@anthropic.com","user":{"login":"claude"}},{"email":"noreply@github.com","user":{"login":"web-flow"}},{"email":"no-reply@tool.dev","user":{"login":"tool"}}]},
					"associatedPullRequests":{"nodes":[
						{"number":1,"state":"MERGED","mergedAt":"2026-11-01T00:00:00Z","author":{"__typename":"User","login":"ann"}},
						{"number":2,"state":"CLOSED","mergedAt":null,"author":{"__typename":"User","login":"gone"}},
						{"number":3,"state":"MERGED","mergedAt":"2026-11-02T00:00:00Z","author":{"__typename":"Bot","login":"dependabot"}},
						{"number":4,"state":"MERGED","mergedAt":"2026-11-03T00:00:00Z","author":null}]}},
				"c1":null,
				"c2":{"authors":{"nodes":[]},"associatedPullRequests":{"nodes":[]}}}}}"#,
		)
		.unwrap();
		let got = parse_commit_info(&doc, &shas).unwrap();
		// the git author (first) has the pull request; a tool's no-reply trailer is no one
		assert_eq!(got["aaaa"].co_authors, ["cy"]);
		assert_eq!(got["aaaa"].prs.iter().map(|p| (p.number, p.login.clone())).collect::<Vec<_>>(), [(Some(1), Some("ann".into())), (Some(3), Some("app/dependabot".into())), (Some(4), None)]);
		assert!(!got.contains_key("bbbb"));
		assert!(got["cccc"].prs.is_empty());
		assert!(parse_commit_info(&serde_json::json!({"errors":[{"message":"bad"}]}), &shas).is_err());
		let q = commit_query("o", "r", &shas);
		assert!(q.contains("c1: object(oid: \"bbbb\")") && q.contains("repository(owner: \"o\", name: \"r\")"));
	}

	#[test]
	fn the_relay_map_reads_from_credits_json() {
		let dir = std::env::temp_dir().join(format!("forge-contributors-map-{}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		let file = dir.join("credits.json");
		std::fs::write(&file, r#"{"supporters":[],"github":{"Pip":"PipGH"}}"#).unwrap();
		assert_eq!(read_relayed(&file).unwrap(), [("Pip".to_string(), "PipGH".to_string())]);
		std::fs::write(&file, r#"{"supporters":[]}"#).unwrap();
		assert!(read_relayed(&file).unwrap().is_empty());
		std::fs::write(&file, r#"{"github":{"Pip":"@PipGH"}}"#).unwrap();
		assert!(read_relayed(&file).is_err());
		let _ = std::fs::remove_dir_all(&dir);
	}

	/// A repository for the range tests: `base` (tagged v1.0.0), a hotfix branch that picked `one` as
	/// `pick` (tagged v1.0.0.1), and `next` with `one` and `two` after base.
	fn tiny_repo(name: &str, merged_back: bool) -> std::path::PathBuf {
		let dir = std::env::temp_dir().join(format!("forge-contributors-{name}-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(&dir).unwrap();
		let git = |args: &[&str]| {
			let out = std::process::Command::new("git")
				.arg("-C")
				.arg(&dir)
				.args(["-c", "user.name=T", "-c", "user.email=t@x.org", "-c", "commit.gpgsign=false", "-c", "tag.gpgsign=false"])
				.args(args)
				.output()
				.unwrap();
			assert!(out.status.success(), "git {args:?}: {}", String::from_utf8_lossy(&out.stderr));
		};
		let commit = |file: &str, text: &str, msg: &str| {
			std::fs::write(dir.join(file), text).unwrap();
			git(&["add", file]);
			git(&["commit", "-q", "-m", msg, "--date", "2026-01-02T03:04:05Z"]);
		};
		git(&["init", "-q", "-b", "next"]);
		commit("base.txt", "base", "base");
		for t in ["v0.9.0", "v1.0.0", "client-v5.0.0", "v1.0.1-rc.1"] {
			git(&["tag", t]);
		}
		git(&["switch", "-q", "-c", "hotfix"]);
		commit("one.txt", "one", "one (#1)\n\n(cherry picked from commit 0123456789abcdef0123456789abcdef01234567)");
		git(&["tag", "v1.0.0.1"]);
		git(&["switch", "-q", "next"]);
		commit("one.txt", "one", "one (#1)");
		commit("two.txt", "two", "two\n\nFixes #2");
		git(&["switch", "-q", "-c", "side", "v1.0.0"]);
		commit("side.txt", "side", "side work");
		git(&["switch", "-q", "next"]);
		git(&["merge", "-q", "--no-ff", "side", "-m", "Merge pull request #5 from x/side"]);
		if merged_back {
			git(&["merge", "-q", "--no-ff", "hotfix", "-m", "Merge hotfix back"]);
		}
		dir
	}

	#[test]
	fn the_range_is_the_previous_release_tag_to_the_ref_without_what_the_previous_release_already_had() {
		let dir = tiny_repo("range", false);
		// the previous tag: the newest release tag below the version; pre-releases and other tags ignored
		assert_eq!(previous_tag(&dir, "1.0.1").unwrap(), "v1.0.0.1");
		assert_eq!(previous_tag(&dir, "1.0.1-rc.2").unwrap(), "v1.0.0.1");
		assert_eq!(previous_tag(&dir, "1.0.0.1").unwrap(), "v1.0.0");
		assert_eq!(previous_tag(&dir, "1.0.0").unwrap(), "v0.9.0");
		assert!(previous_tag(&dir, "0.9.0").is_err());
		assert!(previous_tag(&dir, "nonsense").is_err());
		assert!(has_rev(&dir, "v1.0.0") && !has_rev(&dir, "v9.9.9"));
		// v1.0.0..next: the commits of next, and the merge of the side branch (a merge commit)
		let subjects = |v: &[Commit]| -> Vec<String> {
			let mut s: Vec<String> = v.iter().map(|c| c.subject.clone()).collect();
			s.sort();
			s
		};
		let all = range_commits(&dir, "v1.0.0", "next", None).unwrap();
		assert_eq!(subjects(&all), ["Merge pull request #5 from x/side", "one (#1)", "side work", "two"]);
		assert_eq!(all.iter().filter(|c| c.merge).map(|c| c.subject.as_str()).collect::<Vec<_>>(), ["Merge pull request #5 from x/side"]);
		let two = all.iter().find(|c| c.subject == "two").unwrap();
		assert_eq!((two.body.trim(), two.email.as_str(), two.sha.len()), ("Fixes #2", "t@x.org", 40));
		// v1.0.0.1..next, the hotfix not merged back: `one` is already in v1.0.0.1 as a pick (the same
		// change), so it is left out
		let new = range_commits(&dir, "v1.0.0.1", "next", None).unwrap();
		assert_eq!(subjects(&new), ["Merge pull request #5 from x/side", "side work", "two"]);
		// the hotfix itself: its pick, from the line it was cut from
		let hot = range_commits(&dir, "v1.0.0", "v1.0.0.1", None).unwrap();
		assert_eq!(hot.len(), 1);
		assert_eq!(cherry_source(&hot[0].body).as_deref(), Some("0123456789abcdef0123456789abcdef01234567"));
		assert!(range_commits(&dir, "v9.9.9", "next", None).is_err());
		let _ = std::fs::remove_dir_all(&dir);
	}

	#[test]
	fn a_hotfix_merged_back_into_the_line_has_its_picks_originals_left_out_through_the_release_before_it() {
		let dir = tiny_repo("merged-back", true);
		let subjects = |v: &[Commit]| -> Vec<String> {
			let mut s: Vec<String> = v.iter().map(|c| c.subject.clone()).collect();
			s.sort();
			s
		};
		// v1.0.0.1 is now an ancestor of next: nothing on its side to compare with, so the original of
		// the pick is in the range, until the release before it names the picks
		let plain = range_commits(&dir, "v1.0.0.1", "next", None).unwrap();
		assert_eq!(subjects(&plain), ["Merge hotfix back", "Merge pull request #5 from x/side", "one (#1)", "side work", "two"]);
		let cut = range_commits(&dir, "v1.0.0.1", "next", Some("v1.0.0")).unwrap();
		assert_eq!(subjects(&cut), ["Merge hotfix back", "Merge pull request #5 from x/side", "side work", "two"]);
		// the picks are the commits of the release before it; only a hotfix tag has them
		assert_eq!(prior_of(&dir, "v1.0.0.1").as_deref(), Some("v1.0.0"));
		assert_eq!((prior_of(&dir, "v1.0.0"), prior_of(&dir, "v0.9.0"), prior_of(&dir, "next")), (None, None, None));
		let picks = picks(&dir, "v1.0.0", "v1.0.0.1").unwrap();
		assert_eq!(picks.iter().map(|c| c.subject.as_str()).collect::<Vec<_>>(), ["one (#1)"]);
		let _ = std::fs::remove_dir_all(&dir);
	}

	#[test]
	fn a_merge_commit_carries_no_pull_request_and_names_no_issue() {
		// The previous release (a hotfix) had the pull request's own commits as picks, so only its merge
		// commit is left in the range: the pull request and its issues were thanked there.
		let mut merge = commit("m1", "Merge pull request #10 from ann/x", "Fixes #1");
		merge.merge = true;
		let info = [("m1", ci(&["cy"], &[pr(10, "ann")]))];
		let closed = issue(1, "bob", &["bug", "confirmed"], &[10]);
		assert!(run(&src(&[], &[], &[]), &[], &[merge], &info, &[], &[closed], &[]).is_empty());
	}

	#[test]
	fn what_the_previous_hotfix_fixed_is_not_this_releases_even_through_a_pull_request_they_shared() {
		// A maintainer's batch pull request (7) gave the hotfix its picks and this release the rest.
		// #1 is named by a pick and #2 is closed by pull request 7 (nothing names it): both were
		// thanked with the hotfix. #3 is named by a commit of this range, #4 is closed by a pull
		// request only this release has.
		let source = "a".repeat(40);
		let picks = [commit("p1", "Fix the first (#1)", &format!("(cherry picked from commit {source})"))];
		let commits = [commit("c1", "Fix the third (#3)", ""), commit("c2", "The rest of the batch", ""), commit("c3", "Other work", "")];
		let info: HashMap<String, CommitInfo> =
			[(source, ci(&[], &[pr(7, "dev")])), ("c2".to_string(), ci(&[], &[pr(7, "dev")])), ("c3".to_string(), ci(&[], &[pr(8, "newdev")]))].into_iter().collect();
		let issues =
			[issue(1, "ann", &["bug", "confirmed"], &[7]), issue(2, "bob", &["bug", "confirmed"], &[7]), issue(3, "cid", &["bug", "confirmed"], &[]), issue(4, "dee", &["bug", "confirmed"], &[8])];
		let src = src(&[], &[], &[]);
		let at = |picks: &[Commit]| -> Vec<String> {
			credits_for(&Input { src: &src, relayed: &[], commits: &commits, info: &info, folded: &[], issues: &issues, known: &[], picks }).into_iter().map(|c| c.login).collect()
		};
		assert_eq!(at(&picks), ["cid", "dee", "dev", "newdev"]);
		// without the hotfix's picks (a release after a full release) nothing is held back
		assert_eq!(at(&[]), ["ann", "bob", "cid", "dee", "dev", "newdev"]);
	}
}
