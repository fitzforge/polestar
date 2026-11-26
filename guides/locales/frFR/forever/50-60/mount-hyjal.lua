-- French (frFR): the guide forever/50-60/mount-hyjal (forever/50-60/mount-hyjal.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus
	["About 100 quests in Forever's new endgame zone, 57 to 59, then on to {zone:1451}."] = "Une centaine de quêtes dans la nouvelle zone de fin de jeu de Forever, de 57 à 59, puis vers {zone:1451}.",

	-- Step 1: Into Mount Hyjal
	-- {area:616} Mount Hyjal
	["Into {area:616}"] = "Vers {area:616}",
	-- {area:616} Mount Hyjal · {zone:1452} Winterspring · {area:2255} Everlook · {npc:256222} Ketharas · {area:493} Moonglade · {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge · {npc:10201} Lady Hederine
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Hederine Slayers = {npc:7463} Hederine Slayer
	["New in Forever: this guide follows what players did on {area:616}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{area:616} lies south of {zone:1452}. Fly to {area:2255} (from Theramore on the Alliance route; the Horde route already ends there), bind your Hearthstone at the inn (partway through this guide {npc:256222} sends you to {area:493}, and the way there starts in {area:2255}), then ride south down the road through {area:2249} and on through {area:2256}, which leads up into {area:616}.\nCareful: elites stand along the whole way in. Frostmaul Giants and Preservers (59-60) flank the road through {area:2249}, and Hederine Slayers, Initiates and Manastalkers (57-58) line {area:2256} from its mouth to the zone line, with {npc:10201} (61) on its east side. Follow the arrows' line at full speed, never stop or fight on the way, and don't turn off it."] = "Nouveauté de Forever : ce guide suit ce que les joueurs ont fait en {area:616}. Si une étape est fausse, dites-le-nous sur le Discord ou sur GitHub de Polestar et nommez l'étape.\n{area:616} se trouve au sud de {zone:1452}. Volez vers {area:2255} (depuis Theramore sur la route de l'Alliance ; la route de la Horde y aboutit déjà), liez votre pierre de foyer à l'auberge (à mi-chemin de ce guide, {npc:256222} vous envoie en {area:493}, et le chemin pour y aller part de {area:2255}), puis descendez au sud par la route à travers {area:2249} puis par {area:2256}, qui monte jusqu'à {area:616}.\nAttention : des élites se tiennent tout le long du chemin. Les Géants Cognegivre et les Protecteurs Cognegivre (59-60) flanquent la route qui traverse {area:2249}, et les Pourfendeurs Hederine, les Initiées Hederine et les Traque-mana Hederine (57-58) bordent {area:2256} depuis son embouchure jusqu'à la limite de la zone, avec {npc:10201} (61) sur son flanc est. Suivez la ligne des flèches à pleine vitesse, ne vous arrêtez jamais et ne combattez pas en chemin, et n'en sortez pas.",
	-- {area:2249} Frostwhisper Gorge
	["The road through {area:2249}"] = "La route qui traverse {area:2249}",
	-- {area:2256} Darkwhisper Gorge
	["The mouth of {area:2256}"] = "L'embouchure de {area:2256}",
	["Turn west here"] = "Tournez à l'ouest ici",

	-- Step 2: The road in
	["The road in"] = "Le chemin d'entrée",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["{npc:266803} (Alliance) and {npc:266802} (Horde) wait together by the road a little inside the zone."] = "{npc:266803} (Alliance) et {npc:266802} (Horde) attendent ensemble au bord de la route, un peu à l'intérieur de la zone.",
	-- {quest:96833} Venom Maws · {npc:256222} Ketharas
	["{quest:96833}: for {npc:256222}, the hermit"] = "{quest:96833} : pour {npc:256222}, l'ermite",
	-- {quest:96830} Farsight Guided · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	["{quest:96830}: for {npc:244512} in {area:16848}, later in this guide; keep it"] = "{quest:96830} : pour {npc:244512} en {area:16848}, plus loin dans ce guide ; gardez-la",

	-- Step 3: Loose Cog
	-- {npc:256222} Ketharas
	["The cog lies by the path south-west of the camp, on your way to {npc:256222}."] = "L'engrenage se trouve au bord du sentier au sud-ouest du camp, sur le chemin de {npc:256222}.",

	-- Step 4: Ketharas
	-- {npc:256222} Ketharas
	["{npc:256222}, the hermit, lives at the Hermit's Abode a little further south-west. He takes the cog too."] = "{npc:256222}, l'ermite, vit à la Demeure de l'Ermite, un peu plus au sud-ouest. Il prend l'engrenage lui aussi.",
	-- {quest:96796} Woods Workshop · {npc:249235} Kaylaena Springwhisper
	["{quest:96796}: for {npc:249235}, on the way"] = "{quest:96796} : pour {npc:249235}, sur le chemin",

	-- Step 5: Seeds and owl eggs
	["Seeds and owl eggs"] = "Graines et œufs de hibou",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["The seeds and the owl eggs lie on the slopes between the Hermit's Abode and the road you came in on: search north-east up towards {npc:266803} and {npc:266802}."] = "Les graines et les œufs de hibou se trouvent sur les pentes entre la Demeure de l'Ermite et la route par laquelle vous êtes entré : cherchez vers le nord-est, en montant vers {npc:266803} et {npc:266802}.",

	-- Step 7: Kaylaena Springwhisper's workshop
	-- {npc:249235} Kaylaena Springwhisper
	["{npc:249235}'s workshop"] = "L'atelier de {npc:249235}",
	-- {npc:249235} Kaylaena Springwhisper · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	["North-west over the shrub field to {npc:249235}'s workshop on the slope above it. {quest:91923}, an elite (level 57), patrols the field, and {npc:248709}, an elite ancient (level 56), stands in its middle: give both room. Ghansurok, an elite chimaera (level 61), prowls around the workshop itself: see where he is before you ride up to {npc:249235}."] = "Au nord-ouest, par le champ d'arbustes, jusqu'à l'atelier de {npc:249235}, sur la pente au-dessus. {quest:91923}, un élite (niveau 57), patrouille dans le champ, et {npc:248709}, un ancestral élite (niveau 56), se tient en son milieu : laissez-leur de la place tous les deux. Ghansurok, une chimère élite (niveau 61), rôde autour de l'atelier lui-même : regardez où il est avant de monter vers {npc:249235}.",
	-- {quest:92008} Premiere Parts · {npc:228216} Nami · {area:2255} Everlook · {area:493} Moonglade
	["{quest:92008}: for {npc:228216} in {area:2255}; you go there from {area:493} at the end of this guide"] = "{quest:92008} : pour {npc:228216} en {area:2255} ; vous y allez depuis {area:493} à la fin de ce guide",

	-- Step 8: The ancients' outpost
	["The ancients' outpost"] = "L'avant-poste des ancestraux",
	-- {npc:248395} Tainted Shrubbery · {item:247892} Verdant Leaves · {npc:248367} Hyacinth · {quest:91755} Leaves to Ligatures · {npc:249235} Kaylaena Springwhisper · {npc:260626} Bluebell · {npc:265586} Thylaen · {npc:248366} Fraxinus
	["South down the west side of the shrub field to the ancients' outpost. Leave the {npc:248395} for now: their {item:247892} drop only once {npc:248367}'s {quest:91755} is in your log, and the guide brings you back to the shrub field for the leaves and {npc:249235}'s kills together. {npc:260626}, the flight mistress, waits by the outpost; {npc:248367} and {npc:265586} stand with the ancient {npc:248366}."] = "Vers le sud le long du côté ouest du champ d'arbustes jusqu'à l'avant-poste des anciens. Laissez les {npc:248395} pour l'instant : leurs {item:247892} ne tombent que lorsque {quest:91755} de {npc:248367} est dans votre journal, et le guide vous ramène au champ d'arbustes pour les feuilles et les victimes de {npc:249235} en même temps. {npc:260626}, la maîtresse de vol, attend près de l'avant-poste ; {npc:248367} et {npc:265586} se tiennent avec l'ancien {npc:248366}.",

	-- Step 9: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite (level 57) and patrols the shrub field: grouping up is advised."] = "{quest:91923} est élite (niveau 57) et patrouille dans le champ d'arbustes : il est conseillé de se grouper.",

	-- Step 10: Soil and venison
	["Soil and venison"] = "Terre et venaison",
	-- {npc:256222} Ketharas · {npc:248709} Sunderbark
	-- plural, as words: Hyjal Stags = {npc:248041} Hyjal Stag
	["The untainted soil lies in the fields south and east of the outpost; Hyjal Stags graze there too, and their venison is for {npc:256222}'s stew.\nCareful: {npc:248709} (56), an elite treant, walks the fields to the south-east around 60,78: give him room."] = "La terre intacte se trouve dans les champs au sud et à l'est de l'avant-poste ; les Cerfs d'Hyjal y paissent aussi, et leur venaison est pour le ragoût de {npc:256222}.\nAttention : {npc:248709} (56), un tréant élite, parcourt les champs au sud-est vers 60,78 : laissez-lui de la place.",

	-- Step 11: The three wrecks
	["The three wrecks"] = "",
	-- {npc:256222} Ketharas · {item:269944} Bag of Enchanted Seeds
	["The three wrecks {npc:256222} named lie at the east end of the fields: use the {item:269944} beside each, the catapult and the flying machine first, then the ballista a little north of them."] = "",
	-- {item:269944} Bag of Enchanted Seeds · {npc:266887} Ruined Catapult
	["{item:269944}: the {npc:266887}"] = "",
	-- {item:269944} Bag of Enchanted Seeds · {npc:266886} Ruined Flying Machine
	["{item:269944}: the {npc:266886}"] = "",
	-- {item:269944} Bag of Enchanted Seeds · {npc:262036} Ruined Ballista
	["{item:269944}: the {npc:262036}"] = "",

	-- Step 12: The shrub field
	["The shrub field"] = "Le champ d'arbustes",
	-- {npc:248395} Tainted Shrubbery · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	-- plural, as words: Scarlet Dart Tubers = {item:267289} Scarlet Dart Tuber
	-- was: ["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. The ruined ballista stands at the field's north-eastern edge: plant the last seed there. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "Au nord, vers le champ d'arbustes : les {npc:248395} laissent tomber les feuilles, et les Tubercules-flèches écarlates poussent sur le sol dégagé, la plupart dans la moitié ouest du champ. La baliste en ruines se tient à la lisière nord-est du champ : plantez la dernière graine là. Restez à l'écart de {quest:91923} et de {npc:248709}, les élites du champ."
	["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "",

	-- Step 13: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite: grouping up is advised. He walks the shrub field."] = "{quest:91923} est élite : il est conseillé de se grouper. Il parcourt le champ d'arbustes.",

	-- Step 14: Ketharas
	["South-east back to the Hermit's Abode."] = "Au sud-est, retour à la Demeure de l'Ermite.",

	-- Step 15: Ketharas's shrine
	-- {npc:256222} Ketharas
	["{npc:256222}'s shrine"] = "Le sanctuaire de {npc:256222}",
	["The shrine is a pair of standing stones west of the Hermit's Abode, on the way back to the outpost: bury the remains there."] = "Le sanctuaire est un couple de menhirs à l'ouest de la Demeure de l'Ermite, sur le chemin du retour vers l'avant-poste : enterrez les restes là-bas.",

	-- Step 17: The ancients' outpost
	["West to the outpost."] = "À l'ouest, vers l'avant-poste.",
	-- {npc:248366} Fraxinus
	["put the poultice on {npc:248366}"] = "appliquez le cataplasme sur {npc:248366}",

	-- Step 19: Fine Feathered Friend
	-- {quest:91923} Celastrus the Bitter · {npc:248366} Fraxinus · {quest:95766} Fine Feathered Friend · {npc:257753} Curious Crow · {area:17050} Felblood Scar
	["With {quest:91923} handed in, {npc:248366} offers {quest:95766}: the {npc:257753} at {area:17050} takes it later in this guide."] = "",

	-- Step 20: The Dying Ancients
	-- {npc:248709} Sunderbark
	["{npc:248709} is an elite corrupted ancient (level 56) in the middle of the shrub field, back east: grouping up is advised."] = "{npc:248709} est un ancestral corrompu élite (niveau 56) au milieu du champ d'arbustes, à l'est : il est conseillé de se grouper.",

	-- Step 21: Sunderbark
	-- {npc:248709} Sunderbark
	["{npc:248709} is elite: grouping up is advised."] = "{npc:248709} est élite : il est conseillé de se grouper.",
	["plant the seed in his remains"] = "plantez la graine dans ses restes",

	-- Step 23: The Curious Crow
	-- {npc:257753} Curious Crow
	["The {npc:257753}"] = "Les {npc:257753}",
	-- {area:17050} Felblood Scar · {npc:257753} Curious Crow
	["West of the outpost to {area:17050}: the {npc:257753} perches at its southern end."] = "À l'ouest de l'avant-poste, vers {area:17050} : les {npc:257753} se perchent à son extrémité sud.",

	-- Step 24: Felflick
	-- {npc:263757} Felflick
	["North to {npc:263757}, a demon caged in the middle of the scar. He stood at the spot marked here every time he was met in the recording, south of where the quest data puts him."] = "Au nord, vers {npc:263757}, un démon enfermé au milieu de la balafre. Il se tenait à l'endroit indiqué ici chaque fois qu'on l'a rencontré dans l'enregistrement, au sud de là où le placent les données de quête.",

	-- Step 25: The Ashen camp
	["The Ashen camp"] = "Le camp des Cendrés",
	-- plural, as words: Ashen Acolytes = {npc:260422} Ashen Acolyte · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Ashen Acolytes hold the camp at the north of the scar. Not every Acolyte carries notes: keep killing them after the twelve kills until you have all twelve notes.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: pull the Acolytes away from them."] = "Les Acolytes cendrés Cendrés tiennent le camp au nord de la balafre. Chaque acôtrel ne porte pas de notes : continuez à les tuer après les douze premières jusqu'à ce que vous ayez les douze notes.\nAttention : les Limons de cendre vil éveillés (58, élite) suintent sur la balafre : éloignez les acôtres d'eux.",

	-- Step 27: Fel-slime crystals
	["Fel-slime crystals"] = "Cristaux de gelée gangrenée",
	-- {npc:263757} Felflick · {npc:257753} Curious Crow
	["The crystals grow in the scar west and south of {npc:263757}. The pristine one turned up at the scar's southern end, close to the {npc:257753}, at the spot marked."] = "Les cristaux poussent dans la balafre à l'ouest et au sud de {npc:263757}. Celui qui est intact est apparu à l'extrémité sud de la balafre, près des {npc:257753}, à l'endroit indiqué.",

	-- Step 28: The Curious Crow
	["The Crow is just south of the pristine crystal."] = "Le Corbeau est juste au sud du cristal intact.",

	-- Step 29: Slime ooze as you go
	["Slime ooze as you go"] = "Du limon en chemin",
	-- plural, as words: Noxious Slimes = {npc:243509} Noxious Slime · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Noxious Slimes crawl all over the scar's southern half, and not every one leaves ooze: kill the ones you pass from here on.\nCareful: Awakened Fel Ash Slimes (elites, 58) ooze among the slimes: leave them be."] = "Les Limons nocifs rampent dans toute la moitié sud de la balafre, et tous ne laissent pas du limon : tuez ceux que vous croisez à partir d'ici.\nAttention : les Limons de cendre vil éveillés (élites, 58) suintent parmi les limons : laissez-les tranquilles.",

	-- Step 31: The warlocks
	["The warlocks"] = "Les démonistes",
	-- {npc:260440} Brashann Grimdark
	-- plural, as words: Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The three warlocks and {npc:260440} are in and around the Ashen camp at the north of the scar.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: keep clear of them."] = "Les trois démonistes et {npc:260440} sont dans le camp des Cendrés et autour, au nord de la balafre.\nAttention : les Limons de cendre vil éveillés (58, élite) suintent sur la balafre : restez à l'écart d'eux.",

	-- Step 33: The bone pile
	["The bone pile"] = "Le tas d'os",
	-- {npc:264306} Awakened Fel Ash Slime
	["West to the bone pile by the slime pools: throw the warlocks' bones on it, then hand the quest in at the pile itself. Handing it in wakes the {npc:264306}, an elite (level 58) that hits hard: unless you are grouped for it, hand in and ride clear at once."] = "À l'ouest, vers le tas d'os près des mares de limon : jetez les os des démonistes dessus, puis rendez la quête au tas lui-même. La rendre réveille {npc:264306}, un élite (niveau 58) qui frappe fort : à moins d'être groupé pour lui, rendez-la et éloignez-vous au galop aussitôt.",

	-- Step 34: Amalgamated Marrow
	-- {npc:264306} Awakened Fel Ash Slime
	["The bone pile wakes the {npc:264306}, an elite (level 58) that hits hard: grouping up is advised."] = "Le tas d'os réveille {npc:264306}, un élite (niveau 58) qui frappe fort : il est conseillé de se grouper.",

	-- Step 35: Prickly pinecones
	["Prickly pinecones"] = "Pommes de pin piquantes",
	["The pinecones lie under the healthy trees just south of the bone pile, on the scar's south-western rim, and a few east of the Crow."] = "Les pommes de pin se trouvent sous les arbres sains juste au sud du tas d'os, sur le pourtour sud-ouest de la balafre, et quelques-unes à l'est du Corbeau.",

	-- Step 36: Felflick
	-- {npc:263757} Felflick
	["{npc:263757}: decide his fate"] = "{npc:263757} : décidez de son sort",

	-- Step 37: Finish the slime ooze
	["Finish the slime ooze"] = "Finissez le limon",
	["The slimes are thickest in the scar's south-western corner."] = "Les limons sont les plus nombreux dans le coin sud-ouest de la balafre.",

	-- Step 40: The Ashen workstations
	["The Ashen workstations"] = "Les postes de travail cendrés",
	["Four workstations stand in the Ashen camp: throw a pinecone at each, from the south up."] = "Quatre postes de travail se tiennent dans le camp des Cendrés : lancez une pomme de pin sur chacun, de bas en haut.",
	["Slime Workstation"] = "Poste de limon",
	["Alchemy Workstation"] = "Poste d'alchimie",
	["Disease Workstation"] = "Poste de maladie",
	["Vessel Workstation"] = "Poste de récipient",

	-- Step 41: The Curious Crow
	-- {quest:91881} The Western Post · {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["{quest:91881}: for {npc:244517} in {area:16848}, later in this guide; keep it"] = "{quest:91881} : pour {npc:244517} en {area:16848}, plus loin dans ce guide ; gardez-la",
	-- {quest:91881} The Western Post · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{quest:91881}: for {npc:244511} in {area:16848}, later in this guide; keep it"] = "{quest:91881} : pour {npc:244511} en {area:16848}, plus loin dans ce guide ; gardez-la",

	-- Step 42: Velician
	-- {npc:278305} Velician
	["West across the slope from the scar: {npc:278305} waits alone."] = "À l'ouest, de l'autre côté de la pente depuis la balafre : {npc:278305} attend seul.",

	-- Step 44: Ketharas
	["East across the foothills to the Hermit's Abode."] = "À l'est, par les contreforts, jusqu'à la Demeure de l'Ermite.",

	-- Step 45: Fly to Moonglade
	-- {area:493} Moonglade
	["Fly to {area:493}"] = "Volez vers {area:493}",
	-- {npc:260626} Bluebell · {area:493} Moonglade · {spell:18960} Teleport: Moonglade · {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {zone:1448} Felwood
	["Back west to {npc:260626} at the ancients' outpost and fly to {area:493}. Druids: {spell:18960} is quicker. (No flight path to {area:493} yet? The road in is {area:1769}'s tunnel, from {zone:1452} or {zone:1448}.)"] = "Retour à l'ouest, vers {npc:260626} à l'avant-poste des ancestraux, et volez vers {area:493}. Druides : {spell:18960} est plus rapide. (Pas encore de chemin de vol vers {area:493} ? La route y passe par le tunnel de {area:1769}, depuis {zone:1452} ou {zone:1448}.)",
	-- {npc:260626} Bluebell
	["{npc:260626}, the flight mistress"] = "{npc:260626}, la maîtresse de vol",

	-- Step 46: Fly to Moonglade
	-- {area:493} Moonglade · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Fly to {area:493} from {area:2255}'s flight master. No flight path to {area:493} yet? The way in is the tunnel through {area:1769}, at the western end of {zone:1452}."] = "Volez vers {area:493} depuis la maîtresse de vol de {area:2255}. Pas encore de chemin de vol vers {area:493} ? Le chemin passe par le tunnel à travers {area:1769}, à l'extrémité ouest de {zone:1452}.",

	-- Step 47: Dendrite Starblaze
	-- {area:2361} Nighthaven · {npc:11802} Dendrite Starblaze
	["North into {area:2361}: {npc:11802} stands in the north-east of the village, upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Au nord, vers {area:2361} : {npc:11802} se tient au nord-est du village, à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 48: Orokai
	-- {npc:216289} Orokai
	["South-west to {npc:216289}, the ancient. Talk to him again when you are ready and watch what he shows you."] = "Au sud-ouest, vers {npc:216289}, l'ancestral. Parlez-lui à nouveau quand vous êtes prêt et regardez ce qu'il vous montre.",
	-- {npc:216289} Orokai
	["{npc:216289}: ready to watch"] = "{npc:216289} : prêt à regarder",

	-- Step 49: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {quest:93773} The Pact · {npc:256222} Ketharas
	["{quest:93773}: for {npc:256222}"] = "{quest:93773} : pour {npc:256222}",

	-- Step 50: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:11802} Dendrite Starblaze · {zone:1457} Darnassus
	["{quest:1123}'s house stands in {area:2361}, a short walk from {npc:11802}: hand her the letter from {zone:1457} on the way to the flight master."] = "La maison de {quest:1123} se trouve en {area:2361}, à une courte marche de {npc:11802} : remettez-lui la lettre de {zone:1457} en allant vers la maîtresse de vol.",
	-- {npc:13220} Layo Starstrike · {zone:1451} Silithus
	["For {npc:13220} in {zone:1451}, on the next guide: keep it"] = "Pour {npc:13220} en {zone:1451}, dans le guide suivant : gardez-la",

	-- Step 51: Rabine Saturna
	-- {zone:1457} Darnassus · {quest:1123} Rabine Saturna · {quest:1124} Wasteland · {area:2361} Nighthaven
	["The letter from {zone:1457} is already with {quest:1123}: take {quest:1124} from her, in her house in {area:2361}."] = "La lettre de {zone:1457} est déjà chez {quest:1123} : prenez {quest:1124} auprès d'elle, dans sa maison à {area:2361}.",

	-- Step 52: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",
	-- {area:493} Moonglade · {area:2255} Everlook · {npc:249235} Kaylaena Springwhisper
	["South to {area:493}'s flight master (the Alliance's at the southern end of the valley, the Horde's at its south-western end) and fly to {area:2255} for {npc:249235}'s parts order."] = "Au sud, vers la maîtresse de vol de {area:493} (celle de l'Alliance à l'extrémité sud de la vallée, celle de la Horde à son extrémité sud-ouest) et volez vers {area:2255} pour la commande de pièces de {npc:249235}.",

	-- Step 53: Nami
	-- {npc:228216} Nami · {area:2255} Everlook · {area:16853} Tainted Foothills · {npc:249235} Kaylaena Springwhisper
	["{npc:228216} stands between {area:2255}'s two flight masters. Her crate holds fragile cells that fizzle out in time and when knocked about: fly straight back to the {area:16853} and take it to {npc:249235} without detours or fights (about four minutes in the recording). If it fizzles out anyway, {npc:228216} fills it again."] = "{npc:228216} se tient entre les deux maîtresses de vol de {area:2255}. Sa caisse contient des cellules fragiles qui se dissipent avec le temps et quand on les secoue : volez directement vers {area:16853} et portez-la à {npc:249235} sans détour ni combat (environ quatre minutes dans l'enregistrement). Si elle se dissipe quand même, {npc:228216} la remplit à nouveau.",

	-- Step 54: Fly to the Tainted Foothills
	-- {area:16853} Tainted Foothills
	["Fly to the {area:16853}"] = "Volez vers {area:16853}",

	-- Step 55: Kaylaena Springwhisper's workshop
	-- {npc:260626} Bluebell
	["North from {npc:260626} to the workshop, crate first. Watch for Ghansurok, the elite chimaera (level 61) that prowls around the workshop."] = "Au nord, depuis {npc:260626} jusqu'à l'atelier, la caisse d'abord. Surveillez Ghansurok, la chimère élite (niveau 61) qui rôde autour de l'atelier.",
	["deliver the crate before it fizzles"] = "livrez la caisse avant qu'elle ne se dissipe",
	-- {quest:92011} Rubble Rummage · {area:16866} Dae'gun
	["{quest:92011}: in {area:16866}, later in this guide; keep it"] = "{quest:92011} : en {area:16866}, plus loin dans ce guide ; gardez-la",

	-- Step 56: Ketharas
	["South-east to the Hermit's Abode."] = "Au sud-est, vers la Demeure de l'Ermite.",
	-- {quest:96930} The Capricious Corvid · {npc:257753} Curious Crow
	["{quest:96930}: for the {npc:257753}, later in this guide"] = "{quest:96930} : pour les {npc:257753}, plus loin dans ce guide",
	-- {quest:92171} Taking to New Heights · {npc:254131} Skylord Omnuron
	["{quest:92171}: for {npc:254131}, later in this guide"] = "{quest:92171} : pour {npc:254131}, plus loin dans ce guide",

	-- Step 57: The Curious Crow
	-- {npc:257753} Curious Crow · {area:17050} Felblood Scar
	["West across the foothills, past the ancients' outpost, to the {npc:257753} at the southern end of {area:17050}."] = "À l'ouest, par les contreforts, devant l'avant-poste des ancestraux, vers les {npc:257753} à l'extrémité sud de {area:17050}.",
	-- {quest:96931} Heading Up the Mountain · {area:17145} Cradle of Tranquility
	["{quest:96931}: for the {area:17145}, later in this guide"] = "{quest:96931} : pour {area:17145}, plus loin dans ce guide",

	-- Step 58: Malorne's Retreat
	-- {area:17144} Malorne's Retreat · {npc:249549} Fenwick Togglespring
	["West along the southern slopes to {area:17144}: {npc:249549}, a gnome test pilot, hangs tangled up in a tree. A sturdy branch lies just south of him."] = "À l'ouest, le long des pentes du sud, jusqu'à {area:17144} : {npc:249549}, un pilote d'essai gnome, pend emmêlé dans un arbre. Une branche solide se trouve juste au sud de lui.",
	-- {npc:254501} Tree Branch
	["{npc:254501}, above Fenwick's head"] = "{npc:254501}, au-dessus de la tête de Fenwick",

	-- Step 59: Fenwick's survival pack
	["Fenwick's survival pack"] = "Le sac de survie de Fenwick",
	["His pack fell just north of the tree. Open it, then wait half a minute while its safety lock discharges before you open it again."] = "Son sac est tombé juste au nord de l'arbre. Ouvrez-le, puis attendez une demi-minute que son verrou de sécurité se décharge avant de l'ouvrir à nouveau.",

	-- Step 60: Brerufa
	-- {npc:256978} Brerufa
	["North-west to Barkskin Burrow, the furbolgs' den in the hillside: {npc:256978} waits just north of its mouth. The Barkskin furbolgs show as hostile until your standing with them improves, but none of them attacked in the recording: the Deadwood furbolgs in the camps around are the ones to fight. {npc:256978} offers more only once this first quest is handed in."] = "Au nord-ouest, vers Barkskin Burrow, la tanière des furbolgs dans la colline : {npc:256978} attend juste au nord de son entrée. Les furbolgs Barkskin apparaissent hostiles jusqu'à ce que votre réputation avec eux s'améliore, mais aucun n'a attaqué dans l'enregistrement : ce sont les furbolgs Deadwood des camps alentour qu'il faut combattre. {npc:256978} n'en propose plus qu'une fois cette première quête rendue.",

	-- Step 61: Deadwood Den Guardians
	-- plural, as words: Deadwood Den Guardians = {npc:252063} Deadwood Den Guardian
	["Deadwood Den Guardians"] = "Les gardiens de tanière Deadwood",
	-- {npc:256978} Brerufa
	["The Deadwood furbolgs camp on the slopes north and east of {npc:256978}: kill their Den Guardians."] = "Les furbolgs Deadwood campent sur les pentes au nord et à l'est de {npc:256978} : tuez leurs gardiens de tanière.",

	-- Step 63: Osi Mistpaw
	-- {npc:256646} Osi Mistpaw
	["Inside the burrow: {npc:256646} at the far end."] = "Dans la tanière : {npc:256646}, tout au fond.",

	-- Step 64: Bear berries
	["Bear berries"] = "Baies d'ours",
	-- {npc:256978} Brerufa
	["The bear berries grow on the slopes around the burrow: a few on the hill north of {npc:256978}, most of them east of the burrow.\nCareful: Grimroot, an elite treant (level 60), walks the slopes west of the burrow, around 16-20,58-66: give him room."] = "Les baies d'ours poussent sur les pentes autour de la tanière : quelques-unes sur la colline au nord de {npc:256978}, la plupart à l'est de la tanière.\nAttention : Grimroot, un tréant élite (niveau 60), parcourt les pentes à l'ouest de la tanière, vers 16-20,58-66 : laissez-lui de la place.",

	-- Step 65: Barkskin Burrow
	["Barkskin Burrow"] = "Barkskin Burrow",
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw · {area:16848} Elderwild · {area:16867} Shrine of Aviana
	["Back to Osi, then the two elders at the back of the burrow. {npc:260661} stands beside Osi, {npc:256660} a little north-west of them, where the recording met him. {npc:260661}'s moss grows around {area:16848}, later in this guide; {npc:256660}'s amulets come from the harpies at the {area:16867}, also later in this guide, and you bring both back here then."] = "Retour à Osi, puis les deux anciens au fond de la tanière. {npc:260661} se tient à côté d'Osi, {npc:256660} un peu au nord-ouest d'eux, là où l'enregistrement l'a rencontré. La mousse de {npc:260661} pousse autour de {area:16848}, plus loin dans ce guide ; les amulettes de {npc:256660} viennent des harpies de {area:16867}, également plus loin dans ce guide, et vous rapportez les deux ici à ce moment-là.",
	-- {quest:93826} Deal Dread to Deadwood
	["{quest:93826}: on your way back here later; keep it"] = "{quest:93826} : sur le chemin du retour ici plus tard ; gardez-la",

	-- Step 66: The Western Post
	-- {area:16848} Elderwild · {npc:244517} Sefira Everbright · {npc:249968} Hnaz Blunderflame · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok
	["North up the valley to {area:16848}, where the Alliance outpost ({npc:244517}, {npc:249968}) and the Horde's ({npc:244511}, {npc:244512}) stand next to each other."] = "Au nord, dans la vallée, jusqu'à {area:16848}, où l'avant-poste de l'Alliance ({npc:244517}, {npc:249968}) et celui de la Horde ({npc:244511}, {npc:244512}) se tiennent côte à côte.",

	-- Step 67: The Western Post
	-- {area:16848} Elderwild · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["North up the valley to {area:16848}, where the Horde outpost ({npc:244511}, {npc:244512}, {npc:265788}) and the Alliance's stand next to each other."] = "Au nord, dans la vallée, jusqu'à {area:16848}, où l'avant-poste de la Horde ({npc:244511}, {npc:244512}, {npc:265788}) et celui de l'Alliance se tiennent côte à côte.",

	-- Step 69: Elderwild
	-- {area:16848} Elderwild
	["The two outposts of {area:16848}."] = "Les deux avant-postes de {area:16848}.",
	-- {npc:244512} Ortak Lomgok · {quest:96616} Herbs for the Bruised and Weary · {area:16868} Mourning's Rest
	["{npc:244512}: {quest:96616}, on the way back from {area:16868}"] = "{npc:244512} : {quest:96616}, au retour de {area:16868}",

	-- Step 70: Final Death
	-- {quest:92591} Final Death · {npc:260148} Scourge Reanimator · {area:16868} Mourning's Rest
	["{quest:92591}'s {npc:260148} is level 59-60: this guide burns its bone pile once you are 58, on one of its two passes through {area:16868}."] = "Le {npc:260148} de {quest:92591} est de niveau 59-60 : ce guide brûle son tas d'os une fois que vous êtes 58, lors de l'un de ses deux passages par {area:16868}.",

	-- Step 71: Final Death
	-- {quest:92592} Final Death · {npc:260148} Scourge Reanimator · {area:16868} Mourning's Rest
	["{quest:92592}'s {npc:260148} is level 59-60: this guide burns its bone pile once you are 58, on one of its two passes through {area:16868}."] = "Le {npc:260148} de {quest:92592} est de niveau 59-60 : ce guide brûle son tas d'os une fois que vous êtes 58, lors de l'un de ses deux passages par {area:16868}.",

	-- Step 72: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92591} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92591}'s bone pile is level 59-60."] = "Un choix de groupe à votre niveau : le {npc:260148} qui répond au tas d'os de {quest:92591} est de niveau 59-60.",

	-- Step 73: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92592} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92592}'s bone pile is level 59-60."] = "Un choix de groupe à votre niveau : le {npc:260148} qui répond au tas d'os de {quest:92592} est de niveau 59-60.",

	-- Step 74: Moonveil Moss
	-- {npc:260661} Suma Mossmane · {area:16848} Elderwild
	["The moss for {npc:260661} grows around {area:16848}: by the outposts and on the slopes north of them."] = "La mousse pour {npc:260661} pousse autour de {area:16848} : près des avant-postes et sur les pentes au nord d'eux.",

	-- Step 75: Eluneth
	-- {npc:264089} Eluneth · {area:16868} Mourning's Rest
	["South-east to {npc:264089} on the slope above {area:16868}."] = "Au sud-est, vers {npc:264089}, sur la pente au-dessus de {area:16868}.",

	-- Step 76: Owl feathers
	["Owl feathers"] = "Plumes de hibou",
	-- {npc:264089} Eluneth · {area:16848} Elderwild
	-- plural, as words: Hyjal Owls = {npc:249053} Hyjal Owl · Death Wailers = {npc:249226} Death Wailer
	-- was: ["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimroot, the elite treant (level 60), walks the western slopes here: pull the owls away from his path."] = "Les Hiboux d'Hyjal nichent sur les pentes entre {npc:264089} et Barkskin Burrow : leurs plumes sont pour {area:16848}.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur les pentes de l'ouest : laissez-leur un large passage.\nAttention : Grimroot, le tréant élite (niveau 60), parcourt les pentes de l'ouest ici : éloignez les hiboux de son chemin."
	["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimroot, an elite treant (level 60), walks the slopes beside {npc:264089}. He leaves you alone unless you hit him: don't, and pull the owls away from his path."] = "",

	-- Step 77: Unmarked Grave
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener
	["At the northern end of {area:16868}: something has dug up the grave. The Fleshflay Raveners around it carry what was taken."] = "À l'extrémité nord de {area:16868} : quelque chose a exhumé la tombe. Les Horreurs charognardes qui l'entourent portent ce qui a été pris.",

	-- Step 78: Mourning's Rest
	-- {area:16868} Mourning's Rest · {area:16848} Elderwild
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Forgotten Soldiers = {npc:249247} Forgotten Soldier · Death Wailers = {npc:249226} Death Wailer
	-- was: ["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimroot, the elite treant (level 60), walks the slopes on the way in: give him room."] = "Le Fléau tient les ruines de {area:16868}, à l'est de {area:16848} : des Horreurs charognardes et des Soldats oubliés partout, avec des Sentinelles éternelles parmi eux.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur {area:16868} : tenez-vous à l'écart d'eux.\nAttention : Grimroot, le tréant élite (niveau 60), parcourt les pentes en chemin : laissez-lui de la place."
	["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimroot, the elite treant (level 60), walks the slopes on the way in. He leaves you alone unless you hit him: give him room."] = "",

	-- Step 79: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Brûlez le tas d'os à l'extrémité sud-est de {area:16868} avec le {item:274411} : le {npc:260148} qui répond porte l'amulette.\nAttention : le {npc:260148} est de niveau 59-60 : brûlez le tas d'os en dernier, à pleine vie, avec les ruines alentour dégagées.",

	-- Step 80: Final Death
	-- {npc:260148} Scourge Reanimator
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised; alone, this guide comes back past the pile later."] = "Un choix de groupe en dessous du niveau 58 : le {npc:260148} qui répond au tas d'os brûlé est de niveau 59-60. Il est conseillé de se grouper ; seul, ce guide repasse devant le tas plus tard.",

	-- Step 81: Eluneth and the veteran
	-- {npc:264089} Eluneth
	["{npc:264089} and the veteran"] = "{npc:264089} et le vétéran",
	-- {npc:264089} Eluneth · {npc:255009} Veteran of the Third War · {area:16868} Mourning's Rest
	["Back to {npc:264089}, then the ghostly {npc:255009} at {area:16868}'s western edge, where the recording met him, on your way west."] = "Retour vers {npc:264089}, puis vers le spectral {npc:255009} à la lisière ouest de {area:16868}, là où l'enregistrement l'a rencontré, sur votre chemin vers l'ouest.",

	-- Step 82: Hyjal Silphium
	-- {area:16868} Mourning's Rest · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	-- plural, as words: Death Wailers = {npc:249226} Death Wailer
	["North-east up the slope from the veteran, north of {area:16868}: {npc:244512}'s silphium grows in the meadows there, where the Horde players in our recordings picked it. Then ride west to {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over these slopes: keep out of their way."] = "Au nord-est, en montant la pente depuis le vétéran, au nord de {area:16868} : le silfium de {npc:244512} pousse dans les prairies là-bas, là où les joueurs de la Horde l'ont cueilli dans nos enregistrements. Puis allez vers l'ouest jusqu'à {area:16848}.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur ces pentes : tenez-vous à l'écart d'eux.",

	-- Step 83: Elderwild
	["West to the Alliance outpost."] = "À l'ouest, vers l'avant-poste de l'Alliance.",

	-- Step 85: To the Summit of Eternity
	-- {quest:91688} To the Summit of Eternity · {npc:254915} Thisalee Crow
	["{quest:91688}: for {npc:254915}, later in this guide; keep it"] = "{quest:91688} : pour {npc:254915}, plus loin dans ce guide ; gardez-la",

	-- Step 86: Daythor Brellan and Sefira Everbright
	-- {npc:264521} Daythor Brellan · {npc:244517} Sefira Everbright
	["{npc:264521} and {npc:244517}"] = "{npc:264521} et {npc:244517}",
	-- {npc:244517} Sefira Everbright · {npc:264521} Daythor Brellan
	["The worker {npc:244517} means is a peasant just north of her; {npc:264521} stands between them."] = "L'ouvrier dont parle {npc:244517} est un paysan juste au nord d'elle ; {npc:264521} se tient entre eux.",
	-- {quest:94832} Belle's Ring · {npc:2329} Michelle Belle · {area:87} Goldshire
	["{quest:94832}: {npc:2329} at the Lion's Pride Inn in {area:87}; take it only if you'll pass by"] = "{quest:94832} : {npc:2329} à l'auberge de l'Orgueil du Lion en {area:87} ; ne la prenez que si vous passez par là",

	-- Step 87: Elderwild
	-- {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["West to the Horde outpost: {npc:244511}, then {npc:244512} and {npc:265788} beside him."] = "À l'ouest, vers l'avant-poste de la Horde : {npc:244511}, puis {npc:244512} et {npc:265788} à côté de lui.",
	-- {npc:265788} Kal'tinzan · {quest:91794} Flags of Our Forebears · {area:16866} Dae'gun
	["{npc:265788}: {quest:91794}: the flag and the heraldry are in {area:16866}, later in this guide; keep it"] = "{npc:265788} : {quest:91794} : l'étendard et l'héraldique se trouvent en {area:16866}, plus loin dans ce guide ; gardez-la",

	-- Step 88: Maruke and Enho Runehoof
	-- {npc:265895} Maruke · {npc:265862} Enho Runehoof
	["{npc:265895} and {npc:265862}"] = "{npc:265895} et {npc:265862}",
	-- {npc:244512} Ortak Lomgok · {npc:265895} Maruke · {area:16848} Elderwild · {npc:265862} Enho Runehoof
	["{npc:244512}'s poultice is for two of the outpost's wounded: {npc:265895} lies at the north end of {area:16848}, {npc:265862} just south of {npc:244512}."] = "Le cataplasme de {npc:244512} est pour deux des blessés de l'avant-poste : {npc:265895} gît à l'extrémité nord de {area:16848}, {npc:265862} juste au sud de {npc:244512}.",

	-- Step 89: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. {npc:244511}'s rabbit carcass lures him out in the woods by the Deadwood camps south-east of here, on part 3's way back to Barkskin Burrow; his claws come back here at the end of this guide."] = "{quest:92446} est élite (niveau 60 dans nos données) : il est conseillé de se grouper. Le cadavre de lapin de {npc:244511} l'attire dans le bois près des camps Deadwood au sud-est d'ici, sur le chemin du retour de la Barkskin Burrow dans la partie 3 ; ses griffes reviennent ici à la fin de ce guide.",

	-- Step 90: The overlook
	["The overlook"] = "Le belvédère",
	["West to the overlook above the valley: the veteran's old scabbard lies there. Hand his quest in at the scabbard and take the next from it, then use the scabbard in your bags to call his spirit and listen to his story."] = "À l'ouest, vers le belvédère au-dessus de la vallée : la vieille fourreau du vétéran s'y trouve. Rendez sa quête à la fourreau et prenez la suivante dedans, puis utilisez la fourreau de votre sac pour appeler son esprit et écouter son histoire.",

	-- Step 91: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["{npc:255683} and {npc:267109}"] = "{npc:255683} et {npc:267109}",
	-- {area:16868} Mourning's Rest · {area:17145} Cradle of Tranquility · {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["East past {area:16868} into the {area:17145}: {npc:255683}, the great cat, waits by the path, and {npc:267109} rests in the ruins just south of her."] = "À l'est, après {area:16868}, vers {area:17145} : {npc:255683}, la grande chatte, attend près du sentier, et {npc:267109} se repose dans les ruines juste au sud d'elle.",

	-- Step 92: Lisbael Highfeather
	-- {npc:268168} Lisbael Highfeather
	["East across the Cradle to {npc:268168}."] = "À l'est, à travers le Berceau, vers {npc:268168}.",
	-- {quest:96145} Past Wing and Claw · {npc:260825} Phoebe Highfeather
	["{quest:96145}: for {npc:260825}, later in this guide; keep it"] = "{quest:96145} : pour {npc:260825}, plus loin dans ce guide ; gardez-la",

	-- Step 93: Jereman
	-- {npc:267158} Jereman
	["North to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158}, the crow wild god, appears."] = "Au nord, vers le vieux pont sur le Berceau : touchez l'effigie de corbeau qui s'y trouve et {npc:267158}, le dieu sauvage des corbeaux, apparaît.",

	-- Step 94: The falls and the first kitten
	["The falls and the first kitten"] = "Les chutes et le premier chaton",
	-- {npc:267109} Galvinquam Leafsyre · {npc:255685} Solstice · {npc:255683} Shalla'kal
	["Fill {npc:267109}'s gourd at the falls beside the bridge. {npc:255685}, one of {npc:255683}'s kittens, plays just west of the falls: walk up to her."] = "Remplissez la gourde de {npc:267109} aux chutes près du pont. {npc:255685}, l'un des chatons de {npc:255683}, joue juste à l'ouest des chutes : approchez-vous d'elle.",
	["fill the gourd"] = "remplissez la gourde",

	-- Step 95: Johun "Punchy" Dillas's camp
	-- {npc:249234} Johun "Punchy" Dillas
	["{npc:249234}'s camp"] = "Le camp de {npc:249234}",
	-- {npc:249234} Johun "Punchy" Dillas
	["North to {npc:249234} and his crates. Drive the skunks out from behind the crates without attacking them."] = "Au nord, vers {npc:249234} et ses caisses. Chassez les mouffettes derrière les caisses sans les attaquer.",

	-- Step 96: Brie
	-- {npc:255773} Brie · {npc:249234} Johun "Punchy" Dillas
	["{npc:255773}, the second kitten, plays just west of {npc:249234}'s camp."] = "{npc:255773}, la deuxième chatonne, joue juste à l'ouest du camp de {npc:249234}.",

	-- Step 97: Foxes
	["Foxes"] = "Renards",
	-- {npc:249234} Johun "Punchy" Dillas · {npc:255183} Jezerelle the Swaying · {npc:256830} Bannerwing Survivor
	["The Rustleaf Foxes are thick in the woods around {npc:249234}'s camp.\nCareful: {npc:255183} (61, rare) walks the woods north of the camp, and a {npc:256830} (60, rare) can turn up there too: leave them be."] = "",

	-- Step 99: Kala'th
	-- {npc:255693} Kala'th
	["West across the Cradle to {npc:255693}, another of the wild gods."] = "À l'ouest, à travers le Berceau, vers {npc:255693}, un autre des dieux sauvages.",

	-- Step 100: The burnt buildings
	["The burnt buildings"] = "Les bâtiments brûlés",
	-- {npc:255693} Kala'th
	["The burnt buildings stand in the meadows east of {npc:255693}: the nails and brackets lie among the rubble."] = "Les bâtiments brûlés se tiennent dans les prairies à l'est de {npc:255693} : les clous et les supports gisent parmi les décombres.",

	-- Step 101: Predatory stags
	["Predatory stags"] = "Cerfs prédateurs",
	-- {npc:255693} Kala'th
	-- plural, as words: Predatory Hyjal Stags = {npc:256809} Predatory Hyjal Stag · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The Predatory Hyjal Stags roam the same meadows, east of {npc:255693}.\nCareful: Spectral Frostwyrms (61, elites) circle over the western meadows: keep out from under them."] = "Les Cerfs prédateurs d'Hyjal errent dans les mêmes prairies, à l'est de {npc:255693}.\nAttention : les Wyrm spectraux du givre (61, élites) tournent au-dessus des prairies de l'ouest : ne vous mettez pas dessous.",

	-- Step 103: Marrosis
	-- {npc:267113} Marrosis · {area:16868} Mourning's Rest
	["South to {npc:267113}, another wild god, at {area:16868}'s eastern edge."] = "Au sud, vers {npc:267113}, un autre dieu sauvage, à la lisière est de {area:16868}.",
	-- {quest:92317} Stolen Life · {npc:256222} Ketharas
	["{quest:92317}: for {npc:256222}, later in this guide; keep it"] = "{quest:92317} : pour {npc:256222}, plus loin dans ce guide ; gardez-la",

	-- Step 104: Bones and stolen life
	["Bones and stolen life"] = "Os et vie volée",
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Death Wailers = {npc:249226} Death Wailer · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The sun-bleached bones lie all over {area:16868}; the Fleshflay Raveners there carry the drop of stolen life.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way. Spectral Frostwyrms (61, elites) circle over the meadows around it: keep out from under them."] = "Les os décolorés par le soleil gisent partout dans {area:16868} ; les Horreurs charognardes là-bas portent le butin de vie volée.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur {area:16868} : tenez-vous à l'écart d'eux. Les Wyrm spectraux du givre (61, élites) tournent au-dessus des prairies autour : ne vous mettez pas dessous.",

	-- Step 105: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet. The hand-in waits for the ride back to {area:16848} at the end of this guide.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Brûlez le tas d'os à l'extrémité sud-est de {area:16868} avec le {item:274411} : le {npc:260148} qui répond porte l'amulette. La remise attend le trajet de retour vers {area:16848} à la fin de ce guide.\nAttention : le {npc:260148} est de niveau 59-60 : brûlez le tas d'os en dernier, à pleine vie, avec les ruines alentour dégagées.",

	-- Step 106: Final Death
	-- {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. The hand-in waits for the ride back to {area:16848} at the end of this guide."] = "Un choix de groupe en dessous du niveau 58 : le {npc:260148} qui répond au tas d'os brûlé est de niveau 59-60. Il est conseillé de se grouper. La remise attend le trajet de retour vers {area:16848} à la fin de ce guide.",

	-- Step 107: Final Death
	-- {npc:260148} Scourge Reanimator · {npc:244511} Zet'gan · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. {npc:244511} takes the amulet on the ride back to {area:16848} at the end of this guide."] = "Un choix de groupe en dessous du niveau 58 : le {npc:260148} qui répond au tas d'os brûlé est de niveau 59-60. Il est conseillé de se grouper. {npc:244511} reçoit l'amulette sur le trajet de retour vers {area:16848} à la fin de ce guide.",

	-- Step 109: Whisperfur
	-- {npc:255771} Whisperfur · {area:16868} Mourning's Rest
	["The last kitten, {npc:255771}, plays at the southern end of {area:16868}."] = "La dernière chatonne, {npc:255771}, joue à l'extrémité sud de {area:16868}.",

	-- Step 110: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["North to {npc:255683}, then {npc:267109} in the ruins south of her."] = "Au nord, vers {npc:255683}, puis {npc:267109} dans les ruines au sud d'elle.",

	-- Step 111: Corrupted Growth
	-- {area:16867} Shrine of Aviana · {npc:260825} Phoebe Highfeather
	["East from the Cradle towards the {area:16867}, where the Wormwing harpies nest: a corrupted growth on the shrine's western slope starts a quest for {npc:260825}."] = "À l'est, depuis le Berceau, vers {area:16867}, où nichent les harpies Aile-verm : une excroissance corrompue sur la pente ouest du sanctuaire lance une quête pour {npc:260825}.",
	["remove the corrupted knots on the trees just north-west of the shrine, on your way"] = "enlevez les nœuds corrompus sur les arbres juste au nord-ouest du sanctuaire, en chemin",

	-- Step 112: Skylord Omnuron
	-- {npc:254131} Skylord Omnuron · {npc:260825} Phoebe Highfeather · {area:16867} Shrine of Aviana
	["{npc:254131} and {npc:260825} stand together at the {area:16867}."] = "{npc:254131} et {npc:260825} se tiennent ensemble à {area:16867}.",
	-- {quest:92500} A Bit of the Sky · {npc:256222} Ketharas
	["{quest:92500}: for {npc:256222}, later in this guide"] = "{quest:92500} : pour {npc:256222}, plus loin dans ce guide",

	-- Step 114: The Shrine of Aviana
	-- {area:16867} Shrine of Aviana
	["The {area:16867}"] = "Le {area:16867}",

	-- Step 115: The harpy grounds
	["The harpy grounds"] = "Le territoire des harpies",
	-- {npc:256660} Thobon Sapclaw · {object:650219} Jewel of the Horizon (no name in this language: may be words) · {npc:260826} Zarrat Wormwing
	["The Wormwing harpies nest on the slopes north-west of the shrine. They drop the pinfeathers and {npc:256660}'s amulets; the bangles lie in their nests, the {object:650219} in a nest on the western slope, and {npc:260826}, who has Omnuron's spear, is among them. The corrupted knots grow on the trees just north-west of the shrine."] = "Les harpies Aile-verm nichent sur les pentes au nord-ouest du sanctuaire. Elles laissent tomber les pennes et les amulettes de {npc:256660} ; les bracelets gisent dans leurs nids, le {object:650219} dans un nid de la pente ouest, et {npc:260826}, qui a la lance d'Omnuron, est parmi elles. Les nœuds corrompus poussent sur les arbres juste au nord-ouest du sanctuaire.",

	-- Step 117: The way into the Deadwood camps
	["The way into the Deadwood camps"] = "",
	-- {area:17144} Malorne's Retreat · {area:16868} Mourning's Rest
	["The Deadwood camps fill {area:17144}, a sunken valley whose northern end runs in under the cliffs: there is no way down into it from {area:16868}. Go round to the valley's mouth in the south-east and follow it west, then north up into the camps, as players do."] = "",
	-- {area:17144} Malorne's Retreat
	["the mouth of the valley up into {area:17144}"] = "",

	-- Step 118: The Deadwood camps
	["The Deadwood camps"] = "Les camps Deadwood",
	-- {quest:92446} Head Scratcher
	["South-west back towards Barkskin Burrow: the Deadwood camps on the slopes east of the burrow hold the Totemics and Fel-Tenders. An elite named {quest:92446} (level 60) may roam the camps' eastern end."] = "Au sud-ouest, de retour vers Barkskin Burrow : les camps Deadwood sur les pentes à l'est de la tanière abritent les Totemics et les Eleveurs de fel. Un élite nommé {quest:92446} (niveau 60) peut rôder à l'extrémité est des camps.",

	-- Step 119: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. Put {npc:244511}'s rabbit carcass down in the woods at the camps' eastern end, where the Horde players in our recordings fought him, and take his claws."] = "{quest:92446} est élite (niveau 60 dans nos données) : il est conseillé de se grouper. Déposez le cadavre de lapin de {npc:244511} dans le bois à l'extrémité est des camps, là où les joueurs de la Horde l'ont combattu dans nos enregistrements, et prenez ses griffes.",

	-- Step 120: Barkskin Burrow
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw
	["Into the burrow for the elders, {npc:260661} and {npc:256660}."] = "Dans la tanière, pour les anciens, {npc:260661} et {npc:256660}.",

	-- Step 121: Galvinquam Leafsyre
	-- {area:17145} Cradle of Tranquility · {npc:267109} Galvinquam Leafsyre · {npc:255683} Shalla'kal
	["North-east into the {area:17145}: {npc:267109} rests in the ruins south of {npc:255683}, on your way."] = "Au nord-est, vers {area:17145} : {npc:267109} se repose dans les ruines au sud de {npc:255683}, en chemin.",
	-- {quest:96991} Trail Assist · {npc:264795} Marn Euhorn · {area:16849} Summit of Eternity
	["{quest:96991}: for {npc:264795} at the {area:16849}, later in this guide"] = "{quest:96991} : pour {npc:264795} à {area:16849}, plus loin dans ce guide",

	-- Step 122: Jereman
	-- {npc:267158} Jereman
	["On to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158} appears again."] = "Continuez vers le vieux pont sur le Berceau : touchez l'effigie de corbeau qui s'y trouve et {npc:267158} apparaît à nouveau.",
	-- {quest:96964} A Clever Creature · {npc:259695} Renalard · {area:16866} Dae'gun
	["{quest:96964}: for {npc:259695} in {area:16866}, just ahead"] = "{quest:96964} : pour {npc:259695} en {area:16866}, juste devant",

	-- Step 123: Johun "Punchy" Dillas
	-- {npc:249234} Johun "Punchy" Dillas · {area:16866} Dae'gun
	["North-east across the Cradle to {npc:249234}'s camp at the edge of {area:16866}."] = "Au nord-est, à travers le Berceau, vers le camp de {npc:249234} à la lisière de {area:16866}.",

	-- Step 124: Elaena Moonwhisper, Witherbeard and Yashiro
	-- {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["{npc:263406}, {npc:249052} and {npc:267121}"] = "{npc:263406}, {npc:249052} et {npc:267121}",
	-- {area:16866} Dae'gun · {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["Into {area:16866}, north of the Cradle: the ruins of a Horde base, now held by demons. {npc:263406} and {npc:249052} camp at its western edge; {npc:267121}, a blademaster, waits a little east of them. Doomguards (elites, levels 58-59) walk among the demons: pull carefully."] = "Vers {area:16866}, au nord du Berceau : les ruines d'une base de la Horde, désormais tenues par des démons. {npc:263406} et {npc:249052} campent à sa lisière ouest ; {npc:267121}, un maître de guerre, attend un peu à l'est d'eux. Les Gardes funestes (élites, niveaux 58-59) marchent parmi les démons : attirez avec précaution.",

	-- Step 125: Maerion Thaelemaches
	-- {npc:267097} Maerion Thaelemaches · {area:16866} Dae'gun · {quest:97009} Maerion's Misery · {npc:267439} Doomguard Xarkul
	-- plural, as words: Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:267097} at the northern ruins of {area:16866}: take {quest:97009} so the Defiling Hounds drop their spikes while you work the other errands here.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "",

	-- Step 126: Renalard
	-- {area:16866} Dae'gun · {npc:259695} Renalard
	["South-east across {area:16866} to {npc:259695}, the wild god, indoors at its south-eastern edge."] = "Au sud-est, à travers {area:16866}, vers {npc:259695}, le dieu sauvage, à l'intérieur à sa lisière sud-est.",
	-- {quest:92335} Ashes of the Legion Ascent · {npc:256222} Ketharas
	["{quest:92335}: for {npc:256222}, later in this guide"] = "{quest:92335} : pour {npc:256222}, plus loin dans ce guide",

	-- Step 127: Dae'gun
	-- {area:16866} Dae'gun · {npc:259695} Renalard · {npc:265788} Kal'tinzan · {item:253249} Horde Flag · {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:255183} Jezerelle the Swaying · {npc:267439} Doomguard Xarkul
	-- plural, as words: Felguard Sentinels = {npc:249229} Felguard Sentinel · Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["Work west back through {area:16866}: the Felguard Sentinels and Defiling Hounds are everywhere, the hounds carry the essence, and the Horde base's rubble (wire, scrap and dung) lies all over it. Light the two bonfires on your way, scout the Horde tower in the middle, take Azgalor's ashes west of the tower, and pick up the abandoned supplies, a few just north-west of {npc:259695} and the rest in the western half: {npc:259695}'s tuft of fur, used on a demon, distracts it while you take them.\nHorde: the demons here also drop the Scraps of Horde Heraldry for {npc:265788}, the old {item:253249} stands in the camp north of the south bonfire, and the {object:656786} at the camp's eastern edge start {quest:96998}.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room. {npc:255183} (61, rare) walks the camp north of the south bonfire: keep away from her.\nCareful: Doomguards (elites, 58-59) stand among the demons, and {npc:267439} (elite, 61) walks the camp: pull the hounds and sentinels to you, away from them."] = "Travaillez vers l'ouest à travers {area:16866} : les Sentinelles de la garde vil et les Molosses profanateurs sont partout, les molosses portent l'essence, et les décombres de la base de la Horde (fil, ferraille et fumier) couvrent tout le sol. Allumez les deux feux de joie en chemin, explorez la tour de la Horde au centre, prenez les cendres d'Azgalor à l'ouest de la tour, et ramassez les fournitures abandonnées, quelques-unes juste au nord-ouest de {npc:259695} et le reste dans la moitié ouest : la touffe de poils de {npc:259695}, utilisée sur un démon, le distrait pendant que vous les prenez.\nHorde : les démons ici laissent aussi tomber les Fragments d'héraldique de la Horde pour {npc:265788}, le vieil {item:253249} se trouve dans le camp au nord du feu de joie sud, et les {object:656786} de la lisière est du camp lancent {quest:96998}.\nAttention : les Mastodontes de la Légion (60, élites rares) foulent le sol des camps de {area:16866} : laissez-leur de la place. {npc:255183} (61, rare) parcourt le camp au nord du feu de joie sud : tenez-vous loin d'elle.\nAttention : les Gardes funestes (élites, 58-59) se tiennent parmi les démons, et {npc:267439} (élite, 61) parcourt le camp : attirez les molosses et les sentinelles vers vous, loin d'eux.",
	["light it"] = "allumez-la",
	["scout the Horde tower"] = "explorez la tour de la Horde",
	-- {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{object:656786}: {quest:96998}, for {npc:244511} in {area:16848}; keep it"] = "{object:656786} : {quest:96998}, pour {npc:244511} en {area:16848} ; gardez-la",

	-- Step 129: Drawing Down the Malevolent
	-- {npc:263394} Bethra'zel the Feeble · {npc:252457} Mazzogore · {npc:263406} Elaena Moonwhisper
	["{npc:263394} and {npc:252457} are level 60 elites until {npc:263406}'s eye drains them: drain each one first, then fight it. Drained, they are no longer elite and you can take them alone; players in our recordings killed both once drained."] = "{npc:263394} et {npc:252457} sont des élites de niveau 60 jusqu'à ce que l'œil de {npc:263406} les draine : drainez chacun d'abord, puis combattez-le. Drainés, ils ne sont plus élites et vous pouvez les affronter seul ; les joueurs de nos enregistrements ont tué les deux une fois drainés.",

	-- Step 131: Bethra'zel the Feeble
	-- {npc:263394} Bethra'zel the Feeble · {npc:263406} Elaena Moonwhisper · {npc:252457} Mazzogore · {npc:267439} Doomguard Xarkul · {area:16866} Dae'gun
	-- plural, as words: Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:263394}. Drain him first: use {npc:263406}'s eye on him, and only then fight him. Undrained, he and {npc:252457} are level 60 elites. {npc:267439}, an elite (level 61), walks this corner of {area:16866}: keep out of his way.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room."] = "Au nord-est, vers {npc:263394}. Drainez-le d'abord : utilisez l'œil de {npc:263406} sur lui, et alors seulement combattez-le. Sans drainage, lui et {npc:252457} sont des élites de niveau 60. {npc:267439}, un élite (niveau 61), parcourt ce coin de {area:16866} : tenez-vous hors de son chemin.\nAttention : les Mastodontes de la Légion (60, élites rares) foulent le sol des camps de {area:16866} : laissez-leur de la place.",

	-- Step 132: Maerion Thaelemaches
	-- {npc:267097} Maerion Thaelemaches · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble · {npc:267439} Doomguard Xarkul
	-- plural, as words: Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["North-east back to {npc:267097}, in the corner of {area:16866} where {npc:263394} stands: the Defiling Hounds around him drop any spikes you still need.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "",

	-- Step 133: Mazzogore
	-- {npc:263426} Mazzogore the Weak · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble
	["South-west to {npc:263426}, in the middle of {area:16866}: drain him with the eye first, as {npc:263394}, then kill him. Undrained, he is a level 60 elite.\nCareful: Doomguards (elites, 58-59) stand around him: pull him out to you."] = "Au sud-ouest, vers {npc:263426}, au milieu de {area:16866} : drainiez-le avec l'œil d'abord, comme {npc:263394}, puis tuez-le. Sans drainage, c'est un élite de niveau 60.\nAttention : les Gardes funestes (élites, 58-59) se tiennent autour de lui : attirez-le hors de lui vers vous.",

	-- Step 134: Elaena Moonwhisper
	-- {quest:96025} As the Crow Flies · {npc:254915} Thisalee Crow
	["{quest:96025}: for {npc:254915} at the Summit"] = "{quest:96025} : pour {npc:254915} au Sommet",

	-- Step 135: Renalard
	-- {npc:259695} Renalard
	["South-east to {npc:259695}."] = "Au sud-est, vers {npc:259695}.",

	-- Step 136: The Summit of Eternity
	-- {area:16849} Summit of Eternity
	["The {area:16849}"] = "Le {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:41861} Fayran Elthas · {npc:264795} Marn Euhorn · {npc:243855} Toron Rockhoof · {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane · {npc:243815} Sebelia
	["East up to the {area:16849}, the druids' camp. {npc:41861}, the flight master, stands at its north end; {npc:264795}, {npc:243855} and {npc:254915} along the path south; {npc:40833} indoors next to Thisalee; {npc:243815}, the innkeeper, at the south-east end."] = "À l'est, en montant vers {area:16849}, le camp des druides. {npc:41861}, la maîtresse de vol, se tient à son extrémité nord ; {npc:264795}, {npc:243855} et {npc:254915} le long du sentier vers le sud ; {npc:40833}, à l'intérieur, à côté de Thisalee ; {npc:243815}, l'aubergiste, à l'extrémité sud-est.",
	-- {npc:41861} Fayran Elthas
	["{npc:41861}, at the flight point"] = "{npc:41861}, au point de vol",
	-- {npc:243815} Sebelia · {quest:93197} Mending Communications · {npc:11118} Innkeeper Vizzie · {area:2255} Everlook
	["{npc:243815}: {quest:93197}: for {npc:11118} in {area:2255}, at the end"] = "{npc:243815} : {quest:93197} : pour {npc:11118} en {area:2255}, à la fin",

	-- Step 138: As the Crow Flies
	-- {npc:254915} Thisalee Crow · {npc:263406} Elaena Moonwhisper
	["{npc:254915}, at the Summit, for {npc:263406}'s message."] = "{npc:254915}, au Sommet, pour le message de {npc:263406}.",

	-- Step 139: The Summit's Blackthorne quests
	["The Summit's Blackthorne quests"] = "Les quêtes de Blackthorne du Sommet",
	-- {npc:260674} Ve'han Talongrasp
	["A group stop: the Blackthorne camps north-east of the Summit hold elite Outrunners, Priests and a Courier (60) as often as the Cultists and Adepts, with {npc:260674} (60, elite) in the middle and Ghansurok (61, elite) on the ridge. Grouping up is encouraged, look for people to do it with. Skip these if you are alone."] = "Un arrêt de groupe : les camps de Blackthorne au nord-est du Sommet abritent des Éclaireurs, des Prêtres et un Messager (60) élites aussi souvent que des Cultistes et des Adeptes, avec {npc:260674} (60, élite) au milieu et Ghansurok (61, élite) sur la crête. Il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Passez-les si vous êtes seul.",

	-- Step 140: Fly to the Tainted Foothills
	-- {npc:260626} Bluebell · {npc:249235} Kaylaena Springwhisper · {npc:256222} Ketharas
	["Fly down to {npc:260626} for {npc:249235} and {npc:256222}."] = "Volez jusqu'à {npc:260626} pour {npc:249235} et {npc:256222}.",

	-- Step 141: Kaylaena Springwhisper's workshop
	["North to the workshop. Turn the two gears and connect the two battery terminals on both sides of her glaive thrower. Ghansurok, the elite chimaera (level 61), prowls around the workshop: watch for him while you work."] = "Au nord, vers l'atelier. Tournez les deux engrenages et reliez les deux bornes de la batterie des deux côtés de son lance-glaive. Ghansurok, la chimère élite (niveau 61), rôde autour de l'atelier : surveillez-le pendant que vous travaillez.",

	-- Step 142: Ketharas
	["South-east to the Hermit's Abode with what the wild gods and Omnuron gave you."] = "Au sud-est, vers la Demeure de l'Ermite avec ce que les dieux sauvages et Omnuron vous ont donné.",

	-- Step 146: Final Death, still not done
	-- {quest:92591} Final Death
	["{quest:92591}, still not done"] = "{quest:92591}, pas encore terminée",
	-- {area:16868} Mourning's Rest · {quest:92591} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92591}: the route doesn't come back for it."] = "Encore en dessous de 58 après le deuxième passage par {area:16868} ? Abandonnez {quest:92591} : l'itinéraire n'y revient pas.",

	-- Step 147: Final Death, still not done
	-- {quest:92592} Final Death
	["{quest:92592}, still not done"] = "{quest:92592}, pas encore terminée",
	-- {area:16868} Mourning's Rest · {quest:92592} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92592}: the route doesn't come back for it."] = "Encore en dessous de 58 après le deuxième passage par {area:16868} ? Abandonnez {quest:92592} : l'itinéraire n'y revient pas.",

	-- Step 148: Back to Elderwild
	-- {area:16848} Elderwild
	["Back to {area:16848}"] = "Retour à {area:16848}",
	-- {area:16848} Elderwild · {npc:265788} Kal'tinzan · {npc:244511} Zet'gan
	["Horde: ride west across the foothills and north up the valley to {area:16848}, about four minutes, for {npc:265788}'s flags, {npc:244511}'s amulet and his war paint wrap, then back up to the Summit."] = "Horde : chevauchez vers l'ouest à travers les contreforts puis vers le nord dans la vallée jusqu'à {area:16848}, environ quatre minutes, pour les étendards de {npc:265788}, l'amulette de {npc:244511} et son bandage de guerre, puis remontez au Sommet.",
	-- {npc:244511} Zet'gan · {quest:96999} Wrap Return · {npc:3187} Tai'tasi · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:244511}: {quest:96999}, for {npc:3187} in {area:367}, {zone:1411}; take it only if you'll pass by"] = "{npc:244511} : {quest:96999}, pour {npc:3187} en {area:367}, {zone:1411} ; ne la prenez que si vous passez par là",

	-- Step 149: Back to Elderwild
	-- {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["Alliance: the amulet from the second pass goes to {npc:244517}: ride west across the foothills and north up the valley to {area:16848}, about four minutes, then back up to the Summit."] = "Alliance : l'amulette du deuxième passage va pour {npc:244517} : chevauchez vers l'ouest à travers les contreforts puis vers le nord dans la vallée jusqu'à {area:16848}, environ quatre minutes, puis remontez au Sommet.",

	-- Step 151: To the Summit of Eternity
	-- {npc:244517} Sefira Everbright · {npc:254915} Thisalee Crow
	["{npc:244517}: for {npc:254915} at the Summit, next"] = "{npc:244517} : pour {npc:254915} au Sommet, ensuite",

	-- Step 152: To the Summit of Eternity
	-- {npc:244511} Zet'gan · {npc:254915} Thisalee Crow
	["{npc:244511}: for {npc:254915} at the Summit, next"] = "{npc:244511} : pour {npc:254915} au Sommet, ensuite",

	-- Step 153: Zet'gan
	-- {quest:92446} Head Scratcher
	["{quest:92446}'s claws"] = "Les griffes de {quest:92446}",

	-- Step 154: Up to the Summit of Eternity
	-- {area:16849} Summit of Eternity
	["Up to the {area:16849}"] = "Remontez vers {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:260626} Bluebell
	["Back up to the {area:16849}: {npc:260626}, at the ancients' outpost, flies there, and your Hearthstone is bound there."] = "Remontez vers {area:16849} : {npc:260626}, à l'avant-poste des ancestraux, vole jusque-là, et votre pierre de foyer y est liée.",

	-- Step 155: Tiala Whitemane
	-- {npc:254915} Thisalee Crow
	["Indoors at the Summit, next to {npc:254915}."] = "À l'intérieur au Sommet, à côté de {npc:254915}.",

	-- Step 156: Thisalee Crow
	-- {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane
	["{npc:254915}, next to {npc:40833} at the Summit."] = "{npc:254915}, à côté de {npc:40833} au Sommet.",

	-- Step 158: The Blackthorne camps
	["The Blackthorne camps"] = "Les camps de Blackthorne",
	-- {npc:260674} Ve'han Talongrasp · {npc:40833} Tiala Whitemane
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nUse {npc:40833}'s staff on a Pact member to strip its ward, then kill it, ten times: pick Cultists and Adepts, whom Thisalee wants dead too. The Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Les cultistes de Blackthorne campent sur les pentes au nord-est du Sommet (niveau 60, avec des Éclaireurs, des Prêtres et un Messager élites parmi eux : attirez avec précaution). {npc:260674}, un élite (niveau 60) qui les dirige, se tient parmi eux : laissez-le tranquille. Ghansurok, une chimère élite (niveau 61), rôde aussi sur la crête au nord des camps.\nUtilisez le bâton de {npc:40833} sur un membre du Pacte pour lui retirer sa garde, puis tuez-le, dix fois : choisissez des Cultistes et des Adeptes, que Thisalee veut morts aussi. Les Cultistes portent le kris et les Adeptes le bâton ; les graines épineuses se trouvent dans le bois là-bas, et les hippogriffes et les chimères errent sur les pentes tout autour. Pas encore terminé dans nos enregistrements : si quelque chose ici cloche, dites-le-nous.",

	-- Step 159: The Blackthorne camps
	-- {npc:260674} Ve'han Talongrasp
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nThe Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Les cultistes de Blackthorne campent sur les pentes au nord-est du Sommet (niveau 60, avec des Éclaireurs, des Prêtres et un Messager élites parmi eux : attirez avec précaution). {npc:260674}, un élite (niveau 60) qui les dirige, se tient parmi eux : laissez-le tranquille. Ghansurok, une chimère élite (niveau 61), rôde aussi sur la crête au nord des camps.\nLes Cultistes portent le kris et les Adeptes le bâton ; les graines épineuses se trouvent dans le bois là-bas, et les hippogriffes et les chimères errent sur les pentes tout autour. Pas encore terminé dans nos enregistrements : si quelque chose ici cloche, dites-le-nous.",

	-- Step 162: Fly to Everlook
	-- {npc:41861} Fayran Elthas · {area:2255} Everlook
	["{npc:41861} flies you to {area:2255}."] = "{npc:41861} vous emmène en vol vers {area:2255}.",

	-- Step 163: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {zone:1452} Winterspring
	["{npc:11118} is in {area:2255}'s inn. She has more mail for you in {zone:1452}, outside this guide."] = "{npc:11118} est à l'auberge de {area:2255}. Elle a plus de courrier pour vous en {zone:1452}, hors de ce guide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A group choice: {npc:263394} and {npc:252457} are level 60 elites until {npc:263406}'s eye drains them. Drain each one first, then fight it; players in our recordings killed both once drained. Grouping up is advised."] = "Un choix de groupe : {npc:263394} et {npc:252457} sont des élites de niveau 60 jusqu'à ce que l'œil de {npc:263406} les draine. Drainiez chacun d'abord, puis combattez-le ; les joueurs de nos enregistrements ont tué les deux une fois drainés. Il est conseillé de se grouper.",
	-- ["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. The ruined ballista stands at the field's north-eastern edge: plant the last seed there. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "Au nord, vers le champ d'arbustes : les {npc:248395} laissent tomber les feuilles, et les Tubercules-flèches écarlates poussent sur le sol dégagé, la plupart dans la moitié ouest du champ. La baliste en ruines se tient à la lisière nord-est du champ : plantez la dernière graine là. Restez à l'écart de {quest:91923} et de {npc:248709}, les élites du champ.",
	-- ["North-east to {npc:267097}, in the corner of {area:16866} where {npc:263394} stands. His Felhound Spikes come from the Defiling Hounds, and in the first recording about one hound in ten had one: kill the hounds around him while you are here, and leave his quest if the twelve spikes are slow to come.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "Au nord-est, vers {npc:267097}, dans le coin de {area:16866} où se tient {npc:263394}. Ses Pointes de gangrechien proviennent des Molosses profanateurs, et dans le premier enregistrement un molosse sur dix en avait une environ : tuez les molosses autour de lui pendant que vous êtes ici, et abandonnez sa quête si les douze pointes tardent à arriver.\nAttention : les Mastodontes de la Légion (60, élites rares) foulent le sol des camps de {area:16866}, et {npc:267439}, un élite (niveau 61), parcourt ce coin : laissez-leur de la place.",
	-- ["South Bonfire"] = "Feu de joie sud",
	-- ["South down the west side of the shrub field to the ancients' outpost: kill the {npc:248395} you pass for {npc:249235}. {npc:260626}, the flight mistress, waits by the outpost; {npc:248367} and {npc:265586} stand with the ancient {npc:248366}."] = "Au sud, par le côté ouest du champ d'arbustes, jusqu'à l'avant-poste des ancestraux : tuez les {npc:248395} que vous croisez pour {npc:249235}. {npc:260626}, la maîtresse de vol, attend près de l'avant-poste ; {npc:248367} et {npc:265586} se tiennent avec l'ancestral {npc:248366}.",
	-- ["Southeast Bonfire"] = "Feu de joie sud-est",
	-- ["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimroot, the elite treant (level 60), walks the western slopes here: pull the owls away from his path."] = "Les Hiboux d'Hyjal nichent sur les pentes entre {npc:264089} et Barkskin Burrow : leurs plumes sont pour {area:16848}.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur les pentes de l'ouest : laissez-leur un large passage.\nAttention : Grimroot, le tréant élite (niveau 60), parcourt les pentes de l'ouest ici : éloignez les hiboux de son chemin.",
	-- ["The Rustleaf Foxes are thick in the woods around {npc:249234}'s camp.\nCareful: {npc:255183} (61, rare) walks the woods north of the camp: leave her be."] = "Les Renards à rousselle abondent dans le bois autour du camp de {npc:249234}.\nAttention : {npc:255183} (61, rare) parcourt le bois au nord du camp : laissez-la tranquille.",
	-- ["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimroot, the elite treant (level 60), walks the slopes on the way in: give him room."] = "Le Fléau tient les ruines de {area:16868}, à l'est de {area:16848} : des Horreurs charognardes et des Soldats oubliés partout, avec des Sentinelles éternelles parmi eux.\nAttention : les Pleureuses de la mort (61, élites rares) dérivent sur {area:16868} : tenez-vous à l'écart d'eux.\nAttention : Grimroot, le tréant élite (niveau 60), parcourt les pentes en chemin : laissez-lui de la place.",
	-- ["The ruined catapult and flying machine"] = "La catapulte et l'engin volant en ruines",
	-- ["Two of the wrecks {npc:256222} named lie at the east end of the fields: plant one of his seeds beside each."] = "Deux des épaves dont {npc:256222} a parlé se trouvent à l'extrémité est des champs : plantez une de ses graines à côté de chacune.",
	-- ["the {npc:262036}"] = "les {npc:262036}",
}
