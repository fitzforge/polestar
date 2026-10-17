-- Portuguese (Brazil) (ptBR): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "Aprenda {skill:182}",
	-- {skill:182} Herbalism
	["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "Qualquer instrutor de {skill:182} da sua facção ensina {skill:182} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo.",

	-- Step 2: Silverleaf & Earthroot: Elwynn Forest (1-50)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10."] = "Colha todo {item:2447} (1, laranja), {item:765} (1, laranja), {item:2449} (a partir de 15) que encontrar e percorra os pontos de rota até {skill:182} 50. Nível da zona 1-10.",

	-- Step 8: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "{skill:182} (Profissional)",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10. A seta escolhe o instrutor de {skill:182} da sua facção mais próximo.",

	-- Step 9: Briarthorn & Stranglekelp: Westfall (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Colha todo {item:2447} (1, amarelo), {item:765} (1, amarelo), {item:2449} (15, amarelo), {item:785} (50, laranja), {item:2450} (a partir de 70), {item:3820} (a partir de 85) que encontrar e percorra os pontos de rota até {skill:182} 100. Nível da zona 10-20.",

	-- Step 10: Mageroyal & Briarthorn: Loch Modan (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Colha todo {item:2447} (1, amarelo), {item:765} (1, amarelo), {item:2449} (15, amarelo), {item:785} (50, laranja), {item:2450} (a partir de 70) que encontrar e percorra os pontos de rota até {skill:182} 100. Nível da zona 10-20.",

	-- Step 12: Briarthorn & Stranglekelp: The Barrens (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-25."] = "Colha todo {item:2447} (1, amarelo), {item:765} (1, amarelo), {item:2449} (15, amarelo), {item:785} (50, laranja), {item:2450} (a partir de 70), {item:3820} (a partir de 85) que encontrar e percorra os pontos de rota até {skill:182} 100. Nível da zona 10-25.",

	-- Step 14: Bruiseweed: Redridge Mountains (100-125)
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. Zone level 15-25."] = "Colha todo {item:2447} (1, verde), {item:2449} (15, verde), {item:785} (50, verde), {item:2450} (70, amarelo), {item:2453} (100, laranja) que encontrar e percorra os pontos de rota até {skill:182} 125. Nível da zona 15-25.",

	-- Step 15: Bruiseweed & Wild Steelbloom: Thousand Needles (100-125)
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 25-35."] = "Colha todo {item:2453} (100, laranja), {object:1623} (a partir de 115) que encontrar e percorra os pontos de rota até {skill:182} 125. Nível da zona 25-35.",

	-- Step 16: Bruiseweed & Wild Steelbloom: Hillsbrad Foothills (100-125)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "Colha todo {item:2447} (1, verde), {item:765} (1, verde), {item:2449} (15, verde), {item:785} (50, verde), {item:2450} (70, amarelo), {item:3820} (85, laranja), {item:2453} (100, laranja), {object:1623} (a partir de 115) que encontrar e percorra os pontos de rota até {skill:182} 125. Nível da zona 20-30.",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "{skill:182} (Perito)",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Perito) eleva o limite para 225; exige perícia 125 e nível de personagem 20. A seta escolhe o instrutor de {skill:182} da sua facção mais próximo.",

	-- Step 18: Grave Moss & Kingsblood: Duskwood (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "Colha todo {item:785} (50, verde), {item:2450} (70, verde), {item:2453} (100, amarelo), {object:1623} (115, laranja), {object:1628} (120, laranja), {item:3356} (125, laranja) que encontrar e percorra os pontos de rota até {skill:182} 160. Nível da zona 18-30.",

	-- Step 19: Kingsblood & Liferoot: Alterac Mountains (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "Colha todo {item:785} (50, verde), {item:2450} (70, verde), {item:3820} (85, amarelo), {item:2453} (100, amarelo), {object:1623} (115, laranja), {object:1628} (120, laranja), {item:3356} (125, laranja), {item:3357} (a partir de 150) que encontrar e percorra os pontos de rota até {skill:182} 160. Nível da zona 30-40.",

	-- Step 20: Fadeleaf & Goldthorn: Swamp of Sorrows (160-185)
	-- {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. Zone level 35-45."] = "Colha todo {item:3820} (85, verde), {item:3356} (125, amarelo), {item:3357} (150, laranja), {item:3818} (160, laranja), {item:3821} (a partir de 170) que encontrar e percorra os pontos de rota até {skill:182} 185. Nível da zona 35-45.",

	-- Step 21: Goldthorn & Khadgar's Whisker: Swamp of Sorrows (185-200)
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45."] = "Colha todo {item:3356} (125, verde), {item:3357} (150, amarelo), {item:3818} (160, amarelo), {item:3821} (170, laranja), {object:2043} (185, laranja) que encontrar e percorra os pontos de rota até {skill:182} 200. Nível da zona 35-45.",

	-- Step 22: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "{skill:182} (Artífice)",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} Artífice eleva o limite para 300; requer perícia 200 e nível de personagem 35. A seta escolhe o instrutor de {skill:182} mais próximo da sua facção.",

	-- Step 23: Khadgar's Whisker: Swamp of Sorrows (200-210) cont.
	-- {object:2043} Khadgar's Whisker · {zone:1435} Swamp of Sorrows
	["{object:2043}: {zone:1435} (200-210) cont."] = "{object:2043}: {zone:1435} (200-210) cont.",
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45."] = "Colete cada {item:3356} (125, verde), {item:3357} (150, verde), {item:3818} (160, amarelo), {item:3821} (170, amarelo), {object:2043} (185, laranja) pelo caminho e percorra os pontos de rota até {skill:182} 210. Zona de nível 35-45.",

	-- Step 24: Firebloom & Purple Lotus: Badlands (210-230)
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick every {object:1623} (115, green), {item:3356} (125, green), {item:3818} (160, green), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:4625} (205, orange), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. Zone level 35-45."] = "Colete cada {object:1623} (115, verde), {item:3356} (125, verde), {item:3818} (160, verde), {item:3821} (170, amarelo), {object:2043} (185, amarelo), {item:4625} (205, laranja), {item:8831} (210, laranja) pelo caminho e percorra os pontos de rota até {skill:182} 230. Zona de nível 35-45.",

	-- Step 25: Sungrass & Gromsblood: Blasted Lands (230-260)
	-- {item:4625} Firebloom · {item:8838} Sungrass · {item:8846} Gromsblood · {skill:182} Herbalism
	["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "Colete cada {item:4625} (205, amarelo), {item:8838} (230, laranja), {item:8846} (a partir de 250) pelo caminho e percorra os pontos de rota até {skill:182} 260. Zona de nível 45-55.",

	-- Step 26: Dreamfoil & Mountain Silversage: Felwood (260-285)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {skill:182} Herbalism
	["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "Colete cada {item:8836} (220, amarelo), {item:8838} (230, amarelo), {item:8846} (250, laranja), {item:13464} (260, laranja), {item:13463} (a partir de 270), {item:13465} (a partir de 280) pelo caminho e percorra os pontos de rota até {skill:182} 285. Zona de nível 48-55.",

	-- Step 27: Mountain Silversage & Plaguebloom: Felwood (285-300)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "Colete cada {item:8836} (220, verde), {item:8838} (230, verde), {item:8846} (250, amarelo), {item:13464} (260, amarelo), {item:13463} (270, laranja), {item:13465} (280, laranja), {item:13466} (285, laranja) pelo caminho e percorra os pontos de rota até {skill:182} 300. Zona de nível 48-55.",
}
