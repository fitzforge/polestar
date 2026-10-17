-- German (deDE): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Flieg nach {area:378}",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Reite von {area:378} die Straße entlang nach Osten in die Marschen. Das ausgebrannte {area:403} steht gleich hinter der Grenze daneben; der Schild, die Plakette und die Hufspuren sind in und neben der Ruine.",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "Nimm an der Gabelung die Straße nach Norden zum Ogerdorf Brackenwall.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, am Südrand des Dorfs, wo die Straße hereinkommt",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} wartet im Morast ({area:2302}) östlich des Dorfs. Folge ihm zu Reethe und halte ihn im ausbrechenden Kampf am Leben.",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "Stinki Ignatz",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Reite nach Norden zum {area:502}. Stinki steht am Fuß des Hügels; eskortiere ihn, während er gleich südlich davon Blätter von Sumpfbohnenpflanzen sammelt.",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs der Schlammflossen",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Die Murlocs der Schlammflossen drängen sich an der Küste östlich und nordöstlich vom {area:502}; jede Art lässt Köpfe fallen.",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Sumpfauge Jarl",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl wohnt im {area:497} südöstlich vom {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, neben dem Anwesen",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "Dunkelzahnspinnen",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Reite nach Westen zurück durch die Marschen. Die Dunkelzahngiftspucker auf den Kämmen nördlich von Brackenwall lassen die Giftbeutel fallen. Spitzel von Theramore (35-36) schleichen durch dieselben Wälder: Sie sind getarnt, also schau genau hin.",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Die Graunebelspinnen wimmeln am Höhleneingang nordwestlich von Brackenwall; jede Art lässt Augen fallen.",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "Reite nach Osten zurück zum {area:497}.",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "nur, wenn du ein {item:3853} dabeihast ({skill:164} oder Auktionshaus)",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, jetzt wo {npc:4791} den Bericht gelesen hat",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "Reite mit dem Kopf zurück nach Westen nach Brackenwall.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in the next guide"] = "Für {npc:2519} in {object:3202}, im nächsten Guide",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "Ruhestein nach {area:392}",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Reite nach Nordosten ins Tal ({area:607}). {npc:12277} wird im Zentaurenlager der Maraudine festgehalten; befreie sie und eskortiere sie nach Osten aus dem Tal hinaus.",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} wartet im Goblinlager auf der Westseite des Friedhofs ({area:596}).",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "Die Karawane von {npc:11626} hält auf der Straße am Rand von {area:602}. Eskortiere sie nach Osten am Koven vorbei; Dämonen greifen sie zweimal an.",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "Die Karawane endet in {npc:11596}s Lager auf der Ostseite des Friedhofs ({area:596}).",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} und {npc:5412} stehen im Posten gleich westlich von {npc:11596}s Lager.",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "Reite die Straße hinauf nach Norden zur Hütte an der Straße nördlich des Friedhofs.",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "Kodoknochen und Geister",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Sammle die über den Friedhof verstreuten Kodoknochen und benutze die {item:15848} zwischen den Knochen: Die angelockten Geister lassen das Geisterplasma fallen.",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Die Burning Blade hält die Festung nordwestlich von {area:2407}. Benutze {item:14523} an {npc:11876} in der Festung, um {item:13542} zu bekommen.",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Reite nach Westen zum Turm von {npc:11863} in {area:2405} an der Nordwestküste.",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "Küste der Zackenkämme",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Die Naga der Zackenkämme halten die Küste nördlich von {area:2405} bis zum {area:598}. {npc:12369} bewacht {quest:6027} an der äußersten Nordspitze.",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "Totems der Maraudine",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Reite von {area:2405} nach Süden ins Tal ({area:607}). Die Späher, Zänker, Raufer, Windhetzer und Marodeure der Maraudine (36-39) lassen {quest:93225} fallen.",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "Reite weiter nach Südwesten nach Shadowprey.",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Reite nach Osten zu {area:602}. Benutze den Rod of Banishing an jedem Dämonenportal, um sechs davon zu schließen.",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "Reite vom Koven nach Norden zu {npc:5412} am {area:597}.",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "Ruhestein nach Shadowprey",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "Der nächste Guide bringt dich zurück ins {zone:1434}.",
}
