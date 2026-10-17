-- Russian (ruRU): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {area:608} Nijel's Point
	["From {area:608}"] = "Откуда: {area:608}",
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: для NPC {npc:1480} в Менетиле, в конце этого гайда",

	-- Step 2: Delgren the Purifier
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Идите по дороге на запад из места {area:415}; {area:413} — к северу от нее.",

	-- Step 3: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Мелирия и {npc:3901}",
	["The two stand together at the western end of the road."] = "Обе стоят вместе в западном конце дороги.",

	-- Step 4: Shael'dryn
	-- {area:415} Astranaar
	["The moonwell lies in the hills north-east of {area:415}."] = "Лунный колодец — на холмах к северо-востоку от места {area:415}.",

	-- Step 5: Dartol's Rod
	["Dartol's Rod"] = "Жезл Дартола",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "{item:5475} у безумных и высохших древняков к северу от лунного колодца; старый сундук, который он открывает, стоит среди них.",

	-- Step 6: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Пройдите по туннелю сюда: {area:419}; фолиант лежит в руинах в западной части.",

	-- Step 8: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Идите по дороге на восток к лагерям сатиров ({area:429}); {npc:3920} прячется на их окраине.",

	-- Step 9: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} ведет сатиров ({area:429}); ветвь у него.",

	-- Step 10: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901} стоит в лагере сатиров ({area:430}), дальше на восток по дороге.",

	-- Step 11: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоит {npc:3848}.",

	-- Step 12: Bottle of Disease
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}."] = "Лагерь Отрекшихся — в лесу к югу от места {area:2358}.",

	-- Step 13: Iron Pommel
	["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Ржавые сундуки стоят вокруг лагерей фурболгов из Чащобы к западу от Отрекшихся; открывайте их, пока в одном не найдется навершие.",

	-- Step 14: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931} бродит по берегу ({quest:1035}) к юго-западу от сундуков; {object:669176} лежит к северу от озера, по пути.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: для NPC {npc:3961} ({area:415})",

	-- Step 16: Insane druids
	["Insane druids"] = "Обезумевшие друиды",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Три друида стоят вместе в лагере Отрекшихся к югу от места {area:2358}.",

	-- Step 18: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Второй {object:19901} — в долине ({area:428}), по пути на запад.",

	-- Step 20: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Святилище стоит на холме чуть юго-восточнее лунного колодца; поднимитесь по извилистой тропе.",

	-- Step 23: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, фурболг, не тронутый порчей, сидит к югу от дороги ниже места {area:421}.",

	-- Step 24: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} и его стража стоят лагерем чуть восточнее: {npc:3897}.",

	-- Step 29: Auberdine
	-- {area:150} Menethil Harbor · {area:442} Auberdine
	["Take the boat to {area:150} from {area:442}'s docks."] = "Плывите на корабле в {area:150} с причалов места {area:442}.",

	-- Step 30: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} стоит на верхнем этаже Крепости Менетил.",

	-- Step 31: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Обломки «Flying Osprey» лежат на мелководье к югу от крепости.",

	-- Step 32: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Слитки светлостали",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Слитки у мурлоков из племени Синежабрых на пляже к юго-западу от Менетила.",

	-- Step 34: Deepwater Tavern
	-- {npc:5082} Vincent Hyal · {npc:4963} Mikhail · {npc:4962} Tapoke "Slim" Jahn · {npc:1480} Caitlin Grassman
	["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} и {npc:4962} — все в таверне Менетила; Тапоке нападает, когда вы говорите с NPC {npc:4963}, но сдается после поражения. {npc:1480} стоит недалеко к северо-востоку от таверны.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Обратно на запад по дороге к лагерям сатиров ({area:429}).",
	-- ["Geltharis"] = "Гелтарис",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоят {npc:3848} и {npc:221269}.",
	-- ["{area:429} satyrs"] = "Сатиры: {area:429}",
}
