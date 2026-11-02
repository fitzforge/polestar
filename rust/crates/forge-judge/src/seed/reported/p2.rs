//! Part of tests/guides-reported.test.js (see reported.rs): lines 559-1146, without the tests that play
//! the guide in the addon (those are in eng.rs).

#[allow(unused_imports)]
use crate::seed::{at, everyone, for_class, is, located, Check, Ctx, Row, SeedTest};
use forge_guide::js::V;

const DUROTAR: &str = "forever/horde/orc-troll/01-durotar.guide";
const DUN_MOROGH: &str = "forever/alliance/dwarf-gnome/01-dun-morogh.guide";
const TELDRASSIL: &str = "forever/alliance/nightelf/01-teldrassil.guide";
const MULGORE: &str = "forever/horde/tauren/01-mulgore.guide";
const TIRISFAL: &str = "forever/horde/undead/01-tirisfal-glades.guide";
const BARRENS: &str = "forever/horde/04-the-barrens.guide";
const WESTFALL: &str = "forever/alliance/02-westfall.guide";
const REDRIDGE: &str = "forever/alliance/04-redridge-mountains.guide";
const HILLSBRAD_HORDE: &str = "forever/horde/06-hillsbrad-foothills.guide";
const SILVERPINE: &str = "forever/horde/03-silverpine-forest.guide";
const HILLSBRAD_ALLIANCE: &str = "forever/alliance/30-40/01-hillsbrad-foothills.guide";
const ASHENVALE_30: &str = "forever/alliance/30-40/03-ashenvale.guide";
const ARATHI: &str = "forever/alliance/30-40/05-arathi-highlands.guide";
const DARKSHORE: &str = "forever/alliance/03-darkshore.guide";
const THOUSAND_NEEDLES: &str = "forever/alliance/07-thousand-needles.guide";
const BADLANDS: &str = "forever/alliance/30-40/06-badlands.guide";
const STRANGLETHORN_HORDE: &str = "forever/horde/30-40/02-stranglethorn-vale.guide";
const TANARIS_ALLIANCE: &str = "forever/alliance/40-50/04-tanaris.guide";
const UN_GORO_ALLIANCE: &str = "forever/alliance/40-50/07-un-goro-crater.guide";
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest.guide";
const ZEPHRAS_ALLIANCE: &str = "forever/alliance/skyborne/01-zephras-isle.guide";
const ZEPHRAS_HORDE: &str = "forever/horde/skyborne/01-zephras-isle.guide";
const NEEDLES: &str = "forever/alliance/07-thousand-needles.guide";

/// `at(...)`, returning from the test when absent (the JS assertion throws).
macro_rules! at {
	($c:expr, $list:expr, $what:expr, $pred:expr) => {
		match at($c, &$list, &$what, $pred) {
			Some(i) => i,
			None => return,
		}
	};
}

fn num(g: &V, k: &str) -> Option<f64> {
	g.get(k).as_num()
}
fn t_is(g: &V, t: &str) -> bool {
	g.get("t").as_str() == Some(t)
}
fn item_goal(t: &'static str, item: i64) -> impl Fn(&V) -> bool {
	move |g: &V| t_is(g, t) && num(g, "item") == Some(item as f64)
}
fn quest_goal(t: &'static str, q: i64) -> impl Fn(&V) -> bool {
	move |g: &V| t_is(g, t) && num(g, "quest") == Some(q as f64)
}
fn find(list: &[Row], pred: impl Fn(&V) -> bool) -> Option<usize> {
	list.iter().position(|r| pred(&r.goal))
}

fn gretchen(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(DUN_MOROGH);
	let shipments = at!(c, list, "Flintfire's Shipment", item_goal("collect", 280413));
	let a = at!(c, list, "accept 98319 (Secure the Mountain, Gretchen)", is("accept", 98319));
	c.ok(a < shipments, "Gretchen before the den");
	let k = at!(c, list, "complete 98319 (Cornelius)", is("complete", 98319));
	c.eq(list[k].s, list[shipments].s, "Cornelius on the same trip");
}

fn brewnall(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(DUN_MOROGH);
	let rejold = at!(c, list, "turnin 318 (Evershine, Rejold)", is("turnin", 318));
	let first = list.iter().find(|r| r.s == list[rejold].s).unwrap();
	c.eq((first.goal.get("t").as_str(), num(&first.goal, "quest")), (Some("accept"), Some(98326.0)), "Gretta's Frosthowl first");
	let a = at!(c, list, "accept 319 (A Favor for Evershine)", is("accept", 319));
	let h = at!(c, list, "Frostmane Headhunter", |g: &V| t_is(g, "kill") && g.get("target").as_str() == Some("Frostmane Headhunter"));
	c.ok(a < h, "Evershine's animals are in the log on the way to the Hold");
}

fn argent_emissary(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TIRISFAL);
	let a = at!(c, list, "accept 96895 (The Argent Emissary)", is("accept", 96895));
	let g = &list[a].goal;
	c.eq((num(g, "map"), num(g, "x"), num(g, "y")), (Some(1420.0), Some(61.4), Some(53.4)), "Deathguard Terrence");
}

fn priest_event(ctx: &Ctx, c: &mut Check) {
	for (guide, quest) in [(TIRISFAL, 99134), (TIRISFAL, 99144), (DUROTAR, 99123), (TELDRASSIL, 99053)] {
		let list = ctx.goals(guide);
		let a = at!(c, list, format!("{guide}: accept {quest}"), is("accept", quest));
		let k = at!(c, list, format!("{guide}: complete {quest}"), is("complete", quest));
		let t = at!(c, list, format!("{guide}: turnin {quest}"), is("turnin", quest));
		c.ok(a < k && k < t, &format!("{guide}: {quest} is completed between its accept and its turn-in"));
	}
}

/// #735: the Webbed Forsaken are freed by attacking their cocoons: a kill goal of the cocoon NPC named for
/// what the game counts, not a bare `complete`.
fn webbed_forsaken(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TIRISFAL);
	let a = at!(c, list, "accept 98389", is("accept", 98389));
	let k = at!(c, list, "kill 271961 quest 98389.1", |g: &V| g.get("t").as_str() == Some("kill") && num(g, "quest") == Some(98389.0) && num(g, "npc") == Some(271961.0));
	let t = at!(c, list, "turnin 98389", is("turnin", 98389));
	c.ok(a < k && k < t, "freed between the accept and the turn-in");
	c.eq(list[k].goal.get("text").as_str(), Some("Free the Webbed Forsaken"), "the goal says what to do");
	c.ok(!list.iter().any(|r| is("complete", 98389)(&r.goal)), "no bare complete");
}

/// #743: every Camping 101: Cooking is done by learning Cooking from the quest's own trainer, before the
/// hand-in: a `train Cooking` there, never "ask him about cooking".
fn camping_cooking(ctx: &Ctx, c: &mut Check) {
	for (guide, quest, trainer) in [
		(DUN_MOROGH, 96629, 1699.0),
		(ELWYNN, 96626, 1430.0),
		(TELDRASSIL, 96634, 6286.0),
		(ZEPHRAS_ALLIANCE, 96646, 251905.0),
		(ZEPHRAS_HORDE, 96646, 251905.0),
		(DUROTAR, 96655, 3191.0),
		(MULGORE, 96661, 3067.0),
		(TIRISFAL, 96658, 265944.0),
	] {
		let list = ctx.goals(guide);
		let a = at!(c, list, format!("{guide}: accept {quest}"), is("accept", quest));
		let tr = at!(c, list, format!("{guide}: train Cooking at npc {trainer}"), |g: &V| g.get("t").as_str() == Some("train") && num(g, "skillLine") == Some(185.0) && num(g, "npc") == Some(trainer));
		let t = at!(c, list, format!("{guide}: turnin {quest}"), is("turnin", quest));
		c.ok(a < tr && tr < t, &format!("{guide}: Cooking is learnt between the accept of {quest} and its turn-in"));
		c.ok(!list.iter().any(|r| r.goal.get("t").as_str() == Some("kill") && num(&r.goal, "quest") == Some(quest as f64)), &format!("{guide}: {quest} has no kill or talk goal"));
	}
}

fn hotline_paladin(ctx: &Ctx, c: &mut Check) {
	let list: Vec<Row> = ctx.goals(TIRISFAL).into_iter().filter(for_class("PALADIN")).collect();
	let a = at!(c, list, "accept 90902", is("accept", 90902));
	let k = at!(c, list, "complete 90902", is("complete", 90902));
	let t = at!(c, list, "turnin 90902", is("turnin", 90902));
	c.ok(a < k && k < t, "healing comes between the accept and the turn-in");
	let s = list[k].s;
	c.ok(list.iter().any(|r| r.s == s && t_is(&r.goal, "goto") && located(r)), "the healing step leads to the Injured Deathguard");
}

fn recipe_kaldorei(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TELDRASSIL);
	let take = at!(c, list, "accept 4161", is("accept", 4161));
	c.eq(list[take].goal.get("profName").as_str(), Some("Cooking"), "4161 needs Cooking");
	let l = at!(c, list, "turnin 96634 (Camping 101: Cooking)", is("turnin", 96634));
	c.ok(l < take, "4161 after the cooking lesson");
	let tr = at!(c, list, "train Cooking", |g: &V| t_is(g, "train") && num(g, "skillLine") == Some(185.0));
	c.ok(tr < take, "4161 after training Cooking");
}

fn walton_vrang(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(BARRENS);
	let mut order = Vec::new();
	for (t, q) in [
		("accept", 95494),
		("accept", 95507),
		("turnin", 95494),
		("turnin", 95507),
		("accept", 95495),
		("turnin", 95495),
		("accept", 95621),
		("turnin", 95621),
		("accept", 95508),
		("complete", 95508),
		("turnin", 95508),
	] {
		order.push(at!(c, list, format!("{t} {q}"), quest_goal(t, q)));
	}
	let mut sorted = order.clone();
	sorted.sort();
	c.eq(order, sorted, "each goal comes after the one before it in the chain");
}

fn miguel(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(BARRENS);
	let carcass = at!(c, list, "collect 10338 (Fresh Zhevra Carcass)", item_goal("collect", 10338));
	let us = at!(c, list, "use 10338 (at the Dead Tree)", item_goal("use", 10338));
	let fang = at!(c, list, "collect 5101 (Ishamuhale's Fang)", item_goal("collect", 5101));
	c.ok(carcass < us && us < fang, "carcass, then the tree, then the Fang");
	let tree = V::obj();
	tree.set("map", 1413.0);
	tree.set("x", 59.95);
	tree.set("y", 30.21);
	let Some(d) = ctx.yards(&list[us].goal, &tree) else {
		c.ok(false, "points on one map with an Era frame");
		return;
	};
	c.ok(d <= 20.0, &format!("the carcass is used at the Dead Tree, not {} yd off", d.round()));
}

fn follow_ups(ctx: &Ctx, c: &mut Check) {
	let cases: &[(&str, i64, &[i64], bool)] = &[
		(MULGORE, 99081, &[99079], false),
		(MULGORE, 99101, &[99081], false),
		(MULGORE, 99080, &[99101], false),
		(MULGORE, 99082, &[99080], false),
		(MULGORE, 98435, &[760], false),
		(TIRISFAL, 96899, &[96897, 96898], false),
		(TIRISFAL, 99156, &[356], true),
		(REDRIDGE, 98386, &[89], false),
		(WESTFALL, 92745, &[92742], false),
		(HILLSBRAD_HORDE, 98094, &[528], false),
		(SILVERPINE, 91920, &[430], false),
		(SILVERPINE, 91921, &[91920], true),
		(HILLSBRAD_ALLIANCE, 98209, &[98208], true),
		(HILLSBRAD_ALLIANCE, 88758, &[88757], true),
		(HILLSBRAD_ALLIANCE, 98297, &[98291], true),
		(ASHENVALE_30, 98418, &[98417], true),
		(ARATHI, 92459, &[92458], true),
		(DARKSHORE, 87760, &[4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733], false),
		(SILVERPINE, 425, &[91921], false),
		(SILVERPINE, 98298, &[99], true),
		(WESTFALL, 92911, &[92910], true),
		(THOUSAND_NEEDLES, 98221, &[464], false),
		(THOUSAND_NEEDLES, 465, &[98221], false),
	];
	for &(guide, quest, after, optional) in cases {
		let list = ctx.goals(guide);
		let take = find(&list, is("accept", quest));
		if take.is_none() && optional {
			continue;
		}
		if !c.ok(take.is_some(), &format!("{guide}: accept {quest} is in the guide")) {
			return;
		}
		let take = take.unwrap();
		for &pre in after {
			let p = at!(c, list, format!("{guide}: turnin {pre}"), is("turnin", pre));
			c.ok(p < take, &format!("{guide}: {quest} is taken after {pre} is handed in"));
		}
	}
}

fn stop_the_spread(ctx: &Ctx, c: &mut Check) {
	for guide in ctx.all_guides() {
		let asked: Vec<String> = ctx.goals(&guide).iter().filter(|r| num(&r.goal, "quest") == Some(98299.0)).map(|r| r.goal.get("t").to_js_string()).collect();
		if !c.eq(asked, vec![], &format!("{guide} has no goal for 98299")) {
			return;
		}
	}
}

fn lou_saydus(ctx: &Ctx, c: &mut Check) {
	let needles = ctx.goals(THOUSAND_NEEDLES);
	c.eq(find(&needles, is("turnin", 465)), None, "the catapult is not lit in the guide that takes the quest");
	let done = at!(c, needles, "complete 98221", is("complete", 98221));
	c.ok(located(&needles[done]), "the attack plans have a place");
	let list = ctx.goals(HILLSBRAD_ALLIANCE);
	c.eq(find(&list, is("accept", 98221)), None, "From the Ashes is not taken again");
	let lit = at!(c, list, "turnin 465", is("turnin", 465));
	let h = at!(c, list, "turnin 98230", is("turnin", 98230));
	c.ok(h < lit, "after Howin");
	let b = at!(c, list, "accept 98223", is("accept", 98223));
	c.ok(lit < b, "before the Tattered Spellbook");
}

fn alba(ctx: &Ctx, c: &mut Check) {
	let chain = [92742.0, 92744.0, 92745.0, 92747.0, 92748.0];
	let list: Vec<Row> = ctx.goals(WESTFALL).into_iter().filter(|r| num(&r.goal, "quest").is_some_and(|q| chain.contains(&q))).collect();
	if !c.ok(!list.is_empty(), "the chain is in the guide") {
		return;
	}
	for r in &list {
		let races: Vec<V> = [r.step.get("only"), r.goal.get("only")].iter().filter(|o| o.truthy()).flat_map(|o| o.get("races").items()).collect();
		if !c.ok(
			!races.is_empty() && !races.iter().any(|x| x.as_str() == Some("Human")),
			&format!("{} {} is for its races only, not Humans", r.goal.get("t").to_js_string(), r.goal.get("quest").to_js_string()),
		) {
			return;
		}
	}
}

fn xoove_beached(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(DARKSHORE);
	let take = at!(c, list, "accept 4723 (Beached Sea Creature)", is("accept", 4723));
	c.eq(list[take].step.get("title").as_str(), Some("Bashal'Aran"), "it is taken in the Bashal'Aran step");
	let a = at!(c, list, "accept 957 (Asterion)", is("accept", 957));
	c.ok(a < take, "after Asterion");
	let b = at!(c, list, "turnin 1001 (Buzzbox 411)", is("turnin", 1001));
	c.ok(take < b, "before Buzzbox 411");
	let hand_in = at!(c, list, "turnin 4723", is("turnin", 4723));
	let t4722 = at!(c, list, "turnin 4722", is("turnin", 4722));
	c.eq(list[hand_in].s, list[t4722].s, "handed in with 4722");
	let a4728 = at!(c, list, "accept 4728", is("accept", 4728));
	c.ok(hand_in < a4728, "before the second loop");
}

fn pynte_zenn(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TELDRASSIL);
	let take = at!(c, list, "accept 488 (Zenn's Bidding)", is("accept", 488));
	let p = at!(c, list, "accept 2159 (Porthannius, leaving Shadowglen)", is("accept", 2159));
	c.ok(p < take, "after Porthannius");
	let d = at!(c, list, "turnin 96630 (Lyreena Duskblade in Dolanaar)", is("turnin", 96630));
	c.ok(take < d, "before the first Dolanaar stop");
}

fn badlands(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(BADLANDS);
	let take = at!(c, list, "accept 6027 (Book of the Ancients)", is("accept", 6027));
	let a = at!(c, list, "accept 1454 (Nijel's Point)", is("accept", 1454));
	c.ok(a < take, "after Nijel's Point");
	let b = at!(c, list, "turnin 1454 (Karnitol's Chest)", is("turnin", 1454));
	c.ok(take < b, "before the chest");
}

fn giver_already(ctx: &Ctx, c: &mut Check) {
	// (Each case: the quest, and the goals of a step at its giver the route stands at, any one of which
	// may hold its accept. Simmer stands beside Calvin at Solliden, so Fields of Grief is taken at
	// either pass by him: Calvin's duel, or the letter on the walk in from Deathknell, RevUndead c13.)
	for (guide, quest, with) in [
		(TIRISFAL, 365, &[("accept", 590, "Calvin's duel at Solliden"), ("accept", 8, "Calvin's letter on the walk in from Deathknell")][..]),
		(TANARIS_ALLIANCE, 2781, &[("accept", 2875, "Andre Firebeard's poster at Steamwheedle Port")][..]),
		(STRANGLETHORN_HORDE, 192, &[("turnin", 191, "Panther Mastery's second turn-in")][..]),
	] {
		let list = ctx.goals(guide);
		let take = at!(c, list, format!("{guide}: accept {quest}"), is("accept", quest));
		let at_steps: Vec<usize> = with.iter().filter_map(|&(wt, wq, _)| list.iter().position(|r| quest_goal(wt, wq)(&r.goal)).map(|w| list[w].s)).collect();
		let what = with.iter().map(|w| w.2).collect::<Vec<_>>().join(" or ");
		if !c.ok(!at_steps.is_empty(), &format!("{guide}: {what} is in the guide")) {
			return;
		}
		c.ok(at_steps.contains(&list[take].s), &format!("{guide}: {quest} is taken at {what}"));
	}
}

fn objectives_between(ctx: &Ctx, c: &mut Check) {
	for (guide, quest, t, count) in [(MULGORE, 96661, "complete", 1), (DUN_MOROGH, 96629, "complete", 1), (UN_GORO_ALLIANCE, 3845, "collect", 3)] {
		let list = ctx.goals(guide);
		let a = at!(c, list, format!("{guide}: accept {quest}"), is("accept", quest));
		let tu = at!(c, list, format!("{guide}: turnin {quest}"), is("turnin", quest));
		let between = list.get(a + 1..tu).unwrap_or(&[]).iter().filter(|r| quest_goal(t, quest)(&r.goal)).count();
		if !c.eq(between, count, &format!("{guide}: {count} {t} goal(s) for {quest} between its accept and its turn-in")) {
			return;
		}
	}
}

fn ilthalaine(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TELDRASSIL);
	let il = at!(c, list, "accept 456 (The Balance of Nature)", is("accept", 456));
	let me = at!(c, list, "accept 458 (The Woodland Protector)", is("accept", 458));
	c.eq(list[il].s, 1, "taken in the opening step");
	c.ok(il < me, "Ilthalaine before Melithar");
	let Some(first) = list.iter().find(|r| located(r)) else {
		c.ok(false, "a located goal");
		return;
	};
	c.eq(num(&first.goal, "npc"), Some(2079.0), "the arrow first leads to Conservator Ilthalaine");
}

fn sigils(ctx: &Ctx, c: &mut Check) {
	for (quest, cls) in [(3116, "WARRIOR"), (3117, "HUNTER"), (3118, "ROGUE"), (3119, "PRIEST"), (3120, "DRUID")] {
		let list: Vec<Row> = ctx.goals(TELDRASSIL).into_iter().filter(for_class(cls)).collect();
		let take = at!(c, list, format!("accept {quest} ({cls})"), is("accept", quest));
		let give = at!(c, list, format!("turnin {quest} ({cls})"), is("turnin", quest));
		let b = at!(c, list, "turnin 456 (The Balance of Nature)", is("turnin", 456));
		if !c.ok(b < take, &format!("{cls}: the sigil is taken once The Balance of Nature is handed in")) {
			return;
		}
		let sacs = at!(c, list, "Webwood Venom Sacs (916)", quest_goal("collect", 916));
		if !c.ok(take < sacs, &format!("{cls}: taken before the cave")) {
			return;
		}
		let w = at!(c, list, "turnin 916 (Webwood Venom)", is("turnin", 916));
		if !c.ok(w < give, &format!("{cls}: handed in after the cave")) {
			return;
		}
		let class_train = |r: &Row| t_is(&r.goal, "train") && r.goal.get("class").truthy();
		let train = list.iter().enumerate().position(|(i, r)| i > give && class_train(r));
		if !c.ok(train.is_some_and(|t| t > give && list[t].s == list[give].s), &format!("{cls}: handed in on the training stop, before the training")) {
			return;
		}
		if !c.ok(!list.get(take..give).unwrap_or(&[]).iter().any(class_train), &format!("{cls}: no class training between the sigil's accept and its turn-in")) {
			return;
		}
	}
}

fn escaping_banethil(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TELDRASSIL);
	let escort = at!(c, list, "accept 99053 (Escaping Ban'ethil)", is("accept", 99053));
	let a = at!(c, list, "accept 2541 (The Sleeping Druid)", is("accept", 2541));
	c.ok(a < escort, "The Sleeping Druid is taken first");
	let b = at!(c, list, "turnin 2561 (Druid of the Claw)", is("turnin", 2561));
	c.ok(b < escort, "the chain is handed in before the escort");
	for item in [3405, 3406, 3407, 3408] {
		let r = at!(c, list, format!("relic {item}"), item_goal("collect", item));
		c.ok(r < escort, &format!("relic {item} before the escort"));
	}
	let k = at!(c, list, "complete 99053", is("complete", 99053));
	c.ok(escort < k, "taken before the walk out");
}

fn bronze_tube(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(NEEDLES);
	let give = at!(c, list, "turnin 174 (Look to the Stars)", is("turnin", 174));
	let buy = at!(c, list, "buy 4371 (Bronze Tube)", item_goal("buy", 4371));
	c.ok(buy < give && list[buy].s == list[give].s, "bought on the same stop, before the turn-in");
	c.eq(num(&list[buy].goal, "npc"), Some(3133.0), "from Herble Baubbletump, beside Viktori");
	c.ok(list[buy].goal.get("optional").strict_eq(&V::Bool(true)), "the buy is optional");
}

pub fn tests() -> Vec<SeedTest> {
	let t = |n: String, f: fn(&Ctx, &mut Check)| (n, f);
	vec![
		t(format!("{DUN_MOROGH}: thmastin's report: Gretchen comes first and the Grizzled Den is walked once for the shipments and Cornelius"), gretchen),
		t(format!("{DUN_MOROGH}: thmastin's report: at Brewnall Gretta's dock comes first, and the village before Frostmane Hold"), brewnall),
		t(format!("{TIRISFAL}: Pledge-Resupply's report: The Argent Emissary points to Deathguard Terrence at 61.4,53.4"), argent_emissary),
		t("a Priest's report: an event or escort objective holds its step until the quest is complete".into(), priest_event),
		t(format!("{TIRISFAL}: Fitz's report (#735): A Light in the Darkness says to free the Webbed Forsaken, a kill goal of the cocoons"), webbed_forsaken),
		t("Fitz's report (#743): every Camping 101: Cooking trains Cooking at the quest's trainer before the hand-in".into(), camping_cooking),
		t("Hotline's report: a Paladin heals the Injured Deathguard before turning in Rediscovering the Light".into(), hotline_paladin),
		t(format!("{TELDRASSIL}: Recipe of the Kaldorei is taken after the guide teaches Cooking"), recipe_kaldorei),
		t("Hotline's report: Walton and Vrang's quests come in the order the game offers them".into(), walton_vrang),
		t(format!("{BARRENS}: Miguel Antunes's report (#592): loot a zhevra carcass and use it at the Dead Tree before Ishamuhale's Fang"), miguel),
		t("Forever follow-ups are taken only once the quests before them are handed in".into(), follow_ups),
		t("Rupert's and Wyatt R's reports: no guide sends you to Dalar Dawnweaver or the refugees for Stop the Spread (#229, #161)".into(), stop_the_spread),
		t(format!("{HILLSBRAD_ALLIANCE}: Lou-Saydus's report: Nek'rosh's Gambit, taken after From the Ashes in {THOUSAND_NEEDLES}, is handed in on the Wetlands loop (#225)"), lou_saydus),
		t(format!("{WESTFALL}: Alba Fairmoon's chain is not given to Humans (#144)"), alba),
		t(format!("{DARKSHORE}: XooVe's report: the Beached Sea Creature by Bashal'Aran is taken on the walk from Asterion to Buzzbox 411 (#213)"), xoove_beached),
		t(format!("{TELDRASSIL}: Pynte's report: Zenn's Bidding is taken on the walk down to Dolanaar that passes Zenn (#89)"), pynte_zenn),
		t(format!("{BADLANDS}: the same pattern as #89: Book of the Ancients is taken from Azore on the way to Karnitol's Chest, not on a walk back from it"), badlands),
		t("#213: quests whose giver the route already stands at are taken there, not on a walk back".into(), giver_already),
		t("a quest with objectives is completed or collected between its accept and its turn-in".into(), objectives_between),
		t(format!("{TELDRASSIL}: Pynte's report: Conservator Ilthalaine's quest is taken before Melithar's"), ilthalaine),
		t(format!("{TELDRASSIL}: Pynte's report: each class's sigil is handed to its trainer at the training stop after Shadowthread Cave"), sigils),
		t(format!("{TELDRASSIL}: Pynte's report: Escaping Ban'ethil is taken after the relics and The Sleeping Druid's chain (#334)"), escaping_banethil),
		t(format!("{NEEDLES}: Yendi's report: Herble's Bronze Tube is offered before Look to the Stars is handed in, without holding the step"), bronze_tube),
	]
}
