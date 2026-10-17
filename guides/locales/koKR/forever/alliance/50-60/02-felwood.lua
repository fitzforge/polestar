-- Korean (koKR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "{area:702}에서 배를 타고 {area:442}(으)로 간 뒤 {area:415}(으)로 날아가세요.",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{area:415}에서 북쪽으로 {zone:1448}에 들어가세요. 펄볼그 {npc:11554}은(는) {area:2479} 바로 남쪽 길가에 서 있습니다.",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "마른가지일족 펄볼그는 {npc:11554} 바로 남서쪽 마을에 삽니다. 그들이 떨어뜨리는 {item:21377}은(는) 보관하세요.",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395}은(는) {zone:1448} 북쪽 끝에서 기다립니다",
	["Five feathers buy a little Timbermaw reputation"] = "깃털 5개로 나무구렁 요새 평판을 조금 얻습니다",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, {npc:11554} 바로 동쪽 폐허",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "비취불꽃의 사티로스가 길 서쪽 숲을 차지하고 있으며, {npc:9454}은(는) 그 안쪽에 있습니다.",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763}은(는) 숲 북쪽의 폐허가 된 사원입니다. 일부 이교도가 약 30마리에 한 번꼴로 {item:13140}을(를) 떨어뜨립니다. 이 열쇠로 안쪽 동굴인 {area:1770}의 {npc:11018} 감옥을 엽니다. 열쇠가 나오면 그녀를 풀어 주기 전에 나가는 길을 정리하고, 안 나오면 그녀의 퀘스트는 건너뛰세요.",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}, 드물게 획득",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016}, {area:1770} 안",
	["Keep her alive until she is out of the cave"] = "동굴을 나갈 때까지 그녀를 살려 두세요",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "다시 {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "{area:1763} 한가운데의 타락한 달샘에서 {item:12922}을(를) 사용하세요. {npc:11018}을(를) 풀어 주었다면 {area:1770}에 다시 들어가 서큐버스 {npc:9518}을(를) 처치하세요. 트레이 라이트포지의 유해가 그녀 옆에 있습니다.",

	-- Step 10: Oozes
	["Oozes"] = "수액괴물",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "저주받은 수액괴물과 {npc:7092}이(가) {area:1763}와(과) {area:1765} 주변의 개울과 지옥 웅덩이를 미끄러져 다닙니다. 처치한 뒤 라리스의 빈 수액괴물 단지를 그 잔해에 사용하세요.",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "길을 따라 북쪽의 구덩이 파인 골짜기로 가서 구덩이마다 들르며, 그 사이의 {npc:9878}와(과) 혼돈의 소산물을 처치하세요.",
	["First crater"] = "첫 번째 구덩이",
	["Second crater"] = "두 번째 구덩이",
	["Third crater"] = "세 번째 구덩이",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618}은(는) 북서쪽의 사티로스 골짜기이며, 맨 끝에 {npc:10648}이(가) 있습니다. 그가 {quest:939}을(를) 떨어뜨리고, 비취불꽃의 사티로스는 누구나 {item:11674}을(를) 떨어뜨릴 수 있습니다.",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{area:2618} 동쪽 {area:1767}의 굽이나무정령이 {item:11503}을(를) 가지고 있습니다.",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "동쪽으로 {area:1998}의 나이트 엘프 야영지로 가세요.",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "길을 따라 북쪽으로 {area:1769}의 동굴 입구까지 가세요. {npc:15395}이(가) 입구를 지킵니다.",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "{area:1762}의 마른가지일족 펄볼그가 동굴 서쪽 언덕을 채우고 있습니다. 마른가지일족 복수자가 {quest:8470}을(를) 떨어뜨릴 수 있습니다.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, 드물게 획득",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "살파는 터널의 {zone:1452} 쪽 끝에 서 있습니다: 보관하세요",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "동굴에 들어가세요. {npc:11558}와(과) {npc:11557}이(가) 바로 안쪽에 서 있습니다.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: 나무구렁 요새는 중립부터 대화해 줍니다",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: {quest:6031} 30장, 57레벨에 다시 지나갈 때 제출",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "{area:1998}에서 길의 성소 쪽 끝으로 날아가거나, 길을 따라 남쪽으로 가세요.",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "유리병은 {zone:1457}에서 채웁니다: 보관하세요",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "{zone:1413}에서 끝납니다: 보관하세요",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "북쪽으로 {area:1769}까지 가서(또는 먼저 {area:1998}(으)로 날아가서) 터널을 지나 {zone:1452}에 들어가세요. 길을 따라 동쪽으로 고블린 마을 {area:2255}까지 가세요.",
}
