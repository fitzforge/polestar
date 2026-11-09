-- Chinese (simplified) (zhCN): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "奥格瑞玛声望",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "{faction:76}达到崇拜",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76}：规则说明",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "{faction:76} 声望来自任务和布料。布匹军需官 {npc:14726} 站在暗巷区的布甲与皮甲商店旁。她接受四种各 60 块布的一次性捐献（每种奖励 150 点声望），随后可无限重复 {quest:7832}，每 20 个 {item:14047} 换取 50 点声望。每获得一点 {faction:76} 声望，还会给 {zone:1456}、{zone:1458} 和暗矛巨魔各提供四分之一的声望。升级时，在任务等级与你相差不超过 5 级时完成 {faction:76} 的任务：5 至 12 级做 {zone:1411}，12 至 20 级做十字路口，12 至 16 级做 {npc:4949} 的 {quest:5726}。传承特权外交家可使声望收益最多提高 10%。奖励：尊敬后，奥格瑞玛商人会给你 10% 折扣（经典旧世规则），包括座狼商人；崇拜后，其他种族也可购买座狼：学会骑术后，40 级座狼为 20 金币，60 级迅捷座狼为 200 金币。{faction:76} 没有战袍或其他奖励。",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363}（可选任务点）",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144}，位于{faction:76}：{quest:787}，+50",
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
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "",
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
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "龙虾人和海浪蟹在森金村东侧和南侧的海滩活动。{quest:97223} 在村庄东侧。脊影 蜘蛛位于 {area:362} 南侧道路沿线、巢穴东北方。",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}：交任务",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949}：{quest:5726}（可选任务点）",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827}：{item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827}就是{faction:76}东面不远处的洞穴。里面的火刃狂热者和学徒约每击杀5个掉落一次徽记。",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76}：{npc:4949} 和 {npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216} 在 {object:172960} 内。告诉他可以直说，逐项点击听完他的故事。",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216}：听他说完",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "{area:2437}的入口位于{object:172960}旁。{npc:11518}和{npc:11519}在尽头等候。",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518}和{npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76}：{quest:5728} 已完成",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}：交还森金村的任务",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362}（可选任务点）",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}，+100：需要先接取森金村的 {quest:823}",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "要塞位于{area:362}南面的海岸。{npc:3192}在要塞唯一的建筑里；他的钥匙能打开屋顶的{object:3239}，里面的{item:4881}可触发{quest:830}。水手和海军陆战队员掉落{item:4870}；{item:275713}、战斧和盾牌在要塞外。",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} 与 {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "钢鬃营地在{area:362}西南方和西侧；营地间长有刺梨仙人掌。然后前往{area:368}寻找{object:3240}：每个巢穴必定提供一个蛋。",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}：交任务",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}，+100：交给{faction:76}的{npc:3230}",

	-- Step 23: The wreck
	["The wreck"] = "沉船",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "沉船在{area:372}东面的浅水中。打开侏儒工具箱。",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "回到 {area:362} 的 {npc:3139} 处",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "{zone:1411} 北部",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} 站在 {area:362} 北面的道路上，{npc:3193} 在道路西侧的自家农场里。",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369}和{area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} 在 {faction:76} 南侧的 {area:369}、雷霆蜥蜴之间建立了一处火刃营地。补给袋散落在 {area:362} 北侧的 {area:410}。{item:4891} 由西侧河流沿线的鳄鱼掉落，概率约为十分之一。",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293}和米莎",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "{npc:3118} 可能掉落 {item:277661}：使用它开始 {quest:97281}。交还后，{npc:3293} 会提供 {quest:97282}。",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}，位于 {area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "带电的雷霆蜥蜴器官由 {area:369} 的雷霆蜥蜴掉落，就在 {npc:3293} 正西方。",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828}在{quest:827}外扎营，后者是{faction:76}东面不远处的洞穴。",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76}：{npc:3216} 和 {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829}在{object:172960}；{npc:3230}在格罗玛什要塞的{npc:4949}旁。",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "从 {faction:76} 西门出去，过桥进入 {zone:1413}。{npc:3337} 和 {quest:809} 位于 {area:379}。",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}，+100 点声望：交给 {npc:3338}。",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380}（可选任务点）",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "十字路口周边",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "钢鬃营地和补给箱在镇子东北面；精英野猪{npc:267307}待在那里的{area:1699}洞穴深处。巫翼鹰身人的巢穴在西北远处。{npc:10668}的尸体位于南部、{area:378}东北面：右键点击。迅猛龙和陆行鸟到处都有。",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668}：右键点击它。",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380}：交任务",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "斑马、野猪人、鹰身人及{area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "快步斑马在镇子以南和以西觅食。{npc:3438}领导着东北面的钢鬃营地。巫翼杀戮者携带指环。{quest:3281}位于{area:378}东面的{area:1697}：沿其左侧两旁都是鸟巢的小径走到最后一个巢。",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380}：再次交还",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "徘徊者、{npc:3452}和{quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "草原徘徊者在十字路口西侧和北侧活动。{quest:876} 在西北远处率领巫翼鹰身人。随后 {npc:3338} 会给你 {item:10327}：到镇北 {object:147524} 的科多兽骸骨旁吹响它，击杀白狮。",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819}（可选任务点）",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819}：在路旁寻找",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "狮子、平原陆行鸟和一只雷霆蜥蜴",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "草原狮、陆行鸟和雷霆蜥蜴遍布 {zone:1413} 北部。狮子约有一半概率掉落长牙，陆行鸟掉落肾脏的概率约为五分之二；任何雷霆蜥蜴都可能掉角，概率约为五分之一。",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392}：可重复的酒桶任务",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "此后，酿酒师德罗恩每收取5个闪电腺、一个 {item:4897} 和一个 {item:4896}，就会奖励50点，可无限重复。{area:378} 南边的雷霆蜥蜴 {npc:3238}（约每两只掉落一个腺体）、巨型雷鹰和科多兽会掉落所需材料。多收集几套，再返回 {area:392}。",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}，从雷鳞蜥蜴身上获得",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}，由巨型雷鹰掉落",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}，由科多兽掉落",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "接下来靠交布。必须先交完毛料、丝绸和魔纹布，{npc:14726}才会开放{item:14047}捐献，而{quest:7832}又要求先完成{item:14047}捐献。可在拍卖行买布，也可自行刷取：人型生物会掉落，15到25级掉毛料，25到40级掉丝绸，40到50级掉魔纹布，50级及以上掉{item:14047}。60级时刷52级或更高的怪物：更低的已是灰色。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：蓟皮熊怪约每击杀四只掉落一个",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "丝绸：{area:287} 和奥特兰克的辛迪加约每三次击杀掉落一次，也可以购买。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔纹布：{zone:1448} 南部的碧火萨特和 {zone:1446} 的砂槌食人魔大约每击杀三只掉落一次，也可以购买。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火萨特",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}的{area:2266}血色成员、{zone:1444}的{area:2577}外戈多克食人魔，以及{zone:1451}的暮光营地敌人，约每击杀3个掉落一次。若有金币，拍卖行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266} 外的血色十字军",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "这些任务为 56 至 59 级，因此 60 级仍给予完整奖励。{npc:10306} 站在 {area:1997}；枭兽栖息在 {zone:1452}，穿过 {zone:1448} 北边的木喉隧道可到达。",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452}：枭兽",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "狂怒的枭兽在 {area:2255} 西北，蓬毛枭兽在更西边。",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997}：交任务",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452}：月光枭兽",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "{area:2255} 北侧和南侧的月光枭兽。",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997}：再次交还",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452}：狂暴枭兽",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "大多数狂暴枭兽都在 {area:2255} 北边。枭兽现在可能掉落 {item:12558}：使用它开始 {quest:4882}。",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997}：最后一次交任务",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}，+100点 {zone:1456} 声望：交给 {zone:1456} 的 {area:1639} 上的 {npc:5770}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721}：300点 {faction:76} 声望。",

	-- Step 54: Belgrom Rockmaul: Betrayed
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {object:173084} Hall of the Brave (no name in this language: may be words) · {quest:3504} Betrayed
	["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay in full at 60 too, as every quest does in Forever."] = "",

	-- Step 55: Valormok
	-- {area:1237} Valormok · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist
	["Fly to {area:1237} in western {zone:1447}. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "飞往{zone:1447}西部的{area:1237}。{npc:8576}会派你向东北前往北部半岛高地上的血精灵营地。",

	-- Step 56: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的营地",
	-- {object:151286} Kaldorei Tome of Summoning · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "击杀搜寻者和勘测员，然后走近环形石柱内的书。阅读那里的{object:151286}开启后续任务：破坏圆圈周围的水晶，击杀出现的守卫，最后击杀{npc:8578}。",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "找到{npc:8578}的营地",
	-- {object:151286} Kaldorei Tome of Summoning
	["the {object:151286}"] = "{object:151286}",

	-- Step 57: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237} 与 {faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485}，在 {faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506}：60 级时奖励 300 点 {faction:76} 声望。",

	-- Step 58: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "黑石山，组队前往",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{zone:1418}的{area:340}提供前往{area:1584}和{area:1583}的{faction:76}声望任务，全部为58到60级，奖励全额发放：“押送囚徒”和“行动：杀死安格弗将军”（各150）、{quest:4724}和{item:12652}（各100）、{quest:4903}（150）、{npc:3144}的智慧（100），以及“为部落而战！”（雷德的头颅，向每座部落主城奖励200）。这些都是地下城任务：小队前往时就接上。",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077}：{quest:4903}，+150 点声望，五人小队。",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081}：{quest:4724}，+100 点声望，五人小队",

	-- Step 59: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832}刷到尊敬",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832}：每 20 个 {item:14047} 换取 50 点声望，可无限重复。友善到尊敬需要 6,000 点：交还 120 次，共 2,400 个 {item:14047}，再减去任务已奖励的部分（兽人初始为友善 1,000 点：需交还 100 次；亡灵或天裔初始为中立 2,000 点，需先交还 20 次、共 400 个 {item:14047}，才能达到友善）。把身上每 20 个依次交完。",

	-- Step 60: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832}刷到崇敬",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "从尊敬到崇敬需要12,000声望：交还240次，共4,800块 {item:14047}。根据拍卖行每组售价，决定自己刷还是购买。",

	-- Step 61: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832}刷到崇拜",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "从崇敬到崇拜需要 21,000 点：交还 420 次，共 8,400 个 {item:14047}。团队首领的头颅也能提供声望：“黑石之王”（奈法利安）向每座部落城市提供 200 点，“部落的胜利”（奥妮克希亚）向 {faction:76} 提供 400 点。崇拜后，{object:172958} 中的 {npc:3362} 会向所有部落种族出售座狼：40 级座狼 20 金币，60 级迅捷座狼 200 金币（无限的价格）；经典旧世中，其他种族需要崇拜才能购买。",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362}：狼",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。{area:363} 是其中效率最高的：25 分钟约提供 1,400 点 {faction:76} 和 1,400 点暗矛声望（按五分之一计算各约 280 点）。{npc:3143} 在巢穴那间大屋里等待；{npc:10176} 站在屋外。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{area:362} 和 {zone:1411} 北部：80分钟约得1,800点 {faction:76} 声望和1,650点暗矛声望（按五分之一则为360和330）。{npc:3142} 和 {npc:3139} 站在镇中央，{npc:3191} 在兵营旁，{npc:3147} 和 {npc:266940} 在镇子边缘。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{area:367} 和 {area:368}：25分钟约得700点 {faction:76} 声望和650点暗矛声望（按五分之一则为140和130）。{npc:3188} 和 {npc:3304} 站在小屋旁，{npc:3194} 靠近水边，{npc:7953} 在村庄南面。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:380}: about 1,500 {faction:76} reputation in 70 minutes (300 at a fifth), {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{area:380}：70分钟约得1,500点 {faction:76} 声望（按五分之一则为300），只给 {faction:76} 声望。{npc:3338}、{npc:3464}、{npc:3429}、{npc:3449} 和 {npc:267310} 站在镇内，{npc:3432} 在旅店旁。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {quest:5726}: 400 {faction:76} reputation in 20 minutes (80 at a fifth), with a run through {area:2437} that a level 60 clears alone."] = "经典版中，低于你6级或更多的任务奖励会减少（60级时为五分之一）；一则无限服测试反馈称仍按全额发放。第一次交还就能看出：如果只有五分之一，就跳过这些任务点。{quest:5726}：20分钟获得400点{faction:76}声望（五分之一则为80），需要通关{area:2437}，60级可单刷。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip this. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like (10 at a fifth)."] = "经典旧世中，低于你 6 级及以上的任务奖励会减少（60 级时只有五分之一）；有无限服测试报告称奖励仍全额发放。首次交任务即可确认：若只有五分之一，就跳过此步骤。{quest:819} 出现在 {zone:1413} 中北部若干位置之一的地面上，多数在十字路口周边的路旁；有人拾取后，它会换到另一处出现。{area:392} 的 {npc:3292} 会为酒桶及首次装酒奖励 250 点 {faction:76} 声望，此后每次装酒奖励 50 点，可无限重复（五分之一时为 10 点）。",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7832}，直到{faction:76}达到崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7832}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "这里的科卡尔半人马（30-33级）会掉落。也可以去拍卖行购买。",
	-- ["Level 56-60 quests and {item:14047} to Exalted, with the old {zone:1411} quests as a fast extra if they still pay in full."] = "通过56-60级任务和{item:14047}刷到崇拜；如果{zone:1411}的旧任务仍给全额声望，可以顺手快速做掉。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的风险投资公司执行者（16-17级）会掉落。也可以去拍卖行购买。",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726}在{faction:76}收取布料以提升{faction:76}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7832}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726}：已交付{item:14047}",
	-- ["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay a little less at 60 (in Classic 30 and 45); the last two pay in full."] = "{npc:4485}站在{object:172958}的{object:173084}外。前两个{quest:3504}任务为53级，60级时奖励略少（经典版为30和45）；最后两个按全额奖励。",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
}
