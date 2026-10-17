-- Chinese (simplified) (zhCN): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "你从{area:379}来到这里。{npc:3338}站在旅店旁；{npc:3429}和{npc:3449}在塔楼平台上；药剂师赫布瑞姆和{npc:3464}在北门旁；{npc:3448}在南门。",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "陆行鸟和迅猛龙",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "平原陆行鸟和赤鳞迅猛龙在{area:380}周围的平原上游荡。",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "斑马和迅猛龙",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "{npc:3242}在同一片平原上吃草；顺路收集完迅猛龙的头。",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}，在塔楼平台上：需要12级",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878}在向东通往{area:392}的路旁扎营。",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}站在{area:380}东边、钢鬃营地北边的山脊上。",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900}在钢鬃营地东边、{area:814}的{zone:1411}一侧河岸等候。",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898}的祭司",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "{npc:3199}占据着{zone:1411}北部{area:370}旁的{area:1898}；他们掉落{item:6652}。",

	-- Step 10: Razormane camp
	["Razormane camp"] = "钢鬃营地",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "钢鬃寻水者、钢鬃织棘者和钢鬃猎手占据着{area:380}东边的营地。补给箱在营地东端。战士：{object:58369}在营地里。萨满祭司：野猪人掉落{item:5026}。顺路击杀{npc:3425}获取爪子。",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}用焦油和袋子制作{item:6636}。在他旁边的火盆处使用它，让{npc:5893}现身，击杀它获得{item:6655}，然后把余烬放进火盆。",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "沿道路向东南到海岸边的{area:392}。",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}，在码头上",

	-- Step 15: Southsea beach
	["Southsea beach"] = "南海海滩",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "海盗在{area:392}南边的海滩上扎营。一堆错综复杂的零件散落在营地内外。",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "回到海盗营地：靴子在营地南端标着{object:3767}的箱子里，透镜在其东边的“易碎品”箱子里。",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "返回{area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "沿道路走回{area:380}。{npc:3425}在沿路和镇子西边的平原上捕猎：交任务前收集完爪子。",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}站在{area:380}西边不远处的科卡尔哨所。",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "科卡尔营地和{area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "科卡尔营地分布在{npc:3389}的西北方；每个科卡尔半人马都可能掉落{quest:855}。{area:386}在营地中间，水边长着{object:3640}。{npc:3425}在同一片平原上游荡。",
	["Wade into the pools to explore them"] = "涉水进入水池探索",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "巫翼鹰身人",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "鹰身人在{area:386}西北方的{area:383}筑巢；任何一只都可能掉落爪子。",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "向东到{area:382}西边的风险投资公司研究站。使用{object:4141}，关闭钻机周围的三个阀门，再次使用控制台，然后从{npc:3471}身上拿到{item:5089}。",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}的巢穴在{area:382}南边、{area:380}东北方。在那里使用{npc:3338}给你的号角，把白狮引出来。然后用炉石返回{area:392}。",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "返回{area:380}的路上，再次经过钢鬃营地：钢鬃地卜师和钢鬃防御者占据着营地东半部；{npc:3438}在他们中间巡逻。",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "绿洲在{area:380}东南方。在水中央冒泡的裂隙处测试种子。",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697}在绿洲西南方。{npc:3256}掉落羽毛，用在三个巢穴上。",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "{npc:3461}挤满了{area:380}西南方的{area:387}水域。",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "沿道路向北到{area:1703}；{npc:9316}就站在它南边。",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "{object:161752}散落在{npc:9316}东边、{area:382}的风险投资公司营地周围。",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "{npc:3278}",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "巫翼杀戮者占据着{area:383}西端，在你之前对付过的鹰身人更远处；它们掉落戒指。",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "在{zone:1413}的{area:383}刷{npc:3278}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "返回{area:380}；下一份指南从这里开始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "返回{area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "返回{area:380}；下一份指南从这里开始。",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "向东到{area:382}西边的风险投资公司研究站。使用{object:4141}，关闭钻机周围的三个阀门，再次使用控制台，然后从{npc:3471}身上拿到{item:5089}。",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "{npc:3461}挤满了{area:380}西南方的{area:387}水域。",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "返回{area:380}的路上，再次经过钢鬃营地：钢鬃地卜师和钢鬃防御者占据着营地东半部；{npc:3438}在他们中间巡逻。",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "平原陆行鸟和赤鳞迅猛龙在{area:380}周围的平原上游荡。",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "雷戈萨·死门站在{area:380}西边不远处的科卡尔哨所。",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "科卡尔营地分布在雷戈萨·死门的西北方；每个科卡尔半人马都可能掉落{quest:855}。{area:386}在营地中间，水边长着{object:3640}。{npc:3425}在同一片平原上游荡。",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "{object:161752}散落在维妮·布特巴克东边、{area:382}的风险投资公司营地周围。",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "绿洲在{area:380}东南方。在水中央冒泡的裂隙处测试种子。",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "沿道路走回{area:380}。{npc:3425}在沿路和镇子西边的平原上捕猎：交任务前收集完爪子。",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "钢鬃寻水者、钢鬃织棘者和钢鬃猎手占据着{area:380}东边的营地。补给箱在营地东端。战士：{object:58369}在营地里。萨满祭司：野猪人掉落{item:5026}。顺路击杀{npc:3425}获取爪子。",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}站在{area:380}东边、钢鬃营地北边的山脊上。",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}的巢穴在{area:382}南边、{area:380}东北方。在那里使用瑟格拉·黑棘给你的号角，把白狮引出来。然后用炉石返回{area:392}。",
}
