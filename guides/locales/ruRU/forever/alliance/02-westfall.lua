-- Russian (ruRU): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "",

	-- Step 3: The bridge
	["The bridge"] = "Мост",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "Лагерь – к северо-востоку от моста. Вязанки дров лежат вокруг лагеря и в лесу к северу от него.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}, внутри",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Оно лежит у реки к северо-западу от лесозаготовок.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Волшебники-плуты из Братства Справедливости стоят лагерем на берегах ({area:86}); с них падают и красные льняные банданы. {object:56} лежит в деревне мурлоков на северо-восточном берегу.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Красные льняные банданы",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "Лагеря гноллов",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Гноллы из стаи Речной Лапы стоят лагерем на холмах к западу (ориентир: {area:86}); {quest:91725} лежат в их лагерях.",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}: убивайте их по пути",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "Рудник – к юго-западу от лагерей гноллов. {item:247816} лежат у входа; туннели занимают кобольды-геоманты.",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476} ходит здесь: {area:54}: ищите внутри круга на карте",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "Идите по холмам на юг к башне.",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "Следуйте по дороге из Элвиннского леса в Зону {zone:1436}: супруги Хмуробров сидят у своей сгоревшей фермы — первой по дороге. Собирайте овес из каждого предмета {object:2724} по пути: остальное соберете на полях здесь на обратном пути.",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; люди взяли это у {npc:963} в Элвинне",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Только если вы добыли в Элвиннском лесу предмет {item:1972}: щелкните по нему правой кнопкой",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "На юг вдоль дороги, мимо развилки. {npc:233} стоит снаружи, {npc:235} — в доме, {npc:253395} — в амбаре к западу. Молодые жутевепри и шкуродёры бродят по полям вокруг фермы: по пути начните собирать печень и мясо для похлёбки.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235} – внутри",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "Рыла жутевепря",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "Молодые жутевепри роются в полях вдоль дороги на юг от фермы Сальденов до {area:108}: по пути собирайте их рыла.",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491} – внутри",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "",
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "",
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "",

	-- Step 22: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} и {npc:821} стоят на вершине каменной башни. {npc:491} – в башне; {npc:878} – на южном склоне холма, рядом с таверной и укротителем грифонов (это {npc:523}).",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092} – рядом с NPC {npc:878}",

	-- Step 24: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "",
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "",

	-- Step 25: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: шкуродеры",

	-- Step 26: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "",

	-- Step 27: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "",

	-- Step 28: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "",
	["Fill the vial at the farm's well"] = "Наполните склянку у колодца фермы",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Дозорные полей",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "Холмы гноллов",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Лапы гнолла",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Жабры мурлока с Бескрайнего берега",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "{object:290}; внутри",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "Мешки овса на полях вокруг фермы",
	["Fill the vial at the well"] = "Наполните склянку у колодца",

	-- Step 34: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "",

	-- Step 35: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "",

	-- Step 37: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "",

	-- Step 38: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Для NPC {npc:266} ({area:69}, Красногорье)",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Обратно на север мимо фермы ({area:918}) к руднику: внутри работают кобольды-землекопы.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Кобольды-землекопы",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "На юго-запад к побережью, к западу от фермы ({area:918}). В карьере работают шахтеры из стаи Речной Лапы.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Шахтеры из стаи Речной Лапы",

	-- Step 41: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20}: убивайте этих по пути",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "",

	-- Step 44: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "Из Зоны {zone:1436} идите в город {zone:1453}; поезд из города {zone:1455} прибывает сюда: {object:28027}. {npc:5480} обучает воинов ({object:2100}); там же у входа ({object:2152}) вместе стоят {npc:6089} и {npc:6090}. {npc:6090} сразится с вами за свою кружку. Если {npc:5480} не предлагает задание {quest:1638}, идите сразу к NPC {npc:6089}: он дает {quest:1639} и без него.",

	-- Step 46: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Идите в город {zone:1453}. {npc:376} – в Соборе Света.",

	-- Step 48: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171} и {npc:6173} – в Соборе Света; {npc:6174} стоит здесь: {object:2096}; она просит десять шт. {item:2589} (падает с гуманоидов; продается на аукционе).",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "Щелкните правой кнопкой по предмету {item:6775}, который он даст",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172} – у {area:86} в Элвиннском лесу, на дороге в Красногорье",

	-- Step 49: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 50: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Поезд до {zone:1455}",

	-- Step 51: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Отправляйтесь в {zone:1453}. Там нет учителя шаманов: от {object:28027} сядьте на {area:2257} до {zone:1455}, обучитесь у {npc:258098}, затем вернитесь на трамвае к кораблю.",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "",
	["In through the main gate (already done if you are in the city)"] = "",
	["Level 12, 14 and 16 spells"] = "Заклинания 12, 14 и 16-го уровней",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "Обратно: {zone:1453}",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} для задания «Сбор лекарственных ингредиентов» (6123), {zone:1439}: {npc:1313}, товары для алхимиков; травники вместо этого собирают его там сами",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Святилище волшебника: {quest:1861}",

	-- Step 56: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Раз уж вы здесь: изучите {spell:202} у NPC {npc:11867} ({object:2096}, 10 серебра); с двуручным оружием воин качается быстрее всего.",

	-- Step 57: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Раз уж вы здесь: изучите навык {spell:202} у NPC {npc:11867} ({object:2096}, 10 серебра); с двуручным оружием паладин качается быстрее всего.",

	-- Step 58: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Раз уж вы здесь: изучите владение посохами у NPC {npc:11867} ({object:2096}, 10 серебра); у оружия ближнего боя охотника важнее всего характеристики, а у двуручного их больше всего.",

	-- Step 59: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Раз уж вы здесь: изучите владение мечами у NPC {npc:11867} ({object:2096}, 10 серебра); с мечом в правой руке разбойник стабильно качается.",

	-- Step 60: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Раз уж вы здесь: изучите владение посохами у NPC {npc:11867} ({object:2096}, 10 серебра); при прокачке посох дает больше характеристик для заклинаний, чем одноручное оружие.",

	-- Step 62: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} продает рыболовные принадлежности у канала, чуть западнее (ориентир: {object:2096}); {npc:267118} рыбачит в гавани, по пути к кораблю.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}: продает {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "Назад: {area:108}",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "По поселению {area:20} ходят налетчики и кастетники из Братства Справедливости; проходимцы (17-й уровень) патрулируют парами холмы к югу и востоку от него: выманивайте их поодиночке. Вход в {area:1581} в кузнице ведет в групповое подземелье.",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "По поселению {area:20} ходят налетчики и кастетники из Братства Справедливости; проходимцы (17-й уровень) патрулируют парами холмы к югу и востоку от него: выманивайте их поодиночке. Вход в {area:1581} в кузнице ведет в групповое подземелье.\nОсторожно: в лагерях на холмах стоят смешанные группы Братства, при низком уровне легко выманить нескольких сразу.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Погромщики и мошенники из Братства Справедливости занимают фермы к западу (ориентир: {area:108}), между прибрежной дорогой и поселением {area:20}.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "Погромщики и мошенники из Братства Справедливости занимают фермы к западу (ориентир: {area:108}), между прибрежной дорогой и поселением {area:20}.\nОсторожно: в пещере ({area:113}) много членов Братства стоят плотно, там легко выманить сразу нескольких.",
	-- ["Defias Trappers and Smugglers camp in the fields between {area:108} and {area:918}.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone.\nYoung Goretusks and Fleshrippers roam every leg of this loop: their livers and meat are for the pie and the stew."] = "Звероловы и контрабандисты из Братства Справедливости стоят лагерем в полях между {area:108} и {area:918}.\nК западу от фермы Сальденов. На полях работают дозорные полей и уборочные големы; с них падают изопружины, гиростабилизаторы, {item:732}, а иногда и {item:255155}. Здесь бродит редкий противник 20-го уровня – {npc:573}: не трогайте его.\nНа каждом отрезке этого круга бродят молодые жутевепри и шкуродеры: их печень и мясо нужны для пирога и похлебки.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Летите или езжайте в город {zone:1453}. Учителя: {object:2100} (воины, разбойники), собор (паладины, жрецы), {object:2101} (маги, чернокнижники), парк (друиды).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Летите или езжайте в город {zone:1453}. Учителя: {object:2100} (воины, разбойники), собор (паладины, жрецы), {object:2101} (маги, чернокнижники), парк (друиды). {npc:11026} работает здесь: {object:28027}; {npc:279} – здесь: {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Летите или езжайте в город {zone:1453}. {npc:376} – в Соборе Света.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Летите или езжайте в город {zone:1453}. {npc:5480} обучает воинов ({object:2100}); там же у входа ({object:2152}) вместе стоят {npc:6089} и {npc:6090}. {npc:6090} сразится с вами за свою кружку.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Летите или идите в {zone:1453}. Учителя: {object:2100} (воины, разбойники), собор (паладины, жрецы), {object:2101} (маги, чернокнижники), парк (друиды).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Летите или идите в {zone:1453}. {npc:376} — в Соборе Света.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Летите или идите в {zone:1453}. {npc:5480} обучает воинов в {object:2100}; там же у {object:2152} вместе стоят {npc:6089} и {npc:6090}. {npc:6090} сразится с вами за свою кружку.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Следуйте по дороге из Элвиннского леса в {zone:1436}: семья Фёрлброу сидит у своей сгоревшей фермы — первой по дороге. Попутно собирайте овёс из мешков овса на полях.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Идите по дороге на север. {npc:233} стоит снаружи, {npc:235} – в доме, {npc:253395} – в амбаре к западу.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Для NPC {npc:11026} ({zone:1453}, {object:28027})",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Дальше на север по дороге. Супруги Хмуробров сидят у своей сгоревшей фермы. По пути собирайте овес из мешков овса на полях и наполните склянку у колодца усадьбы.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Дальше на север по дороге. Супруги Хмуробров сидят у своей сгоревшей фермы. По пути собирайте овес из мешков овса на полях.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Камень возвращения перезаряжается? Идите по дороге на северо-восток.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "На пляже к северу от рудника полно мурлоков-береговиков и мурлоков-налетчиков. При низком здоровье они убегают: выманивайте по одному.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "К северу от фермы Мольсена. Звероловы и контрабандисты из Братства Справедливости стоят лагерем у входа в рудник, внутри работают кобольды-землекопы. {object:290} – у разрушенного дома к востоку от рудника.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "К северу от фермы Мольсена. Звероловы и контрабандисты из Братства Справедливости стоят лагерем у входа в рудник. {object:290} – у разрушенного дома к востоку от рудника.",
	-- ["Only if he takes the isosprings alone"] = "Только если он принимает одни изопружины",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Езжайте в город {zone:1453}. Там нет учителя шаманов: в районе {object:28027} сядьте на поезд ({area:2257}) до города {zone:1455}, обучитесь у NPC {npc:258098} и вернитесь на поезде к кораблю.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Гноллы и разведчики Речной Лапы (11-13 уровень) бродят по холмам к югу от берега, от {area:111} на восток до {area:916}. Гноллы дальше к югу и западу — 13-19 уровня: держитесь северных холмов.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: {object:290} stands in the ruined house east of the mine, on the way to the {area:916}. Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "Гноллы и разведчики Речной Лапы (11-13 уровень) бродят по холмам к югу от берега, от {area:111} на восток до {area:916}. Гноллы дальше к югу и западу — 13-19 уровня: держитесь северных холмов.\nНа пляже к северу от рудника полно мурлоков-береговиков и мурлоков-налетчиков. При низком здоровье они убегают: выманивайте по одному.\nОсторожно: гноллы, стоящие рядом, часто вступают в бой группой. Безопаснее выманивать по одному.\nОсторожно: {object:290} стоит в разрушенном доме к востоку от рудника, по пути к {area:916}. Внутри на страже двое из Братства Справедливости, один из них – именной противник 15-го уровня {npc:502}. Они связаны: нападете на одного – придут оба.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Гноллы и разведчики из стаи Речной Лапы бродят по холмам между побережьем и {area:916}.",
	-- ["Sacks of Oats"] = "Мешки овса",
	-- ["Stormwind City"] = "Штормград",
	-- ["The gnoll hills"] = "Холмы гноллов",
	-- ["The north coast"] = "Северное побережье",
	-- ["The western farms"] = "Западные фермы",
	-- ["Walk to {zone:1453}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Идите в город {zone:1453} или летите, если знаете туда маршрут полета. Учителя: {object:2100} (воины, разбойники), собор (паладины, жрецы), {object:2101} (маги, чернокнижники), парк (друиды).",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "К западу от фермы Мольсена, в сторону побережья. В карьере работают шахтеры из стаи Речной Лапы.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "К западу от фермы Сальденов. На полях работают дозорные полей и уборочные големы; с них падают изопружины, гиростабилизаторы, {item:732}, а иногда и {item:255155}. Здесь бродит редкий противник 20-го уровня – {npc:573}: не трогайте его. На каждом отрезке этого круга продолжайте убивать жутевепрей и шкуродеров.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "По полям вокруг фермы бродят молодые жутевепри и шкуродеры: на обратном пути начинайте собирать печень и мясо для похлебки.",
	-- ["{area:109}: kill these as you meet them"] = "{area:109}: убивайте этих по пути",
	-- ["{area:20} and the Defias hills"] = "{area:20} и холмы Братства Справедливости",
	-- ["{area:918}: kill these as you meet them"] = "{area:918}: убивайте этих по пути",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}: из ящиков вокруг поселения {area:20}",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} и {npc:821} стоят на вершине каменной башни. {npc:491} – в башне; {npc:878} и {npc:253092} – на южном склоне холма, рядом с таверной и укротителем грифонов (это {npc:523}).",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}; от бесплатного полета откажитесь",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}: падают со всех членов Братства Справедливости",
	-- ["{quest:153}: every Defias drops them, from {area:111} to the {area:916}"] = "{quest:153}: падают со всех членов Братства Справедливости, от {area:111} до {area:916}",
}
