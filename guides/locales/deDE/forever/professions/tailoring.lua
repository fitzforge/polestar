-- German (deDE): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Tailoring
	-- {skill:197} Tailoring
	["Apprentice {skill:197}"] = "{skill:197} (Lehrling)",
	-- {skill:197} Tailoring
	["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 1g 8s wert.",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die ihn fallen lassen, am Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Das Auktionshaus geht auch.",

	-- Step 3: Simple Linen Pants to 50
	-- {item:10045} Simple Linen Pants
	["{item:10045} to 50"] = "{item:10045} bis 50",
	["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Orange (jede Herstellung ein Punkt) bis 40, gelb bis 50, grün bis 60.",

	-- Step 4: Tailoring recipes at 50
	-- {skill:197} Tailoring
	["{skill:197} recipes at 50"] = "Rezepte für {skill:197} bei 50",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Zurück zu einem Lehrer für {skill:197}: {spell:8776} wird ab {skill:197} 50 gelehrt.",

	-- Step 5: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} bis 75",
	["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Gelb bis 67, grün bis 85: Nicht jede Herstellung bringt einen Punkt. 75 ist die Obergrenze für Lehrling.",

	-- Step 6: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} (Geselle)",
	-- {skill:197} Tailoring
	["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Geselle erfordert Charakterstufe 10 und {skill:197} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 17g wert.",

	-- Step 8: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Allianz)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Hier fällt es von {npc:98} (Stufe 17-18). Das Auktionshaus geht auch.",

	-- Step 9: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Hier fällt es von {npc:3263} (Stufe 19-20). Das Auktionshaus geht auch.",

	-- Step 10: Tailoring materials for 75-150
	-- {skill:197} Tailoring
	["{skill:197} materials for 75-150"] = "Materialien für {skill:197} 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- {skill:171} Alchemy · {item:3383} Elixir of Wisdom
	["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (oder das Auktionshaus)",

	-- Step 11: Linen Belt to 80
	-- {item:7026} Linen Belt
	["{item:7026} to 80"] = "{item:7026} bis 80",
	["Yellow until 67, green until 85: not every craft gives a point."] = "Gelb bis 67, grün bis 85: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 12: Tailoring recipes at 80
	-- {skill:197} Tailoring
	["{skill:197} recipes at 80"] = "Rezepte für {skill:197} bei 80",
	-- {skill:197} Tailoring · {spell:2402} Woolen Cape
	["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Zurück zu einem Lehrer für {skill:197}: {spell:2402} wird ab {skill:197} 80 gelehrt.",

	-- Step 13: Woolen Cape to 110
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 110"] = "{spell:2402} bis 110",
	["Yellow until 97, green until 115: not every craft gives a point."] = "Gelb bis 97, grün bis 115: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 14: Tailoring recipes at 110
	-- {skill:197} Tailoring
	["{skill:197} recipes at 110"] = "Rezepte für {skill:197} bei 110",
	-- {skill:197} Tailoring · {spell:3848} Double-stitched Woolen Shoulders
	["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Zurück zu einem Lehrer für {skill:197}: {spell:3848} wird ab {skill:197} 110 gelehrt.",

	-- Step 15: Double-stitched Woolen Shoulders to 125
	-- {spell:3848} Double-stitched Woolen Shoulders
	["{spell:3848} to 125"] = "{spell:3848} bis 125",
	["Yellow until 127, green until 145: not every craft gives a point."] = "Gelb bis 127, grün bis 145: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 16: Tailoring recipes at 125
	-- {skill:197} Tailoring
	["{skill:197} recipes at 125"] = "Rezepte für {skill:197} bei 125",
	-- {skill:197} Tailoring · {spell:3852} Gloves of Meditation
	["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Zurück zu einem Lehrer für {skill:197}: {spell:3852} wird ab {skill:197} 125 gelehrt.",

	-- Step 17: Gloves of Meditation to 150
	-- {spell:3852} Gloves of Meditation
	["{spell:3852} to 150"] = "{spell:3852} bis 150",
	-- {skill:197} Tailoring
	["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Gelb bis 140, grün bis 155: Nicht jede Herstellung bringt einen Punkt. {skill:197} 150 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 18: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} (Experte)",
	-- {skill:197} Tailoring
	["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Experte erfordert Charakterstufe 20 und {skill:197} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 135g wert.",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7053} Azure Silk Cloak · {skill:197} Tailoring
	["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Lehrt {item:7053} (erfordert {skill:197} 140). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Allianz)",
	-- {npc:6006} Shadowsworn Adept
	["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Hier fällt es von {npc:6006} (Stufe 52-53). Das Auktionshaus geht auch.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horde)",
	-- {npc:5472} Dunemaul Enforcer
	["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Hier fällt es von {npc:5472} (Stufe 46-47). Das Auktionshaus geht auch.",

	-- Step 23: Azure Silk Cloak to 180
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 180"] = "{item:7053} bis 180",
	["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Orange (jede Herstellung ein Punkt) bis 160, gelb bis 175, grün bis 190.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 24: Tailoring recipes at 180
	-- {skill:197} Tailoring
	["{skill:197} recipes at 180"] = "Rezepte für {skill:197} bei 180",
	-- {skill:197} Tailoring · {spell:8799} Crimson Silk Pantaloons
	["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Zurück zu einem Lehrer für {skill:197}: {spell:8799} wird ab {skill:197} 180 gelehrt.",

	-- Step 25: Crimson Silk Pantaloons to 185
	-- {item:7062} Crimson Silk Pantaloons
	["{item:7062} to 185"] = "{item:7062} bis 185",
	["Yellow until 190, green until 200: not every craft gives a point."] = "Gelb bis 190, grün bis 200: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 26: Tailoring recipes at 185
	-- {skill:197} Tailoring
	["{skill:197} recipes at 185"] = "Rezepte für {skill:197} bei 185",
	-- {skill:197} Tailoring · {spell:12048} Black Mageweave Vest
	["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Zurück zu einem Lehrer für {skill:197}: {spell:12048} wird ab {skill:197} 185 gelehrt.",

	-- Step 27: Black Mageweave Vest to 205
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 205"] = "{item:9998} bis 205",
	["Yellow until 200, green until 215: not every craft gives a point."] = "Gelb bis 200, grün bis 215: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 28: Tailoring recipes at 205
	-- {skill:197} Tailoring
	["{skill:197} recipes at 205"] = "Rezepte für {skill:197} bei 205",
	-- {skill:197} Tailoring · {spell:12072} Black Mageweave Headband
	["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Zurück zu einem Lehrer für {skill:197}: {spell:12072} wird ab {skill:197} 205 gelehrt.",

	-- Step 29: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} bis 225",
	-- {skill:197} Tailoring
	["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Gelb bis 220, grün bis 235: Nicht jede Herstellung bringt einen Punkt. {skill:197} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 30: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} (Fachmann)",
	-- {skill:197} Tailoring
	["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:197} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 845g wert.",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:13863} Runecloth Gloves · {skill:197} Tailoring
	["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Lehrt {item:13863} (erfordert {skill:197} 230). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird.",

	-- Step 32: Pattern: Runecloth Cuffs
	-- {item:254123} Runecloth Cuffs · {skill:197} Tailoring
	["Teaches {item:254123} (needs {skill:197} 250)."] = "Lehrt {item:254123} (erfordert {skill:197} 250).",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Allianz)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1815}, {npc:1816}, {npc:1817} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 35: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Allianz)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Hier fällt es von {npc:7027} (Stufe 56-57). Das Auktionshaus geht auch.",

	-- Step 36: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Hier fällt es von {npc:6189} (Stufe 51-52). Das Auktionshaus geht auch.",

	-- Step 37: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Allianz)",
	-- {npc:1824} Plague Lurker
	["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Hier fällt es von {npc:1824} (Stufe 54-55). Das Auktionshaus geht auch.",

	-- Step 38: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horde)",
	-- {npc:11739} Rock Stalker
	["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Hier fällt es von {npc:11739} (Stufe 57-59). Das Auktionshaus geht auch.",

	-- Step 39: Runecloth Belt to 236
	-- {item:13856} Runecloth Belt
	["{item:13856} to 236"] = "{item:13856} bis 236",
	["Yellow until 240, green until 255: not every craft gives a point."] = "Gelb bis 240, grün bis 255: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 40: Runecloth Gloves to 251
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 251"] = "{item:13863} bis 251",
	["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Orange (jede Herstellung ein Punkt) bis 245, gelb bis 260, grün bis 275.",

	-- Step 41: Runecloth Cuffs to 295
	-- {item:254123} Runecloth Cuffs
	["{item:254123} to 295"] = "{item:254123} bis 295",
	["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Orange (jede Herstellung ein Punkt) bis 265, gelb bis 280, grün bis 295.",

	-- Step 42: Tailoring 295-300
	-- {skill:197} Tailoring · {item:14342} Mooncloth · {item:14137} Mooncloth Leggings · {item:279943} Spinning Wheel · {item:14155} Mooncloth Bag · {item:14128} Wizardweave Robe · {item:19047} Wisdom of the Timbermaw
	["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "In Forever bringt kein Rezept, das ein Lehrer lehrt oder die Händler beider Fraktionen verkaufen, nach 295 noch Punkte in {skill:197}, daher hat Polestar keine Route für die letzten Punkte. Rezepte, die noch Punkte bringen: {item:14342} (erfordert einen Mondbrunnen), {item:14137} (erfordert {item:279943}), {item:14155} (Rezept wird gedroppt), {item:14128} (Rezept wird gedroppt), {item:19047} (erfordert {item:279943}).",
}
