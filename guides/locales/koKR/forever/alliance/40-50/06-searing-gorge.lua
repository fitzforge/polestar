-- Korean (koKR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: 이전 가이드가 귀환석으로 이곳에 데려오므로 보통 바로 완료됩니다",

	-- Step 2: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "{area:144}에서 남쪽 {zone:1418}(으)로 간 다음, 서쪽으로 호드 마을 {area:340}을(를) 지나(거리를 두십시오) 오솔길을 따라 {zone:1427}(으)로 올라가십시오. {area:1446}은(는) 북서쪽 가장자리의 비계가 세워진 야영지입니다.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827} 게시판",

	-- Step 3: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "나이트 엘프 잠마엘 룬시슬이 {area:1446} 서쪽에 홀로 서 있습니다. 그의 이야기를 들으십시오.",

	-- Step 4: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "칼라란 윈드블레이드는 {area:1446} 남쪽, 용광로 가장자리에 서 있습니다. 그의 이야기를 들으십시오.",

	-- Step 5: Golems and elementals
	["Golems and elementals"] = "골렘과 정령",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "칼라란 아래 용광로 바닥을 육중한 전투골렘이 순찰하고, 그 사이를 용암 정령이 떠다닙니다. 골렘 기름은 골렘과 정령이, 화염의 심장은 정령이 떨어뜨립니다.",

	-- Step 7: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "{object:147516} 드워프",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "검은무쇠단 감독관과 검은무쇠단 노예상인이 용광로 곳곳에서 노예를 부리며, 누구든 {item:10551}을(를) 지니고 있을 수 있습니다. 검은무쇠단 증기기술자는 한가운데 용광로에서 일하고({item:18959}), 검은무쇠단 망꾼은 남쪽 능선에 서 있습니다(감시병의 망원경). {object:147516} 누구든 {item:11818}을(를) 떨어뜨릴 수 있으니 간직하십시오.",

	-- Step 8: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "거대한 용암거미",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "거미는 협곡 남서쪽의 고원과 용암 웅덩이를 돌아다닙니다.",

	-- Step 10: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443}은(는) 용광로 북쪽에 입구가 있습니다. 비밀조제법: 불꽃 융해촉진제는 위쪽 바위 턱에 있습니다. 더 안쪽 용암 웅덩이에서 인센도사우루스가 헤엄치니 가장자리로 끌어내십시오. 깊숙한 곳의 {npc:14621}와(과) 그의 정예 경비병은 피하십시오.",

	-- Step 12: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "검댕가루 간이화장실",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "용광로를 가로질러 동쪽으로, 남동쪽의 {area:247}까지 가세요. 나무 변소 안의 죄수가 {item:4306} 15개와 그 주변 발굴지의 {npc:5839} 8마리 처치를 원합니다. 열쇠를 찾았다면 변소를 열쇠로 열 수도 있습니다.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "포로의 다음 임무인 {zone:1446}의 장부는 {zone:1435}와(과) {zone:1445}(으)로 보냅니다: 건너뛰십시오.",

	-- Step 13: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "드워프 도리우스 스톤텐더는 발굴현장의 길가에 서 있습니다. 그를 따라 길을 북쪽으로 가며 {object:147516}의 매복을 물리치십시오. 끝나면 {area:1959}의 길에 그가 남긴 {object:175704}을(를) 읽으십시오.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "나중에 {zone:1455}의 {npc:8256}에게",
}
