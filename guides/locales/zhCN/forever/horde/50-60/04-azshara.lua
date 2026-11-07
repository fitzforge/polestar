-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}，在{object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}，在{object:172957}：留着它去{zone:1451}",

	-- Step 2: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 3: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "莉芙的工作室在{area:392}码头北端；{object:149036}就在里面。",
	["Inside"] = "",

	-- Step 4: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}在{area:392}正北的海岸上扎营。",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "净化后的水要送到{zone:1448}的{area:2479}：留到之后。",

	-- Step 5: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "{npc:256386}的箱子",
	-- {area:380} Crossroads · {npc:256386} Dokimi · {zone:1454} Orgrimmar
	["Ride north up the road to the {area:380}; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {zone:1454} from the {area:380}."] = "沿大路向北骑往{area:380}；{npc:256386}站在那里。打开她交给你的每一个箱子，把里面的东西带回来。然后从{area:380}飞往{zone:1454}。",

	-- Step 6: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 7: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "在{object:172958}。",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "",

	-- Step 8: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "飞往{area:1237}",

	-- Step 10: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向东骑往海岸边的废墟。在沿岸的海潮之池装满科雷的四个瓶子；恶鞭纳迦在海潮之池之间巡逻。",

	-- Step 11: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "血精灵在东北的悬崖上扎营，就在{area:1227}旁边。",

	-- Step 12: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的营地",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "",

	-- Step 13: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "向西骑回{area:1237}。",

	-- Step 14: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 15: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 16: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "",

	-- Step 17: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "",

	-- Step 18: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "",

	-- Step 19: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 20: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在炼金房",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}，在他旁边",

	-- Step 21: The Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "",

	-- Step 22: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}，在附近",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}要交还给{zone:1422}的{npc:10778}：留着它。",
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "仅在背包中带有从{area:159}炼金店取得的书籍《{quest:79095}》时进行，详见《图书馆藏书》指南",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "两次{item:14047}捐献都在路线后面交还：开始攒{item:14047}。",
	-- ["Fly to the {area:380}"] = "飞往{area:380}",
	-- ["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "飞往{area:1637}；{npc:4485}在{object:172958}。",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "在{object:172961}。把毛料、丝绸和魔纹布带在背包里。",
	-- ["Open {object:149036} for the {item:10556}"] = "打开{object:149036}拿取{item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "雷姆托里的营地在萨拉斯营地东端。在那里阅读{object:151286}，然后杀死这位大法师。",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "飞艇塔就在{zone:1454}正门东北不远；乘坐前往{zone:1458}的飞艇。",
	-- ["Zeppelin to the {zone:1458}"] = "乘飞艇前往{zone:1458}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386}站在{area:380}。打开她交给你的每一个箱子，把里面的东西带回来。",
}
