//! `travel build` (tools/lib/travel, tools/commands/travel.js) on fixture Blizzard CSVs, data/forever-shaped JSON
//! and one recording: what it keeps, where it puts docks and inns, learned paths, determinism, and that the
//! generated TravelData.lua loads and plans under Lua 5.1.

use forge_addontest::{emitted, truthy, Addon, RunAddon};
use serde_json::{json, Value};

fn nav_run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])], script: script.into(), ..Default::default() }).remove(0)
}

#[test]
fn the_committed_traveldata_lua_is_loaded_by_the_addon_with_the_real_network() {
	let counts = nav_run("emit({ Polestar.Nav.travel.Counts() })");
	let (taxi, transports, inns) = (&counts[0], &counts[1], &counts[2]);
	assert!(taxi.as_f64().is_some_and(|n| n >= 50.0), "{taxi} flight masters");
	assert!(transports.as_f64().is_some_and(|n| n >= 8.0), "{transports} transports");
	assert!(inns.as_f64().is_some_and(|n| n >= 40.0), "{inns} inns");
	// Inns with their own area answer to both names (GetBindLocation may report either).
	let names = nav_run(
		r#"
			local out = {}
			for _, inn in ipairs(Polestar.Nav.GetTravelData().inns) do
				if inn.npc == 6734 then out = inn.names end
			end
			emit(out)"#,
	);
	assert_eq!(names, json!(["Stoutlager Inn", "Thelsamar"]));
}

// The committed inns, as the addon reads them.
fn committed_inns() -> Vec<Value> {
	let v = nav_run(
		r#"
			local out = {}
			for _, inn in ipairs(Polestar.Nav.GetTravelData().inns) do out[#out + 1] = { npc = inn.npc, area = inn.area or false, names = inn.names } end
			emit(out)"#,
	);
	v.as_array().cloned().unwrap_or_default()
}

#[test]
fn every_inn_of_the_committed_traveldata_lua_has_its_areatable_area() {
	let inns = committed_inns();
	assert!(inns.len() >= 40, "{} inns", inns.len());
	let missing: Vec<Value> = inns.iter().filter(|i| !i["area"].is_number()).map(|i| i["names"][0].clone()).collect();
	assert_eq!(json!(missing), json!([]));
	assert_eq!(inns.iter().find(|i| i["npc"] == 6790).unwrap()["area"], 42, "Darkshire (#83)");
}

#[test]
fn the_committed_traveldata_lua_gives_the_tram_and_zeppelin_ends_their_floor_the_tram_s_entrances_the_towers_tops() {
	let ends = nav_run(
		r#"
			local out = {}
			for _, t in ipairs(Polestar.Nav.GetTravelData().transports) do
				out[t.id] = { t.a.z or false, t.b.z or false }
			end
			emit(out)"#,
	);
	let near = |v: &Value, z: f64| v.as_f64().is_some_and(|f| (f - z).abs() < 3.0);
	let tram = &ends["tram-stormwind-ironforge"];
	assert!(near(&tram[0], 92.0) && near(&tram[1], 502.0), "the tram's entrances in Stormwind (AreaTrigger 96.6) and Ironforge: {},{}", tram[0], tram[1]);
	let og = &ends["zeppelin-orgrimmar-undercity"];
	assert!(near(&og[0], 54.0), "Orgrimmar's tower top (Frezza at 53.6): {}", og[0]);
}

#[test]
fn the_committed_traveldata_lua_has_the_forever_ships_on_their_dock_maps() {
	let ships = nav_run(
		r#"
			local out = {}
			for _, t in ipairs(Polestar.Nav.GetTravelData().transports) do
				out[t.id] = { t.faction, t.a.map, t.a.f, t.b.map, t.b.f, t.ab, t.ba, t.waitA, t.waitB }
			end
			emit(out)"#,
	);
	let expect = [
		("boat-stormwind-auberdine", json!([1, 1453, "l", 1439, "e"])), // Stormwind Harbor is on Forever's redrawn Stormwind map
		("boat-menethil-southshore", json!([1, 1437, "e", 1424, "e"])),
		("boat-southshore-auberdine", json!([1, 1424, "e", 1439, "e"])),
		("boat-menethil-auberdine", json!([1, 1437, "e", 1439, "e"])),
		("boat-tanaris-powderfuse", json!([3, 1446, "e", 2548, "l"])), // Riverglades: a Forever-only map
	];
	for (id, want) in expect {
		let t = &ships[id];
		assert!(truthy(t), "{id} present");
		let arr = t.as_array().unwrap();
		assert_eq!(json!(arr[..5.min(arr.len())]), want, "{}", id);
		let rest = &arr[5.min(arr.len())..];
		let shown = rest.iter().map(|v| v.to_string()).collect::<Vec<_>>().join(",");
		for secs in rest {
			assert!(secs.as_f64().is_some_and(|s| s > 20.0 && s < 600.0), "{id}: {shown} s");
		}
	}
}

// KEPT IN JS: a flight master in a city uses its named city, not the surrounding region (#347) | flight masters, flights, transports and inns come from the client tables and spawn data | each inn gets the AreaTable area of its bind location in its own zone, never a Forever copy of the town | learned walking paths follow recorded breadcrumbs, mark zone borders and break at flights | works with no recordings at all | the CLI writes byte-identical travel.json, TravelData.lua and FlightPaths.lua on every run | with --lua and no --flight-lua the CLI writes FlightPaths.lua beside it, never into the addon | generated TravelData.lua loads under Lua 5.1 and the addon planner routes with it | every committed inn's area is named, in English, like one of its bind locations | a Forever ship calling at three docks: one transport per dock pair, following the loop | a ship stop in the water 12 yd off a pier gets a board point on the deck; a stop on dry ground gets none | an end on dry ground gets the floor nearest its source's height: the entrance under a roof, not the roof | every boat end of the committed TravelData.lua is boarded on dry ground within 30 yd of its stop
