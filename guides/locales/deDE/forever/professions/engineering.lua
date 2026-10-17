-- German (deDE): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "{skill:202} (Lehrling)",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 62s wert.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: ein Werkzeug, behalte es in deinen Taschen",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die ihn fallen lassen, am Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Das Auktionshaus geht auch.",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Allianz)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} stammt aus Vorkommen von {object:1731} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horde)",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "Materialien für {skill:202} 1-75",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: {item:2770} verhütten (oder das Auktionshaus)",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "{spell:3918} bis 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Orange (jede Herstellung ein Punkt) bis 20, gelb bis 30, grün bis 40.",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "{spell:3920} bis 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "Gelb bis 45, grün bis 60: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "Rezepte für {skill:202} bei 45",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3922} wird ab {skill:202} 45 gelehrt.",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "{spell:3922} bis 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 52, grün bis 60: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "Rezepte für {skill:202} bei 60",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3923} wird ab {skill:202} 60 gelehrt.",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "{spell:3923} bis 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Gelb bis 75, grün bis 90: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe. 75 ist die Obergrenze für Lehrling.",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} (Geselle)",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Geselle erfordert Charakterstufe 10 und {skill:202} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 3g 23s wert.",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Allianz)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Hier fällt es von {npc:98} (Stufe 17-18). Das Auktionshaus geht auch.",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Hier fällt es von {npc:3263} (Stufe 19-20). Das Auktionshaus geht auch.",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Allianz)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} stammt aus Vorkommen von {object:1732} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horde)",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Allianz)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} stammt aus Vorkommen von {object:1735} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horde)",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "Materialien für {skill:202} 75-150",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: {item:2840} verhütten (oder das Auktionshaus)",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "{spell:3923} bis 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 75, grün bis 90: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "Rezepte für {skill:202} bei 80",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3924} wird ab {skill:202} 80 gelehrt.",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "{spell:3924} bis 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 95, grün bis 110: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "Rezepte für {skill:202} bei 85",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3929} wird ab {skill:202} 85 gelehrt.",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "{spell:3929} bis 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "Gelb bis 90, grün bis 95: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "Rezepte für {skill:202} bei 95",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3926} wird ab {skill:202} 95 gelehrt.",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "{spell:3926} bis 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 110, grün bis 125: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	["a tool: keep it in your bags"] = "ein Werkzeug: Behalte es in deinen Taschen",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "Rezepte für {skill:202} bei 111",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3937} wird ab {skill:202} 105 gelehrt.",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "{spell:3937} bis 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 130, grün bis 155: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Rezepte für {skill:202} bei 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3945} wird ab {skill:202} 125 gelehrt.",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "{spell:3945} bis 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "Gelb bis 135, grün bis 145: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "Rezepte für {skill:202} bei 139",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Zurück zu einem Lehrer für {skill:202}: {spell:3942} wird ab {skill:202} 125 gelehrt.",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "{spell:3942} bis 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Gelb bis 150, grün bis 175: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe. {skill:202} 150 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202} (Experte)",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Experte erfordert Charakterstufe 20 und {skill:202} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 15g wert.",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Allianz)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Schnappkiefer, {npc:2384}, {npc:2354} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Allianz)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} stammt aus Vorkommen von {object:2040} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horde)",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "Materialien für {skill:202} 150-225",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: {item:3575} verhütten (oder das Auktionshaus)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: {item:3858} verhütten (oder das Auktionshaus)",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} bis 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "Gelb bis 170, grün bis 195: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Rezepte für {skill:202} bei 175",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Zurück zu einem Lehrer für {skill:202}: {spell:12590} wird ab {skill:202} 175 gelehrt.",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "{item:10498} bis 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 195, grün bis 215: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Rezepte für {skill:202} bei 210",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Zurück zu einem Lehrer für {skill:202}: {spell:12585}, {spell:12596} werden ab {skill:202} 210 gelehrt.",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} bis 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Gelb bis 230, grün bis 250: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe. {skill:202} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202} (Fachmann)",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:202} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 67g wert.",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Lehrt {item:15994} (erfordert {skill:202} 260). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird; das Auktionshaus hat es oft auch.",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Lehrt {item:16000} (erfordert {skill:202} 275). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird.",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Allianz)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Hier fällt es von {npc:7027} (Stufe 56-57). Das Auktionshaus geht auch.",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Hier fällt es von {npc:6189} (Stufe 51-52). Das Auktionshaus geht auch.",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "Materialien für {skill:202} 225-300",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: {item:10620} verhütten (oder das Auktionshaus)",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} bis 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 230, grün bis 250: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Rezepte für {skill:202} bei 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Zurück zu einem Lehrer für {skill:202}: {spell:12621} wird ab {skill:202} 245 gelehrt.",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "{item:10513} bis 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 265, grün bis 285: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "{item:15994} bis 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 280, gelb bis 290, grün bis 300. Erfordert einen Amboss in der Nähe.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} bis 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 295, gelb bis 305, grün bis 315. Erfordert einen Amboss in der Nähe. {skill:202} 300 ist ein Meilenstein des Vermächtnissystems.",
}
