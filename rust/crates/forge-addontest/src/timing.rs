//! Timing budgets: a figure read off a clock (os.clock's CPU time, a wall clock) held to a budget set on a quiet
//! machine. GitHub's shared runners are neither quiet nor alike, so CI sets `POLESTAR_TIMING_BUDGETS=warn`: there
//! a figure over its budget prints a warning annotation and the test goes on. Anywhere else (unset, or any other
//! value) it fails the test as `assert!` does, and the release gate runs them that way, alone on a quiet machine
//! (docs/RELEASING.md, step 3). Everything else a timing test checks (allocations, counts, what shows) stays a
//! plain assertion.
//!
//! ```no_run
//! # let (ms, budget) = (1.0, 2.0);
//! forge_addontest::assert_timing!(ms < budget, "a step took {ms} ms, budget {budget} ms");
//! ```

use std::io::Write;

/// The variable CI sets to `warn`.
pub const ENV: &str = "POLESTAR_TIMING_BUDGETS";

/// Whether a figure over its budget only warns (`POLESTAR_TIMING_BUDGETS=warn`).
pub fn warns() -> bool {
	std::env::var(ENV).is_ok_and(|v| v == "warn")
}

/// [`assert_timing!`]'s body: nothing when `within`; otherwise a panic with the message, or with
/// `POLESTAR_TIMING_BUDGETS=warn` a GitHub warning annotation at the caller's line.
#[track_caller]
pub fn budget(within: bool, message: impl FnOnce() -> String) {
	if let Some(line) = over(within, warns(), message) {
		// Straight to the process's stdout: the test harness captures print!, and drops a passing test's output.
		// On a line of its own: run one at a time, the harness has already printed "test <name> ... " unended.
		let _ = std::io::stdout().lock().write_all(format!("\n{line}").as_bytes());
	}
}

/// What a reading does: `None` within budget; over it, a panic, or when `warn` the annotation line to print.
#[track_caller]
fn over(within: bool, warn: bool, message: impl FnOnce() -> String) -> Option<String> {
	if within {
		return None;
	}
	let message = message();
	if !warn {
		panic!("{message}");
	}
	let at = std::panic::Location::caller();
	Some(format!("::warning file={},line={},title=Timing budget ({ENV}=warn)::{}\n", repo_path(at.file()), at.line(), escape(&message)))
}

/// A source path as GitHub names it, from the repository's root: cargo names a workspace member's files from
/// rust/.
fn repo_path(file: &str) -> String {
	if std::path::Path::new(file).is_absolute() {
		file.to_string()
	} else {
		format!("rust/{file}")
	}
}

/// An annotation's message on one line (GitHub's workflow command escapes).
fn escape(s: &str) -> String {
	s.replace('%', "%25").replace('\r', "%0D").replace('\n', "%0A")
}

/// `assert!` for a timing budget: fails the test where budgets are enforced, warns where
/// `POLESTAR_TIMING_BUDGETS=warn` (CI on GitHub's runners). The message is formatted only when over budget.
#[macro_export]
macro_rules! assert_timing {
	($within:expr, $($message:tt)+) => {
		$crate::timing::budget($within, || format!($($message)+))
	};
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn over_budget_fails_where_enforced_and_warns_at_its_line_where_ci_says_warn() {
		assert_eq!(over(true, false, || unreachable!("formatted only when over")), None);
		assert_eq!(over(true, true, || unreachable!("formatted only when over")), None);
		let enforced = std::panic::catch_unwind(|| over(false, false, || "a step took 3 ms, budget 2 ms".into()));
		assert_eq!(enforced.unwrap_err().downcast_ref::<String>().map(String::as_str), Some("a step took 3 ms, budget 2 ms"));
		let line = over(false, true, || "a step took 3 ms\nbudget 2 ms".into()).unwrap();
		let want = format!("line={},title=Timing budget (POLESTAR_TIMING_BUDGETS=warn)::a step took 3 ms%0Abudget 2 ms\n", line!() - 1);
		assert!(line.starts_with("::warning file=") && line.contains("timing.rs,") && line.ends_with(&want), "{line}");
	}

	#[test]
	fn an_annotation_stays_on_one_line_and_names_the_file_from_the_repository_root() {
		assert_eq!(escape("50% over\nbudget\r"), "50%25 over%0Abudget%0D");
		assert_eq!(repo_path("crates/forge-addontest/tests/addontest/settings-perf.rs"), "rust/crates/forge-addontest/tests/addontest/settings-perf.rs");
	}
}
