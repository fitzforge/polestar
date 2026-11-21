//! Scenes on the release zip: what a player sees, hears and has done for them in the situations every
//! player meets (a capital, fights, a flight, a full quest log, the first run, an update), with the work each
//! event costs. Run on an unpacked release by `rust/scripts/scenes.sh <zip> --previous <live zip>`
//! (docs/RELEASING.md); without one every scene skips.

mod common;

#[path = "questlog.rs"]
mod questlog;

#[path = "capitals.rs"]
mod capitals;

#[path = "automation.rs"]
mod automation;

#[path = "firstrun.rs"]
mod firstrun;

#[path = "update.rs"]
mod update;

#[path = "fights.rs"]
mod fights;

#[path = "flight.rs"]
mod flight;
