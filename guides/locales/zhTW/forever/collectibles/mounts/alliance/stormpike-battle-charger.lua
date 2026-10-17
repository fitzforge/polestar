-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/stormpike-battle-charger (forever/collectibles/mounts/alliance/stormpike-battle-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormpike Guard
	-- {area:2839} Alterac Valley · {faction:730} Stormpike Guard · {npc:13217} Thanthaldis Snowgleam · {zone:1416} Alterac Mountains · {area:287} Hillsbrad · {npc:13216} Gaelden Hammersmith
	["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839}（51級以上）可提升{faction:730}聲望：取得勝利、佔領哨塔和墓地，並繳交戰場的任務物品。{npc:13217}在{area:287}上方{zone:1416}邊界的戰場外等候；{area:2839}裡的{npc:13216}也販售同一匹坐騎。",

	-- Step 2: Stormpike Battle Charger
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever用戶端標價200金、等級60，且不需要騎術等級。",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}, 200g"] = "{npc:13217}，200金",
}
