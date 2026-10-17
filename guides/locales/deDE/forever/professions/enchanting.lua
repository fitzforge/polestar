-- German (deDE): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Enchanting
	-- {skill:333} Enchanting
	["Apprentice {skill:333}"] = "{skill:333} (Lehrling)",
	-- {skill:333} Enchanting
	["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 4g 3s wert.",

	-- Step 2: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418} bis 25",
	["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "Orange (jede Herstellung ein Punkt) bis 20, gelb bis 22, grün bis 25. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",
	["a tool: keep it in your bags"] = "ein Werkzeug: Behalte es in deinen Taschen",

	-- Step 3: Enchant Bracer - Minor Deflect to 75
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 75"] = "{spell:7428} bis 75",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "Orange (jede Herstellung ein Punkt) bis 80, gelb bis 100, grün bis 120. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt. 75 ist die Obergrenze für Lehrling.",

	-- Step 4: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "{skill:333} (Geselle)",
	-- {skill:333} Enchanting
	["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "Geselle erfordert Charakterstufe 10 und {skill:333} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 7g 51s wert.",

	-- Step 5: Formula: Enchant Cloak - Minor Agility
	-- {spell:13419} Enchant Cloak - Minor Agility · {skill:333} Enchanting
	["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Lehrt {spell:13419} (erfordert {skill:333} 110). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird; das Auktionshaus hat es oft auch.",

	-- Step 6: Shadowgem (Alliance)
	-- {item:1210} Shadowgem
	["{item:1210} (Alliance)"] = "{item:1210} (Allianz)",
	-- {item:1210} Shadowgem · {object:1731} Copper Vein · {skill:186} Mining
	["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210} stammt aus Vorkommen von {object:1731} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",

	-- Step 7: Shadowgem (Horde)
	-- {item:1210} Shadowgem
	["{item:1210} (Horde)"] = "{item:1210} (Horde)",

	-- Step 8: Enchanting materials for 75-150
	-- {skill:333} Enchanting
	["{skill:333} materials for 75-150"] = "Materialien für {skill:333} 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- {skill:164} Blacksmithing · {item:6338} Silver Rod
	["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}: {item:6338} (oder das Auktionshaus)",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: entzaubere ungewöhnliche (grüne) Ausrüstung (oder das Auktionshaus)",

	-- Step 9: Enchant Bracer - Minor Deflect to 90
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 90"] = "{spell:7428} bis 90",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "Orange (jede Herstellung ein Punkt) bis 80, gelb bis 100, grün bis 120. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 10: Enchanting recipes at 90
	-- {skill:333} Enchanting
	["{skill:333} recipes at 90"] = "Rezepte für {skill:333} bei 90",
	-- {skill:333} Enchanting · {spell:7426} Enchant Chest - Minor Absorption
	["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "Zurück zu einem Lehrer für {skill:333}: {spell:7426} wird ab {skill:333} 90 gelehrt.",

	-- Step 11: Enchant Chest - Minor Absorption to 120
	-- {spell:7426} Enchant Chest - Minor Absorption
	["{spell:7426} to 120"] = "{spell:7426} bis 120",
	["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 110, grün bis 130: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 12: Enchanting recipes at 120
	-- {skill:333} Enchanting
	["{skill:333} recipes at 120"] = "Rezepte für {skill:333} bei 120",
	-- {skill:333} Enchanting · {spell:7788} Enchant Weapon - Minor Striking
	["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "Zurück zu einem Lehrer für {skill:333}: {spell:7788} wird ab {skill:333} 120 gelehrt.",

	-- Step 13: Enchant Weapon - Minor Striking to 130
	-- {spell:7788} Enchant Weapon - Minor Striking
	["{spell:7788} to 130"] = "{spell:7788} bis 130",
	["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 140, grün bis 160: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 14: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "Rezepte für {skill:333} bei 130",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod
	["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "Zurück zu einem Lehrer für {skill:333}: {spell:7795} wird ab {skill:333} 130 gelehrt.",

	-- Step 15: Enchant Cloak - Minor Agility to 150
	-- {spell:13419} Enchant Cloak - Minor Agility
	["{spell:13419} to 150"] = "{spell:13419} bis 150",
	-- {skill:333} Enchanting
	["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 135, gelb bis 155, grün bis 175. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt. {skill:333} 150 ist ein Meilenstein des Vermächtnissystems.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 16: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "{skill:333} (Experte)",
	-- {skill:333} Enchanting
	["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "Experte erfordert Charakterstufe 20 und {skill:333} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 13s wert.",

	-- Step 17: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500} (Allianz)",
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Open Giant Clams here. The Auction House works too."] = "Öffne hier Riesenmuscheln. Das Auktionshaus geht auch.",

	-- Step 18: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500} (Horde)",

	-- Step 19: Enchanting materials for 150-225
	-- {skill:333} Enchanting
	["{skill:333} materials for 150-225"] = "Materialien für {skill:333} 150-225",
	-- {skill:171} Alchemy · {item:6371} Fire Oil
	["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}: {item:6371} (oder das Auktionshaus)",
	-- {skill:164} Blacksmithing · {item:11128} Golden Rod
	["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}: {item:11128} (oder das Auktionshaus)",

	-- Step 20: Enchant Cloak - Lesser Fire Resistance to 155
	-- {spell:7861} Enchant Cloak - Lesser Fire Resistance
	["{spell:7861} to 155"] = "{spell:7861} bis 155",
	["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 170, grün bis 190: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 21: Enchanting recipes at 155
	-- {skill:333} Enchanting
	["{skill:333} recipes at 155"] = "Rezepte für {skill:333} bei 155",
	-- {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "Zurück zu einem Lehrer für {skill:333}: {spell:13501} wird ab {skill:333} 155 gelehrt.",

	-- Step 22: Enchant Bracer - Lesser Stamina to 180
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 180"] = "{spell:13501} bis 180",
	["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 175, grün bis 195: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 23: Enchanting recipes at 180
	-- {skill:333} Enchanting
	["{skill:333} recipes at 180"] = "Rezepte für {skill:333} bei 180",
	-- {skill:333} Enchanting · {spell:13628} Runed Golden Rod · {spell:13637} Enchant Boots - Lesser Agility
	["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "Zurück zu einem Lehrer für {skill:333}: {spell:13628}, {spell:13637} werden ab {skill:333} 180 gelehrt.",

	-- Step 24: Enchant Boots - Lesser Agility to 200
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 200"] = "{spell:13637} bis 200",
	["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 200, grün bis 220: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 25: Enchanting recipes at 200
	-- {skill:333} Enchanting
	["{skill:333} recipes at 200"] = "Rezepte für {skill:333} bei 200",
	-- {skill:333} Enchanting · {spell:13661} Enchant Bracer - Strength
	["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "Zurück zu einem Lehrer für {skill:333}: {spell:13661} wird ab {skill:333} 200 gelehrt.",

	-- Step 26: Enchant Bracer - Strength to 225
	-- {spell:13661} Enchant Bracer - Strength
	["{spell:13661} to 225"] = "{spell:13661} bis 225",
	-- {skill:333} Enchanting
	["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "Gelb bis 220, grün bis 240: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt. {skill:333} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 27: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "{skill:333} (Fachmann)",
	-- {skill:333} Enchanting
	["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:333} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 30s wert.",
	-- {npc:11073} Annora · {skill:333} Enchanting · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073} lehrt {skill:333} (Fachmann) im Dungeon {area:1517} ({zone:1418}); nimm eine Gruppe mit",

	-- Step 28: Black Pearl (Alliance)
	-- {item:7971} Black Pearl
	["{item:7971} (Alliance)"] = "{item:7971} (Allianz)",
	-- {npc:922} Silt Crawler
	["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "Hier fällt es von {npc:922} (Stufe 40-41). Das Auktionshaus geht auch.",

	-- Step 29: Black Pearl (Horde)
	-- {item:7971} Black Pearl
	["{item:7971} (Horde)"] = "{item:7971} (Horde)",
	-- {npc:5431} Surf Glider
	["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "Hier fällt es von {npc:5431} (Stufe 48-50). Das Auktionshaus geht auch.",

	-- Step 30: Wildvine (Alliance)
	-- {item:8153} Wildvine
	["{item:8153} (Alliance)"] = "{item:8153} (Allianz)",
	-- {item:8153} Wildvine · {item:8831} Purple Lotus · {skill:182} Herbalism
	["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153} stammt aus Vorkommen von {item:8831} ({skill:182}); das ist das dichteste Vorkommen in den Daten. Das Auktionshaus geht auch.",

	-- Step 31: Wildvine (Horde)
	-- {item:8153} Wildvine
	["{item:8153} (Horde)"] = "{item:8153} (Horde)",

	-- Step 32: Enchanting materials for 225-300
	-- {skill:333} Enchanting
	["{skill:333} materials for 225-300"] = "Materialien für {skill:333} 225-300",
	-- {skill:164} Blacksmithing · {item:11144} Truesilver Rod
	["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}: {item:11144} (oder das Auktionshaus)",

	-- Step 33: Enchant Cloak - Greater Defense to 255
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 255"] = "{spell:13746} bis 255",
	["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 245, grün bis 265: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 34: Enchanting recipes at 255
	-- {skill:333} Enchanting
	["{skill:333} recipes at 255"] = "Rezepte für {skill:333} bei 255",
	-- {skill:333} Enchanting · {spell:13935} Enchant Boots - Agility
	["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "Zurück zu einem Lehrer für {skill:333}: {spell:13935} wird ab {skill:333} 255 gelehrt.",

	-- Step 35: Enchant Boots - Agility to 292
	-- {spell:13935} Enchant Boots - Agility
	["{spell:13935} to 292"] = "{spell:13935} bis 292",
	["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Gelb bis 275, grün bis 295: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt.",

	-- Step 36: Enchanting recipes at 292
	-- {skill:333} Enchanting
	["{skill:333} recipes at 292"] = "Rezepte für {skill:333} bei 292",
	-- {skill:333} Enchanting · {spell:13948} Enchant Gloves - Minor Haste
	["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "Zurück zu einem Lehrer für {skill:333}: {spell:13948} wird ab {skill:333} 270 gelehrt.",

	-- Step 37: Enchant Gloves - Minor Haste to 300
	-- {spell:13948} Enchant Gloves - Minor Haste
	["{spell:13948} to 300"] = "{spell:13948} bis 300",
	-- {skill:333} Enchanting
	["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "Gelb bis 290, grün bis 310: Nicht jede Herstellung bringt einen Punkt. Verzaubere deine eigene Ausrüstung: Jeder Gegenstand für diesen Platz genügt. {skill:333} 300 ist ein Meilenstein des Vermächtnissystems.",
}
