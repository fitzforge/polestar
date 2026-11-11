-- French (frFR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Apprenez {skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pêchez ici jusqu'à la compétence 50, environ 50 prises : sous 75, chaque prise augmente la compétence. Lancez {skill:356} depuis votre grimoire, cliquez sur le bouchon quand il plonge. Gardez les poissons : ce sont vos premiers ingrédients de {skill:185}. Ici, les poissons s'échappent sous la compétence 25 ; un appât sur la canne ajoute à votre compétence pendant dix minutes et comble l'écart.",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "Pêchez ici jusqu'à la compétence 50, environ 50 prises : sous 75, chaque prise augmente la compétence. Lancez {skill:356} depuis votre grimoire, cliquez sur le bouchon quand il plonge. Gardez les poissons : ce sont vos premiers ingrédients de {skill:185}.",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "Rivage de {area:16638}",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "Côte de Sen'jin",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Compagnon)",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:356} (Compagnon) porte le plafond à 150 ; il demande la compétence 50 et le niveau 10 (les listes de maîtres relevées sur Forever exigent ce niveau), et coûte 5 pa. La flèche indique le maître de {skill:356} de votre faction le plus proche. {spell:1229745}, l'objet de camping de Forever pour {skill:356} (dès la compétence 20, 1 pa ou gratuit via Introduction au camping : {skill:356}), est un {item:6291} dans une {item:3371} : il ne donne aucun point de compétence, mais posé près d'un feu de camp il donne à tout le camp une amélioration pendant une heure.",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pêchez dans les bancs et en eau libre ici jusqu'à la compétence 125, environ 120 prises : dès 75, une prise augmente la compétence moins souvent (environ une sur deux vers 100, une sur trois vers 125). Les bancs (épaves flottantes, bancs de poissons) donnent aussi du butin en plus. Les {item:6530} (+50 dès la compétence 50, 1 pa pièce) sont deux fois plus forts qu'une {item:6529}. La {item:6365} (+5 dès la compétence 10, 9 pa 1 pc) est en stock limité chez les marchands de pêche : achetez-la dès que vous la voyez. Ici, les poissons s'échappent sous la compétence 75 ; un appât sur la canne ajoute à votre compétence pendant dix minutes et comble l'écart.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Côte de la {zone:1436}",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Côte de {zone:1439}",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oasis des {zone:1413}",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Expert)",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "{skill:356} (Expert) (plafond 225) est un livre, pas un rang de maître : {npc:2626} vend {item:16083} (1 po) sur le quai le plus bas de {area:35}, à la pointe sud de {zone:1434}, aux deux factions. Achetez-le et lisez-le ; il demande la compétence 125 et le niveau 20. Au niveau 20, le chemin sûr est le bateau depuis {area:392}, dans les {zone:1413}, pas la route à travers Strangleronce. Il vend aussi la {item:6532} (+75 dès la compétence 100, 2 pa 50 pc pièce), l'appât pour le reste du chemin.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Achetez et lisez {item:16083} ({skill:356} Expert)",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pêchez dans les bancs ici jusqu'à la compétence 225, environ 500 prises : une sur trois augmente la compétence à 125, une sur sept vers 225, c'est donc la longue étape. Le second objet de camping de Forever, le {item:279965} (dès la compétence 140), est un plan que laisse tomber Gelihast dans {area:2797}. Ici, les poissons s'échappent sous la compétence 150 ; un appât sur la canne ajoute à votre compétence pendant dix minutes et comble l'écart.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Côte : {zone:1437}",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Eaux d'{zone:1440}",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Côte de {area:287}",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Artisan) (plafond 300) s'obtient auprès de {npc:12919}, au {zone:1445}. Le maître de pêche d'{zone:1455} vous envoie à lui ; la quête demande la compétence 225 et le niveau 35.",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} (Artisan) (plafond 300) s'obtient auprès de {npc:12919}, au {zone:1445}. Le maître de pêche d'{zone:1454} vous envoie à lui ; la quête demande la compétence 225 et le niveau 35.",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} pêche depuis le rivage d'un îlot au large de la côte est, au sud de Theramore ; rejoignez-le à la nage depuis la côte.",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pêchez le long de la côte de {zone:1443} ({area:598} au nord-ouest, ou le rivage à l'ouest de {area:2408}) jusqu'à prendre un {item:16968} : environ une prise sur cinq le remonte là-bas, et il ne mord nulle part ailleurs. À la compétence 225, rien ne s'échappe ici.",

	-- Step 26: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "Pêchez le long de la {area:2521}, dans {zone:1444} (au sud-est de {area:2577}), jusqu'à prendre un {item:16967} : environ une prise sur cinq le remonte là-bas, et il ne mord nulle part ailleurs. Cette eau perd des poissons sous la compétence 300 : à 225, la plupart s'échappent, alors mettez d'abord une {item:6532} (+75) sur la canne.",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pêchez le long de {area:301} de {zone:1434} (le rivage ouest) jusqu'à prendre un {item:16969} : environ une prise sur cinq le remonte là-bas, et il ne mord nulle part ailleurs. À la compétence 225, rien ne s'échappe ici.",

	-- Step 29: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pêchez le long de {area:300} (le rivage est de {zone:1435}) jusqu'à prendre un {item:16970} : environ une prise sur cinq le remonte là-bas, et il ne mord nulle part ailleurs. À la compétence 225, rien ne s'échappe ici.",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Artisan)",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "Pêchez dans les bancs le long de la côte ici (anguilles, vivaneaux, épaves) jusqu'à la compétence 300, environ 650 prises (une sur sept augmente la compétence à 225, une sur dix vers 300). Une eau plus difficile ne fait pas monter plus vite : une prise compte pareil partout. Dès la compétence 225, cette eau ne perd aucun poisson, donc aucun appât n'est nécessaire. L'{item:6533} (+100 dès la compétence 100, 2 pa 50 pc) et la {item:6532} servent pour les eaux plus difficiles et les poissons rares, pas pour la compétence.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Côte de {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "N'importe quel maître de {skill:356} de votre faction enseigne {skill:356} (Apprenti) (niveau de personnage 5) ; la flèche indique le plus proche. Achetez une {item:6256} chez un marchand de fournitures ou d'articles de pêche et équipez-la.",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "Tout maître de {skill:356} de votre faction enseigne {skill:356} (Apprenti) (niveau 5, 1 pa) ; la flèche indique le plus proche, et chaque zone de départ en a un au bord de son lac ou de sa côte. Achetez une {item:6256} (23 pc) chez un marchand de fournitures ou de pêche et équipez-la (on ne pêche qu'avec une canne en main), ainsi que deux ou trois Verroteries brillantes (+25, 50 pc pièce) : un appât ajoute son bonus à votre compétence pendant dix minutes, donc moins de poissons s'échappent au début. Si vous vous êtes assis au feu de camp de votre zone de départ pour Les grands espaces sauvages, le guide de camping propose aussi Introduction au camping : {skill:356}, à rendre au maître de pêche qu'elle désigne à la compétence 20 pour la recette {spell:1229745}.",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} (Expert) (plafond 225) est un livre, pas un rang de maître : {npc:2626} vend {item:16083} à {area:35}, à la pointe sud de la {zone:1434}, aux deux factions. Achetez-le et lisez-le ; il faut la compétence 125 et le niveau 20.",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Pêchez ici jusqu'à la compétence 50. Cliquez sur le flotteur quand il éclabousse ; chaque prise peut augmenter la compétence.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Pêchez dans {area:2521}, à {zone:1444}, jusqu'à attraper un {item:16967} ; il ne mord qu'ici.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Pêchez sur {area:300}, le rivage sud-est du {zone:1435}, jusqu'à attraper un {item:16970} ; il ne mord qu'ici.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Pêchez sur {area:301}, le rivage nord-ouest de la {zone:1434}, jusqu'à attraper un {item:16969} ; il ne mord qu'ici.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Pêchez à {area:598}, la côte nord-ouest de {zone:1443} (le rivage des nagas Ondulame), jusqu'à attraper un {item:16968} ; il ne mord qu'ici.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Pêchez dans les bancs le long de la côte ici (anguilles, vivaneaux, épaves) jusqu'à la compétence 300. On vend à {area:35} des appâts et des {item:6530} pour un petit bonus de pêche.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Pêchez dans les bancs et en eau libre ici jusqu'à la compétence 125. Les bancs (débris flottants, bancs de poissons) donnent aussi du butin supplémentaire.",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Pêchez dans les bancs ici jusqu'à la compétence 225. Si les poissons s'échappent souvent, pêchez dans des eaux plus faciles le temps que votre compétence rattrape son retard.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} (Compagnon) porte le plafond à 150 ; il faut la compétence 50 et le niveau de personnage 10. La flèche indique le maître de {skill:356} de votre faction le plus proche.",
	-- ["Vile Fin shore"] = "Rivage des Aileron noir",
	-- ["{area:442} shore"] = "Rivage d'{area:442}",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} pêche depuis le rivage d'un petit îlot au large de la côte est, au sud de Theramore.",
	-- ["{zone:1411} coast"] = "Côte de {zone:1411}",
	-- ["{zone:1413} oasis"] = "Oasis : {zone:1413}",
}
