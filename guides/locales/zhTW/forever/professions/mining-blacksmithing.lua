-- Chinese (traditional) (zhTW): the guide forever/professions/mining-blacksmithing (forever/professions/mining-blacksmithing.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "",
	["No character level needed."] = "",

	-- Step 2: Buy a Blacksmith Hammer
	-- {item:5956} Blacksmith Hammer
	["Buy a {item:5956}"] = "",
	["A tool: it stays in your bags, and most recipes need it."] = "",

	-- Step 3: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "",

	-- Step 4: Buy a Mining Pick
	-- {item:2901} Mining Pick
	["Buy a {item:2901}"] = "",
	["A tool: it stays in your bags, and mining needs it."] = "",

	-- Step 5: Mine Chunk of Amber and Copper until Mining 50
	-- {skill:186} Mining
	["Mine Chunk of Amber and Copper until {skill:186} 50"] = "",
	-- {spell:2660} Rough Sharpening Stone
	["This loop gives part of what {spell:2660} needs; the next one the rest."] = "",

	-- Step 6: Mine Chunk of Amber and Copper until Mining 65
	-- {skill:186} Mining
	["Mine Chunk of Amber and Copper until {skill:186} 65"] = "",

	-- Step 7: Mine 198 Rough Stone
	-- {item:2835} Rough Stone
	["Mine 198 {item:2835}"] = "",
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone · Rough Grinding Stones = {spell:3320} Rough Grinding Stone
	["For 30 Rough Sharpening Stones and 84 Rough Grinding Stones."] = "",

	-- Step 8: Craft 30 Rough Sharpening Stones until 25
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone
	["Craft 30 Rough Sharpening Stones until 25"] = "",
	["About 30 crafts."] = "",

	-- Step 9: Learn Rough Grinding Stone
	-- {spell:3320} Rough Grinding Stone
	["Learn {spell:3320}"] = "",

	-- Step 10: Train Journeyman Mining
	-- {skill:186} Mining
	["Train Journeyman {skill:186}"] = "",

	-- Step 11: Learn Smelt Bronze
	-- {spell:2659} Smelt Bronze
	["Learn {spell:2659}"] = "",

	-- Step 12: Learn Smelt Tin
	-- {spell:3304} Smelt Tin
	["Learn {spell:3304}"] = "",

	-- Step 13: Craft 84 Rough Grinding Stones until 75
	-- plural, as words: Rough Grinding Stones = {spell:3320} Rough Grinding Stone
	["Craft 84 Rough Grinding Stones until 75"] = "",
	["About 84 crafts."] = "",

	-- Step 14: Mine Copper, Incendicite and Tin until Mining 125
	-- {skill:186} Mining
	["Mine Copper, Incendicite and Tin until {skill:186} 125"] = "",
	-- {spell:3326} Coarse Grinding Stone
	["This loop gives part of what {spell:3326} needs; the next one the rest."] = "",

	-- Step 15: Train Expert Mining
	-- {skill:186} Mining
	["Train Expert {skill:186}"] = "",

	-- Step 16: Learn Smelt Iron
	-- {spell:3307} Smelt Iron
	["Learn {spell:3307}"] = "",

	-- Step 17: Mine Tin and Iron until Mining 155
	-- {skill:186} Mining
	["Mine Tin and Iron until {skill:186} 155"] = "",

	-- Step 18: Mine 120 Coarse Stone
	-- {item:2836} Coarse Stone
	["Mine 120 {item:2836}"] = "",
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["For 60 Coarse Grinding Stones."] = "",

	-- Step 19: Train Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Journeyman {skill:164}"] = "",
	["Needs level 10."] = "",

	-- Step 20: Learn Smelt Gold
	-- {spell:3308} Smelt Gold
	["Learn {spell:3308}"] = "",

	-- Step 21: Learn Coarse Grinding Stone
	-- {spell:3326} Coarse Grinding Stone
	["Learn {spell:3326}"] = "",

	-- Step 22: Craft 60 Coarse Grinding Stones · keep them for the bracers and gauntlets
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["Craft 60 Coarse Grinding Stones · keep them for the bracers and gauntlets"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 84."] = "",

	-- Step 23: Mine and smelt 91 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Mine and smelt 91 Bronze Bars"] = "",
	-- {spell:2668} Rough Bronze Leggings · {spell:2672} Patterned Bronze Bracers
	["For 11 {spell:2668} and 5 {spell:2672}."] = "",

	-- Step 24: Learn Rough Bronze Leggings
	-- {spell:2668} Rough Bronze Leggings
	["Learn {spell:2668}"] = "",

	-- Step 25: Go to an anvil
	["Go to an anvil"] = "",
	["Anvil"] = "",

	-- Step 26: Craft 11 Rough Bronze Leggings until 95
	-- {spell:2668} Rough Bronze Leggings
	["Craft 11 {spell:2668} until 95"] = "",
	["About 11 crafts. Short of 84 after the stones? These leggings carry on from where you are."] = "",

	-- Step 27: Learn Patterned Bronze Bracers
	-- {spell:2672} Patterned Bronze Bracers
	["Learn {spell:2672}"] = "",

	-- Step 29: Craft 5 Patterned Bronze Bracers until 100
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 5 {spell:2672} until 100"] = "",
	["About 5 crafts."] = "",

	-- Step 30: Mine Incendicite, Tin, Silver and Iron until Mining 175
	-- {skill:186} Mining
	["Mine Incendicite, Tin, Silver and Iron until {skill:186} 175"] = "",
	-- {spell:3337} Heavy Grinding Stone
	["This loop gives part of what {spell:3337} needs; the next one the rest."] = "",

	-- Step 31: Mine Iron, Gold and Mithril until Mining 200
	-- {skill:186} Mining
	["Mine Iron, Gold and Mithril until {skill:186} 200"] = "",

	-- Step 32: Train Artisan Mining
	-- {skill:186} Mining
	["Train Artisan {skill:186}"] = "",

	-- Step 33: Mine Iron, Gold and Mithril until Mining 230
	-- {skill:186} Mining
	["Mine Iron, Gold and Mithril until {skill:186} 230"] = "",

	-- Step 34: Mine 90 Heavy Stone
	-- {item:2838} Heavy Stone
	["Mine 90 {item:2838}"] = "",
	-- plural, as words: Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["For 30 Heavy Grinding Stones."] = "",

	-- Step 35: Learn Heavy Grinding Stone
	-- {spell:3337} Heavy Grinding Stone
	["Learn {spell:3337}"] = "",

	-- Step 36: Craft 30 Heavy Grinding Stones · keep them for the bracers at 185
	-- plural, as words: Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["Craft 30 Heavy Grinding Stones · keep them for the bracers at 185"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 115."] = "",

	-- Step 37: Mine and smelt 50 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Mine and smelt 50 Bronze Bars"] = "",
	-- {spell:2672} Patterned Bronze Bracers
	["For 10 {spell:2672}."] = "",

	-- Step 38: Learn Patterned Bronze Bracers
	["Taught at 95, before the part of the guide you started from."] = "",

	-- Step 40: Craft 10 Patterned Bronze Bracers until 125
	-- {spell:2672} Patterned Bronze Bracers
	["Craft 10 {spell:2672} until 125"] = "",
	["About 10 crafts."] = "",

	-- Step 41: Mine and smelt 120 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Mine and smelt 120 Bronze Bars"] = "",
	-- {spell:3333} Silvered Bronze Gauntlets
	["For 15 {spell:3333}."] = "",

	-- Step 42: Get 15 Silver Bars
	-- plural, as words: Silver Bars = {item:2842} Silver Bar
	["Get 15 Silver Bars"] = "",

	-- Step 43: Learn Silvered Bronze Gauntlets
	-- {spell:3333} Silvered Bronze Gauntlets
	["Learn {spell:3333}"] = "",

	-- Step 45: Craft 15 Silvered Bronze Gauntlets until 140
	-- {spell:3333} Silvered Bronze Gauntlets
	["Craft 15 {spell:3333} until 140"] = "",
	-- {item:2842} Silver Bar
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["About 15 crafts. {item:2842} dear? 15 Bronze Warhammers reach 140 too."] = "",

	-- Step 46: Buy 40 Green Dye
	-- {item:2605} Green Dye
	["Buy 40 {item:2605}"] = "",
	-- {spell:3501} Green Iron Bracers
	["For 40 {spell:3501}."] = "",

	-- Step 47: Mine and smelt 240 Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Mine and smelt 240 Iron Bars"] = "",

	-- Step 48: Train Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Expert {skill:164}"] = "",
	["Needs level 20."] = "",

	-- Step 49: Learn Green Iron Bracers
	-- {spell:3501} Green Iron Bracers
	["Learn {spell:3501}"] = "",

	-- Step 51: Craft 40 Green Iron Bracers until 175
	-- {spell:3501} Green Iron Bracers
	["Craft 40 {spell:3501} until 175"] = "",
	["About 40 crafts."] = "",

	-- Step 52: Mine 60 Solid Stone
	-- {item:7912} Solid Stone
	["Mine 60 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone · Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["For 8 Solid Grinding Stones and 28 Solid Sharpening Stones."] = "",

	-- Step 53: Learn Solid Grinding Stone
	-- {spell:9920} Solid Grinding Stone
	["Learn {spell:9920}"] = "",

	-- Step 54: Learn Solid Sharpening Stone
	-- {spell:9918} Solid Sharpening Stone
	["Learn {spell:9918}"] = "",
	["For 180-185: taught here now, so no second trip."] = "",

	-- Step 55: Learn Golden Scale Bracers
	-- {spell:7223} Golden Scale Bracers
	["Learn {spell:7223}"] = "",
	["For 185-195: taught here now, so no second trip."] = "",

	-- Step 56: Craft 8 Solid Grinding Stones · keep them for 210
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 8 Solid Grinding Stones · keep them for 210"] = "",
	-- {skill:164} Blacksmithing
	["They take {skill:164} to about 180."] = "",

	-- Step 57: Craft 28 Solid Sharpening Stones until 185
	-- plural, as words: Solid Sharpening Stones = {item:7964} Solid Sharpening Stone
	["Craft 28 Solid Sharpening Stones until 185"] = "",
	["About 28 crafts. Green from 180: short of 185? A few more do it."] = "",

	-- Step 58: Buy 75 Coal
	["Buy 75 Coal"] = "",
	-- {item:3859} Steel Bar
	["Smelting {item:3859} takes 1 Coal a bar."] = "",

	-- Step 59: Learn Smelt Steel
	-- {spell:3569} Smelt Steel
	["Learn {spell:3569}"] = "",
	["The bars next are smelted from what you mine."] = "",

	-- Step 60: Mine and smelt 75 Steel Bars
	-- plural, as words: Steel Bars = {item:3859} Steel Bar
	["Mine and smelt 75 Steel Bars"] = "",
	-- {item:6040} Golden Scale Bracers
	["For 15 {item:6040}."] = "",

	-- Step 61: Learn Golden Scale Bracers
	["Taught at 175, before the part of the guide you started from."] = "",

	-- Step 63: Craft 15 Golden Scale Bracers until 195
	-- {item:6040} Golden Scale Bracers
	["Craft 15 {item:6040} until 195"] = "",
	["About 15 crafts. The Alliance Armorsmithing quest asks for 6 of these."] = "",

	-- Step 64: Learn Smelt Mithril
	-- {spell:10097} Smelt Mithril
	["Learn {spell:10097}"] = "",

	-- Step 65: Mine Gold, Mithril, Dark Iron and Truesilver until Mining 245
	-- {skill:186} Mining
	["Mine Gold, Mithril, Dark Iron and Truesilver until {skill:186} 245"] = "",
	-- {item:7920} Mithril Plate Pants
	["This loop gives part of what {item:7920} needs; the next one the rest."] = "",

	-- Step 66: Mine and smelt 204 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 204 Mithril Bars"] = "",
	-- {item:7920} Mithril Plate Pants
	["For 17 {item:7920}."] = "",

	-- Step 67: Learn Mithril Plate Pants
	-- {spell:9931} Mithril Plate Pants
	["Learn {spell:9931}"] = "",

	-- Step 69: Craft 17 Mithril Plate Pants until 210
	-- {item:7920} Mithril Plate Pants
	["Craft 17 {item:7920} until 210"] = "",
	["About 17 crafts. Armorsmith or Weaponsmith opens at 200 and level 40; optional."] = "",

	-- Step 70: Train Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Train Artisan {skill:164}"] = "",
	["Needs level 35."] = "",

	-- Step 71: Buy Plans: Mithril Spurs at the Auction House
	-- {item:7989} Plans: Mithril Spurs
	["Buy {item:7989} at the Auction House"] = "",
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Saves about 130 Thorium and 150 Mithril Bars."] = "",
	["None listed, or too dear"] = "",

	-- Step 72: Learn Mithril Spurs
	-- {spell:9964} Mithril Spurs
	["Learn {spell:9964}"] = "",
	["From the plans in your bags."] = "",

	-- Step 73: Mine 148 Solid Stone
	-- {item:7912} Solid Stone
	["Mine 148 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 37 Solid Grinding Stones."] = "",

	-- Step 74: Mine and smelt 60 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 60 Mithril Bars"] = "",
	-- {item:7969} Mithril Spurs
	["For 15 {item:7969}."] = "",

	-- Step 76: Craft 37 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 37 Solid Grinding Stones"] = "",
	["Parts for the spurs; no skill points from these."] = "",

	-- Step 78: Craft 15 Mithril Spurs until 225
	-- {item:7969} Mithril Spurs
	["Craft 15 {item:7969} until 225"] = "",
	["About 15 crafts."] = "",

	-- Step 79: Mine 16 Dense Stone
	-- {item:12365} Dense Stone
	["Mine 16 {item:12365}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["For 16 Dense Sharpening Stones. {skill:186} 245 to 263 on the way."] = "",

	-- Step 80: Learn Dense Sharpening Stone
	-- {spell:16641} Dense Sharpening Stone
	["Learn {spell:16641}"] = "",

	-- Step 81: Craft 16 Dense Sharpening Stones until 235
	-- plural, as words: Dense Sharpening Stones = {item:12404} Dense Sharpening Stone
	["Craft 16 Dense Sharpening Stones until 235"] = "",
	["About 16 crafts."] = "",

	-- Step 82: Mine 336 Solid Stone
	-- {item:7912} Solid Stone
	["Mine 336 {item:7912}"] = "",
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["For 84 Solid Grinding Stones."] = "",

	-- Step 83: Mine and smelt 112 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 112 Mithril Bars"] = "",
	-- {item:7969} Mithril Spurs
	["For 28 {item:7969}."] = "",

	-- Step 85: Craft 84 Solid Grinding Stones
	-- plural, as words: Solid Grinding Stones = {item:7966} Solid Grinding Stone
	["Craft 84 Solid Grinding Stones"] = "",

	-- Step 86: Learn Mithril Spurs
	["Taught at 210, before the part of the guide you started from."] = "",

	-- Step 88: Craft 28 Mithril Spurs until 245
	-- {item:7969} Mithril Spurs
	["Craft 28 {item:7969} until 245"] = "",
	["About 28 crafts."] = "",

	-- Step 89: Mine and smelt 72 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 72 Mithril Bars"] = "",
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["For 6 Heavy Mithril Axes."] = "",

	-- Step 90: Get 12 Citrine
	-- {item:3864} Citrine
	["Get 12 {item:3864}"] = "",

	-- Step 91: Get 24 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 24 {item:4234}"] = "",

	-- Step 92: Learn Heavy Mithril Axe
	-- {spell:9993} Heavy Mithril Axe
	["Learn {spell:9993}"] = "",

	-- Step 94: Craft 6 Heavy Mithril Axes until 215
	-- plural, as words: Heavy Mithril Axes = {item:7941} Heavy Mithril Axe
	["Craft 6 Heavy Mithril Axes until 215"] = "",
	["About 6 crafts. The Weaponsmithing quest asks for 2 of these."] = "",

	-- Step 95: Mine and smelt 100 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 100 Mithril Bars"] = "",
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["For 10 Mithril Coifs."] = "",

	-- Step 96: Get 60 Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get 60 {item:4338}"] = "",

	-- Step 97: Learn Mithril Coif
	-- {spell:9961} Mithril Coif
	["Learn {spell:9961}"] = "",

	-- Step 99: Craft 10 Mithril Coifs until 225
	-- plural, as words: Mithril Coifs = {item:7931} Mithril Coif
	["Craft 10 Mithril Coifs until 225"] = "",
	["About 10 crafts. The Armorsmithing quest asks for 2 of these."] = "",

	-- Step 103: Mine and smelt 154 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 154 Mithril Bars"] = "",
	-- {item:7933} Heavy Mithril Boots
	["For 11 {item:7933}."] = "",

	-- Step 104: Get 44 Thick Leather
	-- {item:4304} Thick Leather
	["Get 44 {item:4304}"] = "",

	-- Step 105: Learn Heavy Mithril Boots
	-- {spell:9968} Heavy Mithril Boots
	["Learn {spell:9968}"] = "",

	-- Step 107: Craft 11 Heavy Mithril Boots until 240
	-- {item:7933} Heavy Mithril Boots
	["Craft 11 {item:7933} until 240"] = "",
	["About 11 crafts. The Armorsmithing quest asks for 2 of these."] = "",

	-- Step 108: Get 5 Aquamarine
	-- {item:7909} Aquamarine
	["Get 5 {item:7909}"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts."] = "",

	-- Step 109: Get 30 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 30 {item:8170}"] = "",

	-- Step 110: Learn Smelt Thorium
	-- {spell:16153} Smelt Thorium
	["Learn {spell:16153}"] = "",

	-- Step 111: Mine Mithril, Truesilver and Small Thorium until Mining 275
	-- {skill:186} Mining
	["Mine Mithril, Truesilver and Small Thorium until {skill:186} 275"] = "",
	-- {quest:7653} Imperial Plate Belt
	["This loop gives part of what {quest:7653} needs; the next one the rest."] = "",

	-- Step 112: Mine Dark Iron, Truesilver, Small Thorium and Rich Thorium until Mining 300
	-- {object:147516} Dark Iron · {skill:186} Mining
	["Mine {object:147516}, Truesilver, Small Thorium and Rich Thorium until {skill:186} 300"] = "",

	-- Step 113: Mine and smelt 150 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 150 Thorium Bars"] = "",
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["For 5 Imperial Plate Belts and the plans."] = "",

	-- Step 114: Reach level 50
	["Reach level 50"] = "",
	-- {quest:7652} A Blue Light Bargain
	["{quest:7652} asks for level 50."] = "",

	-- Step 115: Hand in A Blue Light Bargain
	-- {quest:7652} A Blue Light Bargain
	["Hand in {quest:7652}"] = "",

	-- Step 116: Hand in Imperial Plate Belt
	-- {quest:7653} Imperial Plate Belt
	["Hand in {quest:7653}"] = "",

	-- Step 117: Hand in Imperial Plate Bracer
	-- {quest:7655} Imperial Plate Bracer
	["Hand in {quest:7655}"] = "",

	-- Step 118: Learn Imperial Plate Belt
	-- {spell:16647} Imperial Plate Belt
	["Learn {spell:16647}"] = "",

	-- Step 120: Craft 5 Imperial Plate Belts until 245
	-- plural, as words: Imperial Plate Belts = {item:12424} Imperial Plate Belt
	["Craft 5 Imperial Plate Belts until 245"] = "",

	-- Step 121: Get 27 Star Ruby
	-- {item:7910} Star Ruby
	["Get 27 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 27 {item:12425}."] = "",

	-- Step 123: Mine Mithril, Truesilver and Small Thorium until Mining 275
	-- {item:12425} Imperial Plate Bracers
	["This loop gives part of what {item:12425} needs; the next one the rest."] = "",

	-- Step 125: Mine and smelt 560 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 560 Thorium Bars"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 27 {item:12425} and the plans."] = "",

	-- Step 129: Learn Imperial Plate Bracers
	-- {spell:16649} Imperial Plate Bracers
	["Learn {spell:16649}"] = "",

	-- Step 131: Craft 27 Imperial Plate Bracers until 270
	-- {item:12425} Imperial Plate Bracers
	["Craft 27 {item:12425} until 270"] = "",
	["About 27 crafts."] = "",

	-- Step 132: Buy Plans: Radiant Boots at the Auction House
	-- {item:12697} Plans: Radiant Boots
	["Buy {item:12697} at the Auction House"] = "",
	["The cheapest way to 300 when both plans are listed."] = "",

	-- Step 133: Buy Plans: Radiant Leggings at the Auction House
	-- {item:12713} Plans: Radiant Leggings
	["Buy {item:12713} at the Auction House"] = "",

	-- Step 134: Buy Plans: Thorium Leggings at the Auction House
	-- {item:12704} Plans: Thorium Leggings
	["Buy {item:12704} at the Auction House"] = "",
	["Next cheapest; the plans are learned at 275."] = "",

	-- Step 135: Learn Radiant Boots
	-- {spell:16656} Radiant Boots
	["Learn {spell:16656}"] = "",

	-- Step 136: Get 88 Hearts of Fire
	["Get 88 Hearts of Fire"] = "",
	-- {item:12419} Radiant Boots
	["For 22 {item:12419}."] = "",

	-- Step 137: Mine and smelt 308 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 308 Thorium Bars"] = "",

	-- Step 139: Craft 22 Radiant Boots until 290
	-- {item:12419} Radiant Boots
	["Craft 22 {item:12419} until 290"] = "",
	["About 22 crafts."] = "",

	-- Step 140: Get 40 Hearts of Fire
	["Get 40 Hearts of Fire"] = "",
	-- {item:12420} Radiant Leggings
	["For 10 {item:12420}."] = "",

	-- Step 141: Mine and smelt 200 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 200 Thorium Bars"] = "",

	-- Step 142: Learn Radiant Leggings
	-- {spell:16725} Radiant Leggings
	["Learn {spell:16725}"] = "",

	-- Step 144: Craft 10 Radiant Leggings until 300
	-- {item:12420} Radiant Leggings
	["Craft 10 {item:12420} until 300"] = "",

	-- Step 147: Learn Radiant Boots
	["Taught at 270, before the part of the guide you started from."] = "",

	-- Step 150: Get 20 Star Ruby
	-- {item:7910} Star Ruby
	["Get 20 {item:7910}"] = "",
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658}."] = "",

	-- Step 151: Mine and smelt 500 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 500 Thorium Bars"] = "",
	-- {quest:7658} Imperial Plate Leggings
	["For 10 {quest:7658} and the plans."] = "",

	-- Step 152: Hand in Imperial Plate Leggings
	-- {quest:7658} Imperial Plate Leggings
	["Hand in {quest:7658}"] = "",

	-- Step 153: Learn Imperial Plate Leggings
	-- {spell:16730} Imperial Plate Leggings
	["Learn {spell:16730}"] = "",

	-- Step 155: Craft 10 Imperial Plate Leggings until 300
	-- {item:12429} Imperial Plate Leggings
	["Craft 10 {item:12429} until 300"] = "",

	-- Step 156: Get 11 Star Ruby
	-- {item:7910} Star Ruby
	["Get 11 {item:7910}"] = "",
	-- {item:12425} Imperial Plate Bracers
	["For 11 {item:12425}."] = "",

	-- Step 157: Mine and smelt 220 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 220 Thorium Bars"] = "",

	-- Step 158: Learn Imperial Plate Bracers
	["Taught at 245, before the part of the guide you started from."] = "",

	-- Step 160: Craft 11 Imperial Plate Bracers until 275
	-- {item:12425} Imperial Plate Bracers
	["Craft 11 {item:12425} until 275"] = "",
	["About 11 crafts."] = "",

	-- Step 161: Get 108 Red Power Crystals
	-- plural, as words: Red Power Crystals = {item:11186} Red Power Crystal
	["Get 108 Red Power Crystals"] = "",
	-- {item:12414} Thorium Leggings
	["For 27 {item:12414}."] = "",

	-- Step 162: Mine and smelt 702 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 702 Thorium Bars"] = "",

	-- Step 163: Learn Thorium Leggings
	-- {spell:16662} Thorium Leggings
	["Learn {spell:16662}"] = "",

	-- Step 165: Craft 27 Thorium Leggings until 300
	-- {item:12414} Thorium Leggings
	["Craft 27 {item:12414} until 300"] = "",

	-- Step 166: Get 20 Aquamarine
	-- {item:7909} Aquamarine
	["Get 20 {item:7909}"] = "",
	-- {quest:7654} Imperial Plate Boots
	["For 20 {quest:7654}."] = "",

	-- Step 168: Mine and smelt 720 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 720 Thorium Bars"] = "",
	-- {quest:7654} Imperial Plate Boots
	["For 20 {quest:7654} and the plans."] = "",

	-- Step 169: Hand in Imperial Plate Boots
	-- {quest:7654} Imperial Plate Boots
	["Hand in {quest:7654}"] = "",

	-- Step 170: Learn Imperial Plate Boots
	-- {spell:16657} Imperial Plate Boots
	["Learn {spell:16657}"] = "",

	-- Step 172: Craft 20 Imperial Plate Boots until 290
	-- {item:12426} Imperial Plate Boots
	["Craft 20 {item:12426} until 290"] = "",
	["About 20 crafts."] = "",
}
