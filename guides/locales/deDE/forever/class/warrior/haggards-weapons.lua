-- German (deDE): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Alliance)"] = "{spell:71} und eine Waffe (Allianz)",
	-- {spell:71} Defensive Stance · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{spell:71} at 10 and a one-hand weapon of your choice from {zone:1453}, {zone:1455} or {zone:1457}."] = "{spell:71} mit Stufe 10 und eine Einhandwaffe nach Wahl aus {zone:1453}, {zone:1455} oder {zone:1457}.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} in {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "Mit Stufe 10 steht {npc:252377} mit den Lehrern am Westtor von {area:16638}. Ein Kultist, {npc:257196}, hält den Schild ihrer Familie am {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Geh von {area:16638} nach Nordwesten zum {area:16629}. {npc:257196} steht westlich des Schreinzugangs zwischen den Guardians, Spiritcallers und Blademasters des Kults: Pull sie einzeln, bevor du dir ihn vornimmst. Er lässt {item:263993} fallen.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, von {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:6090} Bartleby · {zone:1453} Stormwind
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:6090}'s road below still gives a weapon, once you reach {zone:1453}."] = "Zurück zu {npc:252377} in {area:16638}. Sie bringt dir {spell:71} bei und gibt dir {item:275290}, einen Schild dafür. Der Weg von {npc:6090} unten gibt dir trotzdem eine Waffe, sobald du {zone:1453} erreichst.",

	-- Step 4: Muren Stormpike
	-- {npc:1229} Granis Swiftaxe · {area:131} Kharanos · {quest:1679} Muren Stormpike · {zone:1455} Ironforge · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:1229}, the warrior trainer in {area:131}, sends you to {quest:1679} in {zone:1455}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} is the quickest stance (one fight in a tavern), with a Haggard's weapon after it."] = "Mit Stufe 10 schickt dich {npc:1229}, der Kriegerlehrer in {area:131}, zu {quest:1679} in {zone:1455}. Jeder Allianz-Krieger darf einen der drei Wege nehmen, nie zwei: Bist du mit 10 sowieso in {zone:1453}? {quest:1638} von {npc:5480} ist die schnellste Haltung (ein Kampf in einer Taverne), danach folgt eine Waffe von Haggard.",

	-- Step 5: Muren Stormpike in Ironforge
	-- {quest:1679} Muren Stormpike · {zone:1455} Ironforge
	["{quest:1679} in {zone:1455}"] = "{quest:1679} in {zone:1455}",
	-- {quest:1679} Muren Stormpike · {object:32390} Hall of Arms (no name in this language: may be words) · {object:32359} Military Ward (no name in this language: may be words)
	["{quest:1679} stands in the {object:32390} in the {object:32359}."] = "{quest:1679} steht in {object:32390} im {object:32359}.",

	-- Step 6: Vejrek
	-- {quest:1678} Vejrek · {area:135} Frostmane Hold · {spell:71} Defensive Stance · {spell:6343} Thunder Clap
	["{quest:1678} (level 11, a lone troll) waits at his hut on a hill south of {area:135}, near the mountains at the top of a short ramp, with no other trolls around; the hut at the front of {area:135} is the wrong one. He fights in {spell:71} and sunders your armor; {spell:6343} slows him. His head always drops; he returns about 8 minutes after dying."] = "{quest:1678} (Stufe 11, ein einzelner Troll) wartet an seiner Hütte auf einem Hügel südlich von {area:135}, nahe den Bergen am oberen Ende einer kurzen Rampe, ohne andere Trolle in der Nähe; die Hütte vorn bei {area:135} ist die falsche. Er kämpft in {spell:71} und zerreißt deine Rüstung; {spell:6343} verlangsamt ihn. Sein Kopf fällt immer; er kehrt etwa 8 Minuten nach seinem Tod zurück.",

	-- Step 7: Tormus Deepforge
	-- {npc:6114} Muren Stormpike · {spell:71} Defensive Stance · {quest:1680} Tormus Deepforge · {object:32372} Great Forge (no name in this language: may be words) · {zone:1455} Ironforge
	["Back to {npc:6114} for {spell:71}, then to {quest:1680} at the {object:32372} in the middle of {zone:1455}."] = "Zurück zu {npc:6114} für {spell:71}, dann zu {quest:1680} an {object:32372} mitten in {zone:1455}.",

	-- Step 8: Ironband's Compound
	-- {quest:1681} Ironband's Compound · {zone:1426} Dun Morogh · {area:212} Helm's Bed Lake · {object:85562} Ironband's Strongbox · {npc:6124} Captain Beld
	["{quest:1681} lies in eastern {zone:1426}, below {area:212} on its south side. Dark Iron Spies (level 8-10) stand along the way, far enough apart to pull one at a time. {object:85562} is in the basement of the southernmost house; {npc:6124} (level 11) stands by it and charges on sight. The box always holds the ore and refills 15 minutes after opening."] = "{quest:1681} liegt im östlichen {zone:1426}, unterhalb von {area:212} an der Südseite. Entlang des Weges stehen Dark Iron Spies (Stufe 8-10), weit genug auseinander, um sie einzeln zu pullen. {object:85562} steht im Keller des südlichsten Hauses; {npc:6124} (Stufe 11) steht daneben und greift auf Sicht an. Die Kiste enthält immer das Erz und füllt sich 15 Minuten nach dem Öffnen wieder.",
	-- {item:6800} Umbral Ore · {object:85562} Ironband's Strongbox
	["{item:6800}, from {object:85562}"] = "{item:6800}, aus {object:85562}",

	-- Step 10: Elanaria
	-- {npc:3598} Kyra Windblade · {area:186} Dolanaar · {npc:2151} Moon Priestess Amara · {quest:1684} Elanaria · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:3598}, the warrior trainer in {area:186}, or {npc:2151}, who patrols the road west of {area:186}, sends you to {quest:1684} on the {area:1660} in {zone:1457}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} teaches the same stance after one fight in a tavern."] = "Mit Stufe 10 schickt dich {npc:3598}, der Kriegerlehrer in {area:186}, oder {npc:2151}, die auf der Straße westlich von {area:186} patrouilliert, zu {quest:1684} auf {area:1660} in {zone:1457}. Jeder Allianz-Krieger darf einen der drei Wege nehmen, nie zwei: Bist du mit 10 sowieso in {zone:1453}? {quest:1638} von {npc:5480} bringt dieselbe Haltung nach einem Kampf in einer Taverne bei.",

	-- Step 11: Elanaria in Darnassus
	-- {quest:1684} Elanaria · {zone:1457} Darnassus
	["{quest:1684} in {zone:1457}"] = "{quest:1684} in {zone:1457}",
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}."] = "{quest:1684} steht auf {area:1660}.",

	-- Step 12: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:186} Dolanaar
	["{quest:1683} (level 10, a satyr) stands at a hidden moonwell up a hillside west of {area:186}. The trail is hard to spot: it starts behind a Gnarlpine camp and climbs in switchbacks lined with lamp posts. The furbolgs below can come in groups. His horn always drops; he returns 5 minutes after dying."] = "{quest:1683} (Stufe 10, ein Satyr) steht an einem versteckten Mondbrunnen einen Hang westlich von {area:186} hinauf. Der Pfad ist schwer zu erkennen: Er beginnt hinter einem Gnarlpine-Lager und führt in Serpentinen hinauf, gesäumt von Laternenpfählen. Die Furbolgs unten können in Gruppen kommen. Sein Horn fällt immer; er kehrt 5 Minuten nach seinem Tod zurück.",

	-- Step 14: Elunite under Auberdine
	-- {area:442} Auberdine
	["Elunite under {area:442}"] = "Elunite unter {area:442}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {npc:6133} Shade of Elura
	["Take the boat from {area:702} to {area:442}. The wreck lies underwater just south of {area:442}'s southern pier, where the Menethil boat docks. Open Crates of Elunite on the sea floor around the wreck, by a huge sunken turtle, toward the beach and under the pier until you have eight; every crate holds ore and comes back in 3-5 minutes. The grey {npc:6133} (level 11) drifts around the middle of the wreck and always drops the medallion: target it when you see it, so you can find it after surfacing for air. Watch your breath; Threshers can join in."] = "Nimm das Boot von {area:702} nach {area:442}. Das Wrack liegt unter Wasser direkt südlich des südlichen Piers von {area:442}, wo das Boot aus Menethil anlegt. Öffne Crates of Elunite auf dem Meeresboden rund um das Wrack, bei einer riesigen versunkenen Schildkröte, zum Strand hin und unter dem Pier, bis du acht hast; jede Kiste enthält Erz und kommt nach 3-5 Minuten zurück. Der graue {npc:6133} (Stufe 11) treibt in der Mitte des Wracks umher und lässt das Medaillon immer fallen: Wähl ihn als Ziel aus, wenn du ihn siehst, damit du ihn nach dem Auftauchen für Luft wiederfindest. Achte auf deinen Atem; Threshers können eingreifen.",
	-- {item:6808} Elunite Ore
	["{item:6808}, from Crates of Elunite"] = "{item:6808}, aus Crates of Elunite",
	-- {item:6809} Elura's Medallion · {npc:6133} Shade of Elura
	["{item:6809}, from the {npc:6133}"] = "{item:6809}, von {npc:6133}",

	-- Step 15: Smith Mathiel
	-- {area:1660} Warrior's Terrace · {npc:4088} Elanaria · {item:6812} Case of Elunite · {npc:6142} Mathiel
	["Back on the {area:1660}: {npc:4088} hands you the {item:6812}; {npc:6142} works on the far, south side of the same terrace, easy to miss."] = "Zurück auf {area:1660}: {npc:4088} gibt dir {item:6812}; {npc:6142} arbeitet auf der fernen Südseite derselben Terrasse, leicht zu übersehen.",

	-- Step 16: A Warrior's Training
	-- {npc:913} Lyria Du Lac · {area:87} Goldshire · {npc:6089} Harry Burlguard · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town
	["At 10, {npc:913}, the warrior trainer by the inn in {area:87}, sends you to {npc:6089} in {zone:1453}; {npc:5480}, the warrior trainer in {zone:1453}'s {object:2100}, offers it too."] = "Mit Stufe 10 schickt dich {npc:913}, der Kriegerlehrer beim Gasthaus in {area:87}, zu {npc:6089} in {zone:1453}; {npc:5480}, die Kriegerlehrerin in {object:2100} von {zone:1453}, bietet sie ebenfalls an.",

	-- Step 17: Bartleby
	-- {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2100} Old Town · {quest:1638} A Warrior's Training · {npc:5480} Ilsa Corbin · {zone:1453} Stormwind
	["{npc:6089} and {npc:6090} are in the Pig and Whistle tavern in {object:2100}; {npc:6090} is the drunk at the far end of the bar. {npc:6090} (level 10) hits harder than his level, so start at full health; he gives up at low health instead of dying. If he wins, he disappears for about three minutes: keep the quest and talk to him again when he is back. A Dwarf, Gnome or Night Elf who took {quest:1638} from {npc:5480} instead of their home road is led through {zone:1453} from here."] = "{npc:6089} und {npc:6090} sind in der Taverne Pig and Whistle in {object:2100}; {npc:6090} ist der Betrunkene am anderen Ende der Theke. {npc:6090} (Stufe 10) schlägt härter zu, als seine Stufe vermuten lässt, fang also mit voller Gesundheit an; bei niedriger Gesundheit gibt er auf, statt zu sterben. Gewinnt er, verschwindet er für etwa drei Minuten: Behalte die Quest und sprich ihn erneut an, wenn er wieder da ist. Ein Zwerg, Gnom oder Nachtelf, der {quest:1638} von {npc:5480} statt seines Heimatwegs genommen hat, wird von hier aus durch {zone:1453} geführt.",

	-- Step 18: Marshal Haggard
	-- {npc:294} Marshal Haggard · {area:88} Eastvale Logging Camp
	["{npc:294}'s manor stands at the south-east edge of the {area:88} in eastern Elwynn, at the end of a short road that does not join the main one."] = "Das Anwesen von {npc:294} steht am südöstlichen Rand von {area:88} im östlichen Elwynn, am Ende einer kurzen Straße, die nicht auf die Hauptstraße trifft.",

	-- Step 19: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {item:6783} Dead-tooth's Key · {object:85563} Dead-tooth's Strongbox · {item:6782} Marshal Haggard's Badge
	["{npc:6093} (level 11) camps in the far south-east of Elwynn. A guard stands beside him and Defias and wolves are spread around the camp (now and then a rarer guard too): clear them one at a time, then kill Jack. He always drops {item:6783}; open {object:85563} in the crates by him for {item:6782}. Jack returns 3 minutes after dying, the box 1 minute after opening."] = "{npc:6093} (Stufe 11) lagert im äußersten Südosten von Elwynn. Eine Wache steht neben ihm, und Defias und Wölfe sind über das Lager verteilt (ab und zu auch eine seltenere Wache): Räum sie einzeln, dann töte Jack. Er lässt immer {item:6783} fallen; öffne {object:85563} in den Kisten bei ihm für {item:6782}. Jack kehrt 3 Minuten nach seinem Tod zurück, die Kiste 1 Minute nach dem Öffnen.",
	-- {npc:6093} Dead-Tooth Jack
	["from {npc:6093}"] = "von {npc:6093}",
	-- {item:6782} Marshal Haggard's Badge · {object:85563} Dead-tooth's Strongbox
	["{item:6782}, from {object:85563}"] = "{item:6782}, aus {object:85563}",

	-- Step 20: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "Zurück zu {npc:294}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Haggard's Weapons"] = "Haggards Waffen",
	-- ["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "Das Haus von {npc:294} steht im Osten von {zone:1429}, südlich der Straße von {zone:1453} ins Rotkammgebirge.",
	-- ["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} bildet Krieger in der {object:2100} aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",
	-- ["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} lagert im äußersten Südosten von {zone:1429}, südöstlich von {npc:294}. Er trägt den Schlüssel zur Geldkassette in seinem Lager.",
	-- ["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: Sein Schlüssel öffnet die Geldkassette",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} und eine Einhandwaffe deiner Wahl mit 10.",
}
