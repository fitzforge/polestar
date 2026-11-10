-- Chinese (traditional) (zhTW): the guide forever/reputation/kirin-tor (forever/reputation/kirin-tor.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kirin Tor Reputation"] = "",
	-- {area:279} Dalaran
	["New in Forever: {area:279}'s mages sell Azure armour recipes at Friendly and their tabard at Exalted."] = "",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["Eight Azure helm and shoulder recipes at Friendly ({skill:164}, {skill:165}, {skill:197})"] = "",

	-- Step 1: Skyborne: the recipes now
	["Skyborne: the recipes now"] = "",
	-- {faction:2740} Kirin Tor · {npc:32287} Archmage Alvareaux · {area:279} Dalaran
	["Alliance Skyborne start Friendly with the {faction:2740}, and their arrival quests The Magical City of Dalaran and Exploring the Alliance pay 100 more each, so {npc:32287} sells you the Azure recipes at once (10g each, they need skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}, past the Sky Enclave. Buy the ones for your profession."] = "",

	-- Step 2: An Alarming Request
	-- {npc:247264} Emissary Jacques · {faction:2740} Kirin Tor · {area:271} Southshore · {npc:246748} Archmage Modera · {area:1338} Lordamere Lake · {area:279} Dalaran
	["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation at any level in Forever."] = "",

	-- Step 3: Archmage Modera's image
	-- {npc:246748} Archmage Modera
	["{npc:246748}'s image"] = "",
	-- {item:277507} Dalaran Sewer Key
	["you get the {item:277507} with it"] = "",

	-- Step 4: The City of Dalaran
	["The City of Dalaran"] = "",
	-- {quest:92457} Starving Arcane · {npc:246020} Shade of the Archmage · {npc:246748} Archmage Modera · {item:251961} Arcane Mote · {faction:2740} Kirin Tor
	["The City of Dalaran is a dungeon for levels 28 to 33: go in through the sewers with the key Modera gave you. The arcane elementals throughout the city count for {quest:92457}. The {npc:246020}, the last boss, waits in the Purple Parlor above the Violet Citadel (a portal by {npc:246748} in the Citadel takes you up) and drops the {item:251961}. Beta players saw every kill in the dungeon pay {faction:2740} reputation, the bosses the most. Group of five advised below level 35."] = "",
	-- {item:251961} Arcane Mote · {npc:246020} Shade of the Archmage
	["{item:251961}, from the {npc:246020}"] = "",

	-- Step 5: Back to Modera's image
	["Back to Modera's image"] = "",

	-- Step 6: Archmage Celindra
	-- {npc:252085} Archmage Celindra · {area:279} Dalaran
	["{npc:252085} waits in the Violet Citadel in {area:279}."] = "",

	-- Step 7: Past Due
	-- {npc:264265} Magus Olvek · {area:279} Dalaran · {npc:6487} Arcanist Doan · {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["{npc:264265} in {area:279} wants a book back from {npc:6487}, the last boss of the {area:796}'s Library (levels 33 to 41), in {zone:1420}."] = "",

	-- Step 8: Arcanist Doan
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["The {area:796} stands in the north-east of {zone:1420}; Doan waits at the end of the Library wing. Group of five advised below level 40."] = "",
	-- {item:273169} The Lost Magic of the Runemasters · {npc:6487} Arcanist Doan
	["{item:273169}, from {npc:6487}"] = "",

	-- Step 9: Back to Magus Olvek
	-- {npc:264265} Magus Olvek
	["Back to {npc:264265}"] = "",

	-- Step 10: City of Dalaran runs to Friendly
	["City of Dalaran runs to Friendly"] = "",
	["The quests leave a non-Skyborne at about 320 of the 3,000 Friendly needs. The rest comes from kills in the City of Dalaran dungeon: run it until Friendly. How much each kill pays is not in the game's data; the bosses pay the most. At 60 you clear it alone."] = "",

	-- Step 11: Archmage Alvareaux: the Azure recipes
	-- {npc:32287} Archmage Alvareaux
	["{npc:32287}: the Azure recipes"] = "",
	-- {npc:32287} Archmage Alvareaux · {faction:2740} Kirin Tor · {area:279} Dalaran
	["{npc:32287} sells the Azure helm and shoulder recipes at Friendly, 10g each (skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}. Buy the ones for your profession."] = "",

	-- Step 12: City of Dalaran runs to Exalted
	["City of Dalaran runs to Exalted"] = "",
	["Nothing is sold at Honored or Revered in the game's data. Friendly to Exalted is 39,000 reputation, all from City of Dalaran kills. In Classic most dungeon kills stop paying at Honored or Revered; whether these do is not known yet."] = "",

	-- Step 13: The Kirin Tor Tabard
	-- {item:285327} Kirin Tor Tabard
	["The {item:285327}"] = "",
	-- {npc:32287} Archmage Alvareaux · {npc:28776} Elizabeth Ross · {area:279} Dalaran · {item:285327} Kirin Tor Tabard
	["{npc:32287} and {npc:28776}, the tabard vendor in {area:279}, sell the {item:285327} at Exalted for 25g."] = "",
}
