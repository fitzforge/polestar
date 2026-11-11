-- Korean (koKR): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:205} Troll Witchery
	["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "35~36레벨 캐릭터용이지만, 여기 퀘스트 몇 개는 37-41레벨입니다. 경험치를 위해 일부러 넣었습니다. {quest:205}의 백골가루부족 트롤은 39-42레벨이니 하나씩 끌어오세요.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: {area:35}의 {npc:773}에게",

	-- Step 5: Nesingwary's Expedition
	["South along the road: the hunters' tents stand just west of it."] = "",
	-- {npc:718} Sir S. J. Erlgadin · {area:37} Lake Nazferiti · {area:101} Kurzen's Compound
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: 어둠아귀 표범은 {area:101} 이후 {area:37} 주변을 어슬렁거립니다",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "동쪽의 {area:101}(으)로 가세요. 헤로드의 장부는 서쪽에 있는 오두막 안에 있습니다.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "",

	-- Step 7: Kurzen's Compound
	-- {spell:7964} Smoke Bomb
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "",

	-- Step 8: Lake Nazferiti
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "주둔지에서 남쪽의 {area:37}(으)로 가세요. 호숫가 야영지의 투자개발회사 지질학자가 연마된 수정을 가지고 있으며, 어둠아귀 표범은 호수 남쪽과 동쪽 밀림에서 은신한 채 어슬렁거립니다.",

	-- Step 9: The jungle ruins
	["The jungle ruins"] = "밀림의 폐허",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "밀림을 가로질러 서쪽의 트롤 폐허로 가세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. 처음 두 개는 네싱워리 야영지 남서쪽 폐허에, 마지막 두 개는 북서쪽 언덕에 있습니다.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "",

	-- Step 10: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "유령이 출몰하는 섬은 두 번째 석판 서쪽 해안 바로 앞에 있습니다. 하급 물의 정령이 섬 주변 물속에서 솟아오릅니다.",

	-- Step 11: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "해안을 따라 북쪽으로 언덕 위 폐허로 가세요. 마지막 두 석판이 그곳에 있습니다. 녹색 언덕 페이지가 나오면 주워 두세요.",

	-- Step 12: Rebel Camp
	-- {area:99} Rebel Camp
	["East to the {area:99}, on the way back to Nesingwary's camp."] = "네싱워리 야영지로 돌아가는 길에 동쪽의 {area:99}에 들르세요.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "",

	-- Step 15: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "{npc:1152}",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "",

	-- Step 16: Level 36
	["Level 36"] = "",
	-- {quest:205} Troll Witchery · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "",

	-- Step 17: Skullsplitter trolls
	["Skullsplitter trolls"] = "백골가루부족 트롤",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "백골가루부족 트롤은 네싱워리와 {object:3202} 사이 길 동쪽의 폐허를 차지하고 있습니다.",

	-- Step 18: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, 선술집 위층",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "{zone:1416}의 대마법사 앤자이럼 룬위버에게",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}은(는) 위층에 있습니다. 이 선택 퀘스트에는 {item:4278} 4개가 필요합니다. {zone:1417}에서 {skill:186} 75로 저급 혈석 광맥을 캐거나, 경매장에서 광석을 사거나, 채광하는 친구에게 부탁하세요. 코볼트는 이 광석을 떨어뜨리지 않습니다. 광석을 구할 수 없으면 이 퀘스트는 건너뛰세요.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "북쪽과 중앙의 트롤 폐허를 한 바퀴 도세요. 폐허마다 트롤 전설이 새겨진 석판이 하나씩 있습니다. {npc:684}은(는) 그 주변 밀림에서 은신한 채 어슬렁거리고, {area:37}의 투자개발회사 야영지가 {item:4106}을(를) 가지고 있습니다.",
}
