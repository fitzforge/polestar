-- German (deDE): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Alchemy
	-- {skill:171} Alchemy
	["Apprentice {skill:171}"] = "Lehrling: {skill:171}",
	-- {skill:171} Alchemy
	["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171} läuft neben dem Leveln. Forevers Vermächtnissystem belohnt Herstellungsberufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen von Geselle, Experte und Fachmann), also zählt jeder dieser Meilensteine. Die Materialien für 1-75 sind insgesamt etwa 68s wert.",

	-- Step 2: Silverleaf (Alliance)
	-- {item:765} Silverleaf
	["{item:765} (Alliance)"] = "{item:765} (Allianz)",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:765} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 3: Silverleaf (Horde)
	-- {item:765} Silverleaf
	["{item:765} (Horde)"] = "{item:765} (Horde)",

	-- Step 4: Peacebloom (Alliance)
	-- {item:2447} Peacebloom
	["{item:2447} (Alliance)"] = "{item:2447} (Allianz)",
	-- {item:2447} Peacebloom · {skill:182} Herbalism
	["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:2447} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 5: Peacebloom (Horde)
	-- {item:2447} Peacebloom
	["{item:2447} (Horde)"] = "{item:2447} (Horde)",

	-- Step 6: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} bis 75",
	["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Orange (jede Herstellung ein Punkt) bis 55, gelb bis 75, grün bis 95. 75 ist die Obergrenze für Lehrlinge.",

	-- Step 7: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "Geselle: {skill:171}",
	-- {skill:171} Alchemy
	["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Geselle erfordert Charakterstufe 10 und {skill:171} 50; die Obergrenze steigt auf 150. Die Materialien für 75-150 sind insgesamt etwa 1g 44s wert.",

	-- Step 8: Recipe: Holy Protection Potion
	-- {item:6051} Holy Protection Potion · {skill:171} Alchemy
	["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Lehrt {item:6051} (erfordert {skill:171} 100). Händler verkaufen es in begrenzter Menge, die sich wieder auffüllt.",

	-- Step 9: Murloc Eye (Alliance)
	-- {item:730} Murloc Eye
	["{item:730} (Alliance)"] = "{item:730} (Allianz)",
	-- {npc:513} Murloc Netter
	["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "{npc:513} (Stufe 14-15) lassen es hier fallen. Im Auktionshaus gibt es sie auch.",

	-- Step 10: Murloc Eye (Horde)
	-- {item:730} Murloc Eye
	["{item:730} (Horde)"] = "{item:730} (Horde)",
	-- {npc:1958} Vile Fin Tidecaller
	["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "{npc:1958} (Stufe 17-18) lassen es hier fallen. Im Auktionshaus gibt es sie auch.",

	-- Step 11: Mageroyal (Alliance)
	-- {item:785} Mageroyal
	["{item:785} (Alliance)"] = "{item:785} (Allianz)",
	-- {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:785} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 12: Mageroyal (Horde)
	-- {item:785} Mageroyal
	["{item:785} (Horde)"] = "{item:785} (Horde)",

	-- Step 15: Briarthorn (Alliance)
	-- {item:2450} Briarthorn
	["{item:2450} (Alliance)"] = "{item:2450} (Allianz)",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:2450} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 16: Briarthorn (Horde)
	-- {item:2450} Briarthorn
	["{item:2450} (Horde)"] = "{item:2450} (Horde)",

	-- Step 17: Swiftthistle (Alliance)
	-- {item:2452} Swiftthistle
	["{item:2452} (Alliance)"] = "{item:2452} (Allianz)",
	-- {item:2452} Swiftthistle · {item:2450} Briarthorn · {skill:182} Herbalism
	["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} stammt aus Vorkommen von {item:2450} ({skill:182}); hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 18: Swiftthistle (Horde)
	-- {item:2452} Swiftthistle
	["{item:2452} (Horde)"] = "{item:2452} (Horde)",

	-- Step 19: Bruiseweed (Alliance)
	-- {item:2453} Bruiseweed
	["{item:2453} (Alliance)"] = "{item:2453} (Allianz)",
	-- {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:2453} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 20: Bruiseweed (Horde)
	-- {item:2453} Bruiseweed
	["{item:2453} (Horde)"] = "{item:2453} (Horde)",

	-- Step 21: Minor Mana Potion to 85
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 85"] = "{spell:2331} bis 85",
	["Yellow until 85, green until 105: not every craft gives a point."] = "Gelb bis 85, grün bis 105: nicht jede Herstellung gibt einen Punkt.",

	-- Step 22: Alchemy recipes at 85
	-- {skill:171} Alchemy
	["{skill:171} recipes at 85"] = "Rezepte für {skill:171} bei 85",
	-- {skill:171} Alchemy · {spell:1244645} Lesser Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Zurück zu einem Lehrer für {skill:171}: {spell:1244645} wird ab {skill:171} 85 gelehrt.",

	-- Step 23: Lesser Discolored Healing Potion to 100
	-- {item:247239} Lesser Discolored Healing Potion
	["{item:247239} to 100"] = "{item:247239} bis 100",
	["Yellow until 105, green until 125: not every craft gives a point."] = "Gelb bis 105, grün bis 125: nicht jede Herstellung gibt einen Punkt.",

	-- Step 24: Holy Protection Potion to 150
	-- {item:6051} Holy Protection Potion
	["{item:6051} to 150"] = "{item:6051} bis 150",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 130, gelb bis 150, grün bis 170. {skill:171} 150 ist ein Meilenstein des Vermächtnissystems.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 25: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "Experte: {skill:171}",
	-- {skill:171} Alchemy
	["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Experte erfordert Charakterstufe 20 und {skill:171} 125; die Obergrenze steigt auf 225. Die Materialien für 150-225 sind insgesamt etwa 3g 65s wert.",

	-- Step 26: Murloc Eye
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die es fallen lassen, an dem Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Im Auktionshaus gibt es sie auch.",

	-- Step 27: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Allianz)",
	-- {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {object:1623} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es das auch.",

	-- Step 28: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Horde)",

	-- Step 29: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Allianz)",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:3356} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 30: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Horde)",

	-- Step 31: Liferoot (Alliance)
	-- {item:3357} Liferoot
	["{item:3357} (Alliance)"] = "{item:3357} (Allianz)",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:3357} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 32: Liferoot (Horde)
	-- {item:3357} Liferoot
	["{item:3357} (Horde)"] = "{item:3357} (Horde)",

	-- Step 33: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Allianz)",
	-- {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {object:2046} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es das auch.",

	-- Step 34: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Horde)",

	-- Step 35: Oily Blackmouth (Alliance)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Alliance)"] = "{item:6358} (Allianz)",
	-- {object:180582} Oily Blackmouth School
	["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Angle in {object:180582}; hier gibt es laut Daten die meisten. Im Auktionshaus gibt es sie auch.",

	-- Step 36: Oily Blackmouth (Horde)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Horde)"] = "{item:6358} (Horde)",

	-- Step 37: Firefin Snapper (Alliance)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Alliance)"] = "{item:6359} (Allianz)",
	-- {object:180657} Firefin Snapper School
	["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Angle in {object:180657}; hier gibt es laut Daten die meisten. Im Auktionshaus gibt es sie auch.",

	-- Step 38: Firefin Snapper (Horde)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Horde)"] = "{item:6359} (Horde)",

	-- Step 39: Fire Oil to 165
	-- {item:6371} Fire Oil
	["{item:6371} to 165"] = "{item:6371} bis 165",
	["Yellow until 160, green until 170: not every craft gives a point."] = "Gelb bis 160, grün bis 170: nicht jede Herstellung gibt einen Punkt.",

	-- Step 40: Alchemy recipes at 165
	-- {skill:171} Alchemy
	["{skill:171} recipes at 165"] = "Rezepte für {skill:171} bei 165",
	-- {skill:171} Alchemy · {spell:7845} Elixir of Fire Power
	["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Zurück zu einem Lehrer für {skill:171}: {spell:7845} wird ab {skill:171} 165 gelehrt.",

	-- Step 41: Elixir of Fire Power to 175
	-- {spell:7845} Elixir of Fire Power
	["{spell:7845} to 175"] = "{spell:7845} bis 175",
	["Yellow until 185, green until 205: not every craft gives a point."] = "Gelb bis 185, grün bis 205: nicht jede Herstellung gibt einen Punkt.",

	-- Step 42: Alchemy recipes at 175
	-- {skill:171} Alchemy
	["{skill:171} recipes at 175"] = "Rezepte für {skill:171} bei 175",
	-- {skill:171} Alchemy · {spell:1244647} Greater Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Zurück zu einem Lehrer für {skill:171}: {spell:1244647} wird ab {skill:171} 175 gelehrt.",

	-- Step 43: Greater Discolored Healing Potion to 200
	-- {item:247241} Greater Discolored Healing Potion
	["{item:247241} to 200"] = "{item:247241} bis 200",
	["Yellow until 195, green until 215: not every craft gives a point."] = "Gelb bis 195, grün bis 215: nicht jede Herstellung gibt einen Punkt.",

	-- Step 44: Alchemy recipes at 200
	-- {skill:171} Alchemy
	["{skill:171} recipes at 200"] = "Rezepte für {skill:171} bei 200",
	-- {skill:171} Alchemy · {spell:11447} Draught of Water Walking
	["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Zurück zu einem Lehrer für {skill:171}: {spell:11447} wird ab {skill:171} 190 gelehrt.",

	-- Step 45: Draught of Water Walking to 215
	-- {spell:11447} Draught of Water Walking
	["{spell:11447} to 215"] = "{spell:11447} bis 215",
	["Yellow until 210, green until 230: not every craft gives a point."] = "Gelb bis 210, grün bis 230: nicht jede Herstellung gibt einen Punkt.",

	-- Step 46: Alchemy recipes at 215
	-- {skill:171} Alchemy
	["{skill:171} recipes at 215"] = "Rezepte für {skill:171} bei 215",
	-- {skill:171} Alchemy · {spell:11450} Elixir of Defense
	["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Zurück zu einem Lehrer für {skill:171}: {spell:11450} wird ab {skill:171} 215 gelehrt.",

	-- Step 47: Elixir of Defense to 225
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 225"] = "{spell:11450} bis 225",
	-- {skill:171} Alchemy
	["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Gelb bis 235, grün bis 255: nicht jede Herstellung gibt einen Punkt. {skill:171} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 48: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "Fachmann: {skill:171}",
	-- {skill:171} Alchemy
	["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:171} 200; die Obergrenze steigt auf 300. Die Materialien für 225-300 sind insgesamt etwa 7g 80s wert.",

	-- Step 49: Recipe: Elixir of Superior Defense
	-- {item:8951} Elixir of Greater Defense · {skill:171} Alchemy
	["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Lehrt {item:8951} (erfordert {skill:171} 265). Händler verkaufen es in begrenzter Menge, die sich wieder auffüllt; auch im Auktionshaus gibt es es oft.",

	-- Step 55: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Allianz)",
	-- {item:8836} Arthas' Tears · {skill:182} Herbalism
	["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:8836} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 56: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Horde)",

	-- Step 57: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Allianz)",
	-- {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:8838} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",

	-- Step 58: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Horde)",

	-- Step 59: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Allianz)",
	-- {object:180712} Stonescale Eel Swarm
	["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Angle in {object:180712}; hier gibt es laut Daten die meisten. Im Auktionshaus gibt es sie auch.",

	-- Step 60: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Horde)",

	-- Step 61: Elixir of Defense to 230
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 230"] = "{spell:11450} bis 230",
	["Yellow until 235, green until 255: not every craft gives a point."] = "Gelb bis 235, grün bis 255: nicht jede Herstellung gibt einen Punkt.",

	-- Step 62: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "Rezepte für {skill:171} bei 230",
	-- {skill:171} Alchemy · {spell:1244648} Superior Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Zurück zu einem Lehrer für {skill:171}: {spell:1244648} wird ab {skill:171} 230 gelehrt.",

	-- Step 63: Superior Discolored Healing Potion to 250
	-- {item:247242} Superior Discolored Healing Potion
	["{item:247242} to 250"] = "{item:247242} bis 250",
	["Yellow until 250, green until 270: not every craft gives a point."] = "Gelb bis 250, grün bis 270: nicht jede Herstellung gibt einen Punkt.",

	-- Step 64: Alchemy recipes at 250
	-- {skill:171} Alchemy
	["{skill:171} recipes at 250"] = "Rezepte für {skill:171} bei 250",
	-- {skill:171} Alchemy · {spell:17551} Stonescale Oil
	["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Zurück zu einem Lehrer für {skill:171}: {spell:17551} wird ab {skill:171} 250 gelehrt.",

	-- Step 65: Stonescale Oil to 259
	-- {item:13423} Stonescale Oil
	["{item:13423} to 259"] = "{item:13423} bis 259",
	["Yellow until 255, green until 260: not every craft gives a point."] = "Gelb bis 255, grün bis 260: nicht jede Herstellung gibt einen Punkt.",

	-- Step 66: Alchemy recipes at 259
	-- {skill:171} Alchemy
	["{skill:171} recipes at 259"] = "Rezepte für {skill:171} bei 259",
	-- {skill:171} Alchemy · {spell:11460} Draught of Detect Undead
	["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Zurück zu einem Lehrer für {skill:171}: {spell:11460} wird ab {skill:171} 245 gelehrt.",

	-- Step 67: Draught of Detect Undead to 265
	-- {spell:11460} Draught of Detect Undead
	["{spell:11460} to 265"] = "{spell:11460} bis 265",
	["Yellow until 265, green until 285: not every craft gives a point."] = "Gelb bis 265, grün bis 285: nicht jede Herstellung gibt einen Punkt.",

	-- Step 68: Elixir of Greater Defense to 300
	-- {spell:17554} Elixir of Greater Defense
	["{spell:17554} to 300"] = "{spell:17554} bis 300",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 280, gelb bis 300, grün bis 320. {skill:171} 300 ist ein Meilenstein des Vermächtnissystems.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:3355} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:3821} mit {skill:182}; hier ist das dichteste Vorkommen laut Daten. Im Auktionshaus gibt es sie auch.",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Allianz)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Horde)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Allianz)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Horde)",
}
