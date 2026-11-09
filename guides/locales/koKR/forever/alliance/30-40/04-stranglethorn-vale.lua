-- Korean (koKR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 3: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "{zone:1431}에서 길을 따라 남쪽으로 가시덤불 골짜기에 들어가세요. 사냥꾼들의 천막은 {area:99} 갈림길을 지나 길 바로 서쪽에 있습니다.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{zone:1441}에서 온 {npc:715}",

	-- Step 4: Young tigers and panthers
	["Young tigers and panthers"] = "새끼 호랑이와 새끼 퓨마",
	["Both roam the grass around the camp and along the road north."] = "둘 다 야영지 주변 풀밭과 북쪽 길을 따라 돌아다닙니다.",

	-- Step 8: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "{npc:682}",
	["The adult tigers prowl the hills just south and west of the camp."] = "다 자란 호랑이는 야영지 바로 남쪽과 서쪽 언덕을 어슬렁거립니다.",

	-- Step 9: Level 33.2
	["Level 33.2"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:682} Stranglethorn Tiger
	["grind on {npc:682}"] = "",

	-- Step 10: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "덩치큰 가시덤불 호랑이는 나중에 {area:99}에서 돌아오는 길에 잡습니다",

	-- Step 11: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "퓨마, 랩터, 덩치큰 호랑이",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "네싱워리를 지나 남쪽으로 돌아가세요. 퓨마와 {npc:685}은(는) 야영지 서쪽에서 해안 쪽 빈터를 뛰어다니고, 덩치큰 가시덤불 호랑이는 남서쪽 언덕을 차지하고 있습니다.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "야영지 서쪽 해안의 희귀 멀록 글루글이 {item:4614}을(를) 떨어뜨립니다. 만나면 챙기세요",

	-- Step 12: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, 오두막 안",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "",

	-- Step 14: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side."] = "",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, {object:263} 상자에서",

	-- Step 15: Level 33.6
	["Level 33.6"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "",

	-- Step 17: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 18: Level 34
	["Level 34"] = "",
	-- {area:796} Scarlet Monastery
	["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716}이(가) {item:2755}을(를) 모읍니다. 책장은 밀림의 거의 모든 인간형 몹이 떨어뜨립니다. 모이는 대로 책장을 장(章)으로 묶으세요.",

	-- Step 20: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729}와(과) 채찍꼬리랩터",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "거대한 호랑이 {npc:729}은(는) 야영지 남서쪽 언덕 꼭대기에 살고, {npc:686}은(는) 그 남쪽, {area:35}(으)로 가는 길을 따라 뛰어다닙니다.",

	-- Step 21: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "{area:35}(으)로 내려가기",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "큰길을 따라 밀림을 끝까지 남쪽으로 가서 {object:3202} 갈림길을 지나 남쪽 곶의 {area:35}에 도착하세요.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, 선술집 안",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, 선술집 위층",

	-- Step 22: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {zone:1436} Westfall · {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "",
	["The haunted island"] = "유령의 섬",

	-- Step 25: River crocolisks
	["River crocolisks"] = "민물악어",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "{npc:1150}은(는) {area:99} 옆 강에서 헤엄칩니다.",

	-- Step 26: Private Thorsen
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",

	-- Step 27: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: 사냥꾼 야영지를 둘러보기만 하세요",

	-- Step 28: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "",

	-- Step 29: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}로 비행",

	-- Step 31: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "",

	-- Step 32: Druid training
	["Druid training"] = "드루이드 수련",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{npc:5504}, the druid trainer, stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 35: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, {area:413} 북쪽",

	-- Step 36: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "붉은머리부족 트롤",
	-- ["Fly from {area:150} to {area:1537} and train."] = "{area:150}에서 {area:1537}(으)로 날아가 기술을 배우세요.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "{area:42}(으)로 날아가세요: {area:1537} {object:32372}의 {npc:1573}, 또는 {zone:1453} {object:2096}의 {npc:352}.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "서쪽 해안을 따라 북쪽으로 가세요. 유령의 섬은 네싱워리 야영지 서쪽 앞바다에 있습니다. 도착만 하면 됩니다.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "{zone:1416}의 대마법사 앤자이럼 룬위버에게",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "쿠르젠 심리학자는 주둔지 더 안쪽에 서 있고, 쿠르젠 특전사는 은신한 채 주변과 동굴 안에 숨어 있습니다. 푸른 언덕 책장이 떨어지면 챙기세요.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "헤로드의 장부는 주둔지 서쪽 오두막에 있고, 그의 금고는 더 동쪽 동굴 입구 옆에 있습니다.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "북쪽과 중앙의 트롤 폐허를 한 바퀴 도세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. {npc:684}은(는) 그 주변 밀림에서 은신한 채 어슬렁거리고, {area:37}의 투자개발회사 야영지가 {item:4106}을(를) 가지고 있습니다.",
	-- ["Skullsplitter trolls"] = "백골가루부족 트롤",
	-- ["Snapjaw Crocolisks"] = "{npc:1152}",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "{npc:1152}은(는) {area:35} 북쪽 해안을 따라 물가와 섬에서 햇볕을 쬡니다.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "길을 따라 북쪽으로 가세요. {npc:738}은(는) 길을 순찰하고, 야영지는 서쪽 언덕에 있습니다.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "길을 따라 북쪽으로 가세요. {npc:738}은(는) 길 위에 서 있고, 야영지는 서쪽 언덕에 있습니다.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "붉은머리부족 트롤은 네싱워리 야영지 서쪽 해안의 폐허를 차지하고 있습니다.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "쿠르젠 반란군이 {area:99} 동쪽 야영지를 차지하고 있습니다. 쿠르젠 밀림전사와 쿠르젠 약사가 서 있는 바깥쪽부터 처리하고, 천막 옆 보급품 상자를 뒤지세요.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "백골가루부족 트롤은 네싱워리와 {object:3202} 사이 길 동쪽의 폐허를 차지하고 있습니다.",
	-- ["The jungle ruins"] = "밀림의 폐허",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "광석은 {zone:1417}의 마른수염 코볼트가 떨어뜨립니다",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "토르센은 야영지 북쪽, {area:99} 방향 길을 순찰합니다.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "북쪽으로 걸어 돌아가세요. {area:310}은(는) 밀림 한가운데, 길 서쪽에 있습니다. 그곳의 {npc:689}이(가) 파편을 떨어뜨립니다.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537}에는 드루이드 상급자가 없습니다. {object:171524}에서 {area:2257}을(를) 타고 {zone:1453}(으)로 가서 {npc:5504}에게 배우세요.",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, 은행 옆",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, {object:56910} 안",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, 부두 옆 꼭대기 층",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: {area:35}의 {npc:773}에게",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, 선술집 안",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: 트롤 전설 4개",
}
