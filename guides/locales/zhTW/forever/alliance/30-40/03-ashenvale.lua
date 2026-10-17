-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {area:608} Nijel's Point
	["From {area:608}"] = "從{area:608}出發",
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}：交給米奈希爾的{npc:1480}，在本指南的最後",

	-- Step 2: Delgren the Purifier
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["Follow the road west out of {area:415}; {area:413} lies north of it."] = "沿著道路向西離開{area:415}；{area:413}在道路北邊。",

	-- Step 3: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "梅麗瑞亞與{npc:3901}",
	["The two stand together at the western end of the road."] = "她們兩人一起站在道路西端。",

	-- Step 4: Shael'dryn
	-- {area:415} Astranaar
	["The moonwell lies in the hills north-east of {area:415}."] = "月井在{area:415}東北方的山丘上。",

	-- Step 5: Dartol's Rod
	["Dartol's Rod"] = "達圖爾的變形魔棒",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "月井北邊的瘋狂的古樹和乾枯的古樹帶著{item:5475}；它能打開的破舊箱子就在它們之間。",

	-- Step 6: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "穿過隧道進入{area:419}；書在山谷西端的廢墟裡。",

	-- Step 8: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "沿著道路向東前往{area:429}的薩特營地；{npc:3920}躲在營地邊緣。",

	-- Step 9: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}率領{area:429}的薩特；樹枝在他身上。",

	-- Step 10: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901}在道路更東邊的{area:430}薩特營地裡。",

	-- Step 11: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}是道路東端的夜精靈前哨：{npc:3848}和{npc:221269}站在那裡。",

	-- Step 12: Bottle of Disease
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}."] = "被遺忘者的營地在{area:2358}南邊的樹林裡。",

	-- Step 13: Iron Pommel
	["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "生銹的箱子散落在被遺忘者西邊的沼澤獸營地周圍；逐一打開，直到其中一個裝著柄頭。",

	-- Step 14: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931}在箱子西南方的{quest:1035}岸邊走動；{object:669176}在湖的北邊，就在路上。",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}：交給{area:415}的{npc:3961}",

	-- Step 16: Xavian satyrs
	-- {area:429} Xavian
	["{area:429} satyrs"] = "{area:429}的薩特",
	-- {area:429} Xavian
	["Back west along the road to the satyr camps of {area:429}."] = "沿著道路向西回到{area:429}的薩特營地。",

	-- Step 17: Insane druids
	["Insane druids"] = "發狂的德魯伊",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}."] = "三名德魯伊一起站在{area:2358}南邊的被遺忘者營地。",

	-- Step 19: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "第二個{object:19901}在{area:428}的山谷裡，在往西的路上。",

	-- Step 21: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "神龕在月井東南方的山丘上；沿著蜿蜒的小路往上走。",

	-- Step 24: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "未受腐化的熊怪{npc:3897}坐在{area:421}下方的道路南邊。",

	-- Step 25: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696}和他的守衛在{npc:3897}東邊紮營。",

	-- Step 30: Auberdine
	-- {area:150} Menethil Harbor · {area:442} Auberdine
	["Take the boat to {area:150} from {area:442}'s docks."] = "從{area:442}的碼頭搭船前往{area:150}。",

	-- Step 31: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}站在米奈希爾城堡的上層。",

	-- Step 32: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "沉船殘骸在城堡南邊的淺水處。",

	-- Step 33: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "光鑄鐵錠",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "米奈希爾西南方海灘上的藍腮魚人帶著鐵錠。",

	-- Step 35: Deepwater Tavern
	-- {npc:5082} Vincent Hyal · {npc:4963} Mikhail · {npc:4962} Tapoke "Slim" Jahn · {npc:1480} Caitlin Grassman
	["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}、{npc:4963}和{npc:4962}·賈恩都在米奈希爾的旅店；你和{npc:4963}說話時塔伯克會攻擊你，但被打敗後就會投降。{npc:1480}站在旅店東北方不遠處。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Geltharis"] = "加薩里斯",
}
