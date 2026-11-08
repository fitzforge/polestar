-- French (frFR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71} et une arme (Horde)",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, Brill's crypt, or the Skybreaker shield."] = "",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker
	["{npc:252377} in Valanaar"] = "",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield
	["At 10, {npc:252377} stands with the trainers by Valanaar's west gate. A cultist, {npc:257196}, holds her family's shield at the Shrine of Akir."] = "",

	-- Step 2: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from Valanaar to the Shrine of Akir. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, sur {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in Valanaar. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {object:3224} Razor Hill (no name in this language: may be words) · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon
	["At 10, {npc:3169}, the warrior trainer in the barracks of {object:3224}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in Brill's inn offers the other: one fight by Brill's graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {object:2968}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek
	["{npc:5810} at Far Watch Post"] = "",
	-- {npc:5810} Uzzek · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of Far Watch Post, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "",

	-- Step 7: Singed Scales in Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in Thunder Ridge"] = "",
	-- {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the Thunder Ridge crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast Lizard Bolt."] = "",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}, sur les lézards",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek
	["Back to {npc:5810} under his tree west of Far Watch Post."] = "",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878}'s hut sits on top of Thorn Hill, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}, dans le {object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of Brill, sends you to {npc:1496} by the graveyard on Brill's west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "",

	-- Step 12: Deathguard Dillinger
	-- {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on Brill's west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through Brill from here."] = "",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390} dort dans le mausolée du cimetière, juste au nord de Dillinger. Pour le réveiller, cliquez sur la plaque plate en forme de crâne au sol, à gauche du chemin menant à la porte du mausolée ; le sceau se lève et {npc:6390} (niveau 11, pas élite) sort. Commencez avec toute votre vie.",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["{npc:1500} is in the Gallows' End Tavern, the inn on Brill's east side."] = "",

	-- Step 15: The Agamand Family Crypt
	["The Agamand Family Crypt"] = "",
	-- {object:1631} Agamand Mills (no name in this language: may be words)
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the Agamand Family Crypt at the north end of {object:1631}, north of Brill, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "Retournez voir {npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "Au niveau 10, {npc:2131}, le maître des guerriers dans l'auberge de {area:159}, vous envoie voir {npc:1496}, près du cimetière à la lisière ouest de {area:159}. Cette voie et celle de {npc:5810} s'excluent : supprimez {quest:1505} ou {quest:1498} de votre journal si vous en avez une.",
	-- ["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "Au niveau 10, {npc:252377} se tient avec les maîtres près de la porte ouest de {area:16638}. Un sectateur, {npc:257196}, détient le bouclier de sa famille au {area:16629}.",
	-- ["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "Au niveau 10, {npc:3063}, le maître des guerriers du {area:222}, vous envoie voir {npc:5810} dans les {zone:1413}. {npc:3041}, aux {zone:1456}, la propose aussi.",
	-- ["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "Au niveau 10, {npc:3169}, le maître des guerriers de la caserne de {area:362}, vous envoie voir {npc:5810} dans les {zone:1413}. Sorek, dans la {object:172958} d'{zone:1454}, la propose aussi. Tout guerrier de la Horde peut prendre l'une des deux voies, jamais les deux : vous allez de toute façon dans les {zone:1420} au niveau 10 ? {npc:2131}, à l'auberge de {area:159}, propose l'autre : un combat près du cimetière de {area:159} pour la même posture, puis la crypte des Agamand pour une arme de famille.",
	-- ["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "Retournez voir {npc:252377} à {area:16638}. Elle enseigne {spell:71} et vous donne le {item:275290}, un bouclier à utiliser avec. La voie de {npc:5810}, plus bas, donne encore une arme plus tard, une fois en Kalimdor.",
	-- ["Back to {npc:5810} under his tree west of {area:379}."] = "Retournez voir {npc:5810} sous son arbre, à l'ouest du {area:379}.",
	-- ["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "Dillinger se tient près du cimetière, à la lisière ouest de {area:159}. Un Orc, un Troll, un Tauren ou un Éolide qui a pris {quest:1818} auprès de {npc:2131} au lieu de la voie de {npc:5810} est guidé à travers {area:159} à partir d'ici.",
	-- ["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Allez au nord-ouest de {area:16638} jusqu'au {area:16629}. {npc:257196} se tient à l'ouest de l'accès au sanctuaire, parmi les Gardiens, les Mande-esprits et les Maîtres-lames du culte : attirez-les un par un avant de vous attaquer à lui. Il lâche le {item:263993}.",
	-- ["Singed Scales in {area:369}"] = "Écailles roussies à la {area:369}",
	-- ["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "Les quatre Râteliers d'armes Agamand sont dans la {area:158}, au nord des {area:157}, au nord de {area:159}, un râtelier par salle : un dans la salle la plus basse, deux dans les deux salles en haut de l'escalier, un dans la salle au-dessus. Le râtelier à hache se trouve dans un coin sombre. Les morts-vivants de la crypte viennent par groupes de trois ou plus et reviennent vite ; ceux de la salle du haut ne sont pas liés. Les râteliers à hache, à dague et à masse mettent 15 minutes à se remplir après avoir été fouillés.",
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Les quatre Râteliers d'armes Agamand se trouvent parmi les bâtiments des {area:157}, au nord de {area:159}. Les morts-vivants des moulins attaquent à vue.",
	-- ["The {area:158}"] = "La {area:158}",
	-- ["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the {area:380}. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "Le {object:58369} se trouve près d'un chariot cassé, dans le camp Tranchecrin au nord-ouest de {npc:5878}, au nord-est de la {area:380}. Deux Tranchecrins le gardent et leurs chasseurs attirent d'autres hurans : éliminez-les un par un, puis ouvrez le coffre (il se remplit en quelques secondes, un ami peut donc le fouiller aussi).",
	-- ["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "Il vous faut cinq Écailles roussies. Les Lézards-tonnerre (niveau 9-10) et les Foudroyants (10-11) vivent au fond de la crevasse de la {area:369}, au nord-ouest de {zone:1411}, au sud d'{zone:1454} : depuis le pont des {zone:1413}, tournez à gauche et suivez la rivière vers le nord pour y entrer. Les deux lâchent une écaille environ quatre fois sur cinq ; les deux lancent {spell:5401}.",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} se tient à {area:159}. {npc:6390} attend dans le mausolée sur la colline juste au nord du bourg : ouvrez la grille et combattez-le.",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} est à l'auberge, la {area:2119}, à {area:159}.",
	-- ["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500} est dans la {area:2119}, l'auberge du côté est de {area:159}.",
	-- ["{npc:252377} in {area:16638}"] = "{npc:252377} à {area:16638}",
	-- ["{npc:5810} at {area:379}"] = "{npc:5810} au {area:379}",
	-- ["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the {area:380}."] = "{npc:5810} est facile à manquer : il se tient sous un petit auvent près d'un grand arbre juste à l'ouest du {area:379}, en contrebas du côté sud de la route, le poste en vue à l'est. Aller tout droit au sud depuis le poste ne mène pas à lui. Depuis {zone:1411}, traversez le pont vers l'ouest ; depuis {zone:1412}, allez au nord en passant la {area:380}.",
	-- ["{npc:5878}'s hut sits on top of {area:1699}, east of the {area:380}. Most slopes are too steep: climb the broad ridge on the north or east side."] = "La hutte de {npc:5878} se dresse au sommet de la {area:1699}, à l'est de la {area:380}. La plupart des pentes sont trop raides : montez par la large crête du côté nord ou est.",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} et une arme à une main au choix au niveau 10.",
	-- ["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "{spell:71} au niveau 10 et une arme à une main de votre choix : la voie de {npc:5810}, la crypte de {area:159}, ou le bouclier Brise-ciel.",
}
