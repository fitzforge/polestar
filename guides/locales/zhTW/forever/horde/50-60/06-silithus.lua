-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1451} Silithus · {zone:1446} Tanaris
	["{area:976} first, then {zone:1451}, Un'Goro and back to {zone:1446}."] = "先去{area:976}，再去{zone:1451}、安戈洛，然後回到{zone:1446}。",

	-- Step 1: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {area:2249} Frostwhisper Gorge
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["{npc:11118}, in {area:2255}'s inn, has more mail for you: the Ice Thistle Yetis in the hills south-east of town carry it. Keep it for the last guide, whose ride back north from {area:2249} crosses those hills."] = "",

	-- Step 2: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "",
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {area:976} Gadgetzan · {npc:9299} Gaeriyan · {npc:7583} Sprinkle · {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Back from {zone:2482}: fly from {area:2255} to {area:976} for {npc:9299}, {npc:7583} and Pestlezugg, then on to {area:541} and {zone:1451}."] = "",
	["Yugrek, the Horde flight master"] = "",

	-- Step 3: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "在{area:976}東邊不遠的墓地喝下{item:11243}：你會死亡，只有變成鬼魂才看得到{npc:9299}，他在墓地正北方丘陵的岩縫裡。在那裡和他交談，然後跑回屍體復活：他要你去找的顯眼的墓碑就在那座墓地裡。",

	-- Step 4: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir · {area:976} Gadgetzan
	["{npc:9299} has already met you: drink the {item:11243} at the graveyard just east of {area:976} and find him, as a ghost, in the rocky crevice due north of it."] = "{npc:9299}已經見過你了：在{area:976}東邊的墓地喝下{item:11243}，以靈魂狀態在其正北的岩石裂縫中找到他。",

	-- Step 5: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "對{area:976}的哥布林女孩{npc:7583}使用{item:12928}。{npc:10977}和{npc:10978}會在路線後段被嚇到。",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "用{item:12928}嚇唬{npc:7583}",

	-- Step 6: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "在裡面：{quest:4493}，如果你在{zone:1447}指南時於{zone:1454}接了它",

	-- Step 7: Alchemist Pestlezugg
	["Inside"] = "在裡面",

	-- Step 9: Gaeriyan
	-- {object:148504} A Conspicuous Gravestone · {area:976} Gadgetzan · {npc:8737} Linken
	["Alive again, go to {object:148504} in the graveyard just east of {area:976} and use it: it takes the quest. {npc:8737}'s sword goes back to {npc:8737} in Un'Goro: keep it."] = "",
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}要交回安戈洛環形山的{npc:8737}：先留著。",

	-- Step 10: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}在{area:976}南邊、通往{area:1336}的路旁紮營。",

	-- Step 11: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飛往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 12: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}，地下",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	-- was: ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "保留{quest:3942}：{npc:9116}在{area:2479}，下一份指南經過{zone:1448}時會路過。"
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 13: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "從安戈洛來的山道出口在{area:3077}，也就是{zone:1451}東北部的墓地。{npc:13220}站在墳墓之間。",

	-- Step 14: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "往西南騎到{area:2738}的廢墟。要交給{npc:11801}的{object:179565}就在其中一間破屋裡。",

	-- Step 16: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	-- was: ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "向西騎往沙漠中央有城牆環繞的要塞。{npc:15189}站在他那座建築的樓上：從裡面上樓，箭頭分不清樓層。"
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 17: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "",

	-- Step 18: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：遇到這些就殺",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打擊者、石鞭蠍和掠沙蜘蛛都在城堡北邊不遠的沙地上。",

	-- Step 19: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	-- was: ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "發光的石碑碎片散落在極西北的暮光營地周圍；那裡的灰塵風暴和沙漠奔行者也會掉落。小心：最大的沙漠奔行者和旋風入侵者是58級：一次只拉一隻。"
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "",

	-- Step 20: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他那座建築的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 21: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "回到南風村並爬上塔。攪動塔頂的蟲巢會引出亞什伏擊者；其中一隻帶著{item:17346}。",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "",

	-- Step 23: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "往東南騎到安戈洛懸崖下的{area:3447}。",
	["Below ground"] = "地下",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "從{npc:11739}身上獲取{item:20377}，在西南130碼處",

	-- Step 24: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "掘泥摧毀者與巨鉗蠍",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "沿著西側沙丘往北走；從這裡到城堡一帶都有掘泥摧毀者和石鞭巨鉗蠍。",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741}在{area:2738}一帶走動：看地圖圓圈內",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "掠奪者與石行蜘蛛",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes north of {area:2744}, in the south-east of {zone:1451}."] = "石鞭剝皮者（{npc:11737}）和岩石潛伏者（{npc:11739}）在{zone:1451}東南部、{area:2744}以北的沙丘上遊蕩。",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "暮光先鋒",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803}在極西南的先鋒營地巡邏。保留信徒掉落的每一份{item:20404}：{npc:15306}和奧泰爾之後各要十份。",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}守在西邊的營地。",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804}站在{area:3425}西邊的前哨站。這裡掉落的暮光加密文件也都留著。",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}和{npc:15190}站在他們那座建築的樓上：從裡面上樓，箭頭分不清樓層。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在城堡西側",

	-- Step 32: Calandrath
	-- {npc:15174} Calandrath · {object:180503} Sandy Cookbook
	["{npc:15174}, the innkeeper, takes the {object:180503}'s torn page."] = "",

	-- Step 33: Wanted: Deathclasp
	-- {npc:15196} Deathclasp
	["Wanted: {npc:15196}"] = "",
	-- {npc:15196} Deathclasp · {npc:15190} Noggle Ficklespragg · {npc:15182} Vish Kozus
	["{npc:15196}, Terror of the Sands, is a level 59 elite scorpid patrolling the mountains by {npc:15190}'s satchel, at your level: a group choice. The wanted poster stands in the middle of the Hold; {npc:15182} pays out."] = "",

	-- Step 34: Hermit Ortell
	-- {area:3447} Ortell's Hideout · {area:2738} Southwind Village
	["Ride south-east to {area:3447}, in the mountains south of {area:2738}."] = "",

	-- Step 35: Noggle's Lost Satchel
	-- {npc:15196} Deathclasp
	-- was: ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "背包在極南方的山裡，過了銅鬚營地就是。精英蠍子死亡彎鉤在附近巡邏：趁牠離開時拿走。"
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171}和{npc:15170}在銅鬚營地紮營，就在挎包山以北不遠處。盤問他們：逐一走完每個人的整段對話；不必與他們戰鬥。",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane · {area:2739} Twilight Base Camp · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts, ten for {npc:15306} and ten for Ortell. The {area:2739} holds only elementals: the texts drop from the Twilight's Hammer cultists of the Vanguard in the far south-west, the Post in the west and the Outpost west of {area:3425}. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "每個任務十個：{npc:15306}的那十個先於奧泰爾交",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "從信徒身上多拿的文件",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "回到{area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他那座建築的樓上：從裡面上樓，箭頭分不清樓層。",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "瑪爾利斯的下一個差事「深入瘋狂之喉」要深入精英環伺的{area:2744}。跳過。",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "往東北騎到{area:3077}；從旁邊的山道離開{zone:1451}。",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	-- was: ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "穿過山道，沿北側懸崖往東到{area:541}。{npc:9997}站在飛行管理員旁邊。"
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}，然後騎回西邊找{npc:10302}。",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}要你去找{zone:1452}的{npc:9298}：保留此任務。",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "僅限你來這裡途中在{area:976}接了{quest:4496}：{area:537}南邊{area:540}的佐里斯蟲會掉落氣味腺，火山口大部分的野獸和植物會掉落{item:11018}。",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "在箭頭所指處，也就是{area:540}的格里什蟲巢內使用{item:11833}，召喚{npc:10041}（56級）。",

	-- Step 51: Torwa Pathfinder
	-- {quest:4301} The Mighty U'cha · {area:541} Marshal's Refuge
	["{quest:4301}: his north-east cave is on your way back here from {area:541}"] = "",
	-- {npc:9684} Lar'korwi
	["Keep the bait for {npc:9684}'s lair, next (he is level 56)."] = "",

	-- Step 52: Lar'korwi
	-- {item:11568} Torwa's Pouch · {npc:9684} Lar'korwi
	["Open {item:11568}: it holds the meat and the pheromone mixture. {npc:9684}'s lair is the bone-strewn valley just south of the pylon: place the meat among the bones, then use the mixture on it to call {npc:9684}. He is level 56 and hits hard, so start at full health."] = "",

	-- Step 53: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}坐在山脊上，迷路又筋疲力盡。",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "把{npc:9999}向北引到{area:541}。他昏倒時，對他使用{item:11804}把他喚醒。",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	-- was: ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "飛往{area:976}。身上還有{quest:2741}嗎？機器就在鎮中央。"
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",

	-- Step 63: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "聖騎士訓練師",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344}在{zone:1456}；{zone:1454}沒有聖騎士訓練師",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一張撕破的卷軸在{area:2260}南邊的地穴{area:2261}入口。",
	-- ["Andorhal watchtowers and silos"] = "安多哈爾的哨塔與穀倉",
	-- ["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "向東經過{area:202}回到{area:201}，那是東邊丘陵下的農場：{npc:11078}守著它的大鍋。殺他拿鑰匙，然後使用大鍋。",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "從這裡的信徒身上收集二十份暮光加密文件，十份給{npc:15306}，十份給奧泰爾。從暮光復仇者和暮光地卜師身上拿；別碰奪焰者和喚石者（59-60級）。",
	-- ["Diseased Grizzlies"] = "生病的灰熊",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "迪瑟斯提供{item:14619}（{quest:838}）。跳過。",
	-- ["Dredge Strikers"] = "掘泥打擊者",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打擊者、石鞭蠍和掠沙蜘蛛都在城堡北邊不遠的沙地上。",
	-- ["Dredge and scorpids"] = "掘泥者與蠍子",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "沿著道路往東，{npc:11077}守著{area:200}的大鍋。",
	-- ["Fly to {area:1637} and train."] = "飛往{area:1637}並訓練。",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "飛往{area:976}。身上還有{quest:2741}嗎？機器就在鎮中央。",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "飛往{area:976}。{object:142071}就在鎮中央。",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "從飛艇塔沿著道路往東騎到{area:152}，前往{zone:1422}的路上。",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "哈米亞藏在{area:2273}東北角的苔蘚剝皮者食人妖中。\n小心：通往{area:2273}路上的食人妖是57-59級。他們低血量時會逃跑並呼救，所以常常帶來額外的怪。",
	-- ["Hameya's mound"] = "哈米亞的土堆",
	-- ["Hameya's scroll"] = "哈米亞的卷軸",
	-- ["Into {zone:1422}"] = "進入{zone:1422}",
	-- ["Into {zone:1423}"] = "進入{zone:1423}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "保留誘餌：{npc:9684}是56級，第二圈路線會經過牠的巢穴。",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "保留{quest:3942}：{npc:9116}在{area:2479}，下一份指南經過{zone:1448}時會路過。",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "騎士和法師在{area:192}幹活；醫護兵和獵人在它南邊紮營。順便在伐木場中央放下{npc:11615}的白蟻桶。\n小心：伐木營地可能站著一隻{npc:10996}，58-59級精英，{zone:1422}許多其他地點也有：離它遠一點。",
	-- ["Level 57"] = "等級57",
	-- ["Level 58"] = "58級",
	-- ["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- ["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",
	-- ["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- ["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",
	-- ["Pamela and the {area:2261}"] = "潘蜜拉與{area:2261}",
	-- ["Radley and Durgen"] = "萊德雷與杜爾根",
	-- ["Ride east across the plaguelands to the chapel."] = "往東穿過瘟疫之地到禮拜堂。",
	-- ["Ride east along the road to the {area:152} on the border."] = "沿著道路往東騎到邊界上的{area:152}。",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "往東騎到{area:2619}旁{npc:1855}的小屋，聽他把話說完。",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "往東北騎到{area:2275}旁的{area:2276}：高等精靈遊俠、巡路者和樵夫守著那裡，登記簿就在裡面。小心：巡路者是57-58級，但遊俠可達60級：一次拉一隻，最後再打遊俠。",
	-- ["Ride north-east to {area:3447}."] = "往東北騎到{area:3447}。",
	-- ["Ride north-west to {npc:1855}'s hut."] = "往西北騎到{npc:1855}的小屋。",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "往南騎進安多哈爾。{npc:10667}在鎮西側的旅店廢墟裡等著。帶著{item:12815}站在四座哨塔各自的門口來標記；沿著鎮的外緣走。在鎮中央的穀倉旁使用{item:12627}，引出時光寄生蟲。",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "從{npc:1855}往東南騎到{area:2260}的農舍。",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "往西南騎到安多哈爾找{npc:10667}。",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "騎到西南方的{area:2262}；潘蜜拉在房屋之間玩耍。{npc:11886}潛伏在{area:2261}，就是鎮西邊不遠的墓穴。\n小心：米庫提奧會帶來大約四隻非精英的幫手。牠們是走到墳墓那裡，而不是當場出現。",
	-- ["Ride west to the Horde camp north of {area:2744}."] = "往西騎到{area:2744}北邊的部落營地。",
	-- ["Ride west to the walled hold in the middle of the desert."] = "往西騎到沙漠中央有城牆的城堡。",
	-- ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "向西騎往沙漠中央有城牆環繞的要塞。{npc:15189}站在他那座建築的樓上：從裡面上樓，箭頭分不清樓層。",
	-- ["Scare {npc:10977} with {npc:10980}"] = "用{npc:10980}嚇唬{npc:10977}",
	-- ["Scarlet Crusade"] = "血色十字軍",
	-- ["Scourge Champions"] = "天災勇士",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "天災勇士在禮拜堂北邊的{area:2270}遊蕩。每殺一隻就用{npc:11063}的{item:13156}掃過屍體：產生共鳴的頭骨就是他要的。",
	-- ["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "南部沙漠各處會有希利蘇斯之塵間歇泉噴發。走進噴發後留下的希利蘇斯之塵，把它帶到奇立卡營地的部落希利蘇斯之塵提取器；戰鬥或騎乘坐騎會讓它掉落。",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "石鞭掠奪者和石行蜘蛛在奇立卡營地西南的沙丘上遊蕩。",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "在{area:1637}外的塔上搭飛艇到{zone:1420}，再騎進{zone:1458}。希瓦娜斯女士在{object:36126}。",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "東南方的掘泥摧毀者（57-58級）在你未滿57級時會高你兩級。先在{area:3425}東邊沙地上的掘泥打擊者（55-56級）身上練到57級，那裡也有掠沙蜘蛛和石鞭蠍（54-56級）遊蕩，且遠離北方沙地的異種蟲飛鏢手。或者組隊改打{area:1583}地城（下層）或{quest:838}地城。",
	-- ["The Spirits of Southwind"] = "南風之靈",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "發光的石碑碎片散落在極西北的暮光營地周圍；那裡的灰塵風暴和沙漠奔行者也會掉落。",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "發光的石碑碎片散落在極西北的暮光營地周圍；那裡的灰塵風暴和沙漠奔行者也會掉落。小心：最大的沙漠奔行者和旋風入侵者是58級：一次只拉一隻。",
	-- ["The lake for {quest:5845}"] = "{quest:5845}要去的湖",
	-- ["The libram lies further north, on the way to {area:190}."] = "聖契在更北邊，前往{area:190}的路上。",
	-- ["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "鎖箱放在{npc:10667}所在旅店周圍的安多哈爾廢棄房屋裡。小心：食屍鬼和骷髏通常站在箱子旁，你靠近時會發動攻擊。灼熱食屍鬼還會傷害附近所有人，並會打破潛行。",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "伐木場就在雷德利旁邊：把{npc:11615}的白蟻桶放在它中央。",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "背包在極南方的山裡，過了銅鬚營地就是。精英蠍子死亡彎鉤在附近巡邏：趁牠離開時拿走。",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "盾牌在{npc:1855}小屋南邊的{area:201}。",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}後面。",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675}就在南邊不遠，{area:2261}後面。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "這些是精英怪：建議組隊，找人一起打。{npc:11897}是60級精英：單人就跳過。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "穿過山道，沿北側懸崖往東到{area:541}。{npc:9997}站在飛行管理員旁邊。",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "在這裡練到58級，再去打奧泰爾的石行蜘蛛（57-59級）和南方；回{area:3425}接{npc:15181}的{quest:8304}也需要58級。往東南路上的掘泥摧毀者（57-58級）就是{npc:15191}要的：別理會牠們周圍的暮光信徒。或者組隊改打{area:1583}地城（下層）或{quest:838}地城。",
	-- ["Underwater"] = "在水下",
	-- ["Upstairs"] = "樓上",
	-- ["Use {npc:10980} on {npc:10977}"] = "對{npc:10977}使用{npc:10980}",
	-- ["West to the {area:152} one last time."] = "最後一次向西去{area:152}。",
	-- ["West to the {area:152}."] = "向西到{area:152}。",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "往西到{area:152}。下一份指南從往西騎不遠的{zone:1458}開始。",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。",
	-- ["Zeppelin to {zone:1458}"] = "搭飛艇前往{zone:1458}",
	-- ["from the cauldron, for {npc:11055} at the {area:152}"] = "來自大鍋，交給{area:152}的{npc:11055}",
	-- ["grind on {npc:11740}"] = "刷{npc:11740}",
	-- ["grind on {npc:11741}"] = "擊殺{npc:11741}練等",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "{area:190}的血色成員是58-60級。騎到地圖上標記的高點，俯瞰鎮子，然後離開。\n小心：門前的哨兵能發現潛行玩家。鎮內還有更多哨兵，附近有一個精英在巡邏。",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "哥布林{npc:10302}坐在{area:543}，就在水晶塔東邊。",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}的達隆郡之戰最後要對付精英。跳過。",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}，樓上",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739}在{area:202}的大鍋旁紮營；他的熊在北邊和東邊的山丘遊蕩，往{area:201}的路上。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的農場是{area:152}以東的第一座。農場上的喋喋不休的食屍鬼身上有她護符的另一半；{npc:11075}守著田裡的大鍋。",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}自己的差事不在這條路線上。跳過。",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610}躲在{area:192}東北方的山丘上。",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}站在伐木場東邊；{npc:11611}守著{npc:11610}東北通往{area:190}的路。\n小心：塔底有衛兵，還有一個繞著塔巡邏。和杜爾根交戰前先清掉他們，免得他們加入戰鬥。",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}的差事不在這條路線上。跳過。",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{area:3425}的{npc:15181}提供的{quest:8304}需要58級：擊殺前哨站西邊的掘泥摧毀者（57-58級）補足經驗，別去碰牠們周圍的暮光復仇者、暮光地王和暮光喚石者（57-61級）。或者，組隊去打{area:1583}地城（下層）或{quest:838}地城。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士守在{area:2261}北邊的{area:2260}農舍。",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在城堡西側",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852}（61級，精英）站在安多哈爾中央，周圍是骷髏督軍（56-57級，精英）：和你的隊伍一起殺了他，然後從那裡的{object:177241}取得碎片。",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}的下一個任務「失落的榮耀」不在這條路線上。跳過。",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565}在{area:2276}一帶走動：檢視地圖上的圓圈範圍",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117}在洞穴裡面。",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619}現在要{npc:9622}的毛皮，在東北方的洞穴裡：跳過。",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}的巢穴就在水晶塔南邊。在那裡使用{npc:9619}的誘餌；{npc:9684}是56級且攻擊力強，滿血再開始。",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "{quest:105}的碎片就在安多哈爾中央{npc:1852}的腳邊：他是61級精英，身邊有精英骷髏督軍，需要組隊戰鬥。",
}
