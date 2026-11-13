-- Spanish (Latin America) (esMX): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71} y un arma (Horda)",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek · {area:159} Brill
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "{spell:71} a nivel 10 y un arma de una mano a elección: el camino de {npc:5810}, la cripta de {area:159} o el escudo Rompecielos.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} en {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "A nivel 10, {npc:252377} está con los instructores junto a la puerta oeste de {area:16638}. Un sectario, {npc:257196}, tiene el escudo de su familia en {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Ve al noroeste desde {area:16638} hasta {area:16629}. {npc:257196} está al oeste de la subida al santuario, entre los guardianes, clamaespíritus y maestros de espadas del culto: atráelos de a uno antes de enfrentarlo. Suelta {item:263993}.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, de {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "De vuelta con {npc:252377} en {area:16638}. Te enseña {spell:71} y te da {item:275290}, un escudo para usarla. El camino de {npc:5810}, más abajo, igual te da un arma más adelante, cuando llegues a Kalimdor.",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {area:362} Razor Hill · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon · {area:159} Brill
	["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "A nivel 10, {npc:3169}, el instructor de guerreros en el cuartel de {area:362}, te manda con {npc:5810} en {zone:1413}. Sorek, en {object:172958} de {zone:1454}, también la ofrece. Cualquier guerrero de la Horda puede tomar uno de los dos caminos, nunca ambos: ¿igual vas a ir a {zone:1420} a nivel 10? {npc:2131}, en la posada de {area:159}, ofrece el otro: una pelea junto al cementerio de {area:159} para la misma actitud, y después la cripta Agamand para un arma reliquia.",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {area:222} Bloodhoof Village · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "A nivel 10, {npc:3063}, el instructor de guerreros de {area:222}, te manda con {npc:5810} en {zone:1413}. {npc:3041}, en {zone:1456}, también la ofrece.",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:5810} at {area:379}"] = "{npc:5810} en {area:379}",
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "{npc:5810} es fácil de pasar por alto: está bajo un pequeño toldo junto a un árbol grande, justo al oeste de {area:379}, debajo del lado sur del camino, con el puesto a la vista hacia el este. Ir derecho al sur desde el puesto no lleva hasta él. Desde {zone:1411}, cruza el puente hacia el oeste; desde {zone:1412}, ve al norte pasando el Cruce.",

	-- Step 7: Singed Scales in Thunder Ridge
	-- {area:369} Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in {area:369}"] = "Escamas chamuscadas en {area:369}",
	-- {area:369} Thunder Ridge · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens · {spell:5401} Lizard Bolt
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "Necesitas cinco Escamas chamuscadas. Los truenagartos (nivel 9-10) y los pielrrelámpago (10-11) viven abajo, en la grieta de {area:369}, en el noroeste de {zone:1411}, al sur de {zone:1454}: desde el puente de {zone:1413}, dobla a la izquierda y sigue el río al norte hasta entrar. Ambos sueltan una escama más o menos cuatro de cada cinco veces; ambos lanzan {spell:5401}.",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}, de los lagartos",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["Back to {npc:5810} under his tree west of {area:379}."] = "De vuelta con {npc:5810}, bajo su árbol al oeste de {area:379}.",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "La choza de {npc:5878} está en lo alto de {area:1699}, al este del Cruce. La mayoría de las laderas son demasiado empinadas: sube por la cresta ancha del lado norte o este.",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "{object:58369} está junto a una carreta rota en el campamento Crines de Acero al noroeste de {npc:5878}, al noreste del Cruce. Dos Crines de Acero la custodian y sus cazadores atraen más jabaespines: despéjalos de a uno y luego abre el cofre (se rellena en segundos, así que un amigo también puede saquearlo).",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}, de {object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {area:159} Brill · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "A nivel 10, {npc:2131}, el instructor de guerreros dentro de la posada de {area:159}, te manda con {npc:1496}, junto al cementerio del borde oeste de {area:159}. Este camino y el de {npc:5810} se excluyen: quita {quest:1505} o {quest:1498} de tu registro si tienes alguna.",

	-- Step 12: Deathguard Dillinger
	-- {area:159} Brill · {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "Dillinger está junto al cementerio del borde oeste de {area:159}. Un orco, trol, tauren o Skyborne que tomó {quest:1818} de {npc:2131} en vez del camino de {npc:5810} sigue por {area:159} desde aquí.",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390} duerme en el mausoleo del cementerio, justo al norte de Dillinger. Para despertarlo, haz clic en la placa plana con forma de cráneo en el suelo, a la izquierda del camino a la puerta del mausoleo; el sello se levanta y {npc:6390} (nivel 11, no élite) sale. Empieza con la salud al máximo.",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500} está en {area:2119}, la posada del lado este de {area:159}.",

	-- Step 15: The Agamand Family Crypt
	-- {area:158} Agamand Family Crypt
	["The {area:158}"] = "{area:158}",
	-- {area:158} Agamand Family Crypt · {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "Los cuatro Armeros Agamand están dentro de {area:158}, en el extremo norte de {area:157}, al norte de {area:159}, uno por sala: uno en la sala más baja, dos en el par de salas subiendo la escalera y uno en la sala de arriba de esas. El armero del hacha está en un rincón oscuro. Los no-muertos de la cripta vienen en grupos de tres o más y reaparecen rápido; los de la sala de arriba no están vinculados. Los armeros del hacha, la daga y la maza tardan 15 minutos en rellenarse después de que alguien los saquea.",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "Regresa con {npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Los cuatro Expositores de armas de Agamand están entre los edificios de {area:157}, al norte de {area:159}. Los no-muertos de los molinos atacan al verte.",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} está en {area:159}. {npc:6390} espera en el mausoleo de la colina, justo al norte del pueblo: abre la reja y pelea con él.",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} está en la posada, {area:2119}, en {area:159}.",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} y un arma de una mano a tu elección a nivel 10.",
}
