-- Russian (ruRU): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Летите из города {zone:1455} в {area:150} и сядьте на корабль до места {area:442}.",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "От причала ({area:442}) летите в {area:415}.",

	-- Step 3: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Езжайте по дороге на восток из зоны {zone:1440} в зону {zone:1447} к лагерю часовых: {area:3137}.",

	-- Step 4: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Святилище лежит в юго-западном углу зоны {zone:1447}, к югу от заставы ({area:3137}).",

	-- Step 5: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Призраки высокорожденных бродят по руинам вокруг святилища; сатиры из племени Халдарр занимают лагерь сразу к северу от него.",

	-- Step 7: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Езжайте от святилища на северо-восток: {npc:8405} стоит лагерем здесь – {area:1224}, в холмах над дорогой.",

	-- Step 8: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Мохоногие олени",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Ближайшие мохоногие олени пасутся в холмах к северо-востоку от места {area:1224}, в сторону места {area:1219}; стадо побольше бродит по открытой местности на юге.",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Необязательно: {npc:8395} хочет два неповрежденных пера гиппогрифа с гиппогрифов вокруг его лагеря. По данным, опыта за это не дают.",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} стоит лагерем на севере ({area:1219}); его снаряжение разбросано по всему месту {area:1220} сразу к юго-востоку от него.",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Наги из клана Бича Злобы ({area:1221}) носят предмет {item:13815}. Четыре руны, которые нужны NPC {npc:8507}, стоят среди руин: используйте на каждой его {item:10445}.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, около 10%",

	-- Step 13: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Поднимитесь назад к NPC {npc:8405} ({area:1224}) над руинами.",

	-- Step 15: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Доплывите до островка у южной оконечности зоны {zone:1447}: {npc:8392} ждет у памятника.",

	-- Step 17: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "Летите из города {zone:1455} в {area:69}.",

	-- Step 18: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Езжайте на север из поселка {area:69} через перевал в зону {zone:1428}; {area:2418} – наверху, на юго-востоке степей.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: медальоны падают с орков из клана Черной Горы, держите задание открытым всё время в Пылающих степях",

	-- Step 19: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Огры из клана Огненного Чрева занимают большую скалу к северу от Дозора, громилы – на ее восточной стороне.",

	-- Step 21: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Идите по дороге на запад, затем поднимитесь на север к лагерю гоблинов: {area:251}.",

	-- Step 22: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "Мощи Тауриссана",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Мощи – это резные камни, разбросанные по руинам ({area:250}) вокруг места {area:251}: щелкайте по ним, пока не восстановите сведения.",

	-- Step 23: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Прочитайте табличку в лагере ({object:147516}) среди руин к юго-западу от места {area:251}, чтобы скопировать текст.",

	-- Step 24: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Используйте {item:12284} на противнике {npc:7047} на склонах к востоку от места {area:251} незадолго до его смерти, затем заберите оставшуюся эссенцию.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Завершается заданием «{quest:4808}» ({area:2255}, {zone:1452}): сохраните",

	-- Step 26: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} и орки из клана Черной Горы занимают лагеря и крепость у подножия горы ({area:254}), к западу от места {area:251}. Выманивайте их по одному; медальон может выпасть с любого орка и ворга, так что убивайте, пока не наберете пятьдесят.",

	-- Step 27: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Необязательно: призрак {npc:8888} стоит на своей гробнице на огромной цепи внутри горы ({area:254}), и видят его только мертвые. Если вы все равно погибнете у горы, доберитесь до него духом, прежде чем воскреснуть.",

	-- Step 28: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Езжайте по дороге назад на восток к Дозору.",

	-- Step 29: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Поднимитесь на вершину скалы ({area:249}) и посадите голову в кучу мягкой земли.",

	-- Step 31: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "Летите в {area:1438}.",

	-- Step 32: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} ждет на холме к юго-западу от крепости ({area:2517}). С существ зоны {zone:1419} по пути падают несовершенные фрагменты дренетиста; принесите ей, сколько есть.",

	-- Step 33: Wildkin feathers
	["Wildkin feathers"] = "Перья диких совухов",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Езжайте назад в {area:1438} и летите в {area:348}. Перья диких совухов лежат на земле по всей зоне {zone:1425}, к югу и востоку от места {area:348}, где бродят совухи; здешние существа теперь намного ниже вас уровнем.",

	-- Step 35: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Летите в {area:150} и сядьте на корабль до места {area:442}, затем на корабль дальше: {area:702}.",

	-- Step 36: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Дикие совухи – в зоне {zone:1452}: сохраните",

	-- Step 37: Druid training
	["Druid training"] = "Обучение друида",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "В городе {zone:1455} нет учителя друидов: поднимитесь порталом в город {zone:1457}, обучитесь в анклаве ({area:1658}) и спуститесь назад: {area:702}.",
}
