-- Russian (ruRU): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: сохраните для края {zone:1451}",
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist · {area:1237} Valormok
	["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "",

	-- Step 2: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 3: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "Мастерская Лив – в северном конце пристани ({area:392}); {object:149036} стоит внутри.",
	["Inside"] = "Внутри",

	-- Step 4: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} стоит лагерем на берегу чуть к северу от места {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "Очищенную воду нужно отнести сюда: {area:2479} ({zone:1448}) – сохраните на потом.",

	-- Step 5: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Ящики: {npc:256386}",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "",

	-- Step 6: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Летите сюда: {area:1237}",
	["Crossroads flight master"] = "",

	-- Step 8: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Езжайте на восток к руинам на побережье. Наполните четыре склянки Карабоса в приливных лужах вдоль берега; между ними патрулируют наги клана Бича Злобы.",

	-- Step 9: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Эльфы крови стоят лагерем на скалах на северо-востоке, у места {area:1227}.",

	-- Step 10: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Лагерь: {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "",

	-- Step 11: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Возвращайтесь на запад сюда: {area:1237}.",

	-- Step 12: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 13: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 14: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "",

	-- Step 15: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Летите сюда: {zone:1454}; {npc:4485} – здесь: {object:172958}.",

	-- Step 16: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "",

	-- Step 17: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 18: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, рядом с ним",

	-- Step 19: The Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "",

	-- Step 20: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, неподалеку",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} сдается персонажу {npc:10778} ({zone:1422}): сохраните задание.",
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "",

	-- Step 22: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "",

	-- Step 24: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",
	["Upstairs"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Оба пожертвования ({item:14047}) сдаются позже по маршруту: начните копить {item:14047}.",
	-- ["Fly to the {area:380}"] = "Летите сюда: {area:380}",
	-- ["In the {object:172958}."] = "Ориентир: {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {object:172961}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Open {object:149036} for the {item:10556}"] = "Откройте {object:149036}, чтобы получить {item:10556}",
	-- ["Ride north up the road to the {area:380}; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {zone:1454} from the {area:380}."] = "Езжайте на север по дороге сюда: {area:380}; там стоит {npc:256386}. Открывайте каждый ящик, который она дает, и приносите ей содержимое. Затем летите отсюда ({area:380}) сюда: {zone:1454}.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Лагерь Римтори – в восточной части основного лагеря. Прочтите там предмет {object:151286}, затем убейте волшебника.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "Башня дирижаблей стоит чуть к северо-востоку от главных ворот ({zone:1454}); садитесь на дирижабль ({zone:1458}).",
	-- ["Zeppelin to the {zone:1458}"] = "Дирижабль: {zone:1458}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, в Районе Фармацевтов",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} стоит здесь: {area:380}. Открывайте каждый ящик, который она дает, и приносите ей содержимое.",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} сдается персонажу {npc:10778} ({area:28}): сохраните задание.",
}
