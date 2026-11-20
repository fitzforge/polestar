-- Chinese (traditional) (zhTW): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "幽暗城聲望",
	-- {item:14047} Runecloth
	["Tirisfal quests while you level, the Plaguelands quests from 55, then {item:14047} to Exalted."] = "升級時做提里斯法林地的任務，55級起做瘟疫之地的任務，然後上交{item:14047}直到崇拜。",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "{faction:68}崇拜",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68}：運作方式",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:287} Hillsbrad · {area:272} Tarren Mill · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "",
	["his donations are handed in from his window and never enter the log"] = "他的捐獻任務在他的視窗中直接繳交，不會進入任務日誌",

	-- Step 2: Deathknell (optional hub)
	-- {area:154} Deathknell
	["{area:154} (optional hub)"] = "{area:154}（可選據點）",
	-- {area:154} Deathknell · {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["Forever pays these old quests in full at any level. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "Forever 裡這些舊任務任何等級都足額給分。{area:154}，提里斯法西端的被遺忘者新手村：25分鐘約900點{faction:68}聲望。新手區任務不分給其他城市。{npc:1661}、{npc:1570}和{npc:1740}站在村裡。",

	-- Step 3: Deathknell: the next quests
	-- {area:154} Deathknell
	["{area:154}: the next quests"] = "{area:154}：後續任務",

	-- Step 4: Around Deathknell
	-- {area:154} Deathknell
	["Around {area:154}"] = "{area:154}一帶",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "{object:164662}遍佈村子四周。{quest:380}是西北方的礦洞；{npc:271961}吊在裡面。{npc:1919}在東北方路邊的廢棄營地等你：把他的遺骨埋到{object:178090}，就在村墓地的前排。",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "{npc:271961}已釋放",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "{object:178090}，帶上{item:16333}",

	-- Step 5: Deathknell: hand in
	-- {area:154} Deathknell
	["{area:154}: hand in"] = "{area:154}：交任務",

	-- Step 6: The Scarlet camp
	["The Scarlet camp"] = "血色十字軍營地",
	-- {area:154} Deathknell · {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "血色營地在{area:154}東南方。由{npc:1667}統領。",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}，出自{npc:1667}",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand · {area:159} Brill
	["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}，+75：送去{area:159}的{npc:1515}",

	-- Step 8: Brill (optional hub)
	-- {area:159} Brill
	["{area:159} (optional hub)"] = "{area:159}（可選據點）",
	-- {area:159} Brill · {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["Forever pays these old quests in full at any level. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "Forever 裡這些舊任務任何等級都足額給分。{area:159}和周圍的田地：45分鐘約1,100點{faction:68}聲望。{npc:1515}、{npc:1499}、{npc:1518}、{npc:1496}和{npc:1500}在鎮上。",

	-- Step 9: Around Brill
	-- {area:159} Brill
	["Around {area:159}"] = "{area:159}一帶",
	-- {item:286176} Executor's Motivator · {area:159} Brill · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "對{area:159}周圍的五名亡靈衛兵使用{item:286176}。{quest:99141}要找：{area:159}西邊的{npc:1496}、東邊驛站的{npc:251001}和路上的{npc:10666}。腐皮豺狼人在{area:159}以北的亂葬崗刨土。{npc:1525}在{area:159}以西的舊橋一帶走動；幹樹枝就在那裡的樹下。黑暗犬到處遊蕩。",
	-- {area:159} Brill
	["Motivate 5 Deathguards: the Deathguards around {area:159}"] = "激勵5名亡靈衛兵：{area:159}周圍的亡靈衛兵",

	-- Step 10: Agamand Mills
	-- {npc:1657} Devlin Agamand · {area:157} Agamand Mills
	["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657}在通往{area:157}的路上走；妮薩在第一家屋子的樓上等，格里高和索爾曼在更遠的磨坊裡。",

	-- Step 11: Brill: hand in
	-- {area:159} Brill
	["{area:159}: hand in"] = "{area:159}：交任務",

	-- Step 12: Agamand Mills again
	-- {area:157} Agamand Mills
	["{area:157} again"] = "再去{area:157}",
	-- {area:157} Agamand Mills
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "{area:157}的骷髏掉肋骨；暗眼碎骨者掉顱骨。",

	-- Step 13: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "從這裡開始靠布料。{npc:14729}要你先把毛料、絲綢和魔紋布都捐過一輪，才會開放{item:14047}捐贈，而{quest:7819}需要捐{item:14047}。布料可在拍賣行買，也可以刷：人形怪掉落，毛料出自15到25級，絲綢25到40級，魔紋布40到50級，{item:14047}出自50級以上。60級時刷52級以上的怪：等級更低的是灰色的。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：薊皮熊怪約四次擊殺掉一組",

	-- Step 14: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "絲綢：{area:287}和奧特蘭克的辛迪加約三次擊殺掉一組，或者直接買。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 15: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔紋布：{zone:1448}南部的碧火薩特和{zone:1446}的杜恩莫食人魔約三次擊殺掉一組，或者直接買。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火薩特",

	-- Step 16: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}{area:2266}的血色十字軍、{zone:1444}{area:2577}外的戈多克食人魔和{zone:1451}的暮光營地約三次擊殺掉一組。有錢的話拍賣行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266}外的血色十字軍",

	-- Step 17: Undercity: Harbinger Balthazad
	-- {area:152} Bulwark · {npc:10879} Harbinger Balthazad · {faction:68} Undercity · {object:36126} Royal Quarter · {quest:5961} The Champion of the Banshee Queen · {npc:11878} Nathanos Blightcaller · {quest:6136} The Corpulent One
	["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there. Lady Sylvanas in the {object:36126} gives {quest:5961}, an introduction to {npc:11878}: {quest:6136}, his last quest here, needs it handed in."] = "等級55到60的任務給予全額聲望。首先是{area:152}：{faction:68}電梯旁的{npc:10879}會派你去那裡。{object:36126}的希瓦娜斯女士給予{quest:5961}，是給{npc:11878}的引薦：他在這裡的最後一個任務{quest:6136}需要先繳交它。",

	-- Step 18: Bulwark: Scarlet Diversions
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {area:200} Dalson's Tears · {area:199} Felstone Field · {item:12807} Scourge Banner
	["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "{area:152}是從提里斯法通往{zone:1422}路上的被遺忘者營地。{npc:10837}的任務鏈派你去對付{zone:1422}的天災大鍋：約820點{faction:68}聲望。從他旁邊的箱子裡拿一個{item:12814}；燒掉{area:200}和{area:199}之間血色營地指揮帳篷，並在旁邊埋下{item:12807}。",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}，+100（53級）",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "{object:176088}",

	-- Step 19: Bulwark: the cauldrons
	-- {area:152} Bulwark
	["{area:152}: the cauldrons"] = "{area:152}：瘟疫鍋",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}，+100（53級）",

	-- Step 20: Felstone Field and the Andorhal towers
	-- {area:199} Felstone Field
	["{area:199} and the Andorhal towers"] = "{area:199}和安多哈爾塔樓",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075}守著{area:199}的瘟疫鍋。擊殺後點選瘟疫鍋開始{quest:5230}。用{item:12815}在安多哈爾四座塔樓的門口做標記。",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "{object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902}：在塔門處使用{item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 22: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077}守著{area:200}的瘟疫鍋。",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "{object:177289}",

	-- Step 23: Bulwark: the Writhing Haunt
	-- {area:152} Bulwark · {area:202} Writhing Haunt
	["{area:152}: the {area:202}"] = "{area:152}：{area:202}",

	-- Step 24: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt
	["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076}守著{area:202}的瘟疫鍋。",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "{object:176393}",

	-- Step 26: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078}守著{area:201}的瘟疫鍋。",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "{object:176392}",

	-- Step 27: Bulwark: done
	-- {area:152} Bulwark
	["{area:152}: done"] = "{area:152}：完成",
	-- {area:152} Bulwark · {area:2057} Scholomance · {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "較長的任務鏈“{area:2057}的鑰匙”也在{area:152}結束（200點）。{faction:68}鍊金房的{npc:10136}還會為{zone:1448}和{zone:1449}的軟泥怪再給約290點。",

	-- Step 28: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 525 {faction:68} reputation with Sylvanas's introduction."] = "遊俠領主{npc:11878}的營地在{zone:1423}西緣。他的任務等級58到60，給予全額聲望：有希瓦娜斯的引薦可得525{faction:68}聲望。",

	-- Step 29: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {area:2276} Quel'Lithien Lodge · {area:2264} Corin's Crossing
	["Plaguebats, {area:2276} and {area:2264}"] = "瘟疫蝙蝠，{area:2276}和{area:2264}",
	-- {area:2276} Quel'Lithien Lodge · {area:2268} Light's Hope Chapel · {item:15847} Quel'Thalas Registry · {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "劇毒瘟疫蝙蝠在該地區南部飛，巨型瘟疫蝙蝠在更西北方。{area:2276}在{area:2268}西北方；{item:15847}就在裡面。{area:2264}留到最後做：那裡的天災掉落的{item:15447}只能儲存10分鐘。揹包裡攢夠7個後，立刻使用{item:15454}換取{item:15448}。",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448}：7個{item:15447}加{item:15454}",

	-- Step 30: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878}：交任務",

	-- Step 31: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897}和{npc:11896}",
	-- {npc:11897} Duskwing · {area:2260} Marris Stead · {npc:11896} Borelgore · {area:2272} Northdale
	["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "精英蝙蝠{npc:11897}在{area:2260}以北的田野遊蕩。{npc:11896}在{area:2272}以西的一條長谷裡來回走動。",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {area:2279} Stratholme · {npc:12337} Crimson Courier
	["{npc:11878}: 525 {faction:68} reputation with Sylvanas's introduction. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878}：有希瓦娜斯的引薦可得525{faction:68}聲望。他的{area:2279}任務（{npc:12337}、血色神諭者、德米提亞、瑞姆斯坦）需要小隊。",

	-- Step 32: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936}（可選任務鏈）",
	-- {zone:1425} Hinterlands · {area:272} Tarren Mill · {area:367} Sen'jin Village · {area:978} Zul'Farrak · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 and pay in full too. Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "{zone:1425}、{area:272}、{area:367}、{area:978}和{faction:68}一帶的六個任務：600點{faction:68}和225點暗矛食人妖聲望。{quest:2937}和{quest:2938}是55級，60級足額給400；在它們之前的四個是43到45級，也足額給。加上跑路大概留90分鐘。{quest:2933}放在{zone:1425}西部枯木村落的桌上：點一個就能開始。",

	-- Step 34: Shadra'Alor: an Undamaged Venom Sac
	-- {area:353} Shadra'Alor · {quest:2934} Undamaged Venom Sac
	["{area:353}: an {quest:2934}"] = "{area:353}：一個{quest:2934}",
	-- {area:353} Shadra'Alor · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "枯木巢穴守衛在{zone:1425}西南部的{area:353}一帶爬動；約十分之一帶著完好的囊。",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}，枯木巢穴守衛掉落",

	-- Step 35: Tarren Mill, then Sen'jin Village
	-- {area:272} Tarren Mill · {area:367} Sen'jin Village
	["{area:272}, then {area:367}"] = "{area:272}，然後{area:367}",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}，+75暗矛",
	-- {npc:3188} Master Gadrin · {area:367} Sen'jin Village
	["{npc:3188}, in {area:367}"] = "{npc:3188}，在{area:367}",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}，+150暗矛",

	-- Step 36: Zul'Farrak: the Tablet of Theka
	-- {area:978} Zul'Farrak · {object:142715} Tablet of Theka
	["{area:978}: the {object:142715}"] = "{area:978}：{object:142715}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978}是{zone:1446}北部的44到54級地城；60級可以單刷清路，也可以組隊。精英食人妖{npc:7272}守著地城裡的墓穴：殺掉他，閱讀那裡的{object:142715}。",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "閱讀{object:142715}",

	-- Step 38: Shadra'Alor: Shadra
	-- {item:9323} Gadrin's Parchment · {area:353} Shadra'Alor · {npc:2707} Shadra
	["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "在{area:353}的祭壇讀取{item:9323}來召喚{npc:2707}，一隻55級精英蜘蛛：她每次必掉毒液。",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}，出自{npc:2707}",

	-- Step 39: Tarren Mill and the Undercity
	-- {area:272} Tarren Mill · {faction:68} Undercity
	["{area:272} and the {faction:68}"] = "{area:272}和{faction:68}",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}，在皇家藥劑師協會",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819}到尊敬",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819}：20塊{item:14047}換50點聲望，想交多少次都行。友善到尊敬是6000點：120次上繳、2400塊{item:14047}，還要減去任務給你的部分（不死族從友善1000點起步：100次上繳；其他種族從中立500點起步，先要用50次上繳、1000塊{item:14047}衝到友善）。每攢夠20塊就連續上繳。",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819}到崇敬",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet · {area:1584} Blackrock Depths
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "尊敬到崇敬是12000點：240次上繳，4800塊{item:14047}。{item:12358}（{area:1584}）全額給150點。",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819}到崇拜",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post · {area:159} Brill
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "崇敬到崇拜是21000點：420次上繳，8400塊{item:14047}。“為了部落！”（雷德的頭顱）和“黑石之王”（奈法利安的頭顱）給每個部落主城各200點。崇拜後，{area:159}的{npc:4731}把骸骨軍馬賣給所有部落種族：40級馬20金，60級戰馬200金（Forever的價格）；經典舊世裡其他種族需要崇拜才能買。",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731}：骸骨軍馬",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7819}，直到{faction:68}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7819}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "科卡爾半人馬（30-33級）在這裡會掉落。拍賣場也買得到。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的風險投資公司執行者（16-17級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729}在{faction:68}收取布料以提升{faction:68}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7819}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}：{item:14047}已交付",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
