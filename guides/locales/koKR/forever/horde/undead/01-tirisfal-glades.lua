-- Korean (koKR): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Inside"] = "",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "넋 나간 좀비",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "좀비는 교회 바로 동쪽의 묘지와 집 주변을 배회합니다.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: {npc:244808}에게 줄 두루마리",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "",
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

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "",

	-- Step 7: Back to the church
	["Back to the church"] = "교회로 돌아가기",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "교회 안의 {npc:1570}",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662}은(는) {area:154} 북쪽의 폐허가 된 집 옆에 있습니다.",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "{area:154}(으)로 돌아가기",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "{npc:246143}에게 도움을 주세요",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "",
	["Below ground"] = "",
	["attack the cocoons inside the cave to free them; below ground"] = "",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "붉은십자군 농장",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "붉은십자군 순례자와 견습마법사가 {area:154} 동쪽 농장을 차지하고 있습니다. {npc:1919}은(는) 농가 사이를 돌아다닙니다. 그의 유해는 {quest:6395}에 필요합니다.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{npc:1919}에게서 {item:16333}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090}은(는) 교회 옆 {area:154} 묘지에 있습니다.",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "",

	-- Step 18: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "",

	-- Step 19: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "티리스팔 호박",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "",

	-- Step 21: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "",

	-- Step 22: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "",

	-- Step 23: Dry Branches
	["Dry Branches"] = "마른 가지",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "마른 가지는 {area:159} 남서쪽 끝 주변 땅에 떨어져 있습니다.",

	-- Step 24: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "엘리노어 섀클턴은 마을 바로 남서쪽에서 야영합니다.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "{spell:1229451}을(를) 얻을 때까지 그녀의 모닥불 옆에서 /앉기 하세요",

	-- Step 25: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "성기사 상급자 {npc:246152}",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "",
	["The Wanted poster by the inn"] = "여관 옆의 현상수배 전단",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "마을 회관 안의 {npc:1499}",

	-- Step 26: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "",

	-- Step 27: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "마을 주변에서 빈둥거리는 죽음의경비병 5명에게 {item:286176}을(를) 사용하세요",

	-- Step 29: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "",

	-- Step 30: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "여관 안의 {npc:1500}",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "",

	-- Step 31: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "{npc:1495}의 야영지",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "{area:159}에서 남동쪽 길을 따라 비행선 탑을 지나가세요. 리니아, 크리스토프, {npc:3549}이(가) 길가에서 야영합니다.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "{npc:251001}에게 보고를 요청하세요",

	-- Step 32: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "{npc:1496}에게 보고를 요청하세요",

	-- Step 33: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "",

	-- Step 34: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "{npc:10666}에게 보고를 요청하세요",

	-- Step 35: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "결투에서 {npc:6784}을(를) 이기세요",

	-- Step 36: Crusader's Outpost
	["Crusader's Outpost"] = "붉은십자군 전초기지",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "{npc:275954}을(를) 전초기지 밖으로 호위하세요",

	-- Step 37: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "그레첸 데드마에게 줄 {item:2320}, {npc:2118}에게서 구입",

	-- Step 38: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "",

	-- Step 39: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "",

	-- Step 40: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "",

	-- Step 41: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "",

	-- Step 42: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "",

	-- Step 43: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "",

	-- Step 44: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "희귀 획득품 {item:2839}",
	["Only if the letter dropped"] = "편지를 얻었을 때만",

	-- Step 45: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "여관 안의 {npc:1560}",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {zone:1458}의 {npc:4568}에게 가져가세요",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "",

	-- Step 46: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "",

	-- Step 47: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "{area:159}에서 남쪽 {area:153}(으)로 가서 {zone:1458}(으)로 내려가세요. {npc:5675}은(는) {object:36082}에 있습니다. 붉은십자군 야영지는 폐허 바로 서쪽입니다.",

	-- Step 48: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "{area:159}에서 남쪽 {area:153}(으)로 가서 {zone:1458}(으)로 내려가세요. {npc:4568}은(는) {object:36082}에 있습니다. 붉은십자군 야영지는 폐허 바로 서쪽입니다.",

	-- Step 49: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "",
	["The Scarlet camp"] = "붉은십자군 야영지",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "{area:159}에서 남서쪽 길을 따라 붉은십자군 야영지로 가세요. {npc:1662}은(는) 남쪽 끝에 있으며, 그곳의 붉은십자군은 모두 반지를 떨어뜨릴 수 있습니다.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "",

	-- Step 51: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098}은(는) 야영지 남쪽 끝 {npc:1662} 옆에 있습니다.",

	-- Step 53: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "",

	-- Step 54: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "",

	-- Step 55: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "농장 정원의 {item:7227}",

	-- Step 57: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "",

	-- Step 58: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "리어니드와 {npc:246378}의 대화를 들은 뒤 그에게 다시 말을 거세요",

	-- Step 59: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "",

	-- Step 60: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Vile Fin Attacker",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Vile Fin Seer",

	-- Step 61: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "",
	["the basement under the ruined house"] = "",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "",

	-- Step 62: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "",

	-- Step 63: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661}은(는) 비행선 탑 옆 {area:153} 아래에 있습니다. {npc:5675}은(는) {object:36082}에 있습니다. 그 옆의 소환진에서 {item:6284}을(를) 사용하고 공허방랑자를 물리치세요. {npc:4606}은(는) {object:36070}에 있습니다. {npc:4568}도 {object:36082}에 있습니다.",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "{area:159}(으)로 돌아가세요.",
	-- ["Back up the road to {area:159}."] = "길을 따라 {area:159}(으)로 돌아가세요.",
	-- ["Balnir graves"] = "발니르 농장 무덤",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "서쪽으로 돌아가는 길 내내 그늘박쥐와 암흑사냥개가 돌아다닙니다. 가는 길에 날개와 가죽을 마저 모으세요.",
	-- ["Fields west of {area:159}"] = "{area:159} 서쪽 들판",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "길을 따라 동쪽 {area:159}(으)로 가세요. {npc:10665}은(는) 마을 북서쪽 끝에 있습니다. {area:2119}은(는) 마을 한가운데의 큰 여관이며, 그 앞에 {npc:1515}이(가) 있습니다.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "길을 따라 동쪽으로 가세요. 피투성이 좀비와 떠도는 영혼이 농장 동쪽 무덤에 출몰하며, 그곳에 {quest:99142}이(가) 자랍니다.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "{area:159}에서 북동쪽 길을 따라 {area:162}을(를) 지나가세요. {npc:1665}와(과) 붉은십자군 경호원 2명이 {area:459} 북쪽, 북동쪽 해안의 붉은십자군 감시탑을 지킵니다. 경호원부터 끌어내세요.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "길을 따라 북서쪽 {area:157}(으)로 가세요. {npc:1657}은(는) 방앗간 남쪽 묘지를 걸어 다니고, 니사, 그레고르, {npc:1656}은(는) 방앗간 안에 출몰합니다. 덜그럭거리는 해골병사와 금이간 해골병사는 갈비뼈를, 검은눈 해골마법사는 두개골을 떨어뜨리며, 누구든 {item:2839}을(를) 떨어뜨릴 수 있습니다. 지금부터 지나가며 그늘박쥐와 암흑사냥개를 처치하세요. {npc:3549}에게 날개와 가죽이 필요합니다.",
	-- ["Follow the road south back to {area:159}."] = "길을 따라 남쪽 {area:159}(으)로 돌아가세요.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "길을 따라 서쪽으로 {area:157}을(를) 지나 {area:16616}(으)로 가세요. 리어니드 바돌로매는 {npc:246389}의 야영지 바로 북쪽에 있습니다.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "{npc:244808}을(를) 위해 동굴 안에서 거미줄에 갇힌 희생자 6명을 구출하세요",
	-- ["Greater Duskbats"] = "거대한 그늘박쥐",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "거대한 그늘박쥐는 {area:159} 주변 들판과 북쪽 길을 따라 날아다닙니다.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "서쪽 {area:16616}(으)로 가세요. {npc:246389}와(과) {npc:259190}이(가) 숲 가장자리에서 야영합니다.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "서쪽 동굴로 가세요. 새끼 검은그물거미는 밖에 있고, 검은그물거미와 거미줄에 갇힌 희생자는 안에 있습니다.",
	-- ["Hearth to {area:159}"] = "귀환석으로 {area:159}에 가기",
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "북동쪽 길로 {area:154}을(를) 떠나세요. {npc:6784}은(는) {area:156}의 농가 옆에 서 있습니다.",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "전초기지 바로 북쪽 해안에도 썩은지느러미멀록이 더 있습니다.",
	-- ["Paladin: {area:16616}"] = "성기사: {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "성기사: 교회 주변의 {npc:259377} 5명을 {spell:635}(으)로 치유하면 {quest:90902}이(가) 완료됩니다.",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "덜그럭거리는 해골은 {area:154} 북쪽의 폐허가 된 집들을 배회합니다. 새끼 승냥이와 그늘박쥐는 마을 곳곳을 돌아다니고, 승냥이와 병든 그늘박쥐는 마을 동쪽에 있습니다.",
	-- ["Rattlecage skulls"] = "덜그럭거리는 해골의 두개골",
	-- ["Rattlecages, scavengers and duskbats"] = "해골, 승냥이, 그늘박쥐",
	-- ["Rot Hide graveyards"] = "썩은가죽일족 묘지",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "붉은십자군 전사가 호박밭 바로 서쪽 전초기지를 지킵니다. {npc:275954}이(가) 안에 갇혀 있습니다. 말을 걸고 빠져나올 때까지 함께 있으세요.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "남동쪽 길로 {area:159}을(를) 나가세요. 죽음의경비병 테렌스가 비행선 탑 조금 못 미쳐 서 있습니다.",
	-- ["Talk to {npc:265944}"] = "{npc:265944}와(과) 대화하세요",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "폐허가 된 집의 덜그럭거리는 해골이 두개골을 떨어뜨립니다.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "썩은가죽일족 도굴꾼이 {area:159} 북쪽 묘지를 파헤칩니다. 썩은가죽일족은 모두 체액을 떨어뜨립니다.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "썩은가죽일족 싸움꾼이 더 북쪽 언덕을 차지하고 있습니다. {npc:1753}(11레벨)은(는) 해안 남쪽 언덕의 야영지에 있습니다. 주변 놀부터 처치하세요.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "붉은십자군 수사가 무덤 바로 북동쪽에서 야영하며, {npc:1664}이(가) 그들 사이에 있습니다.",
	-- ["The Vile Fin murlocs line the north shore."] = "썩은지느러미멀록이 북쪽 해안을 따라 늘어서 있습니다.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "호박은 솔리덴 농장 북서쪽, 붉은십자군이 차지한 들판에 자랍니다.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "거미는 숲 동쪽 맨 끝의 수풀에 숨어 있습니다.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "거미는 숲 동쪽 맨 끝의 수풀에 숨어 있습니다. 떠돌이 누더기골렘 {npc:276020}이(가) 그 바로 북서쪽을 배회합니다. {npc:276020}은(는) 정예이니 파티를 권장합니다.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "비행선은 {zone:1454} 정문 바로 북동쪽 탑에 내립니다. 길을 따라 남쪽 {zone:1411}(으)로 가서, {area:379} 아래 {area:815} 다리를 건넌 뒤 서쪽 길을 따라 {area:380}로 가세요.",
	-- ["The {area:159} trainers are in and around the inn"] = "{area:159}의 상급자들은 여관 안팎에 있습니다",
	-- ["The {npc:1931}, in the town hall basement"] = "마을 회관 지하실의 {npc:1931}",
	-- ["The {npc:2211}, in the town hall basement"] = "마을 회관 지하실의 {npc:2211}",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482}은(는) {area:159} 바로 북쪽의 묘지 들판에 자랍니다.",
	-- ["Vicious Night Web Spiders"] = "흉포한 검은그물거미",
	-- ["Vile Fin murlocs"] = "썩은지느러미멀록",
	-- ["Vile Fin shore"] = "썩은지느러미 물가",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "계속 서쪽의 {area:156}(으)로 가세요. {npc:1519}이(가) 농장에 있고, 농가 옆의 {npc:6784}이(가) 결투를 원합니다. 그에게 말을 거세요.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "서쪽의 {npc:6784}에게 가서 말을 거세요. 결투를 원합니다.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "{area:159}에서 남동쪽으로 {area:153} 밖의 비행선 탑으로 가서 {zone:1454}행 비행선에 타세요(다른 하나는 {object:3202}(으)로 갑니다).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "방앗간에서 남서쪽으로 가세요. 호박은 솔리덴 농장 북서쪽, 붉은십자군이 차지한 들판에 자랍니다.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "남서쪽 {area:156}(으)로 가세요. 죽음의경비병 시머가 농장에 있습니다.",
	-- ["Webbed Victims"] = "거미줄에 갇힌 희생자",
	-- ["Zeppelin to {zone:1411}"] = "비행선으로 {zone:1411}에 가기",
	-- ["Zeppelin tower"] = "비행선 탑",
	-- ["in the inn: ask him about cooking"] = "여관 안: 요리에 대해 물어보세요",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881}은(는) 숲 서쪽 끝의 분지입니다. {npc:260428}와(과) 비술사가 뼈를 떨어뜨리고, 병은 그들 사이 땅에 놓여 있으며, {item:286269}은(는) 남쪽 끝에 있습니다.",
	-- ["{item:286326}, from {npc:276020}"] = "{npc:276020}에게서 {item:286326}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "덩치 큰 누더기골렘 {npc:10666}은(는) 조금 더 동쪽 길을 걸어 다닙니다. {item:12737}은(는) 그 주변 길가에 자랍니다.",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: 동쪽의 정예 누더기골렘 {npc:276020}",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}은(는) {area:159}에 있습니다. {npc:6390}은(는) 마을 바로 북쪽 언덕의 묘지에서 기다립니다. 문을 열고 그와 싸우십시오.",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525}와(과) 심하게 훼손된 시체가 {area:159} 바로 서쪽 들판을 배회합니다. 암흑사냥개는 조금 더 서쪽, {npc:10666} 쪽에 돌아다닙니다.",
	-- ["{npc:1661}, beside the church"] = "교회 옆의 {npc:1661}",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667}은(는) 붉은십자군 농장 남쪽 끝에 서 있습니다.",
	-- ["{npc:2119}, the warrior trainer"] = "전사 상급자 {npc:2119}",
	-- ["{npc:2132}, beside Johaan"] = "연금술사 요한 옆의 {npc:2132}",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808}와(과) {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808}와(과) {npc:5667}이(가) 교회 옆에 서 있습니다.",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009}은(는) {npc:1495}의 야영지에 있습니다.",
	-- ["{npc:3615}, the wind rider master"] = "와이번 조련사 {npc:3615}",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: {npc:246143}은(는) 교회 바로 서쪽 언덕으로 도망쳤습니다.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897}이(가) 야영지 바로 남동쪽 농장을 차지하고 있습니다. 괴저 수정 파편은 신도들 사이 땅에 놓여 있고, 신도들도 일부 지니고 있습니다.",
}
