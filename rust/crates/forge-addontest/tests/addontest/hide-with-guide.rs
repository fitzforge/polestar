//! Hiding the guide window (ui.shown): the action buttons, the travel button and the rare and transport alerts
//! go with it; the arrow only with "Hide the arrow with the guide" (nav.hideArrowWithGuide) on, and never on the
//! way back to your corpse or a Spirit Healer (QoL/Death.lua). The buttons run the QoL harness
//! (tests/lua/stub_qol.lua), the arrow, travel button, alerts and commands the real Core/Init.lua + Theme +
//! Nav/Nav.xml against tests/lua/stub_nav.lua, and the rares the real Core, Nav, Lookup and Rares files over
//! stub_world.lua and stub_rares.lua.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, lua_string, Addon, RunAddon};
use serde_json::{json, Value};

fn run_nav(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn hiding_the_guide_hides_the_quest_item_hearthstone_target_rare_and_bag_buttons_and_showing_it_brings_them_back() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])],
		login: true,
		script: r#"
		local q = stub.qol
		q.addItem(0, 1, 6948, 1)
		q.addItem(0, 2, 900, 1)
		q.step({ { t = "hearth" }, { t = "kill", target = "Wolf" }, { t = "use", item = 900, quest = 7, oi = 1 } })
		Polestar.Rares = { Nearby = function() return { "Thuros" } end }
		Polestar.QoL.Space = { Low = function() return true end, Junk = function() return { id = 900 } end, Armed = function() return false end, Free = function() return 1 end }
		local function shown()
			stub.runTimers()
			emit({ PolestarQuestItemButton:IsShown(), PolestarHearthButton:IsShown(), PolestarTargetButton:IsShown(), PolestarRareButton:IsShown(), PolestarBagButton:IsShown() })
		end
		Polestar.Fire("BAG_SPACE")
		shown()
		Polestar.Set("ui.shown", false)
		shown()
		Polestar.Set("ui.shown", true)
		shown()"#
			.into(),
		..Default::default()
	});
	let all = |v: bool| json!(vec![v; 5]);
	assert_eq!(out, vec![all(true), all(false), all(true)]);
}

// The travel button (the route's Hearthstone) is a button: it goes with the window. The arrow stays unless
// nav.hideArrowWithGuide is on; turning the option on or off while the guide is hidden takes effect at once.
const TRAVEL_AND_ARROW: &str = r#"
local P, Nav = Polestar.Nav.prompts, Polestar.Nav
stub.nav.items[6948] = 1
Nav.GetRoute = function() return { { kind = "hearth" }, { kind = "walk" } }, 1 end
local function shown()
	stub.runTimers()
	emit({ P.Wanted() ~= nil, P.button ~= nil and P.button:IsShown(), Nav.arrow.frame:IsShown() })
end
stub.nav.setWaypoint({ map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
Nav.Refresh()
shown()
Polestar.Set("ui.shown", false)
shown()
Polestar.Set("nav.hideArrowWithGuide", not Polestar.Get("nav.hideArrowWithGuide"))
shown()
Polestar.Set("nav.hideArrowWithGuide", not Polestar.Get("nav.hideArrowWithGuide"))
Polestar.Set("ui.shown", true)
shown()"#;

#[test]
fn hiding_the_guide_hides_the_travel_button_the_arrow_stays_unless_hide_the_arrow_with_the_guide_is_on() {
	let default = run_nav(TRAVEL_AND_ARROW);
	assert_eq!(
		default,
		vec![json!([true, true, true]), json!([false, false, true]), json!([false, false, false]), json!([true, true, true])],
		"by default the arrow stays with the guide hidden; the option turned on then hides it"
	);
	let on = run_nav(&format!("Polestar.Set(\"nav.hideArrowWithGuide\", true)\n{TRAVEL_AND_ARROW}"));
	assert_eq!(
		on,
		vec![json!([true, true, true]), json!([false, false, false]), json!([false, false, true]), json!([true, true, true])],
		"with the option on the arrow goes with the guide; turned off it comes back"
	);
}

#[test]
fn the_arrow_to_your_corpse_shows_with_the_guide_hidden_and_hide_the_arrow_with_the_guide_on() {
	let death = addons_dir().join("Polestar/QoL/Death.lua");
	let script = format!(
		r#"
		local Nav, C = Polestar.Nav, Polestar.Compat
		C.Readable = C.Readable or function(v) return v end
		C.GetContinentMap = C.GetContinentMap or function() return nil end
		-- The real death helper over a QoL with no Spirit Healers: the corpse is the way back.
		local state = {{}}
		Polestar.QoL = {{ On = function() return true end, State = function() return state end, data = {{ spiritHealers = {{}} }},
			Duration = function(s) return tostring(s) end }}
		assert(loadfile({}))("Polestar", Polestar)
		local ghost = false
		function UnitIsGhost(unit) return unit == "player" and ghost end
		C_DeathInfo = {{ GetCorpseMapPosition = function(map) if map == 9000 then return {{ x = 0.5, y = 0.2 }} end end }}
		local function arrow()
			stub.runTimers()
			local t = Nav.GetTarget()
			emit({{ t and t.label or false, Nav.arrow.frame:IsShown() }})
		end
		Polestar.Set("nav.hideArrowWithGuide", true)
		Polestar.Set("ui.shown", false)
		stub.nav.setWaypoint({{ map = 9000, x = 50, y = 80, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }})
		arrow()
		ghost = true
		stub.fire("PLAYER_ALIVE")
		arrow()
		stub.advance(1.1)
		arrow()
		ghost = false
		stub.fire("PLAYER_UNGHOST")
		arrow()"#,
		lua_string(&death.to_string_lossy())
	);
	let out = run_nav(&script);
	assert_eq!(
		out,
		vec![json!(["Somewhere", false]), json!(["Your corpse", true]), json!(["Your corpse", true]), json!(["Somewhere", false])],
		"the guide's arrow is hidden with the guide; the way back to the corpse shows, and goes once alive"
	);
}

#[test]
fn no_transport_alert_fires_while_the_guide_is_hidden_and_it_is_still_due_once_the_guide_is_back() {
	let out = run_nav(
		r#"
		local A = Polestar.Nav.alerts
		Polestar.Transit = { Now = function() return 0 end, Riding = function()
			return { kind = "boat", dock = "Menethil", route = "r", arriveIn = A.ON_BOARD - 1 }
		end }
		local alerts = 0
		Polestar.On("NAV_TRANSIT_ALERT", function() alerts = alerts + 1 end)
		Polestar.Set("ui.shown", false)
		A.Check()
		emit(alerts)
		Polestar.Set("ui.shown", true)
		emit(alerts)"#,
	);
	assert_eq!(out, vec![json!(0), json!(1)]);
}

#[test]
fn no_rare_alert_or_sound_fires_while_the_guide_is_hidden() {
	let run = |shown: bool| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_rares.lua"],
			addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Lookup/Lookup.xml", "Rares/Rares.xml"])],
			login: true,
			script: format!(
				r#"
				local got = 0
				Polestar.On("RARE_SPOTTED", function() got = got + 1 end)
				Polestar.Set("ui.shown", {shown})
				stub.rares.unit("nameplate1", {{ npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" }})
				stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
				emit({{ got, #stub.sounds }})
				Polestar.Rares.ShowSample() -- the options' test button works either way
				emit(got)"#
			),
			..Default::default()
		})
	};
	assert_eq!(run(true), vec![json!([1, 1]), json!(2)]);
	assert_eq!(run(false), vec![json!([0, 0]), json!(1)]);
}

#[test]
fn a_command_that_asks_for_the_arrow_says_so_only_while_the_guide_hides_the_arrow() {
	let run = |shown: bool, hide_arrow: bool| {
		run_nav(&format!(
			r#"
			local Nav = Polestar.Nav
			Polestar.Set("nav.hideArrowWithGuide", {hide_arrow})
			Polestar.Set("ui.shown", {shown})
			Nav.nearby.Find = function() return {{ name = "Innkeeper", map = 9000, x = 50, y = 20 }} end
			Polestar.Set("nav.answerTomTom", true)
			local function said(command)
				local before = #stub.messages
				command()
				local n = 0
				for i = before + 1, #stub.messages do
					if stub.messages[i]:find("/polestar show", 1, true) then n = n + 1 end
				end
				emit(n)
			end
			said(function() SlashCmdList.POLESTAR("arrow show") end)
			said(function() SlashCmdList.POLESTAR("arrow hide") end)
			said(function() SlashCmdList.POLESTAR("arrow") end)
			said(function() SlashCmdList.POLESTAR("way 50 20") end)
			said(function() SlashCmdList.POLESTAR("near inn") end)
			said(function() Nav.journey.Way("50 20") end)
			emit(Nav.GetTarget() ~= nil)"#
		))
	};
	let quiet = vec![json!(0), json!(0), json!(0), json!(0), json!(0), json!(0), json!(true)];
	assert_eq!(run(false, true), vec![json!(1), json!(0), json!(1), json!(1), json!(1), json!(1), json!(true)]);
	assert_eq!(run(false, false), quiet, "the arrow stays with the guide hidden: nothing to say");
	assert_eq!(run(true, true), quiet);
}
