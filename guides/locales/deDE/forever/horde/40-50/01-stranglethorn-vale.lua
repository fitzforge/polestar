-- German (deDE): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["From {area:2408} fly to {area:392}."] = "Flieg von {area:2408} nach {area:392}.",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Schiff nach {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Das Schiff nach {area:35} legt am Ende des Piers von {area:392} an.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Pier von {area:392}",

	-- Step 3: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Das Schiff legt im Hafen von {area:35} an. Die Questgeber stehen auf den Stegen rund um den Hafen und im Gasthaus.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}"] = "für Stoley in {zone:1446}",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: für {quest:2864} in {area:976}",

	-- Step 4: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Verlass den Ort durch den Tunnel; die Notiz liegt in der Piratenbucht gleich nördlich von {area:35}.",

	-- Step 6: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Südlich von Booty Bay lagern die Schwadroneure der Blutsegelbukaniere an der {area:43}; die Karten und Befehle liegen in ihren Zelten. Jeder Blutsegelbukanier kann Schnupftabak und {npc:2493}s Auge tragen, also töte weiter, bis du beides hast.",

	-- Step 8: The Bloodsail ships
	["The Bloodsail ships"] = "Die Schiffe der Blutsegelbukaniere",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Die drei Schiffe liegen vor der {area:43}. Die Besatzungen sind 42-45, Stillwasser 45, Kielhol 46 und {npc:2546} 48: Mit 41 ist das ein Kampf für eine Gruppe oder für das Ende des Guides. Wenn du hingehst, schwimm hinaus und zieh die Besatzung einzeln an die Reling. Eine Schriftrolle, {quest:624}, liegt auf den Decks der Schiffe: Nimm sie mit.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "für einen späteren Halt in den {zone:1435}",

	-- Step 10: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Nimm die Straße nach Norden aus {area:35}; Unbagwa sitzt auf einem Hügel in {area:1737}, östlich der Straße.",

	-- Step 11: Mistvale gorillas
	["Mistvale gorillas"] = "Nebeltalgorillas",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Die Gorillas streifen durch das Tal um Unbagwa. Die Alten lassen die Innereien fallen; jeder kann einen Fangzahn fallen lassen.",

	-- Step 12: Mokk the Savage
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Gib Unbagwa die Fangzähne und bleib bei ihm: Er ruft drei Wellen Gorillas, dann {npc:1514}. Kämpf einzeln gegen sie.",

	-- Step 13: Zanzil's camps
	["Zanzil's camps"] = "Lager von Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Nordöstlich des Nebeltals lagern Zanzils Anhänger im Dschungel; jeder von ihnen kann die Mixtur tragen.",

	-- Step 14: Venture Co. mine
	["Venture Co. mine"] = "Mine der Venture Co.",
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Weiter nördlich graben die Goblins der Venture Co. in der Mine östlich der Straße; Minenarbeiter, Großknechte, Feldmesser und Tüftler lassen alle die Kristalle fallen.",

	-- Step 15: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north-west to {object:3202}."] = "Reite nach Nordwesten nach {object:3202}.",
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "für später: das {zone:1425}, etwa ab Stufe 48",

	-- Step 16: Nesingwary's Expedition
	["Ride north up the road; the hunters camp on the hill above the river."] = "Reite die Straße nach Norden hinauf; die Jäger lagern auf dem Hügel über dem Fluss.",

	-- Step 17: Zul'Kunda
	["Zul'Kunda"] = "Ruinen von Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Westlich der Expedition stehen die Häuptlinge der Bloodscalp, {npc:1061} und {npc:1062}, zusammen in den Ruinen von Zul'Kunda. Räum zuerst ihre Wachen weg und zieh dann die beiden.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Ruhestein nach {object:3202}",
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, neben {npc:2497}",

	-- Step 19: Jungle stalkers
	["Jungle stalkers"] = "Dschungelpirscher",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Die Pirscher-Raptoren jagen im Dschungel südlich von {object:3202}, hinaus Richtung Westküste.",

	-- Step 20: Naga shore and the Holy Spring
	-- {object:759} Holy Spring
	["Naga shore and the {object:759}"] = "Nagaufer und {object:759}",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Folge der Küste nach Süden. Die Forscher der Naga waten am Ufer entlang und tragen die Schilfbündel; {object:759} sprudelt in den Hügeln gleich östlich davon.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Reite nach Süden nach {area:35}. Der zittrige Phillipe wartet an den Docks.",

	-- Step 22: Pirate ghosts
	["Pirate ghosts"] = "Piratengeister",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Die drei geisterhaften Piraten spuken im Dschungel nördlich von {area:35}, nahe Zanzils Lagern: {npc:2535} und {npc:2536} stehen zusammen, {npc:2537} weiter östlich.",

	-- Step 23: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinen von Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Reite nach Norden zu den Ruinen der Skullsplitter östlich der Mine der Venture Co.; zieh die Kopfjäger und Berserker einzeln. {npc:1059} bewacht die südwestlichen Ruinen, und ein Haufen Trophäenschädel steht auf der Nordseite der Ruinen. Jeder Skullsplitter kann einen Hauer oder eine Halskette fallen lassen: Die Halsketten dauern am längsten, also töte im Kriegerlager nördlich der Ruinen weiter, bis du alle hast.",
	["Skullsplitter warriors"] = "Krieger der Skullsplitter",

	-- Step 24: Balia'mah Ruins
	["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Die nächsten Trophäenschädel stehen in den kleinen Ruinen gleich nördlich des Kriegerlagers.",

	-- Step 25: Ziata'jai Ruins
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Die letzten Schädel sind in den Ruinen ein kurzes Stück westlich, auf dem Rückweg nach {object:3202}.",

	-- Step 26: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride west to {object:3202}."] = "Reite nach Westen nach {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",

	-- Step 27: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Ruhestein nach {area:35}",

	-- Step 28: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",

	-- Step 29: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Reite die Straße nach Norden hinauf zum Lager der Jäger.",

	-- Step 30: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "In die {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Reite weiter nach Norden in den {zone:1431}, dann auf der Straße nach Osten durch den {zone:1430} in den Sumpf. {npc:1776} wartet bei {area:657}, dem Draeneilager nahe dem Weg vom {zone:1430} herein.",

	-- Step 31: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Reite nach Osten nach {area:75}, im Schilf südlich der Straße.",

	-- Step 32: Draenethyst crystals
	["Draenethyst crystals"] = "Draenethystkristalle",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Reite nach Nordosten zum {area:76}. Die Kristalle stehen am Weg hinauf zum Käfig von {npc:5391}.",

	-- Step 33: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} wird im {area:76} im Nordosten des Sumpfs gefangen gehalten. Befrei ihn und folge ihm hinaus; wehr die Sumpfkreaturen ab, die ihn verfolgen.",

	-- Step 34: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru wandert über die Lichtung südwestlich vom {area:76}; sein Knüppel startet eine Quest.",

	-- Step 35: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "Seine Geldkassette wartet in seinem alten Lager nördlich von {area:75}.",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Sägezahnkrokilisken",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Die Krokilisken suhlen sich in den Tümpeln um {npc:5391}s Lager und südlich Richtung {area:75}; etwa jeder vierte lässt eine Flanke fallen.",

	-- Step 37: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Reite auf der Straße nach Westen zum Draeneilager bei {area:657}, nahe dem Weg vom {zone:1430} herein.",

	-- Step 38: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Reite zurück nach Osten an {area:75} vorbei und folge der Straße nach Südosten zum kleinen Hordeposten am Ufer.",

	-- Step 39: Sawtooth snappers
	["Sawtooth snappers"] = "Sägezahnschnapper",
	["The snappers line the strand south of the post."] = "Die Schnapper säumen den Strand südlich des Postens.",

	-- Step 40: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}."] = "Der nächste Guide beginnt hier und bringt dich nach {zone:1446}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:657}"] = "{area:657}",
}
