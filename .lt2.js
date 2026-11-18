const { AreaGraph, CITIES } = require('./tools/lib/nav/city/graph');
const { spawnHeight } = require('./tools/lib/nav/city/match');
const fs = require('fs'); const H = process.env.HOME;
const frames = require('./data/forever/map-frames.json').forever;
const spawnz = require('./data/forever/spawnz.json').npc; const taxi = require('./data/forever/travel.json').taxi.nodes;
const { landOnTower } = (() => { const src = fs.readFileSync("./tools/lib/nav/city/gate.js", "utf8") + "\nmodule.exports.landOnTower = landOnTower;"; const M = new (require("module"))("x"); M.paths = module.paths; M.filename = require("path").resolve("./tools/lib/nav/city/gate.js"); M._compile(src, M.filename); return M.exports; })();
for (const m of [1453,1454,1455,1456,1458]) {
  const g = AreaGraph.forMap(m, { grid: H + '/work/Release040/grid-70532', frames });
  const trips = JSON.parse(fs.readFileSync(H + '/work/CityPaths/priv/' + m + '/gate-trips.json'));
  const nz = spawnHeight(spawnz, CITIES[m].c);
  const ch = trips.map(t => landOnTower(g, { ...t, c: CITIES[m].c }, taxi, nz)).filter(t => t.A.landed !== undefined);
  console.log(m, 'moved', ch.length, [...new Set(ch.map(t => t.A.landed.toFixed(1) + '->' + t.A.z.toFixed(1)))].join(' '));
}
