-- Korean (koKR): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever에서는 독 조제를 상급자가 아니라 이 연계 퀘스트로 배웁니다. {item:7676} 제조법도 함께 얻습니다.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "20레벨에 {object:2100} SI:7 건물 위층의 {npc:332}이(가) {zone:1436}의 {npc:7024}에게 보냅니다. Forever에서는 이 연계 퀘스트로 독 조제를 배우니 건너뛰지 마십시오.",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "",

	-- Step 3: Klaven's Tower, with a group
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, with a group"] = "{quest:2359}, 파티로",
	-- {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {object:123214} Duskwood Chest · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["{npc:7053} on the top floor is a level 26 elite: easier at 24 or with a friend. Get the key first: the {npc:7051} (level 23, the spiky-haired one trailing yellow sparkles) walks a loop around the tower; stealth up and {spell:921} it from behind. Then up the tower past the Defias Tower Patrollers (23) and Sentries (24) to the {object:123214} beside Klaven's desk (Lockpicking about 70-75). Opening it poisons you with the {spell:9810}, which stops your stealth for a while."] = "꼭대기 층의 {npc:7053}은(는) 26레벨 정예입니다. 24레벨이 되거나 친구와 함께하면 쉽습니다. 먼저 열쇠를 얻으세요. {npc:7051}(23레벨, 노란 반짝임을 끌고 다니는 뾰족 머리)이 탑 주위를 돕니다. 은신한 뒤 뒤에서 {spell:921}하세요. 그다음 데피아즈단 순찰병(23)과 보초병(24)을 지나 탑을 올라 클라벤의 책상 옆 {object:123214}(으)로 가세요(자물쇠 따기 약 70-75). 열면 {spell:9810}에 중독되어 한동안 은신할 수 없습니다.",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{object:123214} 꼭대기 층의 {item:7908}",

	-- Step 4: Klaven's Tower, solo
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, solo"] = "{quest:2359}, 혼자",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint · {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone · Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol. Then sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "먼저 열쇠를 얻으세요. {npc:7051}(23레벨, 비정예)은(는) 탑 입구에서 출발해 바깥을 한 바퀴 돕니다. 노란 반짝임을 끌고 다니는 뾰족 머리입니다. 은신한 뒤 뒤에서 {spell:921}하세요. 항상 열쇠를 갖고 있습니다. 공격이 아프니 은신이 풀리면 {spell:2983}로 도망치세요. 함께 순찰하는 데피아즈단 일꾼 두 마리도 조심하세요. 그다음 몰래 탑을 오르세요. 데피아즈단 순찰병(23)과 보초병(24)이 각 층을 지킵니다. 처치하고 싶다면 단검 매복 한 방에 죽습니다. 26레벨 정예 {npc:7053}은(는) 꼭대기 층에서 기다립니다. 혼절시키거나 친구를 데려오세요. 책상 옆 {object:123214}은(는) 자물쇠 따기 약 70-75가 필요합니다(먼저 붉은마루 산맥 {area:97}의 상자로 연습하세요). 요령: 보초병이 자리를 비운 사이 의자에서 램프, 궤짝 위 책장으로 뛰어올라 은신을 풀고 거기서 궤짝을 여세요. 열면 {spell:9810}에 중독되어 한동안 은신할 수 없고 일꾼에게 발각됩니다. 그래서 열쇠를 먼저 얻는 것입니다. 그다음 빠져나오세요.",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {spell:8681} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {spell:8681} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "엘윈 숲을 지나 북쪽의 {zone:1453}(으)로 가세요. 마티아스 쇼는 SI:7 위층에 있습니다. 그가 독 조제를 가르쳐 주고 {item:7676} 제조법을 줍니다. 독은 사는 것이 아니라 만드는 것입니다. {spell:8681}을(를) 한 번 만들 때마다 {item:2928}와(과) {item:3371}이(가) 하나씩 필요하며, SI:7 옆 {object:2100}의 {npc:1325}와(과) {npc:1326}이(가) 팝니다. 각각 한 묶음씩 사서 마법책에서 독 조제를 열어 만든 다음, 무기에 독을 바르세요.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "",
	["/lay with the Doc targeted"] = "",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "치료제 재료",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "{npc:7207}에게 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "모두 {zone:1453}에 있습니다: 검프 남매가 {item:3421}을(를) 팔고, {item:8431}은(는) 도시 안에 놓여 있으며, 가까운 상인이 {item:3372}와(과) {item:4371}을(를) 팝니다.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "엘윈 숲을 지나 북쪽 {zone:1453}(으)로 달려가십시오. 마티아스 쇼는 {object:2100}의 SI:7에 있습니다.",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024}은(는) {zone:1436} 동쪽 끝, {zone:1431} 경계 근처 언덕에서 {npc:7053}의 탑을 감시합니다. 탑을 지키는 {npc:7051}(레벨 23)이(가) 열쇠를 가지고 있으며, 클라벤의 일지는 꼭대기의 상자에 있습니다.",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207}은(는) SI:7 병영 지하실에 있습니다. 그 옆에서 /lay down을 입력해 진찰을 받으십시오.",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842} (얼라이언스)",
}
