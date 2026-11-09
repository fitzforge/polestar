-- German (deDE): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 2: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 3: Searing Gorge
	["The Grimesilt outhouse"] = "Das Grimesilt-Nebengebäude",

	-- Step 4: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "",

	-- Step 5: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "Die nächste Aufgabe des Gefangenen, Geschäftsbuch aus {zone:1446}, schickt dich in die {zone:1435} und in die {zone:1445}: Überspring sie.",

	-- Step 6: Level 48.27
	["Level 48.27"] = "",
	-- {item:3985} Monogrammed Sash · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "",

	-- Step 7: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "",
	-- {npc:8256} Curator Thorius · {area:1537} Ironforge
	["For {npc:8256} in {area:1537}, later"] = "Für {npc:8256} in {area:1537}, später",

	-- Step 8: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Das Brett {object:179827}",

	-- Step 10: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "Der Nachtelf steht allein westlich der {area:1446}. Hör dir seine Geschichte an.",

	-- Step 13: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Versengende Lavaspinnen",
	-- {npc:8436} Zamael Lunthistle · {npc:8479} Velarok Windblade
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to {npc:8479}."] = "",

	-- Step 14: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "",

	-- Step 17: Golems and elementals
	["Golems and elementals"] = "Golems und Elementare",
	-- {npc:8479} Velarok Windblade
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below {npc:8479}; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "",

	-- Step 19: Dark Iron dwarves: kill these as you meet them
	-- {object:147516} Dark Iron
	["{object:147516} dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",

	-- Step 22: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} öffnet sich im Norden des Kessels. Die Geheimpläne liegen auf ihrem oberen Vorsprung; Incendosaurier schwimmen weiter drinnen in den Lavateichen, also zieh sie an den Rand. Halte dich von {npc:14621} und seinen Elitewachen tief drinnen fern.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 25: Level 48.66
	["Level 48.66"] = "",
	-- {quest:7701} WANTED: Overseer Maltorius · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "",

	-- Step 27: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 29: Level 48.98
	["Level 48.98"] = "",
	-- {quest:3452} The Flame's Casing · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "",

	-- Step 30: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "",

	-- Step 33: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 34: Class trainer
	["Class trainer"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Reite von {area:144} nach Süden ins {zone:1418}, dann nach Westen an der Hordestadt {area:340} vorbei (halte Abstand) und den Pfad hinauf in die {zone:1427}. Die {area:1446} ist das eingerüstete Lager am Nordwestrand.",
	-- ["Greater Lava Spiders"] = "Versengende Lavaspinnen",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Schwere Kriegsgolems patrouillieren unterhalb von Kalaran über den Boden des Kessels; Magmaelementare treiben zwischen ihnen. Golems und Elementare droppen das Öl, Elementare die Herzen.",
	-- ["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran steht am Rand des Kessels, südlich der {area:1446}. Hör dir seine Geschichte an.",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Reite nach Osten über den Kessel zur {area:247} im Südosten. Der Gefangene im hölzernen Abort will 15 {item:4306} und acht tote Geologen der Dunkeleisenzwerge von der Grabungsstätte drumherum. Der Abort lässt sich auch mit dem Schlüssel öffnen, falls du einen gefunden hast.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Zuchtmeister und Sklavenhändler treiben die Sklaven überall im Kessel an, und jeder von ihnen kann einen {item:10551} tragen. Die Dampfschmiede arbeiten an den Schmelzöfen in der Mitte (die {item:18959}), die Ausgucke stehen auf den südlichen Graten (das Handfernrohr). Jeder {object:147516}-Zwerg kann den {item:11818} droppen: Behalte ihn.",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Der Zwerg steht an der Straße bei der Grabungsstätte. Folge ihm auf der Straße nach Norden und wehr die Hinterhalte der {object:147516}-Zwerge ab. Wenn es vorbei ist, lies den {object:175704}, den er im {area:1959} auf der Straße zurücklässt.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Die Spinnen streifen über die Plateaus und Lavateiche im Südwesten der Schlucht.",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",
	-- ["{object:147516} dwarves"] = "{object:147516}-Zwerge",
}
