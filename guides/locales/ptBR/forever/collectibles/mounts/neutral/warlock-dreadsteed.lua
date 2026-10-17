-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Corcel Medonho de Bruxo",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Sua montaria épica no nível 60: evocada em qualquer lugar, sem gastar ouro num cavalo épico.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5520} no {object:2164} manda você a {quest:7562} nas {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:6382} em {zone:1455} manda você a {quest:7562} nas {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow (no name in this language: may be words) · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5815} na {object:172960} manda você a {quest:7562} nas {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter (no name in this language: may be words) · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5753} no {object:36082} manda você a {quest:7562} nas {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} e o goblin dele, {npc:14437}, acampam no {area:255}, no noroeste das {zone:1428}, a oeste da {area:254}. A série é longa, custa ouro com {npc:14437} e termina em duas masmorras.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Os corujursos de {zone:1452} deixam cair o sangue, cerca de um em três: as Ferujas Maltrapilhas e Furiosas a oeste e em volta de {area:2255}, as Enlouquecidas, Lunamarca e {spell:417141} no leste. Enquanto caça, comece os materiais da próxima etapa: a Casa de Leilões tem todos.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "De volta a {npc:14436}, depois entregue o {item:18591} dele a {npc:14437}, ao lado. {npc:14436} então pede três peças do ritual e {npc:14437} manda você a {zone:1448}: compre duas Poções Sombrias de {npc:14437} para essa viagem.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "ele lhe dá o {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, de {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "As peças do ritual",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} quer 10 Elixires de Poder Sombrio ({skill:171}), 6 Estilhaços Brilhantes Grandes ({skill:333}), 25 {item:11370} ({skill:186}, em {area:1584} e em {zone:1427}) e 35 Escamas de Dragão Negro ({skill:393}, dragonídeos negros de {zone:1428}). Faça ou colete o que suas profissões permitirem; compre o resto na Casa de Leilões.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Entregue as três peças a {npc:14437}. Ele então quer 3 Barras de Arcanita: alquimistas as transmutam, os demais as compram na Casa de Leilões.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} fica no oeste de {zone:1448}. Beba uma {item:18802} antes de entrar: os sectários do Concílio das Sombras ficam amistosos por um tempo, os demônios não. {quest:7623} espera no fundo do {area:1770}, a caverna acima de {area:1763}, depois de uma ponte na grande câmara das raízes.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} espera numa câmara lateral junto a uma ponte no caminho de volta. Fale com ele e ele e seus quatro guardas atacam; nenhum é elite. Leve o coração dele de volta a {npc:9516}, bebendo outra poção se a primeira tiver passado.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, ao lado de {quest:7623}, vende a {item:18687}; ele só negocia com você enquanto uma {item:18802} estiver ativa. Leve bastante ouro.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, de {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "De volta a {npc:14437} com a poeira estelar. Ele lhe dá o {item:18688} para {area:2057}.",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha do sudeste das {zone:1422}: você precisa da chave ou de um ladino para abrir a porta, e da {item:13873} de Ossorrange para ir mais fundo. Use o {item:18688} no laboratório de alquimia da sala de {npc:10508}; {npc:14500} faz o pergaminho. Leve um grupo.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "Use o {item:18688} no laboratório de alquimia",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "De volta a {npc:14437}, depois {npc:14436} lhe entrega as instruções do ritual. Compre o {item:18663}, a {item:18629} e os {item:18670} de {npc:14437} e leve dez ou mais Estilhaços de Alma.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "O ritual em {area:2577}",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} fica nas ruínas do centro de {zone:1444}; o círculo do ritual fica na ala oeste, depois de {npc:11496}, e a porta requer a {item:18249} ou um ladino. Use o {item:18663} para começar; quando o sino, a roda ou a vela enfraquecer, clique nele com a {item:18629} (um {item:6265} cada). Quando os demônios pararem de vir, use os {item:18670}, derrote o {npc:14502} e seu mestre senhor do medo e fale com o {npc:14504}. Leve um grupo.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}: ele se vincula a você",
}
