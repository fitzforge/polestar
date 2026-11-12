//! Lookup's quest steps warn of the elites at an object's work (#1778): Berard's Journal, from Berard's Bookshelf
//! in Pyrewood Village (A Recipe For Death, the Ruins of Lordaeron's pick-up guide), lies beside Apothecary
//! Berard, a level 16 elite, among the village's elite Watchers, Sentries and Elders; the step said nothing. The
//! Codex build marks such an objective per side (forge-data codex/elites.rs, packed `w<side><rank>,<lvl>` after
//! the objective); an interact, or a collect of an item only objects give, carries the compiled guides' `group`
//! (UI.GroupLine: "Elite: group advised") for the character's side, read from the record: nothing is searched in
//! game. A tiny Codex is registered by hand (Codex.Register), with Core and Lookup on the stub world.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// The ledger (an item from the crate) and the crate marked for both sides (the Horde's mark the higher level: an
// Alliance elite stands there too); the far crate unmarked; a pack from before the mark (the same crate, no `w`).
const CODEX: &str = r#"
Polestar.RegisterMapFrames({ era = { [9001] = { c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 } } })
local C = Polestar.Codex
C.Register("meta", { version = 1 })
C.Register("npc", "\n8003\t\tWarden Ilsa", "\n8003\t19;;;;;;;9001,e,500,500")
C.Register("object", "\n6002\t\tSupply Crate\n6003\t\tLonely Crate", "\n6002\t;;9001,e,630,420\n6003\t;;9001,e,200,200")
C.Register("item", "\n8100\t\tMarked Ledger", "\n8100\t1;;;;;;;o6002,100,l")
C.Register("quest", "\n7101\t\tThe Ledger\n7102\t\tThe Crate\n7103\t\tThe Far Crate\n7104\t\tThe Old Crate",
	"\n7101\t20;15;;;;9001;8003;;;8003;;;;;;i8100,1,Marked Ledger;wA1,21;wH1,30" ..
	"\n7102\t20;15;;;;9001;8003;;;8003;;;;;;o6002,1,Supply Crate;wA1,21;wH1,30" ..
	"\n7103\t20;15;;;;9001;8003;;;8003;;;;;;o6003,1,Lonely Crate" ..
	"\n7104\t20;15;;;;9001;8003;;;8003;;;;;;o6002,1,Supply Crate")
local function groups(id)
	local out = {}
	for _, g in ipairs(Polestar.Lookup.QuestStep(C.Quest(id), nil).goals) do
		if g.t ~= "accept" and g.t ~= "turnin" then out[#out + 1] = { t = g.t, group = g.group or false } end
	end
	return out
end
emit({ ledger = groups(7101), crate = groups(7102), far = groups(7103), old = groups(7104) })
"#;

fn run(faction: &str, race: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_lookup_runtime.lua"],
		before: format!(
			"local w = stub.world\nw.addMap(9001, {{ name = \"Amber Vale\", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 }})\nw.moveTo(9001, 50, 50)\nw.level, w.race, w.raceName, w.faction = 20, \"{race}\", \"{race}\", \"{faction}\""
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml"])],
		login: true,
		script: CODEX.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn issue_1778_an_object_s_work_the_codex_marks_among_elites_says_elite_group_advised_for_that_side() {
	let alliance = run("Alliance", "Human");
	let a = json!({ "kind": "elite", "rank": 1, "lvl": 21 });
	assert_eq!(alliance["ledger"], json!([{ "t": "collect", "group": a }]), "the item from the crate, among the elites");
	assert_eq!(alliance["crate"], json!([{ "t": "interact", "group": a }]));
	assert_eq!(alliance["far"], json!([{ "t": "interact", "group": false }]), "an unmarked crate: no warning");
	assert_eq!(alliance["old"], json!([{ "t": "interact", "group": false }]), "a pack from before the mark: no warning");
	let horde = run("Horde", "Orc");
	assert_eq!(horde["ledger"], json!([{ "t": "collect", "group": { "kind": "elite", "rank": 1, "lvl": 30 } }]), "the Horde's own mark");
}
