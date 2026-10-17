-- Chinese (traditional) (zhTW): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "學習{skill:182}",
	-- {skill:182} Herbalism
	["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "你陣營的任何{skill:182}訓練師都能教初級{skill:182}（角色等級5）；箭頭會指向最近的一位。",

	-- Step 2: Silverleaf & Earthroot: Elwynn Forest (1-50)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10."] = "採集沿途經過的每一株{item:2447}（1，橙色）、{item:765}（1，橙色）、{item:2449}（15起），並繞著路徑點循環，直到{skill:182}50。地區等級1-10。",

	-- Step 8: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "中級{skill:182}",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "中級{skill:182}將上限提高至150；需要技能50且角色等級10。箭頭會指向你陣營最近的{skill:182}訓練師。",

	-- Step 9: Briarthorn & Stranglekelp: Westfall (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "採集沿途經過的每一株{item:2447}（1，黃色）、{item:765}（1，黃色）、{item:2449}（15，黃色）、{item:785}（50，橙色）、{item:2450}（70起）、{item:3820}（85起），並繞著路徑點循環，直到{skill:182}100。地區等級10-20。",

	-- Step 10: Mageroyal & Briarthorn: Loch Modan (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "採集沿途經過的每一株{item:2447}（1，黃色）、{item:765}（1，黃色）、{item:2449}（15，黃色）、{item:785}（50，橙色）、{item:2450}（70起），並繞著路徑點循環，直到{skill:182}100。地區等級10-20。",

	-- Step 12: Briarthorn & Stranglekelp: The Barrens (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-25."] = "採集沿途經過的每一株{item:2447}（1，黃色）、{item:765}（1，黃色）、{item:2449}（15，黃色）、{item:785}（50，橙色）、{item:2450}（70起）、{item:3820}（85起），並繞著路徑點循環，直到{skill:182}100。地區等級10-25。",

	-- Step 14: Bruiseweed: Redridge Mountains (100-125)
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. Zone level 15-25."] = "採集沿途經過的每一株{item:2447}（1，綠色）、{item:2449}（15，綠色）、{item:785}（50，綠色）、{item:2450}（70，黃色）、{item:2453}（100，橙色），並繞著路徑點循環，直到{skill:182}125。地區等級15-25。",

	-- Step 15: Bruiseweed & Wild Steelbloom: Thousand Needles (100-125)
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 25-35."] = "採集沿途經過的每一株{item:2453}（100，橙色）、{object:1623}（115起），並繞著路徑點循環，直到{skill:182}125。地區等級25-35。",

	-- Step 16: Bruiseweed & Wild Steelbloom: Hillsbrad Foothills (100-125)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "採集沿途經過的每一株{item:2447}（1，綠色）、{item:765}（1，綠色）、{item:2449}（15，綠色）、{item:785}（50，綠色）、{item:2450}（70，黃色）、{item:3820}（85，橙色）、{item:2453}（100，橙色）、{object:1623}（115起），並繞著路徑點循環，直到{skill:182}125。地區等級20-30。",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "高級{skill:182}",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:182} trainer of your faction."] = "高級{skill:182}將上限提高至225；需要技能125且角色等級20。箭頭會指向你陣營最近的{skill:182}訓練師。",

	-- Step 18: Grave Moss & Kingsblood: Duskwood (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "採集沿途經過的每一株{item:785}（50，綠色）、{item:2450}（70，綠色）、{item:2453}（100，黃色）、{object:1623}（115，橙色）、{object:1628}（120，橙色）、{item:3356}（125，橙色），並繞著路徑點循環，直到{skill:182}160。地區等級18-30。",

	-- Step 19: Kingsblood & Liferoot: Alterac Mountains (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "採集沿途經過的每一株{item:785}（50，綠色）、{item:2450}（70，綠色）、{item:3820}（85，黃色）、{item:2453}（100，黃色）、{object:1623}（115，橙色）、{object:1628}（120，橙色）、{item:3356}（125，橙色）、{item:3357}（150起），並繞著路徑點循環，直到{skill:182}160。地區等級30-40。",

	-- Step 20: Fadeleaf & Goldthorn: Swamp of Sorrows (160-185)
	-- {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. Zone level 35-45."] = "採集沿途經過的每一株{item:3820}（85，綠色）、{item:3356}（125，黃色）、{item:3357}（150，橙色）、{item:3818}（160，橙色）、{item:3821}（170起），並繞著路徑點循環，直到{skill:182}185。地區等級35-45。",

	-- Step 21: Goldthorn & Khadgar's Whisker: Swamp of Sorrows (185-200)
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45."] = "採集沿途經過的每一株{item:3356}（125，綠色）、{item:3357}（150，黃色）、{item:3818}（160，黃色）、{item:3821}（170，橙色）、{object:2043}（185，橙色），並繞著路徑點循環，直到{skill:182}200。地區等級35-45。",

	-- Step 22: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "專家級{skill:182}",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:182} trainer of your faction."] = "專家級{skill:182}將上限提高至300；需要技能200且角色等級35。箭頭會指向你陣營最近的{skill:182}訓練師。",

	-- Step 23: Khadgar's Whisker: Swamp of Sorrows (200-210) cont.
	-- {object:2043} Khadgar's Whisker · {zone:1435} Swamp of Sorrows
	["{object:2043}: {zone:1435} (200-210) cont."] = "{object:2043}：{zone:1435}（200-210）（續）",
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45."] = "採集沿途經過的每一株{item:3356}（125，綠色）、{item:3357}（150，綠色）、{item:3818}（160，黃色）、{item:3821}（170，黃色）、{object:2043}（185，橙色），並繞著路徑點循環，直到{skill:182}210。地區等級35-45。",

	-- Step 24: Firebloom & Purple Lotus: Badlands (210-230)
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick every {object:1623} (115, green), {item:3356} (125, green), {item:3818} (160, green), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:4625} (205, orange), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. Zone level 35-45."] = "採集沿途經過的每一株{object:1623}（115，綠色）、{item:3356}（125，綠色）、{item:3818}（160，綠色）、{item:3821}（170，黃色）、{object:2043}（185，黃色）、{item:4625}（205，橙色）、{item:8831}（210，橙色），並繞著路徑點循環，直到{skill:182}230。地區等級35-45。",

	-- Step 25: Sungrass & Gromsblood: Blasted Lands (230-260)
	-- {item:4625} Firebloom · {item:8838} Sungrass · {item:8846} Gromsblood · {skill:182} Herbalism
	["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "採集沿途經過的每一株{item:4625}（205，黃色）、{item:8838}（230，橙色）、{item:8846}（250起），並繞著路徑點循環，直到{skill:182}260。地區等級45-55。",

	-- Step 26: Dreamfoil & Mountain Silversage: Felwood (260-285)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {skill:182} Herbalism
	["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "採集沿途經過的每一株{item:8836}（220，黃色）、{item:8838}（230，黃色）、{item:8846}（250，橙色）、{item:13464}（260，橙色）、{item:13463}（270起）、{item:13465}（280起），並繞著路徑點循環，直到{skill:182}285。地區等級48-55。",

	-- Step 27: Mountain Silversage & Plaguebloom: Felwood (285-300)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "採集沿途經過的每一株{item:8836}（220，綠色）、{item:8838}（230，綠色）、{item:8846}（250，黃色）、{item:13464}（260，黃色）、{item:13463}（270，橙色）、{item:13465}（280，橙色）、{item:13466}（285，橙色），並繞著路徑點循環，直到{skill:182}300。地區等級48-55。",
}
