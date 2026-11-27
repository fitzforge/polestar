-- German (deDE): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1451} Silithus · {zone:1446} Tanaris
	["{area:976} first, then {zone:1451}, Un'Goro and back to {zone:1446}."] = "Zuerst {area:976}, dann {zone:1451}, Un'Goro und zurück nach {zone:1446}.",

	-- Step 1: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {area:2249} Frostwhisper Gorge
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["{npc:11118}, in {area:2255}'s inn, has more mail for you: the Ice Thistle Yetis in the hills south-east of town carry it. Keep it for the last guide, whose ride back north from {area:2249} crosses those hills."] = "{npc:11118} im Gasthaus von {area:2255} hat mehr Post für dich: die Eisdistel-Yetis in den Hügeln südöstlich der Stadt tragen sie. Behalte sie für den letzten Guide, dessen Ritt zurück nach Norden von {area:2249} durch diese Hügel führt.",

	-- Step 2: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "Zurück aus {zone:2482}",
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {area:976} Gadgetzan · {npc:9299} Gaeriyan · {npc:7583} Sprinkle · {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Back from {zone:2482}: fly from {area:2255} to {area:976} for {npc:9299}, {npc:7583} and Pestlezugg, then on to {area:541} and {zone:1451}."] = "Zurück von {zone:2482}: Flieg von {area:2255} nach {area:976} für {npc:9299}, {npc:7583} und Pestlezugg, dann weiter nach {area:541} und {zone:1451}.",
	["Yugrek, the Horde flight master"] = "Yugrek, der Horde-Flugmeister",

	-- Step 3: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Trink das {item:11243} auf dem Friedhof direkt östlich von {area:976}: Es tötet dich, und nur als Geist kannst du {npc:9299} sehen, in einer Felsspalte in den Hügeln genau nördlich davon. Sprich dort mit ihm, lauf dann zurück zu deinem Körper und belebe dich wieder: Der Auffällige Grabstein, zu dem er dich schickt, steht auf diesem Friedhof.",

	-- Step 4: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir · {area:976} Gadgetzan
	["{npc:9299} has already met you: drink the {item:11243} at the graveyard just east of {area:976} and find him, as a ghost, in the rocky crevice due north of it."] = "{npc:9299} hat dich schon getroffen: Trink {item:11243} auf dem Friedhof direkt östlich von {area:976} und finde ihn als Geist in der Felsspalte genau nördlich davon.",

	-- Step 5: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Benutze {item:12928} an {npc:7583}, dem Goblinmädchen in {area:976}. {npc:10977} und {npc:10978} erschreckst du später auf der Route.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Verscheuche {npc:7583} mit {item:12928}",

	-- Step 6: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Drinnen: {quest:4493}, falls du sie im Guide für {zone:1447} in {zone:1454} angenommen hast",

	-- Step 7: Alchemist Pestlezugg
	["Inside"] = "Drinnen",

	-- Step 9: Gaeriyan
	-- {object:148504} A Conspicuous Gravestone · {area:976} Gadgetzan · {npc:8737} Linken
	["Alive again, go to {object:148504} in the graveyard just east of {area:976} and use it: it takes the quest. {npc:8737}'s sword goes back to {npc:8737} in Un'Goro: keep it."] = "Wieder belebt, geh zu {object:148504} auf dem Friedhof direkt östlich von {area:976} und benutze es: Es nimmt die Quest an. {npc:8737}s Schwert geht zurück an {npc:8737} in Un'Goro: Behalte es.",
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} geht zurück zu {npc:8737} in Un'Goro: Behalte sie.",

	-- Step 10: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} lagert an der Straße zur {area:1336}, südlich von {area:976}.",

	-- Step 11: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 12: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "Der Flug landet in {area:541}: {npc:8737} steht ein paar Schritte vom Flugmeister entfernt bei der Höhle, {npc:9117} drinnen.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "Behalte {quest:3942}: {npc:9116} ist am {area:2479}, auf dem Weg des letzten Guides durch {zone:1448}.",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "Benutze {item:12928} auf {npc:10977}",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "Erschrecke {npc:10977} mit {item:12928}",

	-- Step 13: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Der Pass aus dem Un'Goro-Krater endet an der {area:3077}, dem Friedhof im Nordosten von {zone:1451}. {npc:13220} steht zwischen den Gräbern.",

	-- Step 14: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Reite nach Südwesten zu den Ruinen vom {area:2738}. Der {object:179565} für {npc:11801} steht in einem der verfallenen Häuser.",

	-- Step 16: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite von {area:3077} nach Westen zur ummauerten Festung in der Mitte der Wüste. {npc:15189} steht oben in seinem Gebäude: geh drinnen hoch, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 17: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "Köche mit 285 {skill:185} oder mehr: {npc:15174}, der Wirt, bei dem du gerade deinen Ruhestein gebunden hast, will vom Sandwurm-Rezept des Twilight's Hammer hören; das Kochbuch liegt im Außenposten westlich des Hold, wohin dieser Führer später führt.",

	-- Step 18: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: Töte sie, wenn du ihnen begegnest",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",

	-- Step 19: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Die leuchtenden Tafelfragmente liegen auf dem Boden rings um das Dämmerungslager im äußersten Nordwesten: hebe sie auf. Die Staubstürmer und Wüstenbeben dort können sie ebenfalls tragen. Vorsicht: die größten Beben und die wirbelnden Eindringlinge sind 58: zieh sie einzeln.",

	-- Step 20: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 21: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Zurück zum Südwindposten und steig auf den Turm. Wenn du oben den Bau aufscheuchst, kommen Wegelagerer des Ashischwarms heraus; einer trägt {item:17346}.",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "{quest:8308}: hin und wieder trägt ein Silithid aus {area:2742} eines bei; Rechtsklick, falls es fällt",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "für {npc:15170} im Bronzebeard's Encampment, später in diesem Guide",

	-- Step 23: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Reite nach Südosten zu {area:3447} unter den Klippen des Un'Goro-Kraters.",
	["Below ground"] = "Unter der Erde",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377} von {npc:11739}, 130 yd südwestlich",

	-- Step 24: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Baggerbrecher und Steinpanzerzangen",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Geh nach Norden entlang der westlichen Dünen; Baggerbrecher und Steinpanzerzangen ziehen von hier bis zurück zur Burg umher.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} läuft um {area:2738} herum: schau in den Kreis auf der Karte",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Schinder und Felspirscher",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes north of {area:2744}, in the south-east of {zone:1451}."] = "Steinpeitschenschinder ({npc:11737}) und Felspirscher ({npc:11739}) streifen durch die Dünen nördlich von {area:2744}, im Südosten von {zone:1451}.",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "Vorhut der Twilight",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} läuft durch das Lager der Vanguard ganz im Südwesten. Behalte jeden {item:20404}, den die Kultisten fallen lassen: {npc:15306} und Ortell wollen später je zehn.",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} hält das Lager im Westen.",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} steht im Außenposten westlich von {area:3425}. Behalte auch hier alle Encrypted Twilight Texts, die fallen.",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "Das {object:180503} liegt im Außenposten: lies es und bringe die zerrissene Seite zurück zu {npc:15174}.",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} und {npc:15190} stehen oben in ihrem Gebäude: Geht drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, auf der Westseite der Burg",

	-- Step 32: Calandrath
	-- {npc:15174} Calandrath · {object:180503} Sandy Cookbook
	["{npc:15174}, the innkeeper, takes the {object:180503}'s torn page."] = "{npc:15174}, der Wirt, nimmt die zerrissene Seite des {object:180503} entgegen.",

	-- Step 33: Wanted: Deathclasp
	-- {npc:15196} Deathclasp
	["Wanted: {npc:15196}"] = "Gesucht: {npc:15196}",
	-- {npc:15196} Deathclasp · {npc:15190} Noggle Ficklespragg · {npc:15182} Vish Kozus
	["{npc:15196}, Terror of the Sands, is a level 59 elite scorpid patrolling the mountains by {npc:15190}'s satchel, at your level: a group choice. The wanted poster stands in the middle of the Hold; {npc:15182} pays out."] = "{npc:15196}, Terror of the Sands, ist ein Skorpid der Stufe 59, ein Elite, der bei {npc:15190}s Rucksack durch die Berge patrouilliert, auf deinem Level: eine Gruppenaufgabe. Das Kopfgeldbrett steht in der Mitte des Horts; {npc:15182} zahlt aus.",

	-- Step 34: Hermit Ortell
	-- {area:3447} Ortell's Hideout · {area:2738} Southwind Village
	["Ride south-east to {area:3447}, in the mountains south of {area:2738}."] = "Reite nach Südosten zu {area:3447}, in den Bergen südlich von {area:2738}.",

	-- Step 35: Noggle's Lost Satchel
	-- {npc:15196} Deathclasp
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "Der Ranzen liegt in den Bergen im äußersten Süden, hinter Bronzebeard's Encampment. {npc:15196}, ein Elite-Skorpid, patrouilliert in der Nähe: Schnapp ihn dir, während er weg ist.",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "Mit deiner Gruppe: {npc:15196} läuft in den Bergen um den Rucksack herum. Zieh ihn von den anderen Skorpiden weg.",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} und {npc:15170} lagern im Lager von Bronzebeard, direkt nördlich der Berge der Tasche. Befrage sie: Geh jedes ganze Gespräch durch; du musst sie nicht bekämpfen.",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "{npc:15170}, falls du Branns Brief erhalten hast",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane · {area:2739} Twilight Base Camp · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts, ten for {npc:15306} and ten for Ortell. The {area:2739} holds only elementals: the texts drop from the Twilight's Hammer cultists of the Vanguard in the far south-west, the Post in the west and the Outpost west of {area:3425}. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Sammle zwanzig Verschlüsselte Texte der Twilight, zehn für {npc:15306} und zehn für Ortell. Der {area:2739} enthält nur Elementare: Die Texte fallen von den Kultisten der Twilight's Hammer der Vorhut im äußersten Südwesten, dem Posten im Westen und dem Außenposten westlich von {area:3425}. Nimm sie von den Rächern der Twilight und den Geolords; lass die Flammenhäscher und Steinrufer (59-60) aus.",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "zehn für jede Quest: {npc:15306} nimmt seine zehn vor Ortell",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "Die übrigen Texte von den Kultisten",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Zurück nach {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "Mar'aliths nächster Auftrag, Into the Maw of Madness, führt unter Elites nach {area:2744}. Überspring ihn.",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "{npc:15182}, Hauptmann der Wache, zahlt für {npc:15196}s Schere.",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Reite nach Nordosten zur {area:3077}; du verlässt {zone:1451} durch den Pass daneben.",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Du hast das auf der Runde des Un'Goro-Guides verpasst: durch den Pass und nach Osten entlang der nördlichen Klippen nach {area:541}. {npc:9997} steht neben dem Flugmeister.",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Das hast du beim Loop des Un'Goro-Guides verpasst: {npc:10302}, der Goblin, sitzt bei {area:543}, gleich östlich des Pylons.",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Reite nach Osten zum Ort {area:537}, steig hinauf und benutze {npc:10541} am Lavaschlot nahe dem Gipfel; reite dann zurück nach Westen zu {npc:10302}.",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} schickt dich zu {npc:9298} in {zone:1452}: Behalte es.",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Nur wenn du auf dem Weg hierher {quest:4496} in {area:976} angenommen hast: Die Gorishi in {area:540} südlich von {area:537} droppen die Duftdrüse, und die meisten Tiere und Pflanzen des Kraters droppen {item:11018}.",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "Benutze {item:11833} dort, wo der Pfeil hinzeigt, im Gorishi-Bau von {area:540}, um {npc:10041} (Stufe 56) zu rufen.",

	-- Step 51: Torwa Pathfinder
	-- {quest:4301} The Mighty U'cha · {area:541} Marshal's Refuge
	["{quest:4301}: his north-east cave is on your way back here from {area:541}"] = "{quest:4301}: seine nordöstliche Höhle liegt auf deinem Rückweg hierher von {area:541}",
	-- {npc:9684} Lar'korwi
	["Keep the bait for {npc:9684}'s lair, next (he is level 56)."] = "Behalte den Köder für {npc:9684}s Höhle, als Nächstes (er ist Stufe 56).",

	-- Step 52: Lar'korwi
	-- {item:11568} Torwa's Pouch · {npc:9684} Lar'korwi
	["Open {item:11568}: it holds the meat and the pheromone mixture. {npc:9684}'s lair is the bone-strewn valley just south of the pylon: place the meat among the bones, then use the mixture on it to call {npc:9684}. He is level 56 and hits hard, so start at full health."] = "Öffne {item:11568}: Er enthält das Fleisch und die Pheromonmischung. {npc:9684}s Höhle ist das knochenübersäte Tal direkt südlich des Pylons: Lege das Fleisch zwischen die Knochen und benutze die Mischung darauf, um {npc:9684} zu rufen. Er ist Stufe 56 und schlägt hart zu, beginne also mit voller Gesundheit.",

	-- Step 53: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} sitzt verirrt und erschöpft auf dem Grat.",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "Von {area:541} aus reite nach Osten zur Höhle in der Nordostecke des Kraters: {npc:9622} (55) sitzt hinten in ihr unter seinen Gorillas, jetzt deutlich unter dir. Dann nach Süden die Ostseite des Kraters hinab zu {npc:9619}.",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "In {npc:9619}s Ecke gibt es keinen Flugmeister: Reite nach Norden nach {area:541} und fliege nach {area:976}.",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "Hast du {quest:2741} noch dabei? Die Maschine steht mitten in {area:976}.",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",

	-- Step 63: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} in {zone:1456}; in {zone:1454} gibt es keinen Paladin-Lehrer",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Eine zerrissene Schriftrolle liegt am Eingang von {area:2261}, der Gruft südlich von {area:2260}.",
	-- ["Andorhal watchtowers and silos"] = "Wachtürme und Silos von Andorhal",
	-- ["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "Zurück nach Osten an {area:202} vorbei zu {area:201}, der Farm unter den östlichen Hügeln: {npc:11078} bewacht ihren Kessel. Töte ihn für den Schlüssel und benutze dann den Kessel.",
	-- ["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Vorsicht: Un'Goro Gorillas (Stufe 50-51) rufen Verbündete im Umkreis von 20 yd zu Hilfe, sobald sie auf 25% Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und ein Kampf dort bringt viele Adds.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "Sammle zwanzig Encrypted Twilight Texts von den Kultisten hier, zehn für {npc:15306} und zehn für Ortell.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Sammle zwanzig Verschlüsselte Texte der Twilight von den Kultisten hier, zehn für {npc:15306} und zehn für Ortell. Hol sie dir von den Rächern der Twilight und Geolords; lass die Flamereavers und Stonecallers (59-60) in Ruhe.",
	-- ["Diseased Grizzlies"] = "Kranke Grizzlys",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers bietet {item:14619} an ({quest:838}). Überspring sie.",
	-- ["Dredge Strikers"] = "Baggerschläger",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Baggerschläger, Steinpanzerskorpide und Sandhuscher teilen sich den Sand gleich nördlich der Burg.",
	-- ["Dredge and scorpids"] = "Bagger und Skorpide",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Weiter östlich an der Straße bewacht {npc:11077} den Kessel bei {area:200}.",
	-- ["Fly to {area:1637} and train."] = "Flieg nach {area:1637} und trainiere.",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Flieg nach {area:976}. Hast du {quest:2741} noch dabei? Die Maschine steht mitten in der Stadt.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Flieg nach {area:976}. Der {object:142071} steht mitten in der Stadt.",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "Reite vom Zeppelinturm die Straße entlang nach Osten zum {area:152}, auf dem Weg in die {zone:1422}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya versteckt sich unter den Mossflayer-Trollen von {area:2273}, in der Nordostecke.\nVorsicht: Die Trolle entlang des Pfades nach {area:2273} sind Stufe 57-59. Sie laufen bei wenig Gesundheit weg und rufen um Hilfe, daher bringen sie oft Adds mit.",
	-- ["Hameya's mound"] = "Hameyas Hügel",
	-- ["Hameya's scroll"] = "Hameyas Schriftrolle",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "Wenn du {quest:6135} übersprungen hast, grinde hier bis Stufe 59,14, um im Plan der Route zu bleiben. Oder lauf stattdessen mit einer Gruppe den Dungeon {quest:838} oder den Dungeon {area:2279}.",
	-- ["Into {zone:1422}"] = "Nach {zone:1422}",
	-- ["Into {zone:1423}"] = "Nach {zone:1423}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Behalte den Köder: {npc:9684} ist Stufe 56, und die zweite Runde führt an seinem Unterschlupf vorbei.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Behalte {quest:3942}: {npc:9116} ist im Refugium ({area:2479}), auf dem Weg des nächsten Guides durch den {zone:1448}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Ritter und Magier arbeiten im {area:192}; die Sanitäter und Jäger lagern südlich davon. Stell dabei {npc:11615}s Termitenfass mitten im Sägewerk ab.\nVorsicht: Ein {npc:10996}, ein Elite der Stufe 58-59, kann am Holzfällerlager stehen, wie an vielen anderen Stellen der {zone:1422}: Halte Abstand.",
	-- ["Level 57"] = "Stufe 57",
	-- ["Level 58"] = "Stufe 58",
	-- ["Level 59.14"] = "Stufe 59,14",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Mar'aliths Liebste Natalia braucht Stufe 58 und führt in den {area:2744} zwischen Elitegegner. Überspring sie.",
	-- ["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",
	-- ["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- ["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- ["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Nach Norden zum Holzlager Northridge; stell das Fass mit Pestland-Termiten mitten in der Mühle ab.",
	-- ["Pamela and the {area:2261}"] = "Pamela und {area:2261}",
	-- ["Radley and Durgen"] = "Radley und Durgen",
	-- ["Ride east across the plaguelands to the chapel."] = "Reite nach Osten durch die Pestländer zur Kapelle.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Reite die Straße entlang nach Osten zum {area:152} an der Grenze.",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Reite nach Osten zu {npc:1855}s Hütte am Fluss {area:2619} und hör ihn an.",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Reite nach Nordosten zu {area:2276} bei {area:2275}: Die hochelfischen Waldläufer, Pfadschreiter und Holzfäller bewachen es, und das Register liegt drinnen. Vorsicht: Die Pfadschreiter sind 57-58, aber die Waldläufer bis 60: Zieh sie einzeln und nimm die Waldläufer zuletzt.",
	-- ["Ride north-east to {area:3447}."] = "Reite nach Nordosten zu {area:3447}.",
	-- ["Ride north-west to {npc:1855}'s hut."] = "Reite nach Nordwesten zu {npc:1855}s Hütte.",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Reite nach Süden nach Andorhal. {npc:10667} wartet im verfallenen Gasthaus auf der Westseite der Stadt. Stell dich mit der {item:12815} in den Eingang jedes der vier Türme, um ihn zu markieren; halte dich an den Stadtrand. Benutze den {item:12627} bei den Silos mitten in der Stadt, um Temporale Parasiten hervorzulocken.",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Reite von {npc:1855} nach Südosten zum Bauernhaus von {area:2260}.",
	-- ["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "Reite von {npc:1855} nach Südosten zu {area:2261}; {object:177675} liegt direkt dahinter.",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "Reite nach Südwesten zu {npc:10667} in Andorhal.",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Reite nach {area:2262} im Südwesten; Pamela spielt zwischen den Häusern. {npc:11886} lauert in {area:2261}, der Gruft direkt westlich der Stadt.\nVorsicht: Etwa vier Nicht-Elite-Adds kommen mit Mercutio. Sie laufen zum Grab, statt sofort zu erscheinen.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Reite nach {area:2262} im Südwesten; {npc:10926} spielt zwischen den Häusern. {npc:11886} lauert im Tiefgewölbe ({area:2261}), der Gruft gleich westlich des Orts.",
	-- ["Ride west to the Horde camp north of {area:2744}."] = "Reite nach Westen zum Lager der Horde nördlich vom {area:2744}.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Reite nach Westen zur ummauerten Burg mitten in der Wüste.",
	-- ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite nach Westen zur ummauerten Festung mitten in der Wüste. {npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Erschrecke {npc:10977} mit {npc:10980}",
	-- ["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- ["Scourge Champions"] = "Champions der Geißel",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Champions der Geißel streifen durch das Tal ({area:2270}) nördlich der Kapelle. Führe {npc:11063}s {item:13156} über jeden, den du tötest: Die Schädel, die mitschwingen, sind die, die er will.",
	-- ["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Silithystgeysire brechen überall in der südlichen Wüste aus. Lauf in das Silithyst, das einer zurücklässt, und bring es zum Silithyst Extractor der Horde in Kirikas Lager; Kämpfen oder Aufsteigen lässt es fallen.",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Steinpanzerschinder und Felspirscher streifen durch die Dünen südwestlich von Kirikas Lager.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Nimm den Zeppelin vom Turm vor {area:1637} nach {zone:1420} und reite nach {zone:1458}. Fürstin Sylvanas hält das {object:36126}.",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Die Baggerbrecher (57-58) im Südosten sind unter Stufe 57 zwei Stufen über dir. Steig zuerst bei den Baggerschlägern (55-56) im Sand östlich von {area:3425} auf 57 auf, wo zwischen ihnen Sandhuscher und Steinpanzerskorpide (54-56) umherstreifen, abseits der Silithid Darters im nördlichen Sand. Oder geh mit einer Gruppe stattdessen in den Dungeon {area:1583} (unterer Teil) oder den Dungeon {quest:838}.",
	-- ["The Spirits of Southwind"] = "Die Geister von Southwind",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager der Twilight im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Die leuchtenden Tafelbruchstücke liegen um das Lager des Schattenhammers im äußersten Nordwesten; die Staubstürmer und Wüstenrumpler dort lassen sie auch fallen. Vorsicht: Die größten Wüstenrumpler und die Wirbelnden Eindringlinge sind Stufe 58: Zieh sie einzeln.",
	-- ["The lake for {quest:5845}"] = "Der See für {quest:5845}",
	-- ["The libram lies further north, on the way to {area:190}."] = "Davils Buchband liegt weiter nördlich, auf dem Weg nach {area:190}.",
	-- ["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Die Schließkassetten stehen in den zerstörten Häusern von Andorhal rund um das Gasthaus von {npc:10667}. Vorsicht: Ghule und Skelette stehen meist neben den Kassetten und greifen an, wenn du näher kommst. Searing Ghouls verletzen außerdem jeden in der Nähe und brechen die Tarnung.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "Das Sägewerk liegt direkt neben Radley: Stell {npc:11615}s Termitenfass mitten hinein.",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Der Ranzen liegt in den Bergen im äußersten Süden, hinter Bronzebeards Lager. Totenstachel, ein Eliteskorpid, patrouilliert in der Nähe: Schnapp ihn dir, während er weg ist.",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Der Schild liegt bei {area:201}, südlich von {npc:1855}s Hütte.",
	-- ["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} liegt gleich hinter {area:2261}.",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675} liegt gleich südlich, hinter {area:2261}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:11897} ist ein Elite der Stufe 60: Überspring ihn, wenn du allein bist.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Durch den Pass und nach Osten entlang der nördlichen Klippen zu {area:541}. {npc:8737} steht bei der Höhle; {npc:9117} ist drinnen.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Durch den Pass und nach Osten entlang der nördlichen Klippen nach {area:541}. {npc:9997} steht neben dem Flugmeister.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Steig hier auf Stufe 58 auf, bevor du zu Ortells Felspirschern (57-59) und in den Süden gehst; auch {quest:8304} von {npc:15181}, zurück in {area:3425}, braucht Stufe 58. Die Baggerbrecher (57-58) auf dem Weg nach Südosten sind die, die {npc:15191} will: Lass die Kultisten des Schattenhammers um sie herum in Ruhe. Oder geh mit einer Gruppe stattdessen in den Dungeon {area:1583} (unterer Teil) oder den Dungeon {quest:838}.",
	-- ["Underwater"] = "Unter Wasser",
	-- ["Upstairs"] = "Oben",
	-- ["Use {npc:10980} on {npc:10977}"] = "Benutze {npc:10980} an {npc:10977}",
	-- ["West to the {area:152} one last time."] = "Noch einmal nach Westen zu {area:152}.",
	-- ["West to the {area:152}."] = "Nach Westen zu {area:152}.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Nach Westen zum {area:152}. Der nächste Guide beginnt in {zone:1458}, ein kurzer Ritt nach Westen.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",
	-- ["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",
	-- ["from the cauldron, for {npc:11055} at the {area:152}"] = "vom Kessel, für {npc:11055} bei {area:152}",
	-- ["grind on {npc:10717}"] = "grinde {npc:10717}",
	-- ["grind on {npc:11740}"] = "Grinde an {npc:11740}",
	-- ["grind on {npc:11741}"] = "grinde {npc:11741}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Die Scarlets von {area:190} sind Stufe 58-60. Reite zum auf deiner Karte markierten hohen Punkt, sieh dir die Stadt an und verschwinde wieder.\nVorsicht: Am Tor postierte Sentinels können getarnte Spieler entdecken. Weitere Sentinels stehen in der Stadt, und ein Elite läuft in der Nähe eine Patrouillenroute ab.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Der Goblin {npc:10302} sitzt am Ort {area:543}, gleich östlich des Pylons.",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Die Schlacht um Darrowshire von {npc:10667} endet gegen Elitegegner. Überspring sie.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, oben",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} lagert bei {area:202} neben dem Kessel; seine Bären streifen über die Hügel nördlich und östlich davon, auf dem Weg nach {area:201}.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Der Hof von {npc:10778} ist der erste östlich vom {area:152}. Plappernde Ghule auf dem Hof tragen die andere Hälfte ihres Amuletts; {npc:11075} bewacht den Kessel auf dem Feld.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} und {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}s eigener Auftrag ist nicht auf dieser Route. Überspring ihn.",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} versteckt sich auf dem Hügel nordöstlich vom {area:192}.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, in Richtung {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere kreist auf Patrouille darum. Räume sie weg, bevor du Durgen angreifst, damit sie nicht in den Kampf eingreifen.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} läuft durch das Lager der Vorhut im äußersten Südwesten. Jeder Kultist hier lässt Verschlüsselte Texte der Twilight fallen, ob Quest oder nicht: Sammle zwanzig, zehn für {npc:15306} und zehn für Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} steht im Außenposten westlich von {area:3425}. Füll deine Verschlüsselten Texte der Twilight bei den Kultisten hier auf zwanzig auf.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Die Aufträge von {npc:11878} sind nicht auf dieser Route. Überspring sie.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304} von {npc:15181} in {area:3425} braucht Stufe 58: Hol sie an den Dredge Crushers (57-58) westlich des Außenpostens auf und lass die Twilight Avengers, Geolords und Stonecallers (57-61) um sie herum in Ruhe. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1583} (Untere) oder den Dungeon {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Der Champion von {npc:15193} hält das Bauernhaus von {area:2260}, nördlich vom Tiefgewölbe ({area:2261}).",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, auf der Westseite der Burg",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, Elite) steht mitten in Andorhal zwischen Skeletal Warlords (56-57, Elite): Töte ihn mit deiner Gruppe und nimm dann dort den Splitter aus {object:177241}.",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}s nächste Aufgabe, Von verlorener Ehre, ist nicht auf dieser Route. Überspring sie.",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} läuft um {area:2276} herum: schau in den Kreis auf der Karte",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117} ist in der Höhle.",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} will jetzt das Fell von {npc:9622}, zurück in der nordöstlichen Höhle: Überspringe es.",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Der Unterschlupf von {npc:9684} liegt gleich südlich des Pylons. Benutze dort {npc:9619}s Köder; {npc:9684} ist Stufe 56 und schlägt hart zu, also fang mit voller Gesundheit an.",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "Der Splitter für {quest:105} liegt zu Füßen von {npc:1852}, mitten in Andorhal: Er ist ein Elite der Stufe 61, umgeben von Skeletal Warlords (Elite), ein Kampf für eine Gruppe.",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: Töte sie, wenn du ihnen begegnest",
}
