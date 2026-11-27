-- Korean (koKR): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "35~36레벨 캐릭터용이지만, 여기 퀘스트 몇 개는 37-38레벨입니다. 경험치를 위해 일부러 넣었습니다. 물의 정령은 36-37레벨이니 하나씩 끌어오세요.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453} 비행 조련사",

	-- Step 3: Clerk Daltry
	-- {npc:267} Clerk Daltry · {area:42} Darkshire · {npc:661} Jonathan Carevin
	["{npc:267} works in {area:42}'s town hall, a short walk from the flight master; {npc:661} stands just east of it."] = "",
	-- {npc:661} Jonathan Carevin · {area:121} Tranquil Gardens Cemetery · {zone:1435} Swamp of Sorrows
	["{npc:661}: the evidence lies in the {area:121}, on the next guide's way to the {zone:1435}: keep it"] = "",

	-- Step 4: Clerk Daltry
	-- {npc:267} Clerk Daltry · {area:42} Darkshire · {npc:661} Jonathan Carevin
	["{npc:267} works in {area:42}'s town hall; {npc:661} stands just east of it."] = "{npc:267}은(는) {area:42} 시청에서 일하고, {npc:661}은(는) 그 바로 동쪽에 서 있습니다.",

	-- Step 5: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "{zone:1434}(으)로",

	-- Step 6: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}, if the first Stranglethorn loop didn't give it: for {npc:773} in {area:35}"] = "",

	-- Step 7: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "길을 따라 남쪽으로 가세요. 사냥꾼들의 천막은 길 바로 서쪽에 있습니다. {npc:717}와(과) 헤멧이 첫 번째 순회에서 이 퀘스트들을 주었습니다. 받지 않았을 때만 지금 수락하세요.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if the first Stranglethorn loop didn't give it: the Lashtail Raptors, after the jungle ruins"] = "",

	-- Step 8: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "동쪽의 {area:101}(으)로 가세요. 헤로드의 장부는 서쪽에 있는 오두막 안에 있습니다.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "",

	-- Step 9: Bookie Herod
	-- {area:101} Kurzen's Compound · {quest:328} The Hidden Key
	["Herod's records lie in a hut on the west side of {area:101}: take {quest:328} there."] = "헤로드의 기록은 {area:101} 서쪽 오두막에 있습니다: 그곳에서 {quest:328}을(를) 받으십시오.",

	-- Step 10: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "요리사 {npc:218230}은(는) 주둔지 서쪽 끝에 갇혀 있습니다. 지금 퀘스트를 받아 두고 보관하세요. 우리 열쇠와 투사의 제복은 부족장과 정예가 레벨에 맞을 때 40-50 가시덤불 골짜기 가이드에서 진행합니다. 머리사냥꾼은 주둔지 더 안쪽에 있고, 특전사는 주둔지 주변과 동굴 안에서 은신한 채 숨어 있으며, 헤로드의 금고는 동굴 입구 옆에 있습니다. 푸른 언덕 페이지가 떨어지면 주우세요.\n주의: 쿠르젠 특전사는 34-35레벨로 정예는 아니지만 은신한 채 나타나는 일이 많고, 죽기 직전에 {spell:7964}을(를) 사용합니다. 39-40레벨 정예인 {npc:813}은(는) 주둔지 북쪽 끝에 서 있으니 건드리지 마세요.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}, 우리 안",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, 지하",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "",

	-- Step 11: The jungle ruins
	["The jungle ruins"] = "밀림의 폐허",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "밀림을 가로질러 서쪽의 트롤 폐허로 가세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. 처음 두 개는 네싱워리 야영지 남서쪽 폐허에, 마지막 두 개는 북서쪽 언덕에 있습니다.\n주의: 두 번째 석판 근처 해안의 소금비늘 멀록은 정예(35-37)입니다. 물 쪽에서 헤엄쳐 석판으로 가고 그들을 피하세요.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "",

	-- Step 12: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "유령이 출몰하는 섬은 두 번째 석판 서쪽 해안 바로 앞에 있습니다. 하급 물의 정령이 섬 주변 물속에서 솟아오릅니다.",

	-- Step 13: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "해안을 따라 북쪽 언덕 위 폐허로 가십시오: 마지막 석판 두 개가 그곳에 있습니다. 고블린 {npc:268992}은(는) 세 번째 석판 옆 우리에 갇혀 있습니다: 피투성이 트롤이라면 누구든 그의 {item:277957}을(를) 떨어뜨릴 수 있습니다. 도난당한 화물은 폐허 동쪽 끝에 있습니다. 푸른 언덕 쪽지는 떨어지는 대로 주우십시오.\n주의: 피투성이 광전사, 머리사냥꾼, 주술 의사(36-37)가 폐허 중심을 지킵니다: 하나씩 끌어내십시오.",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}, 세 번째 석판 옆 우리 안",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}, 피투성이부족 트롤에게서",

	-- Step 14: Escort Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992}"] = "{npc:268992} 호위",
	-- {npc:268992} Zimmix Sputterspark · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["Lead {npc:268992} out of the ruins and keep him alive: {npc:4631} in {area:35} takes the news at the end of this loop."] = "{npc:268992}을(를) 폐허 밖으로 데려가 살려 두십시오: 이 순회가 끝날 때 {area:35}의 {npc:4631}이(가) 소식을 받습니다.",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "이 경로 끝에 {area:35}의 {npc:4631}에게",

	-- Step 15: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["Check the hilltop on your way to the raptors. If {npc:729} isn't here or you can't pull her alone, keep moving; {npc:717} can take the paw on the later visit."] = "",
	-- {npc:729} Sin'Dall
	["{npc:729}'s hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 16: The Lashtail raptors
	["The Lashtail raptors"] = "채찍꼬리랩터",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 17: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 18: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}: 줄무늬정글랩터는 40-50에서 진행",

	-- Step 19: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "길을 따라 북동쪽의 {area:99}(으)로 간 뒤, 밀림을 지나 다시 남쪽으로 내려오세요.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "보관하세요: 백골가루부족 의술사(41-42)는 40-50 가시덤불 골짜기 가이드에서 처치합니다",

	-- Step 20: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "{npc:1152}",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}. Then hearth back to {area:35}: the hearthstone is still bound there from the first loop."] = "",

	-- Step 21: Tokal
	-- {npc:215643} Tokal · {object:56910} Salty Sailor Tavern · {item:4600} Cherry Grog · {npc:2832} Nixxrax Fillamug
	["{npc:215643}, whom Bibbly sent you to find, waits by the {object:56910}. He asks for a {item:4600}: {npc:2832} sells it in the tavern, a few steps away."] = "",
	-- {item:4600} Cherry Grog · {npc:2832} Nixxrax Fillamug
	["{item:4600}, from {npc:2832}"] = "",

	-- Step 22: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, 내부",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, 선술집 위층",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "{zone:1416}의 대마법사 앤자이럼 룬위버에게",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, 위층",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, 위층",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}은(는) 위층에 있습니다. 이 선택 퀘스트에는 {item:4278} 4개가 필요합니다. {zone:1417}에서 {skill:186} 75로 저급 혈석 광맥을 캐거나, 경매장에서 광석을 사거나, 채광하는 친구에게 부탁하세요. 코볼트는 이 광석을 떨어뜨리지 않습니다. 광석을 구할 수 없으면 이 퀘스트는 건너뛰세요.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, 내부",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}, 부두 위",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "폐허에서 동쪽으로 네싱워리 야영지 남서쪽 언덕 꼭대기로 가세요. 채찍꼬리랩터가 그 주변 밀림을 뛰어다닙니다. 언덕 꼭대기의 거대한 호랑이 {npc:729}(37)은(는) 40-50 가시덤불 골짜기 가이드로 남겨 두세요. 지금은 약 35레벨입니다. 그다음 사냥꾼들의 천막으로 가세요.",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "네싱워리 야영지로 돌아가는 길에 동쪽의 {area:99}에 들르세요.",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "35~36레벨 캐릭터용이지만, 여기 퀘스트 몇 개는 37-41레벨입니다. 경험치를 위해 일부러 넣었습니다. {quest:205}의 백골가루부족 트롤은 39-42레벨이니 하나씩 끌어오세요.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "북쪽과 중앙의 트롤 폐허를 한 바퀴 도세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. {npc:684}은(는) 그 주변 밀림에서 은신한 채 어슬렁거리고, {area:37}의 투자개발회사 야영지가 {item:4106}을(를) 가지고 있습니다.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "해안을 따라 북쪽으로 언덕 위 폐허로 가세요. 마지막 두 석판이 그곳에 있습니다. 녹색 언덕 페이지가 나오면 주워 두세요.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "해안을 따라 북쪽의 언덕 위 폐허로 가세요. 마지막 석판 두 개가 그곳에 있습니다. 고블린 {npc:268992}은(는) 세 번째 석판 옆에 갇혀 있습니다. 붉은머리부족 누구나 {item:277957}을(를) 떨어뜨릴 수 있으니, 그를 풀어 폐허 밖으로 데리고 나가세요. 도난당한 화물은 폐허 동쪽 끝에 있습니다. 푸른 언덕 페이지가 떨어지면 주우세요.\n주의: 붉은머리부족 광전사, 머리사냥꾼, 의술사(36-37)가 폐허 중심부를 지키니 하나씩 끌어오세요.",
	-- ["Skullsplitter trolls"] = "백골가루부족 트롤",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "{area:35}(으)로 남쪽으로 가는 길에, 밀림 한가운데 강가에서 무쇠턱 악어가 햇볕을 쬐고 있습니다.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "주둔지에서 남쪽의 {area:37}(으)로 가세요. 호숫가 야영지의 투자개발회사 지질학자가 연마된 수정을 가지고 있으며, 어둠아귀 표범은 호수 남쪽과 동쪽 밀림에서 은신한 채 어슬렁거립니다.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "주둔지에서 남쪽의 {area:37}(으)로 가세요. 호숫가 야영지의 투자개발회사 지질학자가 연마된 수정을 가지고 있습니다. 주의: 투자개발회사 요원(39)이 그 사이를 돌아다니니 야영지 가장자리의 지질학자를 하나씩 잡으세요. 그림자퓨마(37-38)가 호수 남쪽과 동쪽 밀림에서 은신한 채 어슬렁거리니 호숫가 야영지에 머무르세요.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "백골가루부족 트롤은 네싱워리와 {object:3202} 사이 길 동쪽의 폐허를 차지하고 있습니다.",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "밀림을 가로질러 서쪽의 트롤 폐허로 가세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. 처음 두 개는 네싱워리 야영지 남서쪽 폐허에, 마지막 두 개는 북서쪽 언덕에 있습니다.",
	-- ["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}, 30-40/04에서 받지 않았다면: 채찍꼬리랩터, 밀림 폐허 다음에",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}, 30-40/04에서 받지 않았다면: {npc:729}, 40-50 가시덤불 골짜기 가이드에서",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: 어둠아귀 표범은 {area:101} 이후 {area:37} 주변을 어슬렁거립니다",
	-- ["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}, 30-40/04에서 받지 않았다면: {area:35}의 {npc:773}에게",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: {area:35}의 {npc:773}에게",
}
