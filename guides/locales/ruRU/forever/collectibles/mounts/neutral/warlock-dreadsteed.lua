-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Конь погибели чернокнижника",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "Ваше эпическое средство передвижения на 60-м уровне, призывается где угодно: не нужно покупать эпического коня и платить 1000 з. за навык верховой езды (подмастерье).",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5520}, учитель демонологии ({object:2164}), отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:6382}, учитель демонологии ({zone:1455}), отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5815}, учитель демонологии ({object:172960}), отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5753}, учитель демонологии ({object:36082}), отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "он дает вам {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, у {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Предметы для ритуала",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "Отдайте три предмета {npc:14437}. Затем ему нужны 3 арканитовых слитка для предмета {item:18629}: алхимики получают их трансмутацией (по {item:12363} и {item:12359} на слиток, с долгим временем восстановления); остальные их покупают.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{npc:14522}, рядом с NPC {quest:7623}, продает {item:18687} за 150 золотых. Он имеет с вами дело, только пока действует {item:18802}.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}: {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "Вернитесь к {npc:14437} со звездной пылью; если задание {quest:7630} тоже выполнено, он дает вам {item:18688} для подземелья {area:2057}. Соберите группу из пяти человек сейчас: обычную группу, не рейд.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "Используйте {item:18688} у алхимической лаборатории внутри",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "",

	-- Step 17: The ritual
	["The ritual"] = "",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Вернитесь к {npc:14436}, затем отдайте его {item:18591} NPC {npc:14437} рядом с ним. Затем {npc:14436} просит три предмета для ритуала, а {npc:14437} отправляет вас в зону {zone:1448}: купите у {npc:14437} для этого два теневых зелья.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Вернитесь к {npc:14437}, затем {npc:14436} вручит вам указания для ритуала. Купите у {npc:14437} {item:18663}, {item:18629} и {item:18670} и возьмите с собой десять или больше осколков души.",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Горзиеки нужны 10 эликсиров «{spell:5896}» ({skill:171}), 6 больших сверкающих осколков ({skill:333}), 25 шт. {item:11370} ({skill:186}; {area:1584} и {zone:1427}) и 35 шкур черного дракона ({skill:393}; черные дракониды зоны {zone:1428}). Сделайте или добудьте то, что позволяют ваши профессии; остальное купите на аукционе.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Кровь падает с совухов зоны {zone:1452} примерно в одном случае из трех: лохматые и бешеные совухи – к западу от места {area:2255} и вокруг него, безумные, луноподобные и совухи с эффектом «{spell:417141}» – на востоке. Пока охотитесь, начните собирать материалы для следующего шага: на аукционе есть все.",
	-- ["The ritual in {area:2577}"] = "Ритуал. Локация: {area:2577}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}: чтобы открыть дверь, нужен ключ или разбойник, а чтобы пройти глубже — {item:13873} Громоклина. Используйте {item:18688} у алхимической лаборатории в комнате NPC {npc:10508}; {npc:14500} изготовит пергамент. Возьмите группу.",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Ваше эпическое средство передвижения на 60-м уровне: призывается где угодно, без трат золота на эпического коня.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} находится на западе зоны {zone:1448}. Перед входом выпейте {item:18802}: культисты Совета Теней на время становятся дружелюбными, демоны — нет. {quest:7623} ждет глубоко внутри места {area:1770} — пещеры над местом {area:1763}, за мостом в большом зале с корнями.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} стоит среди руин в центре зоны {zone:1444}; ритуальный круг — в западном крыле, за NPC {npc:11496}, а для двери нужен {item:18249} или разбойник. Используйте {item:18663}, чтобы начать; когда колокол, колесо или свеча гаснет, щелкните по нему, используя {item:18629} (по одному {item:6265} за раз). Когда демоны перестанут появляться, используйте {item:18670}, победите NPC {npc:14502} и его хозяина-повелителя ужаса и поговорите: {npc:14504}. Возьмите группу.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} нужны 10 эликсиров силы тьмы ({skill:171}), 6 больших сверкающих осколков ({skill:333}), 25 шт. {item:11370} ({skill:186}; {area:1584} и {zone:1427}) и 35 шкур черного дракона ({skill:393}; черные дракониды зоны {zone:1428}). Сделайте или добудьте то, что позволяют ваши профессии; остальное купите на аукционе.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}: он привязывается к вам",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} ждет в боковом зале у моста на обратном пути наверх. Поговорите с ним, и он вместе с четырьмя стражами нападет; никто из них не элитный. Отнесите его сердце NPC {npc:9516}, выпив еще одно зелье, если действие первого закончилось.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} и его гоблин {npc:14437} стоят лагерем здесь: {area:255}, на северо-западе зоны {zone:1428}, к западу от места {area:254}. Цепочка длинная, у {npc:14437} придется тратить золото, а заканчивается она в двух подземельях.",
}
