-- Chinese (traditional) (zhTW): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "5級牧師長袍（聯盟）",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "5級即可免費獲得一件優秀長袍：治療並強化你第一個城鎮附近的一名受傷衛兵。",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5級時，{area:24}內的牧師訓練師{npc:375}會讓你去找{area:87}的{npc:377}。既然來了，就向安妮塔學習{spell:613}（2級）：該技能4級開放，花費1銀，下一個任務正好需要這個等級。",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "沿路向南離開{area:9}前往{area:87}。{npc:377}在獅王之傲旅店樓上。",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613}（2級），如果安妮塔還沒教你",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423}跪在{area:87}以東湖岸邊的一棵樹旁，不在路上：沿湖岸走，從路上看小地圖會漏掉他。先對他施放{spell:613}（2級），再放{spell:1243}。{spell:613}的1級不算數；從法術書中把2級拖到動作條上（如果動作條外掛礙事，就直接從法術書施放兩個法術）。兩個法術都命中後他就會走開，大約3分鐘後回來。",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "治療並強化{npc:12423}",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "回到獅王之傲旅店樓上：喬塞塔給你{item:16605}。",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5級時，{area:132}中{area:77}內的牧師訓練師{npc:837}會讓你去找{area:131}的{npc:1226}。既然來了，就向他學習{spell:613}（2級）：該技能4級開放，花費1銀，下一個任務正好需要這個等級。",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "從{area:132}走隧道向東北出去，再沿路向東前往{area:131}。{npc:1226}在{area:2102}內。",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613}（2級），如果{npc:837}還沒教你",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427}跪在{area:131}正南兩道矮牆之間的山脊上，在獵人寵物訓練師的路對面：如果路開始下坡，說明你已經走過他了。先對他施放{spell:613}（2級），再放{spell:1243}；他會在每個法術之後說話。{spell:613}的1級不算數。",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "治療並強化{npc:12427}",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "回到{area:2102}內：{npc:1226}給你{item:16605}。",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "5級時，{area:188}中巨樹{area:256}二樓的牧師訓練師{npc:3595}會讓你去找{area:186}的{npc:3600}。既然來了，就向她學習{spell:613}（2級）：該技能4級開放，花費1銀，下一個任務正好需要這個等級。",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "從斜坡離開{area:188}，沿路向西南前往{area:186}。{npc:3600}在村北緣的建築裡。",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613}（2級），如果{npc:3595}還沒教你",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429}跪在{area:259}邊緣的岩石上，位於{area:186}以南約100碼，頭頂沒有任務標記。先對她施放{spell:613}（2級），再放{spell:1243}；兩個法術都命中後她會朝湖跑去，大約5分鐘後回來。{spell:613}的1級不算數。",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "治療{npc:12429}並施放耐力",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "回到{area:186}北緣：{npc:3600}給你{item:16604}。",
}
