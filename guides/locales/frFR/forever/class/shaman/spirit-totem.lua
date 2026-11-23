-- French (frFR): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} et {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; the Classic item choice may be gone in Forever."] = "De l'expérience et de l'or au niveau 50, avec une fin au {area:1417} ; le choix d'objet de Classic a peut-être disparu dans Forever.",
	["Experience and gold"] = "Expérience et or",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "Au niveau 50, {npc:13417}, maître des chamans dans la {object:172957}, demande les quatre éléments pour {npc:6176}.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {area:1640} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "Au niveau 50, {npc:3032}, maître des chamans sur la {area:1640} aux {zone:1456}, demande les quatre éléments pour {npc:6176}. Éolides : la page de quête de Forever ne réserve {quest:8410} et {quest:8412} qu'aux Orcs, Taurens et Trolls ; si {npc:3032} n'a rien pour vous, la quête {quest:8411} de {npc:6176} lui-même est ouverte à toutes les races de la Horde, mais {quest:8412} qui la suit peut encore vous refuser.",

	-- Step 3: The four elements
	["The four elements"] = "Les quatre éléments",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon · {area:69} Lakeshire
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {area:320} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "Un exemplaire de chaque : {item:7069}, Feu, Terre et Eau ; les quatre s'échangent, l'hôtel des ventes est donc le plus rapide. Pour les farmer, les {zone:1417} ont les exilés près du {area:320} (niveau 38-39, environ une victime sur huit à dix, réapparition en moins de sept minutes) : les Exilés foudroyants au sud-est (air), les Exilés grondants au sud-ouest (terre), les Exilés ardents loin au nord-ouest (feu), et le {npc:2794} loin au sud-ouest (eau, environ une fois sur sept). L'eau s'obtient plus facilement sur les Flaques d'eau élémentaire d'{zone:1447} (deux fois sur cinq) ou sur {npc:14269} près de {area:69}, dans les Carmines.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069} : Exilés foudroyants",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068} : Exilés ardents",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067} : Exilés grondants",
	-- {item:7070} Elemental Water · {npc:2794} Summoned Guardian · {zone:1447} Azshara
	["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "{item:7070} : le {npc:2794}, ou les flaques d'eau d'{zone:1447}",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {area:272} follow the river east of town north into the hills."] = "{npc:6176} campe dans les ruines à l'est des {zone:1416} : depuis {area:272}, suivez vers le nord, dans les collines, la rivière à l'est du village.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "Œil d'araignée et griffe d'ours",
	-- {area:813} Bulwark · {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {item:20610} Bloodshot Spider Eye · {spell:3427} Infected Wound · {item:20611} Thick Black Claw · {area:159} Brill
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the {area:813} and on to the west edge of the {zone:1422}, north-west of {area:3197}: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, {spell:3427}) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of {area:159} in Tirisfal."] = "Huit de chaque. Volez ou chevauchez jusqu'au {area:813}, puis jusqu'à la lisière ouest des {zone:1422}, au nord-ouest du {area:3197} : les Rôdeuses venimeuses des brumes (niveau 50-51, elles empoisonnent) donnent l'{item:20610} et les Ours noirs malades (niveau 51-52, {spell:3427}) la {item:20611}, une victime sur cinq chacun ; les deux Vautours putrides du coin lâchent l'un ou l'autre. Les Grizzlys malades et les Rôdeuses pestilentielles, plus gros, plus à l'est, ne les lâchent presque jamais. Quelques ours et rôdeuses errent aussi au sud-est de {area:159}, dans les clairières de Tirisfal.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "Le {area:1417}",
	-- {area:75} Stonard · {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {spell:139} Renew · {npc:3560} Healing Ward
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to {area:75} and ride east. The {area:1417} ({area:1477}) stands in the middle of the {area:74}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others ({spell:139}, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "Un donjon à cinq joueurs : il faut un groupe de cinq, vers le niveau 50-55. Volez jusqu'à {area:75} et chevauchez vers l'est. Le {area:1417} ({area:1477}) se dresse au milieu de l'{area:74} : montez les marches du côté sud de la ruine, plongez dans la salle inondée, nagez vers le fond et suivez les escaliers et les couloirs jusqu'au portail. Deux plumes de chaque couleur, une sur chacun des six mini-boss trolls élites (niveau 51-52) sur les balcons autour de la grande salle ronde du temple, à chaque victime, et chaque joueur ayant la quête ramasse la sienne : Balafreur et {npc:5716} l'ambre, Hukku et Mijan la bleue, Zolo et Loro la verte. Mijan soigne les autres ({spell:139}, une {npc:3560}) : tuez-le en premier ; Hukku invoque des gardiens et lance des Salves d'Éclairs de l'ombre.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "{item:20606} : Balafreur, {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "{item:20607} : Hukku, Mijan",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "{item:20608} : Zolo, Loro",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "{npc:6176} : l'ancien choix d'objet a peut-être disparu, comptez sur l'expérience",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "Au niveau 50, {npc:13417}, le maître des chamans de la {object:172957}, vous envoie voir {npc:6176}.",
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "Au niveau 50, {npc:3032}, maître des chamans à {zone:1456}, vous envoie voir {npc:6176}.",
	-- ["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "De l'expérience et de l'or au niveau 50, avec une fin dans le {area:1417} ; Forever a supprimé le choix d'objet de Classic.",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "Dans les {zone:1422}, les Rôdeuses venimeuses des brumes laissent tomber l'{item:20610} et les Ours noirs malades la {item:20611} (environ une fois sur cinq chacun).",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Un exemplaire de chacun : {item:7069}, Feu élémentaire, Terre élémentaire et Eau élémentaire. Les Exilés des Hautes-terres Arathies les laissent tomber, un élément chacun, environ une fois sur dix : Exilés foudroyants (air), ardents (feu), grondants (terre) et grimpeurs (eau). Ou achetez-les à l'hôtel des ventes.",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Un exemplaire de chacun : {item:7069}, Feu élémentaire, Terre élémentaire et Eau élémentaire. Les Exilés des {zone:1417} les laissent tomber, un élément chacun, environ une fois sur dix : Exilés foudroyants (air), ardents (feu), grondants (terre) et grimpeurs (eau). Ou achetez-les à l'hôtel des ventes.",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "Le {area:1417} ({area:1477}) se trouve sous le {area:74} ; la flèche indique son entrée. Balafreur ou {npc:5716} laissent tomber la {item:20606}, Hukku ou Mijan la bleue, Zolo ou Loro la verte : tous les six sont des trolls élites à l'intérieur. Venez en groupe.",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070} : Exilés grimpeurs",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} campe dans l'est des {zone:1416}, au nord-est de {area:272}.",
}
