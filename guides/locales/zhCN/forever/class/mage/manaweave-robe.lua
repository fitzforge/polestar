-- Chinese (simplified) (zhCN): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "联盟法师15级时的长袍，来自{zone:1453}和{zone:1432}。",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328}是{area:87}的法师训练师，位于狮王之傲旅店楼上。",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312}在{zone:1455}的{object:32362}教导法师。之后从{object:171524}乘{area:2257}前往{zone:1453}。",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497}位于{object:2101}紫色高塔巫师圣殿顶部，沿螺旋坡道上行，通过接近顶部的传送门即可。她身后的桌子上有{item:7247}和{item:7308}，被拿走后均五分钟刷新。最后交任务时需要两件物品，请保留。",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169}是{object:2101}的旅店。在里面阅读{item:7308}，可显现隐形的 16–17 级裂隙怒灵：地下室出现一只，阳台或厨房两只，大厅或门边三只，因此应在地下室阅读。它们伤害很高，很快挣脱{spell:122}。将一只打到低血量，它不会死亡，而会停止战斗，头顶转圈并昏迷；此时对它使用{item:7247}，再点击地面上出现的{item:7292}。未出现就点击会浪费一次使用次数。共需三个，而咒文每五分钟才能用一次，退出登录也不重置，因此要做三轮。",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}：攻击至其昏迷",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "对昏迷的{npc:6492}使用{item:7247}",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "回到{npc:5497}那里",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "所有人形生物均有几率掉落{item:2589}，收集宝石时，{area:149}的坑道鼠也会掉落；{object:2096}的拍卖行可以买到。需要交付十个。",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "乘{area:2257}前往{zone:1455}，再沿路向东穿过南门隧道进入{zone:1432}。{area:149}在{area:144}以北、洛克湖北端，由坑道鼠狗头人占据。宝石只来自高高叠起的{object:271}，鼠标指向时显示齿轮；单独的小箱子没有。每个箱子给一颗，总共有十四个，三到五分钟刷新。要拿六颗，可能需要深入最里面的房间。这些箱子也用于矮人的“肮脏的爪子”任务。",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "乘地铁回到{zone:1453}。{npc:1309}在{object:2101}的{object:23296}工作。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "人型生物会掉落{item:2589}；{object:2096}的拍卖行也有出售。",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "乘{area:2257}前往{zone:1455}，然后沿路向东穿过南门的隧道进入{zone:1432}。矮人矿工联盟把箱子留在了湖北端的{area:149}里；坑道鼠狗头人占据着矿洞。",
	-- ["{npc:328} is the {area:87} mage trainer."] = "{npc:328}是{area:87}的法师训练师。",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497}站在{object:2101}的法师塔里。{item:7247}和{item:7308}就在她身后。",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169}是{object:2101}里的酒馆。在里面使用{item:7308}让{npc:6492}现形，用法术制服一只，然后使用{item:7247}扔下一个箱子将其捕获。",
}
