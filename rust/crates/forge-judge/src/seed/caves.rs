//! tests/guides-caves.test.js: the arrow leads to the cave's mouth before a target inside a cave or mine,
//! and the step's tip says the target is underground.

use forge_guide::js::V;

use crate::seed::{Check, Ctx, Row, SeedTest};

/// One player report: the guide, the target goal (item collected), the mouth, and what the tip says.
struct Case {
	guide: &'static str,
	item: f64,
	mouth: (f64, f64, f64),
	mouth_text: &'static str,
	tip: &'static str,
}

const CASES: [Case; 5] = [
	// Verium: the arrow sent him onto the hill above the Fargodeep Mine (Bernice's Necklace, from Goldtooth).
	Case { guide: "forever/alliance/human/01-elwynn-forest.guide", item: 981.0, mouth: (1429.0, 39.5, 82.4), mouth_text: "39.5,82.4", tip: "inside the Fargodeep Mine" },
	// Mightie: the Sapphires of Aku'Mai are in the tunnels to the Blackfathom Deeps portal, not on the strand.
	Case { guide: "forever/horde/07-ashenvale.guide", item: 16784.0, mouth: (1440.0, 14.5, 14.2), mouth_text: "14.5,14.2", tip: "tunnels leading to the Blackfathom Deeps portal" },
	// Turesh: in Coldridge Valley the arrow pointed above ground, at Grik'nir inside the troll cave.
	Case { guide: "forever/alliance/dwarf-gnome/01-dun-morogh.guide", item: 2004.0, mouth: (1426.0, 26.93, 80.03), mouth_text: "26.93,80.03", tip: "inside the troll cave" },
	// Onrevax (#392): the Whispering Elixir bottles are in the basement under Shadowvale's ruined house.
	Case { guide: "forever/horde/undead/01-tirisfal-glades.guide", item: 268801.0, mouth: (1420.0, 12.9, 65.7), mouth_text: "12.9,65.7", tip: "basement under the ruined house" },
	// The same basement: a Paladin's Faintly Glowing Bones drop from its Lurchers and Mystics.
	Case { guide: "forever/horde/undead/01-tirisfal-glades.guide", item: 286259.0, mouth: (1420.0, 12.9, 65.7), mouth_text: "12.9,65.7", tip: "basement under the ruined house" },
];

fn name(i: usize) -> String {
	format!("{}: the arrow reaches the target through the cave mouth at {}", CASES[i].guide, CASES[i].mouth_text)
}

pub fn tests() -> Vec<SeedTest> {
	vec![(name(0), |ctx, c| cave(ctx, c, 0)), (name(1), |ctx, c| cave(ctx, c, 1)), (name(2), |ctx, c| cave(ctx, c, 2)), (name(3), |ctx, c| cave(ctx, c, 3)), (name(4), |ctx, c| cave(ctx, c, 4))]
}

fn cave(ctx: &Ctx, c: &mut Check, i: usize) {
	let case = &CASES[i];
	if ctx.compiled(case.guide).is_undef() {
		c.ok(false, &format!("{} compiles", case.guide));
		return;
	}
	let goals = ctx.goals(case.guide);
	let target = goals.iter().position(|r| r.goal.get("t").as_str() == Some("collect") && r.goal.get("item").as_num() == Some(case.item));
	let Some(at) = target.filter(|&a| a > 0) else {
		c.ok(false, "the target goal is in the guide");
		return;
	};
	// (Other work of the target's own step, done in the same basement after the mouth's goto, is not a
	// waypoint on the way in: the Shadowvale step's bottles before a Paladin's bones.)
	let same_step = |r: &Row| r.s == goals[at].s;
	let Some(before) = goals[..at].iter().rev().find(|r| !r.goal.get("map").is_nullish() && !r.goal.get("x").is_nullish() && (!same_step(r) || r.goal.get("t").as_str() == Some("goto"))) else {
		c.ok(false, "a located goal comes before the target");
		return;
	};
	let g = &before.goal;
	let (map, x, y) = case.mouth;
	let same = g.get("t").as_str() == Some("goto") && g.get("map").strict_eq(&V::Num(map)) && g.get("x").strict_eq(&V::Num(x)) && g.get("y").strict_eq(&V::Num(y));
	if !c.ok(
		same,
		&format!(
			"the waypoint before \"{}\" is the mouth (got {} {} {},{})",
			goals[at].step.get("title").to_js_string(),
			g.get("t").to_js_string(),
			g.get("map").to_js_string(),
			g.get("x").to_js_string(),
			g.get("y").to_js_string()
		),
	) {
		return;
	}
	let note = goals[at].step.get("note");
	let note = if note.truthy() { note.to_js_string() } else { String::new() };
	c.ok(note.contains(case.tip), &format!("the step's tip says: {}", case.tip));
}
