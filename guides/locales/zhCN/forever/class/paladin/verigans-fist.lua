-- Chinese (simplified) (zhCN): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5502} Sense Undead
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield and {spell:5502} on the way."] = "联盟圣骑士20多级的稀有双手锤，途中还能拿到一面盾牌和{spell:5502}。",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["At 20 {npc:6179}, upstairs in the {object:32386} in the {object:32362}, gives you the {item:6776}. Right-click it: it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the {area:2257} from {zone:1455} to {zone:1453}."] = "20级时，{object:32362} 内 {object:32386} 楼上的 {npc:6179} 会给你 {item:6776}。右键点击它：它会让你前往 {zone:1453} 的圣光大教堂寻找 {npc:6171}。从 {zone:1455} 搭乘 {area:2257} 前往 {zone:1453}。",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Humans get the {item:6776} from him. Right-click the book to start its quest and hand it straight back to him."] = "{npc:6171} 站在圣光大教堂中。人类可从他那里领取 {item:6776}。右键点击书籍以接受它提供的任务，然后直接交还给他。",
	-- {item:6776} Tome of Valor
	["Right-click the {item:6776}"] = "右键点击{item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall · {area:20} Moonbrook · {area:1581} Deadmines
	-- plural, as words: Defias Raiders = {npc:6180} Defias Raider
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}, south of {area:20}: take the path that runs south beside the {area:1581}' back exit. When you take her quest, she walks from her orchard to the house and three waves of Defias Raiders (level 17-18) attack: three, then four, then five. Fight close to her so they do not swarm her, and heal her when she drops. You get time to eat and drink between waves, and she heals to full. If you or {npc:6182} die, the quest fails: abandon it and take it again from her (she is back five minutes after dying). Players find it hard alone before about 24."] = "{npc:6182}的农舍在{zone:1436}西南海岸、{area:20}以南：沿着{area:1581}后门出口旁向南延伸的小路走。接受任务后，她会从果园走向房屋，随后三波迪菲亚袭击者（17-18级）前来进攻：依次为三名、四名和五名。靠近她战斗，避免敌人围攻她，并在她生命值降低时为她治疗。每波之间有时间吃喝，她也会恢复满血。如果你或{npc:6182}死亡，任务就会失败：放弃后重新找她接受（她死亡后五分钟会刷新）。玩家通常认为约24级以前很难单独完成。",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}: three waves"] = "保护{npc:6182}：三波敌人",

	-- Step 4: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {item:9607} Bastion of Stormwind · {spell:5502} Sense Undead
	["Back to the Cathedral of Light: {npc:6171} gives you the {item:9607} shield and teaches you {spell:5502}."] = "回到圣光大教堂：{npc:6171} 会给你盾牌 {item:9607}，并教你 {spell:5502}。",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} works outside the gates of {zone:1455}, not inside. He gives you {item:6996}: four parts, in any order. Keep the notes."] = "{npc:6181}在{zone:1455}城门外工作，而非城内。他会给你{item:6996}：共4个部分，顺序任意。请保留笔记。",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is downstairs in the house of {area:144} that has a tailoring merchant outside. His quest only opens once you hold Jordan's."] = "{npc:6241} 在 {area:144} 一栋房屋的楼下，屋外有裁缝商人。只有先接到乔丹的“正义试炼”任务，才能接受他的任务。",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The crate of ore sits outdoors in the middle of the Mo'grosh ogre camp in north-east {zone:1432}, beside a big tree and a broken wagon, between the caves. The camp holds about fifteen Mo'grosh ogres, elite (level 18-19), who knock you down and come back after five minutes: grouping up is encouraged; at 20-22 it needs a group of about three. The crate is back two seconds after each loot, so every paladin in the group gets one."] = "矿石箱在{zone:1432}东北部莫格罗什食人魔营地中央的露天区域，位于几个洞穴之间，一棵大树和一辆破损的马车旁。营地里大约有十五个精英莫格罗什食人魔（18-19级），它们会击倒你，五分钟后刷新：建议组队；20-22级时大约需要三人。箱子每次拾取后两秒就会刷新，因此队伍中的每位圣骑士都能拿到一个。",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "{object:92420}箱子",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "回到{npc:6241}处",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}, the part Jordan wants."] = "{npc:6241} 会把矿石制成 {item:6993}，这就是乔丹需要的部件。",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is at the bottom of the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in the mast room with Sneed drop the lumber every time."] = "{area:1581} 是 {area:20} 地下的五人地下城；副本传送门位于 {area:20} 矿井底部。地精木匠（18—19级精英）在斯尼德所在的桅杆房间里，必定掉落木材。",
	-- {area:1581} Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}，在{area:20}的矿洞里",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "地精木匠，在副本内",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest · {zone:1437} Wetlands · {area:287} Hillsbrad
	["{area:236} is a dungeon for a group of five in the low to mid 20s, in southern {zone:1421}, Horde land: a long trip for the Alliance, through the {zone:1437}, Arathi and {area:287}. The hammer lies on a crate across from the horses in the stables, early in the dungeon, at the far end of the courtyard before the ramp up; it is back five minutes after someone takes it."] = "{area:236} 是适合 20 级出头至 25 级左右五人小队的地下城，位于部落领土 {zone:1421} 南部：联盟要走很远，途经 {zone:1437}、阿拉希和 {area:287}。锤子在地下城前段的马厩里，放在马匹对面的箱子上，位于庭院尽头、上行斜坡之前；被人取走后五分钟会重新出现。",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}，在副本内",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}. Take his quest before you hunt naga: the Kor Gem never drops without it."] = "{npc:3649} 位于 {area:442}。猎杀纳迦前先接他的任务：没有任务就绝不会掉落科尔宝石。",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The Blackfathom naga in the flooded passages around the {area:2797} entrance, on {zone:1440}'s north-west coast, drop the {item:6995}: Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24), one in two. You do not need to enter the instance. All are elite: grouping up is encouraged; players solo them one at a time, with difficulty. They heal themselves, run for help at low health, satyrs stand near some, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "{zone:1440} 西北海岸、{area:2797} 入口周围淹水通道里的黑暗深渊纳迦会掉落 {item:6995}：黑暗深渊海潮祭司（20—21级）、黑暗深渊智者（21—22级）和 黑暗深渊海巫（23—24级），掉率为二分之一。无需进入副本。它们全是精英：建议组队；玩家可以逐个单杀，但比较困难。它们会自疗，低血量时会逃跑求援，部分身旁还有萨特，黑暗深渊海巫 会在近距离施放 {spell:122}。有玩家反馈，处于团队中时不掉落。",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "回到{area:442}找{npc:3649}：他会净化宝石。",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}. Accept his last quest and wait by him while he forges the mace at his anvil."] = "把四个部件带给 {zone:1455} 外的 {npc:6181}。接受他的最后一个任务，然后在他身旁等候，直到他在铁砧上铸好锤子。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "20级时，{object:32362}的{npc:6179}会给你{item:6776}；它会让你去找{zone:1453}光明大教堂的{npc:6171}。从{zone:1455}乘地铁前往{zone:1453}。",
	-- ["Bring the four parts to {npc:6181} outside {zone:1455}."] = "把四个部件交给{zone:1455}外的{npc:6181}。",
	-- ["Protect {npc:6182}"] = "保护{npc:6182}",
	-- ["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "联盟圣骑士20多级的稀有双手锤，途中还能拿到一面盾牌。",
	-- ["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "{zone:1440}西北海岸{area:2797}入口附近的黑暗深渊纳迦掉落{item:6995}。它们是精英：建议组队。",
	-- ["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "矿石箱放在{zone:1432}东北部莫格罗什食人魔营地中央的树旁。莫格罗什食人魔是精英：建议组队。",
	-- ["from the {item:6776}"] = "来自{item:6776}",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581}是{area:20}地下的五人副本；副本传送门在{area:20}的矿洞里。桅杆室里与斯尼德一起的地精木匠掉落木材。",
	-- ["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236}是{zone:1421}南部的20-30级地下城。铁锤放在马厩里的一个箱子上，在庭院尽头、上坡之前。",
	-- ["{npc:3649} is in {area:442}."] = "{npc:3649}在{area:442}。",
	-- ["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171}站在光明大教堂里。右键点击{item:6776}开始它的任务。",
	-- ["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181}站在{zone:1455}大门外。他会给你{item:6996}，上面列出了四个部件。",
	-- ["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "{npc:6182}的农舍位于{zone:1436}西南海岸。她的任务期间迪菲亚兄弟会会一波波来袭：保护她存活，需要时为她治疗。",
	-- ["{npc:6241} is in {area:144}."] = "{npc:6241}在{area:144}。",
	-- ["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241}会把矿石变成{item:6993}。",
}
