//! "While you're here" over the guide window (addon/Polestar/UI/GuideFrame.lua, SL.FillWH: the outside card above
//! the window, in every look), the toast while the window is hidden (UI/WhileHere.lua), the maps (Nav/Layers.lua),
//! and its options (UI/Options.lua), end to end: the real addon in the stub world with a guide registered in Lua.
//! The engine side is in engine-while-here.rs.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 47.6, 70.0) -- 700 yd from the vermin: nothing in reach at any radius
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
w.onQuest(60, { { text = "Large Candle: 1/3", type = "item", required = 3, fulfilled = 1 } }, "Candles")
"#;

// 1 (live) kill 8 wolves far away · 2 kill 10 vermin (8 done) at 47.6,35.1 · 3 collect 3 candles (1 done) in two
// spawn areas around 52,35.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Candles", goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, map = 1429, x = 52.0, y = 35.1,
			spots = { { x = 52.0, y = 35.1, r = 15, n = 3 }, { x = 53.0, y = 36.0, r = 10, n = 2 } } } } },
	},
})
"#;

const HELPERS: &str = r#"
local w = stub.world
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
local H = GF.stepList.out.wh
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function row(i) return H.Rows[i or 1] end
local function line()
	local r = H:IsShown() and row(1)
	return { shown = H:IsShown(), text = r and plain(r.Text:GetText()) or false, label = H.Label:GetText(), meta = r and r.Meta:GetText() or false,
		inWindow = GF.parts.here:IsShown() }
end
local function toast()
	local t = PolestarWhileHereToast
	return t and t:IsShown() and plain(t.Text:GetText()) or false
end
"#;

// The distances below are measured against a 60 yd radius (the default is 250), set before login so no line
// shows from where the player starts.
fn run(before_login: &str, script: &str) -> Vec<Value> {
	run_with(&format!("{before_login}\nPolestar.Set(\"behavior.whileHereRadius\", 60)"), "", script)
}

/// Hearth: a look other than the house one (`run_in`); the outside card is in every look.
fn run_with(before_login: &str, setup: &str, script: &str) -> Vec<Value> {
	run_in("hearth", before_login, setup, script)
}

fn run_in(skin: &str, before_login: &str, setup: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, before_login, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, &format!("Polestar.Set(\"ui.skin\", \"{skin}\")\n{setup}"), HELPERS, script].join("\n"),
		..Default::default()
	})
}

// The line comes as a row of the outside card above the window, under its own label: the goal's line, then its
// step, count and distance at the right. A click leads the arrow there; a right-click dismisses it and the card goes.
#[test]
fn the_line_shows_in_the_card_above_the_window_then_a_click_points_the_arrow_a_right_click_dismisses_it() {
	let out = run(
		"",
		r#"
		emit(line())
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
		local p, rel, rp, _, y = H:GetPoint(1)
		emit({ line = line(), toast = toast(), aboveWindow = rel == GF.frame and p == "BOTTOMLEFT" and rp == "TOPLEFT" and y > 0 })
		local R = row(1)
		R:GetScript("OnClick")(R, "LeftButton"); stub.advance(0.2)
		local t = Polestar.Nav.GetTarget()
		emit(t and { t.stepIndex, t.goalIndex } or false)
		R:GetScript("OnClick")(R, "RightButton"); stub.advance(0.6)
		t = Polestar.Nav.GetTarget()
		emit({ shown = H:IsShown(), engine = E.GetWhileHere() == nil, target = t and { t.stepIndex, t.goalIndex } or false })
	"#,
	);
	assert_eq!(out[0]["shown"], false, "nothing close by");
	let shown = &out[1];
	assert_eq!(shown["line"]["shown"], true);
	assert_eq!(shown["line"]["label"], "WHILE YOU'RE HERE", "the card's own label");
	assert_eq!(shown["line"]["text"], "Kill Kobold Vermin", "the goal's line");
	assert_eq!(shown["line"]["meta"], "Step 2  8/10  50 yd", "its step, count and distance at the right");
	assert_eq!(shown["line"]["inWindow"], false, "no block in the window");
	assert_eq!(shown["aboveWindow"], true, "the card sits above the window: {shown}");
	assert_eq!(shown["toast"], false, "the window shows it: no toast");
	assert_eq!(out[2], json!([2, 1]), "a click leads the arrow to the vermin");
	let gone = &out[3];
	assert_eq!(gone["shown"], false);
	assert_eq!(gone["engine"], true);
	assert_eq!(gone["target"], json!([1, 1]), "the arrow is back on the step's wolves");
}

// Fitz, 0.3.5: in the transparent style the panel was a solid box over the world. There the card draws no ground or
// lines, its text outlined like the window's other text; back in the standard style it takes its ground again.
#[test]
fn in_the_transparent_style_the_card_draws_no_ground_and_its_text_is_outlined_not_an_opaque_box() {
	let out = run(
		"",
		r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
		local function dress() return { ground = H.Ground:IsShown(), base = H.Base:IsShown(), line = H.Lines[1]:IsShown() } end
		local solid = dress()
		Polestar.Set("ui.style", "transparent"); stub.advance(0.1)
		local clear, outlined = dress(), select(3, row(1).Text:GetFont())
		Polestar.Set("ui.style", "standard"); stub.advance(0.1)
		emit({ solid = solid, clear = clear, outlined = outlined, back = dress(), shown = H:IsShown() })"#,
	);
	let o = &out[0];
	assert_eq!(o["shown"], true);
	assert_eq!(o["solid"], json!({ "ground": true, "base": true, "line": true }), "the standard style keeps its ground: {o}");
	assert_eq!(o["clear"], json!({ "ground": false, "base": false, "line": false }), "transparent: no box over the world: {o}");
	assert!(o["outlined"].as_str().unwrap_or("").contains("OUTLINE"), "its text is outlined over the world: {o}");
	assert_eq!(o["back"], o["solid"], "back in the standard style it takes its ground again");
}

// Fitz, 0.3.5: several suggestions close by (Engine.GetWhileHereList) are rows of the one card, under its one
// label, in the engine's order, each with its own step, distance and close button; a click on a row aims at that
// one, a right-click or its close button dismisses only that one, and the card goes with the last.
#[test]
fn two_suggestions_are_two_rows_of_one_card_each_aiming_and_dismissing_its_own() {
	let out = run_with(
		"",
		r#"Polestar.Set("behavior.whileHereRadius", 150)"#,
		r#"
		w.moveTo(1429, 49.8, 36.0); stub.advance(1.1)
		local function rows()
			local out = {}
			for i, r in ipairs(H.Rows) do
				if r:IsShown() then
					local v = E.GetWhileHereList()[i]
					out[#out + 1] = { text = plain(r.Text:GetText()), meta = r.Meta:GetText(), close = r.Close:IsShown(), step = v and v.step or false }
				end
			end
			return out
		end
		local labels = 0
		for _, region in ipairs({ H:GetRegions() }) do
			if region.GetText and region:GetText() == "WHILE YOU'RE HERE" then labels = labels + 1 end
		end
		local first = { rows = rows(), list = #E.GetWhileHereList(), labels = labels }
		local second = H.Rows[2]
		local aimAt = second.psView.step
		second:GetScript("OnClick")(second, "LeftButton"); stub.advance(0.2)
		local t = Polestar.Nav.GetTarget()
		local aimed = t and t.stepIndex or false
		local one = H.Rows[1]
		local gone = one.psView.step
		one:GetScript("OnClick")(one, "RightButton"); stub.advance(0.6)
		local after = { rows = rows(), list = #E.GetWhileHereList(), shown = H:IsShown() }
		H.Rows[1].Close:Click(); stub.advance(0.6)
		emit({ first = first, aimAt = aimAt, aimed = aimed, gone = gone, after = after, last = { shown = H:IsShown(), list = #E.GetWhileHereList() } })"#,
	);
	let o = &out[0];
	assert_eq!(o["first"]["list"], 2, "the vermin and the candles are both in reach: {o}");
	assert_eq!(o["first"]["labels"], 1, "one label for the card");
	let rows = o["first"]["rows"].as_array().unwrap();
	assert_eq!(rows.len(), 2, "{o}");
	let texts: Vec<&str> = rows.iter().map(|r| r["text"].as_str().unwrap()).collect();
	assert!(texts.contains(&"Kill Kobold Vermin") && texts.contains(&"Collect Large Candle"), "{texts:?}");
	for r in rows {
		let meta = r["meta"].as_str().unwrap();
		assert!(meta.starts_with(&format!("Step {}  ", r["step"])), "its step first: {r}");
		assert!(meta.ends_with(" yd"), "each row has its own distance: {r}");
		assert_eq!(r["close"], true, "{r}");
	}
	assert_eq!(o["aimed"], o["aimAt"], "a click on the second row aims at its step: {o}");
	let left = o["after"]["rows"].as_array().unwrap();
	assert_eq!((o["after"]["list"].as_i64(), left.len()), (Some(1), 1), "a right-click dismisses only its row: {o}");
	assert_ne!(left[0]["step"], o["gone"], "the other row stays: {o}");
	assert_eq!(o["after"]["shown"], true);
	assert_eq!(o["last"], json!({ "shown": false, "list": 0 }), "the last row's close button takes the card with it");
}

#[test]
fn with_the_window_hidden_one_small_toast_says_it_once() {
	let out = run(
		r#"Polestar.Set("ui.shown", false)"#,
		r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
		emit({ line = H:IsVisible(), toast = toast() })
		stub.advance(9)
		emit(toast())                                       -- it closes itself
		local t = PolestarWhileHereToast
		w.moveTo(1429, 47.6, 45.1); stub.advance(1.1)        -- the line goes
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)        -- and comes again: a new toast
		local again = toast()
		t:GetScript("OnClick")(t, "RightButton"); stub.advance(0.5)
		emit({ again = again, after = toast(), engine = E.GetWhileHere() == nil })
	"#,
	);
	assert_eq!(out[0], json!({ "line": false, "toast": "Kill Kobold Vermin, 2 more  \u{b7}  50 yd" }));
	assert_eq!(out[1], json!(false));
	assert_eq!(out[2], json!({ "again": "Kill Kobold Vermin, 2 more  \u{b7}  50 yd", "after": false, "engine": true }));
}

// Fitz, 0.3.5: in the compact window the panel did not show at all. The card shows in every mode and style of the
// window, normal and compact, standard and transparent, growing down, growing up and with the bars at the bottom:
// two suggestions are two visible rows with their text, step and distance and close button, on the window's top
// edge. With the window on screen no toast says them.
#[test]
fn two_suggestions_show_as_two_rows_in_every_window_mode_and_style() {
	let out = run_with(
		"",
		r#"Polestar.Set("behavior.whileHereRadius", 150)"#,
		r#"
		local F = GF.frame
		local out = {}
		for _, compact in ipairs({ false, true }) do
			for _, style in ipairs({ "standard", "transparent" }) do
				for _, grow in ipairs({ "down", "up", "barsBottom" }) do
					Polestar.Set("ui.compact", compact)
					Polestar.Set("ui.style", style)
					Polestar.Set("ui.growUp", grow ~= "down")
					Polestar.Set("ui.barsBottom", grow == "barsBottom")
					w.moveTo(1429, 47.6, 45.1); stub.advance(1.1)
					w.moveTo(1429, 49.8, 36.0); stub.advance(1.1)
					local rows = {}
					for i, r in ipairs(H.Rows) do
						if r:IsVisible() then
							local meta = r.Meta:IsVisible() and r.Meta:GetText() or ""
							rows[#rows + 1] = { text = plain(r.Text:GetText()) ~= "", dist = meta:find(" yd$") ~= nil,
								close = r.Close:IsVisible(), step = meta:find("^Step %d+") ~= nil, h = r:GetHeight() > 0 }
						end
					end
					local p, rel, rp, _, y = H:GetPoint(1)
					out[#out + 1] = { mode = (compact and "compact" or "normal") .. "/" .. style .. "/" .. grow, list = #E.GetWhileHereList(),
						panel = H:IsVisible() and H:GetHeight() > 0, onTop = rel == F and p == "BOTTOMLEFT" and rp == "TOPLEFT" and y > 0,
						rows = rows, toast = toast() }
				end
			end
		end
		emit(out)"#,
	);
	let runs = out[0].as_array().unwrap();
	assert_eq!(runs.len(), 12);
	for r in runs {
		let mode = r["mode"].as_str().unwrap();
		assert_eq!(r["list"], 2, "{mode}: two suggestions in reach: {r}");
		assert_eq!(r["panel"], true, "{mode}: the card shows: {r}");
		assert_eq!(r["onTop"], true, "{mode}: on the window's top edge: {r}");
		assert_eq!(r["toast"], false, "{mode}: the window shows them, no toast");
		let rows = r["rows"].as_array().unwrap();
		assert_eq!(rows.len(), 2, "{mode}: two visible rows: {r}");
		for row in rows {
			assert_eq!(row, &json!({ "text": true, "dist": true, "close": true, "step": true, "h": true }), "{mode}: {r}");
		}
	}
}

// The minimap shows what the line points at: its mark and spawn area in the accent on both surfaces (its own
// layers), until a click on its row hands it to the arrow's own layers.
#[test]
fn the_maps_and_the_minimap_show_its_mark_and_spawn_area_until_the_arrow_takes_it() {
	let out = run(
		"",
		r#"
		w.moveTo(1429, 52.0, 38.0); stub.advance(1.1)
		local v = E.GetWhileHere()
		local P = Polestar.Pins
		local function n(name) local l = P.GetLayer(name); return l and #l or 0 end
		local function mm(name) return #P.GetMinimapFrames(name) + #P.GetMinimapHulls(name) + #P.GetMinimapAreas(name) end
		emit({ here = v and v.step or false, text = v and v.hereText or false, mark = n("nav.here"), areas = n("nav.hereAreas"),
			mmMark = mm("nav.here"), mmAreas = mm("nav.hereAreas") })
		row(1):GetScript("OnClick")(row(1), "LeftButton"); stub.advance(0.3)
		emit({ mark = n("nav.here"), areas = n("nav.hereAreas"), own = n("nav.areas") })
	"#,
	);
	assert_eq!(out[0]["here"], 3);
	assert_eq!(out[0]["text"], "Collect Large Candle, 2 more");
	assert_eq!(out[0]["mark"], 1, "its mark: {}", out[0]);
	assert!(out[0]["areas"].as_i64().unwrap() > 0, "its spawn area: {}", out[0]);
	assert_eq!(out[0]["mmMark"], 1, "the mark on the minimap: {}", out[0]);
	assert!(out[0]["mmAreas"].as_i64().unwrap() > 0, "the area on the minimap: {}", out[0]);
	assert_eq!(json!([out[1]["mark"], out[1]["areas"]]), json!([0, 0]), "clicked, the arrow's layers draw it: {}", out[1]);
	assert!(out[1]["own"].as_i64().unwrap() > 0, "clicked, it is the arrow's: {}", out[1]);
}

const PING: &str = r#"
local P, A = Polestar.Pins, Polestar.Anim
local function mm() return P.GetMinimapFrames("nav.here")[1] end
local function chimes()
	local n = 0
	for _, s in ipairs(stub.sounds) do if type(s) == "string" and s:find("while%-here%.ogg$") then n = n + 1 end end
	return n
end
local function rings(f)
	local n = 0
	for _, t in ipairs(f and f.pings or {}) do if t:IsShown() then n = n + 1 end end
	return n
end
"#;

// Fitz: a new line chimes once and its minimap mark pings (three rings over about 1.2 s), so the player looks;
// never again for the same line, every new line after 5 s chimes, none with the sound off.
#[test]
fn a_new_line_chimes_once_and_its_minimap_mark_pings_then_settles() {
	let out = run(
		"",
		&format!(
			"{PING}{}",
			r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(0.6)
		local f = mm()
		local early = { chimes = chimes(), pinging = f and f.pinging or false, value = f and A.IsRunning(f, "value") or false }
		stub.advance(0.3)
		early.rings = rings(f)
		emit(early)
		stub.advance(1.2)
		emit({ pinging = f.pinging, rings = rings(f), value = A.IsRunning(f, "value"), glow = f.glow and f.glow:IsShown() or false })
		w.progress(7, 1, 9); stub.advance(0.6)
		emit({ chimes = chimes(), pinging = mm().pinging })
		E.DismissWhileHere(); stub.advance(5); w.moveTo(1429, 52.0, 38.0); stub.advance(0.6)
		emit({ text = E.GetWhileHere().hereText, chimes = chimes(), pinging = mm().pinging })
		stub.advance(31); w.setZone("Westfall"); w.setZone("Elwynn Forest")   -- a new zone stay: the vermin may come back
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
		emit({ text = E.GetWhileHere().hereText, chimes = chimes() })
	"#
		),
	);
	assert_eq!(out[0], json!({ "chimes": 1, "pinging": true, "value": true, "rings": 2 }), "rings expand, staggered");
	assert_eq!(out[1], json!({ "pinging": false, "rings": 0, "value": false, "glow": true }), "it ends and the mark keeps its glow");
	assert_eq!(out[2], json!({ "chimes": 1, "pinging": false }), "the same line again: no chime, no ping");
	assert_eq!(out[3], json!({ "text": "Collect Large Candle, 2 more", "chimes": 2, "pinging": true }), "a new line 5 s on chimes and pings");
	assert_eq!(out[4], json!({ "text": "Kill Kobold Vermin, 1 more", "chimes": 3 }), "the vermin back in a new zone stay: a chime");
	let off = run(r#"Polestar.Set("behavior.whileHereSound", false)"#, &format!("{PING}{}", r#"w.moveTo(1429, 47.6, 37.6); stub.advance(0.6); emit({ chimes(), mm().pinging })"#));
	assert_eq!(off, vec![json!([0, true])], "the sound off: the ping still plays");
}

// Fitz: the hooves were up and the spores appeared with no chime (one chime in 30 s was the rule). Each new line
// chimes, at least 5 s after the last, whatever else is up; two appearing in one poll chime once.
#[test]
fn a_second_line_appearing_while_one_is_up_chimes_two_at_once_chime_once() {
	let out = run_with(
		"",
		r#"Polestar.Set("behavior.whileHereRadius", 120)"#,
		&format!(
			"{PING}{}",
			r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(0.6)        -- the vermin 50 yd, the candles 126
		local one = { n = #E.GetWhileHereList(), chimes = chimes() }
		stub.advance(10)
		w.moveTo(1429, 49.3, 35.1); stub.advance(0.6)        -- the candles 66 yd, the vermin still up
		emit({ one = one, two = { n = #E.GetWhileHereList(), chimes = chimes() } })
	"#
		),
	);
	assert_eq!(out[0], json!({ "one": { "n": 1, "chimes": 1 }, "two": { "n": 2, "chimes": 2 } }));
}

#[test]
fn reduced_motion_the_minimap_mark_flashes_once_instead_of_rings() {
	let out = run(
		r#"Polestar.Set("ui.reduceMotion", true)"#,
		&format!(
			"{PING}{}",
			r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(0.6)
		local f = mm()
		emit({ rings(f), A.IsRunning(f, "value"), A.IsRunning(f.pings[1], "alpha") })
		stub.advance(0.6)
		emit({ rings(f), f.pinging })
	"#
		),
	);
	assert_eq!(out, vec![json!([1, false, true]), json!([0, false])]);
}

// Zoomed in, the line's place is past the minimap's rim: its mark sits on the rim with the edge pointer toward it,
// and the ping plays there.
#[test]
fn off_the_minimap_the_mark_pings_at_the_rim_with_its_edge_pointer() {
	let out = run_with(
		"stub.minimapZoom = 5",
		r#"Polestar.Set("behavior.whileHereRadius", 120); stub.advance(0.6)"#,
		&format!(
			"{PING}{}",
			r#"
		w.moveTo(1429, 47.6, 40.1); stub.advance(0.6)
		local f = mm()
		emit({ here = E.GetWhileHere() and E.GetWhileHere().yards or false, clamped = f and f.clamped or false, pointer = f and f.edge:IsShown() or false, pinging = f and f.pinging or false })
	"#
		),
	);
	assert_eq!(out, vec![json!({ "here": 100, "clamped": true, "pointer": true, "pinging": true })]);
}

#[test]
fn the_options_sit_in_the_window_tab_on_by_default_the_radius_from_60_to_400_yards_and_the_sound() {
	let out = run_with(
		"",
		"",
		r#"
		local UI, O = Polestar.UI, Polestar.UI.Options
		UI.ShowOptions("guide")
		local c = O.Controls("guide", "Window")
		local on, radius, turnins, sound = c["behavior.whileHere"], c["behavior.whileHereRadius"], c["behavior.whileHereTurnins"], c["behavior.whileHereSound"]
		local before = { on ~= nil, radius ~= nil, turnins ~= nil, sound ~= nil, Polestar.Get("behavior.whileHere"), Polestar.Get("behavior.whileHereRadius"),
			Polestar.Get("behavior.whileHereTurnins"), Polestar.Get("behavior.whileHereSound") }
		stub.RunScript(radius.Slider, "OnValueChanged", 398, true)
		local wide = Polestar.Get("behavior.whileHereRadius")
		on:Click()
		emit({ before = before, wide = wide, off = Polestar.Get("behavior.whileHere"), radiusEnabled = radius:IsEnabled(), turninsEnabled = turnins:IsEnabled(), soundEnabled = sound:IsEnabled() })
	"#,
	);
	assert_eq!(out[0]["before"], json!([true, true, true, true, true, 180, true, true]));
	assert_eq!(out[0]["wide"], 400, "the slider steps by 10 yards, up to 400");
	assert_eq!(out[0]["off"], false);
	assert_eq!(out[0]["radiusEnabled"], false, "its children grey out with it off");
	assert_eq!(out[0]["turninsEnabled"], false);
	assert_eq!(out[0]["soundEnabled"], false);
}

// "Hand-ins: how far out of your way", its own slider beside How close: 0 to 60 s in steps of 5, 20 by default,
// greyed out with hand-ins off.
#[test]
fn the_hand_ins_slider_sets_their_seconds_out_of_the_way_apart_from_how_close() {
	let out = run_with(
		"",
		"",
		r#"
		local UI, O = Polestar.UI, Polestar.UI.Options
		UI.ShowOptions("guide")
		local c = O.Controls("guide", "Window")
		local turnins, seconds = c["behavior.whileHereTurnins"], c["behavior.whileHereTurninSeconds"]
		local before = { seconds ~= nil, Polestar.Get("behavior.whileHereTurninSeconds"), seconds.Value:GetText(), seconds:IsEnabled() }
		stub.RunScript(seconds.Slider, "OnValueChanged", 58, true)
		local most = Polestar.Get("behavior.whileHereTurninSeconds")
		turnins:Click()
		emit({ before = before, most = most, radius = Polestar.Get("behavior.whileHereRadius"), off = seconds:IsEnabled() })
	"#,
	);
	assert_eq!(out[0]["before"], json!([true, 20, "20 s", true]));
	assert_eq!(out[0]["most"], 60, "the slider steps by 5 seconds, up to 60");
	assert_eq!(out[0]["radius"], 180, "How close stays its own");
	assert_eq!(out[0]["off"], false, "greyed out with hand-ins off");
}

// Fitz: the spores came back after a dismiss and nothing chimed: only the first row's change was heard. A line that
// comes back chimes and pings like a new one, whichever row it takes (30 s after the last chime at the earliest).
// Here at 120 yd the vermin (the first row) stay while the candles go past their clear distance and come back.
#[test]
fn a_line_that_comes_back_chimes_and_pings_whichever_row_it_takes() {
	let out = run_with(
		"",
		r#"Polestar.Set("behavior.whileHereRadius", 120)"#,
		&format!(
			"{PING}{}",
			r#"
		local function pinging()
			for _, f in ipairs(P.GetMinimapFrames("nav.here")) do if f.pinging then return true end end
			return false
		end
		local function rows()
			local out = {}
			for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.index end
			return table.concat(out, " ")
		end
		w.moveTo(1429, 49.3, 35.1); stub.advance(0.6)       -- the vermin 51 yd, the candles 66
		emit({ rows = rows(), chimes = chimes() })
		stub.advance(2)
		w.moveTo(1429, 44.0, 35.1); stub.advance(0.6)       -- the candles past 200 yd, the vermin in reach
		emit({ rows = rows(), chimes = chimes() })
		stub.advance(31)
		w.moveTo(1429, 49.3, 35.1); stub.advance(0.6)       -- back: the candles come again
		emit({ rows = rows(), chimes = chimes(), pinging = pinging() })
	"#
		),
	);
	assert_eq!(out[0], json!({ "rows": "2:1 3:1", "chimes": 1 }), "two lines at once, one chime (30 s apart at most)");
	assert_eq!(out[1], json!({ "rows": "2:1", "chimes": 1 }));
	assert_eq!(out[2], json!({ "rows": "2:1 3:1", "chimes": 2, "pinging": true }), "the candles back in the second row: a chime and a ping");
}

// Fitz: Dynamic Questing never shows on a flight. On a taxi over the vermin with one's nameplate in sight: no row, no
// chime, no mark. Landed in reach, it shows once, chiming. Taking off again hides it (it waits, not expired, not
// left); landed back there after five minutes it shows again as it was, with no second chime and no ping.
#[test]
fn on_a_flight_nothing_shows_and_a_line_from_before_takeoff_comes_back_quietly() {
	let out = run(
		"",
		&format!(
			"{PING}{}",
			r#"
		local function rows()
			local out = {}
			for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.index end
			return table.concat(out, " ")
		end
		local function marks() return #P.GetMinimapFrames("nav.here") end
		local function pinging()
			for _, f in ipairs(P.GetMinimapFrames("nav.here")) do if f.pinging then return true end end
			return false
		end
		w.onTaxi = true
		w.moveTo(1429, 47.6, 37.6)
		w.units.nameplate2 = "Creature-0-1-0-1-6-0000BEEF"; stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
		stub.advance(1.1)
		emit({ rows = rows(), chimes = chimes(), marks = marks(), toast = toast() })
		w.onTaxi = false; stub.advance(0.6)
		emit({ rows = rows(), chimes = chimes() })
		stub.advance(2)
		w.onTaxi = true; stub.advance(0.6)
		emit({ rows = rows(), marks = marks() })
		stub.advance(300)
		w.onTaxi = false; stub.advance(0.6)
		emit({ rows = rows(), chimes = chimes(), pinging = pinging() })
	"#
		),
	);
	assert_eq!(out[0], json!({ "rows": "", "chimes": 0, "marks": 0, "toast": false }), "on the taxi: nothing");
	assert_eq!(out[1], json!({ "rows": "2:1", "chimes": 1 }), "landed in reach: once, with a chime");
	assert_eq!(out[2], json!({ "rows": "", "marks": 0 }), "flying again: hidden");
	assert_eq!(out[3], json!({ "rows": "2:1", "chimes": 1, "pinging": false }), "landed after five minutes: back, quietly");
}

// The house look: "While you're here" is an outside card above the Optional card, one 18px row per suggestion
// (the line on one line, its step, count and distance muted at the right, a small dismiss square), not the block in
// the window; the dismiss and a click work as before.
#[test]
fn in_the_house_look_while_you_re_here_is_an_outside_card_with_a_row_per_suggestion() {
	let out = run_in(
		"polestar",
		"Polestar.Set(\"behavior.whileHereRadius\", 60)",
		r#"Polestar.Set("behavior.whileHereRadius", 150)"#,
		r#"
		w.moveTo(1429, 49.8, 36.0); stub.advance(1.1)
		local SL = GF.stepList
		local wh = SL.out.wh
		local rows = {}
		for i = 1, wh.psN or 0 do
			local r = wh.Rows[i]
			rows[#rows + 1] = { text = plain(r.Text:GetText()), meta = r.Meta:GetText(), h = r:GetHeight(), close = r.Close:IsShown() }
		end
		local p, rel, rp, _, y = wh:GetPoint(1)
		emit({ shown = wh:IsShown(), rows = rows, old = GF.parts.here:IsShown(), y = y, label = wh.Label:GetText(), outH = SL.out.h })
		local first = wh.Rows[1]
		first:GetScript("OnClick")(first, "RightButton"); stub.advance(0.6)
		emit({ left = wh.psN or 0 })
		Polestar.Set("ui.stepList", true); stub.advance(0.3)
		emit({ listed = wh:IsShown() })"#,
	);
	let a = &out[0];
	assert_eq!(a["shown"], true, "{a}");
	assert_eq!(a["old"], false, "no block in the window");
	assert_eq!(a["label"], "WHILE YOU'RE HERE");
	assert!(a["rows"].as_array().unwrap().len() >= 2, "a row each: {a}");
	for r in a["rows"].as_array().unwrap() {
		assert_eq!(r["h"], 18, "{r}");
		assert_eq!(r["close"], true);
		assert!(is_match(text(&r["meta"]), r"Step \d+"), "the step it is needed: {r}");
	}
	assert!(out[1]["left"].as_u64().unwrap() < a["rows"].as_array().unwrap().len() as u64, "the dismiss works: {}", out[1]);
	assert_eq!(out[2]["listed"], false, "not over the step list");
}

// The outside cards sit above the window: the screen clamp grows upward by their height (a positive top inset, as
// the chat frame's tabs), so neither the window nor the cards leave the screen at the top. A move that widens a
// row's distance gives its line less room, without a whole layout.
#[test]
fn the_outside_cards_stay_on_screen_with_the_window_and_a_wider_distance_narrows_its_row_s_line() {
	let out = run_in(
		"polestar",
		"Polestar.Set(\"behavior.whileHereRadius\", 60)",
		r#"Polestar.Set("behavior.whileHereRadius", 150)
		local F = Polestar.UI.GuideFrame.frame
		F.SetClampRectInsets = function(self, l, r, t, b) self.psClamp = { l, r, t, b } end"#,
		r#"
		w.moveTo(1429, 49.8, 36.0); stub.advance(1.1)
		local SL = GF.stepList
		local wh, F = SL.out.wh, GF.frame
		local r = wh.Rows[1]
		GF.HereMoved(40, 1)
		local near = { meta = r.Meta:GetText(), text = r.Text:GetWidth() }
		GF.HereMoved(1200, 1)
		emit({ shown = wh:IsShown(), outH = SL.out.h, clamp = F.psClamp, near = near, far = { meta = r.Meta:GetText(), text = r.Text:GetWidth() } })"#,
	);
	let a = &out[0];
	assert_eq!(a["shown"], true, "{a}");
	let h = a["outH"].as_u64().unwrap();
	assert!(h > 0, "{a}");
	assert_eq!(a["clamp"], json!([0, 0, h, 0]), "the clamp rect reaches over the cards: {a}");
	assert_ne!(a["near"]["meta"], a["far"]["meta"], "{a}");
	assert!(a["far"]["text"].as_f64().unwrap() < a["near"]["text"].as_f64().unwrap(), "the line gives way to the wider distance: {a}");
}
