//! The settings window's live previews (addon/Polestar_Options/UI/Preview.lua): every Look tab's preview is a band,
//! the element the tab sets, alone, at its real size, only as tall as it, its one hint line and no chrome; laid out
//! again at once on its settings while it shows and on its next show else, never cut off (smaller past its room, and
//! saying so), its parts on whole pixels. A registered page's own frame keeps its contract: shown whole and smaller
//! past its room, its caption the one line under it. The whole addon over stub_world.lua, the settings window open.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const HELPERS: &str = r#"
local UI = Polestar.UI
Polestar.Fire("SHOW_OPTIONS")
stub.advance(0.5)
-- Both are the settings' addon's: there once the window has opened.
local P, O = UI.Preview, UI.Options
-- The frame the preview on screen draws (its host's), after a page and tab are selected.
local function shown(key, tab)
	O.Select(key, tab)
	stub.advance(0.1)
	local host = O.view and rawget(O.view, "PreviewHost")
	return host and host:IsShown() and host.Frame or nil, host
end
-- Every Look page's tabs, { page key, tab }.
local function lookTabs()
	local list = {}
	for _, p in ipairs(O.Pages()) do
		if p.group == "look" then
			for _, tab in ipairs(p.tabs) do list[#list + 1] = { p.key, tab } end
		end
	end
	return list
end
"#;

fn run_script(script: String) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script, ..Default::default() }).remove(0)
}

fn run(script: &str) -> Value {
	run_script(format!("{HELPERS}\n{script}"))
}

// Coverage: every tab of every Look page shows a band, and no tab anywhere shows a preview of another kind; the Look
// pages are the ones with a preview.
#[test]
fn every_look_tab_s_preview_is_a_band() {
	let out = run(r#"
		local pages, missing, others = {}, {}, {}
		for _, p in ipairs(O.Pages()) do
			for _, tab in ipairs(p.tabs) do
				local f = shown(p.key, tab)
				local where = p.key .. "/" .. tab
				if f and P.IsBand(f) and p.group == "look" then
					pages[p.key] = true
				elseif f then
					others[#others + 1] = where
				elseif p.group == "look" then
					missing[#missing + 1] = where
				end
			end
		end
		local keys = {}
		for k in pairs(pages) do keys[#keys + 1] = k end
		table.sort(keys)
		emit({ pages = keys, missing = table.concat(missing, ", "), others = table.concat(others, ", ") })"#);
	assert_eq!(out["missing"], "", "a Look tab without a band");
	assert_eq!(out["others"], "", "a preview that is not a Look tab's band");
	assert_eq!(out["pages"], json!(["alerts", "arrow", "buttons", "guidewindow", "mappins", "routelines", "theme", "trackers"]));
}

// No chrome over a band: on no Look tab a "Preview" label, a Live mark or a backdrop chip. The old stage's backdrop
// pick (PolestarDB.optionsBackdrop, never a setting) is cleared the first time the window opens.
#[test]
fn no_look_tab_has_a_preview_label_a_live_mark_or_a_backdrop_chip_and_the_old_backdrop_pick_is_cleared() {
	let out = run_script(format!(
		"PolestarDB.optionsBackdrop = \"sky\"\n{HELPERS}\n{}",
		r#"
		local chrome, words = {}, {}
		for _, at in ipairs(lookTabs()) do
			local f, host = shown(at[1], at[2])
			for _, k in ipairs({ "Chrome", "Backdrop", "Live", "Label", "Caption", "Foot" }) do
				if rawget(host, k) ~= nil then chrome[#chrome + 1] = at[1] .. "/" .. at[2] .. ": " .. k end
			end
			for _, fr in ipairs({ host, f }) do
				for _, r in ipairs({ fr:GetRegions() }) do
					local t = r.GetText and r:IsShown() and r:GetText()
					if t == "Preview" or t == "Live" then words[#words + 1] = at[1] .. "/" .. at[2] .. ": " .. t end
				end
			end
		end
		emit({ chrome = table.concat(chrome, ", "), words = table.concat(words, ", "), backdrop = PolestarDB.optionsBackdrop == nil })"#
	));
	assert_eq!(out, json!({ "chrome": "", "words": "", "backdrop": true }));
}

// The Guide window band is the one that crops: with Up next on, the window is taller than the band's room, so it is
// cut there and fades out into the band's ground at its foot; scrolled to the part a hovered row edits, at the
// window's end nothing is cut and nothing fades.
#[test]
fn the_guide_window_band_crops_a_window_taller_than_its_room_and_fades_it_out_at_its_foot() {
	let out = run(r#"
		Polestar.Set("ui.upcoming", 3)
		local gw = shown("guidewindow")
		gw:Focus("guideWindow.tabHeight")
		local top = gw.Scene.Fade:IsShown()
		gw:Focus("guideWindow.progressHeight")
		emit({ band = P.IsBand(gw), top = top, foot = gw.Scene.Fade:IsShown() })"#);
	assert_eq!(out, json!({ "band": true, "top": true, "foot": false }));
}

// Every band is as tall as its element and its parts: 20 + [the dropdown 28 + 14] + the element at its fit + [Play
// under it, 8 + 22, on a band too narrow to hang it beside] + [its labels 10 + 15] + [the hint line 10 + 15] + 20,
// never over 55% of the body, and the slot is the band's height. Every element is at its real size where it fits
// (Theme's three, side by side, are the one too wide for the default window).
#[test]
fn every_band_is_as_tall_as_its_element_and_its_parts_and_never_over_55_percent() {
	let out = run(r#"
		local out, win = {}, PolestarOptions
		local room = win:GetHeight() - 112 - 40 - 56
		for _, at in ipairs(lookTabs()) do
			local f, host = shown(at[1], at[2])
			local _, h, _, labels = f:Content(f.psWidth)
			local play = rawget(f, "Play")
			local under = play and play:IsShown() and (play:GetPoint(1)) == "TOPRIGHT"
			local want = 2 * P.BAND_PAD + (rawget(f, "Picker") and P.PICKER_H + P.PICKER_GAP or 0) + (h or 0) * (f.psFit or 1)
				+ (under and P.PLAY_UNDER + P.PLAY_H or 0) + (labels and P.LINE_GAP + P.LINE_H or 0) + (f.Hint:IsShown() and P.LINE_GAP + P.LINE_H or 0)
			f:Layout(f.psWidth, f.psRoom)
			out[#out + 1] = { at = at[1] .. "/" .. at[2], h = f:GetHeight(), want = want, slot = host:GetHeight(), cap = math.floor(room * 0.55), fit = f.psFit }
		end
		emit(out)"#);
	let bands = out.as_array().unwrap();
	assert!(bands.len() >= 25, "every Look tab: {out}");
	for b in bands {
		let (at, h, want) = (b["at"].as_str().unwrap(), b["h"].as_f64().unwrap(), b["want"].as_f64().unwrap());
		assert!((h - want).abs() <= 1.0, "{at}: {h} tall, its parts make {want}: {b}");
		assert!((b["slot"].as_f64().unwrap() - h).abs() <= 0.5, "{at}: the slot is the band's height: {b}");
		assert!(h <= b["cap"].as_f64().unwrap() + 0.5, "{at}: within 55% of the body: {b}");
		if !at.starts_with("theme/") || at == "theme/Names" {
			assert_eq!(b["fit"], 1, "{at}: at its real size where it fits: {b}");
		}
	}
}

// Every band holds its element alone (no mob of a world, no zone painting but the map pins' and route lines' maps),
// at its real size (an alert: the game's UI scale times its own scale setting), centred within 1 px; the band's own
// strings (its hint, labels, dropdown and Play) 12 px or larger.
#[test]
fn a_band_holds_its_element_alone_at_its_real_size_centred_its_strings_12_px_or_larger() {
	let out = run(r#"
		local out = {}
		local function walk(fr, seen)
			for _, c in ipairs({ fr:GetChildren() }) do
				if rawget(c, "Stand") and rawget(c, "Tint") then seen.mob = true end
				if rawget(c, "Canvas") and rawget(c, "Over") then seen.art = true end
				walk(c, seen)
			end
		end
		local function small(f)
			local list = {}
			for _, r in ipairs({ f:GetRegions() }) do if r.GetFont then list[#list + 1] = r end end
			if rawget(f, "Picker") then list[#list + 1] = f.Picker.Label end
			if rawget(f, "Play") then list[#list + 1] = f.Play.Label end
			local n = 0
			for _, fs in ipairs(list) do
				local _, s = fs:GetFont()
				if fs:IsShown() and (fs:GetText() or "") ~= "" and (s or 0) < 12 then n = n + 1 end
			end
			return n
		end
		local ALERT = { ["alerts/Rare alert"] = "rare", ["alerts/Transport alert"] = "transport" }
		for _, at in ipairs(lookTabs()) do
			local where = at[1] .. "/" .. at[2]
			local f = shown(at[1], at[2])
			local seen = {}
			walk(f, seen)
			local o = { mob = seen.mob or false, art = seen.art or false, small = small(f) }
			local kind = ALERT[where]
			if kind then
				local c = f.Card
				local _, _, _, x = c:GetPoint(1)
				local g = c:GetScale()
				o.scale = math.abs(g - Polestar.UI.Toasts.Scale(kind) * P.TrueScale(f)) < 1e-6
				o.centred = math.abs(x * g * 2 + c:GetWidth() * g - f:GetWidth()) <= 2
			end
			out[where] = o
		end
		emit(out)"#);
	let all = out.as_object().unwrap();
	assert!(all.len() >= 25, "every Look tab: {out}");
	for (k, o) in all {
		assert_eq!(o["mob"], false, "{k}: no mob");
		if !k.starts_with("mappins/") && !k.starts_with("routelines/") {
			assert_eq!(o["art"], false, "{k}: no zone painting but the map pins' and route lines' maps");
		}
		assert_eq!(o["small"], 0, "{k}: the band's strings 12 px or larger");
		if o.get("scale").is_some() {
			assert_eq!(o["scale"], true, "{k}: the UI scale times its own: {o}");
			assert_eq!(o["centred"], true, "{k}: centred: {o}");
		}
	}
}

// Theme at the default window (1300 x 946): its three are too wide for the band at their real size, so all three
// are drawn alike at 84-86% and the hint line says so, the cards on whole pixels; in a window wide enough, at their
// real size, no fit note.
#[test]
fn theme_s_three_fit_the_default_window_at_about_85_percent_and_say_so_and_a_wide_one_draws_them_whole() {
	let out = run(r#"
		local function whole(fr)
			local _, _, _, x, y = fr:GetPoint(1)
			return x == math.floor(x) and y == math.floor(y)
		end
		local f = shown("theme", "Essentials")
		local default = { fit = f.psFit, hint = f.Hint:IsShown() and f.Hint:GetText() or false, whole = whole(f.Heads) and whole(f.Toast) }
		Polestar.Set("ui.optionsSize", { 1800, 946 })
		stub.advance(0.2)
		O.Relayout()
		f = shown("theme", "Essentials")
		emit({ default = default, wide = { fit = f.psFit, note = f.Hint:IsShown() and f.Hint:GetText():find("to fit", 1, true) ~= nil } })"#);
	let fit = out["default"]["fit"].as_f64().unwrap();
	assert!((0.84..=0.86).contains(&fit), "{out}");
	assert_eq!(out["default"]["hint"], json!(format!("Shown at {}% to fit", (fit * 100.0).round() as i64)));
	assert_eq!(out["default"]["whole"], true, "on whole pixels: {out}");
	assert_eq!(out["wide"], json!({ "fit": 1, "note": false }), "{out}");
}

// The pointer on a setting's row lights the parts of the preview it changes: every hotspot of that setting and
// every part the page lights for it (f:Light, its frame made the first time it lights), an accent outline and
// wash; the others stay dark, and off the row the lights go out.
#[test]
fn hovering_a_row_lights_the_parts_of_the_preview_its_setting_changes_and_leaving_puts_them_out() {
	let out = run(r#"
		local f, host = shown("arrow", "Look")
		local rows = O.Controls("arrow", "Look")
		local function lit(key)
			local n = 0
			for _, b in ipairs(host.psByKey[key] or {}) do
				local l = rawget(b, "psRegion") and rawget(b, "Frame") or b
				if rawget(l, "psLit") and l.Wash and l.Wash:IsShown() then n = n + 1 end
			end
			return n
		end
		stub.RunScript(rows["nav.arrowScale"], "OnEnter")
		local on = { scale = lit("nav.arrowScale"), ring = lit("nav.arrowRingColor") }
		stub.RunScript(rows["nav.arrowScale"], "OnLeave")
		local off = lit("nav.arrowScale")
		stub.RunScript(rows["nav.arrowAlpha"], "OnEnter")
		local before = lit("nav.arrowAlpha")
		stub.RunScript(rows["nav.arrowAlpha"], "OnLeave")
		local own = f:Light("nav.arrowAlpha", f.Dials[1].holder)
		stub.RunScript(rows["nav.arrowAlpha"], "OnEnter")
		emit({ on = on, off = off, before = before, own = lit("nav.arrowAlpha"), made = #own,
			ownLit = own[1] and own[1].Frame ~= nil and own[1].Frame.psLit == true })"#);
	assert!(out["on"]["scale"].as_i64().unwrap() >= 1, "the setting's part lit: {}", out["on"]);
	assert_eq!(out["on"]["ring"], 0, "another setting's part stays dark");
	assert_eq!(out["off"], 0, "off the row the lights go out");
	assert_eq!(out["made"], 1);
	assert_eq!(out["own"].as_i64().unwrap(), out["before"].as_i64().unwrap() + 1, "a part the page lights for a setting: {out}");
	assert_eq!(out["ownLit"], true);
}

// Every setting on a Look page shows what it changes: the pointer on its row (or on the switch or swatch beside it)
// lights at least one part of that tab's preview, a hotspot or a part the page lights for it (f:Light). Exempt: the
// game menu's button, which lives in the game's own menu and draws nothing on a preview.
#[test]
fn every_look_page_setting_lights_a_part_of_its_tab_s_preview() {
	let out = run(r#"
		local EXEMPT = { ["ui.gameMenuButton"] = true }
		local dark, seen = {}, 0
		for _, p in ipairs(O.Pages()) do
			if p.group == "look" then
				for _, tab in ipairs(p.tabs) do
					local _, host = shown(p.key, tab)
					local map = host and rawget(host, "psByKey") or {}
					for c, w in pairs(O.view.cache) do
						if w:IsShown() then
							local keys = { c.key }
							for _, x in ipairs(rawget(w, "psExtras") or {}) do
								local xc = rawget(x, "psControl")
								if xc and xc.key and x:IsShown() then keys[#keys + 1] = xc.key end
							end
							for _, key in pairs(keys) do
								seen = seen + 1
								if not (map[key] and #map[key] > 0) and not EXEMPT[key] then dark[#dark + 1] = p.key .. "/" .. tab .. ": " .. key end
							end
						end
					end
				end
			end
		end
		table.sort(dark)
		emit({ dark = table.concat(dark, "\n"), seen = seen })"#);
	assert!(out["seen"].as_f64().unwrap() > 300.0, "every Look page's rows walked: {}", out["seen"]);
	assert_eq!(out["dark"], "", "settings that light nothing on their preview:\n{}", out["dark"].as_str().unwrap_or_default());
}

// A setting that paints every surface lights every surface it paints: the pointer on Theme > Accent lights, in the
// band, the guide window's open tab (underline and icon), the current goal's bar and glyph, the progress bar (while
// the crop shows it), the heads-up card's ring, headline, badge (its stripe where the look draws one) and primary
// button, the rare alert's primary button and time bar; and the settings window's own accent parts as they show:
// the emblem, the open page's row, the open tab's underline (not the others'), the sliders' fills and the switches
// that are on. A part the accent does not paint, or one the crop left out, stays dark.
#[test]
fn the_accent_row_lights_every_surface_the_accent_paints_in_the_scene_and_in_the_settings_window() {
	let out = run(r#"
		local f, host = shown("theme", "Colour")
		local rows = O.Controls("theme", "Colour")
		stub.RunScript(rows["ui.accent"], "OnEnter")
		local lit = {}
		for _, rec in ipairs(host.psByKey["ui.accent"] or {}) do
			local l = rawget(rec, "Frame")
			if rawget(rec, "psRegion") and l and l.psLit then lit[rec.psRegion] = true end
			for region, made in pairs(rawget(rec, "psMade") or {}) do
				if made.psLit then lit[region] = true end
			end
		end
		local G, heads, toast, win = f.Scene, f.Heads, f.Toast, PolestarOptions
		-- The heads-up card's accent parts the look draws (the house look draws no stripe), every one lit.
		local cardParts, cardLit = 0, true
		for _, part in ipairs({ heads.Stripe, heads.Ring, heads.Head, heads.Badge }) do
			if part:IsShown() then
				cardParts = cardParts + 1
				cardLit = cardLit and lit[part] == true
			end
		end
		local scene = {
			tab = lit[G.Strip.Bar] and lit[G.Strip.Icon], goal = lit[G.Rows[2].Mark] and lit[G.Rows[2].Icon],
			progress = (lit[G.Foot.Line] == true) == (G.Foot:GetAlpha() > 0), stripe = cardParts >= 2 and cardLit,
			primaries = lit[heads.Act] and lit[toast.Waypoint], timer = lit[toast.Timer],
			dark = not lit[G.Rows[3].Text] and not lit[G.Person.Name],
		}
		local tabs, others, fills, tracks, row = 0, 0, 0, 0, false
		for _, t in ipairs(win.tabButtons) do
			local bar = rawget(t, "psSkin") and t.psSkin.bar
			if bar and lit[bar] then if t.psSelected then tabs = tabs + 1 else others = others + 1 end end
		end
		for _, b in ipairs(win.navButtons) do
			if lit[b.Bar] then row = b.Bar:IsShown() end
		end
		for region in pairs(lit) do
			local p = region.GetParent and region:GetParent()
			if p and rawget(p, "Track") == region and rawget(p, "psOn") == true then tracks = tracks + 1 end
		end
		-- The sliders' fills: the menu scale's in the header.
		fills = lit[win.HeaderTools.Fill] and 1 or 0
		-- A switch turned on lights too.
		stub.RunScript(rows["ui.accent"], "OnLeave")
		Polestar.Set("ui.classAccent", true)
		stub.advance(0.1)
		stub.RunScript(rows["ui.accent"], "OnEnter")
		for _, rec in ipairs(host.psByKey["ui.accent"] or {}) do
			for region, made in pairs(rawget(rec, "psMade") or {}) do
				local p = made.psLit and region.GetParent and region:GetParent()
				if p and rawget(p, "Track") == region and rawget(p, "psOn") == true then tracks = tracks + 1 end
			end
		end
		emit({ scene = scene, window = { emblem = lit[win.Emblem] == true, row = row, tab = tabs, otherTabs = others,
			fills = fills > 0, tracks = tracks > 0 } })"#);
	assert_eq!(out["scene"], json!({ "tab": true, "goal": true, "progress": true, "stripe": true, "primaries": true, "timer": true, "dark": true }), "the scene's accent parts");
	assert_eq!(out["window"], json!({ "emblem": true, "row": true, "tab": 1, "otherTabs": 0, "fills": true, "tracks": true }), "the settings window's own accent parts");
}

// The Hearthstone's two buttons, each its own switch: the one in the action set (qol.hearthButton) and the travel
// button under the arrow (nav.castPrompt) sit side by side on one line wherever both show (the Buttons page, Questing
// > Buttons, Quality of Life > Travel), their labels saying which is which; on the Buttons page each row lights its
// own button in the preview (the travel button under the arrow drawn there too), never the other; and a search for
// "hearth", "HS" or "hearthstone" puts that place first with both in it.
#[test]
fn the_hearthstone_s_two_buttons_sit_side_by_side_each_lights_its_own_and_a_search_finds_them_first() {
	let out = run(r#"
		local out = { places = {}, search = {} }
		for _, at in ipairs({ { "buttons", "Action buttons", "buttons.hearthSize" }, { "questing", "Buttons", "qol.hearthButton" },
			{ "qualityoflife", "Travel", "qol.hearthButton" } }) do
			shown(at[1], at[2])
			local rows = O.Controls(at[1], at[2])
			local h, t = rows[at[3]], rows["nav.castPrompt"]
			local place = false
			if h and t then
				local _, _, _, hx, hy = h:GetPoint(1)
				local _, _, _, tx, ty = t:GetPoint(1)
				place = hy == ty and tx > hx
			end
			out.places[at[1]] = place
		end
		local labels = {}
		for _, c in ipairs(O.AllControls()) do
			if c.key == "qol.hearthButton" or c.key == "nav.castPrompt" then labels[c.key] = c.label end
			for _, x in ipairs(c.extras or {}) do if x.key == "qol.hearthButton" then labels[x.key] = x.label end end
		end
		out.labels = labels
		local f, host = shown("buttons", "Action buttons")
		local faces = f.Faces()
		local travel = f.Travel()
		local function lights(key, part)
			for _, rec in ipairs(host.psByKey[key] or {}) do
				if rawget(rec, "psRegion") == part then return true end
			end
			return false
		end
		out.lights = { hearth = lights("qol.hearthButton", faces.hearth), hearthNotTravel = not lights("qol.hearthButton", travel),
			travel = lights("nav.castPrompt", travel), travelNotHearth = not lights("nav.castPrompt", faces.hearth) }
		for _, q in ipairs({ "hearth", "HS", "hearthstone" }) do
			local first = (O.Search(q))[1]
			local keys = {}
			for _, c in ipairs(first and first.controls or {}) do keys[#keys + 1] = c.key end
			out.search[q] = { title = first and first.title, keys = table.concat(keys, " ") }
		end
		emit(out)"#);
	assert_eq!(out["places"], json!({ "buttons": true, "questing": true, "qualityoflife": true }), "side by side on one line: {out}");
	assert_eq!(out["labels"], json!({ "qol.hearthButton": "Hearthstone in the button set", "nav.castPrompt": "Travel button under the arrow" }));
	assert_eq!(out["lights"], json!({ "hearth": true, "hearthNotTravel": true, "travel": true, "travelNotHearth": true }));
	for q in ["hearth", "HS", "hearthstone"] {
		let s = &out["search"][q];
		assert_eq!(s["title"], "Buttons  \u{b7}  Action buttons  \u{b7}  Buttons", "{q}: the Buttons page first: {s}");
		let keys = s["keys"].as_str().unwrap();
		assert!(keys.contains("buttons.hearthSize") && keys.contains("nav.castPrompt"), "{q}: both in it: {keys}");
	}
}

// A player asked how to hide the text under the arrow and keep the arrow and its distance: Arrow > Label lines,
// Off. A search in the words players use finds that row first ("step text" also names the guide window's step
// card, which comes first there, the row right after it).
#[test]
fn a_search_for_the_text_under_the_arrow_finds_label_lines() {
	let out = run(r#"
		local out = {}
		for _, q in ipairs({ "hide text", "step text", "objective text", "quest text under the arrow", "hide label",
			"text under arrow", "arrow text" }) do
			local at = false
			for i, r in ipairs(O.Search(q)) do
				for _, c in ipairs(r.controls or {}) do
					if c.key == "nav.arrowLabelLines" and not at then at = i end
				end
			end
			out[q] = at
		end
		emit(out)"#);
	for q in ["hide text", "objective text", "quest text under the arrow", "hide label", "text under arrow", "arrow text"] {
		assert_eq!(out[q], 1, "{q}: Label lines in the first result: {out}");
	}
	assert_eq!(out["step text"], 2, "step text: Label lines right after the guide window's step card: {out}");
}

// Trackers' Essentials sets all five of the page's elements: its dropdown picks the flight timer (first), the instance
// tracker, the party panel, the journey or the level mark on its XP bar, one at a time; the pointer on a row picks the
// one that row's setting draws, the band and its slot taking that element's height.
#[test]
fn the_trackers_essentials_band_picks_each_tracker_the_journey_and_the_level_mark() {
	let out = run(r#"
		local f, host = shown("trackers", "Essentials")
		local labels = {}
		for _, c in ipairs(f.psPick.choices) do labels[#labels + 1] = c.label end
		local function showing()
			local on = {}
			if f.Tracker and f.Tracker:IsShown() then on[#on + 1] = "flight" end
			if f.Journey and f.Journey.frame:IsShown() then on[#on + 1] = "journey" end
			if f.XP and f.XP.bar:IsShown() then on[#on + 1] = "xp" end
			return table.concat(on, " ")
		end
		local first = { pick = f.psPick.get(), on = showing() }
		local rows = O.Controls("trackers", "Essentials")
		local function hover(key)
			stub.RunScript(rows[key], "OnEnter")
			stub.advance(0.1)
			local r = { pick = f.psPick.get(), on = showing(), slot = math.abs(host:GetHeight() - f:GetHeight()) <= 0.5 }
			stub.RunScript(rows[key], "OnLeave")
			return r
		end
		emit({ labels = labels, first = first, journey = hover("nav.journeySteps"), mark = hover("qol.xpTargetMark") })"#);
	assert_eq!(out["labels"], json!(["Flight timer", "Instance tracker", "Party panel", "Journey", "Level mark"]));
	assert_eq!(out["first"], json!({ "pick": "flight", "on": "flight" }));
	assert_eq!(out["journey"], json!({ "pick": "journey", "on": "journey", "slot": true }), "{out}");
	assert_eq!(out["mark"], json!({ "pick": "xp", "on": "xp", "slot": true }), "{out}");
}

// A band takes clicks on a part only while that part shows: on the Action buttons tab the travel button's hotspot is
// off while the button sets show, and the sets' hotspots are off while its dropdown shows the travel button.
#[test]
fn a_band_s_hotspots_take_clicks_only_while_their_parts_show() {
	let out = run(r#"
		local f = shown("buttons", "Action buttons")
		local function on(key) return f.psHotspots[key] ~= nil and f.psHotspots[key]:IsShown() end
		local sets = { travel = on("nav.castPrompt"), hearth = on("buttons.hearthSize") }
		f.Pick("travel")
		P.Again(f)
		local travel = { travel = on("nav.castPrompt"), hearth = on("buttons.hearthSize") }
		emit({ sets = sets, travel = travel })"#);
	assert_eq!(out["sets"], json!({ "travel": false, "hearth": true }), "{out}");
	assert_eq!(out["travel"], json!({ "travel": true, "hearth": false }), "{out}");
}

// A band lays itself out again on its own settings at once while it shows, on its next show when it was hidden, and
// not on other settings.
#[test]
fn a_band_lays_itself_out_again_at_once_on_its_settings_while_shown_and_on_its_next_show_else() {
	let out = run(r#"
		local f = P.Band(UIParent, { watch = { "nav." } })
		local laid = 0
		function f:Content()
			laid = laid + 1
			return 100, 40, function() end
		end
		f:Show()
		f:Layout(500)
		local base = laid
		Polestar.Set("nav.arrowScale", 1.4)
		local shownLaid = laid - base
		Polestar.Set("behavior.autoAccept", false)
		local other = laid - base - shownLaid
		f:Hide()
		Polestar.Set("nav.arrowScale", 1.2)
		local hiddenLaid = laid - base - shownLaid
		f:Show()
		emit({ shown = shownLaid, other = other, hidden = hiddenLaid, onShow = laid - base - shownLaid })"#);
	assert_eq!(out["shown"], 1, "a watched setting lays a shown band out again at once");
	assert_eq!(out["other"], 0, "another setting does not");
	assert_eq!(out["hidden"], 0, "a hidden band waits");
	assert_eq!(out["onShow"], 1, "and lays itself out as it shows");
}

// A registered page's own frame keeps its contract: laid out across the main column; taller than its room, shown
// whole at the scale that fits (laid out again for the width that scale gives), the one 12px line under it its
// caption and by how much it shrank; one that fits at full size, its caption (here a function's) alone under it.
#[test]
fn a_registered_frame_taller_than_its_room_is_shown_whole_smaller_and_its_line_says_so() {
	let out = run(r#"
		local laid = {}
		local function preview(height, caption)
			return function(host)
				local f = CreateFrame("Frame", nil, host)
				f.caption = caption
				function f:Layout(width)
					laid[#laid + 1] = width
					return height
				end
				return f
			end
		end
		local function toggle() return { { kind = "toggle", key = "nav.arrow", label = "Arrow" } } end
		Polestar.RegisterOptions({ page = "Preview test", key = "previewtest", order = 90, tab = "Tall", section = "S",
			preview = preview(2000, "A tall scene"), controls = toggle() })
		Polestar.RegisterOptions({ page = "Preview test", tab = "Short", section = "T",
			preview = preview(120, function() return "A short scene" end), controls = toggle() })
		local f, host = shown("previewtest", "Tall")
		local room = PolestarOptions:GetHeight() - 112 - 40 - 56
		local _, size = host.Line:GetFont()
		local tall = { scale = f:GetScale(), slot = host:GetHeight(), cap = math.floor(room * 0.55), size = size,
			line = host.Line:IsShown() and host.Line:GetText() or false, again = #laid >= 2 and laid[#laid] > laid[#laid - 1] }
		local s, short = shown("previewtest", "Short")
		emit({ tall = tall, short = { scale = s:GetScale(), slot = short:GetHeight(), line = short.Line:IsShown() and short.Line:GetText() or false } })"#);
	let tall = &out["tall"];
	let scale = tall["scale"].as_f64().unwrap();
	assert!(scale < 1.0 && scale > 0.0, "shown smaller: {tall}");
	assert!((tall["slot"].as_f64().unwrap() - tall["cap"].as_f64().unwrap()).abs() <= 1.0, "it takes its room, 55% of the body: {tall}");
	let line = tall["line"].as_str().unwrap();
	assert!(line.starts_with("A tall scene") && line.contains("to fit"), "its caption, then by how much: {line}");
	assert!(tall["size"].as_f64().unwrap() >= 12.0, "a 12px line: {tall}");
	assert_eq!(tall["again"], true, "laid out again for the width the scale gives: {tall}");
	assert_eq!(out["short"], json!({ "scale": 1, "slot": 155, "line": "A short scene" }), "the frame, then its line, 10 + 15 + 10: {out}");
}
