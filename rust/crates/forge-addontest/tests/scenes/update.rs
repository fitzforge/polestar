//! An update from the live release: the previous release (`$POLESTAR_PREVIOUS_ADDON_DIR`) plays the full-log
//! scene's character (Goldshire, partway through the Elwynn Forest guide) with three settings changed and every
//! companion addon enabled, and logs out; the client writes every saved variable the previous release's TOCs
//! list. The release under test then logs in with them: no Lua error, the same guide at the same step (its title
//! and goals: an update that drops or merges steps ahead of it renumbers it), the
//! changed settings kept, no addon of the release left off or turned off (#2594), the settings window loading,
//! Install not shown again, nothing in chat, no sound, alert or automatic action, and a bounded login.

use crate::common::{install, play, previous, release_or_skip, skip, Play};
use crate::questlog::{empty, goldshire};
use forge_addontest::lua_string;
use serde_json::Value;
use std::path::Path;

/// (addon, saved variable names) for each addon folder of `dir` whose TOC lists any (`## SavedVariables:` and
/// `## SavedVariablesPerCharacter:`).
fn saved_variables(dir: &Path) -> Vec<(String, Vec<String>)> {
	let mut out = Vec::new();
	let Ok(entries) = std::fs::read_dir(dir) else { return out };
	let mut names: Vec<String> = entries.filter_map(|e| e.ok()).map(|e| e.file_name().to_string_lossy().into_owned()).collect();
	names.sort();
	for name in names {
		let Ok(toc) = std::fs::read_to_string(dir.join(&name).join(format!("{name}.toc"))) else { continue };
		let mut vars = Vec::new();
		for line in toc.lines() {
			let Some(rest) = line.trim().strip_prefix("##") else { continue };
			let Some((key, value)) = rest.split_once(':') else { continue };
			if matches!(key.trim(), "SavedVariables" | "SavedVariablesPerCharacter") {
				vars.extend(value.split(',').map(|v| v.trim().to_string()).filter(|v| !v.is_empty()));
			}
		}
		if !vars.is_empty() {
			out.push((name, vars));
		}
	}
	out
}

/// The settings the player changed before the update: (path, Lua value, the value as emitted).
const CHANGED: &[(&str, &str, &str)] = &[("nav.routeStyle", "\"roads\"", "\"roads\""), ("qol.sellJunk", "false", "false"), ("behavior.whileHereRadius", "240", "240")];

/// Lua: `stepAt(i)`, step i of the loaded guide as its title and goals (verbs and ids, as the Engine keys a step for
/// an update), or false. A release that drops or merges a step ahead of the player's renumbers theirs (0.4.2's
/// Northshire rework put Goldshire at 50 of Elwynn Forest, 51 in 0.4.1.1), so the place is compared by this.
const STEP_AT: &str = r#"
local function stepAt(i)
	local g = Polestar.Engine.GetGuide()
	local s = g and i and g.steps[i]
	if not s then return false end
	local ids = {}
	for k, x in ipairs(s.goals) do
		ids[k] = x.t .. ":" .. tostring(x.quest or x.npc or x.item or x.spell or x.object or x.faction or x.achievement or x.level or x.location or x.map or "")
	end
	return (s.title or "") .. " | " .. table.concat(ids, ",")
end
"#;

#[test]
fn an_update_keeps_the_guide_step_settings_and_addons_2594() {
	let Some(dir) = release_or_skip() else { return };
	let Some(prev) = previous() else {
		skip("POLESTAR_PREVIOUS_ADDON_DIR is unset (the live release's unpacked AddOns folder): the update scene needs it");
		return;
	};
	let vars = saved_variables(&prev);
	assert!(vars.iter().any(|(a, _)| a == "Polestar"), "{}: Polestar's TOC lists no saved variables", prev.display());

	// The previous release: mid-guide, settings changed, then logout.
	let groups: Vec<String> = vars.iter().map(|(a, v)| format!("{{ {}, {{ {} }} }}", lua_string(a), v.iter().map(|n| lua_string(n)).collect::<Vec<_>>().join(", "))).collect();
	let sets: Vec<String> = CHANGED.iter().map(|(p, v, _)| format!("Polestar.Set({}, {v})", lua_string(p))).collect();
	let before = play(&Play {
		dir: Some(prev.clone()),
		script: format!(
			r#"{STEP_AT}
local at = ScenesQ.place(240)
if not at then error("the previous release loaded no guide, or none that hands in a quest to Marshal Dughan (240)", 0) end
{sets}
stub.advance(5)
local E = Polestar.Engine
local state = {{ guide = E.GetGuide() and E.GetGuide().id or false, step = E.GetStepIndex() or false, live = E.GetLiveStep() or false }}
state.stepAt, state.liveAt = stepAt(state.step), stepAt(state.live)
stub.fire("PLAYER_LOGOUT")
local saved = {{}}
for _, g in ipairs({{ {groups} }}) do saved[#saved + 1] = {{ g[1], ScenesQ.saved(g[2]) }} end
emit({{ state = state, saved = saved, world = ScenesQ.world(), lines = Scene.since(Scene.atLogin).lines }})
"#,
			sets = sets.join("\n"),
			groups = groups.join(", ")
		),
		..goldshire("")
	})
	.into_iter()
	.next()
	.expect("the previous release's run emitted nothing");
	let old = &before["state"];
	assert!(old["guide"].is_string() && old["step"].as_u64().is_some_and(|s| s > 1), "the previous release's character is not partway through a guide: {old}");

	// The release under test, with what the previous one saved: login addons get theirs before their
	// ADDON_LOADED, the rest (load on demand here) before any addon loads.
	let login = install(&dir).names;
	let mut saved = Vec::new();
	let mut early = Vec::new();
	for pair in before["saved"].as_array().cloned().unwrap_or_default() {
		let (Some(addon), Some(lua)) = (pair[0].as_str(), pair[1].as_str()) else { continue };
		if lua.is_empty() {
			continue;
		}
		if login.iter().any(|n| n == addon) {
			saved.push((addon.to_string(), lua.to_string()));
		} else {
			early.push(lua.to_string());
		}
	}
	let world = before["world"].as_str().expect("the previous run's world");
	let checks: Vec<String> = CHANGED.iter().map(|(p, _, _)| format!("[{0}] = Polestar.Get({0})", lua_string(p))).collect();
	let out = play(&Play {
		dir: Some(dir.clone()),
		stubs: vec!["stub_scenes_quests.lua"],
		before: format!("ScenesQ.goldshire()\nScenesQ.restore({world})\n{}\nScene.atLogin = Scene.snap()", early.join("\n")),
		saved,
		script: format!(
			r#"{STEP_AT}
local loginMs = ScenesQ.loginMs()
local settle = Scene.work(function() stub.advance(10) end)
local E = Polestar.Engine
local off = {{}}
for _, a in ipairs(stub.addons) do if C_AddOns.GetAddOnEnableState(a.name) ~= 2 then off[#off + 1] = a.name end end
local P = Polestar.UI and Polestar.UI.Packs
local needed = P and P.NeededOff and P.NeededOff() or {{}}
local settings = {{ {checks} }}
local welcome = PolestarWelcome ~= nil and PolestarWelcome:IsShown()
SlashCmdList.POLESTAR("options")
stub.advance(2)
local d = Scene.since(Scene.atLogin)
emit({{ guide = E.GetGuide() and E.GetGuide().id or false, step = E.GetStepIndex() or false, live = E.GetLiveStep() or false,
	stepAt = stepAt(E.GetStepIndex()), liveAt = stepAt(E.GetLiveStep()),
	settings = settings, welcome = welcome, off = off, disabled = ScenesQ.disabled, needed = needed,
	options = C_AddOns.IsAddOnLoaded("Polestar_Options"), lines = d.lines, sounds = d.soundIds, alerts = d.alerts, actions = d.actions,
	loginMs = loginMs, settleMs = settle.ms }})
"#,
			checks = checks.join(", ")
		),
	})
	.into_iter()
	.next()
	.expect("the release's run emitted nothing");
	println!("before: {}\nafter: {}", serde_json::to_string_pretty(old).unwrap(), serde_json::to_string_pretty(&out).unwrap());

	assert_eq!(out["guide"], old["guide"], "the update changed the loaded guide: {old} -> {out}");
	assert!(old["stepAt"].is_string(), "the previous release's step has no title or goals: {old}");
	assert_eq!(out["stepAt"], old["stepAt"], "the update moved the guide's step: {old} -> {out}");
	assert_eq!(out["liveAt"], old["liveAt"], "the update moved the live step: {old} -> {out}");
	for (path, _, want) in CHANGED {
		let want: Value = serde_json::from_str(want).unwrap();
		assert_eq!(out["settings"][path], want, "the update lost the setting {path}: {}", out["settings"]);
	}
	assert!(empty(&out["off"]), "addons of the release left off after the update (#2594): {}", out["off"]);
	assert!(empty(&out["disabled"]), "Polestar turned addons off: {}", out["disabled"]);
	assert!(empty(&out["needed"]), "Polestar reads its own addons as off (#2594): {}", out["needed"]);
	assert_eq!(out["options"], true, "the settings window (Polestar_Options) did not load after the update: {out}");
	assert_eq!(out["welcome"], false, "Install opened again after the update: {out}");
	assert!(empty(&out["lines"]), "chat lines at the first login after the update: {}", out["lines"]);
	assert!(empty(&out["sounds"]), "sounds at the first login after the update: {}", out["sounds"]);
	assert!(empty(&out["alerts"]), "alerts at the first login after the update: {}", out["alerts"]);
	assert!(empty(&out["actions"]), "automatic actions at the first login after the update: {}", out["actions"]);
	let login = out["loginMs"].as_f64().unwrap_or(f64::NAN);
	forge_addontest::assert_timing!(login < LOGIN_MS, "the first login after the update took {login:.0} ms from PLAYER_LOGIN (budget {LOGIN_MS} ms)");
	let settle = out["settleMs"].as_f64().unwrap_or(f64::NAN);
	forge_addontest::assert_timing!(settle < SETTLE_MS, "the 10 s after the update's login took {settle:.0} ms (budget {SETTLE_MS} ms)");
}

/// Budgets (CPU ms, quiet machine), about 5x 0.4.1.1's: PLAYER_LOGIN through the login's timers (the guide placed
/// on the carried quest log, the Codex and the guide parts loaded: 125 ms), and the deferred work of the next 10 s
/// (25 ms).
const LOGIN_MS: f64 = 600.0;
const SETTLE_MS: f64 = 150.0;
