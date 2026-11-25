'use strict';
// The playground and the studio draw a dump that leaves out a shown frame
// lying entirely outside a clipping ancestor (a scroll frame's rows scrolled
// out of view). A frame with no area has no place to judge by: ZoneArt's
// Canvas on the picture path (ZoneArt.Picture) is one, a bare container with
// the picture anchored to the band, and it was judged outside the band's clip
// and dropped, so the render of the Attunements and Dungeons cards showed no
// picture where the game draws it (0.4.3-rc render, ZoneArt.Picture traced).
// Needs data/forever; skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { needs } = require('./helpers/data');
const { tmpdir } = require('./helpers/tmp');
const { Session } = require('../tools/play/session');

const skip = needs('races.json');

test('a bare container frame with a region anchored to its clipping parent stays in the dump; a sized row outside the clip does not', { skip, timeout: 60000 }, async () => {
	const dataDir = tmpdir('polestar-clipped-');
	const s = new Session({ dataDir });
	await s.start();
	try {
		const r = await s.call(`
local band = CreateFrame("Frame", nil, UIParent)
band:SetSize(100, 50)
band:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
band:SetClipsChildren(true)
local bare = CreateFrame("Frame", nil, band)
local pic = bare:CreateTexture(nil, "BACKGROUND")
pic:SetAllPoints(band)
pic:SetColorTexture(1, 0, 0, 1)
local row = CreateFrame("Frame", nil, band)
row:SetSize(100, 20)
row:SetPoint("TOPLEFT", band, "BOTTOMLEFT", 0, -10)
local rowTex = row:CreateTexture(nil, "BACKGROUND")
rowTex:SetAllPoints(row)
rowTex:SetColorTexture(0, 1, 0, 1)
local seen = {}
for _, o in ipairs(play.snapshot(0).dump.objects) do seen[o.id] = true end
return { bare = seen[play.idOf(bare)] == true, pic = seen[play.idOf(pic)] == true, row = seen[play.idOf(row)] == true }`);
		assert.equal(r.ok, true, JSON.stringify(r));
		assert.deepEqual(r.value, { bare: true, pic: true, row: false });
	} finally {
		await s.stop({ save: false });
		fs.rmSync(dataDir, { recursive: true, force: true });
	}
});
