-- French (frFR): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Alchemy
	-- {skill:171} Alchemy
	["Apprentice {skill:171}"] = "{skill:171} (Apprenti)",
	-- {skill:171} Alchemy
	["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "L'{skill:171} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (plafonds de Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 68s au total.",

	-- Step 2: Silverleaf (Alliance)
	-- {item:765} Silverleaf
	["{item:765} (Alliance)"] = "{item:765} (Alliance)",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:765} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 3: Silverleaf (Horde)
	-- {item:765} Silverleaf
	["{item:765} (Horde)"] = "{item:765} (Horde)",

	-- Step 4: Peacebloom (Alliance)
	-- {item:2447} Peacebloom
	["{item:2447} (Alliance)"] = "{item:2447} (Alliance)",
	-- {item:2447} Peacebloom · {skill:182} Herbalism
	["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2447} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 5: Peacebloom (Horde)
	-- {item:2447} Peacebloom
	["{item:2447} (Horde)"] = "{item:2447} (Horde)",

	-- Step 6: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} jusqu'à 75",
	["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Orange (un point à chaque fabrication) jusqu'à 55, jaune jusqu'à 75, vert jusqu'à 95. 75 est le plafond d'Apprenti.",

	-- Step 7: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "{skill:171} (Compagnon)",
	-- {skill:171} Alchemy
	["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Compagnon requiert le niveau 10 et {skill:171} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 1g 44s au total.",

	-- Step 8: Recipe: Holy Protection Potion
	-- {item:6051} Holy Protection Potion · {skill:171} Alchemy
	["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Apprend {item:6051} (requiert {skill:171} 100). Les marchands la vendent en stock limité qui se renouvelle.",

	-- Step 9: Murloc Eye (Alliance)
	-- {item:730} Murloc Eye
	["{item:730} (Alliance)"] = "{item:730} (Alliance)",
	-- {npc:513} Murloc Netter
	["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "Les {npc:513} (niveau 14-15) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 10: Murloc Eye (Horde)
	-- {item:730} Murloc Eye
	["{item:730} (Horde)"] = "{item:730} (Horde)",
	-- {npc:1958} Vile Fin Tidecaller
	["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "Les {npc:1958} (niveau 17-18) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 11: Mageroyal (Alliance)
	-- {item:785} Mageroyal
	["{item:785} (Alliance)"] = "{item:785} (Alliance)",
	-- {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:785} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 12: Mageroyal (Horde)
	-- {item:785} Mageroyal
	["{item:785} (Horde)"] = "{item:785} (Horde)",

	-- Step 15: Briarthorn (Alliance)
	-- {item:2450} Briarthorn
	["{item:2450} (Alliance)"] = "{item:2450} (Alliance)",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2450} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 16: Briarthorn (Horde)
	-- {item:2450} Briarthorn
	["{item:2450} (Horde)"] = "{item:2450} (Horde)",

	-- Step 17: Swiftthistle (Alliance)
	-- {item:2452} Swiftthistle
	["{item:2452} (Alliance)"] = "{item:2452} (Alliance)",
	-- {item:2452} Swiftthistle · {item:2450} Briarthorn · {skill:182} Herbalism
	["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} s'obtient sur les plantes d'{item:2450} ({skill:182}) ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 18: Swiftthistle (Horde)
	-- {item:2452} Swiftthistle
	["{item:2452} (Horde)"] = "{item:2452} (Horde)",

	-- Step 19: Bruiseweed (Alliance)
	-- {item:2453} Bruiseweed
	["{item:2453} (Alliance)"] = "{item:2453} (Alliance)",
	-- {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:2453} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 20: Bruiseweed (Horde)
	-- {item:2453} Bruiseweed
	["{item:2453} (Horde)"] = "{item:2453} (Horde)",

	-- Step 21: Minor Mana Potion to 85
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 85"] = "{spell:2331} jusqu'à 85",
	["Yellow until 85, green until 105: not every craft gives a point."] = "Jaune jusqu'à 85, vert jusqu'à 105 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 22: Alchemy recipes at 85
	-- {skill:171} Alchemy
	["{skill:171} recipes at 85"] = "Recettes d'{skill:171} à 85",
	-- {skill:171} Alchemy · {spell:1244645} Lesser Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Retournez voir un maître en {skill:171} : {spell:1244645} s'apprend à partir de {skill:171} 85.",

	-- Step 23: Lesser Discolored Healing Potion to 100
	-- {item:247239} Lesser Discolored Healing Potion
	["{item:247239} to 100"] = "{item:247239} jusqu'à 100",
	["Yellow until 105, green until 125: not every craft gives a point."] = "Jaune jusqu'à 105, vert jusqu'à 125 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 24: Holy Protection Potion to 150
	-- {item:6051} Holy Protection Potion
	["{item:6051} to 150"] = "{item:6051} jusqu'à 150",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 130, jaune jusqu'à 150, vert jusqu'à 170. {skill:171} 150 est un palier du système d'Héritage.",
	["from the recipe in your bags"] = "avec la recette dans vos sacs",

	-- Step 25: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "{skill:171} (Expert)",
	-- {skill:171} Alchemy
	["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Expert requiert le niveau 20 et {skill:171} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 3g 65s au total.",

	-- Step 26: Murloc Eye
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le laissent tomber à l'endroit choisi par Polestar selon votre niveau et votre faction. L'hôtel des ventes convient aussi.",

	-- Step 27: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Alliance)",
	-- {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {object:1623} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 28: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Horde)",

	-- Step 29: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Alliance)",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3356} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 30: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Horde)",

	-- Step 31: Liferoot (Alliance)
	-- {item:3357} Liferoot
	["{item:3357} (Alliance)"] = "{item:3357} (Alliance)",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3357} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 32: Liferoot (Horde)
	-- {item:3357} Liferoot
	["{item:3357} (Horde)"] = "{item:3357} (Horde)",

	-- Step 33: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Alliance)",
	-- {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {object:2046} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 34: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Horde)",

	-- Step 35: Oily Blackmouth (Alliance)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Alliance)"] = "{item:6358} (Alliance)",
	-- {object:180582} Oily Blackmouth School
	["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180582} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",

	-- Step 36: Oily Blackmouth (Horde)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Horde)"] = "{item:6358} (Horde)",

	-- Step 37: Firefin Snapper (Alliance)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Alliance)"] = "{item:6359} (Alliance)",
	-- {object:180657} Firefin Snapper School
	["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180657} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",

	-- Step 38: Firefin Snapper (Horde)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Horde)"] = "{item:6359} (Horde)",

	-- Step 39: Fire Oil to 165
	-- {item:6371} Fire Oil
	["{item:6371} to 165"] = "{item:6371} jusqu'à 165",
	["Yellow until 160, green until 170: not every craft gives a point."] = "Jaune jusqu'à 160, vert jusqu'à 170 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 40: Alchemy recipes at 165
	-- {skill:171} Alchemy
	["{skill:171} recipes at 165"] = "Recettes d'{skill:171} à 165",
	-- {skill:171} Alchemy · {spell:7845} Elixir of Fire Power
	["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Retournez voir un maître en {skill:171} : {spell:7845} s'apprend à partir de {skill:171} 165.",

	-- Step 41: Elixir of Fire Power to 175
	-- {spell:7845} Elixir of Fire Power
	["{spell:7845} to 175"] = "{spell:7845} jusqu'à 175",
	["Yellow until 185, green until 205: not every craft gives a point."] = "Jaune jusqu'à 185, vert jusqu'à 205 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 42: Alchemy recipes at 175
	-- {skill:171} Alchemy
	["{skill:171} recipes at 175"] = "Recettes d'{skill:171} à 175",
	-- {skill:171} Alchemy · {spell:1244647} Greater Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Retournez voir un maître en {skill:171} : {spell:1244647} s'apprend à partir de {skill:171} 175.",

	-- Step 43: Greater Discolored Healing Potion to 200
	-- {item:247241} Greater Discolored Healing Potion
	["{item:247241} to 200"] = "{item:247241} jusqu'à 200",
	["Yellow until 195, green until 215: not every craft gives a point."] = "Jaune jusqu'à 195, vert jusqu'à 215 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 44: Alchemy recipes at 200
	-- {skill:171} Alchemy
	["{skill:171} recipes at 200"] = "Recettes d'{skill:171} à 200",
	-- {skill:171} Alchemy · {spell:11447} Draught of Water Walking
	["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Retournez voir un maître en {skill:171} : {spell:11447} s'apprend à partir de {skill:171} 190.",

	-- Step 45: Draught of Water Walking to 215
	-- {spell:11447} Draught of Water Walking
	["{spell:11447} to 215"] = "{spell:11447} jusqu'à 215",
	["Yellow until 210, green until 230: not every craft gives a point."] = "Jaune jusqu'à 210, vert jusqu'à 230 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 46: Alchemy recipes at 215
	-- {skill:171} Alchemy
	["{skill:171} recipes at 215"] = "Recettes d'{skill:171} à 215",
	-- {skill:171} Alchemy · {spell:11450} Elixir of Defense
	["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Retournez voir un maître en {skill:171} : {spell:11450} s'apprend à partir de {skill:171} 215.",

	-- Step 47: Elixir of Defense to 225
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 225"] = "{spell:11450} jusqu'à 225",
	-- {skill:171} Alchemy
	["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Jaune jusqu'à 235, vert jusqu'à 255 : chaque fabrication ne rapporte pas forcément un point. {skill:171} 225 est un palier du système d'Héritage.",

	-- Step 48: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "{skill:171} (Artisan)",
	-- {skill:171} Alchemy
	["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Artisan requiert le niveau 35 et {skill:171} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 7g 80s au total.",

	-- Step 49: Recipe: Elixir of Superior Defense
	-- {item:8951} Elixir of Greater Defense · {skill:171} Alchemy
	["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Apprend {item:8951} (requiert {skill:171} 265). Les marchands la vendent en stock limité qui se renouvelle ; l'hôtel des ventes en a souvent aussi.",

	-- Step 55: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Alliance)",
	-- {item:8836} Arthas' Tears · {skill:182} Herbalism
	["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:8836} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 56: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Horde)",

	-- Step 57: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Alliance)",
	-- {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:8838} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",

	-- Step 58: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Horde)",

	-- Step 59: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Alliance)",
	-- {object:180712} Stonescale Eel Swarm
	["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Pêchez au {object:180712} ; c'est ici que les données en recensent le plus. L'hôtel des ventes convient aussi.",

	-- Step 60: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Horde)",

	-- Step 61: Elixir of Defense to 230
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 230"] = "{spell:11450} jusqu'à 230",
	["Yellow until 235, green until 255: not every craft gives a point."] = "Jaune jusqu'à 235, vert jusqu'à 255 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 62: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "Recettes d'{skill:171} à 230",
	-- {skill:171} Alchemy · {spell:1244648} Superior Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Retournez voir un maître en {skill:171} : {spell:1244648} s'apprend à partir de {skill:171} 230.",

	-- Step 63: Superior Discolored Healing Potion to 250
	-- {item:247242} Superior Discolored Healing Potion
	["{item:247242} to 250"] = "{item:247242} jusqu'à 250",
	["Yellow until 250, green until 270: not every craft gives a point."] = "Jaune jusqu'à 250, vert jusqu'à 270 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 64: Alchemy recipes at 250
	-- {skill:171} Alchemy
	["{skill:171} recipes at 250"] = "Recettes d'{skill:171} à 250",
	-- {skill:171} Alchemy · {spell:17551} Stonescale Oil
	["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Retournez voir un maître en {skill:171} : {spell:17551} s'apprend à partir de {skill:171} 250.",

	-- Step 65: Stonescale Oil to 259
	-- {item:13423} Stonescale Oil
	["{item:13423} to 259"] = "{item:13423} jusqu'à 259",
	["Yellow until 255, green until 260: not every craft gives a point."] = "Jaune jusqu'à 255, vert jusqu'à 260 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 66: Alchemy recipes at 259
	-- {skill:171} Alchemy
	["{skill:171} recipes at 259"] = "Recettes d'{skill:171} à 259",
	-- {skill:171} Alchemy · {spell:11460} Draught of Detect Undead
	["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Retournez voir un maître en {skill:171} : {spell:11460} s'apprend à partir de {skill:171} 245.",

	-- Step 67: Draught of Detect Undead to 265
	-- {spell:11460} Draught of Detect Undead
	["{spell:11460} to 265"] = "{spell:11460} jusqu'à 265",
	["Yellow until 265, green until 285: not every craft gives a point."] = "Jaune jusqu'à 265, vert jusqu'à 285 : chaque fabrication ne rapporte pas forcément un point.",

	-- Step 68: Elixir of Greater Defense to 300
	-- {spell:17554} Elixir of Greater Defense
	["{spell:17554} to 300"] = "{spell:17554} jusqu'à 300",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 280, jaune jusqu'à 300, vert jusqu'à 320. {skill:171} 300 est un palier du système d'Héritage.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3355} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:3821} avec {skill:182} ; c'est la zone la plus dense selon les données. L'hôtel des ventes convient aussi.",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Alliance)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Horde)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Alliance)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Horde)",
}
