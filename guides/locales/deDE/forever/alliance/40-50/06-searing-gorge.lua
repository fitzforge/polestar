-- German (deDE): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Flieg nach {area:144}",

	-- Step 2: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Hinein nach {zone:1427}",

	-- Step 3: Searing Gorge
	["The Grimesilt outhouse"] = "Das Grimesilt-Nebengebäude",

	-- Step 4: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Reite von {area:144} nach Süden in das {zone:1418}, dann nach Westen an der Stadt {area:340} der Horde vorbei (halt Abstand) und den Pfad hinauf nach {zone:1427}: Die {area:247} liegt gleich hinter dem Eingang, im Südosten. Der Gefangene im hölzernen Abort will 15 {item:4306} und acht tote Dark Iron Geologists von der Grabungsstätte drumherum. Der Abort lässt sich auch mit dem Schlüssel öffnen, falls du einen gefunden hast.",

	-- Step 5: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "Die nächste Aufgabe des Gefangenen, Geschäftsbuch aus {zone:1446}, schickt dich in die {zone:1435} und in die {zone:1445}: Überspring sie.",

	-- Step 6: Level 48.27
	["Level 48.27"] = "Stufe 48,27",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "Falls du {item:3985} oder Facing Negolash übersprungen hast, grinde hier bis Stufe 48,27, um im Plan der Route zu bleiben.",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "Grinde an {npc:5839}",

	-- Step 7: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "Dorius steht an der Straße neben der {area:247}. Eskortiere ihn nach Nordosten nach {area:1959} und halte ihn am Leben; wenn es vorbei ist, lies den {object:175704}, den er auf der Straße zurücklässt.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, at the end of this guide"] = "Für {npc:8256} in {zone:1455}, am Ende dieses Guides",

	-- Step 8: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "Reite nach Westen entlang des Nordens der Schlucht nach {area:1446}, dem Gerüstlager am nordwestlichen Rand.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Das Brett {object:179827}",

	-- Step 9: Culling the Competition
	["Culling the Competition"] = "Konkurrenz ausmerzen",
	["Take the bounty from the board only if you want to hunt the linked dwarf packs with a group."] = "Nimm den Preis vom Brett nur, wenn du die verknüpften Zwerg-Wacht mit einer Gruppe jagen willst.",

	-- Step 11: Zamael Lunthistle
	-- {npc:8436} Zamael Lunthistle · {area:1442} Firewatch Ridge · {area:1446} Thorium Point · {npc:8282} Highlord Mastrogonde · {quest:3377} Prayer to Elune
	-- plural, as words: Twilight Fire Guards = {npc:5861} Twilight Fire Guard
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:8436} stands inside the Twilight camp at {area:1442}, west of {area:1446}, among Twilight Fire Guards, Idolaters and Geomancers (level 48-49 elites), with {npc:8282} (level 51, rare elite) beside him: {quest:3377} needs a group of 4. Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:8436} steht im Twilight-Lager bei {area:1442}, westlich von {area:1446}, zwischen Twilight-Feuerwachen, Twilight-Götzendienern und Twilight-Geomanten (Elites der Stufe 48-49), mit {npc:8282} (Stufe 51, Rare-Elite) neben sich: {quest:3377} braucht eine Gruppe von 4. Überspring sie, wenn du allein bist.",

	-- Step 14: Prayer to Elune: the page
	-- {quest:3378} Prayer to Elune
	["{quest:3378}: the page"] = "{quest:3378}: das Blatt",
	-- {npc:8436} Zamael Lunthistle · {quest:3378} Prayer to Elune
	["The Twilight elites of {npc:8436}'s camp drop the {quest:3378} page, about one in five: keep the group together here until one drops."] = "Die Twilight-Elite des Lagers von {npc:8436} fallen das {quest:3378}-Blatt, etwa eines von fünf: halte die Gruppe hier zusammen, bis eins abfällt.",

	-- Step 15: Searing Lava Spiders
	-- plural, as words: Searing Lava Spiders = {npc:5858} Searing Lava Spider
	["Searing Lava Spiders"] = "Versengende Lavaspinnen",
	-- {npc:8436} Zamael Lunthistle · {npc:8479} Velarok Windblade
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to {npc:8479}."] = "Die Spinnen streifen über die Plateaus und Lavatümpel südlich von {npc:8436}, auf dem Weg zu {npc:8479}.",

	-- Step 16: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "{npc:8479} steht am Rand des Kessels, südlich von {area:1446}. Hör dir seine Geschichte an.",

	-- Step 19: Golems and elementals
	["Golems and elementals"] = "Golems und Elementare",
	-- {npc:8479} Velarok Windblade
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below {npc:8479}; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Schwere Kriegsgolems patrouillieren unterhalb von {npc:8479} über den Boden des Kessels; Magmaelementare treiben zwischen ihnen. Golems und Elementare droppen das Öl, Elementare die Herzen.",

	-- Step 21: Dark Iron Taskmasters
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Dark Iron Taskmasters"] = "DunkelEisen-Aufseher",
	-- {area:1443} Slag Pit
	["With your group, look for Taskmasters on the open ledges first. Last stop, if you still need some: take the lift (the scaffold cars) down into the {area:1443} below, where four more stand."] = "Mit deiner Gruppe suche zuerst die Aufseher an den offenen Scheiteln. Letzter Stop, falls du noch einige brauchst: nimm den Lifter (die Gerüst-Wagen) hinab in die {area:1443} darunter, wo noch vier weitere stehen.",

	-- Step 22: Dark Iron Slavers
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Dark Iron Slavers"] = "DunkelEisen-Sklavenhändler",
	["Careful: Slavers can net you and call allies within 15 yards. A Taskmaster or Steamsmith may be standing beside one. Wait for a clear pull or leave the pack; don't descend into the Cauldron for this bounty."] = "Vorsicht: Sklavenhändler können dich abfangen und innerhalb von 15 Yards Verbündete rufen. Ein Aufseher oder Dampfschmied steht oft neben einem. Warte auf einen sicheren Zugang oder verlasse das Rudel; fahr nicht in den Kaldern für diesen Preis herunter.",

	-- Step 23: The furnaces and southern ridges
	["The furnaces and southern ridges"] = "Die Schmelzöfen und die südlichen Rücken",
	-- {item:18959} Smithing Tuyere · {item:11818} Grimesilt Outhouse Key
	["The Steamsmiths at the furnaces carry the {item:18959}; the Lookouts on the southern ridges carry the Spyglass. Keep the {item:11818} if a dwarf drops it."] = "Die Dampfsiedler am Schmelzturm tragen das {item:18959}; die Wächter an den südlichen Hängen das Spähers. Lass das {item:11818} stehen, falls ein Zwerge es ablegt.",

	-- Step 24: Thorium Plated Daggers
	-- plural, as words: Thorium Plated Daggers = {item:10551} Thorium Plated Dagger
	["Thorium Plated Daggers"] = "Thorium-Belachtete Dolche",
	-- {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith · Thorium Plated Daggers = {item:10551} Thorium Plated Dagger
	["Dark Iron Steamsmiths at the surface furnaces carry Thorium Plated Daggers as well as the {item:18959}. Pull from the outside of the camp."] = "DunkelEisen-Dampfschmiede an den Oberflächenschmelzöfen tragen Thorium-Belachtete Dolche zusätzlich zum {item:18959}. Jage von außen in das Lager.",

	-- Step 28: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}: Töte diese, sobald sie dir begegnen",
	-- {area:1443} Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} öffnet sich im Norden des Kessels. Die Geheimpläne liegen auf ihrem oberen Vorsprung; Incendosaurier schwimmen weiter drinnen in den Lavateichen, also zieh sie an den Rand. Halte dich von {npc:14621} und seinen Elitewachen tief drinnen fern.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "{item:18922}; unter der Erde",

	-- Step 29: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:14621} ist ein Elite der Stufe 50: Die meisten Klassen schaffen ihn allein auf Stufe 52, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 31: Level 48.66
	["Level 48.66"] = "Stufe 48,66",
	-- {area:1443} Slag Pit · {quest:7701} WANTED: Overseer Maltorius · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["Still under level 48.66 after the {area:1443} (a solo player usually is; a group's Culling the Competition or {quest:7701} covers it)? Top up on the Incendosaurs (47) in the {area:1443}'s lava pools, pulled to the edge.\nCareful: {npc:14621} (50, elite) and his elite guards hold the {area:1443}'s depths: keep to the pools near the entrance and don't follow the tunnels in."] = "Noch unter Stufe 48.66 nach dem {area:1443} (bei einem Solospieler ist das üblich; Culling the Competition einer Gruppe oder {quest:7701} deckt es ab)? Toppe dich bei den Incendosauriern (47) in den Lavabecken des {area:1443} auf, an den Rand gezogen.\nVorsicht: {npc:14621} (50, Elite) und seine Elite-Wachen halten die Tiefen des {area:1443}: bleib bei den Becken nahe dem Eingang und folge den Tunneln nicht hinein.",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "Grinde an {npc:9318}",

	-- Step 33: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:5860} (Elite der Stufe 50) braucht eine Gruppe von 3. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 35: The Torch of Retribution
	-- {npc:8479} Velarok Windblade
	["Listen to {npc:8479}'s story once more."] = "Hör dir die Geschichte von {npc:8479} noch einmal an.",

	-- Step 36: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {npc:8479} Velarok Windblade · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at {npc:8479}'s feet; {quest:3462} stands beside him."] = "{quest:3453} liegt zu Füßen von {npc:8479} auf dem Boden; {quest:3462} steht neben ihm.",
	-- {quest:3462} Squire Maltrake · {area:1446} Thorium Point
	["{quest:3462}: hand it in on the way back to {area:1446}"] = "{quest:3462}: Gib sie auf dem Rückweg zur {area:1446} ab",

	-- Step 37: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Wachkohlenbecken",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the south-east."] = "Trag die {object:149047} am Rand des Kessels entlang nach Süden und entzünde die vier Wachkohlenbecken, vom Südwesten herum bis zum Südosten.",

	-- Step 38: Level 48.98
	["Level 48.98"] = "Stufe 48,98",
	-- {quest:3452} The Flame's Casing · {object:147516} Dark Iron · {area:1442} Firewatch Ridge
	-- plural, as words: Searing Lava Spiders = {npc:5858} Searing Lava Spider · Magma Elementals = {npc:5855} Magma Elemental
	["Still under level 48.98 (a solo player usually is; a group's {quest:3452} covers it)? Top up on the Searing Lava Spiders (47-48) of the western plateaus, away from the {object:147516} camps.\nCareful: Magma Elementals (46-48) drift among the spiders: pull one at a time. Keep south of the Twilight camp at {area:1442}, whose cultists are elites."] = "Noch unter Stufe 48.98 (als Solospieler ist man das üblicherweise; eine Gruppe mit {quest:3452} deckt das ab)? Hole dir den Rest bei den Großen Lavaspinnen (47-48) der westlichen Hochebenen, weg von den Lagern bei {object:147516}.\nVorsicht: Magmaelementare (46-48) treiben unter den Spinnen umher: Ziehe sie einzeln. Bleibe südlich des Dämmerungslagers bei {area:1442}, dessen Kultisten Elites sind.",
	-- {npc:5858} Searing Lava Spider
	["grind on {npc:5858}"] = "Ertüchtigung auf {npc:5858}",

	-- Step 39: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {quest:3181} braucht eine Gruppe von 2. Überspring sie, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",
	["Below ground"] = "Unter der Erde",

	-- Step 41: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8509} and the dragonflight's hoard are beside {npc:8479}, on the rim south of {area:1446}."] = "{npc:8509} und der Hort des Drachenschwarms befinden sich neben {npc:8479}, am Rand südlich von {area:1446}.",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} it gives holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "Der {object:149502}, den sie dir gibt, enthält eine {item:10575}: Behalte sie für {npc:9459} in der {zone:1428}",

	-- Step 43: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "Flugmeister von {area:1446}",

	-- Step 44: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: Die Schlammbestien sind im {zone:1448}, behalte sie",

	-- Step 45: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Vier Runenabriebe in {zone:1447}: Behalte sie",

	-- Step 46: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 47: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "Xiggs wartet im {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Iron dwarves: kill these as you meet them"] = "Dunkeleisenzwerge: Töte diese, sobald sie dir begegnen",
	-- ["For {npc:8256} in {area:1537}, later"] = "Für {npc:8256} in {area:1537}, später",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Reite von {area:144} nach Süden ins {zone:1418}, dann nach Westen an der Hordestadt {area:340} vorbei (halte Abstand) und den Pfad hinauf in die {zone:1427}. Die {area:1446} ist das eingerüstete Lager am Nordwestrand.",
	-- ["Greater Lava Spiders"] = "Versengende Lavaspinnen",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Schwere Kriegsgolems patrouillieren unterhalb von Kalaran über den Boden des Kessels; Magmaelementare treiben zwischen ihnen. Golems und Elementare droppen das Öl, Elementare die Herzen.",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Velarok; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Heavy War Golems patrouillieren auf dem Boden des Kessels unterhalb von Velarok; Magma Elementals treiben zwischen ihnen umher. Golems und Elementare lassen das Öl fallen, Elementare die Herzen.",
	-- ["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "Falls du {quest:3452} übersprungen hast, grinde hier bis Stufe 48,98, um im Plan der Route zu bleiben.",
	-- ["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "Falls du {quest:7701} übersprungen hast, grinde hier bis Stufe 48,66, um im Plan der Route zu bleiben.",
	-- ["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran steht am Rand des Kessels, südlich der {area:1446}. Hör dir seine Geschichte an.",
	-- ["Listen to Velarok's story once more."] = "Hör dir die Geschichte von Velarok noch einmal an.",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Reite nach Osten über den Kessel zur {area:247} im Südosten. Der Gefangene im hölzernen Abort will 15 {item:4306} und acht tote Geologen der Dunkeleisenzwerge von der Grabungsstätte drumherum. Der Abort lässt sich auch mit dem Schlüssel öffnen, falls du einen gefunden hast.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Zuchtmeister und Sklavenhändler treiben die Sklaven überall im Kessel an, und jeder von ihnen kann einen {item:10551} tragen. Die Dampfschmiede arbeiten an den Schmelzöfen in der Mitte (die {item:18959}), die Ausgucke stehen auf den südlichen Graten (das Handfernrohr). Jeder {object:147516}-Zwerg kann den {item:11818} droppen: Behalte ihn.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Taskmasters und Slavers treiben die Sklaven überall im Kessel an, und jeder von ihnen kann einen {item:10551} tragen. Die Steamsmiths arbeiten an den Öfen in der Mitte (der {item:18959}), die Lookouts stehen auf den südlichen Graten (das Spyglass). Jeder {object:147516} kann den {item:11818} fallen lassen: Behalte ihn.\nVorsicht: Dark Iron Slavers (Stufe 45-46) rufen beim Ziehen Verbündete im Umkreis von 15 Metern zu Hilfe, wirken Netz aus bis zu 15 Metern und benutzen im Nahkampf Wunden.",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Der Zwerg steht an der Straße bei der Grabungsstätte. Folge ihm auf der Straße nach Norden und wehr die Hinterhalte der {object:147516}-Zwerge ab. Wenn es vorbei ist, lies den {object:175704}, den er im {area:1959} auf der Straße zurücklässt.",
	-- ["The night elf stands alone west of {area:1446}. Hear his story."] = "Der Nachtelf steht allein westlich der {area:1446}. Hör dir seine Geschichte an.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Die Spinnen streifen über die Plateaus und Lavateiche im Südwesten der Schlucht.",
	-- ["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Velarok."] = "Die Spinnen streifen über die Plateaus und Lavatümpel südlich von {npc:8436}, auf dem Weg zu Velarok.",
	-- ["To {zone:1455}"] = "Zum {zone:1455}",
	-- ["Velarok Windblade"] = "Velarok Windblade",
	-- ["Velarok stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok steht am Rand des Kessels, südlich von {area:1446}. Hör dir seine Geschichte an.",
	-- ["grind on {npc:5844}"] = "Grinde an {npc:5844}",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",
	-- ["{npc:8509} and the dragonflight's hoard are beside Velarok, on the rim south of {area:1446}."] = "{npc:8509} und der Hort des Drachenschwarms befinden sich neben Velarok, am Rand südlich der {area:1446}.",
	-- ["{object:147516} dwarves"] = "{object:147516}-Zwerge",
	-- ["{quest:3453} lies on the ground at Velarok's feet; {quest:3462} stands beside him."] = "{quest:3453} liegt zu Füßen von Velarok auf dem Boden; {quest:3462} steht neben ihm.",
	-- ["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",
}
