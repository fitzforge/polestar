//! /polestar where (addon/Polestar/Core/Commands.lua): the player's map and position as two guide lines,
//! `zone map <uiMapID>` and `goto <x>,<y> live` (the compiler's two decimals; the client's coordinates are the
//! live frame), printed with the `@x,y live` form for other goals, and shown in a box to copy (UI/Copy.lua).

use forge_addontest::dsl::plain;
use forge_addontest::{emitted, is_match, text, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::parse::parse_guide;
use serde_json::{json, Value};

const SCRIPT: &str = r#"
			stub.login()
			@SETUP@
			local before = #stub.messages
			SlashCmdList.POLESTAR("where")
			local printed = {}
			for i = before + 1, #stub.messages do printed[#printed + 1] = stub.messages[i] end
			local box = PolestarCopy and PolestarCopy:IsShown() and PolestarCopy.Box:GetText() or false
			local out = { printed = printed, box = box, focused = box and stub.focus == PolestarCopy.Box or false }
			@AFTER@
			emit(out)"#;

fn run_where(setup: &str, after: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec!["Polestar".into()], script: SCRIPT.replace("@SETUP@", setup).replace("@AFTER@", after), ..Default::default() }).remove(0)
}

fn printed(out: &Value) -> Vec<&str> {
	out["printed"].as_array().unwrap().iter().map(text).collect()
}

#[test]
fn polestar_where_prints_the_map_and_a_goto_line_at_the_position_with_a_hint_for_other_goals_and_opens_them_in_a_box_to_copy() {
	let out = run_where("stub.world.moveTo(1429, 45.12, 62.34)", "");
	let p = printed(&out);
	let joined = p.join("\n");
	assert_eq!(p.len(), 3, "{joined}");
	assert!(p[0].ends_with("zone map 1429"), "{joined}");
	assert!(p[1].ends_with("goto 45.12,62.34 live"), "{joined}");
	assert!(p[2].ends_with("For another goal, add @45.12,62.34 live"), "{joined}");
	assert_eq!(out["box"], "zone map 1429\ngoto 45.12,62.34 live", "the box holds exactly the two lines to paste");
	assert_eq!(out["focused"], true, "the box takes focus, its text selected for copying");
}

#[test]
fn the_copied_lines_paste_into_a_guide_step_the_zone_then_a_goto_at_the_position_in_the_live_frame() {
	let out = run_where("stub.world.moveTo(1429, 45.12, 62.34)", "");
	let bx = text(&out["box"]).to_string();
	let step: Vec<String> = bx.split('\n').map(|l| format!("  {l}")).collect();
	let mut lines: Vec<String> = ["guide test/where", "title Where", "faction Alliance", "levels 1-2", "zone Elwynn Forest", "", "step Here"].iter().map(|s| s.to_string()).collect();
	lines.extend(step);
	lines.push(String::new());
	let src = lines.join("\n");
	let mut diag = Diagnostics::new();
	let guide = parse_guide(&src, "where.guide", &mut diag);
	let msgs: Vec<String> = diag.sorted().iter().map(|d| format!("{}: {}", d.severity, d.message)).collect();
	assert_eq!(msgs, Vec::<String>::new());
	let goal = guide.get("steps").at(0).get("goals").at(0);
	let o = V::obj();
	o.set("verb", goal.get("verb"));
	o.set("map", goal.get("zone").get("map"));
	o.set("x", goal.get("x"));
	o.set("y", goal.get("y"));
	o.set("frame", goal.get("frame"));
	assert_eq!(plain(&o), json!({ "verb": "goto", "map": 1429, "x": 45.12, "y": 62.34, "frame": "live" }));
}

#[test]
fn polestar_where_keeps_two_decimals_and_says_so_when_the_client_gives_no_position() {
	assert_eq!(run_where("stub.world.moveTo(1429, 7.006, 60)", "")["box"], "zone map 1429\ngoto 7.01,60.00 live");
	let none = run_where("stub.world.moveTo(nil, nil, nil)", "");
	assert_eq!(none["box"], false);
	let p = printed(&none);
	assert_eq!(p.len(), 1);
	assert!(is_match(p[0], r"No position"));
}

#[test]
fn the_copy_box_is_read_only_typing_puts_the_text_back_escape_closes_the_window() {
	let out = run_where(
		"stub.world.moveTo(1429, 45.12, 62.34)",
		r#"
		local b = PolestarCopy.Box
		b:SetText("zone map 1429\ngoto 45.12,62.34 livex")
		stub.RunScript(b, "OnTextChanged", true)
		out.typed = b:GetText()
		stub.RunScript(b, "OnEscapePressed")
		out.closed = not PolestarCopy:IsShown()
		out.special = false
		for _, name in ipairs(UISpecialFrames) do if name == "PolestarCopy" then out.special = true end end"#,
	);
	assert_eq!(out["typed"], "zone map 1429\ngoto 45.12,62.34 live");
	assert_eq!(out["closed"], true);
	assert_eq!(out["special"], true, "the window closes with Escape from anywhere");
}
