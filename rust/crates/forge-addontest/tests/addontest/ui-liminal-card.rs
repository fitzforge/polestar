//! The Liminal Passage heads-up (addon/Polestar/UI/LiminalCard.lua, #4341): the card for the scroll's two offers on the
//! guide window's card, each told once, and the setting. The whole addon on the stub world; the offers are the ones
//! Nav/LiminalScroll.lua hands on (nav-liminal-scroll.rs finds them), the auctioneer is the auction house reminder's
//! stand-in.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK};
use serde_json::{json, Value};

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/li", pack = "test", title = "Errands", minLevel = 30, maxLevel = 45, zone = 1411,
	steps = { { title = "Go", goals = { { t = "goto", map = 1411, x = 50, y = 50 } } } },
})
"#;

const PRELUDE: &str = r#"
local w = stub.world
local E, CT, LC, AU = Polestar.Engine, Polestar.UI.ClassToast, Polestar.UI.LiminalCard, Polestar.UI.AuctionBuys
local auction = { map = 1454, name = "Auctioneer" }
AU.AuctioneerHere = function() return auction end
local use = { kind = "use", member = "Ana", inn = "Everlook", saves = 900, seconds = 60, target = { label = "Kobolds" } }
local need = { kind = "need", base = 900, target = { label = "Kobolds" } }
function card()
	local m = CT.current
	if not m then return false end
	local row = {}
	for i, s in ipairs(m.spells or {}) do row[i] = s.item .. "x" .. (s.count or 1) end
	return { kind = m.kind, title = m.title, lines = m.giver, route = m.route, row = row,
		act = m.act and m.act.label or false, off = m.off and m.off.label or false, noAct = m.noAct or false }
end
E.SetGuide("test/li")
stub.advance(5)
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		script: format!("{TEST_PACK}\n{GUIDE}\nstub.login()\nstub.advance(0.5)\n{PRELUDE}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_use_card_names_the_member_the_inn_and_the_saving_and_is_told_once() {
	let out = run(r#"
		local r = {}
		w.addItem(213548, 3)
		Polestar.Fire("LIMINAL_OFFER", use)
		r.card = card()
		CT.Hide()
		Polestar.Fire("LIMINAL_OFFER", use)
		r.again = card()
		use.target = { label = "Another goal" }
		Polestar.Fire("LIMINAL_OFFER", use)
		r.otherGoal = card() and card().kind
		emit(r)"#);
	assert_eq!(
		out["card"],
		json!({
			"kind": "liminal", "title": "Use a Scroll of Liminal Passage",
			"lines": "Ana rests at Everlook. The scroll takes you there and saves about 15m on this trip.",
			"route": "You and your party member must both rest in an inn or a city, out of combat.",
			"row": ["213548x3"], "act": false, "off": "Turn these off", "noAct": true
		})
	);
	assert_eq!(out["again"], json!(false), "once per member and goal");
	assert_eq!(out["otherGoal"], "liminal");
}

#[test]
fn the_buy_card_shows_in_a_town_with_an_auction_house_once_per_visit() {
	let out = run(r#"
		local r = {}
		Polestar.Fire("LIMINAL_OFFER", need)
		r.card = card()
		CT.Hide()
		Polestar.Fire("LIMINAL_OFFER", need)
		r.sameVisit = card()
		auction = nil
		Polestar.Fire("LIMINAL_OFFER", need)
		r.outside = card()
		auction = { map = 1454, name = "Auctioneer" }
		Polestar.Fire("LIMINAL_OFFER", need)
		r.nextVisit = card() and card().kind
		emit(r)"#);
	assert_eq!(out["card"]["title"], "Buy Scrolls of Liminal Passage");
	assert_eq!(out["card"]["act"], "Show me the auctioneer");
	assert_eq!(out["card"]["row"], json!(["213548x0"]));
	assert_eq!(out["sameVisit"], json!(false));
	assert_eq!(out["outside"], json!(false), "no auction house here: nothing to show");
	assert_eq!(out["nextVisit"], "liminal", "left the town and came back");
}

#[test]
fn nothing_shows_in_combat_over_another_heads_up_or_after_the_offer_goes() {
	let out = run(r#"
		local r = {}
		stub.inCombat = true
		Polestar.Fire("LIMINAL_OFFER", use)
		r.combat = card()
		stub.inCombat = false
		CT.ShowCard({ kind = "other", title = "Other", head = "OTHER", icon = LC.ICON })
		Polestar.Fire("LIMINAL_OFFER", use)
		r.other = card().kind
		CT.Hide()
		Polestar.Fire("LIMINAL_OFFER", use)
		r.shown = card().kind
		Polestar.Fire("LIMINAL_OFFER", nil)
		r.gone = card()
		emit(r)"#);
	assert_eq!(out["combat"], json!(false));
	assert_eq!(out["other"], "other", "the other heads-up keeps the card");
	assert_eq!(out["shown"], "liminal");
	assert_eq!(out["gone"], json!(false), "the offer is gone: so is its card");
}

#[test]
fn turn_these_off_sets_the_setting_off() {
	let out = run(r#"
		Polestar.Fire("LIMINAL_OFFER", use)
		CT.current.off.run()
		emit({ off = Polestar.Get("nav.liminalScroll") })"#);
	assert_eq!(out["off"], false);
}
