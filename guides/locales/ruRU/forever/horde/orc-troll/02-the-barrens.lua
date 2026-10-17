-- Russian (ruRU): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "Вы пришли от места {area:379}. {npc:3338} стоит у таверны; {npc:3429} и {npc:3449} – на площадке башни; Хелбрим и {npc:3464} – у северных ворот; {npc:3448} – у южных ворот.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Долгоноги и ящеры",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг места {area:380}.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "Жевры и ящеры",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "Жевры-бегуны пасутся на тех же равнинах; по пути доберите головы ящеров.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, на площадке башни: нужен 12-й уровень",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} стоит лагерем у дороги на восток к месту {area:392}.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} стоит на хребте к северу от лагеря Иглогривых, к востоку от места {area:380}.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900} ждет на берегу реки ({area:814}) со стороны края {zone:1411}, к востоку от лагеря Иглогривых.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Культисты: {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "Сектанты из клана Пылающего Клинка занимают место {area:1898} на севере края {zone:1411}, у места {area:370}; с них падает {item:6652}.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "Лагерь Иглогривых",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Водоискатели, терноплеты и охотники из племени Иглогривых занимают лагерь к востоку от места {area:380}. Ящики с припасами – в его восточной части. Воины: {object:58369} стоит в лагере. Шаманы: {item:5026} падает со свинобразов. По пути убивайте хищников саванны ради когтей.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} делает предмет {item:6636} из смолы и мешочка. Используйте его у жаровни рядом, чтобы увидеть персонажа {npc:5893}, убейте его ради предмета {item:6655}, затем положите уголек в жаровню.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, ваш {item:5176} и {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Идите по дороге на юго-восток сюда: {area:392}, на побережье.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, на пристани",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Пляж пиратов Южных морей",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "Пираты стоят лагерем вдоль пляжа к югу от места {area:392}. Груды сложных деталей лежат в их лагере и вокруг.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "Назад в лагерь пиратов: сапоги – в ящике с надписью {object:3767} в южной части лагеря, линза – в ящике «Хрупкое» чуть к востоку.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "Назад к месту {area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Возвращайтесь по дороге к месту {area:380}. Хищники саванны рыщут вдоль нее и на равнинах к западу от городка: доберите когти перед сдачей.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} стоит на дозорном посту против Колкар чуть к западу от места {area:380}.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "Лагеря Колкар и {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Лагеря Колкар тянутся к северо-западу от {npc:3389}; с любого кентавра Колкар могут упасть наручи ({quest:855}). {area:386} – посередине, вокруг воды растут спелые грибы. На тех же равнинах бродят хищники саванны.",
	["Wade into the pools to explore them"] = "Зайдите в пруды, чтобы исследовать их",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "Гарпии Зачарованного Крыла",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "Гарпии гнездятся здесь: {area:383}, к северо-западу от места {area:386}; коготь может упасть с любой.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Идите на восток к исследовательскому лагерю Торговой компании к западу от {area:382}. Используйте {object:4141}, закройте три вентиля у бура, снова используйте пульт, затем заберите {item:5089} у персонажа {npc:3471}.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "Логово ({quest:881}) – к югу от места {area:382}, к северо-востоку от места {area:380}. Протрубите там в рог от NPC {npc:3338}, чтобы выманить белого льва. Затем камень возвращения: {area:392}.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "По пути назад к месту {area:380} – снова лагерь Иглогривых: геоманты и защитники занимают восточную половину; {npc:3438} бродит среди них.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "Оазис – к юго-востоку от места {area:380}. Проверьте семена у бурлящей трещины посреди воды.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697} – к юго-западу от оазиса. С яркочешуйчатых смертехватов падают перья, которые нужно использовать на трех гнездах.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Оазисные хрустогрызы толпятся в воде ({area:387}), к юго-западу от места {area:380}.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "Идите по дороге на север сюда: {area:1703}; {npc:9316} стоит чуть к югу.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "Ведра с инструментами стоят вокруг лагеря Торговой компании на {area:382}, к востоку от {npc:9316}.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "Душегубки из стаи Зачарованного Крыла",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "Душегубки занимают западный край места {area:383}, за гарпиями, с которыми вы уже бились; с них падают кольца.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "бейте душегубок из стаи Зачарованного Крыла: {area:383}, {zone:1413}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "Назад к месту {area:380}; здесь начинается следующее руководство.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "Назад: {area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "Назад сюда: {area:380}; здесь начинается следующее руководство.",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Идите на восток к исследовательскому лагерю Торговой компании к западу от места {area:382}. Используйте {object:4141}, закройте три вентиля у бура, снова используйте пульт, затем заберите {item:5089} у персонажа {npc:3471}.",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Оазисные хрустогрызы толпятся в воде ({area:387}), к юго-западу от места {area:380}.",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "По пути назад ({area:380}) – снова лагерь Иглогривых: геоманты и защитники занимают восточную половину; {npc:3438} бродит среди них.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Равнинные долгоноги и яркочешуйчатые ящеры бродят по равнинам вокруг места {area:380}.",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "Ретгар стоит на дозорном посту против Колкар чуть к западу от места {area:380}.",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Лагеря Колкар тянутся к северо-западу от Ретгара; с любого кентавра Колкар могут упасть наручи ({quest:855}). {area:386} – посередине, вокруг воды растут спелые грибы. На тех же равнинах бродят хищники саванны.",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "Ведра с инструментами стоят вокруг лагеря Торговой компании ({area:382}), к востоку от Венаки.",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "Оазис – к юго-востоку от места {area:380}. Проверьте семена у бурлящей трещины посреди воды.",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Возвращайтесь по дороге сюда: {area:380}. Хищники саванны рыщут вдоль нее и на равнинах к западу от городка: доберите когти перед сдачей.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Водоискатели, терноплеты и охотники из племени Иглогривых занимают лагерь к востоку от места {area:380}. Ящики с припасами – в его восточной части. Воины: {object:58369} стоит в лагере. Шаманы: {item:5026} падает со свинобразов. По пути убивайте хищников саванны ради когтей.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} стоит на хребте к северу от лагеря Иглогривых, к востоку от места {area:380}.",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "Логово ({quest:881}) – к югу от места {area:382}, к северо-востоку от места {area:380}. Протрубите там в рог от Сергры, чтобы выманить белого льва. Затем камень возвращения: {area:392}.",
}
