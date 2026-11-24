-- Chinese (traditional) (zhTW): the guide forever/reputation/darkspear-trolls (forever/reputation/darkspear-trolls.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkspear Trolls Reputation"] = "暗矛食人妖聲望",
	-- {item:14047} Runecloth · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too."] = "交{item:14047}交到崇拜，同時把{zone:1411}的舊任務當作快速補充，它們也給{zone:1454}聲望。",
	-- {faction:530} Darkspear Trolls
	["Exalted with the {faction:530}"] = "{faction:530}聲望達到崇拜",

	-- Step 1: Vehena: how it works
	-- {npc:14727} Vehena
	["{npc:14727}: how it works"] = "{npc:14727}：運作方式",
	-- {npc:14727} Vehena · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:7837} Additional Runecloth · {item:14047} Runecloth · {faction:530} Darkspear Trolls · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {area:414} Zoram Strand · {zone:1440} Ashenvale · {object:3202} Grom'gol
	["Darkspear reputation comes from quests and cloth. {npc:14727}, the Darkspear cloth quartermaster, stands in {zone:1454}'s {object:172961}. She takes four one-time donations of 60 cloth (150 each) and then {quest:7837}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:530} also gives a quarter as much to {zone:1454}, {zone:1456} and the {zone:1458}. While you level, do the Darkspear quests within 5 levels of them: {zone:1411} at 5 to 12, {area:414} in {zone:1440} at 19 to 27, {object:3202} in Stranglethorn at 34 to 46. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the Darkspear merchants sell to you for 10% less (the Classic rule), the raptor vendor included; at Exalted other races can buy the raptors: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60, once you have mount training. The {faction:530} have no tabard or other reward."] = "暗矛聲望來自任務和布料。暗矛布料軍需官{npc:14727}站在{zone:1454}的{object:172961}。她先接受四次各60塊布的一次性捐獻（每次150聲望），然後開放{quest:7837}，每20塊{item:14047}換50聲望，可無限重複。你每獲得一點{faction:530}聲望，也會向{zone:1454}、{zone:1456}和{zone:1458}各溢位四分之一。練級時，在任務等級與自身相差不超過5級時完成暗矛任務：5到12級做{zone:1411}，19到27級做{zone:1440}的{area:414}，34到46級做荊棘谷的{object:3202}。傳承的外交家特長最多增加10%。獎勵：尊敬時，暗矛商人的售價降低10%（經典版規則），包括迅猛龍商人；崇拜後其他種族也能購買迅猛龍：學會坐騎騎術後，40級迅猛龍20金幣，60級迅捷迅猛龍200金幣。{faction:530}沒有戰袍或其他獎勵。",
	["her donations are handed in from her window and never enter the log"] = "她的捐獻任務在她的視窗中直接繳交，不會進入任務日誌",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363}（可選任務點）",
	-- {area:363} Valley of Trials · {zone:1454} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Forever 裡這些舊任務任何等級都足額給分。{area:363}是其中最好的：25分鐘約1,400點{zone:1454}和1,400點暗矛食人妖聲望。{npc:3143}在大棚屋“洞穴”裡等著，{npc:10176}站在外面。",
	-- {npc:3144} Eitrigg · {zone:1454} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {zone:1454}: {quest:787}, +50"] = "{npc:3144}，在{zone:1454}：{quest:787}，+50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}：{quest:792}，僅限術士",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "野豬、武器和苦工",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "訓練武器散落在獸穴的地上和北面野豬群中。對付苦工：選中一個睡著的{npc:10556}，對它使用{item:16114}。",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}：用{item:16114}敲它",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "喚醒{npc:10556}",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}：交付",

	-- Step 5: North of the Den
	["North of the Den"] = "獸穴以北",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "仙人掌果長在獸穴以北的仙人掌旁。{npc:3287}受傷躺在北邊的岩石旁；他的大蠍子{quest:790}就在附近遊蕩。{quest:792}在{area:365}洞口成群出沒；{quest:6394}在洞裡面：在三岔口走中間的隧道。",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}，在洞裡",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}：再次交付",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "回到洞裡，全程貼著右手邊的牆走，越過一條小溪，{npc:3183}就在水潭上方的巖架上。",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}，來自{npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}，在獸穴裡",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "{quest:805}，+50：{quest:97225}要等它完成",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367}（可選任務點）",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {zone:1454} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 625 {zone:1454} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Forever 裡這些舊任務任何等級都足額給分。{area:367}和{area:368}：25分鐘約625點{zone:1454}和650點暗矛食人妖聲望。{npc:3188}和{npc:3304}站在棚屋旁，{npc:3194}在水邊，{npc:7953}在村子以南。",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "{quest:97225}，+100：需要洞穴裡的{quest:805}",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "{area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "游到村子東南{area:368}中最大的島上。{quest:826}、神像和力量法陣處的頭骨都在那裡；杜洛塔猛虎在較小的島上出沒。",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}：點選一顆{object:3237}頭骨",

	-- Step 11: The coast and the road
	["The coast and the road"] = "海岸與道路",
	-- {quest:97223} Bloodtalon Matriarch
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village."] = "龍蝦人和碎浪爬行者在森金以東和以南的海灘上活動。{quest:97223}在村子以東。",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}：交付",

	-- Step 13: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}：森金交付",

	-- Step 14: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362}（可選任務點）",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {zone:1454} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,650 {zone:1454} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and Turroc at the edges."] = "Forever 裡這些舊任務任何等級都足額給分。{area:362}和{zone:1411}北部：80分鐘約1,650點{zone:1454}和1,650點暗矛食人妖聲望。{npc:3142}和{npc:3139}站在鎮子中間，{npc:3191}在兵營旁，{npc:3147}和圖洛克在邊上。",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}，+100：需要森金的{quest:823}",

	-- Step 15: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}."] = "要塞在{area:362}以南的海岸上。{npc:3192}在要塞唯一的那棟樓裡；他的鑰匙能開啟屋頂的{object:3239}，裡面的{item:4881}會開啟{quest:830}。水手和陸戰隊員掉{item:4870}。",

	-- Step 16: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816}和{area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "鋼鬃野豬人的營地在{area:362}西南和西邊。然後去{area:368}找{object:3240}：每個巢每次都給一個蛋。",

	-- Step 17: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}：交付",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {zone:1454} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {zone:1454}"] = "{quest:830}，+100：交給{zone:1454}的{npc:3230}",

	-- Step 18: The wreck
	["The wreck"] = "沉船",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "失事的船在{area:372}以東的淺灘裡。開啟地精工具箱。",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "回到{area:362}的{npc:3139}處",

	-- Step 19: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "{zone:1411}北部",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293}站在{area:362}以北的路上，{npc:3193}在村西她的農場。",

	-- Step 20: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369}和{area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {zone:1454}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203}在{zone:1454}以南的{area:369}設有火刃營地，周圍都是雷霆蜥蜴。補給袋在{area:362}以北的{area:410}。{item:4891}由西面河邊的鱷魚掉落，約十殺出一。",

	-- Step 21: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293}和米莎",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "{npc:3118}可能掉落{item:277661}：使用它開啟{quest:97281}。交完該任務後，{npc:3293}會提供{quest:97282}。",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}，在{area:370}",

	-- Step 22: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "充能的雷霆蜥蜴器官來自{area:369}的雷霆蜥蜴，就在{npc:3293}西面。",

	-- Step 24: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {zone:1454} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {zone:1454}."] = "{quest:828}在{quest:827}外面紮營，那是{zone:1454}以東不遠處的洞穴。",

	-- Step 25: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {zone:1454} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{zone:1454}: {npc:3216} and {npc:3230}"] = "{zone:1454}：{npc:3216}和{npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside Thrall."] = "{quest:829}在{object:172960}裡；{npc:3230}在格羅瑪什要塞索爾旁邊。",

	-- Step 26: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {zone:1454}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "跑出{zone:1454}西門，過橋進入{zone:1413}。{npc:3337}和{quest:809}在{area:379}。",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}，+100：交給{npc:3338}",

	-- Step 28: Vehena: A Donation of Wool
	-- {npc:14727} Vehena · {item:14047} Runecloth · {quest:7837} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14727} offers the {item:14047} donation, and {quest:7837} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "從這裡開始就是布料。必須先交完毛料、絲綢和魔紋布，{npc:14727}才會提供{item:14047}捐獻，而{quest:7837}也需要先完成{item:14047}捐獻。布料可在拍賣行購買，或自己刷：人形生物掉落布料，毛料來自15至25級，絲綢25至40級，魔紋布40至50級，{item:14047}50級起。60級時刷52級及以上的怪物，等級更低的怪是灰色的。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：薊皮熊怪約四殺出一",

	-- Step 29: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "絲綢：{area:287}和奧特蘭克的辛迪加約三殺出一，或者直接買。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 30: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔紋布：{zone:1448}南部的碧火薩特和{zone:1446}的砂槌食人魔約三殺出一，或者直接買。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火薩特",

	-- Step 31: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}{area:2266}的血色十字軍、{zone:1444}{area:2577}外的戈多克食人魔和{zone:1451}的暮光營地約三殺出一。有金幣的話拍賣行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266}外的血色十字軍",

	-- Step 32: Everlook: A Little Luck
	-- {quest:969} Luck Be With You · {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10307} Witch Doctor Mau'ari · {item:12334} Frostmaul Shards · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["{quest:969} is level 60, so it pays in full. {npc:11755} in {area:2255} sends you to {npc:10307}, who stands in the same town. The {item:12334} lie on the ground in {area:2249}, the canyon at the south end of {zone:1452}, and the Frostmaul Giants there drop them too (about one in five). The giants are elite level 59 and 60 and stand close together: pick the shards at the edges, pull one giant at a time, or bring a friend."] = "{quest:969}是60級任務，所以全額給聲望。{area:2255}的{npc:11755}讓你去找同鎮的{npc:10307}。{item:12334}散落在{area:2249}——{zone:1452}南端的峽谷——的地上，那裡的霜槌巨人也會掉落（約五殺出一）。巨人是59和60級精英且站位密集：撿邊緣的碎片，一次拉一個巨人，或者帶上朋友。",

	-- Step 33: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "黑石山，組隊前往",
	-- {area:1583} Blackrock Spire · {faction:530} Darkspear Trolls · {area:340} Kargath · {zone:1418} Badlands · {quest:4903} Warlord's Command · {npc:3144} Eitrigg · {zone:1458} Undercity · {area:978} Zul'Farrak · {zone:1425} Hinterlands
	["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way."] = "《為了部落！》（雷德之首，{area:1583}）和《黑石之王》（奈法利安之首）給每個部落城市200點，包括{faction:530}。{zone:1418}的{area:340}開啟雷德任務鏈：{quest:4903}、{npc:3144}的“智慧”，然後是《為了部落！》。組隊去的時候順便接。{zone:1458}指南裡的蜘蛛之神任務鏈（{area:978}和{zone:1425}）路上給225點暗矛聲望。",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, a group of five"] = "{npc:9077}：{quest:4903}，五人小隊",

	-- Step 34: Additional Runecloth to Honored
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Honored"] = "{quest:7837}到尊敬",
	-- {quest:7837} Additional Runecloth · {item:14047} Runecloth
	["{quest:7837}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a troll starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne at Neutral 2,000 first needs 20 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7837}：20張{item:14047}換50點聲望，可無限重複。友善到尊敬是6000點：120次交付，2400張{item:14047}，再減去任務已給的（食人妖從友善1000點開始：100次交付；不死族或天裔從中立2000點開始，需先多交20次才到友善）。身上每攢夠20張就連續交掉。",

	-- Step 35: Additional Runecloth to Revered
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Revered"] = "{quest:7837}到崇敬",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "尊敬到崇敬是12000點：240次交付，4800張{item:14047}。拍賣行的整組價格決定是刷還是買。",

	-- Step 36: Additional Runecloth to Exalted
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Exalted"] = "{quest:7837}到崇拜",
	-- {item:14047} Runecloth · {npc:7952} Zjolnir · {area:367} Sen'jin Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. At Exalted, {npc:7952} in {area:367} sells the raptors to every Horde race: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "崇敬到崇拜是21000點：420次交付，8400張{item:14047}。崇拜後，{area:367}的{npc:7952}向每個部落種族出售迅猛龍：40級迅猛龍20金，60級迅捷迅猛龍200金（Forever的價格）；經典舊世中其他種族需要崇拜才能購買。",
	-- {npc:7952} Zjolnir
	["{npc:7952}: the raptors"] = "{npc:7952}：迅猛龍",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7837} until {faction:530} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7837}，直到{faction:530}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7837}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7837}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "科卡爾半人馬（30-33級）在這裡會掉落。拍賣場也買得到。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的風險投資公司執行者（16-17級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14727} takes cloth for {faction:530} in the {object:172961}, {zone:1454}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7837} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14727}在{zone:1454}的{object:172961}收取布料以提升{faction:530}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7837}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14727}: {item:14047} delivered"] = "{npc:14727}：{item:14047}已交付",
	-- ["{quest:7837} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7837}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
