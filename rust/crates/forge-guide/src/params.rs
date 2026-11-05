//! Port of tools/lib/sim/params.js.
//! Only what timed.rs uses: the prior means (`PRIORS[name][0]`) of the simulator parameters lint estimates with.
//! The rest of params.js (spreads, bounds, calibration files, sampling) belongs to the simulator, not the compiler.

/// run speed, yd/s
pub const RUN_SPEED: f64 = 7.0;
/// level the mount is bought
pub const MOUNT_LEVEL: f64 = 40.0;
/// mounted speed multiplier
pub const MOUNT_MUL: f64 = 1.6;
/// walking detour factor, Eastern Kingdoms (path / straight line)
pub const DETOUR0: f64 = 1.35;
/// walking detour factor, Kalimdor
pub const DETOUR1: f64 = 1.3;
/// seconds per kill incl. downtime at level 1 (equal-level mob)
pub const KILL_SEC1: f64 = 11.0;
/// seconds per kill incl. downtime at level 60
pub const KILL_SEC60: f64 = 30.0;
/// kill time +share per mob level above the player
pub const KILL_UP: f64 = 0.1;
/// kill time -share per mob level below the player (floor 0.5)
pub const KILL_DOWN: f64 = 0.05;
/// kill time multiplier for elites
pub const ELITE_TIME: f64 = 3.5;
/// kill time multiplier of the class
pub const CLASS_FACTOR: f64 = 1.0;
/// multiplier on the walk between mobs from spawn density
pub const SPACING: f64 = 1.0;
/// seconds per accept or turn-in
pub const TALK_SEC: f64 = 6.0;
/// seconds per object use
pub const INTERACT_SEC: f64 = 8.0;
/// incidental kills per objective kill
pub const EXTRA_KILL: f64 = 0.043;
/// seconds per flight: talk, take-off, landing
pub const FLIGHT_OVERHEAD: f64 = 20.0;
/// hearthstone cast, seconds
pub const HEARTH_CAST: f64 = 10.0;
