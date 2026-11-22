//! What every scene shares: the release under test (an unpacked release zip), installed the way the client
//! installs it, and the counters of what the player sees, hears and has done for them.
//!
//! - [`release`]: `$POLESTAR_ADDON_DIR`, the AddOns folder an unpacked `Polestar-<v>.zip` (and the Recorder's)
//!   made; [`previous`]: `$POLESTAR_PREVIOUS_ADDON_DIR`, the live release's, for the update scene.
//!   `rust/scripts/scenes.sh` sets both. Without them every scene skips with a line saying so (the workspace
//!   test run has no release zip); the script refuses to call a run that skipped a pass.
//! - [`play`]: one run on the client stub. The addons that load at login (no `## LoadOnDemand: 1`) load at
//!   login from the release folder; every load-on-demand folder of it (the Codex, QuestDB, ItemDB, the walking
//!   maps' parts, the options, the looks, the Arcade, the race and faction guide parts, the language folders)
//!   loads from the release folder when the addon asks for it (tests/lua/stub_packs.lua), never from addon/.
//! - [`COUNTERS`] (installed by [`play`] before any addon file runs, so an addon's `local X = X` captures the
//!   counting version): `Scene.snap()` and `Scene.since(snap)` count what reached the player: chat lines,
//!   sounds, rare alerts (`RARE_SPOTTED`) and rare cards, raid-warning and error-frame lines, taskbar flashes,
//!   and every automatic action (accepting, completing, turning in, choosing a gossip line, taking a flight,
//!   equipping, using, buying, repairing, accepting or declining a group, sending chat, looting).
//!   `Scene.work(fn)` times one event's handling (CPU ms, KiB allocated).

#![allow(dead_code)]

use forge_addontest::{lua_string, run_addon_output, Addon, Output, RunAddon};
use serde_json::Value;
use std::path::{Path, PathBuf};

/// The release under test, None (the scene skips) when `$POLESTAR_ADDON_DIR` is unset.
pub fn release() -> Option<PathBuf> {
	folder("POLESTAR_ADDON_DIR")
}

/// The live release (the update scene's "before"), None when `$POLESTAR_PREVIOUS_ADDON_DIR` is unset.
pub fn previous() -> Option<PathBuf> {
	folder("POLESTAR_PREVIOUS_ADDON_DIR")
}

fn folder(var: &str) -> Option<PathBuf> {
	let dir = PathBuf::from(std::env::var_os(var)?);
	assert!(dir.join("Polestar/Polestar.toc").exists(), "${var}={}: no Polestar/Polestar.toc there (an unpacked release zip's AddOns folder)", dir.display());
	Some(dir)
}

/// The release, or None after a line saying the scene skipped (no `$POLESTAR_ADDON_DIR`).
pub fn release_or_skip() -> Option<PathBuf> {
	let dir = release();
	if dir.is_none() {
		skip("POLESTAR_ADDON_DIR is unset (run rust/scripts/scenes.sh <release zip>)");
	}
	dir
}

/// Says a scene skipped, on the process's own stdout (the test harness would swallow a passing test's
/// print!), as `scene skipped: <why>` on a line of its own: rust/scripts/scenes.sh fails a run with one.
pub fn skip(why: &str) {
	use std::io::Write;
	let _ = std::io::stdout().lock().write_all(format!("\nscene skipped: {why}\n").as_bytes());
}

/// Whether `<dir>/<name>/<name>.toc` says `## LoadOnDemand: 1`.
pub fn load_on_demand(dir: &Path, name: &str) -> bool {
	std::fs::read_to_string(dir.join(name).join(format!("{name}.toc"))).is_ok_and(|t| t.lines().any(|l| l.trim().replace(' ', "").eq_ignore_ascii_case("##LoadOnDemand:1")))
}

/// A release folder, installed: the addons the client loads at login (in the client's order: Polestar
/// first, then the rest as the release lists them, then the Recorder), and the Lua that registers every
/// load-on-demand folder with the stubbed client (stub.packs, stub.addons).
pub struct Install {
	pub login: Vec<Addon>,
	pub names: Vec<String>,
	pub demand: Vec<String>,
	pub packs_lua: String,
}

pub fn install(dir: &Path) -> Install {
	let mut all = forge_release::addons::release_addons(dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())).names;
	if dir.join("Polestar_Recorder/Polestar_Recorder.toc").exists() {
		all.push("Polestar_Recorder".into());
	}
	let (demand, login): (Vec<String>, Vec<String>) = all.into_iter().partition(|n| load_on_demand(dir, n));
	let mut lua = vec!["stub.packs = stub.packs or {}".to_string()];
	for (i, n) in login.iter().chain(demand.iter()).enumerate() {
		let lod = demand.contains(n);
		lua.push(format!(
			"stub.addons[{}] = {{ name = {q}, title = {q}, enabled = true, loaded = {loaded}, demand = {lod}, reason = {reason} }}",
			i + 1,
			q = lua_string(n),
			loaded = !lod,
			reason = if lod { "\"DEMAND_LOADED\"" } else { "nil" },
		));
		if lod {
			let files = forge_addontest::run::dir_files(&dir.join(n)).unwrap_or_else(|e| panic!("{n}: {e}"));
			let list: Vec<String> = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
			lua.push(format!("stub.packs[{}] = {{ {} }}", lua_string(n), list.join(", ")));
		}
	}
	Install { login: login.iter().map(|n| Addon::dir(n, dir.join(n))).collect(), names: login, demand, packs_lua: lua.join("\n") }
}

/// The counters (see the module docs). Lua, run after the stubs and before any addon file.
pub const COUNTERS: &str = r#"
Scene = { auto = {}, alerts = {}, rares = 0, cards = 0, autoLog = {} }
local function bump(t, k, what) t[k] = (t[k] or 0) + 1; if what then Scene.autoLog[#Scene.autoLog + 1] = what end end
local function wrap(tbl, key, label, into)
	local f = tbl and tbl[key]
	if type(f) ~= "function" then return end
	tbl[key] = function(...)
		local a = select(1, ...)
		bump(into or Scene.auto, label, label .. "(" .. tostring(a) .. ")")
		return f(...)
	end
end
for _, k in ipairs({ "AcceptQuest", "CompleteQuest", "GetQuestReward", "SelectAvailableQuest", "SelectActiveQuest",
	"AcknowledgeAutoAcceptQuest", "DeclineQuest", "TakeTaxiNode", "EquipItemByName", "UseContainerItem", "BuyMerchantItem",
	"RepairAllItems", "AcceptGroup", "DeclineGroup", "SendChatMessage", "LootSlot", "ConfirmBinder", "AcceptTrade",
	"ConfirmLootRoll", "RollOnLoot", "AbandonQuest", "SetAbandonQuest", "PickupContainerItem", "DeleteCursorItem" }) do
	wrap(_G, k, k)
end
if C_GossipInfo then
	for _, k in ipairs({ "SelectAvailableQuest", "SelectActiveQuest", "SelectOption", "SelectOptionByIndex" }) do wrap(C_GossipInfo, k, "C_GossipInfo." .. k) end
end
if C_Container then wrap(C_Container, "UseContainerItem", "C_Container.UseContainerItem") end
wrap(_G, "RaidNotice_AddMessage", "RaidNotice_AddMessage", Scene.alerts)
wrap(_G, "FlashClientIcon", "FlashClientIcon", Scene.alerts)
if UIErrorsFrame and UIErrorsFrame.AddMessage then
	local add = UIErrorsFrame.AddMessage
	UIErrorsFrame.AddMessage = function(self, ...) bump(Scene.alerts, "UIErrorsFrame"); return add(self, ...) end
end

local function copy(t) local o = {} for k, v in pairs(t) do o[k] = v end return o end
local function sum(t) local n = 0 for _, v in pairs(t) do n = n + v end return n end

-- After login (Polestar is loaded): count rare alerts and rare cards.
function Scene.watch()
	if Scene.watching then return end
	Scene.watching = true
	if Polestar and Polestar.On then Polestar.On("RARE_SPOTTED", function() Scene.rares = Scene.rares + 1 end) end
	local toast = Polestar and Polestar.Rares and Polestar.Rares.Toast
	if toast and toast.Show then
		local show = toast.Show
		toast.Show = function(...) Scene.cards = Scene.cards + 1; return show(...) end
	end
end

function Scene.snap()
	return { chat = #stub.messages, sounds = #stub.sounds, rares = Scene.rares, cards = Scene.cards, auto = copy(Scene.auto),
		alerts = copy(Scene.alerts), autoLog = #Scene.autoLog }
end

-- What happened since `s` (a Scene.snap()): counts, plus the chat lines, sounds and automatic actions themselves.
function Scene.since(s)
	local d = { chat = #stub.messages - s.chat, sounds = #stub.sounds - s.sounds, rares = Scene.rares - s.rares,
		cards = Scene.cards - s.cards, auto = {}, alerts = {}, lines = {}, soundIds = {}, actions = {} }
	for k, v in pairs(Scene.auto) do if v - (s.auto[k] or 0) > 0 then d.auto[k] = v - (s.auto[k] or 0) end end
	for k, v in pairs(Scene.alerts) do if v - (s.alerts[k] or 0) > 0 then d.alerts[k] = v - (s.alerts[k] or 0) end end
	for i = s.chat + 1, #stub.messages do d.lines[#d.lines + 1] = stub.messages[i] end
	for i = s.sounds + 1, #stub.sounds do d.soundIds[#d.soundIds + 1] = tostring(stub.sounds[i]) end
	for i = s.autoLog + 1, #Scene.autoLog do d.actions[#d.actions + 1] = Scene.autoLog[i] end
	d.autoTotal, d.alertTotal = sum(d.auto), sum(d.alerts)
	return d
end

-- One event's handling: fn's CPU milliseconds and the KiB the heap grew by (garbage included).
function Scene.work(fn)
	local kb, t = collectgarbage("count"), os.clock()
	fn()
	return { ms = (os.clock() - t) * 1000, kb = collectgarbage("count") - kb }
end
"#;

/// One scene's run.
#[derive(Default)]
pub struct Play {
	/// The release folder (default: [`release`]).
	pub dir: Option<PathBuf>,
	/// More tests/lua stubs, after stub_world.lua (stub_packs.lua is always last).
	pub stubs: Vec<&'static str>,
	/// Lua after the stubs and counters, before any addon file (the world: maps, level, faction, position).
	pub before: String,
	/// (addon name, Lua restoring its saved variables), as [`RunAddon::saved`].
	pub saved: Vec<(String, String)>,
	/// Lua after login; `Scene.watch()` has run.
	pub script: String,
}

/// Runs a scene on the release: its output, or the Lua error.
pub fn play_output(p: &Play) -> Result<Output, String> {
	let dir = p.dir.clone().or_else(release).expect("a release folder");
	let inst = install(&dir);
	let mut stubs = vec!["stub_world.lua"];
	stubs.extend(p.stubs.iter().copied().filter(|s| *s != "stub_world.lua" && *s != "stub_packs.lua"));
	stubs.push("stub_packs.lua");
	run_addon_output(&RunAddon {
		stubs,
		before: format!("{COUNTERS}\n{}\n{}", inst.packs_lua, p.before),
		addons: inst.login,
		saved: p.saved.clone(),
		login: true,
		script: format!("Scene.watch()\n{}", p.script),
	})
}

/// [`play_output`]'s emitted values; a Lua error panics with it.
pub fn play(p: &Play) -> Vec<Value> {
	play_output(p).unwrap_or_else(|e| panic!("{e}")).emitted
}
