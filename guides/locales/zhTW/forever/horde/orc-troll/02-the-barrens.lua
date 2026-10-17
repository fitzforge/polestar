-- Chinese (traditional) (zhTW): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "你從{area:379}抵達。{npc:3338}站在旅店旁；{npc:3429}和{npc:3449}在塔台上；藥劑師赫布瑞姆和{npc:3464}在北門旁；{npc:3448}在南門。",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "平原陸行鳥與迅猛龍",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "平原陸行鳥和赤鱗迅猛龍在{area:380}周圍的平原上遊蕩。",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "斑馬與迅猛龍",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "快步斑馬在同一片平原上吃草；順便收集完迅猛龍頭。",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}，在塔台上：需要12級",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878}在往東通往{area:392}的道路旁紮營。",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}站在鋼鬃營地北邊的山脊上，位於{area:380}東邊。",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900}在{area:814}的{zone:1411}岸邊等著，位於鋼鬃營地東邊。",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898}的祭司",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "火刃祭司佔據{zone:1411}北部、{area:370}旁的{area:1898}；他們會掉落{item:6652}。",

	-- Step 10: Razormane camp
	["Razormane camp"] = "鋼鬃營地",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "鋼鬃尋水者、鋼鬃織棘者和鋼鬃獵手佔據{area:380}東邊的營地。補給箱放在營地東端。戰士：{object:58369}在營地裡。薩滿：野豬人會掉落{item:5026}。順路擊殺草原徘徊者取得爪子。",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}用焦油和袋子製作{item:6636}。在他旁邊的火盆使用它以顯現{npc:5893}，擊殺它取得{item:6655}，然後把餘燼放進火盆。",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "沿道路向東南前往海岸的{area:392}。",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}，在碼頭上",

	-- Step 15: Southsea beach
	["Southsea beach"] = "南海海灘",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "海盜在{area:392}南邊的海灘上紮營。複雜零件堆就在他們的營地裡和周圍。",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "回到海盜營地：靴子在營地南端標有{object:3767}的箱子裡，鏡片在它東邊不遠的易碎箱子裡。",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "返回{area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "沿道路走回{area:380}。草原徘徊者在路邊和城鎮西邊的平原上狩獵：繳交前先收集完爪子。",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}站在{area:380}西邊不遠的科卡爾半人馬哨站。",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "科卡爾半人馬營地與{area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "科卡爾半人馬營地分布在{npc:3389}西北方；每個科卡爾半人馬都可能掉落{quest:855}。{area:386}在營地中央，水邊有豐滿的蘑菇。草原徘徊者在同一片平原遊蕩。",
	["Wade into the pools to explore them"] = "涉水進入水池探索",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "巫翼鷹身人",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "鷹身人在{area:386}西北方的{area:383}築巢；任何一隻都可能掉落爪子。",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "向東前往{area:382}西邊的風險投資公司研究站。使用{object:4141}，關閉鑽機周圍的三個閥門，再次使用控制台，然後從{npc:3471}身上取得{item:5089}。",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}的巢穴在{area:382}南邊、{area:380}東北方。在那裡使用{npc:3338}給你的號角把白獅引出來。然後用爐石回到{area:392}。",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "在返回{area:380}的路上，再去一次鋼鬃營地：鋼鬃地卜師和鋼鬃防禦者佔據營地東半部；{npc:3438}在他們之間走動。",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "綠洲在{area:380}東南方。在水中央冒泡的裂縫測試種子。",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697}在綠洲西南方。赤鱗鐮爪龍會掉落羽毛，用在三個巢上。",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "綠洲鉗嘴龜擠滿了{area:380}西南方{area:387}的水域。",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "沿道路向北前往{area:1703}；{npc:9316}就站在它南邊。",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "工具籃放在{npc:9316}東邊、{area:382}的風險投資公司營地周圍。",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "巫翼殺戮者",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "巫翼殺戮者佔據{area:383}的西端，在你之前打過的鷹身人後方；她們會掉落戒指。",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "在{zone:1413}的{area:383}刷巫翼殺戮者",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "返回{area:380}；下一份指南從這裡開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "返回{area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "返回{area:380}；下一份指南從這裡開始。",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "向東前往{area:382}西邊的風險投資公司研究站。使用{object:4141}，關閉鑽機周圍的三個閥門，再次使用控制台，然後從{npc:3471}身上取得{item:5089}。",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "綠洲鉗嘴龜擠滿了{area:380}西南方{area:387}的水域。",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "在返回{area:380}的路上，再去一次鋼鬃營地：鋼鬃地卜師和鋼鬃防禦者佔據營地東半部；{npc:3438}在他們之間走動。",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "平原陸行鳥和赤鱗迅猛龍在{area:380}周圍的平原上遊蕩。",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "雷戈薩·死門站在{area:380}西邊不遠的科卡爾半人馬哨站。",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "科卡爾半人馬營地分布在雷戈薩西北方；每個科卡爾半人馬都可能掉落{quest:855}。{area:386}在營地中央，水邊有豐滿的蘑菇。草原徘徊者在同一片平原遊蕩。",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "工具籃放在維妮東邊、{area:382}的風險投資公司營地周圍。",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "綠洲在{area:380}東南方。在水中央冒泡的裂縫測試種子。",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "沿道路走回{area:380}。草原徘徊者在路邊和城鎮西邊的平原上狩獵：繳交前先收集完爪子。",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "鋼鬃尋水者、鋼鬃織棘者和鋼鬃獵手佔據{area:380}東邊的營地。補給箱放在營地東端。戰士：{object:58369}在營地裡。薩滿：野豬人會掉落{item:5026}。順路擊殺草原徘徊者取得爪子。",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}站在鋼鬃營地北邊的山脊上，位於{area:380}東邊。",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}的巢穴在{area:382}南邊、{area:380}東北方。在那裡使用瑟格拉給你的號角把白獅引出來。然後用爐石回到{area:392}。",
}
