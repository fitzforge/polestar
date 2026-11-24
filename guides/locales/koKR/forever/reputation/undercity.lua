-- Korean (koKR): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "언더시티 평판",
	-- {item:14047} Runecloth
	["Tirisfal quests while you level, the Plaguelands quests from 55, then {item:14047} to Exalted."] = "레벨을 올리며 티리스팔 퀘스트, 55부터 역병지대 퀘스트, 그다음 {item:14047}로 확고한 동맹까지.",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "{faction:68}과(와) 확고한 동맹",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68}: 작동 방식",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:287} Hillsbrad · {area:272} Tarren Mill · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "{faction:68} 평판은 퀘스트와 옷감에서 옵니다. 옷감 병참장교 {npc:14729}는 재단사 옆 {object:36082}에 서 있습니다. 그는 옷감 60개 기부 넷(각 150)을 받고, 이어서 {quest:7819}, {item:14047} 20개당 50을 제한 없이 받습니다. {faction:68}에서 얻는 포인트마다 {zone:1454}, {zone:1456}, 다크스펠 트롤에게 4분의 1을 더 줍니다. 레벨을 올리며 자신과 5레벨 차 안의 {faction:68} 퀘스트를 하세요: 티리스팔 1~12, 은빛소나무 숲 10~20, {area:287}과(와) {area:272} 20~33. 유산 특성 외교관이 최대 10%를 더합니다. 보상: 우호적이면 {faction:68} 상인이 10% 할인해 주고(고전 규칙) 말 상인도 포함되며, 확고한 동맹이면 다른 종족도 해골 말을 삽니다. 40레벨 말 20골, 60레벨 전쟁마 200골로 탈것 훈련을 마친 뒤입니다. {object:1661}에게는 문장이나 다른 보상이 없습니다.",
	["his donations are handed in from his window and never enter the log"] = "그에게 하는 기부는 대화창에서 바로 제출하며 퀘스트 목록에 들어가지 않습니다",

	-- Step 2: Deathknell (optional hub)
	-- {area:154} Deathknell
	["{area:154} (optional hub)"] = "{area:154} (선택 허브)",
	-- {area:154} Deathknell · {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["Forever pays these old quests in full at any level. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 티리스팔 서쪽 끝에 있는 망자의 시작 지역 {area:154}: 25분에 약 900 {faction:68} 평판. 시작 지역 퀘스트는 다른 도시에 몫을 주지 않습니다. {npc:1661}, {npc:1570}, {npc:1740}이(가) 마을에 서 있습니다.",

	-- Step 3: Deathknell: the next quests
	-- {area:154} Deathknell
	["{area:154}: the next quests"] = "{area:154}: 다음 퀘스트",

	-- Step 4: Around Deathknell
	-- {area:154} Deathknell
	["Around {area:154}"] = "{area:154} 주변",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "{object:164662}은(는) 마을 주변에 모두 있습니다. {quest:380}은(는) 북서쪽 광산에 있고 {npc:271961}이(가) 안에 매달려 있습니다. {npc:1919}은(는) 북동쪽 도로 옆 폐허 야영지에서 기다립니다. 그의 유해를 마을 묘지 앞줄 {object:178090}에 묻어 주세요.",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "{npc:271961} 해방",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "{object:178090}, {item:16333}와 함께",

	-- Step 5: Deathknell: hand in
	-- {area:154} Deathknell
	["{area:154}: hand in"] = "{area:154}: 반납",

	-- Step 6: The Scarlet camp
	["The Scarlet camp"] = "붉은십자군 야영지",
	-- {area:154} Deathknell · {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "붉은십자군 야영지는 {area:154} 남동쪽에 있습니다. {npc:1667}이(가) 이끕니다.",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}, {npc:1667}에게서",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand · {area:159} Brill
	["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}, +75: {area:159}의 {npc:1515}에게",

	-- Step 8: Brill (optional hub)
	-- {area:159} Brill
	["{area:159} (optional hub)"] = "{area:159} (선택 허브)",
	-- {area:159} Brill · {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["Forever pays these old quests in full at any level. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. {area:159}와(과) 주변 들판: 45분에 약 1,100 {faction:68} 평판. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496}, {npc:1500}이(가) 마을에 있습니다.",

	-- Step 9: Around Brill
	-- {area:159} Brill
	["Around {area:159}"] = "{area:159} 주변",
	-- {item:286176} Executor's Motivator · {area:159} Brill · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "{area:159} 주변의 죽음경비병 다섯에게 {item:286176}을(를) 사용하세요. {quest:99141}을(를) 위해 {area:159} 서쪽의 {npc:1496}, 동쪽 여관 지소의 {npc:251001}, 그리고 도로 위의 {npc:10666}과(와) 말을 거세요. 썩은가죽 그놀이 {area:159} 북쪽 공동묘지에서 땅을 팝니다. {npc:1525}가 {area:159} 서쪽 낡은 다리 주변을 거니는데, 마른 가지가 그곳 나무 아래에 있습니다. 어둠개가 어디나 떠돕니다.",
	-- {area:159} Brill
	["Motivate 5 Deathguards: the Deathguards around {area:159}"] = "죽음의경비병 5명 독려: {area:159} 주변의 죽음의경비병",

	-- Step 10: Agamand Mills
	-- {npc:1657} Devlin Agamand · {area:157} Agamand Mills
	["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657}이(가) {area:157}(으)로 가는 도로를 거니고, 니사는 첫 집 위층에서, 그레고르와 서먼은 더 안쪽 방앗간에서 기다립니다.",

	-- Step 11: Brill: hand in
	-- {area:159} Brill
	["{area:159}: hand in"] = "{area:159}: 반납",

	-- Step 12: Agamand Mills again
	-- {area:157} Agamand Mills
	["{area:157} again"] = "다시 {area:157}",
	-- {area:157} Agamand Mills
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "{area:157}의 해골이 갈비뼈를 떨어뜨리고, 검은눈 해골마법사가 두개골을 떨어뜨립니다.",

	-- Step 13: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "여기부터는 옷감입니다. 양모, 비단, 마법천은 {npc:14729}가 {item:14047} 기부를 제공하기 전에 모두 반납해야 하고, {quest:7819}은(는) {item:14047} 기부가 필요합니다. 경매장에서 옷감을 사거나 직접 모으세요. 인간형이 떨어뜨리는데 양모는 15~25레벨, 비단은 25~40, 마법천은 40~50, {item:14047}은(는) 50 이상입니다. 60이면 52레벨 이상 몹을 사냥하세요. 낮은 것은 회색입니다.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: 가시털일족 퓨볼그가 4킬에 한 번꼴로 떨어뜨립니다",

	-- Step 14: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "비단: {area:287}과(와) 알터랙의 신디케이트가 3킬에 한 번꼴로 떨어뜨리거나 삽니다.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: 신디케이트",

	-- Step 15: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "마법 옷감: {zone:1448} 남부의 비취불 사티로스와 {zone:1446}의 모래망치 오우거가 3킬에 한 번꼴로 떨어뜨리거나 삽니다.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: 비취불 사티로스",

	-- Step 16: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: {zone:1423}의 {area:2266}에 있는 스칼렛, {zone:1444}의 {area:2577} 밖 고르독 오우거, {zone:1451}의 황혼 야영지가 3킬에 한 번꼴로 떨어뜨립니다. 골드가 있다면 경매장이 더 빠릅니다.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: {area:2266} 바깥의 스칼렛",

	-- Step 17: Undercity: Harbinger Balthazad
	-- {area:152} Bulwark · {npc:10879} Harbinger Balthazad · {faction:68} Undercity · {object:36126} Royal Quarter · {quest:5961} The Champion of the Banshee Queen · {npc:11878} Nathanos Blightcaller · {quest:6136} The Corpulent One
	["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there. Lady Sylvanas in the {object:36126} gives {quest:5961}, an introduction to {npc:11878}: {quest:6136}, his last quest here, needs it handed in."] = "레벨 55~60 퀘스트는 평판을 전부 줍니다. 먼저 {area:152}: {faction:68} 승강기 옆의 {npc:10879}이(가) 그곳으로 보냅니다. {object:36126}의 실바나스 여왕이 {npc:11878} 소개 퀘스트인 {quest:5961}을(를) 줍니다. 그의 여기 마지막 퀘스트인 {quest:6136}은(는) 이를 제출해야 합니다.",

	-- Step 18: Bulwark: Scarlet Diversions
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {area:200} Dalson's Tears · {area:199} Felstone Field · {item:12807} Scourge Banner
	["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "{area:152}는 티리스팔에서 {zone:1422}(으)로 가는 도로의 포세이큰 야영지입니다. {npc:10837}의 사슬이 {zone:1422}의 스컬지 가마솥들에 대적하라고 보냅니다: 약 820 {faction:68} 평판. 그 옆 상자에서 {item:12814}를 하나 가져가 {area:200}과(와) {area:199} 사이 붉은십자군 야영지의 지휘 천막을 불태우고 그 옆에 {item:12807}을(를) 세우세요.",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}, +100 (53레벨)",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "{object:176088}",

	-- Step 19: Bulwark: the cauldrons
	-- {area:152} Bulwark
	["{area:152}: the cauldrons"] = "{area:152}: 가마솥",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}, +100 (53레벨)",

	-- Step 20: Felstone Field and the Andorhal towers
	-- {area:199} Felstone Field
	["{area:199} and the Andorhal towers"] = "{area:199}와(과) 안도르할 탑",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075}이(가) {area:199}의 가마솥을 지킵니다. 처치 후 가마솥을 클릭해 {quest:5230}을(를) 시작하세요. {item:12815}으로 안도르할의 탑 네 개 문에 표시하세요.",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "{object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902}: 문에 {item:12815} 사용",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",

	-- Step 22: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077}이(가) {area:200}의 가마솥을 지킵니다.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "{object:177289}",

	-- Step 23: Bulwark: the Writhing Haunt
	-- {area:152} Bulwark · {area:202} Writhing Haunt
	["{area:152}: the {area:202}"] = "{area:152}: {area:202}",

	-- Step 24: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt
	["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076}이(가) {area:202}의 가마솥을 지킵니다.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "{object:176393}",

	-- Step 26: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078}이(가) {area:201}의 가마솥을 지킵니다.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "{object:176392}",

	-- Step 27: Bulwark: done
	-- {area:152} Bulwark
	["{area:152}: done"] = "{area:152}: 완료",
	-- {area:152} Bulwark · {area:2057} Scholomance · {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "{area:152}는 {area:2057}의 열쇠(200)가 끝나는 곳이기도 합니다. 다만 더 긴 사슬 이후입니다. {faction:68}의 약초원에 있는 {npc:10136}이(가) {zone:1448}과(와) {zone:1449}의 수액괴물에게서 약 290을 더 줍니다.",

	-- Step 28: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 525 {faction:68} reputation with Sylvanas's introduction."] = "순찰대 군주 {npc:11878}은(는) {zone:1423} 서쪽 끝에 야영지를 두고 있습니다. 그의 퀘스트는 레벨 58~60이며 평판이 깎이지 않고 전부 오릅니다. 실바나스의 소개를 받으면 {faction:68} 평판 525입니다.",

	-- Step 29: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {area:2276} Quel'Lithien Lodge · {area:2264} Corin's Crossing
	["Plaguebats, {area:2276} and {area:2264}"] = "역병박쥐, {area:2276}, {area:2264}",
	-- {area:2276} Quel'Lithien Lodge · {area:2268} Light's Hope Chapel · {item:15847} Quel'Thalas Registry · {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "맹독 역병박쥐는 지역 남부를 날고, 기괴한 역병박쥐는 더 북서쪽을 돕니다. {area:2276}은(는) {area:2268} 북서쪽에 있고 {item:15847}이(가) 안에 있습니다. {area:2264}는 마지막에 하세요. 그곳의 스컬지가 {item:15447}을(를) 떨어뜨리는데 10분만 지속됩니다. 가방에 7개를 넣고 {item:15454}를 즉시 사용해 {item:15448}을(를) 만드세요.",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448}: {item:15447} 7개와 {item:15454}",

	-- Step 30: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878}: 반납",

	-- Step 31: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897}와(과) {npc:11896}",
	-- {npc:11897} Duskwing · {area:2260} Marris Stead · {npc:11896} Borelgore · {area:2272} Northdale
	["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "정예 박쥐 {npc:11897}이(가) {area:2260} 북쪽 들판을 떠돕니다. {npc:11896}이(가) {area:2272} 서쪽의 긴 골짜기를 거닙니다.",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {area:2279} Stratholme · {npc:12337} Crimson Courier
	["{npc:11878}: 525 {faction:68} reputation with Sylvanas's introduction. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878}: 실바나스의 소개를 받으면 {faction:68} 평판 525. 그의 {area:2279} 퀘스트({npc:12337}, 붉은십자군 신탁자, 데메트리아, 람스타인)는 파티가 필요합니다.",

	-- Step 32: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936} (선택 사슬)",
	-- {zone:1425} Hinterlands · {area:272} Tarren Mill · {area:367} Sen'jin Village · {area:978} Zul'Farrak · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 and pay in full too. Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "{zone:1425}, {area:272}, {area:367}, {area:978}, {faction:68}에 걸친 퀘스트 여섯: {faction:68} 평판 600과 다크스펠 225. {quest:2937}과(와) {quest:2938}은(는) 55레벨로 60에서 400을 정액으로 주고, 그 앞의 넷은 43~45레벨로 이 역시 정액입니다. 이동을 포함해 약 90분을 잡으세요. {quest:2933}은(는) {zone:1425} 서쪽 마른나무껍질 마을의 탁자 위에 있습니다. 하나를 클릭해 시작하세요.",

	-- Step 34: Shadra'Alor: an Undamaged Venom Sac
	-- {area:353} Shadra'Alor · {quest:2934} Undamaged Venom Sac
	["{area:353}: an {quest:2934}"] = "{area:353}: {quest:2934}",
	-- {area:353} Shadra'Alor · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "마른나무껍질부족 혈거미가 {zone:1425} 남서쪽 {area:353} 주변을 기어다니는데, 열 마리 중 한 마리가 무사한 독주머니를 지니고 있습니다.",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}, 마른나무껍질부족 혈거미에게서",

	-- Step 35: Tarren Mill, then Sen'jin Village
	-- {area:272} Tarren Mill · {area:367} Sen'jin Village
	["{area:272}, then {area:367}"] = "{area:272}, 그다음 {area:367}",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}, +75 다크스펠",
	-- {npc:3188} Master Gadrin · {area:367} Sen'jin Village
	["{npc:3188}, in {area:367}"] = "{npc:3188}, {area:367}",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}, +150 다크스펠",

	-- Step 36: Zul'Farrak: the Tablet of Theka
	-- {area:978} Zul'Farrak · {object:142715} Tablet of Theka
	["{area:978}: the {object:142715}"] = "{area:978}: {object:142715}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978}은(는) 북부 {zone:1446}의 44~54레벨 던전입니다. 60이면 길을 혼자 공략하거나 파티를 데려가세요. 정예 트롤 {npc:7272}이(가) 인스턴스 안 자기 무덤을 지킵니다. 그를 죽이고 그곳의 {object:142715}을(를) 읽으세요.",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "{object:142715} 읽기",

	-- Step 38: Shadra'Alor: Shadra
	-- {item:9323} Gadrin's Parchment · {area:353} Shadra'Alor · {npc:2707} Shadra
	["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "{area:353}의 제단에서 {item:9323}을(를) 읽어 정예 55레벨 거미 {npc:2707}을(를) 부르세요. 그녀는 매번 독을 떨어뜨립니다.",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}, {npc:2707}에게서",

	-- Step 39: Tarren Mill and the Undercity
	-- {area:272} Tarren Mill · {faction:68} Undercity
	["{area:272} and the {faction:68}"] = "{area:272}와(과) {faction:68}",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "연금술 실험실의 {npc:2055}",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819}: 우호적까지",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819}: {item:14047} 20개에 평판 50, 제한 없이. 약간 우호적에서 우호적은 6,000: 120번, {item:14047} 2,400개. 퀘스트가 준 만큼은 덜습니다(언데드는 약간 우호적 1,000에서 시작: 100번. 다른 종족은 중립 500에서 시작해 약간 우호적까지 먼저 50번, {item:14047} 1,000개를 모아야 합니다). 가지고 있는 20개를 계속 반납하세요.",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819}: 매우 우호적까지",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet · {area:1584} Blackrock Depths
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "우호적에서 매우 우호적은 12,000: 240번, {item:14047} 4,800개. {item:12358}({area:1584})이(가) 정액으로 150을 줍니다.",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819}: 확고한 동맹까지",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post · {area:159} Brill
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "매우 우호적에서 확고한 동맹은 21,000: 420번, {item:14047} 8,400개. 「호드를 위하여!」(렌드의 머리)와 검은바위의 군주(네파리안의 머리)가 모든 호드 도시에 200을 줍니다. 확고한 동맹이면 {area:159}의 {npc:4731}이(가) 모든 호드 종족에게 해골 말을 팝니다. 40레벨 말 20골, 60레벨 전쟁마 200골(Forever 가격)입니다. 고전에서는 다른 종족이 사려면 확고한 동맹이 필요했습니다.",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731}: 해골 말",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "암흑의 수행사제와 어둠마법사(레벨 58-60)가 여기서 떨어뜨립니다. 이곳에서 스컬지를 처치할 때마다 {object:92525} 평판도 오릅니다(해당 가이드 참고). 경매장에서도 구할 수 있습니다.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "모래망치 오우거(레벨 45-48)가 여기서 떨어뜨립니다. 경매장에서도 구할 수 있습니다.",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:68}와(과) 확고한 동맹이 될 때까지 {quest:7819}을(를) 계속 제출하세요. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819}을(를) {item:14047} 20개씩 계속 제출하세요. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "콜카르 켄타우로스(레벨 30-33)가 여기서 떨어뜨립니다. 경매장에서도 구할 수 있습니다.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}의 투자개발회사 집행자(레벨 16-17)가 여기서 떨어뜨립니다. 경매장에서도 구할 수 있습니다.",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729}이(가) {faction:68}에서 {faction:68}을(를) 위해 옷감을 받습니다. 양모 옷감, 비단 옷감, 마법 옷감, {item:14047}의 첫 기부(각 60개)는 한 번만 할 수 있고 옷감당 평판을 가장 많이 줍니다. 그 후에는 {quest:7819}을(를) 확고한 동맹까지 반복합니다. 다른 종족 도시와 확고한 동맹이 되면 그 종족의 탈것을 살 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}: {item:14047} 전달",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819}은(는) 한 번에 {item:14047} 20개를 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20개 단위로 모아 한 번에 연달아 제출하세요. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",
}
