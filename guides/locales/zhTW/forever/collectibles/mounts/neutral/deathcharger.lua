-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "死亡戰騎",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "{item:13335}需要60級和中級{skill:762}才能騎乘（Forever 用戶端）。向你種族的騎術訓練師學習；請見60級坐騎指南。",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance · {object:175440} Elders' Square · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279}是五人副本，58-60級。{zone:1423}西北部{object:175440}的{object:175461}通往亡靈區；{npc:10440}在盡頭的屠宰場等著。依我們的資料，韁繩的掉落率為0.02%（pfQuest，Era）：大約每五千次擊殺掉一次。沒有跡象顯示 Forever 更改了它。",
	-- {object:175461} Service Entrance
	["Stratholme {object:175461}"] = "斯坦索姆{object:175461}",
}
