-- German (deDE): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} und {npc:821} stehen oben auf dem Steinturm. {npc:491} ist im Turm, {npc:878} und {npc:253092} auf der Südseite des Hügels, neben dem Gasthaus und {npc:523}, dem Greifenmeister.",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; überspring den kostenlosen Flug, den er anbietet",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Folge der Straße nach Norden. {npc:233} steht draußen, {npc:235} im Haus, {npc:253395} in der Scheune im Westen.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Weiter nördlich an der Straße. Die Furlbrows sitzen bei ihrem niedergebrannten Hof. Sammle unterwegs den Hafer aus den Hafersäcken auf den Feldern und füll die Phiole am Brunnen des Hofs.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Nur wenn du in Elwynn {item:1972} geplündert hast: Rechtsklicke sie",
	["Fill the vial at the well"] = "Füll die Phiole am Brunnen",
	["Sacks of Oats"] = "Hafersäcke",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Junge Geiferzähne und Fleischreißer streifen über die Felder um den Hof: Fang auf dem Rückweg schon mit Lebern und dem Fleisch für den Eintopf an.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "Westlich von Saldeans Hof. Erntebehüter und Erntegolems arbeiten auf den Feldern; sie lassen die Golemisofedern, Gyrostabilisatoren, {item:732} und manchmal {item:255155} fallen. {npc:573}, ein Rare der Stufe 20, läuft hier herum: Lass ihn in Ruhe. Töte auf jedem Abschnitt dieser Runde weiter Geiferzähne und Fleischreißer.",
	["Fill the vial at the farm's well"] = "Füll die Phiole am Brunnen des Hofs",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Erntebehüter",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Fleischreißer",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "Westlich von Molsens Hof, Richtung Küste. Minenarbeiter der Flusspfoten arbeiten im Steinbruch.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Minenarbeiter der Flusspfoten",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Nördlich von Molsens Hof. Fallensteller und Schmuggler der Defias lagern vor der Mine, Koboldbuddler arbeiten drinnen. {object:290} steht beim zerstörten Haus östlich der Mine.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Koboldbuddler",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: Jeder Defias lässt sie fallen",

	-- Step 8: The north coast
	["The north coast"] = "Die Nordküste",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Murlocküstenläufer und Murlocräuber säumen den Strand nördlich der Mine. Bei wenig Gesundheit fliehen sie: Zieh einen nach dem anderen.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Murlockiemen von Longshore",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "Die Gnollhügel",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolle und Späher der Flusspfoten streifen durch die Hügel zwischen der Küste und {area:916}.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Gnolltatzen",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "Nur wenn er die Golemisofedern allein annimmt",

	-- Step 13: The western farms
	["The western farms"] = "Die westlichen Höfe",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Plünderer und Ausplünderer der Defias halten die Höfe westlich von {area:108}, zwischen der Küstenstraße und {area:20}.",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} und die Hügel der Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Pfadpirscher und Knöchelhauer der Defias streifen durch {area:20}; Straßenräuber der Defias (Stufe 17) patrouillieren paarweise durch die Hügel südlich und östlich davon: Zieh sie auseinander. Der Eingang zu {area:1581} in der Schmiede ist ein Gruppendungeon.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, aus den Kisten rund um {area:20}",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Zurück nach {area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "Ruhestein noch nicht bereit? Folge der Straße nach Nordosten.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Für {npc:266} in {area:69}, Rotkammgebirge",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Für {npc:11026} in {object:28027} in {zone:1453}",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Flieg oder reite nach {zone:1453}. {npc:5480} bildet in {object:2100} Krieger aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Flieg oder reite nach {zone:1453}. {npc:376} ist in der Kathedrale des Lichts.",

	-- Step 19: Shaman training
	["Shaman training"] = "Schamanenausbildung",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Reite nach {zone:1453}. Dort gibt es keinen Schamanenlehrer: Nimm {area:2257} von {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück zum Schiff.",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Flieg oder reite nach {zone:1453}. Lehrer: {object:2100} (Krieger, Schurken), die Kathedrale (Paladine, Priester), {object:2101} (Magier, Hexenmeister), der Park (Druiden). {npc:11026} arbeitet in {object:28027}, {npc:279} in {object:2096}.",
	["Level 12, 14 and 16 spells"] = "Zauber der Stufen 12, 14 und 16",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} für Das Heilmittel sammeln (6123) in {zone:1439}: {npc:1313}, Alchemiebedarf; Kräuterkundige pflücken es stattdessen dort",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Magiersanktum: {quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} verkauft Angelbedarf am Kanal direkt westlich von {object:2096}; {npc:267118} angelt am Hafen, auf dem Weg zum Schiff.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, von {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolle und Späher der Flusspfoten streifen durch die Hügel zwischen der Küste und {area:916}.",
}
