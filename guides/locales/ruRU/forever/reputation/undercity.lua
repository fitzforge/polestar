-- Russian (ruRU): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "Репутация: Подгород",
	-- {item:14047} Runecloth
	["The Plaguelands' level 55-60 quests and {item:14047} to Exalted, with Tirisfal's old quests as an optional extra."] = "Задания Чумных земель для 55-60 уровня и {item:14047} — до превознесения; старые задания Тирисфальских лесов — по желанию.",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "Превознесение: {faction:68}",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "",
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
	["{quest:5096}, +100 (level 53)"] = "",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "",

	-- Step 4: The Bulwark: the cauldrons
	["The Bulwark: the cauldrons"] = "",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "",

	-- Step 5: Felstone Field and the Andorhal towers
	["Felstone Field and the Andorhal towers"] = "",
	-- {npc:11075} Cauldron Lord Bilemaw · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at Felstone Field. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "",

	-- Step 6: The Bulwark: Dalson's Tears
	["The Bulwark: Dalson's Tears"] = "",

	-- Step 7: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:11077} Cauldron Lord Malvinious
	["{npc:11077} guards the cauldron at Dalson's Tears."] = "",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "",

	-- Step 8: The Bulwark: the Writhing Haunt
	["The Bulwark: the Writhing Haunt"] = "",

	-- Step 9: The Writhing Haunt
	["The Writhing Haunt"] = "",
	-- {npc:11076} Cauldron Lord Razarch
	["{npc:11076} guards the cauldron at the Writhing Haunt."] = "",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "",

	-- Step 10: The Bulwark: Gahrron's Withering
	["The Bulwark: Gahrron's Withering"] = "",

	-- Step 11: Gahrron's Withering
	["Gahrron's Withering"] = "",
	-- {npc:11078} Cauldron Lord Soulwrath
	["{npc:11078} guards the cauldron at Gahrron's Withering."] = "",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "",

	-- Step 12: The Bulwark: done
	["The Bulwark: done"] = "",
	-- {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["The Bulwark is also where The Key to Scholomance ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "",

	-- Step 13: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 500 {faction:68} reputation."] = "",

	-- Step 14: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {object:176970} Corin's Crossing (no name in this language: may be words)
	["Plaguebats, Quel'Lithien Lodge and {object:176970}"] = "",
	-- {item:15847} Quel'Thalas Registry · {object:176970} Corin's Crossing (no name in this language: may be words) · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. Quel'Lithien Lodge is north-west of Light's Hope Chapel; the {item:15847} lies inside. Do {object:176970} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "",

	-- Step 15: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "",

	-- Step 16: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "",
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897}, an elite bat, roams the fields north of Marris Stead. {npc:11896} paces a long valley west of Northdale."] = "",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {npc:12337} Crimson Courier
	["{npc:11878}: 500 {faction:68} reputation. His Stratholme quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "",

	-- Step 17: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "",
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
	["{quest:2934}, from Witherbark Broodguards"] = "",

	-- Step 20: Tarren Mill, then Sen'jin Village
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {object:3276} Sen'jin Village (no name in this language: may be words)
	["{object:1772}, then {object:3276}"] = "",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "",
	-- {npc:3188} Master Gadrin · {object:3276} Sen'jin Village (no name in this language: may be words)
	["{npc:3188}, in {object:3276}"] = "",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "",

	-- Step 21: Zul'Farrak: the Tablet of Theka
	-- {object:142715} Tablet of Theka
	["Zul'Farrak: the {object:142715}"] = "",
	-- {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["Zul'Farrak is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "",
	["Zul'Farrak"] = "",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "",

	-- Step 23: Shadra'Alor: Shadra
	-- {npc:2707} Shadra
	["{npc:2707}'Alor: {npc:2707}"] = "",
	-- {item:9323} Gadrin's Parchment · {npc:2707} Shadra
	["Read {item:9323} at the altar of {npc:2707}'Alor to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "",

	-- Step 24: Tarren Mill and the Undercity
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {faction:68} Undercity
	["{object:1772} and the {faction:68}"] = "",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, в Аптекарии",

	-- Step 25: Deathknell (optional hub)
	["Deathknell (optional hub)"] = "",
	-- {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Deathknell, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes (180 at a fifth). Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "",

	-- Step 26: Deathknell: the next quests
	["Deathknell: the next quests"] = "",

	-- Step 27: Around Deathknell
	["Around Deathknell"] = "",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "",

	-- Step 28: Deathknell: hand in
	["Deathknell: hand in"] = "",

	-- Step 29: The Scarlet camp
	["The Scarlet camp"] = "Лагерь Алого ордена",
	-- {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of Deathknell. {npc:1667} leads it."] = "",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "",
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
	["Motivate 5 Deathguards"] = "",

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
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "",

	-- Step 37: A Donation of Silk
	["Silk: the Syndicate in Hillsbrad and Alterac drop it about one kill in three, or buy it."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "",

	-- Step 38: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "",

	-- Step 39: A Donation of Runecloth
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words) · {zone:1423} Eastern Plaguelands · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {object:176973} in the {zone:1423}, the Gordok ogres outside Dire Maul in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "",
	-- {item:14047} Runecloth · {object:176973} Tyr's Hand (no name in this language: may be words)
	["{item:14047}: the Scarlet outside {object:176973}"] = "",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819} — до уважения",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819} — до почтения",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} (Blackrock Depths) pays 150 in full."] = "",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819} — до превознесения",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in Brill sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Адепты Тьмы и темные маги (уровень 58-60) роняют его здесь; каждое убийство Плети здесь также идет в зачет фракции {object:92525} (см. тот гайд). Также можно купить на аукционе.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Огры из клана Песчаного Молота (уровень 45-48) роняют ее здесь. Также можно купить на аукционе.",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать {quest:7819}, пока репутация ({faction:68}) не достигнет превознесения. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать {quest:7819}, по 20 шт. {item:14047}. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Кентавры из племени Колкар (уровень 30-33) роняют его здесь. Также можно купить на аукционе.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Головорезы Торговой компании в месте {area:381} (уровень 16-17) роняют ее здесь. Также можно купить на аукционе.",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729} принимает ткань для фракции {faction:68} (локация: {faction:68}). Первые пожертвования шерсти, шелкового материала, магической ткани и предмета {item:14047} (по 60 штук) делаются один раз и дают больше всего репутации за единицу ткани; после них {quest:7819} повторяется до превознесения. Превознесение у города другой расы позволяет покупать ее транспорт. Бонус наследия Forever «Дипломат» увеличивает получаемую репутацию.",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}: {item:14047} сдан",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819}: 20 шт. {item:14047} за раз, повторяется сколько угодно. Приносите {item:14047} партиями по 20 и сдавайте все сразу, раз за разом. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",
}
