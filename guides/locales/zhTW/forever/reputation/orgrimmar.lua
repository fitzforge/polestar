-- Chinese (traditional) (zhTW): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "奧格瑪聲望",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "練級時做{zone:1411}和十字路口的任務，55級起做{zone:1448}和{zone:1447}的任務，然後交{item:14047}交到崇拜。",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "{faction:76}達到崇拜",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76}：機制說明",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "",
	["her donations are handed in from her window and never enter the log"] = "她的捐獻任務在她的視窗中直接繳交，不會進入任務日誌",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363}（可選據點）",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Forever 裡這些舊任務任何等級都足額給分。{area:363}是其中最好的：25分鐘約1,400點{faction:76}和1,400點暗矛食人妖聲望。{npc:3143}在大棚屋“洞穴”裡等著，{npc:10176}站在外面。",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144}，在{faction:76}：{quest:787}，+50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}：{quest:792}，僅術士",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "野豬、武器和苦工",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "訓練用武器躺在大屋（獸穴）的地上以及北邊野豬群中。對付苦工：選中一個睡著的{npc:10556}並對它使用{item:16114}。",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}：用{item:16114}打它",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "喚醒{npc:10556}",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}：交任務",

	-- Step 5: North of the Den
	["North of the Den"] = "大屋（獸穴）以北",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "仙人掌果長在大屋（獸穴）以北的仙人掌旁。{npc:3287}受傷躺在北邊的岩石旁；他的大蠍子{quest:790}在附近遊蕩。{quest:792}在{area:365}洞口成群；{quest:6394}在裡面：在分三岔處走中間那條隧道。",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}，在洞穴裡",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}：再次交任務",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "回到洞內，一路貼著右手邊的牆壁走，越過一條小溪，到達水池上方巖臺上的{npc:3183}。",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}，來自{npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}，在大屋（獸穴）",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "{quest:805}，+50：{quest:97225}要等它完成",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367}（可選據點）",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Forever 裡這些舊任務任何等級都足額給分。{area:367}和{area:368}：25分鐘約700點{faction:76}和650點暗矛食人妖聲望。{npc:3188}和{npc:3304}站在棚屋旁，{npc:3194}在水邊，{npc:7953}在村子以南。",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "{quest:97225}，+100：需要洞穴裡的{quest:805}",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "{area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "游到村東南{area:368}中最大的島。{quest:826}、神像和能量法陣的骷髏都在那裡；杜洛塔猛虎在較小的島上徘徊。",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}：點選一個{object:3237}骷髏",

	-- Step 11: The coast and the road
	["The coast and the road"] = "海岸與道路",
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "龍蝦人和海灘爬行者出沒在森金村東面和南面的海灘。{quest:97223}在村東。脊影蜘蛛在{area:362}以南的道路沿線以及大屋（獸穴）東北。",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}：交任務",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949}：{quest:5726}（可選據點）",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "Forever 裡這些舊任務任何等級都足額給分。{quest:5726}：20分鐘400點{faction:76}聲望，中間要跑一趟{area:2437}，60級能單清。",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827}：{item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827}是{faction:76}正東的洞穴。裡面的燃燒之刃狂熱者和學徒約每五隻掉一個徽記。",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76}：{npc:4949}和{npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216}在{object:172960}裡。告訴他可以暢所欲言，並把他故事的每一行點完。",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216}：聽他說完",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "{area:2437}從{object:172960}進入。{npc:11518}和{npc:11519}在最深處等候。",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518}和{npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76}：完成{quest:5728}",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}：森金村交付",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362}（可選據點）",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "Forever 裡這些舊任務任何等級都足額給分。{area:362}和{zone:1411}北部：80分鐘約1,800點{faction:76}和1,650點暗矛食人妖聲望。{npc:3142}和{npc:3139}站在鎮子中間，{npc:3191}在兵營旁，{npc:3147}和{npc:266940}在邊上。",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}，+100：需要森金村的{quest:823}",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "城堡在{area:362}以南的海岸上。{npc:3192}在城堡唯一的建築裡；他的鑰匙能開啟屋頂上的{object:3239}，裡面的{item:4881}可開啟{quest:830}。水手和陸戰隊員掉落{item:4870}；{item:275713}、戰斧和盾牌躺在城堡外。",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816}和{area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "刺鬃營地在{area:362}的西南和以西；仙人掌果就長在營地間。然後去{area:368}找{object:3240}：每個巢每次都出一個蛋。",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}：交任務",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}，+100：去{faction:76}找{npc:3230}",

	-- Step 23: The wreck
	["The wreck"] = "沉船",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "沉船在{area:372}以東的淺灘。開啟地精工具箱。",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "回到{area:362}的{npc:3139}處",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "{zone:1411}北部",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293}站在{area:362}以北的道路上，{npc:3193}在她西邊的農場。",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369}和{area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203}在{faction:76}以南{area:369}的雷霆蜥蜴間設有燃燒之刃營地。補給袋在{area:362}以北的{area:410}。{item:4891}由西邊河岸的鱷魚掉落，約十分之一。",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293}和米莎",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "某個{npc:3118}可能掉落{item:277661}：使用它以接取{quest:97281}。交完後，{npc:3293}提供{quest:97282}。",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}，在{area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "充能的雷霆蜥蜴器官來自{npc:3293}正西{area:369}的雷霆蜥蜴。",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828}在{quest:827}（{faction:76}正東的洞穴）外紮營。",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76}：{npc:3216}和{npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829}在{object:172960}裡；{npc:3230}在格羅瑪什要塞，{npc:4949}身旁。",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "從{faction:76}西門跑出，過橋進入{zone:1413}。{npc:3337}和{quest:809}在{area:379}。",
	-- {quest:842} Crossroads Conscription · {quest:860} Sergra Darkthorn
	["{quest:842}, +100: to {quest:860}"] = "",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380}（可選據點）",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {quest:860} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {quest:860}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "十字路口周邊",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "刺鬃營地和補給箱在鎮的東北；精英野豬{npc:267307}深居那裡的{area:1699}洞穴。巫翼鷹身人巢居在遙遠的西北。{npc:10668}在南部{area:378}的東北：右鍵點選它。迅猛龍和陸行鳥到處都有。",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668}：右鍵點選它",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380}：交任務",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "澤布拉、野豬人、鷹身人和{area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "澤布拉奔跑者在鎮南和鎮西吃草。{npc:3438}指向東北的刺鬃營地。巫翼殺戮者攜帶戒指。{quest:3281}在{area:378}以東的{area:1697}：沿其左側佈滿巢穴的小路走到最後一個巢。",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380}：再次交任務",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "徘徊者、{npc:3452}和{quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "草原徘徊者在十字路口以西和以北。{quest:876}指向最西北的巫翼鷹身人。之後{npc:3338}給你{item:10327}：在鎮北{object:147524}的科多獸骸骨旁吹響，並殺死白獅。",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819}（可選據點）",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "Forever 裡任何等級都足額給。{quest:819}躺在{zone:1413}中部和北部幾個位置之一的地上，多數在十字路口周圍的路邊；有人拿走後會出現在另一處。{area:392}的{npc:3292}為酒桶和第一次灌裝給250點{faction:76}聲望，之後每次灌裝給50點，可重複。",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819}：沿路尋找",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "獅子、陸行鳥和一隻雷霆蜥蜴",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "草原獅、陸行鳥和雷霆蜥蜴遍佈{zone:1413}北部。獅子約每兩隻掉一顆獠牙，陸行鳥約五隻掉兩個腎臟；任何雷霆蜥蜴都可能掉角，約五分之一。",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392}：可重複的酒桶",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "此後德羅恩會收5個閃電腺、一個{item:4897}和一個{item:4896}，每次50聲望，不限次數。{npc:3238}雷霆蜥蜴（約每兩隻掉一個腺體）、巨型雷霆鷹和{area:378}以南的科多獸都會掉。回{area:392}之前多攢幾套。",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}，來自風暴皮",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}，來自巨型雷霆鷹",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}，來自科多獸",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "接下來是布料。羊毛、絲綢和魔紋布都要交完，{npc:14726}才會提供{item:14047}捐獻任務，而{quest:7832}需要完成{item:14047}捐獻。在拍賣行買布，或自己刷：人形生物掉落，羊毛15到25級，絲綢25到40級，魔紋布40到50級，{item:14047}50級以上。60級時刷52級以上的怪：更低的已是灰色。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：薊皮熊怪約每四隻掉一個",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "絲綢：{area:287}和奧特蘭克的辛迪加約每三隻掉一個，或者直接買。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔紋布：{zone:1448}南部的碧火薩特和{zone:1446}的沙丘食人魔約每三隻掉一個，或者直接買。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火薩特",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}內{area:2266}的血色士兵、{zone:1444}內{area:2577}外的戈多克食人魔，以及{zone:1451}的暮光營地，約每三隻掉一個。有錢的話拍賣行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266}外的血色士兵",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "這些任務是56到59級，所以60級時全額獎勵。{npc:10306}在{area:1997}；梟獸住在{zone:1452}，經{zone:1448}以北的木喉隧道前往。",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452}：梟獸",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "暴怒梟獸在{area:2255}西北，襤褸梟獸再往西。",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997}：交任務",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452}：月觸梟獸",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "{area:2255}以北和以南的月觸梟獸。",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997}：再次交任務",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452}：狂暴梟獸",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "大多數狂暴梟獸在{area:2255}以北。梟獸現在可能掉落{item:12558}：使用它以接取{quest:4882}。",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997}：最後一次交任務",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}，+100；{zone:1456}：去找{zone:1456}中{area:1639}的{npc:5770}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721}：300{faction:76}聲望。",

	-- Step 54: Valormok: Betrayed
	-- {area:1237} Valormok · {zone:1447} Azshara · {quest:3505} Betrayed · {npc:8576} Ag'tor Bloodfist · {npc:4485} Belgrom Rockmaul
	["Fly to {area:1237} in western {zone:1447}: on Forever, {quest:3505} starts with {npc:8576} there, with no letter from {npc:4485} first. The {quest:3505} quests are level 53 and pay in full at 60 too, as every quest does in Forever. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "飛往{zone:1447}西部的{area:1237}：在Forever上，{quest:3505}直接從那裡的{npc:8576}開始，不需要先拿{npc:4485}的信。{quest:3505}系列任務為53級，但和Forever的所有任務一樣，60級時仍給予全額獎勵。{npc:8576}會派你往東北前往北方半島峭壁上的血精靈營地。",

	-- Step 55: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的營地",
	-- {object:151286} Kaldorei Tome of Summoning (no name in this language: may be words) · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "殺掉收復者和勘測員，然後走到石柱環內的書旁。閱讀那裡的{object:151286}以接下一個任務：打碎圓圈周圍的水晶，殺掉出現的守衛，然後找{npc:8578}。",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "找到{npc:8578}的營地",
	-- {object:151286} Kaldorei Tome of Summoning (no name in this language: may be words)
	["the {object:151286}"] = "{object:151286}",

	-- Step 56: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237}與{faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485}，在{faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506}：60級時300{faction:76}聲望。",

	-- Step 57: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "黑石山，組隊前往",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{zone:1418}的{area:340}會發放{area:1584}和{area:1583}的{faction:76}任務，都是58到60級且全額獎勵：“命懸一線”和“行動：殺死安格弗將軍”（各150），{quest:4724}和{item:12652}（各100），{quest:4903}（150），{npc:3144}的智慧（100）以及“為了部落！”（雷德之首，給所有部落城市200）。這些是地城任務：隨隊前往時接。",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077}：{quest:4903}，+150，五人小隊",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081}：{quest:4724}，+100，五人小隊",

	-- Step 58: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832}到尊敬",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832}：20個{item:14047}換50聲望，不限次數。友善到尊敬需6,000點：120次交付，2,400個{item:14047}，減去任務已給的部分（獸人起始友善1,000：100次交付；不死族或天裔精靈起始中立2,000，先需20次交付、400個{item:14047}才能到友善）。身上每有20個就交一次，連續交。",

	-- Step 59: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832}到崇敬",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "尊敬到崇敬需12,000點：240次交付，4,800個{item:14047}。一組在拍賣行的價格決定是刷還是買。",

	-- Step 60: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832}到崇拜",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "崇敬到崇拜需21,000點：420次交付，8,400個{item:14047}。團隊首領也給聲望：“黑石之王”（奈法利安）給所有部落城市200點，“為部落而戰”（奧妮克希亞）給{faction:76}400點。崇拜後，{object:172958}裡的{npc:3362}會向所有部落種族出售狼：40級的狼20金，60級的迅捷狼200金（Forever價格）；經典舊世裡其他種族需崇拜才能買。",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362}：狼",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7832}，直到{faction:76}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7832}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "科卡爾半人馬（30-33級）在這裡會掉落。拍賣場也買得到。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的風險投資公司執行者（16-17級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726}在{faction:76}收取布料以提升{faction:76}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7832}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726}：{item:14047}已交付",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
