-- French (frFR): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "Apprendre {skill:171}",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "{skill:171} niveau Apprenti vous permet de progresser jusqu'à 75 pour 10c, à n'importe quel niveau de personnage. N'importe quel maître en {skill:171} de votre faction l'enseigne ; la flèche indique le plus proche. Associez-la à {skill:182} : {item:2447} et {item:765} poussent dans toutes les zones de départ, et les Fioles vides coûtent 4c chez n'importe quel fournisseur d'alchimie ou de fournitures d'artisanat. 1-75 demande environ 3s 28c d'achats chez les marchands, plus 82 {item:765} et 110 {item:2447} à cueillir ou acheter.",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1-75 : fournitures de marchand",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 82 {item:3371} (3s 28c) ; environ 3s 28c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",

	-- Step 3: Silverleaf (Elwynn Forest)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1429} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1429} est indiqué.",

	-- Step 4: Silverleaf (Dun Morogh)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1426} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1426} est indiqué.",

	-- Step 5: Silverleaf (Teldrassil)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1438} Teldrassil
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1438} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1438} est indiqué.",

	-- Step 6: Silverleaf (Zephras Isle)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:2521} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:2521} est indiqué.",

	-- Step 7: Silverleaf (Durotar)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1411} Durotar
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1411} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1411} est indiqué.",

	-- Step 8: Silverleaf (Mulgore)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1412} Mulgore
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1412} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1412} est indiqué.",

	-- Step 9: Silverleaf (Tirisfal Glades)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1420} is marked."] = "82 {item:765} pour {item:5997} : {skill:182} : {item:765} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:765} dans {zone:1420} est indiqué.",

	-- Step 10: Peacebloom (Elwynn Forest)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1429} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1429} est indiqué.",

	-- Step 11: Peacebloom (Dun Morogh)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1426} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1426} est indiqué.",

	-- Step 12: Peacebloom (Teldrassil)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1438} Teldrassil
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1438} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1438} est indiqué.",

	-- Step 13: Peacebloom (Zephras Isle)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:2521} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:2521} est indiqué.",

	-- Step 14: Peacebloom (Durotar)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1411} Durotar
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1411} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1411} est indiqué.",

	-- Step 15: Peacebloom (Mulgore)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1412} Mulgore
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1412} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1412} est indiqué.",

	-- Step 16: Peacebloom (Tirisfal Glades)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1420} is marked."] = "110 {item:2447} pour {item:5997} et {spell:2331} (dont 28 pour la tranche 75-150 : ramassez-les tous maintenant) : {skill:182} : {item:2447} (compétence 1) ; ou l'hôtel des ventes. Le meilleur coin de {item:2447} dans {zone:1420} est indiqué.",

	-- Step 17: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} jusqu'à 75",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997} est orange à 1 (jaune à 55, vert à 75, gris à 95) : environ 82 fabrications jusqu'à 75. Chacune demande 1 {item:765}, 1 {item:2447} et 1 {item:3371}. Connue dès le départ, c'est la façon la moins chère de passer la tranche Apprenti. Gardez les élixirs (de l'armure pendant la montée de niveau) ou vendez-les.",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "{skill:171} (Compagnon)",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:4609} Doctor Marsh · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4160} ({zone:1457}), {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:7948} ({zone:1444}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4611} ({zone:1458}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:1386} ({zone:1435}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "Le rang Compagnon fait passer le plafond de 75 à 150 pour 4s 50c (le prix de Classic ; celui de Forever n'est pas dans les données) ; il demande {skill:171} 50 et le niveau 10, vous pouvez donc le prendre à n'importe quelle visite à partir de 50. Tous les maîtres en {skill:171} ne l'enseignent pas : Alliance {npc:4160} ({zone:1457}), {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:7948} ({zone:1444}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) et {npc:5177} ({zone:1455}) ; Horde {npc:3009} ({zone:1456}), {npc:4611} ({zone:1458}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:1386} ({zone:1435}), {npc:2391} ({zone:1424}) et {npc:3347} ({zone:1454}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:2331} (dès 25, 1s). Apprenez aussi {spell:1230564} (1s) : l'objet de camp d'{skill:171} de Forever, 1 {item:2447} et 1 {item:3371}, à poser sur un campement près d'un feu de camp pour son effet. La quête Camping 101 : {skill:171} du guide de camping de votre zone de départ (après The Great Outdoors) vous envoie chez un maître en alchimie qui l'enseigne gratuitement. 75-150 demande environ 1s de recettes et 9s 8c d'achats chez les marchands, plus 77 {item:785}, 152 {item:2450} et 54 {item:2453} à cueillir ou acheter.",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75-150 : fournitures de marchand",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 77 {item:3371} (3s 8c) et 15 {item:3372} (6s) ; environ 9s 8c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",

	-- Step 20: Mageroyal (Westfall)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1436} Westfall
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1436} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:1436} est indiqué.",

	-- Step 21: Mageroyal (Loch Modan)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1432} Loch Modan
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1432} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:1432} est indiqué.",

	-- Step 22: Mageroyal (Teldrassil)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1438} Teldrassil
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1438} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:1438} est indiqué.",

	-- Step 23: Mageroyal (Zephras Isle)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:2521} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:2521} est indiqué.",

	-- Step 24: Mageroyal (The Barrens)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1413} The Barrens
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1413} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:1413} est indiqué.",

	-- Step 25: Mageroyal (Silverpine Forest)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1421} is marked."] = "77 {item:785} pour {spell:2331} et {spell:3171} : {skill:182} : {item:785} (compétence 50) ; ou l'hôtel des ventes. Le meilleur coin de {item:785} dans {zone:1421} est indiqué.",

	-- Step 26: Briarthorn (Westfall)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1436} is marked."] = "152 {item:2450} pour {spell:3171} et {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2450} (compétence 70) ; ou l'hôtel des ventes. Le meilleur coin de {item:2450} dans {zone:1436} est indiqué.",

	-- Step 27: Briarthorn (Loch Modan)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1432} is marked."] = "152 {item:2450} pour {spell:3171} et {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2450} (compétence 70) ; ou l'hôtel des ventes. Le meilleur coin de {item:2450} dans {zone:1432} est indiqué.",

	-- Step 28: Briarthorn (Darkshore)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1439} is marked."] = "152 {item:2450} pour {spell:3171} et {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2450} (compétence 70) ; ou l'hôtel des ventes. Le meilleur coin de {item:2450} dans {zone:1439} est indiqué.",

	-- Step 29: Briarthorn (The Barrens)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1413} is marked."] = "152 {item:2450} pour {spell:3171} et {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2450} (compétence 70) ; ou l'hôtel des ventes. Le meilleur coin de {item:2450} dans {zone:1413} est indiqué.",

	-- Step 30: Briarthorn (Silverpine Forest)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1421} is marked."] = "152 {item:2450} pour {spell:3171} et {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2450} (compétence 70) ; ou l'hôtel des ventes. Le meilleur coin de {item:2450} dans {zone:1421} est indiqué.",

	-- Step 31: Bruiseweed (Westfall)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1436} is marked."] = "54 {item:2453} pour {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2453} (compétence 100) ; ou l'hôtel des ventes. Le meilleur coin de {item:2453} dans {zone:1436} est indiqué.",

	-- Step 32: Bruiseweed (Loch Modan)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1432} is marked."] = "54 {item:2453} pour {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2453} (compétence 100) ; ou l'hôtel des ventes. Le meilleur coin de {item:2453} dans {zone:1432} est indiqué.",

	-- Step 33: Bruiseweed (Darkshore)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1439} is marked."] = "54 {item:2453} pour {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2453} (compétence 100) ; ou l'hôtel des ventes. Le meilleur coin de {item:2453} dans {zone:1439} est indiqué.",

	-- Step 34: Bruiseweed (The Barrens)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1413} is marked."] = "54 {item:2453} pour {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2453} (compétence 100) ; ou l'hôtel des ventes. Le meilleur coin de {item:2453} dans {zone:1413} est indiqué.",

	-- Step 35: Bruiseweed (Silverpine Forest)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1421} is marked."] = "54 {item:2453} pour {spell:3176} (dont 24 pour la tranche 150-225 : ramassez-les tous maintenant) : {skill:182} : {item:2453} (compétence 100) ; ou l'hôtel des ventes. Le meilleur coin de {item:2453} dans {zone:1421} est indiqué.",

	-- Step 36: Minor Mana Potion to 90
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 90"] = "{spell:2331} jusqu'à 90",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331} est jaune à 75 (jaune à 65, vert à 85, gris à 105) : environ 28 fabrications jusqu'à 90. Chacune demande 1 {item:785}, 1 {item:2447} et 1 {item:3371}. Le maître l'enseigne dès 25. Elle est déjà jaune, comptez donc environ deux fabrications par point jusqu'à ce que {spell:3171} prenne le relais à 90. {item:785} pousse dans les zones de niveau 10-25.",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "{skill:171} : recettes à 90",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "Retournez voir un maître en {skill:171} : {spell:3171} (dès 90).",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "{spell:3171} jusqu'à 135",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171} est orange à 90 (jaune à 120, vert à 140, gris à 160) : environ 49 fabrications jusqu'à 135. Chacune demande 1 {item:785}, 2 {item:2450} et 1 {item:3371}. Deux {item:2450} et un {item:785} par fabrication, tous deux des zones de niveau 10-25 ; orange jusqu'à 120.",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "{skill:171} : recettes à 135",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "Retournez voir un maître en {skill:171} : {spell:3176} (dès 125).",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176} jusqu'à 150",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176} est orange à 135 (jaune à 150, vert à 170, gris à 190) : environ 15 fabrications jusqu'à 150, un point par fabrication. Chacune demande 2 {item:2453}, 2 {item:2450} et 1 {item:3372}. Deux {item:2453} et deux {item:2450} par fabrication ; {item:2453} pousse dans les zones de niveau 15-30. {skill:171} 150 est une étape du système d'Héritage.",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150-225 : fournitures de marchand",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 83 {item:3372} (33s 20c) ; environ 33s 20c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",

	-- Step 42: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Alliance)",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1434} is marked."] = "40 {object:1623} pour {item:8951} (dont 8 pour la tranche 225-300 : ramassez-les tous maintenant) : {skill:182} : {object:1623} (compétence 115) dans {zone:1442} (15-27), {zone:1417} (30-40) et {zone:1434} (30-45) ; ou l'hôtel des ventes. Le meilleur coin de {object:1623} dans {zone:1434} est indiqué.",

	-- Step 43: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Horde)",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1442} is marked."] = "40 {object:1623} pour {item:8951} (dont 8 pour la tranche 225-300 : ramassez-les tous maintenant) : {skill:182} : {object:1623} (compétence 115) dans {zone:1442} (15-27), {zone:1417} (30-40) et {zone:1434} (30-45) ; ou l'hôtel des ventes. Le meilleur coin de {object:1623} dans {zone:1442} est indiqué.",

	-- Step 44: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Alliance)",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1434} is marked."] = "39 {item:3356} pour {spell:3452} : {skill:182} : {item:3356} (compétence 125) dans {zone:1440} (18-30), {zone:1437} (20-30) et {zone:1434} (30-45) ; ou l'hôtel des ventes. Le meilleur coin de {item:3356} dans {zone:1434} est indiqué.",

	-- Step 45: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Horde)",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1413} is marked."] = "39 {item:3356} pour {spell:3452} : {skill:182} : {item:3356} (compétence 125) dans {zone:1413} (10-25), {zone:1440} (18-30) et {zone:1434} (30-45) ; ou l'hôtel des ventes. Le meilleur coin de {item:3356} dans {zone:1413} est indiqué.",

	-- Step 46: Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["{object:2045} (Alliance)"] = "{object:2045} (Alliance)",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1434} is marked."] = "39 {object:2045} pour {spell:3452} : {skill:182} : {object:2045} (compétence 85) dans {zone:1437} (20-30), {zone:1434} (30-45) et {zone:1425} (40-50) ; ou l'hôtel des ventes. Le meilleur coin de {object:2045} dans {zone:1434} est indiqué.",

	-- Step 47: Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["{object:2045} (Horde)"] = "{object:2045} (Horde)",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1413} is marked."] = "39 {object:2045} pour {spell:3452} : {skill:182} : {object:2045} (compétence 85) dans {zone:1413} (10-25), {zone:1434} (30-45) et {zone:1425} (40-50) ; ou l'hôtel des ventes. Le meilleur coin de {object:2045} dans {zone:1413} est indiqué.",

	-- Step 48: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Alliance)",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1417} is marked."] = "40 {object:2046} pour {item:8951} (dont 8 pour la tranche 225-300 : ramassez-les tous maintenant) : {skill:182} : {object:2046} (compétence 170) dans {zone:1417} (30-40), {zone:1425} (40-50) et {zone:1444} (40-50) ; ou l'hôtel des ventes. Le meilleur coin de {object:2046} dans {zone:1417} est indiqué.",

	-- Step 49: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Horde)",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1444} is marked."] = "40 {object:2046} pour {item:8951} (dont 8 pour la tranche 225-300 : ramassez-les tous maintenant) : {skill:182} : {object:2046} (compétence 170) dans {zone:1417} (30-40), {zone:1425} (40-50) et {zone:1444} (40-50) ; ou l'hôtel des ventes. Le meilleur coin de {object:2046} dans {zone:1444} est indiqué.",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "{skill:171} (Expert)",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}) and {npc:7948} ({zone:1444}); Horde {npc:4611} ({zone:1458}) and {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Le rang Expert fait passer le plafond de 150 à 225 pour 50s (le prix de Classic ; celui de Forever n'est pas dans les données) ; il demande {skill:171} 125 et le niveau 20, vous pouvez donc le prendre à n'importe quelle visite à partir de 125. Seuls quelques maîtres l'enseignent : Alliance {npc:4160} ({zone:1457}) et {npc:7948} ({zone:1444}) ; Horde {npc:4611} ({zone:1458}) et {npc:1386} ({zone:1435}). La flèche indique le plus proche de votre faction. 150-225 demande environ 33s 20c d'achats chez les marchands, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} et 40 {object:2046} à cueillir ou acheter. Venez avec tout dans vos sacs (les étapes ci-dessus, le reste à l'hôtel des ventes) : ces maîtres enseignent aussi {spell:3452} (dès 160) et {item:8951} (dès 195), et les fabrications ne demandent aucun atelier, alors fabriquez sur place et apprenez chaque recette dès que vous atteignez sa compétence. Un seul trajet au lieu de 3.",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "{spell:3176} jusqu'à 160",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176} est jaune à 150 (jaune à 150, vert à 170, gris à 190) : environ 12 fabrications jusqu'à 160. Chacune demande 2 {item:2453}, 2 {item:2450} et 1 {item:3372}. Deux {item:2453} et deux {item:2450} par fabrication ; {item:2453} pousse dans les zones de niveau 15-30.",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "{skill:171} : recettes à 160",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "Toujours chez le maître Expert : {spell:3452} (dès 160).",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "{spell:3452} jusqu'à 195",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452} est orange à 160 (jaune à 180, vert à 200, gris à 220) : environ 39 fabrications jusqu'à 195. Chacune demande 1 {item:3820}, 1 {item:3356} et 1 {item:3372}. {item:3820} pousse sous l'eau le long des côtes : prenez un élixir de respiration aquatique ou remontez respirer. {item:3356} pousse dans les zones de niveau 20-40.",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "{skill:171} : recettes à 195",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "Toujours chez le maître Expert : {spell:11450} (dès 195).",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951} jusqu'à 225",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951} est orange à 195 (jaune à 215, vert à 235, gris à 255) : environ 32 fabrications jusqu'à 225. Chacune demande 1 {item:3355}, 1 {item:3821} et 1 {item:3372}. {item:3355} et {item:3821} sont les herbes des zones de niveau 30-45 (Strangleronce, Arathi, {zone:1418}). {skill:171} 225 est une étape du système d'Héritage.",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225-300 : fournitures de marchand",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 51 {item:3372} (20s 40c) et 86 {item:8925} (4g 30s) ; environ 4g 50s 40c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 58: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Alliance)",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1422} is marked."] = "43 {item:8836} pour {item:9154} : {skill:182} : {item:8836} (compétence 220) dans {zone:1448} (48-55), {zone:1422} (51-58) et {zone:1423} (53-60) ; ou l'hôtel des ventes. Le meilleur coin de {item:8836} dans {zone:1422} est indiqué.",

	-- Step 59: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Horde)",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1448} is marked."] = "43 {item:8836} pour {item:9154} : {skill:182} : {item:8836} (compétence 220) dans {zone:1448} (48-55), {zone:1422} (51-58) et {zone:1423} (53-60) ; ou l'hôtel des ventes. Le meilleur coin de {item:8836} dans {zone:1448} est indiqué.",

	-- Step 60: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Alliance)",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1425} is marked."] = "",

	-- Step 61: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Horde)",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1444} is marked."] = "",

	-- Step 62: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Alliance)",
	-- {item:13422} Stonescale Eel · {item:13445} Elixir of Greater Defense · {skill:356} Fishing · {object:180712} Stonescale Eel Swarm
	["43 {item:13422} for {item:13445}: {skill:356}; or the Auction House. Fish {object:180712} here."] = "",

	-- Step 63: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Horde)",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "{skill:171} (Artisan)",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Le rang Artisan fait passer le plafond de 225 à 300 pour 4g 50s (le prix de Classic ; celui de Forever n'est pas dans les données) ; il demande {skill:171} 200 et le niveau 35, vous pouvez donc le prendre à n'importe quelle visite à partir de 200. Seuls quelques maîtres l'enseignent : Alliance {npc:7948} ({zone:1444}) ; Horde {npc:1386} ({zone:1435}). La flèche indique le plus proche de votre faction. 225-300 demande environ 1g 30s de recettes et 4g 50s 40c d'achats chez les marchands, plus 43 {item:8836}, 43 {item:8838} et 43 {item:13422} à cueillir, pêcher ou acheter. Venez avec tout dans vos sacs (les étapes ci-dessus, le reste à l'hôtel des ventes) : ces maîtres enseignent aussi {item:9154} (dès 230) et {item:13423} (dès 250), et les fabrications ne demandent aucun atelier, alors fabriquez sur place et apprenez chaque recette dès que vous atteignez sa compétence. Un seul trajet au lieu de 3.",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951} jusqu'à 230",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951} est jaune à 225 (jaune à 215, vert à 235, gris à 255) : environ 8 fabrications jusqu'à 230. Chacune demande 1 {item:3355}, 1 {item:3821} et 1 {item:3372}. {item:3355} et {item:3821} sont les herbes des zones de niveau 30-45 (Strangleronce, Arathi, {zone:1418}).",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "Recettes d'{skill:171} à 230",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "Toujours chez le maître Artisan : {spell:11460} (dès 230).",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154} jusqu'à 265",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154} est orange à 230 (jaune à 245, vert à 265, gris à 285) : environ 43 fabrications jusqu'à 265. Chacune demande 1 {item:8836} et 1 {item:8925}. {item:8836} pousse dans les Maleterres et en {zone:1448} ({skill:182} 220) ; les Fioles de cristal se vendent chez les fournisseurs d'alchimie.",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "{skill:171} : recettes à 265",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "Toujours chez le maître Artisan : {spell:17551} (dès 250).",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445} jusqu'à 300",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445} est orange à 265 (jaune à 280, vert à 300, gris à 320) : environ 43 fabrications jusqu'à 300. Chacune demande 2 {item:13423}, 1 {item:8838} et 1 {item:8925}. Fabriquez d'abord les 86 {item:13423} (43 fabrications). {item:13422} vient des bancs de {item:13422} sur les côtes des zones de niveau 40-55, ou de l'hôtel des ventes (les pêcheurs les vendent par piles). {item:8838} pousse dans les zones de niveau 40-55. {skill:171} 300 est une étape du système d'Héritage.",
	["from the recipe in your bags"] = "avec la recette dans vos sacs",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["43 {item:13422} for {item:8951}: {skill:356}; or the Auction House. Fish {object:180712} here."] = "43 {item:13422} pour {item:8951} : {skill:356} ; ou l'hôtel des ventes. Pêchez dans {object:180712} ici.",
	-- ["43 {item:8838} for {item:8951}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1425} is marked."] = "43 {item:8838} pour {item:8951} : {skill:182} : {item:8838} (compétence 230) dans {zone:1425} (40-50), {zone:1444} (40-50) et {zone:1447} (45-55) ; ou l'hôtel des ventes. Le meilleur coin de {item:8838} dans {zone:1425} est indiqué.",
	-- ["43 {item:8838} for {item:8951}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1444} is marked."] = "43 {item:8838} pour {item:8951} : {skill:182} : {item:8838} (compétence 230) dans {zone:1425} (40-50), {zone:1444} (40-50) et {zone:1447} (45-55) ; ou l'hôtel des ventes. Le meilleur coin de {item:8838} dans {zone:1444} est indiqué.",
	-- ["Apprentice {skill:171}"] = "{skill:171} (Apprenti)",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Artisan requiert le niveau 35 et {skill:171} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 7g 80s au total.",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Retournez voir un maître en {skill:171} : {spell:11447} s'apprend à partir de {skill:171} 190.",
	-- ["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Retournez voir un maître en {skill:171} : {spell:11450} s'apprend à partir de {skill:171} 215.",
	-- ["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Retournez voir un maître en {skill:171} : {spell:11460} s'apprend à partir de {skill:171} 245.",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Retournez voir un maître en {skill:171} : {spell:1244645} s'apprend à partir de {skill:171} 85.",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Retournez voir un maître en {skill:171} : {spell:1244647} s'apprend à partir de {skill:171} 175.",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Retournez voir un maître en {skill:171} : {spell:1244648} s'apprend à partir de {skill:171} 230.",
	-- ["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Retournez voir un maître en {skill:171} : {spell:17551} s'apprend à partir de {skill:171} 250.",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Retournez voir un maître en {skill:171} : {spell:7845} s'apprend à partir de {skill:171} 165.",
	-- ["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 51 {item:3372} (20s 40c) et 86 {item:8925} (4g 30s) ; environ 4g 50s 40c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",
	-- ["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 77 {item:3371} (3s 8c) et 15 {item:3372} (6s) ; environ 9s 8c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",
	-- ["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 82 {item:3371} (3s 28c) ; environ 3s 28c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",
	-- ["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Achetez d'un coup tout ce qu'il faut pour cette tranche : 83 {item:3372} (33s 20c) ; environ 33s 20c en tout. La flèche indique le vendeur le plus proche de votre faction ({zone:1453} : {npc:1286}, Eldraeith et {npc:1325} ; {zone:1454} : {npc:3367}, {npc:3348} et {npc:3334}).",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Expert requiert le niveau 20 et {skill:171} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 3g 65s au total.",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180582} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180657} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180712} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Compagnon requiert le niveau 10 et {skill:171} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 1g 44s au total.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le laissent tomber à l'endroit choisi par Polestar selon votre niveau et votre faction. L'hôtel des ventes convient aussi.",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 130, jaune jusqu'à 150, vert jusqu'à 170. {skill:171} 150 est un palier du système d'Héritage.",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 280, jaune jusqu'à 300, vert jusqu'à 320. {skill:171} 300 est un palier du système d'Héritage.",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Orange (un point à chaque fabrication) jusqu'à 55, jaune jusqu'à 75, vert jusqu'à 95. 75 est le plafond d'Apprenti.",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2447} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2450} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2453} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3355} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3356} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3357} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3821} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:765} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:785} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:8836} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:8838} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {object:1623} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {object:2046} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Apprend {item:6051} (requiert {skill:171} 100). Les marchands la vendent en stock limité qui se renouvelle.",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Apprend {item:8951} (requiert {skill:171} 265). Les marchands la vendent en stock limité qui se renouvelle ; l'hôtel des ventes en a souvent aussi.",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "Jaune jusqu'à 105, vert jusqu'à 125 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "Jaune jusqu'à 160, vert jusqu'à 170 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "Jaune jusqu'à 185, vert jusqu'à 205 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "Jaune jusqu'à 195, vert jusqu'à 215 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "Jaune jusqu'à 210, vert jusqu'à 230 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "Jaune jusqu'à 235, vert jusqu'à 255 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Jaune jusqu'à 235, vert jusqu'à 255 : chaque fabrication ne rapporte pas forcément un point. {skill:171} 225 est un palier du système d'Héritage.",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "Jaune jusqu'à 250, vert jusqu'à 270 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "Jaune jusqu'à 255, vert jusqu'à 260 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "Jaune jusqu'à 265, vert jusqu'à 285 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "Jaune jusqu'à 85, vert jusqu'à 105 : chaque fabrication ne rapporte pas forcément un point.",
	-- ["{item:13423} to 259"] = "{item:13423} jusqu'à 259",
	-- ["{item:13478} teaches {item:8951} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:13478} apprend {item:8951} ({skill:171} 265) pour 1g 30s. Vendu côté Alliance par {npc:5178} ({zone:1455}), stock limité ; côté Horde par {npc:3348} ({zone:1454}), stock limité. Ses vendeurs en ont un ou deux en stock, qui reviennent un certain temps après une vente ; l'hôtel des ventes en a souvent aussi.",
	-- ["{item:2447} (Alliance)"] = "{item:2447} (Alliance)",
	-- ["{item:2447} (Horde)"] = "{item:2447} (Horde)",
	-- ["{item:2450} (Alliance)"] = "{item:2450} (Alliance)",
	-- ["{item:2450} (Horde)"] = "{item:2450} (Horde)",
	-- ["{item:2452} (Alliance)"] = "{item:2452} (Alliance)",
	-- ["{item:2452} (Horde)"] = "{item:2452} (Horde)",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} s'obtient sur les plantes d'{item:2450} ({skill:182}) ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["{item:2453} (Alliance)"] = "{item:2453} (Alliance)",
	-- ["{item:2453} (Horde)"] = "{item:2453} (Horde)",
	-- ["{item:247239} to 100"] = "{item:247239} jusqu'à 100",
	-- ["{item:247241} to 200"] = "{item:247241} jusqu'à 200",
	-- ["{item:247242} to 250"] = "{item:247242} jusqu'à 250",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Alliance)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Horde)",
	-- ["{item:3357} (Alliance)"] = "{item:3357} (Alliance)",
	-- ["{item:3357} (Horde)"] = "{item:3357} (Horde)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Alliance)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Horde)",
	-- ["{item:6051} to 150"] = "{item:6051} jusqu'à 150",
	-- ["{item:6358} (Alliance)"] = "{item:6358} (Alliance)",
	-- ["{item:6358} (Horde)"] = "{item:6358} (Horde)",
	-- ["{item:6359} (Alliance)"] = "{item:6359} (Alliance)",
	-- ["{item:6359} (Horde)"] = "{item:6359} (Horde)",
	-- ["{item:6371} to 165"] = "{item:6371} jusqu'à 165",
	-- ["{item:730} (Alliance)"] = "{item:730} (Alliance)",
	-- ["{item:730} (Horde)"] = "{item:730} (Horde)",
	-- ["{item:765} (Alliance)"] = "{item:765} (Alliance)",
	-- ["{item:765} (Horde)"] = "{item:765} (Horde)",
	-- ["{item:785} (Alliance)"] = "{item:785} (Alliance)",
	-- ["{item:785} (Horde)"] = "{item:785} (Horde)",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "Les {npc:1958} (niveau 17-18) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "Les {npc:513} (niveau 14-15) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{skill:171} recipes at 165"] = "Recettes d'{skill:171} à 165",
	-- ["{skill:171} recipes at 175"] = "Recettes d'{skill:171} à 175",
	-- ["{skill:171} recipes at 200"] = "Recettes d'{skill:171} à 200",
	-- ["{skill:171} recipes at 215"] = "Recettes d'{skill:171} à 215",
	-- ["{skill:171} recipes at 250"] = "Recettes d'{skill:171} à 250",
	-- ["{skill:171} recipes at 259"] = "Recettes d'{skill:171} à 259",
	-- ["{skill:171} recipes at 85"] = "Recettes d'{skill:171} à 85",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "L'{skill:171} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (plafonds de Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 68s au total.",
	-- ["{spell:11447} to 215"] = "{spell:11447} jusqu'à 215",
	-- ["{spell:2331} to 85"] = "{spell:2331} jusqu'à 85",
	-- ["{spell:7845} to 175"] = "{spell:7845} jusqu'à 175",
}
