-- Chinese (simplified) (zhCN): the guide forever/reputation/darkspear-trolls (forever/reputation/darkspear-trolls.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkspear Trolls Reputation"] = "暗矛巨魔声望",
	-- {item:14047} Runecloth · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too."] = "",
	-- {faction:530} Darkspear Trolls
	["Exalted with the {faction:530}"] = "{faction:530}声望达到崇拜",

	-- Step 1: Vehena: how it works
	-- {npc:14727} Vehena
	["{npc:14727}: how it works"] = "{npc:14727}：规则说明",
	-- {npc:14727} Vehena · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:7837} Additional Runecloth · {item:14047} Runecloth · {faction:530} Darkspear Trolls · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {area:414} Zoram Strand · {zone:1440} Ashenvale · {object:3202} Grom'gol
	["Darkspear reputation comes from quests and cloth. {npc:14727}, the Darkspear cloth quartermaster, stands in {zone:1454}'s {object:172961}. She takes four one-time donations of 60 cloth (150 each) and then {quest:7837}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:530} also gives a quarter as much to {zone:1454}, {zone:1456} and the {zone:1458}. While you level, do the Darkspear quests within 5 levels of them: {zone:1411} at 5 to 12, {area:414} in {zone:1440} at 19 to 27, {object:3202} in Stranglethorn at 34 to 46. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the Darkspear merchants sell to you for 10% less (the Classic rule), the raptor vendor included; at Exalted other races can buy the raptors: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60, once you have mount training. The {faction:530} have no tabard or other reward."] = "暗矛声望来自任务和布料。暗矛布料军需官{npc:14727}站在{zone:1454}的{object:172961}。她先接受四次各60块布的一次性捐献（每次150声望），然后开放{quest:7837}，每20块{item:14047}换50声望，可无限重复。你每获得一点{faction:530}声望，也会向{zone:1454}、{zone:1456}和{zone:1458}各溢出四分之一。练级时，在任务等级与自身相差不超过5级时完成暗矛任务：5到12级做{zone:1411}，19到27级做{zone:1440}的{area:414}，34到46级做荆棘谷的{object:3202}。传承的外交家特长最多增加10%。奖励：尊敬时，暗矛商人的售价降低10%（经典版规则），包括迅猛龙商人；崇拜后其他种族也能购买迅猛龙：学会坐骑骑术后，40级迅猛龙20金币，60级迅捷迅猛龙200金币。{faction:530}没有战袍或其他奖励。",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363}（可选任务点）",
	-- {area:363} Valley of Trials · {zone:1454} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "",
	-- {npc:3144} Eitrigg · {zone:1454} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {zone:1454}: {quest:787}, +50"] = "{npc:3144}，位于{zone:1454}：{quest:787}，+50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}：{quest:792}，仅限术士",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "野猪、武器与苦工",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "训练用武器散落在巢穴内及北面野猪群之间。至于苦工：选中睡着的{npc:10556}，对其使用{item:16114}。",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}：用 {item:16114} 击中它",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}：交任务",

	-- Step 5: North of the Den
	["North of the Den"] = "兽穴以北",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "仙人掌果长在巢穴北面的仙人掌旁。{npc:3287}负伤躺在北面岩石旁；他的大蝎子{quest:790}在附近游荡。{quest:792}聚集在{area:365}洞口；{quest:6394}在洞内：遇到三岔路时走中间的隧道。",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}，在洞穴内。",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}：再次交还",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "返回洞穴，始终沿右侧墙走，越过一条小溪，到水池上方凸台上的{npc:3183}处。",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}，由 {npc:3183} 提供",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}，在大兽穴里",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367}（可选任务点）",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {zone:1454} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 625 {zone:1454} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "{area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "游到村庄东南面 {area:368} 中最大的岛。{quest:826}、神像和力量法阵处的头骨都在那里；杜隆塔尔猛虎在较小的岛屿上徘徊。",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}：点击一个{object:3237}骷髅头",

	-- Step 11: The coast and the road
	["The coast and the road"] = "海岸与道路",
	-- {quest:97223} Bloodtalon Matriarch
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village."] = "",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}：交任务",

	-- Step 13: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}：交还森金村的任务",

	-- Step 14: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362}（可选任务点）",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {zone:1454} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,650 {zone:1454} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and Turroc at the edges."] = "",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}，+100：需要先接取森金村的 {quest:823}",

	-- Step 15: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}."] = "",

	-- Step 16: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} 与 {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "",

	-- Step 17: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}：交任务",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {zone:1454} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {zone:1454}"] = "{quest:830}，+100：交给{zone:1454}的{npc:3230}",

	-- Step 18: The wreck
	["The wreck"] = "沉船",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "沉船在{area:372}东面的浅水中。打开侏儒工具箱。",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "回到 {area:362} 的 {npc:3139} 处",

	-- Step 19: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "{zone:1411} 北部",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} 站在 {area:362} 北面的道路上，{npc:3193} 在道路西侧的自家农场里。",

	-- Step 20: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369}和{area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {zone:1454}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} 在 {zone:1454} 南边 {area:369} 的雷霆蜥蜴之间设有火刃营地。补给袋在 {area:362} 北边的 {area:410}。{item:4891} 由西边河流沿岸的鳄鱼掉落，概率约为十分之一。",

	-- Step 21: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293}和米莎",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "{npc:3118} 可能掉落 {item:277661}：使用它开始 {quest:97281}。交还后，{npc:3293} 会提供 {quest:97282}。",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}，位于 {area:370}",

	-- Step 22: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "带电的雷霆蜥蜴器官由 {area:369} 的雷霆蜥蜴掉落，就在 {npc:3293} 正西方。",

	-- Step 24: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {zone:1454} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {zone:1454}."] = "{quest:828} 驻扎在 {quest:827} 外面，那是 {zone:1454} 正东边的洞穴。",

	-- Step 25: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {zone:1454} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{zone:1454}: {npc:3216} and {npc:3230}"] = "{zone:1454}：{npc:3216}和{npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside Thrall."] = "{quest:829}在{object:172960}；{npc:3230}在格罗玛什要塞的萨尔旁边。",

	-- Step 26: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {zone:1454}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "从{zone:1454}西门跑出去，过桥进入{zone:1413}。{npc:3337}和{quest:809}站在{area:379}。",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}，+100 点声望：交给 {npc:3338}。",

	-- Step 28: Vehena: A Donation of Wool
	-- {npc:14727} Vehena · {item:14047} Runecloth · {quest:7837} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14727} offers the {item:14047} donation, and {quest:7837} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "接下来靠交布。必须先交完毛料、丝绸和魔纹布，{npc:14727}才会开放{item:14047}捐献，而{quest:7837}又要求先完成{item:14047}捐献。可在拍卖行买布，也可自行刷取：人型生物会掉落，15到25级掉毛料，25到40级掉丝绸，40到50级掉魔纹布，50级及以上掉{item:14047}。60级时刷52级或更高的怪物：更低的已是灰色。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：蓟皮熊怪约每击杀四只掉落一个",

	-- Step 29: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "丝绸：{area:287} 和奥特兰克的辛迪加约每三次击杀掉落一次，也可以购买。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 30: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔纹布：{zone:1448} 南部的碧火萨特和 {zone:1446} 的砂槌食人魔大约每击杀三只掉落一次，也可以购买。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火萨特",

	-- Step 31: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}的{area:2266}血色成员、{zone:1444}的{area:2577}外戈多克食人魔，以及{zone:1451}的暮光营地敌人，约每击杀3个掉落一次。若有金币，拍卖行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266} 外的血色十字军",

	-- Step 32: Everlook: A Little Luck
	-- {quest:969} Luck Be With You · {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10307} Witch Doctor Mau'ari · {item:12334} Frostmaul Shards · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["{quest:969} is level 60, so it pays in full. {npc:11755} in {area:2255} sends you to {npc:10307}, who stands in the same town. The {item:12334} lie on the ground in {area:2249}, the canyon at the south end of {zone:1452}, and the Frostmaul Giants there drop them too (about one in five). The giants are elite level 59 and 60 and stand close together: pick the shards at the edges, pull one giant at a time, or bring a friend."] = "{quest:969}是60级任务，因此奖励全额声望。{area:2255}的{npc:11755}让你找同一座镇子里的{npc:10307}。{item:12334}散落在{zone:1452}最南端峡谷{area:2249}的地上，当地霜槌巨人也会掉落（约五分之一概率）。巨人是59和60级精英，站得很密：从外围拾取碎片，一次只引一个巨人，或带个朋友。",

	-- Step 33: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "黑石山，组队前往",
	-- {area:1583} Blackrock Spire · {faction:530} Darkspear Trolls · {area:340} Kargath · {zone:1418} Badlands · {quest:4903} Warlord's Command · {npc:3144} Eitrigg · {zone:1458} Undercity · {area:978} Zul'Farrak · {zone:1425} Hinterlands
	["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way."] = "",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, a group of five"] = "{npc:9077}：{quest:4903}，五人小队。",

	-- Step 34: Additional Runecloth to Honored
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Honored"] = "{quest:7837}刷到尊敬",
	-- {quest:7837} Additional Runecloth · {item:14047} Runecloth
	["{quest:7837}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a troll starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne at Neutral 2,000 first needs 20 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7837}：用20块 {item:14047} 换取50点声望，可无限次交还。从友善到尊敬需要6,000点：120次交还，共2,400块 {item:14047}，再减去任务已提供的声望（巨魔起始为友善1,000点：需要100次；亡灵或天裔起始为中立2,000点，需先额外交还20次才能达到友善）。把随身带的布每20块一组，连续交还。",

	-- Step 35: Additional Runecloth to Revered
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Revered"] = "{quest:7837}刷到崇敬",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "从尊敬到崇敬需要12,000声望：交还240次，共4,800块 {item:14047}。根据拍卖行每组售价，决定自己刷还是购买。",

	-- Step 36: Additional Runecloth to Exalted
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Exalted"] = "{quest:7837}刷到崇拜",
	-- {item:14047} Runecloth · {npc:7952} Zjolnir · {area:367} Sen'jin Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. At Exalted, {npc:7952} in {area:367} sells the raptors to every Horde race: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "崇敬到崇拜需要21,000：交还420次、8,400块{item:14047}。崇拜后，{area:367}的{npc:7952}会向所有部落种族出售迅猛龙：40级迅猛龙20金币，60级迅捷迅猛龙200金币（无限服价格）；经典版中其他种族需要崇拜才能购买。",
	-- {npc:7952} Zjolnir
	["{npc:7952}: the raptors"] = "{npc:7952}：迅猛龙。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way (a fifth at 60 in Classic)."] = "“为部落而战！”（雷德的头颅，{area:1583}）和“黑石之王”（奈法利安的头颅）都为每座部落主城增加200声望，包括{faction:530}。雷德任务线从{zone:1418}的{area:340}开始：{quest:4903}、{npc:3144}的智慧，然后是“为部落而战！”。小队前往时就接上。{zone:1458}指南中的“蜘蛛之神”任务线（{area:978}和{zone:1425}）沿途共奖励225暗矛声望（经典版中60级时只有五分之一）。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "经典版中，低于你6级或更多的任务奖励会减少（60级时为五分之一）；一则无限服测试反馈称仍按全额发放。第一次交还就能看出：如果只有五分之一，就跳过这些任务点。其中最佳的是{area:363}：25分钟约获得1,400点{zone:1454}和1,400点暗矛声望（按五分之一则各约280）。{npc:3143}在大兽穴的大屋里等候；{npc:10176}站在屋外。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {zone:1454} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "经典旧世中，比你低至少6级的任务奖励会减少（60级时为五分之一）；一份无限测试版报告称其奖励全额声望。第一次交还任务即可确认：若只有五分之一，就跳过这些任务区。{area:362}和{zone:1411}北部：约80分钟可获得1,800点{zone:1454}和1,650点暗矛巨魔声望（五分之一时为360和330）。{npc:3142}和{npc:3139}站在镇子中央，{npc:3191}在兵营旁，{npc:3147}和{npc:266940}在镇子边缘。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {zone:1454} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。{area:367} 和 {area:368}：25 分钟约提供 700 点 {zone:1454} 和 650 点暗矛声望（按五分之一计算为 140 和 130 点）。{npc:3188} 和 {npc:3304} 站在小屋旁，{npc:3194} 在水边，{npc:7953} 在村庄南侧。",
	-- ["Keep handing in {quest:7837} until {faction:530} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7837}，直到{faction:530}达到崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7837}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7837}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "这里的科卡尔半人马（30-33级）会掉落。也可以去拍卖行购买。",
	-- ["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "龙虾人和海浪蟹在森金村东侧和南侧的海滩活动。{quest:97223} 在村庄东侧。脊影 蜘蛛位于 {area:362} 南侧道路沿线、巢穴东北方。",
	-- ["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "钢鬃营地在{area:362}西南方和西侧；营地间长有刺梨仙人掌。然后前往{area:368}寻找{object:3240}：每个巢穴必定提供一个蛋。",
	-- ["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "要塞位于{area:362}南面的海岸。{npc:3192}在要塞唯一的建筑里；他的钥匙能打开屋顶的{object:3239}，里面的{item:4881}可触发{quest:830}。水手和海军陆战队员掉落{item:4870}；{item:275713}、战斧和盾牌在要塞外。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的风险投资公司执行者（16-17级）会掉落。也可以去拍卖行购买。",
	-- ["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too if they still pay in full."] = "用{item:14047}刷到崇拜，{zone:1411}的老任务可作为快速补充，如果仍给全额奖励，还会同时提升{zone:1454}声望。",
	-- ["{npc:14727} takes cloth for {faction:530} in the {object:172961}, {zone:1454}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7837} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14727}在{zone:1454}的{object:172961}收取布料以提升{faction:530}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7837}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14727}: {item:14047} delivered"] = "{npc:14727}：已交付{item:14047}",
	-- ["{quest:7837} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7837}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
}
