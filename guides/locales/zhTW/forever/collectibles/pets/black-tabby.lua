-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "{area:279}的法師",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "{npc:1920}是{zone:1421}南部{area:233}的稀有21級法師，每6次擊殺約有一次掉落{npc:7383}。它只有一個重生點，可能要幾小時才回來，所以路過就去看看。它沒重新出現的時候，{zone:1416}與{zone:1424}交界處{area:279}巨坑裡的達拉然盾衛、咒術師和召喚師（31-35級）也會掉落，但約500次擊殺才出一次。這隻貓可以交易：也看看拍賣行。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "{npc:1920}是{zone:1421}南部{area:233}法師之間的稀有怪，根據我們的資料約有17%機率掉落；{area:233}和{area:279}坑洞周圍的其他{area:279}法師約有0.2%機率。持續擊殺法師直到書記員出現。聯盟玩家可在拍賣場購買。",
}
