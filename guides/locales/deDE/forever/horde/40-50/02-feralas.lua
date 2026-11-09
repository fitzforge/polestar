-- German (deDE): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 4: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 6: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, Reitlehrer",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Wölfe: {npc:3362}, neben {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "",

	-- Step 8: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptoren: Zjolnir, neben {npc:7953} in {area:367}.",

	-- Step 9: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 11: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "",

	-- Step 13: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, Reitlehrer",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, neben {npc:3690} in {area:222}.",

	-- Step 14: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Flieg zum {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 16: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} für das Teufelsross",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "",

	-- Step 17: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 20: Mirage Raceway
	-- {area:484} Freewind Post · {zone:1446} Tanaris · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["The road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 21: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} ist die ummauerte Goblinstadt gleich hinter der Grenze von {zone:1446}.",

	-- Step 23: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",
	["water pouches in your bags"] = "Wasserbeutel in deinen Taschen",

	-- Step 25: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Reite nach Nordosten zum Goblinhafen an der Küste.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "",

	-- Step 26: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "",
	["Upstairs"] = "",

	-- Step 27: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 28: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "",
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "für {area:35}, etwa ab Stufe 50",

	-- Step 30: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 32: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: für {zone:1454}, etwa ab Stufe 45",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 33: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Nördlich der Gnolle halten die Oger einen Außenposten auf einem Hügel; zieh die Ogermagier zu dir. Das Kobalt ist in den Erdhügeln um den Außenposten, und die Schriftrolle liegt drinnen auf dem Boden.",

	-- Step 34: Woodpaw north camp
	["Woodpaw north camp"] = "Nördliches Lager der Waldpfoten",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "",

	-- Step 35: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: eine Stunde ab jetzt",

	-- Step 36: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "",

	-- Step 38: Grimtotem camp
	["Grimtotem camp"] = "Lager der Grimmtotem",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Die Tauren der Grimmtotem lagern neben dem Hain der Grimmlingflitzer; Räuber, Naturalisten und Schamanen tragen alle Hörner.",

	-- Step 39: Woodpaw battle map
	["Woodpaw battle map"] = "Schlachtplan der Waldpfoten",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Der Schlachtplan liegt im Lager der Waldpfoten südlich von Mojache.",

	-- Step 40: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "für {zone:1454}, etwa ab Stufe 45",

	-- Step 41: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "Der Bau der Zukk'ash gräbt sich in die Hügel südöstlich des Lagers; {quest:7731} wartet in seiner tiefsten Kammer.",

	-- Step 42: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "",

	-- Step 43: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "",

	-- Step 44: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "",

	-- Step 45: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "",

	-- Step 46: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 47: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "für das {zone:1425}, etwa ab Stufe 48",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "Östliche Lager der Wüstenläufer",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Flieg nach {area:1637}. Die Gebrüder Droffers führen ihren Laden in der Gasse.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Flieg zum {area:484}, fahr mit dem Aufzug östlich des Postens hinunter und reite über die Salzebenen, dann nach Süden nach {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Flieg zum {area:484} und reite dann nach Westen durch die Schluchten am {area:2237} vorbei; die Straße steigt in den Dschungel von {zone:1444} hinauf und führt weiter zum {area:1099}.",
	-- ["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",
	-- ["Hearth to {area:1099}"] = "Ruhestein zum {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Reite weiter nach Westen zur Küste. Die Küstenkriechertiefseher und Küstenkriecherschnappklauen an den Stränden lassen etwa bei jedem vierzigsten Kill das Notsignal von OOX-22/FE fallen: Fällt eins, benutze es, um die Quest zu starten.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Nur mit dem Notsignalgeber: Der Roboter sitzt in einer kleinen Höhle auf der Nordseite von {area:1105}. Eskortiere ihn zum Steg an {area:1108}; Yetis und Gorillas überfallen euch unterwegs. Seine Belohnung wartet in {area:35} auf einen späteren Besuch.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Reite von {area:1978} zurück nach Nordwesten nach {area:75} und flieg nach {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Reite zurück nach Westen nach {area:976}.",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Reite nach Südwesten zu den Ogerruinen unterhalb von {area:1105}. Schamanen, Hexenmeister und Raufer füllen sie; die Magierlords am Südende tragen die Kugel.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Reite nach Westen in die Mitte von {zone:1444}. Töte einen {npc:5308}, benutze {item:10699} an seiner Leiche und töte den Geist, der aufsteigt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:3690} in {area:222}, mit den Kodos von {npc:3685} (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:4773} in {area:159}, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:7953} in {area:367} an der Küste von {zone:1411}, mit Zjolnirs Raptoren (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. {npc:4752} lehrt Orcs im {object:172958}, beim Zwinger von {npc:3362}; es ist kein Reitlehrer der Himmelsgeborenen bekannt, also versuchen es Himmelsgeborene ebenfalls bei {npc:4752}. Die übrigen Reittiere deines Volkes kosten je 20 Gold: Sammelobjekte, Reittiere · Stufe 40 hat für jedes einen Guide.",
	-- ["Rogue Vale screechers"] = "Kreischer",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Weiter südlich an der Küste halten die Südmeerfreibeuter die Bucht. {npc:7883} und die gestohlene Fracht sind auf den Docks am hinteren Ende. Jeder Pirat kann einen Hut fallen lassen, die Entführer am häufigsten.",
	-- ["Southern Gordunni ruins"] = "Südliche Ruinen der Gordunni",
	-- ["Southern Wastewander camps"] = "Südliche Lager der Wüstenläufer",
	-- ["Sprite darters and Woodpaw alphas"] = "Grimmlingflitzer und Alphas der Waldpfoten",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Die Gnolle der Waldpfoten lagern in den Hügeln gleich nordwestlich von Mojache; jeder kann eine Mähne fallen lassen.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Die Banditen und Diebe lagern in den Dünen östlich von {area:976}. Jeder Wüstenläufer kann einen Wasserbeutel tragen: Behalte zehn, fünf für jedes von Luglunkets Kopfgeldern.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Die Schattenmagier, Schurken und Auftragsmörder lagern südöstlich von {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Die Grimmlingflitzer schwirren über dem Hain gleich westlich von Mojache; fast jeder lässt einen Flügel fallen. Die Alphas der Waldpfoten führen die Lager südwestlich davon: Töte sie innerhalb der Stunde.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Der Zeppelin nach {object:3202} startet vom Turm gleich nordöstlich des Haupttors von {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Der Zeppelin nach {zone:1454} startet vom Turm neben {object:3202}; er landet gleich vor dem Haupttor von {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, die Flugmeisterin, steht gleich östlich des Zeppelinturms. Flieg nach {area:75}: Dort beginnt der nächste Guide.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Dein Lehrer ist in {area:1638}: {npc:3033} (Druiden) auf der {area:1639}, {npc:246344} (Paladine). Flieg von {zone:1454} dorthin, dann weiter zum {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["the {object:150075} in the square"] = "{object:150075} auf dem Platz",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} ist die ummauerte Goblinstadt gleich hinter der Grenze von {area:440}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrerin",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: Die Kreischer leben in {zone:1444}",
}
