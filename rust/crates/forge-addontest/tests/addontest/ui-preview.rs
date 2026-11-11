//! The settings window's live previews (addon/Polestar_Options/UI/Preview.lua): every page's preview is drawn on
//! the one stage, over a backdrop the player cycles for every preview (the zone they stand in, the night sky,
//! plain), repainted at once on its settings while it shows and on its next show else, never cut off (shown
//! whole and smaller past its room, and saying so), its parts on whole pixels. The whole addon over
//! stub_world.lua, the settings window open.

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
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: format!("{HELPERS}\n{script}"), ..Default::default() }).remove(0)
}

// Coverage: every tab of every page that has a preview draws it on the settings window's stage, and the pages
// that have one are the look pages (none is left out).
#[test]
fn every_page_s_preview_is_drawn_on_the_settings_window_s_one_stage() {
	let out = run(r#"
		local stages, others = {}, {}
		for _, p in ipairs(O.Pages()) do
			for _, tab in ipairs(p.tabs) do
				local f = shown(p.key, tab)
				if f then
					local where = p.key .. "/" .. tab
					if P.IsStage(f) then stages[#stages + 1] = where else others[#others + 1] = where end
				end
			end
		end
		emit({ stages = stages, others = table.concat(others, ", ") })"#);
	assert_eq!(out["others"], "", "a preview not on the stage");
	let stages: Vec<&str> = out["stages"].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	for page in ["theme/", "guidewindow/", "arrow/", "mappins/", "routelines/", "buttons/", "alerts/", "trackers/"] {
		assert!(stages.iter().any(|s| s.starts_with(page)), "{page}'s preview is on the stage: {stages:?}");
	}
}

// The chip over every preview cycles its backdrop for every preview, kept on the account (not a setting): the
// world (the zone the player stands in), the night sky, plain; a stage whose scene is a painting of its own
// (the map pins') keeps its plain ground.
#[test]
fn the_backdrop_chip_cycles_the_world_the_night_sky_and_plain_for_every_preview_and_is_kept() {
	let out = run(r#"
		local arrow, host = shown("arrow")
		local first = P.BackdropOf(arrow)
		local labels = { host.Backdrop.Label:GetText() }
		local kinds = { first }
		for i = 1, 3 do
			host.Backdrop:Click("LeftButton")
			kinds[#kinds + 1] = P.BackdropOf(arrow)
			labels[#labels + 1] = host.Backdrop.Label:GetText()
		end
		host.Backdrop:Click("LeftButton")   -- the night sky
		local toasts = shown("alerts")
		local pins = shown("mappins")
		emit({ kinds = kinds, labels = labels, kept = Polestar.DB().optionsBackdrop, toasts = P.BackdropOf(toasts),
			pins = P.BackdropOf(pins), setting = Polestar.GetDefault("ui.optionsBackdrop") == nil })"#);
	assert_eq!(out["kinds"], json!(["world", "sky", "ground", "world"]), "world, the night sky, plain, the world again");
	assert_eq!(out["labels"], json!(["World", "Night sky", "Plain", "World"]));
	assert_eq!(out["kept"], "sky");
	assert_eq!(out["toasts"], "sky", "the pick is every preview's");
	assert_eq!(out["pins"], "ground", "the map pins' painting is its own scene");
	assert_eq!(out["setting"], true, "the backdrop is not a setting");
}

// A stage whose scene is a painting of its own (the map pins', the route lines') has no backdrop to pick, so no
// chip; the others carry it. A scene cropped at the stage's foot fades out there: the guide window's, until the
// crop is scrolled to the window's end.
#[test]
fn a_painted_scene_has_no_backdrop_chip_and_a_cropped_one_fades_out_at_the_stage_s_foot() {
	let out = run(r#"
		local chips = {}
		for _, key in ipairs({ "arrow", "mappins", "routelines", "alerts" }) do
			local _, host = shown(key)
			chips[key] = host.Backdrop:IsShown()
		end
		local gw = shown("guidewindow")
		local top = gw.Fade:IsShown()
		gw:Focus("guideWindow.progressHeight")
		emit({ chips = chips, top = top, foot = gw.Fade:IsShown() })"#);
	assert_eq!(out["chips"], json!({ "arrow": true, "mappins": false, "routelines": false, "alerts": true }));
	assert_eq!(out["top"], true, "the guide window runs past the stage: its foot fades out");
	assert_eq!(out["foot"], false, "scrolled to the window's end: nothing to fade");
}

// The preview is the page's hero: on every Look page the stage stands on a backdrop at least 40% of the window's
// height across the slot, the page's scene centred on it (as much hero above it as below, by its anchor and the
// height its page laid it out at), over the zone you stand in until another backdrop is picked (the map pins' and
// route lines' paintings keep their plain ground).
#[test]
fn every_look_page_s_preview_is_the_hero_at_least_40_percent_of_the_window_over_the_zone_you_stand_in() {
	let out = run(r#"
		local out, win = {}, PolestarOptions
		for _, key in ipairs({ "theme", "guidewindow", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers" }) do
			local f, host = shown(key)
			local H = f.Hero
			local _, rel, _, _, y = f:GetPoint(1)
			local k = f:GetScale()
			local above = -(y or 0) * k
			local below = H:GetHeight() - above - f:GetHeight() * k
			out[key] = { hero = math.floor(H:GetHeight() / win:GetHeight() * 1000 + 0.5) / 1000, inSlot = host:GetHeight() >= H:GetHeight() - 0.5,
				centred = rel == host and math.abs(above - below) <= 1.5 and below >= -0.5, backdrop = P.BackdropOf(f) }
		end
		emit(out)"#);
	for key in ["theme", "guidewindow", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers"] {
		let p = &out[key];
		assert!(p["hero"].as_f64().unwrap() >= 0.399, "{key}: the stage is {} of the window", p["hero"]);
		assert_eq!(p["inSlot"], true, "{key}: the hero fills its slot");
		assert_eq!(p["centred"], true, "{key}: the scene is centred on the hero");
		let ground = if key == "mappins" || key == "routelines" { "ground" } else { "world" };
		assert_eq!(p["backdrop"], ground, "{key}: the zone you stand in by default");
	}
}

// A surface of the scene stands on a soft floor shadow (s:Floor): under its foot (its top over the foot, the rest
// below it), wider than it on both sides, dark, on the hero's floor layer (over the backdrop, under the surface).
#[test]
fn a_surface_stands_on_a_soft_floor_shadow_under_its_foot() {
	let out = run(r#"
		local s = P.Stage(UIParent, { height = 200 })
		s:SetWidth(600)
		s:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, -100)
		s:Show()
		local box = CreateFrame("Frame", nil, s)
		box:SetSize(200, 100)
		box:SetPoint("TOPLEFT", s, "TOPLEFT", 50, -40)
		local t = s:Floor(box)
		local _, _, _, a = t:GetVertexColor()
		local p1, r1, rp1, x1, y1 = t:GetPoint(1)
		local p2, r2, rp2, x2, y2 = t:GetPoint(2)
		local h = t:GetHeight()
		emit({ under = r1 == box and rp1 == "BOTTOMLEFT" and y1 > 0 and h - y1 > 0 and r2 == box and rp2 == "BOTTOMRIGHT" and y2 == y1,
			wider = p1 == "TOPLEFT" and p2 == "TOPRIGHT" and x1 < 0 and x2 > 0,
			dark = a >= 0.4, layer = t:GetParent() == s.FloorLayer, again = s:Floor(box) == t })"#);
	assert_eq!(out, json!({ "under": true, "wider": true, "dark": true, "layer": true, "again": true }));
}

// The pointer on a setting's row lights the parts of the preview it changes: every hotspot of that setting and
// every part the page lights for it (s:Light, its frame made the first time it lights), an accent outline and
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
// lights at least one part of that tab's preview, a hotspot or a part the page lights for it (s:Light). Exempt: the
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
// scene, the guide window's open tab (underline and icon), the current goal's bar and glyph, the progress bar (while
// the hero's crop shows it), the heads-up card's stripe, ring, headline, badge and primary button, the rare alert's
// primary button and time bar and the arrow; and the settings window's own accent parts as they show: the emblem,
// the open page's row, the open tab's underline (not the others'), the sliders' fills and the switches that are on.
// A part the accent does not paint, or one the crop left out, stays dark.
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
		local scene = {
			tab = lit[G.Strip.Bar] and lit[G.Strip.Icon], goal = lit[G.Rows[2].Mark] and lit[G.Rows[2].Icon],
			progress = (lit[G.Foot.Line] == true) == (G.Foot:GetAlpha() > 0), stripe = lit[heads.Stripe] and lit[heads.Ring] and lit[heads.Head] and lit[heads.Badge],
			primaries = lit[heads.Act] and lit[toast.Waypoint], timer = lit[toast.Timer], arrow = false,
			dark = not lit[G.Rows[3].Text] and not lit[G.Person.Name],
		}
		for region in pairs(lit) do
			local p = region.GetParent and region:GetParent()
			while p and not scene.arrow do
				scene.arrow = p == f.Arrow
				p = p:GetParent()
			end
		end
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
	assert_eq!(out["scene"], json!({ "tab": true, "goal": true, "progress": true, "stripe": true, "primaries": true, "timer": true, "arrow": true, "dark": true }), "the scene's accent parts");
	assert_eq!(out["window"], json!({ "emblem": true, "row": true, "tab": 1, "otherTabs": 0, "fills": true, "tracks": true }), "the settings window's own accent parts");
}

// The Buttons hero and the single alerts stand in the world they act in: the button set with the mob the target
// button names (your target: its ring, and its raid mark while Mark target is on) and the rare the rare button
// names; the rare alert and the transport banner at the top with the arrow under them and the guide window whole
// at the right, cropped at the hero's foot, the rare in the world at its level. The mobs light with the settings
// that act on them; a narrow page leaves the guide window out and keeps the card.
#[test]
fn the_buttons_and_single_alert_heroes_stand_in_the_world_they_act_in() {
	let out = run(r#"
		local f = shown("buttons", "Action buttons")
		local mob, far = f.Mobs()
		local faces = f.Faces()
		local buttons = { mob = mob:IsShown() and mob.Name:GetText() == faces.target.Label:GetText(), ring = rawget(mob, "Ring") ~= nil,
			far = far:IsShown() and far.Name:GetText() == faces.rare.Label:GetText(), markOff = mob.Mark:IsShown() }
		Polestar.Set("qol.markTarget", true)
		f.Paint()
		buttons.markOn = mob.Mark:IsShown()
		Polestar.Set("qol.markTarget", false)
		local _, host = shown("buttons", "Action buttons")
		buttons.lit = host.psByKey["qol.targetButton"] ~= nil and host.psByKey["qol.rareButton"] ~= nil
		local alerts = {}
		for key, tab in pairs({ rare = "Rare alert", transport = "Transport alert" }) do
			local s, h = shown("alerts", tab)
			local w = s.World
			-- The window inside the stage: its box reaches 40 px (its shadow's room) past its right edge.
			local whole = false
			if w.G and w.G:IsShown() then
				local _, _, _, x = w.G:GetPoint(1)
				whole = x + w.G:GetWidth() - 40 <= s.psWidth + 0.5
			end
			local a = { guide = w.G ~= nil and w.G:IsShown(), whole = whole, arrow = w.arrow ~= nil and w.arrow.holder:IsShown(),
				card = s.Card:IsShown() }
			if w.left then a.rare = w.left:IsShown() and w.left.Name:GetText() == s.Card.Name:GetText() and s.Card.Facts:GetText():find(w.left.Level:GetText(), 1, true) ~= nil end
			if key == "rare" then
				s:Layout(420, s.psHeight)
				a.narrow = { guide = w.G:IsShown(), card = s.Card:IsShown() }
				a.lit = h.psByKey["rares.alerts"] ~= nil
			end
			alerts[key] = a
		end
		emit({ buttons = buttons, alerts = alerts })"#);
	assert_eq!(out["buttons"], json!({ "mob": true, "ring": true, "far": true, "markOff": false, "markOn": true, "lit": true }), "{out}");
	assert_eq!(
		out["alerts"],
		json!({
			"rare": { "guide": true, "whole": true, "arrow": true, "card": true, "rare": true,
				"narrow": { "guide": false, "card": true }, "lit": true },
			"transport": { "guide": true, "whole": true, "arrow": true, "card": true },
		})
	);
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

// A stage repaints on its own settings at once while it shows, on its next show when it was hidden, and not on
// other settings (one with no look: a scale or a theme setting repaints every stage through Theme.Refresh).
#[test]
fn a_stage_repaints_at_once_on_its_settings_while_shown_and_on_its_next_show_else() {
	let out = run(r#"
		local s = P.Stage(UIParent, { height = 120, watch = { "nav." } })
		local paints = 0
		s.Paint = function() paints = paints + 1 end
		s:Show()
		s:Layout(500)
		local base = paints
		Polestar.Set("nav.arrowScale", 1.4)
		local shownPaint = paints - base
		Polestar.Set("behavior.autoAccept", false)
		local other = paints - base - shownPaint
		s:Hide()
		Polestar.Set("nav.arrowScale", 1.2)
		local hiddenPaint = paints - base - shownPaint
		s:Show()
		emit({ shown = shownPaint, other = other, hidden = hiddenPaint, onShow = paints - base - shownPaint })"#);
	assert_eq!(out["shown"], 1, "a watched setting repaints a shown stage at once");
	assert_eq!(out["other"], 0, "another setting does not");
	assert_eq!(out["hidden"], 0, "a hidden stage waits");
	assert_eq!(out["onShow"], 1, "and repaints as it shows");
}

// Never cut off: a preview taller than its room is shown whole at the scale that fits, its caption says so; one
// that fits is shown at full size. A part fitted on the stage lands on whole pixels.
#[test]
fn a_preview_taller_than_its_room_is_shown_whole_smaller_and_says_so_and_parts_land_on_whole_pixels() {
	let out = run(r#"
		local made
		Polestar.RegisterOptions({ page = "Preview test", key = "previewtest", order = 90, tab = "Tall", section = "S",
			preview = function(host)
				made = P.Stage(host, { height = 2000 })
				return made
			end,
			controls = { { kind = "toggle", key = "nav.arrow", label = "Arrow" } } })
		local f, host = shown("previewtest", "Tall")
		local room = PolestarOptions:GetHeight()
		local card = CreateFrame("Frame", nil, f)
		card:SetSize(101, 37)
		local k = P.Fit(f, card, 101, 37, 1.3)
		local _, _, _, x, y = card:GetPoint(1)
		emit({ stage = f == made, scale = f:GetScale(), height = host:GetHeight(), room = room,
			caption = host.Caption:GetText(), fitted = k, whole = { x == math.floor(x), y == math.floor(y) } })"#);
	assert_eq!(out["stage"], true);
	let scale = out["scale"].as_f64().unwrap();
	assert!(scale < 1.0 && scale > 0.0, "shown smaller: {scale}");
	let (h, room) = (out["height"].as_f64().unwrap(), out["room"].as_f64().unwrap());
	assert!(h <= room * 0.45 + 1.0, "within its room: {h} of {room}");
	assert!(out["caption"].as_str().unwrap().contains("to fit"), "it says so: {}", out["caption"]);
	assert_eq!(out["fitted"], json!(1.3), "a part that fits is drawn at its own scale");
	assert_eq!(out["whole"], json!([true, true]), "on whole pixels");
}
