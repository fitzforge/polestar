-- German (deDE): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "{skill:164} lernen",
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
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "10 {item:12799} für {item:12773}: {item:12799} taucht in etwa jedem 143. {object:175404}, {object:177388} oder {object:180215} auf: Behalte die, die du beim Abbauen findest.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} für {item:7933} und {item:7945}: {skill:393}: Tiere der Stufe 38-50. Häute hier {npc:2729}, {npc:2730}, {npc:2732} und {npc:2734} ab (Stufe 38-50); der {skill:393}-Guide plant das ein.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} für {item:7933} und {item:7945}: {skill:393}: Tiere der Stufe 38-50. Häute hier {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} und {npc:5296} ab (Stufe 38-50); der {skill:393}-Guide plant das ein.",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "168 {item:3575} für {spell:3501}: {skill:186}: {item:2772} schmelzen.",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "19 {item:7909} für {quest:7654}: {item:7909} taucht in etwa jedem 500. {object:2047} oder {object:123309} auf: Behalte die, die du beim Abbauen findest.",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "19 {item:7910} für {quest:7654}: {item:7910} taucht in etwa jedem 143. {object:2047} oder {object:123309} auf: Behalte die, die du beim Abbauen findest.",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "195 {item:3859} für {item:6040}: {skill:186}: {item:3575} und Kohle schmelzen.",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "2026 {item:12359} für {item:12773}, {item:12775} und {quest:7654}: {skill:186}: {item:10620} schmelzen.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} für {item:12773} und {item:12775}: {skill:393}: Tiere der Stufe 48-60. Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} und {npc:6377} ab (Stufe 48-60); der {skill:393}-Guide plant das ein.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} für {item:12773} und {item:12775}: {skill:393}: Tiere der Stufe 48-60. Häute hier {npc:8598}, Seuchenhunde und {npc:8596} ab (Stufe 48-60); der {skill:393}-Guide plant das ein.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} für {item:12773} und {item:12775}: {skill:393}: Tiere der Stufe 48-60; oder im Auktionshaus. Häute hier {npc:1815}, {npc:1816} und {npc:1817} ab (Stufe 48-60); der {skill:393}-Guide plant das ein.",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "210 {item:2840} für {spell:2666}: {skill:186}: {item:2770} schmelzen.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "234 {item:2838} für {item:6040}: {skill:186}: {object:1735} (Fertigkeit 125) in {zone:1417} (30-40), {zone:1434} (30-45) und {zone:1443} (30-40). Das dichteste Vorkommen von {object:1735} in {zone:1417} ist markiert.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "234 {item:2838} für {item:6040}: {skill:186}: {object:1735} (Fertigkeit 125) in {zone:1441} (25-35), {zone:1417} (30-40) und {zone:1434} (30-45). Das dichteste Vorkommen von {object:1735} in {zone:1441} ist markiert.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "256 {item:2836} für {spell:2672}: {skill:186}: {object:1732} (Fertigkeit 65). Das dichteste Vorkommen von {object:1732} in {zone:1413} ist markiert.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "256 {item:2836} für {spell:2672}: {skill:186}: {object:1732} (Fertigkeit 65). Das dichteste Vorkommen von {object:1732} in {zone:1421} ist markiert.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "256 {item:2836} für {spell:2672}: {skill:186}: {object:1732} (Fertigkeit 65). Das dichteste Vorkommen von {object:1732} in {zone:1432} ist markiert.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "256 {item:2836} für {spell:2672}: {skill:186}: {object:1732} (Fertigkeit 65). Das dichteste Vorkommen von {object:1732} in {zone:1436} ist markiert.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "256 {item:2836} für {spell:2672}: {skill:186}: {object:1732} (Fertigkeit 65). Das dichteste Vorkommen von {object:1732} in {zone:1439} ist markiert.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "28 {item:2838} für {spell:2674}: {skill:186}: {object:1735} (Fertigkeit 125). Das dichteste Vorkommen von {object:1735} in {zone:1413} ist markiert.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "28 {item:2838} für {spell:2674}: {skill:186}: {object:1735} (Fertigkeit 125). Das dichteste Vorkommen von {object:1735} in {zone:1417} ist markiert.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "28 {item:2838} für {spell:2674}: {skill:186}: {object:1735} (Fertigkeit 125). Das dichteste Vorkommen von {object:1735} in {zone:1440} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1411} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1412} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1420} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1426} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1429} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:1439} ist markiert.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "286 {item:2835} für {spell:2660} und {spell:3320} (116 davon für 75-150: hol sie dir jetzt alle): {skill:186}: {object:1731} (Fertigkeit 1). Das dichteste Vorkommen von {object:1731} in {zone:2521} ist markiert.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "30 {item:7912} für {item:7964}: {skill:186}: {object:2040} (Fertigkeit 175) in {zone:1434} (30-45), {zone:1425} (40-50) und {zone:1444} (40-50). Das dichteste Vorkommen von {object:2040} in {zone:1434} ist markiert.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "30 {item:7912} für {item:7964}: {skill:186}: {object:2040} (Fertigkeit 175) in {zone:1443} (30-40), {zone:1425} (40-50) und {zone:1444} (40-50). Das dichteste Vorkommen von {object:2040} in {zone:1443} ist markiert.",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "320 {item:2841} für {spell:2672}: {skill:186}: {item:2840} und {item:3576} schmelzen.",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "320 {item:3860} für {item:7930}: {skill:186}: {item:3858} schmelzen.",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "44 {item:1210} für {item:7945}: {item:1210} taucht in etwa jedem hundertsten {object:1731}, {object:1732} oder {object:1733} auf: Behalte die, die du beim Abbauen findest.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "44 {item:7912} für {item:7945}: {skill:186}: {object:2040} (Fertigkeit 175) in {zone:1425} (40-50), {zone:1444} (40-50) und {zone:1447} (45-55). Das dichteste Vorkommen von {object:2040} in {zone:1425} ist markiert.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "44 {item:7912} für {item:7945}: {skill:186}: {object:2040} (Fertigkeit 175) in {zone:1443} (30-40), {zone:1425} (40-50) und {zone:1444} (40-50). Das dichteste Vorkommen von {object:2040} in {zone:1443} ist markiert.",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "596 {item:3860} für {item:7933} und {item:7945}: {skill:186}: {item:3858} schmelzen.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "801 {item:12365} für {item:12643}, {item:12773} und {item:12775}: {skill:186}: {object:324} (Fertigkeit 245) in {zone:1419} (45-55), {zone:1448} (48-55) und {zone:1452} (55-60). Das dichteste Vorkommen von {object:324} in {zone:1419} ist markiert.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "801 {item:12365} für {item:12643}, {item:12773} und {item:12775}: {skill:186}: {object:324} (Fertigkeit 245) in {zone:1448} (48-55), {zone:1451} (55-60) und {zone:1452} (55-60). Das dichteste Vorkommen von {object:324} in {zone:1448} ist markiert.",
	-- ["Apprentice {skill:164}"] = "{skill:164} (Lehrling)",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "Die Lehrlingsstufe von {skill:164} erlaubt dir, bis 75 herzustellen, für 10c, auf jeder Charakterstufe. Jeder {skill:164}-Lehrer deiner Fraktion bringt sie dir bei; der Pfeil wählt den nächsten. Kauf einen {item:5956} (bei jedem Schmiedebedarfshändler) und kombiniere ihn mit {skill:186}: {item:2835} und {item:2770} stammen aus den Kupferadern jedes Startgebiets. 1-75 kostet etwa 1s an Rezepten, dazu 286 {item:2835} zum Sammeln oder Kaufen.",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:164} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 942g wert.",
	-- ["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "Die Meisterstufe erhöht das Limit von 225 auf 300 für 5g (Preis aus Classic; der von Forever liegt nicht in den Daten); sie erfordert {skill:164} 200 und Charakterstufe 35, du kannst sie also bei jedem Besuch ab 200 nehmen. Nur wenige Lehrer bringen sie bei: Allianz {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:16640} (ab 225), {spell:9968} (ab 210), {spell:9920} (ab 175), {spell:10001} (ab 205) und {spell:16639} (ab 225). 225-300 kostet etwa 3g 60s an Rezepten, dazu 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} und 10 {item:12799} zum Sammeln oder Kaufen.",
	-- ["Artisan {skill:164}"] = "{skill:164} (Fachmann)",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:16639} wird ab {skill:164} 230 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:16640} wird ab {skill:164} 230 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2666} wird ab {skill:164} 80 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2668} wird ab {skill:164} 95 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "Zurück zu einem {skill:164}-Lehrer: {spell:2672} (ab 95, 5s).",
	-- ["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Zurück zu einem Lehrer für {skill:164}: {spell:2672} wird ab {skill:164} 120 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "Zurück zu einem {skill:164}-Lehrer: {spell:2674} (ab 100, 10s).",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Zurück zu einem Lehrer für {skill:164}: {spell:3117} wird ab {skill:164} 100 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "Zurück zu einem {skill:164}-Lehrer: {spell:3320} (ab 25, 1s). Lerne außerdem {spell:1230171} (1s): Forevers {skill:164}-Lagergegenstand, 1 {item:2835} und 1 {item:2840}, der für seinen Buff an einem Lagerplatz neben einem Lagerfeuer aufgestellt wird. Die Quest Camping 101: {skill:164} aus dem Camping-Guide deines Startgebiets (nach The Great Outdoors) schickt dich zu einem Schmiedekunstlehrer, der sie dir kostenlos beibringt.",
	-- ["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Zurück zu einem Lehrer für {skill:164}: {spell:3320} wird ab {skill:164} 45 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "Zurück zu einem {skill:164}-Lehrer: {spell:7223} (ab 160).",
	-- ["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Zurück zu einem Lehrer für {skill:164}: {spell:7223} wird ab {skill:164} 185 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9916} wird ab {skill:164} 200 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "Zurück zu einem {skill:164}-Lehrer: {spell:9918} (ab 175).",
	-- ["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9918} wird ab {skill:164} 175 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9920}, {spell:9935} werden ab {skill:164} 210 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:9959} (from 205)."] = "Zurück zu einem {skill:164}-Lehrer: {spell:9959} (ab 205).",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9968} wird ab {skill:164} 230 gelehrt.",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Zurück zu einem Lehrer für {skill:164}: {spell:9985} wird ab {skill:164} 155 gelehrt.",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Kauf den Bedarf für den ganzen Bereich auf einmal: 28 {item:2605} (28s); insgesamt etwa 28s. Der Pfeil wählt den nächsten Händler deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}). Wenn du die 195 {item:3859} selbst schmilzt ({skill:186} 165: je ein {item:3575} und eine Kohle), kauf auch 195 Kohle (9g 75s, bei Handwerkswaren- und Schmiedebedarfshändlern); lass sie weg, wenn du die Barren kaufst.",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Kauf den Bedarf für den ganzen Bereich auf einmal: {item:5956} (ein Werkzeug: einer, in deinen Taschen aufbewahrt, 18c); insgesamt etwa 18c. Der Pfeil wählt den nächsten Händler deiner Fraktion ({zone:1453}: {npc:5519}, {npc:1286} und {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} und {npc:3413}).",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Experte erfordert Charakterstufe 20 und {skill:164} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 42g wert.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}) and {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}) and {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Die Expertenstufe erhöht das Limit von 150 auf 225 für 50s (Preis aus Classic; der von Forever liegt nicht in den Daten); sie erfordert {skill:164} 125 und Charakterstufe 20, du kannst sie also bei jedem Besuch ab 125 nehmen. Nur wenige Lehrer bringen sie bei: Allianz {npc:4258} ({zone:1455}) und {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}) und {npc:3355} ({zone:1454}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:3501} (ab 140) und {spell:3337} (ab 100, 10s). 150-225 kostet etwa 10s an Rezepten und 28s an Händlerwaren, dazu 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} und 30 {item:7912} zum Sammeln oder Kaufen.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Die Expertenstufe erhöht das Limit von 150 auf 225 für 50s (Preis aus Classic; der von Forever liegt nicht in den Daten); sie erfordert {skill:164} 125 und Charakterstufe 20, du kannst sie also bei jedem Besuch ab 125 nehmen. Nur wenige Lehrer bringen sie bei: Allianz {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:3501} (ab 140) und {spell:3337} (ab 100, 10s). 150-225 kostet etwa 10s an Rezepten und 28s an Händlerwaren, dazu 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} und 30 {item:7912} zum Sammeln oder Kaufen.",
	-- ["Expert {skill:164}"] = "{skill:164} (Experte)",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Geselle erfordert Charakterstufe 10 und {skill:164} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 9g 41s wert.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Die Gesellenstufe erhöht das Limit von 75 auf 150 für 5s; sie erfordert {skill:164} 50 und Charakterstufe 10, du kannst sie also bei jedem Besuch ab 50 nehmen. Nicht jeder {skill:164}-Lehrer bringt sie bei: Allianz {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) und {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) und {npc:3478} ({zone:1413}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:2666} (ab 45, 2s) und {spell:3326} (ab 50, 2s 50c). 75-150 kostet etwa 19s 50c an Rezepten und 18c an Händlerwaren, dazu 256 {item:2836}, 28 {item:2838}, 210 {item:2840} und 320 {item:2841} zum Sammeln oder Kaufen.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) and Traugh ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Die Gesellenstufe erhöht das Limit von 75 auf 150 für 5s; sie erfordert {skill:164} 50 und Charakterstufe 10, du kannst sie also bei jedem Besuch ab 50 nehmen. Nicht jeder {skill:164}-Lehrer bringt sie bei: Allianz {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) und {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) und Traugh ({zone:1413}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:2666} (ab 45, 2s) und {spell:3326} (ab 50, 2s 50c). 75-150 kostet etwa 19s 50c an Rezepten und 18c an Händlerwaren, dazu 256 {item:2836}, 28 {item:2838}, 210 {item:2840} und 320 {item:2841} zum Sammeln oder Kaufen.",
	-- ["Journeyman {skill:164}"] = "{skill:164} (Geselle)",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die ihn fallen lassen, am Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Das Auktionshaus geht auch.",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 120, gelb bis 135, grün bis 150. Erfordert einen Amboss in der Nähe.",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 125, gelb bis 140, grün bis 155. Erfordert einen Amboss in der Nähe. {skill:164} 150 ist ein Meilenstein des Vermächtnissystems.",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Orange (jede Herstellung ein Punkt) bis 15, gelb bis 35, grün bis 55.",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 260, gelb bis 270, grün bis 280. Erfordert einen Amboss in der Nähe.",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 280, gelb bis 292, grün bis 305. Erfordert einen Amboss in der Nähe. {skill:164} 300 ist ein Meilenstein des Vermächtnissystems.",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Orange (jede Herstellung ein Punkt) bis 85, gelb bis 105, grün bis 125. Erfordert einen Amboss in der Nähe.",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pflücke {item:8831} mit {skill:182}; das ist das dichteste Vorkommen in den Daten. Das Auktionshaus geht auch.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1815}, {npc:1816}, {npc:1817} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Schnappkiefer, {npc:2384}, {npc:2354} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "Lehrt {item:12775} (erfordert {skill:164} 255).",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "Lehrt {item:250562} (erfordert {skill:164} 240).",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "Was du für 1-75 brauchst und das Auktionshaus verkauft: 286 {item:2835}. Die Zahlen sinken um das, was du schon in Taschen, Bank und Post hast.",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "Was du für 150-225 brauchst und das Auktionshaus verkauft: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} und 30 {item:7912}. Die Zahlen sinken um das, was du schon in Taschen, Bank und Post hast.",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "Was du für 225-300 brauchst und das Auktionshaus verkauft: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} und 10 {item:12799}. Die Zahlen sinken um das, was du schon in Taschen, Bank und Post hast.",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "Was du für 75-150 brauchst und das Auktionshaus verkauft: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} und 320 {item:2841}. Die Zahlen sinken um das, was du schon in Taschen, Bank und Post hast.",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "Gelb bis 107, grün bis 115: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 155, grün bis 170: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 170, grün bis 185: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "Gelb bis 180, grün bis 185: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 197, grün bis 210: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 212, grün bis 225: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Gelb bis 220, grün bis 230: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe. {skill:164} 225 ist ein Meilenstein des Vermächtnissystems.",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "Gelb bis 232, grün bis 235: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 235, grün bis 245: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Gelb bis 240, grün bis 250: Nicht jede Herstellung bringt einen Punkt. Erfordert einen Amboss in der Nähe.",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "Gelb bis 65, grün bis 85: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Gelb bis 65, grün bis 85: Nicht jede Herstellung bringt einen Punkt. 75 ist die Obergrenze für Lehrling.",
	-- ["a tool, keep it in your bags"] = "ein Werkzeug, behalte es in deinen Taschen",
	-- ["from the pattern bought at the Auction House"] = "aus dem im Auktionshaus gekauften Muster",
	-- ["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",
	-- ["{item:12365} (Alliance)"] = "{item:12365} (Allianz)",
	-- ["{item:12365} (Horde)"] = "{item:12365} (Horde)",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} stammt aus Vorkommen von {object:324} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426} ist bei 285 orange (gelb 290, grün 300, grau 310): etwa 19 Herstellungen bis 300. Jede benötigt 34 {item:12359}, 1 {item:7910} und 1 {item:7909}. Etwa 34 Thoriumbarren pro Herstellung gegenüber den 40 der Streitaxt samt ihren Schleifsteinen, orange bis 290. Unter Charakterstufe 50 hat {npc:14567} keine Quest für dich: Stell stattdessen weiter Huge Thorium Battleaxes bis 300 her (gelb bis 292, grau bei 305: etwa doppelt so viele Thoriumbarren). Braucht einen Amboss in der Nähe. {skill:164} 300 ist ein Meilenstein des Vermächtnissystems.",
	-- ["{item:12426} to 300"] = "{item:12426} bis 300",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643} ist bei 225 orange (gelb 230, grün 232, grau 235): etwa 17 Herstellungen bis 235. Jede benötigt 1 {item:12365}. Ein {item:12365} pro Herstellung (Thoriumadern): günstige Punkte zu Beginn der Meisterstufe.",
	-- ["{item:12643} to 235"] = "{item:12643} bis 235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} ist bei 250 orange (gelb 275, grün 287, grau 300): etwa 5 Herstellungen bis 255, ein Punkt pro Herstellung. Jede benötigt 20 {item:12359}, 2 {item:12799}, 2 {item:12644} und 4 {item:8170}. Stell zuerst die 10 {item:12644} her. {item:12799} taucht in etwa jeder 130. Thoriumader auf: Kauf die zehn im Auktionshaus. Nur fünf Herstellungen, bis die Pläne für die Streitaxt bei 255 nutzbar sind. Braucht einen Amboss in der Nähe.",
	-- ["{item:12773} to 255"] = "{item:12773} bis 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} ist bei 255 orange (gelb 280, grün 292, grau 305): etwa 31 Herstellungen bis 285. Jede benötigt 40 {item:12359}, 6 {item:12644} und 6 {item:8170}. Stell zuerst die 186 {item:12644} her. Pläne von {npc:11278} ({area:2298}, {zone:1422}), unbegrenzter Vorrat, aber sie sind beim Aufheben gebunden. Vierzig Thoriumbarren und sechs Dichte Schleifsteine pro Herstellung: die teuerste Strecke, höre also dort auf, wo {quest:7654} übernimmt. Andere Wege: Weltdrop-Pläne aus dem Auktionshaus (die Radiant-Teile: etwa 820 Thoriumbarren und 190 Hearts of Fire für die Radiant-Route) oder die Sets von Merchant's Favor. Braucht einen Amboss in der Nähe.",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} ist orange bei 255 (gelb 280, grün 292, grau 305): ungefähr 31 Handwerke bis 285. Jeder Tausch kostet 40 {item:12359}, 6 {item:12644} und 6 {item:8170}. Erst die 186 {item:12644} herstellen. Pläne von {npc:11278} in {area:2298} ({zone:1422}): er ist ein Geist, den du nur mit dem {item:13544} Trinne siehst (drauf in {area:2298}), der Belohnung der {npc:11216}-Kette in {area:2057}, die mit {npc:10506} endet (Level 55, einer Dungeon-Gruppe). Unbegrenzte Bestände, aber die Pläne binden sich beim Aufnehmen. Vierzig Thorium-Barren und sechs Dichte Mahlsteine pro Handwerk: der teuerste Teil, also höre auf, wo {quest:7654} übernimmt. Ohne das Trinne: die anderen Wege: weltuelle Pläne vom Auktionshaus (die Radianten Stücke: ungefähr 820 Thorium-Barren und 190 Herzen des Feuers für die Radiant-Route) oder die Handels-Favoriten-Sätze. Daneben muss eine Amboss-Nächte in der Nähe sein.",
	-- ["{item:12775} to 285"] = "{item:12775} bis 285",
	-- ["{item:12775} to 300"] = "{item:12775} bis 300",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "{item:12819} bringt dir {item:12773} ({skill:164} 250) für 1g 60s bei. Verkauft von {npc:11278} ({zone:1422}).",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819} teacht {item:12773} ({skill:164} 250) für 1 Gold 60s. Verkauft von {npc:11278} ({zone:1422}). {npc:11278} ist ein Geist: du siehst ihn nur mit dem {item:13544} an (von der {npc:11216}-Kette in {area:2057}, Level 55, einem Gruppe), also ohne das weglassen.",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "{item:12823} bringt dir {item:12775} ({skill:164} 255) für 2g bei. Verkauft von {npc:11278} ({zone:1422}).",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823} teacht {item:12775} ({skill:164} 255) für 2 Gold. Verkauft von {npc:11278} ({zone:1422}). {npc:11278} ist ein Geist: du siehst ihn nur mit dem {item:13544} an (von der {npc:11216}-Kette in {area:2057}, Level 55, einem Gruppe), also ohne das weglassen.",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Allianz)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- ["{item:250562} to 268"] = "{item:250562} bis 268",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Allianz)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Horde)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} stammt aus Vorkommen von {object:1731} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (Allianz)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (Horde)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} stammt aus Vorkommen von {object:1732} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (Allianz)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (Horde)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} stammt aus Vorkommen von {object:1735} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Allianz)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Horde)",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: ein Werkzeug, behalte es in deinen Taschen",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040} ist bei 185 gelb (gelb 185, grün 197, grau 210): etwa 39 Herstellungen bis 205. Jede benötigt 5 {item:3859} und 2 {spell:3337}. Stell zuerst die 78 {spell:3337} her. Stahlbarren werden aus einem {item:3575} und einer Kohle geschmolzen ({skill:186} 165; Kohle von Handwerkswaren- und Schmiedebedarfshändlern), jede Armschiene braucht also fünf von jedem. Jede Armschiene braucht zwei Schwere Schleifsteine: Stell sie zuerst her. Spezialisierung (optional): Bei 200 und Charakterstufe 40 startet {npc:5164} ({zone:1455}) oder {npc:11177} ({zone:1454}) The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} und eine {item:7935}, deren Pläne aus einer Questreihe der Mithril Order stammen. {npc:11146} ({zone:1455}) oder {npc:11178} ({zone:1454}) startet The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes und 2 Big Black Maces; in Forever sind die Pläne für {item:3853} ({npc:2482}, {area:35}) und {item:3855} beim Aufheben gebunden, kauf und nutz sie also selbst. Du kannst nur eine nehmen; für 300 braucht man keine von beiden, und die Beta hat sie nie getestet (sie endete bei Stufe 30). Braucht einen Amboss in der Nähe.",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:3859} (195 for 150-225): {skill:186}: smelt {item:3575} and Coal; or the Auction House."] = "{item:6040} ist bei 185 gelb (gelb 185, grün 197, grau 210): etwa 39 Herstellungen bis 205. Jede benötigt 5 {item:3859} und 2 {spell:3337}. Stell zuerst die 78 {spell:3337} her. Stahlbarren werden aus einem {item:3575} und einer Kohle geschmolzen ({skill:186} 165; Kohle von Handwerkswaren- und Schmiedebedarfshändlern), jede Armschiene braucht also fünf von jedem. Jede Armschiene braucht zwei Schwere Schleifsteine: Stell sie zuerst her. Spezialisierung (optional): Bei 200 und Charakterstufe 40 startet {npc:5164} ({zone:1455}) oder {npc:11177} ({zone:1454}) The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} und eine {item:7935}, deren Pläne aus einer Questreihe von Mithril Order stammen. {npc:11146} ({zone:1455}) oder {npc:11178} ({zone:1454}) startet The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes und 2 Big Black Maces; in Forever sind die Pläne für {item:3853} ({npc:2482}, {area:35}) und {item:3855} beim Aufheben gebunden, kauf und nutz sie also selbst. Du kannst nur eine nehmen; für 300 braucht man keine von beiden, und die Beta hat sie nie getestet (sie endete bei Stufe 30). Braucht einen Amboss in der Nähe. {item:3859} (195 für 150-225): {skill:186}: {item:3575} und Kohle schmelzen; oder im Auktionshaus.",
	-- ["{item:6040} to 200"] = "{item:6040} bis 200",
	-- ["{item:6040} to 205"] = "{item:6040} bis 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (Allianz)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (Horde)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} stammt aus Vorkommen von {object:2040} ({skill:186}); das ist die dichteste Ansammlung in den Daten. Das Auktionshaus geht auch.",
	-- ["{item:7922} to 225"] = "{item:7922} bis 225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930} ist bei 205 orange (gelb 225, grün 235, grau 245): etwa 20 Herstellungen bis 225, ein Punkt pro Herstellung. Jede benötigt 16 {item:3860}. Sechzehn Mithrilbarren pro Herstellung und sonst nichts; in Forever bis 225 orange, also ein Punkt pro Herstellung bis zum Limit der Meisterstufe. Braucht einen Amboss in der Nähe. {skill:164} 225 ist ein Meilenstein des Vermächtnissystems.",
	-- ["{item:7930} to 225"] = "{item:7930} bis 225",
	-- ["{item:7931} to 230"] = "{item:7931} bis 230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933} ist bei 235 gelb (gelb 230, grün 240, grau 250): etwa 30 Herstellungen bis 247. Jede benötigt 14 {item:3860} und 4 {item:4304}. Mithrilbarren aus Mithrilvorkommen; {item:4304} von Kürschnern oder aus dem Auktionshaus. Braucht einen Amboss in der Nähe.",
	-- ["{item:7933} to 244"] = "{item:7933} bis 244",
	-- ["{item:7933} to 247"] = "{item:7933} bis 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945} ist bei 247 grün (gelb 230, grün 242, grau 255): etwa 11 Herstellungen bis 250. Jede benötigt 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} und 2 {item:4304}. Stell zuerst die 11 {item:7966} her. Nur etwa 11 Herstellungen, um 247-250 zu überbrücken, aber jede braucht vier Schattenedelsteine (etwa einer pro hundert {object:1732}) und eine {item:7971}: Kauf sie im Auktionshaus, es sei denn, deine Taschen enthalten sie schon. Braucht einen Amboss in der Nähe. {item:7971} (11 für 225-300): {item:7971} ist eine seltene Beute (kein Mob lässt sie öfter als einmal in 50 fallen): Kauf sie im Auktionshaus oder behalte die, die du findest.",
	-- ["{item:7945} to 250"] = "{item:7945} bis 250",
	-- ["{item:7956} to 175"] = "{item:7956} bis 175",
	-- ["{item:7963} to 210"] = "{item:7963} bis 210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964} ist bei 175 gelb (gelb 175, grün 180, grau 185): etwa 30 Herstellungen bis 185. Jede benötigt 1 {item:7912}. Ein {item:7912} pro Herstellung (Mithrilvorkommen): günstige Punkte zwischen den Eisen- und den Stahlarmschienen. Nutz die Steine für deine Waffen oder verkauf sie.",
	-- ["{item:7964} to 185"] = "{item:7964} bis 185",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Allianz)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (Allianz)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (Horde)",
	-- ["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "{npc:14567} ({zone:1446}) tauscht {item:12700} ({skill:164} 270) gegen 40 {item:12359} in {quest:7654} ein, die {skill:164} 265 und Charakterstufe 50 erfordert; nimm vorher {quest:7652} an (sie verlangt nichts). Die Pläne sind beim Aufheben gebunden.",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75: Auktionshaus",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225: Auktionshaus",
	-- ["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225: Händlerwaren",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300: Auktionshaus",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150: Auktionshaus",
	-- ["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150: Händlerwaren",
	-- ["{skill:164} materials for 150-225"] = "Materialien für {skill:164} 150-225",
	-- ["{skill:164} materials for 225-300"] = "Materialien für {skill:164} 225-300",
	-- ["{skill:164} materials for 75-150"] = "Materialien für {skill:164} 75-150",
	-- ["{skill:164} recipes at 100"] = "Rezepte für {skill:164} bei 100",
	-- ["{skill:164} recipes at 112"] = "Rezepte für {skill:164} bei 112",
	-- ["{skill:164} recipes at 113"] = "{skill:164}-Rezepte bei 113",
	-- ["{skill:164} recipes at 121"] = "Rezepte für {skill:164} bei 121",
	-- ["{skill:164} recipes at 155"] = "Rezepte für {skill:164} bei 155",
	-- ["{skill:164} recipes at 175"] = "Rezepte für {skill:164} bei 175",
	-- ["{skill:164} recipes at 185"] = "Rezepte für {skill:164} bei 185",
	-- ["{skill:164} recipes at 200"] = "Rezepte für {skill:164} bei 200",
	-- ["{skill:164} recipes at 205"] = "{skill:164}-Rezepte bei 205",
	-- ["{skill:164} recipes at 210"] = "Rezepte für {skill:164} bei 210",
	-- ["{skill:164} recipes at 230"] = "Rezepte für {skill:164} bei 230",
	-- ["{skill:164} recipes at 235"] = "Rezepte für {skill:164} bei 235",
	-- ["{skill:164} recipes at 268"] = "Rezepte für {skill:164} bei 268",
	-- ["{skill:164} recipes at 35"] = "{skill:164}-Rezepte bei 35",
	-- ["{skill:164} recipes at 45"] = "Rezepte für {skill:164} bei 45",
	-- ["{skill:164} recipes at 83"] = "Rezepte für {skill:164} bei 83",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 17s wert.",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: {item:10620} verhütten (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: {item:2770} verhütten (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: {item:2775} verhütten (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: {item:2840} verhütten (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: {item:3575} verhütten (oder das Auktionshaus)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: {item:3858} verhütten (oder das Auktionshaus)",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (oder das Auktionshaus)",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393} (oder das Auktionshaus)",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660} ist bei 1 orange (gelb 15, grün 35, grau 55): etwa 42 Herstellungen bis 35. Jede benötigt 1 {item:2835}. Ein {item:2835} pro Herstellung, bis 15 ein Punkt pro Herstellung.",
	-- ["{spell:2660} to 35"] = "{spell:2660} bis 35",
	-- ["{spell:2660} to 45"] = "{spell:2660} bis 45",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} ist bei 83 orange (gelb 85, grün 105, grau 125): etwa 21 Herstellungen bis 100. Jede benötigt 10 {item:2840}. Forever bringt {spell:2666} ab 45 bei; es bleibt orange bis 85. Zehn Kupferbarren pro Herstellung: Schmelze dein {item:2770}. Braucht einen Amboss in der Nähe. {item:5956} ist ein Werkzeug: Behalte ihn in deinen Taschen.",
	-- ["{spell:2666} to 100"] = "{spell:2666} bis 100",
	-- ["{spell:2668} to 121"] = "{spell:2668} bis 121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672} ist bei 113 orange (gelb 125, grün 140, grau 155): etwa 64 Herstellungen bis 150. Jede benötigt 5 {item:2841} und 2 {spell:3326}. Stell zuerst die 128 {spell:3326} her. Jede Armschiene braucht zwei Grobe Schleifsteine ({item:2836} aus Zinnadern): Stell sie zuerst her; sie geben auch Punkte. Braucht einen Amboss in der Nähe. {skill:164} 150 ist ein Meilenstein des Vermächtnissystems.",
	-- ["{spell:2672} to 150"] = "{spell:2672} bis 150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674} ist bei 100 gelb (gelb 100, grün 107, grau 115): etwa 28 Herstellungen bis 113. Jede benötigt 1 {item:2838}. {item:2838} stammt aus Eisenvorkommen; eins pro Herstellung.",
	-- ["{spell:2674} to 113"] = "{spell:2674} bis 113",
	-- ["{spell:3117} to 112"] = "{spell:3117} bis 112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} ist bei 75 grün (gelb 45, grün 65, grau 85): etwa 58 Herstellungen bis 83. Jede benötigt 2 {item:2835}. Zwei {item:2835} pro Herstellung. Schleifsteine sind Teile für spätere Pläne; die überzähligen verkaufst du an Händler.",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320} ist grün bei 75 (gelb 45, grün 65, grau 85): ungefähr 58 Handwerke bis 83. Jeder Tausch kostet 2 {item:2835}. Zwei {item:2835} pro Handwerk. Mahlsteine sind Teile für spätere Pläne; Reste verkaufe man Händlern. Falls du {spell:3320} noch nicht gelernt hast: ein früherer Schritt teacht es.",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} ist bei 35 orange (gelb 45, grün 65, grau 85): etwa 64 Herstellungen bis 75. Jede benötigt 2 {item:2835}. Zwei {item:2835} pro Herstellung. Schleifsteine sind Teile für spätere Pläne; die überzähligen verkaufst du an Händler.",
	-- ["{spell:3320} to 75"] = "{spell:3320} bis 75",
	-- ["{spell:3320} to 83"] = "{spell:3320} bis 83",
	-- ["{spell:3333} to 155"] = "{spell:3333} bis 155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501} ist bei 150 orange (gelb 165, grün 177, grau 190): etwa 28 Herstellungen bis 175. Jede benötigt 6 {item:3575} und 1 {item:2605}. Sechs Eisenbarren und ein {item:2605} pro Herstellung; {item:2605} gibt es bei Schneider-, Lederer- und Handwerkswarenhändlern. In Forever bis 165 orange, also die ersten fünfzehn Male ein Punkt pro Herstellung. Braucht einen Amboss in der Nähe.",
	-- ["{spell:3501} to 175"] = "{spell:3501} bis 175",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (ab 205) lehren nur die Lehrer für Fachmann: Allianz {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). Du kannst dort jetzt Fachmann lernen, wenn du Stufe 35 bist (dafür brauchst du {skill:164} 200); das spart die Reise bei 225.",
}
