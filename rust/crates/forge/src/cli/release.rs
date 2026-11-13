//! `forge release pack|version|notes|credits`: building and releasing the addon (docs/RELEASING.md;
//! the library is forge-release). `forge changelog` is in [`super::changelog`].

use std::path::{Path, PathBuf};
use std::process::ExitCode;

pub const USAGE: &str = "usage: forge release <command> [options]

Building and releasing the addon (docs/RELEASING.md):
  pack [<dir>]       the release zips dist/Polestar-<version>.zip, dist/Polestar_Recorder-<version>.zip and
                     dist/SHA256SUMS; given another pack, <pack>/dist/<folder>-<version>.zip
  version [<x.y.z>]  print the version (exit 1 when guides/pack.json or an addon TOC disagrees), or set it
                     in package.json, guides/pack.json and every addon TOC
  notes <x.y.z>      the version's release notes from CHANGELOG.md: dist/notes-<v>.md (GitHub),
                     dist/notes-curseforge-<v>.md and dist/notes-discord-<v>.txt
  credits            rewrite addon/Polestar/Core/Credits.lua (the Guiding Stars page) from data/credits.json,
                     the repository's merged pull requests and those the release ref carries, its issues
                     (needs the GitHub CLI, gh, logged in), and the locales' translators

forge release <command> --help shows the command's options. The changelog fragments: forge changelog.";

const NOTES_USAGE: &str = "usage: forge release notes <x.y.z> [--root <dir>] [--out <dir>]

Writes the version's CHANGELOG.md section (## <x.y.z> (<date>)) as notes-<v>.md (GitHub: the players' and
guide authors' entries), notes-curseforge-<v>.md (the players') and notes-discord-<v>.txt (posts of at
most 2,000 characters), each paragraph and list item joined onto one line. Each starts with a
[[REPLACE ...]] line for the intro, to replace before publishing.

  --root <dir>   the checkout holding CHANGELOG.md (default: the one above here, else above the forge binary)
  --out <dir>    where to write (default <root>/dist/)";

const CREDITS_USAGE: &str = "usage: forge release credits [--root <dir>] [--release-ref <git ref>]

Rewrites addon/Polestar/Core/Credits.lua, the names on the Guiding Stars page (Options > Guiding Stars,
and \"Special thanks to\" in the windows' headers):

  supporters     data/credits.json \"supporters\": Ko-fi supporters' names, highest total first.
                 Amounts are never stored.
  contributors   everyone with a pull request on fitzforge/polestar that is merged or that the release
                 ref carries, most first, fetched with the GitHub CLI (gh, logged in). The ref carries an
                 open pull request (a draft too) when its current head commit is on it (a batch merged
                 it at its exact head; GitHub marks it merged once the release reaches next), and a
                 closed one when one of its commits is on it with its authorship kept (cherry-picked).
                 Each pull request counts once.
  bug reporters  the top 40 reporters of fitzforge/polestar's issues by useful reports, most first: the
                 Discord name the bot filed it under, else the GitHub login that opened it. A report
                 counts when it is labelled confirmed or fix-merged, or closed as completed by a fix (a
                 pull request, a released:* label, a maintainer's comment saying fixed), or still open
                 with a fix on the release ref (an open pull request carried there that closes it);
                 never a duplicate, not planned, invalid, wontfix, resolution:* or needs-info one, nor a
                 feature request (enhancement without bug).
  translators    every locale's translators (forge-guide's LOCALES, tools/lib/i18n/locales.js), by
                 language, the language's name beside each.
  ideas          data/credits.json \"ideas\": people whose idea shipped though someone else built
                 it, { \"name\": login or name, \"ref\": the pull request or issue }, in the order
                 they shipped.

\"exclude\" lists logins and names left out (the maintainer, anyone who asked not to be listed);
\"names\" maps a login or Discord name to the name shown. Both apply to every list.

Run it before a release, on the release's integration branch.
  --root <dir>             the checkout (default: the one above here, else above the forge binary)
  --release-ref <git ref>  the commit the release ships, as git in the checkout names it (default
                           HEAD): e.g. origin/dev-040 while the batches aren't on next yet";

/// The Polestar checkout: `--root`, else the nearest folder above the working directory, else above
/// the forge binary, holding addon/Polestar/Polestar.toc and package.json.
pub(super) fn checkout(root: Option<String>) -> Result<PathBuf, super::Fail> {
	if let Some(r) = root {
		return Ok(forge_release::absolute(Path::new(&r)));
	}
	let is_root = |d: &&Path| d.join("addon/Polestar/Polestar.toc").is_file() && d.join("package.json").is_file();
	let cwd = std::env::current_dir().unwrap_or_default();
	let exe = std::env::current_exe().unwrap_or_default();
	cwd.ancestors()
		.find(is_root)
		.or_else(|| exe.ancestors().find(is_root))
		.map(Path::to_path_buf)
		.ok_or_else(|| super::usage("no Polestar checkout (addon/Polestar/Polestar.toc and package.json) above here or the forge binary: pass --root <checkout>"))
}

/// The value of option `k` (`k v` or `k=v`).
pub(super) fn opt(args: &[String], k: &str) -> Option<String> {
	args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned().or_else(|| args.iter().find_map(|a| a.strip_prefix(k)?.strip_prefix('=').map(String::from)))
}

/// The arguments that are neither options nor their values.
pub(super) fn positional(args: &[String], values: &[&str]) -> Vec<String> {
	let mut out = Vec::new();
	let mut it = args.iter();
	while let Some(a) = it.next() {
		if a.starts_with("--") && a.len() > 2 {
			if values.contains(&a.as_str()) {
				it.next();
			}
		} else {
			out.push(a.clone());
		}
	}
	out
}

/// The help text: the command list, or a command's own (`forge release pack --help`).
pub fn help(sub: Option<&str>) -> &'static str {
	match sub {
		Some("pack") => super::pack::USAGE,
		Some("version") => super::version::USAGE,
		Some("notes") => NOTES_USAGE,
		Some("credits") => CREDITS_USAGE,
		_ => USAGE,
	}
}

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	let cmd = args.first().cloned().unwrap_or_default();
	let rest = &args[1..];
	let r = match cmd.as_str() {
		"pack" => super::pack::run(rest),
		"version" => super::version::run(rest),
		"notes" => notes(rest),
		"credits" => credits(rest),
		_ => Err(super::usage(format!("unknown command {cmd}: pack, version, notes or credits"))),
	};
	let name = if help(Some(&cmd)) == USAGE { "release".to_string() } else { format!("release {cmd}") };
	super::exit(&name, r);
	ExitCode::SUCCESS
}

fn notes(args: &[String]) -> Result<(), super::Fail> {
	super::check_args(args, &["--root", "--out"], &[], 1).map_err(super::usage)?;
	let [version] = positional(args, &["--root", "--out"]).try_into().map_err(|_| super::usage("one version"))?;
	if !forge_release::is_version(&version) {
		return Err(super::usage(format!("\"{version}\" is not a version (x.y.z, x.y.z.hotfix or x.y.z-pre)")));
	}
	let root = checkout(opt(args, "--root"))?;
	let file = root.join("CHANGELOG.md");
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	let rel = forge_release::notes::release_section(&text, &version).ok_or_else(|| format!("CHANGELOG.md has no \"## {version} (<date>)\" section"))?;
	let out = opt(args, "--out").map_or_else(|| root.join("dist"), |o| forge_release::absolute(Path::new(&o)));
	std::fs::create_dir_all(&out).map_err(|e| format!("{}: {e}", out.display()))?;
	use forge_release::notes::{curseforge, discord, github, PLACEHOLDER};
	for (name, text) in [(format!("notes-{version}.md"), github(&rel)), (format!("notes-curseforge-{version}.md"), curseforge(&rel)), (format!("notes-discord-{version}.txt"), discord(&rel))] {
		let file = out.join(name);
		std::fs::write(&file, text).map_err(|e| format!("{}: {e}", file.display()))?;
		println!("{}", file.display());
	}
	println!("\nEach file holds a placeholder for the intro, marked {PLACEHOLDER}: replace it before publishing.");
	Ok(())
}

fn credits(args: &[String]) -> Result<(), super::Fail> {
	super::check_args(args, &["--root", "--release-ref"], &[], 0).map_err(super::usage)?;
	let root = checkout(opt(args, "--root"))?;
	let release = opt(args, "--release-ref").unwrap_or_else(|| "HEAD".into());
	use forge_release::credits::{
		fetch_closed, fetch_issues, fetch_merged, fetch_open, fixed_on_ref, folded, folded_open, ideas, rank_contributors, rank_reporters, read_source, ref_commits, ref_ids, render, translators, OUT,
		REPO, REPORTERS_SHOWN, SOURCE,
	};
	let src = read_source(&root.join(SOURCE))?;
	// Merged pull requests, plus closed ones whose commits were folded into the release ref with their
	// authorship kept (contributors' PRs carried by cherry-pick into a maintainer's branch), plus open
	// ones whose head commit is on the ref (batched into the release's integration branch, before the
	// push to next marks them merged). rank_contributors counts each pull request once.
	let on_ref = ref_ids(&root, &release)?;
	let mut prs = fetch_merged(REPO)?;
	let n_merged = prs.len();
	let folded_in = folded(&fetch_closed(REPO, &src.exclude)?, &ref_commits(&root, &release)?);
	let open = fetch_open(REPO)?;
	let open_in = folded_open(&open, &on_ref);
	let (n_folded, n_open) = (folded_in.len(), open_in.len());
	let merged_only = rank_contributors(&prs, &src).len();
	prs.extend(folded_in);
	prs.extend(open_in);
	let contributors = rank_contributors(&prs, &src);
	// Issues those open pull requests close once the release reaches next count as fixed now.
	let fixed = fixed_on_ref(&open, &on_ref);
	let mut issues = fetch_issues(REPO)?;
	for issue in issues.iter_mut().filter(|i| fixed.contains(&i.number)) {
		issue.fixed_on_ref = true;
	}
	let reporters = rank_reporters(&issues, &src, REPORTERS_SHOWN);
	let (translators, ideas) = (translators(&src), ideas(&src));
	let out = root.join(OUT);
	std::fs::write(&out, render(&src.supporters, &contributors, &reporters, &translators, &ideas)).map_err(|e| format!("{}: {e}", out.display()))?;
	println!(
		"credits ({release}, {} commits): {} supporters, {} contributors ({merged_only} by {n_merged} merged pull requests alone; {n_folded} folded closed and {n_open} folded open pull requests counted), {} bug reporters ({} issues fixed on the ref), {} translators, {} ideas -> {}",
		on_ref.len(),
		src.supporters.len(),
		contributors.len(),
		reporters.len(),
		fixed.len(),
		translators.len(),
		ideas.len(),
		out.display()
	);
	Ok(())
}
