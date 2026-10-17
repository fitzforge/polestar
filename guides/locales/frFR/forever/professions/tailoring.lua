-- French (frFR): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Tailoring
	-- {skill:197} Tailoring
	["Apprentice {skill:197}"] = "{skill:197} (apprenti)",
	-- {skill:197} Tailoring
	["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (les plafonds Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 1g 8s au total.",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le laissent tomber au lieu de farm que Polestar choisit selon votre niveau et votre faction. L'hôtel des ventes convient aussi.",

	-- Step 3: Simple Linen Pants to 50
	-- {item:10045} Simple Linen Pants
	["{item:10045} to 50"] = "{item:10045} jusqu'à 50",
	["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Orange (un point à chaque fabrication) jusqu'à 40, jaune jusqu'à 50, vert jusqu'à 60.",

	-- Step 4: Tailoring recipes at 50
	-- {skill:197} Tailoring
	["{skill:197} recipes at 50"] = "Recettes de {skill:197} à 50",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Retournez voir un maître en {skill:197} : {spell:8776} s'apprend à partir de {skill:197} 50.",

	-- Step 5: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} jusqu'à 75",
	["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Jaune jusqu'à 67, vert jusqu'à 85 : chaque fabrication ne donne pas un point. 75 est le plafond d'Apprenti.",

	-- Step 6: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} (compagnon)",
	-- {skill:197} Tailoring
	["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Compagnon nécessite le niveau 10 et {skill:197} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 17g au total.",

	-- Step 8: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Alliance)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Les {npc:98} (niveau 17-18) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 9: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Les {npc:3263} (niveau 19-20) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 10: Tailoring materials for 75-150
	-- {skill:197} Tailoring
	["{skill:197} materials for 75-150"] = "Composants de {skill:197} pour 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Dépecés, désenchantés ou fabriqués par un autre métier : récoltez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- {skill:171} Alchemy · {item:3383} Elixir of Wisdom
	["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171} : {item:3383} (ou l'hôtel des ventes)",

	-- Step 11: Linen Belt to 80
	-- {item:7026} Linen Belt
	["{item:7026} to 80"] = "{item:7026} jusqu'à 80",
	["Yellow until 67, green until 85: not every craft gives a point."] = "Jaune jusqu'à 67, vert jusqu'à 85 : chaque fabrication ne donne pas un point.",

	-- Step 12: Tailoring recipes at 80
	-- {skill:197} Tailoring
	["{skill:197} recipes at 80"] = "Recettes de {skill:197} à 80",
	-- {skill:197} Tailoring · {spell:2402} Woolen Cape
	["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Retournez voir un maître en {skill:197} : {spell:2402} s'apprend à partir de {skill:197} 80.",

	-- Step 13: Woolen Cape to 110
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 110"] = "{spell:2402} jusqu'à 110",
	["Yellow until 97, green until 115: not every craft gives a point."] = "Jaune jusqu'à 97, vert jusqu'à 115 : chaque fabrication ne donne pas un point.",

	-- Step 14: Tailoring recipes at 110
	-- {skill:197} Tailoring
	["{skill:197} recipes at 110"] = "Recettes de {skill:197} à 110",
	-- {skill:197} Tailoring · {spell:3848} Double-stitched Woolen Shoulders
	["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Retournez voir un maître en {skill:197} : {spell:3848} s'apprend à partir de {skill:197} 110.",

	-- Step 15: Double-stitched Woolen Shoulders to 125
	-- {spell:3848} Double-stitched Woolen Shoulders
	["{spell:3848} to 125"] = "{spell:3848} jusqu'à 125",
	["Yellow until 127, green until 145: not every craft gives a point."] = "Jaune jusqu'à 127, vert jusqu'à 145 : chaque fabrication ne donne pas un point.",

	-- Step 16: Tailoring recipes at 125
	-- {skill:197} Tailoring
	["{skill:197} recipes at 125"] = "Recettes de {skill:197} à 125",
	-- {skill:197} Tailoring · {spell:3852} Gloves of Meditation
	["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Retournez voir un maître en {skill:197} : {spell:3852} s'apprend à partir de {skill:197} 125.",

	-- Step 17: Gloves of Meditation to 150
	-- {spell:3852} Gloves of Meditation
	["{spell:3852} to 150"] = "{spell:3852} jusqu'à 150",
	-- {skill:197} Tailoring
	["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Jaune jusqu'à 140, vert jusqu'à 155 : chaque fabrication ne donne pas un point. {skill:197} 150 est un palier du système d'Héritage.",

	-- Step 18: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} (expert)",
	-- {skill:197} Tailoring
	["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Expert nécessite le niveau 20 et {skill:197} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 135g au total.",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7053} Azure Silk Cloak · {skill:197} Tailoring
	["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Apprend {item:7053} (nécessite {skill:197} 140). Les marchands la vendent en stock limité qui se renouvelle.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Alliance)",
	-- {npc:6006} Shadowsworn Adept
	["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Les {npc:6006} (niveau 52-53) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horde)",
	-- {npc:5472} Dunemaul Enforcer
	["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Les {npc:5472} (niveau 46-47) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 23: Azure Silk Cloak to 180
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 180"] = "{item:7053} jusqu'à 180",
	["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Orange (un point à chaque fabrication) jusqu'à 160, jaune jusqu'à 175, vert jusqu'à 190.",
	["from the recipe in your bags"] = "avec la recette dans vos sacs",

	-- Step 24: Tailoring recipes at 180
	-- {skill:197} Tailoring
	["{skill:197} recipes at 180"] = "Recettes de {skill:197} à 180",
	-- {skill:197} Tailoring · {spell:8799} Crimson Silk Pantaloons
	["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Retournez voir un maître en {skill:197} : {spell:8799} s'apprend à partir de {skill:197} 180.",

	-- Step 25: Crimson Silk Pantaloons to 185
	-- {item:7062} Crimson Silk Pantaloons
	["{item:7062} to 185"] = "{item:7062} jusqu'à 185",
	["Yellow until 190, green until 200: not every craft gives a point."] = "Jaune jusqu'à 190, vert jusqu'à 200 : chaque fabrication ne donne pas un point.",

	-- Step 26: Tailoring recipes at 185
	-- {skill:197} Tailoring
	["{skill:197} recipes at 185"] = "Recettes de {skill:197} à 185",
	-- {skill:197} Tailoring · {spell:12048} Black Mageweave Vest
	["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Retournez voir un maître en {skill:197} : {spell:12048} s'apprend à partir de {skill:197} 185.",

	-- Step 27: Black Mageweave Vest to 205
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 205"] = "{item:9998} jusqu'à 205",
	["Yellow until 200, green until 215: not every craft gives a point."] = "Jaune jusqu'à 200, vert jusqu'à 215 : chaque fabrication ne donne pas un point.",

	-- Step 28: Tailoring recipes at 205
	-- {skill:197} Tailoring
	["{skill:197} recipes at 205"] = "Recettes de {skill:197} à 205",
	-- {skill:197} Tailoring · {spell:12072} Black Mageweave Headband
	["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Retournez voir un maître en {skill:197} : {spell:12072} s'apprend à partir de {skill:197} 205.",

	-- Step 29: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} jusqu'à 225",
	-- {skill:197} Tailoring
	["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Jaune jusqu'à 220, vert jusqu'à 235 : chaque fabrication ne donne pas un point. {skill:197} 225 est un palier du système d'Héritage.",

	-- Step 30: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} (artisan)",
	-- {skill:197} Tailoring
	["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Artisan nécessite le niveau 35 et {skill:197} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 845g au total.",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:13863} Runecloth Gloves · {skill:197} Tailoring
	["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Apprend {item:13863} (nécessite {skill:197} 230). Les marchands la vendent en stock limité qui se renouvelle.",

	-- Step 32: Pattern: Runecloth Cuffs
	-- {item:254123} Runecloth Cuffs · {skill:197} Tailoring
	["Teaches {item:254123} (needs {skill:197} 250)."] = "Apprend {item:254123} (nécessite {skill:197} 250).",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alliance)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:1815}, {npc:1816}, {npc:1817} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",

	-- Step 35: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alliance)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Les {npc:7027} (niveau 56-57) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 36: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Les {npc:6189} (niveau 51-52) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 37: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Alliance)",
	-- {npc:1824} Plague Lurker
	["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Les {npc:1824} (niveau 54-55) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 38: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horde)",
	-- {npc:11739} Rock Stalker
	["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Les {npc:11739} (niveau 57-59) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 39: Runecloth Belt to 236
	-- {item:13856} Runecloth Belt
	["{item:13856} to 236"] = "{item:13856} jusqu'à 236",
	["Yellow until 240, green until 255: not every craft gives a point."] = "Jaune jusqu'à 240, vert jusqu'à 255 : chaque fabrication ne donne pas un point.",

	-- Step 40: Runecloth Gloves to 251
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 251"] = "{item:13863} jusqu'à 251",
	["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Orange (un point à chaque fabrication) jusqu'à 245, jaune jusqu'à 260, vert jusqu'à 275.",

	-- Step 41: Runecloth Cuffs to 295
	-- {item:254123} Runecloth Cuffs
	["{item:254123} to 295"] = "{item:254123} jusqu'à 295",
	["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Orange (un point à chaque fabrication) jusqu'à 265, jaune jusqu'à 280, vert jusqu'à 295.",

	-- Step 42: Tailoring 295-300
	-- {skill:197} Tailoring · {item:14342} Mooncloth · {item:14137} Mooncloth Leggings · {item:279943} Spinning Wheel · {item:14155} Mooncloth Bag · {item:14128} Wizardweave Robe · {item:19047} Wisdom of the Timbermaw
	["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "Sur Forever, aucune recette enseignée par un maître ou vendue par les marchands des deux factions ne donne de points de {skill:197} après 295 : Polestar n'a donc pas de trajet pour les derniers points. Recettes qui en donnent encore : {item:14342} (nécessite un Puits de lune), {item:14137} (nécessite un {item:279943}), {item:14155} (recette obtenue sur un monstre), {item:14128} (recette obtenue sur un monstre), {item:19047} (nécessite un {item:279943}).",
}
