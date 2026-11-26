//! The simulated player the guide tests run on the stub world.

/// Lua (tests/lua/simulate.lua) that plays the open guide on stub_world.lua step by step and emits
/// `{ done, stuck, visited, steps, missing, wrongPick, level }`. Run it in `script` after the guide is set. Read
/// from the checkout the tests run in ([`crate::run::root`]), not baked in when they are built.
pub static SIMULATE: std::sync::LazyLock<String> = std::sync::LazyLock::new(|| {
	let file = crate::run::root().join("tests/lua/simulate.lua");
	std::fs::read_to_string(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()))
});
