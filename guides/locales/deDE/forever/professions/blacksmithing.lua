-- German (deDE): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "{skill:164} (Lehrling)",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 17s wert.",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Allianz)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} stammt aus Vorkommen von {object:1731} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horde)",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660} bis 45",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Orange (jede Herstellung ein Punkt) bis 15, gelb bis 35, grün bis 55.",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "Rezepte für {skill:164} bei 45",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Zurück zu einem Lehrer für {skill:164}: {spell:3320} wird ab {skill:164} 45 gelehrt.",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320} bis 75",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Gelb bis 65, grün bis 85: Nicht jede Herstellung bringt einen Punkt. 75 ist die Obergrenze für Lehrling.",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "{skill:164} (Geselle)",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Geselle erfordert Charakterstufe 10 und {skill:164} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 9g 41s wert.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: ein Werkzeug, behalte es in deinen Taschen",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Allianz)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} stammt aus Vorkommen von {object:1732} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horde)",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Allianz)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} stammt aus Vorkommen von {object:1735} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horde)",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "Materialien für {skill:164} 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: {item:2770} verhütten (oder das Auktionshaus)",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: {item:2840} verhütten (oder das Auktionshaus)",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320} bis 83",
	["Yellow until 65, green until 85: not every craft gives a point."] = "Gelb bis 65, grün bis 85: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "Rezepte für {skill:164} bei 83",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2666} wird ab {skill:164} 80 gelehrt.",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666} bis 100",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 85, gelb bis 105, grün bis 125. Erfordert einen Amboss in der Nähe.",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "Rezepte für {skill:164} bei 100",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Zurück zu einem Lehrer für {skill:164}: {spell:3117} wird ab {skill:164} 100 gelehrt.",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117} bis 112",
	["Yellow until 107, green until 115: not every craft gives a point."] = "Gelb bis 107, grün bis 115: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "Rezepte für {skill:164} bei 112",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2668} wird ab {skill:164} 95 gelehrt.",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668} bis 121",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 120, gelb bis 135, grün bis 150. Erfordert einen Amboss in der Nähe.",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "Rezepte für {skill:164} bei 121",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2672} wird ab {skill:164} 120 gelehrt.",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672} bis 150",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 125, gelb bis 140, grün bis 155. Erfordert einen Amboss in der Nähe. {skill:164} 150 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "{skill:164} (Experte)",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Experte erfordert Charakterstufe 20 und {skill:164} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 42g wert.",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Allianz)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Schnappkiefer, {npc:2384}, {npc:2354} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Allianz)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} stammt aus Vorkommen von {object:2040} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horde)",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "Materialien für {skill:164} 150-225",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: {item:2775} verhütten (oder das Auktionshaus)",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: {item:3575} verhütten (oder das Auktionshaus)",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333} bis 155",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 155, grün bis 170: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "Rezepte für {skill:164} bei 155",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9985} wird ab {skill:164} 155 gelehrt.",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956} bis 175",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 170, grün bis 185: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "Rezepte für {skill:164} bei 175",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9918} wird ab {skill:164} 175 gelehrt.",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964} bis 185",
	["Yellow until 180, green until 185: not every craft gives a point."] = "Gelb bis 180, grün bis 185: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "Rezepte für {skill:164} bei 185",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Zurück zu einem Lehrer für {skill:164}: {spell:7223} wird ab {skill:164} 185 gelehrt.",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040} bis 200",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 197, grün bis 210: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "Rezepte für {skill:164} bei 200",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9916} wird ab {skill:164} 200 gelehrt.",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963} bis 210",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 212, grün bis 225: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "Rezepte für {skill:164} bei 210",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9920}, {spell:9935} werden ab {skill:164} 210 gelehrt.",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922} bis 225",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Gelb bis 220, grün bis 230: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe. {skill:164} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "{skill:164} (Fachmann)",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:164} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 942g wert.",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "Lehrt {item:250562} (erfordert {skill:164} 240).",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "Lehrt {item:12775} (erfordert {skill:164} 255).",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Allianz)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horde)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die ihn fallen lassen, am Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Das Auktionshaus geht auch.",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Allianz)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1815}, {npc:1816}, {npc:1817} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (Allianz)",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:8831} mit {skill:182}; das ist das dichteste Vorkommen in den Daten. Das Auktionshaus geht auch.",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (Horde)",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365} (Allianz)",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} stammt aus Vorkommen von {object:324} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365} (Horde)",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "Materialien für {skill:164} 225-300",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: {item:3858} verhütten (oder das Auktionshaus)",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: {item:10620} verhütten (oder das Auktionshaus)",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (oder das Auktionshaus)",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393} (oder das Auktionshaus)",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (oder das Auktionshaus)",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931} bis 230",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 235, grün bis 245: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "Rezepte für {skill:164} bei 230",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:16640} wird ab {skill:164} 230 gelehrt.",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643} bis 235",
	["Yellow until 232, green until 235: not every craft gives a point."] = "Gelb bis 232, grün bis 235: Nicht jede Herstellung bringt einen Punkt.",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "Rezepte für {skill:164} bei 235",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9968} wird ab {skill:164} 230 gelehrt.",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933} bis 244",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 240, grün bis 250: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562} bis 268",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 260, gelb bis 270, grün bis 280. Erfordert einen Amboss in der Nähe.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "Rezepte für {skill:164} bei 268",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:16639} wird ab {skill:164} 230 gelehrt.",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775} bis 300",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 280, gelb bis 292, grün bis 305. Erfordert einen Amboss in der Nähe. {skill:164} 300 ist ein Meilenstein des Vermächtnissystems.",
}
