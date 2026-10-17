-- Russian (ruRU): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {zone:1429} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Корабль из места {area:442} причаливает здесь: {area:17203}. Поднимитесь в город за обучением и к NPC {npc:1646}, затем выйдите через главные ворота и идите по дороге на восток через зону {zone:1429}.",
	["Level 18 and 20 spells"] = "Заклинания 18-го и 20-го уровней",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: письмо Тандриса из места {area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Для NPC {npc:3649}, по возвращении в {area:442} (06-ashenvale)",

	-- Step 2: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "В городе {zone:1453} нет учителя шаманов: сядьте на поезд ({area:2257}) в месте {object:28027} до города {zone:1455}, обучитесь у NPC {npc:258098}, затем вернитесь на поезде.",

	-- Step 3: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "Классовые задания: {zone:1453}",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} находится в ШРУ ({object:2100}), {npc:6122} — в подвале здания {object:2164} ({object:2101}), {npc:376} — в Соборе Света.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: сдается NPC {npc:7024} ({zone:1436}), в конце зоны {zone:1431}",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: сдается NPC {npc:6244} ({zone:1413}), позже",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: сдается NPC {npc:11406} ({zone:1455}), позже",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: сдается NPC {npc:258785} ({zone:1455}), позже",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: сдается NPC {npc:11401} ({zone:1457}), позже",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Летите сюда: {area:108}. Скачите на северо-запад к побережью: {object:177790} лежит на морском дне недалеко от берега. Затем скачите на восток по дороге через Элвиннский лес в Красногорье.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 5: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "Дорога из Элвиннского леса входит в Красногорье здесь: {area:1002}. {npc:464} стоит там, где сходятся дороги в Красногорье и в зону {zone:1431}.",

	-- Step 6: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Идите по дороге вдоль южного берега озера ({area:68}) к распорядителю полетов. {npc:1070} и {npc:903} стоят у дороги рядом с ней.",

	-- Step 7: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Перейдите по длинному мосту на север в город. {npc:341} и {npc:382} стоят у северного конца моста, {npc:900} — в ратуше, {npc:381} и {npc:266} — на пристани, {npc:343} — в таверне, {npc:342} — в своем огороде в западной части.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks"] = "{npc:266}, у пристани",

	-- Step 8: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Плывите от моста на восток ({area:68}); сундук лежит на дне озера.",

	-- Step 9: Gnolls toward Three Corners
	-- {area:1002} Three Corners
	["Gnolls toward {area:1002}"] = "Гноллы по пути к месту {area:1002}",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Полукровки из стаи Красногорья и другие гноллы удерживают холмы к востоку от места {area:1002}, к северу от дороги; между ними бродят твердозубы из стаи Красногорья, а браконьеры стоят лагерем к югу от дороги. По тем же холмам бродят ужасающие кондоры и большие жутевепри.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: твердозубы из стаи Красногорья",

	-- Step 10: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire
	["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (уровень 24) роется в загоне чуть западнее места {area:69}. Выманите его от других кабанов и сражайтесь с полным здоровьем.",

	-- Step 12: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341}: после задания {quest:89}",
	-- {npc:703} Lieutenant Fangore · {area:1000} Galardell Valley
	["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "Объявление о розыске у таверны: {npc:703}, {area:1000}",

	-- Step 13: Lake murlocs
	["Lake murlocs"] = "Озерные мурлоки",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Мурлоки-трупоеды и мурлоки-волномуты стоят вдоль южного берега к востоку от моста. У любого из них может оказаться {item:1467} или плавник.",

	-- Step 14: Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Blackrock Renegades = {npc:437} Blackrock Renegade
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Крупные тарантулы ползают по склонам вокруг лесопилки к северо-востоку от озера; перебежчики из клана Черной Горы удерживают саму лесопилку.",
	-- {item:3014} Battleworn Axe
	-- plural, as words: Blackrock Renegades = {npc:437} Blackrock Renegade
	["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: перебежчики из клана Черной Горы на мельнице",

	-- Step 15: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "На восток мимо лесопилки и через реку. Долина полна гноллов из стаи Темношкуров; {npc:703} (26, намного выше вас) возглавляет их в северной части: сначала перебейте его свиту и сражайтесь с ним с полным здоровьем. Не заходите в {area:2099} на юге: там элитные орки.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: любой гнолл из стаи Темношкуров",

	-- Step 16: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Обратно: {area:69}",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, в ратуше",

	-- Step 17: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Идите на север из места {area:69} вверх через {area:95} сюда: {area:997}. В долине стоят лагерем воители из клана Черной Горы.",

	-- Step 18: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Кеешан прячется в самом северном конце долины, у границы зоны {zone:1428}. Проводите его вниз до места {area:69}; по пути на вас нападут орки клана Черной Горы.",

	-- Step 19: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, у грифонов к югу от моста",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Далее — {zone:1431}: идите по дороге на запад до места {area:1002}, затем на юг сюда: {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Грубобрюх",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: любой орк клана Черной Горы",
}
