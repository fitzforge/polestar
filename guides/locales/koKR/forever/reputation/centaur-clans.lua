-- Korean (koKR): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "부족 병참장교에게서 {quest:93224}(으)로 살 수 있는 제조법 12개, 평판 조건 없음",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "",

	-- Step 1: Pick your clan
	["Pick your clan"] = "",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "겔키스일족({zone:1443} 남서쪽)과 마그람일족(남동쪽)은 전쟁 중입니다. 한 부족을 처치할 때마다 다른 부족 평판이 20 오르고 그 부족 평판은 100 내려가며, 한 부족의 퀘스트는 주는 평판의 다섯 배만큼 다른 부족 평판을 깎으므로(우정 매수: 자기 부족 3,000, 다른 부족 -15,000) 한쪽만 올릴 수 있습니다. 둘 다 중립에서 시작합니다. 이제 Forever의 퀘스트가 처치보다 훨씬 많은 평판을 줍니다. 얼라이언스: {area:608}의 {npc:5396}이(가) {quest:1382}(겔키스일족)와(과) {quest:1385}(마그람일족)을(를) 줍니다. 호드: {npc:5412}이(가) {quest:1368}와(과) {quest:1367}을(를) 줍니다. 자기 부족의 퀘스트와 {quest:93224}을(를) 받으세요. 토템을 가져오면 각 부족의 '우정 매수'(3,000)를 받을 수 있습니다. 그다음 이 항목을 체크하세요. 가이드는 겔키스일족으로 진행합니다. 대신 마그람일족 퀘스트를 받으면 마그람일족 부분으로 넘어갑니다. Forever에서는 이 퀘스트들이 어느 레벨에서든 보상을 모두 줍니다.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "",
	["Take the quests of one clan"] = "",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "{area:608} 남쪽, 동쪽 길을 따라 늘어선 야영지의 콜카르 켄타우로스(30-33레벨)가 토템을 떨어뜨리며, 마그람일족과 마라우돈일족도 떨어뜨립니다. 다섯 개를 가져온 다음 자기 부족의 '우정 매수'를 받으세요(아래는 겔키스일족이며, 마그람일족이라면 마그람일족의 것을 받으세요).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: 콜카르 켄타우로스",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "겔키스일족 또는 마그람일족",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "퀘스트 목록에 어느 부족의 퀘스트도 없으면 가이드는 겔키스일족으로 진행합니다. 마그람일족을 원하면 그들의 선택 퀘스트와 '우정 매수'를 받으세요. 그러면 가이드가 마그람일족 부분으로 넘어갑니다.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "겔키스일족: 선택 퀘스트",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "겔키스일족 부분은 방금 토템을 건넨 퀘스트 제공자에게서 받는 부족 선택 퀘스트로 시작합니다. {area:606}의 {npc:5397} 퀘스트는 그 퀘스트에서 이어지며, '우정 매수'만으로는 열리지 않습니다.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "약간 우호적에서 우호적까지는 6,000입니다. 부족 퀘스트를 마치면 약 4,000이 쌓여 있으니 2,000이 남습니다. {npc:253140}의 {quest:92812}은(는) {quest:93224} 5개를 받고 750을 주며, 계속 반복할 수 있습니다: 세 번 제출, 토템 15개. {zone:1443} 서쪽의 마라우돈일족 켄타우로스(36-40레벨)가 떨어뜨리며, 토템은 귀속되지 않으므로 경매장에서도 구할 수 있습니다. 마그람일족을 처치하면 하나당 20이 오르지만, Forever의 처치 데이터상 약간 우호적 끝, 우호적까지 1을 남기고 멈춥니다. 약간 우호적이 되면 마을에 1,000짜리 제작 주문도 세 개 생깁니다: Halea는 상급 신비의 정수 3개, {npc:253140}은(는) {item:10008}(재봉술), Talra는 {item:5739}(가죽세공)을(를) 원합니다. 유산의 외교관은 최대 10%를 더해 줍니다.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "겔키스일족: {npc:5397}이(가) 골짜기로 보냄",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "우호적 이상, 35레벨이 되면 {npc:5397}이(가) 동쪽, {zone:1443} 남쪽이 {zone:2652}와(과) 만나는 {quest:93034} 서쪽 입구의 겔키스일족 정찰병 {npc:253177}에게 보냅니다. 골짜기 단계는 Forever의 퀘스트 데이터를 따릅니다. 플레이를 기록하는 사람 중 아직 이 퀘스트를 한 사람이 없으므로, 위치나 순서가 틀릴 수 있습니다. 골짜기 퀘스트는 모두 겔키스일족과 우호적을 유지해야 하며, 각각 주는 평판의 다섯 배만큼 마그람일족 평판을 깎습니다. 우호적에서 매우 우호적까지는 12,000이며, 골짜기에서 10,625를 얻고 나머지는 {quest:92811}(으)로 채웁니다.",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "겔키스일족: {npc:253177}",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "퀘스트 데이터 기준: {npc:253177}은(는) 골짜기 서쪽 입구에서 기다립니다. 언데드 약탈자 여섯을 잠재우고 {npc:11559}의 의식 의복을 가져오기를 원합니다. 추방자는 마그람일족의 강령술을 받아들인 겔키스일족 추방자들입니다.",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "겔키스일족: 골짜기 입구",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "퀘스트 데이터 기준: 언데드 약탈자와 {quest:92846}이(가) {npc:253177}에서 북동쪽으로 북쪽 입구의 {npc:253136} 초소까지 골짜기를 가득 메우고 있으며, 플레이어들은 그 길 내내 그들을 만났습니다. {npc:253136}의 마그람일족은 겔키스일족의 동맹에게 적대적입니다. 45레벨 정예 시체먹이가 골짜기를 돌아다니며 누구든 공격합니다.",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "겔키스일족: {quest:93041}",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "퀘스트 데이터 기준: {npc:253177}이(가) {npc:5397}에게 보여 줄 {item:255941}을(를) 주며, {item:255945}은(는) 직접 찾아야 합니다. 골짜기의 거대한 해골 하나의 턱 속에 숨겨진, 막 저주받은 해골입니다. 게임 데이터에 위치가 없습니다.",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "{item:255945}: 거대한 해골의 턱 속",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "겔키스일족: {npc:5397}와(과) {npc:253713}",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "퀘스트 데이터 기준: 서쪽 {area:606}의 {npc:5397}에게 돌아가십시오. 그녀는 테라드라스의 눈물이 필요합니다. 테라드라스의 목소리 {npc:253713}이(가) {npc:253140}을(를) 지나 마을 남쪽 동굴에 보관하고 있습니다. {npc:5397}을(를) 대신해 부탁하고 세 개를 가져오십시오. 가는 길에 {npc:253140}이(가) {quest:92812}을(를) 받습니다.",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "{npc:253713}, 동굴 안",
	["three Tears of Theradras"] = "테라드라스의 눈물 세 개",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "겔키스일족: {quest:93045}",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "퀘스트 데이터 기준: {npc:5397}이(가) 자신의 지팡이와 {item:6071}을(를) 줍니다. 둘을 합쳐 {item:256061}을(를) 만들고, 마을 바로 동쪽 연못가의 의식 장소로 가져가 {item:255945}의 저주를 풀어 주십시오. 그런 다음 다시 동쪽 {npc:253177}에게 가십시오.",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "연못가에서 {item:255945}의 저주 풀기",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "겔키스일족: {npc:253177}에게 돌아가기",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "퀘스트 데이터 기준: {npc:253177}이(가) 500과 35레벨 무기 셋 중 하나를 줍니다: {item:271794}(장창), {item:271795}(양손 도검), {item:271799}(단검). 그다음 골짜기 더 깊은 곳의 임무 두 가지를 줍니다.",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "겔키스일족: 골짜기 한가운데",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "퀘스트 데이터 기준: {npc:253177} 동쪽, 골짜기 한가운데에서 마그람일족이 겔키스일족 포로를 붙잡고 있습니다. 다섯 명을 풀어 주십시오. 그 사이에 소환에 실패해 땅에 박힌 {npc:253446}이(가) 있습니다. 퀘스트에서 받는 {item:256061}(으)로 여덟 개를 잠재우십시오. 45레벨 정예 시체먹이와 마그람일족 강령왕이 골짜기를 돌아다니며 겔키스일족의 동맹을 공격합니다. 끌어오기 전에 지나가게 두십시오.",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "{npc:253446} 잠재우기",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "겔키스일족 포로 다섯 명 풀어 주기",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "겔키스일족: {quest:93122}",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "퀘스트 데이터 기준: {npc:253177}의 다음 명령은 {zone:2652} 더 깊숙이 들어가 두 곳을 정찰하는 것입니다. 골짜기 남동쪽의 마그람일족 야영지인 {area:16675}, 그리고 더 남쪽, 셴드랄라 마을 서쪽의 추방자 야영지인 {area:16676}입니다.",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "겔키스일족: {area:16675}와(과) {area:16676}",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "퀘스트 데이터 기준: {area:16675}의 마그람일족 야영지로 걸어 들어간 뒤, 남서쪽 {area:16676}(으)로 가십시오. 45레벨 정예 추방자 강령왕이 그곳을 지킵니다. 그곳 천막에서 추방자들에게 붙잡힌 겔키스일족 {npc:254040}이(가) 꺼내 달라고 부탁합니다. 은신처 밖까지 호위한 뒤 {npc:253177}에게 알리십시오.",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "{npc:254040}을(를) 은신처 밖으로 호위",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "겔키스일족: {npc:253177}의 마지막 명령",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "퀘스트 데이터 기준: 마그람일족 전사들이 전선에서 바쁜 틈에 {npc:253177}이(가) 그들의 칸을 노릴 기회를 봅니다.",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "",

	-- Step 23: Gelkis done
	["Gelkis done"] = "겔키스일족 완료",
	["No Gelkis quests done: on to the Magram, south-east."] = "완료한 겔키스일족 퀘스트가 없습니다. 남동쪽의 마그람일족으로 가세요.",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "약간 우호적에서 우호적까지는 6,000입니다. 부족 퀘스트를 마치면 약 3,000이 쌓여 있으니({quest:1371}을(를) 했다면 4,000) 2,000~3,000이 남습니다. {npc:253139}의 {quest:92811}은(는) {quest:93224} 5개를 받고 750을 주며 계속 반복할 수 있습니다. {zone:1443} 서쪽의 마라우돈일족 켄타우로스(36-40레벨)가 떨어뜨리며, 토템은 귀속되지 않으므로 경매장에서도 구할 수 있습니다. 겔키스일족을 처치하면 하나당 20이 오르지만, Forever의 처치 데이터상 약간 우호적 끝, 우호적까지 1을 남기고 멈춥니다. 약간 우호적이 되면 마을에 1,000짜리 제작 주문이 두 개 있습니다: Mirda의 상급 암흑 보호 물약 3개와 Grolkar의 큰 철제 도끼 2개(대장기술). {npc:5398}의 {quest:92743}(1,000)은(는) 제작 주문이 아닙니다. 그는 {zone:1418}의 한 지하 묘지에 있는 {item:254392}을(를) 원하며, Forever의 퀘스트 페이지에는 이 퀘스트가 {quest:92841}보다 앞선 연계에 있으니 우호적에 이르기 전에 가져오세요. 유산의 외교관은 최대 10%를 더해 줍니다.",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "마그람일족: {npc:5398}이(가) 골짜기로 보냄",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "우호적 이상, 35레벨이 되면 {quest:92743} 이후 {npc:5398}이(가) {quest:92841}의 북쪽 입구인 {area:604} 남쪽 끝의 {npc:253136}에게 보냅니다. 골짜기 단계는 Forever의 퀘스트 데이터를 따릅니다. 플레이를 기록하는 사람 중 아직 이 퀘스트를 한 사람이 없으므로, 위치나 순서가 틀릴 수 있습니다. 골짜기 퀘스트는 모두 마그람일족과 우호적을 유지해야 하며, 각각 주는 평판의 다섯 배만큼 겔키스일족 평판을 깎습니다. 우호적에서 매우 우호적까지는 12,000이며, 골짜기에서 11,125를 얻고 나머지는 {quest:92811}(으)로 채웁니다.",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "마그람일족: {npc:253136}",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "퀘스트 데이터 기준: {npc:253136}은(는) 골짜기의 언데드 약탈자에게서 얻는 뼈(퀘스트 목록에서는 백 단위로 셉니다)와 {quest:92846} 처치 여섯을 원합니다. 마그람일족의 새 마법에 손을 대는 겔키스일족 추방자들입니다.",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "마그람일족: 골짜기 입구",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "퀘스트 데이터 기준: 언데드 약탈자와 {quest:92846}이(가) {npc:253136}에서 남서쪽으로 서쪽 입구의 {npc:253177} 초소까지 골짜기를 가득 메우고 있으며, 플레이어들은 그 길 내내 그들을 만났습니다. {npc:253177}은(는) 겔키스일족 정찰병입니다. 45레벨 정예 시체먹이가 골짜기를 돌아다니며 누구든 공격합니다.",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "살짝 저주받은 뼈: 언데드 약탈자",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "마그람일족: {quest:92847}",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "퀘스트 데이터 기준: {npc:253136}은(는) 골짜기의 저주받은 나무에서 얻는 {item:254841} 세 개(게임 데이터에 위치가 없습니다)와 {item:254840} 세 개를 원합니다. 겔키스일족에게서 빼앗은 수정은 {npc:5398}이(가) 보관하고 있으니 그에게 부탁하십시오.",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "{item:254841}: 골짜기의 저주받은 나무",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "마그람일족: {quest:92873}",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "퀘스트 데이터 기준: {npc:253136}이(가) {item:254870}을(를) 줍니다. 그는 초소 바로 동쪽 언덕에 해골 두 구를 늘어놓았습니다. 그곳에서 지팡이를 사용하면 갓 깨어난 언데드 약탈자가 잘 저주받은 뼈를 줍니다.",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "잘 저주받은 뼈: 갓 깨어난 언데드 약탈자",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "마그람일족: {npc:253136}의 다음 임무",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "퀘스트 데이터 기준: {npc:253136}이(가) 500과 35레벨 아이템 셋 중 하나를 줍니다: {item:271796}(한손 도검), {item:271797}(지팡이), {item:271798}(방패).",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "마그람일족: 골짜기 한가운데",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "퀘스트 데이터 기준: {npc:253136} 남동쪽, 골짜기 한가운데에서 마그람일족이 겔키스일족 포로를 붙잡고 있습니다. 다섯 명을 처치하십시오. 그곳의 {npc:253446}은(는) 소환에 실패해 땅에 박힌 것들입니다. 오르그룰이 준 강화된 강령술 지팡이로 열 개를 일으키고, 반격하는 것은 처치하십시오. 45레벨 정예 시체먹이는 골짜기를 돌아다니며 누구든 공격합니다. 역시 정예인 마그람일족 강령왕은 마그람일족의 동맹은 건드리지 않습니다.",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "{npc:253446} 일으키거나 처치하기",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "마그람일족: {quest:93066}",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "퀘스트 데이터 기준: {npc:253136}에게 돌아간 뒤, 다음 명령을 위해 동쪽 {quest:93066}(으)로 가십시오.",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "마그람일족: 가시멧돼지",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "퀘스트 데이터 기준: Bristleback 가시멧돼지가 골짜기 동쪽의 {quest:93066}을(를) 차지하고 있습니다. {npc:253527}(정예, 43레벨)와(과) {npc:255678}(정예, 42레벨)이(가) 그들을 이끕니다. 그 둘은 건드리지 마십시오. 그런 다음 은신처 남쪽 {area:16675}의 {npc:253851}에게 보고하십시오.",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "마그람일족: {area:16675}의 {npc:253851}",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "퀘스트 데이터 기준: {npc:253851}이(가) 남서쪽, 셴드랄라 마을 서쪽의 추방자 야영지인 {area:16676}(으)로 보냅니다.",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "마그람일족: {area:16676}",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "퀘스트 데이터 기준: 추방자 정찰병과 추방자 습격자가 은신처를 차지하고 있으며, 그 사이에 45레벨 정예 추방자 강령왕이 있습니다. {item:256892}은(는) 은신처 서쪽의 상자입니다. 퀘스트는 이곳의 {quest:92846}도 요구하지만, 지금까지 플레이어들은 {npc:253136}와(과) {npc:253177} 사이 골짜기에서만 만났으니 은신처에 없다면 그곳에서 처치하십시오.",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "{item:256892}: 상자",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "마그람일족: {npc:253851}에게 돌아가기",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "마그람일족: {npc:253136}의 의식",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "퀘스트 데이터 기준: {quest:93196}은(는) 겔키스일족을 위해 일하는 외부인들에게 살해당했고, {npc:253136}은(는) 그를 되살리려 합니다.",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "호숫가 천막에서 {quest:93196} 되살리기",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "",

	-- Step 44: The totem recipes
	["The totem recipes"] = "",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "두 병참장교 모두 같은 제조법 12개를 {quest:93224}(으)로 팔며, 평판 조건이 없습니다: {item:273613}와(과) 손목보호구 마법부여 - 하급 치유력, 상급 주문 작렬 물약과 {item:250941}, {item:250538}와(과) {item:250606} 설계도, {item:252462}, {item:253973}, {item:10011}, {item:274490} 도안, {item:269900}와(과) {item:269902} 설계도. 나머지를 제출하기 전에 이 제조법에 필요한 토템은 남겨 두세요.",
}
