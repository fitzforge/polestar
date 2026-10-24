//! Tabs of guides whose pack is missing or switched off (Engine "Tabs" with the guide pack registry): they stay
//! saved, with their pins, and come back in their old place when the guide is there again.

use forge_addontest::{emitted, truthy, Addon, RunAddon, TEST_PACK};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
"#;

const STEPS: &str = r#"steps = { { goals = { { t = "level", level = 50 } } }, { goals = { { t = "level", level = 55 } } }, { goals = { { t = "level", level = 60 } } } }"#;

const TEST_GUIDES: &str = r#"
${TEST_PACK}
for i = 1, 8 do
	Polestar.RegisterGuide({ id = "test/" .. i, pack = "test", title = "T" .. i, category = "Exploration", ${STEPS} })
end
Polestar.RegisterGuide({ id = "test/x", pack = "test", title = "X", category = "Exploration", ${STEPS} })
"#;

const JOE: &str = r#"
Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = "Joe", author = "Joe", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "joe/a", pack = "joe", title = "A", category = "Exploration", ${STEPS} })
Polestar.RegisterGuide({ id = "joe/b", pack = "joe", title = "B", category = "Exploration", ${STEPS} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function ids()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { tabs = out, active = active }
end
function stepOf(id)
	for _, t in ipairs(E.GetTabs()) do if t.guideId == id then return t.stepIndex end end
	return false
end
-- SavedVariables as the client writes them back.
function dump(t)
	if type(t) ~= "table" then return t == nil and "nil" or (type(t) == "string" and string.format("%q", t) or tostring(t)) end
	local parts = {}
	local keys = {}
	for k in pairs(t) do keys[#keys + 1] = k end
	table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
	for _, k in ipairs(keys) do
		local key = type(k) == "number" and ("[" .. k .. "]") or ("[" .. string.format("%q", k) .. "]")
		parts[#parts + 1] = key .. " = " .. dump(t[k])
	end
	return "{ " .. table.concat(parts, ", ") .. " }"
end
"#;

fn fill(lua: &str) -> String {
	lua.replace("${TEST_PACK}", TEST_PACK).replace("${STEPS}", STEPS)
}

fn run(joe: bool, saved: Option<&str>, script: &str) -> Value {
	let joe_lua = if joe { fill(JOE) } else { String::new() };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [fill(TEST_GUIDES).as_str(), joe_lua.as_str(), HELPERS, "stub.login(); flush()", script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

const SAVED: &str = r#"PolestarCharDB = { schema = 1, tabs = { "joe/a", "test/x" }, activeTab = 1, pins = { ["joe/a"] = { step = 3, done = false }, ["test/x"] = { step = 2, done = false } } }"#;

fn has(v: &Value, id: &str) -> bool {
	v.as_array().unwrap().iter().any(|x| x.as_str() == Some(id))
}

fn joined(v: &Value) -> String {
	v.as_array().unwrap().iter().map(|x| x.as_str().unwrap_or("").to_string()).collect::<Vec<_>>().join(",")
}

#[test]
fn a_missing_pack_s_tab_stays_saved_with_its_pin_and_comes_back_in_its_old_place_at_its_step() {
	let first = run(
		false,
		Some(SAVED),
		r#"
			local r = { login = ids(), step = stepOf("test/x") }
			E.OpenTab("test/1", false); flush()
			r.saved = PolestarCharDB.tabs
			r.pin = PolestarCharDB.pins["joe/a"] or false
			r.state = dump(PolestarCharDB)
			emit(r)
		"#,
	);
	assert_eq!(first["login"], json!({ "tabs": ["test/x"], "active": 1 }));
	assert_eq!(first["step"], 2);
	assert_eq!(first["saved"], json!(["test/x", "test/1", "joe/a"]));
	assert_eq!(first["pin"], json!({ "step": 3, "done": false }));

	let saved = format!("PolestarCharDB = {}", first["state"].as_str().unwrap());
	let second = run(true, Some(&saved), r#"emit({ ids = ids(), step = stepOf("joe/a"), saved = PolestarCharDB.tabs })"#);
	assert_eq!(second["ids"]["tabs"], json!(["joe/a", "test/x", "test/1"]));
	assert_eq!(second["step"], 3);
	assert_eq!(second["saved"], json!(["joe/a", "test/x", "test/1"]));
}

#[test]
fn switching_a_pack_off_closes_its_tabs_and_keeps_them_saved_on_again_they_return_in_order_at_their_step() {
	let out = run(
		true,
		None,
		r#"
			E.OpenTab("test/x"); E.OpenTab("joe/a"); E.OpenTab("test/1"); E.OpenTab("joe/b")
			E.SelectTab(2); E.Goto(3); flush()
			local r = { before = ids() }
			Polestar.Guides.SetPackShown("joe", false); flush()
			r.hidden = ids()
			r.guide = E.GetGuide().id
			r.saved = PolestarCharDB.tabs
			r.pin = PolestarCharDB.pins["joe/a"] or false
			Polestar.Guides.SetPackShown("joe", true); flush()
			r.back = ids()
			r.step = stepOf("joe/a")
			r.savedBack = PolestarCharDB.tabs
			emit(r)
		"#,
	);
	assert_eq!(out["before"], json!({ "tabs": ["test/x", "joe/a", "test/1", "joe/b"], "active": 2 }));
	assert_eq!(out["hidden"]["tabs"], json!(["test/x", "test/1"]));
	assert!(out["guide"] == "test/x" || out["guide"] == "test/1", "{}", out["guide"]);
	assert_eq!(out["saved"], json!(["test/x", "test/1", "joe/a", "joe/b"]));
	assert_eq!(out["pin"], json!({ "step": 3, "done": false }));
	assert_eq!(out["back"]["tabs"], json!(["test/x", "joe/a", "test/1", "joe/b"]));
	assert_eq!(out["step"], 3);
	assert_eq!(out["savedBack"], json!(["test/x", "joe/a", "test/1", "joe/b"]));
}

#[test]
fn saved_absent_tabs_never_take_an_open_tab_s_place_and_at_most_max_tabs_of_them_are_kept_newest_first() {
	let out = run(
		false,
		Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/1", "test/2", "test/3", "test/4", "test/5", "gone/1", "gone/2" }, activeTab = 1 }"#),
		r#"
			local r = { max = E.MAX_TABS, login = ids().tabs }
			r.sixth = E.OpenTab("test/6") or false
			r.seventh = E.OpenTab("test/7") or false
			r.saved = PolestarCharDB.tabs
			emit(r)
		"#,
	);
	assert_eq!(out["max"], 6);
	assert_eq!(out["login"], json!(["test/1", "test/2", "test/3", "test/4", "test/5"]));
	assert_eq!(out["sixth"], 6, "five open tabs and two absent ones: a sixth still opens");
	assert_eq!(out["seventh"], false, "six open tabs: full, as before");
	assert_eq!(out["saved"], json!(["test/1", "test/2", "test/3", "test/4", "test/5", "test/6", "gone/1", "gone/2"]));

	let many = (1..=9).map(|i| format!("\"gone/{i}\"")).collect::<Vec<_>>().join(", ");
	let saved = format!("PolestarCharDB = {{ schema = 1, tabs = {{ \"test/1\", {many} }}, activeTab = 1 }}");
	let kept = run(false, Some(&saved), r#"E.OpenTab("test/2", false); emit(PolestarCharDB.tabs)"#);
	assert_eq!(kept, json!(["test/1", "test/2", "gone/4", "gone/5", "gone/6", "gone/7", "gone/8", "gone/9"]));
}

#[test]
fn an_absent_guide_put_into_a_tab_by_setguide_is_no_longer_absent_closed_it_stays_closed() {
	let script = fill(
		r#"
			Polestar.RegisterPack({ addon = "ZedAddon", id = "zed", format = 1, title = "Zed", author = "Z", version = "1", license = "MIT" })
			Polestar.RegisterGuide({ id = "zed/a", pack = "zed", title = "Z", category = "Exploration", ${STEPS} })
			local G = Polestar.Guides
			E.OpenTab("joe/a"); for i = 1, 5 do E.OpenTab("test/" .. i) end
			G.SetPackShown("joe", false); flush()
			E.OpenTab("test/6"); flush()
			G.SetPackShown("joe", true); flush()
			local r = { full = ids().tabs, savedFull = PolestarCharDB.tabs }
			E.SetGuide("joe/a"); flush()
			r.set = ids().tabs
			r.savedSet = PolestarCharDB.tabs
			E.CloseTab(ids().active); flush()
			r.closed = PolestarCharDB.tabs
			G.SetPackShown("zed", false); flush()
			r.afterZed = ids().tabs
			r.savedAfterZed = PolestarCharDB.tabs
			emit(r)
		"#,
	);
	let out = run(true, None, &script);
	assert_eq!(out["full"], json!(["test/1", "test/2", "test/3", "test/4", "test/5", "test/6"]), "full strip: joe/a stays absent");
	assert_eq!(out["savedFull"], json!(["test/1", "test/2", "test/3", "test/4", "test/5", "test/6", "joe/a"]));
	assert!(has(&out["set"], "joe/a"), "{}", joined(&out["set"]));
	assert_eq!(out["savedSet"].as_array().unwrap().iter().filter(|id| id.as_str() == Some("joe/a")).count(), 1);
	assert!(!has(&out["closed"], "joe/a"), "{}", joined(&out["closed"]));
	assert!(!has(&out["afterZed"], "joe/a"), "{}", joined(&out["afterZed"]));
	assert!(!has(&out["savedAfterZed"], "joe/a"), "{}", joined(&out["savedAfterZed"]));
}

#[test]
fn a_tab_reopened_after_its_pack_returns_is_no_longer_absent_closed_it_stays_closed() {
	let out = run(
		true,
		None,
		r#"
			local G = Polestar.Guides
			local function close(id) for i, t in ipairs(ids().tabs) do if t == id then E.CloseTab(i) end end; flush() end
			E.OpenTab("test/x"); E.OpenTab("joe/a"); E.OpenTab("joe/b"); flush()
			G.SetPackShown("joe", false); flush()
			G.SetPackShown("joe", true); flush()
			local r = { back = ids().tabs }
			close("joe/a")
			r.closed = PolestarCharDB.tabs
			G.SetPackShown("joe", false); flush()
			r.hidden = PolestarCharDB.tabs
			G.SetPackShown("joe", true); flush()
			r.reopened = ids().tabs
			close("joe/b")
			G.SetPackShown("joe", false); flush()
			G.SetPackShown("joe", true); flush()
			r.again = ids().tabs
			r.saved = PolestarCharDB.tabs
			emit(r)
		"#,
	);
	assert_eq!(out["back"], json!(["test/x", "joe/a", "joe/b"]));
	assert_eq!(out["closed"], json!(["test/x", "joe/b"]));
	assert_eq!(out["hidden"], json!(["test/x", "joe/b"]), "only the open joe tab is kept as absent");
	assert_eq!(out["reopened"], json!(["test/x", "joe/b"]));
	assert_eq!(out["again"], json!(["test/x"]));
	assert_eq!(out["saved"], json!(["test/x"]));
}

#[test]
fn the_step_view_carries_the_step_s_picture_with_its_texture_path_and_a_step_without_one_has_none() {
	let out = run(
		true,
		None,
		r#"
			Polestar.RegisterGuide({ id = "joe/pic", pack = "joe", title = "Pic", category = "Exploration", steps = {
				{ note = "Inside the mine.", image = { file = "media\\cave", w = 512, h = 256 }, goals = { { t = "level", level = 50 } } },
				{ goals = { { t = "level", level = 55 } } },
			} })
			E.OpenTab("joe/pic"); flush()
			emit({ first = E.GetStepView(1).image, second = E.GetStepView(2).image == nil })
		"#,
	);
	assert_eq!(out["first"], json!({ "file": "media\\cave", "w": 512, "h": 256, "texture": "Interface\\AddOns\\JoeAddon\\media\\cave" }));
	assert_eq!(out["second"], true);
	assert!(truthy(&out["second"]));
}
