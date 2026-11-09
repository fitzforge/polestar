-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "从{area:541}飞往{area:392}。",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}：在屋内",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "乘船前往{area:35}",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "从{area:392}乘船前往{area:35}，飞往{zone:1453}。",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}，在运河边走动",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "交给{npc:10778}：留着",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}，在军情七处",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}的{quest:6184}：留着",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "采样瓶在下次去安戈洛时装满",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}，在地铁旁",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飞往{area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "{npc:11038}，在教堂南面的墓地旁：埃根在{area:2627}，先留着",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天灾勇士",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "天灾勇士（59级）在{area:2268}北边的{area:2270}游荡。在你杀死的每一个身上挥动{npc:11063}的{item:13156}：产生共鸣的头骨就是他要的。一次拉一个。",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}，来自天灾勇士",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "安多哈尔的克罗米：留着",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "向北骑行前往{area:2277}东北边缘。\n注意：通往{area:2273}沿途的巨魔为 57–59 级，低血量时会逃跑求援，经常引来更多敌人。",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "向西南骑行前往{area:2261}，土堆位于内部。{npc:11886}是精英，建议组队。\n注意：米库提奥·污血会带来约四名非精英随从，他们会走到墓地，而非原地出现。",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}，来自{npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "安多哈尔的克罗米：留着",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "掘泥摧毁者在更西边挖掘；石鞭巨钳蝎、石鞭掠夺者和石行蜘蛛在同一片沙地狩猎。",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "掘泥打击者在要塞西北方的沙丘中挖掘；石鞭蝎和掠沙蜘蛛在四周游荡。",
	-- ["Dredge and scorpids"] = "掘泥虫和蝎子",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "从{area:976}飞往{area:541}。{npc:8737}的小屋在避难所西边的{area:538}；{npc:9117}在小屋后面的山上。",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "飞往{area:271}，沿道路向北朝奥特兰克骑行：哈格丁在路旁的{area:1056}扎营。",
	-- ["For {area:3197}: keep it"] = "交给{area:3197}：留着",
	-- ["For {npc:10778}: keep it"] = "交给{npc:10778}：留着",
	-- ["For {zone:1448}: keep it"] = "交给{zone:1448}：留着",
	-- ["From {area:392}, fly to {area:976}."] = "从{area:392}飞往{area:976}。",
	-- ["Its jars are filled on the next Un'Goro visit"] = "采样瓶在下次去安戈洛时装满",
	-- ["On {npc:7583}"] = "交给{npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "骑回{area:3425}，飞往{area:392}。",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "向东骑行到{area:2738}的{area:2742}高塔；爬上去，杀死为硬壳物品涌出的亚什伏击者。",
	-- ["Ride east to {npc:13220}."] = "向东骑行到{npc:13220}处。",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "向北骑行到{area:2277}的东北边缘。",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "继续向北骑行到{area:3197}，飞往{area:2268}。",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "从环形山西北的山口骑出，进入{zone:1451}，前往{area:3425}。",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "向西南骑行到{area:2261}。土堆在里面。{npc:11886}是精英：建议组队。",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南骑行到{area:1938}的{npc:7771}营地。",
	-- ["Scourge Champions"] = "天灾勇士",
	-- ["Sixty {item:2592}, if you carry them"] = "六十块{item:2592}，如果你带着的话",
	-- ["Take the {area:2257} to {zone:1455}."] = "乘{area:2257}前往{zone:1455}。",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "焦油兽在{area:538}中打滚；中央{area:537}的火元素携带灰烬；南部{area:540}的格里什异种蝎携带腺体。环形山中的所有生物都可能掉落{item:11018}。",
	-- ["The crater"] = "环形山",
	-- ["The next guide starts here in {area:392}."] = "下一份指南从{area:392}这里开始。",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "被折磨的德鲁伊和被折磨的哨兵在{npc:13220}西南方的废弃村庄中游荡。",
	-- ["The western dunes"] = "西部沙丘",
	-- ["The {area:2742} tower"] = "{area:2742}高塔",
	-- ["Umber in {zone:1450}: keep it"] = "{zone:1450}的阿姆伯尔：留着",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "在{zone:1423}的{area:2258}刷{npc:8532}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}，来自天灾勇士",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}，来自{npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}，在地铁旁",
	-- ["{npc:332}, in SI:7"] = "{npc:332}，在军情七处",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}，在运河边走动",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}在镇子东边不远的墓地等候；墓碑就在附近。",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444}在{area:392}",
}
