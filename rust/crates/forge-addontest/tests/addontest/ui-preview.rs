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
		emit({ stages = stages, others = others })"#);
	assert_eq!(out["others"], json!([]), "a preview not on the stage");
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
// height across the slot, the page's scene centred on it, over the zone you stand in until another backdrop is
// picked (the map pins' and route lines' paintings keep their plain ground).
#[test]
fn every_look_page_s_preview_is_the_hero_at_least_40_percent_of_the_window_over_the_zone_you_stand_in() {
	let out = run(r#"
		local out, win = {}, PolestarOptions
		for _, key in ipairs({ "theme", "guidewindow", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers" }) do
			local f, host = shown(key)
			local H = f.Hero
			local above, below = H:GetTop() - f:GetTop(), f:GetBottom() - H:GetBottom()
			out[key] = { hero = math.floor(H:GetHeight() / win:GetHeight() * 1000 + 0.5) / 1000, inSlot = host:GetHeight() >= H:GetHeight() - 0.5,
				centred = math.abs(above - below) <= 1.5 or (above <= 0.5 and below <= 0.5), backdrop = P.BackdropOf(f) }
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

// A surface of the scene stands on a soft floor shadow (s:Floor): under its foot, wider than it, dark, on the
// hero's floor layer (over the backdrop, under the surface).
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
		emit({ under = t:GetTop() >= box:GetBottom() and t:GetBottom() < box:GetBottom(), wider = t:GetWidth() > box:GetWidth(),
			dark = a >= 0.4, layer = t:GetParent() == s.FloorLayer, again = s:Floor(box) == t })"#);
	assert_eq!(out, json!({ "under": true, "wider": true, "dark": true, "layer": true, "again": true }));
}

// The pointer on a setting's row lights the parts of the preview it changes: every hotspot of that setting and
// every part the page lights for it (s:Light), an accent outline and wash; the others stay dark, and off the row
// the lights go out.
#[test]
fn hovering_a_row_lights_the_parts_of_the_preview_its_setting_changes_and_leaving_puts_them_out() {
	let out = run(r#"
		local f, host = shown("arrow", "Look")
		local rows = O.Controls("arrow", "Look")
		local function lit(key)
			local n = 0
			for _, b in ipairs(host.psByKey[key] or {}) do
				if b.psLit and b.Wash and b.Wash:IsShown() then n = n + 1 end
			end
			return n
		end
		stub.RunScript(rows["nav.arrowScale"], "OnEnter")
		local on = { scale = lit("nav.arrowScale"), ring = lit("nav.arrowRingColor") }
		stub.RunScript(rows["nav.arrowScale"], "OnLeave")
		local off = lit("nav.arrowScale")
		local own = f:Light("nav.arrowAlpha", f.Dials[1].holder)
		stub.RunScript(rows["nav.arrowAlpha"], "OnEnter")
		emit({ on = on, off = off, own = lit("nav.arrowAlpha"), made = #own })"#);
	assert!(out["on"]["scale"].as_i64().unwrap() >= 1, "the setting's part lit: {}", out["on"]);
	assert_eq!(out["on"]["ring"], 0, "another setting's part stays dark");
	assert_eq!(out["off"], 0, "off the row the lights go out");
	assert_eq!(out["made"], 1);
	assert_eq!(out["own"], 1, "a part the page lights for a setting");
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
