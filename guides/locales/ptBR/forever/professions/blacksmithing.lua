-- Portuguese (Brazil) (ptBR): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "Aprender {skill:164}",
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

	-- Step 10: Craft 60 Coarse Grinding Stones · keep them for the bracers and gauntlets
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["Craft 60 Coarse Grinding Stones · keep them for the bracers and gauntlets"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 84."] = "",

	-- Step 11: Get 91 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Get 91 Bronze Bars"] = "",
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

	-- Step 20: Craft 30 Heavy Grinding Stones · keep them for the bracers at 185
	-- plural, as words: Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["Craft 30 Heavy Grinding Stones · keep them for the bracers at 185"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 115."] = "",

	-- Step 21: Get 50 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Get 50 Bronze Bars"] = "",
	-- {spell:2672} Patterned Bronze Bracers · {skill:186} Mining
	["For 10 {spell:2672}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 22: Learn Patterned Bronze Bracers
	["Taught at 95, before the part of the guide you started from."] = "",

	-- Step 24: Craft 10 Patterned Bronze Bracers until 125
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 10 {spell:2672} until 125"] = "",
	["About 10 crafts."] = "",

	-- Step 25: Get 120 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Get 120 Bronze Bars"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets · {skill:186} Mining
	["For 15 {spell:3333}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 26: Get 15 Silver Bars
	-- plural, as words: Silver Bars = {item:2842} Silver Bar
	["Get 15 Silver Bars"] = "",
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

	-- Step 31: Get 240 Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Get 240 Iron Bars"] = "",
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

	-- Step 40: Craft 8 Solid Grinding Stones · keep them for 210
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 8 Solid Grinding Stones · keep them for 210"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 180."] = "",

	-- Step 41: Craft 28 Solid Sharpening Stones until 185
	-- plural, as words: Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["Craft 28 Solid Sharpening Stones until 185"] = "",
	["About 28 crafts. Green from 180: short of 185? A few more do it."] = "",

	-- Step 42: Buy 75 Coal
	["Buy 75 Coal"] = "",
	-- {item:3859} Steel Bar
	["Smelting {item:3859} takes 1 Coal a bar."] = "",

	-- Step 43: Get 75 Steel Bars
	-- plural, as words: Steel Bars = {item:3859} Steel Bar
	["Get 75 Steel Bars"] = "",
	-- {item:6040} Golden Scale Bracers · {skill:186} Mining
	["For 15 {item:6040}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 44: Learn Golden Scale Bracers
	["Taught at 175, before the part of the guide you started from."] = "",

	-- Step 46: Craft 15 Golden Scale Bracers until 195
	-- {item:6040} Golden Scale Bracers
	["Craft 15 {item:6040} until 195"] = "",
	["About 15 crafts. The Alliance Armorsmithing quest asks for 6 of these."] = "",

	-- Step 47: Get 204 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 204 Mithril Bars"] = "",
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

	-- Step 55: Get 60 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 60 Mithril Bars"] = "",
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

	-- Step 64: Get 112 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 112 Mithril Bars"] = "",
	-- {item:7969} Mithril Spurs · {skill:186} Mining
	["For 28 {item:7969}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 66: Craft 84 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 84 Solid Grinding Stones"] = "",

	-- Step 67: Learn Mithril Spurs
	["Taught at 210, before the part of the guide you started from."] = "",

	-- Step 69: Craft 28 Mithril Spurs until 245
	-- {item:7969} Mithril Spurs
	["Craft 28 {item:7969} until 245"] = "",
	["About 28 crafts."] = "",

	-- Step 70: Get 72 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 72 Mithril Bars"] = "",
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
	["About 6 crafts. The Weaponsmithing quest asks for 2 of these."] = "",

	-- Step 76: Get 100 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 100 Mithril Bars"] = "",
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
	["About 10 crafts. The Armorsmithing quest asks for 2 of these."] = "",

	-- Step 84: Get 154 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Get 154 Mithril Bars"] = "",
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
	["About 11 crafts. The Armorsmithing quest asks for 2 of these."] = "",

	-- Step 89: Get 5 Aquamarine
	-- {item:7909} Aquamarine
	["Get 5 {item:7909}"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts."] = "",

	-- Step 90: Get 30 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 30 {item:8170}"] = "",

	-- Step 91: Get 150 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 150 Thorium Bars"] = "",
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

	-- Step 100: Get 560 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 560 Thorium Bars"] = "",
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

	-- Step 111: Get 88 Hearts of Fire
	["Get 88 Hearts of Fire"] = "",
	-- {item:12419} Radiant Boots
	["For 22 {item:12419}."] = "",

	-- Step 112: Get 308 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 308 Thorium Bars"] = "",
	-- {item:12419} Radiant Boots · {skill:186} Mining
	["For 22 {item:12419}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 114: Craft 22 Radiant Boots until 290
	-- {item:12419} Radiant Boots
	["Craft 22 {item:12419} until 290"] = "",
	["About 22 crafts."] = "",

	-- Step 115: Get 40 Hearts of Fire
	["Get 40 Hearts of Fire"] = "",
	-- {item:12420} Radiant Leggings
	["For 10 {item:12420}."] = "",

	-- Step 116: Get 200 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 200 Thorium Bars"] = "",
	-- {item:12420} Radiant Leggings · {skill:186} Mining
	["For 10 {item:12420}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 117: Learn Radiant Leggings
	-- {spell:16725} Radiant Leggings
	["Learn {spell:16725}"] = "",

	-- Step 119: Craft 10 Radiant Leggings until 300
	-- {item:12420} Radiant Leggings
	["Craft 10 {item:12420} until 300"] = "",

	-- Step 122: Learn Radiant Boots
	["Taught at 270, before the part of the guide you started from."] = "",

	-- Step 125: Get 20 Star Ruby
	-- {item:7910} Star Ruby
	["Get 20 {item:7910}"] = "",
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658}."] = "",

	-- Step 126: Get 500 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 500 Thorium Bars"] = "",
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

	-- Step 132: Get 220 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 220 Thorium Bars"] = "",
	-- {item:12425} Imperial Plate Bracers · {skill:186} Mining
	["For 11 {item:12425}. No {skill:186}? The bars, not the ore."] = "",

	-- Step 133: Learn Imperial Plate Bracers
	["Taught at 245, before the part of the guide you started from."] = "",

	-- Step 135: Craft 11 Imperial Plate Bracers until 275
	-- {item:12425} Imperial Plate Bracers
	["Craft 11 {item:12425} until 275"] = "",
	["About 11 crafts."] = "",

	-- Step 136: Get 108 Red Power Crystals
	-- plural, as words: Red Power Crystals = {item:11186} Red Power Crystal
	["Get 108 Red Power Crystals"] = "",
	-- {item:12414} Thorium Leggings
	["For 27 {item:12414}."] = "",

	-- Step 137: Get 702 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 702 Thorium Bars"] = "",
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

	-- Step 143: Get 720 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Get 720 Thorium Bars"] = "",
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
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "10 {item:12799} para {item:12773}: {item:12799} aparece em cerca de um {object:175404}, {object:177388} ou {object:180215} em 143: guarde os que encontrar ao minerar.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} para {item:7933} e {item:7945}: {skill:393}: feras de nível 38-50. Esfole {npc:2729}, {npc:2730}, {npc:2732} e {npc:2734} aqui (nível 38-50); o guia de {skill:393} traça essa rota.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "142 {item:4304} para {item:7933} e {item:7945}: {skill:393}: feras de nível 38-50. Esfole {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} e {npc:5296} aqui (nível 38-50); o guia de {skill:393} traça essa rota.",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "168 {item:3575} para {spell:3501}: {skill:186}: fundir {item:2772}.",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "19 {item:7909} para {quest:7654}: {item:7909} aparece em cerca de um {object:2047} ou {object:123309} em 500: guarde os que encontrar ao minerar.",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "19 {item:7910} para {quest:7654}: {item:7910} aparece em cerca de um {object:2047} ou {object:123309} em 143: guarde os que encontrar ao minerar.",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "195 {item:3859} para {item:6040}: {skill:186}: fundir {item:3575} e Carvão.",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "2026 {item:12359} para {item:12773}, {item:12775} e {quest:7654}: {skill:186}: fundir {item:10620}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} para {item:12773} e {item:12775}: {skill:393}: feras de nível 48-60. Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} e {npc:6377} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} para {item:12773} e {item:12775}: {skill:393}: feras de nível 48-60. Esfole {npc:8598}, Cães Pestilentos e {npc:8596} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} para {item:12773} e {item:12775}: {skill:393}: feras de nível 48-60; ou a Casa de Leilões. Esfole {npc:1815}, {npc:1816} e {npc:1817} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "210 {item:2840} para {spell:2666}: {skill:186}: fundir {item:2770}.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "234 {item:2838} para {item:6040}: {skill:186}: {object:1735} (perícia 125) em {zone:1417} (30-40), {zone:1434} (30-45) e {zone:1443} (30-40). O maior aglomerado de {object:1735} em {zone:1417} está marcado.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "234 {item:2838} para {item:6040}: {skill:186}: {object:1735} (perícia 125) em {zone:1441} (25-35), {zone:1417} (30-40) e {zone:1434} (30-45). O maior aglomerado de {object:1735} em {zone:1441} está marcado.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (perícia 65). O maior aglomerado de {object:1732} em {zone:1413} está marcado.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (perícia 65). O maior aglomerado de {object:1732} em {zone:1421} está marcado.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (perícia 65). O maior aglomerado de {object:1732} em {zone:1432} está marcado.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (perícia 65). O maior aglomerado de {object:1732} em {zone:1436} está marcado.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "256 {item:2836} para {spell:2672}: {skill:186}: {object:1732} (perícia 65). O maior aglomerado de {object:1732} em {zone:1439} está marcado.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (perícia 125). O maior aglomerado de {object:1735} em {zone:1413} está marcado.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (perícia 125). O maior aglomerado de {object:1735} em {zone:1417} está marcado.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "28 {item:2838} para {spell:2674}: {skill:186}: {object:1735} (perícia 125). O maior aglomerado de {object:1735} em {zone:1440} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1411} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1412} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1420} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1426} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1429} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:1439} está marcado.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "286 {item:2835} para {spell:2660} e {spell:3320} (116 deles para 75-150: colete todos agora): {skill:186}: {object:1731} (perícia 1). O maior aglomerado de {object:1731} em {zone:2521} está marcado.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "30 {item:7912} para {item:7964}: {skill:186}: {object:2040} (perícia 175) em {zone:1434} (30-45), {zone:1425} (40-50) e {zone:1444} (40-50). O maior aglomerado de {object:2040} em {zone:1434} está marcado.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "30 {item:7912} para {item:7964}: {skill:186}: {object:2040} (perícia 175) em {zone:1443} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50). O maior aglomerado de {object:2040} em {zone:1443} está marcado.",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "320 {item:2841} para {spell:2672}: {skill:186}: fundir {item:2840} e {item:3576}.",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "320 {item:3860} para {item:7930}: {skill:186}: fundir {item:3858}.",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "44 {item:1210} para {item:7945}: {item:1210} aparece em cerca de um {object:1731}, {object:1732} ou {object:1733} em 100: guarde os que encontrar ao minerar.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "44 {item:7912} para {item:7945}: {skill:186}: {object:2040} (perícia 175) em {zone:1425} (40-50), {zone:1444} (40-50) e {zone:1447} (45-55). O maior aglomerado de {object:2040} em {zone:1425} está marcado.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "44 {item:7912} para {item:7945}: {skill:186}: {object:2040} (perícia 175) em {zone:1443} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50). O maior aglomerado de {object:2040} em {zone:1443} está marcado.",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "596 {item:3860} para {item:7933} e {item:7945}: {skill:186}: fundir {item:3858}.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "801 {item:12365} para {item:12643}, {item:12773} e {item:12775}: {skill:186}: {object:324} (perícia 245) em {zone:1419} (45-55), {zone:1448} (48-55) e {zone:1452} (55-60). O maior aglomerado de {object:324} em {zone:1419} está marcado.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "801 {item:12365} para {item:12643}, {item:12773} e {item:12775}: {skill:186}: {object:324} (perícia 245) em {zone:1448} (48-55), {zone:1451} (55-60) e {zone:1452} (55-60). O maior aglomerado de {object:324} em {zone:1448} está marcado.",
	-- ["Apprentice {skill:164}"] = "{skill:164} (Aprendiz)",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "{skill:164} Aprendiz permite fabricar até 75 por 10c, em qualquer nível de personagem. Qualquer instrutor de {skill:164} da sua facção ensina; a seta escolhe o mais próximo. Compre um {item:5956} (em qualquer fornecedor de ferraria) e combine com {skill:186}: {item:2835} e {item:2770} vêm dos Veios de Cobre de todas as zonas iniciais. De 1 a 75 gasta cerca de 1s em receitas, mais 286 {item:2835} para coletar ou comprar.",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Artífice requer nível de personagem 35 e {skill:164} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 942o no total.",
	-- ["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "Artífice eleva o limite de 225 para 300 por 5g (preço do Classic; o do Forever não consta nos dados); exige {skill:164} 200 e nível de personagem 35, então você pode aprender em qualquer visita a partir de 200. Só alguns instrutores ensinam: Aliança {npc:2836} ({zone:1434}); Horda {npc:2836} ({zone:1434}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:16640} (a partir de 225), {spell:9968} (a partir de 210), {spell:9920} (a partir de 175), {spell:10001} (a partir de 205) e {spell:16639} (a partir de 225). De 225 a 300 gasta cerca de 3g 60s em receitas, mais 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} e 10 {item:12799} para coletar ou comprar.",
	-- ["Artisan {skill:164}"] = "{skill:164} (Artífice)",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:16639} a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:16640} a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:2666} a partir de {skill:164} 80.",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:2668} a partir de {skill:164} 95.",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "De volta a um instrutor de {skill:164}: {spell:2672} (a partir de 95, 5s).",
	-- ["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:2672} a partir de {skill:164} 120.",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "De volta a um instrutor de {skill:164}: {spell:2674} (a partir de 100, 10s).",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:3117} a partir de {skill:164} 100.",
	-- ["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "De volta a um instrutor de {skill:164}: {spell:3320} (a partir de 25, 1s). Aprenda também {spell:1230171} (1s): o item de acampamento de {skill:164} do Forever, 1 {item:2835} e 1 {item:2840}, colocado num acampamento ao lado de uma fogueira para dar o benefício. A missão Introdução ao acampamento: {skill:164}, do guia de acampamento da sua área inicial (depois de Vida ao ar livre), manda você a um instrutor de ferraria que ensina de graça.",
	-- ["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:3320} a partir de {skill:164} 45.",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "De volta a um instrutor de {skill:164}: {spell:7223} (a partir de 160).",
	-- ["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:7223} a partir de {skill:164} 185.",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:9916} a partir de {skill:164} 200.",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "De volta a um instrutor de {skill:164}: {spell:9918} (a partir de 175).",
	-- ["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:9918} a partir de {skill:164} 175.",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:9920}, {spell:9935} a partir de {skill:164} 210.",
	-- ["Back to a {skill:164} trainer: {spell:9959} (from 205)."] = "De volta a um instrutor de {skill:164}: {spell:9959} (a partir de 205).",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:9968} a partir de {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Volte a um instrutor de {skill:164}: ele ensina {spell:9985} a partir de {skill:164} 155.",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Compre a parte de toda a faixa de uma vez: 28 {item:2605} (28s); cerca de 28s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}). Se você mesmo fundir as 195 {item:3859} ({skill:186} 165: uma {item:3575} e um Carvão cada), compre também 195 Carvão (9g 75s, em fornecedores de bens de comércio e de ferraria); pule se for comprar as barras.",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Compre a parte de toda a faixa de uma vez: {item:5956} (uma ferramenta: uma só, mantida nas bolsas, 18c); cerca de 18c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:5519}, {npc:1286} e {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} e {npc:3413}).",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Perito requer nível de personagem 20 e {skill:164} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 42o no total.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}) and {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}) and {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Perito eleva o limite de 150 para 225 por 50s (preço do Classic; o do Forever não consta nos dados); exige {skill:164} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:4258} ({zone:1455}) e {npc:2836} ({zone:1434}); Horda {npc:2836} ({zone:1434}) e {npc:3355} ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:3501} (a partir de 140) e {spell:3337} (a partir de 100, 10s). De 150 a 225 gasta cerca de 10s em receitas e 28s em itens de vendedor, mais 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} e 30 {item:7912} para coletar ou comprar.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Perito eleva o limite de 150 para 225 por 50s (preço do Classic; o do Forever não consta nos dados); exige {skill:164} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:4258} ({zone:1455}); Horda {npc:3355} ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:3501} (a partir de 140) e {spell:3337} (a partir de 100, 10s). De 150 a 225 gasta cerca de 10s em receitas e 28s em itens de vendedor, mais 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} e 30 {item:7912} para coletar ou comprar.",
	-- ["Expert {skill:164}"] = "{skill:164} (Perito)",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Profissional requer nível de personagem 10 e {skill:164} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 9o 41p no total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s; exige {skill:164} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:164} ensina: Aliança {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) e {npc:5511} ({zone:1453}); Horda {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) e {npc:3478} ({zone:1413}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:2666} (a partir de 45, 2s) e {spell:3326} (a partir de 50, 2s 50c). De 75 a 150 gasta cerca de 19s 50c em receitas e 18c em itens de vendedor, mais 256 {item:2836}, 28 {item:2838}, 210 {item:2840} e 320 {item:2841} para coletar ou comprar.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) and Traugh ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s; exige {skill:164} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:164} ensina: Aliança {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) e {npc:5511} ({zone:1453}); Horda {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Rosnado ({zone:1454}) e Traugh ({zone:1413}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:2666} (a partir de 45, 2s) e {spell:3326} (a partir de 50, 2s 50c). De 75 a 150 gasta cerca de 19s 50c em receitas e 18c em itens de vendedor, mais 256 {item:2836}, 28 {item:2838}, 210 {item:2840} e 320 {item:2841} para coletar ou comprar.",
	-- ["Journeyman {skill:164}"] = "{skill:164} (Profissional)",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mate os inimigos que deixam cair o item no local de farm que o Polestar escolhe para seu nível e facção. A casa de leilões também serve.",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Laranja (um ponto por criação) até 120, amarelo até 135, verde até 150. Requer uma bigorna por perto.",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Laranja (um ponto por criação) até 125, amarelo até 140, verde até 155. Requer uma bigorna por perto. {skill:164} 150 é um marco do Sistema de Legado.",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Laranja (um ponto por criação) até 15, amarelo até 35, verde até 55.",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Laranja (um ponto por criação) até 260, amarelo até 270, verde até 280. Requer uma bigorna por perto.",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Laranja (um ponto por criação) até 280, amarelo até 292, verde até 305. Requer uma bigorna por perto. {skill:164} 300 é um marco do Sistema de Legado.",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Laranja (um ponto por criação) até 85, amarelo até 105, verde até 125. Requer uma bigorna por perto.",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Colete {item:8831} com {skill:182}; esta é a área mais densa nos dados. A casa de leilões também serve.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:1815}, {npc:1816}, {npc:1817} aqui (feras de nível 48-60 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384}, {npc:2354} aqui (feras de nível 18-30 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} aqui (feras de nível 38-50 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aqui (feras de nível 18-30 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} aqui (feras de nível 38-50 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aqui (feras de nível 48-60 fornecem o item); o guia de {skill:393} traça essa rota. A casa de leilões também serve.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Esfolados, desencantados ou criados por outra profissão: obtenha você mesmo ou compre na casa de leilões.",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "Ensina {item:12775} (requer {skill:164} 255).",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "Ensina {item:250562} (requer {skill:164} 240).",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "O que 1-75 exige e a Casa de Leilões vende: 286 {item:2835}. As contagens diminuem conforme o que suas bolsas, seu banco e sua correspondência guardam.",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "O que 150-225 exige e a Casa de Leilões vende: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} e 30 {item:7912}. As contagens diminuem conforme o que suas bolsas, seu banco e sua correspondência guardam.",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "O que 225-300 exige e a Casa de Leilões vende: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} e 10 {item:12799}. As contagens diminuem conforme o que suas bolsas, seu banco e sua correspondência guardam.",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "O que 75-150 exige e a Casa de Leilões vende: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} e 320 {item:2841}. As contagens diminuem conforme o que suas bolsas, seu banco e sua correspondência guardam.",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "Amarelo até 107, verde até 115: nem toda criação dá ponto.",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 155, verde até 170: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 170, verde até 185: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "Amarelo até 180, verde até 185: nem toda criação dá ponto.",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 197, verde até 210: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 212, verde até 225: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Amarelo até 220, verde até 230: nem toda criação dá ponto. Requer uma bigorna por perto. {skill:164} 225 é um marco do Sistema de Legado.",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "Amarelo até 232, verde até 235: nem toda criação dá ponto.",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 235, verde até 245: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 240, verde até 250: nem toda criação dá ponto. Requer uma bigorna por perto.",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "Amarelo até 65, verde até 85: nem toda criação dá ponto.",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarelo até 65, verde até 85: nem toda criação dá ponto. 75 é o limite de Aprendiz.",
	-- ["a tool, keep it in your bags"] = "uma ferramenta, mantenha nas bolsas",
	-- ["from the pattern bought at the Auction House"] = "do padrão comprado na Casa de Leilões",
	-- ["from the recipe in your bags"] = "pela receita nas suas bolsas",
	-- ["{item:12365} (Alliance)"] = "{item:12365} (Aliança)",
	-- ["{item:12365} (Horde)"] = "{item:12365} (Horda)",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} sai de {object:324} ({skill:186}); este é o maior aglomerado nos dados. A casa de leilões também serve.",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426} é laranja em 285 (amarelo 290, verde 300, cinza 310): cerca de 19 criações até 300. Cada uma usa 34 {item:12359}, 1 {item:7910} e 1 {item:7909}. Cerca de 34 Barras de Tório por criação contra 40 do machado de batalha e suas pedras de amolar, laranja até 290. Abaixo do nível de personagem 50, {npc:14567} não tem missão para você: continue fazendo Machados de Batalha de Tório Enormes até 300 (amarelo até 292, cinza em 305: cerca do dobro de Barras de Tório). Precisa de uma bigorna por perto. {skill:164} 300 é um marco do Sistema de Legado.",
	-- ["{item:12426} to 300"] = "{item:12426} até 300",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643} é laranja em 225 (amarelo 230, verde 232, cinza 235): cerca de 17 criações até 235. Cada uma usa 1 {item:12365}. Uma {item:12365} por criação (veios de Tório): pontos baratos no início de Artífice.",
	-- ["{item:12643} to 235"] = "{item:12643} até 235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} é laranja em 250 (amarelo 275, verde 287, cinza 300): cerca de 5 criações até 255, um ponto a cada criação. Cada uma usa 20 {item:12359}, 2 {item:12799}, 2 {item:12644} e 4 {item:8170}. Faça primeiro as 10 {item:12644}. {item:12799} aparece em cerca de um veio de Tório em 130: compre as dez na Casa de Leilões. São só cinco criações, até os planos do machado de batalha poderem ser usados em 255. Precisa de uma bigorna por perto.",
	-- ["{item:12773} to 255"] = "{item:12773} até 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} é laranja em 255 (amarelo 280, verde 292, cinza 305): cerca de 31 criações até 285. Cada uma usa 40 {item:12359}, 6 {item:12644} e 6 {item:8170}. Faça primeiro as 186 {item:12644}. Planos de {npc:11278} ({area:2298}, {zone:1422}), estoque ilimitado, mas são vinculados ao pegar. Quarenta Barras de Tório e seis Pedras de Amolar Densas por criação: o trecho mais caro, então pare onde {quest:7654} assumir. Outros caminhos: planos de saque do mundo na Casa de Leilões (as peças Radiantes: cerca de 820 Barras de Tório e 190 Corações de Fogo para o caminho Radiante) ou os conjuntos Favor do Mercador. Precisa de uma bigorna por perto.",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775} está laranja em 255 (amarelo 280, verde 292, cinza 305): cerca de 31 produções até 285. Cada uma leva 40 {item:12359}, 6 {item:12644} e 6 {item:8170}. Faça primeiro as 186 {item:12644}. Projetos com {npc:11278} em {area:2298} ({zone:1422}): ele é um fantasma que você só vê com o berloque {item:13544} equipado (equipe-o dentro de {area:2298}), a recompensa da cadeia de {npc:11216} em {area:2057} que termina com {npc:10506} (nível 55, um grupo de masmorra). Estoque ilimitado, mas os projetos ficam vinculados ao serem pegos. Quarenta barras de tório e seis pedras de amolar densas por produção: o trecho mais caro, então pare onde {quest:7654} assumem. Sem o berloque, os outros caminhos: projetos de saque do mundo na Casa de Leilões (as peças radiantes: cerca de 820 barras de tório e 190 corações de fogo para o caminho radiante) ou os conjuntos do Favor dos Mercadores. Precisa de uma bigorna por perto.",
	-- ["{item:12775} to 285"] = "{item:12775} até 285",
	-- ["{item:12775} to 300"] = "{item:12775} até 300",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "{item:12819} ensina {item:12773} ({skill:164} 250) por 1g 60s. Vendido por {npc:11278} ({zone:1422}).",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819} ensina {item:12773} ({skill:164} 250) por 1 o 60 p. Vendido por {npc:11278} ({zone:1422}). {npc:11278} é um fantasma: você só o vê com {item:13544} equipado (da cadeia de {npc:11216} em {area:2057}, nível 55, em grupo), então pule isto sem ele.",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "{item:12823} ensina {item:12775} ({skill:164} 255) por 2g. Vendido por {npc:11278} ({zone:1422}).",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823} ensina {item:12775} ({skill:164} 255) por 2 o. Vendido por {npc:11278} ({zone:1422}). {npc:11278} é um fantasma: você só o vê com {item:13544} equipado (da cadeia de {npc:11216} em {area:2057}, nível 55, em grupo), então pule isto sem ele.",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Aliança)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- ["{item:250562} to 268"] = "{item:250562} até 268",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Aliança)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Horda)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} sai de {object:1731} ({skill:186}); este é o maior aglomerado nos dados. A casa de leilões também serve.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (Aliança)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (Horda)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} sai de {object:1732} ({skill:186}); este é o maior aglomerado nos dados. A casa de leilões também serve.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (Aliança)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (Horda)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} sai de {object:1735} ({skill:186}); este é o maior aglomerado nos dados. A casa de leilões também serve.",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Aliança)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: uma ferramenta, mantenha-a nas bolsas",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040} é amarelo em 185 (amarelo 185, verde 197, cinza 210): cerca de 39 criações até 205. Cada uma usa 5 {item:3859} e 2 {spell:3337}. Faça primeiro as 78 {spell:3337}. As Barras de Aço são fundidas de uma {item:3575} e um Carvão ({skill:186} 165; Carvão de fornecedores de bens de comércio e de ferraria), então cada braçadeira pede cinco de cada. Cada braçadeira usa duas Pedras de Amolar Pesadas: faça-as antes. Especialização (opcional): em 200 e nível de personagem 40, {npc:5164} ({zone:1455}) ou {npc:11177} ({zone:1454}) inicia A arte de forjar armaduras ({spell:9788}): 4 Elmos Ornados de Mithril, 2 {item:7936} e 1 {item:7935}, cujos planos vêm de uma cadeia de missões da Ordem do Mithril. {npc:11146} ({zone:1455}) ou {npc:11178} ({zone:1454}) inicia O caminho do armeiro: 4 Espadas Largas de Lunaço, 4 Machados Sólidos de Ferro, 2 Machados Pesados de Mithril e 2 Grandes Maças Pretas; no Forever os planos de {item:3853} ({npc:2482}, {area:35}) e os de {item:3855} são vinculados ao pegar, então compre e use você mesmo. Só dá para escolher uma; nenhuma é necessária para chegar a 300, e a beta nunca as testou (parou no nível 30). Precisa de uma bigorna por perto.",
	-- ["{item:6040} to 200"] = "{item:6040} até 200",
	-- ["{item:6040} to 205"] = "{item:6040} até 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (Aliança)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (Horda)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} sai de {object:2040} ({skill:186}); este é o maior aglomerado nos dados. A casa de leilões também serve.",
	-- ["{item:7922} to 225"] = "{item:7922} até 225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930} é laranja em 205 (amarelo 225, verde 235, cinza 245): cerca de 20 criações até 225, um ponto a cada criação. Cada uma usa 16 {item:3860}. Dezesseis Barras de Mithril por criação e mais nada; laranja até 225 no Forever, então um ponto a cada criação até o limite de Artífice. Precisa de uma bigorna por perto. {skill:164} 225 é um marco do Sistema de Legado.",
	-- ["{item:7930} to 225"] = "{item:7930} até 225",
	-- ["{item:7931} to 230"] = "{item:7931} até 230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933} é amarelo em 235 (amarelo 230, verde 240, cinza 250): cerca de 30 criações até 247. Cada uma usa 14 {item:3860} e 4 {item:4304}. Barras de Mithril de Depósitos de Mithril; {item:4304} de esfoladores ou da Casa de Leilões. Precisa de uma bigorna por perto.",
	-- ["{item:7933} to 244"] = "{item:7933} até 244",
	-- ["{item:7933} to 247"] = "{item:7933} até 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945} é verde em 247 (amarelo 230, verde 242, cinza 255): cerca de 11 criações até 250. Cada uma usa 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} e 2 {item:4304}. Faça primeiro as 11 {item:7966}. São só cerca de 11 criações para ligar 247 a 250, mas cada uma pede quatro Tenebritas (cerca de um {object:1732} em cem) e uma {item:7971}: compre na Casa de Leilões, a menos que suas bolsas já os tenham. Precisa de uma bigorna por perto. {item:7971} (11 para 225-300): {item:7971} é um saque raro (nenhum monstro dá um a cada 50): compre na Casa de Leilões, ou guarde os que encontrar.",
	-- ["{item:7945} to 250"] = "{item:7945} até 250",
	-- ["{item:7956} to 175"] = "{item:7956} até 175",
	-- ["{item:7963} to 210"] = "{item:7963} até 210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964} é amarelo em 175 (amarelo 175, verde 180, cinza 185): cerca de 30 criações até 185. Cada uma usa 1 {item:7912}. Uma {item:7912} por criação (Depósitos de Mithril): pontos baratos entre as braçadeiras de ferro e as de aço. Use as pedras nas suas armas ou venda.",
	-- ["{item:7964} to 185"] = "{item:7964} até 185",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Aliança)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (Aliança)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (Horda)",
	-- ["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "{npc:14567} ({zone:1446}) troca {item:12700} ({skill:164} 270) por 40 {item:12359} em {quest:7654}, que exige {skill:164} 265 e nível de personagem 50; faça {quest:7652} antes (ela não pede nada). Os planos são vinculados ao pegar.",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75: Casa de Leilões",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225: Casa de Leilões",
	-- ["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225: itens de vendedor",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300: Casa de Leilões",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150: Casa de Leilões",
	-- ["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150: itens de vendedor",
	-- ["{skill:164} materials for 150-225"] = "Materiais de {skill:164} para 150-225",
	-- ["{skill:164} materials for 225-300"] = "Materiais de {skill:164} para 225-300",
	-- ["{skill:164} materials for 75-150"] = "Materiais de {skill:164} para 75-150",
	-- ["{skill:164} recipes at 100"] = "Receitas de {skill:164} em 100",
	-- ["{skill:164} recipes at 112"] = "Receitas de {skill:164} em 112",
	-- ["{skill:164} recipes at 113"] = "Receitas de {skill:164} em 113",
	-- ["{skill:164} recipes at 121"] = "Receitas de {skill:164} em 121",
	-- ["{skill:164} recipes at 155"] = "Receitas de {skill:164} em 155",
	-- ["{skill:164} recipes at 175"] = "Receitas de {skill:164} em 175",
	-- ["{skill:164} recipes at 185"] = "Receitas de {skill:164} em 185",
	-- ["{skill:164} recipes at 200"] = "Receitas de {skill:164} em 200",
	-- ["{skill:164} recipes at 205"] = "Receitas de {skill:164} em 205",
	-- ["{skill:164} recipes at 210"] = "Receitas de {skill:164} em 210",
	-- ["{skill:164} recipes at 230"] = "Receitas de {skill:164} em 230",
	-- ["{skill:164} recipes at 235"] = "Receitas de {skill:164} em 235",
	-- ["{skill:164} recipes at 268"] = "Receitas de {skill:164} em 268",
	-- ["{skill:164} recipes at 35"] = "Receitas de {skill:164} em 35",
	-- ["{skill:164} recipes at 45"] = "Receitas de {skill:164} em 45",
	-- ["{skill:164} recipes at 83"] = "Receitas de {skill:164} em 83",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} acompanha a evolução de nível. O Sistema de Legado do Forever recompensa profissões de criação na perícia 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 17p no total.",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funda {item:10620} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funda {item:2770} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: funda {item:2775} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funda {item:2840} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funda {item:3575} (ou a casa de leilões)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funda {item:3858} (ou a casa de leilões)",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (ou a casa de leilões)",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393} (ou a casa de leilões)",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660} é laranja em 1 (amarelo 15, verde 35, cinza 55): cerca de 42 criações até 35. Cada uma usa 1 {item:2835}. Uma {item:2835} por criação, um ponto a cada criação até 15.",
	-- ["{spell:2660} to 35"] = "{spell:2660} até 35",
	-- ["{spell:2660} to 45"] = "{spell:2660} até 45",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} é laranja em 83 (amarelo 85, verde 105, cinza 125): cerca de 21 criações até 100. Cada uma usa 10 {item:2840}. O Forever ensina {spell:2666} a partir de 45; ela continua laranja até 85. Dez Barras de Cobre por criação: funda seu {item:2770}. Precisa de uma bigorna por perto. {item:5956} é uma ferramenta: mantenha nas bolsas.",
	-- ["{spell:2666} to 100"] = "{spell:2666} até 100",
	-- ["{spell:2668} to 121"] = "{spell:2668} até 121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672} é laranja em 113 (amarelo 125, verde 140, cinza 155): cerca de 64 criações até 150. Cada uma usa 5 {item:2841} e 2 {spell:3326}. Faça primeiro as 128 {spell:3326}. Cada braçadeira usa duas Pedras de Amolar Grosseiras ({item:2836} de Veios de Estanho): faça-as antes; elas também dão pontos. Precisa de uma bigorna por perto. {skill:164} 150 é um marco do Sistema de Legado.",
	-- ["{spell:2672} to 150"] = "{spell:2672} até 150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674} é amarela em 100 (amarelo 100, verde 107, cinza 115): cerca de 28 criações até 113. Cada uma usa 1 {item:2838}. {item:2838} vem de Depósitos de Ferro; um por criação.",
	-- ["{spell:2674} to 113"] = "{spell:2674} até 113",
	-- ["{spell:3117} to 112"] = "{spell:3117} até 112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} é verde em 75 (amarelo 45, verde 65, cinza 85): cerca de 58 criações até 83. Cada uma usa 2 {item:2835}. Duas {item:2835} por criação. As pedras de amolar são peças para planos futuros; as sobras vão para vendedores.",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320} está verde em 75 (amarelo 45, verde 65, cinza 85): cerca de 58 produções até 83. Cada uma leva 2 {item:2835}. Duas {item:2835} por produção. Pedras de amolar são peças para projetos posteriores; as que sobrarem vendem a mercadores. Se chegou aqui sem aprender {spell:3320}, aprenda agora: uma etapa anterior ensina.",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320} é laranja em 35 (amarelo 45, verde 65, cinza 85): cerca de 64 criações até 75. Cada uma usa 2 {item:2835}. Duas {item:2835} por criação. As pedras de amolar são peças para planos futuros; as sobras vão para vendedores.",
	-- ["{spell:3320} to 75"] = "{spell:3320} até 75",
	-- ["{spell:3320} to 83"] = "{spell:3320} até 83",
	-- ["{spell:3333} to 155"] = "{spell:3333} até 155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501} é laranja em 150 (amarelo 165, verde 177, cinza 190): cerca de 28 criações até 175. Cada uma usa 6 {item:3575} e 1 {item:2605}. Seis Barras de Ferro e um {item:2605} por criação; {item:2605} vem de vendedores de alfaiataria, couraria e suprimentos de comércio. Laranja até 165 no Forever, então um ponto a cada criação nas primeiras quinze. Precisa de uma bigorna por perto.",
	-- ["{spell:3501} to 175"] = "{spell:3501} até 175",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (a partir de 205) só é ensinada pelos instrutores Artífice: Aliança {npc:2836} ({zone:1434}); Horda {npc:2836} ({zone:1434}). Você pode treinar Artífice lá agora se estiver no nível 35 (exige {skill:164} 200), o que poupa a viagem em 225.",
}
