-- Chinese (simplified) (zhCN): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484}和{item:267369}（被遗忘者）",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "被遗忘者圣骑士的双手剑：营救{quest:91862}，收集三个部件，杀死{quest:95140}。",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "18级时，位于{area:156}西北高地、{area:16602}内部的{npc:246378}会让你向南前往{zone:1421}的{area:228}。",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "{npc:248840} 在 {area:228} 的地下区域；{npc:259611} 在镇子入口附近放哨。",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "{area:172}上的火堆",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "{area:172}位于{area:228}东北方的湖中。豺狼人的火堆在湖岸上，{object:566037}就在其中：点击遗骸交还任务，再点击一次接受后续任务。那是牛头人的遗体，不是精灵的。",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "来自{object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "{quest:91862} 被关在岛屿北端 {area:235} 地下室的笼子里。城堡中到处都是腐皮豺狼人（18-19 级）：它们会跨楼层成群被引来，而且玩家反映刷新极快，因此要清出一条路，持续前进。任意一只都可能携带 {item:267412}（经常第一只就掉）；稀有怪 {npc:1944}（22 级）和斯纳麦恩（23 级）也可能携带。如果她的笼子是空的，说明其他玩家正在护送她，等她回来即可。",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}，来自腐皮豺狼人",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "解救{npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "先交还钥匙：如果先开始护送，钥匙任务就不会计入完成进度。之后打开笼子：{npc:248755} 会穿过堡垒及庭院，途中豺狼人会发起攻击，随后她会跑向码头，自行返回 {area:228}。紧跟着她，保护她活下来；如果她死亡，等她回到笼子后重新接受任务。",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "回到{area:228}",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the {area:228} (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "{npc:259620} 在 {area:228} 内的 {npc:248840} 身边等候（这名 {npc:259620} 与你护送的那位不是同一个）。做 {quest:95034} 时，要逐项点击，听完她的全部故事。",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}，{area:228}",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}: hear her story to the end"] = "",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "20级时，{npc:259620} 会让你找一把能杀死 {quest:95140} 的剑。与她身旁的 {npc:248840} 交谈，取得他的 特雷凡的武器笔记，上面列有部件清单，请保留：交部件时也要将笔记还给他。共三种部件，可按任意顺序收集：两种来自地下城（各需五人小队），一颗宝石来自第三个地下城外的精英纳迦。",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "{item:267454}：与 {npc:248840} 交谈",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "{item:267361}",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "{area:236} 是银松森林南部的地下城，适合由 20 级出头至 20 多级中段玩家组成的五人小队。金锭就在最深处 {npc:4275} 旁边的桌上。也可以借用朋友已清空的副本：进入后直接跑到桌旁即可。",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "{item:267361}，在阿鲁高的桌上。",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}，在{area:20}的矿洞里",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "地精木匠，在副本内",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "纳迦位于佐拉姆加北侧、{area:2797} 入口周围被水淹没的废墟和通道里，无需进入副本（副本内最前面的纳迦也掉这颗宝石）。黑暗深渊海潮祭司（20—21级）、黑暗深渊智者（21—22级）和 黑暗深渊海巫（23—24级）掉落 {item:6995}，掉率为二分之一。它们全是精英：建议组队。玩家可以逐个单杀，但比较困难；三人组队就很轻松。它们会自疗，低血量时会逃跑求援，黑暗深渊海巫 还会在近距离施放 {spell:122}。有玩家反馈，处于团队中时不掉落。",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "{item:272448}",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "返回佐拉姆加的 {npc:259649} 处，让他净化宝石。保留 {item:272448}，之后要交给 {npc:248840}。",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "把木材、锭和宝石带给 {area:228} 的 {npc:248840}。他会给你一个 {item:268192}，要交给 {area:272} 的铁匠：把它留在背包里。",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "武器锻造师 {npc:3539} 位于 {zone:1424} 的 {area:272} 正南边。接受 {quest:95125} 后，他就会开始锻造：退开一些，在附近等他完成。",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "{npc:3539} 会给你 {quest:95125}",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "回到{area:228}下层的{npc:248840}处：他会给你双手剑{item:268484}。",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "这把剑是双手剑，你需要足够的武器技能才能用它命中25级精英。{zone:1458} 的 {object:36070} 内的武器大师 {npc:11870} 收取少量费用，教授 {spell:202}；学会后先攻击容易对付的小怪，将技能练到接近上限（每级上限增加五点）。",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "装备 {item:268484}。巨型狼人 {quest:95140} 在 {area:228} 南侧、通往 {area:17065} 大门方向的林地游荡。他是精英（25 级）：建议组队；有玩家需要再找一人帮忙，也有玩家在 25 级时独自击败了他。你用这把剑第一次击中他前，他会受到紫色护盾保护；护盾破裂时会出现提示。",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "装备 {item:268484} 后，对付 {quest:95140}",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "带着 {item:268484} 回到 {area:228} 找 {npc:259620}（任务要求携带它）：她会收下，用她族人的魔法祝福它，使其变成 {item:267369}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "用钥匙放她出来，然后在她杀出要塞时紧跟着她。",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "暂无物品：一段被遗忘者圣骑士的营救故事；其续篇{item:268484}目前还无法完成。",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "离开{area:235}后，卢米娜会在{area:228}等你。再次与她交谈，听听路上到底发生了什么。",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "离开{area:235}后，{npc:259620}会在{area:228}等你。再次与她交谈，听听路上到底发生了什么。",
	-- ["Rescuing {quest:91862}"] = "营救{quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "向南穿过{zone:1421}前往{area:228}。{npc:248840}站在镇里；{npc:259611}在入口附近守望。",
	-- ["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581}在联盟领地{zone:1436}的{area:20}下方：适合约17-24级的五人小队。入口是{area:20}的矿洞。斯尼德伐木房里的地精木匠（精英，18-19级）必定掉落木材。",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}位于{area:228}东边的湖中。烧焦的遗骸就在岛的岸边。",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378}在{area:156}西北的悬崖上，于{area:16602}内领导Tyr's Watch的圣骑士。",
	-- ["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: from the {zone:1458} take the zeppelin to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "{npc:259649} 在 {zone:1440} 西海岸的 {area:2897} 等待：从 {zone:1458} 乘飞艇前往 {zone:1454}，再向北穿过 {zone:1413} 进入 {zone:1440}，沿道路向西走。前哨站的双足飞龙管理员安德鲁克能让你下次免去步行。猎杀纳迦前先接受 {npc:259649} 的任务：只有接到任务后才会掉落 科尔宝石。",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862}被关在岛北端的{area:235}里。她周围的腐皮豺狼人身上带着钥匙。",
	-- ["{zone:1458} and Earthen Ring reputation"] = "{zone:1458}和大地之环声望",
}
