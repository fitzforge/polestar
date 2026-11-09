-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint
	["{npc:4455} stands on the dock just north of the flight master."] = "",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} on Theramore's docks, where this guide's boat lands"] = "",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}站在米奈希爾城堡的上層。",
	["Inside"] = "",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "沉船殘骸在城堡南邊的淺水處。",

	-- Step 6: Lightforge Ingots
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "米奈希爾西南方海灘上的藍腮魚人帶著鐵錠。",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 9: Theramore
	["Theramore"] = "塞拉摩",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "飛行管理員站在{area:514}的大門旁；{npc:5083}和{npc:4964}在要塞裡面。",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, on the docks"] = "",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west out of Theramore to the burned inn on the road toward the {zone:1413}: the black shield lies in the ashes and the hoofprints are in the mud beside the inn."] = "",

	-- Step 11: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "",

	-- Step 12: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "在向南穿過{zone:1413}的道路上，{npc:6244}在道路東邊、{area:378}東北方紮營；從東邊過去，避開部落衛兵。",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}：在{zone:1440}，前往{zone:1443}的路上",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}：夢魔在魅魔旁邊；{item:190309}在{quest:1738}附近",

	-- Step 13: Highperch
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {area:482} Highperch
	["Down the {area:485} into {zone:1441}, then west to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 14: Thousand Needles
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "",

	-- Step 16: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "沿著峽谷向東前往鹽湖。{area:2240}的哥布林和地精是中立的，兩個陣營都能接他們的任務。",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "交給荊棘谷的{quest:5762}，稍後",

	-- Step 17: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Snappers (tortoises) the whole flats. Saltstone Basilisks and Crystalhides hold the middle; the Gazers (34-35) only the far south."] = "",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "",

	-- Step 18: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "",

	-- Step 19: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "",

	-- Step 20: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "",

	-- Step 21: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 22: Theramore
	-- {npc:4456} Fiora Longears · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes in {area:514}; {npc:4941} stands in the town."] = "",

	-- Step 23: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "沿著道路向西回到{area:429}的薩特營地。",
	-- ["Dartol's Rod"] = "達圖爾的變形魔棒",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "沿著道路向東前往{area:429}的薩特營地；{npc:3920}躲在營地邊緣。",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "沿著道路向西離開{area:415}；{area:413}在道路北邊。",
	-- ["From {area:608}"] = "從{area:608}出發",
	-- ["Geltharis"] = "加薩里斯",
	-- ["Insane druids"] = "發狂的德魯伊",
	-- ["Lightforge Ingots"] = "光鑄鐵錠",
	-- ["Melyria and {npc:3901}"] = "梅麗瑞亞與{npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "生銹的箱子散落在被遺忘者西邊的沼澤獸營地周圍；逐一打開，直到其中一個裝著柄頭。",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "從{area:442}的碼頭搭船前往{area:150}。",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "穿過隧道進入{area:419}；書在山谷西端的廢墟裡。",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "月井北邊的瘋狂的古樹和乾枯的古樹帶著{item:5475}；它能打開的破舊箱子就在它們之間。",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "被遺忘者的營地在{area:2358}南邊的樹林裡。",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "月井在{area:415}東北方的山丘上。",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "第二個{object:19901}在{area:428}的山谷裡，在往西的路上。",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "神龕在月井東南方的山丘上；沿著蜿蜒的小路往上走。",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "三名德魯伊一起站在{area:2358}南邊的被遺忘者營地。",
	-- ["The two stand together at the western end of the road."] = "她們兩人一起站在道路西端。",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "沉船殘骸在城堡南邊的淺水處。",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931}在箱子西南方的{quest:1035}岸邊走動；{object:669176}在湖的北邊，就在路上。",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901}在道路更東邊的{area:430}薩特營地裡。",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}是道路東端的夜精靈前哨：{npc:3848}和{npc:221269}站在那裡。",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}是道路東端的夜精靈前哨：{npc:3848}站在那裡。",
	-- ["{area:429} satyrs"] = "{area:429}的薩特",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}站在米奈希爾城堡的上層。",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696}和他的守衛在{npc:3897}東邊紮營。",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "未受腐化的熊怪{npc:3897}坐在{area:421}下方的道路南邊。",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}：交給米奈希爾的{npc:1480}，在本指南的最後",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}率領{area:429}的薩特；樹枝在他身上。",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}、{npc:4963}和{npc:4962}·賈恩都在米奈希爾的旅店；你和{npc:4963}說話時塔伯克會攻擊你，但被打敗後就會投降。{npc:1480}站在旅店東北方不遠處。",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}：交給{area:415}的{npc:3961}",
}
