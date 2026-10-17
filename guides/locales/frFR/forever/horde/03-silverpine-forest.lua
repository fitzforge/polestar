-- French (frFR): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "Vers {area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Depuis {area:380}, suivez la route vers le nord-est jusqu'à {area:1637} et entrez par la porte principale. {npc:3310}, le maître des coursiers du vent, se tient sur la tour de {object:172982}.",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} se tient dans {object:172961}, à l'ouest de la ville.",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Volez jusqu'à {area:1638} : {npc:3033} vous entraîne sur {area:1639}. Éolides : revolez ensuite à {zone:1454} pour le zeppelin.",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960} ; {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) reposent au fond du {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'au {area:2362} sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127} : {area:384}, guide suivant",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, à {area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, à {area:2361}, y emmène les druides ; volez ensuite jusqu'à {zone:1454} pour le zeppelin",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "Zeppelin pour {zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Les tours des zeppelins se dressent juste devant la porte principale d'{zone:1454}. Prenez le zeppelin pour {zone:1420} (l'autre va à {object:3202}).",
	["Zeppelin tower"] = "Tour du zeppelin",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} entraîne les paladins à {area:159}, à courte distance au nord par la route depuis les tours des zeppelins. Redescendez la même route pour la forêt des Pins argentés.",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "Vers la forêt des Pins argentés",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "Le zeppelin se pose aux tours devant {area:153}. Marchez vers l'ouest le long de la route au-delà des ruines, puis vers le sud dans {zone:1421} ; suivez la route jusqu'à {area:228}.",
	["Road to Silverpine"] = "Route de la forêt des Pins argentés",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} est la ville-crypte des Réprouvés, au milieu de la forêt. Tous ceux dont vous avez besoin se tiennent autour de l'entrée de la crypte ; {npc:2226}, le maître des chauves-souris, est juste à l'est.",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Suivez la route vers le sud. {object:1627} se trouve au bord, au nord de Bois-du-Bûcher.",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233} viendra plus tard, sur la boucle sud",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Au nord de {area:228}. {npc:1983} hante le {area:240} : tuez-le, puis traversez le champ.",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} se trouve sur la côte à l'ouest du {area:240}. Il contient {item:15882} pour {quest:30}.",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Suivez la route vers le nord-est jusqu'à la maison des Yorick, à {area:238}.",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} attend au nord-est de la maison. Escortez-le jusqu'à {npc:1950} ; des worgs attaquent en chemin.",

	-- Step 16: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "Pierre de foyer vers {area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} se trouve à l'embarcadère du bac, sur la rive du lac à l'est de {area:228}.",

	-- Step 20: Quinn Yorick
	["North again to the Yoricks' house."] = "",

	-- Step 21: Vile Fin murlocs
	["Vile Fin murlocs"] = "",
	-- {area:172} Fenris Isle
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 22: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Longez la rive du lac vers le sud-est et nagez jusqu'à l'{area:172}. Les gnolls Poil-Putride couvrent l'île ; chaque type lâche de l'ichor. N'entrez pas dans le {area:235} au nord, sauf pour la niche facultative : les gnolls y sont de niveau 18-22.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317} : butin rare des gnolls",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, juste à l'est du donjon",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}, dans le donjon",

	-- Step 23: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "Revenez à la nage et suivez la route vers l'ouest jusqu'à {area:228}.",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121} : {quest:516}, sur la boucle sud",

	-- Step 24: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Descendez la route vers le sud-est jusqu'à {area:233}. Les Protecteurs de Dalaran gardent les abords et les Mages de Dalaran la ville ; les deux lâchent des pendentifs. Des Sorciers et des Gardiens de Dalaran patrouillent sur les routes alentour. Évitez le centre, où se tient {npc:2120}.",

	-- Step 25: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 27: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "Rive de {area:1338}",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Les Rôdeurs lacustres et les Oracles Aileron noir se trouvent sur la rive du lac au sud de {area:237}, à l'est de {area:228}.",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "tuez des {npc:1909} à {area:1338}, {zone:1421}",

	-- Step 28: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "Gardez-la : {npc:2216} à {area:272}, dans un guide ultérieur",

	-- Step 29: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Suivez la route vers le nord hors de la forêt des Pins argentés, dans {zone:1420}, jusqu'à {area:159} : {npc:246152} y entraîne les paladins. Les tours des zeppelins sont à courte distance au sud par la route.",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Suivez la route vers le nord hors de la forêt des Pins argentés, dans {zone:1420}, puis vers l'est jusqu'aux tours des zeppelins devant {area:153}. Prenez le zeppelin pour {zone:1454}.",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entrez par la porte principale. {npc:268701} se tient dans {object:172982} ; {object:173016} est à quelques pas au nord.",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960} est le canyon sous {object:172982} ; {npc:3216} se tient tout au fond.",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} et {npc:3347} tiennent la boutique d'alchimie de la Herse ; {npc:11046} est juste à côté.",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Les massettes et les herbes-lances poussent au bord de l'eau dans {object:172958}, à l'est de la Herse.",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} et {npc:268682} sont assis derrière le fort Grommash, dans {object:172957} ; les Rochers lisses sont autour d'eux. Entraînez-vous pendant que vous êtes en ville (les druides et les paladins n'ont pas de maître ici). Le guide suivant commence auprès de {npc:3310}, le maître des coursiers du vent de {object:172982}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dans le fort Grommash",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "Gardez-la : Thork à {area:380}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949} : {quest:93739}, une tournée des chefs de la Horde",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Parlez à {npc:3230}, dans le fort Grommash",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Parlez à {npc:10540}, dans le fort Grommash",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450} ; {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire reposent au fond de {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'à {area:2362}, sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. {npc:14235} Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Suivez la rive du lac vers le sud-est et nagez jusqu'à {area:172}. Les gnolls Poil-Putride ({npc:14235}) couvrent l'île ; chaque type lâche de l'ichor. Évitez {area:235}, au nord de l'île, sauf pour l'objectif optionnel : les gnolls y sont de niveau 18-22.",
	-- ["Moonrage Bloodhowlers"] = "Hurle-sang Ragelune",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Les Worgs chamarrés rôdent sur les collines autour de la maison. Marchez ensuite vers le sud le long de la rive du lac : les Déchiqueteurs et les Chasse-marée Aileron noir y lâchent les yeux de murloc.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "Retournez au nord jusqu'à la maison des Yorick. {quest:425} rôde à courte distance à l'ouest.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Au nord de {area:228}. Cinglenuit hante {area:240} : tuez-le, puis traversez le champ.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Au nord-est des réfugiés, les Manouvriers et les Gardiens Ravenclaw hantent les ruines de {quest:516}, au sud-est de la forêt.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Seulement si {npc:1938} vous a donné {quest:98298} : les Hurle-sang rôdent dans les bois au sud-ouest de {area:233}, à l'est de Bois-du-Bûcher ; ils lâchent {item:280375}.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Les Réfugiés malades et hagards errent sur la route au sud de Bois-du-Bûcher, vers {area:230}.",
	-- ["The cattails and speargrass grow along the water in the {object:172958}, east of the {object:172959}."] = "Les quenouilles et les herbes-lances poussent au bord de l'eau dans {object:172958}, à l'est de {object:172959}.",
	-- ["The refugees"] = "Les réfugiés",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} se trouve sur la côte à l'ouest de {area:240}. Il contient {item:15882} pour {quest:30}.",
	-- ["Worgs and murlocs"] = "Worgs et murlocs",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} est la ville-crypte des Réprouvés, au milieu de la forêt. Tous ceux dont vous avez besoin se tiennent autour de l'entrée de la crypte ; {npc:2226}, le maître des chauves-souris, est juste à l'est.",
	-- ["{area:263} of Shadow is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{area:263} de l'ombre est le canyon sous {object:172982} ; {npc:3216} se tient tout au bout.",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938} : prenez-la s'il la propose ; elle peut faire suite à sa série {quest:98298}, que l'itinéraire ne suit pas",
	-- ["{npc:3348} and {npc:3347} run the alchemy shop in the {object:172959}; {npc:11046} is next door."] = "{npc:3348} et {npc:3347} tiennent la boutique d'alchimie dans {object:172959} ; {npc:11046} est juste à côté.",
}
