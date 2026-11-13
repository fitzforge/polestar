//! The settings preview's guide window is the window itself: a copy the live window's own code draws
//! (addon/Polestar/UI/GuideFrame.lua, GF.Copy; the scene of the Guide window and Theme pages, UI/Looks/GuideWindow.lua),
//! fed the preview's sample step through the window's content interface (GF.CONTENT, what the live window reads from
//! the Engine and the modules that work its lines out). Its parts, and which of them show, never differ from the live
//! window's under the same settings and the same content, in every look the picker lists: the live window is handed the
//! sample (GF.UseContent) and both are drawn anew; every shown frame and region of each, by kind, draw layer, texture
//! or atlas, text and colour, under frames of the same kinds, must match. A copy hears nothing (no event, message,
//! setting, login, init or theme hook of its own, no global function hooked) and takes no click, wheel or tooltip: only
//! its frame sees the pointer's hover. The whole addon and every bundled skin over stub_world.lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// The skins in the download (forge_release::addons::SKIN_ADDONS), each a look of its own.
const SKINS: &[(&str, &str)] = &[
	("vellum", "Polestar_Skin_Vellum"),
	("lumen", "Polestar_Skin_Lumen"),
	("beacon", "Polestar_Skin_Beacon"),
	("aurora", "Polestar_Skin_Aurora"),
	("hairline", "Polestar_Skin_Hairline"),
	("umbra", "Polestar_Skin_Umbra"),
	("waymark", "Polestar_Skin_Waymark"),
	("lanterns", "Polestar_Skin_Lanterns"),
	("sheen", "Polestar_Skin_Sheen"),
];
// The six built in: Polestar's own, Halo, Hearth, and the game's looks.
const BUILT_IN: [&str; 6] = ["polestar", "halo", "hearth", "forever", "blizzard", "classic"];

// The client's atlases for the game looks' art (C_Texture), so their pieces draw.
const BEFORE: &str = r#"C_Texture = C_Texture or {}
do
	local real = C_Texture.GetAtlasInfo
	C_Texture.GetAtlasInfo = function(name)
		local info = real and real(name)
		if info then return info end
		if type(name) ~= "string" or name == "" then return nil end
		return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 32, height = 32 }
	end
end"#;

const HELPERS: &str = r#"
local GF = Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
Polestar.UI.LoadOptions()
-- The Guide window page's preview, as the settings window builds it.
local f = Polestar.UI.GuideWindowPreview(UIParent)
f:Show()
stub.advance(0.5)
local copy = f.Scene.Copy
-- Every shown region and frame under `fr`, each with the kinds of the frames above it: kind, draw layer, texture or
-- atlas, text, colour (two places). A frame is counted once, under its own parent.
local REGION = { Texture = true, FontString = true, MaskTexture = true, Line = true }
local function r2(v) return v and math.floor(v * 100 + 0.5) / 100 or "-" end
local function describe(o)
	local k = o:GetObjectType()
	if not REGION[k] then return k end
	local layer, sub = o:GetDrawLayer()
	local d = k .. " " .. tostring(layer) .. " " .. tostring(sub or 0)
	if k == "FontString" then
		local r, g, b = o:GetTextColor()
		return d .. " \"" .. tostring(o:GetText() or "") .. "\" " .. r2(r) .. "," .. r2(g) .. "," .. r2(b)
	end
	if k == "Texture" then
		local r, g, b = o:GetVertexColor()
		return d .. " " .. tostring(o:GetAtlas() or o:GetTexture() or "") .. " " .. r2(r) .. "," .. r2(g) .. "," .. r2(b)
	end
	return d
end
local function walk(fr, path, out)
	for _, r in ipairs({ fr:GetRegions() }) do
		if r:IsShown() then out[#out + 1] = path .. " > " .. describe(r) end
	end
	local seen = {}
	for _, c in ipairs({ fr:GetChildren() }) do
		if not seen[c] and c:GetParent() == fr and c:IsShown() then
			seen[c] = true
			local p = path .. " > " .. describe(c)
			out[#out + 1] = p
			walk(c, p, out)
		end
	end
	return out
end
local function parts(root)
	local out = walk(root, "window", {})
	table.sort(out)
	return out
end
-- What `a` holds that `b` does not, each line counted.
local function minus(a, b)
	local n, out = {}, {}
	for _, s in ipairs(b) do n[s] = (n[s] or 0) + 1 end
	for _, s in ipairs(a) do
		if (n[s] or 0) > 0 then n[s] = n[s] - 1 else out[#out + 1] = s end
	end
	return out
end
"#;

fn run(script: &str) -> Value {
	let mut addons = vec![Addon::name("Polestar")];
	addons.extend(SKINS.iter().map(|(_, a)| Addon::name(a)));
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: BEFORE.into(),
		addons,
		login: true,
		script: format!("{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_preview_s_window_shows_the_live_window_s_parts_in_every_look_and_setting() {
	let looks = BUILT_IN.iter().copied().chain(SKINS.iter().map(|(id, _)| *id)).map(|l| format!("{l:?}")).collect::<Vec<_>>().join(", ");
	let out = run(&format!(
		r#"
local LOOKS = {{ {looks} }}
-- The settings that change which parts show: the style and its backings, compact, every part's switch with Up next
-- open and the grip locked away, the bars at the foot of a window growing upward with the whole step listed and a
-- ground of its own.
local STATES = {{
	{{ name = "default", set = {{}} }},
	{{ name = "dark", set = {{ ["ui.style"] = "transparent", ["ui.backing"] = "dark", ["ui.barShown"] = true }} }},
	{{ name = "soft", set = {{ ["ui.style"] = "transparent", ["ui.backing"] = "soft" }} }},
	{{ name = "compact", set = {{ ["ui.compact"] = true }} }},
	{{ name = "parts", set = {{ ["guideWindow.tabs"] = false, ["guideWindow.progress"] = false, ["guideWindow.skipButton"] = false,
		["guideWindow.reportButton"] = false, ["guideWindow.rules"] = false, ["ui.upcoming"] = 3, ["ui.upcomingOpen"] = true,
		["ui.showNotes"] = false, ["nav.nearbyButton"] = false, ["ui.locked"] = true }} }},
	{{ name = "bottom", set = {{ ["ui.growUp"] = true, ["ui.barsBottom"] = true, ["ui.wholeStep"] = true, ["guideWindow.stepCount"] = false,
		["guideWindow.border"] = false, ["guideWindow.bgColor"] = {{ 0.2, 0.1, 0.3 }} }} }},
}}
-- The live window draws the preview's sample: the same content, so whatever differs is the copy's.
GF.UseContent(copy.content)
-- Both drawn anew, twice, a second apart: a paint a look makes a frame after a window shows, and the done line's
-- glow, have landed.
local function draw()
	for _ = 1, 2 do
		GF.UpdateXP()
		GF.ApplyAll()
		f:Layout(1600, 4000)
		stub.advance(1)
	end
end
local out = {{}}
for _, look in ipairs(LOOKS) do
	Polestar.Set("ui.skin", look)
	for _, st in ipairs(STATES) do
		for k, v in pairs(st.set) do Polestar.Set(k, v) end
		draw()
		local live, mine = parts(GF.frame), parts(copy.frame)
		local missing, extra = minus(live, mine), minus(mine, live)
		out[#out + 1] = {{ at = look .. "/" .. st.name, skin = Polestar.Theme.SkinId(), parts = #live,
			-- What the session raises in the live window alone (a copy shows none): never here.
			session = GF.parts.banner:IsShown() or GF.party:IsShown(),
			missing = table.concat(missing, "\n"), extra = table.concat(extra, "\n") }}
		for k in pairs(st.set) do Polestar.Set(k, nil) end
	end
end
GF.UseContent(nil)
emit(out)"#
	));
	let runs = out.as_array().unwrap();
	assert_eq!(runs.len(), (BUILT_IN.len() + SKINS.len()) * 6, "every look in every state: {out}");
	for r in runs {
		let at = r["at"].as_str().unwrap();
		assert_eq!(r["skin"].as_str().unwrap(), at.split('/').next().unwrap(), "{at}: the look in use");
		assert!(r["parts"].as_u64().unwrap() > 60, "{at}: a whole window drawn: {r}");
		assert_eq!(r["session"], false, "{at}: no banner or party line in the live window: {r}");
		assert_eq!(r["missing"], "", "{at}: shown in the live window, not in the preview's:\n{}", r["missing"].as_str().unwrap());
		assert_eq!(r["extra"], "", "{at}: shown in the preview's window, not in the live one:\n{}", r["extra"].as_str().unwrap());
	}
}

// The parts Fitz found missing from the hand-drawn preview the copy has by being the window: the "+" that opens a tab,
// the search (Lookup), the "Then:" line naming the step's other person, the XP pace line. The sample answers the whole
// content interface; the live window reads the Engine itself (no provider between them on its step change) and its
// five lines from their modules.
#[test]
fn the_preview_s_window_has_the_tab_plus_the_search_the_then_line_and_the_xp_line() {
	let out = run(r#"
		local P = copy.parts
		local thenLine = false
		for _, l in ipairs(copy.lines) do
			if l:IsShown() and (l.Text:GetText() or ""):find("^Then:") then thenLine = true end
		end
		local DERIVED = { StepHint = true, Pace = true, XPStats = true, RestParts = true, Target = true }
		local missing = {}
		for _, name in ipairs(GF.CONTENT) do
			local live = DERIVED[name] and GF.Derived() or GF.Engine()
			if type(live[name]) ~= "function" then missing[#missing + 1] = "live " .. name end
			if type(copy.content[name]) ~= "function" then missing[#missing + 1] = "sample " .. name end
		end
		emit({ plus = P.strip:IsShown() and P.strip.Add:IsShown(), search = P.nav.Lookup:IsShown(), thenLine = thenLine,
			xp = copy.xp:IsShown() and copy.xp.Text:GetText() or false, interface = #GF.CONTENT, missing = table.concat(missing, ", "),
			straight = GF.Engine() == Polestar.Engine and GF.content == nil, copyReads = copy.Engine() == copy.content,
			count = P.nav.Steps.Count:GetText(), tab = copy.tabs[1] and copy.tabs[1].Range:GetText() or false })"#);
	assert_eq!(out["plus"], true, "the + that opens a guide in a new tab");
	assert_eq!(out["search"], true, "the search (Lookup)");
	assert_eq!(out["thenLine"], true, "a Then: line naming the step's other person");
	let xp = out["xp"].as_str().unwrap_or_default();
	assert!(xp.contains("XP/h") && xp.contains("On pace for level 6 by step 12"), "the XP pace line: {xp}");
	assert!(out["interface"].as_u64().unwrap() >= 16, "{out}");
	assert_eq!(out["missing"], "", "the live window and the sample answer the whole interface");
	assert_eq!(out["straight"], true, "the live window reads the Engine itself");
	assert_eq!(out["copyReads"], true, "a copy reads its provider");
	assert_eq!(out["count"], "8 / 29");
	assert_eq!(out["tab"], "(1\u{2013}10)", "the sample's tab with its levels");
}

// A copy has no event, message, setting, login, init or theme hook of its own and hooks no global function: built
// and drawn twice, it registers nothing; then a step change, a tab change and a setting change reach the live window
// and never the copy, which only its host draws. None of its parts takes a click, the wheel or the pointer; its frame
// alone sees the hover, never a click.
#[test]
fn a_copy_hears_nothing_and_takes_no_click() {
	let out = run(r#"
		local counts, real = {}, {}
		local function count(t, name, key)
			real[key] = t[name]
			t[name] = function(...)
				counts[key] = (counts[key] or 0) + 1
				return real[key](...)
			end
		end
		count(Polestar, "On", "message"); count(Polestar, "RegisterEvent", "event"); count(Polestar, "OnLogin", "login")
		count(Polestar, "OnInit", "init"); count(Polestar.Theme, "OnChanged", "theme")
		local hook = hooksecurefunc
		hooksecurefunc = function(a, ...)
			if type(a) == "string" then counts.global = (counts.global or 0) + 1 end
			return hook(a, ...)
		end
		local mine = GF.Copy(UIParent, copy.content)
		mine.Draw()
		mine.Draw()
		hooksecurefunc = hook
		Polestar.On, Polestar.RegisterEvent, Polestar.OnLogin, Polestar.OnInit, Polestar.Theme.OnChanged = real.message, real.event, real.login, real.init, real.theme
		-- What the session sends the live window never draws the copy: it stays as its host drew it.
		local before = mine.frame:GetHeight()
		Polestar.Fire("STEP_CHANGED", 1)
		Polestar.Fire("TABS_CHANGED")
		Polestar.Set("ui.compact", true)
		local still = mine.frame:GetHeight() == before
		Polestar.Set("ui.compact", nil)
		-- The mouse: every part of the copy, and the preview's (a control takes it unless told not to, as in the client).
		local CONTROL = { Button = true, CheckButton = true, EditBox = true, Slider = true }
		local takers = {}
		local function walk(fr)
			for _, c in ipairs({ fr:GetChildren() }) do
				if c:GetParent() == fr then
					local m = rawget(c, "mouse")
					if m == true or (m == nil and CONTROL[c:GetObjectType()]) or rawget(c, "mouseWheel") then takers[#takers + 1] = c:GetObjectType() end
					walk(c)
				end
			end
		end
		walk(mine.frame)
		walk(copy.frame)
		emit({ counts = counts, still = still, takers = table.concat(takers, ", "), name = mine.frame:GetName() or false,
			root = mine.frame:IsMouseEnabled(), live = GF.frame:GetName() })"#);
	let counts = &out["counts"];
	assert!(counts.as_object().is_none_or(|o| o.is_empty()) || counts.as_array().is_some_and(|a| a.is_empty()), "a copy registers nothing: {counts}");
	assert_eq!(out["still"], true, "the session's messages and settings draw no copy: its host does");
	assert_eq!(out["takers"], "", "no part of a copy takes the mouse or the wheel");
	assert_eq!(out["name"], false, "a copy is unnamed");
	assert_eq!(out["root"], true, "its frame sees the pointer's hover");
	assert_eq!(out["live"], "PolestarGuideFrame", "the live window keeps its name");
}
