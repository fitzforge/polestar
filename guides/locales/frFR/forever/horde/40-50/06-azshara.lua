-- French (frFR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "Chez le maître de vol de {area:3317}, prenez un vol pour {area:1497}.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} se trouve dans {object:36082}.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Prenez le zeppelin pour {zone:1454} à la tour devant {zone:1458}, puis prenez un vol pour {area:431}.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Entrer en {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Chevauchez vers l'est sur la route en quittant Bois-brisé. {npc:11548} attend au {area:1235}, juste à côté de la route, à quelques pas à l'ouest de la {area:3137} de l'Alliance : arrivez par l'ouest et évitez les Sentinelles d'Azshara ({npc:11276}) et Jarrodenus (élite).",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "Bien-nés et satyres Haldarr",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Les fantômes bien-nés hantent les ruines juste au nord du sanctuaire ; les satyres Haldarr campent un peu plus au nord.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Retournez voir {npc:11548} au sanctuaire ; restez à l'ouest des gardes de {area:3137}.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Suivez la route vers le nord jusqu'à {area:1237}, le camp de la Horde.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, à la lisière est du camp : pas d'expérience, seulement une téléportation vers la tour d'Azshara",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Plumes d'hippogryphe sans défaut",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Les Hippogryphes Tête-tonnerre survolent les collines juste au sud de {area:1237}.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Allez au nord-est jusqu'au camp du gobelin sur les falaises au-dessus de {area:1227}.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Le camp des elfes de sang se trouve juste au sud de {npc:8420}. Ses quatre pièces d'équipement sont dans les caisses autour du camp.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Allez au sud-ouest jusqu'aux ruines. Les quatre tablettes s'y trouvent, gardées par les nagas Fouette-bile ; toute Sirène ou tout Myrmidon Fouette-bile peut porter la rune de {npc:8420}.",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Retournez au nord-est voir {npc:8420}.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Retournez à l'ouest jusqu'à {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Gardez les livraisons pour {npc:4046}, {npc:8659} et {npc:6522} : vous passerez plus tard par {zone:1456}, {zone:1454} et {zone:1458}.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "La tour de Xylem se dresse sur la falaise juste au nord de {area:1237} ; le chemin monte en lacets par son flanc nord.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "Vers {object:3202}",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Prenez un vol de {area:1237} pour {zone:1454}, sortez par la grande porte jusqu'aux tours des zeppelins et prenez le zeppelin pour {object:3202}.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "Le {object:2076} à côté de {npc:2519}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basilics gueule de fer",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Suivez la route vers le sud ; les basilics se prélassent sur les rochers à l'est, au milieu de la jungle. Leurs éclats tombent souvent.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Continuez au sud jusqu'à {area:35}. {npc:7406} a son atelier sur le cercle supérieur de la baie.",
	["Only once all three robots are home"] = "Seulement une fois les trois robots rentrés",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Retour à {object:3202}",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "Reprenez le zeppelin pour {zone:1454}.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, la Herse",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Gardez le paiement de {npc:8659} et {quest:3504} d'Ag'tor : ils retournent à {area:1237} lors d'une visite ultérieure.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Prenez un vol pour {area:1638} ; c'est sur la route de {area:1099}. Pas encore de trajet aérien là-bas ? Prenez un vol pour {area:378} et traversez {zone:1412} vers l'ouest. Hamuul et {npc:4046} sont sur {area:1639} ; druides et paladins s'entraînent ici ({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} se récolte dans le guide suivant ; le paiement de {npc:4046} retourne à {npc:8587} plus tard.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776} : les ours sont dans {zone:1448}",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Gardez {area:1417} pour {npc:7771}, à {zone:1446}.",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hippogryphes Aigreplume",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Les hippogryphes nichent sur les collines au sud-ouest du camp. Tuez-en un, puis utilisez le récipient miniaturisé sur son corps.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Fées fléchetteuses",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Les dragons féériques voltigent dans les bois juste à l'ouest du camp. Utilisez le récipient sur chacun de ceux que vous tuez.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Marcheurs des bois errants",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Les tréants errent sur les routes forestières entre le camp et le centre de {zone:1444} ; ils sont peu nombreux, cherchez le long des chemins.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Allez au nord-ouest jusqu'à {area:1108} ; {npc:14637} attend sur le quai.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "Géants réduits",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Les Marcheurs des terres et les Géants des falaises parcourent les collines au nord du quai. Réduisez d'abord chacun avec l'{item:18904} : réduits, ils ne sont plus élites. Chaque géant réduit lâche un résidu ; utilisez aussi le récipient miniaturisé sur son corps.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "Elémentaires marins",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Les Elémentaires marins et les Embruns ondoient le long du rivage autour du quai.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Retour à {area:1099}",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, à côté du maître des coursiers du vent",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Le goudron de {npc:7876} et les échantillons de l'Alchimiste Pestlezugg viennent de {zone:1449}.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Suivez la route vers le sud jusqu'à {area:1938} ; {npc:7771} campe à côté. De là, la route vers l'ouest descend dans {zone:1449}, où commence le guide suivant.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Gardez {quest:3444} : le coffre de {npc:7771} s'ouvre lors d'une visite ultérieure.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:6986}, the {object:172959}"] = "{npc:6986}, {object:172959}",
}
