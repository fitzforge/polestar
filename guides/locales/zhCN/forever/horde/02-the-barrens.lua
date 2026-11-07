-- Chinese (simplified) (zhCN): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "你从{area:379}过来。{npc:3489}和{npc:3338}站在旅店旁，赫布瑞姆和{npc:3464}在北门边；{npc:3615}、{npc:3429}和{npc:3449}在塔楼平台上。",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}，在塔楼上",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}：鹰身人稍后再打，在{area:383}",

	-- Step 2: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878}在向东通往{area:392}的路旁扎营。",

	-- Step 9: Razormane camp
	["Razormane camp"] = "钢鬃营地",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the {area:380}. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "钢鬃营地位于{area:380}东边。战士：{object:58369}在营地里。萨满祭司：野猪人掉落{item:5026}。\n注意：箱子在一辆破马车旁，由两个钢鬃野猪人看守，其中包括会把更多野猪人拉进战斗的猎手。",

	-- Step 10: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "钢鬃营地：{npc:3429}的野猪人",
	-- {npc:3429} Thork
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end."] = "既然在营地里：{npc:3429}要的钢鬃寻水者和钢鬃织棘者在西半部，钢鬃猎手在中部，补给箱在营地东端。",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine, as at 10. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "",

	-- Step 13: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 15: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380}是本指南的大本营。你要找的人都在旅店几步之内。",

	-- Step 16: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "顺路收集迅猛龙头",
	-- {area:380} The Crossroads
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the {area:380}, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "赤鳞迅猛龙在{area:380}北边和东边的平原上游荡，大约四只中有三只掉落头：杀掉沿途遇到的。注意：赤鳞尖啸龙生命值低于30%时会呼叫30码内的同伴。",

	-- Step 17: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "顺路收集陆行鸟的喙",
	-- {area:17} The Barrens
	["Plainstriders roam the plains all over the {area:17}, and about one in four drops a beak: kill the ones you pass on the way."] = "平原陆行鸟遍布{area:17}的平原，大约四只中有一只掉落喙：杀掉沿途遇到的。",

	-- Step 18: Razormane camp
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks."] = "营地里，钢鬃寻水者和钢鬃织棘者占据西半部，钢鬃猎手在中部；补给箱在营地东端。\n这里的陆行鸟也算在喙的数量里。",

	-- Step 19: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "收集完陆行鸟的喙",
	-- {area:380} The Crossroads
	["Still short of seven? Plainstriders are thickest on the plains north of the {area:380}, along the road north."] = "还不够七个？{area:380}北边沿北向道路的平原上陆行鸟最多。",

	-- Step 21: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "快步斑马在向东通往{area:392}的路边吃草：出发时顺路收集它们的蹄子。",

	-- Step 25: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907}站在钢鬃营地北边的山脊上。",

	-- Step 26: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "沿道路向东前往{area:814}上方的哨站。",

	-- Step 28: Thunder lizards across the river
	["Thunder lizards across the river"] = "河对岸的雷霆蜥蜴",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "雷霆蜥蜴和闪电蜥蜴就在{area:379}下方桥对面吃草。",

	-- Step 30: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900}在{area:379}南边、桥对面的河岸上等候。",

	-- Step 31: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898}的祭司",
	-- {area:1898} Dustwind Gulch · {area:14} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "",

	-- Step 34: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878}在从{area:380}到{area:392}的路旁扎营。{object:58369}在他北边不远的钢鬃营地南部。",

	-- Step 36: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "沿道路向东南前往海岸上的{area:392}。",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}：控制台在{area:382}，稍后",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}，在码头上",

	-- Step 37: The Barrens: kill these as you meet them
	-- {area:17} The Barrens
	["{area:17}: kill these as you meet them"] = "",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "",

	-- Step 39: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end.\nSunscale raptors here count toward the heads."] = "沿海滩往回走，经过海盗营地：一箱靴子和装着镜片的易碎品箱在营地南端。\n这里的赤鳞迅猛龙也算在头的数量里。",

	-- Step 41: Fly to The Crossroads
	-- {area:380} The Crossroads
	["Fly to {area:380}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 43: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "向南前往{npc:3389}在科卡尔边界的哨站。",

	-- Step 44: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "水池就在{npc:3389}北边。走进水里即可探索；给赫布瑞姆的丰满的蘑菇长在水池周围。杀死途中的每个科卡尔半人马获取护腕。{npc:3394}站在水池西边的科卡尔营地里。",

	-- Step 45: Regthar Deathgate
	-- {area:388} Stagnant Oasis · {area:17} The Barrens
	["Verog walks with the Kolkar at the {area:388}: later, in the 19-23 {area:17} guide"] = "维罗格和科卡尔半人马一起在{area:388}走动：稍后，在19-23级{area:17}指南中",

	-- Step 46: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "向西前往{area:383}。巫翼鹰身人在那里到处筑巢；任何一只都可能掉落爪子。{quest:819}就在它们的山丘中。草原徘徊者在{npc:3389}和山丘之间的平原上狩猎：顺路收集它们的爪子。\n注意：有2个巫翼伏击者（等级17-18）。它们脱离战斗时保持潜行。",

	-- Step 47: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "",
	["Inside"] = "",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{area:392}的{npc:3442}：稍后，顺路",

	-- Step 48: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "向东前往海岸上的{area:392}。",

	-- Step 49: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "回到钢鬃营地。钢鬃地卜师和钢鬃防御者占据营地东半部；{npc:3438}在他们中间走动。",

	-- Step 51: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}用焦油和材料袋制作{item:6636}。在他旁边的火盆处使用它，显现出{npc:5893}，杀死它获得{item:6655}，然后把余烬放进火盆。",

	-- Step 52: The Barrens
	["Sunscale raptors here count toward the heads."] = "这里的赤鳞迅猛龙也算在头的数量里。",

	-- Step 55: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "在{area:380}东南方。在绿洲东岸冒泡的裂缝处测试种子。",
	["Underwater"] = "",

	-- Step 56: The Crossroads
	["Back west along the road."] = "沿道路向西返回。",

	-- Step 57: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "{npc:3461}在{area:380}西南方的{area:387}周围和{area:388}周围爬行。",

	-- Step 58: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "向西北前往{area:383}：巫翼杀戮者占据其西端；戒指在它们身上。\n注意：一些潜行的鹰身人伏击者埋伏在该区域，你靠近前不会现身。还有一只19级精英鹰身人在那里巡逻。",

	-- Step 60: Raptor Horns
	-- {npc:9316} Wenikee Boltbucket · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way north-east to {npc:9316}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "向东北前往{npc:9316}的途中：赤鳞镰爪龙在{area:383}东边的平原上徘徊；任何一只都可能掉落{item:5055}，交给{area:392}的{npc:3446}。",

	-- Step 61: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["North-east to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "向东北前往{area:1703}；{npc:9316}站在其南边不远的营地。",

	-- Step 62: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "装有高强度齿轮的工具桶散落在{npc:9316}东边{area:382}中的风险投资公司钻探点周围。",

	-- Step 63: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "",

	-- Step 64: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the next guide's {zone:1454} visit"] = "",

	-- Step 65: Echeyakee
	-- {area:380} The Crossroads · {quest:881} Echeyakee
	["South-east on the way back to the {area:380}: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "返回{area:380}时向东南走：{quest:881}是一头白狮，在钢鬃营地北边的平原上徘徊。\n注意：草原女猎手在巢穴周围游荡。她们刷新很快，经常和{quest:881}一起加入战斗，所以吹号角前先清掉她们。\n这里的赤鳞迅猛龙也算在头的数量里。",

	-- Step 66: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "收集完迅猛龙头",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Still short of twelve? The Sunscale Screechers are thickest on the plains around {quest:881}'s lair, north of the Razormane camp."] = "还不够十二个？钢鬃营地北边、{quest:881}巢穴周围的平原上赤鳞尖啸龙最多。",

	-- Step 67: The Crossroads
	-- {npc:3464} Gazrog · {npc:3449} Darsok Swiftdagger · {npc:3338} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["In from the north gate: {npc:3464}, {npc:3449} on the tower platform, {npc:3338} by the inn, then {npc:3448} and Mura at the south gate. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "从北门进来：{npc:3464}，塔楼平台上的{npc:3449}，旅店旁的{npc:3338}，然后是南门的{npc:3448}和穆拉。下一份指南从这里开始，带你前往{zone:1454}并乘飞艇前往{zone:1420}。",
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}：{zone:1421}的{area:228}，下一份指南",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "沿海滩往回走，经过海盗营地：一箱靴子和装着镜片的易碎品箱在营地南端。",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "火刃祭司占据{zone:1411}北部的{area:1898}；它们掉落{item:6652}。{item:5026}在你下次去钢鬃营地时从钢鬃野猪人身上获得。",
	-- ["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "向东前往{area:1703}；{npc:9316}站在其南边不远的营地。",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "留着：{quest:3923}站在{zone:1454}外；之后的指南会交还",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "科卡尔牧民和科卡尔召雷师占据{npc:3389}南边的营地。",
	-- ["Kolkar camps"] = "科卡尔营地",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "绿洲钳嘴龟在{area:380}西南方的{area:387}周围和{area:388}周围爬行。",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "平原陆行鸟和赤鳞迅猛龙在{area:380}四周的平原上游荡，北边最多。",
	-- ["Plainstriders and raptors"] = "陆行鸟和迅猛龙",
	-- ["Raptor nests"] = "迅猛龙巢穴",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "在{area:380}东南方。在绿洲东岸冒泡的裂缝处测试种子。",
	-- ["Southsea beach"] = "南海海滩",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "草原徘徊者在镇子和东边钢鬃营地之间的平原上狩猎。营地里，钢鬃寻水者和钢鬃织棘者占据西半部，钢鬃猎手在中部；补给箱在营地东端。",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "巫翼杀戮者占据{area:383}西部；戒指在它们身上。",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "海盗在{area:392}南边的海滩上扎营。一堆错综复杂的零件散落在他们之间的沙子里。",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "水池就在{npc:3389}北边。走进水里即可探索；给赫布瑞姆的丰满的蘑菇长在水池周围。杀死途中的每个科卡尔半人马获取护腕。",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "三个巢穴一起位于绿洲西南方的{area:1697}；赤鳞镰爪龙守卫着它们。",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141}位于{area:382}西边的风险投资公司研究站。关闭钻机周围的三个阀门，再次使用控制台，然后从旁边的{npc:3471}身上拿到{item:5089}。",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "索恩格瑞姆在从{area:380}到{area:392}的路旁扎营。{object:58369}在他北边不远的钢鬃营地南部。",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "向南走回{area:380}。下一份指南从这里开始，带你前往{zone:1454}并乘飞艇前往{zone:1420}。",
	-- ["Walk back west along the road to the {area:380}."] = "沿道路向西走回{area:380}。",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "向西前往{area:383}。巫翼鹰身人在那里到处筑巢；任何一只都可能掉落爪子。{quest:819}就在它们的山丘中。",
	-- ["Zhevra"] = "斑马",
	-- ["Zhevra Runners graze north and east of town."] = "快步斑马在镇子北边和东边吃草。",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}，双足飞龙管理员",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}是一头白狮，在钢鬃营地北边的平原上徘徊。",
}
