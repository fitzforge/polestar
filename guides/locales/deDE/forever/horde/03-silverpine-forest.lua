-- German (deDE): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "Nach {area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Folge von {area:380} aus der Straße nach Nordosten bis {area:1637} und geh durch das Haupttor hinein. {npc:3310}, der Windreitermeister, steht auf dem Turm im {object:172982}.",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Klassenquests in {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} steht im {object:172961} auf der Westseite der Stadt.",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Flieg nach {area:1638}: {npc:3033} bildet dich aus ({area:1639}). Himmelsgeborene: Flieg danach für den Zeppelin zurück nach {zone:1454}.",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Wirke {spell:18960}; {npc:11802} ist in {area:2361}. Die Schrein-Schmuckstücke liegen am Grund von {area:656} und vergehen binnen Minuten: Schwimm mit einem direkt zum {area:2362} am Nordwestufer, benutze es dort und sprich mit {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, nächster Guide",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, aus einem {object:177785} im See",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Am {area:2362}",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, am Schrein: {area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798} in {area:2361} fliegt Druiden dorthin; flieg dann weiter nach {zone:1454} zum Zeppelin",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "Zeppelin nach {zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Die Zeppelintürme stehen direkt vor dem Haupttor von {zone:1454}. Nimm den Zeppelin nach {zone:1420} (der andere fliegt nach {object:3202}).",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} bildet in {area:159} Paladine aus, ein kurzer Weg die Straße hinauf nach Norden von den Zeppelintürmen. Für den Silberwald kommst du dieselbe Straße zurück.",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "In den Silberwald",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "Der Zeppelin landet an den Türmen vor den {area:153}. Geh die Straße nach Westen an den Ruinen vorbei und nach Süden in den {zone:1421}; folge der Straße bis zum Ziel {area:228}.",
	["Road to Silverpine"] = "Straße zum Silberwald",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} ist die Gruftstadt der Verlassenen mitten im Wald. Alle, die du brauchst, stehen um den Grufteingang; {npc:2226}, der Fledermausführer, steht gleich östlich davon.",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Folge der Straße nach Süden. Die {object:1627} steht daneben, nördlich von Pyrewood.",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233} kommt später, auf der südlichen Runde",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Nördlich von {area:228}. {npc:1983} spukt auf dem {area:240}: Töte sie und geh dann über das Feld.",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "Die {object:177790} liegt an der Küste westlich vom {area:240}. Sie enthält den {item:15882} für {quest:30}.",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Folge der Straße nach Nordosten zum Haus der Yoricks bei {area:238}.",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} wartet nordöstlich des Hauses. Eskortiere ihn zurück zu {npc:1950}; unterwegs greifen Worgs an.",

	-- Step 16: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Scheckige Worgs",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Scheckige Worgs streifen durch die Hügel um das Haus.",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "Ruhestein: {area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "Das {object:1593} liegt an der Fähranlegestelle am Seeufer östlich vom Grabmal ({area:228}).",

	-- Step 20: Quinn Yorick
	["North again to the Yoricks' house."] = "Wieder nach Norden zum Haus der Yoricks.",

	-- Step 21: Vile Fin murlocs
	["Vile Fin murlocs"] = "Murlocs der Finsterflossen",
	-- {area:172} Fenris Isle
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Folge dem Seeufer nach Südosten Richtung {area:172}: Die Schredder und Gezeitenjäger der Finsterflossen dort lassen die Murlocaugen fallen.",

	-- Step 22: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Folge dem Seeufer nach Südosten und schwimm hinaus zur {area:172}. Gnolle der Moderfelle bevölkern die Insel; jede Art lässt Sekret fallen. Meide {area:235} auf der Nordseite, außer du willst die optionale Nische: Die Gnolle dort sind Stufe 18-22.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: seltene Beute von den Gnollen",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, gleich östlich der Burg",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}, in der Burg",

	-- Step 23: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "Schwimm zurück und folge der Straße nach Westen bis zum Grabmal ({area:228}).",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: für Quinn, am Ende auf der Straße nach Norden",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, auf der südlichen Runde",

	-- Step 24: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Die Straße nach Südosten hinunter nach {area:233}. Beschützer von Dalaran bewachen den Ortsrand und Magier von Dalaran den Ort; beide lassen Anhänger fallen. Hexer und Behüter von Dalaran patrouillieren auf den Straßen ringsum. Meide die Mitte, wo {npc:2120} steht.",

	-- Step 25: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Südwestlich von Ambermill spuken Zwangsarbeiter und Wächter von Rabenklaue in den Ruinen von {quest:516} im Südosten des Waldes.",

	-- Step 27: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "Ufer: {area:1338}",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Die Seepirscher und Orakel der Finsterflossen sitzen am Seeufer südlich der Fähre ({area:237}), östlich vom Grabmal ({area:228}).",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "{npc:1909} grinden: {area:1338}, {zone:1421}",

	-- Step 28: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "Behalte sie: {npc:2216} in {area:272}, ein späterer Guide",

	-- Step 29: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Nimm die Straße nach Norden Richtung {zone:1420}: Das Haus der Yoricks bei {area:238} liegt auf dem Weg. {quest:425} lauert ein kurzes Stück westlich davon.",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Folge der Straße nach Norden aus dem Silberwald nach {zone:1420} und weiter nach {area:159}: {npc:246152} bildet dort Paladine aus. Die Zeppelintürme liegen ein kurzes Stück die Straße hinunter nach Süden.",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Folge der Straße nach Norden aus dem Silberwald nach {zone:1420} und nach Osten zu den Zeppelintürmen vor den {area:153}. Nimm den Zeppelin nach {zone:1454}.",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Geh durch das Haupttor hinein. {npc:268701} steht im {object:172982}; {object:173016} ist ein paar Schritte nördlich.",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960} ist die Schlucht unter dem {object:172982}; {npc:3216} steht an ihrem hinteren Ende.",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} und {npc:3347} führen den Alchemieladen in der Gasse; {npc:11046} ist nebenan.",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Rohrkolben und Speergras wachsen am Wasser im {object:172958}, östlich der Gasse.",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} und {npc:268682} sitzen hinter Grommash Hold im {object:172957}; die Glatten Felsen liegen um sie herum. Trainiere, solange du in der Stadt bist (Druiden und Paladine haben hier keinen Lehrer). Der nächste Guide beginnt bei {npc:3310}, dem Windreitermeister im {object:172982}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, in Grommash Hold",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "Behalte sie: Thork in {area:380}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, eine Tour zu den Anführern der Horde",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Sprich mit {npc:3230} in Grommash Hold",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "Sprich mit {npc:3230}",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Sprich mit {npc:10540} in Grommash Hold",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "Sprich mit {npc:10540}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonrage Bloodhowlers"] = "Moonrage-Blutheuler",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Scheckige Worgs streifen durch die Hügel um das Haus. Geh dann am Seeufer entlang nach Süden: Die Schredder und Gezeitenjäger der Finsterflossen dort lassen die Murlocaugen fallen.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "Wieder nach Norden zum Haus der Yoricks. {quest:425} lauert ein kurzes Stück westlich davon.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Nördlich vom Grabmal ({area:228}). Nachtseele spukt auf dem Feld ({area:240}): Töte sie und geh dann über das Feld.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Nordöstlich der Flüchtlinge spuken die Zwangsarbeiter und Wächter von Rabenklaue in den Ruinen von {quest:516} im Südosten des Waldes.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Nur wenn {npc:1938} dir {quest:98298} gegeben hat: Die Blutheuler streifen durch die Wälder südwestlich von {area:233}, östlich von Pyrewood; sie lassen {item:280375} fallen.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Die Kränklichen und Hageren Flüchtlinge schlurfen die Straße südlich von Pyrewood entlang in Richtung Wall ({area:230}).",
	-- ["The refugees"] = "Die Flüchtlinge",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "Die {object:177790} liegt an der Küste westlich vom Todesfeld ({area:240}). Sie enthält den {item:15882} für {quest:30}.",
	-- ["Worgs and murlocs"] = "Worgs und Murlocs",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} ist die Gruftstadt der Verlassenen mitten im Wald. Alle, die du brauchst, stehen um den Grufteingang; {npc:2226}, der Fledermausführer, steht gleich östlich davon.",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: Nimm sie an, wenn er sie anbietet; sie kann auf seine Reihe {quest:98298} folgen, die die Route nicht macht",
}
