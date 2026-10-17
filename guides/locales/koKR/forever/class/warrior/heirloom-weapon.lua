-- Korean (koKR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "10레벨에 {spell:71}과(와) 원하는 한손 무기 하나.",

	-- Step 1: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}은(는) {area:159}에 있습니다. {npc:6390}은(는) 마을 바로 북쪽 언덕의 묘지에서 기다립니다. 문을 열고 그와 싸우십시오.",

	-- Step 2: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500}은(는) {area:159}의 여관인 {area:2119}에 있습니다.",

	-- Step 3: Agamand Mills
	-- {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "아가만드 무기 선반 네 개가 {area:159} 북쪽 {area:157}의 건물들 사이에 있습니다. 방앗간의 언데드는 보는 즉시 공격합니다.",

	-- Step 4: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "{npc:1500}에게 돌아가기",
}
