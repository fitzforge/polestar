-- Korean (koKR): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",
	-- {zone:1458} Undercity · {object:3202} Grom'gol
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "승강기를 타고 {zone:1458}을(를) 나가 폐허를 지나 비행선 탑으로 올라가세요. {object:3202}행 비행선은 남서쪽 탑에 있습니다.",
	["Zeppelin towers"] = "비행선 탑",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "비행선은 주둔지 서쪽의 탑에 도착합니다.",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "{object:3202} 서쪽 탑에서 {zone:1454}행 비행선을 타고, 다시 날아가기 전에 도시에서 기술을 배우세요.",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "{object:3202} 서쪽 탑에서 {zone:1454}행 비행선을 타고 {area:392}(으)로 날아가세요. {npc:5901}은(는) 그 남쪽으로 조금 떨어진 해안에 야영하고 있습니다.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527}와(과) {item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "{object:3202}(으)로 돌아가기",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "네싱워리의 야영지",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "길을 따라 {object:3202}에서 북쪽으로 나가세요. 네싱워리의 사냥 야영지는 강 북동쪽 언덕에 있습니다. 지금부터 얻는 {quest:338}의 모든 쪽은 보관하세요. 나중에 {npc:716}이(가) 요구합니다.",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "새끼 호랑이와 퓨마",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "새끼 가시덤불 호랑이는 야영지 서쪽에, 새끼 퓨마는 남쪽과 동쪽에 돌아다닙니다.",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "호랑이와 퓨마",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "가시덤불 호랑이와 퓨마(32-33)는 야영지 동쪽, 호숫가를 따라 언덕을 돌아다닙니다.",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "랩터와 붉은머리부족 트롤",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "야영지를 지나 서쪽으로 가세요. 가시덤불랩터(33-34)는 빈터에서 사냥하고, 붉은머리부족 트롤은 해안의 폐허를 차지하고 있습니다. 붉은머리부족은 누구나 붉은머리부족의 어금니를 떨어뜨릴 수 있습니다. 이들은 {item:4614}을(를) 매우 드물게 떨어뜨립니다. 얻으면 읽으세요.",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "덩치큰 호랑이와 채찍꼬리랩터",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "덩치큰 가시덤불 호랑이(34-35)는 야영지 남서쪽 언덕을 돌아다니고, 채찍꼬리랩터(35-36)는 더 남쪽, {object:3202} 쪽에서 사냥합니다.",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol
	["Follow the road south to {object:3202}."] = "길을 따라 남쪽의 {object:3202}(으)로 가세요.",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "북쪽의 야영지로 돌아가세요.",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "레벨 37 호랑이 {npc:729}은(는) 야영지 남서쪽 언덕 꼭대기를 돌아다닙니다.",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "붉은머리부족 인간사냥꾼",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "해안 마을의 붉은머리부족 인간사냥꾼(36-37)이 쭈그러든 해골을 지니고 있습니다.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol
	["Hearth to {object:3202}"] = "귀환석으로 {object:3202}에 가기",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "길을 따라 골짜기 남쪽 끝의 {area:35}(으)로 가서 절벽의 터널로 들어가세요. 길에서 벗어나지 마세요. 길 옆 정글은 레벨이 훨씬 높습니다. 호드 비행 조련사 {npc:2858}은(는) 위층 갑판에 있습니다.",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",

	-- Step 21: The camp by the river
	["The camp by the river"] = "강가의 야영지",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}의 실종된 사냥꾼들의 야영지는 네싱워리의 야영지입니다. 천막 사이를 걸으면 조사가 완료됩니다. 민물악어는 야영지 아래 강을 따라 있습니다.",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "바실리스크와 붉은머리부족 마을",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "야영지를 지나 서쪽 바위 위에 수정가시 바실리스크(34-35)가 있습니다. 그 너머 마을의 붉은머리부족은 누구나 붉은머리부족의 귀를 떨어뜨릴 수 있습니다.",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "해안을 따라 남쪽의 {object:3202}(으)로 간 뒤 {area:35}(으)로 날아가세요.",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: 경로 후반의 아라시 고원용",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "채찍꼬리랩터",
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "채찍꼬리랩터(35-36)는 {object:3202} 바로 북동쪽 정글에서 사냥합니다.",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "모쉬오그일족 야영지",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "모쉬오그일족 오우거는 {object:3202} 바로 동쪽 언덕에 야영하고 있습니다. 모쉬오그일족 투사와 모쉬오그일족 의술사(36-37)를 하나씩 처치하세요. 한 마리씩 끌어오세요.",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "그림자퓨마 정글과 무쇠턱 악어 강",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "오우거 동쪽에서는 그림자퓨마(37-38)가 공격할 때까지 보이지 않게 숨어 다닙니다. 가시덤불 암호랑이도 같은 곳을 돌아다니며 가끔 온전한 암호랑이의 송곳니를 떨어뜨립니다. 무쇠턱 악어는 정글 바로 서쪽 강을 따라 있습니다. 가죽은 {npc:2495}에게 줄 수 있도록 보관하세요.",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "{object:3202}(으)로 돌아가세요.",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "그롬골 북서쪽 해안 앞바다 물속에 {area:104}이(가) 있습니다. {item:4094}은(는) 가라앉은 폐허 옆 바닥에 있습니다. 숨과 멀록을 조심하세요.",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "붉은머리부족 폐허",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "붉은머리부족 트롤은 암초 북쪽 해안의 폐허와 그 너머 마을을 차지하고 있으며, 누구나 {item:3915}을(를) 떨어뜨릴 수 있습니다. {quest:338}의 쪽도 계속 챙기세요.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol
	["Ride back south to {object:3202}."] = "남쪽의 {object:3202}(으)로 돌아가세요.",

	-- Step 33: Nesingwary's camp
	["Follow the road north to the camp."] = "길을 따라 북쪽의 야영지로 가세요.",

	-- Step 34: Green Hills pages
	["Green Hills pages"] = "푸른 언덕의 쪽",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}의 쪽은 붉은머리부족과 백골가루부족 트롤에게서 각각 약 1% 확률로 떨어집니다. 얻은 쪽은 모두 보관하고 나머지는 경매장에서 찾아보세요. {npc:716}은(는) 이 가이드 후반에 장을 받습니다.",

	-- Step 35: Shadowmaw panthers
	["Shadowmaw panthers"] = "그림자퓨마",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "그림자퓨마(37-38)는 모쉬오그일족 언덕 동쪽과 북동쪽 호수 방향 정글에 숨어 다니며, 은신 상태에서 공격합니다. 가는 길에 보이는 푸른 언덕의 쪽은 모두 챙기세요.",

	-- Step 36: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "{item:2755}의 쪽은 붉은머리부족과 백골가루부족 트롤에게서 각각 약 1% 확률로 떨어집니다. 떨어지는 것은 챙기고 나머지는 경매장에서 확인하세요.",

	-- Step 39: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "줄무늬정글랩터",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "줄무늬정글랩터(40-41)는 {object:3202} 남쪽 해안에서 사냥합니다. 레벨이 훨씬 높으니 한 마리씩 끌어오고 전투 사이에 쉬세요.",

	-- Step 41: Mistvale gorillas
	["Mistvale gorillas"] = "안개계곡고릴라",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "길을 따라 남쪽 {area:35} 방향으로 가세요. 덩치큰 안개계곡고릴라(40-41)는 길 동쪽의 {area:1737}에 살며, 약 20마리 중 1마리가 덩치큰 고릴라의 힘줄을 지니고 있습니다.",

	-- Step 42: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "길을 따라 계속 남쪽의 {area:35}(으)로 가세요.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: 앞서 모은 무쇠턱 악어 가죽",

	-- Step 44: Venture Co. camp
	["Venture Co. camp"] = "투자개발회사 야영지",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "네싱워리의 야영지를 지나 북쪽 호수로 가세요. 투자개발회사 지질학자(34-36)가 서쪽 호숫가의 야영지에서 일하며, 연마된 수정을 지니고 있습니다.",

	-- Step 45: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "귀환석으로 {area:35}에 가기",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "다음 가이드에서는 북쪽의 {area:272}(으)로 날아가 {zone:1417}(으)로 갑니다.",
}
