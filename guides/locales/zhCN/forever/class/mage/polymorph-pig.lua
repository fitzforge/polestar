-- Chinese (simplified) (zhCN): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "{spell:118}的新外观：把目标变成猪而不是羊。",

	-- Step 1: Xylem's tower
	["Xylem's tower"] = "",
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Dismount, and he teleports you up; a trail climbs to the Archmage at the top of the tower."] = "联盟飞往{area:3137}，部落飞往{area:1237}。{npc:8395}在{npc:8379}的高塔下扎营，位于{area:1237}稍东侧。从{zone:1447}主路在{area:1221}处的岔路口直向北走，前往峭壁。下坐骑后，他会把你传上去，再沿小径爬到塔顶找大法师。",

	-- Step 2: Warlord Krellian
	-- {npc:8408} Warlord Krellian · {spell:99} Demoralizing Roar · {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["{npc:8408} (level 55, not elite, Strike and {spell:99}) hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He always drops the {item:23250} and is back 5 1/2 minutes after a kill. Leave any raid group first: a raid gets no credit, a party is fine."] = "55 级非精英{npc:8408}藏在{area:1221}中央最大建筑{area:1223}内的恶鞭守卫后方，会使用打击和{spell:99}。必定掉落{item:23250}，五分半刷新。先退出团队，团队状态下无法获得任务进度，小队状态可以。",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower. Xylem hands the shell back with the next quest: keep it in your bags."] = "返回{npc:8395}处并上塔。大法师克希雷姆提供下一项任务时会把贝壳还给你，保留在背包里。",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "变形克隆",
	-- {area:1221} Ruins of Eldarath · {spell:118} Polymorph · {spell:122} Frost Nova · {spell:1449} Arcane Explosion
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Back to the {area:1221}, full of Spitelash naga. Cast your sheep {spell:118} (the turtle one does nothing) on a naga and wait a few seconds: it splits into two to six Polymorph Clones of about 150 health that run off fast. Stand next to the sheep and hit them the moment they appear with {spell:122} and {spell:1449}. Fifty clones are needed, so it takes a while; not in a raid group."] = "返回满是恶鞭纳迦的{area:1221}。对一只纳迦施放绵羊形态的{spell:118}，乌龟形态无效。等待数秒，它会分裂出两到六只约 150 生命值的变形克隆，并迅速逃跑。站在绵羊旁，复制体一出现就使用{spell:122}和{spell:1449}。需要击杀五十只，会花些时间，不能处于团队状态。",

	-- Step 5: Fragmented Magic
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "回到{npc:8395}那里，再上塔。",
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}：{spell:118}（猪）",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "把{item:23250}带回{area:1221}。对一只恶鞭纳迦施放变形术并等几秒：它会分裂成小型的{npc:16479}。迅速杀死克隆体；贝壳会收集它们的精华。",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "飞往{area:3137}（联盟）或{area:1237}（部落）。{npc:8395}在{npc:8379}的塔下扎营：从{zone:1447}主路在{area:1221}的岔口一直向北走到悬崖。他会把你传送上去见大法师。",
	-- ["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "克雷利安躲在{area:1223}里他的恶鞭卫兵身后，那是{area:1221}中央最大的建筑。他会掉落{item:23250}。",
}
