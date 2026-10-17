-- Korean (koKR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}와(과) {npc:821}은(는) 돌탑 꼭대기에 있습니다. {npc:491}은(는) 탑 안에, {npc:878}와(과) {npc:253092}은(는) 언덕 남쪽의 여관과 그리폰 조련사 {npc:523} 옆에 있습니다.",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; 제공되는 무료 비행은 건너뛰십시오",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "길을 따라 북쪽으로 가십시오. {npc:233}은(는) 밖에, {npc:235}은(는) 집 안에, {npc:253395}은(는) 서쪽 헛간에 있습니다.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "길을 따라 더 북쪽으로 가십시오. 펄브로우 부부가 불탄 농장 옆에 앉아 있습니다. 가는 길에 밭의 귀리 부대에서 귀리를 모으고, 농장 우물에서 약병을 채우십시오.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "엘윈 숲에서 {item:1972}을(를) 획득한 경우에만: 오른쪽 클릭하십시오",
	["Fill the vial at the well"] = "우물에서 약병 채우기",
	["Sacks of Oats"] = "귀리 부대",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "새끼 뿔엄니멧돼지와 식인독수리가 농장 주변 밭을 돌아다닙니다. 돌아가는 길에 간과 스튜용 고기를 모으기 시작하십시오.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "살딘 농장 서쪽입니다. 허수아비골렘 보초와 허수아비골렘이 밭에서 일하며, 골렘 등가용수철, 허수아비골렘 회전안정기, {item:732}, 가끔 {item:255155}을(를) 떨어뜨립니다. 20레벨 희귀 몹 {npc:573}이(가) 이곳을 돌아다니니 건드리지 마십시오. 이 경로의 모든 구간에서 뿔엄니멧돼지와 식인독수리를 계속 처치하십시오.",
	["Fill the vial at the farm's well"] = "농장 우물에서 약병 채우기",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "허수아비골렘 보초",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: 식인독수리",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "몰센 농장 서쪽, 해안 방향입니다. 갈퀴발일족 광부가 채석장에서 일합니다.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "갈퀴발일족 광부",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "몰센 농장 북쪽입니다. 데피아즈단 덫사냥꾼과 데피아즈단 밀수업자가 광산 밖에 진을 치고, 코볼트 채굴꾼이 안에서 일합니다. {object:290}은(는) 광산 동쪽의 폐가 옆에 있습니다.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "코볼트 채굴꾼",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: 모든 데피아즈단이 떨어뜨립니다",

	-- Step 8: The north coast
	["The north coast"] = "북쪽 해안",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "멀록 길잡이와 멀록 약탈꾼이 광산 북쪽 해변에 늘어서 있습니다. 생명력이 낮으면 도망치니 하나씩 끌어오십시오.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "기나긴 해안 멀록 아가미",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "놀 언덕",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "갈퀴발 놀과 갈퀴발일족 정찰병이 해안과 {area:916} 사이 언덕을 돌아다닙니다.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "놀의 앞발",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "그가 골렘 등가용수철만 받을 때만",

	-- Step 13: The western farms
	["The western farms"] = "서쪽 농장들",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "데피아즈단 강탈자와 데피아즈단 약탈자가 해안 도로와 {area:20} 사이, {area:108} 서쪽 농장들을 차지하고 있습니다.",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}와(과) 데피아즈단 언덕",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "데피아즈단 정찰병과 데피아즈단 복면강도가 {area:20}을(를) 돌아다니고, 데피아즈단 노상강도(17레벨)가 남쪽과 동쪽 언덕을 둘씩 순찰합니다. 떼어서 상대하십시오. 대장간 안의 {area:1581} 입구는 파티 던전입니다.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, {area:20} 주변 상자에서",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "{area:108}(으)로 돌아가기",
	["Hearthstone on cooldown? Follow the road north-east."] = "귀환석이 재사용 대기 중이라면 북동쪽 길을 따라가십시오.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "붉은마루 산맥 {area:69}의 {npc:266}에게",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "{zone:1453} {object:28027}의 {npc:11026}에게",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{zone:1453}(으)로 비행하거나 이동하십시오. {npc:5480}은(는) {object:2100}에서 전사를 가르치며, {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 있습니다. {npc:6090}이(가) 자기 잔을 걸고 결투를 합니다.",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "{zone:1453}(으)로 비행하거나 이동하십시오. {npc:376}은(는) 빛의 대성당에 있습니다.",

	-- Step 19: Shaman training
	["Shaman training"] = "주술사 수련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "{zone:1453}(으)로 가십시오. 주술사 상급자가 없으니 {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 수련한 뒤, 전차를 타고 돌아와 배를 타십시오.",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "{zone:1453}(으)로 날아가거나 말을 타고 가세요. 상급자: {object:2100}(전사, 도적), 대성당(성기사, 사제), {object:2101}(마법사, 흑마법사), 공원(드루이드). {npc:11026}은(는) {object:28027}에서, {npc:279}은(는) {object:2096}에서 일합니다.",
	["Level 12, 14 and 16 spells"] = "12, 14, 16레벨 주문",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{zone:1439}의 약재 모으기(6123)에 필요한 {item:2449}: {npc:1313}, 연금술 용품. 약초채집가는 대신 그곳에서 채집하세요",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, 마법사의 성소: {quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}은(는) {object:2096} 바로 서쪽 운하를 따라 낚시 용품을 판매합니다. {npc:267118}은(는) 배로 가는 길의 항구에서 낚시를 합니다.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, {npc:5494}에게서",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "갈퀴발 놀과 갈퀴발일족 정찰병이 해안과 {area:916} 사이 언덕을 돌아다닙니다.",
}
