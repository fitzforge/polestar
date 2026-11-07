-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 2: Dartol's Rod
	["Dartol's Rod"] = "达图尔的变形魔棒",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "月亮井北边的疯狂的古树和{npc:3919}带着{item:5475}；它能打开的旧箱子就在它们中间。",

	-- Step 3: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "穿过隧道进入{area:419}；书在西端的废墟里。",

	-- Step 5: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "沿道路向东到{area:429}的萨特营地；{npc:3920}躲在营地边缘。",

	-- Step 6: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}率领{area:429}的萨特；树枝在他身上。",

	-- Step 7: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}是道路东端的暗夜精灵前哨：{npc:3848}站在那里。",

	-- Step 8: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 9: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}：交给{area:415}的{npc:3961}",

	-- Step 11: Insane druids
	["Insane druids"] = "",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "",

	-- Step 12: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "",

	-- Step 14: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "第二个{object:19901}在{area:428}的山谷里，就在向西的路上。",

	-- Step 16: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "隐蔽的神龛在月亮井东南方不远处的山丘上；沿蜿蜒的小路上去。",

	-- Step 19: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}是一个未受腐蚀的熊怪，坐在{area:421}下方道路的南边。",

	-- Step 20: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",

	-- Step 24: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "哨兵梅丽瑞亚·霜影和{npc:3901}",

	-- Step 26: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 27: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "",

	-- Step 28: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "",
	["Inside"] = "",

	-- Step 30: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "",

	-- Step 31: Lightforge Ingots
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "米奈希尔港西南方海滩上的蓝腮鱼人带着锭。",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "沿道路向西返回{area:429}的萨特营地。",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "沿道路向西离开{area:415}；{area:413}在道路北边。",
	-- ["From {area:608}"] = "从{area:608}出发",
	-- ["Geltharis"] = "加萨里斯",
	-- ["Insane druids"] = "发狂的德鲁伊",
	-- ["Lightforge Ingots"] = "{item:2702}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "生锈的箱子散落在被遗忘者营地西边的沼泽兽营地周围；逐个打开，直到找到剑柄。",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "从{area:442}的码头乘船前往{area:150}。",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "被遗忘者的营地在{area:2358}南边的树林里。",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "月亮井在{area:415}东北方的山丘上。",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "三名德鲁伊一起站在{area:2358}南边的被遗忘者营地里。",
	-- ["The two stand together at the western end of the road."] = "两人一起站在道路西端。",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Flying Osprey号的残骸在城堡南边的浅水中。",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931}在箱子西南方的{quest:1035}岸边巡逻；{object:669176}在湖的北边，就在路上。",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901}在沿道路更东边的{area:430}萨特营地里。",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}是道路东端的暗夜精灵前哨：{npc:3848}和{npc:221269}站在那里。",
	-- ["{area:429} satyrs"] = "{area:429}的萨特",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}站在米奈希尔城堡的上层。",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696}和他的卫兵在{npc:3897}东边不远处扎营。",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}：交给米奈希尔港的{npc:1480}，在本指南结尾",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}、{npc:4963}和{npc:4962} Jahn都在米奈希尔港的旅店里；你和{npc:4963}交谈时Tapoke会和你打，但被打败后就会放弃。{npc:1480}在旅店东北方不远处。",
}
