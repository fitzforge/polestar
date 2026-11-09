-- Chinese (traditional) (zhTW): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {quest:6503} Ashenvale Outrunners
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers {quest:6503}: leave it for the way back, at 22."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "",

	-- Step 5: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "",

	-- Step 6: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "在四分鐘內把{npc:267214}的{npc:271181}操控出峽谷到主要道路；如果引導中斷，再找{npc:267214}一次。",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}，在道路上",

	-- Step 7: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "",

	-- Step 8: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "",
	["Naga brazier"] = "納迦火盆",

	-- Step 9: Naga heads
	["Naga heads"] = "納迦頭顱",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "前哨站北邊海岸上的每個怒尾納迦都會掉落頭顱。",

	-- Step 10: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "",

	-- Step 11: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "",

	-- Step 12: Thistlefur Hold
	["Thistlefur Hold"] = "薊皮熊怪的巢穴",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "",
	["Below ground"] = "",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "",

	-- Step 13: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "",

	-- Step 14: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12837} Yama Snowhoof
	["Fly to {area:431}: {npc:12837} waits in the inn for news of Ruul."] = "",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["Out of the inn and south down the road to the lumber camp: {npc:12867} stands there. The night elf Outrunners (23-24) stalk the woods south-east of it; they stealth, so watch for them."] = "",

	-- Step 16: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:431} Splintertree Post · {area:1637} Orgrimmar
	["Back north up the road to the {area:431} flight master and fly to {area:1637}."] = "",
	-- {area:431} Splintertree Post
	["{area:431} flight master"] = "",

	-- Step 17: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 19: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那裡的召喚法陣使用{item:6626}，擊敗魅魔以束縛她。",

	-- Step 20: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒藥：先留著",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 22: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}訓練聖騎士，從飛艇塔沿著道路往北走一小段就到。之後沿同一條路回來前往銀松森林。",

	-- Step 23: Strange Lockbox
	-- {area:240} Dead Field · {object:177790} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177790} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "",

	-- Step 24: Sepulcher
	-- {area:228} Sepulcher · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the {area:228}. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone (no name in this language: may be words)
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}，來自{npc:1973}",
	-- {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "",

	-- Step 27: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words)
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "",

	-- Step 28: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "",

	-- Step 29: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "回到道路往南走。在道路轉向東進入{area:287}的地方，{npc:2214}在{area:285}等候。",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}：{area:272}的達薩利亞",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:8582}"] = "返回{npc:8582}",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "在菲茲克斯東邊，風險投資公司正在砍伐{area:461}；其中一個風險投資公司操作員帶著藍圖。{npc:4276}在東側的小礦坑採礦：他採礦時待在他身邊，風險投資公司的打手會來找他麻煩。",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "飛往{area:431}，沿著道路向南騎往{area:1703}。",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "沿著河岸的道路向東走，然後往東北爬上山丘前往{area:272}。",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "沿著道路向北前往{area:467}。巨角鹿在沿途覓食；腐蝕獸、夜行虎和靈龍在山峰下方的樹林中遊蕩，塞納里奧德魯伊則佔據那裡的樹林。",
	-- ["Follow the road west to {area:460}."] = "沿著道路向西前往{area:460}。",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "從{area:380}沿著道路向北走。{npc:8582}站在道路進入{zone:1440}處的{area:1703}瞭望塔上。打開他給你的{item:16783}。",
	-- ["Gaea Dirt Mounds"] = "蓋亞土堆",
	-- ["Gaea Seeds"] = "蓋亞之種",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "如果你已經知道{area:272}的飛行路線，就飛過去並直接跳到{area:272}。否則從{zone:1458}飛往{area:228}，沿著道路向南騎過焚木村。鴉爪亡靈出沒於森林東南部、道路東邊的{area:231}廢墟；{npc:1973}會掉落{item:271343}，它會帶你找到{object:645153}。",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "沿著道路繼續向北。{npc:12862}在碎木崗哨南邊的戰歌伐木營地等候。",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "向西騎的途中，{npc:267214}困在主要道路南邊、{area:415}東南方的峽谷裡。黑角鹿和梣谷熊在周圍的樹林中遊蕩。",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "沿著{area:1076}騎回{area:2539}。",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "向東騎往{area:380}，飛往{zone:1454}。在{zone:1454}外的塔搭飛艇前往{zone:1420}；{area:1497}位於{area:153}下方。蝙蝠管理員在{object:36078}。",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "向南騎往{area:380}，然後沿著道路向西離開{zone:1413}進入石爪山脈。食人妖村莊{area:2539}位於峽谷入口。",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "沿著主要道路向西穿過{zone:1440}，經過{area:415}（聯盟據點：沿著道路走），前往海岸。{area:2897}在西北方的{area:414}。那裡的其他任務留到27級下次造訪再做。",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是燒焦的{area:465}。把蓋亞之種種在谷底的土堆裡；火元素會掉落{item:16312}。血怒鷹身人和血怒伏擊者在北側築巢，血怒殺戮者和血怒遊蕩者在南側。",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "與{object:36126}的{npc:10181}交談：{quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}的斯布特瓦夫：下一份指南會經過那裡",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "蓋亞之種散落在烈日石居北邊{area:464}南岸周圍的草地上。",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "道路以{area:1076}向北爬升。{quest:1483}的小屋在道路向東分岔通往{area:461}的地方。",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}在{area:428}東邊通往{area:430}的道路上巡邏。",
	-- ["To the {area:1497}"] = "前往{area:1497}",
	-- ["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "在{object:645153}使用{npc:212753}作為自願的祭品，並擊殺回應的{npc:212753}。{quest:95883}是精英：建議組隊。",
	-- ["{area:431} is just north up the road."] = "{area:431}就在道路北邊不遠處。",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}，來自廢墟中受折磨的靈魂",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，來自任何血怒鷹身人",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：從血怒鷹身人身上取得閃亮日長石",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}：瑞什在{area:1718}，在下一份指南中",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁邊",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}站在{area:428}的狩獵告示板旁，那是碎木崗哨東北方不遠處的戰歌營地。",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}的狩獵目標（烏薩苟斯、薩杜布拉、沙普塔隆）要留到27級再次來到{zone:1440}時。",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "左拉姆加的{npc:12736}，27級時",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}站在伐木營地。夜精靈的梣谷先驅者在營地東南方的樹林中潛行；他們會潛行，要留意。",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一個任務「奧達努斯」在{zone:1440}的聯盟那一側。跳過。",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}，在大門外",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606}站在{object:36070}。",
}
