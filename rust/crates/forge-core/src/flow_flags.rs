//! Flow flags: experimental route-flow rules, each off unless named in `FORGE_FLOW`
//! (comma-separated), so rounds can compare them one by one and together (#1046, the overnight
//! flow experiments). Read once per process.
//!
//! - `greedy`: stand-next-to pickups and hand-ins are taken (wider hub pickup and on-the-way radii,
//!   a larger allowance for them);
//! - `revisit`: the search and the passes price the flow counts the guards read (avoidable returns,
//!   split work, left ready, walked past, finished near, givers passed and taken later), so a move
//!   that removes one may cost some model time;
//! - `sweep`: work whose ground the route stands on while its quest is open and on level is done
//!   then, not kept for a later sweep that brings the player back;
//! - `steps`: the writer writes no `along` lists; their work is an ordinary goal at the stop nearest
//!   it (or stays at its own stop);
//! - `coverage`: the pickup pass takes passed quests at half the route's XP rate (a quarter on a
//!   cheap detour) and lets each add 5 minutes, so marginal quests on the route are done;
//! - `grind`: every grind of the model's own of 10 minutes or more is written as a top-up step at
//!   a camp, whatever it costs (no hidden grind inside a task);
//! - `zoneleft`: the search and the passes price each quest of a zone the route leaves for good
//!   while the quest is open (or opens within 2 levels) at about the character's level and no later
//!   visit takes it (forge_sim::guards::GuardCounts::zone_left).
//!
//! The planner flags are part of the routes stage's search key, `steps` of its stage key
//! (forge/src/lib.rs), so a build with other flags never reuses another's finished searches.

use std::sync::atomic::{AtomicU16, Ordering};
use std::sync::LazyLock;

/// Every flag, in key order.
pub const ALL: [&str; 7] = ["greedy", "revisit", "sweep", "steps", "coverage", "grind", "zoneleft"];
/// The flags that change the planner (the search key); the rest change only the writer.
pub const PLANNER: [&str; 6] = ["greedy", "revisit", "sweep", "coverage", "grind", "zoneleft"];

fn parse(s: &str) -> u8 {
	let mut bits = 0u8;
	for part in s.split(',').map(str::trim).filter(|p| !p.is_empty()) {
		let Some(i) = ALL.iter().position(|f| *f == part) else {
			panic!("FORGE_FLOW: unknown flag {part:?} (known: {})", ALL.join(", "));
		};
		bits |= 1 << i;
	}
	bits
}

static BITS: LazyLock<u8> = LazyLock::new(|| parse(&std::env::var("FORGE_FLOW").unwrap_or_default()));
/// A test's flags in place of FORGE_FLOW (NO_OVERRIDE: none). Process-wide: a test binary that
/// sets it holds its flag tests in one test function.
static OVERRIDE: AtomicU16 = AtomicU16::new(NO_OVERRIDE);
const NO_OVERRIDE: u16 = u16::MAX;

fn bits() -> u8 {
	match OVERRIDE.load(Ordering::Relaxed) {
		NO_OVERRIDE => *BITS,
		b => b as u8,
	}
}

/// Tests: the flags `names` on (in place of FORGE_FLOW) for the whole process, until set again.
pub fn set_for_tests(names: &[&str]) {
	OVERRIDE.store(u16::from(parse(&names.join(","))), Ordering::Relaxed);
}

/// Whether flag `name` (one of ALL) is on.
pub fn on(name: &str) -> bool {
	let i = ALL.iter().position(|f| *f == name).unwrap_or_else(|| panic!("flow flag {name:?} is not one of {ALL:?}"));
	bits() & (1 << i) != 0
}

/// The flags that are on among `among`, as a key part ("" when none).
pub fn key(among: &[&str]) -> String {
	among.iter().copied().filter(|f| on(f)).collect::<Vec<_>>().join(",")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn parses_known_flags_and_ignores_spaces() {
		assert_eq!(parse(""), 0);
		assert_eq!(parse("greedy, sweep"), 0b101);
		assert_eq!(parse("steps,revisit"), 0b1010);
	}

	#[test]
	#[should_panic(expected = "unknown flag")]
	fn refuses_an_unknown_flag() {
		parse("greedy,typo");
	}
}
