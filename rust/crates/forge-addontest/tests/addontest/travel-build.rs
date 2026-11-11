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

// The flight points Forever added (`forge data travel`: the Forever client's TaxiNodes rows the Era client lacks,
// with their TaxiPath flights) leave every Era node and flight as the Era client has them: 63 flight masters and
// 268 flights between them, the lengths below the committed file's before they came (0.3.7), among them the
// flights of the Era flight masters the new ones fly to.
#[test]
fn the_committed_traveldata_lua_keeps_every_era_flight_master_and_flight_as_it_was() {
	let out = nav_run(
		r#"
			local d = Polestar.Nav.GetTravelData()
			local forever = { [559] = true, [3203] = true, [3242] = true, [3276] = true }
			local out = { nodes = 0, flights = 0, legs = {} }
			for _, n in ipairs(d.taxi) do
				if not forever[n.id] then out.nodes = out.nodes + 1 end
			end
			for from, list in pairs(d.flights) do
				for i = 1, #list - 1, 2 do
					if not (forever[from] or forever[list[i]]) then out.flights = out.flights + 1 end
					out.legs[from .. ">" .. list[i]] = list[i + 1]
				end
			end
			local n = d.taxiById[5]
			out.lakeshire = { n.c, n.wx, n.wy, n.map, n.x, n.y, n.f, n.faction }
			emit(out)"#,
	);
	assert_eq!((&out["nodes"], &out["flights"]), (&json!(63), &json!(268)));
	let era = [
		("2>5", 3368),
		("5>2", 3374),
		("5>12", 1812),
		("5>71", 1825),
		("71>5", 1884),
		("6>8", 3037),
		("8>6", 3266),
		("8>16", 4902),
		("17>13", 3493),
		("11>21", 14630),
		("21>11", 14918),
		("21>70", 2593),
		("70>21", 2994),
		("56>20", 5646),
		("20>56", 6151),
		("56>21", 8555),
		("52>49", 3639),
		("53>23", 9115),
		("23>25", 3304),
		("25>23", 4252),
	];
	for (leg, yards) in era {
		assert_eq!(out["legs"][leg], yards, "flight {leg}");
	}
	assert_eq!(out["lakeshire"], json!([0, -9429.1, -2231.4, 1433, 30.43, 58.99, "e", 1]), "Lakeshire where the Era client has it");
}

// The Riverglades' Rog'mar (Horde) and Farholde Keep (Alliance), Mount Hyjal's Summit of Eternity and Tainted
// Foothills (both sides): on maps Forever added, which have no Era frame, so their x, y are on the live frame
// (the 11th field "l", no `f`) and the client's map turns them into the node's own world point. Their flights'
// lengths are what players fly: recordings to 2026-11-11 (builds 70862, 70888), at 30 yd/s within a second
// (Stonard -> Rog'mar 170 s over 5085 yd, Rog'mar -> Kargath 120 s over 3607 yd, Hammerfall -> Rog'mar 326 s over
// 9767 yd, Lakeshire -> Farholde Keep 132 s over 3962 yd, Morgan's Vigil -> Farholde Keep 131 s over 3936 yd).
#[test]
fn the_committed_traveldata_lua_has_the_flight_points_forever_added_on_their_live_maps_with_their_flights() {
	let out = nav_run(
		r#"
			local nav = stub.nav
			nav.maps[2548] = { c = 0, top = -6466.666, bottom = -9700, left = -1891.666, right = -6741.666, name = "Riverglades" }
			nav.maps[2482] = { c = 1, top = 6304.166, bottom = 3989.583, left = -922.916, right = -4395.834, name = "Mount Hyjal" }
			local d = Polestar.Nav.GetTravelData()
			local out = {}
			for _, id in ipairs({ 3203, 3276, 559, 3242 }) do
				local n = Polestar.Nav.GetTaxiNode(id)
				local to, from = {}, {}
				local list = d.flights[id] or {}
				for i = 1, #list - 1, 2 do to[#to + 1] = list[i] .. ":" .. list[i + 1] end
				for f, l in pairs(d.flights) do
					for i = 1, #l - 1, 2 do
						if l[i] == id then from[#from + 1] = f end
					end
				end
				table.sort(to)
				table.sort(from)
				local c, wx, wy = nav.Compat.MapToWorld(n.map, n.x, n.y, n.f)
				local off = c == n.c and math.floor(((wx - n.wx) ^ 2 + (wy - n.wy) ^ 2) ^ 0.5 + 0.5) or false
				out[tostring(id)] = { n.name, n.map, n.faction, n.f or "live", off, to, from }
			end
			emit(out)"#,
	);
	assert_eq!(
		out,
		json!({
			"3203": ["Rog'mar, Riverglades", 2548, 2, "live", 0, ["17:9845", "21:3607", "56:4624", "70:3993"], [17, 21, 56, 70]],
			"3276": ["Farholde Keep, Riverglades", 2548, 1, "live", 0, ["5:3917", "71:3676", "8:5193"], [5, 8, 71]],
			"559": ["Summit of Eternity, Mount Hyjal", 2482, 3, "live", 0, ["3242:1866"], [3242]],
			"3242": ["Tainted Foothills, Mount Hyjal", 2482, 3, "live", 0, ["52:3745", "53:3967", "559:1849"], [52, 53, 559]],
		})
	);
}

// A Horde character at Stonard's flight master who knows Rog'mar is flown there (the planner over the committed
// network), in the 170 s players take.
#[test]
fn from_stonard_a_horde_character_who_knows_rog_mar_flies_there() {
	let out = nav_run(
		r#"
			local legs = Polestar.Nav.PlanRoute({ c = 0, wx = -10457, wy = -3279, faction = 2, known = { [56] = true, [3203] = true }, speed = 7,
				target = { c = 0, wx = -7930, wy = -4800, label = "Rog'mar" } })
			local out = {}
			for _, l in ipairs(legs or {}) do
				out[#out + 1] = { l.kind, l.kind == "fly" and l.stops and l.stops[#l.stops].id or false, math.floor(l.seconds + 0.5) }
			end
			emit(out)"#,
	);
	let fly: Vec<&Value> = out.as_array().unwrap().iter().filter(|l| l[0] == "fly").collect();
	assert_eq!(fly.len(), 1, "{out}");
	assert_eq!(fly[0][1], 3203, "{out}");
	assert!(fly[0][2].as_f64().is_some_and(|s| (165.0..=180.0).contains(&s)), "{out}");
}

// #1674 (Megabite): on the Rohashi Spires after Lorthuna, the next step's turn-in at Elaadrin Evengale in
// Valanaar said to hearth: the planner knew no way down but walking. The Portal to Valanaar beside her
// sets the player down beside Elaadrin in five seconds. Zephras Isle (uiMap 2521, continent 2991) on its
// live frame (data/forever/map-frames.json), the Hearthstone bound to Valanaar and ready.
#[test]
fn from_lorthunas_terrace_to_elaadrin_in_valanaar_the_route_takes_the_portal_down_never_the_hearthstone() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: r#"
			local nav = stub.nav
			nav.maps[2521] = { c = 2991, top = 4956.25, bottom = 1247.917, left = 4231.25, right = -1331.25, name = "Zephras Isle" }
			nav.faction = "Alliance"
			nav.items[6948] = 1
			nav.bind = "Valanaar"
			local _, wx, wy = stub.nav.Compat.MapToWorld(2521, 74.87, 53.02, "l")
			nav.place(wx, wy, 2991)
			Polestar.Nav.SetTarget(2521, 66.63, 79.94, "Elaadrin Evengale", "l")
			local legs, ci = Polestar.Nav.GetRoute()
			local r = { kinds = {}, transports = {} }
			for i = ci or 1, legs and #legs or 0 do
				r.kinds[#r.kinds + 1] = legs[i].kind
				if legs[i].transport then r.transports[#r.transports + 1] = tostring(legs[i].transport.id) end
			end
			local ids = {}
			for _, p in ipairs(Polestar.Nav.GetTravelData().portals) do ids[#ids + 1] = p.id end
			r.portals = ids
			emit(r)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let kinds: Vec<&str> = out["kinds"].as_array().unwrap().iter().filter_map(|v| v.as_str()).collect();
	assert!(!kinds.contains(&"hearth"), "no Hearthstone off the heights ({})", kinds.join(", "));
	assert_eq!(out["transports"], json!(["portal-valanaar"]), "the Portal to Valanaar ({})", kinds.join(", "));
	let portals = out["portals"].as_array().unwrap();
	assert!(portals.contains(&json!("portal-rohashi-spires")), "the shrine's portal up is known too ({portals:?})");
}

// KEPT IN JS: a flight master in a city uses its named city, not the surrounding region (#347) | flight masters, flights, transports and inns come from the client tables and spawn data | each inn gets the AreaTable area of its bind location in its own zone, never a Forever copy of the town | learned walking paths follow recorded breadcrumbs, mark zone borders and break at flights | works with no recordings at all | the CLI writes byte-identical travel.json, TravelData.lua and FlightPaths.lua on every run | with --lua and no --flight-lua the CLI writes FlightPaths.lua beside it, never into the addon | generated TravelData.lua loads under Lua 5.1 and the addon planner routes with it | every committed inn's area is named, in English, like one of its bind locations | a Forever ship calling at three docks: one transport per dock pair, following the loop | a ship stop in the water 12 yd off a pier gets a board point on the deck; a stop on dry ground gets none | an end on dry ground gets the floor nearest its source's height: the entrance under a roof, not the roof | every boat end of the committed TravelData.lua is boarded on dry ground within 30 yd of its stop
