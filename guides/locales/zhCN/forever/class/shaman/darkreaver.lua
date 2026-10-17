-- Chinese (simplified) (zhCN): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "60级时在{area:2057}的一场战斗，奖励部落声望；Forever移除了{item:20134}。",
	["200 Horde reputation"] = "200点部落声望",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "58级时，{object:172957}的萨满祭司训练师{npc:13417}要求两颗稀有钻石。",

	-- Step 2: Two diamonds
	["Two diamonds"] = "两颗钻石",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "{item:12800}来自瑟银矿脉，{item:18335}来自{zone:1422}的精英怪，两者都很少见：能的话在拍卖行购买。",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668}需要60级。",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "他会交给你{item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}位于{zone:1422}东南部的岛上小镇{area:2298}之下。在尸骨储藏所地下室的中央使用{item:18746}，击败它召来的灵魂，然后击败{npc:14516}。全都是精英：请带上小队。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}位于{zone:1422}东南部的岛上小镇{area:2298}之下。在{object:179746}地下室的中央使用{item:18746}，击败它召来的灵魂，然后击败{npc:14516}。全都是精英：请带上小队。",
}
