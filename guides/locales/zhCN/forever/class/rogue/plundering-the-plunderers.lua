-- Chinese (simplified) (zhCN): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "十份{item:7676}——潜行者的能量饮料，来自16级的部落开锁任务。",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "16级时，{area:362}的潜行者训练师{npc:3170}会让你去找{zone:1454}的{npc:3401}。",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "16级时，{object:36073}的{npc:6467}会让你去找{zone:1454}的{npc:3401}。同时从他那里接受{quest:1998}；它在本指南最后于{zone:1421}完成。",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401}和{quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "亡灵从{zone:1458}外的塔楼乘飞艇前往{zone:1411}。{npc:3401}和{quest:2379}站在{object:172960}，即{object:172982}下方的峡谷。",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools
	["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "飞往或骑行到{zone:1413}海岸的{area:392}。{npc:7161}和他的机械设备站在镇上：出发前从设备处购买一个{item:7970}和{item:5060}。",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {item:7970} E.C.A.C.
	["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "从{area:392}沿海岸向南，在南海海盗的营地。如果有只异常凶猛的鹦鹉攻击你，对它使用{item:7970}（任务本身的建议）。",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "回到{npc:7161}处",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}：十份{item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "从{zone:1454}乘飞艇前往{zone:1458}，然后向南骑行进入银松森林。{quest:1998}站在{area:228}东北边。",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox
	["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "肯瑞托把报告存放在银松森林东南部的{area:233}：撬开{object:103815}的锁。",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "回到{npc:6467}处",
}
