-- Spanish (Latin America) (esMX): the guide forever/reputation/nightclaw-druids (forever/reputation/nightclaw-druids.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Nightclaw Druids = {npc:254152} Nightclaw Druid
	["Nightclaw Druids Reputation"] = "",
	-- {zone:2521} Zephras Isle
	["{zone:2521}'s hidden druids: five cultist ears pay 1000 reputation, best done before you outlevel the isle."] = "",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["48 {skill:164}, {skill:165} and {skill:197} patterns"] = "",

	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste desde {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the north side of {area:279} about every five minutes; another flies from north of {zone:1456}, and either faction may take either."] = "",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste a {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste desde {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes; another flies from {area:279}, and either faction may take either."] = "",

	-- Step 3: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Players' turn-ins paid their full reputation well above these quests' level."] = "",

	-- Step 4: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into the {area:16631}. {npc:257944} holds the druids' camp in its north-east."] = "",

	-- Step 5: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {area:16720} Nightclaw Cavern
	["{npc:254151}, the druids' quartermaster, waits inside their den: the cave just across the clearing north-east of {npc:257944} ({area:16720} on the map; {npc:257944} calls it the Nightfang Den). Take his ear quest now: the cultists you fight for {npc:257944} drop ears for it."] = "",

	-- Step 6: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Footsoldiers = {npc:252665} Al'Aketh Footsoldier · Bloody Heirlooms = {item:265141} Bloody Heirloom · Shadowgale Shrieklings = {npc:256092} Shadowgale Shriekling
	["The Al'Aketh Footsoldiers and Stormchasers camp just north of {npc:257944} and drop the Bloody Heirlooms (and ears, about one kill in four). The Shadowgale Shrieklings flying west of her drop the feathers; the {item:265105} grows on the trees along the stream west of her."] = "",
	-- {npc:254151} Vayn Moongaze
	["ears for {npc:254151}: keep every one"] = "",

	-- Step 7: Elegael Thornpaw's next tasks
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}'s next tasks"] = "",
	["500 reputation"] = "",

	-- Step 8: The Nightfang Den and Commander Haalien
	-- {npc:253622} Commander Haalien
	["The Nightfang Den and {npc:253622}"] = "",
	-- {npc:257944} Elegael Thornpaw · {npc:258134} Naaleos Leafwhisper · {npc:258130} Jorel Windsinger · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["The Nightfang Den is the cave north across the clearing from {npc:257944}. Heal the seven injured druids inside ({npc:258134} among them) and find {npc:258130}. {npc:253622} stands east of the den: he drops his head and a {quest:94490}; right-click the missive to start its quest."] = "",
	-- {npc:253622} Commander Haalien
	["from {npc:253622}"] = "",

	-- Step 9: Elegael Thornpaw, the den's fate
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the den's fate"] = "",
	["1000 reputation"] = "",

	-- Step 10: Ears at the Shrine of Akir
	-- {area:16629} Shrine of Akir
	["Ears at the {area:16629}"] = "",
	-- {area:16629} Shrine of Akir · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Honor Guards = {npc:3083} Honor Guard
	["The best ears are south of the forest at the {area:16629}: Skypriests drop one in more than half their kills, Guardians in four of ten, Spiritcallers and Honor Guards in a third. The {area:16626} just north-west of {area:16638} are next best (Brawlers and Pillagers, about four in ten). All cultists are level 8 to 10."] = "",

	-- Step 11: Mercy Falls on Deaf Ears
	-- {npc:254151} Vayn Moongaze
	["Back to {npc:254151} inside the den. Ten ears for 1000 reputation and a green piece: leather gloves, cloth pants or mail boots. {npc:254151} then takes ears five at a time, for 1000 each, as often as you like, up to level 18; in Classic the pay drops from level 19 and is 200 from level 22. The Legacy perk Diplomat adds up to 10% to every gain."] = "",

	-- Step 12: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "De vuelta a {area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["{npc:252359} waits in {area:16638}. Hand in on your way to a skyboat or to the {area:16626}."] = "",

	-- Step 13: Friendly to Honored
	["Friendly to Honored"] = "",
	-- {npc:254151} Vayn Moongaze
	["The storyline and {npc:254151}'s first quest leave you at Friendly with 2100 to spare. Honored is 3900 more: four turn-ins of five ears up to level 18, twenty from level 22. Friendly opens 32 of {npc:254151}'s patterns, in two colours, Cloudy and Azure: Blacksmithing Skyforged Wristguards and Chain (skill 50, 9s 50c), Gauntlets and Greaves (55, 11s); Leatherworking Gustwoven and Windraveled bracers and belts (50) and gloves and boots (55); Tailoring Stormsewn Cuffs and Cord (50), Handwraps and Shoes (55). They bind when you buy them, so buy them on the crafter."] = "",
	["five ears per turn-in"] = "",
	-- {quest:93459} More Al'Aketh Ears
	["{quest:93459}: 1000 reputation"] = "",
	-- {npc:254151} Vayn Moongaze
	["{npc:254151}'s patterns"] = "",

	-- Step 14: Honored to Revered
	["Honored to Revered"] = "",
	["Honored opens the chest and leg patterns (skill 60, 12s 50c): Skyforged chainmail and legguards, Gustwoven harness and trousers, Windraveled jerkin and pants, Stormsewn vest and leggings. Revered is 12000 more: 12 turn-ins (60 ears, about 160 cultist kills at the Shrine) up to level 18, 60 turn-ins (300 ears) from level 22."] = "",

	-- Step 15: Revered to Exalted
	["Revered to Exalted"] = "",
	-- {item:280347} Shadowgale Squirrel
	["Revered opens the {item:280347}, a companion pet, for 50s. Exalted is 21000 more: 21 turn-ins (105 ears, about 280 kills) up to level 18, 105 turn-ins (525 ears) from level 22."] = "",
	-- {item:280347} Shadowgale Squirrel
	["{item:280347}, 50s"] = "",

	-- Step 16: The Nightclaw Mantle
	-- {item:280363} Nightclaw Mantle
	["The {item:280363}"] = "",
	-- {item:280363} Nightclaw Mantle
	["Exalted opens the {item:280363}, green cloth shoulders for level 15, for 8s 16c."] = "",
}
