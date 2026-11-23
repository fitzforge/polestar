-- Chinese (simplified) (zhCN): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "5级牧师长袍（联盟）",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "5级即可免费获得一件优秀长袍：治疗并强化你第一个城镇附近的一名受伤卫兵。",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5 级时，{area:24} 内的牧师训练师 {npc:375} 会让你去 {area:87} 找 {npc:377}。趁在这里，向安妮塔学习 {spell:613}（等级 2）：4 级即可学习，花费 1 银币，而且下一个任务要求必须使用这个法术等级。",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "沿路从 {area:9} 向南前往 {area:87}。{npc:377} 在狮王之傲旅店的楼上。",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613}（等级2），如果女牧师安妮塔还没教过你",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423} 跪在 {area:87} 东边湖岸的一棵树旁，离道路有一段距离：沿岸走，在路上时小地图显示不到他。先对他施放 {spell:613}（等级 2），然后施放 {spell:1243}。等级 1 的 {spell:613} 不算；从法术书把等级 2 拖到动作条上（如果动作条插件妨碍操作，就从法术书直接施放这两个法术）。两个法术都生效后，他会走开，大约 3 分钟后回来。",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "治疗{npc:12423}并施加真言术：韧",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "返回狮王之傲旅店楼上：女牧师洁塞塔会给你 {item:16605}。",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "达到 5 级后，{area:132} 的 {area:77} 内的牧师训练师 {npc:837} 会让你去找 {area:131} 的 {npc:1226}。趁现在向他学习 {spell:613}（等级 2）：4 级即可花费 1 银币学习，下一个任务必须使用这个等级。",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "通过隧道从{area:132}向东北出去，再沿路向东前往{area:131}。{npc:1226}在{area:2102}内。",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613}（等级 2），如果 {npc:837} 还没教你。",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427} 跪在 {area:131} 南面不远处、两堵矮墙之间的山脊上，与猎人宠物训练师隔路相望：如果道路开始下坡，就说明你走过头了。先对他施放 {spell:613}（等级2），再施放 {spell:1243}；每次施法后他都会说话。等级1的 {spell:613} 不算。",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "治疗{npc:12427}并施加真言术：韧",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "回到 {area:2102} 内：{npc:1226} 会给你 {item:16605}。",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "达到 5 级后，{area:188} 巨树 {area:256} 第二层的牧师训练师 {npc:3595} 会让你去找 {area:186} 的 {npc:3600}。趁现在向她学习 {spell:613}（等级 2）：4 级即可花费 1 银币学习，下一个任务必须使用这个等级。",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "从坡道离开{area:188}，沿路向西南前往{area:186}。{npc:3600}在村子北边的建筑内。",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613}（等级 2），如果 {npc:3595} 还没教你。",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429} 跪在 {area:259} 边缘的岩石上，位于 {area:186} 以南约 100 码处，头上没有任务标记。先对她施放 {spell:613}（等级 2），再施放 {spell:1243}；两个效果都生效后，她就会向湖边跑去，约 5 分钟后回来。等级 1 的 {spell:613} 不算。",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "治疗{npc:12429}并施加真言术：韧",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "回到 {area:186} 北缘：{npc:3600} 会给你 {item:16604}。",
}
