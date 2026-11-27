-- Russian (ruRU): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "Изучите: {skill:164}",
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

	-- Step 23: Craft 10 Patterned Bronze Bracers until 125
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 10 {spell:2672} until 125"] = "",
	["About 10 crafts."] = "",

	-- Step 24: Get 120 Bronze Bar
	-- {item:2841} Bronze Bar
	["Get 120 {item:2841}"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets · {skill:186} Mining
	["For 15 {spell:3333}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 25: Get 15 Silver Bar
	-- {item:2842} Silver Bar
	["Get 15 {item:2842}"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets
	["For 15 {spell:3333}."] = "",

	-- Step 26: Learn Silvered Bronze Gauntlets
	-- {spell:3333} Silvered Bronze Gauntlets
	["Learn {spell:3333}"] = "",

	-- Step 28: Craft 15 Silvered Bronze Gauntlets until 140
	-- {spell:3333} Silvered Bronze Gauntlets
	["Craft 15 {spell:3333} until 140"] = "",
	-- {item:2842} Silver Bar
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["About 15 crafts. {item:2842} dear? 15 Bronze Warhammers reach 140 too."] = "",

	-- Step 29: Buy 40 Green Dye
	-- {item:2605} Green Dye
	["Buy 40 {item:2605}"] = "",
	-- {spell:3501} Green Iron Bracers
	["For 40 {spell:3501}."] = "",

	-- Step 30: Get 240 Iron Bar
	-- {item:3575} Iron Bar
	["Get 240 {item:3575}"] = "",
	-- {spell:3501} Green Iron Bracers · {skill:186} Mining
	["For 40 {spell:3501}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 31: Train Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Expert {skill:164}"] = "",
	["Needs level 20."] = "",

	-- Step 32: Learn Green Iron Bracers
	-- {spell:3501} Green Iron Bracers
	["Learn {spell:3501}"] = "",

	-- Step 34: Craft 40 Green Iron Bracers until 175
	-- {spell:3501} Green Iron Bracers
	["Craft 40 {spell:3501} until 175"] = "",
	["About 40 crafts."] = "",

	-- Step 35: Get 60 Solid Stone
	-- {item:7912} Solid Stone
	["Get 60 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone · Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["For 8 Solid Grinding Stones and 28 Solid Sharpening Stones."] = "",

	-- Step 36: Learn Solid Grinding Stone
	-- {spell:9920} Solid Grinding Stone
	["Learn {spell:9920}"] = "",

	-- Step 37: Craft 8 Solid Grinding Stones until 180
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 8 Solid Grinding Stones until 180"] = "",
	["About 8 crafts. Keep all 8 for the step at 210."] = "",

	-- Step 38: Learn Solid Sharpening Stone
	-- {spell:9918} Solid Sharpening Stone
	["Learn {spell:9918}"] = "",

	-- Step 39: Craft 28 Solid Sharpening Stones until 185
	-- plural, as words: Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["Craft 28 Solid Sharpening Stones until 185"] = "",
	["About 28 crafts. Green from 180: short of 185? A few more do it."] = "",

	-- Step 40: Buy 75 Coal
	["Buy 75 Coal"] = "",
	-- {item:3859} Steel Bar
	["Smelting {item:3859} takes 1 Coal a bar."] = "",

	-- Step 41: Get 75 Steel Bar
	-- {item:3859} Steel Bar
	["Get 75 {item:3859}"] = "",
	-- {item:6040} Golden Scale Bracers · {skill:186} Mining
	["For 15 {item:6040}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 42: Learn Golden Scale Bracers
	-- {spell:7223} Golden Scale Bracers
	["Learn {spell:7223}"] = "",

	-- Step 44: Craft 15 Golden Scale Bracers until 195
	-- {item:6040} Golden Scale Bracers
	["Craft 15 {item:6040} until 195"] = "",
	["About 15 crafts. Alliance smiths who want Armorsmithing later: keep 6."] = "",

	-- Step 45: Get 204 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 204 {item:3860}"] = "",
	-- {item:7920} Mithril Plate Pants · {skill:186} Mining
	["For 17 {item:7920}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 46: Learn Mithril Plate Pants
	-- {spell:9931} Mithril Plate Pants
	["Learn {spell:9931}"] = "",

	-- Step 48: Craft 17 Mithril Plate Pants until 210
	-- {item:7920} Mithril Plate Pants
	["Craft 17 {item:7920} until 210"] = "",
	["About 17 crafts. Armorsmith or Weaponsmith opens at 200 and level 40; optional."] = "",

	-- Step 49: Train Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Artisan {skill:164}"] = "",
	["Needs level 35."] = "",

	-- Step 50: Buy Plans: Mithril Spurs at the Auction House
	-- {item:7989} Plans: Mithril Spurs
	["Buy {item:7989} at the Auction House"] = "",
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Saves about 130 Thorium and 150 Mithril Bars."] = "",
	["None listed, or too dear"] = "",

	-- Step 51: Learn Mithril Spurs
	-- {spell:9964} Mithril Spurs
	["Learn {spell:9964}"] = "",
	["From the plans in your bags."] = "",

	-- Step 52: Get 148 Solid Stone
	-- {item:7912} Solid Stone
	["Get 148 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 37 Solid Grinding Stones."] = "",

	-- Step 53: Get 60 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 60 {item:3860}"] = "",
	-- {item:7969} Mithril Spurs · {skill:186} Mining
	["For 15 {item:7969}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 54: Craft 37 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 37 Solid Grinding Stones"] = "",
	["Parts for the spurs; no skill points from these."] = "",

	-- Step 56: Craft 15 Mithril Spurs until 225
	-- {item:7969} Mithril Spurs
	["Craft 15 {item:7969} until 225"] = "",
	["About 15 crafts."] = "",

	-- Step 57: Get 16 Dense Stone
	-- {item:12365} Dense Stone
	["Get 16 {item:12365}"] = "",
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["For 16 Dense Sharpening Stones."] = "",

	-- Step 58: Learn Dense Sharpening Stone
	-- {spell:16641} Dense Sharpening Stone
	["Learn {spell:16641}"] = "",

	-- Step 59: Craft 16 Dense Sharpening Stones until 235
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["Craft 16 Dense Sharpening Stones until 235"] = "",
	["About 16 crafts."] = "",

	-- Step 60: Get 336 Solid Stone
	-- {item:7912} Solid Stone
	["Get 336 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 84 Solid Grinding Stones."] = "",

	-- Step 61: Get 112 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 112 {item:3860}"] = "",
	-- {item:7969} Mithril Spurs · {skill:186} Mining
	["For 28 {item:7969}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 62: Craft 84 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 84 Solid Grinding Stones"] = "",

	-- Step 64: Craft 28 Mithril Spurs until 245
	-- {item:7969} Mithril Spurs
	["Craft 28 {item:7969} until 245"] = "",
	["About 28 crafts."] = "",

	-- Step 65: Get 72 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 72 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes. No {skill:186}? The bars, not the ore."] = "",

	-- Step 66: Get 12 Citrine
	-- {item:3864} Citrine
	["Get 12 {item:3864}"] = "",
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes."] = "",

	-- Step 67: Get 24 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 24 {item:4234}"] = "",

	-- Step 68: Learn Heavy Mithril Axe
	-- {spell:9993} Heavy Mithril Axe
	["Learn {spell:9993}"] = "",

	-- Step 70: Craft 6 Heavy Mithril Axes until 215
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["Craft 6 Heavy Mithril Axes until 215"] = "",
	["About 6 crafts. Weaponsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 71: Get 100 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 100 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs. No {skill:186}? The bars, not the ore."] = "",

	-- Step 72: Get 60 Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get 60 {item:4338}"] = "",
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs."] = "",

	-- Step 73: Learn Mithril Coif
	-- {spell:9961} Mithril Coif
	["Learn {spell:9961}"] = "",

	-- Step 75: Craft 10 Mithril Coifs until 225
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["Craft 10 Mithril Coifs until 225"] = "",
	["About 10 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 79: Get 154 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 154 {item:3860}"] = "",
	-- {item:7933} Heavy Mithril Boots · {skill:186} Mining
	["For 11 {item:7933}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 80: Get 44 Thick Leather
	-- {item:4304} Thick Leather
	["Get 44 {item:4304}"] = "",
	-- {item:7933} Heavy Mithril Boots
	["For 11 {item:7933}."] = "",

	-- Step 81: Learn Heavy Mithril Boots
	-- {spell:9968} Heavy Mithril Boots
	["Learn {spell:9968}"] = "",

	-- Step 83: Craft 11 Heavy Mithril Boots until 240
	-- {item:7933} Heavy Mithril Boots
	["Craft 11 {item:7933} until 240"] = "",
	["About 11 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 84: Get 5 Aquamarine
	-- {item:7909} Aquamarine
	["Get 5 {item:7909}"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts."] = "",

	-- Step 85: Get 30 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 30 {item:8170}"] = "",

	-- Step 86: Get 150 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 150 {item:12359}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 87: Reach level 50
	["Reach level 50"] = "",
	-- {quest:7652} A Blue Light Bargain
	["{quest:7652} asks for level 50."] = "",

	-- Step 88: Hand in A Blue Light Bargain
	-- {quest:7652} A Blue Light Bargain
	["Hand in {quest:7652}"] = "",

	-- Step 89: Hand in Imperial Plate Belt
	-- {quest:7653} Imperial Plate Belt
	["Hand in {quest:7653}"] = "",

	-- Step 90: Hand in Imperial Plate Bracer
	-- {quest:7655} Imperial Plate Bracer
	["Hand in {quest:7655}"] = "",

	-- Step 91: Learn Imperial Plate Belt
	-- {spell:16647} Imperial Plate Belt
	["Learn {spell:16647}"] = "",

	-- Step 93: Craft 5 Imperial Plate Belts until 245
	-- plural, as words: Imperial Plate Belts = {item:12424} Imperial Plate Belt
	["Craft 5 Imperial Plate Belts until 245"] = "",

	-- Step 94: Get 27 Star Ruby
	-- {item:7910} Star Ruby
	["Get 27 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 27 {item:12425}."] = "",

	-- Step 95: Get 560 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 560 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 27 {item:12425} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 99: Learn Imperial Plate Bracers
	-- {spell:16649} Imperial Plate Bracers
	["Learn {spell:16649}"] = "",

	-- Step 101: Craft 27 Imperial Plate Bracers until 270
	-- {item:12425} Imperial Plate Bracers
	["Craft 27 {item:12425} until 270"] = "",
	["About 27 crafts."] = "",

	-- Step 102: Buy Plans: Radiant Boots at the Auction House
	-- {item:12697} Plans: Radiant Boots
	["Buy {item:12697} at the Auction House"] = "",
	["The cheapest way to 300 when both plans are listed."] = "",

	-- Step 103: Buy Plans: Radiant Leggings at the Auction House
	-- {item:12713} Plans: Radiant Leggings
	["Buy {item:12713} at the Auction House"] = "",

	-- Step 104: Buy Plans: Thorium Leggings at the Auction House
	-- {item:12704} Plans: Thorium Leggings
	["Buy {item:12704} at the Auction House"] = "",
	["Next cheapest; the plans are learned at 275."] = "",

	-- Step 105: Learn Radiant Boots
	-- {spell:16656} Radiant Boots
	["Learn {spell:16656}"] = "",

	-- Step 106: Get 88 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 88 {item:7077}"] = "",
	-- {item:12419} Radiant Boots
	["For 22 {item:12419}."] = "",

	-- Step 107: Get 308 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 308 {item:12359}"] = "",
	-- {item:12419} Radiant Boots · {skill:186} Mining
	["For 22 {item:12419}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 109: Craft 22 Radiant Boots until 290
	-- {item:12419} Radiant Boots
	["Craft 22 {item:12419} until 290"] = "",
	["About 22 crafts."] = "",

	-- Step 110: Get 40 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 40 {item:7077}"] = "",
	-- {item:12420} Radiant Leggings
	["For 10 {item:12420}."] = "",

	-- Step 111: Get 200 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 200 {item:12359}"] = "",
	-- {item:12420} Radiant Leggings · {skill:186} Mining
	["For 10 {item:12420}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 112: Learn Radiant Leggings
	-- {spell:16725} Radiant Leggings
	["Learn {spell:16725}"] = "",

	-- Step 114: Craft 10 Radiant Leggings until 300
	-- {item:12420} Radiant Leggings
	["Craft 10 {item:12420} until 300"] = "",

	-- Step 115: Get 11 Star Ruby
	-- {item:7910} Star Ruby
	["Get 11 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 11 {item:12425}."] = "",

	-- Step 116: Get 220 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 220 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 11 {item:12425}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 118: Craft 11 Imperial Plate Bracers until 275
	-- {item:12425} Imperial Plate Bracers
	["Craft 11 {item:12425} until 275"] = "",
	["About 11 crafts."] = "",

	-- Step 119: Get 108 Red Power Crystal
	-- {item:11186} Red Power Crystal
	["Get 108 {item:11186}"] = "",
	-- {item:12414} Thorium Leggings
	["For 27 {item:12414}."] = "",

	-- Step 120: Get 702 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 702 {item:12359}"] = "",
	-- {item:12414} Thorium Leggings · {skill:186} Mining
	["For 27 {item:12414}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 121: Learn Thorium Leggings
	-- {spell:16662} Thorium Leggings
	["Learn {spell:16662}"] = "",

	-- Step 123: Craft 27 Thorium Leggings until 300
	-- {item:12414} Thorium Leggings
	["Craft 27 {item:12414} until 300"] = "",

	-- Step 124: Get 20 Aquamarine
	-- {item:7909} Aquamarine
	["Get 20 {item:7909}"] = "",
	-- {quest:7654} Imperial Plate Boots
	["For 20 {quest:7654}."] = "",

	-- Step 125: Get 20 Star Ruby
	-- {item:7910} Star Ruby
	["Get 20 {item:7910}"] = "",

	-- Step 126: Get 720 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 720 {item:12359}"] = "",
	-- {quest:7654} Imperial Plate Boots · {skill:186} Mining
	["For 20 {quest:7654} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 127: Hand in Imperial Plate Boots
	-- {quest:7654} Imperial Plate Boots
	["Hand in {quest:7654}"] = "",

	-- Step 128: Learn Imperial Plate Boots
	-- {spell:16657} Imperial Plate Boots
	["Learn {spell:16657}"] = "",

	-- Step 130: Craft 20 Imperial Plate Boots until 290
	-- {item:12426} Imperial Plate Boots
	["Craft 20 {item:12426} until 290"] = "",
	["About 20 crafts."] = "",

	-- Step 131: Get 20 Star Ruby
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658}."] = "",

	-- Step 132: Get 500 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 500 {item:12359}"] = "",
	-- {quest:7658} Imperial Plate Leggings · {skill:186} Mining
	["For 10 {quest:7658} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 133: Hand in Imperial Plate Leggings
	-- {quest:7658} Imperial Plate Leggings
	["Hand in {quest:7658}"] = "",

	-- Step 134: Learn Imperial Plate Leggings
	-- {spell:16730} Imperial Plate Leggings
	["Learn {spell:16730}"] = "",

	-- Step 136: Craft 10 Imperial Plate Leggings until 300
	-- {item:12429} Imperial Plate Leggings
	["Craft 10 {item:12429} until 300"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "10 {item:12799} для {item:12773}: {item:12799} попадается примерно в одной жиле из 143 ({object:175404}, {object:177388} или {object:180215}): сохраняйте найденные при добыче.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "{item:4304} 142 для {item:7933} и {item:7945}: {skill:393}: звери 38-50 уровня. Снимайте шкуры с {npc:2729}, {npc:2730}, {npc:2732} и {npc:2734} здесь (38-50 уровня); маршрут ведет гайд {skill:393}.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "{item:4304} 142 для {item:7933} и {item:7945}: {skill:393}: звери 38-50 уровня. Снимайте шкуры с {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} и {npc:5296} здесь (38-50 уровня); маршрут ведет гайд {skill:393}.",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "168 {item:3575} для {spell:3501}: {skill:186}: выплавьте из {item:2772}.",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "19 {item:7909} для {quest:7654}: {item:7909} попадается примерно в одной жиле из 500 ({object:2047} или {object:123309}): сохраняйте найденные при добыче.",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "19 {item:7910} для {quest:7654}: {item:7910} попадается примерно в одной жиле из 143 ({object:2047} или {object:123309}): сохраняйте найденные при добыче.",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "195 {item:3859} для {item:6040}: {skill:186}: выплавьте из {item:3575} и угля.",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "2026 {item:12359} для {item:12773}, {item:12775} и {quest:7654}: {skill:186}: выплавьте из {item:10620}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "{item:8170} 206 для {item:12773} и {item:12775}: {skill:393}: звери 48-60 уровня. Снимайте шкуры с {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} и {npc:6377} здесь (48-60 уровня); маршрут ведет гайд {skill:393}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} для {item:12773} и {item:12775}: {skill:393}: звери 48-60 уровня. Снимайте шкуры здесь: {npc:8598}, Чумной пес и {npc:8596} (уровень 48-60); маршрут – в гайде {skill:393}.",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "210 {item:2840} для {spell:2666}: {skill:186}: выплавьте из {item:2770}.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{item:2838} 234 для {item:6040}: {skill:186}: {object:1735} (навык 125) в {zone:1417} (30-40), {zone:1434} (30-45) и {zone:1443} (30-40). В {zone:1417} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "{item:2838} 234 для {item:6040}: {skill:186}: {object:1735} (навык 125) в {zone:1441} (25-35), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1441} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1413} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1421} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1432} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1436} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1439} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1413} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1417} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1440} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1411} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1412} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1420} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1426} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1429} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1439} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:2521} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "{item:7912} 30 для {item:7964}: {skill:186}: {object:2040} (навык 175) в {zone:1434} (30-45), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1434} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:7912} 30 для {item:7964}: {skill:186}: {object:2040} (навык 175) в {zone:1443} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1443} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "320 {item:2841} для {spell:2672}: {skill:186}: выплавьте из {item:2840} и {item:3576}.",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "320 {item:3860} для {item:7930}: {skill:186}: выплавьте из {item:3858}.",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "44 {item:1210} для {item:7945}: {item:1210} попадается примерно в одной жиле из 100 ({object:1731}, {object:1732} или {object:1733}): сохраняйте найденные при добыче.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "{item:7912} 44 для {item:7945}: {skill:186}: {object:2040} (навык 175) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1425} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:7912} 44 для {item:7945}: {skill:186}: {object:2040} (навык 175) в {zone:1443} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1443} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "596 {item:3860} для {item:7933} и {item:7945}: {skill:186}: выплавьте из {item:3858}.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "{item:12365} 801 для {item:12643}, {item:12773} и {item:12775}: {skill:186}: {object:324} (навык 245) в {zone:1419} (45-55), {zone:1448} (48-55) и {zone:1452} (55-60). В {zone:1419} отмечено место, где {object:324} встречается чаще всего.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "{item:12365} 801 для {item:12643}, {item:12773} и {item:12775}: {skill:186}: {object:324} (навык 245) в {zone:1448} (48-55), {zone:1451} (55-60) и {zone:1452} (55-60). В {zone:1448} отмечено место, где {object:324} встречается чаще всего.",
	-- ["Apprentice {skill:164}"] = "{skill:164}: Ученик",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "Подмастерье по {skill:164} позволяет создавать предметы до 75 навыка за 10c на любом уровне персонажа; обучит любой наставник {skill:164} вашей фракции, а стрелка укажет ближайшего. Купите {item:5956} у любого поставщика кузнечных припасов и начните с {skill:186}: {item:2835} и {item:2770} дают медные жилы каждой стартовой зоны. На 1-75 уйдёт примерно 1s рецептов, плюс 286 {item:2835}, которые нужно собрать или купить.",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:164} 200; предел становится 300. Материалы на 225-300 стоят всего около 942з.",
	-- ["Artisan {skill:164}"] = "{skill:164}: Искусник",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16639} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16640} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Вернитесь к учителю ({skill:164}): {spell:2666} – с навыка {skill:164} 80.",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Вернитесь к учителю ({skill:164}): {spell:2668} – с навыка {skill:164} 95.",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "Вернитесь к учителю ({skill:164}): {spell:2672} (с 95, 5 с).",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "Вернитесь к учителю ({skill:164}): {spell:2674} (с 100, 10 с).",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Вернитесь к учителю ({skill:164}): {spell:3117} – с навыка {skill:164} 100.",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "Вернитесь к учителю ({skill:164}): {spell:7223} (с 160).",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Вернитесь к учителю ({skill:164}): {spell:9916} – с навыка {skill:164} 200.",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "Вернитесь к учителю ({skill:164}): {spell:9918} (с 175).",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Вернитесь к учителю ({skill:164}): {spell:9920}, {spell:9935} – с навыка {skill:164} 210.",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:9968} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Вернитесь к учителю ({skill:164}): {spell:9985} – с навыка {skill:164} 155.",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Купите сразу все для этого этапа: 28 {item:2605} (28с); всего около 28с. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1347}, {npc:1286} и {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} и {npc:5817}). Если вы сами плавите 195 {item:3859} ({skill:186} 165: по одному {item:3575} и углю), купите еще 195 углей (9з 75с, у торговцев и кузнецов); пропустите их, если покупаете слитки.",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Купите сразу все для этого этапа: {item:5956} (инструмент: один, держите в сумках, 18м); всего около 18м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:5519}, {npc:1286} и {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} и {npc:3413}).",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:164} 125; предел становится 225. Материалы на 150-225 стоят всего около 42з.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Ранг «Умелец» поднимает предел со 150 до 225 за 50с (цена Classic; цены Forever нет в данных); нужен навык {skill:164} 125 и уровень персонажа 20, так что его можно взять при любом визите начиная со 125. Учат ему лишь немногие: Альянс – {npc:4258} ({zone:1455}); Орда – {npc:3355} ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:3501} (со 140) и {spell:3337} (со 100, 10с). На 150-225 уйдет около 10с на рецепты и 28с на товары торговцев, плюс 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} и 30 {item:7912} – добудьте или купите.",
	-- ["Expert {skill:164}"] = "{skill:164}: Умелец",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:164} 50; предел становится 150. Материалы на 75-150 стоят всего около 9з 41с.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с; нужен навык {skill:164} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:164}): Альянс – {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) и {npc:5511} ({zone:1453}); Орда – {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) и {npc:3478} ({zone:1413}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:2666} (с 45, 2с) и {spell:3326} (с 50, 2с 50м). На 75-150 уйдет около 19с 50м на рецепты и 18м на товары торговцев, плюс 256 {item:2836}, 28 {item:2838}, 210 {item:2840} и 320 {item:2841} – добудьте или купите.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) and Traugh ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с; он требует навыка {skill:164} 50 и уровня персонажа 10, так что его можно взять при любом визите начиная с 50. Не каждый учитель ({skill:164}) обучает ему: Альянс – {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) и {npc:5511} ({zone:1453}); Орда – {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Рык ({zone:1454}) и Трауг ({zone:1413}). Стрелка выбирает ближайшего учителя вашей фракции. Изучите сейчас: {spell:2666} (с 45, 2с) и {spell:3326} (с 50, 2с 50м). На 75-150 нужно около 19с 50м на рецепты и 18м на товары торговцев, а также добыть или купить: {item:2836} – 256, {item:2838} – 28, {item:2840} – 210 и {item:2841} – 320.",
	-- ["Journeyman {skill:164}"] = "{skill:164}: Подмастерье",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 120, желтый до 135, зеленый до 150. Нужна наковальня рядом.",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 125, желтый до 140, зеленый до 155. Нужна наковальня рядом. {skill:164} 150 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Оранжевый (очко за каждое изготовление) до 15, желтый до 35, зеленый до 55.",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 260, желтый до 270, зеленый до 280. Нужна наковальня рядом.",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 292, зеленый до 305. Нужна наковальня рядом. {skill:164} 300 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 85, желтый до 105, зеленый до 125. Нужна наковальня рядом.",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8831}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:1815}, {npc:1816}, {npc:1817} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Хрустогрыз, {npc:2384}, {npc:2354} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "Обучает: {item:12775} (нужно {skill:164} 255).",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "Обучает: {item:250562} (нужно {skill:164} 240).",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 1-75 и продается на аукционе: 286 {item:2835}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 150-225 и продается на аукционе: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} и 30 {item:7912}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 225-300 и продается на аукционе: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} и 10 {item:12799}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 75-150 и продается на аукционе: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} и 320 {item:2841}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "Желтый до 107, зеленый до 115: не каждое изготовление дает очко.",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 155, зеленый до 170: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 170, зеленый до 185: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "Желтый до 180, зеленый до 185: не каждое изготовление дает очко.",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 197, зеленый до 210: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 212, зеленый до 225: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Желтый до 220, зеленый до 230: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:164} 225 – рубеж Системы наследия.",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "Желтый до 232, зеленый до 235: не каждое изготовление дает очко.",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 235, зеленый до 245: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 240, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко.",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко. 75 – предел ранга «Ученик».",
	-- ["a tool, keep it in your bags"] = "инструмент, держите его в сумках",
	-- ["from the pattern bought at the Auction House"] = "из выкройки, купленной на аукционе",
	-- ["from the recipe in your bags"] = "по рецепту из сумки",
	-- ["{item:12365} (Alliance)"] = "{item:12365} (Альянс)",
	-- ["{item:12365} (Horde)"] = "{item:12365} (Орда)",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} добывается из: {object:324} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426}: оранжевый на 285 (желтый 290, зеленый 300, серый 310): около 19 изготовлений до 300. Каждое требует 34 {item:12359}, 1 {item:7910} и 1 {item:7909}. Около 34 ториевых слитков на изготовление против 40 у топора и его точильных камней, оранжевый до 290. Ниже 50-го уровня персонажа {npc:14567} не даст вам задания: продолжайте делать огромные ториевые боевые топоры до 300 (желтый до 292, серый на 305: примерно вдвое больше ториевых слитков). Нужна наковальня рядом. {skill:164} 300 – веха системы Наследия.",
	-- ["{item:12426} to 300"] = "{item:12426} до 300",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643}: оранжевый на 225 (желтый 230, зеленый 232, серый 235): около 17 изготовлений до 235. Каждое требует 1 {item:12365}. По одному {item:12365} на изготовление (ториевые жилы): дешевые очки в начале Искусника.",
	-- ["{item:12643} to 235"] = "{item:12643} до 235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773}: оранжевый на 250 (желтый 275, зеленый 287, серый 300): около 5 изготовлений до 255, по очку за каждое. Каждое требует 20 {item:12359}, 2 {item:12799}, 2 {item:12644} и 4 {item:8170}. Сначала сделайте 10 {item:12644}. {item:12799} попадается примерно в одной ториевой жиле из 130: купите десять на аукционе. Всего пять изготовлений, пока на 255 не откроются выкройки топора. Нужна наковальня рядом.",
	-- ["{item:12773} to 255"] = "{item:12773} до 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}: оранжевый на 255 (желтый 280, зеленый 292, серый 305): около 31 изготовлений до 285. Каждое требует 40 {item:12359}, 6 {item:12644} и 6 {item:8170}. Сначала сделайте 186 {item:12644}. Выкройки у {npc:11278} ({area:2298}, {zone:1422}), запасы без ограничений, но они становятся персональными при получении. Сорок ториевых слитков и шесть массивных шлифовальных камней на изготовление: самый дорогой отрезок, так что остановитесь там, где его подхватит {quest:7654}. Другие пути: выкройки общего дропа с аукциона (части Сияющего: около 820 ториевых слитков и 190 сердец огня на маршрут Сияющего) или комплекты «Услуга торговца». Нужна наковальня рядом.",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}: оранжевый на 255 (желтый 280, зеленый 292, серый 305): около 31 изготовления до 285. Каждое требует 40 {item:12359}, 6 {item:12644} и 6 {item:8170}. Сначала сделайте 186 {item:12644}. Чертеж у NPC {npc:11278} в месте {area:2298} ({zone:1422}): это призрак, видимый только с аксессуаром {item:13544} (наденьте его внутри места {area:2298}), наградой цепочки NPC {npc:11216} в месте {area:2057}, которая заканчивается на {npc:10506} (55-й уровень, группа для подземелья). Запас не ограничен, но чертеж становится персональным при получении. Сорок ториевых слитков и шесть плотных точильных камней на изготовление: самый дорогой отрезок, так что остановитесь там, где начинаются {quest:7654}. Без аксессуара другие пути: мировые чертежи с аукциона (сияющие предметы: около 820 ториевых слитков и 190 сердец огня для сияющего пути) или комплекты «Благосклонности торговцев». Нужна наковальня рядом.",
	-- ["{item:12775} to 285"] = "{item:12775} до 285",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819} учит рецепту {item:12773} ({skill:164} 250) за 1з 60с. Продает {npc:11278} ({zone:1422}). {npc:11278} – призрак: вы видите его только с {item:13544} (из цепочки NPC {npc:11216} в месте {area:2057}, 55-й уровень, группа), так что без него пропустите это.",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823} учит рецепту {item:12775} ({skill:164} 255) за 2з. Продает {npc:11278} ({zone:1422}). {npc:11278} – призрак: вы видите его только с {item:13544} (из цепочки NPC {npc:11216} в месте {area:2057}, 55-й уровень, группа), так что без него пропустите это.",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Альянс)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Орда)",
	-- ["{item:250562} to 268"] = "{item:250562} до 268",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Альянс)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Орда)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} добывается из: {object:1731} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (Альянс)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (Орда)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} добывается из: {object:1732} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (Альянс)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (Орда)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} добывается из: {object:1735} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Альянс)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Орда)",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: инструмент, держите его в сумке",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040}: желтый на 185 (желтый 185, зеленый 197, серый 210): около 39 изготовлений до 205. Каждое требует 5 {item:3859} и 2 {spell:3337}. Сначала сделайте 78 {spell:3337}. Стальные слитки плавятся из {item:3575} и угля ({skill:186} 165; уголь у торговцев и кузнецов), так что на каждый наруч нужно пять того и другого. Каждому наручу нужны два тяжелых точильных камня: сделайте их заранее. Специализация (необязательно): на 200 и уровне персонажа 40 {npc:5164} ({zone:1455}) или {npc:11177} ({zone:1454}) начнет «Искусство {spell:9788}»: 4 изысканных мифриловых шлема, 2 {item:7936} и {item:7935}; их выкройки дают по цепочке заданий Мифрилового ордена. {npc:11146} ({zone:1455}) или {npc:11178} ({zone:1454}) начнет «Путь оружейника»: 4 лунно-стальных палаша, 4 массивных железных топора, 2 тяжелых мифриловых топора и 2 больших черных палицы; в Forever выкройки {item:3853} ({npc:2482}, {area:35}) и {item:3855} становятся персональными при получении, так что покупайте и используйте их сами. Выбрать можно только одну; для 300 ни одна не нужна, и на бете их не проверяли (она заканчивалась на 30-м уровне). Нужна наковальня рядом.",
	-- ["{item:6040} to 205"] = "{item:6040} до 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (Альянс)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (Орда)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} добывается из: {object:2040} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:7922} to 225"] = "{item:7922} до 225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930}: оранжевый на 205 (желтый 225, зеленый 235, серый 245): около 20 изготовлений до 225, по очку за каждое. Каждое требует 16 {item:3860}. Шестнадцать мифриловых слитков на изготовление и ничего больше; в Forever оранжевый до 225, так что по очку до предела Искусника. Нужна наковальня рядом. {skill:164} 225 – веха системы Наследия.",
	-- ["{item:7930} to 225"] = "{item:7930} до 225",
	-- ["{item:7931} to 230"] = "{item:7931} до 230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933}: желтый на 235 (желтый 230, зеленый 240, серый 250): около 30 изготовлений до 247. Каждое требует 14 {item:3860} и 4 {item:4304}. Мифриловые слитки – из мифриловых залежей; {item:4304} – от кожевников или с аукциона. Нужна наковальня рядом.",
	-- ["{item:7933} to 247"] = "{item:7933} до 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945}: зеленый на 247 (желтый 230, зеленый 242, серый 255): около 11 изготовлений до 250. Каждое требует 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} и 2 {item:4304}. Сначала сделайте 11 {item:7966}. На мост 247-250 нужно всего около 11 изготовлений, но каждое требует четыре камня теней (примерно один {object:1732} из ста) и {item:7971}: купите их на аукционе, если в сумках их нет. Нужна наковальня рядом. {item:7971} (11 на 225-300): {item:7971} – редкая добыча (ни один моб не дает его чаще одного раза из 50): купите на аукционе или сохраняйте найденные.",
	-- ["{item:7945} to 250"] = "{item:7945} до 250",
	-- ["{item:7956} to 175"] = "{item:7956} до 175",
	-- ["{item:7963} to 210"] = "{item:7963} до 210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964}: желтый на 175 (желтый 175, зеленый 180, серый 185): около 30 изготовлений до 185. Каждое требует 1 {item:7912}. По одному {item:7912} на изготовление (мифриловые залежи): дешевые очки между железными и стальными наручами. Применяйте камни к своему оружию или продавайте их.",
	-- ["{item:7964} to 185"] = "{item:7964} до 185",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Альянс)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Орда)",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (Альянс)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (Орда)",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75: аукцион",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225: аукцион",
	-- ["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225: товары торговцев",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300: аукцион",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150: аукцион",
	-- ["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150: товары торговцев",
	-- ["{skill:164} materials for 150-225"] = "{skill:164}: материалы для 150-225",
	-- ["{skill:164} materials for 225-300"] = "{skill:164}: материалы для 225-300",
	-- ["{skill:164} materials for 75-150"] = "{skill:164}: материалы для 75-150",
	-- ["{skill:164} recipes at 100"] = "{skill:164}: рецепты на 100",
	-- ["{skill:164} recipes at 113"] = "{skill:164}: рецепты на 113",
	-- ["{skill:164} recipes at 121"] = "{skill:164}: рецепты на 121",
	-- ["{skill:164} recipes at 155"] = "{skill:164}: рецепты на 155",
	-- ["{skill:164} recipes at 175"] = "{skill:164}: рецепты на 175",
	-- ["{skill:164} recipes at 185"] = "{skill:164}: рецепты на 185",
	-- ["{skill:164} recipes at 205"] = "{skill:164}: рецепты на 205",
	-- ["{skill:164} recipes at 210"] = "{skill:164}: рецепты на 210",
	-- ["{skill:164} recipes at 230"] = "{skill:164}: рецепты на 230",
	-- ["{skill:164} recipes at 268"] = "{skill:164}: рецепты на 268",
	-- ["{skill:164} recipes at 35"] = "{skill:164}: рецепты на 35",
	-- ["{skill:164} recipes at 45"] = "{skill:164}: рецепты на 45",
	-- ["{skill:164} recipes at 83"] = "{skill:164}: рецепты на 83",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 17с.",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (или аукцион)",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: выплавка – {item:10620} (или аукцион)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: выплавка – {item:2770} (или аукцион)",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: выплавка – {item:2775} (или аукцион)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: выплавка – {item:2840} (или аукцион)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: выплавка – {item:3575} (или аукцион)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: выплавка – {item:3858} (или аукцион)",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (или аукцион)",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393} (или аукцион)",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660}: оранжевый на 1 (желтый 15, зеленый 35, серый 55): около 42 изготовлений до 35. Каждое требует 1 {item:2835}. По одному {item:2835} на изготовление, по очку до 15.",
	-- ["{spell:2660} to 35"] = "{spell:2660} до 35",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666}: оранжевый на 83 (желтый 85, зеленый 105, серый 125): около 21 изготовлений до 100. Каждое требует 10 {item:2840}. Forever обучает {spell:2666} с 45; оранжевый до 85. Десять медных слитков на изготовление: плавьте свой {item:2770}. Нужна наковальня рядом. {item:5956} – инструмент: держите его в сумках.",
	-- ["{spell:2666} to 100"] = "{spell:2666} до 100",
	-- ["{spell:2668} to 121"] = "{spell:2668} до 121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672}: оранжевый на 113 (желтый 125, зеленый 140, серый 155): около 64 изготовлений до 150. Каждое требует 5 {item:2841} и 2 {spell:3326}. Сначала сделайте 128 {spell:3326}. Каждому наручу нужны два грубых точильных камня ({item:2836} из оловянных жил): сделайте их заранее, они тоже дают очки. Нужна наковальня рядом. {skill:164} 150 – веха системы Наследия.",
	-- ["{spell:2672} to 150"] = "{spell:2672} до 150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674}: желтый на 100 (желтый 100, зеленый 107, серый 115): около 28 изготовлений до 113. Каждое требует 1 {item:2838}. {item:2838} добывается в залежах железа; по одному на изготовление.",
	-- ["{spell:2674} to 113"] = "{spell:2674} до 113",
	-- ["{spell:3117} to 112"] = "{spell:3117} до 112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}: зеленый на 75 (желтый 45, зеленый 65, серый 85): около 58 изготовлений до 83. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних планов; лишние продаются торговцам.",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320}: зеленый на 75 (желтый 45, зеленый 65, серый 85): около 58 изготовлений до 83. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних чертежей; лишние продаются торговцам. Если вы дошли сюда, не выучив {spell:3320}, выучите сейчас: его учит один из прошлых шагов.",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}: оранжевый на 35 (желтый 45, зеленый 65, серый 85): около 64 изготовлений до 75. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних планов; лишние продаются торговцам.",
	-- ["{spell:3320} to 75"] = "{spell:3320} до 75",
	-- ["{spell:3320} to 83"] = "{spell:3320} до 83",
	-- ["{spell:3333} to 155"] = "{spell:3333} до 155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}: оранжевый на 150 (желтый 165, зеленый 177, серый 190): около 28 изготовлений до 175. Каждое требует 6 {item:3575} и 1 {item:2605}. Шесть железных слитков и {item:2605} на изготовление; {item:2605} продается у портных, кожевников и торговцев припасами. В Forever оранжевый до 165, так что первые пятнадцать дают по очку. Нужна наковальня рядом.",
	-- ["{spell:3501} to 175"] = "{spell:3501} до 175",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (от 205) обучают только учителя ранга «Искусник»: Альянс – {npc:2836} ({zone:1434}); Орда – {npc:2836} ({zone:1434}). Если у вас 35-й уровень, можно уже сейчас обучиться там рангу «Искусник» (нужен навык {skill:164} 200): это избавит от поездки на 225.",
}
