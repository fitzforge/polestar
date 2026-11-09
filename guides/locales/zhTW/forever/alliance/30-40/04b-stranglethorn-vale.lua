-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：給{area:35}的{npc:773}",

	-- Step 5: Bookie Herod
	-- {area:101} Kurzen's Compound · {area:99} Rebel Camp
	["Herod's records lie in a hut on the west side of {area:101}, east of the {area:99}."] = "",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "",

	-- Step 6: Kurzen's Compound
	-- {spell:7964} Smoke Bomb
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "",

	-- Step 7: Rebel Camp
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "",

	-- Step 8: Nesingwary's Expedition
	["South along the road: the hunters' tents stand just west of it."] = "",

	-- Step 9: The jungle ruins
	["The jungle ruins"] = "叢林廢墟",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "繞行北部和中部的食人妖廢墟：每處都有一塊記載食人妖傳說的石板。深喉獵豹潛行在周圍的叢林中；{area:37}的風險投資公司營地身上帶著打磨過的水晶。",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "",

	-- Step 10: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["Follow the west coast north to the haunted island off the shore west of Nesingwary's camp: the Lesser Water Elementals rise from the water around it."] = "",

	-- Step 11: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",

	-- Step 15: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "鉗嘴鱷魚",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "",

	-- Step 16: Level 36
	["Level 36"] = "",
	-- {quest:205} Troll Witchery · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "",

	-- Step 17: Skullsplitter trolls
	["Skullsplitter trolls"] = "劈顱食人妖",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈顱食人妖佔據奈辛瓦里與{object:3202}之間道路東邊的廢墟。",

	-- Step 18: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在酒館樓上",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "給{zone:1416}的大法師安斯雷姆·魯因維沃爾",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:773} Krazek · {zone:1417} Arathi Highlands
	["{npc:773}: the ore drops from Drywhisker kobolds in {zone:1417}, next"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
}
