-- French (frFR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957} : gardez-la pour {zone:1451}",
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist · {area:1237} Valormok
	["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "",

	-- Step 2: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 3: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "L'atelier de Liv Rizzlefix se trouve au bout nord des quais de {area:392} ; le {object:149036} est à l'intérieur.",
	["Inside"] = "À l'intérieur",

	-- Step 4: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} Waterseer campe sur le rivage, juste au nord de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "L'eau purifiée retourne à {area:2479}, à {zone:1448} : gardez-la pour plus tard.",

	-- Step 5: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Les caisses de {npc:256386}",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "",

	-- Step 6: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Prendre un vol pour {area:1237}",
	["Crossroads flight master"] = "",

	-- Step 8: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Allez à l'est jusqu'aux ruines sur la côte. Remplissez les quatre fioles du Chimiste Cuely aux bassins le long du rivage ; des nagas Fouette-bile patrouillent entre eux.",

	-- Step 9: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Les elfes de sang campent sur les falaises au nord-est, près de {area:1227}.",

	-- Step 10: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Le camp de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez le {object:151286} sur place, puis tuez le magus.\nAttention : le cristal lié à Rimtori est choisi au hasard. Chacun des deux autres invoque à la place un infernal hostile.",

	-- Step 11: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",

	-- Step 12: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Maître de vol de {area:1237}",

	-- Step 13: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} ({zone:1456}) ; {zone:1454} n'a pas de maître des paladins",

	-- Step 14: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Volez jusqu'à {zone:1454} et entraînez-vous.",

	-- Step 15: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Volez jusqu'à {zone:1454} ; {npc:4485} se trouve dans {object:172958}.",

	-- Step 16: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Vers {zone:1411}",

	-- Step 17: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 18: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, à côté de lui",

	-- Step 19: The Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin à la tour devant {zone:1454} jusqu'à {zone:1420}, puis chevauchez jusqu'à {zone:1458}. Dame Sylvanas règne sur {object:36126}.",

	-- Step 20: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, tout près",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} se rend à {npc:10778}, dans {zone:1422} : gardez-la.",
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Seulement avec {quest:79095} de la boutique d'alchimie de {area:159} dans vos sacs (le guide des Livres de la bibliothèque)",

	-- Step 22: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "",

	-- Step 24: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "La ferme de {npc:10778} est la première à l'est de {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son porte-bonheur ; {npc:11075} garde le chaudron dans le champ.\nAttention : un ou deux morts-vivants combattent généralement à ses côtés, et d'autres seigneurs du chaudron peuvent attaquer après que vous avez utilisé le chaudron.",
	["Upstairs"] = "À l'étage",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Les deux dons d'{item:14047} se rendent plus loin dans le parcours : gardez soixante {item:14047} pour chacun si vous les voulez.",
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Les deux dons d'{item:14047} se rendent plus loin dans l'itinéraire : commencez à mettre de l'{item:14047} de côté.",
	-- ["Fly to the {area:380}"] = "Prendre un vol pour {area:380}",
	-- ["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "Prenez un vol pour {area:1637} ; {npc:4485} Rockmaul se trouve dans {object:172958}.",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Hearth to {area:1637}"] = "Pierre de foyer vers {area:1637}",
	-- ["In the {object:172958}."] = "Dans {object:172958}.",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Dans {object:172961}. Chaque don prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez celles que vous avez sur vous, ignorez les autres.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Dans {object:172961}. Ayez l'Etoffe de laine, l'Etoffe de soie et l'Etoffe de tisse-mage dans vos sacs.",
	-- ["Open {object:149036} for the {item:10556}"] = "Ouvrez le {object:149036} pour obtenir le {item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Le camp de Rimtori se trouve à l'extrémité est du camp de base. Lisez-y le {object:151286}, puis tuez le magus.",
	-- ["Take the zeppelin from the tower outside {zone:1454} to {area:85} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin à la tour devant {zone:1454} jusqu'à {area:85}, puis chevauchez jusqu'à {zone:1458}. Dame Sylvanas règne sur {object:36126}.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "La tour des zeppelins se trouve juste au nord-est de la grande porte de {zone:1454} ; prenez le zeppelin pour {zone:1458}.",
	-- ["Zeppelin to the {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, dans l'Apothicarium",
	-- ["{npc:11044}, in the {object:36072}"] = "{npc:11044}, dans {object:36072}",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} se tient à {area:380}. Ouvrez chaque caisse qu'elle vous remet et rapportez-lui ce qu'elle contient.",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} se rend à {npc:10778}, dans {area:28} : gardez-la.",
}
