-- French (frFR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 2: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "",

	-- Step 4: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",

	-- Step 5: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Le bateau accoste dans le port de {area:35}. Les donneurs de quête se tiennent sur les passerelles autour du port et dans l'auberge.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}; upstairs"] = "",
	["Inside"] = "",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}; on the top floor"] = "",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vol pour {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Quittez la ville par le tunnel ; la note se trouve dans la crique des pirates juste au nord de {area:35}.",

	-- Step 13: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 14: Mistvale Valley: kill these as you meet them
	-- {area:1737} Mistvale Valley
	["{area:1737}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye · {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both.\nTake the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "",

	-- Step 16: The Bloodsail ships
	["The Bloodsail ships"] = "Les navires de la Voile sanglante",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Les trois navires sont au large de {area:43}. Les équipages sont de niveau 42-45, Stillwater 45, Keelhaul 46 et {npc:2546} 48 : au niveau 41, c'est un combat pour un groupe, ou pour la fin du guide. Si vous y allez, nagez jusqu'aux navires et attirez l'équipage au bastingage un par un. Un parchemin, {quest:624}, se trouve sur le pont des navires : prenez-le.",
	-- {area:8} Swamp of Sorrows
	["for a later stop in the {area:8}"] = "",

	-- Step 17: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Prenez la route vers le nord hors de {area:35} ; Unbagwa est assis sur une colline de {area:1737}, à l'est de la route.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilles de Valbrume",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Les gorilles parcourent la vallée autour d'Unbagwa. Les anciens laissent tomber les abats ; tous peuvent laisser tomber un croc.",

	-- Step 19: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Donnez les crocs à Unbagwa et restez près de lui : il appelle trois vagues de gorilles, puis {npc:1514}. Combattez-les un par un.",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "Mine de la KapitalRisk",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 23: Nesingwary's camp
	["Nesingwary's camp"] = "",

	-- Step 24: Zul'Kunda
	["Zul'Kunda"] = "Ruines de Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les Ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les.",

	-- Step 25: Hearth to Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp
	["Hearth to {area:117}"] = "",

	-- Step 26: Grom'gol
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}, beside Nimboya"] = "",

	-- Step 27: Jungle stalkers
	["Jungle stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Les raptors traqueurs chassent dans la jungle au sud de {object:3202}, vers la côte ouest.",

	-- Step 28: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Suivez la côte vers le sud. Les explorateurs nagas pataugent le long du rivage et portent les bottes de roseaux ; {object:759} bouillonne dans les collines juste à l'est.",

	-- Step 29: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Chevauchez vers le sud jusqu'à {area:35}. Phillippe le Chancelant attend sur les quais.",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "",

	-- Step 30: Zanzil's camps
	["Zanzil's camps"] = "Les camps de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Au nord-est de Valbrume, les disciples de Zanzil campent dans la jungle ; chacun d'eux peut porter le mélange.",

	-- Step 31: Pirate ghosts
	["Pirate ghosts"] = "Pirates fantômes",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Les trois pirates fantômes hantent la jungle au nord de {area:35}, près des camps de Zanzil : {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est.",

	-- Step 32: Zul'Mamwe
	["Zul'Mamwe"] = "Ruines de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Chevauchez vers le nord jusqu'aux ruines Skullsplitter à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve au nord des ruines. Tout Skullsplitter peut laisser tomber une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	["Skullsplitter warriors"] = "Guerriers Skullsplitter",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "",

	-- Step 33: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "",

	-- Step 34: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride west to {object:3202}."] = "Chevauchez vers l'ouest jusqu'à {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "le {object:2076}",

	-- Step 36: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",

	-- Step 39: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",

	-- Step 41: Into the Swamp of Sorrows
	-- {area:8} Swamp of Sorrows
	["Into the {area:8}"] = "",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continuez vers le nord jusqu'à {zone:1431}, puis vers l'est par la route à travers {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï près de l'entrée depuis {zone:1430}.",

	-- Step 42: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Chevauchez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",

	-- Step 43: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 44: Monstrous Crawler Leg on the way
	-- {item:6184} Monstrous Crawler Leg
	["{item:6184} on the way"] = "",

	-- Step 45: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {npc:5391} Galen Goodward · {area:75} Stonard · {npc:5592} Tok'Kar
	-- plural, as words: Shadow Panthers = {npc:768} Shadow Panther
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank.\nCareful: {npc:5592}'s camp sits by the coast. Along the way to it you pass level 40 spiders that chase a long distance, plus stealthed Shadow Panthers."] = "",

	-- Step 46: Fly to Booty Bay
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 47: Boat to Ratchet
	-- {area:392} Ratchet
	["Boat to {area:392}"] = "",

	-- Step 48: Riding at 40
	["Riding at 40"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Another race's trainer (Kildar in {zone:1454}) teaches you only once you are Exalted with his city."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "",

	-- Step 50: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "",

	-- Step 51: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru erre dans la clairière au sud-ouest de {area:76} ; son gourdin lance une quête.",

	-- Step 52: Draenethyst crystals
	["Draenethyst crystals"] = "Cristaux de draenéthyste",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Chevauchez vers le nord-est jusqu'à {area:76}. Les cristaux se dressent le long du chemin qui monte vers la cage de {npc:5391}.",

	-- Step 53: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} est retenu à {area:76}, dans le nord-est du marais. Libérez-le et suivez-le dehors en repoussant les créatures du marais qui le poursuivent.",

	-- Step 54: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Chevauchez vers l'ouest le long de la route jusqu'au camp draeneï de {area:657}, près de l'entrée depuis {zone:1430}.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "Son coffre attend à son ancien camp au nord de {area:75}.",

	-- Step 56: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Revenez vers l'est après {area:75} et suivez la route vers le sud-est jusqu'au petit poste de la Horde sur le rivage.",

	-- Step 57: Sawtooth snappers
	["Sawtooth snappers"] = "Mordeurs Dents-de-scie",
	["The snappers line the strand south of the post."] = "Les mordeurs bordent la grève au sud du poste.",

	-- Step 58: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}.\nThe small Horde post on the southern shore."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}"] = "Vol pour {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "Depuis {area:2408}, prenez un vol pour {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Plus au nord, les gobelins de la KapitalRisk creusent la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs laissent tous tomber les cristaux.",
	-- ["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- ["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",
	-- ["Into the {zone:1435}"] = "Vers {zone:1435}",
	-- ["Naga shore and the {object:759}"] = "Rivage des nagas et {object:759}",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",
	-- ["Ride north-west to {object:3202}."] = "Chevauchez vers le nord-ouest jusqu'à {object:3202}.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres se trouvent dans leurs tentes. Tout pirate de la Voile sanglante peut porter le tabac et l'œil de {npc:2493} : continuez jusqu'à avoir les deux.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Le bateau pour {area:35} accoste au bout du ponton de {area:392}.",
	-- ["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et vers le sud jusqu'à {area:75} ; environ un sur quatre laisse tomber un flanc.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Les derniers crânes sont dans les ruines un peu à l'ouest, sur le chemin du retour vers {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Le guide suivant commence ici et vous emmène en {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Les crânes trophées suivants se trouvent dans les petites ruines juste au nord du camp des guerriers.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["for Stoley in {zone:1446}"] = "pour Stoley en {zone:1446}",
	-- ["for a later stop in the {zone:1435}"] = "pour une étape ultérieure dans {zone:1435}",
	-- ["for later: the {zone:1425}, around level 48"] = "pour plus tard : {zone:1425}, vers le niveau 48",
	-- ["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",
	-- ["{area:392} pier"] = "Ponton de {area:392}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773} : pour {quest:2864} à {area:976}",
}
