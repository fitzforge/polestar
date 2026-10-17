-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "骷髏戰馬",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773}和{npc:4731}的馬廄在{zone:1420}的{area:159}。60級時{npc:4773}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會獲得一隻坐騎。Forever用戶端在60級時以每隻200金出售骷髏戰馬。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "騎術訓練師{npc:4773}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}，200金",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}，200金",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Forever新增的綠色、深色和紫色骸骨戰馬以及{npc:265653}（60級）目前還沒有已知來源。",
}
