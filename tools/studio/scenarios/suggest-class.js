'use strict';
// The class quest card one level below its first quest (feat/suggest-quest-
// level-037, QoL/ClassQuests.lua): a Human Rogue in Silverpine with the horn
// job done; The Eye of Bhossca's first quest is level 35, so the card comes at
// 34 and not at 33. Each shot returns what ClassQuests.Ready() listed.

const EYE = 'forever/class/rogue/the-eye-of-bhossca';
const ROGUE = (level) => `local w, E, CQ = stub.world, Polestar.Engine, Polestar.QoL.ClassQuests
w.setLevel(${level})
stub.advance(3)
w.moveTo(1421, 45.0, 70.0); play.syncZone()
w.zone, w.subzone = "Silverpine Forest", "Pyrewood Village"
-- Offers start now: the setup ran with them off (it passes level 30, and its
-- heads-up clearing would have dismissed any card), and nothing offered yet.
local flags = Polestar.CharState().flags
flags = flags or {}
Polestar.CharState().flags = flags
flags.classOffered = nil
Polestar.Set("behavior.offerClassQuests", true)
-- The horn job (the chain before) done, as the guide's gate asks.
for _, q in ipairs({ 78261, 78270, 78307 }) do w.completed[q] = true end
local G = Polestar.Guides
local ready = {}
for _, g in ipairs(CQ.Ready()) do ready[#ready + 1] = g.id end
-- The other rogue chains taken already, so the card is this one's when it is ready.
local offered = Polestar.CharState().flags.classOffered or {}
Polestar.CharState().flags.classOffered = offered
for _, id in ipairs(ready) do if id ~= "${EYE}" then offered[id] = true end end
CQ.Check()
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local GF = Polestar.UI.GuideFrame
return { level = ${level}, ready = table.concat(ready, ","), banner = GF.BannerNotice and GF.BannerNotice() or "?",
	gate = tostring(E.StartGate and E.StartGate("${EYE}")) }`;

module.exports = {
	title: 'The class quest card one level below the first quest (The Eye of Bhossca)',
	character: { race: 'Human', cls: 'ROGUE', faction: 'Alliance', level: 30, money: 9000 },
	place: { map: 1421, x: 45.0, y: 70.0, zone: 'Silverpine Forest', subzone: 'Pyrewood Village' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarClassToast'],
	shots: {
		'class-33': { title: 'Rogue 33 in Silverpine: The Eye of Bhossca not offered yet', lua: ROGUE(33) },
		'class-34': { title: 'Rogue 34: the class quest card for The Eye of Bhossca', lua: ROGUE(34) },
	},
};
