-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/01b-riverglades (forever/horde/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16743} Rog'mar
	["About 70 quests in Forever's new zone, from the fort of {area:16743}."] = "Forever新地區約70個任務，從{area:16743}要塞出發。",

	-- Step 1: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "飛往{area:340}",
	-- {zone:2548} Riverglades · {area:3} Badlands · {area:75} Stonard · {area:340} Kargath
	["The {zone:2548} lie south of the {area:3}. Fly from {area:75} to {area:340}: the way down into the zone starts there."] = "",
	-- {area:75} Stonard
	["{area:75} flight master"] = "{area:75}飛行管理員",

	-- Step 2: Into the Riverglades
	-- {area:16591} Riverglades
	["Into the {area:16591}"] = "進入{area:16591}",
	-- {area:16591} Riverglades · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {area:16743} Rog'mar
	["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley."] = "Forever新內容：本指南依照玩家在{area:16591}的實際進度編寫。若有步驟錯誤，請在Polestar的Discord或GitHub告訴我們，並註明是哪個步驟。\n從{area:340}向東南騎過{area:3}，到達該地區南緣：{area:16685}的山道會往下通往{area:16591}。部落的要塞{area:16743}位於地區中央，沿山谷往東走即可到達。",

	-- Step 3: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飛往{area:484}",
	-- {zone:2548} Riverglades · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port · {area:484} Freewind Post · {zone:1441} Thousand Needles · {area:439} Shimmering Flats · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud
	["New in Forever: this guide follows what players did in the {zone:2548}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe {zone:2548} lie across the sea from {zone:1446}: a goblin boat sails from {area:977}, north-east of {area:976}, to {area:16727}. Fly to {area:484} in {zone:1441} and head south-east through the {area:439} to {area:976}. (If you already know {area:340} in the {area:3}, the way in through {area:16685} works too.)"] = "Forever新內容：本指南依照玩家在{zone:2548}的實際進度編寫。若有步驟錯誤，請在Polestar的Discord或GitHub告訴我們，並註明是哪個步驟。\n{zone:2548}與{zone:1446}隔海相望：哥布林的船從{area:976}東北方的{area:977}開往{area:16727}。飛往{zone:1441}的{area:484}，再向東南穿過{area:439}前往{area:976}。（如果你已經有{area:3}的{area:340}飛行路線，也可以從{area:16685}進入。）",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["Learn {area:976}'s flight path: it saves the ride next time."] = "學會{area:976}的飛行路線：下次就不用騎過來了。",

	-- Step 5: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "搭船前往{area:16727}",
	-- {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port
	["{area:977} is on the coast north-east of {area:976}: wait on the pier for the goblin boat to {area:16727}."] = "{area:977}在{area:976}東北方的海岸：在碼頭等候開往{area:16727}的哥布林船。",

	-- Step 6: Powderfuse Port
	-- {npc:255897} Friz Frazzlespark
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{npc:255897} keeps a stall at the west end of the docks. The port's other jobs are for later in this guide: this crate goes to the Horde's fort."] = "Forever新內容：若有步驟錯誤，請在Polestar的Discord或GitHub告訴我們，並註明是哪個步驟。\n{npc:255897}在碼頭西端擺攤。港口的其他任務留待本指南稍後再做：這個箱子要送到部落的要塞。",
	-- {quest:95062} Frazzlespark's Crate · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95062}: for {npc:256418} in {area:16743}"] = "{quest:95062}：交給{area:16743}的{npc:256418}",

	-- Step 7: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "{npc:263367}的工坊",
	-- {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["West up the road from the port: {npc:263367} has his workshop on the hill. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "從港口沿道路往西走：{npc:263367}的工坊在山丘上。氣體噴口在工坊西南方的沼澤裡，第一次替{npc:258031}狩獵時順路。",

	-- Step 8: Rog'mar
	-- {area:16743} Rog'mar · {npc:258031} Neza Bloodsnout · {npc:256657} Kreza Darkthorn · {npc:256418} Krom'rosh · {npc:255993} Grakna · {npc:256675} Innkeeper Toka · {npc:263190} Tan'jani
	["West to {area:16743}, the Horde's fort in the middle of the zone. {npc:258031} stands on its east side, {npc:256657} and {npc:256418} in the middle with {npc:255993}, the wind rider master; {npc:256675} and {npc:263190} on the west side."] = "向西前往部落位於地區中央的要塞{area:16743}。{npc:258031}站在要塞東側，{npc:256657}和{npc:256418}在中央，旁邊是雙足飛龍管理員{npc:255993}；{npc:256675}和{npc:263190}在西側。",
	-- {npc:256418} Krom'rosh · {object:3202} Grom'gol
	["{npc:256418}: Aggro'gosh's report from {object:3202}, if you carry it"] = "{npc:256418}：如果你帶著來自{object:3202}的阿格羅高許報告，交給他",
	-- {npc:255993} Grakna
	["{npc:255993}, in the middle of the fort"] = "{npc:255993}，在要塞中央",
	-- {npc:263190} Tan'jani · {quest:95033} On the Other Side · {npc:8115} Witch Doctor Uzer'i · {area:1099} Camp Mojache · {zone:1444} Feralas
	["{npc:263190}: {quest:95033}, for {npc:8115} at {area:1099} in the {zone:1444} guide"] = "{npc:263190}：{quest:95033}，交給{zone:1444}指南中{area:1099}的{npc:8115}",

	-- Step 9: Krom'rosh
	-- {npc:256418} Krom'rosh
	["Frazzlespark's crate from the port goes to {npc:256418}, in the middle of the fort."] = "把從港口帶來的弗拉茲斯巴克的箱子交給要塞中央的{npc:256418}。",

	-- Step 10: Sleebo Fizzlespout's workshop
	-- {area:16727} Powderfuse Port · {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["East of Rog'mar, on the hill above the road to {area:16727}: {npc:263367} has his workshop there. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "在洛格瑪東邊，通往{area:16727}道路上方的山丘：{npc:263367}的工坊就在那裡。氣體噴口在工坊西南方的沼澤裡，第一次替{npc:258031}狩獵時順路。",

	-- Step 11: The plains and the marsh
	["The plains and the marsh"] = "平原與沼澤",
	-- {area:16729} Terral's Watch · {quest:96103} A Feast for Buzzards
	-- plural, as words: Low Plains Buzzards = {npc:263343} Low Plains Buzzard
	["South-east of Rog'mar the plains run down to {area:16729}. The Low Plains Buzzards circle everywhere; a picked carcass lies in the grass (its skull starts {quest:96103}), and the marsh vents are just past it."] = "洛格瑪東南方的平原一路延伸到{area:16729}。低地平原禿鷹到處盤旋；草叢裡有一具被啃光的屍骸（它的頭骨可開始{quest:96103}），沼澤噴口就在它後面不遠。",

	-- Step 12: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to the workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "向東北前往工坊。{npc:263367}的壓力測試是在工坊旁和他的G45-B4G戰鬥：打敗後繳交任務。",
	["the stress test: beat G45-B4G beside the workshop"] = "壓力測試：在工坊旁打敗G45-B4G",

	-- Step 13: Neza Bloodsnout
	-- {area:16743} Rog'mar
	["West back to {area:16743}'s east side."] = "向西回到{area:16743}的東側。",

	-- Step 14: The vipers and the tallstriders
	["The vipers and the tallstriders"] = "毒蛇與陸行鳥",
	-- {npc:257079} Cavalry Scout Alturin · {area:16729} Terral's Watch · {area:16725} Wheeler's Grange
	-- plural, as words: Glade Vipers = {npc:263307} Glade Viper · Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Glade Vipers hide in the long grass south-east of town; the Roving Tallstriders graze beside them. {npc:257079}, an Alliance elite (level 45), rides the road from {area:16729} to {area:16725} along the grass's south-west edge: keep clear of him."] = "林地毒蛇躲在鎮東南的長草叢中；漫遊陸行鳥在旁邊吃草。{npc:257079}是聯盟精英（45級），會沿著草地西南緣的道路從{area:16729}騎到{area:16725}：遠離他。",

	-- Step 16: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16743} Rog'mar
	["{npc:263315}, an elite lion (level 41), prowls the plains south of {area:16743}, where the lions are: grouping up is advised."] = "{npc:263315}是一隻精英獅子（41級），在{area:16743}南邊有獅子出沒的平原上徘徊：建議組隊。",

	-- Step 17: The lions
	["The lions"] = "獅子",
	-- {area:16743} Rog'mar · {npc:263315} Ombassa
	["The Wildplains lions roam the plains just south of {area:16743}.\nCareful: {npc:263315}, an elite lion (level 41), prowls the same plains around 59.6,53.2: keep an eye out for him and pull the lions away from where he walks."] = "荒原獅在{area:16743}南邊不遠的平原上遊蕩。\n小心：精英獅子{npc:263315}（41級）也在同一片平原的59.6,53.2附近徘徊：留意他的位置，把獅子拉離他走動的路線。",

	-- Step 20: Neza Bloodsnout's elites
	-- {npc:258031} Neza Bloodsnout
	["{npc:258031}'s elites"] = "{npc:258031}的精英",

	-- Step 21: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906}是精英豺狼人（等級40），在{area:16737}西南方的營地遊蕩：建議組小隊。",

	-- Step 23: Turner's Logging Camp
	-- {npc:263380} Ghostmaw
	-- plural, as words: Wood Bundles = {item:271629} Wood Bundle · Peasant Woodpiles = {object:645516} Peasant Woodpile · Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["South-west across the river to the Alliance lumber camp. The lumberjacks carry the axes. Loot Wood Bundles from the Peasant Woodpiles around the camp and use them to fletch Makeshift Stickin' Spears. {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "往西南渡河到聯盟的伐木營地。伐木工身上帶著斧頭。從營地周圍的農民柴堆拾取一捆木材，用來製作臨時戳刺長矛。精英{npc:263380}（42級）在營地旁的河邊徘徊：如果他朝你過來，就退開讓他通過。",
	-- {item:271629} Wood Bundle
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["{item:271629}, from the Peasant Woodpiles"] = "{item:271629}，從農民柴堆拾取",
	-- {item:271629} Wood Bundle
	-- plural, as words: Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["{item:271629}: fletch it into Makeshift Stickin' Spears"] = "{item:271629}：製作成臨時戳刺長矛",

	-- Step 24: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp along the slopes and carry the stolen ore. Work south-west through their camps.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "往西進入{area:16737}：赤脊豺狼人沿著山坡紮營，身上帶著被偷的礦石。往西南逐一清過他們的營地。\n小心：精英豺狼人{npc:255906}（40級）在西南方的營地遊蕩：把豺狼人拉離他。",

	-- Step 26: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["South-east out of the hills: {npc:262399}, a prospector who deals with both sides, has camped by the Cinderscale dragonkin's hollow."] = "往東南出山丘：與兩個陣營都有往來的探礦者{npc:262399}在燼鱗龍類的谷地旁紮營。",

	-- Step 27: The Cinderscale hollow
	["The Cinderscale hollow"] = "燼鱗谷地",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors guard its back, by the {item:271611}. The warriors are level 41-42: pull them one at a time. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "雛龍遍布整個谷地；戰士守在谷地後方的{item:271611}旁。戰士為41-42級：一次拉一隻。稀有精英幼龍Scaldaron也可能在這裡：除非有小隊，否則別惹他。",

	-- Step 29: Meadowsbrook
	-- {area:16735} Meadowsbrook · {area:16744} Southern Watch · {npc:263380} Ghostmaw
	["East to {area:16735}, the Alliance farm by the river: the farmhands work the fields and the feed satchels lie by the barns. {area:16744}, the Alliance outpost on the road, has guards: pass south of it.\nCareful: {npc:263380}, an elite (level 42), hunts along the river by the farm: keep an eye on the riverbank."] = "往東前往河邊的聯盟農場{area:16735}：農場工人在田裡工作，飼料袋放在穀倉旁。路上的聯盟前哨{area:16744}有守衛：從它南邊繞過。\n小心：精英{npc:263380}（42級）沿著農場旁的河流獵殺：注意河岸。",

	-- Step 30: Rog'mar
	-- {area:16743} Rog'mar · {npc:263190} Tan'jani · {npc:256418} Krom'rosh · {npc:256655} Gorg · {npc:256657} Kreza Darkthorn · {npc:258031} Neza Bloodsnout
	["Back to {area:16743}, where your Hearthstone is set: {npc:263190} on the fort's west side first, then {npc:256418}, {npc:256655} by the cook fire, {npc:256657} and {npc:258031} on your way east through the fort."] = "回到設定爐石的{area:16743}：先找堡壘西側的{npc:263190}，然後往東穿過堡壘時找{npc:256418}、營火旁的{npc:256655}、{npc:256657}和{npc:258031}。",
	-- {npc:256655} Gorg
	["{npc:256655}, by the cook fire"] = "{npc:256655}，在營火旁",
	-- {quest:93976} The Goblin Trader · {npc:255897} Friz Frazzlespark · {area:16727} Powderfuse Port
	["{quest:93976}: for {npc:255897} in {area:16727}, keep it"] = "{quest:93976}：要交給{area:16727}的{npc:255897}，先留著",

	-- Step 32: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16743} Rog'mar
	["{npc:263380} is an elite (level 42) who hunts along the river south-west of {area:16743}, by the Farholde camp you go to next: grouping up is advised. The poster hangs in the middle of the fort."] = "{npc:263380}是精英（42級），在{area:16743}西南的河邊獵殺，就在你接下來要去的遠岸營地旁：建議組隊。告示貼在堡壘中央。",
	-- {object:645164} WANTED! (no name in this language: may be words)
	["the {object:645164} poster"] = "{object:645164}告示",

	-- Step 33: The training grounds
	["The training grounds"] = "訓練場",
	-- {npc:256655} Gorg · {item:265066} Hearty Stew · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Trainees = {npc:256749} Rog'mar Trainee
	["North of the fort the Rog'mar Trainees drill: use {npc:256655}'s {item:265066} on them.\nCareful: {npc:263380}, an elite (level 42), can come up from the river south of the fort: let him pass."] = "堡壘北邊有羅格瑪受訓者在操練：對他們使用{npc:256655}的{item:265066}。\n小心：精英{npc:263380}（42級）可能從堡壘南邊的河流上來：讓他過去。",

	-- Step 35: The river and the Farholde camp
	["The river and the Farholde camp"] = "河流與遠岸營地",
	-- {npc:263190} Tan'jani · {npc:257079} Cavalry Scout Alturin · {npc:263380} Ghostmaw
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["South-west of Rog'mar the river runs between the farms: impale the Freshwater Crocolisks with {npc:263190}'s spears. The Alliance trains its scouts and priests at a camp on the far bank. {npc:257079}, the Alliance elite, rides the road just east of the camp: pull the scouts and priests away from it.\nCareful: {npc:263380}, an elite (level 42), hunts along this river: if he comes your way, back off and let him pass."] = "在羅格瑪西南方，河流從農田之間流過：用{npc:263190}的長矛刺穿淡水鱷魚。聯盟在對岸的營地訓練斥候和牧師。聯盟精英{npc:257079}騎馬巡邏營地東邊不遠的道路：把斥候和牧師拉離那裡再打。\n小心：精英{npc:263380}（42級）沿著這條河狩獵：如果他朝你過來，先退開讓他過去。",
	-- {npc:263190} Tan'jani
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["{npc:263190}'s spears, on the Freshwater Crocolisks in the river"] = "{npc:263190}的長矛，在河裡的淡水鱷身上",

	-- Step 39: Tran'gul
	-- {npc:256710} Tran'gul · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["{npc:256710} stands beside {npc:256418} in the middle of {area:16743}: now that the Farholde camp has had its lesson, he has work in {area:16723}."] = "{npc:256710}站在{area:16743}中央的{npc:256418}旁邊：既然遠岸營地已經受到教訓，他在{area:16723}還有工作要交給你。",

	-- Step 40: Fuzzle
	-- {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, waits in a cage at the arrow."] = "",
	-- {quest:94961} Biting the Hand · {npc:259158} Fuzzle
	["{quest:94961}, {npc:259158} in his cage"] = "",

	-- Step 41: Sunnyglade
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade
	["The cultists fill the streets and fields; the Shadowmancers on the town's northern side carry the missives. The finger bones drop from all of them.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass."] = "教徒遍布街道和田野；村子北側的暗影法師帶著密函。他們全都會掉落指骨。\n小心：精英食人魔{npc:256899}（41級）在{area:16723}西側街道巡邏，約在44-47,47-52。把教徒拉向你，讓他走過去。",

	-- Step 42: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158}想離開{area:16723}：帶他向西走到城鎮邊緣的寶藏處，別讓教徒靠近他。",
	-- {npc:259158} Fuzzle
	["{npc:259158} in his cage"] = "",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "帶{npc:259158}離開{area:16723}，前往城鎮西邊他的寶藏",

	-- Step 43: Tran'gul
	-- {area:16743} Rog'mar
	["East back to {area:16743}."] = "向東回到{area:16743}。",
	-- {quest:94727} Digging for Answers · {npc:260931} Clubtoe · {area:16723} Sunnyglade
	["{quest:94727}: for {npc:260931} in {area:16723}"] = "{quest:94727}：交給{area:16723}的{npc:260931}",

	-- Step 44: Clubtoe
	-- {area:16723} Sunnyglade · {npc:260931} Clubtoe · {npc:256710} Tran'gul
	["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits inside the cave under the town's eastern edge, a floor below the street. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "再次向西前往{area:16723}：想脫身的暮光礦工{npc:260931}在城鎮東邊下方的洞穴裡等候，比街道低一層。說服他，然後繳交{npc:256710}的任務；一個失蹤的巨魔就在西邊幾步遠。",
	-- {npc:260931} Clubtoe
	["talk {npc:260931} round"] = "說服{npc:260931}",
	-- {npc:261208} Twilight Brute
	["{npc:261208}, a few steps west"] = "{npc:261208}，在西邊幾步遠",

	-- Step 45: The ritual grounds
	["The ritual grounds"] = "儀式場地",
	-- {area:16723} Sunnyglade · {npc:256899} Chogg'Zac
	["The ritualists and their empowered brutes gather at the ritual circles in the middle of {area:16723}: wreck five of the circles.\nCareful: {npc:256899}, the elite ogre (level 41), walks through here from the western streets: watch for him before each pull."] = "儀式師和他們強化過的蠻兵聚集在{area:16723}中央的儀式法陣：摧毀五個法陣。\n小心：精英食人魔{npc:256899}（41級）會從西側街道走過這裡：每次拉怪前留意他。",
	-- plural, as words: Twilight Ritual Circles = {npc:262006} Twilight Ritual Circle
	["destroy 5 Twilight Ritual Circles"] = "摧毀5個暮光儀式法陣",

	-- Step 47: Twilight No More!
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:260931} Clubtoe · {quest:95420} Land of Giants · {npc:255829} Clugfist · {quest:94668} Bloodmaster's Ring · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised. {npc:260931} wants both his heads, and the rest of the zone's ogre story waits on them: {quest:95420}, {npc:255829}'s quests and the {quest:94668} in {area:16726}, then {npc:258570}'s camp in the west (about 21,000 XP in all). Skip him and the guide leaves those out."] = "",

	-- Step 48: Chogg'Zac
	["Clear the cultists around him first and come in with full health and mana."] = "",

	-- Step 49: Clubtoe
	-- {quest:95418} Spread the Word · {npc:256710} Tran'gul · {area:16743} Rog'mar
	["{quest:95418}: for {npc:256710} in {area:16743}"] = "{quest:95418}：交給{area:16743}的{npc:256710}",

	-- Step 50: Tran'gul
	-- {area:16743} Rog'mar · {npc:260931} Clubtoe · {npc:256710} Tran'gul · {npc:255829} Clugfist
	["East back to {area:16743}: {npc:260931}'s word goes to {npc:256710}, and {npc:256710}'s to {npc:255829}, the ogres' chieftain."] = "向東回到{area:16743}：把{npc:260931}的話帶給{npc:256710}，再把{npc:256710}的話帶給食人魔酋長{npc:255829}。",
	-- {quest:95420} Land of Giants · {npc:255829} Clugfist · {area:16726} Bolder'ok
	["{quest:95420}: for {npc:255829} in {area:16726}"] = "{quest:95420}：交給{area:16726}的{npc:255829}",

	-- Step 51: WANTED: Scoutmaster Vargas
	-- {npc:260211} Scoutmaster Vargas · {npc:256728} Na'zok · {npc:258031} Neza Bloodsnout
	["{npc:260211} is an elite (level 42) at the Alliance scouts' camp in the hills south-east of {npc:256728}, where you go next: grouping up is advised. The poster hangs in the middle of the fort; {npc:258031} takes the eye, later in this guide."] = "{npc:260211}是精英（42級），位於{npc:256728}東南方山丘上的聯盟斥候營地，也就是你接下來要去的地方：建議組隊。告示貼在堡壘中央；眼睛交給{npc:258031}，在本指南稍後。",
	["the Wanted poster"] = "",

	-- Step 52: Na'zok's camp
	-- {npc:256728} Na'zok
	["{npc:256728}'s camp"] = "{npc:256728}的營地",
	-- {area:16743} Rog'mar · {npc:256728} Na'zok
	["North-east from {area:16743} up into the hills: {npc:256728} watches the Paletusk boars from his camp."] = "從{area:16743}向東北上山：{npc:256728}在他的營地看守著白牙野豬。",

	-- Step 53: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:255829} Clugfist
	["North-west to {area:16726}, the ogres' town. {npc:255829}, its chieftain, sits on the hill. The ogres are friendly while you leave them alone."] = "向西北前往食人魔的城鎮{area:16726}。酋長{npc:255829}坐在山丘上。只要你不招惹他們，食人魔就是友善的。",

	-- Step 54: The Twilight ogres' camp
	["The Twilight ogres' camp"] = "暮光食人魔的營地",
	-- {npc:256728} Na'zok · {npc:260973} Klunk · {item:269257} Skullbasher · {npc:260211} Scoutmaster Vargas
	-- plural, as words: Twilight Maulers = {npc:260968} Twilight Mauler · Farholde Ambushers = {npc:260023} Farholde Ambusher
	["The Twilight Maulers and Firecallers camp on the ridge east of {npc:256728}. {npc:260973}, who carries the {item:269257}, stands among them. Just south of the ogres, {npc:260211} (an Alliance elite, level 42) and his Farholde Ambushers hold the scouts' camp: keep north of it unless you came with a group for him."] = "暮光重錘手和喚火者在{npc:256728}東邊的山脊上紮營。攜帶{item:269257}的{npc:260973}就站在他們之中。食人魔營地南邊不遠處，{npc:260211}（聯盟精英，42級）和他的法霍爾德伏擊者佔據著斥候營地：除非你組了小隊來打他，否則待在營地北邊。",
	-- {item:269257} Skullbasher · {npc:260973} Klunk
	["{item:269257}, from {npc:260973}"] = "{item:269257}，來自{npc:260973}",

	-- Step 56: The paletusks
	["The paletusks"] = "白牙野豬",
	-- {npc:256728} Na'zok
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk · Mature Paletusks = {npc:255851} Mature Paletusk
	["South down the hills, round the west side of the Alliance scouts' camp: tap the Young Paletusks with {npc:256728}'s staff to send them home; the Mature Paletusks around the hills drop the boar meat."] = "向南下山，繞過聯盟斥候營地的西側：用{npc:256728}的法杖輕敲年幼的白牙野豬，把牠們趕回家；山丘周圍的成年白牙野豬會掉落野豬肉。",
	-- {item:268521} Swineherd's Staff
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk
	["{item:268521}, on the Young Paletusks"] = "{item:268521}，對年幼的白牙野豬使用",
	-- {item:769} Chunk of Boar Meat
	-- plural, as words: Mature Paletusks = {npc:255851} Mature Paletusk
	["{item:769}, from the Mature Paletusks"] = "{item:769}，來自成年白牙野豬",

	-- Step 58: Jom-jom's Escape
	-- {npc:258048} Jom-jom · {npc:256728} Na'zok · {area:16726} Bolder'ok
	["{npc:258048} waits at the back of the cave by the Twilight ogres' camp north-east of {npc:256728}: go all the way in to find him, then take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "",
	-- {npc:258048} Jom-jom
	["{npc:258048}, in the cave"] = "{npc:258048}，在洞穴裡",
	-- {npc:258048} Jom-jom · {area:16726} Bolder'ok
	["help {npc:258048} reach {area:16726}"] = "幫助{npc:258048}抵達{area:16726}",

	-- Step 59: Bolder'ok
	-- {npc:255829} Clugfist · {npc:257062} Jezap Jinglesprocket · {quest:94668} Bloodmaster's Ring
	["Back to {npc:255829} on his hill. {npc:257062} runs the {quest:94668} just below it."] = "回到山丘上的{npc:255829}那裡。{npc:257062}在山下主持{quest:94668}。",

	-- Step 60: Clugfist
	-- {quest:95428} Clugfist's Decree · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95428}: for {npc:256418} in {area:16743}, later in this guide"] = "{quest:95428}：交給{area:16743}的{npc:256418}，在本指南稍後",
	-- {quest:94669} Pay to Play
	["{quest:94669}: the Ring's bouts, one-on-one fights with elites (41-45); a deposit first"] = "{quest:94669}：競技場的對戰，與精英一對一戰鬥（41-45）；需先支付押金",

	-- Step 61: The Bloodmaster's Ring: Buzzbeak
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Buzzbeak"] = "{quest:94670}：嗡嗡喙",
	-- {npc:255829} Clugfist · {npc:258626} Mog'thar · {npc:257059} Chub'chob · {npc:257062} Jezap Jinglesprocket
	["Each bout is a fight in the ring below {npc:255829}'s hill against an elite: Buzzbeak (41), Kronk and Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) and {npc:257059} (45). Come in rested, with full health and mana; if a bout goes wrong, {npc:257062} offers it again."] = "每場對戰都是在{npc:255829}的山丘下方競技場與一名精英戰鬥：嗡嗡喙（41）、克隆克和啃骨者（42）、{npc:258626}（43）、嗅嗅鼻（44）和{npc:257059}（45）。進場前先休息，保持滿血滿魔；如果對戰失利，{npc:257062}會讓你再挑戰一次。",
	-- {quest:94670} Bloodmaster's Ring
	["{quest:94670}: Buzzbeak"] = "{quest:94670}：嗡嗡喙",
	["beat Buzzbeak"] = "擊敗嗡嗡喙",

	-- Step 62: The Bloodmaster's Ring: Kronk and Bonegnaw
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Kronk and Bonegnaw"] = "{quest:94670}：克隆克和啃骨者",
	["Kronk"] = "克隆克",
	["Bonegnaw"] = "啃骨者",

	-- Step 63: The Bloodmaster's Ring: Mog'thar
	-- {quest:94962} Bloodmaster's Ring · {npc:258626} Mog'thar
	["The {quest:94962}: {npc:258626}"] = "{quest:94962}：{npc:258626}",
	-- {npc:258626} Mog'thar · {npc:257058} Gobam · {npc:263440} Hamur
	["{npc:258626} is a level 43 elite, at or above your level here: a hard one-on-one fight in the ring, where nobody can help you. Take it only rested, with full health and mana; {npc:257058}'s and {npc:263440}'s errands and the last two bouts come after him."] = "",

	-- Step 64: Gobam and Hamur
	-- {npc:257058} Gobam · {npc:263440} Hamur
	["{npc:257058} and {npc:263440}"] = "",
	-- {npc:258626} Mog'thar · {npc:257062} Jezap Jinglesprocket · {npc:257058} Gobam · {npc:263440} Hamur · {area:16727} Powderfuse Port · {item:265806} Riverweed · {area:16743} Rog'mar · {area:16726} Bolder'ok
	["With {npc:258626} beaten, {npc:257062} sends you to {npc:257058}, who keeps the Ring's beasts a few steps north-east of the ring; {npc:263440}, just south of the ring, wants good rock. {npc:257058}'s boar treat needs Sweetberries from the pirates' slopes north of {area:16727} and {item:265806} from the river between {area:16743} and {area:16726}: this guide gathers both and brings you back here after the port, for the Ring's last two bouts."] = "",

	-- Step 65: The rock piles
	["The rock piles"] = "",
	-- {area:16726} Bolder'ok · {npc:263440} Hamur
	["South-east from {area:16726} on the way down to the port: {npc:263440}'s rock piles lie in the hills just south of the town and on the slopes west of the Twilight ogres' camp."] = "",

	-- Step 66: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz
	["South-east down out of the hills to {area:16727}, the goblins' harbour on the coast. {npc:255897} keeps a stall at the west end of the docks, {npc:259962} cooks by the inn, and {npc:259961} works the north pier."] = "往東南下山前往{area:16727}，也就是地精在海岸的港口。{npc:255897}在碼頭西端擺攤，{npc:259962}在旅店旁烹飪，{npc:259961}在北碼頭工作。",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "旅店旁的{object:628948}告示：{npc:260235}",

	-- Step 67: Wharfmaster Whizzbuzz
	-- {npc:259961} Wharfmaster Whizzbuzz · {item:277974} Twice Reordered Package
	["{npc:259961} on the north pier takes Lozgil's {item:277974}."] = "北碼頭的{npc:259961}收下洛茲吉爾的{item:277974}。",

	-- Step 68: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001}是南岸的精英（42級）：建議組隊。",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "旅店旁的{object:628948}告示",

	-- Step 69: The murlocs, south-west
	["The murlocs, south-west"] = "西南方的魚人",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "從港口沿海岸往西南走：鹹水魚人在海灘上紮營。途中路旁撐著一張彩繪獸皮：它會開始{quest:95260}，交給碼頭的{npc:260231}。",

	-- Step 71: Back through the port
	["Back through the port"] = "穿過港口回去",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "沿海岸往北回去：前往爬行者的路上，在碼頭繳交魚人和獸皮任務。",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms grow on the ridge west of the pirates"] = "{quest:95261}：野獸內臟沿路收集；蘑菇長在海盜西邊的山脊上",

	-- Step 72: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "順路收集{item:268632}",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42) wanders the shore and {npc:263380} (elite, 42) the river: take your beasts away from them."] = "{zone:2548}的大部分野獸都會掉落{item:268632}，交給{npc:260231}：這片海岸的海岸爬行者和海盜西邊山脊上的野豬。\n小心：{npc:257001}（精英，42）在海岸遊蕩，{npc:263380}（精英，42）在河中遊蕩：把野獸拉離牠們再打。",

	-- Step 73: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "爬行者和{npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962}, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "從碼頭沿海灘往北：爬行者會掉落給{npc:259962}的肉，牠們的內臟也算{npc:260231}的任務。{npc:260235}是一隻大螃蟹，在碼頭東邊的岩石上爬行。{npc:259758}是49級的稀有精英，在從碼頭到海盜營地的這段海岸遊蕩：如果看到他，離遠一點。",

	-- Step 74: The Eastsea pirates
	["The Eastsea pirates"] = "東海海盜",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "沿著海岸向東北前往懸崖上的海盜營地。海盜和火槍手身上帶著走私貨物。{npc:259758}也會在營地裡走動：留意他的蹤影。",

	-- Step 75: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "回到港口，從北邊碼頭向西穿過船塢。",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}：交給海盜營地的{npc:260390}",

	-- Step 77: The pirates' second wave
	["The pirates' second wave"] = "海盜的第二波",
	-- {npc:259758} Gul'gash
	-- plural, as words: Eastsea Raiders = {npc:257915} Eastsea Raider
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "從港口沿海岸往北：東海劫掠者和投彈手在海盜營地西邊的山坡上、火藥桶之間紮營。在這些懸崖上注意{npc:259758}。\n小心：東海劫掠者是44-45級，比你高一兩級：從山坡邊緣一次拉一隻，並遠離他們後方的營地。",

	-- Step 78: Sweetberries
	["Sweetberries"] = "",
	-- {npc:257058} Gobam · {item:265808} Sweetberry
	["{npc:257058}'s {item:265808} bushes grow on these slopes among the raiders' powder kegs, the last one a little to the north."] = "",

	-- Step 79: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "沿著懸崖向東前往海盜營地的盡頭：{npc:260390}在水邊等你，{npc:260391}就在他旁邊。",

	-- Step 80: Powderfuse Port
	["Back to the port."] = "回到港口。",
	-- {npc:255897} Friz Frazzlespark · {quest:95296} Shipping and Handling · {npc:260405} Wharfmaster Steamfizzle · {area:977} Steamwheedle Port · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:255897}: {quest:95296}, for {npc:260405} at {area:977} in the {zone:1444} & {zone:1446} guide"] = "{npc:255897}：{quest:95296}，之後在{zone:1444}與{zone:1446}指南中交給{area:977}的{npc:260405}",

	-- Step 81: The pirates' ships
	["The pirates' ships"] = "海盜船",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	-- was: ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "再次前往海盜的懸崖。由南到北，在營地下方停泊的三艘船上安放威茲巴茲的炸藥；{quest:95124}站在中間那艘旁邊，她的戰利品箱就在旁邊。途中留意{npc:259758}。\n小心：{quest:95124}是45級，比你高一兩級：先清掉她周圍甲板上的敵人，滿血再上。"
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north. {quest:95124} walks the middle ship's top deck; her loot chest is below deck. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "",
	["on board, at the arrow"] = "在船上，箭頭處",
	-- {item:268505} Remote Explosive Charge
	["Plant a {item:268505} on the southern ship"] = "在南邊的船上安放{item:268505}",
	-- {item:268505} Remote Explosive Charge
	["Plant a {item:268505} on the middle ship"] = "在中間的船上安放{item:268505}",
	-- {item:268505} Remote Explosive Charge
	["Plant a {item:268505} on the northern ship"] = "在北邊的船上安放{item:268505}",

	-- Step 82: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "腐肉蘑菇",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "從北邊的船往西爬上山脊：腐肉蘑菇長在岩石間，靠近暮光食人魔的營地。山脊上的成年白牙象也會掉內臟。",

	-- Step 83: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "收集完{item:268632}",
	-- {npc:259758} Gul'gash
	["South-east back towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "往東南回到港口：碼頭北邊海灘上的海岸爬行者是收集內臟最快的方式。{npc:259758}也會遊蕩到這片海灘。",

	-- Step 84: Powderfuse Port
	["Down to the port."] = "下到港口。",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}：港口西南方淺水區的一隻巨獸，靠近精英{npc:257001}",

	-- Step 85: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} comes up when you call him: right-click the thing floating in the water at the arrow, in the shallows south-west of the port, and he surfaces there. {npc:257001}, an elite, walks the shore close by: give him room."] = "你召喚時{npc:260244}會浮上來：右鍵點擊箭頭處漂在水裡的東西，在港口西南的淺水區，牠就會在那裡浮出水面。精英{npc:257001}在附近的岸邊走動：離他遠點。",
	-- {item:268633} Sea Monster's Head
	["{item:268633}, where the Threshadon surfaces when you call him"] = "{item:268633}，在你召喚時脫顎龍浮出水面的地方",

	-- Step 87: The river: Riverweed
	-- {item:265806} Riverweed
	["The river: {item:265806}"] = "",
	-- {area:16726} Bolder'ok · {npc:257058} Gobam · {item:265806} Riverweed · {area:16743} Rog'mar
	["From the port, ride north-west to the river and follow it upstream towards {area:16726}: {npc:257058}'s {item:265806} grows along its banks between {area:16743} and {area:16726}."] = "",

	-- Step 89: Gobam
	-- {area:16726} Bolder'ok · {npc:263440} Hamur · {npc:257058} Gobam · {npc:257062} Jezap Jinglesprocket
	["North up the river to {area:16726}: {npc:263440} just south of the ring, {npc:257058} north-east of it, then {npc:257062}."] = "",

	-- Step 90: The Bloodmaster's Ring: Snufflesnout
	-- {quest:94965} Bloodmaster's Ring
	["The {quest:94965}: Snufflesnout"] = "",
	["Snufflesnout (44) is elite: a hard one-on-one fight in the ring, where nobody can help you. Come in rested, with full health and mana."] = "",
	["Snufflesnout (44)"] = "嗅嗅鼻（44）",

	-- Step 91: The Bloodmaster's Ring: Chub'chob
	-- {quest:94965} Bloodmaster's Ring · {npc:257059} Chub'chob
	["The {quest:94965}: {npc:257059}"] = "",
	-- {npc:257059} Chub'chob
	["{npc:257059} (45) is elite: a hard one-on-one fight in the ring, where nobody can help you. Come in rested, with full health and mana."] = "",
	-- {npc:255829} Clugfist
	["{npc:255829}, on the hill"] = "{npc:255829}，在山丘上",

	-- Step 92: Rog'mar
	-- {area:16743} Rog'mar · {area:16726} Bolder'ok · {npc:256418} Krom'rosh · {npc:255829} Clugfist · {npc:258570} Da'grosh
	-- was: ["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "從港口回到{area:16743}，你的爐石設在那裡。堡壘中央的{npc:256418}：{npc:255829}的話讓他派你去找{npc:258570}，他在西方的戰士。"
	["Back to {area:16743}: from {area:16726} south-west down the river, or from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "",
	-- {quest:94744} The Wayward Warrior · {npc:258570} Da'grosh · {area:16723} Sunnyglade
	["{quest:94744}: for {npc:258570}, west of {area:16723}"] = "{quest:94744}：之後給{area:16723}西邊的{npc:258570}",

	-- Step 94: Fly to Kargath
	-- {npc:258570} Da'grosh · {npc:256899} Chogg'Zac · {zone:2548} Riverglades · {area:16743} Rog'mar · {npc:255993} Grakna · {area:340} Kargath · {area:3} Badlands
	["The rest of this guide is {npc:258570}'s camp in the west, which waits on {npc:256899}: without him the {zone:2548} end here. Back to {area:16743} from the port, where your Hearthstone is set: {npc:255993}, the wind rider master in the middle of the fort, flies to {area:340} in the {area:3}, where the next guide starts."] = "",

	-- Step 95: Da'grosh
	-- {area:16743} Rog'mar · {area:16723} Sunnyglade · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {npc:256418} Krom'rosh
	["West from {area:16743} through {area:16723} and on up the valley towards {area:16685}: {npc:258570}, {npc:256418}'s wayward warrior, keeps a camp in the hills below the Twilight cult's fortress."] = "從{area:16743}往西穿過{area:16723}，再沿山谷往{area:16685}走：{npc:256418}那位迷途的戰士{npc:258570}在暮光教派堡壘下方的山丘中紮營。",

	-- Step 96: Crag'rog
	-- {npc:260993} Crag'rog · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:260993}, a {area:16726} ogre, hides in the cave west of {npc:258570}'s camp."] = "{npc:260993}是{area:16726}的食人魔，躲在{npc:258570}營地西邊的洞穴裡。",

	-- Step 97: The Twilight camps
	["The Twilight camps"] = "暮光營地",
	-- {npc:258570} Da'grosh · {item:265821} Twilight Key · {npc:257450} Rog'mar Scout · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg · {npc:258023} Sergeant Riftan
	-- plural, as words: Twilight Champions = {npc:256799} Twilight Champion · Twilight Enforcers = {npc:256800} Twilight Enforcer · Farholde Lookouts = {npc:258686} Farholde Lookout
	-- was: ["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "暮光教派的營地遍布{npc:258570}南邊和西邊的山谷。沿途遇到被俘的羅格瑪斥候就救出來。暮光執行者（精英，45級）會在營地間巡邏：每次拉怪前先看清他們的路線。{npc:256881}和{npc:256891}（精英，46級）駐守在山谷盡頭的堡壘：把教徒拉離他們身邊。{npc:258023}的聯盟營地位於山谷南端，那裡的法霍德瞭望者（46級）會攻擊部落：待在營地北邊。"
	["The cult's camps fill the valley south and west of {npc:258570}. Twilight Champions drop the {item:265821} that frees a captive {npc:257450}: free them as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "",
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout
	["free five captive Rog'mar Scouts"] = "救出五名被俘的羅格瑪斥候",

	-- Step 98: The ogre mine
	["The ogre mine"] = "食人魔礦坑",
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine: talk five of them into rising up against their masters.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in."] = "營地北邊，教派在一座礦坑裡奴役食人魔礦工：說服其中五名起來反抗他們的主人。\n小心：暮光執行者（精英，45級）巡邏經過營地時會走過礦坑入口。等一隻走過後再進去。",
	-- plural, as words: Ogre Miners = {npc:260995} Ogre Miner
	["recruit five Ogre Miners"] = "招募五名食人魔礦工",

	-- Step 101: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881}是精英（46級），位於谷底盡頭的要塞中，身邊有執行者：建議組小隊。",

	-- Step 102: Twilight's Shroud
	-- {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["The next guide flies from {area:340} in the {area:3}: up through {area:16685}, the pass at the valley's north-west end, just north of {npc:258570}'s camp. Coming from {area:16743}, ride west through {area:16723} and keep north of the Twilight camps below the pass."] = "",

	-- Step 103: Kargath
	-- {area:3} Badlands · {area:340} Kargath
	["Across the {area:3} to {area:340}, the Horde fortress built into the cliffs at the zone's western edge: its flight master stands at the foot of the fortress."] = "穿越{area:3}前往{area:340}，這座部落堡壘建在地區西緣的峭壁中：飛行管理員就站在堡壘腳下。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "從港口回到{area:16743}，你的爐石設在那裡。堡壘中央的{npc:256418}：{npc:255829}的話讓他派你去找{npc:258570}，他在西方的戰士。",
	-- ["Careful: {npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised under 43. Clear the cultists around him first and come in with full health and mana: recorded players of 42-43 killed him alone. {npc:255829}'s quests in {area:16726} wait on this one: skip him and {quest:95420}, the {area:16726} quests and {npc:258570}'s camp in the west go with him (about 21,000 XP); the guide then leaves them out."] = "小心：{area:16723}西緣的雙頭食人魔{npc:256899}是精英（41級）：43級以下建議組隊。先清掉他周圍的教徒，滿血滿魔再上：有42-43級的玩家單殺過他。{npc:255829}在{area:16726}的任務取決於這一隻：跳過他的話，{quest:95420}、{area:16726}的任務和西邊{npc:258570}的營地都會一併放棄（約21,000經驗值）；之後指南會略過這些。",
	-- ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "再次前往海盜的懸崖。由南到北，在營地下方停泊的三艘船上安放威茲巴茲的炸藥；{quest:95124}站在中間那艘旁邊，她的戰利品箱就在旁邊。途中留意{npc:259758}。\n小心：{quest:95124}是45級，比你高一兩級：先清掉她周圍甲板上的敵人，滿血再上。",
	-- ["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "暮光教派的營地遍布{npc:258570}南邊和西邊的山谷。沿途遇到被俘的羅格瑪斥候就救出來。暮光執行者（精英，45級）會在營地間巡邏：每次拉怪前先看清他們的路線。{npc:256881}和{npc:256891}（精英，46級）駐守在山谷盡頭的堡壘：把教徒拉離他們身邊。{npc:258023}的聯盟營地位於山谷南端，那裡的法霍德瞭望者（46級）會攻擊部落：待在營地北邊。",
	-- ["The next guide flies from {area:340} in the {area:3}: north out of {npc:258570}'s valley and up through {area:16685}, the way through to the {area:3}."] = "下一個指南從{area:3}的{area:340}起飛：往北離開{npc:258570}的山谷，穿過{area:16685}，那是通往{area:3}的路。",
	-- ["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244}在港口西南方的淺水區徘徊，位於魚人海灘下方。精英{npc:257001}就在附近岸邊走動：離他遠一點。",
	-- ["The {quest:94964}: Snufflesnout and {npc:257059}"] = "{quest:94964}：嗅嗅鼻和{npc:257059}",
	-- ["The {zone:2548} lie south of the {area:3}. Ride east from the {area:657} to {area:75} and fly to {area:340}: the way down into the zone starts there."] = "{zone:2548}位於{area:3}南方。從{area:657}向東騎到{area:75}，再飛往{area:340}：進入該地區的下坡路從那裡開始。",
	-- ["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, hides in the middle of the town."] = "在羅格瑪西邊，暮光教派佔據了農村{area:16723}。想脫離教派的狗頭人{npc:259158}躲在村子中央。",
	-- ["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits at the town's eastern edge. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "再次向西前往{area:16723}：想脫離教派的暮光礦工{npc:260931}在村子東緣等著。說服他，然後繳交{npc:256710}的任務；其中一名失蹤的食人魔就站在西邊幾步遠。",
	-- ["the middle ship"] = "中間的船",
	-- ["the northern ship"] = "北邊的船",
	-- ["the {object:707249} poster"] = "{object:707249}告示",
	-- ["{item:268505}, the southern ship"] = "{item:268505}，南邊的船",
	-- ["{npc:257062} offers the last two once Gobam's errands are done (players' recordings), which this guide leaves out. They are level 44 and 45: leave them for later if {npc:258626} was a close fight."] = "完成戈巴姆的差事後，{npc:257062}會提供最後兩個任務（根據玩家的錄影），本指南未收錄這兩個任務。它們是44和45級：如果你打{npc:258626}時打得很險，就留到之後再來。",
	-- ["{npc:258048} waits by the Twilight ogres' camp north-east of {npc:256728}: take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "{npc:258048}在{npc:256728}東北方的暮光食人魔營地旁等待：帶他回{area:16726}，別讓教徒傷到他。如果他倒下，再向他接受一次任務。",
	-- ["{npc:263190}'s spears, on the Freshwater Crocolisks"] = "{npc:263190}的長矛，用在淡水鱷魚身上",
}
