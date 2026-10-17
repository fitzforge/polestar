-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/swift-wolf (forever/collectibles/mounts/horde/swift-wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Wolf"] = "迅捷狼",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift wolf for 200g at level 60."] = "{npc:4752}和{npc:3362}的狼舍在{zone:1454}的{object:172958}。60级时{npc:4752}教授中级{skill:762}（暴雪设计师设定为1,000金）；暴雪称学会骑术会获赠一匹坐骑。Forever 客户端在60级时以每只200金出售迅捷狼。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362}出售其他颜色（Forever 客户端中每个200金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:18796} Horn of the Swift Brown Wolf
	["{item:18796}, 200g"] = "{item:18796}，200金",
	-- {item:18797} Horn of the Swift Timber Wolf
	["{item:18797}, 200g"] = "{item:18797}，200金",
	-- {item:18798} Horn of the Swift Gray Wolf
	["{item:18798}, 200g"] = "{item:18798}，200金",
}
