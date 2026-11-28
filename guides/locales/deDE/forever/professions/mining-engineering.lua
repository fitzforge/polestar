-- German (deDE): the guide forever/professions/mining-engineering (forever/professions/mining-engineering.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "",
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
	-- {spell:3918} Rough Blasting Powder
	["This loop gives part of what {spell:3918} needs; the next one the rest."] = "",

	-- Step 6: Mine 56 Rough Stone
	-- {item:2835} Rough Stone
	["Mine 56 {item:2835}"] = "",
	-- {spell:3918} Rough Blasting Powder
	["For 56 {spell:3918}."] = "",

	-- Step 7: Craft 56 Rough Blasting Powder · keep them for the bombs at 56
	-- {spell:3918} Rough Blasting Powder
	["Craft 56 {spell:3918} · keep them for the bombs at 56"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 35."] = "",

	-- Step 8: Mine and smelt 34 Copper Bars
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["Mine and smelt 34 Copper Bars"] = "",
	-- {item:6219} Arclight Spanner
	["For 28 Handfuls of Copper Bolts and 1 {item:6219}."] = "",

	-- Step 9: Learn Handful of Copper Bolts
	-- {spell:3922} Handful of Copper Bolts
	["Learn {spell:3922}"] = "",

	-- Step 10: Train Journeyman Mining
	-- {skill:186} Mining
	["Train Journeyman {skill:186}"] = "",

	-- Step 11: Go to an anvil
	["Go to an anvil"] = "",
	["Anvil"] = "",

	-- Step 12: Craft 28 Handfuls of Copper Bolts · keep them for the bombs at 56
	["Craft 28 Handfuls of Copper Bolts · keep them for the bombs at 56"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 55."] = "",

	-- Step 13: Learn Arclight Spanner
	-- {spell:7430} Arclight Spanner
	["Learn {spell:7430}"] = "",

	-- Step 15: Craft 1 Arclight Spanner
	-- {item:6219} Arclight Spanner
	["Craft 1 {item:6219}"] = "",
	-- {skill:202} Engineering
	["It takes {skill:202} to about 56. A tool: it stays in your bags, and many recipes need it."] = "",

	-- Step 16: Buy 25 Weak Flux
	-- {item:2880} Weak Flux
	["Buy 25 {item:2880}"] = "",
	-- plural, as words: Bronze Tubes = {spell:3938} Bronze Tube
	["For 25 Bronze Tubes."] = "",

	-- Step 17: Get 28 Linen Cloth
	-- {item:2589} Linen Cloth
	["Get 28 {item:2589}"] = "",
	-- plural, as words: Rough Copper Bombs = {spell:3923} Rough Copper Bomb
	["For 28 Rough Copper Bombs."] = "",

	-- Step 18: Mine and smelt 28 Copper Bars
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["Mine and smelt 28 Copper Bars"] = "",

	-- Step 19: Train Journeyman Engineering
	-- {skill:202} Engineering
	["Train Journeyman {skill:202}"] = "",
	["Needs level 10."] = "",

	-- Step 20: Learn Rough Copper Bomb
	-- {spell:3923} Rough Copper Bomb
	["Learn {spell:3923}"] = "",

	-- Step 22: Craft 28 Rough Copper Bombs until 75
	-- plural, as words: Rough Copper Bombs = {spell:3923} Rough Copper Bomb
	["Craft 28 Rough Copper Bombs until 75"] = "",
	["About 28 crafts."] = "",

	-- Step 23: Mine Chunk of Amber and Copper until Mining 65
	-- {skill:186} Mining
	["Mine Chunk of Amber and Copper until {skill:186} 65"] = "",
	-- {spell:3929} Coarse Blasting Powder · {skill:186} Mining
	["What {spell:3929} needs comes from {skill:186} 65."] = "",

	-- Step 24: Mine Copper, Incendicite and Tin until Mining 125
	-- {skill:186} Mining
	["Mine Copper, Incendicite and Tin until {skill:186} 125"] = "",
	-- {spell:3929} Coarse Blasting Powder
	["This loop gives part of what {spell:3929} needs; the next one the rest."] = "",

	-- Step 25: Learn Smelt Bronze
	-- {spell:2659} Smelt Bronze
	["Learn {spell:2659}"] = "",

	-- Step 26: Learn Smelt Tin
	-- {spell:3304} Smelt Tin
	["Learn {spell:3304}"] = "",

	-- Step 27: Train Expert Mining
	-- {skill:186} Mining
	["Train Expert {skill:186}"] = "",

	-- Step 28: Learn Smelt Iron
	-- {spell:3307} Smelt Iron
	["Learn {spell:3307}"] = "",

	-- Step 29: Mine 51 Coarse Stone
	-- {item:2836} Coarse Stone
	["Mine 51 {item:2836}"] = "",
	-- {spell:3929} Coarse Blasting Powder · {skill:186} Mining
	["For 51 {spell:3929}. {skill:186} 125 to 135 on the way."] = "",

	-- Step 30: Learn Coarse Blasting Powder
	-- {spell:3929} Coarse Blasting Powder
	["Learn {spell:3929}"] = "",

	-- Step 31: Learn Coarse Dynamite
	-- {spell:3931} Coarse Dynamite
	["Learn {spell:3931}"] = "",
	["For 90-100: taught here now, so no second trip."] = "",

	-- Step 32: Craft 51 Coarse Blasting Powder · keep them for the dynamite at 90
	-- {spell:3929} Coarse Blasting Powder
	["Craft 51 {spell:3929} · keep them for the dynamite at 90"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 90."] = "",

	-- Step 33: Get 17 Linen Cloth
	-- {item:2589} Linen Cloth
	["Get 17 {item:2589}"] = "",
	-- plural, as words: Coarse Dynamites = {spell:3931} Coarse Dynamite
	["For 17 Coarse Dynamites."] = "",

	-- Step 34: Learn Coarse Dynamite
	["Taught at 75, before the part of the guide you started from."] = "",

	-- Step 35: Craft 17 Coarse Dynamites until 100
	-- plural, as words: Coarse Dynamites = {spell:3931} Coarse Dynamite
	["Craft 17 Coarse Dynamites until 100"] = "",
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact
	["About 17 crafts. Green from 97: short of 100? The Silver Contacts next carry on."] = "",

	-- Step 36: Get 5 Silver Bars
	-- plural, as words: Silver Bars = {item:2842} Silver Bar
	["Get 5 Silver Bars"] = "",
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact
	["For 5 Silver Contacts."] = "",

	-- Step 37: Learn Silver Contact
	-- {spell:3973} Silver Contact
	["Learn {spell:3973}"] = "",

	-- Step 38: Craft 5 Silver Contacts until 105
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact
	["Craft 5 Silver Contacts until 105"] = "",
	["About 5 crafts."] = "",

	-- Step 39: Mine and smelt 50 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Mine and smelt 50 Bronze Bars"] = "",

	-- Step 40: Learn Bronze Tube
	-- {spell:3938} Bronze Tube
	["Learn {spell:3938}"] = "",

	-- Step 42: Craft 25 Bronze Tubes · keep 10 for the scopes at 125
	-- plural, as words: Bronze Tubes = {spell:3938} Bronze Tube
	["Craft 25 Bronze Tubes · keep 10 for the scopes at 125"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 125."] = "",

	-- Step 43: Get 10 Moss Agate
	-- {item:1206} Moss Agate
	["Get 10 {item:1206}"] = "",
	-- plural, as words: Standard Scopes = {spell:3978} Standard Scope
	["For 10 Standard Scopes."] = "",

	-- Step 44: Learn Standard Scope
	-- {spell:3978} Standard Scope
	["Learn {spell:3978}"] = "",

	-- Step 45: Learn Heavy Blasting Powder
	-- {spell:3945} Heavy Blasting Powder
	["Learn {spell:3945}"] = "",
	-- {spell:3945} Heavy Blasting Powder
	["For the 40 {spell:3945} later: taught here now, so no second trip."] = "",

	-- Step 46: Learn Whirring Bronze Gizmo
	-- {spell:3942} Whirring Bronze Gizmo
	["Learn {spell:3942}"] = "",
	["For 135-150: taught here now, so no second trip."] = "",

	-- Step 47: Craft 10 Standard Scopes until 135
	-- plural, as words: Standard Scopes = {spell:3978} Standard Scope
	["Craft 10 Standard Scopes until 135"] = "",
	["About 10 crafts."] = "",

	-- Step 48: Mine Tin and Iron until Mining 155
	-- {skill:186} Mining
	["Mine Tin and Iron until {skill:186} 155"] = "",
	-- {spell:3942} Whirring Bronze Gizmo
	["This loop gives part of what {spell:3942} needs; the next one the rest."] = "",

	-- Step 49: Mine 40 Heavy Stone
	-- {item:2838} Heavy Stone
	["Mine 40 {item:2838}"] = "",
	-- {spell:3945} Heavy Blasting Powder · {skill:186} Mining
	["For 40 {spell:3945}. {skill:186} 155 to 171 on the way."] = "",

	-- Step 50: Get 15 Wool Cloth
	-- {item:2592} Wool Cloth
	["Get 15 {item:2592}"] = "",
	-- plural, as words: Whirring Bronze Gizmos = {spell:3942} Whirring Bronze Gizmo
	["For 15 Whirring Bronze Gizmos."] = "",

	-- Step 51: Mine and smelt 30 Bronze Bars
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Mine and smelt 30 Bronze Bars"] = "",

	-- Step 52: Learn Heavy Blasting Powder
	["Taught at 125, before the part of the guide you started from."] = "",

	-- Step 53: Learn Smelt Gold
	-- {spell:3308} Smelt Gold
	["Learn {spell:3308}"] = "",

	-- Step 54: Craft 40 Heavy Blasting Powder · keep them for the sheep and grenades
	-- {spell:3945} Heavy Blasting Powder
	["Craft 40 {spell:3945} · keep them for the sheep and grenades"] = "",
	["These give points too."] = "",

	-- Step 57: Craft 15 Whirring Bronze Gizmos · keep them for the sheep at 160
	-- plural, as words: Whirring Bronze Gizmos = {spell:3942} Whirring Bronze Gizmo
	["Craft 15 Whirring Bronze Gizmos · keep them for the sheep at 160"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 150."] = "",

	-- Step 58: Get 15 Medium Leather
	-- {item:2319} Medium Leather
	["Get 15 {item:2319}"] = "",
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["For 15 Bronze Frameworks."] = "",

	-- Step 61: Train Expert Engineering
	-- {skill:202} Engineering
	["Train Expert {skill:202}"] = "",
	["Needs level 20."] = "",

	-- Step 62: Learn Bronze Framework
	-- {spell:3953} Bronze Framework
	["Learn {spell:3953}"] = "",

	-- Step 63: Learn Explosive Sheep
	-- {spell:3955} Explosive Sheep
	["Learn {spell:3955}"] = "",
	["For 160-175: taught here now, so no second trip."] = "",

	-- Step 64: Craft 15 Bronze Frameworks · keep them for the sheep next
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["Craft 15 Bronze Frameworks · keep them for the sheep next"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 160."] = "",

	-- Step 65: Get 30 Wool Cloth
	-- {item:2592} Wool Cloth
	["Get 30 {item:2592}"] = "",
	-- plural, as words: Explosive Sheeps = {spell:3955} Explosive Sheep
	["For 15 Explosive Sheeps."] = "",

	-- Step 66: Learn Explosive Sheep
	["Taught at 150, before the part of the guide you started from."] = "",

	-- Step 68: Craft 15 Explosive Sheeps until 175
	-- plural, as words: Explosive Sheeps = {spell:3955} Explosive Sheep
	["Craft 15 Explosive Sheeps until 175"] = "",
	-- {skill:202} Engineering
	["About 15 crafts. Goblin {skill:202} at 200 asks for 5 of these."] = "",

	-- Step 69: Mine Incendicite, Tin, Silver and Iron until Mining 175
	-- {skill:186} Mining
	["Mine Incendicite, Tin, Silver and Iron until {skill:186} 175"] = "",
	-- {item:10505} Solid Blasting Powder · {skill:186} Mining
	["What {item:10505} needs comes from {skill:186} 175."] = "",

	-- Step 70: Mine Iron, Gold and Mithril until Mining 200
	-- {skill:186} Mining
	["Mine Iron, Gold and Mithril until {skill:186} 200"] = "",
	-- {item:10505} Solid Blasting Powder
	["This loop gives part of what {item:10505} needs; the next one the rest."] = "",

	-- Step 71: Train Artisan Mining
	-- {skill:186} Mining
	["Train Artisan {skill:186}"] = "",

	-- Step 72: Mine Iron, Gold and Mithril until Mining 230
	-- {skill:186} Mining
	["Mine Iron, Gold and Mithril until {skill:186} 230"] = "",

	-- Step 73: Mine Gold, Mithril, Dark Iron and Truesilver until Mining 245
	-- {skill:186} Mining
	["Mine Gold, Mithril, Dark Iron and Truesilver until {skill:186} 245"] = "",

	-- Step 74: Mine 122 Solid Stone
	-- {item:7912} Solid Stone
	["Mine 122 {item:7912}"] = "",
	-- {item:10505} Solid Blasting Powder
	["For 61 {item:10505}."] = "",

	-- Step 75: Learn Solid Blasting Powder
	-- {spell:12585} Solid Blasting Powder
	["Learn {spell:12585}"] = "",

	-- Step 76: Learn Gyromatic Micro-Adjustor
	-- {spell:12590} Gyromatic Micro-Adjustor
	["Learn {spell:12590}"] = "",
	["For 193-194: taught here now, so no second trip."] = "",

	-- Step 77: Learn Iron Grenade
	-- {spell:3962} Iron Grenade
	["Learn {spell:3962}"] = "",
	["For 194-195: taught here now, so no second trip."] = "",

	-- Step 78: Craft 61 Solid Blasting Powder · keep them for the triggers and bombs
	-- {item:10505} Solid Blasting Powder
	["Craft 61 {item:10505} · keep them for the triggers and bombs"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 193."] = "",

	-- Step 79: Buy 4 Coal
	["Buy 4 Coal"] = "",
	-- {item:3859} Steel Bar
	["Smelting {item:3859} takes 1 Coal a bar."] = "",

	-- Step 80: Learn Smelt Steel
	-- {spell:3569} Smelt Steel
	["Learn {spell:3569}"] = "",
	["The bars next are smelted from what you mine."] = "",

	-- Step 81: Mine and smelt 4 Steel Bars
	-- plural, as words: Steel Bars = {item:3859} Steel Bar
	["Mine and smelt 4 Steel Bars"] = "",
	-- {item:10498} Gyromatic Micro-Adjustor
	["For 1 {item:10498}."] = "",

	-- Step 82: Learn Gyromatic Micro-Adjustor
	["Taught at 175, before the part of the guide you started from."] = "",

	-- Step 84: Craft 1 Gyromatic Micro-Adjustor until 194
	-- {item:10498} Gyromatic Micro-Adjustor
	["Craft 1 {item:10498} until 194"] = "",
	-- {skill:202} Engineering
	["A tool: some {skill:202} recipes need it in your bags."] = "",

	-- Step 85: Mine and smelt 3 Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Mine and smelt 3 Iron Bars"] = "",
	-- plural, as words: Iron Grenades = {spell:3962} Iron Grenade
	["For 3 Iron Grenades."] = "",

	-- Step 86: Get 3 Silk Cloth
	-- {item:4306} Silk Cloth
	["Get 3 {item:4306}"] = "",

	-- Step 89: Craft 3 Iron Grenades until 195
	-- plural, as words: Iron Grenades = {spell:3962} Iron Grenade
	["Craft 3 Iron Grenades until 195"] = "",
	["About 3 crafts."] = "",

	-- Step 90: Learn Smelt Mithril
	-- {spell:10097} Smelt Mithril
	["Learn {spell:10097}"] = "",

	-- Step 91: Mine and smelt 18 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 18 Mithril Bars"] = "",
	-- plural, as words: Mithril Tubes = {item:10559} Mithril Tube
	["For 6 Mithril Tubes."] = "",

	-- Step 92: Learn Mithril Tube
	-- {spell:12589} Mithril Tube
	["Learn {spell:12589}"] = "",

	-- Step 94: Craft 6 Mithril Tubes until 200
	-- plural, as words: Mithril Tubes = {item:10559} Mithril Tube
	["Craft 6 Mithril Tubes until 200"] = "",
	-- {spell:20220} Gnomish Engineering
	["About 6 crafts. {spell:20220} at 200 asks for 6 of these."] = "",

	-- Step 95: Mine and smelt 21 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 21 Mithril Bars"] = "",
	-- plural, as words: Unstable Triggers = {item:10560} Unstable Trigger
	["For 21 Unstable Triggers."] = "",

	-- Step 96: Get 21 Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get 21 {item:4338}"] = "",

	-- Step 97: Train Artisan Engineering
	-- {skill:202} Engineering
	["Train Artisan {skill:202}"] = "",
	["Needs level 35."] = "",

	-- Step 98: Learn Unstable Trigger
	-- {spell:12591} Unstable Trigger
	["Learn {spell:12591}"] = "",

	-- Step 100: Craft 21 Unstable Triggers · keep 20 for the bombs at 238
	-- plural, as words: Unstable Triggers = {item:10560} Unstable Trigger
	["Craft 21 Unstable Triggers · keep 20 for the bombs at 238"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 215."] = "",

	-- Step 101: Mine and smelt 120 Mithril Bars
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["Mine and smelt 120 Mithril Bars"] = "",
	-- plural, as words: Mithril Casings = {item:10561} Mithril Casing
	["For 40 Mithril Casings."] = "",

	-- Step 102: Learn Mithril Casing
	-- {spell:12599} Mithril Casing
	["Learn {spell:12599}"] = "",

	-- Step 104: Craft 40 Mithril Casings · keep them for the bombs at 238
	-- plural, as words: Mithril Casings = {item:10561} Mithril Casing
	["Craft 40 Mithril Casings · keep them for the bombs at 238"] = "",
	-- {skill:202} Engineering
	["They take {skill:202} to about 238."] = "",

	-- Step 105: Learn Hi-Explosive Bomb
	-- {spell:12619} Hi-Explosive Bomb
	["Learn {spell:12619}"] = "",

	-- Step 107: Craft 20 Hi-Explosive Bombs until 250
	-- plural, as words: Hi-Explosive Bombs = {item:10562} Hi-Explosive Bomb
	["Craft 20 Hi-Explosive Bombs until 250"] = "",
	["About 20 crafts."] = "",

	-- Step 108: Mine Mithril, Truesilver and Small Thorium until Mining 275
	-- {skill:186} Mining
	["Mine Mithril, Truesilver and Small Thorium until {skill:186} 275"] = "",
	-- {item:15992} Dense Blasting Powder
	["This loop gives part of what {item:15992} needs; the next one the rest."] = "",

	-- Step 109: Mine Dark Iron, Truesilver, Small Thorium and Rich Thorium until Mining 300
	-- {object:147516} Dark Iron · {skill:186} Mining
	["Mine {object:147516}, Truesilver, Small Thorium and Rich Thorium until {skill:186} 300"] = "",

	-- Step 110: Mine 88 Dense Stone
	-- {item:12365} Dense Stone
	["Mine 88 {item:12365}"] = "",
	-- {item:15992} Dense Blasting Powder
	["For 44 {item:15992}."] = "",

	-- Step 111: Learn Dense Blasting Powder
	-- {spell:19788} Dense Blasting Powder
	["Learn {spell:19788}"] = "",

	-- Step 112: Craft 44 Dense Blasting Powder until 260
	-- {item:15992} Dense Blasting Powder
	["Craft 44 {item:15992} until 260"] = "",
	-- {item:15997} Thorium Shells
	["About 44 crafts. The {item:15997} at 286 use 14 of these, if you get those plans."] = "",

	-- Step 113: Learn Smelt Thorium
	-- {spell:16153} Smelt Thorium
	["Learn {spell:16153}"] = "",

	-- Step 114: Mine and smelt 84 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 84 Thorium Bars"] = "",
	-- plural, as words: Thorium Widgets = {item:15994} Thorium Widget
	["For 28 Thorium Widgets."] = "",

	-- Step 115: Get 28 Runecloths
	-- plural, as words: Runecloths = {item:14047} Runecloth
	["Get 28 Runecloths"] = "",

	-- Step 116: Buy Schematic: Thorium Widget · Gearcutter Cogspinner
	-- {item:16042} Schematic: Thorium Widget · {npc:5175} Gearcutter Cogspinner
	["Buy {item:16042} · {npc:5175}"] = "",

	-- Step 117: Buy Schematic: Thorium Widget · Sovik
	-- {item:16042} Schematic: Thorium Widget · {npc:3413} Sovik
	["Buy {item:16042} · {npc:3413}"] = "",

	-- Step 118: Learn Thorium Widget
	-- {spell:19791} Thorium Widget
	["Learn {spell:19791}"] = "",
	["From the schematic in your bags."] = "",

	-- Step 120: Craft 28 Thorium Widgets until 286
	-- plural, as words: Thorium Widgets = {item:15994} Thorium Widget
	["Craft 28 Thorium Widgets until 286"] = "",

	-- Step 121: Buy Schematic: Thorium Shells at the Auction House
	-- {item:16051} Schematic: Thorium Shells
	["Buy {item:16051} at the Auction House"] = "",
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Saves 62 Thorium Bars; each craft makes 200 shells to sell."] = "",
	["None listed, or too dear"] = "",

	-- Step 122: Learn Thorium Shells
	-- {spell:19800} Thorium Shells
	["Learn {spell:19800}"] = "",

	-- Step 123: Mine and smelt 28 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 28 Thorium Bars"] = "",
	-- {item:15997} Thorium Shells
	["For 14 {item:15997}."] = "",

	-- Step 125: Craft 14 Thorium Shells until 300
	-- {item:15997} Thorium Shells
	["Craft 14 {item:15997} until 300"] = "",
	["About 14 crafts."] = "",

	-- Step 126: Mine and smelt 90 Thorium Bars
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Mine and smelt 90 Thorium Bars"] = "",
	-- plural, as words: Thorium Tubes = {item:16000} Thorium Tube
	["For 15 Thorium Tubes."] = "",

	-- Step 127: Buy Schematic: Thorium Tube · Xizzer Fizzbolt or Kor'gar
	-- {item:16047} Schematic: Thorium Tube · {npc:11185} Xizzer Fizzbolt · {npc:260565} Kor'gar
	["Buy {item:16047} · {npc:11185} or {npc:260565}"] = "",

	-- Step 128: Buy Schematic: Thorium Tube · Xizzer Fizzbolt
	-- {item:16047} Schematic: Thorium Tube · {npc:11185} Xizzer Fizzbolt
	["Buy {item:16047} · {npc:11185}"] = "",

	-- Step 129: Learn Thorium Tube
	-- {spell:19795} Thorium Tube
	["Learn {spell:19795}"] = "",

	-- Step 131: Craft 15 Thorium Tubes until 300
	-- plural, as words: Thorium Tubes = {item:16000} Thorium Tube
	["Craft 15 Thorium Tubes until 300"] = "",
	["About 15 crafts. Yellow from 295: short of 300? A few more do it."] = "",
}
