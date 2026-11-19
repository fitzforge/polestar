'use strict';
const assert = require('node:assert/strict');
const test = require('node:test');
const path = require('node:path');
const { runAddon, tocFiles, ADDONS } = require('./helpers/lua');
const { navParts } = require('../tools/lib/nav/parts');

test('zone advice distinguishes a level-one character from an unreadable level', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }],
		script: `
			stub.maps.useWorld()
			local d, c = Polestar.Nav.danger, Polestar.Compat
			local secret = {}
			issecretvalue = function(v) return v == secret end
			local function walk(level)
				UnitLevel = function() return level end
				return d.Level() or false
			end
			emit({ walk(1), walk(nil), c.GetPlayerInfo().level, walk(secret), walk(-1) })`,
	});
	assert.deepEqual(emitted[0], [1, false, 1, false, false]);
});

test('opposing settlements block the whole walking segment; mobs and high-level zones do not', () => {
	const { emitted: [rows] } = runAddon({
		stubs: ['stub_world.lua'], before: "stub.clientBuild = '70532'", addons: ['Polestar'],
		script: `
			local d, out = Polestar.Nav.danger, {}
			for _, p in ipairs({'Alliance', 'Horde'}) do
				local function walk(map, x, y, X, Y) return d.Blocked(map,x,y,X,Y,p) or 'clear' end
				local a, b, y = -9644.062, -9244.062, 77.667 -- road across Goldshire, endpoints outside town
				out[p] = {
					walk(0,a,y,a,y), walk(0,b,y,b,y), walk(0,a,y,b,y), walk(0,b,y,a,y),
					walk(0,-8833.38,628.62,-8831.38,628.62), -- Stormwind
					walk(1,1681,-4099.99,1683,-4099.99),     -- Orgrimmar
					walk(0,-5677.17,-3165.29,-5675.17,-3165.29), -- Ol' Sooty
					walk(1,2680.74,-6159.52,2682.74,-6159.52),  -- Azuregos
					walk(1,7390.74,-4861.3,7392.74,-4861.3),    -- Ursius, Winterspring
				}
			end
			out.preference = { d.Mult(20,1452), d.Mult(60,1452) }
			emit(out)`,
	});
	const blocked = 'opposing-settlement', ok = 'clear';
	assert.deepEqual(rows.Alliance, [ok, ok, ok, ok, ok, blocked, ok, ok, ok]);
	assert.deepEqual(rows.Horde, [ok, ok, blocked, blocked, blocked, ok, ok, ok, ok]);
	assert.ok(rows.preference[0] > rows.preference[1] && rows.preference[1] === 1);
});

test('a displaced start cannot sell the unwalkable chord out of the Stonefire Tavern as a transfer', () => {
	const parts = navParts(path.join(ADDONS, 'Polestar_Nav'));
	const before = parts.map(n => `stub.packs[${JSON.stringify(n)}] = {${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`);
	const { emitted: [answer] } = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: ["stub.clientBuild = '70532'", ...before].join('\n'),
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }, 'Polestar_Nav'],
		script: `
			local p, frames = Polestar_NavEngine, {}
			p.after = function(f) frames[#frames + 1] = f end
			local function drain() while #frames > 0 do table.remove(frames, 1)() end end
			local vendor = {x=-4842.3, y=-861, z=502}
			local corner = {x=-4843.75, y=-881.25, z=502}
			local master = {x=-4821.1, y=-1152.4, z=502.3}
			local opts = {profile='Alliance', walkLevel=23}
			local result = {}
			p.Find(0, vendor, corner, function(line, why, job)
				result.transfer = job.walkChecked or false
				if result.transfer then result.knots, result.yards = #line, job.yards end
			end, opts)
			drain()
			p.FindMany(0, corner, {vendor, master}, function(costs, why, job)
				result.vendor, result.master = costs[1] or false, costs[2] or false
				result.vendorYards = job.yards[1] or false
			end, opts, true) -- from each target to the corner
			drain(); emit(result)`,
	});
	assert.equal(typeof answer.master, 'number', 'the walk from the flight master to the same corner remains available');
	assert.equal(Boolean(answer.vendor), answer.transfer, 'the planner must not price a departure refused by the walking engine');
	if (answer.transfer) {
		// A later map can supply a real detour. The missing segment is 20.30 yd
		// long and intersects solid geometry; neither a direct chord nor its old
		// price for a single grid step is a walk from the vendor.
		assert.ok(answer.knots > 2 && answer.yards > 20.31 && answer.vendorYards > 20.31);
	}
});
