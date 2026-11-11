-- Chinese (simplified) (zhCN): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "50级时在安戈洛环形山获得经验和两瓶治疗药水；无限中可能已移除经典版的物品选择。",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "施放 {spell:18960}。{npc:12042} 站在 {area:2361}；你的职业训练师（{npc:3033}、{npc:4217}，或 {zone:1453} 的塞瑞德兰）也提供同一个任务。",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "飞往{area:976}，向西骑到通往{zone:1449}的长坡：{npc:9619}在坡底扎营，位于环形山东南角。",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "格里什钉刺和{item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "两种各需八份。格里什异种蝎和 格里什毒刺蝎（51—52级）分布在环形山西南部的虫巢 {area:540} 内外，毒刺的掉率约为七分之一；这些异种蝎与其他虫类共用刷新点，因此把附近的虫子都杀掉，为更多异种蝎腾出刷新位置（五分钟刷新）。虫子的 {spell:8137} 会使你受到更多物理伤害，持续30分钟；工虫受伤时会呼叫援兵。血瓣花苗遍布环形山（{area:541} 周边和西半部）：打开后约有一半概率获得 {item:22434}，三至五分钟后重新刷新。",

	-- Step 5: Toxic Test
	-- {npc:6498} Devilsaur · {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur · Devilsaurs = {npc:6498} Devilsaur
	["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}：用{item:22432}刺它",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["Stab a {npc:6498} with the {item:22432}"] = "",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "这是五人地下城，需要一支约50—55级的五人小队。部落：飞往 {area:75}；联盟：飞往 {zone:1419} 的 {area:1438}，再骑乘北上。{area:1477} 位于 {zone:1435} 的 {area:74} 中央：从废墟南侧上楼梯，潜入被水淹没的大厅，穿过大厅继续下潜，再沿楼梯和通道向下走到传送门。{npc:8580}（50级精英，会使用 {spell:12887} 和 {spell:6524}）只会在按顺序点击祭坛深坑上方环形露台上的六座蛇雕像后出现：南、北、西南、东南、西北、东北（顺序正确时雕像会变绿；顺序错误则失败）。先清掉每座雕像旁和下方深坑中的小怪；跳进水里是最快的下行方式，但在边缘附近被击退可能致命。{item:22444} 必定掉落。",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "回到{zone:1449}东南角找{npc:9619}。",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619}：原来的物品奖励选项可能已移除，按只有经验奖励来打算。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "施放传送：{zone:1450}。{npc:12042}站在{area:2361}；你的职业训练师也提供同一任务。",
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "施放{spell:18960}。{npc:12042}站在{area:2361}；你的职业训练师也提供同样的任务。",
	-- ["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "50级时在安戈洛环形山获得经验和两瓶治疗药水；Forever移除了经典版的物品选择。",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "环形山南部虫巢的格里什异种蝎、格里什工蝎和格里什劫掠者掉落钉刺；产出{item:22434}的血瓣花苗长满环形山西半部。",
	-- ["Use the {item:22432} on a living {npc:6498} (an Ironhide or {npc:6500}, or {npc:6584}, counts too): they are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The nearest roams south-west of {area:541}."] = "对活着的 {npc:6498} 使用 {item:22432}（铁皮魔暴龙、{npc:6500} 或 {npc:6584} 也算）：它们是54—55级精英，会使用 {spell:14099}，跑得比旅行形态还快。建议组队，但德鲁伊也能单独完成：远距离用休眠或 {spell:339} 控制它，用倒钩刺中它（倒钩不会打破 {spell:2637}），然后离开。倒钩命中的瞬间就会计入进度，之后即使死亡也不影响。最近的一只在 {area:541} 西南面游荡。",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "对一只{npc:6498}使用{item:22432}。魔暴龙是精英（54-55级），在环形山中游荡：建议组队。",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477}位于{zone:1435}的{area:74}中。{npc:8580}守在神庙底层：这是地下城首领，请带上小队。",
}
