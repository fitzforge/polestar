//! The settings switch (Theme/Widgets.lua W.Toggle, W.Switch; its colours Theme.SwitchColors): it reads in
//! every look and colour scheme, a switch another setting turns off is grey (never a darkened accent), and its
//! states (hover, press, the gamepad's focus, the slide) show on its parts.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

use super::skins_bundled::SKINS;

fn lin(c: f64) -> f64 {
	if c <= 0.04045 {
		c / 12.92
	} else {
		((c + 0.055) / 1.055).powf(2.4)
	}
}

fn lum(v: &Value) -> f64 {
	let c = |i: usize| v[i].as_f64().unwrap();
	0.2126 * lin(c(0)) + 0.7152 * lin(c(1)) + 0.0722 * lin(c(2))
}

// WCAG 2 contrast, computed here independently of Theme.Contrast.
fn contrast(a: &Value, b: &Value) -> f64 {
	let (p, q) = (lum(a), lum(b));
	let (x, y) = if p >= q { (p, q) } else { (q, p) };
	(x + 0.05) / (y + 0.05)
}

// The spread of a colour's channels: 0 for a grey.
fn spread(v: &Value) -> f64 {
	let c: Vec<f64> = (0..3).map(|i| v[i].as_f64().unwrap()).collect();
	c.iter().cloned().fold(f64::MIN, f64::max) - c.iter().cloned().fold(f64::MAX, f64::min)
}

fn run(script: &str, skins: bool) -> Value {
	let mut addons = vec![Addon::name("Polestar")];
	if skins {
		addons.extend(SKINS.iter().map(|(_, addon, _)| Addon::name(addon)));
	}
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons,
		login: true,
		script: format!("local T, W = Polestar.Theme, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// The switch as a player sees it, in every look the house switch is drawn in (the house look in each colour
// scheme and with a player's pale accent, Halo, Hearth and every bundled skin in each of its variants; the game's looks draw their own check
// box): off, its knob reads at 3:1 against its track; on, at 3:1 against the track where the knob's shadow meets
// it; at rest and under the cursor alike. On, the accent track reads at 3:1 on the card's ground, and the knob
// is the lighter of the two ends.
#[test]
fn the_switch_reads_at_3_to_1_in_every_look_and_colour_scheme_on_and_off_at_rest_and_hovered() {
	let list = SKINS
		.iter()
		.map(|(id, _, variants)| {
			let v = variants.iter().map(|v| format!("{v:?}")).collect::<Vec<_>>().join(", ");
			format!("{{ id = {id:?}, variants = {{ {v} }} }}")
		})
		.collect::<Vec<_>>()
		.join(",\n");
	let out = run(
		&format!(
			r#"
local out = {{}}
local function take(key)
	local p = T.Palette().panel
	out[#out + 1] = {{ key = key, game = T.GameSkin(), panel = {{ p[1], p[2], p[3] }},
		on = T.SwitchColors(true, false, true), off = T.SwitchColors(false, false, true),
		onHover = T.SwitchColors(true, true, true), offHover = T.SwitchColors(false, true, true) }}
end
for _, s in ipairs(T.SCHEME_ORDER) do
	Polestar.Set("ui.skin", "polestar")
	Polestar.Set("ui.scheme", s)
	take("polestar/" .. s)
end
-- A player's own pale accent: the knob's shadow deepens to hold its edge.
Polestar.Set("ui.accent", {{ 1, 0.95, 0.6 }})
take("polestar/pale accent")
Polestar.Set("ui.accent", false)
for _, id in ipairs({{ "halo", "hearth" }}) do
	Polestar.Set("ui.skin", id)
	take(id)
end
for _, s in ipairs({{ {list} }}) do
	local runs = #s.variants > 0 and s.variants or {{ false }}
	for _, v in ipairs(runs) do
		if v then Polestar.Set("ui.skinVariants." .. s.id, v) end
		Polestar.Set("ui.skin", s.id)
		take(s.id .. (v and ("/" .. v) or ""))
	end
end
emit(out)"#
		),
		true,
	);
	let looks = out.as_array().unwrap();
	assert!(looks.len() >= 5 + SKINS.len(), "every look taken: {}", looks.len());
	let mut bad = vec![];
	for l in looks {
		let key = l["key"].as_str().unwrap();
		// A variant on the game's looks (Umbra's) draws their kit's check box, not this switch.
		if l["game"] == true {
			continue;
		}
		for state in ["off", "offHover"] {
			let c = contrast(&l[state]["knob"], &l[state]["track"]);
			if c < 3.0 {
				bad.push(format!("{key} {state}: knob on track {c:.2}:1"));
			}
		}
		for state in ["on", "onHover"] {
			let c = contrast(&l[state]["knob"], &l[state]["contact"]);
			if c < 3.0 {
				bad.push(format!("{key} {state}: knob on its shadowed track {c:.2}:1"));
			}
			if lum(&l[state]["knob"]) < lum(&l[state]["track"]) {
				bad.push(format!("{key} {state}: a knob darker than its track"));
			}
		}
		let t = contrast(&l["on"]["track"], &l["panel"]);
		if t < 3.0 {
			bad.push(format!("{key} on: track on the panel {t:.2}:1"));
		}
	}
	assert!(bad.is_empty(), "{}", bad.join("\n"));
}

// A switch another setting turns off (Disabled, on) is drawn grey under the row's fade: its track, edge and knob
// lose their hue, so the accent never turns a muddy brown; while it is enabled the track is the accent itself.
#[test]
fn a_disabled_switch_that_is_on_is_grey_never_a_darkened_accent() {
	let out = run(
		r#"
Polestar.Set("ui.skin", "polestar")
Polestar.Set("ui.accent", { 0.91, 0.65, 0.44 })
local host = Polestar.UI.GuideFrame.frame
host:SetSize(400, 40)
Polestar.Set("ui.shadow", true)
local t = W.Toggle(host, "Switch", "ui.shadow", "desc")
local function fill() local r, g, b = t.Track.Fill:GetVertexColor() return { r, g, b } end
local function knob() local r, g, b = t.Knob.parts[1]:GetVertexColor() return { r, g, b } end
local out = { accent = { T.Accent() }, enabled = fill() }
W.SetDisabledWhen(t, function() return true end)
t:Refresh()
out.disabled, out.knob, out.alpha = fill(), knob(), t:GetAlpha()
out.colors = T.SwitchColors(true, false, false)
emit(out)"#,
		false,
	);
	let close = |a: &Value, b: &Value| (0..3).all(|i| (a[i].as_f64().unwrap() - b[i].as_f64().unwrap()).abs() < 0.01);
	assert!(close(&out["enabled"], &out["accent"]), "enabled and on: the accent track: {out}");
	assert!(spread(&out["accent"]) > 0.3, "the accent has a hue: {}", out["accent"]);
	assert!(spread(&out["disabled"]) < 0.06, "disabled and on: a grey track, not the accent darkened: {}", out["disabled"]);
	assert!(spread(&out["knob"]) < 0.06, "and a grey knob: {}", out["knob"]);
	assert!(close(&out["disabled"], &out["colors"]["track"]), "as Theme.SwitchColors gives it");
	assert!(out["alpha"].as_f64().unwrap() < 1.0, "and the row fades it");
}

// The states: under the cursor the track lightens; held down the knob widens by 4 toward the side it goes to; the
// gamepad's focus rings the track (and a focus moving on clears it); a flip slides the knob from one end to the
// other over 150 ms with the colours crossfading, and lands at once with reduced motion.
#[test]
fn hover_lightens_press_widens_focus_rings_and_a_flip_slides_with_its_colours_or_lands_with_reduced_motion() {
	let out = run(
		r#"
Polestar.Set("ui.skin", "polestar")
Polestar.Set("ui.reduceMotion", false)
local host = Polestar.UI.GuideFrame.frame
host:SetSize(400, 40)
Polestar.Set("ui.shadow", false)
local t = W.Toggle(host, "Switch", "ui.shadow", "desc")
local T_ = T
local function lum() local r, g, b = t.Track.Fill:GetVertexColor() return T_.Luminance(r, g, b) end
local function knobX() return select(4, t.Knob:GetPoint(1)) end
local out = { rest = lum(), restW = t.Knob:GetWidth(), restX = knobX(), focus0 = rawget(t.Track, "Focus") ~= nil and t.Track.Focus:IsShown() }
t:GetScript("OnEnter")(t)
out.hover = lum()
t:GetScript("OnMouseDown")(t, "LeftButton")
stub.advance(0.2)
out.pressW, out.pressX = t.Knob:GetWidth(), knobX()
t:GetScript("OnMouseUp")(t, "LeftButton")
t:GetScript("OnLeave")(t)
stub.advance(0.2)
out.backW, out.left = t.Knob:GetWidth(), lum()
t.psOnPadFocus(t, true)
out.focus = t.Track.Focus:IsShown()
t.psOnPadFocus(t, false)
out.unfocus = t.Track.Focus:IsShown()
Polestar.Set("ui.shadow", true)
stub.advance(0.05)
out.midX = knobX()
stub.advance(0.3)
out.endX = knobX()
local r, g, b = t.Track.Fill:GetVertexColor()
out.onFill, out.accent = { r, g, b }, { T.Accent() }
Polestar.Set("ui.reduceMotion", true)
Polestar.Set("ui.shadow", false)
out.reducedX = knobX()
emit(out)"#,
		false,
	);
	let f = |k: &str| out[k].as_f64().unwrap_or_else(|| panic!("{k}: {out}"));
	assert!(f("hover") > f("rest"), "the hover lightens the off track: {out}");
	assert_eq!(f("restW"), 14.0);
	assert_eq!(f("restX"), 2.0, "off: 2 in from the left");
	assert_eq!(f("pressW"), 18.0, "held: 4 wider");
	assert_eq!(f("pressX"), 2.0, "off, it widens to the right");
	assert_eq!(f("backW"), 14.0);
	assert!((f("left") - f("rest")).abs() < 1e-6, "the cursor gone, the rest colour");
	assert_eq!(out["focus0"], false);
	assert_eq!(out["focus"], true, "the gamepad's focus rings the track");
	assert_eq!(out["unfocus"], false);
	assert!(f("midX") > 2.0 && f("midX") < 20.0, "mid-slide: between the ends ({})", f("midX"));
	assert_eq!(f("endX"), 20.0, "on: 2 in from the right of the 36 track");
	assert!((0..3).all(|i| (out["onFill"][i].as_f64().unwrap() - out["accent"][i].as_f64().unwrap()).abs() < 0.01), "on: the accent");
	assert_eq!(f("reducedX"), 2.0, "reduced motion: lands at once");
}
