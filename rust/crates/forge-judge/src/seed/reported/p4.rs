//! Part of tests/guides-reported.test.js (see reported.rs): the tests from line 1911 on that read the
//! compiled guides and the reference data (those that play the guide are in `eng`).

use std::path::Path;

use forge_core::frames::{Frame, MapFrames, Projector, RoutePoint};
use forge_core::MapId;
use forge_guide::diag::Diagnostics;
use forge_guide::js::{str_to_num, Obj, V};
use forge_guide::project::{compile_sources, CompileOpts, Source};
use regex::Regex;

use crate::seed::{at, everyone, for_class, is, located, Check, Ctx, Row, SeedTest};

const DUROTAR: &str = "forever/horde/orc-troll/01-durotar.guide";
const TELDRASSIL: &str = "forever/alliance/nightelf/01-teldrassil.guide";
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest.guide";
const ASHENVALE: &str = "forever/alliance/06-ashenvale.guide";
const WESTFALL: &str = "forever/alliance/02-westfall.guide";
const REDRIDGE: &str = "forever/alliance/04-redridge-mountains.guide";
const HILLSBRAD_HORDE: &str = "forever/horde/06-hillsbrad-foothills.guide";
const SILVERPINE: &str = "forever/horde/03-silverpine-forest.guide";
const DARKSHORE: &str = "forever/alliance/03-darkshore.guide";
const TANARIS_ALLIANCE: &str = "forever/alliance/40-50/04-tanaris.guide";
const ZEPHRAS_HORDE: &str = "forever/horde/skyborne/01-zephras-isle.guide";
const ZEPHRAS_ALLIANCE: &str = "forever/alliance/skyborne/01-zephras-isle.guide";

pub fn tests() -> Vec<SeedTest> {
	let t = |name: &str, f: fn(&Ctx, &mut Check)| (name.to_string(), f);
	vec![
		t("#286: a typed coordinate is near its target's spawns in its own map frame, not only in the other one", typed_coords_frame),
		t("#289: a quest item picked up from objects is collected at one of the objects' spawns", object_items_at_spawns),
		t("forever/horde/05-stonetalon-mountains.guide: Hotline's report (#278): the Bundle of Reports is opened at Kadrak, before the Warsong Scout", warsong_reports),
		t("Pynte's report (#404): guides played below riding level never tell you to ride somewhere", no_riding),
		t(&format!("{TELDRASSIL}: Pynte's report: Flight to Auberdine is flown with Vesprystus, not the boat, and Return to Nessa is handed in (#402, #403)"), flight_to_auberdine),
		t("Bashidian Twotao's report (#385): a quest drop from droppers of several level bands leads to the low ones' camp, not over the whole zone", drops_by_level),
		t(&format!("{WESTFALL}: Pynte's report (#416): the farm quests and Report to Gryan Stoutmantle are taken on the road in, before Sentinel Hill"), westfall_road_in),
		t(&format!("{WESTFALL}: Xaden Ryan's report (#621): the oats are gathered in the Jansen Stead's fields on the way back, not searched over the zone on the road in"), handful_of_oats),
		t("Alx-Ryan's report (#363): on Zephras Isle, the watchtower quests come before Rorian, who takes Harmony in Balance and Falling With Style on one visit", zephras_tower),
		t("𝔄𝔫𝔫𝔦𝔢's report (#285): on Zephras Isle, every objective of a quest is sent for before its turn-in; the Enchanted Gyrozephyr at its spawns", zephras_objectives),
		t("Phear's report (#395): on Zephras Isle, The Wounds of Betrayal and Standing Our Ground lead to each objective, in both guides", zephras_wounds),
		t(&format!("{REDRIDGE}: Tazul's report (#340): the Battleworn Axes lead to the Blackrock camps east of Stonewatch Keep, not to Alther's Mill"), battleworn_axes),
		t(&format!("{DUROTAR}: tor's report (#351): Encroachment is taken after the Tiragarde Keep and Sen'jin, Echo Isles and Kolkar Crag turn-ins"), encroachment),
		t("forever/class/warlock/incubus-horde.guide: Phyz's report (#412): Avelina's and Isaac's hearts each read their own line of Hearts of the Lovers", hearts_of_the_lovers),
		t("Nittepitte's report (#453): Making Do is optional in Redridge and Ashenvale, and taken only after Expanding Horizons is handed in", making_do),
		t(
			&format!("{ASHENVALE}: Ioney's report (#524): Unrequited Love is handed to Tarrel Rockweaver before In Search of the Excavation Team, and taken in Auberdine before the boat"),
			unrequited_love,
		),
		t(&format!("{ASHENVALE}: Ioney's report (#614): Sida's Bag is searched for at Ironbeard's Tomb, not at the oozes across the Wetlands"), sidas_bag),
		t(&format!("{ASHENVALE}: Ioney's report (#617): the grind to 28 comes after the Menethil hand-ins, before Pilot Longbeard"), grind_to_28),
		t(&format!("{TELDRASSIL}: Pynte's report (#327): the Timberling Seed arrow stays round Denalan with the Timberlings, not with the Elder Timberlings in the north"), timberling_seed),
		t(&format!("{TELDRASSIL}: #555: Soft Saber Pelts accept comes before Zenn's Bidding turn-in, so both Nightsaber quests share the first east loop"), soft_saber_pelts),
		t(&format!("{TELDRASSIL}: #619: the Gnarlpine Necklace is looted from Ferocitas before the jewel is collected"), gnarlpine_necklace),
		t("#327: Pirate Hats Ahoy! names every pirate that drops the hat, not the Southsea Kidnapper alone, in both guides", pirate_hats),
		t("forever/alliance/03-darkshore.guide: Deadshot's report (#560): How Big a Threat? points at the furbolg camp by the bears, not the one north-east of Auberdine", how_big_a_threat),
		t("forever/horde/30-40/04-dustwallow-marsh.guide: Syrael's report (#575): the ghost-o-plasm points at the Valley of Bones, after the Kodo Graveyard", ghost_o_plasm),
		t("forever/professions: Schpune's report (#620): Skinning, Mining and Herbalism are learned at level 1, from the Junior trainers in the starting zones too", junior_trainers),
		t(&format!("{ELWYNN}: Nittepitte's report (#613): Marshal Dughan's turn-ins come between Collecting Kelp and The Escape, while William Pestle brews"), collecting_kelp),
		t(&format!("{ELWYNN}: Nittepitte's report (#612): the Mining Tools are picked up on the walk into the Jasperlode Mine, before its far end"), mining_tools),
	]
}

// --- helpers ---

/// `v[k] === n` for a number.
fn num_is(v: &V, k: &str, n: f64) -> bool {
	v.get(k).as_num() == Some(n)
}

/// `v[k] === s` for a string.
fn str_is(v: &V, k: &str, s: &str) -> bool {
	v.get(k).as_str() == Some(s)
}

/// `t === 'collect' && item === item` (and the quest when given; `Some(None)`: no quest).
fn collect(item: f64, quest: Option<Option<f64>>) -> impl Fn(&V) -> bool {
	move |g: &V| {
		str_is(g, "t", "collect")
			&& num_is(g, "item", item)
			&& match quest {
				None => true,
				Some(None) => !g.get("quest").truthy(),
				Some(Some(q)) => num_is(g, "quest", q),
			}
	}
}

/// `compiled(guide)` asserting it compiles to one guide.
fn compiled(ctx: &Ctx, c: &mut Check, guide: &str) -> Option<V> {
	let g = ctx.compiled(guide);
	if g.is_undef() {
		c.ok(false, &format!("{guide} compiles"));
		return None;
	}
	Some(g)
}

/// `goals(guide)` asserting the guide compiles.
fn goals(ctx: &Ctx, c: &mut Check, guide: &str) -> Option<Vec<Row>> {
	compiled(ctx, c, guide)?;
	Some(ctx.goals(guide))
}

/// `yards(a, b)`, asserting both points are on one map with an Era frame.
fn yards(ctx: &Ctx, c: &mut Check, a: &V, b: &V) -> Option<f64> {
	let y = ctx.yards(a, b);
	c.ok(y.is_some(), &format!("points on one map with an Era frame ({}, {})", a.get("map").to_js_string(), b.get("map").to_js_string()));
	y
}

/// A `{ map, x, y }` point.
fn pt(map: f64, x: f64, y: f64) -> V {
	let o = Obj::new();
	o.set("map", map);
	o.set("x", x);
	o.set("y", y);
	V::Obj(o)
}

/// `makeProjector(data.mapFrames)`.
fn projector(ctx: &Ctx) -> Projector {
	let dir = ctx.data.dir.clone().unwrap_or_default();
	let bytes = std::fs::read(Path::new(&dir).join("map-frames.json")).unwrap_or_default();
	Projector::new(&MapFrames::from_json(&bytes).unwrap_or_default())
}

/// `point(map, x, y, f)` with the JS values.
fn point(p: &Projector, map: &V, x: &V, y: &V, f: &V) -> RoutePoint {
	p.point(map.num() as MapId, x.num(), y.num(), f.as_str().and_then(Frame::parse))
}

/// Every spawn point (projected) of the targets on `map`.
fn spawn_points(ctx: &Ctx, p: &Projector, targets: &[(&str, V)], map: &V) -> Vec<RoutePoint> {
	let mut out = Vec::new();
	for (kind, id) in targets {
		for s in ctx.data.spawns(kind, id) {
			if !s.get("map").strict_eq(map) {
				continue;
			}
			for q in s.get("pts").items() {
				out.push(point(p, &s.get("map"), &q.at(0), &q.at(1), &s.get("f")));
			}
		}
	}
	out
}

/// The keys of `o` (an object, or nothing).
fn keys(o: &V) -> Vec<String> {
	if o.is_obj() {
		o.keys().iter().map(|k| k.to_string()).collect()
	} else {
		Vec::new()
	}
}

/// `Math.round`.
fn round(v: f64) -> f64 {
	(v + 0.5).floor()
}

/// `a < at(list, what, pred)`, None (the test stops) when the goal is absent.
fn before_at(c: &mut Check, list: &[Row], a: usize, what: &str, pred: impl Fn(&V) -> bool) -> Option<bool> {
	Some(a < at(c, list, what, pred)?)
}

// --- tests ---

fn typed_coords_frame(ctx: &Ctx, c: &mut Check) {
	let p = projector(ctx);
	let mut offenders = Vec::<String>::new();
	for guide in ctx.all_guides() {
		let Some(g) = compiled(ctx, c, &guide) else { return };
		for (si, ast_step) in g.hidden("_ast").get("steps").items().into_iter().enumerate() {
			for (gi, ag) in ast_step.get("goals").items().into_iter().enumerate() {
				let goal = g.get("steps").at(si).get("goals").at(gi);
				if !ag.get("explicitCoords").truthy() || goal.is_undef() || goal.get("map").is_nullish() || goal.get("x").is_nullish() {
					continue;
				}
				let mut targets: Vec<(&str, V)> = Vec::new();
				if str_is(&goal, "t", "collect") {
					let drops = ctx.data.item(&goal.get("item")).get("drops");
					for id in keys(&drops.get("npc")) {
						targets.push(("npc", V::Num(str_to_num(&id))));
					}
					for id in keys(&drops.get("object")) {
						targets.push(("object", V::Num(str_to_num(&id))));
					}
				} else if goal.get("npc").truthy() {
					targets.push(("npc", V::Num(goal.get("npc").num())));
				} else if goal.get("object").truthy() {
					targets.push(("object", V::Num(goal.get("object").num())));
				}
				let pts = spawn_points(ctx, &p, &targets, &goal.get("map"));
				if pts.is_empty() {
					continue;
				}
				let f = if goal.get("f").truthy() { goal.get("f") } else { V::str("l") };
				let near = |q: RoutePoint| pts.iter().map(|s| (s.wx - q.wx).hypot(s.wy - q.wy)).fold(f64::INFINITY, f64::min);
				let own = near(point(&p, &goal.get("map"), &goal.get("x"), &goal.get("y"), &f));
				let other_f = V::str(if f.as_str() == Some("l") { "e" } else { "l" });
				let other = near(point(&p, &goal.get("map"), &goal.get("x"), &goal.get("y"), &other_f));
				if own > 40.0 && other < 10.0 {
					offenders.push(format!(
						"{guide}:{} {} @{},{} (step {}) is {} yd from its target in its {} frame, {} yd in the other",
						ag.get("line").to_js_string(),
						goal.get("t").to_js_string(),
						goal.get("x").to_js_string(),
						goal.get("y").to_js_string(),
						g.get("steps").at(si).get("title").to_js_string(),
						round(own),
						if f.as_str() == Some("l") { "live" } else { "Era" },
						round(other)
					));
				}
			}
		}
	}
	c.eq(offenders, vec![], "typed coordinates written in the other map frame");
}

const AWAY_FROM_ITS_OBJECTS: [&str; 3] = ["forever/professions/fishing.guide 16968", "forever/professions/fishing.guide 16969", "forever/professions/fishing.guide 16970"];

fn object_items_at_spawns(ctx: &Ctx, c: &mut Check) {
	let p = projector(ctx);
	let mut offenders = Vec::<String>::new();
	for guide in ctx.all_guides() {
		let Some(list) = goals(ctx, c, &guide) else { return };
		for Row { step, goal, .. } in list {
			if !str_is(&goal, "t", "collect") || goal.get("map").is_nullish() || goal.get("x").is_nullish() {
				continue;
			}
			let item = ctx.data.item(&goal.get("item"));
			if !item.truthy() || !item.get("questItem").truthy() || !item.get("drops").truthy() {
				continue;
			}
			let objects = keys(&item.get("drops").get("object"));
			if objects.is_empty() || !keys(&item.get("drops").get("npc")).is_empty() {
				continue;
			}
			let targets: Vec<(&str, V)> = objects.iter().map(|id| ("object", V::Num(str_to_num(id)))).collect();
			let pts = spawn_points(ctx, &p, &targets, &goal.get("map"));
			if pts.is_empty() {
				continue;
			}
			let f = if goal.get("f").truthy() { goal.get("f") } else { V::str("l") };
			let mut near = f64::INFINITY;
			for g in std::iter::once(goal.clone()).chain(goal.get("spots").items()) {
				let q = point(&p, &goal.get("map"), &g.get("x"), &g.get("y"), &f);
				for s in &pts {
					near = near.min((s.x - q.x).hypot(s.y - q.y));
				}
			}
			let key = format!("{guide} {}", goal.get("item").to_js_string());
			if near > 1.0 && !AWAY_FROM_ITS_OBJECTS.contains(&key.as_str()) {
				offenders.push(format!(
					"{guide} collect {} @{},{} (step {}) is {near:.2} from its objects",
					goal.get("item").to_js_string(),
					goal.get("x").to_js_string(),
					goal.get("y").to_js_string(),
					step.get("title").to_js_string()
				));
			}
		}
	}
	c.eq(offenders, vec![], "quest items collected away from the objects that hold them");
}

fn warsong_reports(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, "forever/horde/05-stonetalon-mountains.guide") else { return };
	let Some(reports) = at(c, &list, "the Warsong Reports", collect(16746.0, Some(None))) else { return };
	let count = list[reports].goal.get("count");
	c.ok(if count.truthy() { count.as_num() == Some(1.0) } else { true }, "any report in the bags shows the bundle was opened");
	let Some(kadrak) = at(c, &list, "accept 6543", is("accept", 6543)) else { return };
	c.ok(list[reports].step.strict_eq(&list[kadrak].step), "opened on the Kadrak step");
	for update in [16764.0, 16765.0, 16763.0] {
		let Some(b) = before_at(c, &list, reports, &format!("update {update}"), collect(update, None)) else { return };
		c.ok(b, &format!("a report is in the bags before update {update}"));
	}
}

fn no_riding(ctx: &Ctx, c: &mut Check) {
	let transport = Regex::new(
		r"(?i)(?-u:\b)ride (?:it(?-u:\b)|(?:the |a |on the |up a |down the )?(?:boat|ferry|zeppelin|tram|Deeprun Tram|lift|elevator|airship|flight|hippogryph|gryphon|wind rider|bat|taxi))",
	)
	.unwrap();
	let ride = Regex::new(r"(?i)(?-u:\b)(?:ride|rides|riding|rode)(?-u:\b)").unwrap();
	let mut offenders = Vec::<String>::new();
	for guide in ctx.all_guides() {
		if guide.starts_with("forever/collectibles/") {
			continue;
		}
		let Some(g) = compiled(ctx, c, &guide) else { return };
		if !(g.get("minLevel").num() < 40.0) {
			continue;
		}
		for step in g.get("steps").items() {
			for text in std::iter::once(step.get("note")).chain(step.get("goals").items().iter().map(|goal| goal.get("note"))) {
				let Some(text) = text.as_str() else { continue };
				if ride.is_match(&transport.replace_all(text, "")) {
					offenders.push(format!("{guide} (from level {}), step {}: {text}", g.get("minLevel").to_js_string(), step.get("title").to_js_string()));
				}
			}
		}
	}
	c.eq(offenders, vec![], "travel by riding in a guide played before level 40");
}

fn flight_to_auberdine(ctx: &Ctx, c: &mut Check) {
	let Some(all) = goals(ctx, c, TELDRASSIL) else { return };
	for cls in ["WARRIOR", "HUNTER", "ROGUE", "PRIEST", "DRUID"] {
		let list: Vec<Row> = all.iter().filter(|r| for_class(cls)(r)).cloned().collect();
		let Some(take) = at(c, &list, "accept 6342 (Flight to Auberdine)", is("accept", 6342)) else { return };
		let travel = list.iter().enumerate().skip(take + 1).find(|(_, r)| ["goto", "fly", "hearth"].iter().any(|t| str_is(&r.goal, "t", t)));
		c.ok(travel.is_some_and(|(_, r)| str_is(&r.goal, "t", "fly") && str_is(&r.goal, "location", "Auberdine")), &format!("{cls}: the travel after accepting 6342 is the flight to Auberdine"));
		let Some(give) = at(c, &list, "turnin 6342 (Flight to Auberdine)", is("turnin", 6342)) else { return };
		let travel_at = travel.map_or(-1, |(i, _)| i as i64);
		c.ok(travel_at < give as i64, &format!("{cls}: 6342 is handed in after the flight"));
		c.ok(!list.get(take..give).unwrap_or(&[]).iter().any(|r| str_is(&r.goal, "t", "goto")), &format!("{cls}: no walk to a boat between taking 6342 and handing it in"));
		let Some(back) = at(c, &list, "accept 6343 (Return to Nessa)", is("accept", 6343)) else { return };
		c.ok(give < back, &format!("{cls}: Return to Nessa is taken from Laird after 6342"));
		let Some(b) = before_at(c, &list, back, "turnin 6343 (Return to Nessa)", is("turnin", 6343)) else { return };
		c.ok(b, &format!("{cls}: Return to Nessa is handed in"));
	}
}

const BY_LEVEL: [(&str, f64, f64); 11] = [
	(WESTFALL, 725.0, 102.0),
	(WESTFALL, 254548.0, 92744.0),
	(WESTFALL, 730.0, 38.0),
	(DARKSHORE, 5385.0, 983.0),
	(DARKSHORE, 5412.0, 1001.0),
	("forever/horde/02-the-barrens.guide", 5087.0, 844.0),
	("forever/horde/orc-troll/02-the-barrens.guide", 5087.0, 844.0),
	(SILVERPINE, 3164.0, 429.0),
	(SILVERPINE, 730.0, 91920.0),
	(HILLSBRAD_HORDE, 3476.0, 496.0),
	(HILLSBRAD_HORDE, 3496.0, 501.0),
];

fn drops_by_level(ctx: &Ctx, c: &mut Check) {
	for (guide, item, quest) in BY_LEVEL {
		let Some(list) = goals(ctx, c, guide) else { return };
		let Some(i) = at(c, &list, &format!("{guide} collect {item}"), collect(item, Some(Some(quest)))) else { return };
		let goal = &list[i].goal;
		let q = ctx.data.quest(&V::Num(quest));
		if !c.ok(q.truthy(), &format!("quest {quest} is in the data")) {
			return;
		}
		let qlvl = q.get("level").num();
		let what = format!("{guide} collect {item} (quest {quest}, level {})", q.get("level").to_js_string());
		c.ok(located(&list[i]) && !goal.get("spread").truthy(), &format!("{what} has a point and is no zone-wide search"));
		let npcs = ctx.data.item(&V::Num(item)).get("drops").get("npc");
		if !c.ok(npcs.is_obj(), &format!("item {item} has droppers")) {
			return;
		}
		let map = goal.get("map").to_js_string();
		let droppers: Vec<V> = keys(&npcs).iter().map(|id| ctx.data.npc(&V::Num(str_to_num(id)))).filter(|n| n.truthy() && n.get("spawns").truthy() && n.get("spawns").get(&map).truthy()).collect();
		let (gx, gy) = (goal.get("x").num(), goal.get("y").num());
		let here: Vec<&V> = droppers.iter().filter(|n| n.get("spawns").get(&map).get("pts").items().iter().any(|p| (p.num_at(0) - gx).hypot(p.num_at(1) - gy) < 3.0)).collect();
		let names: Vec<String> = here.iter().map(|n| format!("{} {}", n.get("name").to_js_string(), n.get("level").to_js_string())).collect();
		c.ok(!here.is_empty() && here.iter().all(|n| n.get("level").num() <= qlvl + 2.0), &format!("{what} leads to droppers at most two levels above the quest ({})", names.join(", ")));
	}
	let Some(list) = goals(ctx, c, WESTFALL) else { return };
	let Some(paws) = list.iter().find(|r| collect(725.0, None)(&r.goal)) else {
		c.ok(false, "the Gnoll Paws are in the Westfall guide");
		return;
	};
	c.ok(paws.goal.get("y").num() < 35.0, &format!("the Gnoll Paws lead into the north hills ({},{})", paws.goal.get("x").to_js_string(), paws.goal.get("y").to_js_string()));
}

fn westfall_road_in(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, WESTFALL) else { return };
	let Some(report) = at(c, &list, "turnin 109", is("turnin", 109)) else { return };
	let hill = &list[report];
	let Some(home) = at(c, &list, "sethome", |g| str_is(g, "t", "sethome")) else { return };
	c.ok(hill.step.strict_eq(&list[home].step), "Report to Gryan Stoutmantle is handed in on the first Sentinel Hill stop");
	for q in [109, 36, 151, 64, 9, 22, 92909] {
		let Some(i) = at(c, &list, &format!("accept {q}"), is("accept", q)) else { return };
		c.ok(i < report, &format!("{q} is taken before Sentinel Hill"));
		c.ok(list[i].goal.get("y").num() < hill.goal.get("y").num() - 10.0, &format!("{q} is taken north of the hill, on the road in"));
	}
	let Some(stew) = at(c, &list, "turnin 36", is("turnin", 36)) else { return };
	let ok = stew < report && {
		let Some(salma) = at(c, &list, "accept 38", is("accept", 38)) else { return };
		salma < report
	};
	c.ok(ok, "Westfall Stew is handed to Salma on the way south");
	let before: Vec<&Row> = list[..report].iter().filter(|r| located(r)).filter(|r| everyone(r)).collect();
	for i in 1..before.len() {
		let (g, prev) = (before[i], before[i - 1]);
		if !g.step.strict_eq(&prev.step) {
			c.ok(g.goal.get("y").num() >= prev.goal.get("y").num() - 3.0, &format!("{} is not north of {}", g.step.get("title").to_js_string(), prev.step.get("title").to_js_string()));
		}
	}
	let Some(elwynn) = goals(ctx, c, ELWYNN) else { return };
	let elwynn: Vec<Row> = elwynn.into_iter().filter(everyone).collect();
	let Some(last) = elwynn.last() else {
		c.ok(false, "Elwynn has goals for everyone");
		return;
	};
	let last = &last.goal;
	c.ok(str_is(last, "t", "accept") && num_is(last, "quest", 109.0) && num_is(last, "npc", 963.0), "Elwynn ends at Deputy Rainer on the road west");
	let hill_fp = hill.step.get("goals").items().into_iter().find(|g| str_is(g, "t", "getfp"));
	let mut leaves = true;
	for r in &elwynn {
		if !str_is(&r.goal, "t", "getfp") {
			continue;
		}
		let Some(fp) = &hill_fp else {
			c.ok(false, "the Sentinel Hill stop has a flight path");
			return;
		};
		if r.goal.get("node").strict_eq(&fp.get("node")) {
			leaves = false;
		}
	}
	c.ok(leaves, "Elwynn leaves the Sentinel Hill flight path to Westfall");
}

fn handful_of_oats(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, WESTFALL) else { return };
	let Some(oats) = at(c, &list, "collect 1528", collect(1528.0, None)) else { return };
	let Some(turnin) = at(c, &list, "turnin 151", is("turnin", 151)) else { return };
	let Some(hill) = at(c, &list, "turnin 109", is("turnin", 109)) else { return };
	c.ok(oats > hill, "the oats are not gathered on the road in, before Sentinel Hill");
	c.ok(oats < turnin && list[oats].step.strict_eq(&list[turnin].step), "the oats are gathered on the turn-in stop, before Verna");
	let goal = &list[oats].goal;
	c.ok(located(&list[oats]) && !goal.get("spread").truthy(), "the oats have a point and are no zone-wide search");
	let Some(y) = yards(ctx, c, goal, &list[turnin].goal) else { return };
	c.ok(y < 250.0, &format!("the oats lead into the Jansen Stead's fields ({},{})", goal.get("x").to_js_string(), goal.get("y").to_js_string()));
}

fn zephras_tower(ctx: &Ctx, c: &mut Check) {
	for guide in [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE] {
		let Some(list) = goals(ctx, c, guide) else { return };
		let Some(harmony) = at(c, &list, &format!("{guide}: turnin 92461"), is("turnin", 92461)) else { return };
		let Some(falling) = at(c, &list, &format!("{guide}: turnin 92474"), is("turnin", 92474)) else { return };
		for quest in [94414, 92474] {
			let Some(i) = at(c, &list, &format!("{guide}: accept {quest}"), is("accept", quest)) else { return };
			c.ok(i < harmony, &format!("{guide}: {quest} is taken on the tower before Harmony in Balance is handed in"));
		}
		let Some(anchors) = at(c, &list, &format!("{guide}: turnin 94414"), is("turnin", 94414)) else { return };
		c.ok(anchors < harmony, &format!("{guide}: The Anchors of Zephras is done before Rorian"));
		c.eq(falling.abs_diff(harmony), 1, &format!("{guide}: Harmony in Balance and Falling With Style are handed in one after the other"));
		c.eq(list[falling].s, list[harmony].s, &format!("{guide}: on the same step"));
		c.ok(list[falling].goal.get("npc").strict_eq(&list[harmony].goal.get("npc")), &format!("{guide}: to the same NPC, Rorian"));
		let completes: Vec<usize> = list.iter().filter(|r| num_is(&r.goal, "quest", 92474.0) && str_is(&r.goal, "t", "complete")).map(|r| r.s).collect();
		c.eq(completes, vec![], &format!("{guide}: no complete goal for a quest with no objectives"));
	}
}

const COVERED_ELSEWHERE: [&str; 1] = ["97485.1"];

fn zephras_objectives(ctx: &Ctx, c: &mut Check) {
	for guide in [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE] {
		let Some(list) = goals(ctx, c, guide) else { return };
		for (i, Row { goal, .. }) in list.iter().enumerate() {
			if !str_is(goal, "t", "turnin") {
				continue;
			}
			let q = ctx.data.quest(&goal.get("quest"));
			if !q.truthy() || !q.get("objectives").truthy() || !q.get("objectives").get("length").truthy() {
				continue;
			}
			let before: Vec<&V> = list[..i].iter().map(|r| &r.goal).filter(|g| g.get("quest").strict_eq(&goal.get("quest")) && !str_is(g, "t", "accept") && !str_is(g, "t", "turnin")).collect();
			if before.iter().any(|g| str_is(g, "t", "complete") && !g.get("oi").truthy()) {
				continue;
			}
			let quest = goal.get("quest").to_js_string();
			let missing: Vec<usize> =
				(1..=q.get("objectives").len()).filter(|oi| !COVERED_ELSEWHERE.contains(&format!("{quest}.{oi}").as_str()) && !before.iter().any(|g| num_is(g, "oi", *oi as f64))).collect();
			if !c.eq(missing, vec![], &format!("{guide}: {quest} ({}) is handed in with objectives never sent for", q.get("title").to_js_string())) {
				return;
			}
		}
	}
	let Some(list) = goals(ctx, c, ZEPHRAS_HORDE) else { return };
	let Some(gyro) = at(c, &list, "collect 260883", collect(260883.0, Some(Some(93737.0)))) else { return };
	let Some(b) = before_at(c, &list, gyro, "turnin 93737", is("turnin", 93737)) else { return };
	c.ok(b, "before Riaani takes the quest");
	let Some(spawns) = ctx.data.spawns("object", &V::Num(616466.0)).into_iter().find(|s| num_is(s, "map", 2521.0)) else {
		c.ok(false, "the gyrozephyr spawns on Zephras Isle");
		return;
	};
	let goal = &list[gyro].goal;
	let close = spawns.get("pts").items().iter().any(|p| num_is(goal, "map", 2521.0) && (goal.get("x").num() - p.num_at(0)).hypot(goal.get("y").num() - p.num_at(1)) <= 1.0);
	c.ok(close, &format!("the arrow's point {},{} is at a gyrozephyr", goal.get("x").to_js_string(), goal.get("y").to_js_string()));
}

fn zephras_wounds(ctx: &Ctx, c: &mut Check) {
	for guide in [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE] {
		let Some(list) = goals(ctx, c, guide) else { return };
		for quest in [94489, 92693] {
			let Some(take) = at(c, &list, &format!("{guide}: accept {quest}"), is("accept", quest)) else { return };
			let Some(give) = at(c, &list, &format!("{guide}: turnin {quest}"), is("turnin", quest)) else { return };
			let between: Vec<&Row> = list.get(take + 1..give).unwrap_or(&[]).iter().filter(|r| num_is(&r.goal, "quest", quest as f64)).collect();
			let unplaced: Vec<String> = between.iter().filter(|r| !located(r)).map(|r| r.goal.get("t").to_js_string()).collect();
			c.eq(unplaced, vec![], &format!("{guide}: every goal of {quest} has a place for the arrow"));
			let objectives = ctx.data.quest(&V::Num(quest as f64)).get("objectives");
			if !c.ok(objectives.is_arr(), &format!("quest {quest} has objectives in the data")) {
				return;
			}
			let missing: Vec<usize> = (1..=objectives.len()).filter(|oi| !between.iter().any(|r| num_is(&r.goal, "oi", *oi as f64))).collect();
			c.eq(missing, vec![], &format!("{guide}: every objective of {quest} has its goal before the turn-in"));
		}
	}
}

fn battleworn_axes(ctx: &Ctx, c: &mut Check) {
	let p = projector(ctx);
	let Some(list) = goals(ctx, c, REDRIDGE) else { return };
	let Some(axes) = at(c, &list, "Battleworn Axe", collect(3014.0, None)) else { return };
	let goal = &list[axes].goal;
	let Some(pendant) = at(c, &list, "Shadowhide Pendant", collect(1075.0, None)) else { return };
	c.ok(pendant < axes, "after the Galardell gnolls");
	let f = if goal.get("f").truthy() { goal.get("f") } else { V::str("l") };
	let here = point(&p, &goal.get("map"), &goal.get("x"), &goal.get("y"), &f);
	let npcs = ctx.data.item(&V::Num(3014.0)).get("drops").get("npc");
	if !c.ok(npcs.is_obj(), "the Battleworn Axe has droppers") {
		return;
	}
	let (mut normal, mut elite) = (0, 0);
	for id in keys(&npcs) {
		let id = V::Num(str_to_num(&id));
		let npc = ctx.data.npc(&id);
		for q in spawn_points(ctx, &p, &[("npc", id)], &goal.get("map")) {
			if (q.wx - here.wx).hypot(q.wy - here.wy) < 150.0 {
				if npc.truthy() && npc.get("rank").truthy() {
					elite += 1;
				} else {
					normal += 1;
				}
			}
		}
	}
	c.eq(elite, 0, "no elite axe carrier within 150 yd of the arrow");
	c.ok(normal >= 20, &format!("at least 20 normal axe carriers within 150 yd ({normal})"));
}

fn encroachment(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, DUROTAR) else { return };
	let Some(enc) = at(c, &list, "accept 837 (Encroachment)", is("accept", 837)) else { return };
	for q in [96822, 784, 791, 830, 817, 818, 826, 808, 786] {
		let Some(i) = at(c, &list, &format!("turnin {q}"), is("turnin", q)) else { return };
		c.ok(i < enc, &format!("{q} is handed in before Encroachment is taken"));
	}
	let Some(turnin) = at(c, &list, "turnin 837", is("turnin", 837)) else { return };
	for n in [3111.0, 3112.0, 3113.0, 3114.0] {
		let Some(kill) = at(c, &list, &format!("kill {n}"), |g| str_is(g, "t", "kill") && num_is(g, "quest", 837.0) && num_is(g, "npc", n)) else { return };
		c.ok(enc < kill && kill < turnin, &format!("Razormane {n} is killed between the accept and the turn-in"));
	}
}

fn hearts_of_the_lovers(ctx: &Ctx, c: &mut Check) {
	let dir = ctx.data.dir.clone().unwrap_or_default();
	let corrected = match forge_guide::data::load_data(Path::new(&dir)) {
		Ok(d) => d,
		Err(e) => {
			c.ok(false, &format!("the reference data loads: {e}"));
			return;
		}
	};
	let fix = crate::seed::correction(&ctx.root, "quests", "65593");
	if !c.ok(fix.truthy(), "the corrections correct 65593") {
		return;
	}
	let quest = corrected.quest(&V::Num(65593.0));
	if !c.ok(quest.is_obj(), "quest 65593 is in the data") {
		return;
	}
	for (k, v) in fix.get("set").entries() {
		quest.set(&k, v);
	}
	let guide = "forever/class/warlock/incubus-horde.guide";
	let file = ctx.guides.join(guide);
	let src = Source { file: file.to_string_lossy().into_owned(), source: guide.to_string(), text: std::fs::read_to_string(&file).unwrap_or_default() };
	let out = compile_sources(&[src], &corrected, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	let Some(g) = out.guides.first() else {
		c.ok(false, &format!("{guide} compiles"));
		return;
	};
	let list: Vec<V> = g.get("steps").items().iter().flat_map(|s| s.get("goals").items()).collect();
	let heart = |item: f64| list.iter().find(|g| str_is(g, "t", "collect") && num_is(g, "quest", 65593.0) && num_is(g, "item", item)).cloned();
	let ids: Vec<V> = corrected.quest(&V::Num(65593.0)).get("objectives").items().iter().map(|o| o.get("id")).collect();
	c.eq(ids, vec![V::Num(190179.0), V::Num(190180.0)], "Avelina's Heart is the first objective, Isaac's the second");
	let Some(avelina) = heart(190179.0) else {
		c.ok(false, "Avelina's Heart is collected");
		return;
	};
	c.ok(num_is(&avelina, "oi", 1.0), "Avelina's Heart reads line 1");
	let Some(isaac) = heart(190180.0) else {
		c.ok(false, "Isaac's Heart is collected");
		return;
	};
	c.ok(num_is(&isaac, "oi", 2.0), "Isaac's Heart reads line 2");
}

fn making_do(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, REDRIDGE) else { return };
	let Some(take) = at(c, &list, "accept 97926", is("accept", 97926)) else { return };
	c.ok(list[take].goal.get("optional").truthy(), "accept 97926 is optional");
	let Some(horizons) = at(c, &list, "turnin 97914", is("turnin", 97914)) else { return };
	c.ok(horizons < take, "Expanding Horizons is handed in first");
	let Some(ashenvale) = goals(ctx, c, ASHENVALE) else { return };
	let Some(give) = at(c, &ashenvale, "turnin 97926", is("turnin", 97926)) else { return };
	c.ok(ashenvale[give].goal.get("optional").truthy(), "turnin 97926 is optional");
}

fn unrequited_love(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ASHENVALE) else { return };
	let Some(take) = at(c, &list, "accept 98461", is("accept", 98461)) else { return };
	let Some(give) = at(c, &list, "turnin 98461", is("turnin", 98461)) else { return };
	let Some(excavation) = at(c, &list, "accept 305", is("accept", 305)) else { return };
	c.ok(take < give && give < excavation, "the note is taken, then handed in, then 305 is taken");
	c.eq(list[give].s, list[excavation].s, "the hand-in is in the same Menethil step as 305");
	c.ok(list[take].goal.get("optional").truthy() && list[give].goal.get("optional").truthy(), "both goals are optional");
}

fn sidas_bag(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ASHENVALE) else { return };
	let Some(i) = at(c, &list, "collect 3349", collect(3349.0, Some(Some(470.0)))) else { return };
	let goal = &list[i].goal;
	let tomb = |v: &V| {
		let (x, y) = (v.get("x").num(), v.get("y").num());
		(42.0..=49.0).contains(&x) && (23.0..=30.0).contains(&y)
	};
	c.ok(num_is(goal, "map", 1437.0) && tomb(goal), &format!("the point {},{} is at Ironbeard's Tomb", goal.get("x").to_js_string(), goal.get("y").to_js_string()));
	let arrow: Vec<V> = goal.get("spots").items().into_iter().filter(|s| !s.get("alt").truthy()).collect();
	c.ok(!arrow.is_empty() && arrow.iter().all(tomb), "the arrow picks only the tomb");
}

fn grind_to_28(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ASHENVALE) else { return };
	let Some(grind) = at(c, &list, "level 28", |g| str_is(g, "t", "level") && num_is(g, "level", 28.0)) else { return };
	for quest in [306, 484, 470, 98282] {
		let Some(i) = at(c, &list, &format!("turnin {quest}"), is("turnin", quest)) else { return };
		c.ok(i < grind, &format!("the Menethil hand-in {quest} counts towards 28"));
	}
	let Some(hearth) = at(c, &list, "hearth to Menethil", |g| str_is(g, "t", "hearth") && str_is(g, "location", "Deepwater Tavern")) else { return };
	c.ok(hearth < grind, "the grind is after the hearth");
	let Some(b) = before_at(c, &list, grind, "accept 1179", is("accept", 1179)) else { return };
	c.ok(b, "level 28 before Pilot Longbeard");
}

/// `(goal.fromNpcs || []).map((n) => n.npc)`.
fn from_npcs(goal: &V) -> Vec<V> {
	goal.get("fromNpcs").items().iter().map(|n| n.get("npc")).collect()
}

fn ids_text(ids: &[V]) -> String {
	ids.iter().map(V::to_js_string).collect::<Vec<_>>().join(", ")
}

fn timberling_seed(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, TELDRASSIL) else { return };
	let Some(i) = at(c, &list, "the Timberling Seed collect", collect(5168.0, Some(Some(918.0)))) else { return };
	let goal = &list[i].goal;
	let ids = from_npcs(goal);
	c.ok(!str_is(goal, "from", "Elder Timberling"), "the goal names the Timberlings, not the Elder");
	c.ok(ids.iter().any(|n| n.as_num() == Some(2022.0)), &format!("the Timberlings (2022) are among the droppers ({})", ids_text(&ids)));
	c.ok(!ids.iter().any(|n| n.as_num() == Some(2030.0)), "the Elder Timberling (2030) is not");
	let Some(y) = yards(ctx, c, goal, &pt(1438.0, 60.9, 68.49)) else { return };
	c.ok(y <= 150.0, &format!("the arrow at {},{} is by Denalan, not {} yd off", goal.get("x").to_js_string(), goal.get("y").to_js_string(), round(y)));
}

fn soft_saber_pelts(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, TELDRASSIL) else { return };
	let find = |pred: &dyn Fn(&V) -> bool| list.iter().find(|r| pred(&r.goal));
	let accept = find(&|g| str_is(g, "t", "accept") && num_is(g, "quest", 87288.0));
	let turnin = find(&|g| str_is(g, "t", "turnin") && num_is(g, "quest", 488.0));
	c.ok(accept.is_some(), "accept 87288 is in the guide");
	let (Some(accept), Some(turnin)) = (accept, turnin) else {
		c.ok(false, "accept 87288 and turnin 488 are in the guide");
		return;
	};
	c.ok(accept.s < turnin.s, "accept 87288 (Soft Saber Pelts) comes before turnin 488 (Zenn's Bidding), not after it");
	let coll488 = find(&|g| collect(3409.0, Some(Some(488.0)))(g));
	let coll87288 = find(&|g| str_is(g, "t", "collect") && num_is(g, "quest", 87288.0));
	c.ok(coll87288.is_some(), "collect 280087 quest 87288.1 is in the guide");
	let (Some(coll488), Some(coll87288)) = (coll488, coll87288) else {
		c.ok(false, "both Nightsaber collects are in the guide");
		return;
	};
	c.eq(coll488.s, coll87288.s, "Nightsaber Fang (488.1) and Nightsaber Pelt (87288.1) are in the same step");
}

fn gnarlpine_necklace(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, TELDRASSIL) else { return };
	let Some(necklace) = at(c, &list, "collect 8049 (Gnarlpine Necklace)", collect(8049.0, Some(None))) else { return };
	let Some(jewel) = at(c, &list, "collect 8050 quest 2459 (Tallonkai's Jewel)", collect(8050.0, Some(Some(2459.0)))) else { return };
	c.ok(necklace < jewel, "the necklace comes before the jewel");
	c.eq(list[necklace].s, list[jewel].s, "on the Ferocitas step");
	c.ok(located(&list[necklace]), "the arrow leads to Ferocitas for the necklace");
}

fn pirate_hats(ctx: &Ctx, c: &mut Check) {
	for guide in [TANARIS_ALLIANCE, "forever/horde/40-50/02-feralas.guide"] {
		let Some(list) = goals(ctx, c, guide) else { return };
		let Some(i) = at(c, &list, &format!("{guide}: the Southsea Pirate Hat collect"), collect(20519.0, Some(Some(8365.0)))) else { return };
		let goal = &list[i].goal;
		let ids = from_npcs(goal);
		for pirate in [7855.0, 7856.0, 7857.0, 7858.0] {
			c.ok(ids.iter().any(|n| n.as_num() == Some(pirate)), &format!("{guide}: pirate {pirate} is among the droppers ({})", ids_text(&ids)));
		}
		c.ok(!str_is(goal, "from", "Southsea Kidnapper"), &format!("{guide}: the goal does not send the player after the Kidnapper alone"));
	}
}

fn how_big_a_threat(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, "forever/alliance/03-darkshore.guide") else { return };
	let Some(i) = at(c, &list, "complete 984", is("complete", 984)) else { return };
	let goal = &list[i].goal;
	c.ok(num_is(goal, "map", 1439.0), "the goal is on Darkshore");
	let Some(y) = yards(ctx, c, goal, &pt(1439.0, 39.77, 57.07)) else { return };
	c.ok(y <= 200.0, &format!("the arrow at {},{} is by the camp the report completed at, not {} yd off", goal.get("x").to_js_string(), goal.get("y").to_js_string(), round(y)));
}

fn ghost_o_plasm(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, "forever/horde/30-40/04-dustwallow-marsh.guide") else { return };
	let Some(plasm) = at(c, &list, "collect 15849 (Ghost-o-plasm)", collect(15849.0, Some(Some(6134.0)))) else { return };
	let goal = &list[plasm].goal;
	c.ok(num_is(goal, "map", 1443.0), "the goal is on Desolace");
	let Some(y) = yards(ctx, c, goal, &pt(1443.0, 63.77, 91.6)) else { return };
	c.ok(y <= 200.0, &format!("the arrow at {},{} is in the Valley of Bones, not {} yd off", goal.get("x").to_js_string(), goal.get("y").to_js_string(), round(y)));
	let Some(bones) = at(c, &list, "collect 13703 (Kodo Bone)", |g| str_is(g, "t", "collect") && num_is(g, "quest", 5501.0)) else { return };
	c.ok(bones < plasm, "the kodo bones come first");
	let Some(b) = before_at(c, &list, plasm, "turnin 6134", is("turnin", 6134)) else { return };
	c.ok(b, "the plasm is collected before Hornizz is handed it");
}

fn junior_trainers(ctx: &Ctx, c: &mut Check) {
	let dir = ctx.data.dir.clone().unwrap_or_default();
	if !Path::new(&dir).join("professions.json").exists() {
		c.skip("reference data not built: data/forever has no professions.json (forge data build)");
		return;
	}
	for (file, npcs) in [("skinning", [247227.0, 267327.0]), ("mining", [247226.0, 267328.0]), ("herbalism", [247223.0, 267329.0])] {
		let guide = format!("forever/professions/{file}.guide");
		let Some(g) = compiled(ctx, c, &guide) else { return };
		let learn = g.get("steps").at(0);
		c.ok(learn.get("title").as_str().is_some_and(|t| t.starts_with("Learn ")), &format!("{guide}: the first step learns the profession"));
		let goals = learn.get("goals").items();
		c.ok(!goals.iter().any(|g| str_is(g, "t", "level")), &format!("{guide}: no level goal before Apprentice"));
		let Some(train) = goals.iter().find(|g| str_is(g, "t", "train")) else {
			c.ok(false, &format!("{guide}: the first step trains"));
			return;
		};
		c.ok(num_is(train, "rank", 1.0), &format!("{guide}: Apprentice"));
		let candidates = train.get("candidates");
		if !c.ok(candidates.is_arr(), &format!("{guide}: the trainer has candidates")) {
			return;
		}
		let ids: Vec<V> = candidates.items().iter().map(|n| n.get("npc")).collect();
		for npc in npcs {
			c.ok(ids.iter().any(|n| n.as_num() == Some(npc)), &format!("{guide}: Junior trainer {npc} is a candidate"));
		}
	}
}

fn collecting_kelp(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ELWYNN) else { return };
	let Some(kelp) = at(c, &list, "turnin 112", is("turnin", 112)) else { return };
	let Some(escape) = at(c, &list, "accept 114", is("accept", 114)) else { return };
	let Some(dughan) = at(c, &list, "turnin 39", is("turnin", 39)) else { return };
	let Some(baited) = at(c, &list, "turnin 99131", is("turnin", 99131)) else { return };
	c.ok(baited < kelp, "Baited for Success is handed to Jason on the way in");
	c.ok(kelp < dughan && dughan < escape, "Collecting Kelp, then Dughan, then The Escape");
	c.eq(list[kelp].s, list[escape].s, "all in the same Goldshire step");
}

fn mining_tools(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ELWYNN) else { return };
	let Some(tools) = at(c, &list, "collect 247816", collect(247816.0, Some(Some(91732.0)))) else { return };
	let Some(explore) = at(c, &list, "complete 76", is("complete", 76)) else { return };
	let Some(geomancers) = at(c, &list, "kill 476", is("kill", 91723)) else { return };
	c.eq(list[tools].s, list[explore].s, "one step in the mine");
	c.ok(tools < explore && explore < geomancers, "the tools, then the far end, then the geomancers");
	let entrance = list[..tools].iter().rev().find(|r| str_is(&r.goal, "t", "goto"));
	c.ok(entrance.is_some(), "the step before is the walk to the entrance");
	let goal = &list[tools].goal;
	let spots = if goal.get("spots").truthy() { goal.get("spots").items() } else { vec![goal.clone()] };
	for s in spots {
		let Some(entrance) = entrance else { return };
		let o = Obj::new();
		o.set("map", goal.get("map"));
		for (k, v) in s.entries() {
			o.set_str(k, v);
		}
		let Some(to_tools) = yards(ctx, c, &entrance.goal, &V::Obj(o)) else { return };
		let Some(to_end) = yards(ctx, c, &entrance.goal, &list[explore].goal) else { return };
		c.ok(to_tools < to_end, &format!("the tools at {},{} lie between the entrance and the far end", s.get("x").to_js_string(), s.get("y").to_js_string()));
	}
}
