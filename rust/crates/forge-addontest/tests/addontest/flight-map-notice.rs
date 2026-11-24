//! The flight map notice (#1795, #2189; addon/Polestar/UI/GuideFrameBanner.lua's `taxiMap`): on a continent where no
//! flight map has opened yet for the character, Polestar can't tell the flight paths it has from those it lacks, so
//! once the route flies from, through or to a flight master the character may have there, the guide window's banner
//! asks for any flight master's map there, once. It goes when a flight map opens there; closed, it stays closed on that
//! continent for good. Runs the real Core, Theme and UI against stub_ui.lua, as riding.rs does; Nav is faked: the
//! flight masters the character may have (Nav.TaxiMaybe), the continents a flight map has opened on (Nav.GetTaxiSeen)
//! and the player's continent.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const UI_FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const PRELUDE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local B = GF.parts.banner
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
-- Flight master 5 (West Hold) is one the character may have; 6 and 7 it knows. The player stands on continent 0.
local SEEN, MAYBE, PC = {}, { [5] = true }, 0
Polestar.Nav = Polestar.Nav or {}
Polestar.Nav.GetTaxiSeen = function() return SEEN end
Polestar.Nav.TaxiMaybe = function(id) return MAYBE[id] == true end
Polestar.Compat.GetPlayerWorldPosition = function() return PC, 0, 0 end
-- The route planned: walk to flight master `from`, fly to `to` (both on continent c, 0 unless given), walk on.
local function plan(from, to, c)
	Polestar.Fire("ROUTE_CHANGED", { { kind = "walk", label = "Walk to the flight master" },
		{ kind = "fly", label = "Fly to East Hold", stops = { { id = from, c = c or 0 }, { id = to, c = c or 0 } } },
		{ kind = "walk", label = "Kobolds" } })
	stub.advance(0.1)
end
local function banner()
	local kind = GF.BannerNotice()
	return { kind = kind or false, text = B:IsShown() and B.Text:GetText() or false, close = B.Close:IsShown(), jump = B.Jump:IsShown() }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", UI_FILES)], script: PRELUDE.to_string() + script, ..Default::default() }).remove(0)
}

const ASK: &str = "Open any flight master's map once on this continent so Polestar knows your flight paths.";

#[test]
fn a_route_through_a_flight_master_the_character_may_have_asks_for_a_flight_map_once_on_that_continent() {
	let out = run(r#"
		local r = {}
		plan(6, 7)                                   -- flight masters it knows: nothing to ask
		r.known = banner()
		plan(5, 6)                                   -- from West Hold, which it may have
		r.maybe = banner()
		GF.DismissBanner()                           -- closed
		r.closed = banner()
		r.asked = Polestar.CharState().flags.taxiMapAsked[0] == true
		plan(5, 6)                                   -- planned again: closed for good on this continent
		r.again = banner()
		PC = 1
		plan(5, 6, 0)                                -- on another continent, a flight on the first: not here
		r.elsewhere = banner()
		plan(5, 6, 1)                                -- that continent's own flight: its own notice
		r.other = banner()
		SEEN[1] = true                               -- a flight map opens there
		stub.fire("TAXIMAP_OPENED")
		stub.advance(0.1)
		r.opened = banner()
		emit(r)"#);
	assert_eq!(out["known"]["kind"], false, "only flight masters it knows: {out}");
	assert_eq!(out["maybe"], json!({ "kind": "taxiMap", "text": ASK, "close": true, "jump": false }), "{out}");
	assert_eq!(out["closed"]["kind"], false, "closed: {out}");
	assert_eq!(out["asked"], true, "closed for good on continent 0: {out}");
	assert_eq!(out["again"]["kind"], false, "planned again there, still closed: {out}");
	assert_eq!(out["elsewhere"]["kind"], false, "the flight is on another continent than the player's: {out}");
	assert_eq!(out["other"]["kind"], "taxiMap", "continent 1's own: {out}");
	assert_eq!(out["opened"]["kind"], false, "a flight map opened there: {out}");
	assert_eq!(out["opened"]["text"], false, "the banner is down: {out}");
}
