-- German (deDE): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- {object:1661} The Undercity · {object:36078} Trade Quarter
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Der Flugmeister von {object:1661} ist im Westturm des {object:36078}, außerhalb der Mauern.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Die Gegenstände für {quest:5168} liegen in den späteren Gebieten der Pestländer: Behalte sie.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Seuchenhunde und ihre Kleinen streifen an den Ufern des Sees südwestlich der Kapelle umher.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "Zertrümmertes Schwert von Marduk",
	["The shattered sword lies on the ground north-west of the lake."] = "Das zertrümmerte Schwert liegt nordwestlich des Sees auf dem Boden.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "{area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Der Schädel liegt in {area:2622}, zwischen Verseuchten Schrecken und Seuchenmonstern.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "Hameyas Schriftrolle",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Eine zerrissene Schriftrolle liegt am Eingang von {area:2261}, der Gruft südlich von {area:2260}.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}.",

	-- Step 8: The western hills
	["The western hills"] = "Die westlichen Hügel",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Kleine Seuchenhunde und Seuchenfledermäuse streifen durch die Hügel nördlich von {area:2260}, Aaslarven kriechen zwischen ihnen; arbeite dich nach Norden Richtung {area:2627} vor.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Der Geist {npc:11140} steht bei einer Hütte im {area:2627}, in der Nordwestecke.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Die Waldläufer, Pfadschreiter und Waldmänner der Hochelfen bewachen die Lodge beim {area:2275}; das Register liegt drinnen. Waldläufer erreichen Stufe 60: Zieh sie einzeln. Giftige Seuchenfledermäuse fliegen auf dem Weg über die Felder.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya versteckt sich zwischen den Trollen der Moosschinder in {area:2273}, in der Nordostecke.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Rasende Seuchenhunde und Monströse Seuchenfledermäuse teilen sich die Felder um {area:2272} und den {area:2271}, südlich von {area:2273}.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Reite nach Westen zu {area:2260}.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "Hameyas Hügel",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "{object:177675} liegt gleich hinter {area:2261}.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Flieg nach {zone:1458}, nimm den Zeppelin nach {zone:1454} und flieg weiter nach {area:1638}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Auf der {area:1641}. Hab Wolle, Seide und Magiestoff in deinen Taschen.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Nur wenn du in {zone:1452} eine Flasche {item:12820} gefunden hast: Reite die Straße nach Norden hinauf. Der Kessel steht in {area:1762}, gleich südwestlich der {area:1769}; die Furbolgs der Totenwaldfelle dort sind feindselig.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Nur wenn {quest:8471} für dich gefallen ist: {npc:11558} wartet am Eingang der {area:1769} im {zone:1448} und spricht erst ab neutralem Ruf bei der Holzschlundfeste mit dir.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Geh durch die {area:1769} und nimm die Abzweigung des Tunnels nach {zone:1450}. {npc:11801} ist in {area:2361}.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Beide Quests führen nach {zone:1451}: Behalte sie.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Zurück durch den Tunnel, nimm den Ausgang nach {zone:1452} und reite dann nach Süden zu {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} sind im {zone:1448}, auf einer späteren Reise: Behalte sie, falls du sie hast.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Mondbestrahlte Eulenbestien",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Reite nach Osten nach {area:2255} und von dort nach Norden; die Mondbestrahlten Eulenbestien streifen durch die Hügel an den Südhängen von {area:2241}. Zieh sie einzeln.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "Zurück nach {area:1638}",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "Die Maschine {object:142071}",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Benutze {npc:10980} an {npc:7583}, dem Goblinmädchen in {area:976}. {npc:10977} und {npc:10978} erschreckst du später auf der Route.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} ist ein Geist auf dem Friedhof gleich nördlich von {area:976}; Ein verdächtiger Grabstein liegt südlich davon, außerhalb der Stadtmauer.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} geht zurück zu Linken in Un'Goro: Behalte sie.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} lagert an der Straße zur {area:1336}, südlich von {area:976}.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "Hippogryphen-Eier",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Flieg zum {area:1099}. Die Hippogryphennester sind im Süden von {zone:1444}; jedes enthält ein Ei für {object:142071}.",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "Weiter nach {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Flieg zur {area:541} und reite dann nach Südwesten durch Un'Goro zum Pass nach {zone:1451}. Der nächste Guide beginnt bei {area:3077}, wo der Pass herauskommt.",
}
