-- German (deDE): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Reite von {area:1978} zurück nach Nordwesten nach {area:75} und flieg nach {object:3202}.",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Der Zeppelin nach {zone:1454} startet vom Turm neben {object:3202}; er landet gleich vor dem Haupttor von {zone:1454}.",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. {npc:4752} lehrt Orcs im {object:172958}, beim Zwinger von {npc:3362}; es ist kein Reitlehrer der Himmelsgeborenen bekannt, also versuchen es Himmelsgeborene ebenfalls bei {npc:4752}. Die übrigen Reittiere deines Volkes kosten je 20 Gold: Sammelobjekte, Reittiere · Stufe 40 hat für jedes einen Guide.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, Reitlehrer",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Wölfe: {npc:3362}, neben {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:7953} in {area:367} an der Küste von {zone:1411}, mit Zjolnirs Raptoren (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptoren: Zjolnir, neben {npc:7953} in {area:367}.",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:3690} in {area:222}, mit den Kodos von {npc:3685} (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, Reitlehrer",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, neben {npc:3690} in {area:222}.",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:4773} in {area:159}, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrerin",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Dein Lehrer ist in {area:1638}: {npc:3033} (Druiden) auf der {area:1639}, {npc:246344} (Paladine). Flieg von {zone:1454} dorthin, dann weiter zum {area:484}.",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} für das Teufelsross",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Flieg zum {area:484}",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Flieg zum {area:484}, fahr mit dem Aufzug östlich des Postens hinunter und reite über die Salzebenen, dann nach Süden nach {zone:1446}.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} ist die ummauerte Goblinstadt gleich hinter der Grenze von {zone:1446}.",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "{object:150075} auf dem Platz",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "Östliche Lager der Wüstenläufer",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Die Banditen und Diebe lagern in den Dünen östlich von {area:976}. Jeder Wüstenläufer kann einen Wasserbeutel tragen: Behalte zehn, fünf für jedes von Luglunkets Kopfgeldern.",
	["water pouches in your bags"] = "Wasserbeutel in deinen Taschen",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "Südliche Lager der Wüstenläufer",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Die Schattenmagier, Schurken und Auftragsmörder lagern südöstlich von {area:976}.",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Reite nach Nordosten zum Goblinhafen an der Küste.",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: Die Kreischer leben in {zone:1444}",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Weiter südlich an der Küste halten die Südmeerfreibeuter die Bucht. {npc:7883} und die gestohlene Fracht sind auf den Docks am hinteren Ende. Jeder Pirat kann einen Hut fallen lassen, die Entführer am häufigsten.",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "für {area:35}, etwa ab Stufe 50",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Reite zurück nach Westen nach {area:976}.",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Flieg zum {area:484} und reite dann nach Westen durch die Schluchten am {area:2237} vorbei; die Straße steigt in den Dschungel von {zone:1444} hinauf und führt weiter zum {area:1099}.",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: für {zone:1454}, etwa ab Stufe 45",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "Nördliches Lager der Waldpfoten",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Die Gnolle der Waldpfoten lagern in den Hügeln gleich nordwestlich von Mojache; jeder kann eine Mähne fallen lassen.",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Nördlich der Gnolle halten die Oger einen Außenposten auf einem Hügel; zieh die Ogermagier zu dir. Das Kobalt ist in den Erdhügeln um den Außenposten, und die Schriftrolle liegt drinnen auf dem Boden.",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: eine Stunde ab jetzt",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "Grimmlingflitzer und Alphas der Waldpfoten",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Die Grimmlingflitzer schwirren über dem Hain gleich westlich von Mojache; fast jeder lässt einen Flügel fallen. Die Alphas der Waldpfoten führen die Lager südwestlich davon: Töte sie innerhalb der Stunde.",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "Lager der Grimmtotem",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Die Tauren der Grimmtotem lagern neben dem Hain der Grimmlingflitzer; Räuber, Naturalisten und Schamanen tragen alle Hörner.",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "Schlachtplan der Waldpfoten",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Der Schlachtplan liegt im Lager der Waldpfoten südlich von Mojache.",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "Südliche Ruinen der Gordunni",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Reite nach Südwesten zu den Ogerruinen unterhalb von {area:1105}. Schamanen, Hexenmeister und Raufer füllen sie; die Magierlords am Südende tragen die Kugel.",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "für {zone:1454}, etwa ab Stufe 45",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "Der Bau der Zukk'ash gräbt sich in die Hügel südöstlich des Lagers; {quest:7731} wartet in seiner tiefsten Kammer.",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "Kreischer",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Reite nach Westen in die Mitte von {zone:1444}. Töte einen {npc:5308}, benutze {item:10699} an seiner Leiche und töte den Geist, der aufsteigt.",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Reite weiter nach Westen zur Küste. Die Küstenkriechertiefseher und Küstenkriecherschnappklauen an den Stränden lassen etwa bei jedem vierzigsten Kill das Notsignal von OOX-22/FE fallen: Fällt eins, benutze es, um die Quest zu starten.",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Nur mit dem Notsignalgeber: Der Roboter sitzt in einer kleinen Höhle auf der Nordseite von {area:1105}. Eskortiere ihn zum Steg an {area:1108}; Yetis und Gorillas überfallen euch unterwegs. Seine Belohnung wartet in {area:35} auf einen späteren Besuch.",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "Ruhestein zum {area:1099}",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Flieg nach {area:1637}. Die Gebrüder Droffers führen ihren Laden in der Gasse.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "für das {zone:1425}, etwa ab Stufe 48",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Der Zeppelin nach {object:3202} startet vom Turm gleich nordöstlich des Haupttors von {zone:1454}.",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, die Flugmeisterin, steht gleich östlich des Zeppelinturms. Flieg nach {area:75}: Dort beginnt der nächste Guide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Nur mit dem Notsignal: Der Roboter sitzt in einer kleinen Höhle auf der Nordseite von {area:1105}. Eskortiere ihn zum Steg an der {area:1108}; Yetis und Gorillas überfallen euch unterwegs. Seine Belohnung wartet in {area:35} auf einen späteren Besuch.",
}
