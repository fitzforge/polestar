-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Конь погибели чернокнижника",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Ваше эпическое средство передвижения на 60-м уровне: призывается где угодно, без трат золота на эпического коня.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5520} ({object:2164}) отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:6382} ({zone:1455}) отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5815} ({object:172960}) отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "На 60-м уровне {npc:5753} ({object:36082}) отправляет вас к NPC {quest:7562} ({zone:1428}).",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} и его гоблин {npc:14437} стоят лагерем здесь: {area:255}, на северо-западе зоны {zone:1428}, к западу от места {area:254}. Цепочка длинная, у {npc:14437} придется тратить золото, а заканчивается она в двух подземельях.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Кровь падает с совухов зоны {zone:1452} примерно в одном случае из трех: лохматые и бешеные совухи – к западу от места {area:2255} и вокруг него, безумные, луноподобные и совухи с эффектом «{spell:417141}» – на востоке. Пока охотитесь, начните собирать материалы для следующего шага: на аукционе есть все.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Вернитесь к {npc:14436}, затем отдайте его {item:18591} NPC {npc:14437} рядом с ним. Затем {npc:14436} просит три предмета для ритуала, а {npc:14437} отправляет вас в зону {zone:1448}: купите у {npc:14437} для этого два теневых зелья.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "он дает вам {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, у {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Предметы для ритуала",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} нужны 10 эликсиров силы тьмы ({skill:171}), 6 больших сверкающих осколков ({skill:333}), 25 шт. {item:11370} ({skill:186}; {area:1584} и {zone:1427}) и 35 шкур черного дракона ({skill:393}; черные дракониды зоны {zone:1428}). Сделайте или добудьте то, что позволяют ваши профессии; остальное купите на аукционе.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Отдайте три предмета {npc:14437}. Затем ему нужны 3 арканитовых слитка: алхимики получают их трансмутацией, остальные покупают на аукционе.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} находится на западе зоны {zone:1448}. Перед входом выпейте {item:18802}: культисты Совета Теней на время становятся дружелюбными, демоны — нет. {quest:7623} ждет глубоко внутри места {area:1770} — пещеры над местом {area:1763}, за мостом в большом зале с корнями.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} ждет в боковом зале у моста на обратном пути наверх. Поговорите с ним, и он вместе с четырьмя стражами нападет; никто из них не элитный. Отнесите его сердце NPC {npc:9516}, выпив еще одно зелье, если действие первого закончилось.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, рядом с NPC {quest:7623}, продает {item:18687}; он имеет с вами дело только пока действует {item:18802}. Возьмите побольше золота.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}: {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Вернитесь к {npc:14437} со звездной пылью. Он дает вам {item:18688} для подземелья {area:2057}.",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}: чтобы открыть дверь, нужен ключ или разбойник, а чтобы пройти глубже — {item:13873} Громоклина. Используйте {item:18688} у алхимической лаборатории в комнате NPC {npc:10508}; {npc:14500} изготовит пергамент. Возьмите группу.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "Используйте {item:18688} у алхимической лаборатории",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Вернитесь к {npc:14437}, затем {npc:14436} вручит вам указания для ритуала. Купите у {npc:14437} {item:18663}, {item:18629} и {item:18670} и возьмите с собой десять или больше осколков души.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "Ритуал. Локация: {area:2577}",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} стоит среди руин в центре зоны {zone:1444}; ритуальный круг — в западном крыле, за NPC {npc:11496}, а для двери нужен {item:18249} или разбойник. Используйте {item:18663}, чтобы начать; когда колокол, колесо или свеча гаснет, щелкните по нему, используя {item:18629} (по одному {item:6265} за раз). Когда демоны перестанут появляться, используйте {item:18670}, победите NPC {npc:14502} и его хозяина-повелителя ужаса и поговорите: {npc:14504}. Возьмите группу.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}: он привязывается к вам",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Горзиеки нужны 10 эликсиров «{spell:5896}» ({skill:171}), 6 больших сверкающих осколков ({skill:333}), 25 шт. {item:11370} ({skill:186}; {area:1584} и {zone:1427}) и 35 шкур черного дракона ({skill:393}; черные дракониды зоны {zone:1428}). Сделайте или добудьте то, что позволяют ваши профессии; остальное купите на аукционе.",
}
