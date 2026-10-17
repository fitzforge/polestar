-- Chinese (traditional) (zhTW): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380}是本指南的基地。你需要的人都在旅店附近幾步之內。",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "雙足飛龍管理員{npc:3615}",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}：鷹身人之後在{area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "平原陸行鳥與迅猛龍",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "平原陸行鳥和赤鱗迅猛龍在{area:380}周圍的平原遊蕩，北邊最密集。",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "快步斑馬在城鎮北邊和東邊吃草。",
	["Zhevra"] = "斑馬",

	-- Step 6: Razormane camp
	["Razormane camp"] = "鋼鬃營地",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "草原徘徊者在城鎮與東邊鋼鬃營地之間的平原狩獵。營地中，鋼鬃尋水者和鋼鬃織棘者佔據西半部，鋼鬃獵手在中間；補給箱在營地東端。",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907}站在鋼鬃營地北邊的山脊上。",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "沿道路向東前往{area:814}上方的哨站。",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "河對岸的雷霆蜥蜴",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "雷霆蜥蜴和閃電蜥蜴就在{area:379}下方的橋對面吃草。",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900}在{area:379}南邊、過橋後的河岸上等著。",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898}的祭司",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "火刃祭司佔據{zone:1411}北部的{area:1898}；他們會掉落{item:6652}。{item:5026}在你下次去鋼鬃營地時從鋼鬃野豬人身上取得。",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878}在從{area:380}通往{area:392}的道路旁紮營。{object:58369}在他北邊不遠的鋼鬃營地南部。",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "沿道路向東南前往海岸的{area:392}。",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}：控制台之後在{area:382}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}，在碼頭上",

	-- Step 15: Southsea beach
	["Southsea beach"] = "南海海灘",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "海盜在{area:392}南邊的海灘上紮營。複雜零件堆散落在他們之間的沙地上。",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "沿海灘往回走，經過海盜營地：裝靴子的箱子和裝鏡片的易碎箱子在營地南端。",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "沿道路向西走回{area:380}。",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "回到鋼鬃營地。鋼鬃地卜師和鋼鬃防禦者佔據營地東半部；{npc:3438}在他們之間走動。",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}用焦油和袋子製作{item:6636}。在他旁邊的火盆使用它以顯現{npc:5893}，擊殺它取得{item:6655}，然後把餘燼放進火盆。",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "白獅{quest:881}在鋼鬃營地北邊的平原徘徊。",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141}在{area:382}西邊的風險投資公司研究站。關閉鑽機周圍的三個閥門，再次使用控制台，然後從旁邊的{npc:3471}身上取得{item:5089}。",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{area:392}的{npc:3442}：之後順路",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "向西前往{area:383}。巫翼鷹身人在那裡到處築巢；任何一隻都可能掉落爪子。{quest:819}在她們的丘陵中。",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "向南前往{npc:3389}在科卡爾邊界的哨站。",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "水池就在{npc:3389}北邊不遠。走進水裡探索；要給藥劑師赫布瑞姆的豐滿的蘑菇長在水池周圍。順路擊殺每一個科卡爾半人馬取得護腕。",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "科卡爾半人馬營地",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "科卡爾牧民和科卡爾召雷師佔據{npc:3389}南邊的營地。",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "在{area:380}東南方。在綠洲東岸冒泡的裂縫測試種子。",

	-- Step 32: Raptor nests
	["Raptor nests"] = "迅猛龍巢",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "三個巢一起位於綠洲西南方的{area:1697}；由赤鱗鐮爪龍守護。",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "向東前往海岸的{area:392}。",

	-- Step 34: The Crossroads
	["Back west along the road."] = "沿道路往西回去。",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "綠洲鉗嘴龜在{area:380}西南方的{area:387}周圍，以及{area:388}周圍爬行。",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}：下一份指南中{zone:1421}的{area:228}",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "巫翼殺戮者佔據{area:383}西部；她們戴著戒指。",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "向東前往{area:1703}；{npc:9316}站在它南邊不遠的營地。",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "裝著蛞蝓的工具籃在{npc:9316}東邊、{area:382}的風險投資公司鑽探場周圍。",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "先留著：{quest:3923}站在{zone:1454}外；之後的指南會繳交",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "向南走回{area:380}。下一份指南從這裡開始，帶你前往{zone:1454}並搭飛艇到{zone:1420}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "綠洲鉗嘴龜在{area:380}西南方的{area:387}周圍，以及{area:388}周圍爬行。",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "平原陸行鳥和赤鱗迅猛龍在{area:380}周圍的平原遊蕩，北邊最密集。",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "在{area:380}東南方。在綠洲東岸冒泡的裂縫測試種子。",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "索恩格瑞姆·火眼在從{area:380}通往{area:392}的道路旁紮營。{object:58369}在他北邊不遠的鋼鬃營地南部。",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "向南走回{area:380}。下一份指南從這裡開始，帶你前往{zone:1454}並搭飛艇到{zone:1420}。",
	-- ["Walk back west along the road to the {area:380}."] = "沿道路向西走回{area:380}。",
}
