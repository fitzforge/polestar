-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "豹",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4753}和{npc:4730}的豹位于{zone:1457}{area:1658}的骑术场。40级时{npc:4753}教授{skill:762}（暴雪设计师设定为100金），学会后会获得一匹坐骑。Forever 客户端允许所有联盟种族骑乘这些坐骑。",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}出售其他颜色（Forever 客户端中每个20金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}，20金",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}，20金",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}，20金",
	-- {item:274706} Reins of the Striped Dawnsaber
	["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706}是 Forever 新增的豹（40级，客户端中20金），来源尚不明确。",
}
