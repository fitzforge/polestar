-- Chinese (traditional) (zhTW): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Razor Hill
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:362} Razor Hill · {npc:3336} Takrin Pathseeker · {npc:3142} Orgnil Soulscar
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}. Before it turns west to the {area:814} bridge, step east into {area:362}: {npc:3336} stands on the west side of town, {npc:3142} in the middle."] = "",
	-- {npc:3336} Takrin Pathseeker · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post
	["{npc:3336}: {npc:3337} at {area:379}, on the way"] = "",

	-- Step 2: Orgnil Soulscar
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142} stands in the middle of {area:362}."] = "{npc:3142}站在{area:362}中央。",
	-- {npc:3142} Orgnil Soulscar · {quest:99051} Threat from Below · {zone:1411} Durotar
	["{npc:3142}: {quest:99051}, from {zone:1411}'s naga beach"] = "",

	-- Step 4: Uzzek
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth
	["{npc:5810} stands at {area:379} with {npc:3337} and {quest:809}."] = "{npc:5810}和{npc:3337}、{quest:809}一起站在{area:379}。",

	-- Step 5: Far Watch Post
	-- {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {npc:5810} Uzzek
	["Back west to the road and over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "",
	-- {quest:809} Ak'Zeloth · {npc:3337} Kargal Battlescar · {npc:3216} Neeru Fireblade · {zone:1454} Orgrimmar
	["{quest:809}, beside {npc:3337}: from {npc:3216} in {zone:1454}"] = "{quest:809}，在{npc:3337}旁邊：來自{zone:1454}的{npc:3216}",

	-- Step 6: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {npc:5810} stands at {area:379} just above it, on the road to the Crossroads."] = "從大門離開{zone:1454}，沿道路向南穿過{zone:1411}，再向西過{area:814}橋：{npc:5810}站在橋上方不遠的{area:379}，就在前往十字路口的路上。",

	-- Step 7: Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {area:814} Southfury River
	["{npc:5810} stands at {area:379}, just above the {area:814} bridge."] = "{npc:5810}站在{area:379}，就在{area:814}的橋上方。",

	-- Step 8: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "你從{area:379}抵達。{npc:3489}和{npc:3338}站在旅店旁，赫布瑞姆和{npc:3464}在北門旁；{npc:3615}、{npc:3429}和{npc:3449}在塔樓平臺上。",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "{npc:3390}：{quest:1358}，來自津格",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}，在塔樓上",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}：鷹身人之後在{area:383}",

	-- Step 9: Thork
	-- {npc:3429} Thork
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:3429}'s supply crates lie in the Razormane camp's north-east, among the Flesheaters and Berserkers (18-19, elite): it needs a group of 3. Skip it if you are alone."] = "這些是精英怪物：鼓勵組隊，找人一起做。{npc:3429}的補給箱在鋼鬃營地東北部，在食肉者和狂戰士（18-19，精英）中間：需要3人小隊。如果你是單人，就跳過。",
	-- {npc:3429} Thork
	["{npc:3429}, on the tower"] = "{npc:3429}，在塔上",

	-- Step 10: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878}在往東通往{area:392}的道路旁紮營。",

	-- Step 11: Razormane camp
	["Razormane camp"] = "鋼鬃營地",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "鋼鬃營地在十字路口東邊。戰士：{object:58369}就在營地裡。薩滿：野豬人掉落{item:5026}。\n注意：箱子在一輛破車旁，由兩名鋼鬃守衛看守，其中包括會把更多野豬人拉進戰鬥的獵手。",

	-- Step 12: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "鋼鬃營地：{npc:3429}的野豬人",
	-- {npc:3429} Thork
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, and, if you took his supplies with a group, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "你在營地裡時：{npc:3429}要的覓水者和織棘者在西半邊，獵手在中間；如果你和小隊接了他的補給任務，補給箱在東端。\n小心：鋼鬃食肉者和狂戰士（18-19）是精英；牠們站在營地東北部的補給箱旁：把野豬人一隻隻拉離牠們。",

	-- Step 13: Thork's supply crates
	-- {npc:3429} Thork
	["{npc:3429}'s supply crates"] = "{npc:3429}的補給箱",
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["With your group: the supply crates sit at the camp's eastern end. Careful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand beside the crates."] = "和你的小隊一起：補給箱在營地東端。小心：鋼鬃食肉者（{npc:267308}）和狂戰士（18-19）是精英；牠們站在箱子旁邊。",

	-- Step 15: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine again. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "向東過橋，再次沿小徑上到{npc:5900}的神殿。{npc:5900}用焦油和袋子製作{item:6636}。在他旁邊的火盆使用它以顯現{npc:5893}，擊殺它取得{item:6655}，然後把餘燼放進火盆。",

	-- Step 17: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "{area:380}是本指南的據點。你需要找的人都在旅店幾步之內：{npc:3338}在旅店旁，赫布瑞姆和{npc:3464}在北門旁，再上塔樓找馭風者管理員{npc:3615}、{npc:3429}和{npc:3449}，出門時{npc:3448}在南門。",
	-- {quest:860} Sergra Darkthorn · {quest:842} Crossroads Conscription · {area:379} Far Watch Post
	["{quest:860}: {quest:842}, from {area:379}"] = "",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}，在塔頂",

	-- Step 21: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "順路收集迅猛龍頭",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "陽鱗迅猛龍在十字路口以北和以東的平原上游蕩，大約每四隻就有三隻掉落頭顱：順路把遇到的都殺掉。注意：陽鱗尖嘯龍血量低於30%時會呼叫30碼內附近的同伴。",

	-- Step 22: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "順路收集陸行鳥的喙",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "平原陸行鳥遍佈{zone:1413}的平原，大約四隻中有一隻掉落喙：殺掉沿途遇到的。",

	-- Step 23: Razormane camp
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates (with a group only) sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "營地裡，覓水者和織棘者佔據西半邊，獵手在中間；補給箱（僅限組隊）在東端。\n這裡的平原陸行鳥也算在鳥喙裡。\n小心：鋼鬃食肉者和狂戰士（18-19）是精英；牠們站在營地東北部的補給箱旁：把野豬人一隻隻拉離牠們。",

	-- Step 25: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "收集完陸行鳥的喙",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "還不夠七個？十字路口以北、沿北邊道路的平原上平原陸行鳥最密集。",

	-- Step 28: Thork
	-- {npc:3438} Kreenig Snarlsnout
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:3438} and the Geomancers and Defenders of The Disruption Ends stand in the camp's eastern half, among the Flesheaters and Berserkers (18-19, elite): it needs a group of 3. Skip it if you are alone."] = "這些是精英怪物：鼓勵組隊，找人一起做。{npc:3438}以及動亂之末的地卜師和防禦者站在營地東半邊，在食肉者和狂戰士（18-19，精英）中間：需要3人小隊。如果你是單人，就跳過。",

	-- Step 29: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "快步斑馬在向東通往{area:392}的路旁吃草：出去時順路取走它們的蹄子。",

	-- Step 30: Ratchet
	-- {area:392} Ratchet · {npc:3391} Gazlowe · {npc:7161} Wrenix the Wretched · {npc:3442} Sputtervalve · {npc:16227} Bragok · {npc:3446} Mebok Mizzyrix · {quest:1492} Wharfmaster Dizzywig
	-- was: ["Follow the road south-east to {area:392} on the coast: {npc:3391} and {npc:7161} at the north end of town, {npc:3442} and {npc:16227}, {npc:3446} and the {object:3972} poster, then {quest:1492} on the dock on the way out south."] = "沿道路往東南前往海岸邊的{area:392}：鎮北端的{npc:3391}和{npc:7161}，接著是{npc:3442}和{npc:16227}、{npc:3446}和{object:3972}告示，往南離開時再找碼頭上的{quest:1492}。"
	["Follow the road south-east to {area:392} on the coast: {npc:3391} and {npc:7161} at the north end of town, {npc:3442} and {npc:16227}, {npc:3446} and the WANTED poster, then {quest:1492} on the dock on the way out south."] = "",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}，在樓上",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}：控制台之後在{area:382}",
	-- {npc:16227} Bragok · {npc:3442} Sputtervalve
	["{npc:16227}, beside {npc:3442}"] = "{npc:16227}，在{npc:3442}旁邊",
	-- {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- was: ["{npc:3446}, beside the {object:3972} poster: the Sunscale raptors come on the next {area:392} stop, at 18"] = "{npc:3446}，在{object:3972}告示旁：赤鱗迅猛龍留到18級下次到{area:392}時再做"
	["{npc:3446}, beside the WANTED poster: the Sunscale raptors come on the next {area:392} stop, at 18"] = "",
	-- {npc:3467} Baron Longshore · {area:392} Ratchet
	-- was: ["The {object:3972} poster: {npc:3467} comes on the next {area:392} stop too"] = "{object:3972}告示：{npc:3467}也留到下次到{area:392}時再做"
	["The WANTED poster: {npc:3467} comes on the next {area:392} stop too"] = "",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}，在碼頭上",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "{quest:1492}：翡翠稍後從{area:381}獲得",
	-- {npc:3446} Mebok Mizzyrix · {quest:865} Raptor Horns · {npc:3467} Baron Longshore · {area:392} Ratchet
	["Keep {npc:3446}'s {quest:865} and {npc:3467} for the next {area:392} stop, at 18: Scytheclaws you meet on the plains before then drop the horns too."] = "{npc:3446}的{quest:865}和{npc:3467}留到18級下次到{area:392}時再做：在那之前於平原上遇到的鐮爪龍也會掉落龍角。",

	-- Step 31: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "{zone:1413}：沿途遇到就擊殺",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them. {npc:3467} (16) stands at the camp's southern end: leave him for the next {area:392} stop."] = "海盜在{area:392}南邊的海灘上紮營：複雜零件堆散落在他們之間的沙地上。{npc:3467}（16）站在營地南端：留到下次到{area:392}時再處理。",

	-- Step 32: Ratchet
	-- {npc:3391} Gazlowe · {area:392} Ratchet
	["{npc:3391}: the crates lie at the south end of the beach camp, on the next {area:392} stop at 18"] = "{npc:3391}：箱子在海灘營地南端，留到18級下次到{area:392}時再做",

	-- Step 33: Fly to Crossroads
	["Fly to Crossroads"] = "飛往十字路口",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 35: Gur'ak
	-- {npc:267310} Gur'ak · {quest:97003} Chol'aruk the Ravener · {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:3438} Kreenig Snarlsnout
	["{npc:267310} stands on the north-east side of the Crossroads. {quest:97003} is a group quest: {npc:267307} is a level 20 elite boar in the Razormane's {area:1699} cave, east of the town, where the route goes back for {npc:3438} later."] = "{npc:267310}站在十字路口東北側。{quest:97003}是組隊任務：{npc:267307}是20級精英野豬，位於城鎮東邊鋼鬃野豬人的{area:1699}洞穴，路線稍後會回到那裡找{npc:3438}。",

	-- Step 36: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "向西前往{npc:3389}在科卡爾邊界的哨站。",

	-- Step 37: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane · {quest:4021} Counterattack! · {npc:9456} Warlord Krom'zar
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Kolkar Invaders = {npc:9524} Kolkar Invader
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools.\nCareful: the Kolkar stand in packs around their camp west of the pools, and the Stormers cast from range: pull them one at a time from the edge. When anyone starts {npc:3389}'s {quest:4021}, Kolkar Invaders (16-17) and {npc:9456} (20, elite) charge his watch post: keep away from it until the attack is over."] = "水池就在{npc:3389}以北。走進水裡探索它們；赫布瑞姆要的飽滿的蘑菇（{object:3640}）長在周圍。經過的每個科卡爾都殺掉，收集護腕。{npc:3394}站在水池以西的科卡爾營地裡。\n小心：科卡爾成群站在水池以西的營地周圍，風暴召喚者會遠程施法：從邊緣一次拉一隻。當有人開始{npc:3389}的{quest:4021}時，科卡爾入侵者（{npc:9524}，16-17）和{npc:9456}（20，精英）會衝向他的哨所：攻擊結束前離遠點。",

	-- Step 38: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} comes out when you kill the Kolkar at the {area:388}, later"] = "{npc:3389}：之後在{area:388}擊殺科卡爾時，{npc:3395}就會出現",

	-- Step 39: Dry Hills
	-- {area:383} Dry Hills · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. Any Witchwing harpy drops a talon: keep to the eastern slopes, where the Witchwing Harpies and Roguefeathers (14-15) nest; the Slayers and Windcallers (16-17) hold the western hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "往西前往{area:383}。任何巫翼鷹身人都會掉落爪子：待在東側山坡，巫翼鷹身人和巫翼惡羽（14-15）在那裡築巢；殺手和喚風者（16-17）占據西邊的丘陵。草原徘徊者在{npc:3389}和丘陵之間的平原遊蕩：順路收集牠們的爪子。\n小心：有2隻巫翼伏擊者（17-18級）。牠們脫離戰鬥時會用潛行保持隱形。",

	-- Step 40: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "{object:4141}在{area:382}西邊的風險投資公司研究站。關閉鑽機周圍的三個閥門，再次使用控制台，然後從旁邊的{npc:3471}身上取得{item:5089}。\n小心：有幾名守衛站在閥門的仇恨範圍內，約3分鐘內就會重生，血量低時會逃跑搬救兵；如果你在附近有怪時使用閥門，牠們也會加入。",
	["Inside"] = "在裡面",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "{area:392}的{npc:3442}：下次到{area:392}時",

	-- Step 41: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout · {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them. Careful: Razormane Flesheaters and Berserkers (18-19) are elites in the camp's north-east, near {npc:3438} and the supply crates, and {npc:267307} (20, elite) lies in the cave under {area:1699} beside them: pull {npc:3438} and the quilboar away from them one at a time, and leave the cave alone unless you are in a group."] = "回到鋼鬃營地。鋼鬃地卜師和鋼鬃防禦者占據營地東半部；{npc:3438}在牠們之間走動。小心：鋼鬃食肉者和狂戰士（18-19級）是精英，位於營地東北部、{npc:3438}和補給箱附近，旁邊{area:1699}下方的洞穴裡還有{npc:267307}（20級，精英）：把{npc:3438}和野豬人一隻一隻地從牠們身邊引開，除非有隊伍，否則別碰那個洞穴。",

	-- Step 42: Chol'aruk
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:267307} (level 20 elite) needs a group of 3 and sits deep in the cave under {area:1699}, past the Razormane Flesheaters and Berserkers (18-19, elite). Skip it if you are alone."] = "這些是精英怪物：建議組隊，找人一起打。{npc:267307}（20級精英）需要3人隊伍，位於{area:1699}下方的洞穴深處，要先經過鋼鬃食肉者和狂戰士（18-19級，精英）。如果你是獨自一人就跳過。",

	-- Step 43: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:383} Dry Hills · {quest:853} Apothecary Zamah · {zone:1456} Thunder Bluff
	["{npc:3338} by the inn first, then Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate last. His seed test waits for the {npc:3395} pass at the {area:388}: go straight on north-west to the {area:383}. After the spores Helbrim offers {quest:853}, a delivery to {zone:1456} within 45 minutes: this route doesn't go there, so leave it (Druids take it on the next Crossroads stop, right before their flight to {zone:1456})."] = "先找旅店旁的{npc:3338}，接著是北門旁的赫布瑞姆、塔樓平台上的{npc:3429}和{npc:3449}、旅店旁的{npc:3432}，最後是南門的{npc:3448}。他的種子測試要等到去{area:388}找{npc:3395}那一趟再做：現在直接往西北前往{area:383}。繳交孢子後，赫布瑞姆會提供{quest:853}，要在45分鐘內送到{zone:1456}：這條路線不去那裡，所以先不接（德魯伊會在下一次經過十字路口時接取，正好在飛往{zone:1456}之前）。",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "{npc:3432}：他的妻子稍後在刺背野豬人營地的北緣",
	-- {npc:3448} Tonga Runetotem · {area:388} Stagnant Oasis · {npc:3395} Verog the Dervish
	["{npc:3448}: the bubbling fissure at the {area:388}, on the {npc:3395} pass"] = "{npc:3448}：{area:388}冒泡的裂隙，在去找{npc:3395}的那一趟",

	-- Step 46: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "向西北前往{area:383}：巫翼殺戮者盤踞在它西端；戒指就在她們身上。\n注意：該區域有一些潛行的鷹身人伏擊者，靠近之前不會現身。還有一隻19級精英鷹身人在那裡巡邏。",

	-- Step 48: Vrang Wildgore
	-- {quest:881} Echeyakee · {npc:3682} Vrang Wildgore
	["East from the keg toward {quest:881}: {npc:3682} camps below the hills, and his errands lie in the plains beside his camp."] = "從酒桶向東朝{quest:881}方向：{npc:3682}在山丘下方紮營，他的差事就在營地旁的平原上。",

	-- Step 49: Savannah lions
	["Savannah lions"] = "薩凡納獅子",
	-- {npc:3682} Vrang Wildgore
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of {npc:3682}'s camp, and the Sprung Traps lie among them."] = "草原獅族王在{npc:3682}營地東邊的平原上游蕩，發動過的陷阱就在它們中間。",

	-- Step 50: Vrang Wildgore
	-- {npc:261366} Walton · {npc:3682} Vrang Wildgore · {area:383} Dry Hills · {npc:3452} Serena Bloodfeather
	["{npc:261366}, the hermit on the ridge behind {npc:3682}: on the next {area:383} visit, with {npc:3452}"] = "{npc:261366}，{npc:3682}身後山脊上的隱士：下次去{area:383}時，和{npc:3452}一起",

	-- Step 51: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "回十字路口途中向東南：{quest:881}是一頭白獅，在鋼鬃營地北邊的平原上游蕩。\n注意：薩凡納女獵手在巢穴周圍遊蕩。它們重新出現很快，經常和{quest:881}一起加入戰鬥，所以吹響號角之前先把它們清掉。\n這裡的陽鱗迅猛龍也算在頭的數量裡。",

	-- Step 52: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "收集完迅猛龍頭",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Still short of twelve? Sunscale Screechers are thickest on the open plains just north of {quest:881}'s lair: finish there, then head back south-west to the Crossroads, keeping west of the Razormane camp."] = "還差十二個？日鱗尖嘯者（{npc:3255}）在{quest:881}巢穴以北的開闊平原上最多：在那裡補齊，然後向西南回到十字路口，保持在鋼鬃營地以西。",

	-- Step 53: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "從北門進來：先找{npc:3464}，再找旅店旁的{npc:3338}，然後上到飛行管理員所在的塔樓平台，找{npc:3449}和{npc:3429}。",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "{npc:3464}：{quest:3281}在{area:385}西北的迅猛龍巢裡",
	-- {npc:3390} Apothecary Helbrim · {zone:1456} Thunder Bluff
	["{npc:3390}: 45 minutes, for Zamah on the {zone:1456} step next"] = "{npc:3390}：限時45分鐘，交給接下來{zone:1456}步驟中的札瑪",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "{npc:3338}：十字路口以南的迅猛龍巢穴",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "{npc:3449}，在塔樓上：{quest:876}統領{area:383}的鷹身人",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}，在塔樓上，17級起。留著它：交給{area:1703}的卡德拉克，見下一份指南",

	-- Step 54: Thunder Bluff
	-- {area:1638} Thunder Bluff · {quest:853} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}. {quest:853} waits in the {area:2197}, the cave under {area:1640}: hand in the spores there first, while their time runs. Then {npc:3033} trains you on {area:1639}."] = "從十字路口飛往{area:1638}。{quest:853}在{area:1640}下方的洞穴{area:2197}裡：趁時限還沒到，先去那裡繳交孢子。接著{npc:3033}在{area:1639}為你訓練。",
	-- {quest:853} Apothecary Zamah · {area:2197} Pools of Vision
	["{quest:853}, in the {area:2197}"] = "{quest:853}，在{area:2197}",

	-- Step 55: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "施放{spell:18960}",

	-- Step 56: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "{npc:11802}在{area:2361}他那棟建築的樓上：從室內上樓，箭頭無法區分樓層。神殿靈珠躺在{area:656}的湖底，幾分鐘內就會消失：拿到一個後直接游到西北岸的{area:2362}，在那裡使用它並與{npc:11799}交談。{quest:28}有時間限制：在{npc:11799}收下之前，不要傳送或使用爐石。",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}：{area:384}，下一份指南",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，從湖中的{object:177785}取得",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "在{area:2362}",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}，在{area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "{quest:30}，隨身帶著：本指南在{area:382}拿到一半墜飾，另一半在21級去{area:287}途中、銀松森林外海的水下；墜飾在{area:287}之後才交",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}的{npc:11798}會載德魯伊飛到那裡",

	-- Step 57: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "從{zone:1456}直接飛往{area:392}。",

	-- Step 58: Fly to Ratchet
	["Crossroads flight master"] = "十字路口飛行管理員",

	-- Step 59: Ratchet
	["WANTED poster"] = "",

	-- Step 60: Mebok Mizzyrix
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {quest:1491} Smart Drinks
	["For your {area:718} run: {npc:3446}'s next errand, {quest:1491}."] = "為了你的{area:718}之行：{npc:3446}的下一個差事，{quest:1491}。",

	-- Step 62: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "{npc:3442}：先留著，{quest:1483}在石爪山的{area:1076}，本指南結尾會用到",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "{npc:3442}：{npc:9316}站在十字路口以北的路上，就在前往{area:382}的路上",

	-- Step 63: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone."] = "這些是精英怪：建議組隊，找人一起打。{npc:209797}（20級精英）需要2人小隊。單人就跳過。",

	-- Step 64: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:3391}在他建築的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 65: Raptor nests
	["Raptor nests"] = "迅猛龍巢",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds · {item:5165} Sunscale Feather
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them. Each nest needs a {item:5165}: kill Sunscale raptors (most drop one) until you have three, then use a feather at each nest."] = "從{area:392}往西南穿過平原前往{area:1697}：三個巢一起位於綠洲西南方，由赤鱗鐮爪龍守護。每個巢都需要一根{item:5165}：擊殺赤鱗迅猛龍（大多會掉落一根）直到你有三根，然後在每個巢使用一根羽毛。",

	-- Step 66: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "{area:1697}：遇到就殺",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {npc:3682} Vrang Wildgore · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them back in {area:392}; any still missing come with {npc:3682}'s hills later.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "赤鱗鐮爪龍在{area:1697}周圍的平原獵食；牠們會掉落龍角。回{area:392}交給{npc:3446}；還缺的之後在{npc:3682}的丘陵補齊。\n往東南朝海岸走：被偷的銀子在{area:385}西北方的迅猛龍巢裡。",

	-- Step 67: Stolen Booty
	-- {npc:3467} Baron Longshore
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, and {npc:3467} (16) stands beside them."] = "向東到海灘，在海盜營地南端：裝靴子的箱子和裝鏡片的易碎箱子就在那裡，{npc:3467}（16）站在旁邊。",

	-- Step 68: Ratchet
	-- {area:392} Ratchet
	["Back north along the beach to {area:392}."] = "沿海灘往北走回{area:392}。",
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446}, beside the WANTED poster"] = "",

	-- Step 73: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "從十字路口向北到{area:384}，在{object:19464}處把{item:15842}裝滿，然後回到十字路口的{npc:3448}那裡。沒有{skill:182}？他旁邊的{npc:3490}賣{item:2449}，一次三個，直到他補貨。",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "向{npc:3490}購買{item:2449}；草藥學家可在平原上採集",

	-- Step 74: Kolkar camp
	["Kolkar camp"] = "科卡爾半人馬營地",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "落單的草原科多獸在{npc:3389}西北的科卡爾營地周圍平原上游蕩；草藥師也可以在那裡採集{item:2449}。",

	-- Step 75: The Barrens: kill these as you meet them
	-- {area:383} Dry Hills · {quest:876} Serena Bloodfeather
	["North to the {area:383}: {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "向北前往{area:383}：{quest:876}帶領西邊山丘中的巫翼鷹身人。\n注意：進入的路會經過隱身的巫翼伏擊者和一隻巡邏的精英鷹身人。",
	-- {quest:865} Raptor Horns · {npc:3682} Vrang Wildgore
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions below {npc:3682}'s camp"] = "如果 {quest:865} 還沒完成：赤鱗鐮爪龍就在{npc:3682}營地下方的獅群之間遊蕩",

	-- Step 76: Walton
	-- {npc:261366} Walton · {npc:3682} Vrang Wildgore
	["{npc:261366}, the hermit, stands on the ridge behind {npc:3682}'s camp."] = "{npc:261366}，那個隱士，站在{npc:3682}營地後方的山脊上。",

	-- Step 77: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "{npc:262119}和他的水兵守著{npc:261366}南邊被毀的商隊。這些水兵會互相聯動，拉到一個會引來其餘敵人。從邊緣引怪後拉開距離，它們脫戰距離較短，可以逐個清理營地，再對付下士。",

	-- Step 78: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "協助{npc:261366}：{npc:261367}和{area:21}水兵爬上山脊時，待在他身邊",

	-- Step 79: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "從{npc:261366}向東朝{area:382}走：{npc:9316}站在十字路口北邊道路上的營地。",

	-- Step 80: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "{npc:3439}站在{area:382}的風險投資公司營地內；{npc:3445}帶著鑰匙。",

	-- Step 81: Strange Lockbox
	-- {object:177794} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177794} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177794}在{area:382}北緣，風險投資公司的塔旁。裡面有{quest:30}所需的{item:15883}。",

	-- Step 82: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "維茲克蘭克開著他的伐木機衝出營地：跟著他，殺掉任何攻擊他的東西。{npc:3442}在{area:392}接收。\n注意：路線向西，爬上一段斜坡。一到頂上，兩個風險投資公司的人會伏擊你。",

	-- Step 83: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "裝著蛞蝓的工具籃在{area:382}的風險投資公司鑽探場周圍。",

	-- Step 84: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "地區東北角礦坑的風險投資公司監工和風險投資公司執行者會掉落{item:5097}。",

	-- Step 85: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "從礦洞向西到{npc:9316}的營地，再沿路向南到十字路口。",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "留著它：{quest:3923}在{zone:1454}的{object:172958}，20級去{zone:1454}的行程裡會用到",

	-- Step 86: the Crossroads
	["the Crossroads"] = "十字路口",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "沿路向南到十字路口：{npc:3449}站在塔樓平臺上，{npc:3448}在南門。",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "他會給你{item:15826}",

	-- Step 87: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {npc:3448} Tonga Runetotem
	["{npc:3395} doesn't wander on his own: he comes out when you kill the Kolkar centaurs at the {area:388}, south-east of the Crossroads. Keep killing them around the oasis until he appears. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395}不會自己出現：在十字路口東南方的{area:388}擊殺科卡爾半人馬時他才會現身。在綠洲周圍持續擊殺直到他出現。趁在那裡，到綠洲東岸冒泡的裂縫測試{npc:3448}的種子。",
	["Underwater"] = "在水下",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "{npc:12296}：對它們使用{item:15826}；它們在十字路口周圍的平原上游蕩",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "治療{npc:12296}",

	-- Step 88: Bristleback camps
	["Bristleback camps"] = "刺背營地",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo (level 22), sometimes wanders here: his hoof starts a quest. Leave him alone below level 21."] = "刺背野豬人營地散布在{area:378}北方的平原上，{area:458}兩側都有。{npc:3432}的妻子躺在營地北緣，就在你往南的路上。野豬人先別打：{area:378}的{npc:3430}要你清理同樣的營地。{quest:883}是一隻灰色科多獸（22級），有時會在這裡遊蕩：牠的蹄子會開啟任務。21級以下別惹牠。",

	-- Step 89: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "沿{area:458}向南前往{area:378}。",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}，在籠子裡",

	-- Step 90: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "向北回到刺背野豬人營地。任何刺背野豬人都可能為{npc:3432}掉落獠牙，所以你在為{npc:3430}殺它們時順手收集。留一個{item:5075}。",

	-- Step 93: Level 20
	["Level 20"] = "20級",
	-- {zone:1454} Orgrimmar · {area:1700} Agama'gor · {area:718} Wailing Caverns
	-- plural, as words: Bristleback Geomancers = {npc:3263} Bristleback Geomancer
	["{zone:1454}'s level 20 class quests come right after the Crossroads, and they are offered only from 20. Still short of 20? The Bristleback Geomancers (19-20) hold {area:1700} around you: kill them until level 20. Or, with a group, run the {area:718} dungeon instead."] = "{zone:1454}的20級職業任務緊接在十字路口之後，而且20級才會提供。還不到20級？周圍{area:1700}有刺背地卜師（19-20）：殺到20級。或者有小隊的話，改去打{area:718}地城。",
	-- plural, as words: Bristleback Geomancers = {npc:3263} Bristleback Geomancer
	["Bristleback Geomancers"] = "刺背地卜師",
	-- {npc:3263} Bristleback Geomancer
	["grind on {npc:3263}"] = "刷{npc:3263}",

	-- Step 94: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "沿{area:458}向北前往十字路口：{npc:3448}在南門，{npc:3432}在旅店旁，{npc:3428}在北門西邊。先留著{item:5075}：下次到{area:378}時交給{npc:3430}。",
	-- {npc:3448} Tonga Runetotem · {area:387} Lushwater Oasis · {npc:3396} Hezrul Bloodmark · {zone:1454} Orgrimmar
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3448}: the Oasis Snapjaws at {area:387}, with {npc:3396} after the {zone:1454} trip"] = "{npc:3448}：{area:387}的綠洲鉗嘴龜，去過{zone:1454}之後和{npc:3396}一起做",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "繳交{quest:4921}後，{npc:3432}會提供{quest:95774}",
	-- {npc:3428} Korran · {quest:868} Egg Hunt · {zone:1413} The Barrens
	["{npc:3428}'s {quest:868} waits for this guide's last Crossroads stop: its eggs come on the next {zone:1413} guide's walk south, at about 25."] = "{npc:3428}的{quest:868}留到本指南最後一次到十字路口時再處理：蠍卵在下一份{zone:1413}指南往南走的路上，約25級時收集。",

	-- Step 95: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "現在去{area:1637}訓練20級技能：從十字路口塔樓上的{npc:3615}處起飛。",

	-- Step 96: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "{npc:3354}在{object:172958}裡，{npc:5892}在{object:172957}裡。",

	-- Step 97: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "{quest:3923}就在{object:172958}的水邊，暗巷區以東。",

	-- Step 98: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "{quest:2458}：{npc:7233}在{area:382}旁，下一份指南往北走時會經過",

	-- Step 99: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454}的職業任務",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",

	-- Step 100: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960}是{object:172982}下方的峽谷。",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}，就在幾步之外",

	-- Step 101: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}：兩份指南後{zone:1458}的{npc:4606}",

	-- Step 103: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["Train your level 20 ranks: {npc:246344} teaches Paladins in {area:1638}; {zone:1454} has no Paladin trainer. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "學習20級技能：{npc:246344}在{area:1638}訓練聖騎士；{zone:1454}沒有聖騎士訓練師。你尚未解鎖那裡的飛行路線：先飛到{area:378}，向西穿過{zone:1412}並乘升降梯上去，再向中央高地的{npc:2995}解鎖飛行路線。",

	-- Step 105: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:499} Cat Form · {spell:526} Cure Poison · {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:392} Ratchet
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}. {spell:499} and {spell:526} follow in {zone:1450} on the same trip, then {npc:11798} flies you back here and on to {area:392}."] = "從十字路口飛往{area:1638}，學習20級技能：{npc:3033}在{area:1639}。{spell:499}和{spell:526}隨後在同一趟行程中於{zone:1450}學習，然後{npc:11798}會載你飛回這裡，再飛往{area:392}。",

	-- Step 106: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}。{npc:11802}在{area:2361}他那棟建築的樓上：從室內上樓，箭頭無法區分樓層。",

	-- Step 108: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802}站在{area:2361}他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 109: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}：{npc:3033}的歡迎",

	-- Step 110: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	-- plural, as words: Territorial Terrans = {npc:230558} Territorial Terran
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. Careful: the spirits are Territorial Terrans (level 60) that kill whoever they see: stay off their paths, and click the statue again before the stealth runs out."] = "牛頭人：{npc:11957}在橋上方的南邊山丘等著。天裔精靈：{npc:272054}站在雙橋南邊。然後前往湖東邊的獸穴：解除變形，點擊入口的雕像獲得五分鐘的潛行，避開裡面的靈魂，每種聖物各拿一個；{item:280680}在白貓雕像的腳下。小心：這些靈魂是Territorial Terran（60級），看到誰就殺誰：避開牠們的路線，並在潛行結束前再次點擊雕像。",

	-- Step 113: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "從{zone:1456}繼續飛往{area:392}。",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 114: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "從{object:172982}塔樓上的多拉斯處繼續飛往{area:392}。",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 116: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "{area:385}：遇到就殺",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["South along the beach past the pirate camp to {area:385}, on the coast. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "沿海灘往南經過海盜營地，前往海岸邊的{area:385}。塞拉摩水兵和塞拉摩保衛者（15-16級）會掉落勳章；{npc:3393}（20級）和兩名砲手（19級）在要塞內和城牆上。\n小心：每個指定目標都連結著一名治療者和守衛，法莫斯身邊還多了三名水兵。先殺治療者會讓戰鬥輕鬆許多。",
	["On the top floor"] = "頂層",
	["Upstairs"] = "樓上",

	-- Step 117: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465}被鎖在要塞內。和他交談開始護送並緊跟著他：出去的路上塞拉摩士兵會攻擊。他會和你一起走回{area:392}。",

	-- Step 120: Ratchet: Wailing Caverns quests
	-- {area:392} Ratchet · {area:718} Wailing Caverns
	["{area:392}: {area:718} quests"] = "{area:392}：{area:718}任務",
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {npc:3665} Crane Operator Bigglefuzz · {npc:3396} Hezrul Bloodmark
	-- was: ["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "你的{area:718}任務，如果還沒接的話：{npc:3446}在{object:3972}告示旁，{npc:3665}在飛行管理員旁的碼頭上。這趟地城之行在本指南稍後，在{npc:3396}之後。"
	["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the WANTED poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "",

	-- Step 121: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901}在{area:392}南邊的山丘上等著，就在你往北的路上。",

	-- Step 122: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "{quest:882}是一頭巨大的陽鱗迅猛龍，只有新鮮屍體才能引來：從斑馬身上拾取{item:10338}，然後在{area:392}西北、通往十字路口的道路以北的{object:147538}使用它，等他來時做好準備。",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}，來自任何斑馬；斑馬衝鋒者在大樹周圍吃草",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "在{object:147538}：召喚{quest:882}",

	-- Step 123: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "{npc:3464}，在十字路口北門旁",

	-- Step 126: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197}住在{area:2539}，那是從{npc:3389}往西的道路盡頭、剛進入石爪山脈的食人妖村落。",

	-- Step 127: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "前往{npc:3389}",

	-- Step 129: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {npc:3448} Tonga Runetotem
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop. Oasis Snapjaws crawl in the oasis' water there: their shells are for {npc:3448}."] = "{npc:3396}帶領科卡爾盤踞在{npc:3389}南邊的{area:387}西岸。他沿著岸邊走動，北端約46,36，南端約46,42：若箭頭處沒看到他，就沿岸找到他為止。最後一次到十字路口時，把他的頭交給{npc:3389}。綠洲鉗嘴龜在那裡的綠洲水中爬行：牠們的殼是給{npc:3448}的。",

	-- Step 130: Nalpak and Ebru
	-- {npc:5767} Nalpak · {npc:5768} Ebru
	["{npc:5767} and {npc:5768}"] = "{npc:5767}和{npc:5768}",
	-- {area:718} Wailing Caverns · {npc:5767} Nalpak · {npc:5768} Ebru
	["For your {area:718} run: {npc:5767} and {npc:5768} stand in a hidden cave in the rocks above the entrance, at the north end of the oasis' west shore: climb up from the west side. Follow the arrow up."] = "為了你的{area:718}之行：{npc:5767}和{npc:5768}站在入口上方岩石中的一個隱藏洞穴裡，位於綠洲西岸的北端：從西側爬上去。跟著箭頭往上走。",

	-- Step 131: Wailing Caverns
	-- {area:718} Wailing Caverns · {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:5767} Nalpak · {npc:3655} Mad Magglish · {item:5334} 99-Year-Old Port · {npc:5768} Ebru · {item:6464} Wailing Essence · {npc:3678} Disciple of Naralex · {npc:3654} Mutanus the Devourer · {item:10441} Glowing Shard · {area:392} Ratchet · {npc:8418} Falla Sagewind
	["{area:718} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its mouth is just north of {npc:3396}'s shore, at the north end of {area:387}, under {npc:5767}'s cave.\nIn the caves before the portal: {npc:3655}, stealthed, with the {item:5334} (he moves between a few spots and comes back slowly: leave him if he's gone). Inside: the Deviates for {npc:5768}, and their hides for {npc:5767} (they drop rarely: one run may not be enough, so leave the rest for another run), {item:6464} from the Ectoplasms. After the four Fanglords, the {npc:3678} at the entrance leads you to Naralex: {npc:3654} drops the {item:10441}: its quest (someone in {area:392}, then {npc:8418} above the caverns) is not on this route; the Dungeons page's hand-in guide takes it."] = "{area:718}是五人地城，約17到24級，完整打一次約需一小時。洞口就在{npc:3396}所在岸邊的北邊，{area:387}北端，{npc:5767}的洞穴下方。\n傳送門前的洞穴裡：潛行中的{npc:3655}帶著{item:5334}（他會在幾個地點之間移動，回來得很慢：如果他不在就別管了）。裡面：給{npc:5768}的變異生物，以及給{npc:5767}的牠們的皮（掉率很低：打一次可能不夠，剩下的留給下一次），{item:6464}則來自軟泥怪。擊敗四位尖牙領主後，入口處的{npc:3678}會帶你去找納拉雷克斯：{npc:3654}會掉落{item:10441}，它的任務（先找{area:392}的某人，再找洞穴上方的{npc:8418}）不在本路線中；由地城頁面的繳交指南處理。",
	-- {item:6464} Wailing Essence
	["{item:6464}: the Ectoplasms"] = "{item:6464}：軟泥怪",

	-- Step 132: Nalpak
	["Back out of the caverns and up to the cave above the entrance."] = "從洞穴出來，往上走到入口上方的洞穴。",

	-- Step 134: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "沿{area:458}返回{area:378}的路上：營地北邊道路兩側刺背野豬人營地中的鋼鬃掠奪者攜帶{item:277277}。最後一次在十字路口停留時交給{npc:3432}。",

	-- Step 135: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "再次沿{area:458}往南前往{area:378}。",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "先留著：下一份指南中{zone:1440}的{npc:12696}",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "{npc:6394}，在裡面",

	-- Step 137: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "步兵多格蘭被鎖在道路西邊的野豬人營地裡。",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "留著它：{npc:5875}在{zone:1454}，下一份指南在{zone:1454}停留時會用到",

	-- Step 138: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard (level 24), roams among them: his Tailspike starts a quest. Leave him alone below level 23."] = "雷首蜥蜴在{area:378}南邊不遠的平原吃草。藍色雷霆蜥蜴{quest:884}（24級）在牠們之間遊蕩：牠的尾刺會開啟任務。23級以下別惹牠。",

	-- Step 139: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The antennae come first, at the Silithid Mounds south of the camp, then straight back to {npc:6394}; the thunderhawks after."] = "戰士：現在就向{npc:6394}接取{quest:1824}：從接取起計時30分鐘。先在營地南邊的異種蠍土丘收集觸角，然後直接回到{npc:6394}那裡；雷鷹之後再處理。",

	-- Step 140: Twitching Antennae
	["Twitching Antennae"] = "抽動的觸鬚",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg · {npc:3253} Silithid Harvester
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Mounds = {object:3685} Silithid Mound · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the Silithid Mounds in the {area:390}, south of {area:378}, until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "觸角掉落十五分鐘後就會消失：在{area:378}南邊{area:390}的異種蠍土丘擊殺異種群居蠍和異種爬行者，直到湊滿五個，然後先別管雷鷹，直接帶去{area:378}交給{npc:6394}。小心：異種群居蠍（21-22級）在戰鬥中和戰鬥外都會施放{npc:4196}，引來好幾隻小怪；異種爬行者（20-21級）在戰鬥中會不時施放{npc:5781}，生出額外的小怪。一隻{npc:3253}（24級，稀有）也在土丘間遊蕩：別理牠。",
	["Twitching Antennae from the silithid"] = "從異種蠍身上取得顫抖的觸角",

	-- Step 141: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} before the antennae fade: {npc:6394} is inside."] = "在觸角消失前向北回到{area:378}：{npc:6394}在裡面。",

	-- Step 142: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "雷鷹破雲者在營地南邊的平原上空盤旋。",

	-- Step 143: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "{npc:5899}的小屋在{area:378}南邊野豬人水坑上方的山脊上：在它下方的水坑裝滿{item:7766}。",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "在野豬人的水源裝滿{item:7766}",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "留著它：{object:107045}就在{area:272}旁，{area:287}指南裡會用到",

	-- Step 144: Camp Taurajo
	-- {area:378} Camp Taurajo
	["Back north into {area:378} on the way to the Crossroads: Jorn takes the thunderhawk wings."] = "向北回到{area:378}，在前往十字路口的路上：喬恩收取雷鷹翅膀。",

	-- Step 145: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate."] = "沿{area:458}往北到十字路口：{npc:3448}在南門，{npc:3432}在旅店旁，{npc:3428}在北門西邊。",
	-- {npc:3428} Korran · {quest:868} Egg Hunt · {zone:1413} The Barrens · {area:378} Camp Taurajo
	["{npc:3428}, west of the north gate: keep {quest:868}, its eggs lie on the next {zone:1413} guide's walk south from {area:378}, at about 25"] = "{npc:3428}，在北門西邊：保留{quest:868}，蠍卵在下一份{zone:1413}指南從{area:378}往南走的路上，約25級",

	-- Step 146: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "{npc:5878}在十字路口東邊的路旁紮營。",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "他接著提供{quest:1838}（1838，30級）：需要{area:1717}，並會讓你跑遍卡林多和東部王國。戰士職業指南{quest:1838}涵蓋此任務。",

	-- Step 148: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "再次與{npc:3389}交談開始進攻：科卡爾半人馬會一波波衝擊他西邊的碉堡。和步兵並肩作戰，直到{npc:9456}（20級精英）帶著兩個護衛出現，通常從南邊來，然後點選他屍體上方的旗幟。",

	-- Step 149: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "{npc:4049}的營地",

	-- Step 150: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "{npc:4049}和{npc:11857}同在通往石爪山的西路營地。",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "{npc:4049}：{area:461}的風險投資公司伐木工",

	-- Step 151: Grimtotem camp
	["Grimtotem camp"] = "恐怖圖騰營地",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "恐怖圖騰營地就在{npc:11857}北邊，離大路不遠：恐怖圖騰惡棍和僱傭兵站在帳篷之間。",

	-- Step 152: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "往下走回到{npc:11857}那裡。",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "{npc:11858}在{area:1076}北端等候",

	-- Step 153: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "前往{area:2539}",

	-- Step 154: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "從{npc:4049}沿路向西進入石爪山。食人妖村莊{area:2539}就在峽谷入口處。",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "{npc:12816}：{area:1076}沿途的蜘蛛",

	-- Step 155: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "{area:1076}：遇到就殺",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "從{area:2539}沿路向北：{npc:11858}和他的恐怖圖騰暴徒守著彎道，深苔爬行者和深苔噴毒者一路潛伏在小徑兩側的蛛網裡。",

	-- Step 156: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "道路以{area:1076}向北爬升。{quest:1483}的小屋在道路向東分岔通往{area:461}的地方。",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "{quest:1483}，在裡面",

	-- Step 157: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "在齊茲以東，風險投資公司正在砍伐{area:461}；其中一個操作員帶著圖紙。",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "風險投資公司伐木工，遍佈砍伐區",

	-- Step 158: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "在這個等級，{npc:4276}的防守很難獨自完成：建議組隊，找幾個人一起做。只有你一個人就跳過。\n{npc:4276}在峭壁東側{area:2160}底部挖礦，要穿過他的狗頭人（19-23級）。和他對話，然後在他挖礦的五分鐘裡保住他的命：十幾隻狗頭人會分波衝上來，先是近戰，然後是施法者，礦洞裡的狗頭人也會重生並加入戰鬥。他死了，任務就失敗。",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "{npc:4276}，在地下",

	-- Step 159: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}，在裡面",

	-- Step 160: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks · {npc:3442} Sputtervalve · {area:392} Ratchet · {zone:1413} The Barrens
	["{npc:4201}: for {npc:3442}, beside {area:392}'s flight master at the end of the {zone:1413} & Stonetalon guide"] = "{npc:4201}：交給{npc:3442}，他在{area:392}的飛行管理員旁，於{zone:1413}與石爪山脈指南的最後",

	-- Step 161: Kaya Flathoof
	-- {area:1076} Webwinder Path · {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud · {area:2538} Camp Aparaje
	["On the way back down the {area:1076}, {npc:11856} is held in {npc:11858}'s hut at the bend in the road. Once you take her quest she walks straight off south-east to {area:2538}, the burned village, without waiting: stay close, or the quest fails.\nCareful: Three Grimtotems ambush her at the burned village and go for her, not you: pull them off her and kill their caster quickly."] = "沿{area:1076}往回下山時，{npc:11856}被關在道路轉彎處{npc:11858}的小屋裡。接下她的任務後，她會直接往東南走向被燒毀的村莊{area:2538}，不會等你：緊跟著她，否則任務會失敗。\n小心：三個恐怖圖騰成員會在被燒毀的村莊伏擊她，並且攻擊她而不是你：把他們從她身上拉開，並迅速擊殺他們的施法者。",
	-- {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud
	["{npc:11856}, inside {npc:11858}'s hut"] = "{npc:11856}，在{npc:11858}的小屋裡",

	-- Step 162: Malaka'jin
	-- {area:2539} Malaka'jin · {npc:12816} Xen'Zilla
	["West from the burned village to {area:2539}: {npc:12816} stands just outside it, before the village."] = "從被燒毀的村莊往西前往{area:2539}：{npc:12816}就站在村外，在進村之前。",

	-- Step 164: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "沿路向東前往{npc:4049}和{npc:11857}的營地，就在走出石爪山返回的路上。",
	-- {npc:4049} Seereth Stonebreak · {quest:1063} The Elder Crone · {zone:1456} Thunder Bluff
	["{npc:4049}: {quest:1063}, Magatha in {zone:1456}, on the next guide's way back from Zoram'gar"] = "{npc:4049}：{quest:1063}，在{zone:1456}找瑪加薩，於下一份指南從佐拉姆加回來的路上",
	-- {npc:11857} Makaba Flathoof · {npc:11864} Tammra Windfield · {area:460} Sun Rock Retreat · {zone:1413} The Barrens
	["{npc:11857}: keep it, {npc:11864} at {area:460} in the {zone:1413} & Stonetalon guide"] = "{npc:11857}：先留著，{zone:1413}與石爪山脈指南中{area:460}的{npc:11864}",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "下一份指南向東北穿過{zone:1413}，前往{area:1703}和{zone:1440}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "回到鋼鬃營地。鋼鬃地卜師和鋼鬃防禦者佔據營地東半部；{npc:3438}在他們之間走動。",
	-- ["Back west along the road."] = "沿道路往西回去。",
	-- ["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "火刃祭司佔據{area:14}北部的{area:1898}；他們會掉落{item:6652}。{item:5026}在你下次去鋼鬃營地時從鋼鬃野豬人身上取得。",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "火刃祭司佔據{zone:1411}北部的{area:1898}；他們會掉落{item:6652}。{item:5026}在你下次去鋼鬃營地時從鋼鬃野豬人身上取得。",
	-- ["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "向東到海灘，在海盜營地南端：裝靴子的箱子和裝鏡片的易碎箱子就在那裡，從{area:385}往北走一小段就到。",
	-- ["East to {area:392}, on the coast."] = "向東前往海岸的{area:392}。",
	-- ["Follow the road east to the outpost above the {area:814}."] = "沿道路向東前往{area:814}上方的哨站。",
	-- ["Follow the road south-east to {area:392} on the coast."] = "沿道路向東南前往海岸的{area:392}。",
	-- ["Follow the road south-east to {area:392} on the coast: {npc:3391} and {npc:7161} at the north end of town, {npc:3442} and {npc:16227}, {npc:3446} and the {object:3972} poster, then {quest:1492} on the dock on the way out south."] = "沿道路往東南前往海岸邊的{area:392}：鎮北端的{npc:3391}和{npc:7161}，接著是{npc:3442}和{npc:16227}、{npc:3446}和{object:3972}告示，往南離開時再找碼頭上的{quest:1492}。",
	-- ["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "營地裡，鋼鬃尋水者和鋼鬃織棘者占據西半部，鋼鬃獵手在中間；補給箱在營地東端。\n這裡的陸行鳥也算在鳥喙的數量裡。\n小心：{npc:267308}和狂戰士（18-19級）是精英；牠們站在營地東北部的補給箱旁：把野豬人一隻一隻地從牠們身邊引開。",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "先留著：{quest:3923}站在{zone:1454}外；之後的指南會繳交",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "科卡爾牧民和科卡爾召雷師佔據{npc:3389}南邊的營地。",
	-- ["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "從正門離開{zone:1454}，沿路向南穿過{zone:1411}，再向西過{area:814}上的橋：{area:379}就在橋北側的{zone:1413}一邊。{npc:3337}、{quest:809}和{npc:5810}站在一起。",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "向北前往{area:383}。{npc:3682}在丘陵下紮營；他身後山脊上的隱士{npc:261366}，要等{npc:3682}派你上去後才會有工作給你。",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "綠洲鉗嘴龜在{area:380}西南方的{area:387}周圍，以及{area:388}周圍爬行。",
	-- ["Over the {area:814} bridge below {area:379} and south along the {zone:1411} bank to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "經過{area:379}下方的{area:814}橋，沿{zone:1411}岸邊往南走，直到一條窄路爬上山：{npc:5900}看守山頂的神殿。上山時小心邊緣，並沿同一條路下山。",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "平原陸行鳥和赤鱗迅猛龍在{area:380}周圍的平原遊蕩，北邊最密集。",
	-- ["Plainstriders and raptors"] = "平原陸行鳥與迅猛龍",
	-- ["Raptor nests"] = "迅猛龍巢",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank; {npc:3448} takes the result on the next Crossroads stop, so carry on north-west to the {area:383} from here."] = "在十字路口東南方。在綠洲東岸冒泡的裂縫測試種子；{npc:3448}會在下次回到十字路口時收下結果，所以從這裡繼續往西北前往{area:383}。",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "在{area:380}東南方。在綠洲東岸冒泡的裂縫測試種子。",
	-- ["Southsea beach"] = "南海海灘",
	-- ["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "還差十二個？陽鱗鞭尾龍和尖嘯者在十字路口東北的平原遊蕩，就在從{quest:881}巢穴往南回來的路上。",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "草原徘徊者在城鎮與東邊鋼鬃營地之間的平原狩獵。營地中，鋼鬃尋水者和鋼鬃織棘者佔據西半部，鋼鬃獵手在中間；補給箱在營地東端。",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "巫翼殺戮者佔據{area:383}西部；她們戴著戒指。",
	-- ["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "觸角掉落十五分鐘後就會消失：在同一片土丘擊殺異種蠍群集者和爬行者，直到湊滿五個，然後先別管雷鷹，直接帶去{area:378}交給{npc:6394}。小心：異種蠍群集者（21-22級）在戰鬥中和戰鬥外都會施放{npc:4196}，引來好幾隻小怪；異種蠍爬行者（20-21級）在戰鬥中會不時施放{npc:5781}，生出額外的小怪。一隻{npc:3253}（24級，稀有）也在土丘間遊蕩：別理它。",
	-- ["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "海盜在{area:392}南邊的海灘上紮營：複雜零件堆散落在他們之間的沙地上，{npc:3467}站在營地南端。",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "水池就在{npc:3389}北邊不遠。走進水裡探索；要給赫布瑞姆的豐滿的蘑菇長在水池周圍。順路擊殺每一個科卡爾半人馬取得護腕。{npc:3394}站在水池西邊的科卡爾營地裡。",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "三個巢一起位於綠洲西南方的{area:1697}；由赤鱗鐮爪龍守護。",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:3972} poster: {npc:3467} comes on the next {area:392} stop too"] = "{object:3972}告示：{npc:3467}也留到下次到{area:392}時再做",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "索恩格瑞姆·火眼在從{area:380}通往{area:392}的道路旁紮營。{object:58369}在他北邊不遠的鋼鬃營地南部。",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "雷霆蜥蜴和閃電蜥蜴就在{area:379}下方的橋對面吃草。",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "雷霆蜥蜴和閃電蜥蜴就在{area:379}下方的橋對面吃草。\n小心：12級精英哈利寇在{area:369}的蜥蜴群中遊蕩：拉怪前先留意他的位置。",
	-- ["Thunder lizards across the river"] = "河對岸的雷霆蜥蜴",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "電角蜥蜴在{area:378}南邊不遠的平原吃草。藍色雷霆蜥蜴{quest:884}在牠們之間遊蕩：牠的尾刺會開啟任務。",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "向南走回{area:380}。下一份指南從這裡開始，帶你前往{zone:1454}並搭飛艇到{zone:1420}。",
	-- ["Walk back west along the road to the {area:380}."] = "沿道路向西走回{area:380}。",
	-- ["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The eggs and the antennae come first, at the same mounds, then straight back to {npc:6394}; the thunderhawks after."] = "戰士：現在就向{npc:6394}接取{quest:1824}：從接取起計時30分鐘。先在同一片土丘收集蛋和觸角，然後直接回到{npc:6394}那裡；雷鷹之後再處理。",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "向西前往{area:383}。巫翼鷹身人在那裡到處築巢；任何一隻都可能掉落爪子。{quest:819}在她們的丘陵中。",
	-- ["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "既然在營地裡：{npc:3429}要的鋼鬃尋水者和鋼鬃織棘者在西半部，鋼鬃獵手在中間，補給箱在營地東端。\n小心：{npc:267308}和狂戰士（18-19級）是精英；牠們站在營地東北部的補給箱旁：把野豬人一隻一隻地從牠們身邊引開。",
	-- ["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "你的{area:718}任務，如果還沒接的話：{npc:3446}在{object:3972}告示旁，{npc:3665}在飛行管理員旁的碼頭上。這趟地城之行在本指南稍後，在{npc:3396}之後。",
	-- ["Zhevra"] = "斑馬",
	-- ["Zhevra Runners graze north and east of town."] = "快步斑馬在城鎮北邊和東邊吃草。",
	-- ["{area:1898} cultists"] = "{area:1898}的祭司",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380}是本指南的基地。你需要的人都在旅店附近幾步之內。",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}：在{area:2362}使用一半墜飾",
	-- ["{npc:3337}: {quest:840}, from {zone:1411}"] = "{npc:3337}：{quest:840}，來自{zone:1411}",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Oasis Snapjaws crawl in the water around it: their shells are for {npc:3448}."] = "{npc:3395}在十字路口東南方的{area:388}與科卡爾半人馬一起走動。綠洲鉗嘴龜在周圍的水中爬行：牠們的殼要交給{npc:3448}。",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395}在十字路口東南方{area:388}的科卡爾之間走動。趁在那裡，到綠洲東岸冒泡的裂縫測試{npc:3448}的種子。",
	-- ["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}，在{object:3972}告示旁邊",
	-- ["{npc:3446}, beside the {object:3972} poster: the Sunscale raptors come on the next {area:392} stop, at 18"] = "{npc:3446}，在{object:3972}告示旁：赤鱗迅猛龍留到18級下次到{area:392}時再做",
	-- ["{npc:3448}: the Oasis Snapjaws at the {area:388}, with {npc:3395}"] = "{npc:3448}：{area:388}的綠洲鉗嘴龜，以及{npc:3395}",
	-- ["{npc:3615}, the wind rider master"] = "雙足飛龍管理員{npc:3615}",
	-- ["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878}在從{area:380}通往{area:392}的道路旁紮營。{object:58369}在他北邊不遠的鋼鬃營地南部。",
	-- ["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900}在{area:379}南邊、過橋後的河岸上等著。",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907}站在鋼鬃營地北邊的山脊上。",
	-- ["{object:3972} poster"] = "{object:3972}海報",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}：下一份指南中{zone:1421}的{area:228}",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "白獅{quest:881}在鋼鬃營地北邊的平原徘徊。",
}
