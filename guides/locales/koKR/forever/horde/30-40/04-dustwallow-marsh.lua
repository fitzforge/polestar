-- Korean (koKR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "{area:378}(으)로 날아가기",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "{area:378}에서 길을 따라 동쪽으로 늪지대에 들어가세요. 불타 버린 {area:403}은(는) 경계를 막 지난 길가에 있습니다. 방패, 휘장, 발굽 자국은 폐허 안과 옆에 있습니다.",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "갈림길에서 북쪽 길로 가서 오우거 마을인 담쟁이 마을로 가세요.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "길이 들어오는 마을 남쪽 끝의 {npc:4503}",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}은(는) 마을 동쪽 {area:2302}에서 기다립니다. 그를 따라 리테에게 가서, 벌어지는 싸움에서 그를 살려 두세요.",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "말썽꾼 이그나츠",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "북쪽의 {area:502}(으)로 가세요. 이그나츠는 언덕 기슭에 서 있습니다. 그 바로 남쪽에서 진흙콩 잎을 모으는 동안 그를 호위하세요.",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "진흙아가미멀록",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "진흙아가미멀록은 {area:502} 동쪽과 북동쪽 해안에 몰려 있습니다. 모든 종류가 머리를 떨어뜨립니다.",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "늪지눈알 자를",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "자를은 {area:502} 남동쪽의 {area:497}에 삽니다.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "저택 옆의 {object:20985}",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "검은송곳니 거미",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "서쪽으로 늪지대를 가로질러 돌아가세요. 담쟁이 마을 북쪽 능선의 검은송곳니 독거미가 독주머니를 떨어뜨립니다. 테라모어 첩보원(35-36)이 같은 숲에 숨어 다닙니다. 은신 중이니 잘 살피세요.",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "암흑안개 거미는 담쟁이 마을 북서쪽 동굴 입구에 몰려 있습니다. 모든 종류가 눈알을 떨어뜨립니다.",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "동쪽의 {area:497}(으)로 돌아가세요.",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "{item:3853}을(를) 가지고 있을 때만({skill:164} 또는 경매장)",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{npc:4791}이(가) 보고서를 읽은 뒤의 {object:20985}",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "머리를 가지고 서쪽의 담쟁이 마을로 돌아가세요.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in the next guide"] = "다음 가이드에서 {object:3202}의 {npc:2519}에게",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "귀환석으로 {area:392}에 가기",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "북동쪽의 {area:607}(으)로 가세요. {npc:12277}은(는) 마라우돈일족 켄타우로스 야영지에 붙잡혀 있습니다. 풀어 주고 골짜기 동쪽 밖까지 호위하세요.",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}은(는) {area:596} 서쪽의 고블린 야영지에서 기다립니다.",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}의 대상단은 {area:602} 가장자리 길에 멈춰 있습니다. 동쪽으로 소굴을 지날 때까지 호위하세요. 악마가 두 번 습격합니다.",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "대상단은 {area:596} 동쪽의 {npc:11596} 야영지에서 끝납니다.",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}와(과) {npc:5412}은(는) {npc:11596} 야영지 바로 서쪽의 주둔지에 서 있습니다.",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "길을 따라 북쪽으로 묘지 북쪽 길가의 오두막으로 가세요.",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "코도 뼈와 유령",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "묘지 곳곳에 흩어진 코도 뼈를 줍고, 뼈 사이에서 {item:15848}을(를) 사용하세요. 끌려온 유령이 유령 원형질을 떨어뜨립니다.",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "불타는 칼날단이(가) {area:2407} 북서쪽 요새를 차지하고 있습니다. 요새 안의 {npc:11876}에게 {item:14523}을(를) 사용해 {item:13542}을(를) 얻으세요.",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "서쪽으로 북서쪽 해안 {area:2405}에 있는 {npc:11863}의 탑으로 가세요.",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "뱀갈퀴일족 해안",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "뱀갈퀴일족 나가는 {area:2405} 북쪽부터 {area:598}까지 해안을 차지하고 있습니다. {npc:12369}이(가) 북쪽 맨 끝에서 {quest:6027}을(를) 지키고 있습니다.",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "마라우돈일족 토템",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "{area:2405}에서 남쪽의 {area:607}(으)로 가세요. 마라우돈일족 척후병, 사냥꾼, 투사, 바람전사, 약탈자(36-39)가 {quest:93225}을(를) 떨어뜨립니다.",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "계속 남서쪽의 그늘수렵 마을로 가세요.",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "동쪽의 {area:602}(으)로 가세요. 악마 차원문마다 추방의 막대를 사용해 여섯 개를 닫으세요.",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "소굴에서 북쪽으로 {area:597}의 {npc:5412}에게 가세요.",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "귀환석으로 그늘수렵 마을에 가기",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "다음 가이드는 다시 {zone:1434}(으)로 안내합니다.",
}
