//! A route through a guide both factions play, in Polestar's own pack loaded the way the client loads it
//! (docs/PACK_FORMAT.md, "Format 8"): only the player's faction's part. Shen'dralas (forever/40-50/shendralas)
//! hands each side to its own Feralas, one `next` per faction; the other side's Feralas is in the part this
//! character never loads (Guides.OtherSidePart). The route walks past it to the character's own Feralas,
//! so "Not part of your route" (RoutePlan.OffRoute) says what it knows, and the Engine's
//! chain needs (Own.chainOf) don't stop at "a guide down the chain is not loaded".

use forge_addontest::run::{addons_dir, lua_string};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn pack_files(name: &str) -> String {
	let files = forge_addontest::run::dir_files(&addons_dir().join(name)).unwrap_or_else(|e| panic!("{e}"));
	let list: Vec<String> = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	format!("stub.packs[{}] = {{ {} }}", lua_string(name), list.join(", "))
}

fn run(faction: &str, race: &str, from: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"{}\n{}\nlocal w = stub.world\nw.faction, w.race, w.raceName, w.level = {}, {}, {}, 44\nw.onQuest(990001, {{ 1 }}, \"Stray Errand\")",
			pack_files("Polestar_Guides_Alliance"),
			pack_files("Polestar_Guides_Horde"),
			lua_string(faction),
			lua_string(race),
			lua_string(race)
		),
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Guides")],
		saved: vec![("Polestar".into(), "PolestarCharDB = { schema = 1 }".into())],
		login: true,
		script: format!(
			r#"local G, P = Polestar.Guides, Polestar.RoutePlan
local id = {}
local off = P.OffRoute(id)
local titles = {{}}
for _, q in ipairs(off or {{}}) do titles[#titles + 1] = q.title end
emit({{ from = G.Get(id) ~= nil, shendralas = G.Get("forever/40-50/shendralas") ~= nil,
	horde = G.Get("forever/horde/40-50/03-feralas") ~= nil, alliance = G.Get("forever/alliance/40-50/03-feralas") ~= nil,
	offRoute = off and titles or false }})"#,
			lua_string(from)
		),
	})
	.remove(0)
}

#[test]
fn a_route_through_shendralas_skips_the_other_faction_s_feralas_and_still_says_what_is_off_the_route() {
	let a = run("Alliance", "Human", "forever/alliance/40-50/02-badlands");
	assert_eq!(
		a,
		json!({ "from": true, "shendralas": true, "horde": false, "alliance": true, "offRoute": ["Stray Errand"] })
	);
	let h = run("Horde", "Orc", "forever/horde/40-50/02-feralas");
	assert_eq!(
		h,
		json!({ "from": true, "shendralas": true, "horde": true, "alliance": false, "offRoute": ["Stray Errand"] })
	);
}
