-- German (deDE): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "{skill:182} erlernen",
	-- {skill:182} Herbalism
	["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} at any level, and so does the Junior Herbalism Trainer in each starting zone; the arrow picks the nearest."] = "Jeder Lehrer für {skill:182} deiner Fraktion bringt dir auf jeder Stufe {skill:182} (Lehrling) bei, ebenso der Junior-Lehrer für Kräuterkunde in jedem Startgebiet; der Pfeil wählt den nächsten.",

	-- Step 2: Silverleaf & Earthroot: Elwynn Forest (1-50)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (ab 15) und lauf die Wegpunkte ab, bis {skill:182} 50 erreicht ist. Gebietsstufe 1-10.",

	-- Step 8: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "{skill:182} (Geselle)",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10. Der Pfeil wählt den nächsten Lehrer für {skill:182} deiner Fraktion.",

	-- Step 9: Briarthorn & Stranglekelp: Westfall (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, gelb), {item:765} (1, gelb), {item:2449} (15, gelb), {item:785} (50, orange), {item:2450} (ab 70), {item:3820} (ab 85) und lauf die Wegpunkte ab, bis {skill:182} 100 erreicht ist. Gebietsstufe 10-20.",

	-- Step 10: Mageroyal & Briarthorn: Loch Modan (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, gelb), {item:765} (1, gelb), {item:2449} (15, gelb), {item:785} (50, orange), {item:2450} (ab 70) und lauf die Wegpunkte ab, bis {skill:182} 100 erreicht ist. Gebietsstufe 10-20.",

	-- Step 12: Briarthorn & Stranglekelp: The Barrens (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-25."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, gelb), {item:765} (1, gelb), {item:2449} (15, gelb), {item:785} (50, orange), {item:2450} (ab 70), {item:3820} (ab 85) und lauf die Wegpunkte ab, bis {skill:182} 100 erreicht ist. Gebietsstufe 10-25.",

	-- Step 14: Bruiseweed: Redridge Mountains (100-125)
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. Zone level 15-25."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, grün), {item:2449} (15, grün), {item:785} (50, grün), {item:2450} (70, gelb), {item:2453} (100, orange) und lauf die Wegpunkte ab, bis {skill:182} 125 erreicht ist. Gebietsstufe 15-25.",

	-- Step 15: Bruiseweed & Wild Steelbloom: Thousand Needles (100-125)
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 25-35."] = "Sammle unterwegs jedes Vorkommen von {item:2453} (100, orange), {object:1623} (ab 115) und lauf die Wegpunkte ab, bis {skill:182} 125 erreicht ist. Gebietsstufe 25-35.",

	-- Step 16: Bruiseweed & Wild Steelbloom: Hillsbrad Foothills (100-125)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "Sammle unterwegs jedes Vorkommen von {item:2447} (1, grün), {item:765} (1, grün), {item:2449} (15, grün), {item:785} (50, grün), {item:2450} (70, gelb), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (ab 115) und lauf die Wegpunkte ab, bis {skill:182} 125 erreicht ist. Gebietsstufe 20-30.",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "{skill:182} (Experte)",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Experte) hebt die Obergrenze auf 225; dafür brauchst du Fertigkeit 125 und Charakterstufe 20. Der Pfeil wählt den nächsten Lehrer für {skill:182} deiner Fraktion.",

	-- Step 18: Grave Moss & Kingsblood: Duskwood (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "Sammle unterwegs jedes Vorkommen von {item:785} (50, grün), {item:2450} (70, grün), {item:2453} (100, gelb), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) und lauf die Wegpunkte ab, bis {skill:182} 160 erreicht ist. Gebietsstufe 18-30.",

	-- Step 19: Kingsblood & Liferoot: Alterac Mountains (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "Sammle unterwegs jedes Vorkommen von {item:785} (50, grün), {item:2450} (70, grün), {item:3820} (85, gelb), {item:2453} (100, gelb), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (ab 150) und lauf die Wegpunkte ab, bis {skill:182} 160 erreicht ist. Gebietsstufe 30-40.",

	-- Step 20: Fadeleaf & Goldthorn: Swamp of Sorrows (160-185)
	-- {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. Zone level 35-45."] = "Sammle unterwegs jedes Vorkommen von {item:3820} (85, grün), {item:3356} (125, gelb), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (ab 170) und lauf die Wegpunkte ab, bis {skill:182} 185 erreicht ist. Gebietsstufe 35-45.",

	-- Step 21: Goldthorn & Khadgar's Whisker: Swamp of Sorrows (185-200)
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45."] = "Sammle unterwegs jedes Vorkommen von {item:3356} (125, grün), {item:3357} (150, gelb), {item:3818} (160, gelb), {item:3821} (170, orange), {object:2043} (185, orange) und lauf die Wegpunkte ab, bis {skill:182} 200 erreicht ist. Gebietsstufe 35-45.",

	-- Step 22: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "{skill:182} (Fachmann)",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:182} trainer of your faction."] = "{skill:182} (Fachmann) hebt die Obergrenze auf 300; dafür brauchst du Fertigkeit 200 und Charakterstufe 35. Der Pfeil wählt den nächsten Lehrer für {skill:182} deiner Fraktion.",

	-- Step 23: Khadgar's Whisker: Swamp of Sorrows (200-210) cont.
	-- {object:2043} Khadgar's Whisker · {zone:1435} Swamp of Sorrows
	["{object:2043}: {zone:1435} (200-210) cont."] = "{object:2043}: {zone:1435} (200-210), Fortsetzung",
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45."] = "Sammle unterwegs jedes Vorkommen von {item:3356} (125, grün), {item:3357} (150, grün), {item:3818} (160, gelb), {item:3821} (170, gelb), {object:2043} (185, orange) und lauf die Wegpunkte ab, bis {skill:182} 210 erreicht ist. Gebietsstufe 35-45.",

	-- Step 24: Firebloom & Purple Lotus: Badlands (210-230)
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick every {object:1623} (115, green), {item:3356} (125, green), {item:3818} (160, green), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:4625} (205, orange), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. Zone level 35-45."] = "Sammle unterwegs jedes Vorkommen von {object:1623} (115, grün), {item:3356} (125, grün), {item:3818} (160, grün), {item:3821} (170, gelb), {object:2043} (185, gelb), {item:4625} (205, orange), {item:8831} (210, orange) und lauf die Wegpunkte ab, bis {skill:182} 230 erreicht ist. Gebietsstufe 35-45.",

	-- Step 25: Sungrass & Gromsblood: Blasted Lands (230-260)
	-- {item:4625} Firebloom · {item:8838} Sungrass · {item:8846} Gromsblood · {skill:182} Herbalism
	["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "Sammle unterwegs jedes Vorkommen von {item:4625} (205, gelb), {item:8838} (230, orange), {item:8846} (ab 250) und lauf die Wegpunkte ab, bis {skill:182} 260 erreicht ist. Gebietsstufe 45-55.",

	-- Step 26: Dreamfoil & Mountain Silversage: Felwood (260-285)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {skill:182} Herbalism
	["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "Sammle unterwegs jedes Vorkommen von {item:8836} (220, gelb), {item:8838} (230, gelb), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (ab 270), {item:13465} (ab 280) und lauf die Wegpunkte ab, bis {skill:182} 285 erreicht ist. Gebietsstufe 48-55.",

	-- Step 27: Mountain Silversage & Plaguebloom: Felwood (285-300)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "Sammle unterwegs jedes Vorkommen von {item:8836} (220, grün), {item:8838} (230, grün), {item:8846} (250, gelb), {item:13464} (260, gelb), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) und lauf die Wegpunkte ab, bis {skill:182} 300 erreicht ist. Gebietsstufe 48-55.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "Jeder Lehrer für {skill:182} deiner Fraktion bringt dir {skill:182} (Lehrling) bei (Charakterstufe 5); der Pfeil wählt den nächsten.",
}
