-- Russian (ruRU): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	["{npc:11556} stands right at the {zone:1452} exit of Timbermaw Hold's tunnel, where you come out."] = "",

	-- Step 4: Everlook
	["Everlook"] = "",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- {npc:11629} Jessica Redpath
	["{npc:11629}: keep it for Darrowshire; inside"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "",
	-- {npc:11754} Meggi Peppinrocker
	["{npc:11754} walks around Everlook: look inside the circle on the map"] = "",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "{item:12383}, 110 м к северу",

	-- Step 6: Ice Thistle Hills: kill these as you meet them
	["Ice Thistle Hills: kill these as you meet them"] = "",
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of Winterfall Village, Chillwind Chimaeras in the valley toward Everlook."] = "",

	-- Step 7: The Ruins of Kel'Theril
	-- {object:177132} Starfall Village (no name in this language: may be words)
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {object:177132}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "",

	-- Step 8: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Идите по дороге на запад к лагерю {npc:9298} у горячих источников.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Сохраните: Греган ({zone:1444}) позже сварит эликсир",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	["Frostfire Hot Springs: kill these as you meet them"] = "",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Западный лагерь племени Зимней Спячки стоит на холмах между NPC {npc:11556} и {npc:9298}. С любого фурболга здесь может выпасть {item:12771} (примерно один из десяти) и, редко, {quest:8471}: щелкните правой кнопкой мыши по выпавшему. Сохраните {quest:6031}, который падает с фурболгов, для Мелиоша.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, редкая добыча",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, для Мелиоша позже",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, редкая добыча",
	["For Kernda in Timbermaw Hold: keep it"] = "",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Котел Мертвого Леса ({zone:1448}): сохраните",

	-- Step 11: Level 55.05
	["Level 55.05"] = "",
	["Top up here to level 55.05 before the hand-ins at Everlook: they take you to level 56. Grind the Winterfall furbolgs camped by Frostfire Hot Springs (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through Timbermaw Hold need. Or, with a group, run the Blackrock Depths dungeon or the Blackrock Spire dungeon (Lower) instead."] = "",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "",

	-- Step 13: Winterfall Village
	["Winterfall Village"] = "",
	-- {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of Everlook: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "",

	-- Step 14: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Нетронутые рога йети",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "",

	-- Step 15: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Взяв задание у NPC {npc:10978}, у таверны",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} и {npc:10977} будут позже",

	-- Step 17: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	["Everlook flight master"] = "",

	-- Step 18: Boat to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Boat to {object:1162}"] = "",

	-- Step 19: Fly to Southshore
	["Fly to Southshore"] = "",
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["{object:1162} flight master"] = "",

	-- Step 21: Chillwind Camp
	["Chillwind Camp"] = "",
	["From Southshore, ride north up the road through Alterac to Chillwind Camp."] = "",
	-- {npc:11616} Nathaniel Dumah
	["{npc:11616}: the termites come later, in Terrordale"] = "",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "",
	-- {npc:11053} High Priestess MacDonnell
	["{npc:11053}: the cauldron is at Dalson's Tears, keep it"] = "",

	-- Step 22: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the Writhing Haunt, on the road east to the {zone:1423}."] = "",
	["Inside"] = "Внутри",

	-- Step 23: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 25: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of Darrowshire lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 26: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Кукла {npc:10926}",
	["The three pieces of the doll lie in the ruined houses of Darrowshire; picking one up can call out ghosts. Combine them into the doll."] = "",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 27: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}: сохраните",

	-- Step 28: Light's Hope Chapel
	["Light's Hope Chapel"] = "",
	["Follow the road east across the zone to the chapel."] = "Идите по дороге на восток через всю зону к часовне.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "",

	-- Step 29: Corin's Crossing
	-- {object:176970} Corin's Crossing (no name in this language: may be words)
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {object:176970}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",

	-- Step 30: The Undercroft
	["The Undercroft"] = "",
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the Undercroft, the crypt in the south-west of the zone."] = "",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "",

	-- Step 31: Browman Mill: kill these as you meet them
	["Browman Mill: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 32: Light's Hope Chapel
	["The next guide starts here and flies to Chillwind Camp."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Вернитесь на холмы: рога есть только у матриархов и патриархов ледополохов. Убивайте йети до 54-го уровня: до этого задания Харло про диких совухов красные.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Идите по южной дороге на восток в зону {zone:1423}; руины ({area:2262}) лежат к югу от нее. Призрак {npc:10926} играет у разрушенного дома в южной части.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Следуйте указаниям {npc:9298} ко входу сюда: {area:2256}, мимо великанов ледяного молота: проходите мимо них по одному.",
	-- ["For Kernda in {area:1769}: keep it"] = "Для Кернды ({area:1769}): сохраните",
	-- ["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "Отсюда: {area:271} скачите на север по дороге через Альтеракские горы сюда: {area:3197}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Йети с Холмов ледополоха живут на холмах к югу от места {area:2244}, хладноветрые химеры — в долине по пути к месту {area:2255}.",
	-- ["Optional: {area:1417}"] = "Необязательно: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Подберите припасы вокруг повозки и заберите амулет {npc:10301} у совухов поблизости.",
	-- ["Pristine Yeti Horns"] = "Нетронутые рога йети",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Скачите на север сюда: {area:2627}. {npc:12384} живет в разрушенной хижине, а его книга расписок лежит в разрушенной таверне поблизости.",
	-- ["Ride north-west back to the village."] = "Скачите на северо-запад обратно в деревню.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Скачите на юго-восток вниз по долине к поврежденному ящику {npc:10301} в снегу ({area:2245}); его разбитая повозка — чуть восточнее.",
	-- ["Ride west along the road to the night elf village."] = "Скачите на запад по дороге к деревне ночных эльфов.",
	-- ["Ride west along the road to {npc:10301}."] = "Скачите на запад по дороге к {npc:10301}.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Не хватает до 54-го уровня после йети? Прохождение подземелья {area:1417} (50-54) в группе доведет вас быстрее, чем охота. После этого вернитесь сюда: {area:2255}.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "С Плети вокруг места {area:2264}, к западу от часовни, падают оба вида камней Плети; из убитых поднимаются духи Дарроушира: поговорите с каждым, чтобы освободить его.",
	-- ["The Winterfall camp"] = "Лагерь Зимней Спячки",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Деревня фурболгов из племени Зимней Спячки лежит к востоку от места {area:2255}: шаманы (56-57), дозорные (55-56) и ведмеди (57-58), все выше вас. Сначала убивайте шаманов, они лечат, и выманивайте с краю. {npc:10738} в пещере в глубине — элитный: не заходите туда.",
	-- ["The next guide starts here and flies to {area:3197}."] = "Следующий гайд начинается здесь и ведет полетом сюда: {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Руины окружают замерзшее озеро к югу от места {area:2253}. Подберите четыре фрагмента реликвий, лежащих в руинах, и светолунные перья на земле там, где бродят дикие совухи.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Три части куклы лежат в разрушенных домах ({area:2262}); если подобрать одну, могут появиться призраки. Соедините их в куклу.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Бусы падают с фурболгов западного лагеря Зимней Спячки.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Пройдите через {area:1769} в зону {zone:1448} и летите дальше в Восточные королевства ({area:442}, корабль до места {area:150}). Летите сюда: {area:271} и скачите на север по дороге через Альтеракские горы сюда: {area:3197}.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Зельдарр — элитный: лучше собрать группу. Он ждет на самом дне ({area:2261}) — склепа на юго-западе зоны.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "убивайте противников {npc:7460}: {area:2247}, {zone:1452}",
	-- ["{npc:10301}'s camp"] = "Лагерь {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Припасы {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: сохраните оба для Чумных земель",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} — элитный противник 54-го уровня",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} охраняет вход сюда: {area:1769}, к северо-западу от {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: сохраните для места {area:2262}",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} — элитный: лучше собрать группу. Он ждет на самом дне {area:2261} — склепа на юго-западе зоны.",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}: сохраните",
}
