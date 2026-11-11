//! The house look's own touches (the 0.3.8 glow-up: Theme/House.lua's tokens, answered by Theme.House; docs/DESIGN.md,
//! "The House Look's Own Touches"): each shows in Polestar's built-in house skin and nowhere else. A skin registered
//! on the house look (Lanterns), Halo and a picker card of another skin keep their own way, number for number. Each
//! touch is laid out at the window's narrowest and widest (260 and 560) and at window scales 0.65, 1 and 1.25 with
//! nothing cut, nothing overlapping and everything inside its card. Against the real Core + Theme + UI manifests, the
//! fake Engine (tests/lua/stub_ui.lua) and one bundled skin addon.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Lua helpers: the looks every test walks, a colour read to two places, a region's rect resolved from its anchors
// the way the client lays them out (the stub keeps the anchors only), and what a laid-out card breaks: a string
// wider than its own width, two of its parts overlapping, a part outside the card.
const HELPERS: &str = r#"
local T = Polestar.Theme
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }
local function round(v) return v and math.floor(v * 100 + 0.5) / 100 end
local function rgba(...) local c = { ... }; for i = 1, 4 do c[i] = round(c[i] or 1) end; return c end
local function layout() GF.Layout(); stub.advance(1) end
-- The house skin, the looks that keep their own way, then the house again (a switch back restores it).
local LOOKS = { "polestar", "halo", "lanterns", "polestar" }
local function eachLook(f)
	local out = {}
	for i, id in ipairs(LOOKS) do
		Polestar.Set("ui.skin", id)
		layout()
		out[i] = f(id)
		out[i].skin = T.SkinId()
	end
	return out
end
local function rectOf(r)
	if r == nil or r == UIParent then return { l = 0, b = 0, r = UIParent:GetWidth(), t = UIParent:GetHeight() } end
	local L, R, Tp, B, cx, cy
	local sf = r:GetParent()
	if #r.points == 0 and sf and sf.scrollChild == r then
		local o = rectOf(sf)
		L, Tp = o.l, o.t + sf:GetVerticalScroll()
	end
	for _, p in ipairs(r.points) do
		local o = rectOf(p.rel or r:GetParent())
		local rp = p.relPoint
		local px = rp:find("LEFT") and o.l or rp:find("RIGHT") and o.r or (o.l + o.r) / 2
		local py = rp:find("TOP") and o.t or rp:find("BOTTOM") and o.b or (o.b + o.t) / 2
		px, py = px + p.x, py + p.y
		if p.point:find("LEFT") then L = px elseif p.point:find("RIGHT") then R = px else cx = px end
		if p.point:find("TOP") then Tp = py elseif p.point:find("BOTTOM") then B = py else cy = py end
	end
	local w, h = r:GetWidth(), r:GetHeight()
	-- A string with no size of its own takes its text's, as in the client.
	if r.GetStringHeight then
		if w == 0 then w = r:GetStringWidth() end
		if h == 0 then h = r:GetStringHeight() end
	end
	L = L or (R and R - w) or (cx or 0) - w / 2
	R = R or L + w
	Tp = Tp or (B and B + h) or (cy or 0) + h / 2
	B = B or Tp - h
	return { l = L, r = R, t = Tp, b = B }
end
-- A string's text as drawn, colour codes and textures left out (the stub measures them as letters), and its width
-- at the stub's half a font size per letter.
local function shownWidth(fs)
	local s = tostring(fs:GetText() or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "  ")
	local n = #s - select(2, s:gsub("[\128-\191]", ""))
	return n * select(2, fs:GetFont()) * 0.5
end
-- A string's drawn rect: its text's width (at most its own, where it wraps or is cut) from its left, right or centre,
-- its lines' height down from its top.
local function textRect(fs)
	local q = rectOf(fs)
	local w = fs:GetWidth() > 0 and math.min(shownWidth(fs), fs:GetWidth()) or shownWidth(fs)
	local j = fs:GetJustifyH()
	if j == "RIGHT" then q.l = q.r - w elseif j == "CENTER" then local c = (q.l + q.r) / 2; q.l, q.r = c - w / 2, c + w / 2 else q.r = q.l + w end
	q.b = q.t - fs:GetStringHeight()
	return q
end
local function name(x) return x.psName or (x.GetText and x:GetText()) or x:GetObjectType() end
local function over(a, b) return a.l < b.r - 0.5 and b.l < a.r - 0.5 and a.b < b.t - 0.5 and b.b < a.t - 0.5 end
local function inside(a, o) return a.l >= o.l - 0.5 and a.r <= o.r + 0.5 and a.t <= o.t + 0.5 and a.b >= o.b - 0.5 end
-- parts: { { region, kind }, ... } laid out in `card`, kind "text" for a string shown whole, "trim" for one that may
-- end in "…" where it runs out of room, nothing for any other region. -> what breaks, as words (empty when nothing
-- does): a whole string cut short, a part outside the card, two parts overlapping.
local function breaks(card, parts)
	local bad, rects, box = {}, {}, rectOf(card)
	for i, p in ipairs(parts) do
		local x, kind = p[1], p[2]
		if kind then
			if kind == "text" and x:GetWordWrap() == false and x:GetWidth() > 0 and shownWidth(x) > x:GetWidth() + 0.5 then bad[#bad + 1] = "cut: " .. name(x) end
			rects[i] = textRect(x)
		else
			rects[i] = rectOf(x)
		end
		if not inside(rects[i], box) then bad[#bad + 1] = "outside: " .. name(x) end
	end
	for i = 1, #parts do
		for j = i + 1, #parts do
			if over(rects[i], rects[j]) then bad[#bad + 1] = "overlap: " .. name(parts[i][1]) .. " / " .. name(parts[j][1]) end
		end
	end
	return bad
end
-- Two While you're here lines: an objective with its distance, and a long hand-in that wraps.
local function hereList()
	return {
		{ step = 3, index = 1, t = "kill", here = "objective", text = "Kill Kobold Worker", verb = "Kill", subject = "Kobold Worker", subjectKind = "npc",
			progress = { cur = 3, max = 8 }, yards = 40 },
		{ step = 5, index = 1, t = "turnin", here = "turnin", quest = 62, hereTitle = "The Fargodeep Mine and Its Many Kobold Tunnels",
			hereText = "Hand in The Fargodeep Mine and Its Many Kobold Tunnels to Marshal Dughan", later = true, yards = 1250 },
	}
end
local function showHere()
	Polestar.Engine.GetWhileHereList = hereList
	GF.FillHere(Polestar.Engine)
	layout()
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES), Addon::name("Polestar_Skin_Lanterns")],
		script: format!("uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_house_tokens_answer_only_while_the_house_skin_itself_is_drawn() {
	let out = run(r#"
		local I = Polestar.ThemeInternal
		local function ask() return { raised = T.House("raised") or false, unknown = T.House("nothing") or false, base = T.SkinKey(), skin = T.SkinId() } end
		local out = { looks = {} }
		for _, id in ipairs(LOOKS) do Polestar.Set("ui.skin", id); out.looks[#out.looks + 1] = ask() end
		-- A picker card answers for the skin it draws: another skin's card on the house look, the house's card on Lanterns.
		Polestar.Set("ui.skin", "polestar")
		I.drawing.id = "lanterns"
		out.lanternsCard = ask()
		I.drawing.id = nil
		Polestar.Set("ui.skin", "lanterns")
		I.drawing.id = "polestar"
		out.houseCard = ask()
		I.drawing.id = nil
		emit(out)"#);
	let looks = &out["looks"];
	assert_eq!(looks[0], json!({ "raised": 0.85, "unknown": false, "base": "polestar", "skin": "polestar" }), "the house skin: its tokens");
	assert_eq!(looks[1], json!({ "raised": false, "unknown": false, "base": "halo", "skin": "halo" }), "Halo: none");
	assert_eq!(looks[2], json!({ "raised": false, "unknown": false, "base": "polestar", "skin": "lanterns" }), "a skin on the house look: none");
	assert_eq!(looks[3], looks[0], "back on the house skin: its tokens again");
	assert_eq!(out["lanternsCard"]["raised"], false, "another skin's picker card: none");
	assert_eq!(out["houseCard"]["raised"], 0.85, "the house skin's picker card: its tokens");
}

#[test]
fn while_youre_here_is_a_raised_card_in_the_house_look_and_keeps_the_accent_panel_elsewhere() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		showHere()
		local here = GF.here
		local function look()
			local edges = here.psHairline and here.psHairline.psBorder
			local pr, pg, pb = here.Panel:GetVertexColor()
			return { panel = rgba(here.Panel:GetVertexColor()), hairline = edges ~= nil and edges[1]:IsShown(), edge = here.Edge:IsShown(),
				rowSize = select(2, GF.HereRow(1).Text:GetFont()), raised = rgba(T.Color("panelAlt")), accentGround = rgba(T.AccentGround(GF.HERE_TINT)),
				border = rgba(T.Color("border")), hairlineColor = edges and edges[1]:IsShown() and rgba(edges[1]:GetVertexColor()) or false,
				contrast = T.Contrast({ T.Color("text") }, { pr, pg, pb }) }
		end
		local out = { looks = eachLook(look) }
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.style", "transparent")
		layout()
		out.clear = look()
		out.scrim = rgba(T.Color("scrim"))
		Polestar.Set("ui.skin", "halo")
		layout()
		out.haloClear = look()
		out.accent = rgba(T.Accent())
		emit(out)"#);
	let looks = out["looks"].as_array().unwrap();
	let house = &looks[0];
	let raised = &house["raised"];
	assert_eq!(house["panel"], json!([raised[0], raised[1], raised[2], 0.85]), "the house: the control ground at 85%");
	assert_eq!(house["hairline"], true, "the house: under a hairline");
	assert_eq!(house["hairlineColor"], house["border"], "the hairline in the border token");
	assert_eq!(house["edge"], false, "the house: no accent edge");
	assert_eq!(house["rowSize"], 13, "the house: its rows in Body, a size under the step's goals");
	assert!(house["contrast"].as_f64().unwrap() >= 7.0, "the house: its text reads at 7:1 on the card: {house}");
	for l in &looks[1..3] {
		let skin = &l["skin"];
		assert_eq!(l["panel"], l["accentGround"], "{skin}: the accent at 22% in the window ground, as before");
		assert_eq!(l["hairline"], false, "{skin}: no hairline");
		assert_eq!(l["edge"], true, "{skin}: the accent edge");
		assert_eq!(l["rowSize"], 14, "{skin}: its rows in Goal type");
	}
	assert_eq!(looks[3]["panel"], house["panel"], "back on the house skin, its card again");
	assert_eq!(looks[3]["rowSize"], 13);
	let clear = &out["clear"];
	let scrim = &out["scrim"];
	assert_eq!(clear["panel"], json!([scrim[0], scrim[1], scrim[2], 0.32]), "the house, transparent: the scrim at 32%");
	assert_eq!(clear["hairline"], false, "the house, transparent: no hairline");
	assert_eq!(clear["edge"], false);
	let accent = &out["accent"];
	assert_eq!(out["haloClear"]["panel"], json!([accent[0], accent[1], accent[2], 0.18]), "Halo, transparent: the accent at 18%, as before");
	assert_eq!(out["haloClear"]["edge"], true);
}

#[test]
fn while_youre_here_lays_out_whole_at_every_width_and_scale() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		local out = {}
		for _, id in ipairs({ "polestar", "lanterns" }) do
			Polestar.Set("ui.skin", id)
			for _, width in ipairs({ 260, 560 }) do
				for _, scale in ipairs({ 0.65, 1, 1.25 }) do
					Polestar.Set("ui.width", width)
					Polestar.Set("ui.scale", scale)
					showHere()
					local here, bad = GF.here, {}
					for i = 1, 2 do
						local r = GF.HereRow(i)
						r.Text.psName, r.Dist.psName, r.Sub.psName = "text " .. i, "distance " .. i, "step " .. i
						for _, b in ipairs(breaks(r, { { r.Icon }, { r.Text, "text" }, { r.Dist, "text" }, { r.Close }, { r.Sub, "trim" } })) do bad[#bad + 1] = b end
						if not (rectOf(r).b >= rectOf(here.Panel).b - 0.5) then bad[#bad + 1] = "row " .. i .. " below the card" end
					end
					out[#out + 1] = { at = id .. " " .. width .. " x" .. scale, bad = table.concat(bad, " | "), shown = here:IsShown(),
						rows = GF.HereRow(2):IsShown(), wraps = GF.HereRow(2).Text:GetStringHeight() > select(2, GF.HereRow(2).Text:GetFont()) }
				end
			end
		end
		emit(out)"#);
	for c in out.as_array().unwrap() {
		let at = &c["at"];
		assert_eq!(c["shown"], true, "{at}: the card is on screen");
		assert_eq!(c["rows"], true, "{at}: both lines are");
		assert_eq!(c["bad"], "", "{at}: nothing cut, overlapping or outside its row");
	}
	assert!(out.as_array().unwrap().iter().any(|c| c["wraps"] == true), "the long hand-in wraps somewhere rather than being cut");
}
