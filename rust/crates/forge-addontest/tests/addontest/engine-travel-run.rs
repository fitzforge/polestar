//! The travel-step stall (addon/Polestar/Core/Engine.lua, Own.travelOnly, Own.nextStepDone, Own.arriveRun;
//! docs/ARCHITECTURE.md, "Navigation"). A `goto` passed on arrival (checked only for the step on screen) or once
//! the NEXT step's quest work was done, so a travel step followed by another travel step ("Tram to Stormwind",
//! then "Elwynn Forest") never passed for a player who got there another way: a Dwarf who flew to Stormwind
//! questing in Redridge read "Looking ahead. The guide is at step 23" (the tram). Now a run of travel steps is
//! looked through to the first step with other work, and reaching a later step of the run, or that work's place,
//! passes the steps before it. The real Loch Modan guide (loch-modan.rs).

use crate::loch_modan::{run_as, AT_THE_TRAM, AT_THE_TUNNEL};
use serde_json::json;

#[test]
fn the_dwarf_who_flew_to_stormwind_and_took_three_corners_quest_is_on_lakeridge_highway_not_the_tram() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TRAM}
emit(live())
stub.world.moveTo(1433, 30.0, 70.0); flush()               -- somewhere in Redridge, at no step's place
stub.world.accept(244, {{}}); flush(); stub.advance(1.5); flush()
emit(live())"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!("Tram to Stormwind"));
	assert_eq!(out[1], json!("Lakeridge Highway"), "Three Corners' quest taken passes the tram and Elwynn's road with it");
}

#[test]
fn standing_at_the_second_goto_of_a_run_passes_the_first() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TRAM}
walk(step("Elwynn Forest"))
emit({{ live(), view() }})"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!(["Elwynn Forest", "Elwynn Forest"]), "at the road east to Redridge: the tram is behind the player");
}

#[test]
fn reaching_the_place_of_the_work_after_the_run_passes_the_whole_run() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TRAM}
walk(step("Three Corners"))
emit(live())"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!("Three Corners"));
}

#[test]
fn a_run_before_a_step_whose_work_is_not_done_and_not_reached_passes_nothing() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TRAM}
stub.world.moveTo(1433, 30.0, 70.0); flush(); stub.advance(1.5); flush()
emit(live())"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!("Tram to Stormwind"));
}

#[test]
fn a_stop_with_a_flight_path_and_a_hand_in_ends_the_run_it_is_never_passed_by_reaching_it() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TUNNEL}
emit(live())
walk(step("Ironforge"), "getfp")
emit(live())"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!("Into Dun Morogh"));
	assert_eq!(out[1], json!("Ironforge"), "Dun Morogh and Ironforge's gate pass; Ironforge holds for its flight path and 301");
}
