-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位於{zone:1447}西南角，在{area:3137}南邊。",

	-- Step 2: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "精靈貴族的鬼魂在神殿周圍的遺跡中出沒；哈達爾薩特佔據神殿北邊不遠處的營地。",

	-- Step 5: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "從神殿向東北騎：{npc:8405}在{area:1224}紮營，位於道路上方的山丘上。",

	-- Step 6: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}東北方、往{area:1219}方向的山丘上覓食；更大的一群在南邊的空地上遊蕩。",

	-- Step 9: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可選：{npc:8395}要兩根完整的角鷹獸羽毛，從他營地周圍的角鷹獸身上取得。資料沒有列出這個任務的經驗值。",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 11: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北邊的{area:1219}紮營；他的裝備散落在他東南方不遠處的{area:1220}各處。",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的惡鞭納迦身上帶著{item:13815}。{npc:8507}的四塊符文石立在遺跡之間：對每一塊使用他的{item:10445}。",

	-- Step 17: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，約10%",

	-- Step 18: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 20: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 21: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 23: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外海的小島：{npc:8392}在紀念碑旁等候。",

	-- Step 24: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 25: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 27: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}的國王麥格尼身旁。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "聖物在{zone:1428}：保留此任務",

	-- Step 28: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 29: Wildkin feathers
	["Wildkin feathers"] = "梟獸羽毛",
	-- {zone:1425} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "",

	-- Step 30: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 32: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 33: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 34: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 35: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 36: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",

	-- Step 37: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",

	-- Step 38: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",

	-- Step 40: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 42: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "火腹巨魔佔據摩根的崗哨北邊的巨石，火腹蠻兵在它的東側。",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石獸人會掉落徽章，在整個燃燒平原期間保持此任務進行中",

	-- Step 44: Level 52
	["Level 52"] = "",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿著道路向西走，然後向北爬上{area:251}的哥布林營地。",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}的{area:2255}交給{quest:4808}：保留此任務",

	-- Step 48: Cyrus Therepentous
	["Below ground"] = "",

	-- Step 49: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 51: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 52: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "",

	-- Step 53: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿著道路向東騎回摩根的崗哨。",

	-- Step 54: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬上{area:249}頂端，把頭顱插在鬆軟的土堆上。",

	-- Step 56: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",

	-- Step 57: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%."] = "",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 65: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",

	-- Step 67: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 68: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "梟獸在{zone:1452}：保留此任務",

	-- Step 69: Druid training
	["Druid training"] = "德魯伊訓練",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}沒有德魯伊訓練師：走傳送門上到{zone:1457}，在{area:1658}學習，然後回到下方的{area:702}。",

	-- Step 70: Back to Teldrassil
	-- {zone:1438} Teldrassil
	["Back to {zone:1438}"] = "",

	-- Step 71: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

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
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "游到{area:16}南端外海的小島：{npc:8392}在紀念碑旁等候。",
	-- ["Thaurissan Relics"] = "索瑞森遺物",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遺物是散布在{area:251}周圍{area:250}的雕刻石塊：點擊它們，直到資訊全部取回。",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "神殿位於{area:16}西南角，在{area:3137}南邊。",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}東邊山坡上的{npc:7047}快死時對牠使用{item:12284}，然後拾取牠留下的精華。",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在要塞西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物會掉落不完美的德萊尼水晶碎片；把你有的帶給她。",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}和黑石獸人佔據{area:251}西邊、{area:254}山腳下的營地和要塞。一次拉一隻；每個獸人和座狼都可能掉落徽章，所以一直殺到你有五十個為止。",
}
