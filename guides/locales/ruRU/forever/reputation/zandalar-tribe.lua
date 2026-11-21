-- Russian (ruRU): the guide forever/reputation/zandalar-tribe (forever/reputation/zandalar-tribe.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Zandalar Tribe Reputation"] = "Репутация: племя Зандалар",
	-- {area:19} Zul'Gurub
	["Shoulder and head enchants, a class necklace upgraded at every standing, and {area:19}'s set pieces."] = "Чары для плеч и головы, классовое ожерелье, улучшаемое на каждом уровне репутации, и предметы комплектов из {area:19}.",
	["Your class's necklace at Friendly, upgraded at Honored, Revered and Exalted"] = "Классовое ожерелье при дружелюбии, улучшается при уважении, почтении и превознесении",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s head and leg enchants, from Friendly"] = "Чары для головы и ног у NPC {npc:15042}, с дружелюбия",

	-- Step 1: Yojamba Isle
	-- {area:3357} Yojamba Isle · {zone:1434} Stranglethorn Vale · {area:122} Zuuldaia Ruins · {faction:270} Zandalar Tribe · {npc:15070} Vinchaxa · {npc:14921} Rin'wosho the Trader · {npc:14902} Jin'rokh the Breaker · {npc:14903} Al'tabim the All-Seeing · {npc:14904} Maywiki of Zuldazar · {npc:14905} Falthir the Sightless · {area:19} Zul'Gurub
	["{area:3357} is the small island off the north-west coast of {zone:1434}, west of the {area:122}: swim over from the coast. Everyone starts Neutral with the {faction:270}. {npc:15070} takes coins and bijous, {npc:14921} sells the recipes and trades Honor Tokens, and {npc:14902}, {npc:14903}, {npc:14904} and {npc:14905} hand out the class necklaces and the set pieces. Almost all Zandalar reputation comes from {area:19}, a 20-player raid, and {area:19} is not among the first raids Blizzard has announced for Forever: until it opens there is no Zandalar reputation to earn, and no coins or bijous on the auction house either. Once it is open, the only solo way is buying coins and bijous on the auction house (75 per bijou, 25 per set of three coins). The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3357} — маленький остров у северо-западного побережья {zone:1434}, западнее {area:122}: доплывите от берега. У всех {faction:270} начинается с Равнодушия. {npc:15070} принимает монеты и биджо, {npc:14921} продаёт рецепты и обменивает Жетоны чести, а {npc:14902}, {npc:14903}, {npc:14904} и {npc:14905} выдают ожерелья классов и элементы комплекта. Почти вся репутация племени Зандалар идёт из {area:19}, рейда на 20 игроков, а {area:19} не входит в число первых рейдов, объявленных Blizzard для Forever: пока он не открыт, репутацию Зандалара не заработать, и на аукционе тоже нет монет и биджо. Когда он откроется, единственный способ в одиночку — покупать монеты и биджо на аукционе (75 за биджо, 25 за три монеты). Способность «Дипломат» добавляет до 10% к каждому приросту; числа в этом гайде — без неё.",

	-- Step 2: Zul'Gurub to Friendly
	-- {area:19} Zul'Gurub
	["{area:19} to Friendly"] = "{area:19}: до Дружелюбия",
	-- {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale · {area:3398} Edge of Madness · {npc:15114} Gahz'ranka · {npc:11382} Bloodlord Mandokir · {item:22637} Primal Hakkari Idol · {item:19881} Channeler's Head · {quest:8240} A Bijou for Zanza
	["{area:19} is the troll city in the north-east of {zone:1434}: a 20-player raid. Trash pays 3 to 5 each until 11,999 of 12,000 Honored, one point short of Revered; the Speakers 15, Ohgan 15, the {area:3398} boss 25, {npc:15114} and the five High Priests 100, {npc:11382} and Jin'do 200 and Hakkar 400, all the way to Exalted. A full clear is about 4,050: one clear reaches Friendly (3,000). Loot every coin, bijou, {item:22637}, {item:19881} and Primal Hakkari set piece. Coins and bijous pay the same at any standing: save them until the trash stops counting, except one bijou for {quest:8240}."] = "{area:19} — город троллей на северо-востоке {zone:1434}: рейд на 20 игроков. Рядовые мобы дают от 3 до 5 до 11 999 из 12 000 Уважения, на очко меньше Почтения; Глашатаи 15, Огхан 15, босс {area:3398} 25, {npc:15114} и пять Верховных жрецов 100, {npc:11382} и Джин'до 200, а Хаккар 400 — вплоть до Превознесения. Полное зачищение — около 4 050: одного хватает на Дружелюбие (3 000). Собирайте все монеты, биджо, {item:22637}, {item:19881} и элементы комплекта Изначального Хаккари. Монеты и биджо дают одинаково на любом уровне: берегите их, пока рядовые мобы не перестанут считаться, кроме одного биджо для {quest:8240}.",
	-- {item:19707} Red Hakkari Bijou
	["{item:19707}; any of the nine colours does"] = "{item:19707}; подойдёт любой из девяти цветов",

	-- Step 3: A Bijou for Zanza
	-- {object:180367} Altar of Zanza · {area:3357} Yojamba Isle · {npc:15070} Vinchaxa · {item:19858} Zandalar Honor Token
	["Destroy one bijou at the {object:180367}, the stone altar on the west side of {area:3357} (right-click the bijou there), then tell {npc:15070}: 150 reputation and an extra {item:19858}, once. From then on every bijou you destroy at the altar pays 75 reputation and a token, and every set of three coins {npc:15070} takes pays 25 and a token. They never stop counting."] = "Уничтожьте одно биджо у {object:180367}, каменного алтаря на западной стороне {area:3357} (нажмите правой кнопкой на биджо там), затем скажите {npc:15070}: 150 репутации и дополнительный {item:19858}, один раз. С этого момента каждое биджо, уничтоженное у алтаря, даёт 75 репутации и жетон, а каждые три монеты, принятые {npc:15070}, дают 25 и жетон. Они не перестают считаться.",

	-- Step 4: Friendly: your class necklace
	["Friendly: your class necklace"] = "Дружелюбие: ожерелье вашего класса",
	-- {item:19766} Pattern: Bloodvine Boots · {item:19687} Primal Batskin Bracers · {item:19778} Plans: Bloodsoul Gauntlets · {item:19695} Darksoul Shoulders · {item:20001} Schematic: Bloodvine Lens · {item:20012} Recipe: Greater Dreamless Sleep · {item:20757} Formula: Brilliant Mana Oil
	["At Friendly your class's trainer on the isle gives a necklace for free (100 reputation); the same NPC upgrades it at Honored, Revered and Exalted (100 each) with no raid item needed. Friendly also opens Rin'wosho's first recipes ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012}, 5g each; {item:20757}, 4g) and the Paragons of Power bracers (150 for the Primal Hakkari bracer token of your class)."] = "На Дружелюбии наставник вашего класса на острове даёт ожерелье бесплатно (100 репутации); тот же NPC улучшает его на Уважении, Почтении и Превознесении (по 100) без предметов из рейда. Дружелюбие также открывает первые рецепты Рин'вошо ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012} по 5 з; {item:20757}, 4 з) и наручи Воплощений Силы (150 за жетон наручей Изначального Хаккари вашего класса).",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Friendly"] = "{npc:14902}: {item:19574}, Дружелюбие",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Friendly"] = "{npc:14902}: {item:19579}, Дружелюбие",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Friendly"] = "{npc:14903}: {quest:8049}, Дружелюбие",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Friendly"] = "{npc:14903}: {item:19598}, Дружелюбие",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Friendly"] = "{npc:14903}: {quest:8106}, Дружелюбие",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Friendly"] = "{npc:14904}: {quest:8110}, Дружелюбие",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Friendly"] = "{npc:14904}: {quest:8116}, Дружелюбие",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Friendly"] = "{npc:14905}: {quest:8141}, Дружелюбие",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Friendly"] = "{npc:14905}: {item:19618}, Дружелюбие",

	-- Step 5: Zanza the Restless's enchants, from Friendly
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s enchants, from Friendly"] = "Зачарования {npc:15042}, с Дружелюбия",
	-- {npc:15042} Zanza the Restless · {area:19} Zul'Gurub · {item:22637} Primal Hakkari Idol · {npc:11380} Jin'do the Hexxer · {npc:11382} Bloodlord Mandokir · {item:19813} Punctured Voodoo Doll
	-- plural, as words: Jinxed Hoodoo Piles = {object:180228} Jinxed Hoodoo Pile
	["{npc:15042}, a spirit just inside {area:19}'s entrance, trades your class's head and leg enchant for a {item:22637} ({npc:11380} or {npc:11382}, about 90%) and your class's {item:19813} (the Jinxed Hoodoo Piles scattered through {area:19}, now and then from its trash): 100 reputation each, as often as you like."] = "{npc:15042}, дух сразу за входом в {area:19}, обменивает зачарование на голову и ноги вашего класса на {item:22637} ({npc:11380} или {npc:11382}, около 90%) и ваш {item:19813} класса (Груды зачарованных худу, разбросанные по {area:19}, иногда с рядовых мобов): по 100 репутации, сколько угодно раз.",
	-- {item:22637} Primal Hakkari Idol
	["{item:22637}, Jin'do or Mandokir"] = "{item:22637}, Джин'до или Мандокир",
	-- {item:19813} Punctured Voodoo Doll
	["your class's {item:19813}"] = "ваш {item:19813} класса",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}: idol and doll, 100"] = "{npc:15042}: идол и кукла, 100",

	-- Step 6: Zul'Gurub to Honored
	-- {area:19} Zul'Gurub
	["{area:19} to Honored"] = "{area:19}: до Уважения",
	-- {item:19683} Bloodvine Leggings · {item:19686} Primal Batskin Gloves · {item:19689} Blood Tiger Shoulders · {item:19691} Bloodsoul Shoulders · {item:19694} Darksoul Leggings · {item:20004} Major Troll's Blood Elixir · {item:20000} Schematic: Bloodvine Goggles · {item:20756} Formula: Brilliant Wizard Oil · {item:232611} Magnificent Trollshine · {quest:8196} Essence Mangoes · {item:22635} Savage Guard
	["Friendly to Honored is 6,000: one and a half clears. Honored opens {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} and {item:20004} (5g each), {item:20000} (12g), {item:20756} (4g) and {item:232611} (4g), the Paragons of Power belts and mantles (150 each), {quest:8196} (one Honor Token) and The {item:22635}."] = "От Дружелюбия до Уважения 6 000: полтора зачищения. Уважение открывает {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} и {item:20004} (по 5 з), {item:20000} (12 з), {item:20756} (4 з) и {item:232611} (4 з), пояса и наплечники Воплощений Силы (по 150), {quest:8196} (один Жетон чести) и {item:22635}.",

	-- Step 7: Honored: necklace, Savage Guard and mangoes
	-- {item:22635} Savage Guard
	["Honored: necklace, {item:22635} and mangoes"] = "Уважение: ожерелье, {item:22635} и манго",
	-- {npc:15042} Zanza the Restless · {item:18331} Arcanum of Protection · {item:22635} Savage Guard · {npc:14368} Lorekeeper Lydros · {area:2577} Dire Maul · {item:18335} Pristine Black Diamond · {item:12735} Frayed Abomination Stitching · {item:12938} Blood of Heroes · {item:12753} Skin of Shadow · {npc:14921} Rin'wosho the Trader · {quest:8196} Essence Mangoes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["{npc:15042} takes an {item:18331}, Rapidity or Focus for the {item:22635} head and leg enchant: 200 reputation each, again and again. The Arcanum binds to you, so it never sells: {npc:14368} in the library of {area:2577} makes it from the matching Libram ({area:2577} drops, and on the auction house), a {item:18335} and Large Brilliant Shards, plus {item:12735}, two {item:12938} or two {item:12753}. {npc:14921} trades {quest:8196} for an Honor Token."] = "{npc:15042} берёт {item:18331}, Стремительность или Сосредоточение за зачарование {item:22635} на голову и ноги: по 200 репутации, снова и снова. Аркан привязывается к вам, поэтому никогда не продаётся: {npc:14368} в библиотеке {area:2577} делает его из подходящего либрама (падает в {area:2577} и на аукционе), {item:18335} и больших сверкающих осколков, плюс {item:12735}, два {item:12938} или два {item:12753}. {npc:14921} обменивает {quest:8196} на Жетон чести.",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Honored"] = "{npc:14902}: {item:19574}, Уважение",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Honored"] = "{npc:14902}: {item:19579}, Уважение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Honored"] = "{npc:14903}: {quest:8049}, Уважение",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Honored"] = "{npc:14903}: {item:19598}, Уважение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Honored"] = "{npc:14903}: {quest:8106}, Уважение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Honored"] = "{npc:14904}: {quest:8110}, Уважение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Honored"] = "{npc:14904}: {quest:8116}, Уважение",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Honored"] = "{npc:14905}: {quest:8141}, Уважение",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Honored"] = "{npc:14905}: {item:19618}, Уважение",
	-- {quest:8196} Essence Mangoes · {item:19858} Zandalar Honor Token
	["{quest:8196}: one {item:19858}"] = "{quest:8196}: один {item:19858}",

	-- Step 8: Zul'Gurub to Revered
	-- {area:19} Zul'Gurub
	["{area:19} to Revered"] = "{area:19}: до Почтения",
	-- {quest:8201} A Collection of Heads · {npc:14910} Exzhal · {item:19883} Sacred Cord · {quest:8183} The Heart of Hakkar · {npc:14875} Molthor · {item:19682} Bloodvine Vest · {item:19685} Primal Batskin Jerkin · {item:19688} Blood Tiger Breastplate · {item:19690} Bloodsoul Breastplate · {item:19693} Darksoul Breastplate · {item:20007} Mageblood Elixir · {quest:8243} Zanza's Potent Potables
	-- plural, as words: Channeler's Heads = {item:19881} Channeler's Head
	["Honored to Revered is 12,000: about three clears. Two one-time quests help: {quest:8201} ({npc:14910} on the isle: 200 for five Channeler's Heads from the High Priests, strung on his {item:19883}) and {quest:8183} (one per kill, for whoever loots it; {npc:14875} on the isle pays 200 and a Zandalarian Hero badge, charm or medallion). Revered opens {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} and {item:20007} (5g each), the Paragons of Power chests and mantles (150) and {quest:8243}."] = "От Уважения до Почтения 12 000: около трёх зачищений. Помогают два одноразовых задания: {quest:8201} ({npc:14910} на острове: 200 за пять голов орков-крушителей с Верховных жрецов, нанизанных на его {item:19883}) и {quest:8183} (одно на убийство, тому, кто его подобрал; {npc:14875} на острове платит 200 и значок, оберег или медальон героя Зандалара). Почтение открывает {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} и {item:20007} (по 5 з), нагрудники и наплечники Воплощений Силы (150) и {quest:8243}.",

	-- Step 9: Revered: necklace, coins and bijous
	["Revered: necklace, coins and bijous"] = "Почтение: ожерелье, монеты и биджо",
	-- {npc:15042} Zanza the Restless · {item:22635} Savage Guard · {item:20081} Swiftness of Zanza
	["Trash stopped counting at 11,999 Honored. Revered to Exalted is 21,000: bosses give about 1,350 a clear, and now the saved coins and bijous pay: 75 per bijou (280 bijous alone), 25 per coin set. Coins and bijous are tradeable, so the auction house is the only solo way. Each Paragons piece pays 150, each {npc:15042} enchant 100, each {item:22635} 200. Rin'wosho trades one of {npc:15042}'s potables (Spirit, Sheen or {item:20081}) for an Honor Token."] = "Рядовые мобы перестали считаться на 11 999 Уважения. От Почтения до Превознесения 21 000: боссы дают около 1 350 за зачищение, и теперь бережённые монеты и биджо считаются: 75 за биджо (только биджо — 280), 25 за набор монет. Монеты и биджо передаются, поэтому аукцион — единственный способ в одиночку. Каждый элемент Воплощений даёт 150, каждое зачарование {npc:15042} — 100, каждый {item:22635} — 200. Рин'вошо обменивает один напиток {npc:15042} (Дух, Блеск или {item:20081}) на Жетон чести.",
	-- {npc:14902} Jin'rokh the Breaker · {item:19575} Strength of Mugamba
	["{npc:14902}: {item:19575}, Revered"] = "{npc:14902}: {item:19575}, Почтение",
	-- {npc:14902} Jin'rokh the Breaker · {item:19585} Heathen's Brand
	["{npc:14902}: {item:19585}, Revered"] = "{npc:14902}: {item:19585}, Почтение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8050} The Eye of Zuldazar
	["{npc:14903}: {quest:8050}, Revered"] = "{npc:14903}: {quest:8050}, Почтение",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19599} Pebble of Kajaro
	["{npc:14903}: {item:19599}, Revered"] = "{npc:14903}: {item:19599}, Почтение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8107} Kezan's Taint
	["{npc:14903}: {quest:8107}, Revered"] = "{npc:14903}: {quest:8107}, Почтение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8111} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8111}, Revered"] = "{npc:14904}: {quest:8111}, Почтение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8117} Vision of Voodress
	["{npc:14904}: {quest:8117}, Revered"] = "{npc:14904}: {quest:8117}, Почтение",
	-- {npc:14905} Falthir the Sightless · {quest:8142} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8142}, Revered"] = "{npc:14905}: {quest:8142}, Почтение",
	-- {npc:14905} Falthir the Sightless · {item:19619} Maelstrom's Tendril
	["{npc:14905}: {item:19619}, Revered"] = "{npc:14905}: {item:19619}, Почтение",
	-- {npc:15070} Vinchaxa
	["{npc:15070}: 3 coins, 25 and a token"] = "{npc:15070}: 3 монеты, 25 и жетон",
	["25 and a token"] = "25 и жетон",
	-- {quest:8243} Zanza's Potent Potables
	["{quest:8243}: one token"] = "{quest:8243}: один жетон",

	-- Step 10: Exalted: the Signets of the Zandalar
	-- {quest:8246} Signets of the Zandalar
	["Exalted: the {quest:8246}"] = "Превознесение: {quest:8246}",
	-- {item:20013} Recipe: Living Action Potion
	-- plural, as words: Zandalar Honor Tokens = {item:19858} Zandalar Honor Token
	["At Exalted your necklace takes its last upgrade, Rin'wosho sells {item:20013} (5g), and Rin'wosho trades 15 Zandalar Honor Tokens for one Signet of the Zandalar, the shoulder enchant: Might (attack power), Mojo (spell damage) or Serenity (healing)."] = "На Превознесении ожерелье получает последнее улучшение, Рин'вошо продаёт {item:20013} (5 з), а Рин'вошо обменивает 15 почетных знаков Зандалара на Печатку Зандалара, зачарование на плечи: Мощь (сила атаки), Моджо (урон от заклинаний) или Безмятежность (исцеление).",
	-- {npc:14902} Jin'rokh the Breaker · {item:19576} Strength of Mugamba
	["{npc:14902}: {item:19576}, Exalted"] = "{npc:14902}: {item:19576}, Превознесение",
	-- {npc:14902} Jin'rokh the Breaker · {item:19586} Heathen's Brand
	["{npc:14902}: {item:19586}, Exalted"] = "{npc:14902}: {item:19586}, Превознесение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8051} The Eye of Zuldazar
	["{npc:14903}: {quest:8051}, Exalted"] = "{npc:14903}: {quest:8051}, Превознесение",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19600} Pebble of Kajaro
	["{npc:14903}: {item:19600}, Exalted"] = "{npc:14903}: {item:19600}, Превознесение",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8108} Kezan's Taint
	["{npc:14903}: {quest:8108}, Exalted"] = "{npc:14903}: {quest:8108}, Превознесение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8112} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8112}, Exalted"] = "{npc:14904}: {quest:8112}, Превознесение",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8118} Vision of Voodress
	["{npc:14904}: {quest:8118}, Exalted"] = "{npc:14904}: {quest:8118}, Превознесение",
	-- {npc:14905} Falthir the Sightless · {quest:8143} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8143}, Exalted"] = "{npc:14905}: {quest:8143}, Превознесение",
	-- {npc:14905} Falthir the Sightless · {item:19620} Maelstrom's Tendril
	["{npc:14905}: {item:19620}, Exalted"] = "{npc:14905}: {item:19620}, Превознесение",
	-- {quest:8246} Signets of the Zandalar
	["{quest:8246}: 15 Honor Tokens"] = "{quest:8246}: 15 Жетонов чести",
}
