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
-- The stub keeps no gradient: a texture records its last one, colours read to two places.
if not rawget(stub.Methods, "SetGradient") then
	stub.Methods.SetGradient = function(self, orient, a, b) self.gradient = { orient, rgba(a:GetRGBA()), rgba(b:GetRGBA()) } end
end
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
	-- Anchored on both sides, its width is the anchors' (`both`).
	local both = L ~= nil and R ~= nil
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
	return { l = L, r = R, t = Tp, b = B, both = both }
end
-- A string's text as drawn, colour codes and textures left out (the stub measures them as letters), and its width
-- at the stub's half a font size per letter.
local function shownWidth(fs)
	local s = tostring(fs:GetText() or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "  ")
	local n = #s - select(2, s:gsub("[\128-\191]", ""))
	return n * select(2, fs:GetFont()) * 0.5
end
-- A string's own width: between its left and right anchors (which win over a set width, as in the client), else
-- its set width; nil where it has none.
local function boxWidth(fs, q)
	q = q or rectOf(fs)
	if q.both then return math.max(0, q.r - q.l) end
	if fs:GetWidth() > 0 then return fs:GetWidth() end
end
-- A string's drawn rect: its text's width (at most its own, where it wraps or is cut) from its left, right or centre,
-- its lines' height down from its top.
local function textRect(fs)
	local q = rectOf(fs)
	local own = boxWidth(fs, q)
	local w = own and math.min(shownWidth(fs), own) or shownWidth(fs)
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
			local own = boxWidth(x)
			if kind == "text" and own and own > 0 then
				-- One line cut at its width, or a wrapped one with more lines than its cap.
				local cap = x:GetWordWrap() == false and 1 or x:GetMaxLines()
				if cap > 0 and math.ceil(shownWidth(x) / own - 0.001) > cap then bad[#bad + 1] = "cut: " .. name(x) end
			end
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

// The arrow's goal, lit as well as barred in the house look: the bar's colour at 13% fading to nothing across the
// row, following the target bar's colour and switch, gone in the transparent style; never made in another look and
// put out by a switch to one.
#[test]
fn the_arrows_goal_is_lit_across_its_row_in_the_house_look_only() {
	let out = run(r#"
		Polestar.Set("ui.skin", "lanterns")
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		local function rowWhere(on)
			for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal and r.Mark:IsShown() == on then return r end end
		end
		local function lit(r) local l = r and r.Mark.psLit; return l and l:IsShown() and l.gradient or false end
		local function read() return { lit = lit(rowWhere(true)), other = lit(rowWhere(false)), accent = rgba(T.Accent()) } end
		layout()
		local out = { lanterns = read(), made = rowWhere(true).Mark.psLit ~= nil }
		Polestar.Set("ui.skin", "polestar"); layout()
		out.house = read()
		Polestar.Set("guideWindow.targetBarColor", { 1, 0, 0 }); out.colour = read()
		Polestar.Set("guideWindow.targetBarColor", nil)
		Polestar.Set("guideWindow.targetBar", false); out.off = read()
		Polestar.Set("guideWindow.targetBar", true)
		Polestar.Set("ui.style", "transparent"); layout(); out.clear = read()
		Polestar.Set("ui.style", "standard"); layout(); out.back = read()
		Polestar.Set("ui.skin", "halo"); layout(); out.halo = read()
		emit(out)"#);
	assert_eq!(out["lanterns"]["lit"], false, "a skin on the house look: the bar alone");
	assert_eq!(out["made"], false, "and no light made for it");
	let a = &out["house"]["accent"];
	assert_eq!(out["house"]["lit"], json!(["HORIZONTAL", [a[0], a[1], a[2], 0.13], [a[0], a[1], a[2], 0]]), "the house: the accent at 13%, fading out");
	assert_eq!(out["house"]["other"], false, "only the arrow's goal is lit");
	assert_eq!(out["colour"]["lit"], json!(["HORIZONTAL", [1, 0, 0, 0.13], [1, 0, 0, 0]]), "in the target bar's own colour");
	let a = &out["off"]["accent"];
	assert_eq!(out["off"]["lit"], json!(["HORIZONTAL", [a[0], a[1], a[2], 0], [a[0], a[1], a[2], 0]]), "off with the target bar");
	assert_eq!(out["clear"]["lit"][1][3], 0, "the transparent style draws no fills");
	assert_eq!(out["back"]["lit"], out["house"]["lit"], "lit again in the standard style");
	assert_eq!(out["halo"]["lit"][1][3], 0, "Halo: put out");
}

#[test]
fn the_lit_goal_spans_its_row_from_the_bar_at_every_width_and_scale() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		local out = {}
		for _, width in ipairs({ 260, 560 }) do
			for _, scale in ipairs({ 0.65, 1, 1.25 }) do
				Polestar.Set("ui.width", width)
				Polestar.Set("ui.scale", scale)
				layout()
				for _, r in ipairs(GF.rows) do
					local l = r.Mark.psLit
					if r:IsShown() and l and l:IsShown() then
						local q, m, row = rectOf(l), rectOf(r.Mark), rectOf(r)
						out[#out + 1] = { at = width .. " x" .. scale, bad = table.concat(breaks(r, { { l } }), " | "),
							fromBar = q.l == m.l and q.t == m.t and q.b == m.b, toEdge = q.r == row.r }
					end
				end
			end
		end
		emit(out)"#);
	let cases = out.as_array().unwrap();
	assert_eq!(cases.len(), 6, "one lit goal at each width and scale: {out}");
	for c in cases {
		let at = &c["at"];
		assert_eq!(c["bad"], "", "{at}: inside its row");
		assert_eq!(c["fromBar"], true, "{at}: over the bar's height, from the bar");
		assert_eq!(c["toEdge"], true, "{at}: to the row's right edge");
	}
}

// The heads-up card's model as a dungeon's (UI/DungeonToast.lua) gives it: both the header the other looks show over
// the title and the house look's facts line.
const CARD: &str = r#"
local CT = Polestar.UI.ClassToast
local function model()
	return { head = "LEVEL 18 · DUNGEON", facts = "Level 18 · Dungeon", title = "The Deadmines is open to you",
		giver = "4 quests to pick up  ·  Levels 17–24  ·  Westfall", badge = "+1.4 LEVELS", icon = T.Media("icon-dungeon"), iconColor = "dungeon",
		titleColor = "text", act = { label = "Pick up the quests" }, more = { label = "Open in Dungeons" }, off = { label = "Turn these off" } }
end
local function names(c)
	c.Title.psName, c.Head.psName, c.Giver.psName, c.Badge.psName, c.Ring.psName, c.Close.psName = "title", "facts", "giver", "chip", "ring", "close"
	c.Act.psName, c.More.psName, c.Later.psName, c.Off.psName, c.Rule.psName = "act", "more", "later", "off", "rule"
	return c
end
"#;

// The house look leads the card with its title and puts the facts under it in sentence case, the chip riding the
// facts line, with no stripe down the edge; the other looks keep 0.3.7's card: the header in capitals over the title,
// the chip beside it, the stripe.
#[test]
fn the_heads_up_card_leads_with_its_title_and_its_facts_under_it_in_the_house_look_only() {
	let out = run(&format!(
		r#"{CARD}
		local c = names(CT.NewCard(UIParent))
		local function y(r) return select(5, r:GetPoint(1)) end
		emit(eachLook(function()
			CT.FillCard(c, model(), 340)
			return {{ head = c.Head:GetText(), stripe = c.Stripe:IsShown(), titleFirst = y(c.Title) > y(c.Head), ringX = select(4, c.Ring:GetPoint(1)),
				chipOnFacts = c.Badge:GetPoint(1) == "TOPLEFT" and select(4, c.Badge:GetPoint(1)) > select(4, c.Head:GetPoint(1)) }}
		end))"#
	));
	let looks = out.as_array().unwrap();
	assert_eq!(looks[0], json!({ "head": "Level 18 · Dungeon", "stripe": false, "titleFirst": true, "ringX": 14, "chipOnFacts": true, "skin": "polestar" }));
	for l in &looks[1..3] {
		let skin = &l["skin"];
		assert_eq!(l["head"], "LEVEL 18 · DUNGEON", "{skin}: the header in capitals");
		assert_eq!(l["stripe"], true, "{skin}: the stripe");
		assert_eq!(l["titleFirst"], false, "{skin}: the header over the title");
		assert_eq!(l["ringX"], 18, "{skin}: the ring beside the stripe");
		assert_eq!(l["chipOnFacts"], false, "{skin}: the chip beside the header, at the top right");
	}
	assert_eq!(looks[3], looks[0], "back on the house skin");
}

// A model without the facts line (an add-on's own heads-up) keeps its header in the house look too, under the title.
#[test]
fn a_heads_up_without_facts_shows_its_header_under_the_title_in_the_house_look() {
	let out = run(&format!(
		r#"{CARD}
		local c = CT.NewCard(UIParent)
		local m = model()
		m.facts = nil
		CT.FillCard(c, m, 340)
		emit({{ head = c.Head:GetText(), titleFirst = select(5, c.Title:GetPoint(1)) > select(5, c.Head:GetPoint(1)) }})"#
	));
	assert_eq!(out, json!({ "head": "LEVEL 18 · DUNGEON", "titleFirst": true }));
}

#[test]
fn the_heads_up_card_lays_out_whole_at_every_width_and_scale_full_and_compact() {
	let out = run(&format!(
		r#"{CARD}
		local c = names(CT.NewCard(UIParent))
		local out = {{}}
		for _, id in ipairs({{ "polestar", "lanterns" }}) do
			Polestar.Set("ui.skin", id)
			for _, compact in ipairs({{ false, true }}) do
				Polestar.Set("toasts.headsup.compact", compact or nil)
				for _, width in ipairs({{ 260, 560 }}) do
					for _, scale in ipairs({{ 0.65, 1, 1.25 }}) do
						c:SetScale(scale)
						CT.FillCard(c, model(), width)
						local parts = {{ {{ c.Ring }}, {{ c.Title, compact and "trim" or "text" }}, {{ c.Close }} }}
						for _, p in ipairs({{ {{ c.Head, "text" }}, {{ c.Badge }}, {{ c.Giver, "text" }}, {{ c.Act }}, {{ c.More }}, {{ c.Later }}, {{ c.Off }}, {{ c.Extra }} }}) do
							if p[1]:IsShown() then parts[#parts + 1] = p end
						end
						out[#out + 1] = {{ at = id .. (compact and " compact " or " ") .. width .. " x" .. scale, bad = table.concat(breaks(c, parts), " | ") }}
					end
				end
			end
		end
		emit(out)"#
	));
	let cases = out.as_array().unwrap();
	assert_eq!(cases.len(), 24);
	for c in cases {
		assert_eq!(c["bad"], "", "{}: nothing cut, overlapping or outside the card", c["at"]);
	}
}

// The While you're here toast (UI/WhileHere.lua) and what it shows: in the house look its band (t.psHouse) over the
// card, else the card itself.
const TOAST: &str = r#"
local WT = Polestar.UI.WhileHereToast
local function line(text) return { step = 3, index = 1, t = "kill", here = "objective", hereText = text or "Kill Kobold Worker, 5 more", yards = 40 } end
local function shown(t) local b = t.psHouse; return (b and b:IsShown()) and b or t end
"#;

// In the house look the toast wears the alerts' anatomy: 360 wide, the night band, the glyph in its ring, the
// distance riding "While you're here" in textDim, the line under it; the movers' box takes its size. The other looks
// keep 0.3.7's card: 320 by 46, the accent edge, the distance ending the line; a look switch while it shows lays it out
// again, and a toast first shown in another look makes no band.
#[test]
fn the_while_here_toast_wears_the_alerts_anatomy_in_the_house_look_only() {
	let out = run(&format!(
		r#"{TOAST}
		Polestar.Set("ui.skin", "lanterns")
		WT.Show(line())
		local t = PolestarWhileHereToast
		local function read()
			local p = shown(t)
			local b = t.psHouse
			return {{ band = p ~= t, w = t:GetWidth(), h = t:GetHeight(), edge = t.Edge:IsShown(), head = p.Head:GetText(), text = p.Text:GetText(),
				ring = b ~= nil and b.Ring:IsVisible(), night = b ~= nil and b.Night:IsVisible(), size = {{ WT.Size() }} }}
		end
		local out = {{ lanterns = read(), made = t.psHouse ~= nil }}
		Polestar.Set("ui.skin", "polestar")
		out.house = read()
		out.dim = T.Hex("textDim")
		Polestar.Set("ui.skin", "halo")
		out.halo = read()
		emit(out)"#
	));
	let plain = json!({ "band": false, "w": 320, "h": 46, "edge": true, "head": "While you're here", "text": "Kill Kobold Worker, 5 more  \u{b7}  40 yd",
		"ring": false, "night": false, "size": [320, 46] });
	assert_eq!(out["lanterns"], plain, "a skin on the house look: 0.3.7's card");
	assert_eq!(out["made"], false, "and no band made for it");
	let dim = out["dim"].as_str().unwrap();
	assert_eq!(
		out["house"],
		json!({ "band": true, "w": 360, "h": 56, "edge": false, "head": format!("While you're here  \u{b7}  |c{dim}40 yd|r"),
			"text": "Kill Kobold Worker, 5 more", "ring": true, "night": true, "size": [360, 56] }),
		"the house look: the alerts' anatomy, laid out again on the switch"
	);
	assert_eq!(out["halo"], plain, "Halo: 0.3.7's card again, the band put away");
}

#[test]
fn the_house_while_here_toast_lays_out_whole_on_one_line_or_two_at_every_scale() {
	let out = run(&format!(
		r#"{TOAST}
		local out = {{}}
		for _, text in ipairs({{ "Kill Kobold Worker, 5 more", "Hand in The Fargodeep Mine and Its Many Kobold Tunnels to Marshal Dughan" }}) do
			for _, scale in ipairs({{ 0.65, 1, 1.25 }}) do
				Polestar.Set("ui.scale", scale)
				WT.Show(line(text))
				local t = PolestarWhileHereToast
				local b = t.psHouse
				b.Head.psName, b.Text.psName, b.Ring.psName, b.Icon.psName = "head", "line", "ring", "glyph"
				out[#out + 1] = {{ at = #text .. " x" .. scale, bad = table.concat(breaks(t, {{ {{ b.Ring }}, {{ b.Head, "text" }}, {{ b.Text, "text" }} }}), " | "),
					glyphInRing = select(2, b.Icon:GetPoint(1)) == b.Ring, lines = b.Text:GetNumLines(), h = t:GetHeight() }}
			end
		end
		emit(out)"#
	));
	for c in out.as_array().unwrap() {
		assert_eq!(c["bad"], "", "{}: nothing cut, overlapping or outside the toast", c["at"]);
		assert_eq!(c["glyphInRing"], true);
	}
	let cases = out.as_array().unwrap();
	assert_eq!((cases[0]["lines"].as_i64(), cases[0]["h"].as_i64()), (Some(1), Some(56)), "one line: 56 tall");
	assert_eq!(cases[3]["lines"], 2, "a long hand-in on two lines, not cut");
	assert!(cases[3]["h"].as_f64().unwrap() > 56.0, "and the toast grows to hold them");
}

// A house window's edges (Theme/House.lua, the window painter): once it is on screen, a 1px light inside its top edge
// under the border (ink at 7% of the ground's opacity) and, with the drop shadow, a 1px contact line just outside it
// and its border (shade at 42%). The shadow off leaves the light; the transparent style, another look or the border's
// thickness move or put them away as they should.
#[test]
fn a_house_window_carries_its_light_and_contact_edges_and_no_other_look_does() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		layout()
		local d = F.psSkin
		local function read()
			local e = d.edge
			if not e then return { made = false } end
			local function at(t, i) local p, _, rp, x, y = t:GetPoint(i); return p .. ">" .. rp .. "@" .. (x + 0) .. "," .. (y + 0) end
			return { made = true, light = e[1]:IsShown() and rgba(e[1]:GetVertexColor()) or false, lightAt = at(e[1], 1),
				contact = e[2]:IsShown() and rgba(e[2]:GetVertexColor()) or false, topAt = at(e[2], 1), leftAt = at(e[4], 1),
				ink = rgba(T.Color("ink")), shade = rgba(T.Color("shade")), alpha = round(T.GroundAlpha()) }
		end
		local out = { house = read() }
		Polestar.Set("ui.shadow", false); out.noShadow = read()
		Polestar.Set("ui.shadow", nil)
		Polestar.Set("ui.borderSize", 3); out.thick = read()
		Polestar.Set("ui.borderSize", nil)
		Polestar.Set("ui.style", "transparent"); layout(); out.clear = read()
		Polestar.Set("ui.style", "standard"); layout()
		for _, id in ipairs({ "halo", "lanterns" }) do Polestar.Set("ui.skin", id); layout(); out[id] = read() end
		Polestar.Set("ui.skin", "polestar"); layout(); out.back = read()
		-- A window built and hidden at once, never opened: no edges; opened: its edges.
		-- (Built by a chunk the stub counts as the addon's, as a module builds its windows.)
		stub.addonSources["@glow-window"] = true
		local w = loadstring([[
			local w = CreateFrame("Frame", nil, UIParent)
			w:SetSize(200, 100)
			Polestar.Theme.Skin(w, "window")
			w:Hide()
			return w]], "@glow-window")()
		stub.advance(1)
		out.unopened = w.psSkin.edge ~= nil
		w:Show()
		out.opened = w.psSkin.edge ~= nil and w.psSkin.edge[1]:IsShown()
		emit(out)"#);
	let h = &out["house"];
	let (ink, shade, alpha) = (&h["ink"], &h["shade"], h["alpha"].as_f64().unwrap());
	let r2 = |v: f64| (v * 100.0).round() / 100.0;
	assert_eq!(h["light"], json!([ink[0], ink[1], ink[2], r2(0.07 * alpha.min(1.0))]), "the light: ink at 7% of the ground's opacity");
	assert_eq!(h["contact"], json!([shade[0], shade[1], shade[2], r2(0.42 * (alpha + 0.1).min(1.0))]), "the contact line: shade at 42%");
	assert_eq!(h["lightAt"], "TOPLEFT>TOPLEFT@1,-1", "the light under the border's pixel");
	assert_eq!(h["topAt"], "BOTTOMLEFT>TOPLEFT@-1,0", "the contact line just outside the 1px border");
	assert_eq!(h["leftAt"], "TOPRIGHT>TOPLEFT@0,0");
	assert_eq!(out["noShadow"]["light"], h["light"], "the shadow off keeps the light");
	assert_eq!(out["noShadow"]["contact"], false, "and puts the contact line away with the shadow");
	assert_eq!(out["thick"]["topAt"], "BOTTOMLEFT>TOPLEFT@-3,2", "a 3px border: the contact line outside its outer pixel");
	assert_eq!(out["thick"]["lightAt"], "TOPLEFT>TOPLEFT@1,-1", "the light still under its inner pixel");
	assert_eq!((out["clear"]["light"].clone(), out["clear"]["contact"].clone()), (json!(false), json!(false)), "the transparent style: none");
	for id in ["halo", "lanterns"] {
		assert_eq!((out[id]["light"].clone(), out[id]["contact"].clone()), (json!(false), json!(false)), "{id}: none");
	}
	assert_eq!(out["back"]["light"], h["light"], "the house look again: its edges");
	assert_eq!(out["unopened"], false, "a window never opened makes none");
	assert_eq!(out["opened"], true, "it makes them on its first showing");
}

// The guide window's hairlines (guideWindow.rules): the house look keeps them round the tabs and the navigator and
// over the footer (the XP line, the banner), and lets the body's sections ("Then:", Along the way, Up next, the party)
// breathe on spacing; every other look keeps them all; the setting off takes them all away in every look.
#[test]
fn the_house_look_keeps_the_chrome_hairlines_and_drops_the_body_sections_ones() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		local P = GF.parts
		local function read()
			local a = function(part) return part.Rule:IsShown() and 1 or 0 end
			return { strip = P.strip.Rule:IsShown(), nav = P.nav.Rule:IsShown(), after = a(P.after), along = a(P.along), upnext = a(P.upnext.Toggle),
				party = a(GF.party), xp = a(GF.xp), banner = a(P.banner) }
		end
		local out = { looks = eachLook(read) }
		Polestar.Set("guideWindow.rules", false)
		out.off = eachLook(read)
		emit(out)"#);
	let looks = out["looks"].as_array().unwrap();
	assert_eq!(
		looks[0],
		json!({ "strip": true, "nav": true, "after": 0, "along": 0, "upnext": 0, "party": 0, "xp": 1, "banner": 1, "skin": "polestar" }),
		"the house look: round the chrome and over the footer only"
	);
	for l in &looks[1..3] {
		let skin = &l["skin"];
		for k in ["after", "along", "upnext", "party", "xp", "banner"] {
			assert_eq!(l[k], 1, "{skin}: {k}'s rule kept");
		}
		assert_eq!((l["strip"].as_bool(), l["nav"].as_bool()), (Some(true), Some(true)), "{skin}");
	}
	assert_eq!(looks[3], looks[0], "back on the house skin");
	for l in out["off"].as_array().unwrap() {
		let skin = &l["skin"];
		for k in ["after", "along", "upnext", "party", "xp", "banner"] {
			assert_eq!(l[k], 0, "{skin}: rules off, {k}'s gone");
		}
		assert_eq!((l["strip"].as_bool(), l["nav"].as_bool()), (Some(false), Some(false)), "{skin}");
	}
}

// A lone tab: in the house look it takes the room its title and range need, up to the strip, so "Elwynn Forest
// (1–13)" reads whole instead of cut beside an empty strip; a title longer than the strip truncates inside it. Every
// other look keeps the 150-unit tab, and two tabs share the strip as before in every look.
#[test]
fn a_lone_tab_shows_its_whole_title_in_the_house_look_at_every_width_and_scale() {
	let out = run(r#"
		Polestar.Set("ui.shown", true)
		local LONG = "forever/exploration/eastern-kingdoms-1-30"
		local function tab(i)
			local b = GF.tabs[i]
			return { w = b:GetWidth(), whole = b.Label:IsShown() and b.Label:GetWidth() >= b.psTitleW, range = b.Range:IsShown(),
				inside = rectOf(b).r <= rectOf(GF.parts.strip).r + 0.5, avail = F:GetWidth() - 32 }
		end
		local out = {}
		for _, id in ipairs({ "polestar", "lanterns" }) do
			Polestar.Set("ui.skin", id)
			for _, width in ipairs({ 260, 560 }) do
				for _, scale in ipairs({ 0.64, 0.65, 1, 1.25, 1.5 }) do
					Polestar.Set("ui.width", width)
					Polestar.Set("ui.scale", scale)
					uistub.openTabs({ { uistub.elwynn, 3 } }, 1); layout()
					local short = tab(1)
					uistub.openTabs({ { LONG, 1 } }, 1); layout()
					local long = tab(1)
					uistub.openTabs(TABS, 1); layout()
					out[#out + 1] = { look = id, width = width, scale = scale, short = short, long = long, two = { tab(1).w, tab(2).w } }
				end
			end
		end
		emit(out)"#);
	let cases = out.as_array().unwrap();
	for c in cases {
		let at = format!("{} {} x{}", c["look"], c["width"], c["scale"]);
		let (short, long) = (&c["short"], &c["long"]);
		assert_eq!(short["inside"], true, "{at}: the tab inside the strip");
		assert_eq!(long["inside"], true, "{at}: a long title's tab inside the strip");
		if c["look"] == "polestar" {
			assert!(short["w"].as_f64().unwrap() > 150.0, "{at}: wider than the shared tab: {short}");
			assert_eq!((short["whole"].as_bool(), short["range"].as_bool()), (Some(true), Some(true)), "{at}: the whole title and its range");
			if c["width"] == 560 {
				assert_eq!(long["whole"], true, "{at}: room for the long title");
			} else {
				assert_eq!(long["w"], long["avail"], "{at}: the long title takes the whole strip and truncates there");
			}
		} else {
			assert_eq!(short["w"], 150, "{at}: the shared tab's width");
			assert_eq!(short["whole"], false, "{at}: its title cut, as before");
		}
		let other = cases.iter().find(|o| o["look"] != c["look"] && o["width"] == c["width"] && o["scale"] == c["scale"]).unwrap();
		assert_eq!(c["two"], other["two"], "{at}: two tabs share the strip alike in every look");
	}
}

// The tick boxes: the house look's well is the shade at 12% (it was 35%, a column of black squares down the window's
// edge); a skin built on the house look keeps 35%, Halo its own input ground, and on the world (the transparent
// style) every look keeps the scrim inside.
#[test]
fn the_house_look_draws_a_lighter_tick_box_well() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", true)
		local function well()
			for _, r in ipairs(GF.rows) do
				if r:IsShown() and r.Check:IsShown() then return rgba(r.Check.psSkin.box.psSkin.bg:GetVertexColor()) end
			end
		end
		local out = { looks = eachLook(function() return { well = well(), shade = rgba(T.Color("shade")), input = rgba(T.Color("inputBg")) } end) }
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.style", "transparent"); layout()
		out.clear = well()
		emit(out)"#);
	let looks = out["looks"].as_array().unwrap();
	let s = &looks[0]["shade"];
	assert_eq!(looks[0]["well"], json!([s[0], s[1], s[2], 0.12]), "the house look: the shade at 12%");
	assert_eq!(looks[1]["well"], looks[1]["input"], "Halo: its own input ground");
	let s = &looks[2]["shade"];
	assert_eq!(looks[2]["well"], json!([s[0], s[1], s[2], 0.35]), "a skin on the house look: 35%, as before");
	assert_eq!(looks[3]["well"], looks[0]["well"], "back on the house skin");
	assert_eq!(out["clear"][3], 0.6, "on the world: the scrim inside, as before");
}
