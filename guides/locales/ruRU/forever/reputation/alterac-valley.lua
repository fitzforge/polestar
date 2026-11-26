-- Russian (ruRU): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Репутация: Альтеракская долина",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "Разовые задания на 2000 очков и крупные победы делают эту репутацию самой быстрой из четырех; «Превознесение» дает очко наследия.",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "Мастер Альтеракской долины: очко наследия за «Превознесение»",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} — бой 40 на 40 для уровней с 51-го и самая быстрая из четырёх репутаций полей боя: в ней около 2 000 репутации от одноразовых заданий, а полная победа платит несколько сотен. Те же одноразовые задания дают ещё 1 870 репутации {zone:1455}. {npc:13843} вербует у {object:32372}. Талант наследия Forever Дипломат добавляет до 10% к каждому числу в этом гайде.",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "Лагерь Громового Копья стоит у ворот {zone:1459}, на стороне {zone:1416} над {area:287}. Возьмите здесь все задания: они все платят 100 или больше, один раз.",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}: {item:17849} в {area:3058}, 100",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}: захватите кладбище, 100",
	["destroy a tower or bunker banner, 100"] = "уничтожьте знамя башни или бункера, 100",
	["capture a mine, 100"] = "захватите шахту, 100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "Встаньте в очередь у ворот, у любого боевого магистра или через экран полей боя; вы входите в {area:2959} на севере. Пока ворота закрыты, возьмите задания в городе: они выполняются во время боя.",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058} лежит юго-западнее {area:2959}. {item:17849} стоит в глубине пещеры, за йети и гарпиями.",

	-- Step 5: The battle
	["The battle"] = "Бой",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "Большая часть происходит по пути к {npc:11946}. Соберите {quest:7223} с игроков Орды и стражников, которых вы убили. Захватите {area:3301} или любое кладбище Орды, сожгите башню Орды (нажмите на её знамя) и возьмите {area:2963}. {npc:13154} стоит в {area:2962}; {npc:13597} — в {area:2961}. {quest:7301} просит найти, где высадились три командира крыльев. В классике каждая башня, кладбище или шахта давали 12 репутации, {npc:11947} — 125, а {npc:11946} — около 300.",
	["assault a graveyard"] = "захватите кладбище",
	["Iceblood Tower banner"] = "знамя башни Ледяной Крови",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "место {npc:13437}",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "место {npc:13439}",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "место {npc:13438}",

	-- Step 6: Back in Dun Baldar
	-- {area:2959} Dun Baldar
	["Back in {area:2959}"] = "Обратно в {area:2959}",

	-- Step 7: Back at the gate
	["Back at the gate"] = "Обратно у ворот",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Первые знаки почёта Долины Альтерак несите {npc:15351} рядом с {npc:13841}: 150 в первый раз ({quest:8375}), затем 100 за каждые ещё 3. Экипировка PvP в Forever тоже стоит знаки почёта вместе с честью: решите, что вы хотите, до сдачи. С собой можно нести не больше 30 знаков {zone:1459}: сдайте или потратьте их, прежде чем достигнуть этого.",
	["Alterac Valley Marks of Honor: play games"] = "Знаки почёта Долины Альтерак: играйте матчи",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} до уровня «Дружелюбие»",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "{npc:13816} у ворот хочет, чтобы {npc:11946} погиб: выиграйте матч, в котором ваша команда убьёт его. Тогда он даёт вам выбрать оружие ({quest:8271}).",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}, 10 и оружие",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "«Дружелюбие» позволяет {npc:13841} улучшить ваш знак различия: 100 репутации. От «Дружелюбия» до «Уважения» — 6000 репутации. В классике полная победа платила 300–700 вместе с 3 знаками; бригадный генерал продолжает брать 3 знака за 100. Внутри {item:17354} (75, из пещер Зимокогтя) повторяется каждый матч; {npc:12159} (200, когда он появляется посреди долины) возвращается к {npc:13841} сюда. «Дружелюбие» открывает {item:19032} (1 з) и улучшенные напитки лечения и маны (5 с) у {npc:13217} рядом с ним.",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}, 1 з",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}: {quest:8375} снова, 100 за 3 знака",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "«Уважение»: знак различия 3-го ранга, 100 репутации. От «Уважения» до «Почтения» — 12000 репутации. {npc:13217} рядом с {npc:13841} продаёт плащи и подвески солдата и книжника Громового Копья (около 7 з каждый), пояса Громового Копья (4з74с – 7з12с) и мощные напитки лечения и маны (10 с).",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}: 100 за 3 знака",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "«Почтение»: знак различия 4-го ранга, 150 репутации. От «Почтения» до «Превознесения» — 21000 репутации, половина пути. «Почтение» открывает оружие у {npc:13217}: {item:19100}, {item:19102} и {item:19104} (31з65с – 39з85с), и {npc:14752} (5 з). С 51-го уровня «Общие усилия» (по 3 знака с {zone:1459}, {zone:1461} и {zone:1460}) платят 200 в первый раз и 150 после, плюс репутация двух других полей боя.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}: «Общие усилия»",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}: награды «Почтения»",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "«Превознесение» даёт очко наследия \"Мастер Долины Альтерак\" и последние два знака различия, 400 репутации, которые уже не нужны ни для чего, кроме знаков. {npc:13217} продаёт {item:19030} (200 з, 60-й уровень; у него свой гайд), {item:19325} и {item:21563} (75з56с), {item:19323} (156з49с), {item:19321} (79з53с), {item:19324} (125з66с) и тома за 50 з и предметы для левой руки.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}: награды «Превознесения»",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} — бой 40 на 40 для уровней с 51-го и самая быстрая из четырёх репутаций полей боя: в ней около 2 000 репутации от одноразовых заданий, а полная победа платит несколько сотен. Те же одноразовые задания дают ещё 1 870 репутации {zone:1454}. {npc:13842} стоит в {object:172982}. Талант наследия Forever Дипломат добавляет до 10% к каждому числу в этом гайде.",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "Лагерь Морозного Волка стоит у ворот {zone:1459} в {zone:1416}. Возьмите здесь все задания: они все платят 100 или больше, один раз.",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}: {item:17850} в {area:3337}, 100",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}: захватите кладбище, 100",
	["capture a tower or bunker, 100"] = "захватите башню или бункер, 100",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "Встаньте в очередь у ворот, у любого боевого магистра или через экран полей боя; вы входите в {area:2961} на юге. Пока ворота закрыты, возьмите задания в деревне: они выполняются во время боя.",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337} лежит южнее {area:2978}. {item:17850} стоит в глубине пещеры, за гноллами.",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "Большая часть происходит по пути к {npc:11948}. Соберите {item:17422} с игроков Альянса и стражников, которых вы убили. Захватите {area:3301} или любое кладбище Альянса, сожгите бункер Альянса (нажмите на его знамя) и возьмите {area:2957}. {npc:13320} стоит в {area:3304}; {npc:13598} — в {area:2959}. {quest:7302} просит найти, где высадились три командира крыльев. В классике каждая башня, кладбище или шахта давали 12 репутации, {npc:11949} — 125, а Ванндар — около 300.",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "знамя {area:3305}",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "место {npc:13179}",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "место {npc:13180}",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "место {npc:13181}",

	-- Step 18: Back in Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Back in {area:2961}"] = "Обратно в {area:2961}",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Первые знаки почёта Долины Альтерак несите {npc:15350} у ворот: 150 в первый раз ({quest:8369}), затем 100 за каждые ещё 3. Экипировка PvP в Forever тоже стоит знаки почёта вместе с честью: решите, что вы хотите, до сдачи. С собой можно нести не больше 30 знаков {zone:1459}: сдайте или потратьте их, прежде чем достигнуть этого.",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} до уровня «Дружелюбие»",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "{npc:13817} у ворот хочет, чтобы {npc:11948} погиб: выиграйте матч, в котором ваша команда убьёт его. Тогда он даёт вам выбрать оружие ({quest:8272}).",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}, 10 и оружие",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "«Дружелюбие» позволяет {npc:13840} улучшить ваш знак различия: 100 репутации. От «Дружелюбия» до «Уважения» — 6000 репутации. В классике полная победа платила 300–700 вместе с 3 знаками; Боевой Вестник продолжает брать 3 знака за 100. Внутри {item:17354} (75, из пещер Зимокогтя) повторяется каждый матч; «Легенда о Корраке» (200, когда он появляется посреди долины) возвращается к {npc:13840} сюда. «Дружелюбие» открывает {item:19031} (1 з) и улучшенные напитки лечения и маны (5 с) у {npc:13219} рядом с ним.",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}, 1 з",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}: {quest:8369} снова, 100 за 3 знака",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "«Уважение»: знак различия 3-го ранга, 100 репутации. От «Уважения» до «Почтения» — 12000 репутации. {npc:13219} рядом с {npc:13840} продаёт плащи и подвески {npc:12051} и советника (около 7 з каждый), пояса Морозного Волка (5з9с – 7з66с) и мощные напитки лечения и маны (10 с).",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}: 100 за 3 знака",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "«Почтение»: знак различия 4-го ранга, 150 репутации. От «Почтения» до «Превознесения» — 21000 репутации, половина пути. «Почтение» открывает оружие у {npc:13219}: {item:19099}, {item:19101} и «Морозный Укус» (31з53с – 39з71с), и {npc:14751} (5 з). С 51-го уровня «Ради великой чести» (по 3 знака с {zone:1459}, {zone:1461} и {zone:1460}) платят 200 в первый раз и 150 после, плюс репутация двух других полей боя.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}: «Ради великой чести»",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}: награды «Почтения»",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "«Превознесение» даёт очко наследия \"Мастер Долины Альтерак\" и последние два знака различия, 400 репутации, которые уже не нужны ни для чего, кроме знаков. {npc:13219} продаёт {item:19029} (200 з, 60-й уровень; у него свой гайд), {item:19325} и {item:21563} (75з56с), {item:19323} (156з49с), {item:19321} (79з53с), {item:19324} (125з66с) и тома за 50 з и предметы для левой руки.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}: награды «Превознесения»",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "Превознесение у фракции {faction:729} дает очко наследия.",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "Превознесение у фракции {faction:730} дает очко наследия.",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "Больше всего дают полные бои с убийством босса ({npc:11946}) после падения башен.",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "Больше всего дают полные бои с убийством босса ({npc:11948}) после падения башен.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Продолжайте побеждать: {zone:1459}. Повторяются: «Больше добычи!» ({npc:13176}), {item:17306} для NPC {npc:13236} (призывает: {npc:13256}) и {item:17642} для NPC {npc:13441}.",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Продолжайте побеждать: {zone:1459}. Повторяются: {quest:7223} ({npc:13257}), {item:17423} для NPC {npc:13442} (призывают: {npc:13419}) и {item:17643} для NPC {npc:13577}.",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729} удерживает {area:2978} на юге зоны {zone:1459}. Уничтожение башен, захват кладбищ и рудников, убийство капитанов и генералов дают репутацию всей команде. Собирайте с павших врагов: {item:17422} – для NPC {npc:13176}. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730} удерживает {area:2959} на севере зоны {zone:1459}. Уничтожение башен, захват кладбищ и рудников, убийство капитанов и генералов дают репутацию всей команде. Собирайте с павших врагов предметы для задания {quest:7223} ({npc:13257}). Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{faction:729} to Exalted"] = "{faction:729} до уровня «Превознесение»",
	-- ["{faction:729} to Honored"] = "{faction:729} до уровня «Уважение»",
	-- ["{faction:729} to Revered"] = "{faction:729} до уровня «Почтение»",
	-- ["{faction:730} to Exalted"] = "{faction:730} до уровня «Превознесение»",
	-- ["{faction:730} to Honored"] = "{faction:730} до уровня «Уважение»",
	-- ["{faction:730} to Revered"] = "{faction:730} до уровня «Почтение»",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: припасы Железного рудника и {item:17542} из рудников",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: припасы рудника Ледяного Зуба и {item:17522} из рудников",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}: Больше добычи!",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: Галлон крови",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}: снова {quest:7223}",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}: Гроздь кристаллов",
}
