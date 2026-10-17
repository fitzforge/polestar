-- German (deDE): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "{skill:356} erlernen",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Jeder Lehrer für {skill:356} deiner Fraktion bringt dir {skill:356} (Lehrling) bei (Charakterstufe 5); der Pfeil wählt den nächsten. Kauf eine {item:6256} bei einem Handwerkswaren- oder Angelbedarfshändler und leg sie an.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Angle hier bis Fertigkeit 50. Klick auf den Schwimmer, wenn er platscht; jeder Fang kann die Fertigkeit steigern.",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "Ufer bei {area:442}",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "Küste von {zone:1411}",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oase im {zone:1413}",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "Ufer der Finsterflossen",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Geselle)",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10. Der Pfeil wählt den nächsten Lehrer für {skill:356} deiner Fraktion.",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Angle hier in Schwärmen und offenem Wasser bis Fertigkeit 125. Schwärme (Treibgut, Fischschwärme) bringen auch zusätzliche Beute.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Küste von {zone:1436}",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Küste von {zone:1439}",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Experte)",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} (Experte) (Obergrenze 225) ist ein Buch, kein Lehrerrang: {npc:2626} verkauft {item:16083} in {area:35} an der Südspitze von {zone:1434}, an beide Fraktionen. Kauf und lies es; dafür brauchst du Fertigkeit 125 und Stufe 20.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} kaufen und lesen ({skill:356}, Experte)",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Angle hier in den Schwärmen bis Fertigkeit 225. Entkommen dir ständig Fische, angle in leichteren Gewässern, bis deine Fertigkeit aufholt.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Küste des {zone:1437}",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Gewässer von {zone:1440}",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Küste von {area:287}",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Fachmann) (Obergrenze 300) gibt es bei {npc:12919} in {zone:1445}. Der Angellehrer in {zone:1455} schickt dich zu ihm; die Quest braucht Fertigkeit 225 und Stufe 35.",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Fachmann) (Obergrenze 300) gibt es bei {npc:12919} in {zone:1445}. Der Angellehrer in {zone:1454} schickt dich zu ihm; die Quest braucht Fertigkeit 225 und Stufe 35.",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} angelt vom Ufer einer kleinen Insel vor der Ostküste, südlich von Theramore.",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Angle am {area:598}, der Nordwestküste von {zone:1443} (Ufer der Naga der Zackenkämme), bis du einen {item:16968} fängst; er beißt nur dort.",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Angle im Fluss {area:2521} in {zone:1444}, bis du einen {item:16967} fängst; er beißt nur dort.",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Angle im Gebiet {area:301}, dem Nordwestufer von {zone:1434}, bis du einen {item:16969} fängst; er beißt nur dort.",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Angle am {area:300}, dem Südostufer von {zone:1435}, bis du einen {item:16970} fängst; er beißt nur dort.",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Fachmann)",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Angle hier in den Schwärmen entlang der Küste (Aale, Schnapper, Wrackteile) bis Fertigkeit 300. In {area:35} gibt es Köder und {item:6530} für einen kleinen Angelbonus.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Küste bei {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "Oase im {zone:1413}",
}
