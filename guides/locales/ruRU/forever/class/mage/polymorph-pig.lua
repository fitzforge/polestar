-- Russian (ruRU): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "Новый вид заклинания «{spell:118}»: цель становится свиньей, а не овцой.",

	-- Step 1: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "Летите в {area:3137} (Альянс) или {area:1237} (Орда). {npc:8395} разбил лагерь под башней, где живет {npc:8379}: от развилки главной дороги зоны {zone:1447} у места {area:1221} идите прямо на север к скалам. Он телепортирует вас наверх к верховному магу.",

	-- Step 2: Warlord Krellian
	-- {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "Креллиан прячется за стражей из клана Бича Злобы здесь: {area:1223}, самое большое здание в центре места {area:1221}. С него падает {item:23250}.",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Вернитесь: {npc:8395}, затем наверх в башню.",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "Клонированные овцы",
	-- {item:23250} Prismatic Shell · {area:1221} Ruins of Eldarath
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "Отнесите {item:23250} обратно сюда: {area:1221}. Примените «Превращение» на нагу из клана Бича Злобы и подождите несколько секунд: она распадется на маленьких клонированных овец. Быстро убейте клонов; раковина соберет их сущность.",

	-- Step 5: Fragmented Magic
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}: {spell:118} (свинья)",
}
