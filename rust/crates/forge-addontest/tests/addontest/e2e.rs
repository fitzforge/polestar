//! End to end: a guide compiled by the real toolchain from DSL source, loaded by the real addon (Core, Theme,
//! Nav, UI together, no fakes), driven through a quest flow in the stub world. Each module's own tests fake its
//! neighbours; this is where the Engine view model, the UI rows, the Nav arrow and the compiler's output have
//! to agree.

use forge_addontest::dsl::{escort_data, fixture_data, group_data, our_manifest, write_test_pack, Compiled};
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use forge_guide::diag::format;
use serde_json::{json, Value};
use std::path::PathBuf;

const GUIDE: &str = r#"guide forever/alliance/human/01-northshire
title Northshire Valley
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobold camp
  goto 47.6,35.1 "Kobold camp"
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
"#;

const BEFORE: &str = r#"
				local w = stub.world
				w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
				w.moveTo(1429, 48.5, 42.5)"#;

/// The compile's errors as the CLI prints them (`diag.errors.map(format)`).
fn errors(r: &Compiled) -> Vec<String> {
	r.diag.errors().into_iter().map(format).collect()
}

/// Runs `script` (its `${loads}` replaced by the Lua loading the pack's `scripts`) on the full addon.
fn run_pack(scripts: &[PathBuf], script: &str) -> Vec<Value> {
	let lines: Vec<String> = scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: script.replace("${loads}", &loads), ..Default::default() })
}

const FLOW: &str = r#"
				${loads}
				stub.login()
				stub.advance(0.5)
				local w = stub.world
				local GF = Polestar.UI.GuideFrame
				local function snap(label)
					local rows = {}
					for i, r in ipairs(GF.rows) do
						if r:IsShown() then
							local plain = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
							rows[#rows + 1] = { text = plain, progress = plain:match("(%d+/%d+)$") or "" }
						end
					end
					local t = Polestar.Nav.GetTarget()
					emit({
						label = label,
						guide = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id,
						step = Polestar.Engine.GetStepIndex(),
						card = GF.parts.person.Name:GetText(),
						cardShown = GF.parts.card:IsShown(),
						emptyTitle = GF.parts.empty:IsShown() and GF.parts.empty.Title:GetText() or nil,
						rows = rows,
						target = t and { x = t.x, y = t.y, label = t.label } or false,
						arrow = PolestarNavArrow:IsShown(),
						distance = Polestar.Nav.GetDistance() and math.floor(Polestar.Nav.GetDistance() + 0.5) or false,
					})
				end
				snap("login")
				w.accept(783, {}, "A Threat Within")
				stub.advance(0.5)
				snap("accepted 783")
				w.turnIn(783)
				w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
				stub.advance(0.5)
				snap("on 7, heading to camp")
				w.moveTo(1429, 47.6, 35.1)
				stub.advance(1)
				w.progress(7, 1, 4)
				stub.advance(0.5)
				snap("at camp, 4 kills")
				w.progress(7, 1, 10)
				w.finish(7)
				stub.advance(0.5)
				snap("objectives done")
				w.turnIn(7)
				stub.advance(0.5)
				snap("guide done")"#;

#[test]
fn a_compiled_guide_drives_the_real_engine_guide_window_and_arrow_through_a_quest_flow() {
	let data = fixture_data();
	let r = forge_addontest::dsl::compile_with(&[("e2e.guide", GUIDE)], &data, None);
	assert_eq!(errors(&r), Vec::<String>::new());
	let pack = write_test_pack(&r.guides, &data, &our_manifest());
	let out = run_pack(&pack.scripts, FLOW);
	let (login, accepted, on_seven, at_camp, objectives_done, done) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5]);
	let texts = |s: &Value| -> Vec<String> { s["rows"].as_array().unwrap().iter().map(|r| text(&r["text"]).to_string()).collect() };

	// Login: the guide is suggested for a level-1 Human and its first step shows.
	assert_eq!(login["guide"], "forever/alliance/human/01-northshire");
	assert_eq!(login["step"], 1);
	assert_eq!(login["card"], "Deputy Willem");
	assert!(texts(login).iter().any(|t| is_match(t, "A Threat Within")), "{}", login["rows"]);
	assert_eq!(json!([login["target"]["x"], login["target"]["y"]]), json!([48.17, 42.94]));
	assert_eq!(login["arrow"], true);
	assert!(login["distance"].as_f64().is_some_and(|d| d > 0.0), "arrow measures a distance to Deputy Willem");

	// Accepting 783 moves the window and the arrow to Marshal McBride.
	assert_eq!(accepted["step"], 2);
	assert_eq!(accepted["card"], "Marshal McBride");
	assert_eq!(json!([accepted["target"]["x"], accepted["target"]["y"]]), json!([48.92, 41.61]));

	// After the hand-in, the arrow leads to the kobolds themselves (the nearest place they spawn), not the
	// camp's Go to, which is the step's header.
	assert_eq!(on_seven["step"], 3);
	assert_eq!(on_seven["card"], "Kobold camp");
	assert_eq!(json!([on_seven["target"]["x"], on_seven["target"]["y"]]), json!([45.1, 33.9]));

	// Arriving completes the goto; the kill goal shows live progress.
	assert_eq!(at_camp["step"], 3);
	let kill_row = at_camp["rows"].as_array().unwrap().iter().find(|r| is_match(text(&r["text"]), "Kobold Vermin"));
	assert!(kill_row.is_some(), "{}", at_camp["rows"]);
	assert_eq!(kill_row.unwrap()["progress"], "4/10");

	assert_eq!(objectives_done["step"], 4);
	assert_eq!(objectives_done["card"], "Marshal McBride", "the window names the person to hand in to");

	// Turning in the last quest completes the guide; the window says so.
	assert_eq!(done["emptyTitle"], "Guide complete");
}

// Group content: the compiler derives `group` from the data (dungeon and raid quests, elites) or takes the
// author's `group 3`; the guide window says it under the goal, once per run, and the guide menu tags the guide
// "Group".
const GROUP_GUIDE: &str = r#"guide forever/class/hollow
title The Hollow Deeps
category Class
faction Alliance
levels 1-60
zone Elwynn Forest

step Marshal McBride
  accept 9600
  accept 9603
  accept 9601
  accept 9602

step Kobolds
  kill 95003 group 3
  kill 95003 "Kill the Elite Kobold again"
"#;

const GROUP_SCRIPT: &str = r#"
				${loads}
				stub.login()
				stub.advance(0.5)
				local w, GF = stub.world, Polestar.UI.GuideFrame
				local DUNGEON = "|c" .. Polestar.Theme.Hex("dungeon")
				local function subs()
					local out = {}
					for _, r in ipairs(GF.rows) do
						if r:IsShown() then
							local sub = r.Sub:IsShown() and r.Sub:GetText() or ""
							out[#out + 1] = { sub = sub:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), coloured = sub:find(DUNGEON, 1, true) == 1 }
						end
					end
					return out
				end
				Polestar.Engine.SetGuide("forever/class/hollow")
				stub.advance(0.5)
				local accepts = subs()
				for _, q in ipairs({ 9600, 9603, 9601, 9602 }) do w.accept(q, {}) end
				stub.advance(0.5)
				local kills = subs()
				Polestar.UI.ShowPicker()
				Polestar.UI.Picker.SetCategory("All")
				local chips = {}
				for _, f in ipairs(stub.frames) do
					if f.psGuide and rawget(f, "Range") and f:IsShown() then
						chips[f.psGuide.id] = f.Group:IsShown() and f.Group.Text:GetText() or false
					end
				end
				Polestar.UI.Picker.Select("forever/class/hollow")
				local details = {}
				for _, c in ipairs(Polestar.UI.Picker.details.Chips) do if c:IsShown() then details[#details + 1] = c.Text:GetText() end end
				emit({ accepts = accepts, kills = kills, chips = chips, details = details })"#;

#[test]
fn a_compiled_guide_with_group_content_shows_the_group_line_once_per_run_and_the_menu_s_group_chip() {
	let data = group_data();
	let r = forge_addontest::dsl::compile_with(&[("e2e.guide", GUIDE), ("hollow.guide", GROUP_GUIDE)], &data, None);
	assert_eq!(errors(&r), Vec::<String>::new());
	let pack = write_test_pack(&r.guides, &data, &our_manifest());
	let out = &run_pack(&pack.scripts, GROUP_SCRIPT)[0];
	let dungeon = json!({ "sub": "Dungeon: Hollow Deeps", "coloured": true });
	let none = json!({ "sub": "", "coloured": false });
	// Two quests in the Hollow Deeps say it once; the raid quest names its raid; the breadcrumb with the
	// dungeon's area is done outside.
	assert_eq!(out["accepts"], json!([dungeon, none, { "sub": "Raid: Molten Core", "coloured": true }, none]));
	// The author's group size wins over the elite the data names.
	assert_eq!(out["kills"], json!([{ "sub": "Group of 3 advised", "coloured": true }, { "sub": "Elite: group advised", "coloured": true }]));
	assert_eq!(out["chips"], json!({ "forever/class/hollow": "Group", "forever/alliance/human/01-northshire": false }));
	let details = out["details"].as_array().unwrap();
	assert_eq!(Value::from(details[..2].to_vec()), json!(["Levels 1\u{2013}60", "Group"]));
}

// Escort quests: the compiler marks an escort quest's accept and complete (tools/lib/dsl/escort.js); the
// guide window says under the first one of the card that the NPC may have to respawn, never under a turn-in.
const ESCORT_GUIDE: &str = r#"guide forever/class/escort
title The Vineyard Walk
category Class
faction Alliance
levels 1-60
zone Elwynn Forest

step Marshal McBride
  accept 9700
  accept 9704
  accept 9701
  complete 9700
  complete 9701
  turnin 9700
  turnin 9701
"#;

const ESCORT_SCRIPT: &str = r#"
				${loads}
				stub.login()
				stub.advance(0.5)
				local w, GF = stub.world, Polestar.UI.GuideFrame
				local DUNGEON = "|c" .. Polestar.Theme.Hex("dungeon")
				local function subs()
					local out = {}
					for _, r in ipairs(GF.rows) do
						if r:IsShown() then
							local sub = r.Sub:IsShown() and r.Sub:GetText() or ""
							out[#out + 1] = { t = r.psGoal.t, quest = r.psGoal.quest, sub = sub:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), coloured = sub:find(DUNGEON, 1, true) == 1 }
						end
					end
					return out
				end
				Polestar.Engine.SetGuide("forever/class/escort")
				stub.advance(0.5)
				local before = subs()
				w.accept(9700, { { text = "Escort Brother Danil to the vineyard", required = 1 }, { text = "Kobold Vermin slain: 0/3", required = 3 } }, "The Vineyard Walk")
				w.accept(9704, { { text = "Keep the vigil at the abbey", required = 1 } }, "The Vigil")
				w.accept(9701, {}, "Out of the Abbey")
				stub.advance(0.5)
				local accepted = subs()
				w.finish(9700)
				w.finish(9701)
				stub.advance(0.5)
				emit({ before = before, accepted = accepted, finished = subs() })"#;

#[test]
fn compiled_escort_quests_say_once_per_card_under_the_accepts_and_then_the_completes_that_the_npc_may_have_to_respawn() {
	let data = escort_data();
	let r = forge_addontest::dsl::compile_with(&[("e2e.guide", GUIDE), ("escort.guide", ESCORT_GUIDE)], &data, None);
	assert_eq!(errors(&r), Vec::<String>::new());
	let pack = write_test_pack(&r.guides, &data, &our_manifest());
	let out = &run_pack(&pack.scripts, ESCORT_SCRIPT)[0];
	const LINE: &str = "Escort: if the NPC is not there, wait for it to respawn";
	let row = |t: &str, quest: i32, sub: &str, coloured: bool| json!({ "t": t, "quest": quest, "sub": sub, "coloured": coloured });
	// The card lists the whole step (the later visit to the Marshal named on its rows). Once per card, under the
	// first escort; not under The Vigil, an event.
	let mcbride = "Marshal McBride";
	assert_eq!(
		out["before"],
		json!([
			row("accept", 9700, LINE, true),
			row("accept", 9704, "", false),
			row("accept", 9701, "", false),
			row("complete", 9700, "", false),
			row("complete", 9701, "", false),
			row("turnin", 9700, mcbride, false),
			row("turnin", 9701, mcbride, false),
		])
	);
	// Accepted: the completes say it once, before the open objectives; the accepts stay listed, done.
	let objectives = "Escort Brother Danil to the vineyard 0/1  ·  Kobold Vermin slain: 0/3";
	assert_eq!(
		out["accepted"],
		json!([
			row("accept", 9700, mcbride, false),
			row("accept", 9704, mcbride, false),
			row("accept", 9701, mcbride, false),
			row("complete", 9700, &format!("{LINE}  ·  {objectives}"), true),
			row("complete", 9701, "", false),
			row("turnin", 9700, mcbride, false),
			row("turnin", 9701, mcbride, false),
		])
	);
	// The walks are over: nothing says the escort line any more.
	let finished = out["finished"].as_array().unwrap();
	assert_eq!(finished.len(), 7);
	for r in finished {
		assert!(!text(&r["sub"]).contains("Escort"), "{} {}: {}", text(&r["t"]), r["quest"], text(&r["sub"]));
	}
}

// The Map page is assembled from several modules: the options window declares its tabs and sections, and Nav,
// Quests, Rares and Maps fill them by name. A name that drifts would open a stray section or tab.
#[test]
fn the_map_page_gathers_every_map_setting_from_its_modules_into_the_declared_tabs_and_sections() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		script: r#"
			stub.login()
			local O = Polestar.UI.Options
			Polestar.UI.ShowOptions("map")
			local tabs = {}
			for _, p in ipairs(O.Pages()) do if p.key == "map" then tabs = p.tabs end end
			local out = { tabs = tabs, sections = {}, keys = {} }
			for _, t in ipairs(tabs) do
				O.Select("map", t)
				local heads = {}
				for _, h in ipairs(O.view.headers) do if h:IsShown() then heads[#heads + 1] = h.Text:GetText() end end
				local keys = {}
				for k in pairs(O.Controls("map", t)) do keys[#keys + 1] = k end
				table.sort(keys)
				out.sections[t], out.keys[t] = heads, keys
			end
			emit(out)"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["tabs"], json!(["Guide & quests", "Rares & travel", "Zones"]));
	assert_eq!(
		out["sections"],
		json!({
			"Guide & quests": ["Guide", "Quest markers"],
			"Rares & travel": ["Rares and treasures", "Dungeons and travel", "NPC services"],
			"Zones": ["Zones", "Coordinates"],
		})
	);
	assert_eq!(
		out["keys"]["Guide & quests"],
		json!([
			"maps.minimapButton",
			"nav.minimapPins",
			"nav.trailDots",
			"nav.upcomingPins",
			"nav.worldPins",
			"qol.availableQuests",
			"qol.guideDim",
			"qol.guideHighlight",
			"qol.lowLevelQuests",
			"qol.mapObjectives",
			"qol.minimapObjectives",
			"qol.objectiveAreas",
			"qol.questLevelWindow",
			"qol.turnInMarkers",
		])
	);
	let mut rares: Vec<String> =
		["maps.dockPins", "maps.dungeonPins", "maps.innPins", "maps.taxiPins", "maps.travelMinimap", "maps.serviceMinimap", "maps.servicePins"].iter().map(|s| s.to_string()).collect();
	rares.extend(
		["repair", "mailbox", "class", "weapon", "auctioneer", "banker", "battlemaster", "spirithealer", "stablemaster", "trainer", "vendor"].iter().map(|key| format!("maps.serviceFilters.{key}")),
	);
	rares.extend(["rares.hideGrey", "rares.minimapRares", "rares.minimapTreasures", "rares.worldRares", "rares.worldTreasures"].iter().map(|s| s.to_string()));
	rares.sort();
	assert_eq!(out["keys"]["Rares & travel"], json!(rares));
	assert_eq!(out["keys"]["Zones"], json!(["maps.coords", "maps.minimapCoords", "maps.reveal", "maps.zoneLevels"]));
}
