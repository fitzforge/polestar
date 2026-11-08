-- Russian (ruRU): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298} (Альянс)",
	["A dagger at 10 from your home town's rogue quests."] = "Кинжал на 10-м уровне за задания разбойников в вашем родном городе.",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["At 10 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in Goldshire, gives you a package for {npc:332} in {zone:1453}. Train Pick Pocket if you lack it: this chain needs it."] = "",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north to {zone:1453}. Shaw stands upstairs in the SI:7 building in {object:2100} (the quest says the Barracks; it means SI:7)."] = "",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster
	["The {npc:6846} (level 10, a goblin) works in the dock house at Jerod's Landing, on the river at Elwynn's southern edge, south of Goldshire. Stealth in and Pick Pocket him from behind: the schedule never drops from his corpse. Do not open with Sap or a fight: he calls in three waves of bodyguards. Keep away from the fireplaces in the house; they burn you out of stealth. He is back 2 to 5 minutes after a death."] = "",
	-- {npc:6846} Defias Dockmaster · {item:7675} Defias Shipping Schedule
	["Pick Pocket the {npc:6846} for the {item:7675}"] = "",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "Назад к Матиасу Шоу",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}, ШРУ",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the Thunderbrew Distillery in Kharanos, sends you to {npc:5165} in {zone:1455}."] = "",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1455} Ironforge
	["{npc:5165} is in the {object:32383}, the rogue quarter in the north of {zone:1455}: go into the building with a shady dealer outside and down the stairs."] = "",

	-- Step 7: Onin MacHammar
	-- {npc:6886} Onin MacHammar · {npc:1211} Leper Gnome
	["Head west to Gnomeregan. Beside the road to its entrance stands a wooden spiral tower: {npc:6886} waits stealthed on the top platform, next to a level 10 {npc:1211}, so you only see him up close."] = "",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "Назад к {npc:5165}",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in the Dolanaar inn, gives you a rose for {npc:4163} in {zone:1457}. If you lose the rose, abandon the quest and take it again."] = "",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna
	["Head west to {zone:1457}. {npc:4163} is below ground in the Cenarion Enclave: the way down is the opening at the foot of the split tree left of the Arch Druid's tree, near the nightsaber trainer. Her map marker shows above ground."] = "",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {object:12360} Oracle Glade (no name in this language: may be words)
	["{npc:6909} (level 12 satyr) lives out on a great branch north of the {object:12360}: go through the V-shaped gap in the wall north of the glade and out along the branch. Pick his pocket for the journal; killing him does not give it, and a fight brings out three Minions of Sethir. He walks between the main branch and a side branch: wait stealthed at the far end of the main branch and pick him from behind when he comes back. Then Sprint away. He is back 8 1/2 minutes after a death."] = "",
	-- {item:7737} Sethir's Journal
	["Pick Pocket Sethir the Ancient for {item:7737}"] = "Обчистите карманы Сетира Древнего: {item:7737}",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "Назад: {npc:4163}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "На 10-м уровне {npc:1234}, учитель разбойников ({area:2102}, {area:131}), отправляет вас к персонажу {npc:5165} ({zone:1455}).",
	-- ["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "На 10-м уровне {npc:3599}, учитель разбойников ({area:186}), дает вам розу для персонажа {npc:4163} ({zone:1457}).",
	-- ["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "На 10-м уровне {npc:917}, учитель разбойников в таверне ({area:87}), дает вам сверток для персонажа {npc:332} ({zone:1453}).",
	-- ["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Езжайте на север: {zone:1453}. Мастер Матиас Шоу – в здании ШРУ ({object:2100}).",
	-- ["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Езжайте на запад: {zone:1457}. {npc:4163} стоит в северо-западной части города.",
	-- ["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "{npc:6846} стоит у реки на южном краю Элвиннского леса, к югу от места {area:87}. Расписание поставок – у него.",
	-- ["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165} стоит в северной части города ({zone:1455}).",
	-- ["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886} ждет рядом с местом {area:133}, на западе зоны {zone:1426}.",
	-- ["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909} живет на севере зоны {zone:1438}, к северо-востоку от города {zone:1457}. Заберите его дневник.",
	-- ["{spell:921} the {npc:6846} for the {item:7675}"] = "{spell:921}: {npc:6846} – {item:7675}",
}
