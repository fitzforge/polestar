-- French (frFR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 2: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "L'atelier de Liv Rizzlefix se trouve au bout nord des quais de {area:392} ; le {object:149036} est à l'intérieur.",
	["Inside"] = "À l'intérieur",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} Waterseer campe sur le rivage, juste au nord de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "L'eau purifiée retourne à {area:2479}, à {zone:1448} : gardez-la pour plus tard.",

	-- Step 4: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 5: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 6: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957} : gardez-la pour {zone:1451}",

	-- Step 7: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010} travaille dans la Herse.",

	-- Step 8: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1451} Silithus · {zone:2482} Mount Hyjal
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1451} guide's first stop, after {zone:2482}."] = "",

	-- Step 9: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Dans {object:172961}. Chaque don prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez celles que vous avez sur vous, ignorez les autres.",

	-- Step 10: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Dans {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Les deux dons d'{item:14047} se rendent plus loin dans le parcours : gardez soixante {item:14047} pour chacun si vous les voulez.",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} ({zone:1456}) ; {zone:1454} n'a pas de maître des paladins",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Volez jusqu'à {zone:1454} et entraînez-vous.",

	-- Step 13: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Vers {zone:1411}",

	-- Step 14: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 15: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390} et {npc:8393} travaillent dans l'Apothicarium.",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, à côté de lui",

	-- Step 16: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522} se trouve dans le {object:36073}.",

	-- Step 17: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "Dame Sylvanas se tient dans {object:36126}.",

	-- Step 20: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, tout près",

	-- Step 21: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} se rend à {npc:10778}, dans {zone:1422} : gardez-la.",

	-- Step 22: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Seulement avec {quest:79095} de la boutique d'alchimie de {area:159} dans vos sacs (le guide des Livres de la bibliothèque)",

	-- Step 24: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "Sortez de {zone:1458} vers l'est par la route ; {area:152} garde l'accès aux {zone:1422}.",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615} : les termites sont à {area:2627}, dans le guide suivant",

	-- Step 26: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "La ferme de {npc:10778} est la première à l'est de {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son porte-bonheur ; {npc:11075} garde le chaudron dans le champ.\nAttention : un ou deux morts-vivants combattent généralement à ses côtés, et d'autres seigneurs du chaudron peuvent attaquer après que vous avez utilisé le chaudron.",

	-- Step 27: Janice Felstone
	["Upstairs"] = "À l'étage",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north to {npc:8420} with the rune, then south-west along the road."] = "Retournez au nord auprès de {npc:8420} avec la rune, puis suivez la route vers le sud-ouest.",
	-- ["Back north-west to {npc:8420}."] = "Retournez au nord-ouest auprès de {npc:8420}.",
	-- ["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Retournez au Tome sin'dorei : remettez les sceaux, puis utilisez-le pour invoquer {npc:8578}.\nAttention : le cristal lié à Rimtori est choisi au hasard. Chacun des deux autres invoque un infernal hostile à la place.",
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Les deux dons d'{item:14047} se rendent plus loin dans l'itinéraire : commencez à mettre de l'{item:14047} de côté.",
	-- ["Crossroads flight master"] = "Maître de vol de la Croisée",
	-- ["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Chacun des trois officiers du camp (53) porte un sceau : {npc:247006} au centre du camp, {npc:247013} à son extrémité est, et {npc:246991}, qui patrouille sa moitié ouest : affrontez-le du côté est de sa ronde, là où pointe la Flèche.\nAttention : le {npc:250023}, un élite de niveau 55-57, se tient à la lisière ouest du camp, près du bout de la ronde de Hawkhelm : attendez que Hawkhelm revienne vers l'est.",
	-- ["Fly to the {area:380}"] = "Prendre un vol pour {area:380}",
	-- ["Fly to {area:1237}"] = "Prendre un vol pour {area:1237}",
	-- ["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "Prenez un vol pour {area:1637} ; {npc:4485} Rockmaul se trouve dans {object:172958}.",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "Prenez un vol pour {zone:1454} ; {npc:4485} se trouve dans la {object:172958}, {npc:3326} et {npc:8659} dans {object:172960}.",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Volez jusqu'à {zone:1454} ; {npc:4485} se trouve dans {object:172958}.",
	-- ["Hearth to {area:1637}"] = "Pierre de foyer vers {area:1637}",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Dans {object:172961}. Ayez l'Etoffe de laine, l'Etoffe de soie et l'Etoffe de tisse-mage dans vos sacs.",
	-- ["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "Gardez les livraisons pour {npc:8659}, {npc:6522}, {npc:4485} et {npc:3326} : vous passez ensuite par {zone:1454} et {zone:1458}. Celle de Magatha, à {zone:1456}, est hors de cet itinéraire : laissez-la.",
	-- ["Makrinni Burrowers"] = "Fouisseurs makrinni",
	-- ["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Continuez au nord-est à travers le centre d'{zone:1447} : {npc:235903} campe près de la route.",
	-- ["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "Seulement si {quest:4494} n'est pas encore faite : {npc:7010} travaille dans la Herse. Pestlezugg la reprend à {area:976}, sur le chemin d'Un'Goro dans le Guide {zone:1423}.",
	-- ["Open {object:149036} for the {item:10556}"] = "Ouvrez le {object:149036} pour obtenir le {item:10556}",
	-- ["Ride back west to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Allez à l'est jusqu'aux ruines sur la côte. Remplissez les quatre fioles du Chimiste Cuely aux bassins le long du rivage ; des nagas Fouette-bile patrouillent entre eux.",
	-- ["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Chevauchez vers l'est jusqu'aux ruines sur la côte. Les quatre tablettes se trouvent parmi les ruines, gardées par des nagas Fouette-bile (52-55) : attirez-les un par un.",
	-- ["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Remontez la route vers le nord jusqu'à la Croisée ; {npc:256386} s'y tient. Ouvrez chaque caisse qu'elle vous remet et rapportez-lui ce qu'elle contient. Prenez ensuite un vol depuis la Croisée pour {area:1237}.",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Chevauchez au nord-est jusqu'au camp du gobelin sur les falaises au-dessus de {area:1227}, juste au nord des elfes de sang.",
	-- ["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Allez au sud jusqu'à la lisière nord des {area:1221}. Les Sirènes et les Myrmidons Fouette-bile (50-52) qui s'y trouvent portent la rune de {npc:8420} ; elle tombe rarement, alors longez la lisière jusqu'à l'obtenir.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez-y le {object:151286}, puis tuez le magus.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez le {object:151286} sur place, puis tuez le magus.\nAttention : le cristal lié à Rimtori est choisi au hasard. Chacun des deux autres invoque à la place un infernal hostile.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez-y le {object:151286} : sur Forever, le Tome sin'dorei à côté demande ensuite les sceaux des trois officiers du camp.",
	-- ["South-west along the road: {npc:235903} takes the satyrs."] = "Suivez la route vers le sud-ouest : {npc:235903} prend les satyres.",
	-- ["Take the zeppelin from the tower outside {zone:1454} to {area:85} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin à la tour devant {zone:1454} jusqu'à {area:85}, puis chevauchez jusqu'à {zone:1458}. Dame Sylvanas règne sur {object:36126}.",
	-- ["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin à la tour devant {zone:1454} jusqu'à {zone:1420}, puis chevauchez jusqu'à {zone:1458}. Dame Sylvanas règne sur {object:36126}.",
	-- ["The Legashi satyrs"] = "Les satyres legashi",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Les satyres legashi (51-52) occupent les collines au nord du camp des elfes de sang : {npc:235903} en veut cinq de chaque type.",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Les Fouisseurs makrinni (50-51) creusent le sable juste à l'est des ruines, sur le chemin du nord-est ; eux et les caches enfouies là donnent les Fragments de trésor de Bien-né.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Les elfes de sang campent sur les falaises au nord-est, près de {area:1227}.\nAttention : un {npc:250023}, un élite de niveau 55-57, se tient à la lisière ouest du camp : occupez-vous des elfes de sang par le côté est.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Les elfes de sang campent sur les falaises au nord-est, près de {area:1227}. Les quatre pièces d'équipement de {npc:8420} se trouvent dans les caisses autour du camp ; les Arcanistes elfes de sang portent la baguette de {npc:247473}.\nAttention : un {npc:250023}, un élite de niveau 55-57, se tient à la lisière ouest du camp : occupez-vous des elfes de sang par le côté est.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "La tour des zeppelins se trouve juste au nord-est de la grande porte de {zone:1454} ; prenez le zeppelin pour {zone:1458}.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "La tour de Xylem se dresse sur la falaise juste au nord de {area:1237} : {npc:8395}, à {area:1237}, vous y téléporte gratuitement (parlez-lui) ; sinon, le chemin serpente par son flanc nord.",
	-- ["Zeppelin to the {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221} : tuez-les au passage",
	-- ["{area:1237} flight master"] = "Maître de vol de {area:1237}",
	-- ["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, sur les Arcanistes elfes de sang",
	-- ["{item:246721}, from {npc:246991}"] = "{item:246721}, sur {npc:246991}",
	-- ["{item:246722}, from {npc:247013}"] = "{item:246722}, sur {npc:247013}",
	-- ["{item:246725}, from {npc:247006}"] = "{item:246725}, sur {npc:247006}",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, dans l'Apothicarium",
	-- ["{npc:11044}, in the {object:36072}"] = "{npc:11044}, dans {object:36072}",
	-- ["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903} : {quest:86746}, les satyres au nord du camp des elfes de sang",
	-- ["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473} : {quest:91569}, une baguette sur les arcanistes elfes de sang",
	-- ["{npc:256386}'s crates"] = "Les caisses de {npc:256386}",
	-- ["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- ["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "{npc:4485}, {object:172958} : rapportée de la première visite d'{zone:1447}, sinon prenez-la ici pour {npc:8576} à {area:1237}",
	-- ["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576} : {quest:91531}, pour {npc:4485} à {zone:1454}",
	-- ["{npc:8578}'s camp"] = "Le camp de {npc:8578}",
	-- ["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587} : le tome va à {npc:3326} à {zone:1454}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} se rend à {npc:10778}, dans {area:28} : gardez-la.",
	-- ["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538} : pour {npc:8587} à {area:1237}",
	-- ["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",
}
