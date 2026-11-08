-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "搭船前往{area:35}",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "從{area:392}搭船前往{area:35}，然後飛往{zone:1453}。",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}，在運河邊走動",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "交給{npc:10778}：保留此任務",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}，在軍情七處",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}的{quest:6184}：保留此任務",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "它的罐子會在下次造訪安戈洛時裝滿",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}，在地鐵旁",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飛往{area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天災勇士",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "天災勇士（59級）在{area:2268}北邊的{area:2270}遊蕩。每殺一隻就用{npc:11063}的{item:13156}掃過牠：產生共鳴的頭骨才是他要的。一次只拉一隻。",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}，來自天災勇士",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "安多哈爾的克羅米：保留此任務",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}，來自{npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "安多哈爾的克羅米：保留此任務",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "掘泥摧毀者在更西邊挖掘；石鞭巨鉗蠍、石鞭掠奪者和石行蜘蛛在同一片沙地上狩獵。",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "掘泥打擊者在要塞西北方的沙丘中挖掘；石鞭蠍和掠沙蜘蛛在四周遊蕩。",
	-- ["Dredge and scorpids"] = "掘泥蟲與蠍子",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "從{area:976}飛往{area:541}。{npc:8737}的小屋在避難營西邊的{area:538}；{npc:9117}在小屋後方的山丘上。",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "飛往{area:271}，沿著道路向北往奧特蘭克騎：哈格丁在路旁的{area:1056}紮營。",
	-- ["For {area:3197}: keep it"] = "交給{area:3197}：保留此任務",
	-- ["For {npc:10778}: keep it"] = "交給{npc:10778}：保留此任務",
	-- ["For {zone:1448}: keep it"] = "交給{zone:1448}：保留此任務",
	-- ["From {area:392}, fly to {area:976}."] = "從{area:392}飛往{area:976}。",
	-- ["Its jars are filled on the next Un'Goro visit"] = "它的罐子會在下次造訪安戈洛時裝滿",
	-- ["On {npc:7583}"] = "關於{npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "騎回{area:3425}，飛往{area:392}。",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "向東騎往{area:2738}的{area:2742}高塔；爬上去，擊殺為了異種蠍粘液包裹的物體而出現的亞什伏擊者。",
	-- ["Ride east to {npc:13220}."] = "向東騎往{npc:13220}。",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "向北騎往{area:2277}的東北邊緣。",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "繼續向北騎往{area:3197}，飛往{area:2268}。",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "從環形山西北方的山口騎進{zone:1451}，繼續前往{area:3425}。",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "向西南騎往{area:2261}。土堆在裡面。{npc:11886}是精英：建議組隊。",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南騎往{area:1938}的{npc:7771}營地。",
	-- ["Scourge Champions"] = "天災勇士",
	-- ["Sixty {item:2592}, if you carry them"] = "六十塊{item:2592}，如果你帶著的話",
	-- ["Take the {area:2257} to {zone:1455}."] = "搭乘{area:2257}前往{zone:1455}。",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "焦油獸在{area:538}打滾；中央{area:537}的火元素帶著灰燼；南邊{area:540}的格里什異種蠍帶著腺體。環形山的每隻生物都可能掉落{item:11018}。",
	-- ["The crater"] = "環形山",
	-- ["The next guide starts here in {area:392}."] = "下一份指南從{area:392}這裡開始。",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "被折磨的德魯伊和被折磨的哨兵在{npc:13220}西南方的廢墟村莊出沒。",
	-- ["The western dunes"] = "西部沙丘",
	-- ["The {area:2742} tower"] = "{area:2742}高塔",
	-- ["Umber in {zone:1450}: keep it"] = "{zone:1450}的阿姆伯爾：保留此任務",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "在{zone:1423}的{area:2258}擊殺{npc:8532}練等",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}，來自天災勇士",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}，來自{npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}，在地鐵旁",
	-- ["{npc:332}, in SI:7"] = "{npc:332}，在軍情七處",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}，在運河邊走動",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}在城鎮東邊的墓地等候；墓碑就在附近。",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444}在{area:392}",
}
