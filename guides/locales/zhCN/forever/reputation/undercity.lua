-- Chinese (simplified) (zhCN): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "幽暗城声望",
	-- {item:14047} Runecloth
	["Tirisfal quests while you level, the Plaguelands quests from 55, then {item:14047} to Exalted."] = "",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "{faction:68}崇拜",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68}：规则说明",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:287} Hillsbrad · {area:272} Tarren Mill · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "{faction:68}声望来自任务和布料。布匹军需官{npc:14729}站在{object:36082}的裁缝旁。他接收4种一次性捐赠，每种60块布（各150声望），然后是可无限重复的{quest:7819}，每20个{item:14047}换50声望。每获得1点{faction:68}声望，{zone:1454}、{zone:1456}和暗矛巨魔也会获得四分之一。练级时，应在与任务相差不超过5级时完成{faction:68}任务：1至12级做提瑞斯法，10至20级做银松森林，20至33级做{area:287}和{area:272}。传承系统特长“外交家”最多增加10%。奖励：尊敬后{faction:68}商人售价降低10%（经典旧世规则），包括马匹商人；崇拜后其他种族也可购买骸骨军马：40级马匹20金币，60级战马200金币，均需先接受坐骑训练。{object:1661}没有战袍或其他奖励。",

	-- Step 2: Deathknell (optional hub)
	-- {area:154} Deathknell
	["{area:154} (optional hub)"] = "{area:154}（可选任务点）",
	-- {area:154} Deathknell · {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["Forever pays these old quests in full at any level. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "",

	-- Step 3: Deathknell: the next quests
	-- {area:154} Deathknell
	["{area:154}: the next quests"] = "{area:154}：后续任务",

	-- Step 4: Around Deathknell
	-- {area:154} Deathknell
	["Around {area:154}"] = "{area:154}周围",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "{object:164662} 散布在村庄周围。{quest:380} 是西北方的矿洞；{npc:271961} 悬挂在洞内。{npc:1919} 在东北方道路旁的废弃营地等待：将他的遗骸埋在村庄墓地前排的 {object:178090}。",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "解救{npc:271961}",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "用{item:16333}处理{object:178090}",

	-- Step 5: Deathknell: hand in
	-- {area:154} Deathknell
	["{area:154}: hand in"] = "{area:154}：交任务",

	-- Step 6: The Scarlet camp
	["The Scarlet camp"] = "血色营地",
	-- {area:154} Deathknell · {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "血色营地在 {area:154} 东南方，由 {npc:1667} 统领。",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}，由{npc:1667}掉落",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand · {area:159} Brill
	["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}，+75：交给{area:159}的{npc:1515}",

	-- Step 8: Brill (optional hub)
	-- {area:159} Brill
	["{area:159} (optional hub)"] = "{area:159}（可选任务点）",
	-- {area:159} Brill · {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["Forever pays these old quests in full at any level. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "",

	-- Step 9: Around Brill
	-- {area:159} Brill
	["Around {area:159}"] = "{area:159}周围",
	-- {item:286176} Executor's Motivator · {area:159} Brill · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "对{area:159}周围的5名亡灵卫兵使用{item:286176}。做{quest:99141}时，与{area:159}西面的{npc:1496}、东面驿站的{npc:251001}及路上的{npc:10666}交谈。腐皮豺狼人在{area:159}北面的乱葬岗挖掘。{npc:1525}在{area:159}西面旧桥周围行走；干树枝散落在那里的树下。黑暗犬到处都有。",
	["Motivate 5 Deathguards"] = "激励5名亡灵卫兵",

	-- Step 10: Agamand Mills
	-- {npc:1657} Devlin Agamand · {area:157} Agamand Mills
	["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657} 在通往 {area:157} 的道路上巡逻；妮萨在第一间房子楼上，格里高和萨尔曼在更前面的磨坊中等候。",

	-- Step 11: Brill: hand in
	-- {area:159} Brill
	["{area:159}: hand in"] = "{area:159}：交任务",

	-- Step 12: Agamand Mills again
	-- {area:157} Agamand Mills
	["{area:157} again"] = "再次前往 {area:157}",
	-- {area:157} Agamand Mills
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "{area:157}的骷髅掉落肋骨；暗眼骷髅法师掉落颅骨。",

	-- Step 13: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "接下来靠交布。必须先交完毛料、丝绸和魔纹布，{npc:14729}才会开放{item:14047}捐献，而{quest:7819}又要求先完成{item:14047}捐献。可在拍卖行买布，也可自行刷取：人型生物会掉落，15到25级掉毛料，25到40级掉丝绸，40到50级掉魔纹布，50级及以上掉{item:14047}。60级时刷52级或更高的怪物：更低的已是灰色。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：蓟皮熊怪约每击杀四只掉落一个",

	-- Step 14: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "丝绸：{area:287} 和奥特兰克的辛迪加约每三次击杀掉落一次，也可以购买。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 15: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔纹布：{zone:1448} 南部的碧火萨特和 {zone:1446} 的砂槌食人魔大约每击杀三只掉落一次，也可以购买。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火萨特",

	-- Step 16: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}的{area:2266}血色成员、{zone:1444}的{area:2577}外戈多克食人魔，以及{zone:1451}的暮光营地敌人，约每击杀3个掉落一次。若有金币，拍卖行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266} 外的血色十字军",

	-- Step 17: Undercity: Harbinger Balthazad
	-- {area:152} Bulwark · {npc:10879} Harbinger Balthazad · {faction:68} Undercity
	["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there."] = "55 至 60 级任务会给予完整奖励。先去 {area:152}：{faction:68} 升降梯旁的 {npc:10879} 会让你前往。",

	-- Step 18: Bulwark: Scarlet Diversions
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {area:200} Dalson's Tears · {area:199} Felstone Field · {item:12807} Scourge Banner
	["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}，+100（53级）",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "{object:176088}",

	-- Step 19: Bulwark: the cauldrons
	-- {area:152} Bulwark
	["{area:152}: the cauldrons"] = "{area:152}：瘟疫之锅",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}，+100（53级）",

	-- Step 20: Felstone Field and the Andorhal towers
	-- {area:199} Felstone Field
	["{area:199} and the Andorhal towers"] = "{area:199} 和安多哈尔的哨塔",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075}守卫着{area:199}的大锅。击杀后点击大锅，开启{quest:5230}。在安多哈尔四座塔的门口使用{item:12815}进行标记。",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "{object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902}：在门口使用 {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",

	-- Step 22: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077} 守卫着 {area:200} 的瘟疫之锅。",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "{object:177289}",

	-- Step 23: Bulwark: the Writhing Haunt
	-- {area:152} Bulwark · {area:202} Writhing Haunt
	["{area:152}: the {area:202}"] = "{area:152}：{area:202}",

	-- Step 24: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt
	["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076} 守着 {area:202} 的大锅。",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "{object:176393}",

	-- Step 26: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078} 守卫着 {area:201} 的瘟疫之锅。",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "{object:176392}",

	-- Step 27: Bulwark: done
	-- {area:152} Bulwark
	["{area:152}: done"] = "{area:152}：完成",
	-- {area:152} Bulwark · {area:2057} Scholomance · {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "{area:152}也是“{area:2057}的钥匙”长任务线的终点（200）。{faction:68}炼金房的{npc:10136}还会为{zone:1448}和{zone:1449}的软泥怪任务奖励约290声望。",

	-- Step 28: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 500 {faction:68} reputation."] = "游侠领主 {npc:11878} 在 {zone:1423} 西边缘扎营。他的任务为58至60级，可获得全额奖励：500点 {faction:68} 声望。",

	-- Step 29: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {area:2276} Quel'Lithien Lodge · {area:2264} Corin's Crossing
	["Plaguebats, {area:2276} and {area:2264}"] = "瘟疫蝙蝠、{area:2276} 和 {area:2264}",
	-- {area:2276} Quel'Lithien Lodge · {area:2268} Light's Hope Chapel · {item:15847} Quel'Thalas Registry · {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "毒性瘟疫蝙蝠在地区南部飞行，巨型瘟疫蝙蝠则在更西北。{area:2276} 位于 {area:2268} 西北；{item:15847} 就在里面。最后再做 {area:2264}：那里的天灾军团会掉落 {item:15447}，它只能保存 10 分钟。背包里凑齐 7 个后，立即使用 {item:15454} 获取 {item:15448}。",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448}：7个 {item:15447} 和 {item:15454}",

	-- Step 30: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878}：交还任务",

	-- Step 31: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897}和{npc:11896}",
	-- {npc:11897} Duskwing · {area:2260} Marris Stead · {npc:11896} Borelgore · {area:2272} Northdale
	["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "{npc:11897}是一只精英蝙蝠，在{area:2260}以北的田野游荡。{npc:11896}在{area:2272}以西的一条长山谷中来回走动。",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {area:2279} Stratholme · {npc:12337} Crimson Courier
	["{npc:11878}: 500 {faction:68} reputation. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878}：500点{faction:68}声望。他在{area:2279}的任务（{npc:12337}、“血色十字军圣者，德米提雅”、拉姆斯登）需要组队。",

	-- Step 32: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936}（可选任务线）",
	-- {zone:1425} Hinterlands · {area:272} Tarren Mill · {area:367} Sen'jin Village · {area:978} Zul'Farrak · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 and pay in full too. Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "",

	-- Step 34: Shadra'Alor: an Undamaged Venom Sac
	-- {area:353} Shadra'Alor · {quest:2934} Undamaged Venom Sac
	["{area:353}: an {quest:2934}"] = "{area:353}：一个 {quest:2934}",
	-- {area:353} Shadra'Alor · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "枯木巢穴守卫在 {zone:1425} 西南的 {area:353} 周围爬行；约十分之一携带完整的毒囊。",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}，由枯木巢穴守卫掉落",

	-- Step 35: Tarren Mill, then Sen'jin Village
	-- {area:272} Tarren Mill · {area:367} Sen'jin Village
	["{area:272}, then {area:367}"] = "先到{area:272}，再到{area:367}",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}，+75点暗矛声望",
	-- {npc:3188} Master Gadrin · {area:367} Sen'jin Village
	["{npc:3188}, in {area:367}"] = "{npc:3188}，位于 {area:367}",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}，+150暗矛巨魔声望",

	-- Step 36: Zul'Farrak: the Tablet of Theka
	-- {area:978} Zul'Farrak · {object:142715} Tablet of Theka
	["{area:978}: the {object:142715}"] = "{area:978}：{object:142715}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978} 是位于 {zone:1446} 北部的44至54级地下城；60级角色可以独自清出道路，也可以带小队。精英巨魔 {npc:7272} 在副本中守着自己的墓穴：击杀他，阅读那里的 {object:142715}。",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "阅读 {object:142715}",

	-- Step 38: Shadra'Alor: Shadra
	-- {item:9323} Gadrin's Parchment · {area:353} Shadra'Alor · {npc:2707} Shadra
	["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "在 {area:353} 的祭坛阅读 {item:9323}，召来 {npc:2707}，这是一只 55 级精英蜘蛛：她必定掉落毒液。",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}，由{npc:2707}掉落",

	-- Step 39: Tarren Mill and the Undercity
	-- {area:272} Tarren Mill · {faction:68} Undercity
	["{area:272} and the {faction:68}"] = "{area:272} 与 {faction:68}",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}，在炼金房",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819}刷到尊敬",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819}：每20块{item:14047}换50声望，可无限重复。友善到尊敬需要6,000：交还120次、2,400块{item:14047}，再扣除任务奖励的部分（亡灵起点为友善1,000：需要交还100次；其他所有种族从中立500开始，先需交还50次、1,000块{item:14047}才能到友善）。把携带的布每20块一组，连续全部交还。",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819}刷到崇敬",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet · {area:1584} Blackrock Depths
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "尊敬到崇敬需要 12,000 点：交还 240 次，共 4,800 个 {item:14047}。{item:12358}（{area:1584}）会给予全额 150 点声望。",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819}刷到崇拜",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post · {area:159} Brill
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "从崇敬到崇拜需要21,000声望：交还420次，共8,400块 {item:14047}。“为部落而战！”（雷德的头颅）和“黑石之王”（奈法利安的头颅）各给每座部落主城200声望。达到崇拜后，{area:159} 的 {npc:4731} 会向所有部落种族出售骸骨马：40级马20金币，60级战马200金币（无限服价格）；在经典旧世中，其他种族购买时需要崇拜。",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731}：骸骨战马",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes (180 at a fifth). Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{area:154} 是提瑞斯法最西端的被遗忘者起始区：25分钟约得900点 {faction:68} 声望（按五分之一则为180）。起始区任务不会给其他主城分享声望。{npc:1661}、{npc:1570} 和 {npc:1740} 站在村庄里。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes (220 at a fifth). {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{area:159} 及周围田地：45分钟约得1,100点 {faction:68} 声望（按五分之一则为220）。{npc:1515}、{npc:1499}、{npc:1518}、{npc:1496} 和 {npc:1500} 在镇内。",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7819}，直到{faction:68}达到崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7819}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "这里的科卡尔半人马（30-33级）会掉落。也可以去拍卖行购买。",
	-- ["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 (a fifth at 60 in Classic, 440 {faction:68} in all then). Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "六个任务横跨 {zone:1425}、{area:272}、{area:367}、{area:978} 和 {faction:68}：共提供 600 点 {faction:68} 和 225 点暗矛声望。{quest:2937} 和 {quest:2938} 为 55 级，60 级时仍提供全额的 400 点；前四个任务为 43 至 45 级（经典旧世中 60 级时奖励降至五分之一，此时合计为 440 点 {faction:68}）。算上赶路，预留约 90 分钟。{quest:2933} 放在 {zone:1425} 西部枯木村庄的桌上：点击一个即可开始。",
	-- ["The Plaguelands' level 55-60 quests and {item:14047} to Exalted, with Tirisfal's old quests as an optional extra."] = "通过瘟疫之地的55-60级任务和{item:14047}刷到崇拜，提瑞斯法林地的旧任务可选做。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的风险投资公司执行者（16-17级）会掉落。也可以去拍卖行购买。",
	-- ["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation, about 710 at 60 if the level 53 quests pay less. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "{area:152}是被遗忘者的营地，在提瑞斯法通往{zone:1422}的路上。{npc:10837}的任务线会让你去处理{zone:1422}的天灾大锅：约820点{faction:68}声望；若53级任务的奖励减少，60级时约710。从他身旁的箱子拿一个{item:12814}；烧毁{area:200}与{area:199}之间血色营地的指挥帐篷，并在旁边插下{item:12807}。",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729}在{faction:68}收取布料以提升{faction:68}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7819}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}：已交付{item:14047}",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
}
