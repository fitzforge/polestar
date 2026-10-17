-- Korean (koKR): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "Forever에서는 더 이상 {spell:8946}을(를) 수련할 수 없습니다: 이 연계 퀘스트가 가르쳐 주며, 도중에 약초 가방도 얻습니다.",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}은(는) {area:1658}에 있습니다.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 그런 다음 {area:442}(으)로 날아가세요.",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "{area:442}에서 북동쪽으로 {area:445}까지 달려가, 폭포 옆 동굴 입구에서 {item:15844}을(를) 채우십시오.",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "{area:442}(으)로 돌아가십시오.",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}와(과) {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "{object:177750}은(는) {area:442} 바로 동쪽 언덕의 달빛야수 동굴에 자랍니다. 그곳 달빛야수는 공격적입니다. {item:2449}에는 {skill:182}이(가) 필요합니다. 약초채집가는 {zone:1439} 곳곳에서 채집하고, 그 외에는 {zone:1453}의 {npc:1313}(연금술 용품)이나 경매장에서 사세요.",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "{npc:12298}에게 {item:15826}을(를) 사용하십시오. 북쪽 {area:456}에서 남쪽 {zone:1440} 경계까지 {zone:1439}을(를) 돌아다닙니다.",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298}: 연고를 사용하십시오",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "{spell:18960}을(를) 시전해 {npc:11802}을(를) 만난 뒤, {area:702}(으)로 날아가 차원문을 타고 {zone:1457}(으)로 올라가세요.",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}은(는) {area:1639}에 있습니다.",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {npc:11798}이(가) 드루이드를 {area:1638}(으)로 태워 줍니다. 그곳에서 {area:380}(으)로 날아가세요.",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words)
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "{area:380}에서 북쪽으로 {area:384}까지 달려가 {object:19464}에서 {item:15842}을(를) 채우십시오.",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448}은(는) {area:380}에 있습니다. {skill:182}이(가) 없다면 몇 걸음 떨어진 {npc:3490}이(가) {item:2449}을(를) 팝니다. 재입고될 때까지 한 번에 세 개씩입니다.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}. 약초채집가는 평원에서 캘 수 있습니다",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449}와(과) 코도 뿔",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "{npc:3234}은(는) {area:380}의 북쪽과 서쪽 평원, 그리고 {area:388} 주변을 돌아다니며, 각각 뿔을 하나씩 떨어뜨립니다. 약초채집가는 {zone:1413} 북부 곳곳에서 {item:2449}을(를) 찾을 수 있습니다.",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "병든 가젤",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "병든 가젤에게 {item:15826}을(를) 사용하십시오: {area:380}을(를) 동서로 가로지르는 길 북쪽에서 풀을 뜯고 있습니다.",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296}: 연고를 사용하십시오",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "{spell:18960}을(를) 시전해 {npc:11802}을(를) 만난 뒤, {npc:11798}의 비행편으로 {area:1638}에 가세요.",
}
