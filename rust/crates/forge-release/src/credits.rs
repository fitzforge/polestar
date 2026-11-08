//! The Guiding Stars page's names (addon/Polestar/Core/Credits.lua): the supporters, kept by hand in
//! data/credits.json in rank order (highest Ko-fi total first; amounts are never stored), and the
//! contributors, counted from the repository's pull requests on GitHub: the merged ones, and the closed
//! ones whose commits were folded into the release (cherry-picked with their authorship kept).

use serde_json::Value;
use std::path::Path;

pub const SOURCE: &str = "data/credits.json";
pub const OUT: &str = "addon/Polestar/Core/Credits.lua";
pub const REPO: &str = "fitzforge/polestar";

/// data/credits.json: `supporters` (names, rank order), `exclude` (logins left out: the maintainer),
/// `names` (login -> the name shown).
pub struct Source {
	pub supporters: Vec<String>,
	pub exclude: Vec<String>,
	pub names: Vec<(String, String)>,
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
	Ok(Source { supporters, exclude: strings("exclude")?, names })
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

fn lua_string(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

/// Core/Credits.lua.
pub fn render(supporters: &[String], contributors: &[(String, usize)]) -> String {
	let mut out = vec![
		"-- Generated by `forge release credits` from data/credits.json and the repository's merged and folded pull requests. Do not edit: rebuild with that command.".to_string(),
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
		let src = Source { supporters: vec![], exclude: vec![], names: vec![] };
		assert_eq!(rank_contributors(&all, &src), [("bob".to_string(), 2), ("ann".into(), 1)]);
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
		let src = Source { supporters: vec![], exclude: vec!["owner".into()], names: vec![("most".into(), "Most Of All".into())] };
		assert_eq!(rank_contributors(&prs, &src), [("Most Of All".to_string(), 3), ("early".into(), 2), ("late".into(), 2)]);
	}

	#[test]
	fn names_with_quotes_backslashes_and_newlines_load_back_unchanged_in_lua() {
		let odd: Vec<String> = ["Say \"hi\"", "back\\slash", "two\nlines", "pipe|name"].iter().map(|s| s.to_string()).collect();
		let lua_text = render(&odd, &[("q\"uote".into(), 1)]);
		let lua = mlua::Lua::new();
		let ns = lua.create_table().unwrap();
		lua.load(&lua_text).call::<()>((mlua::Nil, ns.clone())).unwrap();
		let credits: mlua::Table = ns.get("Credits").unwrap();
		let supporters: Vec<String> = credits.get::<mlua::Table>("supporters").unwrap().sequence_values::<String>().map(Result::unwrap).collect();
		assert_eq!(supporters, odd);
		let first: mlua::Table = credits.get::<mlua::Table>("contributors").unwrap().get(1).unwrap();
		assert_eq!(first.get::<String>("name").unwrap(), "q\"uote");
		assert_eq!(first.get::<i64>("prs").unwrap(), 1);
	}

	#[test]
	fn gh_output_parses() {
		let got = parse_merged(r#"[{"author":{"login":"ann"},"mergedAt":"2026-10-01T00:00:00Z"},{"author":null,"mergedAt":null}]"#).unwrap();
		assert_eq!(got[0].login.as_deref(), Some("ann"));
		assert!(got[1].login.is_none());
	}
}
