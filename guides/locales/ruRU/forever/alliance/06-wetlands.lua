-- Russian (ruRU): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: соедините половинки здесь: {area:2362}",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Летите сюда: {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Распорядитель полетов: {area:442}",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "В зону {zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Корабль: {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 13: First Mate Fitzsimmons
	-- {quest:288} The Third Fleet · {zone:1440} Ashenvale · {npc:1239} First Mate Fitzsimmons · {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{quest:288}, if the {zone:1440} guide's Menethil stop didn't do it: {npc:1239} wants a {item:2594} from {npc:1464}, both in the inn."] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, в таверне",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}: продает {npc:1464}",

	-- Step 14: Menethil Harbor
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, на пирсе к северу от таверны",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, рядом с NPC {npc:2094} у причалов",

	-- Step 15: Harlo Barnaby
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it at {area:205}, at the north end of this visit's east loop"] = "",

	-- Step 16: Glorin Steelbrow
	-- {quest:270} The Doomed Fleet · {npc:1212} Bishop Farthing · {zone:1453} Stormwind City · {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {quest:321} Lightforge Iron · {item:279915} Nord'el
	["{quest:270}, from {npc:1212} in {zone:1453}: {npc:1217} stands in the {area:2104}, south of the keep. His {quest:321} lies in the wreck just south of town, by {item:279915}."] = "",
	["Inside"] = "Внутри",

	-- Step 17: James Halloran
	-- {area:17732} Excavation Site: Wetlands · {npc:2094} James Halloran
	["For your {area:17732} run, later in this guide: {npc:2094}, by the docks, wants hides from the raptors inside."] = "Для подземелья {area:17732}, позже в этом гайде: {npc:2094} у причалов просит шкуры ящеров, которые водятся внутри.",

	-- Step 18: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915} лежит на берегу чуть южнее места {area:150}, недалеко от южной окраины города. Затем идите вдоль побережья на север из города к хижинам.",

	-- Step 19: Waterlogged Chest
	-- {item:279915} Nord'el
	["The wreck of the Flying Osprey lies in the shallows south of the keep, beside {item:279915}."] = "",

	-- Step 20: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Слитки светлостали",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["The Bluegill Raiders (28-29) on the beach south-west of Menethil carry the ingots."] = "",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 21: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back north through Menethil: {npc:1217} is in the {area:2104}, on the way to the hovels."] = "",
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind City
	["For {npc:1416} in {zone:1453}, on this guide's {zone:1453} stop"] = "",

	-- Step 22: The Bluegill hovels
	["The Bluegill hovels"] = "Хижины Синежабрых",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "",

	-- Step 23: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039}: убивайте их по пути",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "",
	-- {npc:1158} Cursed Marine · {npc:270589} Nightveiled Rotheap
	["{npc:1158}; careful: {npc:270589}, a level 31 elite, roams this coast"] = "{npc:1158}; осторожно: по этому побережью бродит {npc:270589}, элитный противник 31-го уровня",

	-- Step 24: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, рядом с ним",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "Для NPC {npc:3649} ({area:442}), во время плавания по этому руководству: сохраните",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: для NPC {npc:2104} в крепости",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Для Верховного лорда Болвара Фордрагона ({object:2117}): сохраните",
	-- {npc:1239} First Mate Fitzsimmons · {npc:1160} Captain Halyndor
	["{npc:1239}: {npc:1160} (30) is for the end of this visit, from level 29"] = "",

	-- Step 25: Raptor valley
	["Raptor valley"] = "Долина ящеров",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "",

	-- Step 26: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "",

	-- Step 27: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118}: убивайте их по пути",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: work around them; don't pull them."] = "Реликвии лежат прямо на раскопках. {npc:1353}, крупный острозуб, рыщет в долине ящеров сразу к западу от них.\nСреди реликвий и у объекта {object:331} стоят хранители Гоаз (элитные, 32): обходите их стороной и не выманивайте.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 28: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} и Вельгар",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "",

	-- Step 29: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "",

	-- Step 30: Prospector Whelgar
	["Below ground"] = "Под землей",

	-- Step 31: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "",

	-- Step 32: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "",

	-- Step 33: Mosshide gnolls
	["Mosshide gnolls"] = "",
	-- {quest:277} Fire Taboo · {item:2611} Crude Flint · {area:309} Ironbeard's Tomb · {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Mosshide Brutes = {npc:1012} Mosshide Brute
	["{quest:277} is still short of its nine {item:2611}: the Mosshide Fenrunners and Trappers (22-24) along the river north-west of the Angerfang camp, south-west of {area:309}, drop them. Almost every one carries some.\nCareful: Maddened Rotclaws (25-26) roam the {area:1025} around {npc:1244}; Mosshide Brutes, Mystics and Alphas (24-27) hold the hills north-west of the Fenrunners' camp."] = "",

	-- Step 34: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "",

	-- Step 35: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",
	-- {area:1038} Dragonmaw Gates
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor · Fen Creepers = {npc:1040} Fen Creeper
	["Razormaw Incisors: from the raptors by the {area:1038}, after the Fen Creepers"] = "",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same walk"] = "",

	-- Step 36: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "",

	-- Step 37: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 38: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands · {zone:1424} Hillsbrad Foothills
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of the {zone:1424} guide"] = "",

	-- Step 39: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}: убивайте их по пути",
	-- {npc:1244} Rethiel the Greenwarden · {area:1036} Angerfang Encampment · {area:205} Dun Modr · {quest:98283} Carnage · {npc:270892} Goaz Warder · {area:1038} Dragonmaw Gates · {npc:270637} Howin Kindfeather
	-- plural, as words: Crimson Whelps = {npc:1069} Crimson Whelp · Highland Razormaws = {npc:1018} Highland Razormaw · Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["East from {npc:1244}: the Crimson Whelps (25-26) nest in the hills north-east of the {area:1036}, and the Highland Razormaws (27-28) hunt the highlands north of them, towards {area:205}. The Perfect Razormaw Eggs lie in the raptors' nests.\nCareful: {quest:98283}, an elite raptor, prowls the hills north of the whelps, and Ados, an elite {npc:270892} guardian, stands at the {area:1038}: give both room. The Dragonmaw east of {npc:270637} are elite too."] = "",

	-- Step 40: Longbraid the Grim
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North-west to the road and north along it to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites: keep to the road.\nCareful: Modr (32, elite) walks the {object:147516} ruins about 55 yards west of {npc:1075}; players have met it from the camp and the road: stay on the camp's east side."] = "",

	-- Step 41: Dun Modr
	-- {npc:1075} Rhag Garmason · {npc:1071} Longbraid the Grim · {area:205} Dun Modr · {object:147516} Dark Iron
	["{npc:1075} stands beside {npc:1071} in the dwarves' camp at {area:205}, east of the road; keep out of the {object:147516} ruins west of it, where Modr (32, elite) walks."] = "",

	-- Step 42: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Эбенезер Ржавый Засов",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. His parchment goes back to {npc:1075}.\nCareful: Two elite Dark Iron Saboteurs (28-29) stand by the corpse inside the span: loot the corpse and walk straight out without fighting, or, from level 31, pull them one at a time."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, внутри",
	["the same corpse"] = "",

	-- Step 43: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed. Keep to the camp's east side, away from Modr (32, elite) in the ruins."] = "",

	-- Step 44: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "{object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron · Dark Iron Shadowcasters = {npc:2577} Dark Iron Shadowcaster
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end.\nCareful: Dark Iron Shadowcasters (31-32) and Bombardiers (30-31), who fight from range, and a Supplier (31-32) stand within 15-25 yards of the cache: pull them one at a time to the bridge before you touch it."] = "",

	-- Step 45: Waterlogged Envelope
	-- {item:4433} Waterlogged Envelope · {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["In the river under the Arathi end of the span, a {item:4433} lies on the bottom: {npc:2695} in {zone:1455}, at the end of this guide, takes it."] = "",
	["Underwater"] = "Под водой",

	-- Step 46: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "Снова {npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road to {area:205}, on the camp's east side, away from Modr (32, elite) in the ruins."] = "",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands
	["For {npc:2700} at {area:320}, on your {zone:1417} visit (30-40)"] = "",

	-- Step 47: Howin Kindfeather
	-- {area:1025} Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["South along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",

	-- Step 48: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:260808} Highland Horror
	["For your {area:17732} run, on the way back west: {npc:1244} wants the root core of a {npc:260808} inside."] = "Для подземелья {area:17732}, по пути обратно на запад: {npc:1244} просит сердцевину корня, которую несет {npc:260808} внутри.",

	-- Step 49: Excavation Site: Wetlands
	-- {area:17732} Excavation Site: Wetlands · {npc:260808} Highland Horror · {npc:1244} Rethiel the Greenwarden · {npc:260326} Relic Guardian · {item:270865} Titan Relic · {npc:1077} Prospector Whelgar
	["{area:17732} is a dungeon for a group of five at about level 28 to 31. Its entrance lies just south of the road west, east of Whelgar's dig.\nInside: the Thicket raptors and Shadetooth drop the hides for Halloran, a {npc:260808} the root core for {npc:1244}. Saltspine, Shadetooth and the {npc:260326} are the bosses; the {npc:260326} drops a {item:270865}, which starts a quest for {npc:1077}."] = "{area:17732} – подземелье для группы из пяти игроков, примерно 28-31-й уровень. Вход – чуть южнее дороги на запад, к востоку от раскопа Велгара.\nВнутри: с ящеров Thicket и Shadetooth падают шкуры для Халлорана, с NPC {npc:260808} – сердцевина корня для NPC {npc:1244}. Saltspine, Shadetooth и {npc:260326} – боссы; с NPC {npc:260326} падает {item:270865}: этот предмет начинает задание для NPC {npc:1077}.",
	-- {quest:98815} Highland Hides
	["{quest:98815}: the hides, inside"] = "{quest:98815}: шкуры, внутри",
	-- {quest:95646} Horrors in the Highland
	["{quest:95646}: the root core, inside"] = "{quest:95646}: сердцевина корня, внутри",

	-- Step 50: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, west of the entrance on the way back west."] = "{item:270865} из подземелья {area:17732}: {npc:1077} – под землей в своем раскопе, к западу от входа, по пути обратно на запад.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, под землей",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: для NPC {npc:5387} в городе {zone:1455}, в конце этого гайда",

	-- Step 51: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	-- was: ["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:2094} by the docks on the way to the boat."] = "Используйте камень возвращения, чтобы вернуться сюда: {area:150}, если вы привязаны к таверне ({area:2104}), или идите на запад по дороге: {npc:2104} стоит на верхнем этаже ({area:2103}), {npc:2094} – у причалов по пути к кораблю."
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:2094} by the docks."] = "",
	["On the top floor"] = "",
	-- {zone:1437} Wetlands · {zone:1424} Hillsbrad Foothills
	["For the Dragonmaw catapult, on the {zone:1437} loop of the {zone:1424} guide"] = "",
	-- {npc:2094} James Halloran · {npc:270637} Howin Kindfeather · {zone:1437} Wetlands · {zone:1424} Hillsbrad Foothills
	["{npc:2094}: the crate for {npc:270637}, on the {zone:1437} loop of the {zone:1424} guide"] = "",

	-- Step 52: Captain Halyndor
	-- {npc:1160} Captain Halyndor · {npc:270589} Nightveiled Rotheap · {zone:1437} Wetlands
	-- plural, as words: Cursed Marines = {npc:1158} Cursed Marine
	["From level 29: north along the coast from Menethil to the wreck of the Intrepid. {npc:1160} (30) is aboard, and the locked strongbox sits in the wreck.\nCareful: Cursed Marines (27-28) crowd the deck around him: clear them first. {npc:270589}, a level 31-32 elite, roams the {zone:1437}: give it a wide berth."] = "",
	-- {item:2629} Intrepid Strongbox Key · {npc:1160} Captain Halyndor
	["{item:2629}, from {npc:1160}"] = "{item:2629} – от NPC {npc:1160}",

	-- Step 53: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back south to Menethil: {npc:1217} stands in the {area:2104}."] = "Назад на юг в Менетил: {npc:1217} стоит в таверне ({area:2104}).",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Для NPC {npc:1284} ({zone:1453}), в конце этого гайда",

	-- Step 54: Level 28
	["Level 28"] = "28-й уровень",
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Still below level 28? That happens when you start this guide here without the {zone:1437} and {zone:1440} quests of the guides before it: top up on the Bluegill Raiders along the coast just south of Menethil before the boat, so {zone:1440}'s level 28-32 quests aren't too hard."] = "Еще не достигли 28-го уровня? Так бывает, если начать этот гайд здесь без заданий зон {zone:1437} и {zone:1440} из предыдущих гайдов: доберите опыт на налетчиках из племени Синежабрых вдоль побережья чуть южнее Гавани Менетилов перед кораблем, чтобы задания 28-32-го уровня в зоне {zone:1440} не оказались слишком трудными.",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "убивайте цель {npc:1418}",

	-- Step 55: James Halloran
	-- {npc:2094} James Halloran
	["Your Excavation Site hides: {npc:2094}, by the docks."] = "Шкуры с места раскопок: {npc:2094}, у причалов.",

	-- Step 56: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "",

	-- Step 57: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649} стоит в северной части места {area:442}, вверх по дороге от причала.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}: от NPC {npc:270844} ({area:150})",

	-- Step 58: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "",
	-- {zone:1439} Darkshore · {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on the {zone:1439} return's first {area:442} stop)"] = "",

	-- Step 59: Auberdine
	-- {npc:3693} Terenthis · {quest:990} Trek to Ashenvale · {npc:3694} Sentinel Selarin
	["{npc:3693} stands by the flight master. No {quest:990} yet? Give it a minute after the hand-in: {npc:3694} comes to {npc:3693}'s side shortly after Volcor's escort is handed in. Changing layer can also find her."] = "{npc:3693} стоит рядом с распорядителем полетов. Задания {quest:990} еще нет? Подождите минуту после сдачи: {npc:3694} подходит к NPC {npc:3693} вскоре после того, как сдано задание на сопровождение Волкора. Также ее можно найти, сменив слой.",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}: сопровождение Волкора в конце гайда по зоне {zone:1439}",
	-- {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, once she comes: {quest:990}, for {npc:3691} in {area:415}"] = "{npc:3694}, когда она появится: {quest:990}, для NPC {npc:3691} ({area:415})",

	-- Step 60: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["Your {area:2797} brain stems: {npc:8997} stands a short walk west of {npc:3693}."] = "Стволы мозга из подземелья {area:2797}: {npc:8997} стоит чуть западнее NPC {npc:3693}.",

	-- Step 61: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Летите сюда: {area:415}",

	-- Step 62: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {npc:3970} Llana · {area:415} Astranaar
	["{npc:3845} and {npc:3970} stand by {area:415}'s flight master."] = "{npc:3845} и {npc:3970} стоят рядом с распорядителем полетов ({area:415}).",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "",
	-- {npc:3970} Llana · {quest:95737} Seeking Caitlin · {npc:1480} Caitlin Grassman · {area:150} Menethil Harbor
	["{npc:3970}: {quest:95737}, for {npc:1480} in {area:150}"] = "{npc:3970}: {quest:95737}, для NPC {npc:1480} ({area:150})",

	-- Step 63: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, внутри",

	-- Step 64: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691} stands in the inn, beside the innkeeper."] = "{npc:3691} стоит в таверне, рядом с хозяином таверны.",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {zone:1439} Darkshore
	["{npc:3691}: {quest:990}, if you still carry it from {zone:1439}"] = "{npc:3691}: {quest:990}, если это задание из зоны {zone:1439} еще у вас",

	-- Step 65: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, at the inn, if you missed her first visit"] = "",

	-- Step 66: Teronis' Corpse
	-- {area:415} Astranaar · {area:441} Lake Falathim
	["Go west from {area:415} to {area:441}. Teronis lies on the shore among the Saltspittle murlocs."] = "",

	-- Step 67: Glowing Gem
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["The Saltspittle murlocs around Teronis at {area:441} drop the {item:5463}."] = "",

	-- Step 68: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Мелирия и {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "",

	-- Step 69: Therysil
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["{npc:3585} stands at the {area:416}, a short walk from Melyria and {npc:3901}."] = "{npc:3585} стоит здесь: {area:416}, недалеко от Мелирии и NPC {npc:3901}.",
	-- {npc:3585} Therysil · {quest:945} Therylune's Escape · {zone:1439} Darkshore
	["{npc:3585}: {quest:945}, if you still carry it from {zone:1439}"] = "{npc:3585}: {quest:945}, если это задание из зоны {zone:1439} еще у вас",

	-- Step 70: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3691}, at the {area:415} inn"] = "",

	-- Step 71: Raene Wolfrunner's delivery
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}'s delivery"] = "",
	-- {npc:3916} Shael'dryn
	["Take her message to {npc:3916} on the way east"] = "",

	-- Step 72: Raene Wolfrunner's message
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}'s message"] = "",
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}. {npc:3916} stands by the moonwell."] = "",

	-- Step 73: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Идите по дороге на восток сюда: {area:419}; {npc:3916} стоит у лунного колодца.",

	-- Step 74: Dartol's Rod
	["Dartol's Rod"] = "Жезл Дартола",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "{item:5475} у безумных и высохших древняков к северу от лунного колодца; старый сундук, который он открывает, стоит среди них.",

	-- Step 76: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Идите по дороге на восток к лагерям сатиров ({area:429}); {npc:3920} прячется на их окраине.",
	-- {npc:3920} Anilia · {quest:1031} The Branch of Cenarius · {npc:4619} Geltharis
	["{npc:3920}: {quest:1031}, from {npc:4619} (level 32): a fight for a group at this level"] = "{npc:3920}: {quest:1031}, с NPC {npc:4619} (32-й уровень): на этом уровне бой для группы",

	-- Step 77: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch. He is level 32, above you here, among level 29-30 satyrs: grouping up is advised."] = "{npc:4619} ведет сатиров ({area:429}); ветвь у него. Он 32-го уровня, выше вас, и окружен сатирами 29-30-го уровня: лучше собрать группу.",

	-- Step 78: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоит {npc:3848}, а {npc:221269} — в нескольких шагах к востоку от нее.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}: следы ее мужа ({area:430}), на обратном пути от озера",

	-- Step 79: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}: убивайте их по пути",
	-- {area:2358} Forest Song · {object:19021} Rusty Chest
	-- plural, as words: Rotting Slimes = {npc:3928} Rotting Slime
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRotting Slimes in and around the Barrow Den leave a {object:19021} when they die: open the chests until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 80: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: для NPC {npc:3961} ({area:415})",

	-- Step 81: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "От озера идите на север к лагерю сатиров ({area:430}), чуть западнее места {area:2358}: там стоит {object:19901}, а рядом лежит {object:673431}, в нем {item:281014}.\nОсторожно: разбойники Скверного Мускуса здесь ({area:428}) часто скрываются в незаметности, а в лагере ({area:430}) есть сатиры-заклинатели.",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "{item:281014}: {object:673431}",

	-- Step 82: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, в нескольких шагах к востоку",

	-- Step 83: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "",

	-- Step 84: Insane druids
	["Insane druids"] = "Обезумевшие друиды",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, внутри: {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, внутри: {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, внутри: {area:432}",

	-- Step 86: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Второй {object:19901} — в долине ({area:428}), по пути на запад.",

	-- Step 88: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Святилище стоит на холме чуть юго-восточнее лунного колодца; поднимитесь по извилистой тропе.",

	-- Step 90: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Пройдите по туннелю сюда: {area:419}; фолиант лежит в руинах в западной части. Осторожно: потрошители и ткачи теней из стаи Ужасоволков (28-30) стоят плотными группами вокруг фолианта, а по долине ходит {npc:3792}, редкий противник 32-го уровня. Выманивайте волков по одному из туннеля и сначала пропустите вожака стаи.",

	-- Step 91: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}, в таверне",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "",

	-- Step 92: Raene Wolfrunner
	-- {zone:1440} Ashenvale · {npc:3691} Raene Wolfrunner · {quest:1025} An Aggressive Defense · {npc:3897} Krolg · {quest:1054} Culling the Threat · {npc:3987} Dal Bloodclaw · {area:413} Maestra's Post
	["Not done on your first {zone:1440} visit? {npc:3691} also has {quest:1025} (the Foulweald, on the way to {npc:3897}) and {quest:1054} ({npc:3987}, on the way back from {area:413})."] = "",

	-- Step 93: The Foulweald
	["The Foulweald"] = "Гиблая Чаща",
	-- {npc:3897} Krolg · {area:415} Astranaar
	["On the way south-east to {npc:3897}: the Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "По пути на юго-восток к NPC {npc:3897}: фурболги из Гиблолесья живут в лесу к югу от дороги, к юго-востоку от места {area:415}. Логово охраняют дозорный логова и урсы.",

	-- Step 94: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:3897} Krolg · {npc:12759} Tideress
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}, just north of the road to {npc:3897}. Befouled Water Elementals wade in the lake; {npc:12759}, a level 27 water elemental, walks among them and drops the bracers too."] = "{npc:3885} стоит здесь: {area:420}, на восточном берегу ({area:421}), чуть севернее дороги к NPC {npc:3897}. В озере бродят злобные элементали воды; среди них ходит {npc:12759}, элементаль воды 27-го уровня, с нее тоже падают наручи.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Убивайте элементалей ради 5 неповрежденных браслетов элементаля, затем используйте {item:5456}",

	-- Step 95: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}, фурболг, не тронутый порчей, сидит к югу от дороги ниже места {area:421}. Сначала используйте рядом с ним {item:5462}: он говорит с вами только в облике фурболга.",

	-- Step 96: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}, у персонажа {npc:3696}",

	-- Step 98: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "",
	-- {npc:3880} Sentinel Melyria Frostshadow · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus · {area:442} Auberdine
	["{npc:3880}: for {npc:8026} in {zone:1457}, a hop from {area:442} on the way to the boat"] = "",

	-- Step 99: Illiyana
	-- {npc:3901} Illiyana
	["{npc:3901} stands beside Melyria."] = "{npc:3901} стоит рядом с Мелирией.",
	-- {npc:3901} Illiyana · {item:5461} Branch of Cenarius
	["{npc:3901}: the {item:5461}"] = "{npc:3901}: {item:5461}",

	-- Step 100: The Branch of Cenarius, taken alone
	-- {quest:1031} The Branch of Cenarius
	["{quest:1031}, taken alone"] = "{quest:1031}, взято в одиночку",
	-- {quest:1031} The Branch of Cenarius · {npc:4619} Geltharis
	["Not grouped? {quest:1031} ({npc:4619}, 32) is a fight for a group at this level: abandon it, the route doesn't come back for it."] = "Без группы? {quest:1031} ({npc:4619}, 32) – на этом уровне бой для группы: откажитесь от задания, маршрут к нему не вернется.",

	-- Step 101: Insane Druids, taken alone
	-- {quest:1012} Insane Druids
	["{quest:1012}, taken alone"] = "{quest:1012}, взято в одиночку",
	-- {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Not grouped? {quest:1012} (the {area:432}) is a fight for a group at this level: abandon it, the route doesn't come back for it."] = "Без группы? {quest:1012} ({area:432}) – на этом уровне бой для группы: откажитесь от задания, маршрут к нему не вернется.",

	-- Step 102: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {quest:967} The Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3663}: {quest:967}, if you still carry it from {zone:1439}"] = "{npc:3663}: {quest:967}, если это задание из зоны {zone:1439} еще у вас",

	-- Step 103: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "",

	-- Step 104: Dal Bloodclaw
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3987} Dal Bloodclaw
	["From {area:413}, east to the Thistlefur camp north of {area:415}: {npc:3987} leads the furbolgs there. Then south to {area:415}.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "От места {area:413} идите на восток к лагерю Чертополоховых к северу от места {area:415}: там фурболгов ведет {npc:3987}. Затем на юг ({area:415}).\nОсторожно: фурболги рядом с ним обычно вступают в бой, когда его выманивают. Убейте сначала тех, что на его пути, чтобы сразиться с ним один на один.",

	-- Step 105: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["Back east along the road from {area:413} to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "",

	-- Step 106: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Летите сюда: {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Распорядитель полетов: {area:415}",

	-- Step 107: Fly to Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["From {area:442}'s flight master, a short flight over the water to {area:702}."] = "",

	-- Step 108: Into Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Through the pink portal at {area:702}, up into {zone:1457}."] = "",

	-- Step 109: Thyn'tel Bladeweaver
	-- {npc:8026} Thyn'tel Bladeweaver · {area:1660} Warrior's Terrace · {object:19877} Velinde's Locker
	["{npc:8026} stands on the {area:1660} in the north of the city; {object:19877} is in the south of it."] = "",

	-- Step 110: Velinde's Locker
	-- {item:5520} Velinde's Journal · {object:19877} Velinde's Locker
	["{item:5520}, in {object:19877}"] = "",

	-- Step 111: Thyn'tel Bladeweaver
	-- {npc:8026} Thyn'tel Bladeweaver · {npc:3453} Wharfmaster Dizzywig · {area:392} Ratchet · {zone:1445} Dustwallow Marsh
	["{npc:8026}: for {npc:3453} in {area:392}, on your {zone:1445} trip at about 33 (30-40)"] = "",

	-- Step 112: Fly to Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine
	["Back through the portal to {area:702} and fly to {area:442} for the boat."] = "",

	-- Step 114: Caitlin Grassman
	-- {npc:1480} Caitlin Grassman
	["Off the boat, {npc:1480} stands beside Menethil's inn, on the way to the flight master."] = "Сойдя с корабля, найдите NPC {npc:1480} у таверны Менетила, по пути к распорядителю полетов.",

	-- Step 115: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Лететь в {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Распорядитель полетов: {area:150}",

	-- Step 117: High Explorer Magellas
	-- {quest:98824} Prehistoric Prism · {npc:5387} High Explorer Magellas · {object:32356} Hall of Explorers · {object:32372} Great Forge
	["{quest:98824}: {npc:5387} stands in the {object:32356}, north-east of the {object:32372}."] = "{quest:98824}: {npc:5387} стоит здесь: {object:32356}, к северо-востоку от места {object:32372}.",

	-- Step 118: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Жрецы: {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} и {npc:258785} находятся здесь: {object:32386} ({object:32362}).",

	-- Step 119: Sara Balloo
	-- {area:880} Thandol Span · {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["Sully Balloo's letter, from the {area:880}: {npc:2695} takes it here in {zone:1455}."] = "",
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695}: для короля Магни, в ту же остановку ({zone:1455})",

	-- Step 120: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784} holds court in the {object:171709}."] = "",

	-- Step 121: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "Поезд до {zone:1453}",

	-- Step 122: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square
	["{npc:1646} stands in the {object:2098}."] = "{npc:1646} стоит здесь: {object:2098}.",
	-- {npc:1646} Baros Alexston · {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver
	["{npc:1646}: {quest:97914}, {npc:3649}'s letter, if you still carry it"] = "{npc:1646}: {quest:97914}, письмо от NPC {npc:3649}, если оно еще у вас",

	-- Step 123: Grimand Elmore
	-- {object:28027} Dwarven District · {npc:1416} Grimand Elmore
	["The tram comes in at the {object:28027}: {npc:1416} works at the forge there."] = "",
	-- {npc:1416} Grimand Elmore · {quest:322} Blessed Arm · {npc:1217} Glorin Steelbrow
	["{npc:1416}: {quest:322}, from {npc:1217} in Menethil"] = "",

	-- Step 124: Cathedral of Light
	["Cathedral of Light"] = "Собор Света",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Сядьте на поезд ({area:2257}) в месте {object:171524} до места {object:28027} ({zone:1453}), затем идите сюда: {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, в Соборе Света",

	-- Step 125: Archbishop Benedictus
	-- {quest:293} Cleansing the Eye · {npc:1217} Glorin Steelbrow · {npc:1284} Archbishop Benedictus
	["{quest:293}, from {npc:1217} in Menethil: {npc:1284} stands in the Cathedral of Light."] = "",

	-- Step 126: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Только если вы добыли {quest:337} в зоне {zone:1431}",

	-- Step 127: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Вернитесь в Собор Света: {npc:928} стоит внутри.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Для NPC {npc:2228} ({area:271}): сохраните",

	-- Step 128: Warden Thelwater
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square
	["For your {area:717} run: {npc:1719} keeps the {area:717}'s gate, south of the {object:2098}."] = "Для подземелья {area:717}: {npc:1719} охраняет ворота ({area:717}) к югу от места {object:2098}.",

	-- Step 129: Warden Thelwater
	-- {npc:1719} Warden Thelwater · {quest:389} Bazil Thredd · {npc:1646} Baros Alexston
	["{npc:1719}: {quest:389}, from {npc:1646}"] = "{npc:1719}: {quest:389}, от NPC {npc:1646}",

	-- Step 131: Stockade
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square · {npc:1663} Dextren Ward · {quest:389} Bazil Thredd
	["{area:717} is a dungeon for a group of five, about levels 23 to 29, and a run takes under an hour. Its gate is {npc:1719}'s, south of the {object:2098}.\nInside: the Defias prisoners, convicts and insurgents for Thelwater, {npc:1663}'s hand for Millstipe, and {quest:389} at the far end."] = "{area:717} – подземелье для группы из пяти игроков, примерно 23-29-й уровень; прохождение занимает меньше часа. Его ворота охраняет {npc:1719}, к югу от места {object:2098}.\nВнутри: заключенные, каторжники и повстанцы из Братства Справедливости для Телвотера, рука NPC {npc:1663} для Миллстайпа и цель задания «{quest:389}» в дальнем конце.",

	-- Step 132: Warden Thelwater
	-- {npc:1719} Warden Thelwater
	["{npc:1719}, at the gate"] = "{npc:1719}, у ворот",

	-- Step 134: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} и {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, сырная лавка ({object:2096})",

	-- Step 135: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Далее: летите сюда: {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:2094} by the docks on the way to the boat."] = "Используйте камень возвращения, чтобы вернуться сюда: {area:150}, если вы привязаны к таверне ({area:2104}), или идите на запад по дороге: {npc:2104} стоит на верхнем этаже ({area:2103}), {npc:2094} – у причалов по пути к кораблю.",
	-- ["South from {npc:3987}'s camp to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "От лагеря NPC {npc:3987} на юг, сюда: {area:415}. {npc:3691} – в таверне, распорядитель полетов – в западном конце.",
	-- ["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Капитан ходит по палубе разбитого корабля; его сундук стоит в трюме.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "Реликвии лежат прямо на раскопках. {npc:1353}, крупный острозуб, рыщет в долине ящеров сразу к западу от них.\nСреди реликвий и у объекта {object:331} стоят хранители Гоаз (элитные, 32): выманивайте их по одному или обходите стороной.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоит {npc:3848}.",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, в таверне",
	-- ["{npc:3691}: {quest:1025}, the Foulweald on the way to {npc:3897}"] = "{npc:3691}: {quest:1025}, Гиблолесье по пути к NPC {npc:3897}",
	-- ["{npc:3691}: {quest:1054}, {npc:3987} on the way back from {area:413}"] = "{npc:3691}: {quest:1054}, {npc:3987} на обратном пути от места {area:413}",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, фурболг, не тронутый порчей, сидит к югу от дороги ниже места {area:421}.",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} ведет сатиров ({area:429}); ветвь у него.",
}
