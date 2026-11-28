-- Chinese (simplified) (zhCN): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "学习{skill:164}",
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

	-- Step 67: Learn Mithril Spurs
	["Taught at 210; done at once if you learned it then."] = "",

	-- Step 69: Craft 28 Mithril Spurs until 245
	-- {item:7969} Mithril Spurs
	["Craft 28 {item:7969} until 245"] = "",
	["About 28 crafts."] = "",

	-- Step 70: Get 72 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 72 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes. No {skill:186}? The bars, not the ore."] = "",

	-- Step 71: Get 12 Citrine
	-- {item:3864} Citrine
	["Get 12 {item:3864}"] = "",
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes."] = "",

	-- Step 72: Get 24 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 24 {item:4234}"] = "",

	-- Step 73: Learn Heavy Mithril Axe
	-- {spell:9993} Heavy Mithril Axe
	["Learn {spell:9993}"] = "",

	-- Step 75: Craft 6 Heavy Mithril Axes until 215
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["Craft 6 Heavy Mithril Axes until 215"] = "",
	["About 6 crafts. Weaponsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 76: Get 100 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 100 {item:3860}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs. No {skill:186}? The bars, not the ore."] = "",

	-- Step 77: Get 60 Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get 60 {item:4338}"] = "",
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs."] = "",

	-- Step 78: Learn Mithril Coif
	-- {spell:9961} Mithril Coif
	["Learn {spell:9961}"] = "",

	-- Step 80: Craft 10 Mithril Coifs until 225
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["Craft 10 Mithril Coifs until 225"] = "",
	["About 10 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 84: Get 154 Mithril Bar
	-- {item:3860} Mithril Bar
	["Get 154 {item:3860}"] = "",
	-- {item:7933} Heavy Mithril Boots · {skill:186} Mining
	["For 11 {item:7933}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 85: Get 44 Thick Leather
	-- {item:4304} Thick Leather
	["Get 44 {item:4304}"] = "",
	-- {item:7933} Heavy Mithril Boots
	["For 11 {item:7933}."] = "",

	-- Step 86: Learn Heavy Mithril Boots
	-- {spell:9968} Heavy Mithril Boots
	["Learn {spell:9968}"] = "",

	-- Step 88: Craft 11 Heavy Mithril Boots until 240
	-- {item:7933} Heavy Mithril Boots
	["Craft 11 {item:7933} until 240"] = "",
	["About 11 crafts. Armorsmithing later? Keep 2: its quest asks for them."] = "",

	-- Step 89: Get 5 Aquamarine
	-- {item:7909} Aquamarine
	["Get 5 {item:7909}"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts."] = "",

	-- Step 90: Get 30 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 30 {item:8170}"] = "",

	-- Step 91: Get 150 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 150 {item:12359}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 92: Reach level 50
	["Reach level 50"] = "",
	-- {quest:7652} A Blue Light Bargain
	["{quest:7652} asks for level 50."] = "",

	-- Step 93: Hand in A Blue Light Bargain
	-- {quest:7652} A Blue Light Bargain
	["Hand in {quest:7652}"] = "",

	-- Step 94: Hand in Imperial Plate Belt
	-- {quest:7653} Imperial Plate Belt
	["Hand in {quest:7653}"] = "",

	-- Step 95: Hand in Imperial Plate Bracer
	-- {quest:7655} Imperial Plate Bracer
	["Hand in {quest:7655}"] = "",

	-- Step 96: Learn Imperial Plate Belt
	-- {spell:16647} Imperial Plate Belt
	["Learn {spell:16647}"] = "",

	-- Step 98: Craft 5 Imperial Plate Belts until 245
	-- plural, as words: Imperial Plate Belts = {item:12424} Imperial Plate Belt
	["Craft 5 Imperial Plate Belts until 245"] = "",

	-- Step 99: Get 27 Star Ruby
	-- {item:7910} Star Ruby
	["Get 27 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 27 {item:12425}."] = "",

	-- Step 100: Get 560 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 560 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 27 {item:12425} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 104: Learn Imperial Plate Bracers
	-- {spell:16649} Imperial Plate Bracers
	["Learn {spell:16649}"] = "",

	-- Step 106: Craft 27 Imperial Plate Bracers until 270
	-- {item:12425} Imperial Plate Bracers
	["Craft 27 {item:12425} until 270"] = "",
	["About 27 crafts."] = "",

	-- Step 107: Buy Plans: Radiant Boots at the Auction House
	-- {item:12697} Plans: Radiant Boots
	["Buy {item:12697} at the Auction House"] = "",
	["The cheapest way to 300 when both plans are listed."] = "",

	-- Step 108: Buy Plans: Radiant Leggings at the Auction House
	-- {item:12713} Plans: Radiant Leggings
	["Buy {item:12713} at the Auction House"] = "",

	-- Step 109: Buy Plans: Thorium Leggings at the Auction House
	-- {item:12704} Plans: Thorium Leggings
	["Buy {item:12704} at the Auction House"] = "",
	["Next cheapest; the plans are learned at 275."] = "",

	-- Step 110: Learn Radiant Boots
	-- {spell:16656} Radiant Boots
	["Learn {spell:16656}"] = "",

	-- Step 111: Get 88 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 88 {item:7077}"] = "",
	-- {item:12419} Radiant Boots
	["For 22 {item:12419}."] = "",

	-- Step 112: Get 308 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 308 {item:12359}"] = "",
	-- {item:12419} Radiant Boots · {skill:186} Mining
	["For 22 {item:12419}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 114: Craft 22 Radiant Boots until 290
	-- {item:12419} Radiant Boots
	["Craft 22 {item:12419} until 290"] = "",
	["About 22 crafts."] = "",

	-- Step 115: Get 40 Heart of Fire
	-- {item:7077} Heart of Fire
	["Get 40 {item:7077}"] = "",
	-- {item:12420} Radiant Leggings
	["For 10 {item:12420}."] = "",

	-- Step 116: Get 200 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 200 {item:12359}"] = "",
	-- {item:12420} Radiant Leggings · {skill:186} Mining
	["For 10 {item:12420}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 117: Learn Radiant Leggings
	-- {spell:16725} Radiant Leggings
	["Learn {spell:16725}"] = "",

	-- Step 119: Craft 10 Radiant Leggings until 300
	-- {item:12420} Radiant Leggings
	["Craft 10 {item:12420} until 300"] = "",

	-- Step 122: Learn Radiant Boots
	["Taught at 270; done at once if you learned it then."] = "",

	-- Step 125: Get 20 Star Ruby
	-- {item:7910} Star Ruby
	["Get 20 {item:7910}"] = "",
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658}."] = "",

	-- Step 126: Get 500 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 500 {item:12359}"] = "",
	-- {quest:7658} Imperial Plate Leggings · {skill:186} Mining
	["For 10 {quest:7658} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 127: Hand in Imperial Plate Leggings
	-- {quest:7658} Imperial Plate Leggings
	["Hand in {quest:7658}"] = "",

	-- Step 128: Learn Imperial Plate Leggings
	-- {spell:16730} Imperial Plate Leggings
	["Learn {spell:16730}"] = "",

	-- Step 130: Craft 10 Imperial Plate Leggings until 300
	-- {item:12429} Imperial Plate Leggings
	["Craft 10 {item:12429} until 300"] = "",

	-- Step 131: Get 11 Star Ruby
	-- {item:7910} Star Ruby
	["Get 11 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 11 {item:12425}."] = "",

	-- Step 132: Get 220 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 220 {item:12359}"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 11 {item:12425}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 133: Learn Imperial Plate Bracers
	["Taught at 245; done at once if you learned it then."] = "",

	-- Step 135: Craft 11 Imperial Plate Bracers until 275
	-- {item:12425} Imperial Plate Bracers
	["Craft 11 {item:12425} until 275"] = "",
	["About 11 crafts."] = "",

	-- Step 136: Get 108 Red Power Crystal
	-- {item:11186} Red Power Crystal
	["Get 108 {item:11186}"] = "",
	-- {item:12414} Thorium Leggings
	["For 27 {item:12414}."] = "",

	-- Step 137: Get 702 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 702 {item:12359}"] = "",
	-- {item:12414} Thorium Leggings · {skill:186} Mining
	["For 27 {item:12414}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 138: Learn Thorium Leggings
	-- {spell:16662} Thorium Leggings
	["Learn {spell:16662}"] = "",

	-- Step 140: Craft 27 Thorium Leggings until 300
	-- {item:12414} Thorium Leggings
	["Craft 27 {item:12414} until 300"] = "",

	-- Step 141: Get 20 Aquamarine
	-- {item:7909} Aquamarine
	["Get 20 {item:7909}"] = "",
	-- {quest:7654} Imperial Plate Boots
	["For 20 {quest:7654}."] = "",

	-- Step 143: Get 720 Thorium Bar
	-- {item:12359} Thorium Bar
	["Get 720 {item:12359}"] = "",
	-- {quest:7654} Imperial Plate Boots · {skill:186} Mining
	["For 20 {quest:7654} and the plans. No {skill:186}? The bars, not the ore."] = "",

	-- Step 144: Hand in Imperial Plate Boots
	-- {quest:7654} Imperial Plate Boots
	["Hand in {quest:7654}"] = "",

	-- Step 145: Learn Imperial Plate Boots
	-- {spell:16657} Imperial Plate Boots
	["Learn {spell:16657}"] = "",

	-- Step 147: Craft 20 Imperial Plate Boots until 290
	-- {item:12426} Imperial Plate Boots
	["Craft 20 {item:12426} until 290"] = "",
	["About 20 crafts."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "为{item:12773}准备10个{item:12799}：约每143个{object:175404}、{object:177388}或{object:180215}出一个{item:12799}：留着采矿时找到的。",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "为 {item:7933} 和 {item:7945} 准备 142 个 {item:4304}：通过 {skill:393} 从 38-50 级野兽身上获取。在这里剥取 {npc:2729}、{npc:2730}、{npc:2732} 和 {npc:2734}（38-50 级）的皮；{skill:393} 指南会提供路线。",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "准备142个{item:4304}制作{item:7933}和{item:7945}：{skill:393}：剥取38-50级野兽。在这里剥取{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}和{npc:5296}（38-50级）；{skill:393}指南有对应路线。",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "为{spell:3501}准备168个{item:3575}：{skill:186}：熔炼{item:2772}。",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "为{quest:7654}准备19个{item:7909}：约每500个{object:2047}或{object:123309}出一个{item:7909}：留着采矿时找到的。",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "为{quest:7654}准备19个{item:7910}：约每143个{object:2047}或{object:123309}出一个{item:7910}：留着采矿时找到的。",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "为{item:6040}准备195个{item:3859}：{skill:186}：熔炼{item:3575}和煤块。",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "为{item:12773}、{item:12775}和{quest:7654}准备2026个{item:12359}：{skill:186}：熔炼{item:10620}。",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "准备 206 个 {item:8170}，用于 {item:12773} 和 {item:12775}：通过 {skill:393} 剥取 48-60 级野兽。在这里剥取 {npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378} 和 {npc:6377}（48-60 级）；{skill:393} 指南提供对应路线。",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "准备206个{item:8170}制作{item:12773}和{item:12775}：{skill:393}：剥取48-60级野兽。在这里剥取{npc:8598}、瘟疫犬和{npc:8596}（48-60级）；{skill:393}指南有对应路线。",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "准备206个{item:8170}制作{item:12773}和{item:12775}：{skill:393}：剥取48-60级野兽；或从拍卖行购买。在这里剥取{npc:1815}、{npc:1816}和{npc:1817}（48-60级）；{skill:393}指南有对应路线。",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "为{spell:2666}准备210个{item:2840}：{skill:186}：熔炼{item:2770}。",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "为 {item:6040} 准备234块 {item:2838}：{skill:186}：开采 {zone:1417}（30-40级）、{zone:1434}（30-45级）和 {zone:1443}（30-40级）的 {object:1735}（技能125）。已标记 {zone:1417} 中 {object:1735} 最密集的区域。",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "为{item:6040}准备234个{item:2838}：通过{skill:186}在{zone:1441}（25-35级）、{zone:1417}（30-40级）和{zone:1434}（30-45级）开采{object:1735}（需要技能125）。已标记{zone:1441}中{object:1735}最密集的区域。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "为 {spell:2672} 准备256个 {item:2836}：{skill:186}：开采 {object:1732}（技能65）。已标出 {zone:1413} 中 {object:1732} 最密集的矿点群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "为 {spell:2672} 准备256个 {item:2836}：{skill:186}：开采 {object:1732}（技能65）。已标出 {zone:1421} 中 {object:1732} 最密集的矿点群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "为 {spell:2672} 准备256个 {item:2836}：{skill:186}：开采 {object:1732}（技能65）。已标出 {zone:1432} 中 {object:1732} 最密集的矿点群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "为 {spell:2672} 准备256个 {item:2836}：{skill:186}：开采 {object:1732}（技能65）。已标出 {zone:1436} 中 {object:1732} 最密集的矿点群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "为 {spell:2672} 准备256个 {item:2836}：{skill:186}：开采 {object:1732}（技能65）。已标出 {zone:1439} 中 {object:1732} 最密集的矿点群。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "为 {spell:2674} 准备 28 个 {item:2838}：通过 {skill:186} 开采 {object:1735}（需要技能 125）。已标记 {zone:1413} 中 {object:1735} 最密集的位置。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "为 {spell:2674} 准备 28 个 {item:2838}：通过 {skill:186} 开采 {object:1735}（需要技能 125）。已标记 {zone:1417} 中 {object:1735} 最密集的位置。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "为 {spell:2674} 准备 28 个 {item:2838}：通过 {skill:186} 开采 {object:1735}（需要技能 125）。已标记 {zone:1440} 中 {object:1735} 最密集的位置。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1411} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1412} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1420} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1426} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1429} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:1439} 中 {object:1731} 最密集的矿点群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "为 {spell:2660} 和 {spell:3320} 准备286个 {item:2835}（其中116个用于75-150阶段：现在就全部采好）：{skill:186}：开采 {object:1731}（技能1）。已标出 {zone:2521} 中 {object:1731} 最密集的矿点群。",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "为 {item:7964} 准备30块 {item:7912}：{skill:186}：开采 {zone:1434}（30-45级）、{zone:1425}（40-50级）和 {zone:1444}（40-50级）的 {object:2040}（技能175）。已标记 {zone:1434} 中 {object:2040} 最密集的区域。",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "准备30个{item:7912}制作{item:7964}：{skill:186}：在{zone:1443}（30-40级）、{zone:1425}（40-50级）和{zone:1444}（40-50级）采集{object:2040}（技能175）。已标记{zone:1443}中{object:2040}最密集的位置。",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "为{spell:2672}准备320个{item:2841}：{skill:186}：熔炼{item:2840}和{item:3576}。",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "为{item:7930}准备320个{item:3860}：{skill:186}：熔炼{item:3858}。",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "为{item:7945}准备44个{item:1210}：约每100个{object:1731}、{object:1732}或{object:1733}出一个{item:1210}：留着采矿时找到的。",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "为 {item:7945} 准备 44 个 {item:7912}：通过 {skill:186} 开采 {zone:1425}（40-50 级）、{zone:1444}（40-50 级）和 {zone:1447}（45-55 级）的 {object:2040}（需要技能 175）。已标记 {zone:1425} 中 {object:2040} 最密集的位置。",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "准备 44 个 {item:7912}，用于 {item:7945}：通过 {skill:186} 开采 {object:2040}（技能 175），产地有 {zone:1443}（30-40 级）、{zone:1425}（40-50 级）和 {zone:1444}（40-50 级）。已标记 {zone:1443} 中 {object:2040} 最密集的区域。",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "为{item:7933}和{item:7945}准备596个{item:3860}：{skill:186}：熔炼{item:3858}。",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "为 {item:12643}、{item:12773} 和 {item:12775} 准备801块 {item:12365}：{skill:186}：开采 {zone:1419}（45-55级）、{zone:1448}（48-55级）和 {zone:1452}（55-60级）的 {object:324}（技能245）。已标记 {zone:1419} 中 {object:324} 最密集的区域。",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "准备801个{item:12365}制作{item:12643}、{item:12773}和{item:12775}：{skill:186}：在{zone:1448}（48-55级）、{zone:1451}（55-60级）和{zone:1452}（55-60级）采集{object:324}（技能245）。已标记{zone:1448}中{object:324}最密集的位置。",
	-- ["Apprentice {skill:164}"] = "初级{skill:164}",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "初级{skill:164}的技能上限为75，学习费用10铜币，角色等级不限。向本阵营任意{skill:164}训练师学习即可；箭头指向最近的一位。购买{item:5956}（任意锻造供应商均有），并搭配{skill:186}：所有初始地区的铜矿都能产出{item:2835}和{item:2770}。1-75的配方费用约1银币，另需采集或购买286个{item:2835}。",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "专家级需要角色等级35和{skill:164} 200，可将上限提高到300。225-300的材料总价约942金。",
	-- ["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "大师级技能将上限从225提高到300，费用5金币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:164} 200和角色35级，因此达到200后，随时拜访都能学习。只有少数训练师教授：联盟的 {npc:2836}（{zone:1434}）；部落的 {npc:2836}（{zone:1434}）。箭头会选择本阵营最近的一位。现在学习：{spell:16640}（225起）、{spell:9968}（210起）、{spell:9920}（175起）、{spell:10001}（205起）和 {spell:16639}（225起）。225—300阶段约需购买3金币60银币的配方，另外还需采集或购买44颗 {item:1210}、596块 {item:3860}、142张 {item:4304}、19颗 {item:7909}、19颗 {item:7910}、44块 {item:7912}、11颗 {item:7971}、206张 {item:8170}、2026块 {item:12359}、801块 {item:12365} 和10颗 {item:12799}。",
	-- ["Artisan {skill:164}"] = "专家级{skill:164}",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:16639}在{skill:164}达到230时可学。",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:16640}在{skill:164}达到230时可学。",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "回到{skill:164}训练师处：{spell:2666}在{skill:164}达到80时可学。",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "回到{skill:164}训练师处：{spell:2668}在{skill:164}达到95时可学。",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "回去找 {skill:164} 训练师：学习 {spell:2672}（95点起可学，5银币）。",
	-- ["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "回到{skill:164}训练师处：{spell:2672}在{skill:164}达到120时可学。",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "返回 {skill:164} 训练师处：学习 {spell:2674}（技能 100 起，10 银币）。",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "回到{skill:164}训练师处：{spell:3117}在{skill:164}达到100时可学。",
	-- ["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "返回 {skill:164} 训练师处：学习 {spell:3320}（25起，1银币）。同时学习 {spell:1230171}（1银币）：这是无限服的 {skill:164} 露营物品，需1块 {item:2835} 和1块 {item:2840}，在营地营火旁放置可获得增益。起始地区露营指南中的“露营 101：{skill:164}”任务（在“广阔天地”之后）会派你去找锻造训练师，可免费学会它。",
	-- ["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "回到{skill:164}训练师处：{spell:3320}在{skill:164}达到45时可学。",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "回到{skill:164}训练师处：学习{spell:7223}（160起）。",
	-- ["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "回到{skill:164}训练师处：{spell:7223}在{skill:164}达到185时可学。",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "回到{skill:164}训练师处：{spell:9916}在{skill:164}达到200时可学。",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "返回 {skill:164} 训练师处：学习 {spell:9918}（175起）。",
	-- ["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "回到{skill:164}训练师处：{spell:9918}在{skill:164}达到175时可学。",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "回到{skill:164}训练师处：{spell:9920}、{spell:9935}在{skill:164}达到210时可学。",
	-- ["Back to a {skill:164} trainer: {spell:9959} (from 205)."] = "回去找 {skill:164} 训练师：学习 {spell:9959}（205点起可学）。",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:9968}在{skill:164}达到230时可学。",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "回到{skill:164}训练师处：{spell:9985}在{skill:164}达到155时可学。",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "一次买齐本阶段的用量：28份 {item:2605}（28银币）；总计约28银币。箭头会指向本阵营最近的商人（{zone:1453}：{npc:1347}、{npc:1286} 和 {npc:5565}；{zone:1454}：{npc:3364}、{npc:3367} 和 {npc:5817}）。如果自行熔炼195块 {item:3859}（{skill:186} 165：每块需一块 {item:3575} 和一份煤），还需购买195份煤（9金币75银币，商贸及锻造供应商有售）；如果直接买锭，就不用买煤。",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "一次买齐整个阶段的用量：{item:5956}（工具：只需一个，留在背包里，18铜）；合计约18铜。箭头会选择本阵营最近的商人（{zone:1453}：{npc:5519}、{npc:1286}和{npc:5512}；{zone:1454}：{npc:3367}、{npc:5817}和{npc:3413}）。",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "高级需要角色等级20和{skill:164} 125，可将上限提高到225。150-225的材料总价约42金。",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}) and {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}) and {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "高级技能将上限从150提高到225，费用50银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:164} 125和角色20级，因此达到125后，随时拜访都能学习。只有少数训练师教授：联盟的 {npc:4258}（{zone:1455}）和 {npc:2836}（{zone:1434}）；部落的 {npc:2836}（{zone:1434}）和 {npc:3355}（{zone:1454}）。箭头会选择本阵营最近的一位。现在学习：{spell:3501}（140起）和 {spell:3337}（100起，10银币）。150—225阶段约需购买10银币的配方和28银币的商人物资，另外还需采集或购买234块 {item:2838}、168块 {item:3575}、195块 {item:3859}、320块 {item:3860} 和30块 {item:7912}。",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "高级技能将上限从150提高到225，费用50银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:164} 125和角色20级，因此达到125后，随时拜访都能学习。只有少数训练师教授：联盟的 {npc:4258}（{zone:1455}）；部落的 {npc:3355}（{zone:1454}）。箭头会选择本阵营最近的一位。现在学习：{spell:3501}（140起）和 {spell:3337}（100起，10银币）。150—225阶段约需购买10银币的配方和28银币的商人物资，另外还需采集或购买234块 {item:2838}、168块 {item:3575}、195块 {item:3859}、320块 {item:3860} 和30块 {item:7912}。",
	-- ["Expert {skill:164}"] = "高级{skill:164}",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "中级需要角色等级10和{skill:164} 50，可将上限提高到150。75-150的材料总价约9金41银。",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "中级可将上限从75提高到150，费用5银；需要{skill:164}达到50且角色等级10，因此从50点起任何一次拜访都可以学。并非每个{skill:164}训练师都教授：联盟为{npc:3136}（{zone:1431}）、{npc:252479}（{zone:2521}）、{npc:10276}（{zone:1455}）和{npc:5511}（{zone:1453}）；部落为{npc:276067}（{zone:1420}）、{npc:252479}（{zone:2521}）、{npc:4596}（{zone:1458}）、{npc:2998}（{zone:1456}）、{npc:1383}（{zone:1454}）和{npc:3478}（{zone:1413}）。箭头会指向你所在阵营最近的一位。现在学习：{spell:2666}（45点起，2银）和{spell:3326}（50点起，2银50铜）。75-150约需19银50铜的配方和18铜的商人材料，另需自行收集或购买256个{item:2836}、28个{item:2838}、210个{item:2840}和320个{item:2841}。",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) and Traugh ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "中级可将上限从75提高到150，费用5银；需要{skill:164}达到50且角色等级10，因此从50点起任何一次拜访都可以学。并非每个{skill:164}训练师都教授：联盟为{npc:4258}（{zone:1455}）、{npc:2836}（{zone:1434}）、{npc:3136}（{zone:1431}）、{npc:252479}（{zone:2521}）、{npc:10276}（{zone:1455}）和{npc:5511}（{zone:1453}）；部落为{npc:2836}（{zone:1434}）、{npc:252479}（{zone:2521}）、{npc:4596}（{zone:1458}）、{npc:2998}（{zone:1456}）、{npc:3355}（{zone:1454}）、斯纳尔（{zone:1454}）和特劳弗（{zone:1413}）。箭头会指向你所在阵营最近的一位。现在学习：{spell:2666}（45点起，2银）和{spell:3326}（50点起，2银50铜）。75-150约需19银50铜的配方和18铜的商人材料，另需自行收集或购买256个{item:2836}、28个{item:2838}、210个{item:2840}和320个{item:2841}。",
	-- ["Journeyman {skill:164}"] = "中级{skill:164}",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar根据你的等级和阵营选择的刷怪点击杀掉落它的怪物。拍卖行也能买到。",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "橙色（每次制作必得一点）到120，黄色到135，绿色到150。需要附近有铁砧。",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "橙色（每次制作必得一点）到125，黄色到140，绿色到155。需要附近有铁砧。{skill:164} 150是传承系统的里程碑。",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "橙色（每次制作必得一点）到15，黄色到35，绿色到55。",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "橙色（每次制作必得一点）到260，黄色到270，绿色到280。需要附近有铁砧。",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "橙色（每次制作必得一点）到280，黄色到292，绿色到305。需要附近有铁砧。{skill:164} 300是传承系统的里程碑。",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "橙色（每次制作必得一点）到85，黄色到105，绿色到125。需要附近有铁砧。",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:8831}；这里是数据中最密集的草点。拍卖行也能买到。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:1815}、{npc:1816}、{npc:1817}（48-60级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、钳嘴龟、{npc:2384}、{npc:2354}（18-30级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}（38-50级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}（18-30级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}（38-50级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}（48-60级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剥皮、分解或由其他专业制作：自己收集，或在拍卖行购买。",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "教授{item:12775}（需要{skill:164} 255）。",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "教授{item:250562}（需要{skill:164} 240）。",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "1-75阶段所需材料中拍卖行有售的：286个{item:2835}。背包、银行和邮箱中已有的数量会自动扣除。",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "150-225阶段所需材料中拍卖行有售的：234个{item:2838}、168个{item:3575}、195个{item:3859}、320个{item:3860}和30个{item:7912}。背包、银行和邮箱中已有的数量会自动扣除。",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "225-300阶段所需材料中拍卖行有售的：44个{item:1210}、596个{item:3860}、142个{item:4304}、19个{item:7909}、19个{item:7910}、44个{item:7912}、11个{item:7971}、206个{item:8170}、2026个{item:12359}、801个{item:12365}和10个{item:12799}。背包、银行和邮箱中已有的数量会自动扣除。",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "75-150阶段所需材料中拍卖行有售的：256个{item:2836}、28个{item:2838}、210个{item:2840}和320个{item:2841}。背包、银行和邮箱中已有的数量会自动扣除。",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "黄色到107，绿色到115：并非每次制作都会加点。",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "黄色到155，绿色到170：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "黄色到170，绿色到185：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "黄色到180，绿色到185：并非每次制作都会加点。",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "黄色到197，绿色到210：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "黄色到212，绿色到225：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "黄色到220，绿色到230：并非每次制作都会加点。需要附近有铁砧。{skill:164} 225是传承系统的里程碑。",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "黄色到232，绿色到235：并非每次制作都会加点。",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "黄色到235，绿色到245：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "黄色到240，绿色到250：并非每次制作都会加点。需要附近有铁砧。",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "黄色到65，绿色到85：并非每次制作都会加点。",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黄色到65，绿色到85：并非每次制作都会加点。75是初级上限。",
	-- ["a tool, keep it in your bags"] = "工具，留在背包里",
	-- ["from the pattern bought at the Auction House"] = "使用拍卖行购买的图样",
	-- ["from the recipe in your bags"] = "使用背包里的配方",
	-- ["{item:12365} (Alliance)"] = "{item:12365}（联盟）",
	-- ["{item:12365} (Horde)"] = "{item:12365}（部落）",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365}来自{object:324}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426}在285时为橙色（290变黄，300变绿，310变灰）：约制作19次可升至300。每次需要34个{item:12359}、1个{item:7910}和1个{item:7909}。每次约用34块瑟银锭，而战斧要40块，还要砂轮；此配方到290前都是橙色。角色等级低于50时，{npc:14567}不会提供任务：改为继续制作巨型瑟银战斧至300（292前为黄色，305变灰：约需两倍瑟银锭）。附近需要有铁砧。{skill:164}300是传承系统的里程碑。",
	-- ["{item:12426} to 300"] = "制作{item:12426}，提升至 300",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643} 在技能 225 时为橙色（230 变黄、232 变绿、235 变灰）：约制作 17 次可升到 235。每次需要 1 个 {item:12365}。每次消耗一个来自瑟银矿脉的 {item:12365}：这是大师级初期较省钱的升级方式。",
	-- ["{item:12643} to 235"] = "{item:12643}练到235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} 在技能 250 时为橙色（275 变黄、287 变绿、300 变灰）：约制作 5 次可到 255，每次必涨一点。每次需要 20 个 {item:12359}、2 个 {item:12799}、2 个 {item:12644} 和 4 个 {item:8170}。先制作 10 个 {item:12644}。{item:12799} 大约每 130 处瑟银矿脉才出一个：去拍卖行买十个。只制作五次，到 255 后就能使用战斧设计图。附近需要铁砧。",
	-- ["{item:12773} to 255"] = "制作{item:12773}，提升至 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} 在255点时为橙色（280变黄，292变绿，305变灰）：制作约31次可到285。每次需要40块 {item:12359}、6个 {item:12644} 和6张 {item:8170}。先制作好186个 {item:12644}。图纸由 {npc:11278}（{zone:1422} 的 {area:2298}）出售，不限量，但拾取后绑定。每次制作消耗四十块瑟银锭和六个致密砂轮：这是开销最大的阶段，所以到可以改做 {quest:7654} 时就停下。其他方案包括在拍卖行购买世界掉落图纸（辐光系列：这条路线约需820块瑟银锭和190个火焰之心），或采用商人青睐套装。附近需要有铁砧。",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}在255时为橙色（黄色280，绿色292，灰色305）：大约制作31次到285。每次需要40个{item:12359}、6个{item:12644}和6个{item:8170}。先做186个{item:12644}。图纸来自{area:2298}（{zone:1422}）的{npc:11278}：他是幽灵，只有戴着{item:13544}饰品时才能看见（在{area:2298}里面戴上），这是{npc:11216}的{area:2057}任务线的奖励，该任务线以{npc:10506}结束（55级，地下城队伍）。库存无限，但图纸拾取后绑定。每次需要四十个瑟银锭和六个致密砂轮：最贵的一段，所以在{quest:7654}接手的地方停下。没有饰品的话，其他途径：拍卖行上的世界掉落图纸（光辉系列：光辉路线大约需要820个瑟银锭和190个火焰之心），或商人之友套装。需要附近有铁砧。",
	-- ["{item:12775} to 285"] = "制作{item:12775}，提升至 285",
	-- ["{item:12775} to 300"] = "{item:12775}练到300",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "{item:12819} 可教你制作 {item:12773}（{skill:164} 250），售价1金币60银币。由 {npc:11278}（{zone:1422}）出售。",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819}教会{item:12773}（{skill:164} 250），价格1金60银。由{zone:1422}的{npc:11278}出售。{npc:11278}是幽灵：只有戴着{item:13544}时才能看见他（来自{npc:11216}的{area:2057}任务线，55级，需要队伍），没有它就跳过。",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "{item:12823} 可教会制作 {item:12775}（{skill:164} 255），售价 2 金币。由 {npc:11278}（{zone:1422}）出售。",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823}教会{item:12775}（{skill:164} 255），价格2金。由{zone:1422}的{npc:11278}出售。{npc:11278}是幽灵：只有戴着{item:13544}时才能看见他（来自{npc:11216}的{area:2057}任务线，55级，需要队伍），没有它就跳过。",
	-- ["{item:2319} (Alliance)"] = "{item:2319}（联盟）",
	-- ["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- ["{item:250562} to 268"] = "{item:250562}练到268",
	-- ["{item:2835} (Alliance)"] = "{item:2835}（联盟）",
	-- ["{item:2835} (Horde)"] = "{item:2835}（部落）",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}来自{object:1731}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",
	-- ["{item:2836} (Alliance)"] = "{item:2836}（联盟）",
	-- ["{item:2836} (Horde)"] = "{item:2836}（部落）",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}来自{object:1732}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",
	-- ["{item:2838} (Alliance)"] = "{item:2838}（联盟）",
	-- ["{item:2838} (Horde)"] = "{item:2838}（部落）",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}来自{object:1735}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",
	-- ["{item:4304} (Alliance)"] = "{item:4304}（联盟）",
	-- ["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包里",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040}在技能185时为黄色（185变黄，197变绿，210变灰）：约制作39次可到205。每次需要5个{item:3859}和2个{spell:3337}。先制作78个{spell:3337}。钢锭由1个{item:3575}和1份煤块熔炼而成（需要{skill:186}165；煤块向杂货及锻造供应商购买），所以每副护腕需要铁锭和煤块各5份。每副护腕还需2个重砂轮：先做好。专精（可选）：技能200且角色40级时，{npc:5164}（{zone:1455}）或{npc:11177}（{zone:1454}）提供“铸造护甲的艺术”（{spell:9788}）：需要4个精制秘银头盔、2个{item:7936}和1个{item:7935}，图纸来自秘银会任务链。{npc:11146}（{zone:1455}）或{npc:11178}（{zone:1454}）提供“武器铸造师之道”：需要4把月钢宽剑、4把巨型铁斧、2把秘银重斧和2把巨型黑色锤；无限中，{item:3853}图纸（{area:35}的{npc:2482}出售）和{item:3855}图纸拾取绑定，必须自己购买并学习。两种专精只能选一种；升到300均不需要，而且测试版未测试过它们（测试止于30级）。附近需要有铁砧。",
	-- ["{item:6040} to 200"] = "{item:6040}练到200",
	-- ["{item:6040} to 205"] = "制作{item:6040}，提升至 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912}（联盟）",
	-- ["{item:7912} (Horde)"] = "{item:7912}（部落）",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}来自{object:2040}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",
	-- ["{item:7922} to 225"] = "{item:7922}练到225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930} 在技能205时为橙色（225变黄，235变绿，245变灰）：大约制作20次升到225，每次必涨一点。每次需要16块 {item:3860}。每次只需十六块秘银锭，无需其他材料；在无限服中到225前保持橙色，因此直到大师级上限每次都必涨一点。附近需要有铁砧。{skill:164} 225是传承系统的一项里程碑。",
	-- ["{item:7930} to 225"] = "将{item:7930}做到 225",
	-- ["{item:7931} to 230"] = "{item:7931}练到230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933} 在技能235时为黄色（230变黄，240变绿，250变灰）：大约制作30次升到247。每次需要14块 {item:3860} 和4张 {item:4304}。秘银锭来自秘银矿脉；{item:4304} 从剥皮玩家或拍卖行获取。附近需要有铁砧。",
	-- ["{item:7933} to 244"] = "{item:7933}练到244",
	-- ["{item:7933} to 247"] = "制作{item:7933}，提升至 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945}在247时为绿色（230变黄，242变绿，255变灰）：约制作11次可升至250。每次需要16个{item:3860}、1个{item:7971}、4个{item:1210}、1个{item:7966}和2个{item:4304}。先制作11个{item:7966}。247-250只需制作约11次，但每次都要四颗暗影石（约一百个{object:1732}出一颗）和一个{item:7971}：除非背包已有，否则去拍卖行购买。附近需要有铁砧。{item:7971}（225-300阶段需要11个）：{item:7971}是稀有掉落（没有任何怪物的掉率能达到五十分之一）：去拍卖行买，或留着找到的。",
	-- ["{item:7945} to 250"] = "制作{item:7945}，提升至 250",
	-- ["{item:7956} to 175"] = "{item:7956}练到175",
	-- ["{item:7963} to 210"] = "{item:7963}练到210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964} 在技能175时为黄色（175变黄，180变绿，185变灰）：大约制作30次升到185。每次需要1块 {item:7912}。每次用一块 {item:7912}（来自秘银矿脉）：在制作铁质护腕与钢质护腕之间，这是便宜的冲点方式。做好的石头可用于武器或出售。",
	-- ["{item:7964} to 185"] = "{item:7964}练到185",
	-- ["{item:8170} (Alliance)"] = "{item:8170}（联盟）",
	-- ["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- ["{item:8831} (Alliance)"] = "{item:8831}（联盟）",
	-- ["{item:8831} (Horde)"] = "{item:8831}（部落）",
	-- ["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "{npc:14567}（{zone:1446}）会通过 {quest:7654}，用 {item:12700}（{skill:164} 270）换取40块 {item:12359}，任务需要 {skill:164} 265和角色50级；先接 {quest:7652}（无需任何物品）。图纸拾取后绑定。",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75：拍卖行",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225：拍卖行",
	-- ["{skill:164} 150-225: vendor goods"] = "{skill:164} 150–225：商人材料",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300：拍卖行",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150：拍卖行",
	-- ["{skill:164} 75-150: vendor goods"] = "{skill:164} 75–150：商人材料",
	-- ["{skill:164} materials for 150-225"] = "{skill:164} 150-225所需材料",
	-- ["{skill:164} materials for 225-300"] = "{skill:164} 225-300所需材料",
	-- ["{skill:164} materials for 75-150"] = "{skill:164} 75-150所需材料",
	-- ["{skill:164} recipes at 100"] = "100点的{skill:164}配方",
	-- ["{skill:164} recipes at 112"] = "112点的{skill:164}配方",
	-- ["{skill:164} recipes at 113"] = "{skill:164}：技能 113 时学习的配方",
	-- ["{skill:164} recipes at 121"] = "121点的{skill:164}配方",
	-- ["{skill:164} recipes at 155"] = "155点的{skill:164}配方",
	-- ["{skill:164} recipes at 175"] = "175点的{skill:164}配方",
	-- ["{skill:164} recipes at 185"] = "185点的{skill:164}配方",
	-- ["{skill:164} recipes at 200"] = "200点的{skill:164}配方",
	-- ["{skill:164} recipes at 205"] = "{skill:164}：技能 205 时学习的配方",
	-- ["{skill:164} recipes at 210"] = "210点的{skill:164}配方",
	-- ["{skill:164} recipes at 230"] = "230点的{skill:164}配方",
	-- ["{skill:164} recipes at 235"] = "235点的{skill:164}配方",
	-- ["{skill:164} recipes at 268"] = "268点的{skill:164}配方",
	-- ["{skill:164} recipes at 35"] = "{skill:164}：技能 35 时学习的配方",
	-- ["{skill:164} recipes at 45"] = "45点的{skill:164}配方",
	-- ["{skill:164} recipes at 83"] = "83点的{skill:164}配方",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164}与升级同步进行。Forever的传承系统会在专业技能达到150、225和300（中级、高级和专家级上限）时奖励制造专业，所以每个节点都很重要。1-75的材料总价约17银。",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}：{item:249410}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔炼{item:10620}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔炼{item:2770}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}：熔炼{item:2775}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔炼{item:2840}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔炼{item:3575}（或去拍卖行）",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔炼{item:3858}（或去拍卖行）",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}：{item:249432}（或去拍卖行）",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393}（或去拍卖行）",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660}在1时为橙色（15变黄，35变绿，55变灰）：约制作42次可升至35。每次需要1个{item:2835}。每次制作消耗一个{item:2835}，15以前每次都升一点。",
	-- ["{spell:2660} to 35"] = "制作{spell:2660}，提升至 35",
	-- ["{spell:2660} to 45"] = "{spell:2660}练到45",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} 在83点时为橙色（85变黄，105变绿，125变灰）：制作约21次可到100。每次需要10块 {item:2840}。无限服在45点即可学习 {spell:2666}；到85点前一直为橙色。每次制作消耗十块铜锭：熔炼你的 {item:2770}。附近需要有铁砧。{item:5956} 是工具：留在背包中。",
	-- ["{spell:2666} to 100"] = "{spell:2666}练到100",
	-- ["{spell:2668} to 121"] = "{spell:2668}练到121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672}在113时为橙色（125变黄，140变绿，155变灰）：约制作64次可升至150。每次需要5个{item:2841}和2个{spell:3326}。先制作128个{spell:3326}。每副护腕需要两个粗制砂轮（{item:2836}来自锡矿）：先做好砂轮，它们也能提升技能。附近需要有铁砧。{skill:164}150是传承系统的里程碑。",
	-- ["{spell:2672} to 150"] = "{spell:2672}练到150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674} 在技能 100 时为黄色（100 变黄、107 变绿、115 变灰）：约制作 28 次可升到 113。每次需要 1 个 {item:2838}。{item:2838} 来自铁矿石，每次制作消耗一个。",
	-- ["{spell:2674} to 113"] = "制作{spell:2674}，提升至 113",
	-- ["{spell:3117} to 112"] = "{spell:3117}练到112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} 在技能75时为绿色（45变黄，65变绿，85变灰）：大约制作58次升到83。每次需要2块 {item:2835}。每次用两块 {item:2835}。砂轮是后续图纸的材料；多余的可卖给商人。",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320}在75时为绿色（黄色45，绿色65，灰色85）：大约制作58次到83。每次需要2个{item:2835}。每次两个{item:2835}。磨石是后续图纸的材料；多余的卖给商人。如果你到这里还没学会{spell:3320}，现在就学：之前的步骤会教。",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}在35时为橙色（45变黄，65变绿，85变灰）：约制作64次可升至75。每次需要2个{item:2835}。每次制作消耗两个{item:2835}。砂轮是后续配方的材料；多余的可以卖给商人。",
	-- ["{spell:3320} to 75"] = "{spell:3320}练到75",
	-- ["{spell:3320} to 83"] = "{spell:3320}练到83",
	-- ["{spell:3333} to 155"] = "{spell:3333}练到155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}在技能150时为橙色（165变黄，177变绿，190变灰）：约制作28次可到175。每次需要6个{item:3575}和1个{item:2605}。也就是每次6块铁锭和1个{item:2605}；{item:2605}可向裁缝、制皮及杂货供应商购买。无限中到165前都是橙色，因此前15次制作每次都涨一点。附近需要有铁砧。",
	-- ["{spell:3501} to 175"] = "将{spell:3501}做到 175",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959}（205起）只有大师级训练师教授：联盟{npc:2836}（{zone:1434}）；部落{npc:2836}（{zone:1434}）。如果你已满35级（需要{skill:164} 200），现在就可以在那里学习大师级，省得225时再跑一趟。",
}
