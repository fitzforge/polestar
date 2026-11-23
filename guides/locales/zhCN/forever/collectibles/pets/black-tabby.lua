-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "{area:279}的法师",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "{npc:1920} 是 {zone:1421} 南部 {area:233} 的一名 21 级稀有法师，约每击杀 6 次掉落一次 {npc:7383}。它只有一个刷新点，可能数小时才会刷新，每次经过都可以看看。它没刷新时，也可以打 {area:279} 陨石坑内的达拉然持盾守卫、法师和召唤师（31-35 级），那里是 {zone:1416} 与 {zone:1424} 交界处，不过掉率只有约五百分之一。这只猫可以交易：也看看拍卖行。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "{npc:1920}是{zone:1421}南部{area:233}法师中的稀有刷新怪，据我们的数据约17%几率掉落；{area:233}和{area:279}陨坑周围的其他{area:279}法师约0.2%几率掉落。不断击杀法师，直到达拉然书记员出现。联盟玩家可在拍卖行购买。",
}
