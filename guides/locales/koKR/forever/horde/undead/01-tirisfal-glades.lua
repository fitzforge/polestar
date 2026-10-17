-- Korean (koKR): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "{area:154} 남쪽 끝의 지하실에서 깨어납니다. {npc:1568}이(가) 바로 밖에서 기다립니다.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "길을 따라 북쪽 {area:154}(으)로 가세요. 어둠의사제 사비스가 교회 앞에 서 있습니다.",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "넋 나간 좀비",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "좀비는 교회 바로 동쪽의 묘지와 집 주변을 배회합니다.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "교회 옆의 {npc:1661}",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "전사 상급자 {npc:2119}",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "도적 상급자 {npc:2122}",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "교회 안의 사제 상급자 {npc:2123}",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "교회 안의 마법사 상급자 {npc:2124}",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "흑마법사 상급자 {npc:2126}",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "{area:154}의 상급자들은 교회 주변에 있습니다",

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808}와(과) {npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808}와(과) {npc:5667}이(가) 교회 옆에 서 있습니다.",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: {npc:244808}에게 줄 두루마리",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "해골, 승냥이, 그늘박쥐",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "덜그럭거리는 해골은 {area:154} 북쪽의 폐허가 된 집들을 배회합니다. 새끼 승냥이와 그늘박쥐는 마을 곳곳을 돌아다니고, 승냥이와 병든 그늘박쥐는 마을 동쪽에 있습니다.",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "덜그럭거리는 해골의 두개골",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "폐허가 된 집의 덜그럭거리는 해골이 두개골을 떨어뜨립니다.",

	-- Step 8: Back to the church
	["Back to the church"] = "교회로 돌아가기",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "교회 안의 {npc:1570}",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "성기사: 교회 주변의 {npc:259377} 5명을 {spell:635}(으)로 치유하면 {quest:90902}이(가) 완료됩니다.",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662}은(는) {area:154} 북쪽의 폐허가 된 집 옆에 있습니다.",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "서쪽 동굴로 가세요. 새끼 검은그물거미는 밖에 있고, 검은그물거미와 거미줄에 갇힌 희생자는 안에 있습니다.",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "{npc:244808}을(를) 위해 동굴 안에서 거미줄에 갇힌 희생자 6명을 구출하세요",
	["Webbed Victims"] = "거미줄에 갇힌 희생자",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "{area:154}(으)로 돌아가기",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: {npc:246143}은(는) 교회 바로 서쪽 언덕으로 도망쳤습니다.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "{npc:246143}에게 도움을 주세요",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "붉은십자군 농장",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "붉은십자군 순례자와 견습마법사가 {area:154} 동쪽 농장을 차지하고 있습니다. {npc:1919}은(는) 농가 사이를 돌아다닙니다. 그의 유해는 {quest:6395}에 필요합니다.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{npc:1919}에게서 {item:16333}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090}은(는) 교회 옆 {area:154} 묘지에 있습니다.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667}은(는) 붉은십자군 농장 남쪽 끝에 서 있습니다.",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "북동쪽 길로 {area:154}을(를) 떠나세요. {npc:6784}은(는) {area:156}의 농가 옆에 서 있습니다.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "덩치 큰 누더기골렘 {npc:10666}은(는) 조금 더 동쪽 길을 걸어 다닙니다. {item:12737}은(는) 그 주변 길가에 자랍니다.",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "길을 따라 동쪽 {area:159}(으)로 가세요. {npc:10665}은(는) 마을 북서쪽 끝에 있습니다. {area:2119}은(는) 마을 한가운데의 큰 여관이며, 그 앞에 {npc:1515}이(가) 있습니다.",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "성기사 상급자 {npc:246152}",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "{npc:1496}에게 보고를 요청하세요",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "{area:159}의 상급자들은 여관 안팎에 있습니다",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "마을 주변에서 빈둥거리는 죽음의경비병 5명에게 {item:286176}을(를) 사용하세요",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482}은(는) {area:159} 바로 북쪽의 묘지 들판에 자랍니다.",

	-- Step 25: Dry Branches
	["Dry Branches"] = "마른 가지",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "마른 가지는 {area:159} 남서쪽 끝 주변 땅에 떨어져 있습니다.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "엘리노어 섀클턴은 마을 바로 남서쪽에서 야영합니다.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "{spell:1229451}을(를) 얻을 때까지 그녀의 모닥불 옆에서 /앉기 하세요",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "{area:159} 서쪽 들판",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525}와(과) 심하게 훼손된 시체가 {area:159} 바로 서쪽 들판을 배회합니다. 암흑사냥개는 조금 더 서쪽, {npc:10666} 쪽에 돌아다닙니다.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "{npc:10666}에게 보고를 요청하세요",

	-- Step 29: Calvin Montague
	-- {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer · {npc:6784} Calvin Montague
	["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "계속 서쪽의 {area:156}(으)로 가세요. {npc:1519}이(가) 농장에 있고, 농가 옆의 {npc:6784}이(가) 결투를 원합니다. 그에게 말을 거세요.",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "결투에서 {npc:6784}을(를) 이기세요",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "귀환석으로 {area:159}에 가기",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "연금술사 요한 옆의 {npc:2132}",
	["in the inn: ask him about cooking"] = "여관 안: 요리에 대해 물어보세요",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "{npc:265944}와(과) 대화하세요",
	["The Wanted poster by the inn"] = "여관 옆의 현상수배 전단",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "마을 회관 안의 {npc:1499}",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "여관 안의 {npc:1500}",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "그레첸 데드마에게 줄 {item:2320}, {npc:2118}에게서 구입",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "거대한 그늘박쥐",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "거대한 그늘박쥐는 {area:159} 주변 들판과 북쪽 길을 따라 날아다닙니다.",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "썩은가죽일족 묘지",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "썩은가죽일족 도굴꾼이 {area:159} 북쪽 묘지를 파헤칩니다. 썩은가죽일족은 모두 체액을 떨어뜨립니다.",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "썩은가죽일족 싸움꾼이 더 북쪽 언덕을 차지하고 있습니다. {npc:1753}(11레벨)은(는) 해안 남쪽 언덕의 야영지에 있습니다. 주변 놀부터 처치하세요.",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "썩은지느러미멀록",
	["The Vile Fin murlocs line the north shore."] = "썩은지느러미멀록이 북쪽 해안을 따라 늘어서 있습니다.",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "길을 따라 남쪽 {area:159}(으)로 돌아가세요.",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "{area:159}에서 남동쪽 길을 따라 비행선 탑을 지나가세요. 리니아, 크리스토프, {npc:3549}이(가) 길가에서 야영합니다.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "{npc:251001}에게 보고를 요청하세요",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "길을 따라 {area:159}(으)로 돌아가세요.",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "길을 따라 북서쪽 {area:157}(으)로 가세요. {npc:1657}은(는) 방앗간 남쪽 묘지를 걸어 다니고, 니사, 그레고르, {npc:1656}은(는) 방앗간 안에 출몰합니다. 덜그럭거리는 해골병사와 금이간 해골병사는 갈비뼈를, 검은눈 해골마법사는 두개골을 떨어뜨리며, 누구든 {item:2839}을(를) 떨어뜨릴 수 있습니다. 지금부터 지나가며 그늘박쥐와 암흑사냥개를 처치하세요. {npc:3549}에게 날개와 가죽이 필요합니다.",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "희귀 획득품 {item:2839}",
	["Only if the letter dropped"] = "편지를 얻었을 때만",

	-- Step 40: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "티리스팔 호박",
	["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "방앗간에서 남서쪽으로 가세요. 호박은 솔리덴 농장 북서쪽, 붉은십자군이 차지한 들판에 자랍니다.",

	-- Step 41: Crusader's Outpost
	["Crusader's Outpost"] = "붉은십자군 전초기지",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "붉은십자군 전사가 호박밭 바로 서쪽 전초기지를 지킵니다. {npc:275954}이(가) 안에 갇혀 있습니다. 말을 걸고 빠져나올 때까지 함께 있으세요.",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "{npc:275954}을(를) 전초기지 밖으로 호위하세요",

	-- Step 42: Vile Fin shore
	["Vile Fin shore"] = "썩은지느러미 물가",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "전초기지 바로 북쪽 해안에도 썩은지느러미멀록이 더 있습니다.",

	-- Step 43: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "성기사: {area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "서쪽 {area:16616}(으)로 가세요. {npc:246389}와(과) {npc:259190}이(가) 숲 가장자리에서 야영합니다.",

	-- Step 44: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881}은(는) 숲 서쪽 끝의 분지입니다. {npc:260428}와(과) 비술사가 뼈를 떨어뜨리고, 병은 그들 사이 땅에 놓여 있으며, {item:286269}은(는) 남쪽 끝에 있습니다.",

	-- Step 47: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "여관 안의 {npc:1560}",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "마을 회관 지하실의 {npc:1931}",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {zone:1458}의 {npc:4568}에게 가져가세요",

	-- Step 48: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}은(는) {area:159}에 있습니다. {npc:6390}은(는) 마을 바로 북쪽 언덕의 묘지에서 기다립니다. 문을 열고 그와 싸우십시오.",

	-- Step 49: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "{area:159}에서 남쪽 {area:153}(으)로 가서 {zone:1458}(으)로 내려가세요. {npc:5675}은(는) {object:36082}에 있습니다. 붉은십자군 야영지는 폐허 바로 서쪽입니다.",

	-- Step 50: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "{area:159}에서 남쪽 {area:153}(으)로 가서 {zone:1458}(으)로 내려가세요. {npc:4568}은(는) {object:36082}에 있습니다. 붉은십자군 야영지는 폐허 바로 서쪽입니다.",

	-- Step 51: The Scarlet camp
	["The Scarlet camp"] = "붉은십자군 야영지",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "{area:159}에서 남서쪽 길을 따라 붉은십자군 야영지로 가세요. {npc:1662}은(는) 남쪽 끝에 있으며, 그곳의 붉은십자군은 모두 반지를 떨어뜨릴 수 있습니다.",

	-- Step 52: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098}은(는) 야영지 남쪽 끝 {npc:1662} 옆에 있습니다.",

	-- Step 54: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "남동쪽 길로 {area:159}을(를) 나가세요. 죽음의경비병 테렌스가 비행선 탑 조금 못 미쳐 서 있습니다.",

	-- Step 55: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009}은(는) {npc:1495}의 야영지에 있습니다.",

	-- Step 56: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897}이(가) 야영지 바로 남동쪽 농장을 차지하고 있습니다. 괴저 수정 파편은 신도들 사이 땅에 놓여 있고, 신도들도 일부 지니고 있습니다.",

	-- Step 57: Balnir graves
	["Balnir graves"] = "발니르 농장 무덤",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "길을 따라 동쪽으로 가세요. 피투성이 좀비와 떠도는 영혼이 농장 동쪽 무덤에 출몰하며, 그곳에 {quest:99142}이(가) 자랍니다.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "농장 정원의 {item:7227}",

	-- Step 58: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "붉은십자군 수사가 무덤 바로 북동쪽에서 야영하며, {npc:1664}이(가) 그들 사이에 있습니다.",

	-- Step 59: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "흉포한 검은그물거미",
	["The spiders lurk in the woods at the far east end of the glades."] = "거미는 숲 동쪽 맨 끝의 수풀에 숨어 있습니다.",

	-- Step 60: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "서쪽으로 돌아가는 길 내내 그늘박쥐와 암흑사냥개가 돌아다닙니다. 가는 길에 날개와 가죽을 마저 모으세요.",

	-- Step 61: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "{npc:1495}의 야영지",

	-- Step 62: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "마을 회관 지하실의 {npc:2211}",

	-- Step 63: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "{area:159}에서 북동쪽 길을 따라 {area:162}을(를) 지나가세요. {npc:1665}와(과) 붉은십자군 경호원 2명이 {area:459} 북쪽, 북동쪽 해안의 붉은십자군 감시탑을 지킵니다. 경호원부터 끌어내세요.",

	-- Step 64: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "{area:159}(으)로 돌아가세요.",

	-- Step 65: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "길을 따라 서쪽으로 {area:157}을(를) 지나 {area:16616}(으)로 가세요. 리어니드 바돌로매는 {npc:246389}의 야영지 바로 북쪽에 있습니다.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "리어니드와 {npc:246378}의 대화를 들은 뒤 그에게 다시 말을 거세요",

	-- Step 67: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661}은(는) 비행선 탑 옆 {area:153} 아래에 있습니다. {npc:5675}은(는) {object:36082}에 있습니다. 그 옆의 소환진에서 {item:6284}을(를) 사용하고 공허방랑자를 물리치세요. {npc:4606}은(는) {object:36070}에 있습니다. {npc:4568}도 {object:36082}에 있습니다.",

	-- Step 68: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "비행선으로 {zone:1411}에 가기",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "{area:159}에서 남동쪽으로 {area:153} 밖의 비행선 탑으로 가서 {zone:1454}행 비행선에 타세요(다른 하나는 {object:3202}(으)로 갑니다).",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 69: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "비행선은 {zone:1454} 정문 바로 북동쪽 탑에 내립니다. 길을 따라 남쪽 {zone:1411}(으)로 가서, {area:379} 아래 {area:815} 다리를 건넌 뒤 서쪽 길을 따라 {area:380}로 가세요.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "와이번 조련사 {npc:3615}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "호박은 솔리덴 농장 북서쪽, 붉은십자군이 차지한 들판에 자랍니다.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "거미는 숲 동쪽 맨 끝의 수풀에 숨어 있습니다. 떠돌이 누더기골렘 {npc:276020}이(가) 그 바로 북서쪽을 배회합니다. {npc:276020}은(는) 정예이니 파티를 권장합니다.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "비행선은 {zone:1454} 정문 바로 북동쪽 탑에 내립니다. 길을 따라 남쪽 {zone:1411}(으)로 가서, {area:379} 아래 {area:815} 다리를 건넌 뒤 서쪽 길을 따라 {area:380}(으)로 가세요.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "서쪽의 {npc:6784}에게 가서 말을 거세요. 결투를 원합니다.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "남서쪽 {area:156}(으)로 가세요. 죽음의경비병 시머가 농장에 있습니다.",
	-- ["{item:286326}, from {npc:276020}"] = "{npc:276020}에게서 {item:286326}",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: 동쪽의 정예 누더기골렘 {npc:276020}",
}
