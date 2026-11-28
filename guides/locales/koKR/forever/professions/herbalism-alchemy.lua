-- Korean (koKR): the guide forever/professions/herbalism-alchemy (forever/professions/herbalism-alchemy.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "",
	["No character level needed."] = "",

	-- Step 2: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "",

	-- Step 3: Buy 54 Empty Vial
	-- {item:3371} Empty Vial
	["Buy 54 {item:3371}"] = "",
	["For 9 Elixirs of Minor Force and 45 Elixirs of Minor Defense."] = "",

	-- Step 4: Pick until Herbalism 15
	-- {skill:182} Herbalism
	["Pick until {skill:182} 15"] = "",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["This loop gives the {item:765} to {skill:182} 15; the next one the rest."] = "",

	-- Step 5: Pick 9 Silverleaf
	-- {item:765} Silverleaf
	["Pick 9 {item:765}"] = "",
	["For 9 Elixirs of Minor Force."] = "",

	-- Step 6: Craft 9 Elixirs of Minor Force until 10
	["Craft 9 Elixirs of Minor Force until 10"] = "",
	["About 9 crafts."] = "",

	-- Step 7: Pick until Herbalism 50
	-- {skill:182} Herbalism
	["Pick until {skill:182} 50"] = "",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["This loop gives the {item:765} to {skill:182} 50; the next one the rest."] = "",

	-- Step 8: Pick 45 Silverleaf
	-- {item:765} Silverleaf
	["Pick 45 {item:765}"] = "",
	-- {skill:182} Herbalism
	["For 45 Elixirs of Minor Defense. {skill:182} 50 to 67 on the way."] = "",

	-- Step 9: Pick 45 Peacebloom
	-- {item:2447} Peacebloom
	["Pick 45 {item:2447}"] = "",
	["For 45 Elixirs of Minor Defense."] = "",

	-- Step 10: Craft 45 Elixirs of Minor Defense until 55
	["Craft 45 Elixirs of Minor Defense until 55"] = "",
	["About 45 crafts."] = "",

	-- Step 11: Buy 98 Empty Vial
	-- {item:3371} Empty Vial
	["Buy 98 {item:3371}"] = "",
	-- plural, as words: Minor Mana Potions = {spell:2331} Minor Mana Potion · Lesser Mana Potions = {spell:3173} Lesser Mana Potion · Fire Oils = {item:6371} Fire Oil
	["For 10 Minor Mana Potions, 28 Elixirs of Minor Fortitude, 30 Elixirs of Wisdom, 10 Lesser Mana Potions and 20 Fire Oils."] = "",

	-- Step 12: Pick 10 Mageroyal
	-- {item:785} Mageroyal
	["Pick 10 {item:785}"] = "",
	-- plural, as words: Minor Mana Potions = {spell:2331} Minor Mana Potion
	["For 10 Minor Mana Potions."] = "",

	-- Step 13: Pick 10 Peacebloom
	-- {item:2447} Peacebloom
	["Pick 10 {item:2447}"] = "",

	-- Step 14: Train Journeyman Alchemy
	-- {skill:171} Alchemy
	["Train Journeyman {skill:171}"] = "",
	["Needs level 10."] = "",

	-- Step 15: Train Journeyman Herbalism
	-- {skill:182} Herbalism
	["Train Journeyman {skill:182}"] = "",

	-- Step 16: Learn Minor Mana Potion
	-- {spell:2331} Minor Mana Potion
	["Learn {spell:2331}"] = "",

	-- Step 17: Learn Elixir of Minor Fortitude
	-- {spell:2334} Elixir of Minor Fortitude
	["Learn {spell:2334}"] = "",
	["For 65-90: taught here now, so no second trip."] = "",

	-- Step 18: Craft 10 Minor Mana Potions until 65
	-- plural, as words: Minor Mana Potions = {spell:2331} Minor Mana Potion
	["Craft 10 Minor Mana Potions until 65"] = "",
	["About 10 crafts."] = "",

	-- Step 19: Pick 28 Peacebloom
	-- {item:2447} Peacebloom
	["Pick 28 {item:2447}"] = "",
	["For 28 Elixirs of Minor Fortitude."] = "",

	-- Step 20: Pick until Herbalism 70
	-- {skill:182} Herbalism
	["Pick until {skill:182} 70"] = "",
	-- {item:2449} Earthroot · {skill:182} Herbalism
	["This loop gives the {item:2449} to {skill:182} 70; the next one the rest."] = "",

	-- Step 21: Pick until Herbalism 100
	-- {skill:182} Herbalism
	["Pick until {skill:182} 100"] = "",
	-- {item:2449} Earthroot · {skill:182} Herbalism
	["This loop gives the {item:2449} to {skill:182} 100; the next one the rest."] = "",

	-- Step 22: Pick 56 Earthroot
	-- {item:2449} Earthroot
	["Pick 56 {item:2449}"] = "",

	-- Step 23: Learn Elixir of Minor Fortitude
	["Taught at 55; done at once if you learned it then."] = "",

	-- Step 24: Craft 28 Elixirs of Minor Fortitude until 90
	["Craft 28 Elixirs of Minor Fortitude until 90"] = "",
	["About 28 crafts. No points past 75 until Journeyman is trained."] = "",

	-- Step 25: Pick 30 Mageroyal
	-- {item:785} Mageroyal
	["Pick 30 {item:785}"] = "",
	["For 30 Elixirs of Wisdom."] = "",

	-- Step 26: Pick until Herbalism 115
	-- {skill:182} Herbalism
	["Pick until {skill:182} 115"] = "",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["This loop gives the {item:2450} to {skill:182} 115; the next one the rest."] = "",

	-- Step 27: Pick until Herbalism 125
	-- {skill:182} Herbalism
	["Pick until {skill:182} 125"] = "",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["This loop gives the {item:2450} to {skill:182} 125; the next one the rest."] = "",

	-- Step 28: Pick until Herbalism 150
	-- {skill:182} Herbalism
	["Pick until {skill:182} 150"] = "",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["This loop gives the {item:2450} to {skill:182} 150; the next one the rest."] = "",

	-- Step 29: Train Expert Herbalism
	-- {skill:182} Herbalism
	["Train Expert {skill:182}"] = "",

	-- Step 30: Pick until Herbalism 160
	-- {skill:182} Herbalism
	["Pick until {skill:182} 160"] = "",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["This loop gives the {item:2450} to {skill:182} 160; the next one the rest."] = "",

	-- Step 31: Pick 60 Briarthorn
	-- {item:2450} Briarthorn
	["Pick 60 {item:2450}"] = "",

	-- Step 32: Learn Elixir of Wisdom
	-- {spell:3171} Elixir of Wisdom
	["Learn {spell:3171}"] = "",

	-- Step 33: Craft 30 Elixirs of Wisdom until 120
	["Craft 30 Elixirs of Wisdom until 120"] = "",
	["About 30 crafts."] = "",

	-- Step 34: Pick 10 Mageroyal
	-- plural, as words: Lesser Mana Potions = {spell:3173} Lesser Mana Potion
	["For 10 Lesser Mana Potions."] = "",

	-- Step 35: Pick 10 Stranglekelp
	-- {object:2045} Stranglekelp
	["Pick 10 {object:2045}"] = "",

	-- Step 36: Learn Lesser Mana Potion
	-- {spell:3173} Lesser Mana Potion
	["Learn {spell:3173}"] = "",

	-- Step 37: Craft 10 Lesser Mana Potions until 130
	-- plural, as words: Lesser Mana Potions = {spell:3173} Lesser Mana Potion
	["Craft 10 Lesser Mana Potions until 130"] = "",

	-- Step 38: Get 40 Firefin Snapper
	-- {item:6359} Firefin Snapper
	["Get 40 {item:6359}"] = "",
	-- plural, as words: Fire Oils = {item:6371} Fire Oil
	["For 20 Fire Oils."] = "",

	-- Step 39: Learn Fire Oil
	-- {spell:7837} Fire Oil
	["Learn {spell:7837}"] = "",

	-- Step 40: Craft 20 Fire Oils until 150
	-- plural, as words: Fire Oils = {item:6371} Fire Oil
	["Craft 20 Fire Oils until 150"] = "",
	["About 20 crafts. Each craft makes 2 oils. Keep 30: the Elixirs of Fire Power at 150 use them."] = "",

	-- Step 41: Buy 87 Leaded Vial
	-- {item:3372} Leaded Vial
	["Buy 87 {item:3372}"] = "",
	-- plural, as words: Mana Potions = {spell:3452} Mana Potion · Nature Protection Potions = {item:6052} Nature Protection Potion
	["For 15 Elixirs of Fire Power, 36 Mana Potions and 36 Nature Protection Potions."] = "",

	-- Step 42: Pick 15 Kingsblood
	-- {item:3356} Kingsblood
	["Pick 15 {item:3356}"] = "",
	["For 15 Elixirs of Fire Power."] = "",

	-- Step 43: Train Expert Alchemy
	-- {skill:171} Alchemy
	["Train Expert {skill:171}"] = "",
	["Needs level 20."] = "",

	-- Step 44: Learn Elixir of Fire Power
	-- {spell:7845} Elixir of Fire Power
	["Learn {spell:7845}"] = "",

	-- Step 45: Craft 15 Elixirs of Fire Power until 165
	["Craft 15 Elixirs of Fire Power until 165"] = "",
	["About 15 crafts."] = "",

	-- Step 46: Pick until Herbalism 170
	-- {skill:182} Herbalism
	["Pick until {skill:182} 170"] = "",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["This loop gives the {item:3356} to {skill:182} 170; the next one the rest."] = "",

	-- Step 47: Pick 36 Kingsblood
	-- {item:3356} Kingsblood
	["Pick 36 {item:3356}"] = "",
	-- plural, as words: Mana Potions = {spell:3452} Mana Potion
	["For 36 Mana Potions."] = "",

	-- Step 48: Pick 36 Stranglekelp
	-- {object:2045} Stranglekelp
	["Pick 36 {object:2045}"] = "",

	-- Step 49: Learn Mana Potion
	-- {spell:3452} Mana Potion
	["Learn {spell:3452}"] = "",

	-- Step 50: Craft 36 Mana Potions until 195
	-- plural, as words: Mana Potions = {spell:3452} Mana Potion
	["Craft 36 Mana Potions until 195"] = "",
	["About 36 crafts."] = "",

	-- Step 51: Pick until Herbalism 185
	-- {skill:182} Herbalism
	["Pick until {skill:182} 185"] = "",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["This loop gives the {item:3357} to {skill:182} 185; the next one the rest."] = "",

	-- Step 52: Pick 36 Liferoot
	-- {item:3357} Liferoot
	["Pick 36 {item:3357}"] = "",
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion
	["For 36 Nature Protection Potions."] = "",

	-- Step 54: Buy Recipe: Nature Protection Potion · Alchemist Pestlezugg, Glyx Brewright or Logannas
	-- {item:6057} Recipe: Nature Protection Potion · {npc:5594} Alchemist Pestlezugg · {npc:2848} Glyx Brewright · {npc:8157} Logannas
	["Buy {item:6057} · {npc:5594}, {npc:2848} or {npc:8157}"] = "",
	["It binds when picked up."] = "",

	-- Step 55: Buy Recipe: Nature Protection Potion · Alchemist Pestlezugg, Glyx Brewright or Bronk
	-- {item:6057} Recipe: Nature Protection Potion · {npc:5594} Alchemist Pestlezugg · {npc:2848} Glyx Brewright · {npc:8158} Bronk
	["Buy {item:6057} · {npc:5594}, {npc:2848} or {npc:8158}"] = "",

	-- Step 56: Learn Nature Protection Potion
	-- {spell:7259} Nature Protection Potion
	["Learn {spell:7259}"] = "",
	["From the recipe in your bags."] = "",

	-- Step 57: Craft 36 Nature Protection Potions until 225
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion
	["Craft 36 Nature Protection Potions until 225"] = "",

	-- Step 58: Buy 73 Leaded Vial
	-- {item:3372} Leaded Vial
	["Buy 73 {item:3372}"] = "",
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion · Stonescale Oils = {item:13423} Stonescale Oil
	["For 26 Nature Protection Potions and 47 Stonescale Oils."] = "",

	-- Step 59: Buy 69 Crystal Vial
	-- {item:8925} Crystal Vial
	["Buy 69 {item:8925}"] = "",
	["For 25 Elixirs of Greater Intellect and 44 Elixirs of Greater Defense."] = "",

	-- Step 60: Pick until Herbalism 200
	-- {skill:182} Herbalism
	["Pick until {skill:182} 200"] = "",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["This loop gives the {item:3357} to {skill:182} 200; the next one the rest."] = "",

	-- Step 61: Pick 26 Liferoot
	-- {item:3357} Liferoot
	["Pick 26 {item:3357}"] = "",
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion
	["For 26 Nature Protection Potions."] = "",

	-- Step 62: Pick 26 Stranglekelp
	-- {object:2045} Stranglekelp
	["Pick 26 {object:2045}"] = "",

	-- Step 63: Train Artisan Alchemy
	-- {skill:171} Alchemy
	["Train Artisan {skill:171}"] = "",
	["Needs level 35."] = "",

	-- Step 64: Train Artisan Herbalism
	-- {skill:182} Herbalism
	["Train Artisan {skill:182}"] = "",

	-- Step 65: Learn Nature Protection Potion
	["Taught at 195; done at once if you learned it then."] = "",

	-- Step 66: Craft 26 Nature Protection Potions until 235
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion
	["Craft 26 Nature Protection Potions until 235"] = "",
	["About 26 crafts. Green for the last 5 points: short of 235? A few more do it."] = "",

	-- Step 67: Pick 15 Khadgar's Whisker
	-- {object:2043} Khadgar's Whisker
	["Pick 15 {object:2043}"] = "",
	["For 15 Elixirs of Greater Intellect."] = "",

	-- Step 68: Pick until Herbalism 210
	-- {skill:182} Herbalism
	["Pick until {skill:182} 210"] = "",
	-- {skill:182} Herbalism · {item:9179} Elixir of Greater Intellect · {item:8839} Blindweed
	["{skill:182} 200 to 210 before {item:9179}: its {item:8839} come from {skill:182} 260."] = "",

	-- Step 69: Pick until Herbalism 230
	-- {skill:182} Herbalism
	["Pick until {skill:182} 230"] = "",
	-- {skill:182} Herbalism · {item:9179} Elixir of Greater Intellect · {item:8839} Blindweed
	["{skill:182} 210 to 230 before {item:9179}: its {item:8839} come from {skill:182} 260."] = "",

	-- Step 70: Pick until Herbalism 260
	-- {skill:182} Herbalism
	["Pick until {skill:182} 260"] = "",
	-- {skill:182} Herbalism · {item:9179} Elixir of Greater Intellect · {item:8839} Blindweed
	["{skill:182} 230 to 260 before {item:9179}: its {item:8839} come from {skill:182} 260."] = "",

	-- Step 71: Pick 15 Blindweed
	-- {item:8839} Blindweed
	["Pick 15 {item:8839}"] = "",
	-- {skill:182} Herbalism
	["For 15 Elixirs of Greater Intellect. {skill:182} 260 to 281 on the way."] = "",

	-- Step 72: Learn Elixir of Greater Intellect
	-- {spell:11465} Elixir of Greater Intellect
	["Learn {spell:11465}"] = "",

	-- Step 73: Craft 15 Elixirs of Greater Intellect until 250
	["Craft 15 Elixirs of Greater Intellect until 250"] = "",

	-- Step 74: Get 47 Stonescale Eel
	-- {item:13422} Stonescale Eel
	["Get 47 {item:13422}"] = "",
	-- plural, as words: Stonescale Oils = {item:13423} Stonescale Oil
	["For 47 Stonescale Oils."] = "",

	-- Step 75: Learn Stonescale Oil
	-- {spell:17551} Stonescale Oil
	["Learn {spell:17551}"] = "",

	-- Step 76: Craft 47 Stonescale Oils until 260
	-- plural, as words: Stonescale Oils = {item:13423} Stonescale Oil
	["Craft 47 Stonescale Oils until 260"] = "",
	["About 47 crafts. Each craft makes 2 oils. Keep all of them: the elixirs at 265 use 88."] = "",

	-- Step 77: Pick 10 Khadgar's Whisker
	-- {object:2043} Khadgar's Whisker
	["Pick 10 {object:2043}"] = "",
	["For 10 Elixirs of Greater Intellect."] = "",

	-- Step 78: Pick until Herbalism 285
	-- {skill:182} Herbalism
	["Pick until {skill:182} 285"] = "",
	-- {item:8839} Blindweed · {skill:182} Herbalism
	["This loop gives the {item:8839} to {skill:182} 285; the next one the rest."] = "",

	-- Step 79: Pick 10 Blindweed
	-- {item:8839} Blindweed
	["Pick 10 {item:8839}"] = "",

	-- Step 80: Learn Elixir of Greater Intellect
	["Taught at 235; done at once if you learned it then."] = "",

	-- Step 81: Craft 10 Elixirs of Greater Intellect until 265
	["Craft 10 Elixirs of Greater Intellect until 265"] = "",

	-- Step 82: Pick 44 Sungrass
	-- {item:8838} Sungrass
	["Pick 44 {item:8838}"] = "",
	["For 44 Elixirs of Greater Defense."] = "",

	-- Step 83: Buy Recipe: Elixir of Superior Defense · Soolie Berryfizz
	-- {item:13478} Recipe: Elixir of Superior Defense · {npc:5178} Soolie Berryfizz
	["Buy {item:13478} · {npc:5178}"] = "",
	-- {item:13445} Elixir of Greater Defense
	["Its name says Superior Defense; it teaches the {item:13445}."] = "",

	-- Step 84: Buy Recipe: Elixir of Superior Defense · Kor'geld
	-- {item:13478} Recipe: Elixir of Superior Defense · {npc:3348} Kor'geld
	["Buy {item:13478} · {npc:3348}"] = "",

	-- Step 85: Learn Elixir of Greater Defense
	-- {spell:17554} Elixir of Greater Defense
	["Learn {spell:17554}"] = "",

	-- Step 86: Pick until Herbalism 300
	-- {skill:182} Herbalism
	["Pick until {skill:182} 300"] = "",
	-- {skill:182} Herbalism · {skill:171} Alchemy
	["{skill:182} 300 before the last stretch: the guide ends with {skill:171}."] = "",

	-- Step 87: Craft 44 Elixirs of Greater Defense until 300
	["Craft 44 Elixirs of Greater Defense until 300"] = "",
	["About 44 crafts. Yellow from 280: short of 300? A few more do it."] = "",
}
