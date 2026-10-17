-- French (frFR): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Apprendre {skill:129}",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Tout maître en {skill:129} de votre faction enseigne {skill:129} (Apprenti) (niveau de personnage 5) ; la flèche choisit le plus proche.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251} : étoffe",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "les humanoïdes de niveau 5-20 lâchent de l'{item:2589} (ou achetez-en à l'hôtel des ventes).",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} est orange dès 1 (jaune à 30, gris à 60) : environ 61 fabrications jusqu'à 50. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} (Compagnon)",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} (Compagnon) porte le maximum à 150 ; il faut la compétence 50 et le niveau de personnage 10 : la flèche choisit le maître en {skill:129} de votre faction le plus proche. Apprenez {spell:3276} lors de la même visite.",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581} : étoffe",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} est jaune dès 50 (jaune à 50, gris à 100) : environ 46 fabrications jusqu'à 80. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277} : étoffe",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "les humanoïdes de niveau 15-30 lâchent de l'{item:2592} (ou achetez-en à l'hôtel des ventes).",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} est jaune dès 80 (jaune à 80, gris à 150) : environ 49 fabrications jusqu'à 115. Les bandages ne demandent pas de feu : fabriquez-les n'importe où. Tout maître en {skill:129} de votre faction l'enseigne ; la flèche choisit le plus proche.",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278} : étoffe",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} est jaune dès 115 (jaune à 115, gris à 185) : environ 11 fabrications jusqu'à 125. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} (Expert)",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} (Expert) porte le maximum à 225 ; il faut la compétence 125 et le niveau de personnage 20 : c'est un livre, {item:16084} ; la flèche choisit son vendeur le plus proche pour votre faction. Achetez-le et lisez-le. Le même marchand vend les manuels de Bandage épais en soie et de {item:8544} : achetez les deux maintenant, vous les lirez à 180 et 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Acheter et lire {item:16084} ({skill:129} Expert)",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} est jaune dès 125 (jaune à 115, gris à 185) : environ 38 fabrications jusqu'à 150. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450} : étoffe",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "les humanoïdes de niveau 25-45 lâchent de l'{item:4306} (ou achetez-en à l'hôtel des ventes).",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} est jaune dès 150 (jaune à 150, gris à 210) : environ 42 fabrications jusqu'à 180. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451} : étoffe",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} est jaune dès 180 (jaune à 180, gris à 240) : environ 42 fabrications jusqu'à 210. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544} : étoffe",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "les humanoïdes de niveau 35-50 lâchent de l'{item:4338} (ou achetez-en à l'hôtel des ventes).",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} est jaune dès 210 (jaune à 210, gris à 270) : environ 18 fabrications jusqu'à 225. Les bandages ne demandent pas de feu : fabriquez-les n'importe où.",

	-- Step 20: Trauma
	["Trauma"] = "Traumatologie",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} (Artisan) s'obtient avec la quête {quest:6624}. Il faut la compétence 225 et le niveau 40 ; le maître en {skill:129} de {zone:1455} vous envoie voir le docteur à Theramore.",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} (Artisan) s'obtient avec la quête {quest:6622}. Il faut la compétence 225 et le niveau 40 ; le maître en {skill:129} d'{zone:1454} vous envoie voir le docteur à {area:321}.",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624} : soignez les soldats blessés de la tente du docteur avec les bandages qu'il vous donne, les plus critiques d'abord, avant qu'aucun ne meure.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} (Artisan)",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622} : soignez les soldats blessés de la tente du docteur avec les bandages qu'il vous donne, les plus critiques d'abord, avant qu'aucun ne meure.",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} est jaune dès 225 (jaune à 210, gris à 270) : environ 88 fabrications jusqu'à 260. Les bandages ne demandent pas de feu : fabriquez-les n'importe où. {item:8544} reste jaune jusqu'à 270 ; une seule recette jusqu'à 260 évite deux trajets chez le docteur.",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (compétence 260) est une recette d'Artisan : seul le docteur de {quest:6622} l'enseigne ({npc:12939} à Theramore, {npc:12920} à {area:321}).",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529} : étoffe",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "les humanoïdes de niveau 45-60 lâchent de l'{item:14047} (ou achetez-en à l'hôtel des ventes).",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} est jaune à partir de 260 (jaune à 260, gris à 320) : environ 65 fabrications jusqu'à 300. Les bandages n'ont pas besoin de feu : fabriquez-les n'importe où. {item:14529} reste jaune jusqu'à 320 ; il vous mène donc à 300 sans aller chercher le Bandage épais en étoffe runique.",
}
