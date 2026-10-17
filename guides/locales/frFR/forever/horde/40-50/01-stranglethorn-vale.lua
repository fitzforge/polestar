-- French (frFR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vol pour {area:392}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["From {area:2408} fly to {area:392}."] = "Depuis {area:2408}, prenez un vol pour {area:392}.",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Le bateau pour {area:35} accoste au bout du ponton de {area:392}.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Ponton de {area:392}",

	-- Step 3: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Le bateau accoste dans le port de {area:35}. Les donneurs de quête se tiennent sur les passerelles autour du port et dans l'auberge.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}"] = "pour Stoley en {zone:1446}",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773} : pour {quest:2864} à {area:976}",

	-- Step 4: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Quittez la ville par le tunnel ; la note se trouve dans la crique des pirates juste au nord de {area:35}.",

	-- Step 6: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres se trouvent dans leurs tentes. Tout pirate de la Voile sanglante peut porter le tabac et l'œil de {npc:2493} : continuez jusqu'à avoir les deux.",

	-- Step 8: The Bloodsail ships
	["The Bloodsail ships"] = "Les navires de la Voile sanglante",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Les trois navires sont au large de {area:43}. Les équipages sont de niveau 42-45, Stillwater 45, Keelhaul 46 et {npc:2546} 48 : au niveau 41, c'est un combat pour un groupe, ou pour la fin du guide. Si vous y allez, nagez jusqu'aux navires et attirez l'équipage au bastingage un par un. Un parchemin, {quest:624}, se trouve sur le pont des navires : prenez-le.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "pour une étape ultérieure dans {zone:1435}",

	-- Step 10: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Prenez la route vers le nord hors de {area:35} ; Unbagwa est assis sur une colline de {area:1737}, à l'est de la route.",

	-- Step 11: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilles de Valbrume",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Les gorilles parcourent la vallée autour d'Unbagwa. Les anciens laissent tomber les abats ; tous peuvent laisser tomber un croc.",

	-- Step 12: Mokk the Savage
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Donnez les crocs à Unbagwa et restez près de lui : il appelle trois vagues de gorilles, puis {npc:1514}. Combattez-les un par un.",

	-- Step 13: Zanzil's camps
	["Zanzil's camps"] = "Les camps de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Au nord-est de Valbrume, les disciples de Zanzil campent dans la jungle ; chacun d'eux peut porter le mélange.",

	-- Step 14: Venture Co. mine
	["Venture Co. mine"] = "Mine de la KapitalRisk",
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Plus au nord, les gobelins de la KapitalRisk creusent la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs laissent tous tomber les cristaux.",

	-- Step 15: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north-west to {object:3202}."] = "Chevauchez vers le nord-ouest jusqu'à {object:3202}.",
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "pour plus tard : {zone:1425}, vers le niveau 48",

	-- Step 16: Nesingwary's Expedition
	["Ride north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",

	-- Step 17: Zul'Kunda
	["Zul'Kunda"] = "Ruines de Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les Ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",

	-- Step 19: Jungle stalkers
	["Jungle stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Les raptors traqueurs chassent dans la jungle au sud de {object:3202}, vers la côte ouest.",

	-- Step 20: Naga shore and the Holy Spring
	-- {object:759} Holy Spring
	["Naga shore and the {object:759}"] = "Rivage des nagas et {object:759}",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Suivez la côte vers le sud. Les explorateurs nagas pataugent le long du rivage et portent les bottes de roseaux ; {object:759} bouillonne dans les collines juste à l'est.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Chevauchez vers le sud jusqu'à {area:35}. Phillippe le Chancelant attend sur les quais.",

	-- Step 22: Pirate ghosts
	["Pirate ghosts"] = "Pirates fantômes",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Les trois pirates fantômes hantent la jungle au nord de {area:35}, près des camps de Zanzil : {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est.",

	-- Step 23: Zul'Mamwe
	["Zul'Mamwe"] = "Ruines de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Chevauchez vers le nord jusqu'aux ruines Skullsplitter à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve au nord des ruines. Tout Skullsplitter peut laisser tomber une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	["Skullsplitter warriors"] = "Guerriers Skullsplitter",

	-- Step 24: Balia'mah Ruins
	["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Les crânes trophées suivants se trouvent dans les petites ruines juste au nord du camp des guerriers.",

	-- Step 25: Ziata'jai Ruins
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Les derniers crânes sont dans les ruines un peu à l'ouest, sur le chemin du retour vers {object:3202}.",

	-- Step 26: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride west to {object:3202}."] = "Chevauchez vers l'ouest jusqu'à {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "le {object:2076}",

	-- Step 27: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",

	-- Step 28: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vol pour {object:3202}",

	-- Step 29: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",

	-- Step 30: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Vers {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continuez vers le nord jusqu'à {zone:1431}, puis vers l'est par la route à travers {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï près de l'entrée depuis {zone:1430}.",

	-- Step 31: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Chevauchez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",

	-- Step 32: Draenethyst crystals
	["Draenethyst crystals"] = "Cristaux de draenéthyste",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Chevauchez vers le nord-est jusqu'à {area:76}. Les cristaux se dressent le long du chemin qui monte vers la cage de {npc:5391}.",

	-- Step 33: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} est retenu à {area:76}, dans le nord-est du marais. Libérez-le et suivez-le dehors en repoussant les créatures du marais qui le poursuivent.",

	-- Step 34: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru erre dans la clairière au sud-ouest de {area:76} ; son gourdin lance une quête.",

	-- Step 35: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "Son coffre attend à son ancien camp au nord de {area:75}.",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et vers le sud jusqu'à {area:75} ; environ un sur quatre laisse tomber un flanc.",

	-- Step 37: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Chevauchez vers l'ouest le long de la route jusqu'au camp draeneï de {area:657}, près de l'entrée depuis {zone:1430}.",

	-- Step 38: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Revenez vers l'est après {area:75} et suivez la route vers le sud-est jusqu'au petit poste de la Horde sur le rivage.",

	-- Step 39: Sawtooth snappers
	["Sawtooth snappers"] = "Mordeurs Dents-de-scie",
	["The snappers line the strand south of the post."] = "Les mordeurs bordent la grève au sud du poste.",

	-- Step 40: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}."] = "Le guide suivant commence ici et vous emmène en {zone:1446}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:657}"] = "{area:657}",
}
