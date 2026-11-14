'use strict';
// Worst case: realistic data at its limits, through the stub world (the
// quest log, the level, the place, the screen), never by editing the addon's
// frames. A player who installs Polestar mid-leveling: at 34 with a messy
// log of 25 quests from eleven zones (Duskwood to Alterac), and at 47 with
// the log full (40 of 40, two quests of the same name, a quarter of them
// ready to hand in). The quests, their titles and objectives are real
// (data/forever). Searing Gorge's Dark Iron step carries the longest names
// the leveling guides show in German ("GESTOHLEN: Schmiedewindform und ein
// Ausguck-Handfernrohr", "Sklavenhändler der Dunkeleisenzwerge"): play it
// with --locale deDE (ruRU, koKR, zhCN) and --fit.
// Shots:
//   room-34            Make room in your quest log at 34, UI scale 1 on 1920x1080
//   room-34-768        the same on a 1366x768 screen at UI scale 1
//   room-47            at 47 with 40 of 40
//   room-47-768-064    at 47 on a 1366x768 screen at UI scale 0.64
//   carried-47         Finished quests you're still carrying, at 47
//   banner-47          the guide window's full-log notice at Feathermoon (Feralas)
//   guide-34           the guide window at 34 on the Desolace guide's first step
//   sg-dark-iron       Searing Gorge's Dark Iron step, halfway through, at the
//                      window's default width; -260 at its narrowest
//   sg-thorium         Thorium Point's six accepts with 36 quests in the log
//   sg-4k-15           the Dark Iron step on a 3840x2160 screen at UI scale 1.5
//   sg-ultrawide       the same on 3440x1440 at UI scale 1
//   welcome-768        Install's first page on a 1366x768 screen at UI scale 1
//   finish-768         Install's last page there
// The screen: UIParent's size in UI units (the screen's pixels over the UI
// scale), drawn into the 1920x1080 render at the scale that fits it.

const fs = require('node:fs');
const path = require('node:path');

const DATA = path.join(__dirname, 'worst-case');
const log34 = fs.readFileSync(path.join(DATA, 'log34.lua'), 'utf8');
const log47 = fs.readFileSync(path.join(DATA, 'log47.lua'), 'utf8');

const screen = (w, h, s) => {
	const units = [w / s, h / s];
	const fit = Math.min(1920 / units[0], 1080 / units[1]);
	return `UIParent:SetScale(${fit})
function UIParent:GetWidth() return ${units[0]} end
function UIParent:GetHeight() return ${units[1]} end
UIParent.width, UIParent.height = ${units[0]}, ${units[1]}
stub.advance(0.5)`;
};

// A quest's title as the client's log gives it: in its language (the
// language folder's name, when the client is not English), else English.
const TITLE = `local function title(q, en)
	stub.world.titles[q] = nil
	return Polestar.Names.Quest(q) or en
end`;

// The log as it stands before Polestar sees it (no accept events), then one
// update. `keep`: the first that many rows only.
const fill = (rows, keep = 99) => `local w = stub.world
${TITLE}
for q in pairs(w.log) do w.log[q] = nil end
for i, r in ipairs({
${rows}
}) do
	if i > ${keep} then break end
	local t = title(r[1], r[2])
	w.onQuest(r[1], r[3], t)
	w.titles[r[1]] = t
end
stub.fire("QUEST_LOG_UPDATE")
stub.advance(1)`;

// To level 47 on the Feralas guide, at Feathermoon, the notices of the way there answered.
const at47 = (guide = 'forever/alliance/40-50/03-feralas', map = 1444, x = 30.8, y = 43.4, zone = 'Feralas', sub = 'Feathermoon Stronghold') => `local w = stub.world
w.setLevel(47)
w.moveTo(${map}, ${x}, ${y}); play.syncZone()
w.zone, w.subzone = ${JSON.stringify(zone)}, ${JSON.stringify(sub)}
Polestar.Engine.SetGuide(${JSON.stringify(guide)})
stub.advance(1)
studio.clearHeadsUps()`;

const room = (mode) => `local n = 0 for _ in pairs(stub.world.log) do n = n + 1 end
Polestar.UI.ShowQuestRoom(${mode ? JSON.stringify(mode) : ''})
stub.advance(0.5)
local F = PolestarQuestRoom
local list = ${mode === 'carried' ? 'Polestar.RoutePlan.Carried()' : 'Polestar.RoutePlan.Unneeded()'} or {}
return { log = n, rows = #list, height = F:GetHeight(), top = F:GetTop(), bottom = F:GetBottom(), screen = UIParent:GetHeight() }`;

// The first step with a `t` goal for `id` (its quest, NPC or flight path's name: titles are
// translated) on screen, the heads-ups of the way there answered.
const step = (t, id) => `local E = Polestar.Engine
local at
for i, st in ipairs(E.GetGuide().steps) do
	for _, g in ipairs(st.goals or {}) do
		if not at and g.t == ${JSON.stringify(t)} and (g.quest == ${JSON.stringify(id)} or g.npc == ${JSON.stringify(id)} or g.node == ${JSON.stringify(id)} or g.name == ${JSON.stringify(id)}) then at = i end
	end
end
assert(at, "no step with ${t} ${id}")
E.Goto(at)
stub.advance(0.5)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The Whirlwind Weapon's class guide on its first accept, The Islander (1718): the class card above the goals.
const CLASS_CARD = `Polestar.Engine.SetGuide("forever/class/warrior/whirlwind-weapon")
stub.advance(1)
${step('accept', 1718)}
local F = Polestar.UI.ClassCard.frame
return { shown = F ~= nil and F:IsVisible(), head = F and F.Head:GetText() or false }`;

// Searing Gorge at 47: Thorium Point's quests in the log, the Dark Iron step half done.
const DARK_IRON = `local w = stub.world
${TITLE}
w.onQuest(7729, { { text = "Dark Iron Taskmaster slain", required = 15, fulfilled = 4 }, { text = "Dark Iron Slaver slain", required = 15, fulfilled = 11 } }, title(7729, "JOB OPPORTUNITY: Culling the Competition"))
w.onQuest(7728, { { text = "Smithing Tuyere", required = 1, fulfilled = 1 }, { text = "Lookout's Spyglass", required = 1, fulfilled = 0 } }, title(7728, "STOLEN: Smithing Tuyere and Lookout's Spyglass"))
w.onQuest(3443, { { text = "Thorium Plated Dagger", required = 8, fulfilled = 3 } }, title(3443, "Forging the Shaft"))
w.onQuest(7723, { { text = "Heavy War Golem slain", required = 20, fulfilled = 20 } }, title(7723, "Curse These Fat Fingers"))
w.onQuest(7724, { { text = "Greater Lava Spider slain", required = 20, fulfilled = 20 } }, title(7724, "Fiery Menace!"))
stub.fire("QUEST_LOG_UPDATE")
stub.advance(1)`;
const SEARING = at47('forever/alliance/40-50/06-searing-gorge', 1427, 41.0, 54.0, 'Searing Gorge', 'The Cauldron');

const welcome = (key) => `Polestar.Set("nav.arrow", false)
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.Welcome.Show(${JSON.stringify(key)})
stub.advance(1)
local key, at, count, title = Polestar.UI.Welcome.Page()
return { key = key, step = at .. " of " .. count, height = PolestarWelcome:GetHeight(), scale = PolestarWelcome:GetScale(), screen = UIParent:GetHeight(), top = PolestarWelcome:GetTop(), bottom = PolestarWelcome:GetBottom() }`;


// Death: the client's ghost state and corpse position as death-arrow.rs has them;
// the character dies at (map, x, y), in instance `inst` (its map id) when given,
// and releases to the Spirit Healer at (gmap, gx, gy).
const DEATH = ({ level, map, x, y, inst, gmap, gx, gy, zone }) => `local w = stub.world
w.setLevel(${level})
dead, ghost, corpseAt = false, false, nil
function UnitIsDeadOrGhost(unit) return unit == "player" and (dead or ghost) end
function UnitIsGhost(unit) return unit == "player" and ghost end
function UnitIsDead(unit) return unit == "player" and dead end
C_DeathInfo = { GetCorpseMapPosition = function(m)
	if not corpseAt or m ~= corpseAt[1] then return nil end
	return { x = corpseAt[2] / 100, y = corpseAt[3] / 100 }
end }
local instance = ${inst || 'nil'}
function GetInstanceInfo() if w.inInstance then return "Instance", "party", 1, "Normal", 5, 0, false, instance end return "", "none", 0, "", 0, 0, false, 0 end
w.moveTo(${map}, ${x}, ${y}); play.syncZone()
w.zone = ${JSON.stringify(zone)}
if instance then w.inInstance = true end
dead = true
stub.fire("PLAYER_DEAD")
stub.advance(1)
dead, ghost = false, true
w.inInstance = false
if not instance then corpseAt = { ${map}, ${x}, ${y} } end
w.moveTo(${gmap}, ${gx}, ${gy}); play.syncZone()
stub.fire("PLAYER_ALIVE")
stub.advance(3)
local a = Polestar.QoL.GetDeathAdvice()
local t = Polestar.Nav.GetTarget()
local geo = Polestar.Nav.GetRouteGeometry()
local pts = 0
for _, leg in ipairs(geo and geo.legs or {}) do pts = pts + #(leg.pts or {}) end
return { choice = a and a.choice, note = a and a.note, target = t and t.label, routePoints = pts }`;
const guideProbe = 'local GF = Polestar.UI.GuideFrame\nreturn { notice = (GF.BannerNotice()), height = PolestarGuideFrame:GetHeight(), top = PolestarGuideFrame:GetTop(), bottom = PolestarGuideFrame:GetBottom(), screen = UIParent:GetHeight() }';

// The account's other characters as their snapshots stand in PolestarDB (Alts/Snapshot.lua): Forever's
// names carry a surname (twelve letters each at most), the money cap (2^31 - 1 copper: 214,748g 36s 47c),
// every profession a character can hold, a guide 123 steps into 171, a level-60 one, one played a
// year ago, one on another realm, the place names in the client's language when it has them.
const ALTS = `local db = Polestar.DB()
db.alts = db.alts or {}
db.alts.chars = db.alts.chars or {}
local now = Polestar.Compat.Now()
local area = function(id, en) return Polestar.Names.Area and Polestar.Names.Area(id) or en end
local list = {
	{ name = "Aleksandrina Szczepańska", realm = "Forever", class = "WARLOCK", race = "Scourge", faction = "Horde", level = 47, xp = 61040, xpMax = 98300, rested = 147450, resting = true,
		zone = area(267, "Hillsbrad Foothills"), bind = "Tarren Mill", money = 2147483647, profs = { [171] = 300, [182] = 300, [185] = 300, [356] = 300, [129] = 300 },
		tabs = { { id = "forever/horde/02-the-barrens", title = "The Barrens", step = 123, count = 171 } }, active = 1, seen = now - 3600 },
	{ name = "Jo Li", realm = "Forever", class = "MAGE", race = "Gnome", faction = "Alliance", level = 60, xp = 0, xpMax = 0, zone = area(139, "Eastern Plaguelands"),
		bind = "Light's Hope Chapel", money = 1, profs = {}, tabs = {}, seen = now - 400 * 86400 },
	{ name = "Konstantinos Oberhauserin", realm = "Forever Classic Hardcore EU", class = "DRUID", race = "Tauren", faction = "Horde", level = 1, xp = 0, xpMax = 400,
		zone = area(215, "Mulgore"), bind = "Camp Narache", money = 0, profs = {}, tabs = { { id = "forever/horde/tauren/01-mulgore", title = "Mulgore", step = 1, count = 99 } }, active = 1, seen = now - 86400 },
}
for i, e in ipairs(list) do e.key = e.name .. "-" .. e.realm; db.alts.chars[e.key] = e end
Polestar.Fire("SHOW_ALTS")
stub.advance(1)
return { shown = PolestarPicker and PolestarPicker:IsShown() }`;

module.exports = {
	title: 'Worst case: installed mid-leveling with a messy or full quest log, the longest names, small and huge screens',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 34, money: 412345 },
	place: { map: 1443, x: 66.2, y: 6.6, zone: 'Desolace', subzone: "Nijel's Point" },
	guide: { id: 'forever/alliance/30-40/02-desolace' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarQuestRoom'],
	shots: {
		'room-34': { title: 'Make room in your quest log at 34: 25 quests from eleven zones', lua: `${screen(1920, 1080, 1)}\n${fill(log34)}\n${room()}` },
		'room-34-768': { title: 'Make room at 34, 1366x768 at UI scale 1', lua: `${screen(1366, 768, 1)}\n${fill(log34)}\n${room()}` },
		'room-47': { title: 'Make room at 47 with 40 of 40', lua: `${at47()}\n${screen(1920, 1080, 1)}\n${fill(log47)}\n${room()}` },
		'room-47-768-064': { title: 'Make room at 47, 1366x768 at UI scale 0.64', lua: `${at47()}\n${screen(1366, 768, 0.64)}\n${fill(log47)}\n${room()}` },
		'carried-47': { title: 'Finished quests you\'re still carrying, at 47', lua: `${at47()}\n${screen(1920, 1080, 1)}\n${fill(log47)}\n${room('carried')}` },
		'banner-47': {
			title: 'The full-log notice at Feathermoon',
			capture: ['PolestarGuideFrame'],
			lua: `${at47()}\n${screen(1920, 1080, 1)}\n${step('accept', 2866)}\n${fill(log47)}\nPolestar.UI.GuideFrame.Layout()\nstub.advance(0.5)\n${guideProbe}`,
		},
		'guide-34': {
			title: 'The guide window at 34 on the Desolace guide, 25 quests in the log',
			capture: ['PolestarGuideFrame'],
			lua: `${screen(1920, 1080, 1)}\n${step('accept', 1458)}\n${fill(log34)}\nPolestar.UI.GuideFrame.Layout()\nstub.advance(0.5)\n${guideProbe}`,
		},
		'sg-dark-iron': {
			title: 'Searing Gorge: the Dark Iron step, half done',
			capture: ['PolestarGuideFrame'],
			lua: `${SEARING}\n${screen(1920, 1080, 1)}\n${DARK_IRON}\n${step('kill', 5846)}\n${guideProbe}`,
		},
		'sg-dark-iron-260': {
			title: 'The Dark Iron step at the window\'s narrowest (260)',
			capture: ['PolestarGuideFrame'],
			lua: `${SEARING}\n${screen(1920, 1080, 1)}\nPolestar.Set("ui.width", 260)\nstub.advance(0.5)\n${DARK_IRON}\n${step('kill', 5846)}\n${guideProbe}`,
		},
		'sg-thorium': {
			title: 'Thorium Point\'s six accepts with 36 quests in the log',
			capture: ['PolestarGuideFrame'],
			lua: `${SEARING}\n${screen(1920, 1080, 1)}\n${step('accept', 7728)}\n${fill(log47, 36)}\nPolestar.UI.GuideFrame.Layout()\nstub.advance(0.5)\n${guideProbe}`,
		},
		'sg-4k-15': {
			title: 'The Dark Iron step on 3840x2160 at UI scale 1.5',
			capture: ['PolestarGuideFrame'],
			lua: `${SEARING}\n${screen(3840, 2160, 1.5)}\n${DARK_IRON}\n${step('kill', 5846)}\n${guideProbe}`,
		},
		'sg-ultrawide': {
			title: 'The Dark Iron step on 3440x1440 at UI scale 1',
			capture: ['PolestarGuideFrame'],
			lua: `${SEARING}\n${screen(3440, 1440, 1)}\n${DARK_IRON}\n${step('kill', 5846)}\n${guideProbe}`,
		},
		'welcome-768': { title: 'Install\'s first page on 1366x768 at UI scale 1', capture: ['PolestarWelcome'], lua: `${screen(1366, 768, 1)}\n${welcome('welcome')}` },
		'finish-768': { title: 'Install\'s last page on 1366x768 at UI scale 1', capture: ['PolestarWelcome'], lua: `${screen(1366, 768, 1)}\n${welcome('finish')}` },
		// Died at Goldtooth inside the Fargodeep Mine at 11 (sickness from 11 on: the run back wins),
		// released at Goldshire's Spirit Healer: does the way back lead through the mine's mouth (39.5, 82.4)?
		'death-cave': {
			title: 'Died at Goldtooth in the Fargodeep Mine, released at Goldshire',
			capture: ['PolestarNavArrow'],
			lua: DEATH({ level: 11, map: 1429, x: 41.7, y: 78.0, gmap: 1429, gx: 39.48, gy: 60.55, zone: 'Elwynn Forest' }).replace(/\nreturn \{ choice/, `
local C = Polestar.Compat
local mc, mx, my = C.MapToWorld(1429, 39.5, 82.4)
local near
for _, leg in ipairs(geo and geo.legs or {}) do
	for _, p in ipairs(leg.pts or {}) do
		if p[1] == mc then
			local d = ((p[2] - mx) ^ 2 + (p[3] - my) ^ 2) ^ 0.5
			if not near or d < near then near = d end
		end
	end
end
return { mouthYards = near and math.floor(near), choice`),
		},
		// Died inside the Deadmines at 18, released at Sentinel Hill: the run back to its entrance.
		'death-dungeon': {
			title: 'Died in the Deadmines, released at Sentinel Hill',
			capture: ['PolestarNavArrow'],
			lua: DEATH({ level: 18, map: 1436, x: 42.5, y: 71.7, inst: 36, gmap: 1436, gx: 51.71, gy: 49.67, zone: 'Westfall' }),
		},
		// The same with Lookup switched off (Options > Discovery): the Codex, which knows the entrance, never loads.
		'death-dungeon-nolookup': {
			title: 'Died in the Deadmines with Lookup off',
			capture: ['PolestarNavArrow'],
			lua: `Polestar.Set("lookup.enabled", false)\n${DEATH({ level: 18, map: 1436, x: 42.5, y: 71.7, inst: 36, gmap: 1436, gx: 51.71, gy: 49.67, zone: 'Westfall' })}`,
		},
		'alts': { title: 'Characters: four on the account, the worst of each field', capture: ['PolestarPicker'], lua: `${screen(1920, 1080, 1)}\n${ALTS}` },
		'alts-768': { title: 'Characters on 1366x768 at UI scale 1', capture: ['PolestarPicker'], lua: `${screen(1366, 768, 1)}\n${ALTS}` },
		// Journey 3 on the Desolace guide: two steps skipped, then a look back with Prev (the banners say where the guide is).
		'skip-back': {
			title: 'Two steps skipped, then a step back',
			capture: ['PolestarGuideFrame'],
			lua: `${screen(1920, 1080, 1)}\n${step('accept', 1458)}
local E = Polestar.Engine
E.Skip(); stub.advance(0.5)
E.Skip(); stub.advance(0.5)
local skipped = (Polestar.UI.GuideFrame.BannerNotice())
E.Prev(); stub.advance(0.5)
Polestar.UI.GuideFrame.Layout(); stub.advance(0.5)
return { afterSkips = skipped, afterPrev = (Polestar.UI.GuideFrame.BannerNotice()), step = E.GetStepIndex(), live = E.GetLiveStep() }`,
		},
		// Another guide picked mid-zone in the same tab: the Desolace guide goes to the closed tabs, its banner offers it back.
		'switch-guide': {
			title: 'Stranglethorn Vale picked mid-Desolace',
			capture: ['PolestarGuideFrame'],
			lua: `${screen(1920, 1080, 1)}\n${step('accept', 1458)}
local E = Polestar.Engine
E.SetGuide("forever/alliance/30-40/04-stranglethorn-vale"); stub.advance(1)
Polestar.UI.GuideFrame.Layout(); stub.advance(0.5)
return { notice = (Polestar.UI.GuideFrame.BannerNotice()), guide = E.GetGuide().id, tabs = #E.GetTabs() }`,
		},
		// Died in Forever's own Alcaz Prison (instance 2994), whose entrance the Codex lacks; where the
		// character stood before is no matter (the corpse is inside), released at Theramore's Spirit Healer.
		'death-alcaz': {
			title: 'Died in Alcaz Prison (no entrance in the Codex)',
			capture: ['PolestarNavArrow'],
			lua: DEATH({ level: 40, map: 1445, x: 63.62, y: 42.42, inst: 2994, gmap: 1445, gx: 63.62, gy: 42.42, zone: 'Dustwallow Marsh' }),
		},
		// The class card over a class quest's step: the Whirlwind Weapon's first accept (The Islander), its class line
		// beside the badge ("ВОИН · УРОВЕНЬ 30" in Russian goes under it).
		'class-card': { title: 'The Whirlwind Weapon class card at 34', lua: `${screen(1920, 1080, 1)}\n${CLASS_CARD}` },
	},
	// The Lua pieces, for scenarios that draw these cases on other surfaces (worst-case-looks).
	lua: { screen, fill, room, log34, log47, ALTS, CLASS_CARD },
};
