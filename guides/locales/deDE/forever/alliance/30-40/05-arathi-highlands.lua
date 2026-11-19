-- German (deDE): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:327} Faldir's Cove
	["For characters of 35 to 37. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "Für Charaktere der Stufe 35 bis 37. {area:327}, wo die Naga und die Wasserelementare des Professors 38-40 sind, ist ein Gruppenstopp: Überspring ihn, wenn du allein bist.",

	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "{npc:5476} bewacht die Straßenkreuzung im Westen des Sumpfes. {npc:217412} steht ein kurzes Stück nördlich von ihm.\n{npc:217412} ist auf Forever vielleicht nicht hier: Falls {npc:217412} {quest:93176} nicht anbietet, überspring sie.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: drei Kleintiere zum Fangen im Arathihochland, in {zone:1443} und im Schlingendorntal",

	-- Step 4: The western swamp
	["The western swamp"] = "Der westliche Sumpf",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Junge Sägezahnkrokilisken, Trauerspinner und Sumpfjaguare streifen alle durch den Sumpf um die Straße.",

	-- Step 6: Father Tuttle
	-- {npc:255597} Father Tuttle · {area:657} Harborage
	["North-west of Watcher Biggs, {npc:255597} (level 34) waits by the road: lead him north to the {area:657}, on your way there. Stay close to him and clear what attacks him; if he falls, abandon the quest and go on."] = "Nordwestlich von Wächter Biggs wartet {npc:255597} (Stufe 34) an der Straße: Führ ihn auf deinem Weg dorthin nach Norden zur {area:657}. Bleib nah bei ihm und erledige, was ihn angreift; stirbt er, brich die Quest ab und zieh weiter.",

	-- Step 7: Harborage
	-- {area:657} Harborage · {npc:254775} Karana · {npc:254770} Pelluk · {npc:1776} Magtoor · {area:76} Fallow Sanctuary
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Follow the road north to the draenei of the {area:657}. {npc:254775} and {npc:254770} stand beside {npc:1776}: their Lost Ones are the ones you meet in the {area:76} anyway."] = "Folge der Straße nach Norden zu den Draenei der {area:657}. {npc:254775} und {npc:254770} stehen neben {npc:1776}: Ihre Verirrten sind die, denen du im {area:76} ohnehin begegnest.",
	-- {npc:1776} Magtoor · {npc:255597} Father Tuttle
	["{npc:1776}: {npc:255597}'s escort"] = "{npc:1776}: Eskorte von {npc:255597}",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {quest:1389} Draenethyst Crystals · {npc:254797} Lost One · {npc:254775} Karana · {npc:254770} Pelluk · {item:258530} Lucky Lure · {quest:1392} Noboru the Cudgel · {npc:1776} Magtoor
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["East along the road to the {area:76}. The {quest:1389} are the glowing blue crystals among the Lost Ones' tents: click them. Any {npc:254797} counts for {npc:254775}, and the Lost One Fishermen on the sanctuary's west side carry {npc:254770}'s {item:258530}. {quest:1392} walks a long path through the ruins; his cudgel starts a quest for {npc:1776}. Don't wait for him.\nCareful: Noboru is level 39, two over you here: fight him only with a friend or from level 38; otherwise let him pass."] = "Nach Osten die Straße entlang zum {area:76}. Die {quest:1389} sind die leuchtend blauen Kristalle zwischen den Zelten der Verirrten: Klick sie an. Jeder {npc:254797} zählt für {npc:254775}, und die Angler der Verirrten auf der Westseite des Refugiums tragen {npc:254770}s {item:258530}. {quest:1392} läuft einen langen Weg durch die Ruinen; sein Knüppel startet eine Quest für {npc:1776}. Warte nicht auf ihn.\nVorsicht: Noboru ist Stufe 39, zwei über dir: Kämpf nur mit einem Freund oder ab Stufe 38 gegen ihn; sonst lass ihn vorbeiziehen.",
	-- {quest:1392} Noboru the Cudgel
	["from {quest:1392}: he walks a path through the ruins"] = "von {quest:1392}: Er läuft einen Weg durch die Ruinen",
	-- {item:6071} Draenethyst Crystal
	["{item:6071}, the blue crystals by the tents"] = "{item:6071}, die blauen Kristalle bei den Zelten",
	-- {item:258530} Lucky Lure · {npc:757} Lost One Fisherman
	["{item:258530}, from a {npc:757}"] = "{item:258530}, von einem {npc:757}",
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Lost Ones: Hunters, Muckdwellers, Seers and Riftseekers all count"] = "Verirrte: Jäger, Schlammbewohner, Seher und Risssucher zählen alle",

	-- Step 9: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "Die Truhe der zerstörten Karawane liegt am Nordende des {area:76}, neben dem Käfig von {npc:5391}.\nVorsicht: Das Lager ist voller Lost Ones um Stufe 38. Sie stehen in verbundenen Gruppen zu 2-3, viele sind Zauberwirker, und sie respawnen schnell.",

	-- Step 10: Galen Goodward
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost One Riftseekers = {npc:762} Lost One Riftseeker · Lost Ones = {npc:254797} Lost One
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards. Careful: on the walk out the camp's Lost One Riftseekers (37-38) and their pets, with the Lost Ones around them, turn on {npc:5391}: clear the cage and the start of his path first, stay beside him and pull every attacker onto yourself. Many players lose him the first time; if he dies, abandon the quest and take it again at his cage."] = "{npc:5391} ist am Nordende des Refugiums eingesperrt. Befreie ihn und halte ihn auf dem Weg hinaus am Leben; seine Geldkassette wartet danach an der Straße. Vorsicht: Auf dem Weg hinaus greifen die Kluftsucher der Verlorenen (37-38) des Lagers und ihre Tiere, mit den Verlorenen um sie herum, {npc:5391} an: Räum zuerst den Käfig und den Anfang seines Wegs frei, bleib neben ihm und zieh jeden Angreifer auf dich. Viele Spieler verlieren ihn beim ersten Mal; stirbt er, brich die Quest ab und nimm sie an seinem Käfig erneut an.",

	-- Step 11: Harborage
	-- {npc:5391} Galen Goodward · {area:657} Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "Nach Westen entlang der Straße von der Geldkassette von {npc:5391} zum {area:657}.",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "{npc:1776}: Noboros Knüppel",
	-- {npc:1776} Magtoor · {quest:93464} The Visiting Mage · {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:1776}: {quest:93464}, for {npc:11863} in {zone:1443}, on the {zone:1443} guide at the end of 30-40"] = "{npc:1776}: {quest:93464}, für {npc:11863} in {zone:1443}, im {zone:1443}-Guide am Ende von 30-40",

	-- Step 12: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "Südlich die Straße hinunter zu {npc:5476}, auf dem Weg nach Westen aus dem Sumpf.",

	-- Step 14: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Zurück nach Westen durch {zone:1430} nach {area:42}.",

	-- Step 15: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, Straße zum {area:17203}",

	-- Step 16: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} wartet im Keller von {object:2164} in {object:2101}. Benutze {item:6913} am Beschwörungskreis dort und besiege den herbeigerufenen Sukkubus. Wenn du {quest:65602} angenommen hast, gib ihm auch {item:190309}, stelle sie am selben Kreis ab und besiege den Inkubus.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "{npc:5677}, am Beschwörungskreis",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, falls du sie angenommen hast",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, am selben Kreis",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} bindet den Inkubus an dich",

	-- Step 17: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Kathedrale des Lichts",

	-- Step 19: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, die Königliche Bibliothek in der Burg",

	-- Step 20: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tiefenbahn nach {zone:1455}",

	-- Step 21: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",

	-- Step 22: Southshore
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside, if 30-40/01 didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}, drinnen, falls 30-40/01 sie nicht angenommen hat: Das Lager des Syndikats liegt auf dem Weg ins Arathihochland",

	-- Step 23: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore · {npc:2276} Magistrate Henry Maleb
	["A {npc:2434} (37-38) lurks stealthed on the edge of {area:271}, and few players find him. Careful: he is a level or two over you; fight him only at full health, or leave him. His contract goes to {npc:2276}. Don't wait for him: the rest of this step doesn't need him."] = "Ein {npc:2434} (37-38) lauert getarnt am Rand von {area:271}, und nur wenige Spieler finden ihn. Vorsicht: Er ist ein oder zwei Stufen über dir; kämpfe nur mit voller Gesundheit gegen ihn oder lass ihn in Ruhe. Sein Vertrag geht an {npc:2276}. Warte nicht auf ihn: Der Rest dieses Schritts braucht ihn nicht.",
	-- {npc:2434} Shadowy Assassin
	["{npc:2434}, if you spot him"] = "{npc:2434}, wenn du ihn entdeckst",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, drinnen",

	-- Step 25: Alterac Mountains
	["Syndicate camp"] = "Syndikatslager",

	-- Step 26: Syndicate camp
	-- {area:271} Southshore · {area:272} Tarren Mill
	-- plural, as words: Syndicate Wizards = {npc:2319} Syndicate Wizard
	["North out of {area:271} to the Syndicate camp on the Alterac border, west of {area:272} (Horde): its Footpads and Thieves are the Syndicate Maleb wants, and the documents lie in the camp. Then back to the road and east to Arathi.\nCareful: a few Syndicate Wizards (34-35) stand among the tents and cast from range: pull them one at a time."] = "Von {area:271} nach Norden zum Lager des Syndikats an der Grenze zu Alterac, westlich von {area:272} (Horde): Seine Straßenräuber und Diebe sind das Syndikat, das Maleb will, und die Dokumente liegen im Lager. Dann zurück zur Straße und nach Osten ins Arathihochland.\nVorsicht: Einige Hexer des Syndikats (34-35) stehen zwischen den Zelten und zaubern aus der Ferne: Zieh sie einzeln.",

	-- Step 28: Refuge Pointe
	-- {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["From the Syndicate camp, follow the road east over {area:1057} to {area:320}."] = "Folge vom Lager des Syndikats der Straße nach Osten über {area:1057} nach {area:320}.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700}: Die Bitte von {npc:1075}, von 01-hillsbrad-foothills",

	-- Step 29: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "Das Syndikat hält die Farm nordwestlich von {area:320}.\nVorsicht: Syndicate Highwaymen sind Stufe 30-31 und können außerhalb des Kampfes Schleichen wirken, sodass sie oft getarnt und schwer zu erkennen sind.",

	-- Step 30: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s {item:213565}."] = "Hay Weevils kriechen am Nordende der Farm von {quest:681} umher: Fang eines mit dem Werkzeug aus dem {item:213565} von {npc:217412}.",

	-- Step 31: Shards of Myzrael
	-- {quest:681} Northfold Manor · {area:333} Circle of East Binding · {area:314} Go'Shek Farm
	["East from {quest:681} across the north of the Highlands; the shards glitter on the hill by the {area:333}, north of {area:314}."] = "Nach Osten von {quest:681} quer durch den Norden des Hochlands; die Splitter glitzern auf dem Hügel bei {area:333}, nördlich von {area:314}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Nur wenn Gluckser dir im Schlingendorntal den Anhänger gegeben hat",

	-- Step 32: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318}: Töte diese, sobald sie dir begegnen",
	-- {area:321} Hammerfall · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop the Motes of Myzrael, not Krazek's ore. Lesser Bloodstone Deposits need {skill:186} 75: mine four ore, buy them at the Auction House, or ask a miner friend. The ore goal is optional; continue with Myzrael if you cannot get it. Careful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Die Kobolde der Trockenstoppel graben in der Schlucht östlich von {area:321} (Horde); umgeh den Ort im Norden. Sie lassen die Körner von Myzrael fallen, nicht Krazeks Erz. Geringe Blutsteinablagerungen brauchen {skill:186} 75: Bau vier Erz ab, kauf sie im Auktionshaus oder frag einen befreundeten Bergarbeiter. Das Erz-Ziel ist optional; mach mit Myzrael weiter, wenn du es nicht bekommst. Vorsicht: Jede Koboldart rennt bei wenig Gesundheit um Hilfe (Kobolde bei 30%, Feldvermesser und Buddler bei 15%), was weitere anlocken kann.",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "{item:4435} von {npc:2572}, {npc:2573} und {npc:2574}, bei diesem Halt",

	-- Step 33: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Die Splitter liegen am hinteren Ende von {area:318}.",
	["Below ground"] = "Unter der Erde",

	-- Step 34: Iridescent Shards
	-- {quest:651} Stones of Binding · {object:2691} Stone of East Binding
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{quest:651} is a group quest at this level: three Cresting Exiles (38-39) guard the {object:2691} and attack together. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:651} ist auf dieser Stufe eine Gruppenquest: Drei Schäumende Verbannte (38-39) bewachen den {object:2691} und greifen gemeinsam an. Eine Gruppe wird empfohlen, such dir Mitspieler dafür. Überspring sie, wenn du allein bist.",

	-- Step 35: Witherbark Village
	-- {area:318} Drywhisker Gorge · {area:314} Go'Shek Farm · {area:317} Witherbark Village
	-- plural, as words: Witherbark Goliaths = {npc:218032} Witherbark Goliath
	["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk. Careful: Witherbark Goliaths (35, elite) walk the far end with the Shadow Hunters: pull the Hunters out to you one at a time, away from the Goliaths."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040}; unter der Erde",

	-- Step 36: Quae
	-- {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["North-west out of the Witherbark valley; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "Nach Nordwesten aus dem Witherbark-Tal hinaus; {npc:2712} und {npc:2713} lagern in den Hügeln direkt nördlich von {area:314}.",

	-- Step 37: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road from {area:314} west across the Highlands, as far as about 24,45, and back, with two guards: the arrow follows the road west until you meet him. Pull them off the road."] = "Der Kurier geht mit zwei Wachen die Straße von {area:314} nach Westen quer durch das Hochland bis etwa 24,45 und wieder zurück: Der Pfeil folgt der Straße nach Westen, bis du ihn triffst. Lock sie von der Straße weg.",

	-- Step 39: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} und {npc:2713}",

	-- Step 40: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "Auftrag von {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "Bleib bei {npc:2713}, während sie sich nach {area:314} schleicht und zurück; Orcs der Horde greifen dich unterwegs an.\nVorsicht: Orcs, die auf wenig Gesundheit fallen, laufen weg. {npc:2713} folgt ihnen und kann weitere Mobs ziehen, also töte oder verlangsame Flüchtende schnell.",

	-- Step 41: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Für {npc:2711} in {area:271}",

	-- Step 42: Stones of Binding
	-- {npc:2712} Quae · {object:2691} Stone of East Binding · {area:314} Go'Shek Farm · {object:2702} Stone of Inner Binding · {area:320} Refuge Pointe
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["From {npc:2712}'s camp, a short way north-east to the {object:2691}, by the shards' hill north of {area:314}. The {object:2702}, where the three keys go, stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Vom Lager von {npc:2712} ein kurzes Stück nach Nordosten zum {object:2691}, beim Hügel der Splitter nördlich von {area:314}. Der {object:2702}, wo die drei Schlüssel hingehören, steht westlich von {area:320}.\nVorsicht: Jeder mittlere Stein wird von etwa drei Elementaren nahe Stufe 39 bewacht, die gemeinsam angreifen, wenn du den Stein anklickst, ohne sie zu töten: Brennende Verbannte am westlichen, Donnernde Verbannte am äußeren, Schäumende Verbannte am östlichen Stein.",

	-- Step 43: Refuge Pointe
	-- {area:320} Refuge Pointe
	["West along the road to {area:320}."] = "Nach Westen entlang der Straße nach {area:320}.",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {object:2689} Stone of West Binding
	["{npc:2789}: {npc:2793}'s cave, west past the {object:2689}"] = "{npc:2789}: Die Höhle von {npc:2793}, westlich am {object:2689} vorbei",

	-- Step 45: Faldir's Cove
	-- {npc:2768} Professor Phizzlethorpe
	["A group stop: two level 40 water elementals ambush {npc:2768}'s escort, and the Daggerspine naga in the reef are 38-40, with Sorceresses among them. Grouping up is encouraged, look for people to do it with. Skip it if you are alone.\nSouth along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Ein Gruppenhalt: Zwei Wasserelementare der Stufe 40 überfallen die Eskorte von {npc:2768}, und die Naga der Dolchrücken im Riff sind 38-40, darunter Zauberinnen. Eine Gruppe wird empfohlen, such dir Mitspieler dafür. Überspring es, wenn du allein bist.\nNach Süden entlang der Westküste zur Bucht der Goblins; Lolo hält auf den Felsen darüber Wache.",

	-- Step 46: Phizzlethorpe
	["Phizzlethorpe"] = "Phizzlethorpe",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Eskortiere den Professor den Hügel hinauf zur Höhle über der Bucht und beschütze ihn, während er arbeitet. Zwei Wasserelementare der Stufe 40 greifen ihn dort aus dem Hinterhalt an, und sie sind immun gegen Frost. Halt sie am Höhleneingang fest, weg von ihm: Findet der Kampf in der Höhle statt, mischt er sich ein, statt zu arbeiten, und es kommen immer mehr Elementare nach.",

	-- Step 48: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: Töte diese, sobald sie dir begegnen",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Die beiden Wracks liegen in der Bucht westlich der Bucht der Goblins. Die Karten und Logbücher sind darin; die Edelsteine liegen um sie herum auf dem Meeresgrund. Naga der Säbelflossen schwimmen in der ganzen Bucht.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}, unter Wasser",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492}; unter Wasser",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}, unter Wasser",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709}; unter Wasser",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707}; unter Wasser",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710}; unter Wasser",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708}; unter Wasser",

	-- Step 49: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Für {npc:2487} in {area:35}: behalten",

	-- Step 50: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["South-east through the hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley.\nCareful: {npc:2793} is level 39, a caster, one or two over you here: clear the cave mouth first, then pull him alone at full health."] = "Nach Südosten durch die Hügel: {npc:2793}, ein Ogermagier, hält die Höhle am südlichen Ende des Tals der Bleichborken.\nVorsicht: {npc:2793} ist Stufe 39, ein Zauberwirker, hier ein oder zwei Stufen über dir: Säubere zuerst den Höhleneingang und zieh ihn dann allein mit voller Gesundheit.",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525}; unter der Erde",

	-- Step 51: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "Südwestlich von der Höhle von {npc:2793} zur {area:880}: {npc:2696} steht auf einem zerbrochenen Abschnitt der Brücke; spring von ihrem Nordende zu ihm hinunter. {quest:647} muss {npc:2705} in {area:271} innerhalb von 15 Minuten erreichen: Geh direkt zurück nach {area:320} und flieg nach {area:271}.",

	-- Step 53: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "Flugmeister von {area:320}",

	-- Step 54: Brewmeister Bilger
	-- {area:271} Southshore · {npc:2276} Magistrate Henry Maleb · {npc:2277} Loremaster Dibbs · {area:280} Strahnbrad
	["Off the flight, straight to the {area:271} inn. Then {npc:2276} and {npc:2277}, in the town hall, take the Syndicate camp's quests and send you north to {area:280}."] = "Nach dem Flug direkt ins Gasthaus von {area:271}. Dann nehmen {npc:2276} und {npc:2277} im Rathaus die Quests zum Lager des Syndikats an und schicken dich nach Norden nach {area:280}.",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}, unter der Erde",
	-- {npc:2276} Magistrate Henry Maleb · {area:280} Strahnbrad
	["{npc:2276}: the signet rings are in {area:280}"] = "{npc:2276}: Die Siegelringe sind in {area:280}",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}, at the end of this guide"] = "Für {npc:1356} in {zone:1455}, am Ende dieses Guides",

	-- Step 56: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings."] = "Folge der Straße von {area:271} nach Norden in die Berge. Berglöwen streifen über die Hänge; das Syndikat in {area:280} trägt die Siegelringe.",

	-- Step 57: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281}: Töte diese, sobald sie dir begegnen",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "Die Folianten liegen in der zerstörten Festung westlich von {area:280}; Argus Shadow Mages halten die Ruinen.\nVorsicht: Crushridge Warmongers rufen nahe Verbündete im Umkreis von 15 Metern, sobald sie unter die Hälfte ihrer Gesundheit fallen.\nDie Crushridge Maulers, Mages, Enforcers und Warmongers (36-39) sind Elites; die Crushridge Ogres und Brutes (34-35) nicht und tragen die Folianten ebenfalls: Zieh einzeln, oder bilde eine Gruppe.",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: Crushridge-Oger",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase · {quest:540} Preserving Knowledge
	["{item:3659}: the {object:1760}, beside Muckrake (40, elite): get it with a group, or abandon {quest:540}; inside"] = "{item:3659}: {object:1760} neben Muckrake (40, Elite): Hol es mit einer Gruppe oder brich {quest:540} ab; drinnen",

	-- Step 58: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:2417} walks from the arrow north-east through the ruins to about 40,47 and back: if he isn't at the arrow, follow his path."] = "Dies sind Elitegegner: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:2417} ist ein Elitegegner der Stufe 40: Die meisten Klassen schaffen ihn auf Stufe 42 allein, aber vielleicht brauchst du Hilfe. Lass ihn aus, wenn du allein bist: Die Route lässt dich die EP wieder hereinholen.\n{npc:2417} geht vom Pfeil aus nach Nordosten durch die Ruinen bis etwa 40,47 und zurück: Wenn er nicht am Pfeil ist, folge seinem Weg.",

	-- Step 59: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280}: Töte diese, sobald sie dir begegnen",
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps north of the village. Leave him be."] = "Vorsicht: Spione und Auftragsmörder des Syndikats können getarnt sein. Auftragsmörder vergiften dich außerdem.\nVorsicht: {npc:2306} (40) taucht jeweils an einem Ort auf: im Keller des Gasthauses von {area:280} oder in einem der Zeltlager des Syndikats nördlich des Dorfes. Lass ihn in Ruhe.",

	-- Step 60: Crushridge ogres
	["Crushridge ogres"] = "Crushridge-Oger",
	-- {area:280} Strahnbrad
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Careful: Nagaz (40) stands far to the north-west by a worn wooden chest, with Syndicate guards: stay with the ogres.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "Die Crushridge-Oger halten die Hügel nördlich von {area:280}. Vorsicht: Nagaz (40) steht weit im Nordwesten bei einer abgenutzten Holztruhe, mit Wachen des Syndikats: Bleib bei den Ogern.\nDie Crushridge-Raufer, -Magier, -Vollstrecker und -Kriegshetzer (36-39) sind Elites; die Crushridge-Oger und -Rohlinge (34-35) nicht und lassen die Knöchelchen ebenfalls fallen: Zieh einzeln, oder bilde eine Gruppe.",

	-- Step 62: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Nach Südwesten zum Lager der Kirin Tor am Seeufer westlich von {area:279}, gleich hinter der Grenze in {zone:1421}: Dort steht {npc:269127}. Erzmagier Ansirem steht südöstlich davon, bei der Kuppel.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Für {npc:2542} in {area:35}: behalten",

	-- Step 63: Image of Archmage Modera
	-- {npc:269127} Image of Archmage Modera · {quest:92458} Heart of Disruption · {item:277507} Dalaran Sewer Key
	["For your City of Dalaran run, next: the {npc:269127} wants the arcane remnants in the city thinned out and a mote from the heart of the disruption. {quest:92458} brings the {item:277507}, which opens the grate."] = "Für deinen Run durch die City of Dalaran, als Nächstes: {npc:269127} will, dass du die arkanen Überreste in der Stadt ausdünnst, und ein Partikel aus dem Herzen der Störung. {quest:92458} bringt dir {item:277507}, der das Gitter öffnet.",

	-- Step 64: City of Dalaran
	["City of Dalaran"] = "City of Dalaran",
	-- {quest:92457} Starving Arcane · {item:251961} Arcane Mote · {quest:92458} Heart of Disruption
	-- plural, as words: Seeking Remnants = {npc:247003} Seeking Remnant · Saturated Remnants = {npc:247001} Saturated Remnant
	["The City of Dalaran is a dungeon for a group of five at about level 28 to 33: at your level it goes quickly. Its way in is the sewer grate in the city's western wall, by the lake, 30 yards from Modera's camp.\nInside: the Seeking Remnants, Saturated Remnants and Mana Echoes are Modera's {quest:92457}; the {item:251961} for {quest:92458} drops inside too."] = "Die City of Dalaran ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 28 bis 33: Auf deiner Stufe geht er schnell. Der Weg hinein ist das Kanalgitter in der Westmauer der Stadt, am See, 30 Meter von Moderas Lager.\nDrinnen: Die Seeking Remnants, Saturated Remnants und Mana Echoes sind für Moderas {quest:92457}; {item:251961} für {quest:92458} droppt ebenfalls drinnen.",
	-- {quest:92457} Starving Arcane
	["{quest:92457}: the remnants and echoes, inside"] = "{quest:92457}: die Überreste und Echos, drinnen",
	-- {quest:92458} Heart of Disruption · {item:251961} Arcane Mote
	["{quest:92458}: the {item:251961}, inside"] = "{quest:92458}: {item:251961}, drinnen",

	-- Step 65: Image of Archmage Modera
	["Back out of the grate to Modera's camp on the lake shore."] = "Durch das Gitter zurück nach draußen zu Moderas Lager am Seeufer.",

	-- Step 68: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Für {npc:1440} in {zone:1453}: behalten",

	-- Step 69: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "{npc:2438} steht zwischen dem Flugmeister und dem Gasthaus; {npc:2381} neben ihm verkauft {item:2321}, falls du keinen hast.",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "{item:2321}, von {npc:2381}",

	-- Step 71: Ironforge
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}: für {npc:1344} in {zone:1432}, als Nächstes",

	-- Step 72: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Flieg nach {area:144}",

	-- Step 73: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "Nach {area:144}",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Nimm von {zone:1455} aus den Tunnel nach Osten durch {zone:1426} nach {zone:1432} und folge der Straße nach {area:144}.",

	-- Step 74: Thelsamar
	-- {zone:2548} Riverglades · {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass
	["Leave the {zone:2548} for about level 41: its Western Front has elite patrols. After Stranglethorn, the {zone:2548} guide takes you from {zone:1455} to {area:69}, then through {area:2417}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, unter der Erde",

	-- Step 75: Prospector Ironband
	["South-east along the loch to the dig site."] = "Nach Südosten am See entlang zur Ausgrabungsstätte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks stealthed on the edge of {area:271}, and few players find him. If you spot him, kill him and read the contract he carries: {npc:2276} takes it. Don't wait for him: the rest of this step doesn't need him."] = "Ein {npc:2434} lauert getarnt am Rand von {area:271}, und nur wenige Spieler finden ihn. Wenn du ihn entdeckst, töte ihn und lies den Vertrag, den er bei sich trägt: {npc:2276} nimmt ihn an. Warte nicht auf ihn: Der Rest dieses Schritts braucht ihn nicht.",
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Ein {npc:2434} lauert unsichtbar am Rand von {area:271}; töte ihn und lies den Vertrag, den er bei sich trägt.",
	-- ["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "Vorsicht: Syndicate Spies und Assassins können getarnt sein. Assassins vergiften dich außerdem.\nVorsicht: Etwa drei getarnte Mobs des Syndikats sind im Haus von {npc:2320}. {npc:2320} greift nicht ein, wenn sie gezogen werden, und ein Fernangriff durch die Tür lockt ihn allein heraus.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Jeder Schlüssel liegt an einem der Steinkreise des Hochlands: östlich der Splitter, nahe {area:320} und im Westen. {object:2702} steht westlich von {area:320}.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Jeder Schlüssel liegt an einem der Menhirkreise des Hochlands: östlich der Splitter, nahe {area:320} und im Westen. Der {object:2702} steht westlich von {area:320}.\nVorsicht: Jeder mittlere Stein wird von etwa drei Elementaren nahe Stufe 39 bewacht, die gemeinsam angreifen, wenn du den Stein anklickst, ohne sie zu töten: Burning Exiles im Westen, Thundering Exiles im Äußeren, Cresting Exiles im Osten.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals. {quest:1392} walks a long path through the ruins: if you meet him, kill him, his cudgel starts a quest for {npc:1776}. Don't wait for him."] = "Auf der Straße nach Osten zu {area:76}. Gegner vom Typ {npc:256028} lassen die Kristalle fallen. {quest:1392} läuft einen langen Weg durch die Ruinen: Triffst du ihn, töte ihn, sein Knüppel startet eine Quest für {npc:1776}. Warte nicht auf ihn.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Auf der Straße nach Osten zu {area:76}. Gegner vom Typ {npc:256028} lassen die Kristalle fallen; Noboru streift durch die Ruinen und lässt seinen Knüppel fallen.",
	-- ["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "Von {area:327} nach Osten durch die südlichen Hügel: {npc:2793}, ein Ogermagier, hält die Höhle am Südende des Witherbark-Tals.",
	-- ["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Eskortiere den Professor zum Strand nördlich der Bucht und beschütze ihn, während er arbeitet; Naga greifen in Wellen an.",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Folge der Straße von {area:287} nach Osten über {area:1057} nach {area:320}.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Folge der Straße von {area:271} nach Norden in die Berge. Berglöwen streifen über die Hänge; das Syndikat in {area:280} trägt die Siegelringe, und {npc:2306} geht auf dem Gutshof an der Nordseite des Orts umher.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings. {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village."] = "Folge der Straße von {area:271} nach Norden in die Berge. Berglöwen streifen über die Hänge; das Syndikat in {area:280} trägt die Siegelringe. {npc:2306} (40) taucht jeweils an einem Ort auf: im Keller des Gasthauses von {area:280} oder in einem der Zeltlager des Syndikats im Hochland nördlich und nordwestlich des Dorfes.",
	-- ["Follow the road north to the draenei of the {area:657}."] = "Folge der Straße nach Norden zu den Draenei in {area:657}.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Folge der Straße nach Süden über die Brücke nach {area:205} am Ende im {zone:1437}, wo {npc:1075} wartet.",
	-- ["For characters of 36 to 38, but {area:327} and the Alterac Syndicate quests are level 40: on purpose, for their experience. {npc:2768}'s two water elementals (40) are immune to frost, and {npc:2306} (40) waits among his Syndicate: pull them one at a time."] = "Für Charaktere der Stufe 36 bis 38, aber {area:327} und die Quests des Syndikats von Alterac sind Stufe 40: absichtlich, wegen ihrer EP. Die zwei Wasserelementare von {npc:2768} (40) sind immun gegen Frost, und {npc:2306} (40) wartet inmitten seines Syndikats: Zieh sie einzeln.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Folge von {area:42} aus der Straße nach Osten durch {zone:1430} in {zone:1435}; Biggs bewacht die Straßenkreuzung gleich hinter der Grenze. {npc:217412} steht ein kurzes Stück nördlich von ihm.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "Nimm von {zone:1455} aus den Tunnel nach Osten durch {zone:1426} nach {area:38} und folge der Straße nach {area:144}.",
	-- ["Gyll, {area:35}"] = "Gyll, {area:35}",
	-- ["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Geh zurück nach Nordosten an {area:320} vorbei; {npc:2712} und {npc:2713} lagern in den Hügeln nördlich von {area:314}.",
	-- ["Head back south from the eastern circle; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "Geh vom östlichen Steinkreis zurück nach Süden; {npc:2712} und {npc:2713} lagern in den Hügeln direkt nördlich von {area:314}.",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Geh nach Norden an {area:314} vorbei; die Splitter glitzern auf dem Hügel bei {area:333}.",
	-- ["Inside"] = "Drinnen",
	-- ["Off the flight, straight to the {area:271} inn."] = "Direkt nach dem Flug zum Gasthaus von {area:271}.",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Reite zurück nach Nordosten an {area:320} vorbei; {npc:2712} und {npc:2713} lagern in den Hügeln nördlich von {area:314}.",
	-- ["Shaman training"] = "Schamanentraining",
	-- ["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Südlich entlang der Westküste zur Bucht der Goblins; Lolo hält auf den Felsen darüber Wache.",
	-- ["South from the {object:2691}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "Nach Süden vom {object:2691} an {area:314} vorbei nach {area:317} in den Hügeln: Die Hexendoktoren der Witherbark stehen zwischen den Hütten und die Schattenjäger der Witherbark bewachen das hintere Ende des Tals. Jeder Troll kann einen Stoßzahn fallen lassen.",
	-- ["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "Nach Süden von {area:318} an {area:314} vorbei nach {area:317} in den Hügeln: Die Hexendoktoren stehen zwischen den Hütten und die Schattenjäger bewachen das hintere Ende des Tals. Jeder Troll kann einen Stoßzahn fallen lassen.",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Nach Südwesten zum Lager der Kirin Tor am Seeufer westlich von {area:279}, gleich hinter der Grenze in {area:130}: Dort steht {npc:269127}. Erzmagier Ansirem steht südöstlich davon, bei der Kuppel.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Bleib bei {npc:2713}, während sie sich nach {area:314} und zurück schleicht; Orcs der Horde fallen unterwegs über dich her.",
	-- ["Subdue the succubus"] = "Bezwinge den Sukkubus",
	-- ["Summon Succubus"] = "Wirke Sukkubus beschwören",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Die Crushridge-Oger halten die Hügel nördlich von {area:280}. Weiter nördlich enthält eine abgenutzte Holztruhe {item:3706}; {npc:2320} aus {quest:537} steht direkt daneben.",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "Die Crushridge-Oger halten die Hügel nördlich von {area:280}. Weiter nördlich enthält eine abgenutzte Holztruhe das {item:3706}; {npc:2320} vom {quest:537} steht direkt dabei.\nDie Crushridge Maulers, Mages, Enforcers und Warmongers (36-39) sind Elites; die Crushridge Ogres und Brutes (34-35) nicht und lassen die Knöchelchen ebenfalls fallen: Zieh einzeln, oder bilde eine Gruppe.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Die Kobolde der Trockenstoppel graben in der Schlucht östlich von {area:321} (Horde); umgeh den Ort im Norden. Sie lassen sowohl die Partikel als auch Krazeks Erz fallen.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Das Syndikat hält den Hof nordwestlich von {area:320}. Ein {npc:217589} krabbelt auf dem Hof herum: Fang einen mit dem Einsteigerpaket für Entomologen von {npc:217412} und hak ihn dann ab.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Die Trolle der Witherbark leben in den Hügeln südlich von {area:314}; Hexendoktoren der Witherbark stehen im Dorf, Schattenjäger der Witherbark bewachen das hintere Ende des Tals.",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Der Kurier geht mit zwei Wachen die Straße westlich von {area:314} entlang; lock sie von der Straße weg.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Die Folianten liegen in der zerstörten Burg westlich von {area:280}; Schattenmagier der Arguswacht halten die Ruinen.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "Die zerstörte Karawane liegt abseits der Straße nahe Biggs.",
	-- ["The wrecks"] = "Die Wracks",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Geh zurück auf den Übergang: Ebenezer liegt unter dessen Ende im Arathihochland.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Nach Westen entlang der Küste zur Bucht der Goblins; Lolo hält auf den Felsen darüber Wache.",
	-- ["West along the road to {area:320}, on the way to the {object:2689}."] = "Nach Westen entlang der Straße nach {area:320}, auf dem Weg zum {object:2689}.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} für {npc:2438}s Umhang, von {npc:2381}, falls du keinen hast",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",
	-- ["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}, {object:32356}: für {npc:1344} in {zone:1432}, als Nächstes",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: Fang ihn, für {quest:93176}",
	-- ["{npc:2277}: the parchment"] = "{npc:2277}: das Pergament",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, in der Stadt Dalaran",
	-- ["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "{npc:2789}: Die Höhle von {npc:2793} kommt nach {area:327}",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, ein Ogermagier, hält die Höhle am Südende des Witherbark-Tals.",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455} und trainiere bei {npc:258098}. {npc:1573} bei {object:32372} fliegt ebenfalls nach {area:271}.",
}
