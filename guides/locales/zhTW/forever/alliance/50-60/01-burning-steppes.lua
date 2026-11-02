-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {area:16} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "",

	-- Step 2: On the way
	["On the way"] = "",
	-- {npc:6116} Highborne Apparition · {area:1235} Shadowsong Shrine
	["{npc:6116} along the way to {area:1235}"] = "",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} along the way to {area:1235}"] = "",

	-- Step 3: Azshara: kill these as you meet them
	-- {area:16} Azshara
	["{area:16}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "精靈貴族的鬼魂在神殿周圍的遺跡中出沒；哈達爾薩特佔據神殿北邊不遠處的營地。",

	-- Step 6: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "從神殿向東北騎：{npc:8405}在{area:1224}紮營，位於道路上方的山丘上。",

	-- Step 7: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}東北方、往{area:1219}方向的山丘上覓食；更大的一群在南邊的空地上遊蕩。",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可選：{npc:8395}要兩根完整的角鷹獸羽毛，從他營地周圍的角鷹獸身上取得。資料沒有列出這個任務的經驗值。",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北邊的{area:1219}紮營；他的裝備散落在他東南方不遠處的{area:1220}各處。",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的惡鞭納迦身上帶著{item:13815}。{npc:8507}的四塊符文石立在遺跡之間：對每一塊使用他的{item:10445}。",

	-- Step 15: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，約10%",

	-- Step 17: Level 50.89
	["Level 50.89"] = "",
	-- {area:1256} The Ruined Reaches
	["Top up here to level 50.89 before the hand-ins at {area:1256}: they take you to level 51."] = "",

	-- Step 19: Ravencrest Monument
	-- {area:16} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "",

	-- Step 20: Hearth to Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["Hearth to {area:2101}"] = "",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 22: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 24: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 25: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 26: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "火腹巨魔佔據摩根的崗哨北邊的巨石，火腹蠻兵在它的東側。",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",

	-- Step 27: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石獸人會掉落徽章，在整個燃燒平原期間保持此任務進行中",

	-- Step 28: Blackrock Medallion on the way
	-- {item:11467} Blackrock Medallion
	["{item:11467} on the way"] = "",

	-- Step 29: Thaurissan Relic on the way
	-- {object:153556} Thaurissan Relic
	["{object:153556} on the way"] = "",

	-- Step 30: Level 51.39
	["Level 51.39"] = "",
	-- {area:251} Flame Crest
	["Top up here to level 51.39 before the hand-ins at {area:251}: they take you to level 52."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "",

	-- Step 31: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿著道路向西走，然後向北爬上{area:251}的哥布林營地。",

	-- Step 32: Level 52
	["Level 52"] = "",
	-- {area:251} Flame Crest
	["Top up here to level 52 before the hand-ins at {area:251}: they take you to level 53."] = "",

	-- Step 33: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "",

	-- Step 34: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}的{area:2255}交給{quest:4808}：保留此任務",

	-- Step 35: Cyrus Therepentous
	["Below ground"] = "",

	-- Step 36: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 38: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 39: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "",

	-- Step 40: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿著道路向東騎回摩根的崗哨。",

	-- Step 41: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬上{area:249}頂端，把頭顱插在鬆軟的土堆上。",

	-- Step 43: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",

	-- Step 44: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {object:141891} Razelikh's Tear (no name in this language: may be words)
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts Mana Burn, Strong Cleave and Decimate, and as its health drops it adds {object:141891}, Flames of Chaos and then Enrage at 15%."] = "",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 53: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",

	-- Step 54: Wildkin feathers
	["Wildkin feathers"] = "梟獸羽毛",
	-- {area:47} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {area:47}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "",

	-- Step 55: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 57: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 59: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 60: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "梟獸在{zone:1452}：保留此任務",

	-- Step 61: Druid training
	["Druid training"] = "德魯伊訓練",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}沒有德魯伊訓練師：走傳送門上到{zone:1457}，在{area:1658}學習，然後回到下方的{area:702}。",

	-- Step 62: Back to Teldrassil
	-- {area:141} Teldrassil
	["Back to {area:141}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "爬回遺跡上方{area:1224}的{npc:8405}處。",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "從{zone:1455}飛往{area:150}，搭船前往{area:442}。",
	-- ["Fly from {zone:1455} to {area:69}."] = "從{zone:1455}飛往{area:69}。",
	-- ["Fly to {area:1438}."] = "飛往{area:1438}。",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "飛往{area:150}，搭船前往{area:442}，再轉船前往{area:702}。",
	-- ["From the {area:442} dock, fly to {area:415}."] = "從{area:442}碼頭飛往{area:415}。",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "可選：{npc:8888}的鬼魂站在{area:254}內巨大鎖鏈上的墳墓上，只有死者能看見他。如果你反正在山附近死了，在復活前讓你的靈魂跑去找他。",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "閱讀{area:251}西南方遺跡中{object:147516}營地裡的石板，抄下文字。",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "騎回{area:1438}，飛往{area:348}。梟獸羽毛散落在{area:348}南邊和東邊、梟獸遊蕩的{zone:1425}各處地上；這裡的怪物現在比你低很多。",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "沿著道路向東騎出{zone:1440}進入{zone:1447}，前往{area:3137}的哨兵營地。",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "向北騎出{area:69}，穿過山口進入{zone:1428}；{area:2418}位於頂端，在燃燒平原東南部。",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外海的小島：{npc:8392}在紀念碑旁等候。",
	-- ["Thaurissan Relics"] = "索瑞森遺物",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遺物是散布在{area:251}周圍{area:250}的雕刻石塊：點擊它們，直到資訊全部取回。",
	-- ["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位於{zone:1447}西南角，在{area:3137}南邊。",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}東邊山坡上的{npc:7047}快死時對牠使用{item:12284}，然後拾取牠留下的精華。",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在要塞西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物會掉落不完美的德萊尼水晶碎片；把你有的帶給她。",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}和黑石獸人佔據{area:251}西邊、{area:254}山腳下的營地和要塞。一次拉一隻；每個獸人和座狼都可能掉落徽章，所以一直殺到你有五十個為止。",
}
