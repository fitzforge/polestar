//! Alerts & toasts and Trackers (addon/Polestar/UI/Toasts.lua, UI/Trackers.lua; their pages and previews in Polestar_Options/UI/Looks/): the player's scale,
//! opacity, type sizes, duration, entrance and stacking reach the real rare alert (Rares/Toast.lua), transport
//! banner (Nav/Alerts.lua) and heads-up card (UI/ClassToast.lua); the While you're here toast (UI/WhileHere.lua) keeps
//! only its time and place, in the theme's look; the
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
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: format!("Polestar.UI.LoadOptions()\n{HELPERS}\n{script}"), ..Default::default() })
}

#[test]
fn scale_opacity_type_sizes_and_time_on_screen_reach_the_real_rare_alert_and_banner_while_here_keeps_only_its_time() {
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

		-- While you're here: its own time; no look of its own (a value its old tab saved is not read).
		local W = UI.WhileHereToast
		Polestar.Set("toasts.whilehere.seconds", 3)
		Polestar.Set("toasts.whilehere.scale", 0.8)
		Polestar.Set("toasts.whilehere.alpha", 0.5)
		W.Show(HERE)
		local t = PolestarWhileHereToast
		-- Its header as shown: the house look's band over the card.
		local head = ((t.psHouse and t.psHouse:IsShown()) and t.psHouse or t).Head
		local s0 = size(head)
		Polestar.Set("toasts.whilehere.titleSize", 1.6)
		stub.advance(0.5)
		local s1, alpha = size(head), r2(t:GetAlpha())
		stub.advance(2)
		local shown = t:IsShown()
		stub.advance(1)
		emit({ scale = r2(t:GetScale()), same = s0 == s1, alpha = alpha, shown = shown, gone = not t:IsShown() })
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
	assert_eq!(here, &json!({ "scale": 1, "same": true, "alpha": 1, "shown": true, "gone": true }), "3 s, the shared look: {here}");
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
		-- A frame of Polestar's for the bar (the stub refuses addon frames under the test's own).
		local bar = UI.Preview.Band(UIParent)
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
	assert_eq!(f["both"], "≈1:14  \u{b7}  62%");
	assert_eq!(out[1], json!({ "scale": 0.75, "width": 280, "calm": true, "faded": ["fade", 0.18], "hidden": false, "after": true, "alpha": 0.5 }));
	assert_eq!(out[2], json!({ "panel": 360, "needs": 340, "tick": 5, "label": false }));
}

#[test]
fn previews_are_sandbox_copies_that_fire_nothing_play_sound_only_on_play_and_run_nothing_while_hidden() {
	let out = run(r#"
		Polestar.Set("rares.sound", true)
		local fired = 0
		Polestar.On("RARE_SPOTTED", function() fired = fired + 1 end)
		-- The bands on UIParent (the stub refuses addon frames under the test's own).
		local host = UIParent
		local stages, heights = {}, {}
		-- Each band's height against what its parts make (UI/Preview.lua's band): 20 + the element at its fit + [Play
		-- under it on a band too narrow] + [its labels] + [the hint line] + 20, a dropdown 28 + 14 over it on a tab
		-- with one.
		local P = UI.Preview
		local function band(s)
			local h = s:Layout(640)
			local _, eh, _, labels = s:Content(640)
			local play = rawget(s, "Play")
			local under = play and play:IsShown() and (play:GetPoint(1)) == "TOPRIGHT"
			local want = 2 * P.BAND_PAD + (rawget(s, "Picker") and P.PICKER_H + P.PICKER_GAP or 0) + (eh or 0) * s.psFit
				+ (under and P.PLAY_UNDER + P.PLAY_H or 0) + (labels and P.LINE_GAP + P.LINE_H or 0) + (s.Hint:IsShown() and P.LINE_GAP + P.LINE_H or 0)
			s:Layout(640)
			return { h = h, want = want, element = (eh or 0) > 0 }
		end
		for _, tab in ipairs({ "rare", "transport", "headsup", "classcard" }) do
			local s = TS.Preview(host, tab)
			heights[#heights + 1] = band(s)
			stages[tab] = s
		end
		for _, tab in ipairs({ "flight", "instances", "party" }) do
			local s = TR.Preview(host, tab)
			heights[#heights + 1] = band(s)
			stages[tab] = s
		end
		local rare = stages.rare.Card
		local live = {
			sandbox = rare ~= PolestarRareToast and rare:GetName() == nil,
			name = rare.Name:GetText(),
			banner = stages.transport.Card:GetName() == nil and stages.transport.Card.Title:GetText(),
			heads = stages.headsup.Card.Title:GetText(),
			card = stages.classcard.Card.Title:GetText(),
			flight = stages.flight.Tracker.Dest:GetText(),
			instances = stages.instances.Tracker.Count:GetText(),
			party = stages.party.Tracker.rows[2] and stages.party.Tracker.rows[2].Step:GetText() or false,
			xp = stages.instances.XP.mark.Label:GetText(),
		}
		-- Its parts lead to their settings' rows.
		local hots = {}
		for _, tab in ipairs({ "rare", "classcard", "flight", "instances" }) do
			for key in pairs(rawget(stages[tab], "Hots") or {}) do hots[#hots + 1] = key end
		end
		table.sort(hots)
		live.hots = hots
		emit({ heights = heights, live = live, sounds = #stub.sounds, fired = fired, target = Polestar.Nav.GetTarget() ~= nil })

		-- A bigger rare alert: the band shows it shrunk to fit and its hint line says so.
		Polestar.Set("toasts.rare.scale", 2)
		stages.rare:Layout(640, 400)
		emit({ fit = r2(rare:GetScale()) < 2, note = stages.rare.Hint:IsShown() and stages.rare.Hint:GetText() or "" })

		-- Play: on the four single tabs, not on Essentials; its foot on the card's, right of it. A click: the
		-- entrance again, and the sound only while it is on.
		local plays = {}
		for _, tab in ipairs({ "rare", "transport", "headsup", "classcard" }) do plays[tab] = rawget(stages[tab], "Play") ~= nil end
		plays.essentials = rawget(TS.Preview(host, "all"), "Play") ~= nil
		local pp, _, prp = stages.transport.Play:GetPoint(1)
		stages.rare.Play:Click()
		local on = #stub.sounds
		Polestar.Set("rares.sound", false)
		stages.rare.Play:Click()
		emit({ sounds = on, quiet = #stub.sounds, entering = Polestar.Anim.IsRunning(rare, "alpha"), plays = plays, foot = { pp, prp } })
		Polestar.Set("rares.sound", true)

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
	for b in first["heights"].as_array().unwrap() {
		let (h, want) = (b["h"].as_f64().unwrap(), b["want"].as_f64().unwrap());
		assert!(b["element"] == true && (h - want).abs() <= 1.0, "a band as tall as its element and its parts: {b} in {first}");
	}
	assert_eq!(
		first["live"],
		json!({
			"sandbox": true, "name": "Thuros Lightfingers", "banner": "Boat to Menethil Harbor",
			"heads": "The Deadmines is open to you", "card": "The Binding", "flight": "Sentinel Hill", "instances": "3/5 this hour", "party": "Step 39",
			"xp": "Guide: 14 (2 levels)",
			"hots": [
				"toasts.classcard.bodySize", "toasts.classcard.glow", "toasts.classcard.stripe", "toasts.classcard.titleSize",
				"toasts.rare.bodySize", "toasts.rare.scale", "toasts.rare.titleSize",
				"trackers.flight.barHeight", "trackers.flight.bodySize", "trackers.flight.scale", "trackers.flight.titleSize",
				"trackers.instances.bodySize", "trackers.instances.scale", "trackers.instances.titleSize",
				"trackers.xp.labelSize", "trackers.xp.tickWidth"
			]
		})
	);
	assert_eq!(first["sounds"], 0, "no sound while previewing");
	assert_eq!(first["fired"], 0, "no rare event");
	assert_eq!(first["target"], false, "no waypoint");
	assert_eq!(out[1]["fit"], true);
	assert!(out[1]["note"].as_str().unwrap().starts_with("Shown at "), "{}", out[1]);
	assert_eq!(
		out[2],
		json!({ "sounds": 1, "quiet": 1, "entering": true,
		"plays": { "rare": true, "transport": true, "headsup": true, "classcard": true, "essentials": false }, "foot": ["BOTTOMLEFT", "TOPLEFT"] })
	);
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
			"alerts": ["Essentials", "Rare alert", "Transport alert", "Heads-up card", "Class quest card"],
			"trackers": ["Essentials", "Travel", "Instances & XP", "Party panel"]
		})
	);
}

// Layout v2: each section is one element; its on/off sits in its header; a colour rides on its slider's row and
// secondary knobs behind the cog; row labels are short; every control, extra and cog row keeps its tooltip
// (help), its search words and its "New" mark; and nothing a player could set before is gone from the pages
// (0.3.8: the While you're here toast's look went; its switches are on Guide > Window's Dynamic Questing).
#[test]
fn the_look_pages_put_switches_in_section_headers_colours_beside_their_sliders_and_keep_every_setting() {
	let out = run(r#"
		local toggles, extras, more, missing, long, keys, thin, crowded, count = {}, {}, {}, {}, {}, {}, {}, {}, {}
		local function check(c, row)
			if c.key then keys[c.key] = true end
			if not (c.help and c.help ~= "") or not (c.search and c.search ~= "") then missing[#missing + 1] = c.key or c.label end
			if row and select(2, c.label:gsub("%S+", "")) > 3 then long[#long + 1] = c.label end
		end
		-- The deep tabs' registrations (Essentials stands for their rows: settings-essentials.rs).
		Polestar.Widgets.OnOptionsRegistered(function(spec)
			if (spec.key ~= "alerts" and spec.key ~= "trackers") or spec.tab == "Essentials" then return end
			local where = spec.key .. "/" .. spec.tab .. "/" .. spec.section
			if spec.toggle then
				toggles[where] = spec.toggle.key
				check(spec.toggle, false)
			end
			count[where] = (count[where] or 0) + #(spec.controls or {})
			for _, c in ipairs(spec.controls or {}) do
				check(c, true)
				local switches, swatches = 0, 0
				for _, e in ipairs(c.extras or {}) do
					if e.kind == "toggle" then switches = switches + 1 else swatches = swatches + 1 end
				end
				if switches > 1 or swatches > 1 then crowded[#crowded + 1] = c.key end
				for _, e in ipairs(c.extras or {}) do extras[c.key] = e.key; check(e, false) end
				for _, m in ipairs(c.more or {}) do more[c.key] = m.key; check(m, false) end
			end
		end)
		-- Two halves a row: a section of fewer than three controls is one row.
		for where, n in pairs(count) do if n < 3 then thin[#thin + 1] = where end end
		local all = {}
		for k in pairs(keys) do all[#all + 1] = k end
		table.sort(all)
		emit({ toggles = toggles, extras = extras, more = more, missing = table.concat(missing, ", "), long = table.concat(long, ", "), keys = all,
			thin = table.concat(thin, ", "), crowded = table.concat(crowded, ", ") })
	"#);
	let o = &out[0];
	assert_eq!(o["missing"], "", "every control has help (its tooltip) and search words");
	assert_eq!(o["long"], "", "row labels are one to three words");
	assert_eq!(o["thin"], "", "no section of one row");
	assert_eq!(o["crowded"], "", "at most one switch and one swatch beside a control");
	assert_eq!(
		o["toggles"],
		json!({
			"alerts/Rare alert/Rare alert": "rares.alerts",
			"alerts/Transport alert/Transport alert": "nav.alerts",
			"trackers/Travel/Flight timer": "maps.flightTimer",
			"trackers/Instances & XP/Instance tracker": "maps.instances",
			"trackers/Party panel/Party panel": "party.panel"
		})
	);
	assert_eq!(o["extras"]["toasts.rare.bgAlpha"], "toasts.rare.bg");
	assert_eq!(o["extras"]["toasts.rare.borderSize"], "toasts.rare.border");
	assert_eq!(o["extras"]["rares.soundKit"], "rares.sound");
	assert_eq!(o["extras"]["trackers.flight.barHeight"], "trackers.flight.barColor");
	assert_eq!(o["extras"]["trackers.xp.tickWidth"], "trackers.xp.tickColor");
	assert_eq!(o["more"]["toasts.stack"], "toasts.max");
	assert_eq!(o["more"]["trackers.flight.titleSize"], "trackers.flight.format", "the time's outline and format behind its size's cog");
	assert_eq!(o["more"]["trackers.xp.labelSize"], "trackers.xp.outline");
	let keys: Vec<&str> = o["keys"].as_array().unwrap().iter().map(|k| k.as_str().unwrap()).collect();
	for kind in ["rare", "transport", "headsup"] {
		for prop in ["scale", "alpha", "bgAlpha", "bg", "border", "borderSize", "enter", "speed", "titleSize", "bodySize"] {
			let key = format!("toasts.{kind}.{prop}");
			assert!(keys.contains(&key.as_str()), "{key} is on the page");
		}
	}
	for prop in ["scale", "alpha", "bgAlpha", "bg", "border", "borderSize", "enter", "speed", "titleSize", "bodySize", "accent", "seconds"] {
		let key = format!("toasts.whilehere.{prop}");
		assert!(!keys.contains(&key.as_str()), "{key} is not on the page");
	}
	for kind in ["flight", "instances", "party"] {
		for prop in ["scale", "width", "alpha", "bgAlpha", "bg", "border", "borderSize", "titleSize", "bodySize", "outline"] {
			let key = format!("trackers.{kind}.{prop}");
			assert!(keys.contains(&key.as_str()), "{key} is on the page");
		}
	}
	// What a tracker does in a fight and inside an instance; the flight timer has neither: it shows only on a flight
	// path, never in a fight or inside an instance.
	for prop in ["combat", "instance"] {
		for kind in ["instances", "party"] {
			let key = format!("trackers.{kind}.{prop}");
			assert!(keys.contains(&key.as_str()), "{key} is on the page");
		}
		let key = format!("trackers.flight.{prop}");
		assert!(!keys.contains(&key.as_str()), "{key} is not on the page");
	}
	for key in [
		"rares.toastSeconds",
		"rares.treasureAlerts",
		"rares.combatAlerts",
		"nav.alertBanner",
		"nav.alertSound",
		"nav.alertFlash",
		"toasts.transport.linger",
		"toasts.headsup.seconds",
		"dungeons.headsUp",
		"ui.classCardSound",
		"toasts.classcard.glow",
		"toasts.classcard.stripe",
		"toasts.classcard.shine",
		"toasts.classcard.note",
		"toasts.classcard.titleSize",
		"toasts.classcard.bodySize",
		"toasts.growth",
		"toasts.spacing",
		"toasts.max",
		"trackers.flight.barHeight",
		"trackers.flight.format",
		"maps.instanceDisplay",
		"trackers.xp.label",
		"trackers.journey.rows",
		"trackers.journey.numbers",
	] {
		assert!(keys.contains(&key), "{key} is on the page");
	}
}

// The window's own widgets on the page: the header switch turns rare alerts off, the inline swatch is its own
// setting (right-click resets it), and the entrance row's cog opens its speed.
#[test]
fn on_the_rare_alert_tab_the_header_switch_the_inline_swatch_and_the_cog_are_the_settings_they_name() {
	let out = run(r#"
		local O = UI.Options
		UI.ShowOptions("alerts")
		O.Select("alerts", "Rare alert")
		local c = O.Controls("alerts", "Rare alert")
		local found = { header = c["rares.alerts"] ~= nil, swatch = c["toasts.rare.bg"] ~= nil, slider = c["toasts.rare.bgAlpha"] ~= nil }
		c["rares.alerts"]:Click()
		local off = Polestar.Get("rares.alerts")
		c["rares.alerts"]:Click()
		Polestar.Set("toasts.rare.bg", { 0.2, 0.1, 0.3 })
		c["toasts.rare.bg"]:Click("RightButton")
		local bg = Polestar.Get("toasts.rare.bg")
		c["toasts.stack"].Cog:Click()
		local more = O.MoreControls()
		emit({ found = found, off = off, on = Polestar.Get("rares.alerts"), bg = bg, speed = more["toasts.spacing"] ~= nil })
	"#);
	assert_eq!(out[0], json!({ "found": { "header": true, "swatch": true, "slider": true }, "off": false, "on": true, "bg": false, "speed": true }));
}
