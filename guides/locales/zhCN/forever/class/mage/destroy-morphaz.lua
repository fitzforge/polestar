-- Chinese (simplified) (zhCN): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50级时通过{zone:1447}和{area:1417}获得经验；Forever移除了经典版的物品选择。",
	["Experience"] = "经验",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "大法师{npc:331}站在{zone:1453}{object:2101}的巫师圣殿里；{zone:1455}的丁克也提供同样的任务。",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "{zone:1454}的法师训练师之一{npc:7311}会给你这个任务；{zone:1458}的{npc:4567}和{zone:1456}的{npc:3047}也会。",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to {npc:8379}."] = "飞往{area:3137}（联盟）或{area:1237}（部落）。{npc:8395}在他导师的塔下扎营：从{zone:1447}主路在{area:1221}的岔口一直向北走到悬崖。他会把你传送上去见{npc:8379}。",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "{npc:8379}，在塔里",

	-- Step 4: Glittering Dust
	-- {zone:1447} Azshara
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "血精灵在{zone:1447}东北部的悬崖沿线扎营；血精灵勘测员和血精灵搜寻者会掉落尘埃。",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "回到{npc:8395}那里，他会把你传送到塔上。",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "恶鞭海妖在{area:1221}周围的废墟和海湾沙滩上游荡；珊瑚在她们身上。",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "再次找{npc:8379}",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "回到{npc:8395}那里，再上塔。",

	-- Step 8: Morphaz
	["Morphaz"] = "摩弗拉斯",
	-- {area:1477} Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {item:20085} Arcane Shard
	["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "摩弗拉斯是一条绿龙，在{area:74}中的{area:1417}——{area:1477}深处等候：需要五人小队，50-54级。杀死他获得{item:20085}。",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085}：摩弗拉斯",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "{item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo
	["Back to {zone:1447}, {npc:8395} and the tower."] = "回到{zone:1447}，找{npc:8395}上塔。",
}
