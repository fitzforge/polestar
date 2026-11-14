-- Spanish (Latin America) (esMX): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Reputación: Valle de Alterac",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "Misiones únicas que suman 2.000 y victorias grandes lo hacen el más rápido de los cuatro; Exaltado da un Punto de legado.",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "Maestro del Valle de Alterac: un Punto de legado en Exaltado",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge (no name in this language: may be words)
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} es una batalla de 40 contra 40 para nivel 51 o más, y la más rápida de las cuatro reputaciones de campo de batalla: tiene unas 2.000 de reputación en misiones únicas, y una victoria completa paga varios cientos. Esas mismas misiones únicas también pagan 1.870 de reputación con {zone:1455}. {npc:13843} recluta afuera de la {object:32372}. La ventaja Diplomático del Legado de Forever suma hasta un 10% a cada número de esta guía.",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "El campamento Pico Tormenta está afuera de la puerta de {zone:1459}, del lado de {zone:1416}, arriba de {area:287}. Toma todas las misiones de aquí: todas pagan 100 o más, una vez.",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}: el {item:17849} en {area:3058}, 100",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}: asalta un cementerio, 100",
	["destroy a tower or bunker banner, 100"] = "destruye el estandarte de una torre o búnker, 100",
	["capture a mine, 100"] = "captura una mina, 100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "Entra a la cola en la puerta, con cualquier maestro de batalla o desde la pantalla de campos de batalla; entras en {area:2959}, en el norte. Antes de que se abran las puertas, toma las misiones del pueblo: se completan durante la batalla.",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058} está al suroeste de {area:2959}. El {item:17849} está al fondo de la cueva, pasando los yetis y las arpías.",

	-- Step 5: The battle
	["The battle"] = "La batalla",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "Casi todo esto pasa de camino a {npc:11946}. Saquea {quest:7223} de los jugadores y guardias de la Horda que mates. Asalta {area:3301} o cualquier cementerio de la Horda, quema una torre de la Horda (clic en su estandarte) y toma {area:2963}. {npc:13154} está en {area:2962}; el {npc:13597} en {area:2961}. {quest:7301} te pide encontrar dónde aterrizaron los tres comandantes de vuelo. En Classic cada torre, cementerio o mina pagaba 12 de reputación, {npc:11947} 125 y {npc:11946} unos 300.",
	["assault a graveyard"] = "asalta un cementerio",
	["Iceblood Tower banner"] = "estandarte de la Torre Sangrehielo",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "el lugar de {npc:13437}",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "el lugar de {npc:13439}",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "el lugar de {npc:13438}",

	-- Step 6: Back in Dun Baldar
	-- {area:2959} Dun Baldar
	["Back in {area:2959}"] = "De vuelta en {area:2959}",

	-- Step 7: Back at the gate
	["Back at the gate"] = "De vuelta en la puerta",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Tus primeras Marcas de Honor del Valle de Alterac van al {npc:15351} junto a {npc:13841}: 150 la primera vez ({quest:8375}), y luego 100 por cada 3 más. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1459}: entrégalas o gástalas antes de llegar a eso.",
	["Alterac Valley Marks of Honor: play games"] = "Marcas de Honor del Valle de Alterac: juega partidas",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} hasta Amistoso",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "{npc:13816}, junto a la puerta, quiere a {npc:11946} muerto: gana una partida en la que tu equipo lo mate. Entonces te deja elegir un arma ({quest:8271}).",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}, 10 y un arma",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "Amistoso permite que {npc:13841} mejore tu insignia: 100 de reputación. De Amistoso a Honorable son 6000 de reputación. En Classic una victoria completa pagaba de 300 a 700 con sus 3 marcas; el general de brigada sigue aceptando 3 marcas por 100. Adentro, {item:17354} (75, de las cuevas Hachainvernal) se repite en cada partida; {npc:12159} (200, cuando aparece en medio del valle) se entrega aquí a {npc:13841}. Amistoso abre el {item:19032} (1 de oro) y los tragos de sanación y de maná superiores (5s) con {npc:13217}, a su lado.",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}, 1 de oro",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}: {quest:8375} otra vez, 100 por 3 marcas",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "Honorable: insignia de rango 3, 100 de reputación. De Honorable a Reverenciado son 12000 de reputación. {npc:13217}, junto a {npc:13841}, vende las capas y colgantes de soldado y de sabio Pico Tormenta (unos 7 de oro cada uno), los cinturones Pico Tormenta (de 4g74s a 7g12s) y los tragos de sanación y de maná sublimes (10s).",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}: 100 por 3 marcas",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Reverenciado: insignia de rango 4, 150 de reputación. De Reverenciado a Exaltado son 21000 de reputación, la mitad de la subida. Reverenciado abre las armas con {npc:13217}: {item:19100}, {item:19102} y {item:19104} (de 31g65s a 39g85s), y el {npc:14752} (5 de oro). A nivel 51 o más, Esfuerzos coordinados (3 marcas de cada uno de {zone:1459}, {zone:1461} y {zone:1460}) paga 200 la primera vez y 150 después, más reputación con los otros dos campos de batalla.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}: Esfuerzos coordinados",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}: recompensas de Reverenciado",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Exaltado da el Punto de legado \"Maestro del Valle de Alterac\" y las dos últimas insignias, 400 de reputación que ya no cuenta para nada más que las insignias. {npc:13217} vende el {item:19030} (200 de oro, nivel 60; tiene su propia guía), {item:19325} y {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) y los tomos y objetos de mano izquierda de 50 de oro.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}: recompensas de Exaltado",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} es una batalla de 40 contra 40 para nivel 51 o más, y la más rápida de las cuatro reputaciones de campo de batalla: tiene unas 2.000 de reputación en misiones únicas, y una victoria completa paga varios cientos. Esas mismas misiones únicas también pagan 1.870 de reputación con {zone:1454}. {npc:13842} está en el {object:172982}. La ventaja Diplomático del Legado de Forever suma hasta un 10% a cada número de esta guía.",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "El campamento Lobo Gélido está afuera de la puerta de {zone:1459}, en {zone:1416}. Toma todas las misiones de aquí: todas pagan 100 o más, una vez.",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}: el {item:17850} en {area:3337}, 100",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}: asalta un cementerio, 100",
	["capture a tower or bunker, 100"] = "captura una torre o búnker, 100",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "Entra a la cola en la puerta, con cualquier maestro de batalla o desde la pantalla de campos de batalla; entras en {area:2961}, en el sur. Antes de que se abran las puertas, toma las misiones de la aldea: se completan durante la batalla.",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337} está al sur de {area:2978}. El {item:17850} está al fondo de la cueva, pasando los gnolls.",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "Casi todo esto pasa de camino a {npc:11948}. Saquea {item:17422} de los jugadores y guardias de la Alianza que mates. Asalta {area:3301} o cualquier cementerio de la Alianza, quema un búnker de la Alianza (clic en su estandarte) y toma {area:2957}. {npc:13320} está en {area:3304}; el {npc:13598} en {area:2959}. {quest:7302} te pide encontrar dónde aterrizaron los tres comandantes de vuelo. En Classic cada torre, cementerio o mina pagaba 12 de reputación, {npc:11949} 125 y Vanndar unos 300.",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "estandarte de {area:3305}",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "el lugar de {npc:13179}",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "el lugar de {npc:13180}",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "el lugar de {npc:13181}",

	-- Step 18: Back in Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Back in {area:2961}"] = "De vuelta en {area:2961}",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Tus primeras Marcas de Honor del Valle de Alterac van al {npc:15350} junto a la puerta: 150 la primera vez ({quest:8369}), y luego 100 por cada 3 más. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1459}: entrégalas o gástalas antes de llegar a eso.",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} hasta Amistoso",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "{npc:13817}, junto a la puerta, quiere a {npc:11948} muerto: gana una partida en la que tu equipo lo mate. Entonces te deja elegir un arma ({quest:8272}).",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}, 10 y un arma",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "Amistoso permite que {npc:13840} mejore tu insignia: 100 de reputación. De Amistoso a Honorable son 6000 de reputación. En Classic una victoria completa pagaba de 300 a 700 con sus 3 marcas; el Belisario de la Horda sigue aceptando 3 marcas por 100. Adentro, {item:17354} (75, de las cuevas Hachainvernal) se repite en cada partida; La leyenda de Korrak (200, cuando aparece en medio del valle) se entrega aquí a {npc:13840}. Amistoso abre el {item:19031} (1 de oro) y los tragos de sanación y de maná superiores (5s) con {npc:13219}, a su lado.",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}, 1 de oro",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}: {quest:8369} otra vez, 100 por 3 marcas",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "Honorable: insignia de rango 3, 100 de reputación. De Honorable a Reverenciado son 12000 de reputación. {npc:13219}, junto a {npc:13840}, vende las capas y colgantes de {npc:12051} y de consejero (unos 7 de oro cada uno), los cinturones Lobo Gélido (de 5g9s a 7g66s) y los tragos de sanación y de maná sublimes (10s).",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}: 100 por 3 marcas",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Reverenciado: insignia de rango 4, 150 de reputación. De Reverenciado a Exaltado son 21000 de reputación, la mitad de la subida. Reverenciado abre las armas con {npc:13219}: {item:19099}, {item:19101} y Congelación (de 31g53s a 39g71s), y el {npc:14751} (5 de oro). A nivel 51 o más, Por un gran honor (3 marcas de cada uno de {zone:1459}, {zone:1461} y {zone:1460}) paga 200 la primera vez y 150 después, más reputación con los otros dos campos de batalla.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}: Por un gran honor",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}: recompensas de Reverenciado",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Exaltado da el Punto de legado \"Maestro del Valle de Alterac\" y las dos últimas insignias, 400 de reputación que ya no cuenta para nada más que las insignias. {npc:13219} vende el {item:19029} (200 de oro, nivel 60; tiene su propia guía), {item:19325} y {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) y los tomos y objetos de mano izquierda de 50 de oro.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}: recompensas de Exaltado",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "Ser Exaltado con {faction:729} otorga un Punto de legado.",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "Ser Exaltado con {faction:730} otorga un Punto de legado.",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "Las partidas completas que matan a {npc:11946} después de caer las torres son las que más dan.",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "Las partidas completas que matan a {npc:11948} después de caer las torres son las que más dan.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Sigue ganando en {zone:1459}. ¡Más botines! ({npc:13176}), {item:17306} para {npc:13236} (invoca a {npc:13256}) y Pellejos de carnero de Alterac para {npc:13441} se repiten.",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Sigue ganando en {zone:1459}. Más {quest:7223} ({npc:13257}), Cristales de tormenta para {npc:13442} (invocan a {npc:13419}) y Pellejos Lobo Gélido para {npc:13577} se repiten.",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729} controla {area:2978}, en el sur de {zone:1459}. Destruir torres, tomar cementerios y minas, y matar capitanes y generales da reputación a todo el equipo. Despoja {item:17422} de los enemigos caídos para {npc:13176}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730} controla {area:2959}, en el norte de {zone:1459}. Destruir torres, tomar cementerios y minas, y matar capitanes y generales da reputación a todo el equipo. Despoja {quest:7223} de los enemigos caídos para {npc:13257}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{faction:729} to Exalted"] = "{faction:729} hasta Exaltado",
	-- ["{faction:729} to Honored"] = "{faction:729} hasta Honorable",
	-- ["{faction:729} to Revered"] = "{faction:729} hasta Reverenciado",
	-- ["{faction:730} to Exalted"] = "{faction:730} hasta Exaltado",
	-- ["{faction:730} to Honored"] = "{faction:730} hasta Honorable",
	-- ["{faction:730} to Revered"] = "{faction:730} hasta Reverenciado",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: Ferrohondo y {item:17542} de las minas",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: Dentefrío y {item:17522} de las minas",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}: ¡Más botines!",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: Un galón de sangre",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}: Más {quest:7223}",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}: Recogida de cristal",
}
