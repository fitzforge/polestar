-- French (frFR): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Enchanting
	-- {skill:333} Enchanting
	["Apprentice {skill:333}"] = "Apprenti {skill:333}",
	-- {skill:333} Enchanting
	["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (les plafonds Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 4 po 3 pa au total.",

	-- Step 2: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418} jusqu'à 25",
	["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "Orange (un point à chaque fabrication) jusqu'à 20, jaune jusqu'à 22, vert jusqu'à 25. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",
	["a tool: keep it in your bags"] = "un outil : gardez-le dans vos sacs",

	-- Step 3: Enchant Bracer - Minor Deflect to 75
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 75"] = "{spell:7428} jusqu'à 75",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "Orange (un point à chaque fabrication) jusqu'à 80, jaune jusqu'à 100, vert jusqu'à 120. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient. 75 est le plafond Apprenti.",

	-- Step 4: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "Compagnon {skill:333}",
	-- {skill:333} Enchanting
	["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "Compagnon requiert le niveau 10 et {skill:333} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 7 po 51 pa au total.",

	-- Step 5: Formula: Enchant Cloak - Minor Agility
	-- {spell:13419} Enchant Cloak - Minor Agility · {skill:333} Enchanting
	["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks."] = "Enseigne {spell:13419} (requiert {skill:333} 110). Les marchands la vendent en quantité limitée qui se renouvelle.",

	-- Step 6: Shadowgem (Alliance)
	-- {item:1210} Shadowgem
	["{item:1210} (Alliance)"] = "{item:1210} (Alliance)",
	-- {item:1210} Shadowgem · {object:1731} Copper Vein · {skill:186} Mining
	["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210} provient des gisements de {object:1731} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 7: Shadowgem (Horde)
	-- {item:1210} Shadowgem
	["{item:1210} (Horde)"] = "{item:1210} (Horde)",

	-- Step 8: Enchanting materials for 75-150
	-- {skill:333} Enchanting
	["{skill:333} materials for 75-150"] = "{skill:333} : composants pour 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Dépecés, désenchantés ou fabriqués par un autre métier : récupérez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- {skill:164} Blacksmithing · {item:6338} Silver Rod
	["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164} : {item:6338} (ou l'hôtel des ventes)",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333} : désenchantez de l'équipement inhabituel (vert) (ou l'hôtel des ventes)",

	-- Step 9: Enchant Bracer - Minor Deflect to 90
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 90"] = "{spell:7428} jusqu'à 90",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "Orange (un point à chaque fabrication) jusqu'à 80, jaune jusqu'à 100, vert jusqu'à 120. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 10: Enchanting recipes at 90
	-- {skill:333} Enchanting
	["{skill:333} recipes at 90"] = "{skill:333} : recettes à 90",
	-- {skill:333} Enchanting · {spell:7426} Enchant Chest - Minor Absorption
	["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "Retournez voir un maître de métier ({skill:333}) : {spell:7426} est enseigné dès {skill:333} 90.",

	-- Step 11: Enchant Chest - Minor Absorption to 120
	-- {spell:7426} Enchant Chest - Minor Absorption
	["{spell:7426} to 120"] = "{spell:7426} jusqu'à 120",
	["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 110, vert jusqu'à 130 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 12: Enchanting recipes at 120
	-- {skill:333} Enchanting
	["{skill:333} recipes at 120"] = "{skill:333} : recettes à 120",
	-- {skill:333} Enchanting · {spell:7788} Enchant Weapon - Minor Striking
	["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "Retournez voir un maître de métier ({skill:333}) : {spell:7788} est enseigné dès {skill:333} 120.",

	-- Step 13: Enchant Weapon - Minor Striking to 130
	-- {spell:7788} Enchant Weapon - Minor Striking
	["{spell:7788} to 130"] = "{spell:7788} jusqu'à 130",
	["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 140, vert jusqu'à 160 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 14: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "{skill:333} : recettes à 130",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod
	["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "Retournez voir un maître de métier ({skill:333}) : {spell:7795} est enseigné dès {skill:333} 130.",

	-- Step 15: Enchant Cloak - Minor Agility to 150
	-- {spell:13419} Enchant Cloak - Minor Agility
	["{spell:13419} to 150"] = "{spell:13419} jusqu'à 150",
	-- {skill:333} Enchanting
	["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 135, jaune jusqu'à 155, vert jusqu'à 175. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient. {skill:333} 150 est un palier du système d'Héritage.",
	["from the recipe in your bags"] = "depuis la recette dans vos sacs",

	-- Step 16: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "Expert {skill:333}",
	-- {skill:333} Enchanting
	["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "Expert requiert le niveau 20 et {skill:333} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 13 pa au total.",

	-- Step 17: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500} (Alliance)",
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Open Giant Clams here. The Auction House works too."] = "Ouvrez des Palourdes géantes ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 18: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500} (Horde)",

	-- Step 19: Enchanting materials for 150-225
	-- {skill:333} Enchanting
	["{skill:333} materials for 150-225"] = "{skill:333} : composants pour 150-225",
	-- {skill:171} Alchemy · {item:6371} Fire Oil
	["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171} : {item:6371} (ou l'hôtel des ventes)",
	-- {skill:164} Blacksmithing · {item:11128} Golden Rod
	["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164} : {item:11128} (ou l'hôtel des ventes)",

	-- Step 20: Enchant Cloak - Lesser Fire Resistance to 155
	-- {spell:7861} Enchant Cloak - Lesser Fire Resistance
	["{spell:7861} to 155"] = "{spell:7861} jusqu'à 155",
	["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 170, vert jusqu'à 190 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 21: Enchanting recipes at 155
	-- {skill:333} Enchanting
	["{skill:333} recipes at 155"] = "{skill:333} : recettes à 155",
	-- {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "Retournez voir un maître de métier ({skill:333}) : {spell:13501} est enseigné dès {skill:333} 155.",

	-- Step 22: Enchant Bracer - Lesser Stamina to 180
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 180"] = "{spell:13501} jusqu'à 180",
	["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 175, vert jusqu'à 195 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 23: Enchanting recipes at 180
	-- {skill:333} Enchanting
	["{skill:333} recipes at 180"] = "{skill:333} : recettes à 180",
	-- {skill:333} Enchanting · {spell:13628} Runed Golden Rod · {spell:13637} Enchant Boots - Lesser Agility
	["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "Retournez voir un maître de métier ({skill:333}) : {spell:13628} et {spell:13637} sont enseignés dès {skill:333} 180.",

	-- Step 24: Enchant Boots - Lesser Agility to 200
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 200"] = "{spell:13637} jusqu'à 200",
	["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 200, vert jusqu'à 220 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 25: Enchanting recipes at 200
	-- {skill:333} Enchanting
	["{skill:333} recipes at 200"] = "{skill:333} : recettes à 200",
	-- {skill:333} Enchanting · {spell:13661} Enchant Bracer - Strength
	["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "Retournez voir un maître de métier ({skill:333}) : {spell:13661} est enseigné dès {skill:333} 200.",

	-- Step 26: Enchant Bracer - Strength to 225
	-- {spell:13661} Enchant Bracer - Strength
	["{spell:13661} to 225"] = "{spell:13661} jusqu'à 225",
	-- {skill:333} Enchanting
	["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "Jaune jusqu'à 220, vert jusqu'à 240 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient. {skill:333} 225 est un palier du système d'Héritage.",

	-- Step 27: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "Artisan {skill:333}",
	-- {skill:333} Enchanting
	["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "Artisan requiert le niveau 35 et {skill:333} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 30 pa au total.",
	-- {npc:11073} Annora · {skill:333} Enchanting · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073} enseigne {skill:333} Artisan dans le donjon {area:1517} ({zone:1418}) ; venez en groupe",

	-- Step 28: Black Pearl (Alliance)
	-- {item:7971} Black Pearl
	["{item:7971} (Alliance)"] = "{item:7971} (Alliance)",
	-- {npc:922} Silt Crawler
	["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "Les {npc:922} (niveau 40-41) le lâchent ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 29: Black Pearl (Horde)
	-- {item:7971} Black Pearl
	["{item:7971} (Horde)"] = "{item:7971} (Horde)",
	-- {npc:5431} Surf Glider
	["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "Les {npc:5431} (niveau 48-50) le lâchent ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 30: Wildvine (Alliance)
	-- {item:8153} Wildvine
	["{item:8153} (Alliance)"] = "{item:8153} (Alliance)",
	-- {item:8153} Wildvine · {item:8831} Purple Lotus · {skill:182} Herbalism
	["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153} provient de {item:8831} ({skill:182}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 31: Wildvine (Horde)
	-- {item:8153} Wildvine
	["{item:8153} (Horde)"] = "{item:8153} (Horde)",

	-- Step 32: Enchanting materials for 225-300
	-- {skill:333} Enchanting
	["{skill:333} materials for 225-300"] = "{skill:333} : composants pour 225-300",
	-- {skill:164} Blacksmithing · {item:11144} Truesilver Rod
	["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164} : {item:11144} (ou l'hôtel des ventes)",

	-- Step 33: Enchant Cloak - Greater Defense to 255
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 255"] = "{spell:13746} jusqu'à 255",
	["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 245, vert jusqu'à 265 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 34: Enchanting recipes at 255
	-- {skill:333} Enchanting
	["{skill:333} recipes at 255"] = "{skill:333} : recettes à 255",
	-- {skill:333} Enchanting · {spell:13935} Enchant Boots - Agility
	["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "Retournez voir un maître de métier ({skill:333}) : {spell:13935} est enseigné dès {skill:333} 255.",

	-- Step 35: Enchant Boots - Agility to 292
	-- {spell:13935} Enchant Boots - Agility
	["{spell:13935} to 292"] = "{spell:13935} jusqu'à 292",
	["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Jaune jusqu'à 275, vert jusqu'à 295 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient.",

	-- Step 36: Enchanting recipes at 292
	-- {skill:333} Enchanting
	["{skill:333} recipes at 292"] = "{skill:333} : recettes à 292",
	-- {skill:333} Enchanting · {spell:13948} Enchant Gloves - Minor Haste
	["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "Retournez voir un maître de métier ({skill:333}) : {spell:13948} est enseigné dès {skill:333} 270.",

	-- Step 37: Enchant Gloves - Minor Haste to 300
	-- {spell:13948} Enchant Gloves - Minor Haste
	["{spell:13948} to 300"] = "{spell:13948} jusqu'à 300",
	-- {skill:333} Enchanting
	["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "Jaune jusqu'à 290, vert jusqu'à 310 : chaque fabrication ne rapporte pas un point. Enchantez votre propre équipement : n'importe quel objet pour cet emplacement convient. {skill:333} 300 est un palier du système d'Héritage.",
}
