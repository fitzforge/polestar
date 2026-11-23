-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 40 {npc:4753} teaches {skill:762} to Night Elves for 100g (10% less at Honored with {faction:69}), and it comes with a saber. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4753} 和 {npc:4730} 的夜刃豹位于 {faction:69} 的 {area:1658} 骑术训练场。40 级时，{npc:4753} 会向暗夜精灵传授 {skill:762}，费用 100 金币（{faction:69} 声望尊敬可享 10% 折扣），并附赠一只夜刃豹。其他种族需向本族骑术训练师学习 {skill:762}，并获得本族的第一只坐骑。",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}，骑术训练师",

	-- Step 2: Tiger Riding for other races
	-- {spell:828} Tiger Riding
	["{spell:828} for other races"] = "其他种族学习{spell:828}",
	-- {spell:828} Tiger Riding · {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes {spell:828}, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "联盟任何种族都能购买这些夜刃豹，但骑乘还需要 {spell:828}，只有暗夜精灵学习 {skill:762} 时会一并获得。其他种族在 {faction:69} 声望达到崇拜后，可向 {npc:4753} 学习（“达纳苏斯声望”指南中有具体方法）。达到之前，不要给这个角色购买夜刃豹。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}出售其他颜色（无限 客户端中每个20金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}，20金",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}，20金",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}，20金",
	["new in Forever, 20g; beta players found it here"] = "无限服新增，20金币；测试服玩家曾在这里找到",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706}是 Forever 新增的豹（40级，客户端中20金），来源尚不明确。",
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4753}和{npc:4730}的豹位于{zone:1457}{area:1658}的骑术场。40级时{npc:4753}教授{skill:762}（暴雪设计师设定为100金），学会后会获得一匹坐骑。Forever 客户端允许所有联盟种族骑乘这些坐骑。",
}
