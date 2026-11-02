-- German (deDE): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Jansen Stead
	-- {area:40} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {area:40}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; Menschen haben es von {npc:963} in Elwynn genommen",

	-- Step 3: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Nur wenn du in Elwynn {item:1972} geplündert hast: Rechtsklicke sie",

	-- Step 4: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Südlich der Straße, vorbei an der Gabelung. {npc:233} steht draußen, {npc:235} im Haus, {npc:253395} in der Scheune im Westen. Junge Hauerzähne und Fleischreißer streifen um die Felder der Farm: Beginne unterwegs mit Lebern und dem Eintopffleisch.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "",

	-- Step 5: Goretusk Snout on the way
	-- {item:731} Goretusk Snout
	["{item:731} on the way"] = "",

	-- Step 6: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} und {npc:821} stehen oben auf dem Steinturm. {npc:491} ist im Turm, {npc:878} auf der Südseite des Hügels, neben dem Gasthaus und {npc:523}, dem Greifenmeister.",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; überspring den kostenlosen Flug, den er anbietet",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, neben {npc:878}",

	-- Step 8: Westfall: kill these as you meet them
	-- {area:40} Westfall
	["{area:40}: kill these as you meet them"] = "",
	-- {object:290} Furlbrow's Wardrobe · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Harvest Watchers = {npc:114} Harvest Watcher
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Erntebehüter",

	-- Step 10: The Jansen Stead
	["Fill the vial at the well"] = "Füll die Phiole am Brunnen",

	-- Step 11: Westfall: kill these as you meet them
	["Fill the vial at the farm's well"] = "Füll die Phiole am Brunnen des Hofs",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Fleischreißer",

	-- Step 12: Furlbrow's Pumpkin Farm: kill these as you meet them
	-- {area:109} Furlbrow's Pumpkin Farm
	["{area:109}: kill these as you meet them"] = "",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll · Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: Two Defias stand guard inside the house, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: Jeder Defias lässt sie fallen",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Gnolltatzen",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Murlockiemen von Longshore",

	-- Step 13: Handful of Oats
	["Sacks of Oats in the fields around the farm"] = "Haferbündel auf den Feldern rund um die Farm",

	-- Step 15: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Für {npc:266} in {area:69}, Rotkammgebirge",

	-- Step 16: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Zurück nach Norden an {area:918} vorbei zur Mine: Koboldbuddler arbeiten drinnen.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Koboldbuddler",

	-- Step 17: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Nach Südwesten zur Küste, westlich von {area:918}. Minenarbeiter der Flusspfoten arbeiten im Steinbruch.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Minenarbeiter der Flusspfoten",

	-- Step 18: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",

	-- Step 20: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} und die Hügel der Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, aus den Kisten rund um {area:20}",

	-- Step 21: Hearth to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Hearth to {area:108}"] = "",

	-- Step 22: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Zurück nach {area:108}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Für {npc:11026} in {object:28027} in {zone:1453}",

	-- Step 26: Defensive Stance
	["Defensive Stance"] = "",
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Flieg oder geh nach {zone:1453}. {npc:5480} bildet in {object:2100} Krieger aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",
	-- {npc:6089} Harry Burlguard
	["{npc:6089}: Defensive Stance"] = "",

	-- Step 28: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Flieg oder geh nach {zone:1453}. {npc:376} ist in der Kathedrale des Lichts.",

	-- Step 30: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "",

	-- Step 32: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 33: Shaman training
	["Shaman training"] = "Schamanenausbildung",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Geh nach {zone:1453}. Dort gibt es keinen Schamanen-Lehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahre dann die Straßenbahn zurück für das Schiff.",

	-- Step 34: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Flieg oder geh nach {zone:1453}. Lehrer: {object:2100} (Krieger, Schurken), die Kathedrale (Paladine, Priester), {object:2101} (Magier, Hexenmeister), der Park (Druiden).",
	["Level 12, 14 and 16 spells"] = "Zauber der Stufen 12, 14 und 16",

	-- Step 35: Back to Stormwind City
	-- {area:1519} Stormwind City
	["Back to {area:1519}"] = "",

	-- Step 37: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} für Das Heilmittel sammeln (6123) in {zone:1439}: {npc:1313}, Alchemiebedarf; Kräuterkundige pflücken es stattdessen dort",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Magiersanktum: {quest:1861}",

	-- Step 39: Stormwind City
	["Stormwind City"] = "",

	-- Step 40: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 42: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 43: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 44: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 46: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} verkauft Angelbedarf am Kanal direkt westlich von {object:2096}; {npc:267118} angelt am Hafen, auf dem Weg zum Schiff.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, von {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Pfadpirscher und Knöchelhauer der Defias streifen durch {area:20}; Straßenräuber der Defias (Stufe 17) patrouillieren paarweise durch die Hügel südlich und östlich davon: Zieh sie auseinander. Der Eingang zu {area:1581} in der Schmiede ist ein Gruppendungeon.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Plünderer und Ausplünderer der Defias halten die Höfe westlich von {area:108}, zwischen der Küstenstraße und {area:20}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Flieg oder reite nach {zone:1453}. Lehrer: {object:2100} (Krieger, Schurken), die Kathedrale (Paladine, Priester), {object:2101} (Magier, Hexenmeister), der Park (Druiden).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Flieg oder reite nach {zone:1453}. Lehrer: {object:2100} (Krieger, Schurken), die Kathedrale (Paladine, Priester), {object:2101} (Magier, Hexenmeister), der Park (Druiden). {npc:11026} arbeitet in {object:28027}, {npc:279} in {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Flieg oder reite nach {zone:1453}. {npc:376} ist in der Kathedrale des Lichts.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Flieg oder reite nach {zone:1453}. {npc:5480} bildet in {object:2100} Krieger aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Folge der Straße aus Elwynn nach {zone:1436}: Die Furlbrows sitzen bei ihrem niedergebrannten Hof, dem ersten an der Straße. Sammle unterwegs den Hafer aus den Hafersäcken auf den Feldern.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "Folge der Straße von Elwynn nach {zone:1436}: Die Furlbrows wohnen bei ihrer abgebrannten Farm, die erste Familie an der Straße. Nimm Hafer von jedem {object:2724} mit, an dem du auf der Runde vorbeikommst: Der Rest wird auf dem Rückweg auf den Feldern hier gesammelt.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Folge der Straße nach Norden. {npc:233} steht draußen, {npc:235} im Haus, {npc:253395} in der Scheune im Westen.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Weiter nördlich an der Straße. Die Furlbrows sitzen bei ihrem niedergebrannten Hof. Sammle unterwegs den Hafer aus den Hafersäcken auf den Feldern und füll die Phiole am Brunnen des Hofs.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Weiter nördlich an der Straße. Die Furlbrows sitzen bei ihrem niedergebrannten Hof. Sammle unterwegs den Hafer aus den Hafersäcken auf den Feldern.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Ruhestein noch nicht bereit? Folge der Straße nach Nordosten.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Murlocküstenläufer und Murlocräuber säumen den Strand nördlich der Mine. Bei wenig Gesundheit fliehen sie: Zieh einen nach dem anderen.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Nördlich von Molsens Hof. Fallensteller und Schmuggler der Defias lagern vor der Mine, Koboldbuddler arbeiten drinnen. {object:290} steht beim zerstörten Haus östlich der Mine.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Nördlich von Molsens Hof. Fallensteller und Schmuggler der Defias lagern vor der Mine. {object:290} steht beim zerstörten Haus östlich der Mine.",
	-- ["Only if he takes the isosprings alone"] = "Nur wenn er die Golemisofedern allein annimmt",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Reite nach {zone:1453}. Dort gibt es keinen Schamanenlehrer: Nimm {area:2257} von {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück zum Schiff.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Flusszahngnolle und -späher (Stufe 11-13) streifen durch die Hügel südlich der Küste, von oberhalb {area:111} ostwärts bis zur {area:916}. Die Gnolle weiter südlich und westlich sind Stufe 13-19: Bleib in den nördlichen Hügeln.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolle und Späher der Flusspfoten streifen durch die Hügel zwischen der Küste und {area:916}.",
	-- ["Sacks of Oats"] = "Hafersäcke",
	-- ["The gnoll hills"] = "Die Gnollhügel",
	-- ["The north coast"] = "Die Nordküste",
	-- ["The western farms"] = "Die westlichen Höfe",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "Westlich von Molsens Hof, Richtung Küste. Minenarbeiter der Flusspfoten arbeiten im Steinbruch.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "Westlich von Saldeans Hof. Erntebehüter und Erntegolems arbeiten auf den Feldern; sie lassen die Golemisofedern, Gyrostabilisatoren, {item:732} und manchmal {item:255155} fallen. {npc:573}, ein Rare der Stufe 20, läuft hier herum: Lass ihn in Ruhe. Töte auf jedem Abschnitt dieser Runde weiter Geiferzähne und Fleischreißer.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Junge Geiferzähne und Fleischreißer streifen über die Felder um den Hof: Fang auf dem Rückweg schon mit Lebern und dem Fleisch für den Eintopf an.",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} und {npc:821} stehen oben auf dem Steinturm. {npc:491} ist im Turm, {npc:878} und {npc:253092} auf der Südseite des Hügels, neben dem Gasthaus und {npc:523}, dem Greifenmeister.",
}
