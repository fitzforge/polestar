-- French (frFR): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "Réputation : Fossoyeuse",
	-- {item:14047} Runecloth
	["The Plaguelands' level 55-60 quests and {item:14047} to Exalted, with Tirisfal's old quests as an optional extra."] = "Les quêtes de niveau 55-60 des Maleterres et l'{item:14047} jusqu'à Exalté, avec les anciennes quêtes des clairières de Tirisfal en option.",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "Exalté auprès de {faction:68}",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68} : comment ça marche",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {object:1772} Tarren Mill (no name in this language: may be words) · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, Hillsbrad and {object:1772} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "",

	-- Step 2: Undercity: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {faction:68} Undercity
	["The level 55 to 60 quests pay in full. First the Bulwark: {npc:10879}, by the {faction:68}'s elevators, sends you there."] = "",

	-- Step 3: The Bulwark: Scarlet Diversions
	-- {quest:5096} Scarlet Diversions
	["The Bulwark: {quest:5096}"] = "",
	-- {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {item:12807} Scourge Banner
	["The Bulwark is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation, about 710 at 60 if the level 53 quests pay less. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between Dalson's Tears and Felstone Field and plant the {item:12807} beside it."] = "",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}, +100 (niveau 53)",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "le camp avancé de la Croisade écarlate",

	-- Step 4: The Bulwark: the cauldrons
	["The Bulwark: the cauldrons"] = "",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}, +100 (niveau 53)",

	-- Step 5: Felstone Field and the Andorhal towers
	["Felstone Field and the Andorhal towers"] = "",
	-- {npc:11075} Cauldron Lord Bilemaw · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at Felstone Field. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "le {object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902} : utilisez la {item:12815} à la porte",

	-- Step 6: The Bulwark: Dalson's Tears
	["The Bulwark: Dalson's Tears"] = "",

	-- Step 7: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:11077} Cauldron Lord Malvinious
	["{npc:11077} guards the cauldron at Dalson's Tears."] = "",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "le {object:177289}",

	-- Step 8: The Bulwark: the Writhing Haunt
	["The Bulwark: the Writhing Haunt"] = "",

	-- Step 9: The Writhing Haunt
	["The Writhing Haunt"] = "",
	-- {npc:11076} Cauldron Lord Razarch
	["{npc:11076} guards the cauldron at the Writhing Haunt."] = "",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "le {object:176393}",

	-- Step 10: The Bulwark: Gahrron's Withering
	["The Bulwark: Gahrron's Withering"] = "",

	-- Step 11: Gahrron's Withering
	["Gahrron's Withering"] = "",
	-- {npc:11078} Cauldron Lord Soulwrath
	["{npc:11078} guards the cauldron at Gahrron's Withering."] = "",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "le {object:176392}",

	-- Step 12: The Bulwark: done
	["The Bulwark: done"] = "",
	-- {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["The Bulwark is also where The Key to Scholomance ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "",

	-- Step 13: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 500 {faction:68} reputation."] = "{npc:11878}, le seigneur forestier, a son camp à la lisière ouest des {zone:1423}. Ses quêtes sont de niveau 58 à 60 et paient en entier : 500 de réputation {faction:68}.",

	-- Step 14: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {object:176970} Corin's Crossing (no name in this language: may be words)
	["Plaguebats, Quel'Lithien Lodge and {object:176970}"] = "",
	-- {item:15847} Quel'Thalas Registry · {object:176970} Corin's Crossing (no name in this language: may be words) · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. Quel'Lithien Lodge is north-west of Light's Hope Chapel; the {item:15847} lies inside. Do {object:176970} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448} : 7 {item:15447} et le {item:15454}",

	-- Step 15: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878} : rendez les quêtes",

	-- Step 16: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897} et {npc:11896}",
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897}, an elite bat, roams the fields north of Marris Stead. {npc:11896} paces a long valley west of Northdale."] = "",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {npc:12337} Crimson Courier
	["{npc:11878}: 500 {faction:68} reputation. His Stratholme quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "",

	-- Step 17: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936} (suite optionnelle)",
	-- {zone:1425} Hinterlands · {object:1772} Tarren Mill (no name in this language: may be words) · {object:3276} Sen'jin Village (no name in this language: may be words) · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {object:1772}, {object:3276}, Zul'Farrak and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 (a fifth at 60 in Classic, 440 {faction:68} in all then). Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "",

	-- Step 19: Shadra'Alor: an Undamaged Venom Sac
	-- {npc:2707} Shadra · {quest:2934} Undamaged Venom Sac
	["{npc:2707}'Alor: an {quest:2934}"] = "",
	-- {npc:2707} Shadra · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {npc:2707}'Alor in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}, sur les Gardes du clan Witherbark",

	-- Step 20: Tarren Mill, then Sen'jin Village
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {object:3276} Sen'jin Village (no name in this language: may be words)
	["{object:1772}, then {object:3276}"] = "",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}, +75 Sombrelance",
	-- {npc:3188} Master Gadrin · {object:3276} Sen'jin Village (no name in this language: may be words)
	["{npc:3188}, in {object:3276}"] = "",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}, +150 Sombrelance",

	-- Step 21: Zul'Farrak: the Tablet of Theka
	-- {object:142715} Tablet of Theka
	["Zul'Farrak: the {object:142715}"] = "",
	-- {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["Zul'Farrak is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "",
	["Zul'Farrak"] = "",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "lisez la {object:142715}",

	-- Step 23: Shadra'Alor: Shadra
	-- {npc:2707} Shadra
	["{npc:2707}'Alor: {npc:2707}"] = "",
	-- {item:9323} Gadrin's Parchment · {npc:2707} Shadra
	["Read {item:9323} at the altar of {npc:2707}'Alor to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}, sur {npc:2707}",

	-- Step 24: Tarren Mill and the Undercity
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {faction:68} Undercity
	["{object:1772} and the {faction:68}"] = "",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, dans l'Apothicarium",

	-- Step 25: Deathknell (optional hub)
	["Deathknell (optional hub)"] = "",
	-- {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Deathknell, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes (180 at a fifth). Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "",

	-- Step 26: Deathknell: the next quests
	["Deathknell: the next quests"] = "",

	-- Step 27: Around Deathknell
	["Around Deathknell"] = "",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "Les {object:164662} sont tout autour du village. La mine ({quest:380}) est au nord-ouest ; les Réprouvés entoilés ({npc:271961}) y sont suspendus. {npc:1919} attend au camp en ruine au bord de la route, au nord-est : enterrez ses restes sur la {object:178090}, au premier rang du cimetière du village.",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "{npc:271961} libéré",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "{object:178090}, avec le {item:16333}",

	-- Step 28: Deathknell: hand in
	["Deathknell: hand in"] = "",

	-- Step 29: The Scarlet camp
	["The Scarlet camp"] = "Le camp écarlate",
	-- {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of Deathknell. {npc:1667} leads it."] = "",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}, sur {npc:1667}",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand
	["{quest:383}, +75: to {npc:1515} in Brill"] = "",

	-- Step 30: Brill: Executor Zygand
	-- {npc:1515} Executor Zygand
	["Brill: {npc:1515}"] = "",

	-- Step 31: Brill (optional hub)
	["Brill (optional hub)"] = "",
	-- {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Brill and the fields around it: about 1,100 {faction:68} reputation in 45 minutes (220 at a fifth). {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "",

	-- Step 32: Around Brill
	["Around Brill"] = "",
	-- {item:286176} Executor's Motivator · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around Brill. For {quest:99141}, talk to {npc:1496} west of Brill, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of Brill. The {npc:1525} walk around the old bridge west of Brill; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "",
	["Motivate 5 Deathguards"] = "Motivez 5 Gardes noirs",

	-- Step 33: Agamand Mills
	-- {npc:1657} Devlin Agamand · {object:1631} Agamand Mills (no name in this language: may be words)
	["{npc:1657} walks the road to {object:1631}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "",

	-- Step 34: Brill: hand in
	["Brill: hand in"] = "",

	-- Step 35: Agamand Mills again
	-- {object:1631} Agamand Mills (no name in this language: may be words)
	["{object:1631} again"] = "",
	-- {object:1631} Agamand Mills (no name in this language: may be words)
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {object:1631} drop the ribs; the Darkeye Bonecasters the skulls."] = "",

	-- Step 36: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "À partir d'ici, ce sont les étoffes. La laine, la soie et le tisse-mage doivent tous être donnés avant que {npc:14729} propose le don d'{item:14047}, et {quest:7819} demande le don d'{item:14047}. Achetez les étoffes à l'hôtel des ventes, ou farmez-les : les humanoïdes en laissent, la laine du niveau 15 à 25, la soie 25 à 40, le tisse-mage 40 à 50, l'{item:14047} 50 et plus. Au niveau 60, farmez des monstres de niveau 52 ou plus : les plus bas sont gris.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592} : les furbolgs Crin-de-Chardon en laissent environ une fois sur quatre",

	-- Step 37: A Donation of Silk
	["Silk: the Syndicate in Hillsbrad and Alterac drop it about one kill in three, or buy it."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306} : le Syndicat",

	-- Step 38: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Tisse-mage : les satyres Jadefeu du sud de {zone:1448} et les ogres Cognedune de {zone:1446} en laissent environ une fois sur trois, ou achetez-le.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338} : les satyres Jadefeu",

	-- Step 39: A Donation of Runecloth
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words) · {zone:1423} Eastern Plaguelands · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {object:176973} in the {zone:1423}, the Gordok ogres outside Dire Maul in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "",
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words)
	["{item:14047}: the Scarlet outside {object:176973}"] = "",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819} jusqu'à Honoré",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819} : 20 {item:14047} pour 50 de réputation, autant de fois que vous voulez. D'Amical à Honoré, il faut 6 000 : 120 remises, 2 400 {item:14047}, moins ce que les quêtes vous ont donné (un mort-vivant commence à Amical 1 000 : 100 remises ; toutes les autres races commencent à Neutre 500 et ont d'abord besoin de 50 remises, 1 000 {item:14047}, pour atteindre Amical). Rendez chaque lot de 20 que vous portez, l'un après l'autre.",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819} jusqu'à Révéré",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} (Blackrock Depths) pays 150 in full."] = "",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819} jusqu'à Exalté",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in Brill sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731} : les chevaux squelettes",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Around {area:154}"] = "Autour de {area:154}",
	-- ["Around {area:159}"] = "Autour de {area:159}",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour l'{object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "D'Honoré à Révéré, il faut 12 000 : 240 remises, 4 800 {item:14047}. La {item:12358} ({area:1584}) rapporte 150 en entier.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes (180 at a fifth). Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. {area:154}, le départ des Réprouvés à l'extrémité ouest des clairières de Tirisfal : environ 900 de réputation {faction:68} en 25 minutes (180 au cinquième). Les quêtes de la zone de départ ne donnent rien aux autres villes. {npc:1661}, {npc:1570} et {npc:1740} se tiennent dans le village.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes (220 at a fifth). {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. {area:159} et les champs alentour : environ 1 100 de réputation {faction:68} en 45 minutes (220 au cinquième). {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} et {npc:1500} sont en ville.",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7819} jusqu'à être Exalté auprès de {faction:68}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7819}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les centaures kolkar (niveau 30-33) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Plaguebats, {area:2276} and {area:2264}"] = "Chauves-souris pestiférées, {area:2276} et {area:2264}",
	-- ["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "Lisez le {item:9323} à l'autel de {area:353} pour appeler {npc:2707}, une araignée élite de niveau 55 : elle laisse son venin à chaque fois.",
	-- ["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Révéré à Exalté, il faut 21 000 : 420 remises, 8 400 {item:14047}. Pour la Horde ! (la tête de Rend) et Le seigneur de Rochenoire (la tête de Nefarian) rapportent 200 à chaque ville de la Horde. À Exalté, {npc:4731} à {area:159} vend les chevaux squelettes à toutes les races de la Horde : 20 po pour un cheval de niveau 40, 200 po pour un cheval de guerre de niveau 60 (les prix de Forever) ; dans Classic, les autres races devaient être Exaltées pour les acheter.",
	-- ["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Soie : le Syndicat à {area:287} et en Alterac en laisse environ une fois sur trois, ou achetez-la.",
	-- ["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 (a fifth at 60 in Classic, 440 {faction:68} in all then). Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "Six quêtes à travers les {zone:1425}, {area:272}, {area:367}, {area:978} et {faction:68} : 600 de réputation {faction:68} et 225 de Sombrelance. {quest:2937} et {quest:2938} sont de niveau 55 et paient 400 en entier au niveau 60 ; les quatre précédentes sont de niveau 43 à 45 (un cinquième au niveau 60 dans Classic, soit 440 de {faction:68} en tout). Comptez environ 90 minutes avec les trajets. Les flacons de venin ({quest:2933}) sont posés sur les tables du village Witherbark à l'ouest des {zone:1425} : cliquez sur l'un d'eux pour commencer.",
	-- ["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "Les Chauves-souris pestiférées nuisibles volent dans le sud de la zone, les Chauves-souris pestiférées monstrueuses plus au nord-ouest. Le {area:2276} est au nord-ouest de la {area:2268} ; le {item:15847} se trouve à l'intérieur. Faites {area:2264} en dernier : son Fléau laisse de la {item:15447}, qui ne dure que 10 minutes. Avec 7 dans vos sacs, utilisez aussitôt le {item:15454} pour obtenir la {item:15448}.",
	-- ["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "Le camp écarlate est au sud-est de {area:154}. {npc:1667} le dirige.",
	-- ["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "Les Gardes du clan Witherbark rampent autour de {area:353} dans le sud-ouest des {zone:1425} ; environ un sur dix porte un sac intact.",
	-- ["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there."] = "Les quêtes de niveau 55 à 60 paient en entier. D'abord le {area:152} : {npc:10879}, près des ascenseurs de {faction:68}, vous y envoie.",
	-- ["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "Les squelettes de {area:157} laissent les côtes ; les Ossomanciens Sombroeil, les crânes.",
	-- ["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "Utilisez le {item:286176} sur cinq Gardes noirs autour de {area:159}. Pour {quest:99141}, parlez à {npc:1496} à l'ouest de {area:159}, à {npc:251001} au relais à l'est et à {npc:10666} sur la route. Les gnolls Poil-Putride creusent dans la fosse commune au nord de {area:159}. Les morts pourrissants ({npc:1525}) errent autour du vieux pont à l'ouest de {area:159} ; les branches sèches sont sous les arbres à cet endroit. Des sombredogues rôdent partout.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de la {area:381} (niveau 16-17) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "C'est aussi au {area:152} que se termine La clé de {area:2057} (200), après une plus longue suite de quêtes. {npc:10136}, dans l'Apothicarium de {faction:68}, paie environ 290 de plus pour des limons de {zone:1448} et du {zone:1449}.",
	-- ["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation, about 710 at 60 if the level 53 quests pay less. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "Le {area:152} est le camp des Réprouvés sur la route qui mène des clairières de Tirisfal aux {zone:1422}. La suite de quêtes de {npc:10837} vous envoie contre les chaudrons du Fléau des {zone:1422} : environ 820 de réputation {faction:68}, environ 710 au niveau 60 si les quêtes de niveau 53 rapportent moins. Prenez des {item:12814} dans la caisse à côté de lui ; brûlez la tente de commandement du camp écarlate entre les {area:200} et le {area:199} et plantez la {item:12807} à côté.",
	-- ["{area:152}: done"] = "{area:152} : terminé",
	-- ["{area:152}: the cauldrons"] = "{area:152} : les chaudrons",
	-- ["{area:152}: the {area:202}"] = "{area:152} : le {area:202}",
	-- ["{area:154} (optional hub)"] = "{area:154} (étape facultative)",
	-- ["{area:154}: hand in"] = "{area:154} : rendez les quêtes",
	-- ["{area:154}: the next quests"] = "{area:154} : les quêtes suivantes",
	-- ["{area:157} again"] = "De nouveau {area:157}",
	-- ["{area:159} (optional hub)"] = "{area:159} (étape facultative)",
	-- ["{area:159}: hand in"] = "{area:159} : rendez les quêtes",
	-- ["{area:199} and the Andorhal towers"] = "{area:199} et les tours d'Andorhal",
	-- ["{area:272} and the {faction:68}"] = "{area:272} et {faction:68}",
	-- ["{area:272}, then {area:367}"] = "{area:272}, puis {area:367}",
	-- ["{area:353}: an {quest:2934}"] = "{area:353} : un sac à venin intact ({quest:2934})",
	-- ["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978} est un donjon de niveau 44 à 54 dans le nord de {zone:1446} ; un personnage de niveau 60 peut ouvrir le chemin seul, sinon venez en groupe. {npc:7272}, un troll élite, garde son tombeau dans l'instance : tuez-le et lisez la {object:142715} qui s'y trouve.",
	-- ["{area:978}: the {object:142715}"] = "{area:978} : la {object:142715}",
	-- ["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "La réputation {faction:68} vient des quêtes et des étoffes. {npc:14729}, l'intendant des étoffes, se tient dans le {object:36082} à côté des tailleurs. Il prend quatre dons uniques de 60 étoffes (150 chacun), puis {quest:7819}, 20 {item:14047} pour 50, autant de fois que vous voulez. Chaque point de réputation gagné auprès de {faction:68} donne aussi un quart à {zone:1454}, à {zone:1456} et aux Trolls Sombrelance. Pendant que vous montez de niveau, faites les quêtes de {faction:68} à 5 niveaux près : les clairières de Tirisfal de 1 à 12, la forêt des Pins-Argentés de 10 à 20, {area:287} et {area:272} de 20 à 33. L'atout d'Héritage Diplomate ajoute jusqu'à 10 %. Récompenses : à Honoré, les marchands de {faction:68} vous vendent 10 % moins cher (la règle de Classic), marchand de chevaux compris ; à Exalté, les autres races peuvent acheter les chevaux squelettes : 20 po pour un cheval de niveau 40, 200 po pour un cheval de guerre de niveau 60, une fois la monte apprise. {object:1661} n'a ni tabard ni autre récompense.",
	-- ["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047} : la Croisade écarlate à {area:2266} dans les {zone:1423}, les ogres Gordok devant {area:2577} à {zone:1444} et les camps du Crépuscule de {zone:1451} en laissent environ une fois sur trois. L'hôtel des ventes est plus rapide si vous avez de l'or.",
	-- ["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047} : la Croisade écarlate devant {area:2266}",
	-- ["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075} garde le chaudron du {area:199}. Cliquez sur le chaudron après l'avoir tué pour lancer {quest:5230}. Marquez les quatre tours d'Andorhal avec la {item:12815} à leurs portes.",
	-- ["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076} garde le chaudron du {area:202}.",
	-- ["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077} garde le chaudron des {area:200}.",
	-- ["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078} garde le chaudron de {area:201}.",
	-- ["{npc:11878}: 500 {faction:68} reputation. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878} : 500 de réputation {faction:68}. Ses quêtes de {area:2279} (Le {npc:12337}, L'Oracle écarlate, Demetria, Ramstein) demandent un groupe.",
	-- ["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "{npc:11897}, une chauve-souris élite, parcourt les champs au nord de la {area:2260}. {npc:11896} arpente une longue vallée à l'ouest de {area:2272}.",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729} prend les étoffes pour {faction:68} à {faction:68}. Les premiers dons d'étoffe de laine, de soie, de tisse-mage et d'{item:14047} (60 étoffes chacun) se font une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7819} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729} : {item:14047} livrée",
	-- ["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657} arpente la route vers {area:157} ; Nissa attend à l'étage de la première maison, Gregor et Thurman plus loin dans les moulins.",
	-- ["{npc:3188}, in {area:367}"] = "{npc:3188}, au {area:367}",
	-- ["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}, +75 : à {npc:1515} à {area:159}",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819} prend 20 {item:14047} par remise et se répète à volonté. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
}
