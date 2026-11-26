-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1451} Silithus · {zone:1446} Tanaris
	["{area:976} first, then {zone:1451}, Un'Goro and back to {zone:1446}."] = "先去{area:976}，再去{zone:1451}、安戈洛，然后回到{zone:1446}。",

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
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "在{area:976}东边不远处的墓地喝下{item:11243}：它会杀死你，只有以鬼魂形态才能看到{npc:9299}，他在墓地正北方山丘中的一道岩缝里。在那里和他交谈，然后跑回尸体处复活：他让你去找的显眼的墓碑就在那片墓地里。",

	-- Step 4: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir · {area:976} Gadgetzan
	["{npc:9299} has already met you: drink the {item:11243} at the graveyard just east of {area:976} and find him, as a ghost, in the rocky crevice due north of it."] = "{npc:9299}已经见过你了：在{area:976}东边的墓地喝下{item:11243}，以灵魂状态在其正北的岩石裂缝中找到他。",

	-- Step 5: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "对{area:976}的地精女孩{npc:7583}使用{item:12928}。{npc:10977}和{npc:10978}在路线后面再吓唬。",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "用{item:12928}吓唬{npc:7583}",

	-- Step 6: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "屋内：{quest:4493}，如果你在{zone:1447}指南中于{zone:1454}接了它",

	-- Step 7: Alchemist Pestlezugg
	["Inside"] = "在里面",

	-- Step 9: Gaeriyan
	-- {object:148504} A Conspicuous Gravestone · {area:976} Gadgetzan · {npc:8737} Linken
	["Alive again, go to {object:148504} in the graveyard just east of {area:976} and use it: it takes the quest. {npc:8737}'s sword goes back to {npc:8737} in Un'Goro: keep it."] = "",
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}要交还给安戈洛的{npc:8737}：留着它。",

	-- Step 10: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}在{area:976}南边通往{area:1336}的路旁扎营。",

	-- Step 11: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飞往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 12: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	-- was: ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "留着{quest:3942}：{npc:9116}在{area:2479}，下一个指南穿过{zone:1448}时会经过。"
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 13: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "从安戈洛环形山出来的山口通往{area:3077}，那是{zone:1451}东北部的墓地。{npc:13220}站在坟墓之间。",

	-- Step 14: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "向西南骑往{area:2738}的废墟。给{npc:11801}的{object:179565}在其中一座毁坏的房子里。",

	-- Step 16: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	-- was: ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "向西骑往沙漠中央有城墙环绕的要塞。{npc:15189}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。"
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 17: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "",

	-- Step 18: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：沿途击杀以下目标",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打击者、石鞭蝎和掠沙蜘蛛共处于要塞正北的沙地上。",

	-- Step 19: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	-- was: ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。小心：最大的沙漠奔行者和旋风入侵者是58级：一次引一只。"
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "",

	-- Step 20: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",

	-- Step 21: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "回到南风村，爬上塔。搅动塔顶的虫巢会引出亚什伏击者；其中一个携带{item:17346}。",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "",

	-- Step 23: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "向东南骑往安戈洛悬崖下的{area:3447}。",
	["Below ground"] = "在地下",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "从{npc:11739}身上获取{item:20377}，在西南130码处",

	-- Step 24: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "掘泥摧毁者和巨钳蝎",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "沿西部沙丘向北；掘泥摧毁者和石鞭巨钳蝎分布在从这里到要塞的一带。",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741}在{area:2738}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "石鞭掠夺者和石行蜘蛛",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes north of {area:2744}, in the south-east of {zone:1451}."] = "石鞭剥皮者（{npc:11737}）和岩石潜伏者（{npc:11739}）在{zone:1451}东南部、{area:2744}以北的沙丘上游荡。",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "暮光先锋军营地",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803}在西南尽头的先锋营地里走动。保留信徒掉落的所有{item:20404}；稍后{npc:15306}和隐士奥泰尔各需要十份。",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}占据着西边的营地。",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804}在{area:3425}西侧的前哨站，这里掉落的暮光密文信也要保留。",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}和{npc:15190}站在他们那座建筑的楼上：从里面上楼，箭头分不清楼层。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在要塞西侧",

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
	-- was: ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "诺格的背包在遥远南方的山里，过了铜须营地。精英蝎子死亡弯钩在附近巡逻：趁它走开时拿走背包。"
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} 和 {npc:15170} 在铜须营地扎营，就在丢失背包所在山地的北边。询问他们：与两人分别完成全部对话；无需战斗。",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane · {area:2739} Twilight Base Camp · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts, ten for {npc:15306} and ten for Ortell. The {area:2739} holds only elementals: the texts drop from the Twilight's Hammer cultists of the Vanguard in the far south-west, the Post in the west and the Outpost west of {area:3425}. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "每个任务各需十份：先给{npc:15306}十份，再给隐士奥泰尔",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "信徒身上多出来的密文信",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "返回{area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "玛尔利斯接下来的任务“深入疯狂之口”会带你进入精英遍布的 {area:2744}。跳过它。",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "向东北骑往{area:3077}；你从旁边的山口离开{zone:1451}。",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	-- was: ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "穿过山口，沿北侧峭壁向东前往{area:541}。{npc:9997}站在飞行管理员旁。"
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "向东骑往{area:537}，爬上去，在接近山顶的熔岩口使用{npc:10541}，然后向西骑回{npc:10302}那里。",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}让你去找{zone:1452}的{npc:9298}：留着它。",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "仅当你来时在{area:976}接了{quest:4496}：{area:537}南边{area:540}的高瑟尔虫子掉落气味腺，环形山里大多数野兽和植物都掉落{item:11018}。",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "在 {area:540} 的格里什虫巢内、箭头所指的位置使用 {item:11833}，召唤 {npc:10041}（56 级）。",

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
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}坐在山脊上，迷路了，筋疲力尽。",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "护送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "向北护送{npc:9999}前往{area:541}。他昏倒时，对他使用{item:11804}唤醒。",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	-- was: ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "飞往{area:976}。还带着{quest:2741}吗？机器立在镇中央。"
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",

	-- Step 63: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一张破损的卷轴在{area:2260}南边的墓穴{area:2261}的入口处。",
	-- ["Andorhal watchtowers and silos"] = "安多哈尔的哨塔和粮仓",
	-- ["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "向东返回，经过{area:202}后到达{area:201}，即东侧丘陵下的农场：{npc:11078}守着那里的瘟疫之锅。击杀他取得钥匙，再使用瘟疫之锅。",
	-- ["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "小心：安戈洛猩猩（50-51 级）的生命值降到 25% 时，会呼叫 20 码内的同伴援助。此地有一座满是猩猩的洞穴，在里面战斗会引来许多额外怪物。",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "从这里的信徒身上收集二十份暮光密文信，十份交给{npc:15306}，十份交给奥泰尔。",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "从这里的信徒身上收集二十份暮光密文信，十份交给{npc:15306}，十份交给奥泰尔。从暮光复仇者和暮光地卜师身上获取；别碰烈焰掠夺者和唤石者（59-60级）。",
	-- ["Diseased Grizzlies"] = "生病的灰熊",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "迪瑟斯提供{item:14619}（{quest:838}）。跳过它。",
	-- ["Dredge Strikers"] = "掘泥打击者",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打击者、石鞭蝎和掠沙蜘蛛共处于要塞正北的沙地上。",
	-- ["Dredge and scorpids"] = "掘泥者和蝎子",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "沿道路向东，{npc:11077}守着{area:200}的瘟疫之锅。",
	-- ["Fly to {area:1637} and train."] = "飞往{area:1637}训练。",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "飞往{area:976}。还带着{quest:2741}吗？机器立在镇中央。",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "飞往{area:976}。{object:142071}立在镇中央。",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "从飞艇塔沿道路向东骑往{area:152}，即进入{zone:1422}的路上。",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "哈米亚 藏在东北角{area:2273}的烂苔巨魔之中。\n小心：通往{area:2273}的路上，巨魔为57-59级。它们低血量时会逃跑求援，经常引来额外怪物。",
	-- ["Hameya's mound"] = "哈米亚的土堆",
	-- ["Hameya's scroll"] = "哈米亚的卷轴",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "如果跳过了 {quest:6135}，就在此刷到 59.14 级，跟上路线规划。也可组队前往 {quest:838} 副本或 {area:2279} 副本。",
	-- ["Into {zone:1422}"] = "进入{zone:1422}",
	-- ["Into {zone:1423}"] = "进入{zone:1423}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "留着诱饵：{npc:9684}是56级，第二圈会经过它的巢穴。",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "留着{quest:3942}：{npc:9116}在{area:2479}，下一个指南穿过{zone:1448}时会经过。",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "骑士和法师在{area:192}活动；医师和猎人在其南边扎营。顺便把{npc:11615}的白蚁桶放在伐木场中央。\n小心：伐木营地可能有一只{npc:10996}（58-59级精英），{zone:1422}的许多其他地点也有：离它远点。",
	-- ["Level 57"] = "57级",
	-- ["Level 58"] = "58 级",
	-- ["Level 59.14"] = "等级 59.14",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "玛尔利斯的“最亲爱的纳塔莉亚”需要58级，而且要进入满是精英的{area:2744}。跳过它。",
	-- ["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",
	-- ["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- ["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- ["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "向北前往伐木场；把白蚁桶放在锯木厂中央。",
	-- ["Pamela and the {area:2261}"] = "帕米拉和 {area:2261}",
	-- ["Radley and Durgen"] = "猎人莱德雷和骑士杜尔根",
	-- ["Ride east across the plaguelands to the chapel."] = "向东骑过瘟疫之地前往教堂。",
	-- ["Ride east along the road to the {area:152} on the border."] = "沿道路向东骑往边境上的{area:152}。",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "向东骑往{area:2619}旁{npc:1855}的小屋，听他把话说完。",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "向东北骑往{area:2275}旁的{area:2276}：高等精灵游侠、巡路者和林业人守在那里，登记簿就在屋内。小心：巡路者是57-58级，但游侠可达60级：一次拉一只，最后再打游侠。",
	-- ["Ride north-east to {area:3447}."] = "向东北骑往{area:3447}。",
	-- ["Ride north-west to {npc:1855}'s hut."] = "向西北骑往{npc:1855}的小屋。",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "向南骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候。拿着{item:12815}站在四座塔的每一个门口来标记它；沿城镇边缘走。在镇中央的粮仓旁使用{item:12627}引出时光寄生虫。",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "从{npc:1855}处向东南骑往{area:2260}的农舍。",
	-- ["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "从{npc:1855}处骑乘向东南前往{area:2261}，{object:177675}就在其后方。",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "向西南骑往安多哈尔的{npc:10667}那里。",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "骑马前往西南的 {area:2262}；帕米拉在房屋之间玩耍。{npc:11886} 潜伏在 {area:2261}，也就是镇子正西边的墓穴。\n小心：墨丘利奥会带来约四只非精英小怪。它们会走到墓前，而不是直接在原地出现。",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "骑往西南的{area:2262}；{npc:10926}在房子间玩耍。{npc:11886}潜伏在城镇正西的墓穴{area:2261}里。",
	-- ["Ride west to the Horde camp north of {area:2744}."] = "向西骑往{area:2744}北边的部落营地。",
	-- ["Ride west to the walled hold in the middle of the desert."] = "向西骑往沙漠中央有城墙环绕的塞纳里奥要塞。",
	-- ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "向西骑往沙漠中央有城墙环绕的要塞。{npc:15189}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",
	-- ["Scare {npc:10977} with {npc:10980}"] = "用{npc:10980}吓唬{npc:10977}",
	-- ["Scarlet Crusade"] = "血色十字军",
	-- ["Scourge Champions"] = "天灾勇士",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "天灾勇士在教堂北边的{area:2270}游荡。在你杀死的每一个身上晃一晃{npc:11063}的{item:13156}：产生共鸣的头骨就是他要的。",
	-- ["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "水晶尘喷泉在南部沙漠各处喷发。走进喷泉留下的水晶尘，把它带到吉里卡营地的部落水晶尘提取器；战斗或骑上坐骑都会让它掉落。",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "石鞭掠夺者和石行蜘蛛在吉里卡营地西南的沙丘上游荡。",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "在{area:1637}外的塔上乘飞艇前往{zone:1420}，再骑进{zone:1458}。希尔瓦娜斯·风行者在{object:36126}。",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "你低于57级时，东南方的掘泥摧毁者（57-58级）比你高两级。先在{area:3425}东边沙地上的掘泥打击者（55-56级）身上升到57级，掠沙蜘蛛和石鞭蝎（54-56级）也在其间游荡，远离北部沙地的异种虫投掷者。或者组队去打{area:1583}地下城（下层）或{quest:838}地下城。",
	-- ["The Spirits of Southwind"] = "南风村的灵魂",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。小心：最大的沙漠奔行者和旋风入侵者是58级：一次引一只。",
	-- ["The lake for {quest:5845}"] = "{quest:5845}所需的湖泊",
	-- ["The libram lies further north, on the way to {area:190}."] = "圣契在更北边，通往{area:190}的路上。",
	-- ["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "锁箱放在{npc:10667}所在旅店周围的安多哈尔废弃房屋里。小心：食尸鬼和骷髅通常站在箱子旁，你靠近时会发动攻击。灼热食尸鬼还会伤害附近所有人，并会打破潜行。",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "锯木厂就在猎人莱德雷身旁：把{npc:11615}的白蚁桶放在厂房中央。",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "诺格的背包在遥远南方的山里，过了铜须营地。精英蝎子死亡弯钩在附近巡逻：趁它走开时拿走背包。",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "盾牌在{npc:1855}小屋南边的{area:201}。",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}后面。",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675}就在南边，{area:2261}后面。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "这些是精英怪：建议组队，找人一起打。{npc:11897}是60级精英：单人就跳过。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave."] = "穿过山口，沿北侧峭壁向东到 {area:541}。{npc:8737} 就站在洞口旁。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "穿过山口，沿北边的悬崖向东前往{area:541}。{npc:8737}站在洞穴旁；{npc:9117}在洞里。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "穿过山口，沿北侧峭壁向东前往{area:541}。{npc:9997}站在飞行管理员旁。",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "在挑战奥泰尔的石行蜘蛛（57-59级）和南部之前，先在这里升到58级；{area:3425}的{npc:15181}的{quest:8304}也需要58级。往东南路上的掘泥摧毁者（57-58级）正是{npc:15191}要的：别去碰它们周围的暮光信徒。或者组队去{area:1583}（下层）或{quest:838}地下城。",
	-- ["Underwater"] = "在水下",
	-- ["Upstairs"] = "在楼上",
	-- ["Use {npc:10980} on {npc:10977}"] = "对{npc:10977}使用{npc:10980}",
	-- ["West to the {area:152} one last time."] = "最后一次向西返回{area:152}。",
	-- ["West to the {area:152}."] = "向西前往 {area:152}。",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "向西前往{area:152}。下一个指南从西边不远的{zone:1458}开始。",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。",
	-- ["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",
	-- ["from the cauldron, for {npc:11055} at the {area:152}"] = "从大锅处取得，交给{area:152}的{npc:11055}",
	-- ["grind on {npc:10717}"] = "击杀{npc:10717}刷经验",
	-- ["grind on {npc:11740}"] = "反复击杀{npc:11740}补足经验",
	-- ["grind on {npc:11741}"] = "击杀 {npc:11741} 刷经验",
	-- ["{area:1099} flight master"] = "{area:1099}的飞行管理员",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "{area:190} 的血色十字军是 58-60 级。骑马进去，到地图标记的高点俯瞰镇子，然后离开。\n小心：门口的哨兵能侦测潜行玩家。镇内还有更多哨兵，附近也有一名精英巡逻。",
	-- ["{item:20375} on the way"] = "顺路获取{item:20375}",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "地精{npc:10302}坐在水晶塔正东的{area:543}。",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}的达隆郡之战最后要对付精英。跳过它。",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}：在楼上",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739}在{area:202}旁、瘟疫之锅边扎营；他的熊在其北边和东边的山丘游荡，就在前往{area:201}的路上。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的农场是{area:152}东边的第一座农场。农场上的{npc:10801}携带她护身符的另一半；{npc:11075}守着田里的瘟疫之锅。",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926}和{area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}自己的差事不在本路线上。跳过它。",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610}藏在{area:192}东北的山丘上。",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} 站在伐木营地东边；{npc:11611} 守在 {npc:11610} 东北、通往 {area:190} 的道路旁。\n小心：塔底有守卫，另有一名绕塔巡逻。与杜根·挽锤交战前先清掉它们，避免它们加入战斗。",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803}在遥远西南的暮光先锋军营地里走动。这里的每个信徒都会掉落暮光密文信，不管你有没有任务：收集二十份，十份给{npc:15306}，十份给奥泰尔。",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804}站在{area:3425}西边的前哨站里。在这里的信徒身上把暮光密文信补到二十份。",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}的差事不在本路线上。跳过它们。",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{area:3425} 的 {npc:15181} 提供的 {quest:8304} 需要 58 级：击杀前哨站西侧的掘泥摧毁者（57-58 级）补足经验，别去碰它们周围的暮光复仇者、暮光地王和暮光唤石者（57-61 级）。也可组队前往 {area:1583} 副本（下层）或 {quest:838} 副本。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在要塞西侧",
	-- ["{npc:15306}, on the west side of the Hold: the texts are already in your bags"] = "{npc:15306}，在要塞西侧：密文信已经在你的背包里",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852}（61级，精英）站在安多哈尔中央，周围是骷髅督军（56-57级，精英）：和队伍一起杀死他，然后从那里的{object:177241}取得碎片。",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}的下一个任务（失落的荣耀）不在本路线上。跳过它。",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565}在{area:2276}附近巡逻，请在地图标出的圆圈内寻找",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117} 在洞穴内。",
	-- ["{npc:9167} walks around here: look inside the circle on the map"] = "{npc:9167}在附近巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619}接下来要东北洞穴里{npc:9622}的毛皮：跳过它。",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}的巢穴就在水晶塔正南。在那里使用{npc:9619}的诱饵；{npc:9684}是56级，攻击很重，所以满血再开始。",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "{quest:105}的碎片就在{npc:1852}脚下，位于安多哈尔中央：他是61级精英，周围还有精英骷髅督军，需要组队应战。",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}：沿途击杀以下目标",
}
