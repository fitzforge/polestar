-- Chinese (traditional) (zhTW): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A new look for Polymorph: it turns the target into a pig rather than a sheep."] = "",

	-- Step 1: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara
	["Fly to Talrendis Point (Alliance) or Valormok (Horde). {npc:8395} camps below {npc:8379}'s tower, a short way east of Valormok: from the fork of {zone:1447}'s main road at the Ruins of Eldarath, head straight north to the cliffs. Dismount, and he teleports you up; a trail climbs to the Archmage at the top of the tower."] = "",

	-- Step 2: Warlord Krellian
	-- {npc:8408} Warlord Krellian · {item:23250} Prismatic Shell
	["{npc:8408} (level 55, not elite, Strike and Demoralizing Roar) hides behind his Spitelash guards in the Temple of Zin-Malor, the biggest building in the middle of the Ruins of Eldarath. He always drops the {item:23250} and is back 5 1/2 minutes after a kill. Leave any raid group first: a raid gets no credit, a party is fine."] = "",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower. Xylem hands the shell back with the next quest: keep it in your bags."] = "",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "變形複製",
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Back to the Ruins of Eldarath, full of Spitelash naga. Cast your sheep Polymorph (the turtle one does nothing) on a naga and wait a few seconds: it splits into two to six Polymorph Clones of about 150 health that run off fast. Stand next to the sheep and hit them the moment they appear with Frost Nova and Arcane Explosion. Fifty clones are needed, so it takes a while; not in a raid group."] = "",

	-- Step 5: Fragmented Magic
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "回到{npc:8395}處，然後上塔。",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}: Polymorph (pig)"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "{spell:118}的新外觀：把目標變成豬而不是綿羊。",
	-- ["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "把{item:23250}帶回{area:1221}。對一隻惡鞭納迦施放變形術並等幾秒：牠會分裂成小型的變形複製。迅速擊殺這些複製體；貝殼會收集它們的精華。",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "飛往{area:3137}（聯盟）或{area:1237}（部落）。{npc:8395}在{npc:8379}的塔下紮營：從{area:1221}處{zone:1447}主要道路的岔路口，直直往北走到懸崖。他會把你傳送到大法師那裡。",
	-- ["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "克雷利安躲在{area:1221}中央最大的建築{area:1223}裡，在他的惡鞭守衛後方。他會掉落{item:23250}。",
	-- ["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}：{spell:118}（豬）",
}
