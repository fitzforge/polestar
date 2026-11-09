-- German (deDE): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Ruf: Zirkel des Cenarius",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "Verzauberungen und Muster für Naturwiderstand, Abzeichen-Ausrüstung und Forevers neue Muster aus {zone:1451}, aus den Lagern von {zone:1451}.",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Forevers neue Muster aus {zone:1451} für Schneider, Lederer und Schmiede, Freundlich und Wohlwollend",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "Der Gesandte in {zone:1455}",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Optional und nur für die späteren Dredge-Quests nötig: {npc:15187} schickt dich mit {quest:8275}, einem Brief für 10 Ruf, nach {zone:1451}. Überspringe es, wenn du schon in {zone:1451} bist.",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "Der Gesandte in {zone:1454}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Optional und nur für die späteren Dredge-Quests nötig: {npc:15188} schickt dich mit {quest:8275}, einem Brief für 10 Ruf, nach {zone:1451}. Überspringe es, wenn du schon in {zone:1451} bist.",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425} ist das ummauerte Druidenlager im Norden der Mitte von {zone:1451}, mit Flugrouten für beide Seiten. Alle beginnen bei {faction:609} auf Neutral (Druiden auf 2.000 von 3.000). Bor und {npc:15270} stehen zusammen im Hauptgebäude. {quest:8318} schaltet die Abgaben von {item:20404} dauerhaft frei. Der Vermächtnis-Vorteil „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu; die Zahlen in diesem Guide verstehen sich ohne ihn.",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}, Stufe 60",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "Das Kultistenlager westlich von {area:3425}",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "Das nächste Lager von Twilight's Hammer liegt direkt südwestlich der Feste. Avengers, Geolords und Stonecallers (Stufe 57 bis 59) lassen etwa bei jedem dritten Mal einen {item:20404} fallen, und jeder Kultist-Kill bringt 1 Ruf. {npc:11804} läuft am Rand des Lagers entlang. Behalte jede Robe, Kapuze und jeden Mantel von Kultisten, die du erbeutest: Es sind die Twilight Trappings für die Wind Stones später.",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Zurück nach {area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "Kultisten bis zum Ende von Freundlich, Texte aufgespart",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "Von Neutral bis Wohlwollend sind es 9.000 Ruf (7.000 für Druiden). Jeder {npc:11880}, Geolord, Stonecaller, Master und Overlord gibt 1 Ruf bis 5.999 von 6.000 Freundlich, einen Punkt vor Wohlwollend; dort hören sie auf. Spare jeden {item:20404} auf und lass die Quests der nächsten Schritte für später: Jeder Kill unterhalb dieser Grenze ist ein freier Punkt zusätzlich zu seinem Text, und die Texte und Quests zahlen auf jeder Stufe gleich. Etwa jeder dritte Kill lässt einen Text fallen, 30 Kills bringen also 30 Ruf und 10 Texte (später 100 Ruf). Vier Lager: südwestlich der Feste (39,44), im äußersten Westen (26,34), im äußersten Südwesten (19,84) und im Nordosten unterhalb von {area:2742} (66,18: Overlords und Flamereavers, die bis zum Ende von Wohlwollend zählen). Der {npc:15308} (87% Text) läuft zwischen 18,31 und 23,69 umher. Texte kannst du auch im Auktionshaus verkaufen, wenn du lieber kaufst. Bei 5.999 Freundlich kommt der letzte Punkt zu Wohlwollend von einem Flamereaver, Twilight Keeper oder Marauder oder von deinen ersten 10 Texten bei {npc:15306}.",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "Allein durch Kills bis zum Ende von Freundlich sind es 8.999 Kills (6.999 für Druiden), aber die Texte, die sie fallen lassen (etwa 3.000), sind 30.000 mehr wert: der größte Teil des Weges bis Ehrfürchtig.",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "Freundlich (3.000) schaltet Kanias {item:20732} (10g), Mishtas {item:22251} (2g) und {item:22758} (5g) sowie Forevers neue Muster für Handschuhe bei Freundlich (7g 50s) frei.",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}: spare sie auf",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}: zählt noch bei 5.999 Freundlich",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}: 10 Texte, 100, für den letzten Punkt",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321} (Stufe 61, keine Elite) wartet hinten in {area:3446}, der Höhle im Nordosten von {zone:1451}. Flamereavers und Twilight Masters bewachen den Weg: Die Flamereavers zählen bis zum Ende von Wohlwollend, die Masters hören wie die anderen Kultisten am Ende von Freundlich auf.",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "Quests in {zone:1451} bei {area:3425}",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Löse jetzt die einmaligen Quests ein: allein etwa 1.700 Ruf, mit den Gruppenquests 2.400. Sie sind Stufe 55 bis 60 und zahlen auf 60 voll. {quest:8280} braucht zuerst {quest:8275}. {npc:15196} ist ein Elite-Skorpid mit zwei Wachen (Gruppe mit 2 oder 3). {quest:8307} von {npc:15174} ist für Köche: Sein Rezept stellt die {item:20452} her, die er will. {npc:15189} steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}, nach {quest:8275}",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "Steckbrief: {npc:15196}, Elite",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}, für Köche",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "Um {area:3425}",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "Stonelash Scorpids und Sand Skitterers streifen durch den Sand um die Feste; Dredge Strikers graben nordöstlich davon. Das {object:180503} liegt im Kultistenlager südwestlich der Feste.",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "Zurück in der Feste",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "Stonelash und Dredge Crushers",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "Stonelash Flayers, Pincers und Rock Stalkers leben südlich und südwestlich der Feste; ihre Stachel und Fangzähne fallen bei etwa jedem zehnten Mal. Dredge Crushers graben südlich und westlich der Feste.",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}, aus dem {object:180503}",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}, aus {item:20424} und {item:3713}",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190} und Proudhorn",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "Das {area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "Das zerstörte Lager im äußersten Nordwesten von {zone:1451}: Die Twilight Tablet Fragments liegen zwischen den Ruinen auf dem Boden.",

	-- Step 14: Larksbane
	["Larksbane"] = "Larksbane",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194} versteckt sich in den Hügeln im Osten von {zone:1451}. Er entschlüsselt auch {quest:8319} für die Chance auf eine Schriftrolle der Herbeirufung, aber {quest:8349} zahlt den Ruf: Behalte die Texte für Bor.",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "Die drei Twilight Keepers",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "Jeder Keeper ist Stufe 60, keine Elite, allein am Rand eines Lagers und lässt sein Kapitel immer fallen: Mayna im Lager im äußersten Westen, Havunth im Lager südwestlich der Feste, Exeter im Lager im äußersten Südwesten neben dem Twilight Lord.",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "Zurück zu Ortell",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Bronzebeards Lager",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "Das Lager der Zwerge im Süden von {zone:1451}. Sprich mit {npc:15171} und {npc:15170} durch ihre ganzen Geschichten für {quest:8304}. {item:20379} liegt auf dem Berg südöstlich des Lagers. {npc:15196} lebt den Pfad östlich des Lagers hinauf: eine Elite, und sein {spell:10101} kann dich von der Klippe werfen.",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171} und {npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}, Elite: Gruppe mit 2 oder 3",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "Zurück nach {area:3425} mit Neuigkeiten",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	["Natalia, elite: group up"] = "Natalia, Elite: such dir eine Gruppe",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "Abriebe und Gehirne",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "Rutgar und Frankal geben die nächsten beiden Quests in ihrem Lager aus. In jedem Stock gibt es einen {object:210337}, den du mit dem {item:20453} abreibst, und seine Silithiden lassen die Gehirne fallen: {area:2742} nördlich der Feste, {area:2743} im Westen, {area:2744} im Süden. In {area:2744} wartet Mistress Natalia (Elite der Stufe 62, Gedankenkontrolle und Furcht; Gruppe mit 3 bis 5). Ab und zu lässt ein Stockinsektoid {quest:8308} fallen: Es startet eine Quest für Rutgar im Wert von 100.",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}, tief in {area:2744}",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}, ein seltener Beutefund",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "Mistress Natalia",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "Optional: Natalia wartet tief in {area:2744}, dem Stock im Süden von {zone:1451}. Sie ist eine Elite der Stufe 62, die Gedankenkontrolle und Furcht einsetzt und sich unter halber Gesundheit selbst heilt: Bring eine Gruppe mit 3 bis 5 mit und unterbrich ihre Heilungen.",
	["Mistress Natalia: group of 3 to 5"] = "Mistress Natalia: Gruppe mit 3 bis 5",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314} führt zu {quest:8315}: {npc:15183} schickt dich zu den {area:3257}, um {npc:14862} zu beschwören, einen Boss der Stufe 63 für einen Schlachtzug mit etwa 20 Spielern. Nimm sie nur mit einem Schlachtzug an.",
	["raid of 20"] = "Schlachtzug mit 20 Spielern",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}, {npc:14862}: Schlachtzug mit 20 Spielern",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "Optional: Die Questreihe von {quest:1123} zahlt 525 Ruf beim Zirkel des Cenarius über sieben Quests der Stufen 55 bis 57, auf 60 voll. {npc:10881} schickt dich zu {npc:5769} auf {area:1639}, der dich zu {quest:1123} in {area:2361}, {zone:1450}, schickt.",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "Optional: Die Questreihe von {quest:6762} zahlt 525 Ruf beim Zirkel des Cenarius über sieben Quests der Stufen 55 bis 57, auf 60 voll. {npc:10878} schickt dich zu {npc:3516}, der dich zu {npc:4217} schickt, der dich zu {quest:6762} in {area:2361}, {zone:1450}, schickt.",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123} lebt in {area:2361}. Sie schickt dich zu {npc:13220} in {area:3077}, dem Lager in der Nordostecke von {zone:1451}.",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "Die Tortured Druids und Sentinels streifen durch die Ruinen von {area:2738}, südöstlich von {area:3425}; die {object:178553} liegt im obersten Stockwerk ihres von Wespen umkreisten Turms.",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{npc:11939} in {area:2361}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "Quests anderswo",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "Die anderen Quests von {faction:609} sind über {zone:1414} und das Pestland verstreut. Forever zahlt sie auf jeder Stufe voll: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, Stufen 54 und 56) 75 und 75, Corruption of Earth and Seed ({area:2100}, Stufe 51) 150. Shards of the Felvine ({quest:1123}, Stufe 60, der {item:18501} von Alzzin in {area:2577}) zahlt 150 und sein Reliquary 100 auf jeder Stufe.",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "Erledige die Quests in {zone:1422} und {area:2100}, während du levelst; auf 60 zahlen sie vielleicht nur einen Bruchteil.",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319} bis Respektvoll",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "Von Wohlwollend bis Respektvoll sind es 12.000 Ruf. {npc:15306} nimmt 10 {quest:8319} für 100 Ruf an, immer wieder, bis Ehrfürchtig: 120 Abgaben (1.200 Texte) bis Respektvoll ohne die Quests, oder etwa 950 Texte danach. Gib jetzt die aufgesparten Texte ab. Die Kultisten zählen nicht mehr, aber die Flamereavers, Twilight Keepers, Marauders und Templars zählen bis 11.999 von 12.000 Wohlwollend, und der {npc:14479} und der Prophet bis Ehrfürchtig. Wohlwollend schaltet Kanias {item:20733} (10g), Mishtas {item:22773} (5g) und Forevers neue Muster für Wohlwollend (je 7g 50s) frei.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}: 10 Texte, 100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}, Stufe 60",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540} steht am Mondbrunnen von {area:3425}. {quest:8507} (25 Ruf, wiederholbar) schickt dich mit ungezeichneten Papieren zum Hauptmann deiner Seite: zur Eisenschmiede-Brigade von {npc:15440} vor {area:2743} (Allianz) oder zur Orgrimmar-Legion von {npc:15612} vor {area:2744} (Horde). Benutze zuerst die Papiere und sprich dann mit dem Hauptmann: Ein Stockinsektoid der Stufe 60 (Elite) greift an; halte den Hauptmann am Leben, dann unterschreibt er. Kaldon lässt dich dann eine Combat-, Logistics- oder {item:20809} wählen, jede mit einer zufälligen Einweisung im Wert von 50 Ruf und einem Abzeichen: 30 Kills von Stockinsektoiden (Elites), Waren wie 30 Heavy Runecloth Bandages oder 3 {item:7936}, oder ein Bericht über einen Templar, {npc:15542} oder Späher. Ein Abzeichen jeder Art kauft bei Kaldon {quest:9338}: 200 Ruf, wiederholbar. Eine volle Runde bringt etwa 375 Ruf.",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "Allegiance: je ein Combat-, Logistics- und Tactical-Abzeichen, 200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}: Abzeichen-Ausrüstung von {npc:15176}",

	-- Step 31: Silithyst
	["Silithyst"] = "Silithyst",
	-- {quest:9419} Scouring the Desert · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {npc:17079} General Kirika · {area:2744} Hive'Regal
	["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "Optional, einmalig 100 Ruf: {quest:9419}. Das Lager deiner Seite liegt bei einem Stock: das von {npc:17080} bei {area:2743} (Allianz), das von {npc:17079} bei {area:2744} (Horde). Silithyst steigt aus glühenden Geysiren in der Wüste auf: Geh durch einen hindurch, trage das Silithyst zum Silithyst-Extraktor deines Lagers und sprich dann mit dem Anführer des Lagers. Es ist ein Welt-PvP-Ziel: Spieler der anderen Seite können es dir abnehmen.",
	["deliver Silithyst at the extractor"] = "liefere Silithyst am Extraktor ab",

	-- Step 32: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "Templars und der Abyssal Council",
	-- {object:180456} Lesser Wind Stone (no name in this language: may be words) · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "Wer ein vollständiges Set Twilight Trappings trägt (Kapuze, Mantel und Robe der Kultisten, etwa 8%, 8% und 6% pro Kultist), kann einen {object:180456} benutzen: In jedem der drei westlichen Lager stehen zwei. Ein zufälliger Abyssal Templar erscheint: eine Elite der Stufe 60 für 1 bis 3 Spieler, 5 Ruf bis zum Ende von Wohlwollend und in 93% der Fälle ein {item:20513}. Die Beschwörung verbraucht das Set (und später auch Medaillon und Ring), und wenn der Elementar entkommt, sind sie weg: Beschwöre nur, wenn du gewinnen kannst. {quest:8361} zahlt 100 für das erste Wappen; danach nimmt Bor 3 Wappen für 50 an. Ab Freundlich schickt dich {npc:15270} zu {quest:8331}: 3 Wappen und ein {item:14344} kaufen das Medallion of Station, das zusammen mit einem Set den größeren {object:180461} für einen Duke öffnet (Elite der Stufe 62, Gruppe mit 5; 25 Ruf, {item:20514} in 85%).",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}: Templar, Gruppe aus 1 bis 3",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}, Freundlich",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3 Wappen und ein {item:14344}: das Medallion of Station",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}: Herzog, Gruppe aus 5",

	-- Step 33: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "Siegel und Zepter bis Ehrfürchtig",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone (no name in this language: may be words) · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000 Ruf: 210 Wappen-Abgaben (2.100 Wappen), oder weniger mit dem Rest. Ab Wohlwollend nimmt Bor 3 {quest:8363} für 100 an (jeder Herzog gibt zusätzlich 25, bis Ehrfürchtig), und {npc:15282} nimmt ein {item:20515} für {quest:9248} an (200, einmalig). Ab Respektvoll führt {quest:8343} zu {quest:8341}: 3 Siegel und 5 Große strahlende Splitter kaufen den Ring of Lordship, und Set, Medaillon und Ring öffnen den {object:180466} für einen Abyssal Lord: ein Boss der Stufe 63 für einen Schlachtzug von etwa 20, 50 Ruf und ein {item:20515}. Bor zahlt 200 für das erste Zepter und 150 für je 3 weitere. Respektvoll schaltet Mishtas {item:22252} (5g), {item:22660} (9g) und {item:22756} (5g) frei; Ehrfürchtig ist die nötige Stufe für die Champion's Battlegear bei {npc:15176}.",
	["10 texts: 100"] = "10 Wappen: 100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3 {quest:8363}: 100, Wohlwollend",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}: Lord, Schlachtzug aus 20",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}, Respektvoll",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3 Siegel und 5 Große strahlende Splitter: der Ring of Lordship",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3 {quest:8364}: 150, Respektvoll",

	-- Step 34: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "Das {area:3454}, wenn es öffnet",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "Ein Schlachtzug für 20 Spieler hinter der {area:2737} im äußersten Südwesten von {zone:1451}. Ein kompletter Clear bringt etwa 1.600 Ruf bei Cenarion: der Trash je 3 bis 20.999 von 21.000 Respektvoll, Kurinnaxx, Moam, Buru und Ayamiss je 150 und Ossirian 300, bis Ehrfürchtig. Ossirians Kopf startet {quest:8791} (200 hier und 200 bei {npc:15185}). Ihre Beute kauft die Ring- (Wohlwollend), Umhang- (Respektvoll) und Waffenquests (Ehrfürchtig) von {npc:15498}, {npc:15500} und {npc:15499} in der Feste, je 100 Ruf. {npc:16091} in der Feste zahlt einmalig 100 für {quest:9023}: {item:22217} von hier und Venoxis' von {area:19}. {npc:15471} verkauft drinnen {item:22219} (Respektvoll, 5g) und {item:22191} (Ehrfürchtig, 8g).",

	-- Step 35: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "Optional, für {quest:9023}: {npc:14507} ist der erste Boss von {area:19}, einem Schlachtzug für 20 Spieler im Nordosten von {zone:1434}.",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}: Schlachtzug aus 20",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "Abyssische Wappen, Abyssische Siegel und Abyssische Szepter sind bei {npc:15306} wiederholbar, sobald ihre Einstiegsquests erledigt sind.",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Verschlüsselte Texte der Twilight ist wiederholbar: {npc:15306} nimmt immer wieder weitere Texte an. In den Kultistenlagern farmst du sie am besten.",
	-- ["Encrypted Twilight Texts to Friendly"] = "Verschlüsselte Texte der Twilight bis Freundlich",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "Ab hier bringen der Schlachtzug {area:3454} und die Abgaben für den Abyssischen Rat (Wappen, Siegel, Szepter) den meisten Ruf.",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Farm weiter in den Twilight-Lagern. Mit der Twilight-Kultistenausrüstung (das Twilightkultisten-Set plus ein Standesmedaillon aus der Quest Das Standesmedallion von {npc:15282}) kannst du an den Windsteinen Abyssische Templer beschwören; ihre Abyssischen Wappen gehen an {npc:15306}.",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Lauf weiter {area:3454} und gib Insignien für den Abyssischen Rat ab, bis du Ehrfürchtig bist.",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Kultisten des Twilight-Hammers halten die Lager im Westen von {zone:1451}. {quest:8320} und Steinrufer sind hier gemischt; jeder Kultist kann {item:20404} fallen lassen. Jeder getötete Kultist zählt auch für den {faction:609}. Die Geolords zählen nur für {quest:8320}, wenn du 60 bist und die Quest angenommen hast.",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} ist die ummauerte Stadt im nördlichen Zentrum von {zone:1451}. Bor und {npc:15270} stehen zusammen drinnen. Beim {faction:609} beginnst du mit Neutral. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{faction:609} to Exalted"] = "{faction:609} bis Ehrfürchtig",
	-- ["{faction:609} to Honored"] = "{faction:609} bis Wohlwollend",
	-- ["{faction:609} to Revered"] = "{faction:609} bis Respektvoll",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: Verschlüsselte Texte der Twilight",
	-- ["{quest:8320} needs level 60"] = "{quest:8320} erfordert Stufe 60",
}
