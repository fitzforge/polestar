-- Russian (ruRU): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 2: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "Мастерская Лив – в северном конце пристани ({area:392}); {object:149036} стоит внутри.",
	["Inside"] = "Внутри",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} стоит лагерем на берегу чуть к северу от места {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "Очищенную воду нужно отнести сюда: {area:2479} ({zone:1448}) – сохраните на потом.",

	-- Step 4: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Распорядитель полетов: {area:392}",

	-- Step 5: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 6: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: сохраните для края {zone:1451}",

	-- Step 7: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010} работает в Волоке.",

	-- Step 8: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1451} Silithus · {zone:2482} Mount Hyjal
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1451} guide's first stop, after {zone:2482}."] = "",

	-- Step 9: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 10: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Ориентир: {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} – здесь: {zone:1456}; в городе {zone:1454} нет учителя паладинов",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "",

	-- Step 13: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "В зону {zone:1411}",

	-- Step 14: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Дирижабль: {zone:1458}",

	-- Step 15: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, рядом с ним",

	-- Step 16: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522} стоит здесь: {object:36073}.",

	-- Step 17: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "Леди Сильвана – здесь: {object:36126}.",

	-- Step 20: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, неподалеку",

	-- Step 21: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} сдается персонажу {npc:10778} ({zone:1422}): сохраните задание.",

	-- Step 22: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "",

	-- Step 24: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}: термиты – здесь: {area:2627}, в следующем гайде",

	-- Step 26: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",

	-- Step 27: Janice Felstone
	["Upstairs"] = "Наверху",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north to {npc:8420} with the rune, then south-west along the road."] = "Возвращайтесь на север к NPC {npc:8420} с руной, затем на юго-запад по дороге.",
	-- ["Back north-west to {npc:8420}."] = "Возвращайтесь на северо-запад к NPC {npc:8420}.",
	-- ["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Вернитесь к фолианту син'дорай: вложите печати, затем используйте его, чтобы призвать NPC {npc:8578}.\nОсторожно: какой кристалл связан с Римтори – случайно. Каждый из двух других вместо этого призывает враждебного инфернала.",
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Оба пожертвования ({item:14047}) сдаются позже по маршруту: начните копить {item:14047}.",
	-- ["Crossroads flight master"] = "Распорядитель полетов на Перекрестке",
	-- ["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "У каждого из трех офицеров лагеря (53) есть печать: {npc:247006} – в центре лагеря, {npc:247013} – в его восточном конце, а {npc:246991} ходит по западной половине: атакуйте его в восточной части маршрута, куда указывает стрелка.\nОсторожно: {npc:250023}, элита 55-57 уровня, стоит у западного края лагеря, рядом с дальним концом маршрута Ястребиного Шлема: дождитесь, пока он вернется на восток.",
	-- ["Fly to the {area:380}"] = "Летите сюда: {area:380}",
	-- ["Fly to {area:1237}"] = "Летите сюда: {area:1237}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "Летите сюда: {zone:1454}; {npc:4485} – здесь: {object:172958}, {npc:3326} и {npc:8659} – здесь: {object:172960}.",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Летите сюда: {zone:1454}; {npc:4485} – здесь: {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {object:172961}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "Сохраните поручения для NPC {npc:8659}, {npc:6522}, {npc:4485} и {npc:3326}: дальше вы проходите через {zone:1454} и {zone:1458}. Задание для Магаты ({zone:1456}) не по этому маршруту: оставьте его.",
	-- ["Makrinni Burrowers"] = "Макриннские землерои",
	-- ["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Дальше на северо-восток через середину зоны {zone:1447}: {npc:235903} стоит лагерем у дороги.",
	-- ["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "Только если задание {quest:4494} еще не выполнено: {npc:7010} работает в Волоке. Пестлезугг принимает его в месте {area:976} по пути в Ун'Горо в гайде по зоне {zone:1423}.",
	-- ["Open {object:149036} for the {item:10556}"] = "Откройте {object:149036}, чтобы получить {item:10556}",
	-- ["Ride back west to {area:1237}."] = "Возвращайтесь на запад сюда: {area:1237}.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Езжайте на восток к руинам на побережье. Наполните четыре склянки Карабоса в приливных лужах вдоль берега; между ними патрулируют наги клана Бича Злобы.",
	-- ["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Езжайте на восток к руинам на побережье. Четыре скрижали лежат среди руин под охраной наг из племени Хлещущих Злобой (52-55): выманивайте по одному.",
	-- ["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Езжайте на север по дороге к Перекрестку; там стоит {npc:256386}. Открывайте каждый ящик, который она дает, и приносите ей содержимое. Затем летите с Перекрестка сюда: {area:1237}.",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Езжайте на северо-восток к лагерю гоблина на скалах над местом {area:1227}, чуть к северу от эльфов крови.",
	-- ["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Езжайте на юг к северному краю места {area:1221}. Сирены и мирмидоны из клана Бича Злобы (50-52) носят руну для NPC {npc:8420}; она падает нечасто, так что продвигайтесь вдоль края, пока не выпадет.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Лагерь Римтори – в восточной части основного лагеря. Прочтите там предмет {object:151286}, затем убейте волшебника.\nОсторожно: какой кристалл связан с Римтори, определяется случайно. Каждый из двух других вместо этого призывает враждебного инфернала.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Лагерь Римтори – в восточной части лагеря. Прочитайте там {object:151286}: на Forever лежащий рядом фолиант син'дорай затем потребует печати трех офицеров лагеря.",
	-- ["South-west along the road: {npc:235903} takes the satyrs."] = "На юго-запад по дороге: {npc:235903} принимает сатиров.",
	-- ["The Legashi satyrs"] = "Сатиры Легаши",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Сатиры Легаши (51-52) занимают холмы к северу от лагеря эльфов крови: {npc:235903} нужно по пять каждого вида.",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Макриннские землерои (50-51) роются в песках чуть к востоку от руин, по пути на северо-восток; с них и из закопанных тайников там добываются фрагменты сокровища высокорожденных.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Эльфы крови стоят лагерем на скалах на северо-востоке, у места {area:1227}.\nОсторожно: у западного края лагеря стоит {npc:250023}, элитный противник 55-57 уровня: бейте эльфов крови с восточной стороны лагеря.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Эльфы крови стоят лагерем на скалах на северо-востоке, у места {area:1227}. Четыре предмета снаряжения для {npc:8420} лежат в ящиках вокруг лагеря; у чародеев эльфов крови – жезл для {npc:247473}.\nОсторожно: у западного края лагеря стоит {npc:250023}, элитный противник 55-57 уровня: бейте эльфов крови с восточной стороны лагеря.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "Башня дирижаблей стоит чуть к северо-востоку от главных ворот ({zone:1454}); садитесь на дирижабль ({zone:1458}).",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "Башня Ксилема стоит на утесе чуть к северу от места {area:1237}: {npc:8395} ({area:1237}) бесплатно телепортирует вас наверх (поговорите с ним); иначе тропа вьется вверх по северному склону.",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221}: убивайте их по пути",
	-- ["{area:1237} flight master"] = "Распорядитель полетов: {area:1237}",
	-- ["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680} – с чародеев эльфов крови",
	-- ["{item:246721}, from {npc:246991}"] = "{item:246721}, с NPC {npc:246991}",
	-- ["{item:246722}, from {npc:247013}"] = "{item:246722}, с NPC {npc:247013}",
	-- ["{item:246725}, from {npc:247006}"] = "{item:246725}, с NPC {npc:247006}",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, в Районе Фармацевтов",
	-- ["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, сатиры к северу от лагеря эльфов крови",
	-- ["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, жезл с чародеев эльфов крови",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} стоит здесь: {area:380}. Открывайте каждый ящик, который она дает, и приносите ей содержимое.",
	-- ["{npc:256386}'s crates"] = "Ящики: {npc:256386}",
	-- ["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- ["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, для NPC {npc:4485} ({zone:1454})",
	-- ["{npc:8578}'s camp"] = "Лагерь: {npc:8578}",
	-- ["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: фолиант нужно отнести NPC {npc:3326} ({zone:1454})",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} сдается персонажу {npc:10778} ({area:28}): сохраните задание.",
	-- ["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: для NPC {npc:8587} ({area:1237})",
	-- ["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",
}
