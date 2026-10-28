//! The written-guide check fed back to the routes stage (FlowDiag fix 4): the planner's hub counts
//! (crate::hubs) read straight lines between its own steps, while the player walks the written
//! guide, with its flight and dock walks, spawn spots, zone gotos and class detours (c13: the
//! planner counted 9 walked-past on Orc's order, the check 40 on the written guides). So after the
//! routes are written, the guides are written from them and the check's `walked-past`, `dup-trip`,
//! `bounce` and `feel-return` (avoidable returns v1 does not make) read on them; each finding goes
//! back to the route as a move (the quest's accept or hand-in done at the stop the walk passed, a
//! return's work done on the visit before as one block: search::passby::flow_fixes), the routes and
//! guides are written again, and the round is kept when the check finds fewer, at most FLOW_ROUNDS
//! times.
//!
//! forge-sim writes no guides: the caller (forge build) gives the check as a [`FlowCheck`].

use std::path::Path;

/// Rounds of fixes after the first check (each: fixes, written again, checked again).
pub const FLOW_ROUNDS: usize = 3;

/// The rules read on the written guides.
pub const FLOW_RULES: [&str; 4] = ["walked-past", "dup-trip", "bounce", "feel-return"];

/// A rule whose finding is fixed by moving its lines together as one block (an avoidable return).
pub const BLOCK_RULE: &str = "feel-return";
/// One quest line of a written guide, as the route has it: (run kind K_ACCEPT, K_TASK or K_TURNIN,
/// quest id).
pub type Line = (u8, u32);

/// One finding of the check on a start's written guides, as a fix the route can make: `lines`
/// done at the stop the walk passed (right after `after`, the last quest line written there, else
/// right before `before`, the first quest line where the walk goes on to).
#[derive(Clone, Debug, PartialEq)]
pub struct Finding {
	pub start: String,
	pub rule: String,
	/// The check's own line (`<file>:<line> <rule>: <message>`), for the log.
	pub text: String,
	pub lines: Vec<Line>,
	pub after: Option<Line>,
	pub before: Option<Line>,
}

/// The check: given the routes directory (each start's `<start>.json` written there) and the
/// starts, every finding of FLOW_RULES on each start's written guides.
pub type FlowCheck<'a> = dyn Fn(&Path, &[String]) -> Result<Vec<Finding>, String> + Sync + 'a;

/// The findings per rule, `walked-past 12, dup-trip 1, bounce 0`.
pub fn summary(f: &[Finding]) -> String {
	FLOW_RULES.iter().map(|r| format!("{r} {}", f.iter().filter(|x| x.rule == *r).count())).collect::<Vec<_>>().join(", ")
}
