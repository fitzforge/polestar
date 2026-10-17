-- German (deDE): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Nimm vom Steg im Gebiet {area:1108} das Boot nach Feathermoon und flieg nach {area:489}, dann reite nach Osten durch {zone:1441} zur {area:2240} im Gebiet {area:439}. {npc:4454} und {npc:4630} sind in den Lagern neben der Rennstrecke; {npc:4709} steht beim Goblinlager.",
	["He runs off to keep Rizzle busy"] = "Er läuft los, um Rizzle abzulenken",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "Rizzles Pläne",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Während {npc:4709} Rizzle in ein Gespräch verwickelt, liegen dessen Pläne unbewacht im Gnomenlager auf der anderen Seite der Rennstrecke.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Reite vom Gebiet {area:439} nach Südosten nach {zone:1446}. {area:976} liegt gleich hinter der Grenze.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, an der Nordseite der Stadt",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, beim Wasserturm",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, neben ihm",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Reite nach Osten über die Dünen zum Goblinhafen an der Nordostküste.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, in der Taverne des Hafens",
	["The Wanted poster beside him"] = "Der Steckbrief neben ihm",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Folge der Küste nach Süden zur Piratenbucht. Piraten der Südmeerfreibeuter drängen sich am Strand und auf den Booten: Arbeite dich am Rand entlang und zieh einen nach dem anderen. {npc:7883} steht auf der anderen Seite; die gestohlene Fracht von {npc:7881} liegt im Lager.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "Die nächste Lieferung von {npc:7881} geht zurück nach {area:35}: Überspring sie.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "Banditen der Wüstenläufer",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Reite zurück nach Westen Richtung {area:976}. Die Banditen und Diebe der Wüstenläufer halten unterwegs die Dünen; jeder von ihnen kann einen Wasserbeutel tragen.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Die stärkeren Schurken, Schattenmagier und Auftragsmörder der Wüstenläufer lagern südöstlich von {area:976}, südlich der Banditen. Lass {npc:7847} in der Mitte des südlichen Lagers für später.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: Seine Kiste geht später nach {area:702}",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Der Teich bei der {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Reite nach Nordwesten zum Trolllager der Sandfury bei der {area:979}. Benutze den {item:8584} am Rand des Teichs; die Trolle stehen dicht beieinander, also zieh zuerst den nächsten.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Gibt dir den {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Teich bei der {area:979}",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "Die {area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Reite nach Süden zum Grabungslager an der {area:1938}. {npc:7771} gibt dir einen Detektorhelm: Trag ihn, um die Hügel von {quest:3161} zu sehen, die dicht im Sand rund um das Lager und nach Südwesten Richtung Oger liegen.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Reite nach Südwesten zum Lager der Oger. Schläger und Vollstrecker (46-48) füllen es; {npc:12046} (49) steht mit Wachen um sich herum in der Mitte: Räum sie zuerst weg.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Reite nach Nordwesten zum Stock der Centipaar in den Dünen. Jeder Centipaar kann Insektenteile droppen.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Reite nach Süden ins {quest:3362}. Die Disteltausammler droppen die Drüsen; nur manche sind gefüllt, also behalte die Gefüllte Taudrüse. Knorrige Distelwandler und Distelwurzelformer teilen sich das Tal. Die Distelwandler sind Stufe 48-50, über dir: Zieh einen nach dem anderen.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Eskorte von {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "Die kleine Schildkröte {npc:5955} versteckt sich am Nordende des Tals. Führe ihn heim zu seiner Frau {npc:6015}, am Wasser gleich östlich von {area:977}: Er läuft langsam und die Bestien der Wüste greifen ihn an, also halte ihn am Leben.",

	-- Step 19: Steamwheedle Port
	-- {npc:7882} Security Chief Bilgewhizzle
	["The Wanted poster by {npc:7882}"] = "Der Steckbrief bei {npc:7882}",

	-- Step 20: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Reite zurück nach Westen nach {area:976}.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, an der Ostseite der Stadt",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "Die nächste Zutat von {npc:7583} wächst im {zone:1425}, und die Route führt dich nie wieder dorthin: Überspring sie.",

	-- Step 21: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Reite nach Südosten zum {area:985}. {npc:7847} steht in der Mitte des südlichen Lagers der Wüstenläufer: Räum zuerst um ihn herum.",

	-- Step 22: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Reite nach Süden an {area:1938} vorbei zu {area:981}, den Tunneln der Hazzali; Scrimshanks Ausrüstung liegt tief darin.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "Ruhestein nach {area:976}.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "für {zone:1457}: Die Route führt dich mit 47 dorthin",

	-- Step 24: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Flieg von {area:976} nach Theramore, nimm das Boot zum Ort {area:150} und flieg nach {area:1537}. Trainiere.",

	-- Step 25: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "Flieg nach {area:348}. Der Guide für {zone:1425} beginnt hier.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Flieg nach {area:348}. Der Guide für {zone:1425} beginnt hier.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Reite nach Süden an der {area:1938} vorbei zu den Tunneln der Hazzali ({area:981}); Scrimshanks Ausrüstung liegt tief darin.",
}
