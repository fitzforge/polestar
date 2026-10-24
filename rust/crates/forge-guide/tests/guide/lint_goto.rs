//! A `goto` right before a goal that already leads to the same place (validate.rs, checkRedundantGotos):
//! warned with a fix hint; approach waypoints, lone gotos and paths are kept.

use crate::common;
use common::*;
use forge_guide::diag::Diag;

fn goto_warnings(src: &str) -> Vec<Diag> {
	compile(src).diag.warnings().into_iter().filter(|d| d.message.contains("already leads")).cloned().collect()
}

#[test]
fn a_goto_next_to_the_kill_goal_it_leads_to_is_warned_naming_both_and_how_to_fix_it() {
	let src = guide_text(&["step Kobolds", "  goto 47.6,31.5 \"Kobold camp\"", "  kill 6 x10"]);
	let ws = goto_warnings(&src);
	assert_eq!(ws.len(), 1);
	assert_eq!(ws[0].line as usize, line_of(&src, "  goto 47.6,31.5 \"Kobold camp\""));
	assert_match(&ws[0].message, &format!(r#"^`goto 47.6,31.5` "Kobold camp" sends the player where `kill Kobold Vermin` \(line {}\) already leads, \d+ yards away$"#, line_of(&src, "  kill 6 x10")));
	assert_eq!(ws[0].hint.as_deref(), Some("remove the goto: the arrow leads to `kill Kobold Vermin` directly"));
}

#[test]
fn an_approach_goto_far_from_the_objective_and_a_lone_goto_are_not_warned() {
	assert!(goto_warnings(&guide_text(&["step Kobolds", "  goto 47.6,70.0 \"South road\"", "  kill 6 x10"])).is_empty());
	assert!(goto_warnings(&guide_text(&["step The road", "  goto 47.6,31.5 \"Kobold camp\"", "", "step Kobolds", "  kill 6 x10"])).is_empty());
}

#[test]
fn a_path_of_gotos_keeps_all_but_the_last_travel_steps_and_optional_next_goals_keep_theirs() {
	let path = guide_text(&["step Kobolds", "  goto 47.0,33.0 \"Hill\"", "  goto 47.6,31.5 \"Kobold camp\"", "  kill 6 x10"]);
	assert_eq!(goto_warnings(&path).iter().map(|d| d.line as usize).collect::<Vec<_>>(), vec![line_of(&path, "  goto 47.6,31.5 \"Kobold camp\"")]);
	assert!(goto_warnings(&guide_text(&["step Kobolds", "  goto 47.6,31.5 \"Kobold camp\"", "  kill 6 x10 optional"])).is_empty());
	assert!(goto_warnings(&guide_text(&["step Kobolds", "  goto 47.6,31.5 \"Kobold camp\"", "  kill 6 x10", "  hearth \"Goldshire\""])).is_empty());
}
