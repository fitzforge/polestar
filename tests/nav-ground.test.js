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

test('every client build checks walks against the enemy towns; a newer one than the data says so once in the log', () => {
	// The data files name the builds they were paired on; the log line names the same pair.
	for (const file of ['DangerAreas.lua', 'DangerHubs.lua']) {
		const banner = require('node:fs').readFileSync(path.join(ADDONS, 'Polestar', 'Nav', file), 'utf8').split('\n')[0];
		assert.match(banner, /paired ground policy for builds 70532 and 70959\.$/, file);
	}
	const rows = {};
	for (const build of ['70338', '70532', '70959', '70960', '71000']) {
		const { emitted: [row] } = runAddon({
			stubs: ['stub_world.lua'], before: `stub.clientBuild = '${build}'`, addons: ['Polestar'],
			script: `
				local d = Polestar.Nav.danger
				local function walk(map, x, y, X, Y) return d.Blocked(map,x,y,X,Y,'Horde') or 'clear' end
				local log = {}
				for _, line in ipairs(Polestar.DebugLog()) do
					if line:find('ground: ', 1, true) then log[#log + 1] = line:gsub('^%S+ ', '') end
				end
				emit({ goldshire = walk(0,-9644.062,77.667,-9244.062,77.667), stormwind = walk(0,-8833.38,628.62,-8831.38,628.62),
					orgrimmar = walk(1,1681,-4099.99,1683,-4099.99), log = table.concat(log, '\\n') })`,
		});
		rows[build] = row;
	}
	const checked = { goldshire: 'opposing-settlement', stormwind: 'opposing-settlement', orgrimmar: 'clear' };
	const newer = b => `ground: client build ${b} is newer than the enemy-town data (70532, 70959); walks are still checked`;
	assert.deepEqual(rows, {
		70338: { ...checked, log: '' }, 70532: { ...checked, log: '' }, 70959: { ...checked, log: '' },
		70960: { ...checked, log: newer('70960') }, 71000: { ...checked, log: newer('71000') },
	});
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

test('Ironforge street walks round the signpost in both directions without closing the west pavement', () => {
	const parts = navParts(path.join(ADDONS, 'Polestar_Nav'));
	const { emitted: [lines] } = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: ["stub.clientBuild = '70532'", ...parts.map(n => `stub.packs[${JSON.stringify(n)}] = {${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`)].join('\n'),
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }, 'Polestar_Nav'],
		script: `
			local p, frames = Polestar_NavEngine, {}
			p.after = function(fn) frames[#frames+1] = fn end
			local function walk(x,y,X,Y)
				local points
				p.Find(0,{x=x,y=y,z=502},{x=X,y=Y,z=502},function(line, _, job)
					if job.walkChecked and not job.reached then
						points = {}
						for _,v in ipairs(line) do points[#points+1]={v.x,v.y,v.z} end
					end
				end,{profile='Alliance',walkLevel=23})
				while #frames>0 do table.remove(frames,1)() end
				return points or false
			end
			local a,b,c,d = -4864.5833333333,-1122.9166666667,-4868.75,-1097.9166666667
			emit({walk(a,b,c,d),walk(c,d,a,b),walk(c,-1118.75,c,-1102.0833333333)})`,
	});
	for (const line of lines) {
		assert.ok(Array.isArray(line) && line.length >= 2, 'the pavement remains connected');
		for (let i = 1; i < line.length; ++i) {
			const [x, y, z] = line[i - 1], [X, Y, Z] = line[i], dx = X-x, dy = Y-y;
			assert.ok(Math.abs(z-502)<1 && Math.abs(Z-502)<1, 'stay on the pavement');
			for (const [px, py] of [[-4866.847,-1107.031],[-4864.583,-1106.652],[-4866.632,-1108.366]]) {
				const t = Math.max(0, Math.min(1, ((px-x)*dx+(py-y)*dy)/(dx*dx+dy*dy || 1)));
				assert.ok(Math.hypot(x+t*dx-px,y+t*dy-py) >= .454, 'a shoulder crosses a fixed sign face');
			}
		}
	}
});

function missesFace(a, b, [px, py, pz]) {
	const [x,y,z] = a, [X,Y,Z] = b, dx = X-x, dy = Y-y;
	const t = Math.max(0, Math.min(1, ((px-x)*dx+(py-y)*dy)/(dx*dx+dy*dy || 1)));
	const height = pz-z-t*(Z-z);
	return height <= .29 || height >= 1.95 || Math.hypot(x+t*dx-px,y+t*dy-py) >= .454;
}

test('the standalone walking map does not send a departing vendor through the Stonefire wall', () => {
	const nav = 'Polestar_Nav', parts = navParts(path.join(ADDONS, nav));
	const { emitted: [result] } = runAddon({
		stubs: ['stub_encoding.lua', 'stub_packs.lua'],
		before: parts.map(n => `stub.packs[${JSON.stringify(n)}]={${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`).join('\n'),
		addons: [nav],
		script: `
			local p = Polestar_NavEngine
			local function walk(a, b)
				local line = p.FindSync(0,a,b,{profile='Alliance'})
				if not line then return false end
				local out = {}
				for _,pt in ipairs(line) do out[#out+1] = {pt.x,pt.y,pt.z} end
				return out
			end
			local vendor = {x=-4842.3,y=-861,z=502}
			local street = {x=-4843.75,y=-881.25,z=502}
			local master = {x=-4821.1,y=-1152.4,z=502.3}
			emit({back=walk(vendor,master), street=walk(street,master)})`,
	});
	assert.ok(result.street && Math.hypot(result.street.at(-1)[0]+4821.1,result.street.at(-1)[1]+1152.4) < 5,
		'the street outside still connects to the flight master');
	const line = result.back;
	if (line) {
		assert.deepEqual(line[0], [-4842.3,-861,502], 'a route may not silently start outside');
		for (let i=1; i<line.length; i++) assert.ok(missesFace(line[i-1],line[i],[-4843.076958,-871.850614,502.55]),
			'the line leaves through fixed masonry, not the lower doorway');
	}
});

for (const [place, goal, maxGap, faces] of [
	['the trainer ramp', [-4876.6,-1149.2,512.5], 10, [[-4861.273418,-1141.422549,503.223817],[-4868.359568,-1147.723829,506.619640]]],
	// The vendor route is still partial; keep the approach without sending the player through the ForgeRoom wall.
	['Stonefire Tavern', [-4842.3,-861,502], 21, [[-4814.472715,-1050.653239,503.215],[-4825.530720,-1013.096860,503.236699]]],
]) test(`the walk from the Ironforge flight master to ${place} goes around the masonry`, () => {
	const [gx, gy, gz] = goal;
	const parts = navParts(path.join(ADDONS, 'Polestar_Nav'));
	const { emitted: [line] } = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: ["stub.clientBuild='70532'", ...parts.map(n => `stub.packs[${JSON.stringify(n)}]={${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`)].join('\n'),
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }, 'Polestar_Nav'],
		script: `
			local e,q,points=Polestar_NavEngine,{},{}
			e.after=function(f) q[#q+1]=f end
			e.Find(0,{x=-4821.1,y=-1152.4,z=502.3},{x=${gx},y=${gy},z=${gz}},function(path)
				for _,p in ipairs(path or {}) do points[#points+1]={p.x,p.y,p.z} end
			end,{profile='Alliance',walkLevel=23})
			while #q>0 do table.remove(q,1)() end
			emit(points)`,
	});
	assert.ok(Array.isArray(line) && line.length >= 2 && Math.hypot(line.at(-1)[0]-gx,line.at(-1)[1]-gy)<maxGap,
		'the walking approach remains available, not just a refusal at the flight master');
	for (let i=1; i<line.length; i++) {
		for (const face of faces) assert.ok(missesFace(line[i-1],line[i],face), 'a walking segment enters fixed masonry');
	}
});

test('a steering shortcut cannot cross the Ironforge trainer floors or the Searing Gorge entrance jump', () => {
	const parts = navParts(path.join(ADDONS, 'Polestar_Nav'));
	const { emitted: [sight] } = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: ["stub.clientBuild = '70532'", ...parts.map(n => `stub.packs[${JSON.stringify(n)}] = {${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`)].join('\n'),
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }, 'Polestar_Nav'],
		script: `
			local p, frames = Polestar_NavEngine, {}
			p.after = function(fn) frames[#frames+1] = fn end
			local function checks(x,y,z,X,Y,Z)
				p.Prefetch(0,x,y)
				while #frames>0 do table.remove(frames,1)() end
				local function sight(a,b,c,d,e,f) return p.Sight(0,a,b,c,d,e,f,'Alliance') end
				return {sight(x,y,z,x+.02,y,z), sight(X,Y,Z,X+.02,Y,Z),
					sight(x,y,z,X,Y,Z), sight(X,Y,Z,x,y,z)}
			end
			emit({checks(-4876.6,-1149.2,505.77007,-4876.58,-1149.2,512.43678),
				checks(-7323.96,-1094.79,279.02,-7323.96,-1092.71,277.57)})`,
	});
	assert.deepEqual(sight, [[true, true, false, false], [true, true, false, false]]);
});

test('a near waypoint is on the other deck in Silithus, not on the slope beside the player', () => {
	const nav = 'Polestar_Nav', parts = navParts(path.join(ADDONS, nav));
	const { emitted: [floors] } = runAddon({
		stubs: ['stub_encoding.lua', 'stub_packs.lua'],
		before: ["stub.clientBuild='70959'", ...parts.map(n => `stub.packs[${JSON.stringify(n)}]={${tocFiles(n).map(p => JSON.stringify(p)).join(',')}}`)].join('\n'),
		addons: [nav],
		script: `
			assert(C_AddOns.LoadAddOn('Polestar_Nav_Kalimdor'))
			local separate = Polestar_NavEngine.OnSeparateLocalFloors
			local x,y,X,Y = -8072.916667,441.666667,-8075,439.583333
			local low,high,Low,High = -39.512269,-36.849965,-39.991777,-36.343852
			emit({separate(1,x,y,low,X,Y,High), separate(1,X,Y,High,x,y,low),
				separate(1,x,y,low,X,Y,Low), separate(1,X,Y,High,x,y,high)})`,
	});
	assert.deepEqual(floors, [true, true, false, false]);
});
