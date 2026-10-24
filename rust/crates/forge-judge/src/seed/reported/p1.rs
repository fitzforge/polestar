//! Part of tests/guides-reported.test.js (see reported.rs): its lines 1-558, without the tests that play
//! the guide in the addon (those are in eng.rs).

use forge_guide::js::V;

use crate::seed::{at, everyone, for_class, is, located, Check, Ctx, Row, SeedTest};

const DUROTAR: &str = "forever/horde/orc-troll/01-durotar.guide";
const DUN_MOROGH: &str = "forever/alliance/dwarf-gnome/01-dun-morogh.guide";
const TELDRASSIL: &str = "forever/alliance/nightelf/01-teldrassil.guide";
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest.guide";
const MULGORE: &str = "forever/horde/tauren/01-mulgore.guide";
const TIRISFAL: &str = "forever/horde/undead/01-tirisfal-glades.guide";
const STONETALON: &str = "forever/horde/05-stonetalon-mountains.guide";
const ASHENVALE_HORDE: &str = "forever/horde/07-ashenvale.guide";

/// `c.ok` / `c.eq` with the condition evaluated first (so it may itself use `c`).
macro_rules! ok {
	($c:expr, $cond:expr, $msg:expr) => {{
		let b = $cond;
		$c.ok(b, $msg)
	}};
}
macro_rules! eq {
	($c:expr, $a:expr, $b:expr, $msg:expr) => {{
		let (a, b) = ($a, $b);
		$c.eq(a, b, $msg)
	}};
}

/// `at(...)`, returning from the test when absent (the JS assertion throws).
macro_rules! at {
	($c:expr, $list:expr, $what:expr, $pred:expr) => {
		match at($c, $list, &$what, $pred) {
			Some(i) => i,
			None => return,
		}
	};
}

/// `goals(guide)`, with the JS `compiled` assertion that the file compiles to one guide.
fn goals(ctx: &Ctx, c: &mut Check, guide: &str) -> Option<Vec<Row>> {
	if !ok!(c, !ctx.compiled(guide).is_undef(), &format!("{guide} compiles")) {
		return None;
	}
	Some(ctx.goals(guide))
}

macro_rules! goals {
	($ctx:expr, $c:expr, $guide:expr) => {
		match goals($ctx, $c, $guide) {
			Some(l) => l,
			None => return,
		}
	};
}

/// `yards(a, b)`, with its assertion that both points are on one map with an Era frame.
macro_rules! yards {
	($ctx:expr, $c:expr, $a:expr, $b:expr) => {{
		let y = $ctx.yards($a, $b);
		if !$c.ok(y.is_some(), "points on one map with an Era frame") {
			return;
		}
		y.unwrap()
	}};
}

fn n(v: &V, k: &str, x: f64) -> bool {
	v.get(k).as_num() == Some(x)
}
fn t(v: &V, x: &str) -> bool {
	v.get("t").as_str() == Some(x)
}
fn filter(list: &[Row], f: impl Fn(&Row) -> bool) -> Vec<Row> {
	list.iter().filter(|r| f(r)).cloned().collect()
}
/// `${goal.t} ${goal.quest}` for a list asserted empty.
fn names(list: &[Row]) -> Vec<String> {
	list.iter().map(|r| format!("{} {}", r.goal.get("t").to_js_string(), r.goal.get("quest").to_js_string())).collect()
}
/// `deepEqual(arr, [x])` for an array of one number.
fn is_one(v: &V, x: f64) -> bool {
	v.is_arr() && v.len() == 1 && v.at(0).as_num() == Some(x)
}

fn call_of_fire(ctx: &Ctx, c: &mut Check) {
	for file in ["forever/horde/02-the-barrens.guide", "forever/horde/orc-troll/02-the-barrens.guide"] {
		let list = goals!(ctx, c, file);
		let start = list.iter().position(|r| is("accept", 1524)(&r.goal));
		if !ok!(c, start.is_some(), &format!("{file}: the shared ritual is offered")) {
			return;
		}
		let start = start.unwrap();
		for quest in [1522, 1523, 2983, 2984] {
			let lead = list[..start].iter().find(|r| is("turnin", quest)(&r.goal));
			if !ok!(c, lead.is_some(), &format!("{file}: carried trainer lead {quest} is handed in before the shared ritual")) {
				return;
			}
			let lead = lead.unwrap();
			if quest != (if file.contains("orc-troll") { 2983 } else { 1523 }) {
				let blocks = lead
					.step
					.get("when")
					.items()
					.iter()
					.any(|p| p.get("k").as_str() == Some("onquest") && !p.get("neg").truthy() && p.get("q").items().iter().any(|q| q.as_num() == Some(quest as f64)));
				if !ok!(c, blocks, &format!("{file}: an uncarried alternative never blocks the route")) {
					return;
				}
			}
			if !ok!(c, n(&lead.goal, "npc", 5907.0), &format!("{file}: no trip to a different giver")) {
				return;
			}
			for field in ["map", "x", "y"] {
				if !ok!(c, lead.goal.get(field).strict_eq(&list[start].goal.get(field)), &format!("{file}: the same Kranal stop")) {
					return;
				}
			}
		}
	}
}

/// `/\bTWO\b.*flares/i`.
fn two_flares(s: &str) -> bool {
	let l = s.to_ascii_lowercase();
	let b = l.as_bytes();
	let word = |i: usize| b.get(i).is_some_and(|c| c.is_ascii_alphanumeric() || *c == b'_');
	l.match_indices("two").any(|(i, _)| (i == 0 || !word(i - 1)) && !word(i + 3) && l[i + 3..].split(['\n', '\r', '\u{2028}', '\u{2029}']).next().is_some_and(|rest| rest.contains("flares")))
}

fn poisons(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, "forever/horde/04-the-barrens.guide");
	let contact = list[at!(c, &list, "contact Fizzule", is("turnin", 2458))].step.clone();
	let note = contact.get("note");
	let Some(note) = note.as_str() else {
		ok!(c, false, "the contact step has a note");
		return;
	};
	let flare = note.find("{item:8051}");
	let salute = note.find("/salute");
	if !ok!(c, matches!((flare, salute), (Some(f), Some(s)) if f < s), "signal with the quest item before saluting") {
		return;
	}
	ok!(c, two_flares(note), "the quest requires two signals");
}

fn sarkoth(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUROTAR);
	let sarkoth = at!(c, &list, "Sarkoth's Mangled Claw", |g: &V| t(g, "collect") && n(g, "quest", 790.0));
	for (what, q, msg) in [
		("turnin 788 (Cutting Teeth)", ("turnin", 788), "Cutting Teeth is handed in before Sarkoth"),
		("accept 789 (Sting of the Scorpid)", ("accept", 789), "Sting of the Scorpid is taken before Sarkoth"),
		("accept 4402 (Galgar's Cactus Apple Surprise)", ("accept", 4402), "the cactus apples are taken before Sarkoth"),
	] {
		if !ok!(c, at!(c, &list, what, is(q.0, q.1)) < sarkoth, msg) {
			return;
		}
	}
	let back = at!(c, &list, "turnin 804 (Sarkoth)", is("turnin", 804));
	for q in [789.0, 4402.0] {
		if !ok!(c, at!(c, &list, format!("the objective of {q}"), |g: &V| t(g, "collect") && n(g, "quest", q)) < back, &format!("{q}'s objective is done before the Den")) {
			return;
		}
	}
}

fn securing(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUROTAR);
	let securing = at!(c, &list, "accept 835 (Securing the Lines)", is("accept", 835));
	for q in [817, 818, 826, 808, 786] {
		if !ok!(c, at!(c, &list, format!("turnin {q}"), is("turnin", q)) < securing, &format!("{q} is handed in before Securing the Lines is taken")) {
			return;
		}
	}
	let a806 = at!(c, &list, "accept 806 (Fizzle Darkstorm)", is("accept", 806));
	let a834 = at!(c, &list, "accept 834 (Rezlak)", is("accept", 834));
	if !ok!(c, a806 < a834, "834 is taken after 806") {
		return;
	}
	let t835 = at!(c, &list, "turnin 835", is("turnin", 835));
	let t806 = at!(c, &list, "turnin 806", is("turnin", 806));
	ok!(c, t835 < t806, "835 is done before 806 is handed in");
}

fn patience(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, TIRISFAL);
	for (item, npc, name) in [(286200.0, 1496.0, "Deathguard Dillinger"), (286201.0, 251001.0, "Deathguard Kristof"), (286202.0, 10666.0, "Gordo")] {
		let goal = &list[at!(c, &list, format!("collect {item} ({name})"), |g: &V| t(g, "collect") && n(g, "item", item))].goal;
		if !ok!(c, n(goal, "npc", npc), &format!("{name} is named on the goal")) || !ok!(c, goal.get("npcName").as_str() == Some(name), &format!("npcName is {name}")) {
			return;
		}
	}
}

fn warsong(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, STONETALON);
	for (item, npc, name) in [(16764.0, 12862.0, "Warsong Scout"), (16763.0, 12863.0, "Warsong Runner"), (16765.0, 12864.0, "Warsong Outrider")] {
		let goal = &list[at!(c, &list, format!("collect {item} ({name})"), |g: &V| t(g, "collect") && n(g, "item", item))].goal;
		let f = goal.get("fromNpcs");
		let one = f.is_arr() && f.len() == 1 && {
			let o = f.at(0);
			o.is_obj() && o.len() == 2 && n(&o, "npc", npc) && o.get("npcName").as_str() == Some(name)
		};
		if !ok!(c, one, &format!("{name} is the goal's hand-over NPC")) {
			return;
		}
	}
}

fn kzan(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUROTAR);
	let kzan = at!(c, &list, "turnin 97279 (Wayward Weapons)", is("turnin", 97279));
	let Some(last) = (0..kzan).rev().find(|&i| t(&list[i].goal, "goto")) else {
		ok!(c, false, "a goto comes before Kzan");
		return;
	};
	let lg = &list[last].goal;
	if !ok!(c, n(lg, "map", 1411.0) && n(lg, "x", 42.4) && n(lg, "y", 68.6), "the goto before Kzan is { map: 1411, x: 42.4, y: 68.6 }") {
		return;
	}
	for r in list[last + 1..kzan].iter().filter(|r| located(r) && everyone(r)) {
		let y = yards!(ctx, c, &r.goal, lg);
		if !ok!(c, y < 40.0, &format!("{} {} lies by the mouth", r.goal.get("t").to_js_string(), r.goal.get("quest").to_js_string())) {
			return;
		}
	}
}

struct Cave {
	cave: &'static str,
	guide: &'static str,
	target: fn(&V) -> bool,
	mouth: (f64, f64, f64),
}

const CAVES: [Cave; 10] = [
	Cave { cave: "the Burning Blade Coven (the pick)", guide: DUROTAR, target: |g| t(g, "collect") && n(g, "item", 16332.0), mouth: (1411.0, 45.0, 56.0) },
	Cave { cave: "Skull Rock", guide: DUROTAR, target: |g| t(g, "collect") && n(g, "item", 4871.0), mouth: (1411.0, 55.0, 10.0) },
	Cave { cave: "the Coldridge troll cave", guide: DUN_MOROGH, target: |g| t(g, "collect") && n(g, "item", 2004.0), mouth: (1426.0, 26.93, 80.03) },
	Cave { cave: "the Grizzled Den", guide: DUN_MOROGH, target: |g| t(g, "collect") && n(g, "item", 280413.0), mouth: (1426.0, 42.57, 54.68) },
	Cave { cave: "the Grizzled Den (Frosthowl)", guide: DUN_MOROGH, target: |g| t(g, "collect") && n(g, "item", 280426.0), mouth: (1426.0, 42.57, 54.68) },
	Cave { cave: "Frostmane Hold", guide: DUN_MOROGH, target: |g| t(g, "kill") && n(g, "quest", 287.0), mouth: (1426.0, 25.1, 50.94) },
	Cave { cave: "the Jasperlode Mine", guide: ELWYNN, target: |g| t(g, "collect") && n(g, "item", 247816.0), mouth: (1429.0, 61.6, 54.1) },
	Cave { cave: "Shadowthread Cave", guide: TELDRASSIL, target: |g| t(g, "collect") && n(g, "item", 5167.0), mouth: (1438.0, 56.69, 31.29) },
	Cave { cave: "Fel Rock", guide: TELDRASSIL, target: |g| t(g, "collect") && n(g, "item", 5221.0), mouth: (1438.0, 54.59, 52.12) },
	Cave { cave: "Night Web's Hollow", guide: TIRISFAL, target: |g| t(g, "goto") && n(g, "x", 24.8) && n(g, "y", 59.6), mouth: (1420.0, 26.0, 60.0) },
];

fn cave_name(k: usize) -> String {
	let cv = &CAVES[k];
	format!("{}: Tom's report: the arrow reaches {} through its mouth at {},{}", cv.guide, cv.cave, cv.mouth.1, cv.mouth.2)
}

fn cave(k: usize, ctx: &Ctx, c: &mut Check) {
	let cv = &CAVES[k];
	let list = goals!(ctx, c, cv.guide);
	let i = at!(c, &list, cv.cave, cv.target);
	let Some(before) = list[..i].iter().rev().find(|r| located(r)) else {
		ok!(c, false, "a located goal comes before the target");
		return;
	};
	let g = &before.goal;
	let (map, x, y) = cv.mouth;
	ok!(c, t(g, "goto") && n(g, "map", map) && n(g, "x", x) && n(g, "y", y), &format!("the waypoint before \"{}\" is the mouth", list[i].step.get("title").to_js_string()));
}

fn gruko(ctx: &Ctx, c: &mut Check) {
	let all = goals!(ctx, c, DUROTAR);
	for cls in ["WARRIOR", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK"] {
		let list = filter(&all, for_class(cls));
		let pick = at!(c, &list, "Thazz'ril's Pick", |g: &V| t(g, "collect") && n(g, "item", 16332.0));
		let yarrog = at!(c, &list, "the Burning Blade Medallion", |g: &V| t(g, "collect") && n(g, "item", 4859.0));
		if !ok!(c, at!(c, &list, "accept 794 (Burning Blade Medallion)", is("accept", 794)) < pick, &format!("{cls}: the Medallion is taken before the cave"))
			|| !ok!(c, pick < yarrog, &format!("{cls}: the pick, then Yarrog"))
		{
			return;
		}
		let outside: Vec<String> = list[pick + 1..yarrog]
			.iter()
			.filter(|r| located(r))
			.map(|r| {
				let q = r.goal.get("quest");
				format!("{} {}", r.goal.get("t").to_js_string(), if q.truthy() { q } else { r.goal.get("text") }.to_js_string())
			})
			.collect();
		if !eq!(c, outside, vec![], &format!("{cls}: nothing outside the cave between the pick and Yarrog")) {
			return;
		}
	}
}

fn dolanaar(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, TELDRASSIL);
	let take = at!(c, &list, "accept 2159 (Dolanaar Delivery)", is("accept", 2159));
	for q in [921, 3522, 917, 457, 456] {
		if !ok!(c, at!(c, &list, format!("turnin {q}"), is("turnin", q)) < take, &format!("turnin {q} comes before the delivery")) {
			return;
		}
	}
	let keldamyr = list[at!(c, &list, "turnin 2159", is("turnin", 2159))].goal.clone();
	let tenaron = list[at!(c, &list, "turnin 921", is("turnin", 921))].goal.clone();
	let porthannius = list[take].goal.clone();
	let a = yards!(ctx, c, &porthannius, &keldamyr);
	let b = yards!(ctx, c, &tenaron, &keldamyr);
	if !ok!(c, a < b, "Porthannius is on the way down to Dolanaar") {
		return;
	}
	let Some(next) = list[take + 1..].iter().filter(|r| located(r)).find(|r| everyone(r)) else {
		ok!(c, false, "a stop after the delivery");
		return;
	};
	let a = yards!(ctx, c, &next.goal, &keldamyr);
	let b = yards!(ctx, c, &next.goal, &tenaron);
	ok!(c, a < b, &format!("the next stop ({} {}) is in Dolanaar", next.goal.get("t").to_js_string(), next.goal.get("quest").to_js_string()));
}

fn oracle_tree(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, TELDRASSIL);
	let bark = at!(c, &list, "turnin 98398 (The Oracle Tree)", is("turnin", 98398));
	let take = at!(c, &list, "accept 940 (Teldrassil)", is("accept", 940));
	if !eq!(c, take, bark + 1, "taken straight after The Oracle Tree is handed in") || !ok!(c, everyone(&list[take]), "for every class") {
		return;
	}
	let y = yards!(ctx, c, &list[take].goal, &list[bark].goal);
	if !ok!(c, y < 5.0, "at the same Oracle Tree Bark, not back at Arynia") {
		return;
	}
	let fandral = at!(c, &list, "turnin 935 (Crown of the Earth)", is("turnin", 935));
	let hand = at!(c, &list, "turnin 940 (Teldrassil)", is("turnin", 940));
	if !ok!(c, list[hand].step.strict_eq(&list[fandral].step), "handed in on the Darnassus visit that already goes to Fandral") {
		return;
	}
	let y = yards!(ctx, c, &list[hand].goal, &list[fandral].goal);
	ok!(c, y < 5.0, "to Fandral himself");
}

fn tannok(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let take = at!(c, &list, "accept 2160 (Supplies to Tannok)", is("accept", 2160));
	for q in [3365, 218, 170, 183] {
		if !ok!(c, at!(c, &list, format!("turnin {q}"), is("turnin", q)) < take, &format!("turnin {q} comes before Supplies to Tannok")) {
			return;
		}
	}
	let thalos = list[at!(c, &list, "turnin 282 (Mountaineer Thalos)", is("turnin", 282))].goal.clone();
	let y = yards!(ctx, c, &list[take].goal, &thalos);
	if !ok!(c, y < 40.0, "Hands Springsprocket is taken at the tunnel, beside Thalos") {
		return;
	}
	let Some(before) = list[..take].iter().rev().filter(|r| located(r)).find(|r| everyone(r)) else {
		ok!(c, false, "a stop before Supplies to Tannok");
		return;
	};
	let y = yards!(ctx, c, &before.goal, &thalos);
	ok!(c, y < 40.0, "the stop before it is at the tunnel too");
}

fn task_unfinished(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, MULGORE);
	let take = at!(c, &list, "accept 1656 (A Task Unfinished)", is("accept", 1656));
	let hunt = at!(c, &list, "the cougar hunt (750)", |g: &V| n(g, "quest", 750.0) && !t(g, "accept") && !t(g, "turnin"));
	if !ok!(c, take < hunt, "Antur comes before the hunt") || !ok!(c, list[take].step.strict_eq(&list[hunt].step), "Antur's quest opens the hunt's step: the hunt starts at his end of the camp") {
		return;
	}
	if !eq!(c, names(&filter(&list[take + 1..hunt], |r| located(r) && everyone(r))), vec![], "the hunt follows Antur straight away") {
		return;
	}
	ok!(c, hunt < at!(c, &list, "turnin 750", is("turnin", 750)), "the hunt ends at Grull");
}

fn chill_of_death(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, TIRISFAL);
	let hand = at!(c, &list, "turnin 375 (The Chill of Death)", is("turnin", 375));
	let thread = list.iter().position(|r| r.s == list[hand].s && t(&r.goal, "buy") && n(&r.goal, "item", 2320.0));
	let Some(thread) = thread.filter(|&i| i < hand) else {
		ok!(c, false, "the turn-in step buys the thread before Gretchen");
		return;
	};
	ok!(c, n(&list[thread].goal, "npc", 2118.0), "from Abigail Shiel, Trade Supplies in Brill");
}

/// [guide, quest, item, count, vendor npc or None for `nearest` on the Horde, what]
const BUY_AT_TURNIN: [(&str, i64, f64, f64, Option<f64>, &str); 7] = [
	("forever/alliance/30-40/01-hillsbrad-foothills.guide", 555, 3713.0, 1.0, Some(2381.0), "the Soothing Spices for Chef Jessen"),
	("forever/alliance/40-50/01-stranglethorn-vale.guide", 1218, 3713.0, 3.0, Some(4897.0), "the Soothing Spices for \"Swamp Eye\" Jarl, from Theramore"),
	("forever/horde/30-40/04-dustwallow-marsh.guide", 1218, 3713.0, 3.0, None, "the Soothing Spices for \"Swamp Eye\" Jarl, bought in Ratchet in the Arathi guide"),
	(TELDRASSIL, 99050, 3371.0, 1.0, Some(3614.0), "the Empty Vial for Byancie"),
	(TELDRASSIL, 99050, 159.0, 1.0, Some(6736.0), "the Refreshing Spring Water for Byancie"),
	("forever/collectibles/mounts/alliance/paladin-charger.guide", 7645, 13724.0, 20.0, Some(10857.0), "the Enriched Manna Biscuits for Merideth Carlson, from Chillwind Camp"),
	("forever/collectibles/mounts/neutral/warlock-dreadsteed.guide", 7625, 18687.0, 1.0, Some(14522.0), "the Xorothian Stardust for Gorzeeki Wildeyes, from Ur'dan in Felwood"),
];

fn buy_name(k: usize) -> String {
	let (guide, quest, _, _, _, what) = BUY_AT_TURNIN[k];
	format!("{guide}: the same pattern as #365, {what}: asked for again on the step that hands in {quest}")
}

fn buy_at_turnin(k: usize, ctx: &Ctx, c: &mut Check) {
	let (guide, quest, item, count, vendor, _) = BUY_AT_TURNIN[k];
	let list = goals!(ctx, c, guide);
	let hand = at!(c, &list, format!("turnin {quest}"), is("turnin", quest));
	let buy = list.iter().position(|r| r.s == list[hand].s && t(&r.goal, "buy") && n(&r.goal, "item", item));
	let Some(buy) = buy.filter(|&i| i < hand) else {
		ok!(c, false, &format!("the turn-in step buys item {item} before handing in {quest}"));
		return;
	};
	let goal = &list[buy].goal;
	let have = goal.get("count");
	let have = if have.truthy() { have.num() } else { 1.0 };
	if !ok!(c, have >= count, &format!("at least the {count} the quest needs")) {
		return;
	}
	match vendor {
		None => {
			let cands = goal.get("candidates");
			if !ok!(c, cands.truthy() && !cands.is_empty(), "vendors to pick the nearest from") {
				return;
			}
			let horde = cands.items().iter().any(|v| {
				let f = v.get("faction");
				f.truthy() && (f.as_str().is_some_and(|s| s.contains('H')) || f.items().iter().any(|x| x.as_str() == Some("H")))
			});
			ok!(c, horde, "some of them sell to the Horde");
		}
		Some(v) => {
			ok!(c, n(goal, "npc", v), &format!("from npc {v}"));
		}
	}
}

fn bandarion(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, TIRISFAL);
	let keep = [246389.0, 259190.0];
	let at_keep = |g: &V| g.get("npc").as_num().is_some_and(|x| keep.contains(&x));
	let mage = filter(&list, for_class("MAGE"));
	let met: Vec<String> =
		mage.iter().filter(|r| at_keep(&r.goal)).map(|r| format!("{} {} ({})", r.goal.get("t").to_js_string(), r.goal.get("quest").to_js_string(), r.goal.get("npcName").to_js_string())).collect();
	if !eq!(c, met, vec![], "a Mage meets neither giver") {
		return;
	}
	if !eq!(c, names(&filter(&mage, |r| n(&r.goal, "quest", 99152.0) || n(&r.goal, "quest", 99153.0))), vec![], "nor any goal of their quests") {
		return;
	}
	at!(c, &mage, "collect 268801 (Bottle of Whispering Elixir)", |g: &V| t(g, "collect") && n(g, "quest", 95314.0));
	let paladin = filter(&list, for_class("PALADIN"));
	for q in [99152, 99153] {
		let take = at!(c, &paladin, format!("accept {q} for a Paladin"), is("accept", q));
		if !ok!(c, at_keep(&paladin[take].goal), &format!("a Paladin takes {q} at the keep")) {
			return;
		}
		if !ok!(c, take < at!(c, &paladin, format!("turnin {q} for a Paladin"), is("turnin", q)), &format!("{q}: accept before turn-in")) {
			return;
		}
	}
}

fn righteous_cause(ctx: &Ctx, c: &mut Check) {
	let paladin = filter(&goals!(ctx, c, TIRISFAL), for_class("PALADIN"));
	let cause = at!(c, &paladin, "turnin 96896 (A Righteous Cause)", is("turnin", 96896));
	for q in [99152, 99153] {
		let take = at!(c, &paladin, format!("accept {q}"), is("accept", q));
		if !ok!(c, cause < take, &format!("{q} is taken after A Righteous Cause is handed in")) {
			return;
		}
		let work = at!(c, &paladin, format!("the objective of {q}"), |g: &V| t(g, "collect") && n(g, "quest", q as f64));
		if !(take < work) {
			ok!(c, false, &format!("{q}: accept, objective, turn-in"));
			return;
		}
		if !ok!(c, work < at!(c, &paladin, format!("turnin {q}"), is("turnin", q)), &format!("{q}: accept, objective, turn-in")) {
			return;
		}
	}
}

fn class_letter(ctx: &Ctx, c: &mut Check) {
	const SARVIS: f64 = 1569.0;
	let all = goals!(ctx, c, TIRISFAL);
	for (cls, letter) in [("WARRIOR", 3095), ("ROGUE", 3096), ("PRIEST", 3097), ("MAGE", 3098), ("WARLOCK", 3099)] {
		let list = filter(&all, for_class(cls));
		let first = at!(c, &list, format!("accept 3901 for a {cls}"), is("accept", 3901));
		let take = at!(c, &list, format!("accept {letter} for a {cls}"), is("accept", letter));
		if !ok!(c, take > first, &format!("a {cls} takes the letter after Rattling the Rattlecages")) {
			return;
		}
		if !eq!(
			c,
			names(&filter(&list[first..take + 1], |r| !n(&r.goal, "npc", SARVIS))),
			vec![],
			&format!("nothing from another giver comes between the two accepts of a {cls}, so Sarvis's window is one visit")
		) {
			return;
		}
	}
	let warlock = filter(&all, for_class("WARLOCK"));
	let kill = warlock[at!(c, &warlock, "the skeleton kills (3901)", |g: &V| t(g, "kill") && n(g, "quest", 3901.0))].s;
	let skulls = warlock[at!(c, &warlock, "the Rattlecage Skulls (1470)", |g: &V| t(g, "collect") && n(g, "quest", 1470.0))].s;
	if !eq!(c, skulls, kill, "the skulls are collected in the step that kills the skeletons") {
		return;
	}
	let mage = filter(&all, for_class("MAGE"));
	eq!(c, names(&filter(&mage, |r| n(&r.goal, "quest", 1470.0))), vec![], "a Mage has no goal for Piercing the Veil");
}

fn light_in_darkness(ctx: &Ctx, c: &mut Check) {
	let all = goals!(ctx, c, TIRISFAL);
	for cls in ["WARRIOR", "ROGUE", "PRIEST", "MAGE", "WARLOCK", "PALADIN"] {
		let list = filter(&all, for_class(cls));
		let accept = at!(c, &list, format!("accept 98389 for a {cls}"), is("accept", 98389));
		if !ok!(c, accept > at!(c, &list, format!("turnin 376 for a {cls}"), is("turnin", 376)), &format!("a {cls} takes it after The Damned is handed in")) {
			return;
		}
		if !ok!(c, list[accept].s > list[at!(c, &list, format!("accept 3901 for a {cls}"), is("accept", 3901))].s, &format!("a {cls} is not sent to Aramis in the step that starts at Sarvis")) {
			return;
		}
		if !ok!(c, is_one(&list[accept].goal.get("pre"), 376.0), &format!("a {cls}'s accept needs The Damned")) {
			return;
		}
	}
}

fn griknir(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let griknir = at!(c, &list, "Grelin Whitebeard's Journal (Grik'nir)", |g: &V| t(g, "collect") && n(g, "item", 2004.0));
	if !ok!(c, at!(c, &list, "turnin 3364 (Scalding Mornbrew Delivery, Anvilmar)", is("turnin", 3364)) < griknir, "Anvilmar comes before Grik'nir") {
		return;
	}
	let journal = at!(c, &list, "turnin 218 (The Stolen Journal)", is("turnin", 218));
	let mug = at!(c, &list, "turnin 3365 (Bring Back the Mug)", is("turnin", 3365));
	if !ok!(c, griknir < journal && griknir < mug, "both are handed in after Grik'nir")
		|| !ok!(c, list[journal].step.strict_eq(&list[mug].step), "the journal and the mug are handed in on one visit to Grelin's camp")
	{
		return;
	}
	ok!(c, at!(c, &list, "turnin 97277 (Grund and Gozwin)", is("turnin", 97277)) < griknir, "Grund and Gozwin is handed in before the troll cave");
}

fn adventurer(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let take = at!(c, &list, "accept 96628 (The Adventurer)", is("accept", 96628));
	let thalos = at!(c, &list, "turnin 282 (Senir's Observations, Thalos)", is("turnin", 282));
	if !ok!(c, list[take].step.strict_eq(&list[thalos].step), "taken at the tunnel, on the way out of the valley") {
		return;
	}
	let give = at!(c, &list, "turnin 96628 (The Adventurer)", is("turnin", 96628));
	if !ok!(c, list[give].goal.get("npcName").as_str() == Some("Eric Brighthammer"), "turned in at Eric") {
		return;
	}
	ok!(c, give < at!(c, &list, "accept 96608 (The Great Outdoors)", is("accept", 96608)), "before The Great Outdoors, which it leads to");
}

const LETTERS: [i64; 11] = [3106, 3112, 3107, 3108, 3109, 3113, 3110, 98574, 98581, 3114, 3115];

fn sten(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let balir = at!(c, &list, "accept 170 (A New Threat, Balir)", is("accept", 170));
	if !ok!(c, at!(c, &list, "accept 233 (Coldridge Valley Mail Delivery, Sten)", is("accept", 233)) < balir, "the mail delivery before Balir") {
		return;
	}
	for q in LETTERS {
		let take = at!(c, &list, format!("accept {q} (class letter)"), is("accept", q));
		let give = at!(c, &list, format!("turnin {q} (class letter)"), is("turnin", q));
		if !ok!(c, take < balir && balir < give, &format!("letter {q}: taken from Sten before Balir, handed in inside after him"))
			|| !ok!(c, list[take].step.strict_eq(&list[balir].step), &format!("letter {q} on the same visit"))
		{
			return;
		}
	}
}

fn mornbrew(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let mornbrew = at!(c, &list, "turnin 3364 (Scalding Mornbrew Delivery)", is("turnin", 3364));
	if !eq!(c, at!(c, &list, "accept 3365 (Bring Back the Mug)", is("accept", 3365)), mornbrew + 1, "Durnan's follow-up right after the Mornbrew") {
		return;
	}
	ok!(c, mornbrew < at!(c, &list, "turnin 3361 (A Refugee's Quandary, Felix)", is("turnin", 3361)), "Felix after Durnan, at the door");
}

fn kharanos(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let eric = at!(c, &list, "turnin 96628 (The Adventurer, Eric)", is("turnin", 96628));
	let tharek = at!(c, &list, "accept 400 (Tools for Steelgrill, Tharek)", is("accept", 400));
	let tannok = at!(c, &list, "turnin 2160 (Supplies to Tannok)", is("turnin", 2160));
	if !ok!(c, eric < tharek && tharek < tannok, "Eric's campfire, then Tharek's forge, then inside") {
		return;
	}
	let inside = filter(&list, |r| r.step.strict_eq(&list[tannok].step));
	if !ok!(c, t(&inside[inside.len() - 1].goal, "train"), "class training is the last goal of the distillery visit") {
		return;
	}
	let bind = inside.iter().find(|r| t(&r.goal, "sethome"));
	ok!(c, bind.is_some_and(located), "the bind leads to the innkeeper");
}

fn camping(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let lesson = at!(c, &list, "train Cooking", |g: &V| t(g, "train") && n(g, "skillLine", 185.0));
	let camping = at!(c, &list, "turnin 96629 (Camping 101: Cooking)", is("turnin", 96629));
	if !ok!(c, lesson < camping, "Gremlock teaches Cooking before taking the quest") {
		return;
	}
	if !ok!(c, at!(c, &list, "Crag Boar Rib", |g: &V| t(g, "collect") && n(g, "item", 2886.0)) < lesson, "on the return with the ribs, not on arrival") {
		return;
	}
	let ribs = at!(c, &list, "turnin 384 (Beer Basted Boar Ribs)", is("turnin", 384));
	ok!(c, list[camping].step.strict_eq(&list[ribs].step), "on the same visit as the ribs");
}

fn talk_to(ctx: &Ctx, c: &mut Check) {
	let talks = [
		(TELDRASSIL, 96634, 1.0, "Zarrin"),
		("forever/horde/03-silverpine-forest.guide", 93739, 1.0, "Nazgrel"),
		("forever/horde/03-silverpine-forest.guide", 93739, 2.0, "Vol'jin"),
		(STONETALON, 93739, 4.0, "Lady Sylvanas Windrunner"),
		(ASHENVALE_HORDE, 93739, 3.0, "Cairne Bloodhoof"),
	];
	for (guide, quest, oi, name) in talks {
		let list = goals!(ctx, c, guide);
		let goal = &list[at!(c, &list, format!("{quest}.{oi} ({name})"), |g: &V| t(g, "kill") && n(g, "quest", quest as f64) && n(g, "oi", oi))].goal;
		if !ok!(c, goal.get("text").as_str() == Some(format!("Talk to {name}").as_str()), &format!("{guide}: {name}")) {
			return;
		}
	}
	for guide in ctx.all_guides() {
		for r in goals!(ctx, c, &guide) {
			let note = r.goal.get("note");
			if t(&r.goal, "kill")
				&& note.as_str().is_some_and(|s| s.starts_with("Speak with "))
				&& !ok!(c, r.goal.get("text").as_str().is_some_and(|s| s.starts_with("Talk to ")), &format!("{guide}: {}", note.to_js_string()))
			{
				return;
			}
		}
	}
}

fn tame(ctx: &Ctx, c: &mut Check) {
	let tames = [
		(TELDRASSIL, 6063, "Webwood Lurker"),
		(DUN_MOROGH, 6064, "Large Crag Boar"),
		(ELWYNN, 94792, "Rockhide Boar"),
		("forever/alliance/skyborne/01-zephras-isle.guide", 94978, "Windsong Crawler"),
		(MULGORE, 6061, "Adult Plainstrider"),
		(DUROTAR, 6062, "Dire Mottled Boar"),
	];
	for (guide, quest, name) in tames {
		let list = goals!(ctx, c, guide);
		let goal = &list[at!(c, &list, format!("{quest}.1 ({name})"), |g: &V| t(g, "kill") && n(g, "quest", quest as f64) && n(g, "oi", 1.0))].goal;
		if !ok!(c, goal.get("text").as_str() == Some(format!("Tame {name}").as_str()), &format!("{guide}: {name}")) {
			return;
		}
	}
	let mut seen = 0;
	for guide in ctx.all_guides() {
		for r in goals!(ctx, c, &guide) {
			let g = &r.goal;
			if !t(g, "kill") || !g.get("quest").truthy() {
				continue;
			}
			let q = ctx.data.quests.get(&g.get("quest").to_js_string());
			if q.truthy() && q.get("objectiveText").as_str().is_some_and(|s| s.contains("Taming Rod to tame")) {
				if !ok!(c, g.get("text").as_str().is_some_and(|s| s.starts_with("Tame ")), &format!("{guide}: {}.{}", g.get("quest").to_js_string(), g.get("oi").to_js_string())) {
					return;
				}
				seen += 1;
			}
		}
	}
	ok!(c, seen >= 21, &format!("the seven Hunter starting guides' 21 tames (found {seen})"));
}

fn reports(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let accept = at!(c, &list, "accept 291 (The Reports)", is("accept", 291));
	if !eq!(c, accept, at!(c, &list, "turnin 287 (Frostmane Hold)", is("turnin", 287)) + 1, "taken right after Frostmane Hold is handed in") {
		return;
	}
	let turnin = at!(c, &list, "turnin 291 (Senator Barin Redstone)", is("turnin", 291));
	if !ok!(c, turnin > accept, "handed in later") {
		return;
	}
	let tram = at!(c, &list, "goto Deeprun Tram", |g: &V| t(g, "goto") && g.get("text").as_str() == Some("Deeprun Tram"));
	ok!(c, list[turnin].step.strict_eq(&list[tram].step), "in the Deeprun Tram step");
}

fn kills_on_the_way(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let cases: [(f64, f64, fn(&V) -> bool, &str); 2] = [
		(99160.0, 276003.0, |g| t(g, "collect") && n(g, "quest", 99162.0), "Rime's Wrath's elementals, with Treacherous Cold's rifles"),
		(319.0, 1196.0, |g| t(g, "goto") && g.get("text").as_str() == Some("Frostmane Hold"), "A Favor for Evershine's bears, on the walk to Frostmane Hold"),
	];
	for (quest, npc, along, name) in cases {
		let kills: Vec<usize> = (0..list.len()).filter(|&i| (t(&list[i].goal, "kill") || t(&list[i].goal, "collect")) && n(&list[i].goal, "quest", quest) && n(&list[i].goal, "npc", npc)).collect();
		let Some(early) = kills.iter().copied().find(|&i| list[i].goal.get("optional").truthy()) else {
			ok!(c, false, &format!("{name}: an optional kill goal"));
			return;
		};
		let a = at!(c, &list, name, along);
		if !ok!(c, list[early].step.strict_eq(&list[a].step), &format!("{name}: in that step")) {
			return;
		}
		let later = kills.iter().copied().find(|&i| !list[i].goal.get("optional").truthy());
		if !ok!(c, later.is_some_and(|l| !list[l].step.strict_eq(&list[early].step) && l > early), &format!("{name}: a required kill goal in a later step finishes it")) {
			return;
		}
	}
}

fn rumbleshot(ctx: &Ctx, c: &mut Check) {
	let list = goals!(ctx, c, DUN_MOROGH);
	let loslor = at!(c, &list, "accept 5541 (Loslor Rudge)", is("accept", 5541));
	if !eq!(c, loslor, at!(c, &list, "turnin 400 (Beldin)", is("turnin", 400)) + 1, "Loslor right after Beldin") {
		return;
	}
	let hegnar = at!(c, &list, "turnin 5541 (Hegnar Rumbleshot)", is("turnin", 5541));
	ok!(c, hegnar < at!(c, &list, "turnin 98321 (Tognus Flintfire)", is("turnin", 98321)), "Hegnar before the walk back to Kharanos");
}

type F = fn(&Ctx, &mut Check);

pub fn tests() -> Vec<SeedTest> {
	let s = |n: &str| n.to_string();
	let mut v: Vec<SeedTest> = vec![
		(s("Horde Call of Fire: hand in the carried trainer lead at Kranal before starting the shared ritual"), call_of_fire),
		(s("Horde poisons: the mainline contact instructions use the supplied flare gun before saluting Fizzule"), poisons),
		(format!("{DUROTAR}: Tom's report: Cutting Teeth is turned in and Sting of the Scorpid and Galgar's Cactus Apple Surprise accepted before Sarkoth"), sarkoth),
		(format!("{DUROTAR}: tor's report: Securing the Lines is taken after the Sen'jin, Echo Isles and Kolkar Crag turn-ins, on Fizzle Darkstorm's visit"), securing),
		(format!("{TIRISFAL}: Onrevax's report: each Patience report goal names the NPC who hands it over"), patience),
		(format!("{STONETALON}: the Warsong update goals name the scouts who hand them over, from the data"), warsong),
		(format!("{DUROTAR}: Tom's report: the arrow's last waypoint before Kzan Thornslash is the Den's mouth"), kzan),
	];
	let caves: [F; 10] = [
		|x, c| cave(0, x, c),
		|x, c| cave(1, x, c),
		|x, c| cave(2, x, c),
		|x, c| cave(3, x, c),
		|x, c| cave(4, x, c),
		|x, c| cave(5, x, c),
		|x, c| cave(6, x, c),
		|x, c| cave(7, x, c),
		|x, c| cave(8, x, c),
		|x, c| cave(9, x, c),
	];
	v.extend(caves.into_iter().enumerate().map(|(k, f)| (cave_name(k), f)));
	v.extend([
		(format!("{DUROTAR}: Gruko's report (#240): Thazz'ril's Pick and Yarrog are done on one trip into the Burning Blade Coven, for every class"), gruko as F),
		(format!("{TELDRASSIL}: Dolanaar Delivery is taken from Porthannius after the Shadowglen quests, on the way out to Dolanaar"), dolanaar),
		(format!("{TELDRASSIL}: Pynte's report (#647): Teldrassil is taken from the Oracle Tree Bark on The Oracle Tree's turn-in and handed to Fandral with Crown of the Earth"), oracle_tree),
		(format!("{DUN_MOROGH}: Supplies to Tannok is taken from Hands Springsprocket at the tunnel, leaving Coldridge Valley"), tannok),
		(format!("{MULGORE}: A Task Unfinished at Antur Fallow starts the cougar hunt, with no walk back into the camp"), task_unfinished),
		(format!("{TIRISFAL}: Onrevax's report (#365): the Coarse Thread for The Chill of Death is asked for again at the turn-in, from Abigail Shiel"), chill_of_death),
	]);
	let buys: [F; 7] = [
		|x, c| buy_at_turnin(0, x, c),
		|x, c| buy_at_turnin(1, x, c),
		|x, c| buy_at_turnin(2, x, c),
		|x, c| buy_at_turnin(3, x, c),
		|x, c| buy_at_turnin(4, x, c),
		|x, c| buy_at_turnin(5, x, c),
		|x, c| buy_at_turnin(6, x, c),
	];
	v.extend(buys.into_iter().enumerate().map(|(k, f)| (buy_name(k), f)));
	v.extend([
		(format!("{TIRISFAL}: Mike_'s report: only Paladins are sent to Hilda the Breaker and Ephram Barbaro at Bandarion Keep"), bandarion as F),
		(format!("{TIRISFAL}: MadReign_Ltd's report: a Paladin takes Hilda's and Ephram's quests after A Righteous Cause is handed in"), righteous_cause),
		(
			format!("{TIRISFAL}: an3vilmonk3y's report (#345): the class letter is taken at Sarvis with Rattling the Rattlecages, and a Warlock's skulls are collected in the Rattlecage step"),
			class_letter,
		),
		(
			format!("{TIRISFAL}: an3vilmonk3y's report (#345) and Onrevax's (#120): A Light in the Darkness is taken from Aramis once The Damned is handed in, for every class, and not at Sarvis"),
			light_in_darkness,
		),
		(format!("{DUN_MOROGH}: thmastin's report: Grik'nir comes after Anvilmar, and the journal and Nori's mug are handed in on one camp visit"), griknir),
		(format!("{DUN_MOROGH}: thmastin's report: The Adventurer is taken from Thalos at the tunnel and turned in at Eric before The Great Outdoors"), adventurer),
		(format!("{DUN_MOROGH}: thmastin's report: Sten's quests and the class letter are taken before Balir, then Anvilmar is entered once"), sten),
		(format!("{DUN_MOROGH}: thmastin's report: Bring Back the Mug is taken from Durnan with the Mornbrew, before Felix"), mornbrew),
		(format!("{DUN_MOROGH}: thmastin's report: Kharanos is done outside first (Eric before Tharek), then the distillery, training last"), kharanos),
		(format!("{DUN_MOROGH}: thmastin's report: Camping 101: Cooking waits for the return to Kharanos, the lesson before the turn-in"), camping),
		(s("EpicTibbles's report (#532): an objective that is talking to someone reads \"Talk to\", not \"Kill\": Zarrin in Teldrassil and the Skyborne visits to the Horde leaders"), talk_to),
		(s("EpicTibbles's report (#565): a Hunter's Taming the Beast beast reads \"Tame\", not \"Kill\", in every guide"), tame),
		(format!("{DUN_MOROGH}: thmastin's report: The Reports is taken from Senir with Frostmane Hold and handed to the senator on the way to the tram"), reports),
		(format!("{DUN_MOROGH}: thmastin's report: kills on the way are counted on the way and finished after"), kills_on_the_way),
		(format!("{DUN_MOROGH}: thmastin's report: Ammo for Rumbleshot is taken beside Beldin and handed in before the walk back to Kharanos"), rumbleshot),
	]);
	v
}
