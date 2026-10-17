-- French (frFR): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "Apprenez {skill:182}",
	-- {skill:182} Herbalism
	["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "Tout maître en {skill:182} de votre faction enseigne {skill:182} (Apprenti) (personnage niveau 5) ; la flèche choisit le plus proche.",

	-- Step 2: Silverleaf & Earthroot: Elwynn Forest (1-50)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10."] = "Cueillez sur votre passage chaque {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (dès 15) et faites le tour des points de passage jusqu'à {skill:182} 50. Niveau de la zone : 1-10.",

	-- Step 8: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "{skill:182} (Compagnon)",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Compagnon) monte le plafond à 150 ; il faut la compétence 50 et le niveau 10. La flèche choisit le maître en {skill:182} de votre faction le plus proche.",

	-- Step 9: Briarthorn & Stranglekelp: Westfall (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Cueillez sur votre passage chaque {item:2447} (1, jaune), {item:765} (1, jaune), {item:2449} (15, jaune), {item:785} (50, orange), {item:2450} (dès 70), {item:3820} (dès 85) et faites le tour des points de passage jusqu'à {skill:182} 100. Niveau de la zone : 10-20.",

	-- Step 10: Mageroyal & Briarthorn: Loch Modan (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Cueillez sur votre passage chaque {item:2447} (1, jaune), {item:765} (1, jaune), {item:2449} (15, jaune), {item:785} (50, orange), {item:2450} (dès 70) et faites le tour des points de passage jusqu'à {skill:182} 100. Niveau de la zone : 10-20.",

	-- Step 12: Briarthorn & Stranglekelp: The Barrens (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-25."] = "Cueillez sur votre passage chaque {item:2447} (1, jaune), {item:765} (1, jaune), {item:2449} (15, jaune), {item:785} (50, orange), {item:2450} (dès 70), {item:3820} (dès 85) et faites le tour des points de passage jusqu'à {skill:182} 100. Niveau de la zone : 10-25.",

	-- Step 14: Bruiseweed: Redridge Mountains (100-125)
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. Zone level 15-25."] = "Cueillez sur votre passage chaque {item:2447} (1, vert), {item:2449} (15, vert), {item:785} (50, vert), {item:2450} (70, jaune), {item:2453} (100, orange) et faites le tour des points de passage jusqu'à {skill:182} 125. Niveau de la zone : 15-25.",

	-- Step 15: Bruiseweed & Wild Steelbloom: Thousand Needles (100-125)
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 25-35."] = "Cueillez sur votre passage chaque {item:2453} (100, orange), {object:1623} (dès 115) et faites le tour des points de passage jusqu'à {skill:182} 125. Niveau de la zone : 25-35.",

	-- Step 16: Bruiseweed & Wild Steelbloom: Hillsbrad Foothills (100-125)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "Cueillez sur votre passage chaque {item:2447} (1, vert), {item:765} (1, vert), {item:2449} (15, vert), {item:785} (50, vert), {item:2450} (70, jaune), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (dès 115) et faites le tour des points de passage jusqu'à {skill:182} 125. Niveau de la zone : 20-30.",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "{skill:182} (Expert)",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Expert) monte le plafond à 225 ; il faut la compétence 125 et le niveau 20. La flèche choisit le maître en {skill:182} de votre faction le plus proche.",

	-- Step 18: Grave Moss & Kingsblood: Duskwood (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "Cueillez sur votre passage chaque {item:785} (50, vert), {item:2450} (70, vert), {item:2453} (100, jaune), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) et faites le tour des points de passage jusqu'à {skill:182} 160. Niveau de la zone : 18-30.",

	-- Step 19: Kingsblood & Liferoot: Alterac Mountains (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "Cueillez sur votre passage chaque {item:785} (50, vert), {item:2450} (70, vert), {item:3820} (85, jaune), {item:2453} (100, jaune), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (dès 150) et faites le tour des points de passage jusqu'à {skill:182} 160. Niveau de la zone : 30-40.",

	-- Step 20: Fadeleaf & Goldthorn: Swamp of Sorrows (160-185)
	-- {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. Zone level 35-45."] = "Cueillez sur votre passage chaque {item:3820} (85, vert), {item:3356} (125, jaune), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (dès 170) et faites le tour des points de passage jusqu'à {skill:182} 185. Niveau de la zone : 35-45.",

	-- Step 21: Goldthorn & Khadgar's Whisker: Swamp of Sorrows (185-200)
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45."] = "Cueillez sur votre passage chaque {item:3356} (125, vert), {item:3357} (150, jaune), {item:3818} (160, jaune), {item:3821} (170, orange), {object:2043} (185, orange) et faites le tour des points de passage jusqu'à {skill:182} 200. Niveau de la zone : 35-45.",

	-- Step 22: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "{skill:182} (Artisan)",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Artisan) monte le plafond à 300 ; il faut la compétence 200 et le niveau 35. La flèche choisit le maître en {skill:182} de votre faction le plus proche.",

	-- Step 23: Khadgar's Whisker: Swamp of Sorrows (200-210) cont.
	-- {object:2043} Khadgar's Whisker · {zone:1435} Swamp of Sorrows
	["{object:2043}: {zone:1435} (200-210) cont."] = "{object:2043} : {zone:1435} (200-210), suite",
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45."] = "Cueillez sur votre passage chaque {item:3356} (125, vert), {item:3357} (150, vert), {item:3818} (160, jaune), {item:3821} (170, jaune), {object:2043} (185, orange) et faites le tour des points de passage jusqu'à {skill:182} 210. Niveau de la zone : 35-45.",

	-- Step 24: Firebloom & Purple Lotus: Badlands (210-230)
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick every {object:1623} (115, green), {item:3356} (125, green), {item:3818} (160, green), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:4625} (205, orange), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. Zone level 35-45."] = "Cueillez sur votre passage chaque {object:1623} (115, vert), {item:3356} (125, vert), {item:3818} (160, vert), {item:3821} (170, jaune), {object:2043} (185, jaune), {item:4625} (205, orange), {item:8831} (210, orange) et faites le tour des points de passage jusqu'à {skill:182} 230. Niveau de la zone : 35-45.",

	-- Step 25: Sungrass & Gromsblood: Blasted Lands (230-260)
	-- {item:4625} Firebloom · {item:8838} Sungrass · {item:8846} Gromsblood · {skill:182} Herbalism
	["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "Cueillez sur votre passage chaque {item:4625} (205, jaune), {item:8838} (230, orange), {item:8846} (dès 250) et faites le tour des points de passage jusqu'à {skill:182} 260. Niveau de la zone : 45-55.",

	-- Step 26: Dreamfoil & Mountain Silversage: Felwood (260-285)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {skill:182} Herbalism
	["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "Cueillez sur votre passage chaque {item:8836} (220, jaune), {item:8838} (230, jaune), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (dès 270), {item:13465} (dès 280) et faites le tour des points de passage jusqu'à {skill:182} 285. Niveau de la zone : 48-55.",

	-- Step 27: Mountain Silversage & Plaguebloom: Felwood (285-300)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "Cueillez sur votre passage chaque {item:8836} (220, vert), {item:8838} (230, vert), {item:8846} (250, jaune), {item:13464} (260, jaune), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) et faites le tour des points de passage jusqu'à {skill:182} 300. Niveau de la zone : 48-55.",
}
