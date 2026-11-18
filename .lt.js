const { AreaGraph, CITIES } = require('./tools/lib/nav/city/graph');
const { spawnHeight } = require('./tools/lib/nav/city/match');
const fs = require('fs'); const H = process.env.HOME;
const frames = require('./data/forever/map-frames.json').forever;
const spawnz = require('./data/forever/spawnz.json').npc; const taxi = require('./data/forever/travel.json').taxi.nodes;
const gate = require('./tools/lib/nav/city/gate');
for (const m of [1453,1454,1455,1456,1458]) {
  const g = AreaGraph.forMap(m, { grid: H + '/work/Release040/grid-70532', frames });
  const trips = JSON.parse(fs.readFileSync(H + '/work/CityPaths/priv/' + m + '/gate-trips.json'));
  const nz = spawnHeight(spawnz, CITIES[m].c);
  const ch = trips.map(t => gate._landOnTower(g, { ...t, c: CITIES[m].c }, taxi, nz)).filter(t => t.A.landed !== undefined);
  console.log(m, 'moved', ch.length, [...new Set(ch.map(t => t.A.landed.toFixed(1) + '->' + t.A.z.toFixed(1)))].join(' '));
}
