-- Korean (koKR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, \"늪지눈알\" 자를에게 줄 것",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "{area:378}(으)로 날아가기",
	["Crossroads flight master"] = "",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "갈림길에서 북쪽 길로 가서 오우거 마을인 담쟁이 마을로 가세요.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "길이 들어오는 마을 남쪽 끝의 {npc:4503}",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}은(는) 마을 동쪽 {area:2302}에서 기다립니다. 그를 따라 리테에게 가서, 벌어지는 싸움에서 그를 살려 두세요.",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "말썽꾼 이그나츠",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "진흙아가미멀록",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "진흙아가미멀록은 {area:502} 동쪽과 북동쪽 해안에 몰려 있습니다. 모든 종류가 머리를 떨어뜨립니다.",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "늪지눈알 자를",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "자를은 {area:502} 남동쪽의 {area:497}에 삽니다.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "저택 옆의 {object:20985}",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{npc:4791}이(가) 보고서를 읽은 뒤의 {object:20985}",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "{item:3853}을(를) 가지고 있을 때만({skill:164} 또는 경매장)",

	-- Step 18: The Theramore Docks
	["Underwater"] = "",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 20: Level 37.5
	["Level 37.5"] = "",
	-- {zone:1443} Desolace · {area:1316} Razorfen Downs · {area:796} Scarlet Monastery
	["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "",
	["Darkmist cavern"] = "",
	-- {npc:4377} Darkmist Lurker
	["grind on {npc:4377}"] = "",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "",
	-- {npc:3391} Gazlowe · {area:35} Booty Bay
	["{npc:3391}'s next errand takes you to {area:35}, off this part of the route: leave it."] = "",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "",

	-- Step 26: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}은(는) {area:596} 서쪽의 고블린 야영지에서 기다립니다.",

	-- Step 31: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 32: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard
	["North to the goblin camp on the west side of the {area:596}."] = "",

	-- Step 34: Shadowprey
	["Shadowprey"] = "",
	["West to Shadowprey."] = "",

	-- Step 35: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 36: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408} 비행 조련사",

	-- Step 37: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",

	-- Step 39: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 40: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "검은송곳니 거미",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "다음 가이드에서 {object:3202}의 {npc:2519}에게",
	-- ["Hearth to Shadowprey"] = "귀환석으로 그늘수렵 마을에 가기",
	-- ["Hearth to {area:392}"] = "귀환석으로 {area:392}에 가기",
	-- ["Kodo bones and ghosts"] = "코도 뼈와 유령",
	-- ["Maraudine totems"] = "마라우돈일족 토템",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "묘지 곳곳에 흩어진 코도 뼈를 줍고, 뼈 사이에서 {item:15848}을(를) 사용하세요. 끌려온 유령이 유령 원형질을 떨어뜨립니다.",
	-- ["Ride back west to Brackenwall with the head."] = "머리를 가지고 서쪽의 담쟁이 마을로 돌아가세요.",
	-- ["Ride east back to the {area:497}."] = "동쪽의 {area:497}(으)로 돌아가세요.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "{area:378}에서 길을 따라 동쪽으로 늪지대에 들어가세요. 불타 버린 {area:403}은(는) 경계를 막 지난 길가에 있습니다. 방패, 휘장, 발굽 자국은 폐허 안과 옆에 있습니다.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "동쪽의 {area:602}(으)로 가세요. 악마 차원문마다 추방의 막대를 사용해 여섯 개를 닫으세요.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "소굴에서 북쪽으로 {area:597}의 {npc:5412}에게 가세요.",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "북쪽의 {area:502}(으)로 가세요. 이그나츠는 언덕 기슭에 서 있습니다. 그 바로 남쪽에서 진흙콩 잎을 모으는 동안 그를 호위하세요.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "길을 따라 북쪽으로 묘지 북쪽 길가의 오두막으로 가세요.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "북동쪽의 {area:607}(으)로 가세요. {npc:12277}은(는) 마라우돈일족 켄타우로스 야영지에 붙잡혀 있습니다. 풀어 주고 골짜기 동쪽 밖까지 호위하세요.",
	-- ["Ride on south-west to Shadowprey."] = "계속 남서쪽의 그늘수렵 마을로 가세요.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "{area:2405}에서 남쪽의 {area:607}(으)로 가세요. 마라우돈일족 척후병, 사냥꾼, 투사, 바람전사, 약탈자(36-39)가 {quest:93225}을(를) 떨어뜨립니다.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "서쪽으로 늪지대를 가로질러 돌아가세요. 담쟁이 마을 북쪽 능선의 검은송곳니 독거미가 독주머니를 떨어뜨립니다. 테라모어 첩보원(35-36)이 같은 숲에 숨어 다닙니다. 은신 중이니 잘 살피세요.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "서쪽으로 북서쪽 해안 {area:2405}에 있는 {npc:11863}의 탑으로 가세요.",
	-- ["Slitherblade coast"] = "뱀갈퀴일족 해안",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "불타는 칼날단이(가) {area:2407} 북서쪽 요새를 차지하고 있습니다. 요새 안의 {npc:11876}에게 {item:14523}을(를) 사용해 {item:13542}을(를) 얻으세요.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "암흑안개 거미는 담쟁이 마을 북서쪽 동굴 입구에 몰려 있습니다. 모든 종류가 눈알을 떨어뜨립니다.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "뱀갈퀴일족 나가는 {area:2405} 북쪽부터 {area:598}까지 해안을 차지하고 있습니다. {npc:12369}이(가) 북쪽 맨 끝에서 {quest:6027}을(를) 지키고 있습니다.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "대상단은 {area:596} 동쪽의 {npc:11596} 야영지에서 끝납니다.",
	-- ["The next guide takes you back to {zone:1434}."] = "다음 가이드는 다시 {zone:1434}(으)로 안내합니다.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}의 대상단은 {area:602} 가장자리 길에 멈춰 있습니다. 동쪽으로 소굴을 지날 때까지 호위하세요. 악마가 두 번 습격합니다.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}와(과) {npc:5412}은(는) {npc:11596} 야영지 바로 서쪽의 주둔지에 서 있습니다.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
}
