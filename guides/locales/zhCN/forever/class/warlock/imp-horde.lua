-- Chinese (simplified) (zhCN): the guide forever/class/warlock/imp-horde (forever/class/warlock/imp-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Horde)"] = "小鬼（部落）",
	["Your first demon at level 1-4: the imp, with a starter blade or staff for Orcs and Trolls."] = "1-4级获得你的第一个恶魔：小鬼，兽人和巨魔还可获得一把新手刀剑或法杖。",

	-- Step 1: Ruzan (Orcs and Trolls)
	-- {npc:5765} Ruzan
	["{npc:5765} (Orcs and Trolls)"] = "{npc:5765}（兽人和巨魔）",
	-- {item:9579} Tainted Parchment · {item:282346} Tainted Tablet · {npc:5765} Ruzan · {area:363} Valley of Trials
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Your first letter ({item:9579} for Orcs, {item:282346} for Trolls, from Gornek after Cutting Teeth) points you to Nartok, the warlock trainer in the Den. {npc:5765} stands just outside the Den in the {area:363} and asks for six Vile Familiar Heads."] = "你的第一封信（完成“小试身手”后由高内克提供，兽人为{item:9579}，巨魔为{item:282346}）会指引你去大兽穴找术士训练师纳托克。{npc:5765}站在{area:363}的大兽穴外，要求收集六个邪灵劣魔的头颅。",

	-- Step 2: Vile Familiars
	-- {quest:1485} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:1485} (level 3-4) swarm the {area:365}, the cave north of the Den, inside and around its mouth. Almost every kill drops a head (80%), so about eight kills does it; they throw small fireballs, so pull them one at a time. They respawn in just over three minutes. Other classes hunt the same imps for their own {quest:1485} quest."] = "{quest:1485}（3—4级）聚集在 {area:365}，即兽穴北面的洞穴内部和洞口周围。几乎每只都会掉落头颅（80%），因此大约击杀八只即可；它们会投掷小火球，一次只引一只。刷新时间略超过三分钟。其他职业也会为自己的 {quest:1485} 任务击杀这些小鬼。",
	-- plural, as words: Vile Familiar Heads = {item:6487} Vile Familiar Head
	["Vile Familiar Heads"] = "邪灵劣魔的头颅",

	-- Step 3: Summon Imp
	-- {npc:5765} Ruzan · {spell:688} Summon Imp · {npc:3145} Zureetha Fargaze
	["{npc:5765} teaches you {spell:688} when you hand in the heads: summon it right away, it costs nothing and fights beside you. Then speak with {npc:3145} a few steps away for a starter weapon."] = "交还头颅时，{npc:5765} 会教你 {spell:688}：马上召唤，不花钱，还能帮你战斗。然后找几步之外的 {npc:3145} 交谈，领取一件起步武器。",

	-- Step 4: Venya Marthand (Undead)
	-- {npc:5667} Venya Marthand
	["{npc:5667} (Undead)"] = "{npc:5667}（亡灵）",
	-- {item:9578} Tainted Scroll · {npc:1569} Shadow Priest Sarvis · {area:154} Deathknell · {npc:5667} Venya Marthand
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Your first letter ({item:9578}, from {npc:1569} after The Mindless Ones) points you to Maximillion, the warlock trainer in {area:154}. {npc:5667} waits inside the building beside him and asks for three Rattlecage Skulls."] = "你的第一封信（完成“无脑的僵尸”后由{npc:1569}给予的{item:9578}）会指引你去找{area:154}的术士训练师马克希米林。{npc:5667}在他旁边的建筑里等候，要你收集3个断骨骷髅的颅骨。",

	-- Step 5: Rattlecage Skulls
	-- plural, as words: Rattlecage Skulls = {item:6281} Rattlecage Skull
	["Rattlecage Skulls"] = "断骨骷髅的颅骨",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons (level 2-3) stand around the old smithy buildings just north of {area:154}, often right against the walls. Four kills in five drop a skull, so plan on about five; twenty of them spawn there and each comes back after five minutes."] = "断骨骷髅（2—3级）在 {area:154} 正北方的旧铁匠铺建筑附近，常常紧贴着墙。颅骨掉率约为五分之四，因此预计需击杀五只左右；那里共有二十只刷新，每只五分钟刷新一次。",

	-- Step 6: Summon Imp
	-- {npc:5667} Venya Marthand · {spell:688} Summon Imp
	["{npc:5667} teaches you {spell:688} when you hand in the skulls: summon it right away, it costs nothing and fights beside you."] = "交还头颅时，{npc:5667}会教你{spell:688}：马上召唤它，无需消耗，还能帮你战斗。",
}
