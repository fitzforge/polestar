'use strict';
// Flight paths Polestar has not seen yet (#1795). A Tauren Hunter at 18 on
// the shipped Barrens guide, with Thunder Bluff, Orgrimmar and the
// Crossroads known (taxi nodes 22, 23 and 25), in each look and at each UI
// scale (the game's UI scale: UIParent's):
//   <look>-<scale>-learn   the arrow at Camp Taurajo's flight master, not
//                          learnt, bound for the Crossroads: "Learn the
//                          flight path at Camp Taurajo, then fly to
//                          Crossroads" (part 2)
//   <look>-<scale>-report  the bug report window with its Travel: line, the
//                          same plan (part 2)
//   <look>-<scale>-row-seen / -row-unseen  While you're here at Camp
//                          Taurajo's flight master: its "Learn the flight
//                          path" line where a flight map has opened in
//                          Kalimdor, none where none has (part 1)
// Studio shot names: flight-paths/<look>-<scale>-<shot>.

const { SKINS, pick } = require('./skins');

const LOOKS = Object.keys(SKINS);
const SCALES = { '064': 0.64, '100': 1, '150': 1.5 };

// Camp Taurajo's flight master stands at the Barrens 44.46,59.1.
const AT_TAURAJO = (seen) => `local flags = Polestar.CharState().flags
flags.taxi = { [22] = true, [23] = true, [25] = true }
flags.taxiSeen = ${seen ? '{ [1] = true }' : '{}'}
stub.world.moveTo(1413, 44.50, 59.14); play.syncZone()
stub.world.zone, stub.world.subzone = "The Barrens", "Camp Taurajo"
studio.clearHeadsUps()
stub.advance(2)`;

const SCALE = (s) => `UIParent:SetScale(${s})
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const TO_CROSSROADS = `Polestar.Nav.SetTarget(1413, 51.67, 30.96, "The Crossroads")
for _ = 1, 40 do stub.advance(0.1) end
local legs, ci = Polestar.Nav.GetRoute()
assert(legs and legs[ci] and legs[ci].kind == "fly", "not on the flight: " .. tostring(legs and legs[ci] and legs[ci].label))`;

// The report with something said (Copy report waits for 5 letters), copied:
// the report's text in its box, the Travel: line after Routes.
const REPORT = `if PolestarGuideFrame then PolestarGuideFrame:Hide() end
if PolestarNavArrow then PolestarNavArrow:Hide() end
Polestar.UI.ShowReport()
stub.advance(0.5)
local F = PolestarReport
F.Desc:SetText("The arrow walked me past the flight master")
local changed = F.Desc:GetScript("OnTextChanged")
if changed then changed(F.Desc, true) end
stub.advance(0.2)
F.Copy:Click()
stub.advance(0.5)
-- The box scrolled to the Travel: line (about 12 px a line, as the window sizes it).
local before = 0
for line in (F.Box:GetText() .. "\\n"):gmatch("(.-)\\n") do
	if line:find("^Travel: ") then break end
	before = before + 1
end
Polestar.Widgets.ScrollTo(F.BoxScroll, math.max(0, (before - 2) * 12))
stub.advance(0.3)`;

const ROWS = `Polestar.Set("behavior.whileHereFlights", true)
stub.advance(3)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const shots = {};
for (const look of LOOKS) {
	const [id, folder, variant] = SKINS[look];
	const base = pick(id, folder, variant);
	for (const [tag, s] of Object.entries(SCALES)) {
		const name = `${look}-${tag}`;
		shots[`${name}-learn`] = {
			title: `${look} at ${s}: the arrow at an unlearnt flight master, "Learn the flight path at Camp Taurajo, then fly to Crossroads"`,
			capture: ['PolestarNavArrow'],
			pad: 40,
			lua: `${base}\n${SCALE(s)}\n${AT_TAURAJO(true)}\n${TO_CROSSROADS}`,
		};
		shots[`${name}-report`] = {
			title: `${look} at ${s}: the bug report window, its Travel: line`,
			capture: ['PolestarReport'],
			lua: `${base}\n${SCALE(s)}\n${AT_TAURAJO(true)}\n${TO_CROSSROADS}\n${REPORT}`,
		};
		shots[`${name}-row-seen`] = {
			title: `${look} at ${s}: a flight map opened in Kalimdor, "Learn the flight path at Camp Taurajo" in While you're here`,
			lua: `${base}\n${SCALE(s)}\n${AT_TAURAJO(true)}\n${ROWS}`,
		};
		shots[`${name}-row-unseen`] = {
			title: `${look} at ${s}: no flight map opened in Kalimdor yet, no such line`,
			lua: `${base}\n${SCALE(s)}\n${AT_TAURAJO(false)}\n${ROWS}`,
		};
	}
}

module.exports = {
	title: 'Flight paths Polestar has not seen yet (#1795): the learn caption, the report\'s Travel: line, While-here\'s line',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 44.5, y: 59.14, zone: 'The Barrens', subzone: 'Camp Taurajo' },
	guide: { id: 'forever/horde/02-the-barrens', play: 39, hours: 1 },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	stubs: require('./skins').stubs,
	capture: ['PolestarGuideFrame'],
	shots,
};
