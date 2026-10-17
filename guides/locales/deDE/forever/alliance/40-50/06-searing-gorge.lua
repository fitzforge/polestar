-- German (deDE): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Reite von {area:144} nach Süden ins {zone:1418}, dann nach Westen an der Hordestadt {area:340} vorbei (halte Abstand) und den Pfad hinauf in die {zone:1427}. Die {area:1446} ist das eingerüstete Lager am Nordwestrand.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Das Brett {object:179827}",

	-- Step 2: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "Der Nachtelf steht allein westlich der {area:1446}. Hör dir seine Geschichte an.",

	-- Step 3: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran steht am Rand des Kessels, südlich der {area:1446}. Hör dir seine Geschichte an.",

	-- Step 4: Golems and elementals
	["Golems and elementals"] = "Golems und Elementare",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Schwere Kriegsgolems patrouillieren unterhalb von Kalaran über den Boden des Kessels; Magmaelementare treiben zwischen ihnen. Golems und Elementare droppen das Öl, Elementare die Herzen.",

	-- Step 6: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "{object:147516}-Zwerge",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Zuchtmeister und Sklavenhändler treiben die Sklaven überall im Kessel an, und jeder von ihnen kann einen {item:10551} tragen. Die Dampfschmiede arbeiten an den Schmelzöfen in der Mitte (die {item:18959}), die Ausgucke stehen auf den südlichen Graten (das Handfernrohr). Jeder {object:147516}-Zwerg kann den {item:11818} droppen: Behalte ihn.",

	-- Step 7: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Versengende Lavaspinnen",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Die Spinnen streifen über die Plateaus und Lavateiche im Südwesten der Schlucht.",

	-- Step 9: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} öffnet sich im Norden des Kessels. Die Geheimpläne liegen auf ihrem oberen Vorsprung; Incendosaurier schwimmen weiter drinnen in den Lavateichen, also zieh sie an den Rand. Halte dich von {npc:14621} und seinen Elitewachen tief drinnen fern.",

	-- Step 11: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "Das Grimesilt-Nebengebäude",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Reite nach Osten über den Kessel zur {area:247} im Südosten. Der Gefangene im hölzernen Abort will 15 {item:4306} und acht tote Geologen der Dunkeleisenzwerge von der Grabungsstätte drumherum. Der Abort lässt sich auch mit dem Schlüssel öffnen, falls du einen gefunden hast.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "Die nächste Aufgabe des Gefangenen, Geschäftsbuch aus {zone:1446}, schickt dich in die {zone:1435} und in die {zone:1445}: Überspring sie.",

	-- Step 12: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Der Zwerg steht an der Straße bei der Grabungsstätte. Folge ihm auf der Straße nach Norden und wehr die Hinterhalte der {object:147516}-Zwerge ab. Wenn es vorbei ist, lies den {object:175704}, den er im {area:1959} auf der Straße zurücklässt.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "Für {npc:8256} in {zone:1455}, später",
}
