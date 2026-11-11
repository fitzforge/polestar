-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71} e uma Arma (Horda)",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek · {area:159} Brill
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "{spell:71} no nível 10 e uma arma de uma mão à sua escolha: o caminho de {npc:5810}, a cripta de {area:159}, ou o escudo Skybreaker.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} em {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "No nível 10, {npc:252377} fica com os instrutores junto ao portão oeste de {area:16638}. Uma cultista, {npc:257196}, guarda o escudo da família dela em {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Siga para noroeste saindo de {area:16638} até {area:16629}. {npc:257196} fica a oeste da aproximação do santuário, entre os Guardiões, Evocaespíritos e Mestres-lâmina do culto: puxe-os um de cada vez antes de pegá-lo. Ele solta {item:263993}.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, de {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "De volta a {npc:252377}, em {area:16638}. Ela ensina {spell:71} e entrega {item:275290}, um escudo para usar com ela. O caminho de {npc:5810}, abaixo, ainda dá uma arma depois, quando você chegar a Kalimdor.",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {area:362} Razor Hill · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon · {area:159} Brill
	["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "No nível 10, {npc:3169}, o instrutor de guerreiro no quartel de {area:362}, manda você a {npc:5810} em {zone:1413}. Sorek, no {object:172958} de {zone:1454}, também a oferece. Qualquer guerreiro da Horda pode tomar um dos dois caminhos, nunca os dois: vai para {zone:1420} no nível 10 de qualquer jeito? {npc:2131}, na estalagem de {area:159}, oferece o outro: uma luta junto ao cemitério de {area:159} pela mesma postura, depois a cripta dos Agamand para uma arma de herança.",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {area:222} Bloodhoof Village · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "No nível 10, {npc:3063}, o instrutor de guerreiro de {area:222}, manda você para {npc:5810}, em {zone:1413}. {npc:3041}, em {zone:1456}, também oferece.",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:5810} at {area:379}"] = "{npc:5810} em {area:379}",
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "{npc:5810} é fácil de não ver: ele fica sob um pequeno toldo junto a uma árvore grande logo a oeste de {area:379}, abaixo do lado sul da estrada, com o posto à vista a leste dele. Ir direto para o sul a partir do posto não leva a ele. De {zone:1411}, atravesse a ponte para oeste; de {zone:1412}, siga para o norte passando pela Encruzilhada.",

	-- Step 7: Singed Scales in Thunder Ridge
	-- {area:369} Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in {area:369}"] = "Escamas Chamuscadas em {area:369}",
	-- {area:369} Thunder Ridge · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens · {spell:5401} Lizard Bolt
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "Você precisa de cinco Escamas Chamuscadas. Lagartos Trovejantes (nível 9-10) e Pelegos de Relâmpago (10-11) vivem lá embaixo, na fenda de {area:369}, no noroeste de {zone:1411}, ao sul de {zone:1454}: a partir da ponte de {zone:1413}, vire à esquerda e siga o rio para o norte, entrando nela. Os dois soltam uma escama em cerca de quatro de cada cinco mortes; os dois lançam {spell:5401}.",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}, dos lagartos",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["Back to {npc:5810} under his tree west of {area:379}."] = "De volta a {npc:5810}, embaixo da árvore dele, a oeste de {area:379}.",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "A cabana de {npc:5878} fica no alto de {area:1699}, a leste da Encruzilhada. A maioria das encostas é íngreme demais: suba pela crista larga do lado norte ou leste.",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "{object:58369} fica ao lado de uma carroça quebrada no acampamento dos Crinavalha a noroeste de {npc:5878}, a nordeste da Encruzilhada. Dois Crinavalha guardam e os caçadores deles puxam mais quilboar: limpe um de cada vez e depois abra o baú (ele se enche em segundos, então um amigo também pode saquear).",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}, de {object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {area:159} Brill · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "No nível 10, {npc:2131}, o instrutor de guerreiro dentro da estalagem de {area:159}, manda você para {npc:1496}, junto ao cemitério na borda oeste de {area:159}. Este caminho e o de {npc:5810} se excluem: descarte {quest:1505} ou {quest:1498} do seu registro, se tiver uma.",

	-- Step 12: Deathguard Dillinger
	-- {area:159} Brill · {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "Dillinger fica junto ao cemitério na borda oeste de {area:159}. Um Orc, Troll, Tauren ou Celonato que pegou {quest:1818} com {npc:2131} em vez do caminho de {npc:5810} é conduzido por {area:159} a partir daqui.",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390} dorme no mausoléu do cemitério, logo ao norte de Dillinger. Para acordá-lo, clique na placa de caveira plana no chão, à esquerda do caminho até a porta do mausoléu; o selo se ergue e {npc:6390} (nível 11, não elite) sai andando. Comece com vida cheia.",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500} fica na {area:2119}, a estalagem no lado leste de {area:159}.",

	-- Step 15: The Agamand Family Crypt
	-- {area:158} Agamand Family Crypt
	["The {area:158}"] = "{area:158}",
	-- {area:158} Agamand Family Crypt · {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "Os quatro Cavaletes de Armas dos Agamand ficam dentro de {area:158}, no extremo norte de {area:157}, ao norte de {area:159}, um cavalete por sala: um na sala mais baixa, dois no par de salas escada acima, um na sala acima dessas. O cavalete do machado fica num canto escuro. Os mortos-vivos da cripta vêm em grupos de três ou mais e voltam rápido; os da sala de cima não são ligados. Os cavaletes de machado, adaga e maça levam 15 minutos para se encher depois que alguém saqueia.",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "De volta a {npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Os quatro Cavaletes de Armas dos Agamand ficam entre os prédios de {area:157}, ao norte de {area:159}. Os mortos-vivos dos moinhos atacam assim que veem você.",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e enfrente-o.",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} está na estalagem, a {area:2119}, em {area:159}.",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} e uma arma de uma mão à sua escolha no nível 10.",
}
