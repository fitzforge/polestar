-- Chinese (traditional) (zhTW): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "小鬼（部落）",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "1-4級獲得你的第一個惡魔：小鬼，獸人和巨魔還可獲得一把新手刀劍或法杖。",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765}（獸人與巨魔）",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan · {area:363} Valley of Trials
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "你的第一封信（獸人是{item:9579}，巨魔是{item:282346}，完成前置任務後由格奈克給你）指向巢穴裡的術士訓練師納托克。{npc:5765}就站在巢穴外{area:363}，要六顆邪惡魔僕頭顱。",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "{quest:1485}中要求的魔僕（3-4級）成群盤踞在{area:365}，也就是巢穴北邊的洞穴，洞內和洞口周圍都有。幾乎每隻都掉頭顱（80%），所以大約八隻就夠了；它們會扔小火球，所以一次拉一隻。三分鐘多一點就會重新整理。其他職業也會為了自己的{quest:1485}任務獵殺同樣的魔僕。",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "邪惡魔僕頭顱",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "交上頭顱後{npc:5765}會教你{spell:688}：馬上召喚它，不消耗任何東西，還會和你並肩作戰。然後再走幾步找{npc:3145}領起始武器。",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667}（亡靈）",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {area:154} Deathknell · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "你的第一封信（{item:9578}，完成前置任務後由{npc:1569}給你）指向{area:154}的術士訓練師馬克西米利安。{npc:5667}就在他旁邊的屋子裡等你，要三個響骨骷髏頭。",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "響骨骷髏頭",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "響骨骷髏（2-3級）聚集在{area:154}北邊廢棄的鐵匠鋪周圍，常常緊貼牆邊。五次擊殺中有四次會掉骷髏頭，所以按五次計劃；那裡一共刷二十隻，每隻五分鐘後回來。",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "交上骷髏頭後{npc:5667}會教你{spell:688}：馬上召喚它，不消耗任何東西，還會和你並肩作戰。",
}
