-- French (frFR): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:268701} Thatog
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:268701} by the bank below it."] = "",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960} est le canyon sous {object:172982} ; {quest:829} se tient tout au fond.",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} et {npc:3347} tiennent la boutique d'alchimie de la Herse ; {npc:11046} est juste à côté.",

	-- Step 5: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Les massettes et les herbes-lances poussent au bord de l'eau dans {object:172958}, à l'est de la Herse.",

	-- Step 6: Class trainer
	["Class trainer"] = "Maître de classe",
	["Train while you are in the city: Druids and Paladins have no trainer here."] = "",

	-- Step 7: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11868} ({object:172958}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 8: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:2704} ({object:172958}, 10 pièces d'argent) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 9: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:2704} ({object:172958}, 10 pièces d'argent) ; un bâton apporte plus de caractéristiques de sorts qu'une arme à une main pendant la progression.",

	-- Step 12: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "",

	-- Step 13: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dans le fort Grommash",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949} : {quest:93739}, une tournée des chefs de la Horde",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Parlez à {npc:3230}, dans le fort Grommash",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "Parlez à {npc:3230}",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Parlez à {npc:10540}, dans le fort Grommash",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "Parlez à {npc:10540}",

	-- Step 14: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "",

	-- Step 15: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 16: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}, à l'intérieur",

	-- Step 17: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "",

	-- Step 18: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "",

	-- Step 20: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} entraîne les paladins à {area:159}, à courte distance au nord par la route depuis les tours des zeppelins. Redescendez la même route pour la forêt des Pins argentés.",

	-- Step 22: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} est la ville-crypte des Réprouvés, au milieu de la forêt. Tous ceux dont vous avez besoin se tiennent autour de l'entrée de la crypte ; {npc:2226}, le maître des chauves-souris, est juste à l'est.",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}, sous terre",

	-- Step 24: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Suivez la route vers le sud. {object:1627} se trouve au bord, au nord de Bois-du-Bûcher.",

	-- Step 25: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Au nord de {area:228}. {npc:1983} hante le {area:240} : tuez-le, puis traversez le champ.",

	-- Step 26: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Suivez la route vers le nord-est jusqu'à la maison des Yorick, à {area:238}.",

	-- Step 27: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Worgs chamarrés",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Les Worgs chamarrés rôdent sur les collines autour de la maison.",

	-- Step 28: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} attend au nord-est de la maison. Escortez-le jusqu'à {npc:1950} ; des worgs attaquent en chemin.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "{npc:1978}, à l'intérieur",

	-- Step 31: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "",

	-- Step 32: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "",

	-- Step 33: Quinn Yorick
	["North again to the Yoricks' house."] = "Retournez au nord jusqu'à la maison des Yorick.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "{npc:1951}, à l'intérieur",

	-- Step 34: Vile Fin murlocs
	["Vile Fin murlocs"] = "Murlocs Aileron noir",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 35: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "",

	-- Step 36: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Stay out of the middle, where {npc:2120} stands."] = "",

	-- Step 37: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937} : pour Quinn, sur la route du nord à la fin",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "",

	-- Step 38: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Prenez la route du nord vers {zone:1420} : la maison des Yorick, à {area:238}, est sur le chemin. {quest:425} rôde à courte distance à l'ouest.",
	["Inside"] = "À l'intérieur",

	-- Step 40: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "{area:159} est à quelques pas au nord en remontant la route depuis les tours du zeppelin ; {npc:1499} est dans l'hôtel de ville.",

	-- Step 42: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, dans l'Apothicarium",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "",

	-- Step 43: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Parlez à {npc:10181}, dans {object:36126} : {quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "Parlez à {npc:10181}",

	-- Step 44: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 45: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 46: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "Entrez par la grande porte. {npc:268701} se tient dans la {object:172982}.",

	-- Step 52: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11868} ({object:172958}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 54: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide walks from here to {area:379} and the Crossroads."] = "",

	-- Step 55: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "À {area:2362}",
	-- ["Back to {area:130}"] = "Retour à la {area:130}",
	-- ["Below ground"] = "Sous terre",
	-- ["Cast Teleport: {zone:1450}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450} ; {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire reposent au fond de {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'à {area:2362}, sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- ["Cast {spell:18960}"] = "Lancez {spell:18960}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960} ; {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire reposent au fond du {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'au {area:2362}, sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- ["Druid trainer"] = "Maître des druides",
	-- ["Fly to {area:1638}"] = "Prendre un vol pour {area:1638}",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Volez jusqu'à {area:1638} : {npc:3033} vous entraîne sur {area:1639}. Éolides : revolez ensuite à {zone:1454} pour le zeppelin.",
	-- ["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Longez la rive du lac vers le sud-est et nagez jusqu'à l'{area:172}. Les gnolls Poil-Putride couvrent l'île ; chaque type lâche de l'ichor. N'entrez pas dans le {area:235} au nord, sauf pour la niche facultative : les gnolls y sont de niveau 18-22.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. {npc:14235} Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Suivez la rive du lac vers le sud-est et nagez jusqu'à {area:172}. Les gnolls Poil-Putride ({npc:14235}) couvrent l'île ; chaque type lâche de l'ichor. Évitez {area:235}, au nord de l'île, sauf pour l'objectif optionnel : les gnolls y sont de niveau 18-22.",
	-- ["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Suivez la rive du lac vers le sud-est en direction de {area:172} : les Déchiqueteurs Aileron noir et les Chasse-marée Aileron noir qui la longent lâchent les yeux de murloc.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Suivez la route vers le nord hors de la forêt des Pins argentés, dans {zone:1420}, puis vers l'est jusqu'aux tours des zeppelins devant {area:153}. Prenez le zeppelin pour {zone:1454}.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Suivez la route vers le nord hors de la forêt des Pins argentés, dans {zone:1420}, jusqu'à {area:159} : {npc:246152} y entraîne les paladins. Les tours des zeppelins sont à courte distance au sud par la route.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Depuis {area:380}, suivez la route vers le nord-est jusqu'à {area:1637} et entrez par la porte principale. {npc:3310}, le maître des coursiers du vent, se tient sur la tour de {object:172982}.",
	-- ["From the {area:380}, follow the road north-east to {zone:1454} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Depuis la {area:380}, suivez la route vers le nord-est jusqu'à {zone:1454} et entrez par la grande porte. {npc:3310}, le maître des coursiers du vent, se tient sur la tour, dans la {object:172982}.",
	-- ["Hearth to the {area:228}"] = "Pierre de foyer vers {area:228}",
	-- ["Hearth to {area:228}"] = "Pierre de foyer vers le {area:228}",
	-- ["Into Silverpine"] = "Vers la forêt des Pins argentés",
	-- ["Keep it: Thork at the {area:380}"] = "Gardez-la : Thork à {area:380}",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "Gardez-la : {npc:2216} à {area:272}, dans un guide ultérieur",
	-- ["Level 16.51"] = "Niveau 16.51",
	-- ["Moonrage Bloodhowlers"] = "Hurle-sang Ragelune",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Les Worgs chamarrés rôdent sur les collines autour de la maison. Marchez ensuite vers le sud le long de la rive du lac : les Déchiqueteurs et les Chasse-marée Aileron noir y lâchent les yeux de murloc.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "Retournez au nord jusqu'à la maison des Yorick. {quest:425} rôde à courte distance à l'ouest.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Au nord de {area:228}. Cinglenuit hante {area:240} : tuez-le, puis traversez le champ.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Au nord-est des réfugiés, les Manouvriers et les Gardiens Ravenclaw hantent les ruines de {quest:516}, au sud-est de la forêt.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Seulement si {npc:1938} vous a donné {quest:98298} : les Hurle-sang rôdent dans les bois au sud-ouest de {area:233}, à l'est de Bois-du-Bûcher ; ils lâchent {item:280375}.",
	-- ["Paladin trainer"] = "Maître des paladins",
	-- ["Road to Silverpine"] = "Route de la forêt des Pins argentés",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Descendez la route vers le sud-est jusqu'à {area:233}. Les Protecteurs de Dalaran gardent les abords et les Mages de Dalaran la ville ; les deux lâchent des pendentifs. Des Sorciers et des Gardiens de Dalaran patrouillent sur les routes alentour. Évitez le centre, où se tient {npc:2120}.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Au sud-ouest de Moulin-de-l'Ambre, les manouvriers et gardiens Ravenclaw hantent les ruines de {quest:516}, au sud-est de la forêt.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest.\nCareful: The cave passages are narrow, so it is easy to pull extra mobs. Three mobs guard the entrance, and one of them walks a short patrol away from the other two."] = "Au sud-ouest de Moulin-de-l'Ambre, les Manouvriers et les Gardiens Ravenclaw hantent les ruines de {quest:516}, au sud-est de la forêt.\nAttention : les passages de la grotte sont étroits, il est facile d'attirer des monstres en plus. Trois monstres gardent l'entrée, et l'un d'eux fait une courte patrouille à l'écart des deux autres.",
	-- ["Swim back and follow the road west to the {area:228}."] = "Revenez à la nage et suivez la route vers l'ouest jusqu'à {area:228}.",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Prenez la route vers le nord en direction des {area:85} : la maison des Yorick, à {area:238}, est sur le chemin. {quest:425} rôde à quelques pas à l'ouest.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Les Réfugiés malades et hagards errent sur la route au sud de Bois-du-Bûcher, vers {area:230}.",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Les Rôdeurs lacustres et les Oracles Aileron noir se trouvent sur la rive du lac au sud de {area:237}, à l'est de {area:228}.",
	-- ["The cattails and speargrass grow along the water in the {object:172958}, east of the {object:172959}."] = "Les quenouilles et les herbes-lances poussent au bord de l'eau dans {object:172958}, à l'est de {object:172959}.",
	-- ["The refugees"] = "Les réfugiés",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "Le zeppelin se pose aux tours devant {area:153}. Marchez vers l'ouest le long de la route au-delà des ruines, puis vers le sud dans {zone:1421} ; suivez la route jusqu'à {area:228}.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Les tours des zeppelins se dressent juste devant la porte principale d'{zone:1454}. Prenez le zeppelin pour {zone:1420} (l'autre va à {object:3202}).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} se trouve à l'embarcadère du bac, sur la rive du lac à l'est de {area:228}.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790} se trouve sur la côte à l'ouest du {area:240}. Il contient {item:15882} pour L'épreuve du lion de mer.",
	-- ["To {area:1637}"] = "Vers {area:1637}",
	-- ["To {zone:1454}"] = "Vers {zone:1454}",
	-- ["Top up here to level 16.51 before the hand-ins at {area:239}: they take you to level 17."] = "Montez ici jusqu'au niveau 16.51 avant de rendre les quêtes ({area:239}) : elles vous font passer au niveau 17.",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entrez par la porte principale. {npc:268701} se tient dans {object:172982} ; {object:173016} est à quelques pas au nord.",
	-- ["Worgs and murlocs"] = "Worgs et murlocs",
	-- ["Zeppelin to {zone:1420}"] = "Zeppelin pour {zone:1420}",
	-- ["Zeppelin tower"] = "Tour du zeppelin",
	-- ["grind on {npc:1888}"] = "tuez en boucle : {npc:1888}",
	-- ["grind on {npc:1909} at {area:1338}, {area:130}"] = "tuez en boucle : {npc:1909} à {area:1338}, {area:130}",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "tuez des {npc:1909} à {area:1338}, {zone:1421}",
	-- ["grind on {npc:1914}"] = "tuez en boucle : {npc:1914}",
	-- ["grind on {npc:1940}"] = "tuez en boucle : {npc:1940}",
	-- ["grind on {npc:1983}"] = "tuez en boucle : {npc:1983}",
	-- ["the {area:228}"] = "le {area:228}",
	-- ["{area:130}: kill these as you meet them"] = "{area:130} : tuez-les au passage",
	-- ["{area:1338} shore"] = "Rive de {area:1338}",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it.\nSwim back and follow the road west to the {area:228}."] = "Le {area:228} est la ville-crypte des Réprouvés, au milieu de la forêt. Tous ceux dont vous avez besoin se tiennent autour de l'entrée de la crypte ; {npc:2226}, le dresseur de chauves-souris, est juste à l'est.\nRetournez à la nage et suivez la route vers l'ouest jusqu'au {area:228}.",
	-- ["{area:233} comes later, on the southern loop"] = "{area:233} viendra plus tard, sur la boucle sud",
	-- ["{area:263} of Shadow is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{area:263} de l'ombre est le canyon sous {object:172982} ; {npc:3216} se tient tout au bout.",
	-- ["{area:392} flight master"] = "Maître de vol de {area:392}",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317} : butin rare des gnolls",
	-- ["{item:3354} along the way to the {area:228}"] = "{item:3354} sur le chemin du {area:228}",
	-- ["{item:3354} on the way"] = "{item:3354} en chemin",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, à {area:2361}, y emmène les druides ; volez ensuite jusqu'à {zone:1454} pour le zeppelin",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}, à {area:2362}",
	-- ["{npc:1499} in {area:159}, on the way to the zeppelin at 19"] = "{npc:1499} à {area:159}, sur le chemin du zeppelin au niveau 19",
	-- ["{npc:1769} on the way"] = "{npc:1769} en chemin",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938} : prenez-la s'il la propose ; elle peut faire suite à sa série {quest:98298}, que l'itinéraire ne suit pas",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121} : {quest:516}, sur la boucle sud",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} aux {zone:1456} ; {zone:1454} n'a pas de maître des paladins",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} et {npc:268682} sont assis derrière le fort Grommash, dans la {object:172957} ; les Rochers lisses se trouvent autour d'eux. Entraînez-vous pendant que vous êtes en ville (les Druides et les Paladins n'ont pas de maître ici). Le prochain guide commence auprès de {npc:3310}, le maître des coursiers du vent, dans la {object:172982}.",
	-- ["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} en {zone:1412} ; {zone:1454} n'a pas de maître des druides",
	-- ["{npc:3348} and {npc:3347} run the alchemy shop in the {object:172959}; {npc:11046} is next door."] = "{npc:3348} et {npc:3347} tiennent la boutique d'alchimie dans {object:172959} ; {npc:11046} est juste à côté.",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} se tient dans {object:172961}, à l'ouest de la ville.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, dans le donjon",
	-- ["{object:112888}, inside the keep; upstairs"] = "{object:112888}, dans le fort ; à l'étage",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}, juste à l'est du donjon",
	-- ["{object:173016} is a few steps north.\nThe {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "La {object:173016} est à quelques pas au nord.\n{object:172960} est le canyon sous la {object:172982} ; {quest:829} se tient tout au fond.",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127} : {area:384}, guide suivant",
	-- ["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
}
