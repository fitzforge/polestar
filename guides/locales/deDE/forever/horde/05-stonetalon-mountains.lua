-- German (deDE): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "Folge von {area:380} der Straße nach Norden. {npc:8582} steht auf dem Wachturm am {area:1703}, wo die Straße nach {zone:1440} führt. Öffne {item:16783}, das er dir gibt.",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Bleib auf der Straße nach Norden. {npc:12862} wartet im Holzfällerlager der Warsong, südlich von Splintertree.",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431} liegt gleich nördlich die Straße hinauf.",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} steht bei {area:428}, dem Lager der Warsong gleich nordöstlich von Splintertree, neben dem Jagdbrett.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}s Jagdziele (Ursangus, Schattumbra, Scharfkralle) sind für den nächsten Besuch in {zone:1440}, mit 27.",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} patrouilliert auf der Straße östlich von {area:428} Richtung {area:430}.",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "Auf dem Ritt nach Westen steckt {npc:267214} in einer Schlucht südlich der Hauptstraße fest, südöstlich von {area:415}. Schattenhornhirsche und Ashenvalebären streifen überall durch die Wälder drumherum.",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Steuere {npc:267214}s {npc:271181} innerhalb von vier Minuten aus der Schlucht zur Hauptstraße; bricht die Kanalisierung ab, frag {npc:267214} erneut.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, auf der Straße",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Reite auf der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten. Seine anderen Quests sind für den nächsten Besuch, mit 27.",

	-- Step 9: Naga heads
	["Naga heads"] = "Nagaköpfe",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Jeder Naga der Rächerflossen am Strand nördlich des Außenpostens lässt Köpfe fallen.",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "Zurück zu {npc:8582}",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Flieg nach {area:431} und reite die Straße nach Süden hinunter zum {area:1703}.",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Reite nach Süden nach {area:380}, dann auf der Straße nach Westen aus dem {zone:1413} ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Die Straße steigt als {area:1076} nach Norden an. {quest:1483} hat eine Hütte, wo die Straße nach Osten zum {area:461} abzweigt.",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "Östlich von Ziz holzt die Venture Co. {area:461} kahl; einer der Maschinenführer trägt die Baupläne. {npc:4276} baut in der kleinen Mine auf der Ostseite ab: Bleib bei ihm, während er abbaut, Schläger der Venture Co. kommen ihn holen.",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "Sputtervalve in {area:392}: Der nächste Guide kommt dort vorbei",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "Folge der Straße nach Westen zum {area:460}.",
	-- {npc:11860} Maggran Earthbinder · {area:1718} Great Lift
	["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Grish ist am {area:1718}, im nächsten Guide",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Glitzernde Sonnensteine von den Harpyien der Blutfurien",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, vor dem Tor",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} in Zoram'gar, mit 27",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Gaeasamenkörner",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "Die Gaeasamenkörner liegen im Gras am Südufer von {area:464}, nördlich vom Sonnenfels.",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Folge der Straße nach Norden Richtung {area:467}. Gehörnte Renner grasen am Weg; die Blutsaftbestien, Mondlichtläufer und Siechdrachen streifen durch die Wälder unterhalb des Gipfels, und die Cenarischen Druiden halten den Hain dort.",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}s nächste Quest, Ordanus, liegt auf der Allianzseite von {zone:1440}. Überspring sie.",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Gaeaerdhügel",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, von jeder Harpyie der Blutfurien",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, oben auf dem Felsvorsprung",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, neben {npc:11862}",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "Reite den {area:1076} zurück hinunter nach {area:2539}.",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "Nach {area:1497}",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Reite nach Osten nach {area:380} und flieg nach {zone:1454}. Nimm den Zeppelin von den Türmen vor {zone:1454} nach {zone:1420}; {area:1497} liegt unter den {area:153}. Der Fledermausführer ist im {object:36078}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Sprich mit {npc:10181} im {object:36126}: {quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} steht im {object:36070}.",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Kennst du die Flugroute von {area:272} schon, flieg dorthin und spring weiter zu {area:272}. Sonst flieg von {zone:1458} zum {area:228} und reite die Straße nach Süden an Pyrewood vorbei. Die Untoten von Rabenklaue spuken in den Ruinen von {area:231} östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt {item:271343} fallen, der zu {object:645153} führt.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, von einem {npc:1973}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, von den Gequälten Seelen in den Ruinen",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Benutze {npc:212753} an {object:645153} für ein freiwilliges Opfer und töte {npc:212753}, die antwortet. {quest:95883} ist Elite: Such dir am besten eine Gruppe.",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Zurück auf die Straße nach Süden. Wo sie nach Osten nach {area:287} abbiegt, wartet {npc:2214} am {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia in {area:272}",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Folge der Straße nach Osten am Fluss entlang, dann nach Nordosten hinauf in die Hügel nach {area:272}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das verbrannte {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
}
