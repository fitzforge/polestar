//! #1390: every Polestar frame follows Appearance > Windows > Skin, live. The whole addon is loaded, its frames
//! are built (the flight timer, the instance tracker, the party panel, the confirm dialog, the toasts, the
//! welcome, copy and Materials windows), and the skin is switched through every choice: each skinned frame is painted in
//! the skin in use (one hidden by a closed window above it as that window shows), the floating ones on the window
//! skin (Halo's veil, not a menu's fill), and the quest item and
//! travel buttons' hover wash follows the skin's.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const SCRIPT: &str = r#"
local T, W = Polestar.Theme, Polestar.Widgets
T._testShowHidden = true
-- Build what is built on demand. The party panel shows only with someone in the party heard running Polestar.
Polestar.Party.IsLive = function() return true end
Polestar.Party.Roster = function() return { { name = "Ana", unit = "party1", level = 12 } } end
Polestar.Set("party.panel", true)
W.Modal({ title = "Reset?", text = "Sure?", action = "Reset" })
Polestar.Nav.alerts.ShowSample()
Polestar.Rares.Toast.Show({ kind = "rare", name = "Mother Fang", map = 1429, x = 50, y = 50 })
Polestar.UI.ShowCopy("Copy", "text")
Polestar.UI.Materials.Show()
-- The swept frames by global name: a name that is gone (a renamed frame) is reported missing, not skipped.
local NAMES = {
	timer = "PolestarFlightTimer", tracker = "PolestarInstanceTracker", party = "PolestarPartyPanel",
	modal = "PolestarModal", transit = "PolestarAlert", rare = "PolestarRareToast", copy = "PolestarCopy",
	materials = "PolestarMaterials",
}
local named, missing = {}, {}
for k, name in pairs(NAMES) do
	local f = _G[name]
	if f and k == "modal" then f = f.Box end
	if f then named[k] = f else missing[#missing + 1] = k end
end
table.sort(missing)
-- Every frame a skin painted.
local painted = {}
for _, f in ipairs(stub.frames) do if rawget(f, "psSkin") then painted[#painted + 1] = f end end
local function hover(b) local hl = b and rawget(b, "Hl"); return hl and { hl:GetVertexColor() } or false end
local out = { missing = table.concat(missing, ","), painted = #painted, skins = {} }
for _, key in ipairs(T.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	-- Every skinned frame in the skin in use: one that shows at once, one hidden by a frame above it (a
	-- closed window's part) as that frame shows (each hidden frame above it shown, then hidden again).
	local stale = 0
	for _, f in ipairs(painted) do
		if f.psSkin.skin ~= key then
			if f:IsVisible() then
				stale = stale + 1
			else
				local up, p = {}, f:GetParent()
				while p do
					if not p:IsShown() then up[#up + 1] = p end
					p = p:GetParent()
				end
				for i = #up, 1, -1 do up[i]:Show() end
				if f.psSkin.skin ~= key then stale = stale + 1 end
				for i = 1, #up do up[i]:Hide() end
			end
		end
	end
	local s = { stale = stale, frames = {} }
	for k, f in pairs(named) do
		local d = f.psSkin
		s.frames[k] = {
			skin = d and d.skin or false,
			veil = d and d.veil ~= nil and d.veil:IsShown() or false,
			shadow = f.psShadow ~= nil and f.psShadow:IsShown() or false,
		}
	end
	s.item = hover(PolestarQuestItemButton)
	s.travel = hover(PolestarTravelButton)
	s.wash = { T.Wash("hover") }
	out.skins[key] = s
end
emit(out)
"#;

fn run() -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: SCRIPT.into(), ..Default::default() }).remove(0)
}

#[test]
fn switching_the_skin_restyles_the_flight_timer_and_every_polestar_frame_live_1390() {
	let out = run();
	assert_eq!(out["missing"], "", "every swept frame was built");
	assert!(out["painted"].as_u64().unwrap() > 10, "the sweep saw the skinned frames: {}", out["painted"]);
	let skins = out["skins"].as_object().unwrap();
	assert_eq!(skins.len(), 6);
	for (key, s) in skins {
		assert_eq!(s["stale"], 0, "{key}: every skinned frame repainted in the skin in use");
		let frames = s["frames"].as_object().unwrap();
		assert_eq!(frames.len(), 8, "{key}: every swept frame reported");
		for (name, f) in frames {
			assert_eq!(f["skin"], json!(key), "{key}: {name} painted in it");
			// The window skin: Halo's soft veil (a panel would take the menu fill), the house drop shadow.
			assert_eq!(f["veil"], json!(key == "halo"), "{key}: {name} on the window skin");
			if key == "polestar" {
				assert_eq!(f["shadow"], true, "{name}: the house window's shadow");
			}
		}
		for b in ["item", "travel"] {
			if s[b] != json!(false) {
				assert_eq!(s[b], s["wash"], "{key}: the {b} button's hover wash is the skin's");
			}
		}
	}
	assert_ne!(skins["polestar"]["wash"], skins["hearth"]["wash"], "the skins' hover washes differ");
	assert!(skins["polestar"]["item"] != json!(false), "the quest item button was built");
}

// Free mode's Your quests page, its line on the guide window and its tab, through every skin, live: the hand-in card
// is an action tile (`tile`), its buttons and ticks the skin's (`button`, `checkbox`; Turn off is the Main page's, below), and
// every other part of it paints from the skin's tokens (the selection wash and accent bar on the quest the arrow leads
// to, the why line, the order's line, the state glyph, the NPC line's glyph, the step's why line), so a skin or scheme
// restyles all of it without a part of its own. The Codex is tests/fixtures/codex/free-mode.json; Marshal Hale takes
// the two finished quests.
const FREE: &str = r#"
local T, F, UI = Polestar.Theme, Polestar.Free, Polestar.UI
w.accept(7001, { { text = "Ridge Gnoll slain: 0/5", required = 5 } }, "Gnoll Trouble")
w.accept(7007, { { text = "Ridge Gnoll slain: 0/3", required = 3 } }, "Gnoll Bounty")
w.accept(7002, { { text = "Boar Tusk: 0/4", required = 4, type = "item" } }, "Boar Hunt")
w.accept(7003, { { text = "Marsh Lurker slain: 0/6", required = 6 } }, "Lurkers in the Marsh")
stub.advance(1)
w.progress(7001, 1, 5)
w.progress(7007, 1, 3)
stub.advance(1)
assert(F.Start())
stub.advance(1)
F.LeaveOut(7003, true)
stub.advance(1)
UI.ShowFreeMode("quests")
stub.advance(0.3)
local P = F.Page
P.parts.OutH:Click()
stub.advance(0.1)
local GF = UI.GuideFrame
GF.Refill()
local cur
for _, r in ipairs(P.rows) do if r:IsShown() and r.Sel:IsShown() then cur = r end end
local outRow
for _, r in ipairs(P.outRows) do if r:IsShown() then outRow = r end end
local function rgb(...) local r, g, b = ...; return { r, g, b } end
local function same(a, b)
	for i = 1, 3 do if math.abs((a[i] or -1) - (b[i] or -2)) > 0.002 then return false end end
	return true
end
local out = { built = { cur = cur ~= nil, out = outRow ~= nil, group = P.groups[1] ~= nil and P.groups[1]:IsShown() }, skins = {} }
for _, key in ipairs(T.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	stub.advance(0.1)
	local function skin(f) return f and f.psSkin and f.psSkin.skin or false end
	out.skins[key] = {
		tile = skin(P.parts.Handin), segment = skin(P.parts.Near), bringBack = skin(outRow and outRow.Back),
		check = skin(cur and cur.Check),
		sel = cur ~= nil and same(rgb(cur.Sel:GetVertexColor()), rgb(T.Wash("selected"))),
		bar = cur ~= nil and same(rgb(cur.Bar:GetVertexColor()), rgb(T.Color("accent"))),
		why = cur ~= nil and same(rgb(cur.Why:GetTextColor()), rgb(T.Color("textDim"))),
		rule = same(rgb(P.parts.Rule:GetTextColor()), rgb(T.Color("textDim"))),
		status = same(rgb(P.parts.StatusIcon:GetVertexColor()), rgb(T.Color("accent"))),
		group = P.groups[1] ~= nil and same(rgb(P.groups[1].Icon:GetVertexColor()), rgb(T.Color("success"))),
		tileIcon = same(rgb(P.parts.Handin.Icon:GetVertexColor()), rgb(T.Color("accent"))),
		stepWhy = same(rgb(GF.parts.person.Why:GetTextColor()), rgb(T.Color("textDim"))),
	}
end
emit(out)
"#;

fn free_maps() -> String {
	let codex = fixture("free-mode.json");
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.into_iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

#[test]
fn the_free_mode_page_and_its_step_line_follow_every_skin_live_through_skin_parts_and_tokens() {
	let pack = write_codex_pack(&fixture("free-mode.json"), &CodexOpts::default());
	let before = format!(
		"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n",
		pack.stub_lua,
		free_maps()
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], login: true, script: format!("local w = stub.world\n{FREE}"), ..Default::default() })
		.remove(0);
	assert_eq!(out["built"], json!({ "cur": true, "out": true, "group": true }), "the route, a left-out row and an NPC line were drawn");
	let skins = out["skins"].as_object().unwrap();
	assert_eq!(skins.len(), 6);
	for (key, s) in skins {
		for part in ["tile", "segment", "bringBack", "check"] {
			assert_eq!(s[part], json!(key), "{key}: {part} painted by the skin in use");
		}
		for token in ["sel", "bar", "why", "rule", "status", "group", "tileIcon", "stepWhy"] {
			assert_eq!(s[token], true, "{key}: {token} in the skin's own token");
		}
	}
}

// The Free mode page's hero (off: Polestar_FreeMode/Hero.lua), through every skin, live, in each of its
// compositions: Activate is the skin's button (`button`), and the art and text paint from the skin's tokens (the
// emblem and its glow in the accent, the quests' stars' names in the quest colour, the tagline in text, the lead in
// textDim, the line under the button in textMuted), so a skin or scheme restyles the hero without a part of its own.
const HERO: &str = r#"
local T, F, UI = Polestar.Theme, Polestar.Free, Polestar.UI
w.accept(7001, { { text = "Ridge Gnoll slain: 0/5", required = 5 } }, "Gnoll Trouble")
w.accept(7002, { { text = "Boar Tusk: 0/4", required = 4, type = "item" } }, "Boar Hunt")
w.accept(7003, { { text = "Marsh Lurker slain: 0/6", required = 6 } }, "Lurkers in the Marsh")
stub.advance(1)
UI.ShowFreeMode()
stub.advance(0.3)
local P, H = F.Page, F.Hero.parts
local function rgb(...) local r, g, b = ...; return { r, g, b } end
local function same(a, b)
	for i = 1, 3 do if math.abs((a[i] or -1) - (b[i] or -2)) > 0.002 then return false end end
	return true
end
local out = {}
for _, d in ipairs({ "sky", "polaris", "seal" }) do
	Polestar.DB().devFreeHero = d
	for _, key in ipairs(T.SKIN_ORDER) do
		Polestar.Set("ui.skin", key)
		stub.advance(0.1)
		local accent = rgb(T.Color("accent"))
		out[d .. ":" .. key] = {
			button = P.parts.Start.psSkin and P.parts.Start.psSkin.skin or false,
			emblem = same(rgb(H.Emblem:GetVertexColor()), accent),
			glow = same(rgb(H.Glow:GetVertexColor()), accent),
			title = same(rgb(H.Title:GetTextColor()), rgb(T.Color("text"))),
			lead = same(rgb(H.Lead:GetTextColor()), rgb(T.Color("textDim"))),
			note = same(rgb(H.Back:GetTextColor()), rgb(T.Color("textMuted"))),
			quest = d ~= "sky" or same(rgb(H.Labels[1].title:GetTextColor()), rgb(T.Color("quest"))),
		}
	end
end
emit(out)
"#;

#[test]
fn the_free_mode_hero_follows_every_skin_live_in_each_composition_through_the_skin_s_button_and_tokens() {
	let pack = write_codex_pack(&fixture("free-mode.json"), &CodexOpts::default());
	let before = format!(
		"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n",
		pack.stub_lua,
		free_maps()
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], login: true, script: format!("local w = stub.world\n{HERO}"), ..Default::default() })
		.remove(0);
	let all = out.as_object().unwrap();
	assert_eq!(all.len(), 18, "three compositions in six skins");
	for (k, s) in all {
		let skin = k.split(':').nth(1).unwrap();
		assert_eq!(s["button"], json!(skin), "{k}: Activate painted by the skin in use");
		for token in ["emblem", "glow", "title", "lead", "note", "quest"] {
			assert_eq!(s[token], true, "{k}: {token} in the skin's own token");
		}
	}
}

// The Main page while on (the hero's state line and Turn off) and the About page (its title, the four beats' numbers,
// titles and lines, the cases' glyphs), through every skin, live: Turn off is the skin's button, and the rest paints
// from the skin's tokens (the emblem and the state glyph in the accent, the text in text, the lines in textDim).
const ON_ABOUT: &str = r#"
local T, F, UI = Polestar.Theme, Polestar.Free, Polestar.UI
w.accept(7001, { { text = "Ridge Gnoll slain: 0/5", required = 5 } }, "Gnoll Trouble")
w.accept(7002, { { text = "Boar Tusk: 0/4", required = 4, type = "item" } }, "Boar Hunt")
stub.advance(1)
assert(F.Start())
stub.advance(1)
local function rgb(...) local r, g, b = ...; return { r, g, b } end
local function same(a, b)
	for i = 1, 3 do if math.abs((a[i] or -1) - (b[i] or -2)) > 0.002 then return false end end
	return true
end
local out = {}
for _, key in ipairs(T.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	stub.advance(0.1)
	UI.ShowFreeMode("main")
	stub.advance(0.1)
	local P, H = F.Page, F.Hero.parts
	local accent = rgb(T.Color("accent"))
	local s = {
		stop = P.parts.Stop:IsShown() and P.parts.Stop.psSkin and P.parts.Stop.psSkin.skin or false,
		emblem = same(rgb(H.Emblem:GetVertexColor()), accent),
		statusIcon = same(rgb(H.StatusIcon:GetVertexColor()), accent),
		status = same(rgb(H.Status:GetTextColor()), rgb(T.Color("text"))),
		note = same(rgb(H.Back:GetTextColor()), rgb(T.Color("textMuted"))),
	}
	UI.ShowFreeMode("about")
	stub.advance(0.1)
	local A = F.About.parts
	s.title = same(rgb(A.Title:GetTextColor()), rgb(T.Color("text")))
	s.num = same(rgb(A.Beats[1].Num:GetTextColor()), accent)
	s.beat = same(rgb(A.Beats[4].Title:GetTextColor()), rgb(T.Color("text")))
	s.line = same(rgb(A.Beats[2].Text:GetTextColor()), rgb(T.Color("textDim")))
	s.when = same(rgb(A.When[2].Icon:GetVertexColor()), accent)
	s.back = same(rgb(A.BackText:GetTextColor()), rgb(T.Color("textDim")))
	s.beats = #(P.Shown().beats or {})
	out[key] = s
end
emit(out)
"#;

#[test]
fn the_free_mode_main_page_on_and_its_about_page_follow_every_skin_live_through_the_skin_s_button_and_tokens() {
	let pack = write_codex_pack(&fixture("free-mode.json"), &CodexOpts::default());
	let before = format!(
		"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n",
		pack.stub_lua,
		free_maps()
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], login: true, script: format!("local w = stub.world\n{ON_ABOUT}"), ..Default::default() })
		.remove(0);
	let skins = out.as_object().unwrap();
	assert_eq!(skins.len(), 6);
	for (key, s) in skins {
		assert_eq!(s["stop"], json!(key), "{key}: Turn off painted by the skin in use");
		assert_eq!(s["beats"], 4, "{key}: the four beats");
		for token in ["emblem", "statusIcon", "status", "note", "title", "num", "beat", "line", "when", "back"] {
			assert_eq!(s[token], true, "{key}: {token} in the skin's own token");
		}
	}
}
