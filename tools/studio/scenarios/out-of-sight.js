'use strict';
// Out of sight, in every skin: another addon turns the guide window and the
// arrow down to a scale far below a pixel (as some UI addons do to follow the
// guide in their own quest tracker), and Polestar's notice at the top of the
// screen says so, the first time on the account. A Tauren Hunter at 18 on the
// shipped Barrens guide, played 39 steps, as in the skins scenario.

const skins = require('./skins');

// The window and the arrow veiled as such an addon does; the notice comes a
// frame later.
const VEIL = `PolestarDB.sightTold = nil
for _, f in ipairs({ PolestarGuideFrame, PolestarNavArrow }) do
	if f then
		f:SetAlpha(0)
		f:SetScale(0.001)
	end
end
stub.advance(1)
local B = Polestar.Nav.alerts.banner
assert(B and B:IsShown(), "no notice")`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(skins.SKINS)) {
	const base = skins.pick(id, folder, variant);
	shots[`${name}-notice`] = { title: `${name}: "Polestar is out of sight", the notice at the top of the screen`, capture: ['PolestarAlert'], pad: 40, lua: `${base}\n${VEIL}` };
}

module.exports = {
	title: 'Out of sight: the notice when another addon keeps the guide window or the arrow out of sight, in every skin',
	character: skins.character,
	place: skins.place,
	guide: skins.guide,
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarAlert'],
	shots,
};
