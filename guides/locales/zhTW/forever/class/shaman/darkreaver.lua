-- Chinese (traditional) (zhTW): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "60級時在{area:2057}的一場戰鬥，換取部落聲望；Forever移除了{item:20134}。",
	["200 Horde reputation"] = "200點部落聲望",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "58級時，{object:172957}的薩滿訓練師{npc:13417}會要你帶兩顆稀有鑽石。",

	-- Step 2: Two diamonds
	["Two diamonds"] = "兩顆鑽石",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "{item:12800}來自瑟銀礦脈，{item:18335}來自{zone:1422}的精英怪，兩者都很稀有：能的話就在拍賣場購買。",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668}需要60級。",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "他會交給你{item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}位於{zone:1422}東南方的島嶼城鎮{area:2298}之下。在大藏骨堂地下室的中心使用{item:18746}，擊敗它召喚出的靈魂，然後擊敗{npc:14516}。全都是精英：找小隊一起去。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}位於{zone:1422}東南方的島嶼城鎮{area:2298}之下。在{object:179746}地下室的中心使用{item:18746}，擊敗它召喚出的靈魂，然後擊敗{npc:14516}。全都是精英：找小隊一起去。",
}
