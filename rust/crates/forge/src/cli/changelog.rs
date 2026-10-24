//! `forge changelog add|check|show|build`: the changelog fragments in changes/ (forge_release::changelog).
//! `add` writes one, `check` validates them, `show` prints what the next release gathers, and `build`
//! writes it into CHANGELOG.md and deletes them.

use super::release::{checkout, opt, positional};
use forge_release::changelog::{self as cl, Fragment, Parsed, DIR};
use std::io::{IsTerminal, Read};
use std::path::Path;
use std::process::ExitCode;

pub const USAGE: &str = "usage: forge changelog <add|check|show|build> [options]

Each change's changelog entry is its own file, changes/<slug>.md: front matter naming its section, then
the entry as CHANGELOG.md writes it, a markdown list item wrapped at 78 columns (changes/README.md).

  add <players|authors|contributors|forge>
                   write a fragment for that section (\"For players\", \"For guide authors\", \"For
                   contributors\", \"Forge\"). The entry is --text or stdin; plain text becomes one list
                   item, wrapped. The file is named --name, else the entry's first words; an existing
                   file is never overwritten.
  check            every fragment has a known section and an entry starting \"- \", and CHANGELOG.md has
                   no ## Unreleased section; names each fault, exit 1
  show             print the entries the next release gathers, as a ## Unreleased section; writes nothing
  build <version>  add ## <version> (<date>) to CHANGELOG.md above the newest release, with each section
                   that has entries, in order, and the entries by file name; then delete the fragments.
                   Refuses when CHANGELOG.md has that version already, when there are no fragments or
                   when one is faulty

options:
  --root <dir>     the checkout to work on (default: the one above here, else above the forge binary)
  --name <slug>    add: the fragment's file name, without .md
  --text <entry>   add: the entry (default stdin)
  --date <date>    build: the release date, YYYY-MM-DD (default today, UTC)";

const VALUES: [&str; 4] = ["--root", "--name", "--text", "--date"];

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	super::exit("changelog", run(&args));
	ExitCode::SUCCESS
}

fn run(args: &[String]) -> Result<(), super::Fail> {
	super::check_args(args, &VALUES, &[], usize::MAX).map_err(super::usage)?;
	let named = positional(args, &VALUES);
	let Some((sub, rest)) = named.split_first() else { return Err(super::usage("changelog needs a subcommand")) };
	let only: &[&str] = match sub.as_str() {
		"add" => &["--name", "--text"],
		"build" => &["--date"],
		_ => &[],
	};
	for key in ["--name", "--text", "--date"] {
		if opt(args, key).is_some() && !only.contains(&key) {
			return Err(super::usage(format!("{key} is not an option of {sub}")));
		}
	}
	let root = checkout(opt(args, "--root"))?;
	match sub.as_str() {
		"add" => add(&root, args, rest),
		"check" | "show" if !rest.is_empty() => Err(super::usage(format!("{sub} takes no arguments"))),
		"check" => check(&root),
		"show" => show(&root),
		"build" => build(&root, args, rest),
		_ => Err(super::usage(format!("unknown changelog subcommand \"{sub}\""))),
	}
}

/// Each faulty fragment's line, and CHANGELOG.md's when it has ## Unreleased.
fn faults(root: &Path, fragments: &[Fragment]) -> Vec<String> {
	let mut out: Vec<String> = fragments.iter().filter_map(|f| f.parsed.as_ref().err().map(|e| format!("{}: {e}", f.name))).collect();
	if std::fs::read_to_string(root.join("CHANGELOG.md")).is_ok_and(|t| cl::has_unreleased(&t)) {
		out.push(format!("CHANGELOG.md: has a ## Unreleased section; its entries go in {DIR}/ as fragments"));
	}
	out
}

fn valid(fragments: &[Fragment]) -> Vec<Parsed> {
	fragments.iter().filter_map(|f| f.parsed.clone().ok()).collect()
}

fn add(root: &Path, args: &[String], rest: &[String]) -> Result<(), super::Fail> {
	let [section] = rest else { return Err(super::usage("add takes one section")) };
	if !cl::is_section(section) {
		return Err(super::usage(format!("unknown section \"{section}\" (use {})", cl::section_keys())));
	}
	let text = match opt(args, "--text") {
		Some(t) => t,
		None => {
			if std::io::stdin().is_terminal() {
				return Err(super::usage("add needs the entry: --text, or on stdin"));
			}
			let mut t = String::new();
			std::io::stdin().read_to_string(&mut t).map_err(|e| format!("stdin: {e}"))?;
			t
		}
	};
	if text.trim().is_empty() {
		return Err(super::usage("the entry is empty"));
	}
	let body = cl::to_entry(&text);
	let content = cl::format_fragment(section, &body);
	cl::parse_fragment(&content).map_err(|e| format!("the entry: {e}"))?;
	let name = opt(args, "--name");
	let base = cl::slugify(name.as_deref().unwrap_or(&body));
	if base.is_empty() {
		return Err(super::usage(match &name {
			Some(n) => format!("--name \"{n}\" has no letters or digits"),
			None => "the entry has no letters or digits to name it by".into(),
		}));
	}
	let dir = root.join(DIR);
	std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let mut slug = base.clone();
	if name.is_some() {
		if dir.join(format!("{slug}.md")).exists() {
			return Err(format!("{DIR}/{slug}.md exists already").into());
		}
	} else {
		let mut n = 2;
		while dir.join(format!("{slug}.md")).exists() {
			slug = format!("{base}-{n}");
			n += 1;
		}
	}
	let file = dir.join(format!("{slug}.md"));
	let mut f = std::fs::OpenOptions::new().write(true).create_new(true).open(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	std::io::Write::write_all(&mut f, content.as_bytes()).map_err(|e| format!("{}: {e}", file.display()))?;
	println!("{DIR}/{slug}.md");
	Ok(())
}

fn check(root: &Path) -> Result<(), super::Fail> {
	let fragments = cl::read_fragments(root);
	let bad = faults(root, &fragments);
	for line in &bad {
		eprintln!("{line}");
	}
	if !bad.is_empty() {
		return Err(format!("{} to fix", forge_release::plural(bad.len(), "fault")).into());
	}
	println!("{}, all valid", forge_release::plural(fragments.len(), "fragment"));
	Ok(())
}

fn show(root: &Path) -> Result<(), super::Fail> {
	let fragments = cl::read_fragments(root);
	let bad: Vec<String> = fragments.iter().filter_map(|f| f.parsed.as_ref().err().map(|e| format!("{}: {e}", f.name))).collect();
	for line in &bad {
		eprintln!("{line}");
	}
	let good = valid(&fragments);
	if good.is_empty() {
		eprintln!("no fragments in {DIR}/");
	} else {
		print!("## Unreleased\n\n{}", cl::assemble(&good));
	}
	if bad.is_empty() {
		Ok(())
	} else {
		Err(format!("{} left out", forge_release::plural(bad.len(), "faulty fragment")).into())
	}
}

/// Today's date (UTC), YYYY-MM-DD.
fn today() -> String {
	let days = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.as_secs() / 86_400) as i64;
	// Civil date from days since 1970-01-01 (Howard Hinnant's algorithm).
	let z = days + 719_468;
	let era = z.div_euclid(146_097);
	let doe = z - era * 146_097;
	let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = yoe + era * 400 + i64::from(m <= 2);
	format!("{y:04}-{m:02}-{d:02}")
}

/// Whether `date` is a real YYYY-MM-DD date.
fn is_date(date: &str) -> bool {
	let p: Vec<&str> = date.split('-').collect();
	if p.len() != 3 || p[0].len() != 4 || p[1].len() != 2 || p[2].len() != 2 || !date.bytes().all(|b| b.is_ascii_digit() || b == b'-') {
		return false;
	}
	let (y, m, d): (u32, u32, u32) = (p[0].parse().unwrap_or(0), p[1].parse().unwrap_or(0), p[2].parse().unwrap_or(0));
	let leap = y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
	let days = [31, if leap { 29 } else { 28 }, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	(1..=12).contains(&m) && d >= 1 && d <= days[m as usize - 1]
}

fn build(root: &Path, args: &[String], rest: &[String]) -> Result<(), super::Fail> {
	let [version] = rest else { return Err(super::usage("build takes one version")) };
	if !forge_release::is_version(version) {
		return Err(super::usage(format!("\"{version}\" is not a version (x.y.z or x.y.z-pre)")));
	}
	let date = opt(args, "--date").unwrap_or_else(today);
	if !is_date(&date) {
		return Err(super::usage(format!("\"{date}\" is not a date (YYYY-MM-DD)")));
	}
	let file = root.join("CHANGELOG.md");
	let changelog = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	let fragments = cl::read_fragments(root);
	let bad = faults(root, &fragments);
	if !bad.is_empty() {
		for line in &bad {
			eprintln!("{line}");
		}
		return Err(format!("{} to fix; nothing written", forge_release::plural(bad.len(), "fault")).into());
	}
	if cl::has_version(&changelog, version) {
		return Err(format!("CHANGELOG.md has a ## {version} section already").into());
	}
	if fragments.is_empty() {
		return Err(format!("no fragments in {DIR}/: nothing to release").into());
	}
	std::fs::write(&file, cl::insert_release(&changelog, version, &date, &valid(&fragments))).map_err(|e| format!("{}: {e}", file.display()))?;
	for f in &fragments {
		std::fs::remove_file(&f.file).map_err(|e| format!("{}: {e}", f.file.display()))?;
	}
	let n = fragments.len();
	println!("CHANGELOG.md: ## {version} ({date}), {n} {}; fragments deleted", if n == 1 { "entry" } else { "entries" });
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn dates() {
		assert!(is_date("2026-10-20") && is_date("2024-02-29"));
		assert!(!is_date("20-10-2026") && !is_date("2026-02-30") && !is_date("2025-02-29") && !is_date("2026-13-01"));
		assert!(is_date(&today()));
	}
}
