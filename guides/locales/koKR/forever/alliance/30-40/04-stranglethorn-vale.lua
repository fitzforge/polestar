-- Korean (koKR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "{area:150}에서 {area:1537}(으)로 날아가 기술을 배우세요.",

	-- Step 2: Druid training
	["Druid training"] = "드루이드 수련",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537}에는 드루이드 상급자가 없습니다. {object:171524}에서 {area:2257}을(를) 타고 {zone:1453}(으)로 가서 {npc:5504}에게 배우세요.",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge (no name in this language: may be words) · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "{area:42}(으)로 날아가세요: {area:1537} {object:32372}의 {npc:1573}, 또는 {zone:1453} {object:2096}의 {npc:352}.",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "{zone:1431}에서 길을 따라 남쪽으로 가시덤불 골짜기에 들어가세요. 사냥꾼들의 천막은 {area:99} 갈림길을 지나 길 바로 서쪽에 있습니다.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{zone:1441}에서 온 {npc:715}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "새끼 호랑이와 새끼 퓨마",
	["Both roam the grass around the camp and along the road north."] = "둘 다 야영지 주변 풀밭과 북쪽 길을 따라 돌아다닙니다.",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "{npc:682}",
	["The adult tigers prowl the hills just south and west of the camp."] = "다 자란 호랑이는 야영지 바로 남쪽과 서쪽 언덕을 어슬렁거립니다.",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "덩치큰 가시덤불 호랑이는 나중에 {area:99}에서 돌아오는 길에 잡습니다",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "길을 따라 북쪽으로 가세요. {npc:738}은(는) 길을 순찰하고, 야영지는 서쪽 언덕에 있습니다.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, 오두막 안",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "쿠르젠 반란군이 {area:99} 동쪽 야영지를 차지하고 있습니다. 쿠르젠 밀림전사와 쿠르젠 약사가 서 있는 바깥쪽부터 처리하고, 천막 옆 보급품 상자를 뒤지세요.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, {object:263} 상자에서",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "헤로드의 장부는 주둔지 서쪽 오두막에 있고, 그의 금고는 더 동쪽 동굴 입구 옆에 있습니다.",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "퓨마, 랩터, 덩치큰 호랑이",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "네싱워리를 지나 남쪽으로 돌아가세요. 퓨마와 {npc:685}은(는) 야영지 서쪽에서 해안 쪽 빈터를 뛰어다니고, 덩치큰 가시덤불 호랑이는 남서쪽 언덕을 차지하고 있습니다.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "야영지 서쪽 해안의 희귀 멀록 글루글이 {item:4614}을(를) 떨어뜨립니다. 만나면 챙기세요",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729}와(과) 채찍꼬리랩터",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "거대한 호랑이 {npc:729}은(는) 야영지 남서쪽 언덕 꼭대기에 살고, {npc:686}은(는) 그 남쪽, {area:35}(으)로 가는 길을 따라 뛰어다닙니다.",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "{area:35}(으)로 내려가기",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "큰길을 따라 밀림을 끝까지 남쪽으로 가서 {object:3202} 갈림길을 지나 남쪽 곶의 {area:35}에 도착하세요.",
	["Gyll, on the top floor by the docks"] = "가일, 부두 옆 꼭대기 층",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832}, {object:56910} 안",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495}, 은행 옆",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773}, 선술집 안",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, 선술집 안",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "북쪽으로 걸어 돌아가세요. {area:310}은(는) 밀림 한가운데, 길 서쪽에 있습니다. 그곳의 {npc:689}이(가) 파편을 떨어뜨립니다.",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "붉은머리부족 트롤",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "붉은머리부족 트롤은 네싱워리 야영지 서쪽 해안의 폐허를 차지하고 있습니다.",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: 사냥꾼 야영지를 둘러보기만 하세요",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "토르센은 야영지 북쪽, {area:99} 방향 길을 순찰합니다.",

	-- Step 21: River crocolisks
	["River crocolisks"] = "민물악어",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "{npc:1150}은(는) {area:99} 옆 강에서 헤엄칩니다.",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "{npc:1152}",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "{npc:1152}은(는) {area:35} 북쪽 해안을 따라 물가와 섬에서 햇볕을 쬡니다.",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, 선술집 위층",

	-- Step 25: The haunted island
	["The haunted island"] = "유령의 섬",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "서쪽 해안을 따라 북쪽으로 가세요. 유령의 섬은 네싱워리 야영지 서쪽 앞바다에 있습니다. 도착만 하면 됩니다.",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716}이(가) {item:2755}을(를) 모읍니다. 책장은 밀림의 거의 모든 인간형 몹이 떨어뜨립니다. 모이는 대로 책장을 장(章)으로 묶으세요.",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "쿠르젠 심리학자는 주둔지 더 안쪽에 서 있고, 쿠르젠 특전사는 은신한 채 주변과 동굴 안에 숨어 있습니다. 푸른 언덕 책장이 떨어지면 챙기세요.",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "밀림의 폐허",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "북쪽과 중앙의 트롤 폐허를 한 바퀴 도세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. {npc:684}은(는) 그 주변 밀림에서 은신한 채 어슬렁거리고, {area:37}의 투자개발회사 야영지가 {item:4106}을(를) 가지고 있습니다.",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: {area:35}의 {npc:773}에게",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "백골가루부족 트롤",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "백골가루부족 트롤은 네싱워리와 {object:3202} 사이 길 동쪽의 폐허를 차지하고 있습니다.",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "광석은 {zone:1417}의 마른수염 코볼트가 떨어뜨립니다",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "{zone:1416}의 대마법사 앤자이럼 룬위버에게",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "길을 따라 북쪽으로 가세요. {npc:738}은(는) 길 위에 서 있고, 야영지는 서쪽 언덕에 있습니다.",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, {object:56910} 안",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: 트롤 전설 4개",
}
