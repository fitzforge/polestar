//! The group mark (#3580): two heads after a step's name in the guide window's step header and after its number
//! in the step browser's card, in the warning colour for a group choice (`when group`), an escort, elite work at or
//! above the player's level and an author's group size, muted for elites near an object's work or below the
//! player's level; never on dungeon work (the dungeon mark's), a plain step or a step done. The reason leads the
//! header's and the card's tooltip. In every look and the Atlas layout. Against the real Core + Theme + UI
//! manifests, the Atlas layout and the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::Value;

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// A guide of one step per case; the player is level 4 (uistub.player).
const SETUP: &str = r#"
local function G(t, f) f.t = t; return f end
local function kill(name, extra)
	local f = { verb = "Kill", subject = name, subjectKind = "npc", npc = 1, status = "active" }
	for k, v in pairs(extra or {}) do f[k] = v end
	return G("kill", f)
end
local ID = "test/group-mark"
uistub.guides[ID] = { id = ID, pack = "guides", title = "Marks", faction = "Alliance", minLevel = 1, maxLevel = 10, category = "Leveling",
	zone = 0, zoneName = "Elwynn Forest", author = "Polestar", version = 1, steps = {
		{ title = "Mokk", when = { { k = "group", q = 1 } }, goals = { kill("Mokk") } },
		{ title = "The escort", goals = { G("complete", { verb = "Complete", subject = "Escort", subjectKind = "quest", quest = 2, escort = true, status = "active" }) } },
		{ title = "Elites over you", goals = { kill("Brute", { party = { kind = "elite", rank = 1, lvl = 10 } }) } },
		{ title = "Elites under you", goals = { kill("Runt", { party = { kind = "elite", rank = 1, lvl = 2 } }) } },
		{ title = "The crate", goals = { G("interact", { verb = "Use", subject = "Crate", subjectKind = "object", status = "active", party = { kind = "elite", rank = 1, lvl = 10, near = true } }) } },
		{ title = "Plain", goals = { kill("Wolf") } },
		{ title = "The dungeon", goals = { kill("Boss", { party = { kind = "dungeon", name = "The Deadmines" } }) } },
		{ title = "Done escort", goals = { G("complete", { verb = "Complete", subject = "Escort", subjectKind = "quest", quest = 3, escort = true, status = "done" }) } },
		{ title = "Solo way", when = { { k = "group", q = 1, neg = true } }, goals = { kill("Mokk") } },
		{ title = "A party of 3", goals = { kill("Prince", { party = { kind = "group", size = 3 } }) } },
	} }
table.insert(uistub.order, ID)
local UI, GF, SL = Polestar.UI, Polestar.UI.GuideFrame, Polestar.UI.StepList
local GLYPH = "icon%-group"
local function marked(s) return s ~= nil and s:find(GLYPH) ~= nil end
-- The glyph's colour in a text: its r:g:b against a theme token's.
local function tinted(s, token)
	local r, g, b = (s or ""):match("icon%-group[^|]*:(%d+):(%d+):(%d+)|t")
	local R, G2, B = Polestar.Theme.Color(token)
	return r ~= nil and tonumber(r) == math.floor(R * 255 + 0.5) and tonumber(g) == math.floor(G2 * 255 + 0.5) and tonumber(b) == math.floor(B * 255 + 0.5)
end
local function header() return GF.parts.person.Name:GetText() end
local function card(i)
	for _, r in ipairs(SL.rows) do if r:IsShown() and r.psIndex == i then return r end end
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES), Addon::files("Polestar_Skins", &["Layouts/Atlas/Atlas.lua"])],
		script: format!("uistub.install()\nstub.login()\n{SETUP}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn each_case_takes_its_state_and_reason() {
	let out = run(r#"
		uistub.setGuide(ID, 1)
		local E, got = Polestar.Engine, {}
		for i = 1, 10 do
			local state, why = UI.StepMark(E.GetStepView(i), E.GetGuide().steps[i])
			got[i] = state and (state .. ": " .. why) or "none"
		end
		emit(got)"#);
	let got: Vec<String> = out.as_array().unwrap().iter().map(|v| text(v).to_string()).collect();
	assert_eq!(
		got,
		[
			"group: Group, or careful: a group quest, yours to do or skip",
			"group: Group, or careful: an escort that can go wrong",
			"group: Group, or careful: elites at your level or above",
			"careful: Careful: elites, below your level",
			"careful: Careful: elites nearby",
			"none",
			"none",
			"none",
			"none",
			"group: Group, or careful: a group is advised",
		]
	);
}

// The header and the card carry the glyph in their state's colour, its reason leading their tooltips; a plain step
// has none.
#[test]
fn the_step_header_and_the_step_browser_show_it_with_its_reason() {
	let out = run(r#"
		uistub.setGuide(ID, 1)
		local h1 = header()
		uistub.setStep(4)
		local h4 = header()
		uistub.setStep(6)
		local h6 = header()
		uistub.setStep(1)
		stub.RunScript(GF.parts.person, "OnEnter")
		SL.Toggle(true)
		local c1, c4, c6 = card(1), card(4), card(6)
		emit({
			h1 = marked(h1) and tinted(h1, "warning"), h4 = marked(h4) and tinted(h4, "textMuted"), h6 = marked(h6),
			headerWhy = GF.parts.person.psMarkWhy or false,
			c1 = marked(c1.Tab:GetText()) and tinted(c1.Tab:GetText(), "warning"), c4 = marked(c4.Tab:GetText()) and tinted(c4.Tab:GetText(), "textMuted"),
			c6 = marked(c6.Tab:GetText()),
			cardWhy = c1.psWhy[1] and c1.psWhy[1][1] or false,
		})"#);
	assert_eq!(out["h1"], true, "{out}");
	assert_eq!(out["h4"], true, "{out}");
	assert_eq!(out["h6"], false, "{out}");
	assert_eq!(out["headerWhy"], "Group, or careful: a group quest, yours to do or skip", "{out}");
	assert_eq!(out["c1"], true, "{out}");
	assert_eq!(out["c4"], true, "{out}");
	assert_eq!(out["c6"], false, "{out}");
	assert!(text(&out["cardWhy"]).ends_with("Group, or careful: a group quest, yours to do or skip"), "{out}");
}

// Every look, the Atlas layout and a scheme change: the header and the card keep the glyph, recoloured to the
// look's warning colour.
#[test]
fn it_reads_in_every_look_and_the_atlas_layout() {
	let out = run(r#"
		local got = {}
		local function look(key)
			uistub.setGuide(ID, 2)
			SL.Toggle(false)
			local h = header()
			SL.Toggle(true)
			local c = card(2)
			got[key] = marked(h) and tinted(h, "warning") and c ~= nil and tinted(c.Tab:GetText(), "warning") or false
		end
		for _, skin in ipairs(Polestar.Theme.SKIN_ORDER) do
			Polestar.Set("ui.skin", skin)
			look(skin)
		end
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.layout", "atlas")
		look("atlas")
		got.layout = Polestar.Get("ui.layout")
		emit(got)"#);
	let looks = out.as_object().unwrap();
	assert!(looks.len() >= 7, "{out}");
	for (key, v) in looks {
		if key == "layout" {
			assert_eq!(v, "atlas", "{out}");
		} else {
			assert_eq!(v, &Value::Bool(true), "{key}: {out}");
		}
	}
}
