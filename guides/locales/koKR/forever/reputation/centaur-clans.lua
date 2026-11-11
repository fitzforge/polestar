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
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "겔키스일족({zone:1443} 남서쪽)과 마그람일족(남동쪽)은 전쟁 중입니다. 한 부족을 처치할 때마다 다른 부족 평판이 20 오르고 그 부족 평판은 100 내려가므로 한쪽만 올릴 수 있습니다. 둘 다 중립에서 시작합니다. 이제 Forever의 퀘스트가 처치보다 훨씬 많은 평판을 주며, 부족 선택 퀘스트는 더 이상 다른 부족의 평판을 깎지 않습니다. 얼라이언스: {area:608}의 {npc:5396}이(가) {quest:1382}(겔키스일족)와(과) {quest:1385}(마그람일족)을(를) 줍니다. 호드: {npc:5412}이(가) {quest:1368}와(과) {quest:1367}을(를) 줍니다. 자기 부족의 퀘스트와 {quest:93224}을(를) 받으세요. 토템을 가져오면 각 부족의 '우정 매수'(3,000)를 받을 수 있습니다. 그다음 이 항목을 체크하세요. 가이드는 겔키스일족으로 진행합니다. 대신 마그람일족 퀘스트를 받으면 마그람일족 부분으로 넘어갑니다. Forever에서는 이 퀘스트들이 어느 레벨에서든 보상을 모두 줍니다.",
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

	-- Step 10: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "",

	-- Step 11: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "",

	-- Step 12: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "",

	-- Step 13: Gelkis done
	["Gelkis done"] = "겔키스일족 완료",
	["No Gelkis quests done: on to the Magram, south-east."] = "완료한 겔키스일족 퀘스트가 없습니다. 남동쪽의 마그람일족으로 가세요.",

	-- Step 14: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 15: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "",

	-- Step 16: Magram: Broken Tears
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

	-- Step 17: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "",

	-- Step 18: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "약간 우호적에서 우호적까지는 6,000입니다. 부족 퀘스트를 마치면 약 3,000이 쌓여 있으니({quest:1371}을(를) 했다면 4,000) 2,000~3,000이 남습니다. {npc:253139}의 {quest:92811}은(는) {quest:93224} 5개를 받고 750을 주며 계속 반복할 수 있습니다. {zone:1443} 서쪽의 마라우돈일족 켄타우로스(36-40레벨)가 떨어뜨리며, 토템은 귀속되지 않으므로 경매장에서도 구할 수 있습니다. 겔키스일족을 처치하면 하나당 20이 오르지만, Forever의 처치 데이터상 약간 우호적 끝, 우호적까지 1을 남기고 멈춥니다. 약간 우호적이 되면 마을에 1,000짜리 제작 주문이 두 개 있습니다: Mirda의 상급 암흑 보호 물약 3개와 Grolkar의 큰 철제 도끼 2개(대장기술). {npc:5398}의 {quest:92743}(1,000)은(는) 제작 주문이 아닙니다. 그는 {zone:1418}의 한 지하 묘지에 있는 {item:254392}을(를) 원하며, Forever의 퀘스트 페이지에는 이 퀘스트가 {quest:92841}보다 앞선 연계에 있으니 우호적에 이르기 전에 가져오세요. 유산의 외교관은 최대 10%를 더해 줍니다.",

	-- Step 19: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "",

	-- Step 20: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "",

	-- Step 21: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "",

	-- Step 22: The totem recipes
	["The totem recipes"] = "",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "두 병참장교 모두 같은 제조법 12개를 {quest:93224}(으)로 팔며, 평판 조건이 없습니다: {item:273613}와(과) 손목보호구 마법부여 - 하급 치유력, 상급 주문 작렬 물약과 {item:250941}, {item:250538}와(과) {item:250606} 설계도, {item:252462}, {item:253973}, {item:10011}, {item:274490} 도안, {item:269900}와(과) {item:269902} 설계도. 나머지를 제출하기 전에 이 제조법에 필요한 토템은 남겨 두세요.",
}
