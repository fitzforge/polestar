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
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: format!("{HELPERS}\n{script}"), ..Default::default() })
		.remove(0)
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
