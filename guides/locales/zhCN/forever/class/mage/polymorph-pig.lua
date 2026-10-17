-- Chinese (simplified) (zhCN): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "{spell:118}的新外观：把目标变成猪而不是羊。",

	-- Step 1: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "飞往{area:3137}（联盟）或{area:1237}（部落）。{npc:8395}在{npc:8379}的塔下扎营：从{zone:1447}主路在{area:1221}的岔口一直向北走到悬崖。他会把你传送上去见大法师。",

	-- Step 2: Warlord Krellian
	-- {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "克雷利安躲在{area:1223}里他的恶鞭卫兵身后，那是{area:1221}中央最大的建筑。他会掉落{item:23250}。",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "回到{npc:8395}那里，再上塔。",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "变形克隆",
	-- {item:23250} Prismatic Shell · {area:1221} Ruins of Eldarath
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "把{item:23250}带回{area:1221}。对一只恶鞭纳迦施放变形术并等几秒：它会分裂成小型的{npc:16479}。迅速杀死克隆体；贝壳会收集它们的精华。",

	-- Step 5: Fragmented Magic
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}：{spell:118}（猪）",
}
