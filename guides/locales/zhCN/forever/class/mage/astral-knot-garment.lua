-- Chinese (simplified) (zhCN): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Alliance mages in their late 20s."] = "为二十多级的联盟法师准备的长袍或短衫。",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144}在{zone:1455}的{object:32362}教导法师。之后从{object:171524}乘{area:2257}前往{zone:1453}。",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}; the portal near the top of the spiral ramp takes you to her."] = "{npc:5497}位于{object:2101}紫色高塔、巫师圣殿的顶部。沿螺旋坡道上行，通过接近顶部的传送门即可到她身旁。",

	-- Step 3: High Sorcerer Andromath (Skyborne)
	-- {npc:5694} High Sorcerer Andromath
	["{npc:5694} (Skyborne)"] = "{npc:5694}（天裔）",
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5694} High Sorcerer Andromath · {npc:5497} Jennea Cannon
	["You do not need a letter: at 26 climb the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:5694} waits on the spiral walkway, just past the door of the portal room near the top, and has the quest for you. ({npc:5497} may also offer you {npc:5694}, the pointer quest; it is only a pointer and you can skip it.)"] = "无需介绍信。26 级时前往{zone:1453}的{object:2101}，登上紫色高塔巫师圣殿。{npc:5694}在接近顶部的螺旋走道、刚经过传送门房间门口的位置，会直接提供任务。{npc:5497}也可能提供指向{npc:5694}的介绍任务，它只用于引路，可跳过。",

	-- Step 4: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} waits on the spiral walkway of the Wizard's Sanctum, just past the door of the portal room as you walk down from the trainers."] = "{quest:1939}位于巫师圣殿的螺旋走道，从训练师处向下走，刚经过传送门房间门口即可找到。",

	-- Step 5: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {area:96} Tower of Ilgalar · {spell:2691} Mana Burn
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. The {area:96} stands alone in the east of the zone. Climb to the very top floor (not the one below): the treatise is the book sticking out of the shelf where the stairs come up. Two gnoll dogs and a gnoll caster guard the shelf; the dogs' {spell:2691} interrupts the click, so fight them on the stairs out of their sight. Morganth (level 26 elite) stands across the top floor: you do not need him, keep to the left edge of the ramp so he stays put. The book is back two seconds after anyone takes it. If you die, your ghost can run up and come back to life beside it."] = "向东穿过{zone:1429}进入赤脊山，或直接飞往{area:69}。{area:96}独立矗立在地区东侧。爬到最顶层，不要停在下一层；论文就是楼梯出口旁书架上突出的书。两只豺狼人猎犬和一名施法者守着书架，猎犬的{spell:2691}会打断拾取，应在楼梯上、避开它们视线的位置战斗。26 级精英莫甘斯在顶层另一侧，无需击杀；沿坡道左缘走，避免引到他。书被拾取两秒后就会重新出现。若死亡，可用灵魂跑上楼，在书旁复活。",

	-- Step 6: Back to Andromath
	["Back to Andromath"] = "回到高阶巫师安多玛斯那里",

	-- Step 7: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "{npc:949}",
	-- {area:492} Raven Hill Cemetery · {zone:1431} Duskwood · {spell:3609} Paralyzing Poison · {npc:522} Mor'Ladim
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["{area:492} in western {zone:1431}: the six Carrion Recluses (level 25-26, green, {spell:3609}) walk the graves, the central statue and the riverbank, and every one drops a silk; they come back after 5 minutes. The Black Widow Hatchlings (24-25) on the slopes east of the cemetery drop it about one time in six, so mix them in while you wait. {npc:522}, a level 35 elite skeleton, walks the cemetery: watch for him."] = "前往{zone:1431}西部的{area:492}。六只 25–26 级、绿色且会施放{spell:3609}的食腐独行蛛分布在墓地、中央雕像及河岸，每只必掉一份丝，五分钟刷新。墓地东侧坡地的 24–25 级小型黑寡妇蜘蛛约六分之一几率掉落，等待刷新时可顺便击杀。35 级精英骷髅{npc:522}会在墓地巡逻，注意避开。",

	-- Step 8: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}. The robe gives intellect, stamina and spirit; the blouse more intellect and stamina but no spirit."] = "{npc:1309}在{object:2101}的{object:23296}工作。长袍提供智力、耐力和精神；短衫提供更多智力和耐力，但没有精神。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a blouse for Human and Gnome mages in their late 20s."] = "为二十多级的人类和侏儒法师准备的长袍或短衫。",
	-- ["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "{npc:949}潜伏在{zone:1431}西部的树林里，每只都会掉落蛛丝。更东边的{npc:930}偶尔也会掉落。",
	-- ["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "向东穿过{zone:1429}进入赤脊山。那位堕落法师伊尔加拉的塔位于该地区东部；论文在他的书房里。",
	-- ["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309}在{object:2101}的{object:23296}工作。",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497}站在{object:2101}的法师塔里。",
	-- ["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939}也在法师塔里。",
}
