//! `enter "<Place>"` during play (addon/Polestar/Core/Engine.lua): done while the zone or subzone text reads the
//! place (inPlace, as for `hearth`), kept once the live step had it, so walking out again does not reopen it.
//! Coordinates only point the arrow. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn
//! Forest), as tests/engine-when-dungeon.rs.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setZone("Elwynn Forest", "Northshire Valley")
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
"#;

// Step 1 goes to Goldshire (an area, with a point for the arrow), step 2 to Westfall (a zone), step 3 hands
// in A Threat Within.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/enter", pack = "test", title = "Enter", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Goldshire", goals = { { t = "enter", location = "Goldshire", map = 1429, x = 42.1, y = 65.9 } } },
		{ title = "Westfall", goals = { { t = "enter", location = "Westfall" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/enter" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, "E = Polestar.Engine", "function flush() stub.advance(0.25) end", "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script]
			.join("\n"),
		..Default::default()
	})
}

#[test]
fn enter_is_done_once_the_subzone_or_zone_text_reads_the_place_and_stays_done() {
	let out = run(r#"
		local out = { start = E.GetLiveStep() }
		local wp = E.GetWaypoint()
		out.arrow = wp and { wp.map, wp.x, wp.y } or false
		stub.world.setZone("Elwynn Forest", "Goldshire"); flush()
		out.area = E.GetLiveStep()
		stub.world.setZone("Elwynn Forest", "Brackwell Pumpkin Patch"); flush()
		out.left = { E.GetLiveStep(), E.GetStepView(1).status }
		stub.world.setZone("Westfall", ""); flush()
		out.zone = E.GetLiveStep()
		emit(out)
	"#);
	let rows = &out[0];
	assert_eq!(rows["start"], 1);
	assert_eq!(rows["arrow"], json!([1429, 42.1, 65.9]), "the coordinates point the arrow");
	assert_eq!(rows["area"], 2, "in Goldshire: step 1 is done");
	assert_eq!(rows["left"], json!([2, "done"]), "walking on does not reopen it");
	assert_eq!(rows["zone"], 3, "in Westfall, a zone: step 2 is done");
}

#[test]
fn guides_validate_takes_enter_with_a_location_and_refuses_it_without() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(goal) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { goals = { goal } } } } end
			emit({ ok = V(g({ t = "enter", location = "Goldshire", area = 87 })) or "ok", none = V(g({ t = "enter" })) or "ok" })
		"#
		.into(),
		..Default::default()
	});
	assert_eq!(out[0]["ok"], "ok");
	assert!(is_match(text(&out[0]["none"]), "enter needs location"));
}
