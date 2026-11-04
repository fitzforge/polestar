//! The simulated player the guide tests run on the stub world.

/// Lua (tests/lua/simulate.lua) that plays the open guide on stub_world.lua step by step and emits
/// `{ done, stuck, visited, steps, missing, wrongPick, level }`. Run it in `script` after the guide is set.
pub const SIMULATE: &str = include_str!("../../../../tests/lua/simulate.lua");
