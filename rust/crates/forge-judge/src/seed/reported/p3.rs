//! Part of tests/guides-reported.test.js (see reported.rs): its lines 1147-1910, less the tests that play
//! the guide in the engine (eng.rs).

#[allow(unused_imports)]
use crate::seed::{at, everyone, for_class, is, located, Check, Ctx, Row, SeedTest};

use forge_guide::js::{Obj, V};

const DUN_MOROGH: &str = "forever/alliance/dwarf-gnome/01-dun-morogh.guide";
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest.guide";
const DARKSHORE: &str = "forever/alliance/03-darkshore.guide";
const REDRIDGE: &str = "forever/alliance/04-redridge-mountains.guide";
const ZEPHRAS_HORDE: &str = "forever/horde/skyborne/01-zephras-isle.guide";
const ZEPHRAS_ALLIANCE: &str = "forever/alliance/skyborne/01-zephras-isle.guide";
const STONETALON_HORDE: &str = "forever/horde/05-stonetalon-mountains.guide";
const ASHENVALE_ALLIANCE: &str = "forever/alliance/06-ashenvale.guide";
const BARRENS_04: &str = "forever/horde/04-the-barrens.guide";

pub fn tests() -> Vec<SeedTest> {
	let t = |n: &str, f: fn(&Ctx, &mut Check)| -> SeedTest { (n.to_string(), f) };
	vec![
		t("Sato's report: The Great Outdoors on Zephras Isle is done by sitting at Raan's campfire, not by clicking it", great_outdoors),
		t("Sato's report: the Scrawny Ursera step leads to the slope west of Thendal Village", scrawny_ursera),
		t("Phear's report: a kill or collect leads to the camp that holds its mobs, not a stray one or two far from it", strays),
		t("forever/alliance/03-darkshore.guide: the Grizzled Scalps are collected in the step at the Grove, where the bears are and Buzzbox 525 takes them", grizzled_scalps),
		t("the cloth the guides tell you to buy leads to the Auction House: the capitals' cloth donations and Grimand's Runecloth", cloth_auction_house),
		t("forever/alliance/dwarf-gnome/01-dun-morogh.guide: rikette's report: the Grizzled Den leads the arrow to the wendigo cave", grizzled_den),
		t("every step with a quest objective to do has a goal the arrow can lead to", objective_steps_placed),
		t("Rumbleshot's Ammo, The Red Crystal: every objective the data can place has a goal of its own, not only the turn-in", objectives_own_goal),
		t("forever/alliance/03-darkshore.guide: Twerkjob's report: The Red Crystal leads the arrow to the crystal on the eastern ridge (#241)", red_crystal),
		t("forever/alliance/03-darkshore.guide: XooVe's report (#302): The Blackwood Corrupted fills the bowl and gathers the three samples before the Talisman, and uses the bowl where Xabraxxis comes", blackwood_corrupted),
		t("forever/alliance/dwarf-gnome/01-dun-morogh.guide: Rumbleshot's Ammo leads to the Ammo Crate by Mountaineer Gretchen, not to Hegnar", rumbleshot_ammo),
		t("legacy-challenges: Return to Bodley is turned in before Back to the Beginning is taken", legacy_bodley),
		t("Fitz's playtest: every goto at a boat, zeppelin or tram stop is on its deck or pier, not in the water", transport_gotos_dry),
		t("Fitz's playtest: typed coordinates are on the zone of every character who sees them", typed_coords_zone),
		t("#171: every hearth is to an inn the guide binds at first", hearth_bound),
		t("forever/alliance/human/01-elwynn-forest.guide: Bashidian Twotao's report (#279): the bait ingredients count their own objectives", bait_ingredients),
		t("forever/alliance/human/01-elwynn-forest.guide: Zepheriel's report (#310): Skirmish at Echo Ridge is taken from McBride before Brother Paxton, with nobody between", echo_ridge),
		t("forever/horde/05-stonetalon-mountains.guide: #246: Kadrak's goals are on the Barrens' map, and the Ashenvale steps after them on Ashenvale's", kadrak_map),
		t("#246: every goal with Tirion leads to Tirion Fordring at his hut, never to Lord Tirion Fordring in Hearthglen", tirion_hut),
		t("forever/horde/04-the-barrens.guide: Fitz's report (#273): the Savannah Lion Hide arrow stays in the Dry Hills with the traps, never by Ratchet", lion_hides),
		t("forever/horde/04-the-barrens.guide: Fitz's report (#274): the Dry Hills step also collects the Raptor Horns, in the Dry Hills, before the Ratchet turn-in", raptor_horns),
		t("forever/alliance/04-redridge-mountains.guide: Avtom's report (#280): Iron Pike and Iron Rivet lead to the gnolls that drop them, not to the rare Ribchaser's camp among the Mongrels", iron_pike),
		t("Tazul's report: Elemental Bracers counts the five bracers before the Divined Scroll", elemental_bracers),
	]
}

// --- helpers

/// `v.k` as a number (NaN when not one: comparisons with it are false, as with undefined in JS).
fn n(v: &V, k: &str) -> f64 {
	v.get(k).as_num().unwrap_or(f64::NAN)
}

/// `v.k === x`.
fn num_is(v: &V, k: &str, x: f64) -> bool {
	v.get(k).as_num() == Some(x)
}

fn t_is(v: &V, t: &str) -> bool {
	v.get("t").as_str() == Some(t)
}

/// `{ map, x, y }`.
fn pt(map: V, x: f64, y: f64) -> V {
	let o = Obj::new();
	o.set("map", map);
	o.set("x", x);
	o.set("y", y);
	V::Obj(o)
}

/// `x != null` on `v.k`.
fn placed(v: &V) -> bool {
	!v.get("map").is_nullish() && !v.get("x").is_nullish()
}

/// The JS `yards`: asserts the two points are on one map with an Era frame (a failure, None, otherwise).
fn yards(ctx: &Ctx, c: &mut Check, a: &V, b: &V) -> Option<f64> {
	let y = ctx.yards(a, b);
	c.ok(y.is_some(), &format!("points on one map with an Era frame ({}, {})", a.get("map").to_js_string(), b.get("map").to_js_string()));
	y
}

/// Zephras Isle has no Era frame: points compare in map percent.
fn close(a: &V, b: &V, pct: f64) -> bool {
	a.get("map").strict_eq(&b.get("map")) && (n(a, "x") - n(b, "x")).hypot(n(a, "y") - n(b, "y")) <= pct
}

/// The guide compiled, asserted to compile to one guide (the JS `compiled` throws otherwise).
fn compiled(ctx: &Ctx, c: &mut Check, guide: &str) -> Option<V> {
	let g = ctx.compiled(guide);
	c.ok(!g.is_undef(), &format!("{guide} compiles")).then_some(g)
}

/// `goals(guide)` with the compile asserted.
fn goals(ctx: &Ctx, c: &mut Check, guide: &str) -> Option<Vec<Row>> {
	compiled(ctx, c, guide)?;
	Some(ctx.goals(guide))
}

/// `goal.spots || []`.
fn spots(g: &V) -> Vec<V> {
	g.get("spots").items()
}

fn non_alt(g: &V) -> Vec<V> {
	spots(g).into_iter().filter(|s| !s.get("alt").truthy()).collect()
}

// --- tests

fn great_outdoors(ctx: &Ctx, c: &mut Check) {
	let fire = ctx.data.spawns("object", &V::Num(460003.0)).into_iter().find(|x| num_is(x, "map", 2521.0));
	let Some(fire) = fire else {
		c.ok(false, "Raan's campfire spawns on Zephras Isle");
		return;
	};
	let p0 = fire.get("pts").at(0);
	let camp = pt(V::Num(2521.0), p0.num_at(0), p0.num_at(1));
	for guide in [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE] {
		let Some(list) = goals(ctx, c, guide) else { return };
		let clicks: Vec<usize> = list.iter().filter(|r| num_is(&r.goal, "quest", 96101.0) && t_is(&r.goal, "interact")).map(|r| r.s).collect();
		if !c.eq(clicks, vec![], &format!("{guide}: no click goal")) {
			return;
		}
		let Some(take) = at(c, &list, &format!("{guide}: accept 96101"), is("accept", 96101)) else { return };
		let Some(sit) = at(c, &list, &format!("{guide}: complete 96101"), is("complete", 96101)) else { return };
		if !(take < sit) {
			c.ok(false, &format!("{guide}: done between its accept and its turn-in"));
			return;
		}
		let Some(turnin) = at(c, &list, &format!("{guide}: turnin 96101"), is("turnin", 96101)) else { return };
		if !c.ok(sit < turnin, &format!("{guide}: done between its accept and its turn-in")) {
			return;
		}
		if !c.ok(close(&list[sit].goal, &camp, 0.3), &format!("{guide}: the arrow leads to Raan's campfire")) {
			return;
		}
	}
}

fn scrawny_ursera(ctx: &Ctx, c: &mut Check) {
	let pts = crate::seed::correction(&ctx.root, "npcs", "250926").get("addSpawns").get("2521").get("pts");
	if !pts.is_arr() {
		c.ok(false, "the corrections add Scrawny Ursera spawns");
		return;
	}
	let pts = pts.items();
	if !c.ok(pts.iter().all(|p| p.num_at(0) <= 41.6), "the corrected spawns are all west of the village") {
		return;
	}
	for guide in [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE] {
		let Some(list) = goals(ctx, c, guide) else { return };
		let Some(i) = at(c, &list, &format!("{guide}: Scrawny Ursera Claw"), |g| t_is(g, "collect") && num_is(g, "item", 251918.0)) else { return };
		let goal = &list[i].goal;
		if !c.ok(pts.iter().any(|p| close(goal, &pt(V::Num(2521.0), p.num_at(0), p.num_at(1)), 0.3)), &format!("{guide}: the arrow's point is at a Scrawny Ursera spawn")) {
			return;
		}
		for sp in non_alt(goal) {
			if !c.ok(n(&sp, "x") <= 41.7, &format!("{guide}: the spot {},{} is west of the village", sp.get("x").to_js_string(), sp.get("y").to_js_string())) {
				return;
			}
		}
	}
}

fn strays(ctx: &Ctx, c: &mut Check) {
	type Pred = fn(&V) -> bool;
	let cases: [(&str, &str, Pred, [f64; 4]); 7] = [
		(DUN_MOROGH, "Frostmane Headhunter (Frostmane Hold)", |g| t_is(g, "kill") && num_is(g, "npc", 1123.0) && num_is(g, "quest", 287.0), [20.0, 27.0, 49.0, 56.0]),
		("forever/alliance/03-darkshore.guide", "Grizzled Scalp", |g| t_is(g, "collect") && num_is(g, "item", 5414.0), [37.0, 46.0, 69.0, 83.0]),
		("forever/alliance/50-60/02-felwood.guide", "Jadefire Hellcaller (Jadefire Run)", |g| t_is(g, "kill") && num_is(g, "npc", 7111.0), [38.0, 44.0, 13.0, 23.0]),
		("forever/horde/05-stonetalon-mountains.guide", "Stonetalon Sap", |g| t_is(g, "collect") && num_is(g, "item", 5582.0), [32.0, 41.0, 9.0, 21.0]),
		("forever/horde/50-60/01-un-goro-crater.guide", "Bloodpetal Lasher (east side)", |g| t_is(g, "kill") && num_is(g, "npc", 6509.0), [55.0, 77.0, 20.0, 50.0]),
		("forever/horde/50-60/01-un-goro-crater.guide", "Bloodpetal Thresher (east side)", |g| t_is(g, "kill") && num_is(g, "npc", 6511.0), [55.0, 77.0, 20.0, 50.0]),
		("forever/horde/40-50/03-feralas.guide", "Marsh Flesheater (huts on the western shore)", |g| t_is(g, "kill") && num_is(g, "npc", 751.0), [60.0, 75.0, 75.0, 100.0]),
	];
	let in_camp = |[x0, x1, y0, y1]: [f64; 4], p: &V| {
		let (x, y) = (n(p, "x"), n(p, "y"));
		x >= x0 && x <= x1 && y >= y0 && y <= y1
	};
	for (guide, what, pred, camp) in cases {
		let Some(list) = goals(ctx, c, guide) else { return };
		for r in list.iter().filter(|r| pred(&r.goal)) {
			let goal = &r.goal;
			if !c.ok(in_camp(camp, goal), &format!("{guide}: {what}: the point {},{} is at the camp", goal.get("x").to_js_string(), goal.get("y").to_js_string())) {
				return;
			}
			if !goal.get("spots").is_arr() {
				c.ok(false, &format!("{guide}: {what}: the goal has spots"));
				return;
			}
			let arrow = non_alt(goal);
			if !c.ok(!arrow.is_empty() && arrow.iter().all(|s| in_camp(camp, s)), &format!("{guide}: {what}: the arrow picks only the camp")) {
				return;
			}
			if !c.ok(spots(goal).iter().any(|s| s.get("alt").truthy() && !in_camp(camp, s)), &format!("{guide}: {what}: the strays stay alternatives")) {
				return;
			}
		}
		if !c.ok(list.iter().any(|r| pred(&r.goal)), &format!("{guide}: {what} is in the guide")) {
			return;
		}
	}
	let kept = [
		("forever/alliance/50-60/01-burning-steppes.guide", 7972.0),
		("forever/class/priest/blood-of-morphaz.guide", 7972.0),
		("forever/alliance/50-60/03-winterspring.guide", 12840.0),
		("forever/horde/50-60/01-un-goro-crater.guide", 12840.0),
		("forever/horde/40-50/02-feralas.guide", 8705.0),
		("forever/class/shaman/darkreaver.guide", 18335.0),
	];
	for (guide, item) in kept {
		let Some(list) = goals(ctx, c, guide) else { return };
		let Some(i) = at(c, &list, &format!("{guide}: collect {item}"), |g| t_is(g, "collect") && num_is(g, "item", item)) else { return };
		let goal = &list[i].goal;
		let first = goal.get("spots").at(0);
		if !first.is_object() {
			c.ok(false, &format!("{guide}: collect {item}: the goal has spots"));
			return;
		}
		let ok = !first.get("alt").truthy() && num_is(&first, "n", 1.0) && (n(&first, "x") - n(goal, "x")).hypot(n(&first, "y") - n(goal, "y")) <= 0.1;
		if !c.ok(ok, &format!("{guide}: collect {item}: the walk starts at the point")) {
			return;
		}
	}
	let Some(list) = goals(ctx, c, "forever/alliance/50-60/01-burning-steppes.guide") else { return };
	let Some(ichor) = list.iter().find(|r| num_is(&r.goal, "item", 7972.0)).map(|r| r.goal.clone()) else {
		c.ok(false, "the Ichor of Undeath is in the Burning Steppes guide");
		return;
	};
	if !ichor.get("spots").is_arr() {
		c.ok(false, "the ichor goal has spots");
		return;
	}
	let trail: Vec<V> = spots(&ichor).into_iter().filter(|s| n(s, "x") >= 34.0 && n(s, "x") <= 41.0 && n(s, "y") >= 45.0 && n(s, "y") <= 62.0).collect();
	if !c.eq(trail.len(), 6, "the Highborne trail") {
		return;
	}
	c.ok(trail.iter().all(|s| !s.get("alt").truthy()), "every spot of the Highborne trail is searched");
}

fn grizzled_scalps(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, "forever/alliance/03-darkshore.guide") else { return };
	let Some(i) = at(c, &list, "Grizzled Scalp", |g| t_is(g, "collect") && num_is(g, "item", 5414.0)) else { return };
	let Some(turnin) = at(c, &list, "turnin 1003", is("turnin", 1003)) else { return };
	if !c.ok(list[i].step.strict_eq(&list[turnin].step), "one step: the bears and Buzzbox 525") || !c.ok(i < turnin, "the scalps before the turn-in") {
		return;
	}
	let Some(y) = yards(ctx, c, &list[i].goal, &list[turnin].goal) else { return };
	c.ok(y < 300.0, "the scalps' point is near Buzzbox 525");
}

fn cloth_auction_house(ctx: &Ctx, c: &mut Check) {
	// The auctioneers: Stormwind's Trade District (live frame) and Ironforge's (Era frame).
	let ah = |map: &V| match map.as_num() {
		Some(1453.0) => Some((61.2, 71.3)),
		Some(1455.0) => Some((24.2, 74.7)),
		_ => None,
	};
	let cases: [(&str, &[i64]); 2] =
		[("forever/alliance/50-60/06-silithus.guide", &[7793, 7794, 7795, 7807, 7808, 7809, 7811, 7802, 7803, 7804, 7805]), ("forever/collectibles/mounts/alliance/paladin-charger.guide", &[7642])];
	let cloth = [2592.0, 4306.0, 4338.0, 14047.0];
	for (guide, quests) in cases {
		let Some(all) = goals(ctx, c, guide) else { return };
		for &quest in quests {
			let list: Vec<&Row> =
				all.iter().filter(|r| t_is(&r.goal, "collect") && num_is(&r.goal, "quest", quest as f64) && r.goal.get("item").as_num().is_some_and(|i| cloth.contains(&i))).collect();
			if !c.ok(!list.is_empty(), &format!("{guide}: the cloth of {quest}")) {
				return;
			}
			for r in list {
				let goal = &r.goal;
				let Some((x, y)) = ah(&goal.get("map")).filter(|&(x, y)| num_is(goal, "x", x) && num_is(goal, "y", y)) else {
					c.ok(
						false,
						&format!(
							"{guide}: {quest} {}: the point {} {},{} is the Auction House",
							goal.get("itemName").to_js_string(),
							goal.get("map").to_js_string(),
							goal.get("x").to_js_string(),
							goal.get("y").to_js_string()
						),
					);
					return;
				};
				for s in non_alt(goal) {
					if !c.ok(num_is(&s, "x", x) && num_is(&s, "y", y), &format!("{guide}: {quest}: the arrow picks only the Auction House")) {
						return;
					}
				}
			}
		}
	}
}

fn grizzled_den(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, DUN_MOROGH) else { return };
	let den: Vec<&Row> = list.iter().filter(|r| r.step.get("title").as_str() == Some("The Grizzled Den")).collect();
	if !c.ok(!den.is_empty(), "the Grizzled Den step is in the guide") {
		return;
	}
	for quest in [98321.0, 313.0] {
		let goal = den.iter().find(|r| num_is(&r.goal, "quest", quest) && t_is(&r.goal, "collect"));
		let Some(goal) = goal.filter(|r| located(r)) else {
			c.ok(false, &format!("the den's objective of {quest} has a place"));
			return;
		};
		// The cave lies south-west of Kharanos (46,51), around 41-44,47-50.
		let Some(y) = yards(ctx, c, &goal.goal, &pt(goal.goal.get("map"), 42.0, 48.5)) else { return };
		if !c.ok(y < 250.0, &format!("{quest} leads into the den")) {
			return;
		}
	}
}

/// Escorts and events start at their NPC in the step before and follow it, so a bare `complete` is right
/// there: the arrow has the NPC to lead to.
const FOLLOWS_AN_NPC: [f64; 6] = [
	5821.0, // Bodyguard for Hire: the Gizelton caravan escort (Desolace)
	665.0,  // Sunken Treasure: escort Doctor Draxlegauge (Arathi Highlands)
	660.0,  // Hints of a New Plague?: escort Kinelory (Arathi Highlands)
	4491.0, // A Little Help From My Friends: escort Ringo (Un'Goro Crater)
	863.0,  // The Escape: escort Wizzlecrank (The Barrens)
	7622.0, // The Balance of Light and Shadow: the event at Eris Havenfire
];

fn objective_steps_placed(ctx: &Ctx, c: &mut Check) {
	let mut offenders = Vec::new();
	for guide in ctx.all_guides() {
		let Some(list) = goals(ctx, c, &guide) else { return };
		// The distinct steps that have goals, in order (goals come step by step).
		let mut steps: Vec<V> = Vec::new();
		for r in &list {
			if !steps.last().is_some_and(|s| s.strict_eq(&r.step)) {
				steps.push(r.step.clone());
			}
		}
		for (i, step) in steps.iter().enumerate() {
			let gs = step.get("goals").items();
			let open: Vec<String> = gs.iter().filter(|g| t_is(g, "complete") && !g.get("quest").as_num().is_some_and(|q| FOLLOWS_AN_NPC.contains(&q))).map(|g| g.get("quest").to_js_string()).collect();
			if !open.is_empty() && !gs.iter().any(placed) {
				offenders.push(format!("{guide} step {} ({}): complete {}", i + 1, step.get("title").to_js_string(), open.join(", ")));
			}
		}
	}
	c.eq(offenders, vec![], "steps whose objectives have no place");
}

/// Quests whose objectives the data places but where the guide's goal cannot be.
const OBJECTIVE_WITHOUT_A_PLACE: [f64; 9] = [
	339.0, 340.0, 341.0, 342.0, // Green Hills of Stranglethorn: pages drop at random across the zone
	96605.0, 96608.0, // The Great Outdoors: the campfire is built with a spell, not clicked
	6134.0,  // Ghost-o-plasm Round Up: the spectres come to the Ghost Magnets in the Kodo Graveyard, not their data spawn
	1149.0,  // Test of Faith: the leap is from the planks beside Dorn Plainstalker (54,41.5); the data's trigger lies at 26.4,32.9, far from him
	1699.0,  // The Rethban Gauntlet: the trigger is at the first fork inside the Rethban Caverns, and its mouth is not marked yet (tests/guides-caves.test.js)
];

fn objectives_own_goal(ctx: &Ctx, c: &mut Check) {
	let d = &ctx.data;
	let spawned = |x: &V| x.truthy() && !x.get("spawns").keys().is_empty();
	let known_place = |o: &V| match o.get("type").as_str() {
		Some("item") => {
			let drops = d.items.get(&o.get("id").to_js_string()).get("drops");
			drops.get("npc").keys().iter().any(|k| spawned(&d.npcs.get(k))) || drops.get("object").keys().iter().any(|k| spawned(&d.objects.get(k)))
		}
		Some("object") => spawned(&d.objects.get(&o.get("id").to_js_string())),
		Some("event") => !o.get("id").is_nullish() && placed(o),
		_ => false,
	};
	let mut offenders = Vec::new();
	for guide in ctx.all_guides() {
		let Some(g) = compiled(ctx, c, &guide) else { return };
		for (i, step) in g.get("steps").items().iter().enumerate() {
			let gs = step.get("goals").items();
			for goal in &gs {
				if !t_is(goal, "complete") || placed(goal) || goal.get("quest").as_num().is_some_and(|q| OBJECTIVE_WITHOUT_A_PLACE.contains(&q)) {
					continue;
				}
				let objectives = d.quests.get(&goal.get("quest").to_js_string()).get("objectives").items();
				if objectives.is_empty() || !objectives.iter().all(known_place) {
					continue;
				}
				let leads = |o: &V| {
					placed(o)
						&& if o.get("quest").strict_eq(&goal.get("quest")) { !t_is(o, "accept") && !t_is(o, "turnin") } else { o.get("quest").is_nullish() && (t_is(o, "goto") || t_is(o, "use")) }
				};
				if gs.iter().any(leads) {
					continue;
				}
				offenders.push(format!("{guide} step {} ({}): complete {}", i + 1, step.get("title").to_js_string(), goal.get("quest").to_js_string()));
			}
		}
	}
	c.eq(offenders, vec![], "objectives led to only by their turn-in, or not at all");
}

fn red_crystal(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, DARKSHORE) else { return };
	let Some(ci) = at(c, &list, "complete 4811 (The Red Crystal)", is("complete", 4811)) else { return };
	let step = &list[ci].step;
	// The step's first placed goal for the quest, past its accept: where the arrow leads.
	let lead = list.iter().find(|r| r.step.strict_eq(step) && num_is(&r.goal, "quest", 4811.0) && !t_is(&r.goal, "accept") && !t_is(&r.goal, "turnin") && located(r));
	let Some(lead) = lead else {
		c.ok(false, "the red crystal step has a goal the arrow can lead to");
		return;
	};
	// "Locate the large, red crystal on Darkshore's eastern mountain range", the quest's area trigger.
	let crystal = ctx.data.quests.get("4811").get("objectives").items().into_iter().find(|o| o.get("type").as_str() == Some("event"));
	let Some(crystal) = crystal else {
		c.ok(false, "The Red Crystal has an event objective");
		return;
	};
	let Some(y) = yards(ctx, c, &lead.goal, &crystal) else { return };
	c.ok(y < 30.0, "the arrow leads to the crystal");
}

fn blackwood_corrupted(ctx: &Ctx, c: &mut Check) {
	let d = &ctx.data;
	let Some(list) = goals(ctx, c, DARKSHORE) else { return };
	let Some(accept) = at(c, &list, "accept 4763 (The Blackwood Corrupted)", is("accept", 4763)) else { return };
	let Some(talisman) = at(c, &list, "the Talisman of Corruption", |g| t_is(g, "collect") && num_is(g, "quest", 4763.0) && num_is(g, "item", 12355.0)) else { return };
	let quest = d.quests.get("4763");
	let table = |kind: &str| if kind == "objects" { &d.objects } else { &d.npcs };
	let spawn = |kind: &str, id: &str| -> Option<V> {
		let p = table(kind).get(id).get("spawns").get("1439").get("pts").at(0);
		p.is_arr().then(|| pt(V::Num(1439.0), p.num_at(0), p.num_at(1)))
	};
	// The samples and the filled bowl: what the quest needs beyond the bowl it hands over.
	let source = quest.get("sourceItem");
	let needed: Vec<V> = quest.get("requiredItems").items().into_iter().filter(|i| !i.strict_eq(&source)).collect();
	let mut sorted: Vec<String> = needed.iter().map(|v| v.to_js_string()).collect();
	sorted.sort();
	if !c.eq(sorted, ["12341", "12342", "12343", "12347"].map(String::from).to_vec(), "the data lists the three samples and the filled bowl") || !needed.iter().all(|v| v.is_num()) {
		return;
	}
	let mut got = Vec::new();
	for item in &needed {
		let it = d.items.get(&item.to_js_string());
		let name = it.get("name").to_js_string();
		let Some(i) = at(c, &list, &format!("collect {} ({name})", item.to_js_string()), |g| t_is(g, "collect") && g.get("item").strict_eq(item)) else { return };
		if !c.ok(i > accept && i < talisman, &format!("{name} is collected after the accept and before the Talisman")) {
			return;
		}
		let Some(src) = it.get("drops").get("object").keys().first().map(|k| k.to_string()) else {
			c.ok(false, &format!("{name} drops from an object"));
			return;
		};
		let Some(sp) = spawn("objects", &src) else {
			c.ok(false, &format!("{name}'s object spawns in Darkshore"));
			return;
		};
		if !c.ok(located(&list[i]), &format!("{name} leads to {}", d.objects.get(&src).get("name").to_js_string())) {
			return;
		}
		let Some(y) = yards(ctx, c, &list[i].goal, &sp) else { return };
		if !c.ok(y < 5.0, &format!("{name} leads to {}", d.objects.get(&src).get("name").to_js_string())) {
			return;
		}
		got.push(i);
	}
	let fill = got[needed.iter().position(|v| v.as_num() == Some(12347.0)).unwrap()];
	if !c.ok(list[fill].step.strict_eq(&list[accept].step), "the bowl is filled in Auberdine, where Thundris gives the quest") {
		return;
	}
	let Some(use_) = at(c, &list, "use 12347 (Filled Cleansing Bowl)", |g| t_is(g, "use") && num_is(g, "item", 12347.0)) else { return };
	if !c.ok(got.iter().all(|&i| i < use_) && use_ < talisman, "the bowl is used with every sample in the bags, before the Talisman") {
		return;
	}
	let Some(sp) = spawn("npcs", "10373") else {
		c.ok(false, "Xabraxxis spawns in Darkshore");
		return;
	};
	let Some(y) = yards(ctx, c, &list[use_].goal, &sp) else { return };
	c.ok(y < 10.0, "the bowl is used where Xabraxxis comes");
}

fn rumbleshot_ammo(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, DUN_MOROGH) else { return };
	let ammo = list.iter().find(|r| t_is(&r.goal, "collect") && num_is(&r.goal, "quest", 5541.0));
	let Some(ammo) = ammo.filter(|r| located(r)) else {
		c.ok(false, "the ammo has a place");
		return;
	};
	let Some(y) = yards(ctx, c, &ammo.goal, &pt(ammo.goal.get("map"), 44.13, 56.95)) else { return };
	c.ok(y < 30.0, "the ammo is at the crate");
}

fn legacy_bodley(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, "forever/legacy/legacy-challenges.guide") else { return };
	let Some(bodley) = at(c, &list, "turnin 8996", is("turnin", 8996)) else { return };
	for quest in [8997, 8998] {
		let Some(a) = at(c, &list, &format!("accept {quest}"), is("accept", quest)) else { return };
		if !c.ok(bodley < a, &format!("8996 before {quest}")) {
			return;
		}
	}
}

/// format.js VERSION: the nav tile version the JS reads.
const NAV_TILE_VERSION: f64 = 4.0;

fn transport_gotos_dry(ctx: &Ctx, c: &mut Check) {
	use forge_nav::grid::{cell_of, flag, Grid, TILE_CELLS};
	let nav_dir = ctx.root.join("data/local/nav");
	let index = std::fs::read_to_string(nav_dir.join("index.json")).ok().and_then(|t| forge_guide::js::parse_json(&t).ok());
	let Some(index) = index else {
		c.skip("no navigation build in data/local/nav (node tools/polestar.js nav build)");
		return;
	};
	if index.get("version").as_num() != Some(NAV_TILE_VERSION) {
		c.skip(&format!("data/local/nav is tile version {}: rebuild it (node tools/polestar.js nav build)", index.get("version").to_js_string()));
		return;
	}
	let nav = match Grid::open(&nav_dir, 256) {
		Ok(g) => g,
		Err(e) => {
			c.ok(false, &format!("the nav build opens: {e}"));
			return;
		}
	};
	let d = &ctx.data;
	// Geo.toWorld: the frame set f's first (`e` the Era set, anything else the live one), the other when
	// the map has none.
	let to_world = |map: &V, x: f64, y: f64, f: &str| -> Option<(f64, f64, f64)> {
		let key = map.as_num()?.to_string();
		let (a, b) = if f == "e" { ("era", "forever") } else { ("forever", "era") };
		let fa = d.map_frames.get(a).get(&key);
		let fr = if fa.truthy() { fa } else { d.map_frames.get(b).get(&key) };
		if !fr.truthy() {
			return None;
		}
		Some((n(&fr, "c"), n(&fr, "top") + (n(&fr, "bottom") - n(&fr, "top")) * (y / 100.0), n(&fr, "left") + (n(&fr, "right") - n(&fr, "left")) * (x / 100.0)))
	};
	let mut stops = Vec::new();
	for t in d.travel.get("transports").items() {
		for side in ["a", "b"] {
			let s = t.get(side);
			stops.push((format!("{} ({})", t.get("id").to_js_string(), s.get("name").to_js_string()), n(&s, "c"), n(&s, "wx"), n(&s, "wy")));
		}
	}
	// A dry walkable surface in the cell at (wx, wy): not swim or blocked, above any water there, in a
	// region the router snaps to (not a pocket under the deck).
	let dry = |cc: f64, wx: f64, wy: f64| -> bool {
		let (col, row, i, j) = cell_of(wx, wy);
		let Some(t) = nav.tile(cc as u32, col, row) else { return false };
		let k = (j * TILE_CELLS as i64 + i) as usize;
		let (a, b) = (t.first[k] as usize, t.first[k + 1] as usize);
		let water = (a..b).filter(|&e| t.flags[e] & flag::SWIM != 0).map(|e| t.z[e] as f64).fold(f64::NEG_INFINITY, f64::max);
		(a..b).any(|e| t.flags[e] & (flag::SWIM | flag::BLOCKED) == 0 && t.z[e] as f64 > water && nav.region_size(cc as u32, col as u32, row as u32, e as u32).unwrap_or(1000) >= 1000)
	};
	let near_dry = |cc: f64, wx: f64, wy: f64| -> bool {
		if dry(cc, wx, wy) {
			return true;
		}
		for r in [2.0f64, 4.0, 6.0, 8.0] {
			for deg in (0..360).step_by(15) {
				let a = (deg as f64 * std::f64::consts::PI) / 180.0;
				if dry(cc, wx + r * a.cos(), wy + r * a.sin()) {
					return true;
				}
			}
		}
		false
	};
	let mut offenders: Vec<String> = Vec::new();
	let mut checked = 0;
	for guide in ctx.all_guides() {
		let Some(list) = goals(ctx, c, &guide) else { return };
		for r in &list {
			let goal = &r.goal;
			if !t_is(goal, "goto") {
				continue;
			}
			let f = goal.get("f");
			let f = if f.truthy() { f.to_js_string() } else { "l".to_string() };
			let Some((wc, wx, wy)) = to_world(&goal.get("map"), n(goal, "x"), n(goal, "y"), &f) else { continue };
			let Some(stop) = stops.iter().find(|s| s.1 == wc && (s.2 - wx).hypot(s.3 - wy) <= 40.0) else { continue };
			checked += 1;
			if !near_dry(wc, wx, wy) {
				let o = format!(
					"{guide} step \"{}\": goto {},{} \"{}\" by {}",
					r.step.get("title").to_js_string(),
					goal.get("x").to_js_string(),
					goal.get("y").to_js_string(),
					goal.get("text").to_js_string(),
					stop.0
				);
				if !offenders.contains(&o) {
					offenders.push(o);
				}
			}
		}
	}
	if !c.ok(checked >= 10, &format!("the guides' transport gotos are found ({checked})")) {
		return;
	}
	c.eq(offenders, vec![], "transport gotos with no deck or pier within 8 yd");
}

fn typed_coords_zone(ctx: &Ctx, c: &mut Check) {
	use forge_guide::conditions::character_keys;
	let d = &ctx.data;
	let classes_of = |race: &str, side: &str| d.race_classes(race, side);
	let classes_of: &dyn Fn(&str, &str) -> V = &classes_of;
	let zone_re = regex::Regex::new(r"^\s+zone\b").unwrap();
	let line_split = regex::Regex::new(r"\r?\n").unwrap();
	let mut offenders = Vec::new();
	for guide in ctx.all_guides() {
		let Some(g) = compiled(ctx, c, &guide) else { return };
		let ast = g.hidden("_ast");
		let text = std::fs::read_to_string(ctx.guides.join(&guide)).unwrap_or_default();
		let lines: Vec<&str> = line_split.split(&text).collect();
		let zone_at = |ln: &V| -> String {
			match ln.as_num() {
				Some(l) if l != 0.0 => lines.get(l as usize - 1).map(|s| s.trim().to_string()).unwrap_or_default(),
				_ => "no zone".into(),
			}
		};
		let header = ast.get("header");
		let head = Obj::new();
		let faction = header.get("faction");
		head.set("factions", if faction.truthy() { V::from(vec![faction]) } else { V::Null });
		let or_null = |v: V| if v.truthy() { v } else { V::Null };
		head.set("races", or_null(header.get("races")));
		head.set("classes", or_null(header.get("classes")));
		let head = V::Obj(head);
		let asteps = ast.get("steps").items();
		// Every step's `zone` lines, with who sees the step.
		let mut zone_lines: Vec<(f64, Vec<String>)> = Vec::new();
		for (i, s) in asteps.iter().enumerate() {
			let end = if i + 1 < asteps.len() { n(&asteps[i + 1], "line") } else { lines.len() as f64 + 1.0 };
			let who = character_keys(&[head.clone(), s.get("only")], Some(classes_of));
			let mut ln = n(s, "line") + 1.0;
			while ln < end {
				if lines.get(ln as usize - 1).is_some_and(|l| zone_re.is_match(l)) {
					zone_lines.push((ln, who.clone()));
				}
				ln += 1.0;
			}
		}
		let header_zone = header.get("zone");
		let gsteps = g.get("steps");
		for (si, s) in asteps.iter().enumerate() {
			for (gi, ag) in s.get("goals").items().iter().enumerate() {
				if !ag.get("explicitCoords").truthy() || !ag.get("coordMap").is_undef() {
					continue;
				}
				let z = ag.get("zone");
				let compiled_zone = zone_at(&if z.truthy() { z.get("line") } else { z });
				let mut elsewhere: Vec<String> = Vec::new();
				let ag_line = n(ag, "line");
				for k in character_keys(&[head.clone(), s.get("only"), ag.get("only")], Some(classes_of)) {
					let mut ln = if header_zone.truthy() { header_zone.get("line") } else { V::Null };
					for (zl, who) in &zone_lines {
						if *zl < ag_line && who.contains(&k) {
							ln = V::Num(*zl);
						}
					}
					let here = zone_at(&ln);
					if here != compiled_zone && !elsewhere.contains(&here) {
						elsewhere.push(here);
					}
				}
				let goal = gsteps.at(si).get("goals").at(gi);
				if !elsewhere.is_empty() {
					offenders.push(format!(
						"{guide}:{} ({} {},{}) is on {compiled_zone}, for characters in {}",
						ag.get("line").to_js_string(),
						goal.get("t").to_js_string(),
						goal.get("x").to_js_string(),
						goal.get("y").to_js_string(),
						elsewhere.join(", ")
					));
				}
			}
		}
	}
	c.eq(offenders, vec![], "typed coordinates on a zone some of their characters are not in");
}

/// Guides that never pass the inn before their hearth, so a bind there would add a detour.
const HEARTH_ON_AN_EARLIER_BIND: [&str; 2] = [
	// Enters the Badlands from Ironband's dig site in south-east Loch Modan; Thelsamar is off the way.
	"forever/alliance/30-40/06-badlands.guide Stoutlager Inn",
	// Starts at the Broken Pillar and goes down into the crater; Gadgetzan is to the north.
	"forever/horde/50-60/01-un-goro-crater.guide Gadgetzan",
];

fn hearth_bound(ctx: &Ctx, c: &mut Check) {
	let mut offenders = Vec::new();
	for guide in ctx.all_guides() {
		let Some(list) = goals(ctx, c, &guide) else { return };
		let mut bound: Vec<V> = Vec::new();
		for r in &list {
			let loc = r.goal.get("location");
			if t_is(&r.goal, "sethome") && everyone(r) && !bound.iter().any(|b| b.strict_eq(&loc)) {
				bound.push(loc.clone());
			}
			let key = format!("{guide} {}", loc.to_js_string());
			if t_is(&r.goal, "hearth") && !bound.iter().any(|b| b.strict_eq(&loc)) && !HEARTH_ON_AN_EARLIER_BIND.contains(&key.as_str()) {
				offenders.push(format!("{key} (step {})", r.step.get("title").to_js_string()));
			}
		}
	}
	c.eq(offenders, vec![], "hearths to an inn the guide has not bound at");
}

fn bait_ingredients(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ELWYNN) else { return };
	for (item, oi, what) in [(286215.0, 1.0, "Vial of Animal Blood is objective 1"), (286214.0, 2.0, "Duskweed Petal is objective 2")] {
		let Some(r) = list.iter().find(|r| t_is(&r.goal, "collect") && num_is(&r.goal, "quest", 99130.0) && num_is(&r.goal, "item", item)) else {
			c.ok(false, &format!("collect {item} for 99130 is in the guide"));
			return;
		};
		if !c.ok(num_is(&r.goal, "oi", oi), what) {
			return;
		}
	}
}

fn echo_ridge(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ELWYNN) else { return };
	let Some(handed) = at(c, &list, "turnin 15 (Investigate Echo Ridge)", is("turnin", 15)) else { return };
	let Some(take) = at(c, &list, "accept 21 (Skirmish at Echo Ridge)", is("accept", 21)) else { return };
	if !c.ok(handed < take, "Investigate Echo Ridge is handed in first") || !c.ok(list[take].goal.get("npc").strict_eq(&list[handed].goal.get("npc")), "both at Marshal McBride") {
		return;
	}
	let between: Vec<String> = list[handed + 1..take]
		.iter()
		.filter(|r| located(r))
		.map(|r| {
			let name = r.goal.get("npcName");
			format!("{} {} at {}", r.goal.get("t").to_js_string(), r.goal.get("quest").to_js_string(), if name.truthy() { name } else { r.goal.get("npc") }.to_js_string())
		})
		.collect();
	if !c.eq(between, vec![], "nobody else between them") {
		return;
	}
	let Some(paxton) = at(c, &list, "turnin 91743 (Rascally Rodents)", is("turnin", 91743)) else { return };
	c.ok(take < paxton, "Skirmish at Echo Ridge is taken before Brother Paxton");
}

fn kadrak_map(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, STONETALON_HORDE) else { return };
	for (i, (t, q)) in [("turnin", 6541), ("accept", 6543), ("turnin", 6543)].into_iter().enumerate() {
		let Some(k) = at(c, &list, &format!("Kadrak goal {}", i + 1), is(t, q)) else { return };
		let g = &list[k].goal;
		if !c.ok(num_is(g, "map", 1413.0), &format!("{t} {q} is on The Barrens (1413), not {}", g.get("map").to_js_string())) {
			return;
		}
	}
	let Some(s) = at(c, &list, "the Warsong Scout Update", |g| t_is(g, "collect") && num_is(g, "item", 16764.0)) else { return };
	c.ok(num_is(&list[s].goal, "map", 1440.0), "the Warsong Scout is still in Ashenvale");
}

fn tirion_hut(ctx: &Ctx, c: &mut Check) {
	let tirion = [5542.0, 5543.0, 5544.0, 5742.0, 5781.0];
	let mut found = Vec::new();
	for guide in ctx.all_guides() {
		let Some(list) = goals(ctx, c, &guide) else { return };
		for r in &list {
			let goal = &r.goal;
			if !goal.get("quest").as_num().is_some_and(|q| tirion.contains(&q)) || !(t_is(goal, "accept") || t_is(goal, "turnin")) {
				continue;
			}
			found.push(format!("{guide} {} {}", goal.get("t").to_js_string(), goal.get("quest").to_js_string()));
			if !c.ok(
				num_is(goal, "npc", 1855.0) && num_is(goal, "map", 1423.0),
				&format!(
					"{guide} (step {}) {} {}: Tirion Fordring on the Eastern Plaguelands' map",
					r.step.get("title").to_js_string(),
					goal.get("t").to_js_string(),
					goal.get("quest").to_js_string()
				),
			) {
				return;
			}
		}
	}
	for guide in ["forever/alliance/50-60/04-western-plaguelands.guide", "forever/horde/50-60/02-felwood.guide"] {
		for q in [5542, 5543, 5544] {
			if !c.ok(found.contains(&format!("{guide} accept {q}")), &format!("{guide} takes {q} from Tirion")) {
				return;
			}
		}
	}
}

/// The Dry Hills, in map percent.
fn in_dry_hills(p: &V) -> bool {
	let (x, y) = (n(p, "x"), n(p, "y"));
	(40.0..=52.0).contains(&x) && (10.0..=22.0).contains(&y)
}

fn lion_hides(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, BARRENS_04) else { return };
	for quest in [95494, 95507] {
		let Some(i) = at(c, &list, &format!("the Dry Hills collect for {quest}"), is("collect", quest)) else { return };
		let goal = &list[i].goal;
		let mut pts = vec![goal.clone()];
		pts.extend(spots(goal));
		for p in &pts {
			let wh = format!("{} at {},{}", goal.get("itemName").to_js_string(), p.get("x").to_js_string(), p.get("y").to_js_string());
			if !c.ok(in_dry_hills(p), &format!("{wh} is in the Dry Hills")) || !c.ok((n(p, "x") - 60.0).hypot(n(p, "y") - 33.0) > 10.0, &format!("{wh} is not near Ratchet's Matriarchs (60,33)")) {
				return;
			}
		}
	}
}

fn raptor_horns(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, BARRENS_04) else { return };
	let hills = list.iter().position(|r| r.step.get("title").as_str() == Some("The Dry Hills") && is("collect", 95494)(&r.goal));
	let Some(hills) = hills else {
		c.ok(false, "the Dry Hills step is in the guide");
		return;
	};
	let Some(horns) = list.iter().position(|r| r.s == list[hills].s && is("collect", 865)(&r.goal)) else {
		c.ok(false, "the Dry Hills step collects the Raptor Horns");
		return;
	};
	let goal = &list[horns].goal;
	if !c.ok(num_is(goal, "item", 5055.0), "Intact Raptor Horn") {
		return;
	}
	// The arrow's spots; the alternatives (alt) are only marked on the map.
	let mut pts = vec![goal.clone()];
	pts.extend(non_alt(goal));
	for p in &pts {
		if !c.ok(in_dry_hills(p), &format!("the horns' arrow at {},{} is in the Dry Hills", p.get("x").to_js_string(), p.get("y").to_js_string())) {
			return;
		}
	}
	let Some(t) = at(c, &list, "the Raptor Horns turn-in", is("turnin", 865)) else { return };
	c.ok(horns < t, "before the horns are handed in at Ratchet");
}

fn iron_pike(ctx: &Ctx, c: &mut Check) {
	let d = &ctx.data;
	let Some(list) = goals(ctx, c, REDRIDGE) else { return };
	let ribchaser = 14271.0;
	let pts_on =
		|id: f64| -> Vec<(f64, f64)> { d.spawns("npc", &V::Num(id)).into_iter().filter(|s| num_is(s, "map", 1433.0)).flat_map(|s| s.get("pts").items()).map(|p| (p.num_at(0), p.num_at(1))).collect() };
	let camp = pts_on(ribchaser);
	if !c.ok(!camp.is_empty(), "Ribchaser spawns in Redridge Mountains") {
		return;
	}
	let map = V::Num(1433.0);
	let near = |c: &mut Check, a: &V, pts: &[(f64, f64)], r: f64| -> Option<bool> {
		let ap = pt(map.clone(), n(a, "x"), n(a, "y"));
		for &(x, y) in pts {
			if yards(ctx, c, &ap, &pt(map.clone(), x, y))? <= r {
				return Some(true);
			}
		}
		Some(false)
	};
	for item in [2856.0, 1013.0] {
		let Some(i) = at(c, &list, &format!("item {item}"), |g| t_is(g, "collect") && num_is(g, "quest", 89.0) && num_is(g, "item", item)) else { return };
		let g = &list[i].goal;
		if !c.ok(g.get("from").as_str() != Some("Ribchaser"), &format!("item {item} names a common dropper, not the rare"))
			|| !c.ok(g.get("fromAlso").as_str() != Some("Ribchaser"), "fromAlso is not the rare")
			|| !c.ok(g.get("fromRank").is_undef(), &format!("item {item} names a common dropper (rank {})", g.get("fromRank").to_js_string()))
		{
			return;
		}
		let it = d.item(&V::Num(item));
		let Some(npcs) = it.get("drops").get("npc").as_obj().map(|o| o.keys()) else {
			c.ok(false, &format!("item {item} drops from NPCs"));
			return;
		};
		let mut droppers: Vec<f64> = Vec::new();
		for k in npcs {
			let id = forge_guide::js::str_to_num(&k);
			if id != ribchaser && !droppers.contains(&id) {
				droppers.push(id);
			}
		}
		let spawns: Vec<(f64, f64)> = droppers.iter().flat_map(|&id| pts_on(id)).collect();
		let mut points = vec![g.clone()];
		points.extend(non_alt(g));
		for p in &points {
			let at_ = format!("{},{}", p.get("x").to_js_string(), p.get("y").to_js_string());
			let Some(in_camp) = near(c, p, &camp, 60.0) else { return };
			if !c.ok(!in_camp, &format!("item {item}: {at_} is in Ribchaser's camp")) {
				return;
			}
			let Some(by) = near(c, p, &spawns, 120.0) else { return };
			if !c.ok(by, &format!("item {item}: {at_} is by a common dropper")) {
				return;
			}
		}
	}
}

fn elemental_bracers(ctx: &Ctx, c: &mut Check) {
	let Some(list) = goals(ctx, c, ASHENVALE_ALLIANCE) else { return };
	let Some(bracers) = at(c, &list, "collect 12220", |g| t_is(g, "collect") && num_is(g, "item", 12220.0)) else { return };
	let Some(scroll) = at(c, &list, "collect 5455", |g| t_is(g, "collect") && num_is(g, "item", 5455.0) && num_is(g, "quest", 1016.0)) else { return };
	let b = &list[bracers].goal;
	if !c.ok(num_is(b, "count", 5.0), "five bracers")
		|| !c.ok(b.get("quest").is_undef(), "counted in the bags: the Divining Scroll uses them up")
		|| !c.ok(b.get("optional").strict_eq(&V::Bool(true)), "a scroll made before the step does not wait on bracers it used up")
	{
		return;
	}
	c.ok(bracers < scroll && list[bracers].s == list[scroll].s, "the bracers come first, in the same step");
}
