-- German (deDE): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "{skill:356} erlernen",
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "Jeder {skill:356}-Lehrer deiner Fraktion lehrt Lehrling in {skill:356} (Charakterstufe 5, 1s); der Pfeil wählt den nächsten, und jedes Startgebiet hat einen an seinem See oder Ufer. Kauf bei einem Handwerkswaren- oder Angelhändler eine {item:6256} (23c) und rüste sie aus (du kannst nur fischen, wenn du eine Angel in den Händen hältst), dazu zwei oder drei Shiny Baubles (+25, je 50c): Ein Köder addiert zehn Minuten lang seinen Bonus zu deiner Fertigkeit, sodass am Anfang weniger Fische entkommen. Wenn du für The Great Outdoors am Lagerfeuer deines Startgebiets gesessen hast, bietet der dortige Camping-Guide auch Camping 101: {skill:356} an; gib sie bei Fertigkeit 20 beim genannten Angellehrer ab, für das Rezept {spell:1229745}.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Angle hier bis Fertigkeit 50, etwa 50 Fänge: Unter 75 steigert jeder Fang die Fertigkeit. Wirf mit {skill:356} aus deinem Zauberbuch die Angel aus und klicke auf den Schwimmer, wenn es spritzt. Behalte die Fische: Sie sind deine ersten {skill:185}-Zutaten. Hier entkommen Fische unter Fertigkeit 25; ein Köder an der Angel addiert zehn Minuten lang zu deiner Fertigkeit und schließt die Lücke.",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "Angle hier bis Fertigkeit 50, etwa 50 Fänge: Unter 75 steigert jeder Fang die Fertigkeit. Wirf mit {skill:356} aus deinem Zauberbuch die Angel aus und klicke auf den Schwimmer, wenn es spritzt. Behalte die Fische: Sie sind deine ersten {skill:185}-Zutaten.",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "Ufer von {area:16638}",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "Küste von Sen'jin",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Geselle)",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "Geselle in {skill:356} hebt die Obergrenze auf 150 an; er braucht Fertigkeit 50 und Charakterstufe 10 (Forevers Listen der erschnüffelten Lehrer verlangen diese Stufe) und kostet 5s. Der Pfeil wählt den nächsten {skill:356}-Lehrer deiner Fraktion. {spell:1229745}, Forevers Camping-Gegenstand für {skill:356} (ab Fertigkeit 20, 1s oder kostenlos durch Camping 101: {skill:356}), ist {item:6291} in {item:3371}: Er gibt keine Fertigkeit, aber neben ein Lagerfeuer gestellt gibt er allen im Camp eine Stunde lang einen Buff.",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Angle hier an den Fischvorkommen und im offenen Wasser bis Fertigkeit 125, etwa 120 Fänge: Ab 75 steigert ein Fang die Fertigkeit seltener (etwa jeder zweite bei 100, jeder dritte bei 125). Fischvorkommen (treibende Wrackteile, Fischschwärme) geben außerdem zusätzliche Beute. {item:6530} (+50 ab Fertigkeit 50, je 1s) sind doppelt so stark wie ein {item:6529}. Die {item:6365} (+5 ab Fertigkeit 10, 9s 1c) gibt es bei Angelhändlern nur in begrenzter Stückzahl: Kauf sie, wenn du sie siehst. Hier entkommen Fische unter Fertigkeit 75; ein Köder an der Angel addiert zehn Minuten lang zu deiner Fertigkeit und schließt die Lücke.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Küste von {zone:1436}",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Küste von {zone:1439}",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oase im {zone:1413}",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Experte)",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "Experte in {skill:356} (Obergrenze 225) ist ein Buch, kein Lehrerrang: {npc:2626} verkauft {item:16083} (1g) am untersten Steg von {area:35}, an der Südspitze von {zone:1434}, an beide Fraktionen. Kauf es und lies es; es braucht Fertigkeit 125 und Stufe 20. Auf Stufe 20 ist der sichere Weg das Boot von {area:392} in {zone:1413}, nicht die Straße durch Stranglethorn. Er verkauft auch {item:6532} (+75 ab Fertigkeit 100, je 2s 50c), den Köder für den Rest des Weges.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} kaufen und lesen ({skill:356}, Experte)",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Angle hier an den Fischvorkommen bis Fertigkeit 225, etwa 500 Fänge: Bei 125 steigert jeder dritte Fang die Fertigkeit, bei 225 nur noch jeder siebte, das ist also die lange Strecke. Forevers zweiter Camping-Gegenstand, das {item:279965} (ab Fertigkeit 140), ist ein Bauplan, der von Gelihast in {area:2797} droppt. Hier entkommen Fische unter Fertigkeit 150; ein Köder an der Angel addiert zehn Minuten lang zu deiner Fertigkeit und schließt die Lücke.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Küste des {zone:1437}",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Gewässer von {zone:1440}",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Küste von {area:287}",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Fachmann) (Obergrenze 300) gibt es bei {npc:12919} in {zone:1445}. Der Angellehrer in {zone:1455} schickt dich zu ihm; die Quest braucht Fertigkeit 225 und Stufe 35.",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Fachmann) (Obergrenze 300) gibt es bei {npc:12919} in {zone:1445}. Der Angellehrer in {zone:1454} schickt dich zu ihm; die Quest braucht Fertigkeit 225 und Stufe 35.",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} angelt am Ufer einer kleinen Insel vor der Ostküste, südlich von Theramore; schwimm von der Küste hinüber.",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Angle entlang der Küste von {zone:1443} ({area:598} im Nordwesten oder das Ufer westlich von {area:2408}), bis du einen {item:16968} fängst: Etwa jeder fünfte Fang dort bringt ihn herauf, und er beißt nirgendwo sonst an. Bei Fertigkeit 225 entkommt hier nichts.",

	-- Step 26: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "Angle entlang des {area:2521} in {zone:1444} (südöstlich von {area:2577}), bis du einen {item:16967} fängst: Etwa jeder fünfte Fang dort bringt ihn herauf, und er beißt nirgendwo sonst an. Dieses Wasser verliert Fische unter Fertigkeit 300: Bei 225 entkommen die meisten, also bring zuerst {item:6532} (+75) an der Angel an.",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Angle entlang der {area:301} von {zone:1434} (das Westufer), bis du einen {item:16969} fängst: Etwa jeder fünfte Fang dort bringt ihn herauf, und er beißt nirgendwo sonst an. Bei Fertigkeit 225 entkommt hier nichts.",

	-- Step 29: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Angle entlang des {area:300} (das Ostufer von {zone:1435}), bis du einen {item:16970} fängst: Etwa jeder fünfte Fang dort bringt ihn herauf, und er beißt nirgendwo sonst an. Bei Fertigkeit 225 entkommt hier nichts.",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Fachmann)",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "Angle hier an den Fischvorkommen entlang der Küste (Aale, Schnapper, Wrackteile) bis Fertigkeit 300, etwa 650 Fänge (bei 225 steigert jeder siebte die Fertigkeit, bei 300 jeder zehnte). Härteres Wasser steigert nicht schneller: Ein Fang zählt überall gleich. Ab Fertigkeit 225 verliert dieses Wasser keine Fische, also brauchst du keinen Köder. Der {item:6533} (+100 ab Fertigkeit 100, 2s 50c) und {item:6532} sind für härteres Wasser und seltene Fische gedacht, nicht für die Fertigkeit.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Küste bei {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Jeder Lehrer für {skill:356} deiner Fraktion bringt dir {skill:356} (Lehrling) bei (Charakterstufe 5); der Pfeil wählt den nächsten. Kauf eine {item:6256} bei einem Handwerkswaren- oder Angelbedarfshändler und leg sie an.",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} (Experte) (Obergrenze 225) ist ein Buch, kein Lehrerrang: {npc:2626} verkauft {item:16083} in {area:35} an der Südspitze von {zone:1434}, an beide Fraktionen. Kauf und lies es; dafür brauchst du Fertigkeit 125 und Stufe 20.",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Angle hier bis Fertigkeit 50. Klick auf den Schwimmer, wenn er platscht; jeder Fang kann die Fertigkeit steigern.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Angle im Fluss {area:2521} in {zone:1444}, bis du einen {item:16967} fängst; er beißt nur dort.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Angle am {area:300}, dem Südostufer von {zone:1435}, bis du einen {item:16970} fängst; er beißt nur dort.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Angle im Gebiet {area:301}, dem Nordwestufer von {zone:1434}, bis du einen {item:16969} fängst; er beißt nur dort.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Angle am {area:598}, der Nordwestküste von {zone:1443} (Ufer der Naga der Zackenkämme), bis du einen {item:16968} fängst; er beißt nur dort.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Angle hier in den Schwärmen entlang der Küste (Aale, Schnapper, Wrackteile) bis Fertigkeit 300. In {area:35} gibt es Köder und {item:6530} für einen kleinen Angelbonus.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Angle hier in Schwärmen und offenem Wasser bis Fertigkeit 125. Schwärme (Treibgut, Fischschwärme) bringen auch zusätzliche Beute.",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Angle hier in den Schwärmen bis Fertigkeit 225. Entkommen dir ständig Fische, angle in leichteren Gewässern, bis deine Fertigkeit aufholt.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10. Der Pfeil wählt den nächsten Lehrer für {skill:356} deiner Fraktion.",
	-- ["Vile Fin shore"] = "Ufer der Finsterflossen",
	-- ["{area:442} shore"] = "Ufer bei {area:442}",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} angelt vom Ufer einer kleinen Insel vor der Ostküste, südlich von Theramore.",
	-- ["{zone:1411} coast"] = "Küste von {zone:1411}",
	-- ["{zone:1413} oasis"] = "Oase im {zone:1413}",
}
