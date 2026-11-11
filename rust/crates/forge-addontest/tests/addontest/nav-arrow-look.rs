//! The arrow's look settings (Settings > Arrow, Nav/ArrowOptions.lua): each changes the live arrow's
//! regions in place without moving its heading or target, and the page's preview paints sandbox dials
//! with the arrow's own code, never the live arrow, animating only while shown.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local N = Polestar.Nav
local A = N.arrow
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "T")
end
local function rgba(t) local r, g, b, a = t:GetVertexColor() return { r, g, b, a } end
local function text(fs) local r, g, b = fs:GetTextColor() return { r, g, b } end
local function size(fs) local _, s = fs:GetFont() return s end
local function flags(fs) local _, _, f = fs:GetFont() return f end
"#;

// The arrow page is the settings window's (Polestar_Options): its file, after the arrow's own, and the
// settings window's preview stage it draws on (UI/Preview.lua).
fn run(script: &str) -> Value {
	let page = forge_addontest::run::addons_dir().join("Polestar_Options/Nav/ArrowOptions.lua").to_string_lossy().into_owned();
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml", "../Polestar_Options/UI/Preview.lua", &page])],
		login: true,
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn r3(v: &Value) -> Value {
	Value::Array(v.as_array().unwrap().iter().map(|x| json!((x.as_f64().unwrap() * 1000.0).round() / 1000.0)).collect())
}

#[test]
fn every_look_setting_changes_the_live_arrow_in_place_and_leaves_its_heading_and_target() {
	let out = run(r#"
		local out = {}
		Polestar.Set("nav.arrowStyle", "flat")
		target(0, 300)                       -- 300 yd west
		stub.advance(1)
		local angle, goal = A.GetAngle(), N.GetTarget()
		out.default = { glow = rgba(A.glow)[4], glowShown = A.glow:IsShown(), dist = size(A.distText), label = size(A.labelText),
			eta = size(A.etaText), outline = flags(A.distText), lines = A.labelText:GetMaxLines(), width = A.labelText:GetWidth(),
			dialPoint = (A.dial:GetPoint(1)), backing = A.backing:IsShown() }
		Polestar.Set("nav.arrowGlowStrength", 2)
		out.glowStrong = rgba(A.glow)[4]
		Polestar.Set("nav.arrowGlow", false)
		out.glowOff = A.glow:IsShown()
		Polestar.Set("nav.arrowDistSize", 2)
		Polestar.Set("nav.arrowLabelSize", 1.5)
		Polestar.Set("nav.arrowEtaSize", 0.5)
		Polestar.Set("nav.arrowOutline", "THICKOUTLINE")
		out.sizes = { size(A.distText), size(A.labelText), size(A.etaText), flags(A.distText) }
		Polestar.Set("nav.arrowDistColor", { 1, 0, 0 })
		Polestar.Set("nav.arrowLabelColor", { 0, 1, 0 })
		Polestar.Set("nav.arrowEtaColor", { 0, 0, 1 })
		out.colours = { text(A.distText), text(A.labelText), text(A.etaText) }
		Polestar.Set("nav.arrowLabelLines", 1)
		Polestar.Set("nav.arrowLabelWidth", 300)
		out.label = { A.labelText:GetMaxLines(), A.labelText:GetWidth(), A.labelText:IsShown() }
		Polestar.Set("nav.arrowLabelLines", 0)
		out.labelOff = A.labelText:IsShown()
		Polestar.Set("nav.arrowDistance", false)
		out.distOff = A.distText:IsShown()
		Polestar.Set("nav.arrowTextPos", "above")
		Polestar.Set("nav.arrowBacking", true)
		Polestar.Set("nav.arrowBackingAlpha", 0.7)
		out.above = { (A.dial:GetPoint(1)), (A.etaText:GetPoint(1)), A.backing:IsShown(), rgba(A.backing)[4] }
		stub.advance(0.5)
		out.kept = { angle = math.abs(A.GetAngle() - angle) < 1e-6, target = N.GetTarget() == goal, mode = A.GetMode() }
		-- The colour starts shifting where nav.arrowNearRange says: off, still the far colour 30 yd out.
		Polestar.Set("nav.arrowNearRange", 0)
		nav.place(0, 270)
		stub.advance(0.2)
		local br, bg, bb = A.body:GetVertexColor()
		out.rangeOff = { body = { br, bg, bb }, arrow = { Polestar.Theme.Color("arrow") } }
		-- Arrival: the ring in its own colour, still without the pulse.
		Polestar.Set("nav.arrowRingColor", { 0, 0, 1 })
		Polestar.Set("nav.arrowPulse", false)
		nav.place(0, 299)
		stub.advance(0.2)
		local w0 = A.ring:GetWidth()
		stub.advance(0.3)
		out.arrived = { mode = A.GetMode(), ring = rgba(A.ring), still = A.ring:GetWidth() == w0 }
		Polestar.Set("nav.arrowPulse", true)
		stub.advance(0.3)
		out.pulsing = A.ring:GetWidth() ~= 64
		-- Combat: the arrow's opacity times nav.arrowCombatAlpha, back after.
		Polestar.Set("nav.arrowCombatAlpha", 0.5)
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		out.combat = A.frame:GetAlpha()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		out.peace = A.frame:GetAlpha()
		-- No goal: hidden by default; a faint, still ring with "dim".
		N.ClearTarget()
		stub.advance(0.2)
		out.noGoal = A.frame:IsShown()
		Polestar.Set("nav.arrowNoTarget", "dim")
		stub.advance(0.2)
		out.dim = { shown = A.frame:IsShown(), mode = A.GetMode(), ring = A.ring:IsShown(), ringA = rgba(A.ring)[4], arrow = A.body:IsShown() }
		target(0, 0)
		nav.place(0, 300)
		stub.advance(0.5)
		out.back = A.GetMode()
		emit(out)"#);
	let d = &out["default"];
	assert_eq!(
		json!([r3(&json!([d["glow"]]))[0], d["glowShown"], d["dist"], d["label"], d["eta"], d["outline"], d["lines"], d["width"], d["dialPoint"], d["backing"]]),
		json!([0.45, true, 16, 12, 12, "OUTLINE", 2, 200, "TOP", false]),
		"the defaults draw the arrow as it always was"
	);
	assert_eq!(r3(&json!([out["glowStrong"]]))[0], json!(0.9), "glow strength doubles the glow");
	assert_eq!(out["glowOff"], false, "glow off hides it");
	assert_eq!(out["sizes"], json!([32, 18, 6, "THICKOUTLINE"]));
	assert_eq!(out["colours"], json!([[1, 0, 0], [0, 1, 0], [0, 0, 1]]));
	assert_eq!(out["label"], json!([1, 300, true]));
	assert_eq!(out["labelOff"], false, "0 lines hides the label");
	assert_eq!(out["distOff"], false, "the distance can go");
	assert_eq!(r3(&json!([out["above"][3]]))[0], json!(0.7));
	assert_eq!(json!([out["above"][0], out["above"][1], out["above"][2]]), json!(["BOTTOM", "BOTTOM", true]), "text over the dial, on a plate");
	assert_eq!(out["kept"], json!({ "angle": true, "target": true, "mode": "travel" }), "no look setting moves the arrow");
	let rng = &out["rangeOff"];
	assert_eq!(
		r3(&json!([rng["body"][0], rng["body"][1], rng["body"][2]])),
		r3(&json!([rng["arrow"][0], rng["arrow"][1], rng["arrow"][2]])),
		"with the colour change off, the far colour right up to the goal"
	);
	assert_eq!(out["arrived"]["mode"], "arrived");
	assert_eq!(out["arrived"]["ring"], json!([0, 0, 1, 1]), "the arrived ring wears its own colour");
	assert_eq!(out["arrived"]["still"], true, "no pulse: the ring stays still");
	assert_eq!(out["pulsing"], true, "the pulse back on: it breathes again");
	assert_eq!(out["combat"], json!(0.5));
	assert_eq!(out["peace"], json!(1));
	assert_eq!(out["noGoal"], false);
	assert_eq!(out["dim"], json!({ "shown": true, "mode": "idle", "ring": true, "ringA": 0.35, "arrow": false }));
	assert_eq!(out["back"], "travel", "a new goal takes the arrow back");
}

#[test]
fn the_preview_paints_its_own_dials_with_the_arrows_code_never_the_live_arrow_and_animates_only_while_shown() {
	let out = run(r#"
		local out = {}
		target(0, 100)
		stub.advance(1)
		local function live()
			local l, r, t, b = A.sheet:GetTexCoord()
			return { angle = A.GetAngle(), mode = A.GetMode(), frame = A.GetFrame(), coords = { l, r, t, b }, tint = rgba(A.sheet) }
		end
		local before = live()
		local goal = N.GetTarget()
		-- The window's page view stands in: the preview hangs off UIParent here.
		local P = N.ArrowPreview(UIParent)
		P:Show()
		out.height = P:Layout(640)
		local D = P.Dials
		out.states = { D[1].dial.sheet:IsShown(), D[2].dial.sheet:IsShown(), D[3].dial.ring:IsShown(), D[3].dial.sheet:IsShown() }
		out.texts = { D[1].dial.distText:GetText(), D[3].dial.distText:GetText() }
		out.liveDial = D[1].dial.dial ~= A.dial and D[1].dial.sheet ~= A.sheet
		out.dialScripts = (D[1].holder:GetScript("OnUpdate") or D[1].dial.dial:GetScript("OnUpdate")) == nil
		out.animating = P:GetScript("OnUpdate") ~= nil
		stub.advance(0.6)
		out.breathes = D[3].dial.ring:GetWidth() ~= 64
		-- A setting repaints the preview; the live arrow keeps its heading and target.
		Polestar.Set("nav.arrowRingColor", { 1, 0, 0 })
		out.previewRing = rgba(D[3].dial.ring)
		Polestar.Set("nav.arrowRingColor", nil)
		local after = live()
		out.liveKept = after.angle == before.angle and after.mode == before.mode and after.frame == before.frame
			and N.GetTarget() == goal and table.concat(after.coords, ",") == table.concat(before.coords, ",")
		P:Hide()
		out.hiddenScript = P:GetScript("OnUpdate")
		Polestar.Set("nav.arrowGlowStrength", 2)   -- hidden: no paint until shown
		Polestar.Set("nav.arrowStyle", "flat")
		out.hiddenStill = D[1].dial.sheet:IsShown()
		P:Show()
		out.shownAgain = { D[1].dial.body:IsShown(), D[1].dial.sheet:IsShown(), rgba(D[1].dial.glow)[4] }
		Polestar.Set("nav.arrowPulse", false)
		out.noPulse = P:GetScript("OnUpdate")
		-- The page is registered: key, order, the look group; every setting is
		-- reachable (rows, section toggles, inline extras, cog popups), with
		-- search words and help (the tooltip); labels short; at most 2 (i).
		local n, page, keys, sections, infos, long = 0, nil, {}, {}, 0, nil
		local function visit(c)
			n = n + 1
			if c.key then keys[#keys + 1] = c.key end
			if not (c.search and c.help) then out.missing = c.key or c.label end
			if c.kind == "slider" and type(c.format) ~= "function" then out.unformatted = c.key end
			if c.info then infos = infos + 1 end
			local _, words = (c.label or ""):gsub("%S+", "")
			if words > 3 then long = c.label end
			local switches, swatches = 0, 0
			for _, x in ipairs(c.extras or {}) do
				if x.kind == "toggle" then switches = switches + 1 elseif x.kind == "color" then swatches = swatches + 1 end
				visit(x)
			end
			if switches > 1 or swatches > 1 then out.crowded = c.key end
			for _, x in ipairs(c.more or {}) do visit(x) end
		end
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == Polestar.L["Arrow"] then
				if spec.key then page = { key = spec.key, order = spec.order, group = spec.group } end
				sections[#sections + 1] = spec.tab .. "/" .. spec.section .. (spec.toggle and (" [" .. spec.toggle.key .. "]") or "")
				if spec.toggle then visit(spec.toggle) end
				local halves = 0
				for _, c in ipairs(spec.controls) do
					visit(c)
					halves = halves + (c.wide and 2 or 1)
				end
				if halves < 3 then out.thin = spec.section end
			end
		end
		table.sort(keys)
		out.page, out.controls, out.keys, out.sections, out.infos, out.long = page, n, table.concat(keys, " "), sections, infos, long
		emit(out)"#);
	assert_eq!(out["height"], json!(168));
	assert_eq!(out["states"], json!([true, true, true, false]), "3D on its way and closing in, the ring on arrival");
	assert_eq!(out["texts"], json!(["420 yd", "Arrived"]));
	assert_eq!(out["liveDial"], true, "the preview builds its own dials");
	assert_eq!(out["dialScripts"], true, "its dials run no OnUpdate");
	assert_eq!(out["animating"], true, "the arrived ring breathes while shown");
	assert_eq!(out["breathes"], true);
	assert_eq!(out["previewRing"], json!([1, 0, 0, 1]), "settings repaint the preview");
	assert_eq!(out["liveKept"], true, "the live arrow keeps its heading, frame and target");
	assert_eq!(out["hiddenScript"], Value::Null, "no OnUpdate while hidden");
	assert_eq!(out["hiddenStill"], true, "hidden: repainted only on show");
	assert_eq!(out["shownAgain"], json!([true, false, 0.9]));
	assert_eq!(out["noPulse"], Value::Null, "nothing animates without the pulse");
	assert_eq!(out["page"], json!({ "key": "arrow", "order": 22, "group": "look" }));
	assert!(out["controls"].as_i64().unwrap() >= 33, "a full page: {}", out["controls"]);
	assert_eq!(out.get("missing"), None, "every control has search words and help (its tooltip)");
	assert_eq!(out.get("unformatted"), None, "every slider says its value in its unit (percent, yards, px)");
	assert_eq!(out.get("long"), None, "labels are 1-3 words");
	assert!(out["infos"].as_i64().unwrap() <= 2, "at most two (i) marks");
	assert_eq!(out.get("crowded"), None, "at most one switch and one swatch beside a control");
	assert_eq!(out.get("thin"), None, "no one-row sections");
	assert_eq!(out["sections"], json!(["Look/Arrow [nav.arrow]", "Look/Arrival", "Look/Visibility", "Text/Text"]), "the arrow, its arrival and when it shows, then its text in one card");
	let keys = out["keys"].as_str().unwrap();
	for k in [
		"nav.arrow",
		"nav.arrowStyle",
		"nav.arrowScale",
		"nav.arrowAlpha",
		"nav.arrowColor",
		"nav.arrowNearColor",
		"nav.arrowNearRange",
		"nav.arrowTurn",
		"nav.arrowGlow",
		"nav.arrowGlowStrength",
		"nav.arrowRingColor",
		"nav.arrowPulse",
		"nav.arrivalSound",
		"nav.hideArrowWithGuide",
		"nav.arrowNoTarget",
		"nav.arrowCombatAlpha",
		"nav.arrowDistance",
		"nav.arrowDistSize",
		"nav.arrowDistColor",
		"nav.distanceUnit",
		"nav.arrowLabelLines",
		"nav.arrowLabelSize",
		"nav.arrowLabelColor",
		"nav.arrowLabelWidth",
		"nav.arrowEta",
		"nav.arrowEtaSize",
		"nav.arrowEtaColor",
		"nav.arrowFont",
		"nav.arrowOutline",
		"nav.arrowTextPos",
		"nav.arrowBacking",
		"nav.arrowBackingAlpha",
	] {
		assert!(keys.split(' ').any(|x| x == k), "{k} is still settable on the page");
	}
}
