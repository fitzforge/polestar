-- German (deDE): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Die Gegenstände für {quest:5168} liegen in den späteren Gebieten der Pestländer: Behalte sie.",

	-- Step 3: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "",

	-- Step 4: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom Tiefgewölbe ({area:2261}).",

	-- Step 5: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Kleine Seuchenhunde und Seuchenfledermäuse streifen durch die Hügel nördlich von {area:2260}, Aaslarven kriechen zwischen ihnen; arbeite dich nach Norden Richtung {area:2627} vor.",

	-- Step 6: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Der Geist {npc:11140} steht bei einer Hütte im {area:2627}, in der Nordwestecke.",
	["Inside"] = "",

	-- Step 7: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Rasende Seuchenhunde und Monströse Seuchenfledermäuse teilen sich die Felder um {area:2272} und den {area:2271}, südlich von {area:2273}.",

	-- Step 8: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "",
	["Underwater"] = "",

	-- Step 9: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "",

	-- Step 10: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "",

	-- Step 11: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Reite nach Westen zu {area:2260}.",

	-- Step 13: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 15: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 17: Orgrimmar
	-- {npc:10880} Warcaller Gorlach · {npc:7776} Talo Thornhoof · {quest:7492} Camp Mojache
	["{npc:10880}, outside the front gate on the way in: for {npc:7776} at {quest:7492}, at the end of this guide"] = "",

	-- Step 18: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 19: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",

	-- Step 20: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",

	-- Step 21: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 23: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 24: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Nur wenn {quest:8471} für dich gefallen ist: {npc:11558} wartet am Eingang der {area:1769} im {zone:1448} und spricht erst ab neutralem Ruf bei der Holzschlundfeste mit dir.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 26: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Geh durch die {area:1769} und nimm die Abzweigung des Tunnels nach {zone:1450}. {npc:11801} ist in {area:2361}.",

	-- Step 27: Class trainer
	["Class trainer"] = "",

	-- Step 28: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Beide Quests führen nach {zone:1451}: Behalte sie.",

	-- Step 30: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Zurück durch den Tunnel, nimm den Ausgang nach {zone:1452} und reite dann nach Süden zu {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "",

	-- Step 31: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Mondbestrahlte Eulenbestien",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Reite nach Osten nach {area:2255} und von dort nach Norden; die Mondbestrahlten Eulenbestien streifen durch die Hügel an den Südhängen von {area:2241}. Zieh sie einzeln.",

	-- Step 33: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 34: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} ist ein Geist auf dem Friedhof gleich nördlich von {area:976}; Ein verdächtiger Grabstein liegt südlich davon, außerhalb der Stadtmauer.",

	-- Step 35: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Benutze {item:12928} an {npc:7583}, dem Goblinmädchen in {area:976}. {npc:10977} und {npc:10978} erschreckst du später auf der Route.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "",

	-- Step 36: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "Die Maschine {object:142071}",

	-- Step 37: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} geht zurück zu {npc:8737} in Un'Goro: Behalte sie.",

	-- Step 38: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} lagert an der Straße zur {area:1336}, südlich von {area:976}.",

	-- Step 39: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 40: Camp Mojache
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}, a few steps from the flight master"] = "",
	-- {area:2577} Dire Maul
	["His next task is for the {area:2577} dungeon: leave it."] = "",

	-- Step 41: Ruins of Isildien
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Flieg zum {area:1099}. Die Hippogryphennester sind im Süden von {zone:1444}; jedes enthält ein Ei für {object:142071}.",

	-- Step 42: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 43: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "",

	-- Step 44: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Der Pass aus dem Un'Goro-Krater endet an der {area:3077}, dem Friedhof im Nordosten von {zone:1451}. {npc:13220} steht zwischen den Gräbern.",

	-- Step 45: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Eine zerrissene Schriftrolle liegt am Eingang von {area:2261}, der Gruft südlich von {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Zurück durch den Tunnel, nimm den Ausgang nach {area:618} und reite dann nach Süden zu {area:2246}.",
	-- ["Back to {area:1638}"] = "Zurück nach {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Flieg nach {zone:1458}, nimm den Zeppelin nach {zone:1454} und flieg weiter nach {area:1638}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Flieg zur {area:541} und reite dann nach Südwesten durch Un'Goro zum Pass nach {zone:1451}. Der nächste Guide beginnt bei {area:3077}, wo der Pass herauskommt.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Geh durch die {area:1769} und nimm die Abzweigung des Tunnels nach {area:493}. {npc:11801} ist in {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya versteckt sich zwischen den Trollen der Moosschinder in {area:2273}, in der Nordostecke.",
	-- ["Hameya's mound"] = "Hameyas Hügel",
	-- ["Hameya's scroll"] = "Hameyas Schriftrolle",
	-- ["Hippogryph eggs"] = "Hippogryphen-Eier",
	-- ["On to {zone:1451}"] = "Weiter nach {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Auf der {area:1641}. Hab Wolle, Seide und Magiestoff in deinen Taschen.",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Nur wenn du in {area:618} eine Flasche {item:12820} gefunden hast: Reite die Straße nach Norden hinauf. Der Kessel steht in {area:1762}, gleich südwestlich der {area:1769}; die Furbolgs der Totenwaldfelle dort sind feindselig.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Seuchenhunde und ihre Kleinen streifen an den Ufern des Sees südwestlich der Kapelle umher.",
	-- ["Sword of Marduk"] = "Zertrümmertes Schwert von Marduk",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Die Waldläufer, Pfadschreiter und Waldmänner der Hochelfen bewachen die Lodge beim {area:2275}; das Register liegt drinnen. Waldläufer erreichen Stufe 60: Zieh sie einzeln. Giftige Seuchenfledermäuse fliegen auf dem Weg über die Felder.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Das zertrümmerte Schwert liegt nordwestlich des Sees auf dem Boden.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Der Schädel liegt in {area:2622}, zwischen Verseuchten Schrecken und Seuchenmonstern.",
	-- ["The western hills"] = "Die westlichen Hügel",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} liegt gleich hinter {area:2261}.",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} verdirbt binnen zehn Minuten: Töte die Geißel des Orts zügig und zerreibe die sieben Stücke sofort mit {item:15454}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Der Flugmeister von {object:1661} ist im Westturm des {object:36078}, außerhalb der Mauern.",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} sind im {zone:1448}, auf einer späteren Reise: Behalte sie, falls du sie hast.",
}
