-- Korean (koKR): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "{spell:118}의 새 모습: 대상을 양 대신 돼지로 바꿉니다.",

	-- Step 1: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "{area:3137}(얼라이언스) 또는 {area:1237}(호드)(으)로 날아가십시오. {npc:8395}은(는) {npc:8379}의 탑 아래에서 야영합니다. {area:1221}에 있는 {zone:1447} 큰길의 갈림길에서 절벽까지 곧장 북쪽으로 가십시오. 그가 대마법사에게 순간이동시켜 줍니다.",

	-- Step 2: Warlord Krellian
	-- {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "크렐리안은 {area:1221} 한가운데 가장 큰 건물인 {area:1223}에서 원한의꼬리일족 경비병 뒤에 숨어 있습니다. {item:23250}을(를) 떨어뜨립니다.",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "{npc:8395}에게 돌아가 탑으로 올라가십시오.",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "변이된 복제생물",
	-- {item:23250} Prismatic Shell · {area:1221} Ruins of Eldarath
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "{item:23250}을(를) {area:1221}(으)로 다시 가져가세요. 원한의꼬리일족 나가에게 변이를 걸고 몇 초 기다리면 작은 변이된 복제생물로 갈라집니다. 복제생물을 빨리 처치하세요. 껍데기가 그 정수를 모읍니다.",

	-- Step 5: Fragmented Magic
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}: {spell:118}(돼지)",
}
