//! A flight to a stop with nothing to do, followed by another flight (validate.rs, check_flight_hops, #1191):
//! one flight to the second one's end does the same. Per character; work, a `when` or another continent in
//! between keep the stop.

use crate::common;
use common::*;
use forge_guide::diag::Diag;

fn hops(src: &str) -> Vec<Diag> {
	// A house rule: an error in our pack, a warning in others.
	compile(src).diag.sorted().into_iter().filter(|d| d.message.contains("with nothing to do in between")).collect()
}

const FLY_STORMWIND: [&str; 3] = ["step Fly to Stormwind", "  goto 42.0,65.0 \"Goldshire flight master\"", "  fly \"Stormwind\""];
const FLY_ON: [&str; 4] = ["step Fly to Sentinel Hill", "  zone Stormwind City", "  goto 66.3,62.7 \"Stormwind flight master\"", "  fly \"Sentinel Hill\""];

fn guide(between: &[&str]) -> String {
	let mut all: Vec<&str> = FLY_STORMWIND.to_vec();
	all.push("");
	all.extend_from_slice(between);
	if !between.is_empty() {
		all.push("");
	}
	all.extend_from_slice(&FLY_ON);
	guide_text(&all)
}

#[test]
fn a_flight_straight_on_from_where_the_first_lands_is_flagged_at_the_first_naming_both() {
	let src = guide(&[]);
	let ws = hops(&src);
	assert_eq!(ws.len(), 1, "{ws:?}");
	assert_eq!(ws[0].line as usize, line_of(&src, "  fly \"Stormwind\""));
	assert_eq!(
		ws[0].message,
		format!(
			"flies to Stormwind and on to Sentinel Hill (line {}) with nothing to do in between for every character: fly to Sentinel Hill from here (the flight passes through Stormwind on its own)",
			line_of(&src, "  fly \"Sentinel Hill\"")
		)
	);
	// A walk across the town to the next flight master is no work either.
	assert_eq!(hops(&guide(&["step Trade District", "  zone Stormwind City", "  goto 60.0,70.0 \"Trade District\""])).len(), 1);
}

#[test]
fn work_a_when_or_optional_work_at_the_stop_keeps_it() {
	assert!(hops(&guide(&["step Stormwind", "  zone Stormwind City", "  turnin 7"])).is_empty());
	assert!(hops(&guide(&["step Stormwind", "  zone Stormwind City", "  when level>=5", "  goto 60.0,70.0 \"Trade District\""])).is_empty());
	assert!(hops(&guide(&["step Stormwind", "  zone Stormwind City", "  vendor nearest optional"])).is_empty());
}

#[test]
fn work_for_some_classes_only_flags_the_hop_for_the_others() {
	let ws = hops(&guide(&["step Mage training", "  only Mage", "  zone Stormwind City", "  train class"]));
	assert_eq!(ws.len(), 1, "{ws:?}");
	assert!(!ws[0].message.contains("every character") && !ws[0].message.contains("Mage"), "{}", ws[0].message);
	assert!(ws[0].message.contains("Warrior"), "{}", ws[0].message);
}

#[test]
fn a_flight_with_no_flight_master_to_leave_from_and_a_trip_onto_another_continent_are_kept() {
	// A Druid's Moonglade flight: no flight master on the way out.
	let moonglade = guide_text(&["step Moonglade", "  fly \"Stormwind\"", "", FLY_ON[0], FLY_ON[1], FLY_ON[2], FLY_ON[3]]);
	assert!(hops(&moonglade).is_empty());
	// A boat between: its dock lies on another continent from the next flight's flight master.
	let boat = guide(&["step Boat", "  zone Durotar", "  goto 50.0,50.0 \"Dock\""]);
	assert!(hops(&boat).is_empty());
}
