-- German (deDE): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {area:35} Booty Bay
	["Gyll, {area:35}"] = "Gyll, {area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Folge von {area:42} aus der Straße nach Osten durch {zone:1430} in {zone:1435}; Biggs bewacht die Straßenkreuzung gleich hinter der Grenze. {npc:217412} steht ein kurzes Stück nördlich von ihm.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: drei Kleintiere zum Fangen im Arathihochland, in {zone:1443} und im Schlingendorntal",

	-- Step 3: The western swamp
	["The western swamp"] = "Der westliche Sumpf",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Junge Sägezahnkrokilisken, Trauerspinner und Sumpfjaguare streifen alle durch den Sumpf um die Straße.",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "Die zerstörte Karawane liegt abseits der Straße nahe Biggs.",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Folge der Straße nach Norden zu den Draenei in {area:657}.",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Auf der Straße nach Osten zu {area:76}. Gegner vom Typ {npc:256028} lassen die Kristalle fallen; Noboru streift durch die Ruinen und lässt seinen Knüppel fallen.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} ist am Nordende des Refugiums eingesperrt. Befreie ihn und halte ihn auf dem Weg hinaus am Leben; seine Geldkassette wartet danach an der Straße.",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Zurück nach Westen durch {zone:1430} nach {area:42}.",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, Straße zum {area:17203}",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Kathedrale des Lichts",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, die Königliche Bibliothek in der Burg",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} wartet im Keller von {object:2164} in {object:2101}. Benutze {item:6913} am Beschwörungskreis dort und besiege den herbeigerufenen Sukkubus. Wenn du {quest:65602} angenommen hast, gib ihm auch {item:190309}, stelle sie am selben Kreis ab und besiege den Inkubus.",
	["Subdue the succubus"] = "Bezwinge den Sukkubus",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, falls du sie angenommen hast",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, am selben Kreis",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} bindet den Inkubus an dich",

	-- Step 14: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455} und trainiere bei {npc:258098}. {npc:1573} bei {object:32372} fliegt ebenfalls nach {area:271}.",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Ein {npc:2434} lauert unsichtbar am Rand von {area:271}; töte ihn und lies den Vertrag, den er bei sich trägt.",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Folge der Straße von {area:287} nach Osten über {area:1057} nach {area:320}.",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Das Syndikat hält den Hof nordwestlich von {area:320}. Ein {npc:217589} krabbelt auf dem Hof herum: Fang einen mit dem Einsteigerpaket für Entomologen von {npc:217412} und hak ihn dann ab.",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: Fang ihn, für {quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Folge der Straße nach Süden über die Brücke nach {area:205} am Ende im {zone:1437}, wo {npc:1075} wartet.",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Geh zurück auf den Übergang: Ebenezer liegt unter dessen Ende im Arathihochland.",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Nach Westen entlang der Küste zur Bucht der Goblins; Lolo hält auf den Felsen darüber Wache.",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "Phizzlethorpe",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Eskortiere den Professor zum Strand nördlich der Bucht und beschütze ihn, während er arbeitet; Naga greifen in Wellen an.",

	-- Step 26: The wrecks
	["The wrecks"] = "Die Wracks",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Die beiden Wracks liegen in der Bucht westlich der Bucht der Goblins. Die Karten und Logbücher sind darin; die Edelsteine liegen um sie herum auf dem Meeresgrund. Naga der Säbelflossen schwimmen in der ganzen Bucht.",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Für {npc:2487} in {area:35}: behalten",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Geh zurück nach Nordosten an {area:320} vorbei; {npc:2712} und {npc:2713} lagern in den Hügeln nördlich von {area:314}.",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Der Kurier geht mit zwei Wachen die Straße westlich von {area:314} entlang; lock sie von der Straße weg.",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} und {npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "Auftrag von {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Bleib bei {npc:2713}, während sie sich nach {area:314} und zurück schleicht; Orcs der Horde fallen unterwegs über dich her.",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Für {npc:2711} in {area:271}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Geh nach Norden an {area:314} vorbei; die Splitter glitzern auf dem Hügel bei {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Nur wenn Gluckser dir im Schlingendorntal den Anhänger gegeben hat",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Die Kobolde der Trockenstoppel graben in der Schlucht östlich von {area:321} (Horde); umgeh den Ort im Norden. Sie lassen sowohl die Partikel als auch Krazeks Erz fallen.",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Die Splitter liegen am hinteren Ende von {area:318}.",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Die Trolle der Witherbark leben in den Hügeln südlich von {area:314}; Hexendoktoren der Witherbark stehen im Dorf, Schattenjäger der Witherbark bewachen das hintere Ende des Tals.",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Jeder Schlüssel liegt an einem der Steinkreise des Hochlands: östlich der Splitter, nahe {area:320} und im Westen. {object:2702} steht westlich von {area:320}.",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, ein Ogermagier, hält die Höhle am Südende des Witherbark-Tals.",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Folge der Straße von {area:271} nach Norden in die Berge. Berglöwen streifen über die Hänge; das Syndikat in {area:280} trägt die Siegelringe, und {npc:2306} geht auf dem Gutshof an der Nordseite des Orts umher.",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "Crushridge-Oger",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Die Crushridge-Oger halten die Hügel nördlich von {area:280}. Weiter nördlich enthält eine abgenutzte Holztruhe {item:3706}; {npc:2320} aus {quest:537} steht direkt daneben.",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Die Folianten liegen in der zerstörten Burg westlich von {area:280}; Schattenmagier der Arguswacht halten die Ruinen.",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: Crushridge-Oger",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Nach Südwesten zum Lager der Kirin Tor am Seeufer westlich von {area:279}, gleich hinter der Grenze in {zone:1421}: Dort steht {npc:269127}. Erzmagier Ansirem steht südöstlich davon, bei der Kuppel.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Für {npc:2542} in {area:35}: behalten",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} für {npc:2438}s Umhang, von {npc:2381}, falls du keinen hast",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Für {npc:1440} in {zone:1453}: behalten",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Nimm von {zone:1455} aus den Tunnel nach Osten durch {zone:1426} nach {zone:1432} und folge der Straße nach {area:144}.",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "Nach Südosten am See entlang zur Ausgrabungsstätte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "Folge der Straße nach Norden zu den Draenei von {area:657}.",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Reite zurück nach Nordosten an {area:320} vorbei; {npc:2712} und {npc:2713} lagern in den Hügeln nördlich von {area:314}.",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, in der Stadt Dalaran",
}
