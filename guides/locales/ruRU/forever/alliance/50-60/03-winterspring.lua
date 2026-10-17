-- Russian (ruRU): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: сохраните для места {area:2262}",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: сохраните оба для Чумных земель",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "Скачите на запад по дороге к деревне ночных эльфов.",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Руины окружают замерзшее озеро к югу от места {area:2253}. Подберите четыре фрагмента реликвий, лежащих в руинах, и светолунные перья на земле там, где бродят дикие совухи.",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Идите по дороге на запад к лагерю {npc:9298} у горячих источников.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Сохраните: Греган ({zone:1444}) позже сварит эликсир",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} охраняет вход сюда: {area:1769}, к северо-западу от {npc:9298}.",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "Лагерь Зимней Спячки",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Западный лагерь племени Зимней Спячки стоит на холмах между NPC {npc:11556} и {npc:9298}. С любого фурболга здесь может выпасть {item:12771} (примерно один из десяти) и, редко, {quest:8471}: щелкните правой кнопкой мыши по выпавшему. Сохраните {quest:6031}, который падает с фурболгов, для Мелиоша.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, редкая добыча",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, редкая добыча",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Для Кернды ({area:1769}): сохраните",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, для Мелиоша позже",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "Котел Мертвого Леса ({zone:1448}): сохраните",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Деревня фурболгов из племени Зимней Спячки лежит к востоку от места {area:2255}: шаманы (56-57), дозорные (55-56) и ведмеди (57-58), все выше вас. Сначала убивайте шаманов, они лечат, и выманивайте с краю. {npc:10738} в пещере в глубине — элитный: не заходите туда.",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Йети с Холмов ледополоха живут на холмах к югу от места {area:2244}, хладноветрые химеры — в долине по пути к месту {area:2255}.",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "Необязательно: {area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Не хватает до 54-го уровня после йети? Прохождение подземелья {area:1417} (50-54) в группе доведет вас быстрее, чем охота. После этого вернитесь сюда: {area:2255}.",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Нетронутые рога йети",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Вернитесь на холмы: рога есть только у матриархов и патриархов ледополохов. Убивайте йети до 54-го уровня: до этого задания Харло про диких совухов красные.",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "убивайте противников {npc:7460}: {area:2247}, {zone:1452}",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Взяв задание у NPC {npc:10978}, у таверны",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} и {npc:10977} будут позже",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "Скачите на запад по дороге к {npc:10301}.",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Лагерь {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Скачите на юго-восток вниз по долине к поврежденному ящику {npc:10301} в снегу ({area:2245}); его разбитая повозка — чуть восточнее.",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Припасы {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Подберите припасы вокруг повозки и заберите амулет {npc:10301} у совухов поблизости.",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Следуйте указаниям {npc:9298} ко входу сюда: {area:2256}, мимо великанов ледяного молота: проходите мимо них по одному.",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "Скачите на северо-запад обратно в деревню.",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "Бусы падают с фурболгов западного лагеря Зимней Спячки.",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Пройдите через {area:1769} в зону {zone:1448} и летите дальше в Восточные королевства ({area:442}, корабль до места {area:150}). Летите сюда: {area:271} и скачите на север по дороге через Альтеракские горы сюда: {area:3197}.",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Идите по южной дороге на восток в зону {zone:1423}; руины ({area:2262}) лежат к югу от нее. Призрак {npc:10926} играет у разрушенного дома в южной части.",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Кукла {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Три части куклы лежат в разрушенных домах ({area:2262}); если подобрать одну, могут появиться призраки. Соедините их в куклу.",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}: сохраните",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Идите по дороге на восток через всю зону к часовне.",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} — элитный противник 54-го уровня",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "С Плети вокруг места {area:2264}, к западу от часовни, падают оба вида камней Плети; из убитых поднимаются духи Дарроушира: поговорите с каждым, чтобы освободить его.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} — элитный: лучше собрать группу. Он ждет на самом дне {area:2261} — склепа на юго-западе зоны.",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Скачите на север сюда: {area:2627}. {npc:12384} живет в разрушенной хижине, а его книга расписок лежит в разрушенной таверне поблизости.",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "Следующий гайд начинается здесь и ведет полетом сюда: {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Зельдарр — элитный: лучше собрать группу. Он ждет на самом дне ({area:2261}) — склепа на юго-западе зоны.",
}
