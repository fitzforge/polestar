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
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "從塞雷思的營地往北走時，貼著道路東側前往{area:382}以北的風險投資公司塔。靠近菲祖爾之前，先用{item:8051}放出兩支訊號彈，然後選中他並輸入/salute：沒先發訊號就靠近的人他都會攻擊。",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "{quest:2478}適合23級及以上：塔裡的工蜂是25級，加里維克斯是23級精英。有能力時組隊去做，參見職業指南《毒藥（部落）》。",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads; Rogues coming from Fizzule's tower head west to it. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "從賽瑞斯的營地往東北穿過{zone:1413}，前往十字路口北邊的道路；從菲蘇勒的塔過來的盜賊則往西走到這條路。{npc:8582}站在道路進入{zone:1440}處的{area:1703}瞭望塔上。",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "進入{zone:1440}",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "向北通往{area:431}的道路",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {quest:6503} Ashenvale Outrunners · {zone:1440} Ashenvale
	-- was: ["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers Ashenvale Outrunners: leave it for the next {zone:1440} visit, at 26."] = "沿路往北不遠就是{area:431}。從南邊進來時，先經過飛行管理員和{area:428}的{npc:12696}狩獵告示板，再到商人處。伐木營地的{npc:12867}提供「梣谷先驅者」：留到下次26級來{zone:1440}時再做。"
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers {quest:6503}: leave it for the next {zone:1440} visit, at 26."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets Ursangous and Shadumbra are for the next {zone:1440} visit, at 26; Sharptalon (31) only from level 30."] = "{npc:12696}的狩獵目標烏薩苟斯和薩杜布拉要留到26級再次來到{zone:1440}時；沙普塔隆（31級）要30級以後才做。",

	-- Step 5: Ashenvale Outrunners
	-- {quest:6503} Ashenvale Outrunners
	["The night elf {quest:6503} (23-24) stalk the woods south and south-east of the lumber camp; they stealth, so watch for them."] = "夜精靈的{quest:6503}（23-24級）在伐木營地南方和東南方的樹林中潛行；他們會隱形，要留意。",

	-- Step 6: Warsong lumber camp
	["Warsong lumber camp"] = "戰歌伐木營地",
	-- {npc:12867} Kuray'bin
	["Back to {npc:12867} at the lumber camp, on the road north to Splintertree."] = "回到伐木營地的{npc:12867}那裡，就在往北通往碎木崗哨的路上。",

	-- Step 7: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "向西的途中，{npc:267214}困在主要道路南邊、{area:415}東南方的峽谷裡。黑角鹿和梣谷熊在周圍的樹林中遊蕩。",

	-- Step 8: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "在四分鐘內把{npc:267214}的{npc:271181}操控出峽谷到主要道路；如果引導中斷，再找{npc:267214}一次。",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}，在道路上",

	-- Step 9: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12717} Muglash · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719} and {npc:12717} stand around it, the {npc:12863} beside the flight master. Its other quests, Thistlefur's among them, are for the next visit, at 26."] = "沿著主要道路向西穿過{zone:1440}，經過{area:415}（聯盟據點：沿著道路走），前往海岸。{area:2897}在西北方的{area:414}：{npc:12719}和{npc:12717}站在它周圍，{npc:12863}在飛行管理員旁邊。那裡的其他任務（包括薊皮的任務）留到26級下次造訪再做。",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "{npc:12717}：最後再接，護送立即開始",

	-- Step 10: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "{npc:12717}沿著海灘向北走到一個納迦火盆旁。熄滅火盆，然後在納迦一波波來襲時保護他，直到鞭笞者沃爾沙死去；怒尾納迦會掉落{npc:12719}要的首級。",
	["Naga brazier"] = "納迦火盆",

	-- Step 11: Naga heads
	["Naga heads"] = "納迦頭顱",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "前哨站北邊海岸上的每個怒尾納迦都會掉落頭顱。",

	-- Step 12: Zoram'gar Outpost
	["Back to the outpost."] = "回到前哨。",

	-- Step 13: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {quest:1063} The Elder Crone · {area:1638} Thunder Bluff · {area:2897} Zoram'gar Outpost · {npc:4046} Magatha Grimtotem · {npc:3419} Apothecary Zamah · {npc:2216} Apothecary Lydon · {area:272} Tarren Mill · {zone:1454} Orgrimmar
	["{quest:1063} first: fly to {area:1638} from the {area:2897} flight master. {npc:4046} and {npc:3419} send you to {npc:2216} in {area:272}, the next guide's base, and {area:1638}'s flight path takes you on to {zone:1454}."] = "先處理{quest:1063}：從{area:2897}的飛行管理員飛往{area:1638}。{npc:4046}和{npc:3419}會派你去找{area:272}的{npc:2216}，那裡是下一份指南的據點；再從{area:1638}的飛行路線前往{zone:1454}。",
	-- {area:2897} Zoram'gar Outpost
	["{area:2897} flight master"] = "{area:2897}飛行管理員",

	-- Step 14: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飛往{area:378}",
	-- {quest:1063} The Elder Crone · {area:378} Camp Taurajo · {area:2897} Zoram'gar Outpost · {zone:1456} Thunder Bluff · {npc:4046} Magatha Grimtotem · {npc:3419} Apothecary Zamah · {npc:2216} Apothecary Lydon · {area:272} Tarren Mill · {zone:1454} Orgrimmar
	["{quest:1063} first: fly to {area:378} from the {area:2897} flight master and walk on to {zone:1456}. {npc:4046} and {npc:3419} send you to {npc:2216} in {area:272}, the next guide's base, and {zone:1456}'s flight path takes you on to {zone:1454}."] = "先處理{quest:1063}：從{area:2897}的飛行管理員飛往{area:378}，再步行前往{zone:1456}。{npc:4046}和{npc:3419}會派你去找{area:272}的{npc:2216}，那裡是下一份指南的據點；再從{zone:1456}的飛行路線前往{zone:1454}。",

	-- Step 15: To Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["To {zone:1456}"] = "前往{zone:1456}",
	-- {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {zone:1456} Thunder Bluff
	["From {area:378} follow the road west through the gate into {zone:1412}, then north past {area:222} to {zone:1456}; a lift at the foot of the bluffs takes you up."] = "從{area:378}沿道路向西穿過大門進入{zone:1412}，然後往北經過{area:222}前往{zone:1456}；高崖腳下的升降梯會載你上去。",
	-- {zone:1456} Thunder Bluff
	["{zone:1456}'s central rise"] = "{zone:1456}的中央高台",

	-- Step 16: Thunder Bluff
	-- {npc:2995} Tal · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3419} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise
	["{npc:2995}, the wind rider master, stands on the central rise: take his flight path if you don't have it. {npc:4046} stands on {area:1639} to the east; {npc:3419} in the {area:2197}, the caves under {area:1640} to the west."] = "雙足飛龍管理員{npc:2995}站在中央高台上：如果還沒有他的飛行路線就先取得。{npc:4046}在東邊的{area:1639}；{npc:3419}在西邊{area:1640}下方洞穴裡的{area:2197}。",
	-- {npc:3419} Apothecary Zamah · {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["{npc:3419}: her note is for {npc:2216} in {area:272}, next guide"] = "{npc:3419}：她的便條要交給下一份指南{area:272}的{npc:2216}",

	-- Step 17: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {npc:2995} Tal · {area:1637} Orgrimmar
	["Back up to {npc:2995} on the central rise and fly to {area:1637}."] = "回到中央高台上的{npc:2995}，飛往{area:1637}。",

	-- Step 18: Fly to Orgrimmar
	-- {area:1637} Orgrimmar · {area:2897} Zoram'gar Outpost
	["Fly to {area:1637} from the {area:2897} flight master."] = "從{area:2897}的飛行管理員飛往{area:1637}。",

	-- Step 19: Druid trainer
	["Druid trainer"] = "德魯伊訓練師",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034}，在{zone:1412}；{zone:1454}沒有德魯伊訓練師",

	-- Step 21: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那裡的召喚法陣使用{item:6626}，擊敗魅魔以束縛她。",

	-- Step 22: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "如果你組隊做了{quest:2478}，現在可以把它交給{object:172960}裡的{npc:3401}。",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒藥：先留著",

	-- Step 23: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "搭飛艇前往{zone:1458}",

	-- Step 24: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}訓練聖騎士，從飛艇塔沿著道路往北走一小段就到。之後沿同一條路回來前往銀松森林。",

	-- Step 25: Morbin Lightbane
	-- {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {object:36126} Royal Quarter · {npc:266484} Morbin Lightbane · {npc:10181} Lady Sylvanas Windrunner
	["For your {area:153} run: the zeppelin lands beside the ruins. Walk into the {zone:1458} through them and down to the {object:36126}: {npc:266484} stands there, near {npc:10181}."] = "為了你的{area:153}之行：飛艇降落在廢墟旁。穿過廢墟走進{zone:1458}，往下到{object:36126}：{npc:266484}站在那裡，靠近{npc:10181}。",

	-- Step 26: Ruins of Lordaeron
	-- {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {item:268580} Intact Limbs · {npc:266484} Morbin Lightbane · {npc:250660} The Baron · {item:280438} Abominable Head · {npc:2055} Master Apothecary Faranell · {npc:256102} Crest of Lordaeron · {npc:7825} Oran Snakewrithe
	["The {area:153} is a dungeon for a group of five, about levels 15 to 22, in the ruined city above the {zone:1458}: its portal is in the ruins you walked through.\nInside: every undead can drop {item:268580} for {npc:266484}, so clear as you go. {npc:250660} can drop an {item:280438}, which starts a quest for {npc:2055}, and a {npc:256102} found inside starts one for {npc:7825}: both are in the {zone:1458}, on this route's next stop there."] = "{area:153}是五人地城，約15到22級，位於{zone:1458}上方的廢墟城市中：傳送門就在你剛走過的廢墟裡。\n裡面：每個不死生物都可能掉落給{npc:266484}的{item:268580}，所以邊走邊清。{npc:250660}可能掉落{item:280438}，可開啟給{npc:2055}的任務；在裡面找到的{npc:256102}則會開啟給{npc:7825}的任務：兩人都在{zone:1458}，就在本路線下一次到那裡時。",
	-- {quest:92421} Light's Justice · {item:268580} Intact Limbs
	["{quest:92421}: the {item:268580}, inside"] = "{quest:92421}：{item:268580}，在裡面",

	-- Step 27: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher
	["Out of the ruins, take the road south through Tirisfal into {zone:1421} and on to the {area:228}."] = "離開廢墟，沿道路向南穿過提里斯法進入{zone:1421}，繼續前往{area:228}。",

	-- Step 28: Strange Lockbox
	-- {area:240} Dead Field · {object:177844} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} The Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177844} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177844} Strange Lockbox
	["{item:15882}, from the {object:177844}"] = "{item:15882}，來自{object:177844}",

	-- Step 29: The Sepulcher
	-- {area:228} The Sepulcher · {object:177844} Strange Lockbox · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["Down the road through Silverpine to the {area:228}: from the zeppelin towers, south through Tirisfal; from the {object:177844}, south-east from the coast to the road. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "沿著道路穿過銀松森林前往{area:228}：從飛艇塔出發的話，往南穿過提里斯法；從{object:177844}出發的話，從海岸往東南走到道路上。{npc:2121}和{npc:1937}站在墓穴入口旁。",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "{npc:1937}：交給{area:272}的萊頓，見下一個指南",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "{npc:2121}：{quest:516}，在{area:233}東南",
	-- {npc:2121} Shadow Priest Allister · {area:233} Ambermill
	["{npc:2121}: {area:233}'s pendants, on the same roads"] = "{npc:2121}：{area:233}的墜飾，在同樣的道路上",

	-- Step 30: Deathguard Podrig
	-- {npc:6389} Deathguard Podrig · {item:16210} Gordon's Crate · {zone:1458} Undercity
	["{npc:6389} stands just west of the crypt entrance: hand him {item:16210} from the {zone:1458}."] = "{npc:6389}站在墓穴入口西邊不遠處：把來自{zone:1458}的{item:16210}交給他。",

	-- Step 31: High Executor Hadrec
	-- {area:236} Shadowfang Keep · {area:287} Hillsbrad · {npc:1952} High Executor Hadrec
	["For your {area:236} run, at the end of the {area:287} guide: {npc:1952} stands below ground in the crypt."] = "為了你在{area:287}指南結尾的{area:236}之行：{npc:1952}站在墓穴的地下。",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}，在地下",

	-- Step 32: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "{zone:1421}：遇到就殺",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger · High Order Mages = {npc:254294} High Order Mage
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest. Careful: High Order Mages (30) walk the same roads among the Watchers and Wizards: leave them."] = "",
	["Below ground"] = "地下",

	-- Step 33: Ambermill
	-- {area:233} Ambermill · {npc:2540} Dalaran Serpent · {npc:2120} Archmage Ataeric
	["On the roads around {area:233}, step into the town's outskirts: Protectors guard them and Mages the town; both drop pendants. Careful: each Mage (15) fights with a {npc:2540} (15) beside it: pull one Mage at a time from the outskirts. Stay out of the middle, where {npc:2120} (22) stands."] = "在{area:233}周圍的道路上，走進城鎮外圍：守衛者守著外圍，法師守著城鎮；兩者都會掉落墜飾。小心：每個法師（15級）身旁都有一隻{npc:2540}（15級）一起戰鬥：從外圍一次拉一個法師。別進入中央，{npc:2120}（22級）站在那裡。",

	-- Step 34: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone (no name in this language: may be words)
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "渡鴉爪亡靈在森林東南、道路以東的{quest:516}廢墟出沒；一隻{npc:1973}會掉{item:271343}，它能引向{object:645153}。\n一個精英幽靈（20級）常站在{object:645153}旁：和渡鴉爪開打之前先把它們從石頭旁拉開。",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}，來自{npc:1973}",
	-- {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "拿到{item:271343}後，{object:645153}會提供{quest:95883}；在地下",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "{item:271350}，來自廢墟中受折磨的靈魂；在地下",

	-- Step 35: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words) · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "任務會給你一個{item:210713}：在{object:645153}旁使用它獻上你的血，然後擊殺回應的精英靈魂。\n{quest:95883}是精英：建議組隊。",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone (no name in this language: may be words)
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "{item:210713}，在{object:645153}旁：召喚精英幽靈",

	-- Step 36: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "進入{area:287}",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "向東通往{area:285}的道路",

	-- Step 37: Southpoint Tower
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
	-- ["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "沿著主要道路向西穿過{zone:1440}，經過{area:415}（聯盟據點：沿著道路走），前往海岸。{area:2897}在西北方的{area:414}：{npc:12719}、{npc:12721}和{npc:12757}站在它周圍，{npc:12863}在飛行管理員旁邊。那裡的其他任務留到26級下次造訪再做。",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "如果你已經知道{area:272}的飛行路線，就飛過去並直接跳到{area:272}。否則從{zone:1458}飛往{area:228}，沿著道路向南騎過焚木村。鴉爪亡靈出沒於森林東南部、道路東邊的{area:231}廢墟；{npc:1973}會掉落{item:271343}，它會帶你找到{object:645153}。",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "沿著道路繼續向北。{npc:12862}在碎木崗哨南邊的戰歌伐木營地等候。",
	-- ["Out of the inn to the {area:431} flight master and fly to {area:1637}."] = "走出旅店，去{area:431}的飛行管理員那裡，飛往{area:1637}。",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "沿著{area:1076}騎回{area:2539}。",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "向東騎往{area:380}，飛往{zone:1454}。在{zone:1454}外的塔搭飛艇前往{zone:1420}；{area:1497}位於{area:153}下方。蝙蝠管理員在{object:36078}。",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "向南騎往{area:380}，然後沿著道路向西離開{zone:1413}進入石爪山脈。食人妖村莊{area:2539}位於峽谷入口。",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是燒焦的{area:465}。把蓋亞之種種在谷底的土堆裡；火元素會掉落{item:16312}。血怒鷹身人和血怒伏擊者在北側築巢，血怒殺戮者和血怒遊蕩者在南側。",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "與{object:36126}的{npc:10181}交談：{quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}的斯布特瓦夫：下一份指南會經過那裡",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "蓋亞之種散落在烈日石居北邊{area:464}南岸周圍的草地上。",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "道路以{area:1076}向北爬升。{quest:1483}的小屋在道路向東分岔通往{area:461}的地方。",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}在{area:428}東邊通往{area:430}的道路上巡邏。",
	-- ["Thistlefur Hold"] = "薊皮熊怪的巢穴",
	-- ["To the {area:1497}"] = "前往{area:1497}",
	-- ["{area:431} is just north up the road."] = "{area:431}就在道路北邊不遠處。",
	-- ["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers Ashenvale Outrunners: leave it for the next {zone:1440} visit, at 26."] = "沿路往北不遠就是{area:431}。從南邊進來時，先經過飛行管理員和{area:428}的{npc:12696}狩獵告示板，再到商人處。伐木營地的{npc:12867}提供「梣谷先驅者」：留到下次26級來{zone:1440}時再做。",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，來自任何血怒鷹身人",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：從血怒鷹身人身上取得閃亮日長石",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}：瑞什在{area:1718}，在下一份指南中",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁邊",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}站在{area:428}的狩獵告示板旁，那是碎木崗哨東北方不遠處的戰歌營地。",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "{npc:12696}的狩獵目標（烏薩苟斯、薩杜布拉、沙普塔隆）要留到26級再次來到{zone:1440}時。",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "左拉姆加的{npc:12736}，27級時",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}站在伐木營地。夜精靈的梣谷先驅者在營地東南方的樹林中潛行；他們會潛行，要留意。",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一個任務「奧達努斯」在{zone:1440}的聯盟那一側。跳過。",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}，在大門外",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606}站在{object:36070}。",
}
