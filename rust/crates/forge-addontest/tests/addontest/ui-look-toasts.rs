//! Alerts & toasts and Trackers (addon/Polestar/UI/Looks/Toasts.lua, UI/Looks/Trackers.lua): the player's scale,
//! opacity, type sizes, duration, entrance and stacking reach the real rare alert (Rares/Toast.lua), transport
//! banner (Nav/Alerts.lua), While you're here toast (UI/WhileHere.lua) and heads-up card (UI/ClassToast.lua); the
//! tracker settings reach the real flight timer (Maps/FlightTimer.lua), instance tracker (Maps/Instances.lua), party
//! panel (UI/PartyPanel.lua) and the guide's mark on the XP bar (QoL/XPMark.lua); the pages' previews are sandbox
//! copies of those builders that fire nothing, play no sound until Play is pressed, and run nothing while hidden.
//! The whole addon over stub_world.lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const HELPERS: &str = r#"
local UI, TS, TR = Polestar.UI, Polestar.UI.Toasts, Polestar.UI.Trackers
local function size(fs) local _, s = fs:GetFont(); return s end
local function r2(v) return math.floor(v * 100 + 0.5) / 100 end
local RARE = { kind = "rare", id = 61, name = "Thuros Lightfingers", level = 11, zone = "Elwynn Forest", yards = 70, map = 1429, x = 50, y = 50, source = "test" }
local HERE = { t = "kill", hereText = "Kill Kobold Vermin  8/10", yards = 50, step = 2, index = 1 }
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!("{HELPERS}\n{script}"),
		..Default::default()
	})
}

#[test]
fn scale_opacity_type_sizes_and_time_on_screen_reach_the_real_rare_alert_banner_and_while_here_toast() {
	let out = run(r#"
		-- The rare alert, as the player left it, then changed while it shows.
		Polestar.Rares.Toast.Show(RARE)
		stub.advance(1)
		local f = PolestarRareToast
		local before = { scale = r2(f:GetScale()), title = size(f.Name), body = size(f.Facts), alpha = r2(f:GetAlpha()), width = f:GetWidth() }
		Polestar.Set("toasts.rare.scale", 1.5)
		Polestar.Set("toasts.rare.alpha", 0.6)
		Polestar.Set("toasts.rare.titleSize", 1.4)
		Polestar.Set("toasts.rare.bodySize", 1.2)
		local after = { scale = r2(f:GetScale()), title = size(f.Name), body = size(f.Facts), alpha = r2(f:GetAlpha()), width = f:GetWidth() }
		emit({ before = before, after = after })

		-- Time on screen and the entrance: none appears at its opacity at once.
		Polestar.Rares.Toast.Hide()
		Polestar.Set("rares.toastSeconds", 5)
		Polestar.Set("toasts.rare.enter", "none")
		Polestar.Rares.Toast.Show(RARE)
		local at = { alpha = r2(f:GetAlpha()), sliding = Polestar.Anim.IsRunning(f, "offset") }
		stub.advance(4.5)
		local still = f:IsShown()
		stub.advance(1)
		emit({ at = at, still = still, gone = not f:IsShown() })

		-- The transport banner: its scale, and how long it stays after the arrival.
		local A = Polestar.Nav.alerts
		Polestar.Set("toasts.transport.scale", 1.3)
		Polestar.Set("toasts.transport.linger", 0)
		A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 3)
		local b = PolestarAlert
		local bscale = r2(b:GetScale())
		stub.advance(3.3)
		local lingerZero = b:IsShown()
		Polestar.Set("toasts.transport.linger", nil)
		A.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 3)
		stub.advance(5)
		local lingerDefault = b:IsShown()
		stub.advance(5)
		emit({ scale = bscale, lingerZero = lingerZero, lingerDefault = lingerDefault, goneAfter = not b:IsShown() })

		-- While you're here: its own time and size; larger type grows it.
		local W = UI.WhileHereToast
		Polestar.Set("toasts.whilehere.seconds", 3)
		Polestar.Set("toasts.whilehere.scale", 0.8)
		W.Show(HERE)
		local t = PolestarWhileHereToast
		local h0 = t:GetHeight()
		Polestar.Set("toasts.whilehere.titleSize", 1.6)
		Polestar.Set("toasts.whilehere.bodySize", 1.6)
		local h1 = t:GetHeight()
		stub.advance(2.5)
		local shown = t:IsShown()
		stub.advance(1)
		emit({ scale = r2(t:GetScale()), h0 = h0, h1 = h1, shown = shown, gone = not t:IsShown() })
	"#);
	let rare = &out[0];
	assert_eq!(rare["before"]["scale"], 1.0);
	assert_eq!(rare["before"]["alpha"], 1.0);
	assert_eq!(rare["after"]["scale"], 1.5, "{rare}");
	assert_eq!(rare["after"]["alpha"], 0.6, "{rare}");
	assert!(rare["after"]["title"].as_f64().unwrap() > rare["before"]["title"].as_f64().unwrap() * 1.3, "the name grows: {rare}");
	assert!(rare["after"]["body"].as_f64().unwrap() > rare["before"]["body"].as_f64().unwrap() * 1.1, "the facts grow: {rare}");
	assert!(rare["after"]["width"].as_f64().unwrap() >= rare["before"]["width"].as_f64().unwrap(), "the card widens for a longer name: {rare}");
	assert_eq!(out[1], json!({ "at": { "alpha": 0.6, "sliding": false }, "still": true, "gone": true }), "5 s, no entrance");
	assert_eq!(out[2], json!({ "scale": 1.3, "lingerZero": false, "lingerDefault": true, "goneAfter": true }), "0 s, then the 6 s default");
	let here = &out[3];
	assert_eq!(here["scale"], 0.8);
	assert!(here["h1"].as_f64().unwrap() > here["h0"].as_f64().unwrap(), "larger type grows the toast: {here}");
	assert_eq!(here["shown"], true);
	assert_eq!(here["gone"], true, "gone after 3 s: {here}");
}

#[test]
fn stacked_alerts_hang_one_under_the_other_spacing_apart_grow_up_when_asked_and_at_most_max_show() {
	let out = run(r#"
		Polestar.Set("toasts.stack", true)
		Polestar.Set("toasts.spacing", 12)
		Polestar.Rares.Toast.Show(RARE)
		Polestar.Nav.alerts.ShowBanner("Boat to Menethil Harbor", "Arrives in %s", 20)
		UI.WhileHereToast.Show(HERE)
		stub.advance(1)
		local function pt(f) local p, rel, rp, x, y = f:GetPoint(1); return { p, rel and (rel:GetName() or "?") or false, rp, r2(x), r2(y) } end
		emit({ PolestarRareToast:IsShown(), pt(PolestarRareToast), pt(PolestarAlert), pt(PolestarWhileHereToast) })
		Polestar.Set("toasts.growth", "up")
		emit({ pt(PolestarRareToast), pt(PolestarAlert) })
		Polestar.Set("toasts.max", 2)
		emit({ PolestarRareToast:IsShown(), #TS.Line() })
		Polestar.Set("toasts.stack", false)
		emit({ pt(PolestarAlert), #TS.Line() })
	"#);
	assert_eq!(out[0], json!([true, ["TOP", "PolestarToastLine", "TOP", 0, 0], ["TOP", "PolestarRareToast", "BOTTOM", 0, -12], ["TOP", "PolestarAlert", "BOTTOM", 0, -12]]));
	assert_eq!(out[1], json!([["BOTTOM", "PolestarToastLine", "BOTTOM", 0, 0], ["BOTTOM", "PolestarRareToast", "TOP", 0, 12]]));
	assert_eq!(out[2], json!([false, 2]), "the oldest (the rare alert) went");
	assert_eq!(out[3], json!([["TOP", "UIParent", "TOP", 0, -72], 0]), "back to its own place");
}

#[test]
fn the_heads_up_card_takes_its_scale_over_the_window_s_and_goes_by_itself_when_asked() {
	let out = run(r#"
		local CT = UI.ClassToast
		Polestar.Set("ui.shown", true)
		UI.GuideFrame.frame:Show()
		Polestar.Set("toasts.headsup.scale", 1.25)
		Polestar.Set("toasts.headsup.seconds", 10)
		local m = { head = "LEVEL 18 · DUNGEON", title = "The Deadmines is open to you", icon = "x", iconColor = "dungeon",
			act = { label = "Pick up the quests", run = function() end } }
		local shown = CT.ShowCard(m)
		local w = UI.GuideFrame.frame
		local k = r2(CT.frame:GetScale() / w:GetScale())
		local width = r2(CT.frame:GetWidth() * 1.25)
		stub.advance(9)
		local still = CT.frame:IsShown()
		stub.advance(2)
		emit({ shown = shown, k = k, width = width == r2(w:GetWidth()), still = still, gone = not CT.frame:IsShown(), current = CT.current ~= nil })
	"#);
	assert_eq!(out[0], json!({ "shown": true, "k": 1.25, "width": true, "still": true, "gone": true, "current": false }));
}

#[test]
fn tracker_settings_reach_the_real_flight_timer_instance_tracker_party_panel_and_xp_mark_and_fights_hide_them() {
	let out = run(r#"
		local ft, it = PolestarFlightTimer, PolestarInstanceTracker
		local before = { scale = r2(ft:GetScale()), width = ft:GetWidth(), bar = ft.Progress:GetHeight(), time = size(ft.Time) }
		Polestar.Set("trackers.flight.scale", 1.4)
		Polestar.Set("trackers.flight.width", 300)
		Polestar.Set("trackers.flight.barHeight", 6)
		Polestar.Set("trackers.flight.titleSize", 1.5)
		Polestar.Set("trackers.flight.barColor", { 1, 0, 0 })
		local r = { ft.Progress.Fill:GetVertexColor() }
		local after = { scale = r2(ft:GetScale()), width = ft:GetWidth(), bar = ft.Progress:GetHeight(), time = size(ft.Time), height = ft:GetHeight(), red = r2(r[1]) == 1 and r2(r[2]) == 0 }
		Polestar.Set("trackers.flight.format", "percent")
		local pct = Polestar.Maps.FlightTimeText("learned", 74, 0.62)
		Polestar.Set("trackers.flight.format", "both")
		local both = Polestar.Maps.FlightTimeText("estimate", 74, 0.62)
		emit({ before = before, after = after, pct = pct, both = both })

		Polestar.Set("trackers.instances.scale", 0.75)
		Polestar.Set("trackers.instances.width", 280)
		Polestar.Set("trackers.instances.alpha", 0.5)
		Polestar.Set("trackers.instances.combat", "fade")
		local calm = TR.Allowed("instances")
		stub.fire("PLAYER_REGEN_DISABLED")
		local faded = { TR.Allowed("instances"), r2(it:GetAlpha()) }
		Polestar.Set("trackers.instances.combat", "hide")
		local hidden = TR.Allowed("instances")
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ scale = r2(it:GetScale()), width = it:GetWidth(), calm = calm, faded = faded, hidden = hidden, after = TR.Allowed("instances"), alpha = r2(it:GetAlpha()) })

		-- The party panel's width reaches its rows; the XP mark's width, colour and label.
		local PP = UI.PartyPanel
		local p = PP.NewPanel(UIParent)
		Polestar.Set("trackers.party.width", 360)
		PP.FillRows(p, { { name = "Brogan", class = "WARRIOR", level = 22, xp = 12, step = "Step 39", needs = { { what = "Defias Bandana", cur = 6, max = 10 } } } })
		local Mk = Polestar.QoL.XPMark
		local bar = TS.NewStage(UIParent)
		bar:SetSize(300, 10)
		local m = Mk.NewDemo(bar)
		Polestar.Set("trackers.xp.tickWidth", 5)
		Polestar.Set("trackers.xp.label", false)
		Polestar.Set("trackers.xp.labelSize", 1.5)
		Mk.FillDemo(m, "Guide: 14 (2 levels)", nil)
		emit({ panel = p:GetWidth(), needs = p.rows[1].Needs:GetWidth(), tick = m.Tick:GetWidth(), label = m.Label:IsShown() })
	"#);
	let f = &out[0];
	assert_eq!(f["before"], json!({ "scale": 1, "width": 220, "bar": 2, "time": f["before"]["time"] }));
	assert_eq!(f["after"]["scale"], 1.4);
	assert_eq!(f["after"]["width"], 300.0);
	assert_eq!(f["after"]["bar"], 6.0);
	assert_eq!(f["after"]["red"], true, "{f}");
	assert!(f["after"]["time"].as_f64().unwrap() > f["before"]["time"].as_f64().unwrap() * 1.4, "{f}");
	assert!(f["after"]["height"].as_f64().unwrap() > 34.0, "the timer grows for larger type: {f}");
	assert_eq!(f["pct"], "62%");
	assert_eq!(f["both"], "~1:14  \u{b7}  62%");
	assert_eq!(out[1], json!({ "scale": 0.75, "width": 280, "calm": true, "faded": ["fade", 0.18], "hidden": false, "after": true, "alpha": 0.5 }));
	assert_eq!(out[2], json!({ "panel": 360, "needs": 340, "tick": 5, "label": false }));
}

#[test]
fn previews_are_sandbox_copies_that_fire_nothing_play_sound_only_on_play_and_run_nothing_while_hidden() {
	let out = run(r#"
		Polestar.Set("rares.sound", true)
		local fired = 0
		Polestar.On("RARE_SPOTTED", function() fired = fired + 1 end)
		-- A frame of Polestar's, as the options window is (the stub refuses addon frames under the test's own).
		local host = TS.NewStage(UIParent)
		host:SetSize(700, 400)
		local stages, heights = {}, {}
		for _, tab in ipairs({ "rare", "transport", "whilehere", "headsup", "classcard", "line" }) do
			local s = TS.Preview(host, tab)
			heights[#heights + 1] = s:Layout(640)
			stages[tab] = s
		end
		for _, tab in ipairs({ "flight", "instances", "party", "xp" }) do
			local s = TR.Preview(host, tab)
			heights[#heights + 1] = s:Layout(640)
			stages[tab] = s
		end
		local rare = stages.rare.Card
		local live = {
			sandbox = rare ~= PolestarRareToast and rare:GetName() == nil,
			name = rare.Name:GetText(),
			banner = stages.transport.Card:GetName() == nil and stages.transport.Card.Title:GetText(),
			here = stages.whilehere.Card.Text:GetText(),
			heads = stages.headsup.Card.Title:GetText(),
			card = stages.classcard.Card.Title:GetText(),
			flight = stages.flight.Tracker.Dest:GetText(),
			instances = stages.instances.Tracker.Count:GetText(),
			party = stages.party.Tracker.rows[2] and stages.party.Tracker.rows[2].Step:GetText() or false,
		}
		emit({ heights = heights, live = live, sounds = #stub.sounds, fired = fired, target = Polestar.Nav.GetTarget() ~= nil })

		-- A bigger rare alert: the preview shows it shrunk to fit and says so.
		Polestar.Set("toasts.rare.scale", 2)
		emit({ fit = r2(rare:GetScale()) < 2, note = stages.rare.caption() })

		-- Play: the entrance again and the sound (it is on).
		stages.rare.Play:Click()
		emit({ sounds = #stub.sounds, entering = Polestar.Anim.IsRunning(rare, "alpha") })

		-- Hidden: nothing ticks, and a change waits for the preview to show again.
		stub.advance(1)
		for _, s in pairs(stages) do s:Hide() end
		local updates = 0
		for _, s in pairs(stages) do
			if s:GetScript("OnUpdate") then updates = updates + 1 end
			local list = { unpack(rawget(s, "Cards") or {}) }
			list[#list + 1] = rawget(s, "Card")
			list[#list + 1] = rawget(s, "Tracker")
			for _, c in pairs(list) do
				if c:GetScript("OnUpdate") then updates = updates + 1 end
			end
		end
		Polestar.Set("toasts.rare.alpha", 0.5)
		local waiting = r2(rare:GetAlpha())
		stages.rare:Show()
		emit({ updates = updates, anim = Polestar.Anim.Active(), waiting = waiting, shown = r2(rare:GetAlpha()) })
	"#);
	let first = &out[0];
	assert!(first["heights"].as_array().unwrap().iter().all(|h| h.as_f64().unwrap() > 100.0), "{first}");
	assert_eq!(
		first["live"],
		json!({
			"sandbox": true, "name": "Thuros Lightfingers", "banner": "Boat to Menethil Harbor", "here": "Kill Kobold Vermin  8/10  \u{b7}  50 yd",
			"heads": "The Deadmines is open to you", "card": "The Binding", "flight": "Sentinel Hill", "instances": "3/5 this hour", "party": "Step 39"
		})
	);
	assert_eq!(first["sounds"], 0, "no sound while previewing");
	assert_eq!(first["fired"], 0, "no rare event");
	assert_eq!(first["target"], false, "no waypoint");
	assert_eq!(out[1]["fit"], true);
	assert!(out[1]["note"].as_str().unwrap().starts_with("Shown at "), "{}", out[1]);
	assert_eq!(out[2], json!({ "sounds": 1, "entering": true }));
	assert_eq!(out[3], json!({ "updates": 0, "anim": 0, "waiting": 1, "shown": 0.5 }));
}

#[test]
fn the_look_pages_list_their_tabs_and_the_settings_they_hold() {
	let out = run(r#"
		local O = UI.Options
		local pages = {}
		for _, p in ipairs(O.Pages()) do if p.key == "alerts" or p.key == "trackers" then pages[p.key] = p.tabs end end
		emit(pages)
	"#);
	assert_eq!(
		out[0],
		json!({
			"alerts": ["Rare alert", "Transport alert", "While you're here", "Heads-up card", "Class quest card", "Stacking"],
			"trackers": ["Flight timer", "Instance tracker", "Party panel", "XP bar", "Journey"]
		})
	);
}
