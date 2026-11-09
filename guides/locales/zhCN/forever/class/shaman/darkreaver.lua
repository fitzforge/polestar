-- Chinese (simplified) (zhCN): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; the {item:20134} may be gone in Forever."] = "60级时在{area:2057}的一场战斗，奖励部落声望；无限可能已移除{item:20134}。",
	["200 Horde reputation"] = "200点部落声望",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds; every Horde shaman goes to him. Skyborne: Forever's quest page lists this quest for Orcs, Tauren and Trolls only: ask before you buy the diamonds."] = "58级时，{object:172957} 的萨满祭司训练师 {npc:13417} 会索要两颗稀有钻石；所有部落萨满祭司都要来找他。天裔角色注意：无限服的任务页面显示，此任务仅限兽人、牛头人和巨魔；买钻石前先确认能否接到。",

	-- Step 2: Two diamonds
	["Two diamonds"] = "两颗钻石",
	-- {item:12800} Azerothian Diamond · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {item:18335} Pristine Black Diamond
	-- plural, as words: Small Thorium Veins = {object:324} Small Thorium Vein
	["Both diamonds are rare: the auction house is the quick way. Miners find the {item:12800} in about one Thorium vein in a hundred (the Small Thorium Veins north of {area:2418} in the {zone:1428} respawn every five minutes). The {item:18335} drops from high-level elites at about one in a hundred, best from the rare elite Revanchion (about one in nine)."] = "两种钻石都很稀有：在拍卖行购买最快。矿工采掘瑟银矿脉时，取得 {item:12800} 的概率约为百分之一（{zone:1428} 的 {area:2418} 北侧的瑟银矿脉每五分钟刷新）。高等级精英掉落 {item:18335} 的概率约为百分之一，最好找稀有精英雷瓦克安，掉落概率约为九分之一。",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668}需要60级。",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "他会交给你{item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {npc:14516} Death Knight Darkreaver · {spell:686} Shadow Bolt · {spell:6958} Blood Leech
	-- plural, as words: Cleaves = {spell:845} Cleave
	["A five-player dungeon event: {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. In the {object:179746}'s basement, first clear every mob in the room, then use the {item:18746} at its centre: four waves of spirits follow, each closing with an Aspect mini-boss (the first wave weak and slow, the rest elite). Fight in a corner so nothing else joins, and drink between waves: it is long. Then {npc:14516} (level 62 elite) appears: he Cleaves, casts {spell:686} and {spell:6958}, and Dominates a player's mind against the group. His head always drops."] = "这是一个五人地下城事件：{area:2057} 位于 {zone:1422} 东南部岛上城镇 {area:2298} 的下方。在 {object:179746} 的地下室中，先清光房间里所有怪物，再在中央使用 {item:18746}：随后会出现四波灵魂，每波最后都有一名“之貌”小首领（陈腐之貌、堕落之貌、恶毒之貌或暗影之貌；第一波弱且行动迟缓，其余都是精英）。在角落作战，以免引到其他怪物，并在每波之间喝水：战斗很漫长。随后 {npc:14516}（62 级精英）出现：他会顺劈斩，施放 {spell:686} 和 {spell:6958}，还会控制一名玩家攻击小队。他必定掉落头颅。",

	-- Step 5: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {item:20134} Skyfury Helm
	["{npc:13417}: 200 Horde reputation; the {item:20134} may be gone"] = "{npc:13417}：200点部落声望；{item:20134} 可能已经消耗掉",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "60级时在{area:2057}的一场战斗，奖励部落声望；Forever移除了{item:20134}。",
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "{item:12800}来自瑟银矿脉，{item:18335}来自{zone:1422}的精英怪，两者都很少见：能的话在拍卖行购买。",
	-- ["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "58级时，{object:172957}的萨满祭司训练师{npc:13417}要求两颗稀有钻石。",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}位于{zone:1422}东南部的岛上小镇{area:2298}之下。在尸骨储藏所地下室的中央使用{item:18746}，击败它召来的灵魂，然后击败{npc:14516}。全都是精英：请带上小队。",
}
