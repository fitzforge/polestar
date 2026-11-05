-- German (deDE): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {area:331} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {area:331}. Open the {item:16783} he gives you."] = "",
	-- {item:16746} Warsong Report · {item:16783} Bundle of Reports
	["{item:16746}, from the {item:16783}"] = "{item:16746}, aus dem {item:16783}",

	-- Step 4: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "",

	-- Step 5: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Bleib auf der Straße nach Norden. {npc:12862} wartet im Holzfällerlager der Warsong, südlich von Splintertree.",

	-- Step 7: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431} liegt gleich nördlich die Straße hinauf.",

	-- Step 8: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run · {area:431} Splintertree Post
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board.\nNorth up the road to {area:431} and {area:428} beside it."] = "",
	-- {npc:12696} Senani Thunderheart · {area:331} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {area:331} visit, at 27."] = "",

	-- Step 9: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} patrouilliert auf der Straße östlich von {area:428} Richtung {area:430}.",

	-- Step 10: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "Auf dem Weg nach Westen steckt {npc:267214} in einer Schlucht südlich der Hauptstraße fest, südöstlich von {area:415}. Schattenhornhirsche und Ashenvalebären streifen rundherum durch die Wälder.",

	-- Step 11: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Steuere {npc:267214}s {npc:271181} innerhalb von vier Minuten aus der Schlucht zur Hauptstraße; bricht die Kanalisierung ab, frag {npc:267214} erneut.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, auf der Straße",

	-- Step 12: Zoram'gar Outpost
	-- {area:331} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Head west along the main road across {area:331}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "",

	-- Step 13: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {area:331} Ashenvale
	["Fly from {area:392} to {area:2897} on the {area:331} coast."] = "",

	-- Step 14: Naga heads
	["Naga heads"] = "Nagaköpfe",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Jeder Naga der Rächerflossen am Strand nördlich des Außenpostens lässt Köpfe fallen.",

	-- Step 16: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "Zurück zu {npc:8582}",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and head south down the road to the {area:1703}."] = "Flieg nach {area:431} und geh die Straße nach Süden hinunter zum {area:1703}.",

	-- Step 19: Malaka'jin
	-- {area:380} Crossroads · {area:17} The Barrens · {area:2539} Malaka'jin
	["Head south to the {area:380}, then west along the road out of the {area:17} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "",

	-- Step 20: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Die Straße steigt als {area:1076} nach Norden an. {quest:1483} hat eine Hütte, wo die Straße nach Osten zum {area:461} abzweigt.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "",

	-- Step 21: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "",

	-- Step 22: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "",
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "Sputtervalve in {area:392}: Der nächste Guide kommt dort vorbei",

	-- Step 23: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "Folge der Straße nach Westen zum {area:460}.",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} in Zoram'gar, mit 27",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Glitzernde Sonnensteine von den Harpyien der Blutfurien",
	-- {npc:11860} Maggran Earthbinder · {area:1718} Great Lift
	["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Grish ist am {area:1718}, im nächsten Guide",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, vor dem Tor",

	-- Step 24: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Gaeasamenkörner",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "",

	-- Step 25: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Folge der Straße nach Norden Richtung {area:467}. Gehörnte Renner grasen am Weg; die Blutsaftbestien, Mondlichtläufer und Siechdrachen streifen durch die Wälder unterhalb des Gipfels, und die Cenarischen Druiden halten den Hain dort.",

	-- Step 26: Hearth to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Hearth to {area:460}"] = "",

	-- Step 27: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {area:331} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {area:331}. Skip it."] = "",

	-- Step 28: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, von jeder Harpyie der Blutfurien",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Gaeaerdhügel",

	-- Step 29: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, oben auf dem Felsvorsprung",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, neben {npc:11862}",

	-- Step 30: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "Geh den {area:1076} zurück hinunter nach {area:2539}.",

	-- Step 32: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:380} Crossroads
	["{area:380} flight master"] = "",

	-- Step 33: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 34: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 35: Orgrimmar flight master
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "",

	-- Step 37: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "",

	-- Step 38: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "",

	-- Step 40: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 42: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and head south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Kennst du den Flugpunkt {area:272} schon, flieg dorthin und spring zu {area:272}. Sonst flieg von der {zone:1458} zum {area:228} und geh die Straße nach Süden an Pyrewood vorbei. Die Untoten der Rabenklaue spuken in den Ruinen von {area:231} östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt {item:271343} fallen, der zu {object:645153} führt.",
	["Below ground"] = "",

	-- Step 43: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Benutze {npc:212753} an {object:645153} für ein freiwilliges Opfer und töte {npc:212753}, die antwortet. {quest:95883} ist Elite: Such dir am besten eine Gruppe.",

	-- Step 44: Beren's Peril
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "",

	-- Step 46: Beren's Peril
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, von einem {npc:1973}",

	-- Step 48: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Zurück auf die Straße nach Süden. Wo sie nach Osten nach {area:287} abbiegt, wartet {npc:2214} am {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia in {area:272}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "Östlich von Ziz holzt die Venture Co. {area:461} kahl; einer der Maschinenführer trägt die Baupläne. {npc:4276} baut in der kleinen Mine auf der Ostseite ab: Bleib bei ihm, während er abbaut, Schläger der Venture Co. kommen ihn holen.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Flieg nach {area:431} und reite die Straße nach Süden hinunter zum {area:1703}.",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Folge der Straße nach Osten am Fluss entlang, dann nach Nordosten hinauf in die Hügel nach {area:272}.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "Folge von {area:380} der Straße nach Norden. {npc:8582} steht auf dem Wachturm am {area:1703}, wo die Straße nach {zone:1440} führt. Öffne {item:16783}, das er dir gibt.",
	-- ["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Geh nach Osten zum {area:380} und flieg nach {zone:1454}. Nimm den Zeppelin von den Türmen vor {zone:1454} nach {zone:1420}; die {area:1497} liegt unter den {area:153}. Der Fledermausführer ist im {object:36078}.",
	-- ["Head south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Geh nach Süden zum {area:380}, dann entlang der Straße nach Westen aus der {zone:1413} ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",
	-- ["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Geh entlang der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten. Seine anderen Quests sind für den nächsten Besuch, mit 27.",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Kennst du die Flugroute von {area:272} schon, flieg dorthin und spring weiter zu {area:272}. Sonst flieg von {zone:1458} zum {area:228} und reite die Straße nach Süden an Pyrewood vorbei. Die Untoten von Rabenklaue spuken in den Ruinen von {area:231} östlich der Straße im Südosten des Waldes; ein {npc:1973} lässt {item:271343} fallen, der zu {object:645153} führt.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "Auf dem Ritt nach Westen steckt {npc:267214} in einer Schlucht südlich der Hauptstraße fest, südöstlich von {area:415}. Schattenhornhirsche und Ashenvalebären streifen überall durch die Wälder drumherum.",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "Reite den {area:1076} zurück hinunter nach {area:2539}.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Reite nach Osten nach {area:380} und flieg nach {zone:1454}. Nimm den Zeppelin von den Türmen vor {zone:1454} nach {zone:1420}; {area:1497} liegt unter den {area:153}. Der Fledermausführer ist im {object:36078}.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Reite nach Süden nach {area:380}, dann auf der Straße nach Westen aus dem {zone:1413} ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Reite auf der Hauptstraße nach Westen durch {zone:1440}, an {area:415} vorbei (Allianz: bleib auf der Straße), bis zur Küste. {area:2897} liegt am {area:414} im Nordwesten. Seine anderen Quests sind für den nächsten Besuch, mit 27.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das verbrannte {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Sprich mit {npc:10181} im {object:36126}: {quest:93739}",
	-- ["Talk to {npc:10181}"] = "Sprich mit {npc:10181}",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "Die Gaeasamenkörner liegen im Gras am Südufer von {area:464}, nördlich vom Sonnenfels.",
	-- ["To the {area:1497}"] = "Nach {area:1497}",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, von den Gequälten Seelen in den Ruinen",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} steht bei {area:428}, dem Lager der Warsong gleich nordöstlich von Splintertree, neben dem Jagdbrett.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}s Jagdziele (Ursangus, Schattumbra, Scharfkralle) sind für den nächsten Besuch in {zone:1440}, mit 27.",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}s nächste Quest, Ordanus, liegt auf der Allianzseite von {zone:1440}. Überspring sie.",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606} steht im {object:36070}.",
}
