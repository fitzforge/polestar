-- Russian (ruRU): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "В край {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and go south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: письмо Пшикса Медноштифа ({area:439})",

	-- Step 3: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Идите на запад по дороге к месту {area:340}; лагерь {npc:2921} – здесь: {area:1878}, на полпути.",

	-- Step 4: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} – крепость Орды в скалах у западного края зоны. {npc:5394} стоит на верхнем ярусе ({area:340}), высоко над распорядителем полетов: поднимайтесь по пандусам, стрелка не различает ярусы.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "для Хелгрума ({area:75}), примерно на 42-м уровне",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Маленькие элементали бродят по равнине между местом {area:340} и лагерем {npc:2921}, по дороге обратно на восток. С любого каменного элементаля в зоне могут падать осколки каменного элементаля для {npc:6868}.",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "",
	-- {area:1878} The Dustbowl · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards.\nThe bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards."] = "Старые скальные койоты и гигантские канюки бродят по низине к югу от места {area:1878}. С койотов падают и челюсти, и клыки; желудки – с гигантских канюков.\nКаменные элементали покрупнее стоят на склонах к северо-западу от места {area:1878}; с каждого падает плита. С любого каменного элементаля могут падать осколки каменного элементаля для {npc:6868}.",

	-- Step 9: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Тельдарин сидит среди руин дворфов ({area:345}), к югу от места {area:1877}.",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Трогги Каменного Свода",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Трогги племени Каменного Свода копают у входов в пещеры к югу от места {area:1877}, по пути к месту {area:345}; хлопья падают с костегрызов и шаманов. Канюки, нужные для крыльев ({npc:2817}), кружат над холмами между местами {area:1877} и {area:345}.",

	-- Step 11: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "Дорога на север к месту {area:1517} проходит здесь: {area:1877}. По пути {npc:2817} и {npc:4618} принимают крылья и хлопья.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "",

	-- Step 12: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Идите дальше на север по дороге; сундук – на раскопках ({area:1517}), у подножия руин к северо-западу от дороги.",
	["Below ground"] = "",

	-- Step 13: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "",

	-- Step 14: The Dustbowl: kill these as you meet them
	-- {area:1878} The Dustbowl
	["{area:1878}: kill these as you meet them"] = "",
	-- {zone:1418} Badlands · {npc:6868} Jarkal Mossmeld · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "",

	-- Step 15: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: только если у вас есть {item:2868} ({skill:164} или аукцион)",

	-- Step 16: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head north back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Возвращайтесь на север сюда: {area:340}. {npc:5394} стоит на верхнем ярусе ({area:340}), высоко над распорядителем полетов: поднимайтесь по пандусам, стрелка не различает ярусы.",
	-- {area:340} Kargath · {area:35} Booty Bay
	["The next guide flies from {area:340} to {area:35}."] = "",
}
