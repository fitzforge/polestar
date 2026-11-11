-- Chinese (simplified) (zhCN): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "部落法师15级的长袍，任务在{zone:1458}和{zone:1421}。",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {object:172961} Valley of Spirits · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311}是{zone:1454}的法师训练师之一，位于{object:172961}的{object:173161}内。随后从{zone:1454}正门外高塔乘飞艇前往{zone:1420}。",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128}是{area:159}的法师训练师，在{area:2119}楼上：从室内楼梯上去，箭头无法区分楼层。",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:4568}站在{object:36082}，她身后的台沿上有{item:7247}和{item:7308}，被拿走后均五分钟刷新。最后交任务时需要两件物品，请保留。",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "炼金商店",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "奥格诺恩的炼金店位于炼金房。在店外台阶或桥上阅读{item:7308}，最多四只隐形的 16–17 级裂隙怒灵会同时出现并攻击，城内守卫不会帮忙。用单体法术攻击一只，再退过桥，其他敌人会放弃并消失，被攻击的那只会追来。在桥上靠商店的一半区域战斗，超过桥中央后盒子将无法生效。将它打到停止战斗、头顶转圈并昏迷时，使用{item:7247}，再等地面出现{item:7292}后点击，点得太早会浪费次数。共需三个。",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}：攻击至其昏迷",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "对昏迷的{npc:6492}使用{item:7247}",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "回到{npc:4568}处",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "离开{zone:1458}，沿路向南穿过{zone:1421}。所有{area:279}人类约五分之四几率掉落{item:7293}，也掉落{item:2589}。最容易的是{area:228}东南侧、南下道路两侧山丘上的达拉然学徒，13–14 级，使用{spell:116}。更深入的银松东南部{area:233}城墙内，有 18–19 级守护者，使用{spell:134}和{spell:2120}；19–20 级巫师使用{spell:122}，四分半刷新，低血量时逃跑求援，从外围拉怪。所需十个{item:2589}也可从任意人形生物取得，或在幽暗城拍卖行购买。",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "奥格诺恩的炼金商店在幽暗城的炼金区。在那里使用{item:7308}让{npc:6492}现形，用法术制服一只，然后使用{item:7247}扔下一个箱子将其捕获。",
	-- ["Algernon's alchemist shop is in the {object:36072}. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "奥格诺恩的炼金商店在{object:36072}。在那里使用{item:7308}让{npc:6492}显形，用法术削弱一个，然后使用{item:7247}扔下一个封灵箱捕获它。",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then take {quest:1962} (Forever's quest data has {npc:11049} offering it; if the \"!\" shows over {npc:4576} instead, take it from him) and hand it to {npc:4576} for the robe."] = "返回{zone:1458}。{npc:4576}、{npc:11048}和{npc:11049}在{object:36082}经营裁缝店。将宝石和布料交给{npc:4576}，让他们三人交谈片刻；然后接受{quest:1962}（无限服的任务数据显示由{npc:11049}提供；如果“!”反而出现在{npc:4576}头上，就从他那里接受），再交还给{npc:4576}领取长袍。",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "回到{zone:1458}。{npc:4576}、{npc:11048}和{npc:11049}经营裁缝店。",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "人型生物会掉落{item:2589}；幽暗城拍卖行也有出售。",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "离开{zone:1458}，沿道路向南穿过{zone:1421}。{area:279}法师占据着{area:228}东南的{area:233}；每个{npc:1867}、达拉然法师、达拉然保卫者、达拉然守卫、达拉然咒术师、达拉然卫士和达拉然巫师都可能掉落{item:7293}。",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128}是{area:159}的法师训练师。",
	-- ["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568}站在{object:36082}。{item:7247}和{item:7308}放在她身后。",
	-- ["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311}是{zone:1454}的法师训练师之一。然后在{zone:1454}正门外的塔上乘飞艇前往{zone:1420}。",
}
