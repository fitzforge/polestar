-- Spanish (Latin America) (esMX): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "Aprende {skill:164}",
	["No character level needed."] = "",

	-- Step 2: Buy a Blacksmith Hammer
	-- {item:5956} Blacksmith Hammer
	["Buy a {item:5956}"] = "",
	["A tool: it stays in your bags, and most recipes need it."] = "",

	-- Step 3: Get 198 Rough Stone
	-- {item:2835} Rough Stone
	["Get 198 {item:2835}"] = "",
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone · Rough Grinding Stones = {spell:3320} Rough Grinding Stone
	["For 30 Rough Sharpening Stones and 84 Rough Grinding Stones."] = "",

	-- Step 4: Craft 30 Rough Sharpening Stones until 25
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone
	["Craft 30 Rough Sharpening Stones until 25"] = "",
	["About 30 crafts."] = "",

	-- Step 5: Learn Rough Grinding Stone
	-- {spell:3320} Rough Grinding Stone
	["Learn {spell:3320}"] = "",

	-- Step 6: Craft 84 Rough Grinding Stones until 75
	-- plural, as words: Rough Grinding Stones = {spell:3320} Rough Grinding Stone
	["Craft 84 Rough Grinding Stones until 75"] = "",
	["About 84 crafts."] = "",

	-- Step 7: Get 120 Coarse Stone
	-- {item:2836} Coarse Stone
	["Get 120 {item:2836}"] = "",
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["For 60 Coarse Grinding Stones."] = "",

	-- Step 8: Train Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Journeyman {skill:164}"] = "",
	["Needs level 10."] = "",

	-- Step 9: Learn Coarse Grinding Stone
	-- {spell:3326} Coarse Grinding Stone
	["Learn {spell:3326}"] = "",

	-- Step 10: Craft 60 Coarse Grinding Stones until 84
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["Craft 60 Coarse Grinding Stones until 84"] = "",
	["About 60 crafts. Keep all 60: the bracers at 95 and 115 and the gauntlets at 125 use them."] = "",

	-- Step 11: Get 91 Bronze Bar
	-- {item:2841} Bronze Bar
	["Get 91 {item:2841}"] = "",
	-- {spell:2668} Rough Bronze Leggings · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining
	["For 11 {spell:2668} and 5 {spell:2672}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 12: Learn Rough Bronze Leggings
	-- {spell:2668} Rough Bronze Leggings
	["Learn {spell:2668}"] = "",

	-- Step 13: Go to an anvil
	["Go to an anvil"] = "",
	["Anvil"] = "",

	-- Step 14: Craft 11 Rough Bronze Leggings until 95
	-- {spell:2668} Rough Bronze Leggings
	["Craft 11 {spell:2668} until 95"] = "",
	["About 11 crafts. Short of 84 after the stones? These leggings carry on from where you are."] = "",

	-- Step 15: Learn Patterned Bronze Bracers
	-- {spell:2672} Patterned Bronze Bracers
	["Learn {spell:2672}"] = "",

	-- Step 17: Craft 5 Patterned Bronze Bracers until 100
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 5 {spell:2672} until 100"] = "",
	["About 5 crafts."] = "",

	-- Step 18: Get 90 Heavy Stone
	-- {item:2838} Heavy Stone
	["Get 90 {item:2838}"] = "",
	-- plural, as words: Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["For 30 Heavy Grinding Stones."] = "",

	-- Step 19: Learn Heavy Grinding Stone
	-- {spell:3337} Heavy Grinding Stone
	["Learn {spell:3337}"] = "",

	-- Step 20: Craft 30 Heavy Grinding Stones until 115
	-- plural, as words: Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["Craft 30 Heavy Grinding Stones until 115"] = "",
	-- {item:6040} Golden Scale Bracers
	["About 30 crafts. Keep all 30 for the {item:6040} at 185."] = "",

	-- Step 21: Get 50 Bronze Bar
	-- {item:2841} Bronze Bar
	["Get 50 {item:2841}"] = "",
	-- {spell:2672} Patterned Bronze Bracers · {skill:186} Mining
	["For 10 {spell:2672}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 22: Learn Patterned Bronze Bracers
	["Taught at 95; done at once if you learned it then."] = "",

	-- Step 24: Craft 10 Patterned Bronze Bracers until 125
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 10 {spell:2672} until 125"] = "",
	["About 10 crafts."] = "",

	-- Step 25: Get 120 Bronze Bar
	-- {item:2841} Bronze Bar
	["Get 120 {item:2841}"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets · {skill:186} Mining
	["For 15 {spell:3333}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 26: Get 15 Silver Bar
	-- {item:2842} Silver Bar
	["Get 15 {item:2842}"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets
	["For 15 {spell:3333}."] = "",

	-- Step 27: Learn Silvered Bronze Gauntlets
	-- {spell:3333} Silvered Bronze Gauntlets
	["Learn {spell:3333}"] = "",

	-- Step 29: Craft 15 Silvered Bronze Gauntlets until 140
	-- {spell:3333} Silvered Bronze Gauntlets
	["Craft 15 {spell:3333} until 140"] = "",
	-- {item:2842} Silver Bar
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["About 15 crafts. {item:2842} dear? 15 Bronze Warhammers reach 140 too."] = "",

	-- Step 30: Buy 40 Green Dye
	-- {item:2605} Green Dye
	["Buy 40 {item:2605}"] = "",
	-- {spell:3501} Green Iron Bracers
	["For 40 {spell:3501}."] = "",

	-- Step 31: Get 240 Iron Bar
	-- {item:3575} Iron Bar
	["Get 240 {item:3575}"] = "",
	-- {spell:3501} Green Iron Bracers · {skill:186} Mining
	["For 40 {spell:3501}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 32: Train Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Expert {skill:164}"] = "",
	["Needs level 20."] = "",

	-- Step 33: Learn Green Iron Bracers
	-- {spell:3501} Green Iron Bracers
	["Learn {spell:3501}"] = "",

	-- Step 35: Craft 40 Green Iron Bracers until 175
	-- {spell:3501} Green Iron Bracers
	["Craft 40 {spell:3501} until 175"] = "",
	["About 40 crafts."] = "",

	-- Step 36: Get 60 Solid Stone
	-- {item:7912} Solid Stone
	["Get 60 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone · Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["For 8 Solid Grinding Stones and 28 Solid Sharpening Stones."] = "",

	-- Step 37: Learn Solid Grinding Stone
	-- {spell:9920} Solid Grinding Stone
	["Learn {spell:9920}"] = "",

	-- Step 38: Learn Solid Sharpening Stone
	-- {spell:9918} Solid Sharpening Stone
	["Learn {spell:9918}"] = "",
	["For 180-185: taught here now, so no second trip."] = "",

	-- Step 39: Learn Golden Scale Bracers
	-- {spell:7223} Golden Scale Bracers
	["Learn {spell:7223}"] = "",
	["For 185-195: taught here now, so no second trip."] = "",

	-- Step 40: Craft 8 Solid Grinding Stones until 180
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 8 Solid Grinding Stones until 180"] = "",
	["About 8 crafts. Keep all 8 for the step at 210."] = "",

	-- Step 41: Craft 28 Solid Sharpening Stones until 185
	-- plural, as words: Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["Craft 28 Solid Sharpening Stones until 185"] = "",
	["About 28 crafts. Green from 180: short of 185? A few more do it."] = "",

	-- Step 42: Buy 75 Coal
	["Buy 75 Coal"] = "",
	-- {item:3859} Steel Bar
	["Smelting {item:3859} takes 1 Coal a bar."] = "",

	-- Step 43: Get 75 Steel Bar
	-- {item:3859} Steel Bar
	["Get 75 {item:3859}"] = "",
	-- {item:6040} Golden Scale Bracers · {skill:186} Mining
	["For 15 {item:6040}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 44: Learn Golden Scale Bracers
	["Taught at 175; done at once if you learned it then."] = "",

	-- Step 46: Craft 15 Golden Scale Bracers until 195
	-- {item:6040} Golden Scale Bracers
	["Craft 15 {item:6040} until 195"] = "",
	["About 15 crafts. Alliance smiths who want Armorsmithing later: keep 6."] = "",

	-- Step 47: Get 204 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 204 {item:3860}"] = "",
	-- {item:7920} Mithril Plate Pants · {skill:186} Mining
	["For 17 {item:7920}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 48: Learn Mithril Plate Pants
	-- {spell:9931} Mithril Plate Pants
	["Learn {spell:9931}"] = "",

	-- Step 50: Craft 17 Mithril Plate Pants until 210
	-- {item:7920} Mithril Plate Pants
	["Craft 17 {item:7920} until 210"] = "",
	["About 17 crafts. Armorsmith or Weaponsmith opens at 200 and level 40; optional."] = "",

	-- Step 51: Train Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Artisan {skill:164}"] = "",
	["Needs level 35."] = "",

	-- Step 52: Buy Plans: Mithril Spurs at the Auction House
	-- {item:7989} Plans: Mithril Spurs
	["Buy {item:7989} at the Auction House"] = "",
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Saves about 130 Thorium and 150 Mithril Bars."] = "",
	["None listed, or too dear"] = "",

	-- Step 53: Learn Mithril Spurs
	-- {spell:9964} Mithril Spurs
	["Learn {spell:9964}"] = "",
	["From the plans in your bags."] = "",

	-- Step 54: Get 148 Solid Stone
	-- {item:7912} Solid Stone
	["Get 148 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 37 Solid Grinding Stones."] = "",

	-- Step 55: Get 60 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 60 {item:3860}"] = "",
	-- {item:7969} Mithril Spurs · {skill:186} Mining
	["For 15 {item:7969}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 57: Craft 37 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 37 Solid Grinding Stones"] = "",
	["Parts for the spurs; no skill points from these."] = "",

	-- Step 59: Craft 15 Mithril Spurs until 225
	-- {item:7969} Mithril Spurs
	["Craft 15 {item:7969} until 225"] = "",
	["About 15 crafts."] = "",

	-- Step 60: Get 16 Dense Stone
	-- {item:12365} Dense Stone
	["Get 16 {item:12365}"] = "",
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["For 16 Dense Sharpening Stones."] = "",

	-- Step 61: Learn Dense Sharpening Stone
	-- {spell:16641} Dense Sharpening Stone
	["Learn {spell:16641}"] = "",

	-- Step 62: Craft 16 Dense Sharpening Stones until 235
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["Craft 16 Dense Sharpening Stones until 235"] = "",
	["About 16 crafts."] = "",

	-- Step 63: Get 336 Solid Stone
	-- {item:7912} Solid Stone
	["Get 336 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 84 Solid Grinding Stones."] = "",

	-- Step 64: Get 112 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 112 {item:3860}"] = "",
	-- {item:7969} Mithril Spurs · {skill:186} Mining
	["For 28 {item:7969}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 66: Craft 84 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 84 Solid Grinding Stones"] = "",

	-- Step 68: Craft 28 Mithril Spurs until 245
	-- {item:7969} Mithril Spurs
	["Craft 28 {item:7969} until 245"] = "",
	["About 28 crafts."] = "",

	-- Step 69: Get 72 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 72 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes. No {skill:186}? The bars, not the ore."] = "",

	-- Step 70: Get 12 Citrine
	-- {item:3864} Citrine
	["Get 12 {item:3864}"] = "",
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes."] = "",

	-- Step 71: Get 24 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 24 {item:4234}"] = "",

	-- Step 72: Learn Heavy Mithril Axe
	-- {spell:9993} Heavy Mithril Axe
	["Learn {spell:9993}"] = "",

	-- Step 74: Craft 6 Heavy Mithril Axes until 215
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["Craft 6 Heavy Mithril Axes until 215"] = "",
	["About 6 crafts. Weaponsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 75: Get 100 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 100 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs. No {skill:186}? The bars, not the ore."] = "",

	-- Step 76: Get 60 Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get 60 {item:4338}"] = "",
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs."] = "",

	-- Step 77: Learn Mithril Coif
	-- {spell:9961} Mithril Coif
	["Learn {spell:9961}"] = "",

	-- Step 79: Craft 10 Mithril Coifs until 225
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["Craft 10 Mithril Coifs until 225"] = "",
	["About 10 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 83: Get 154 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 154 {item:3860}"] = "",
	-- {item:7933} Heavy Mithril Boots · {skill:186} Mining
	["For 11 {item:7933}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 84: Get 44 Thick Leather
	-- {item:4304} Thick Leather
	["Get 44 {item:4304}"] = "",
	-- {item:7933} Heavy Mithril Boots
	["For 11 {item:7933}."] = "",

	-- Step 85: Learn Heavy Mithril Boots
	-- {spell:9968} Heavy Mithril Boots
	["Learn {spell:9968}"] = "",

	-- Step 87: Craft 11 Heavy Mithril Boots until 240
	-- {item:7933} Heavy Mithril Boots
	["Craft 11 {item:7933} until 240"] = "",
	["About 11 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 88: Get 5 Aquamarine
	-- {item:7909} Aquamarine
	["Get 5 {item:7909}"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts."] = "",

	-- Step 89: Get 30 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 30 {item:8170}"] = "",

	-- Step 90: Get 150 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 150 {item:12359}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 91: Reach level 50
	["Reach level 50"] = "",
	-- {quest:7652} A Blue Light Bargain
	["{quest:7652} asks for level 50."] = "",

	-- Step 92: Hand in A Blue Light Bargain
	-- {quest:7652} A Blue Light Bargain
	["Hand in {quest:7652}"] = "",

	-- Step 93: Hand in Imperial Plate Belt
	-- {quest:7653} Imperial Plate Belt
	["Hand in {quest:7653}"] = "",

	-- Step 94: Hand in Imperial Plate Bracer
	-- {quest:7655} Imperial Plate Bracer
	["Hand in {quest:7655}"] = "",

	-- Step 95: Learn Imperial Plate Belt
	-- {spell:16647} Imperial Plate Belt
	["Learn {spell:16647}"] = "",

	-- Step 97: Craft 5 Imperial Plate Belts until 245
	-- plural, as words: Imperial Plate Belts = {item:12424} Imperial Plate Belt
	["Craft 5 Imperial Plate Belts until 245"] = "",

	-- Step 98: Get 27 Star Ruby
	-- {item:7910} Star Ruby
	["Get 27 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 27 {item:12425}."] = "",

	-- Step 99: Get 560 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 560 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 27 {item:12425} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 103: Learn Imperial Plate Bracers
	-- {spell:16649} Imperial Plate Bracers
	["Learn {spell:16649}"] = "",

	-- Step 105: Craft 27 Imperial Plate Bracers until 270
	-- {item:12425} Imperial Plate Bracers
	["Craft 27 {item:12425} until 270"] = "",
	["About 27 crafts."] = "",

	-- Step 106: Buy Plans: Radiant Boots at the Auction House
	-- {item:12697} Plans: Radiant Boots
	["Buy {item:12697} at the Auction House"] = "",
	["The cheapest way to 300 when both plans are listed."] = "",

	-- Step 107: Buy Plans: Radiant Leggings at the Auction House
	-- {item:12713} Plans: Radiant Leggings
	["Buy {item:12713} at the Auction House"] = "",

	-- Step 108: Buy Plans: Thorium Leggings at the Auction House
	-- {item:12704} Plans: Thorium Leggings
	["Buy {item:12704} at the Auction House"] = "",
	["Next cheapest; the plans are learned at 275."] = "",

	-- Step 109: Learn Radiant Boots
	-- {spell:16656} Radiant Boots
	["Learn {spell:16656}"] = "",

	-- Step 110: Get 88 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 88 {item:7077}"] = "",
	-- {item:12419} Radiant Boots
	["For 22 {item:12419}."] = "",

	-- Step 111: Get 308 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 308 {item:12359}"] = "",
	-- {item:12419} Radiant Boots · {skill:186} Mining
	["For 22 {item:12419}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 113: Craft 22 Radiant Boots until 290
	-- {item:12419} Radiant Boots
	["Craft 22 {item:12419} until 290"] = "",
	["About 22 crafts."] = "",

	-- Step 114: Get 40 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 40 {item:7077}"] = "",
	-- {item:12420} Radiant Leggings
	["For 10 {item:12420}."] = "",

	-- Step 115: Get 200 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 200 {item:12359}"] = "",
	-- {item:12420} Radiant Leggings · {skill:186} Mining
	["For 10 {item:12420}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 116: Learn Radiant Leggings
	-- {spell:16725} Radiant Leggings
	["Learn {spell:16725}"] = "",

	-- Step 118: Craft 10 Radiant Leggings until 300
	-- {item:12420} Radiant Leggings
	["Craft 10 {item:12420} until 300"] = "",

	-- Step 123: Get 20 Star Ruby
	-- {item:7910} Star Ruby
	["Get 20 {item:7910}"] = "",
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658}."] = "",

	-- Step 124: Get 500 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 500 {item:12359}"] = "",
	-- {quest:7658} Imperial Plate Leggings · {skill:186} Mining
	["For 10 {quest:7658} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 125: Hand in Imperial Plate Leggings
	-- {quest:7658} Imperial Plate Leggings
	["Hand in {quest:7658}"] = "",

	-- Step 126: Learn Imperial Plate Leggings
	-- {spell:16730} Imperial Plate Leggings
	["Learn {spell:16730}"] = "",

	-- Step 128: Craft 10 Imperial Plate Leggings until 300
	-- {item:12429} Imperial Plate Leggings
	["Craft 10 {item:12429} until 300"] = "",

	-- Step 129: Get 11 Star Ruby
	-- {item:7910} Star Ruby
	["Get 11 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 11 {item:12425}."] = "",

	-- Step 130: Get 220 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 220 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 11 {item:12425}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 131: Learn Imperial Plate Bracers
	["Taught at 245; done at once if you learned it then."] = "",

	-- Step 133: Craft 11 Imperial Plate Bracers until 275
	-- {item:12425} Imperial Plate Bracers
	["Craft 11 {item:12425} until 275"] = "",
	["About 11 crafts."] = "",

	-- Step 134: Get 108 Red Power Crystal
	-- {item:11186} Red Power Crystal
	["Get 108 {item:11186}"] = "",
	-- {item:12414} Thorium Leggings
	["For 27 {item:12414}."] = "",

	-- Step 135: Get 702 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 702 {item:12359}"] = "",
	-- {item:12414} Thorium Leggings · {skill:186} Mining
	["For 27 {item:12414}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 136: Learn Thorium Leggings
	-- {spell:16662} Thorium Leggings
	["Learn {spell:16662}"] = "",

	-- Step 138: Craft 27 Thorium Leggings until 300
	-- {item:12414} Thorium Leggings
	["Craft 27 {item:12414} until 300"] = "",

	-- Step 139: Get 20 Aquamarine
	-- {item:7909} Aquamarine
	["Get 20 {item:7909}"] = "",
	-- {quest:7654} Imperial Plate Boots
	["For 20 {quest:7654}."] = "",

	-- Step 141: Get 720 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 720 {item:12359}"] = "",
	-- {quest:7654} Imperial Plate Boots · {skill:186} Mining
	["For 20 {quest:7654} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 142: Hand in Imperial Plate Boots
	-- {quest:7654} Imperial Plate Boots
	["Hand in {quest:7654}"] = "",

	-- Step 143: Learn Imperial Plate Boots
	-- {spell:16657} Imperial Plate Boots
	["Learn {spell:16657}"] = "",

	-- Step 145: Craft 20 Imperial Plate Boots until 290
	-- {item:12426} Imperial Plate Boots
	["Craft 20 {item:12426} until 290"] = "",
	["About 20 crafts."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "10 {item:12799} para {item:12773}: {item:12799} aparece más o menos en uno de cada 143 {object:175404}, {object:177388} o {object:180215}: guarda los que encuentres al minar.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} para {item:7933} y {item:7945}: {skill:393}: bestias de nivel 38-50. Despelleja aquí a {npc:2729}, {npc:2730}, {npc:2732} y {npc:2734} (nivel 38-50); la guía de {skill:393} traza esta ruta.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} para {item:7933} y {item:7945}: {skill:393}: bestias de nivel 38-50. Despelleja aquí a {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} y {npc:5296} (nivel 38-50); la guía de {skill:393} traza esta ruta.",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "168 {item:3575} para {spell:3501}: {skill:186}: funde {item:2772}.",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "19 {item:7909} para {quest:7654}: {item:7909} aparece más o menos en uno de cada 500 {object:2047} o {object:123309}: guarda los que encuentres al minar.",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "19 {item:7910} para {quest:7654}: {item:7910} aparece más o menos en uno de cada 143 {object:2047} o {object:123309}: guarda los que encuentres al minar.",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "195 {item:3859} para {item:6040}: {skill:186}: funde {item:3575} y carbón.",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "2026 {item:12359} para {item:12773}, {item:12775} y {quest:7654}: {skill:186}: funde {item:10620}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} para {item:12773} y {item:12775}: {skill:393}: bestias de nivel 48-60. Despelleja aquí a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} y {npc:6377} (nivel 48-60); la guía de {skill:393} traza esta ruta.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} para {item:12773} y {item:12775}: {skill:393}: bestias de nivel 48-60. Despelleja aquí a {npc:8598}, Can de peste y {npc:8596} (nivel 48-60); la guía de {skill:393} traza esta ruta.",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "210 {item:2840} para {spell:2666}: {skill:186}: funde {item:2770}.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "234 {item:2838} para {item:6040}: {skill:186}: {object:1735} (habilidad 125) en {zone:1417} (30-40), {zone:1434} (30-45) y {zone:1443} (30-40). Está marcado el grupo más denso de {object:1735} en {zone:1417}.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "234 {item:2838} para {item:6040}: {skill:186}: {object:1735} (habilidad 125) en {zone:1441} (25-35), {zone:1417} (30-40) y {zone:1434} (30-45). Está marcado el grupo más denso de {object:1735} en {zone:1441}.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (habilidad 65). Está marcado el grupo más denso de {object:1732} en {zone:1413}.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (habilidad 65). Está marcado el grupo más denso de {object:1732} en {zone:1421}.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (habilidad 65). Está marcado el grupo más denso de {object:1732} en {zone:1432}.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (habilidad 65). Está marcado el grupo más denso de {object:1732} en {zone:1436}.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (habilidad 65). Está marcado el grupo más denso de {object:1732} en {zone:1439}.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (habilidad 125). Está marcado el grupo más denso de {object:1735} en {zone:1413}.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (habilidad 125). Está marcado el grupo más denso de {object:1735} en {zone:1417}.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (habilidad 125). Está marcado el grupo más denso de {object:1735} en {zone:1440}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1411}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1412}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1420}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1426}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1429}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:1439}.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "286 {item:2835} para {spell:2660} y {spell:3320} (116 de ellos para 75-150: recógelos todos ahora): {skill:186}: {object:1731} (habilidad 1). Está marcado el grupo más denso de {object:1731} en {zone:2521}.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "30 {item:7912} para {item:7964}: {skill:186}: {object:2040} (habilidad 175) en {zone:1434} (30-45), {zone:1425} (40-50) y {zone:1444} (40-50). Está marcado el grupo más denso de {object:2040} en {zone:1434}.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "30 {item:7912} para {item:7964}: {skill:186}: {object:2040} (habilidad 175) en {zone:1443} (30-40), {zone:1425} (40-50) y {zone:1444} (40-50). Está marcado el grupo más denso de {object:2040} en {zone:1443}.",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "320 {item:2841} para {spell:2672}: {skill:186}: funde {item:2840} y {item:3576}.",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "320 {item:3860} para {item:7930}: {skill:186}: funde {item:3858}.",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "44 {item:1210} para {item:7945}: {item:1210} aparece más o menos en uno de cada 100 {object:1731}, {object:1732} o {object:1733}: guarda los que encuentres al minar.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "44 {item:7912} para {item:7945}: {skill:186}: {object:2040} (habilidad 175) en {zone:1425} (40-50), {zone:1444} (40-50) y {zone:1447} (45-55). Está marcado el grupo más denso de {object:2040} en {zone:1425}.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "44 {item:7912} para {item:7945}: {skill:186}: {object:2040} (habilidad 175) en {zone:1443} (30-40), {zone:1425} (40-50) y {zone:1444} (40-50). Está marcado el grupo más denso de {object:2040} en {zone:1443}.",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "596 {item:3860} para {item:7933} y {item:7945}: {skill:186}: funde {item:3858}.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "801 {item:12365} para {item:12643}, {item:12773} y {item:12775}: {skill:186}: {object:324} (habilidad 245) en {zone:1419} (45-55), {zone:1448} (48-55) y {zone:1452} (55-60). Está marcado el grupo más denso de {object:324} en {zone:1419}.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "801 {item:12365} para {item:12643}, {item:12773} y {item:12775}: {skill:186}: {object:324} (habilidad 245) en {zone:1448} (48-55), {zone:1451} (55-60) y {zone:1452} (55-60). Está marcado el grupo más denso de {object:324} en {zone:1448}.",
	-- ["Apprentice {skill:164}"] = "Aprendiz de {skill:164}",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "Aprendiz de {skill:164} te deja fabricar hasta 75 por 10c, con cualquier nivel de personaje. Cualquier instructor de {skill:164} de tu facción lo enseña; la flecha elige el más cercano. Compra un {item:5956} (cualquier proveedor de herrería) y combínala con {skill:186}: {item:2835} y {item:2770} salen de las vetas de cobre de todas las zonas iniciales. De 1 a 75 hacen falta unos 1s en recetas, además de 286 {item:2835} que recolectar o comprar.",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Artesano requiere nivel de personaje 35 y {skill:164} 200; sube el límite a 300. Los materiales para 225-300 valen unos 942g en total.",
	-- ["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "Artesano sube el límite de 225 a 300 por 5g (precio de Classic; el de Forever no está en los datos); requiere {skill:164} 200 y nivel de personaje 35, así que puedes aprenderlo en cualquier visita a partir de 200. Solo lo enseñan unos pocos instructores: Alianza: {npc:2836} ({zone:1434}); Horda: {npc:2836} ({zone:1434}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:16640} (desde 225), {spell:9968} (desde 210), {spell:9920} (desde 175), {spell:10001} (desde 205) y {spell:16639} (desde 225). De 225 a 300 hacen falta unos 3g 60s en recetas, además de 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} y 10 {item:12799} que recolectar o comprar.",
	-- ["Artisan {skill:164}"] = "Artesano de {skill:164}",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Vuelve con un instructor de {skill:164}: {spell:16639} se enseña a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Vuelve con un instructor de {skill:164}: {spell:16640} se enseña a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Vuelve con un instructor de {skill:164}: {spell:2666} se enseña a partir de {skill:164} 80.",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Vuelve con un instructor de {skill:164}: {spell:2668} se enseña a partir de {skill:164} 95.",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "Vuelve con un instructor de {skill:164}: {spell:2672} (desde 95, 5s).",
	-- ["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Vuelve con un instructor de {skill:164}: {spell:2672} se enseña a partir de {skill:164} 120.",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "Vuelve con un instructor de {skill:164}: {spell:2674} (desde 100, 10s).",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Vuelve con un instructor de {skill:164}: {spell:3117} se enseña a partir de {skill:164} 100.",
	-- ["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "Vuelve con un instructor de {skill:164}: {spell:3320} (desde 25, 1s). Aprende también {spell:1230171} (1s): el objeto de campamento de {skill:164} de Forever, con 1 {item:2835} y 1 {item:2840}, que se coloca en un campamento junto a una hoguera para obtener su beneficio. La misión “Campamento básico: {skill:164}” del guía de campamento de tu zona inicial (después de “Bendita naturaleza”) te envía a un instructor de herrería que lo enseña gratis.",
	-- ["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Vuelve con un instructor de {skill:164}: {spell:3320} se enseña a partir de {skill:164} 45.",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "Vuelve con un instructor de {skill:164}: {spell:7223} (desde 160).",
	-- ["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Vuelve con un instructor de {skill:164}: {spell:7223} se enseña a partir de {skill:164} 185.",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Vuelve con un instructor de {skill:164}: {spell:9916} se enseña a partir de {skill:164} 200.",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "Vuelve con un instructor de {skill:164}: {spell:9918} (desde 175).",
	-- ["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Vuelve con un instructor de {skill:164}: {spell:9918} se enseña a partir de {skill:164} 175.",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Vuelve con un instructor de {skill:164}: {spell:9920}, {spell:9935} se enseñan a partir de {skill:164} 210.",
	-- ["Back to a {skill:164} trainer: {spell:9959} (from 205)."] = "Vuelve con un instructor de {skill:164}: {spell:9959} (desde 205).",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Vuelve con un instructor de {skill:164}: {spell:9968} se enseña a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Vuelve con un instructor de {skill:164}: {spell:9985} se enseña a partir de {skill:164} 155.",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Compra de una vez todo lo de este tramo: 28 {item:2605} (28s); unos 28s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} y {npc:5817}). Si fundes tú mismo las 195 {item:3859} ({skill:186} 165: un {item:3575} y un carbón cada una), compra también 195 de carbón (9g 75s, proveedores de comercio y de herrería); sáltatelo si compras las barras.",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Compra de una vez todo lo de este tramo: {item:5956} (una herramienta: uno, guárdalo en tus bolsas, 18c); unos 18c en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:5519}, {npc:1286} y {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} y {npc:3413}).",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Experto requiere nivel de personaje 20 y {skill:164} 125; sube el límite a 225. Los materiales para 150-225 valen unos 42g en total.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Experto sube el límite de 150 a 225 por 50s (precio de Classic; el de Forever no está en los datos); requiere {skill:164} 125 y nivel de personaje 20, así que puedes aprenderlo en cualquier visita a partir de 125. Solo lo enseñan unos pocos instructores: Alianza: {npc:4258} ({zone:1455}); Horda: {npc:3355} ({zone:1454}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:3501} (desde 140) y {spell:3337} (desde 100, 10s). De 150 a 225 hacen falta unos 10s en recetas y 28s en artículos de mercader, además de 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} y 30 {item:7912} que recolectar o comprar.",
	-- ["Expert {skill:164}"] = "Experto de {skill:164}",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Oficial requiere nivel de personaje 10 y {skill:164} 50; sube el límite a 150. Los materiales para 75-150 valen unos 9g 41s en total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Oficial sube el límite de 75 a 150 por 5s; requiere {skill:164} 50 y nivel de personaje 10, así que puedes aprenderlo en cualquier visita a partir de 50. No todos los instructores de {skill:164} lo enseñan: Alianza: {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) y {npc:5511} ({zone:1453}); Horda: {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) y {npc:3478} ({zone:1413}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:2666} (desde 45, 2s) y {spell:3326} (desde 50, 2s 50c). De 75 a 150 hacen falta unos 19s 50c en recetas y 18c en artículos de mercader, además de 256 {item:2836}, 28 {item:2838}, 210 {item:2840} y 320 {item:2841} que recolectar o comprar.",
	-- ["Journeyman {skill:164}"] = "{skill:164} de oficial",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el lugar de farmeo que Polestar elige para tu nivel y facción. También sirve la casa de subastas.",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Naranja (un punto por creación) hasta 120, amarillo hasta 135, verde hasta 150. Requiere un yunque cerca.",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 125, amarillo hasta 140, verde hasta 155. Requiere un yunque cerca. {skill:164} 150 es un hito del Sistema de Legado.",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Naranja (un punto por creación) hasta 15, amarillo hasta 35, verde hasta 55.",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Naranja (un punto por creación) hasta 260, amarillo hasta 270, verde hasta 280. Requiere un yunque cerca.",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 280, amarillo hasta 292, verde hasta 305. Requiere un yunque cerca. {skill:164} 300 es un hito del Sistema de Legado.",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Naranja (un punto por creación) hasta 85, amarillo hasta 105, verde hasta 125. Requiere un yunque cerca.",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:8831} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:1815}, {npc:1816}, {npc:1817} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384}, {npc:2354} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú mismo o cómpralos en la casa de subastas.",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "Enseña {item:12775} (requiere {skill:164} 255).",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "Enseña {item:250562} (requiere {skill:164} 240).",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "Lo que vende la casa de subastas para 1-75: 286 {item:2835}. Las cantidades bajan según lo que tengas en tus bolsas, banco y correo.",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "Lo que vende la casa de subastas para 150-225: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} y 30 {item:7912}. Las cantidades bajan según lo que tengas en tus bolsas, banco y correo.",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "Lo que vende la casa de subastas para 225-300: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} y 10 {item:12799}. Las cantidades bajan según lo que tengas en tus bolsas, banco y correo.",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "Lo que vende la casa de subastas para 75-150: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} y 320 {item:2841}. Las cantidades bajan según lo que tengas en tus bolsas, banco y correo.",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "Amarillo hasta 107, verde hasta 115: no todas las creaciones dan un punto.",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 155, verde hasta 170: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 170, verde hasta 185: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "Amarillo hasta 180, verde hasta 185: no todas las creaciones dan un punto.",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 197, verde hasta 210: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 212, verde hasta 225: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Amarillo hasta 220, verde hasta 230: no todas las creaciones dan un punto. Requiere un yunque cerca. {skill:164} 225 es un hito del Sistema de Legado.",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "Amarillo hasta 232, verde hasta 235: no todas las creaciones dan un punto.",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 235, verde hasta 245: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 240, verde hasta 250: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "Amarillo hasta 65, verde hasta 85: no todas las creaciones dan un punto.",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 65, verde hasta 85: no todas las creaciones dan un punto. 75 es el límite de Aprendiz.",
	-- ["a tool, keep it in your bags"] = "una herramienta, guárdala en tus bolsas",
	-- ["from the pattern bought at the Auction House"] = "del patrón comprado en la casa de subastas",
	-- ["from the recipe in your bags"] = "con la receta de tus bolsas",
	-- ["{item:12365} (Alliance)"] = "{item:12365} (Alianza)",
	-- ["{item:12365} (Horde)"] = "{item:12365} (Horda)",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} se obtiene de nodos de {object:324} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426} es naranja a 285 (amarillo 290, verde 300, gris 310): unas 19 fabricaciones hasta 300. Cada una lleva 34 {item:12359}, 1 {item:7910} y 1 {item:7909}. Unas 34 barras de torio por fabricación, frente a las 40 del hacha de batalla y sus piedras de afilar; naranja hasta 290. Por debajo del nivel de personaje 50, {npc:14567} no tiene misión para ti: sigue haciendo hachas de batalla de torio enormes hasta 300 (amarillas hasta 292, grises a 305: más o menos el doble de barras de torio). Requiere un yunque cerca. {skill:164} 300 es un hito del Sistema de Legado.",
	-- ["{item:12426} to 300"] = "{item:12426} hasta 300",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643} es naranja a 225 (amarillo 230, verde 232, gris 235): unas 17 fabricaciones hasta 235. Cada una lleva 1 {item:12365}. Una {item:12365} por fabricación (vetas de torio): puntos baratos al principio de Artesano.",
	-- ["{item:12643} to 235"] = "{item:12643} hasta 235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} es naranja a 250 (amarillo 275, verde 287, gris 300): unas 5 fabricaciones hasta 255, un punto por fabricación. Cada una lleva 20 {item:12359}, 2 {item:12799}, 2 {item:12644} y 4 {item:8170}. Haz primero los 10 {item:12644}. {item:12799} aparece más o menos en una de cada 130 vetas de torio: compra las diez en la casa de subastas. Solo cinco fabricaciones, hasta que puedas usar los planos del hacha de batalla a 255. Requiere un yunque cerca.",
	-- ["{item:12773} to 255"] = "{item:12773} hasta 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} es naranja a 255 (amarillo 280, verde 292, gris 305): unas 31 fabricaciones hasta 285. Cada una lleva 40 {item:12359}, 6 {item:12644} y 6 {item:8170}. Haz primero los 186 {item:12644}. Planos de {npc:11278} ({area:2298}, {zone:1422}), existencias ilimitadas, pero se ligan al recogerlos. Cuarenta barras de torio y seis piedras de afilar densas por fabricación: el tramo más caro, así que detente donde {quest:7654} toman el relevo. Otras formas de avanzar: planos de botín del mundo en la casa de subastas (las piezas Radiantes: unas 820 barras de torio y 190 corazones de fuego para la ruta Radiante) o los conjuntos del Favor del mercader. Requiere un yunque cerca.",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} es naranja en 255 (amarillo 280, verde 292, gris 305): unas 31 fabricaciones hasta 285. Cada una lleva 40 {item:12359}, 6 {item:12644} y 6 {item:8170}. Haz primero las 186 {item:12644}. Diseños de {npc:11278} en {area:2298} ({zone:1422}): es un fantasma que solo ves con el abalorio {item:13544} equipado (póntelo dentro de {area:2298}), la recompensa de la cadena de {npc:11216} en {area:2057} que termina con {npc:10506} (nivel 55, un grupo de calabozo). Existencias ilimitadas, pero los diseños se ligan al recogerlos. Cuarenta barras de torio y seis piedras de pulir densas por fabricación: el tramo más caro, así que para donde tomen el relevo {quest:7654}. Sin el abalorio, las otras vías: diseños de botín del mundo en la casa de subastas (las piezas radiantes: unos 820 barras de torio y 190 corazones de fuego para la vía radiante) o los conjuntos del Favor de los mercaderes. Necesita un yunque cerca.",
	-- ["{item:12775} to 285"] = "{item:12775} hasta 285",
	-- ["{item:12775} to 300"] = "{item:12775} hasta 300",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "{item:12819} enseña {item:12773} ({skill:164} 250) por 1g 60s. Lo venden {npc:11278} ({zone:1422}).",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819} enseña {item:12773} ({skill:164} 250) por 1 o 60 p. Lo vende {npc:11278} ({zone:1422}). {npc:11278} es un fantasma: solo lo ves con {item:13544} equipado (de la cadena de {npc:11216} en {area:2057}, nivel 55, en grupo), así que omítelo sin él.",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "{item:12823} enseña {item:12775} ({skill:164} 255) por 2g. Lo venden {npc:11278} ({zone:1422}).",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823} enseña {item:12775} ({skill:164} 255) por 2 o. Lo vende {npc:11278} ({zone:1422}). {npc:11278} es un fantasma: solo lo ves con {item:13544} equipado (de la cadena de {npc:11216} en {area:2057}, nivel 55, en grupo), así que omítelo sin él.",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- ["{item:250562} to 268"] = "{item:250562} hasta 268",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Alianza)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Horda)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} se obtiene de nodos de {object:1731} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (Alianza)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (Horda)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} se obtiene de nodos de {object:1732} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (Alianza)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (Horda)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} se obtiene de nodos de {object:1735} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Alianza)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: una herramienta, guárdala en tus bolsas",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040} es amarillo a 185 (amarillo 185, verde 197, gris 210): unas 39 fabricaciones hasta 205. Cada una lleva 5 {item:3859} y 2 {spell:3337}. Haz primero los 78 {spell:3337}. Las barras de acero se funden con un {item:3575} y un carbón ({skill:186} 165; el carbón, de los proveedores de comercio y de herrería), así que cada brazal lleva cinco de cada uno. Cada brazal lleva dos piedras de afilar pesadas: hazlas primero. Especialización (opcional): a 200 y nivel de personaje 40, {npc:5164} ({zone:1455}) o {npc:11177} ({zone:1454}) inicia El arte del {spell:9788}: 4 yelmos de mitril adornados, 2 {item:7936} y un {item:7935}, cuyos planos salen de una cadena de misiones de la Orden del Mitril. {npc:11146} ({zone:1455}) o {npc:11178} ({zone:1454}) inicia El camino del forjador de armas: 4 espadones de acero lunar, 4 hachas de hierro enormes, 2 hachas de mitril pesadas y 2 mazas negras grandes; en Forever, los planos de {item:3853} ({npc:2482}, {area:35}) y de {item:3855} se ligan al recogerlos, así que cómpralos y úsalos tú mismo. Solo puedes elegir una; ninguna hace falta para llegar a 300, y la beta nunca las probó (se detuvo en el nivel 30). Requiere un yunque cerca.",
	-- ["{item:6040} to 200"] = "{item:6040} hasta 200",
	-- ["{item:6040} to 205"] = "{item:6040} hasta 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (Alianza)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (Horda)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} se obtiene de nodos de {object:2040} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:7922} to 225"] = "{item:7922} hasta 225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930} es naranja a 205 (amarillo 225, verde 235, gris 245): unas 20 fabricaciones hasta 225, un punto por fabricación. Cada una lleva 16 {item:3860}. Dieciséis barras de mitril por fabricación y nada más; naranja hasta 225 en Forever, así que un punto por fabricación hasta el límite de Artesano. Requiere un yunque cerca. {skill:164} 225 es un hito del Sistema de Legado.",
	-- ["{item:7930} to 225"] = "{item:7930} hasta 225",
	-- ["{item:7931} to 230"] = "{item:7931} hasta 230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933} es amarillo a 235 (amarillo 230, verde 240, gris 250): unas 30 fabricaciones hasta 247. Cada una lleva 14 {item:3860} y 4 {item:4304}. Barras de mitril, de los depósitos de mitril; {item:4304}, de los desolladores o la casa de subastas. Requiere un yunque cerca.",
	-- ["{item:7933} to 244"] = "{item:7933} hasta 244",
	-- ["{item:7933} to 247"] = "{item:7933} hasta 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945} es verde a 247 (amarillo 230, verde 242, gris 255): unas 11 fabricaciones hasta 250. Cada una lleva 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} y 2 {item:4304}. Haz primero los 11 {item:7966}. Solo unas 11 fabricaciones para cubrir 247-250, pero cada una pide cuatro gemas de las Sombras (más o menos una de cada cien {object:1732}) y una {item:7971}: cómpralas en la casa de subastas, salvo que ya las tengas en las bolsas. Requiere un yunque cerca. {item:7971} (11 para 225-300): {item:7971} es un botín raro (ningún enemigo lo suelta ni una vez de cada 50): cómpralo en la casa de subastas, o guarda los que encuentres.",
	-- ["{item:7945} to 250"] = "{item:7945} hasta 250",
	-- ["{item:7956} to 175"] = "{item:7956} hasta 175",
	-- ["{item:7963} to 210"] = "{item:7963} hasta 210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964} es amarillo a 175 (amarillo 175, verde 180, gris 185): unas 30 fabricaciones hasta 185. Cada una lleva 1 {item:7912}. Una {item:7912} por fabricación (depósitos de mitril): puntos baratos entre los brazales de hierro y los de acero. Usa las piedras en tus armas o véndelas.",
	-- ["{item:7964} to 185"] = "{item:7964} hasta 185",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (Alianza)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (Horda)",
	-- ["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "{npc:14567} ({zone:1446}) cambia {item:12700} ({skill:164} 270) por 40 {item:12359} en {quest:7654}, que requiere {skill:164} 265 y nivel de personaje 50; toma primero {quest:7652} (no pide nada). Los planos se ligan al recogerlos.",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75: casa de subastas",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225: casa de subastas",
	-- ["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225: artículos de mercader",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300: casa de subastas",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150: casa de subastas",
	-- ["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150: artículos de mercader",
	-- ["{skill:164} materials for 150-225"] = "Materiales de {skill:164} para 150-225",
	-- ["{skill:164} materials for 225-300"] = "Materiales de {skill:164} para 225-300",
	-- ["{skill:164} materials for 75-150"] = "Materiales de {skill:164} para 75-150",
	-- ["{skill:164} recipes at 100"] = "Recetas de {skill:164} a 100",
	-- ["{skill:164} recipes at 112"] = "Recetas de {skill:164} a 112",
	-- ["{skill:164} recipes at 113"] = "Recetas de {skill:164} a 113",
	-- ["{skill:164} recipes at 121"] = "Recetas de {skill:164} a 121",
	-- ["{skill:164} recipes at 155"] = "Recetas de {skill:164} a 155",
	-- ["{skill:164} recipes at 175"] = "Recetas de {skill:164} a 175",
	-- ["{skill:164} recipes at 185"] = "Recetas de {skill:164} a 185",
	-- ["{skill:164} recipes at 200"] = "Recetas de {skill:164} a 200",
	-- ["{skill:164} recipes at 205"] = "Recetas de {skill:164} a 205",
	-- ["{skill:164} recipes at 210"] = "Recetas de {skill:164} a 210",
	-- ["{skill:164} recipes at 230"] = "Recetas de {skill:164} a 230",
	-- ["{skill:164} recipes at 235"] = "Recetas de {skill:164} a 235",
	-- ["{skill:164} recipes at 268"] = "Recetas de {skill:164} a 268",
	-- ["{skill:164} recipes at 35"] = "Recetas de {skill:164} a 35",
	-- ["{skill:164} recipes at 45"] = "Recetas de {skill:164} a 45",
	-- ["{skill:164} recipes at 83"] = "Recetas de {skill:164} a 83",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 17s en total.",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funde {item:10620} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funde {item:2770} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: funde {item:2775} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funde {item:2840} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funde {item:3575} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funde {item:3858} (o la casa de subastas)",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (o la casa de subastas)",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393} (o la casa de subastas)",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660} es naranja a 1 (amarillo 15, verde 35, gris 55): unas 42 fabricaciones hasta 35. Cada una lleva 1 {item:2835}. Una {item:2835} por fabricación, un punto por fabricación hasta 15.",
	-- ["{spell:2660} to 35"] = "{spell:2660} hasta 35",
	-- ["{spell:2660} to 45"] = "{spell:2660} hasta 45",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} es naranja a 83 (amarillo 85, verde 105, gris 125): unas 21 fabricaciones hasta 100. Cada una lleva 10 {item:2840}. En Forever, {spell:2666} se enseña desde 45; sigue naranja hasta 85. Diez barras de cobre por fabricación: funde tu {item:2770}. Requiere un yunque cerca. {item:5956} es una herramienta: guárdalo en tus bolsas.",
	-- ["{spell:2666} to 100"] = "{spell:2666} hasta 100",
	-- ["{spell:2668} to 121"] = "{spell:2668} hasta 121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672} es naranja a 113 (amarillo 125, verde 140, gris 155): unas 64 fabricaciones hasta 150. Cada una lleva 5 {item:2841} y 2 {spell:3326}. Haz primero los 128 {spell:3326}. Cada brazal lleva dos piedras de afilar bastas ({item:2836}, de las vetas de estaño): hazlas primero; también dan puntos. Requiere un yunque cerca. {skill:164} 150 es un hito del Sistema de Legado.",
	-- ["{spell:2672} to 150"] = "{spell:2672} hasta 150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674} es amarillo a 100 (amarillo 100, verde 107, gris 115): unas 28 fabricaciones hasta 113. Cada una lleva 1 {item:2838}. {item:2838} sale de los depósitos de hierro; una por fabricación.",
	-- ["{spell:2674} to 113"] = "{spell:2674} hasta 113",
	-- ["{spell:3117} to 112"] = "{spell:3117} hasta 112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} es verde a 75 (amarillo 45, verde 65, gris 85): unas 58 fabricaciones hasta 83. Cada una lleva 2 {item:2835}. Dos {item:2835} por fabricación. Las piedras de afilar son piezas para planos posteriores; las que sobren se venden a los mercaderes.",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320} es verde en 75 (amarillo 45, verde 65, gris 85): unas 58 fabricaciones hasta 83. Cada una lleva 2 {item:2835}. Dos {item:2835} por fabricación. Las piedras de afilar son piezas para diseños posteriores; las que sobren se venden a mercaderes. Si llegaste aquí sin aprender {spell:3320}, apréndelo ahora: lo enseña un paso anterior.",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} es naranja a 35 (amarillo 45, verde 65, gris 85): unas 64 fabricaciones hasta 75. Cada una lleva 2 {item:2835}. Dos {item:2835} por fabricación. Las piedras de afilar son piezas para planos posteriores; las que sobren se venden a los mercaderes.",
	-- ["{spell:3320} to 75"] = "{spell:3320} hasta 75",
	-- ["{spell:3320} to 83"] = "{spell:3320} hasta 83",
	-- ["{spell:3333} to 155"] = "{spell:3333} hasta 155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501} es naranja a 150 (amarillo 165, verde 177, gris 190): unas 28 fabricaciones hasta 175. Cada una lleva 6 {item:3575} y 1 {item:2605}. Seis barras de hierro y un {item:2605} por fabricación; {item:2605} se compra a los mercaderes de sastrería, peletería y suministros de comercio. Naranja hasta 165 en Forever, así que un punto por fabricación durante los primeros quince. Requiere un yunque cerca.",
	-- ["{spell:3501} to 175"] = "{spell:3501} hasta 175",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (desde 205) solo lo enseñan los instructores de Artesano: Alianza {npc:2836} ({zone:1434}); Horda {npc:2836} ({zone:1434}). Puedes entrenar Artesano ahí ahora si eres de nivel 35 (requiere {skill:164} 200), lo que te ahorra el viaje a 225.",
}
