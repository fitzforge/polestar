-- Chinese (traditional) (zhTW): the guide forever/professions/herbalism-alchemy (forever/professions/herbalism-alchemy.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "",
	["No character level needed."] = "",

	-- Step 2: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "",

	-- Step 3: Buy 54 Empty Vials
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Buy 54 Empty Vials"] = "",
	["For 9 Elixirs of Minor Force and 45 Elixirs of Minor Defense."] = "",

	-- Step 4: Pick Peacebloom and Silverleaf until Herbalism 15
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:2447} and {item:765} until {skill:182} 15"] = "",
	-- {item:247755} Elixir of Minor Force
	["This loop gives part of what {item:247755} needs; the next one the rest."] = "",

	-- Step 5: Pick 9 Silverleaf
	-- {item:765} Silverleaf
	["Pick 9 {item:765}"] = "",
	["For 9 Elixirs of Minor Force."] = "",

	-- Step 6: Craft 9 Elixirs of Minor Force until 10
	["Craft 9 Elixirs of Minor Force until 10"] = "",
	["About 9 crafts."] = "",

	-- Step 7: Pick Peacebloom, Silverleaf and Earthroot until Herbalism 50
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick {item:2447}, {item:765} and {item:2449} until {skill:182} 50"] = "",
	-- {item:5997} Elixir of Minor Defense
	["This loop gives part of what {item:5997} needs; the next one the rest."] = "",

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

	-- Step 11: Buy 98 Empty Vials
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Buy 98 Empty Vials"] = "",
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

	-- Step 20: Pick Silverleaf, Peacebloom, Earthroot and Mageroyal until Herbalism 70
	-- {item:765} Silverleaf · {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:765}, {item:2447}, {item:2449} and {item:785} until {skill:182} 70"] = "",
	-- {spell:2334} Elixir of Minor Fortitude
	["This loop gives part of what {spell:2334} needs; the next one the rest."] = "",

	-- Step 21: Pick Silverleaf, Peacebloom, Earthroot, Mageroyal and Briarthorn until Herbalism 100
	-- {item:765} Silverleaf · {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:765}, {item:2447}, {item:2449}, {item:785} and {item:2450} until {skill:182} 100"] = "",

	-- Step 22: Pick 56 Earthroot
	-- {item:2449} Earthroot
	["Pick 56 {item:2449}"] = "",

	-- Step 23: Learn Elixir of Minor Fortitude
	["Taught at 55, before the part of the guide you started from."] = "",

	-- Step 24: Craft 28 Elixirs of Minor Fortitude until 90
	["Craft 28 Elixirs of Minor Fortitude until 90"] = "",
	["About 28 crafts. No points past 75 until Journeyman is trained."] = "",

	-- Step 25: Pick 30 Mageroyal
	-- {item:785} Mageroyal
	["Pick 30 {item:785}"] = "",
	["For 30 Elixirs of Wisdom."] = "",

	-- Step 26: Pick Mageroyal, Briarthorn, Stranglekelp and Bruiseweed until Herbalism 115
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:785}, {item:2450}, Stranglekelp and {item:2453} until {skill:182} 115"] = "",
	-- {spell:3171} Elixir of Wisdom
	["This loop gives part of what {spell:3171} needs; the next one the rest."] = "",

	-- Step 27: Pick Mageroyal, Briarthorn, Stranglekelp, Bruiseweed and Wild Steelbloom until Herbalism 125
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {object:2045} Stranglekelp · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:785}, {item:2450}, {object:2045}, {item:2453} and Wild Steelbloom until {skill:182} 125"] = "",

	-- Step 28: Pick Mageroyal, Briarthorn, Bruiseweed, Wild Steelbloom and Kingsblood until Herbalism 150
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:785}, {item:2450}, {item:2453}, Wild Steelbloom and {item:3356} until {skill:182} 150"] = "",

	-- Step 29: Train Expert Herbalism
	-- {skill:182} Herbalism
	["Train Expert {skill:182}"] = "",

	-- Step 30: Pick Briarthorn, Bruiseweed, Wild Steelbloom, Kingsblood and Liferoot until Herbalism 160
	-- {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:2450}, {item:2453}, {object:1623}, {item:3356} and {item:3357} until {skill:182} 160"] = "",

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

	-- Step 40: Craft 20 Fire Oils · keep 30 for the Elixirs of Fire Power
	-- plural, as words: Fire Oils = {item:6371} Fire Oil
	["Craft 20 Fire Oils · keep 30 for the Elixirs of Fire Power"] = "",
	-- {skill:171} Alchemy
	["They take {skill:171} to about 150. Each craft makes 2 oils."] = "",

	-- Step 41: Buy 87 Leaded Vials
	-- plural, as words: Leaded Vials = {item:3372} Leaded Vial
	["Buy 87 Leaded Vials"] = "",
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

	-- Step 46: Pick Briarthorn, Wild Steelbloom, Kingsblood, Liferoot and Fadeleaf until Herbalism 170
	-- {item:2450} Briarthorn · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {skill:182} Herbalism
	["Pick {item:2450}, {object:1623}, {item:3356}, {item:3357} and {item:3818} until {skill:182} 170"] = "",
	-- {spell:3452} Mana Potion
	["This loop gives part of what {spell:3452} needs; the next one the rest."] = "",

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

	-- Step 51: Pick Wild Steelbloom, Kingsblood, Liferoot, Fadeleaf and Goldthorn until Herbalism 185
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick {object:1623}, {item:3356}, {item:3357}, {item:3818} and {item:3821} until {skill:182} 185"] = "",
	-- {item:6052} Nature Protection Potion
	["This loop gives part of what {item:6052} needs; the next one the rest."] = "",

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

	-- Step 58: Buy 73 Leaded Vials
	-- plural, as words: Leaded Vials = {item:3372} Leaded Vial
	["Buy 73 Leaded Vials"] = "",
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion · Stonescale Oils = {item:13423} Stonescale Oil
	["For 26 Nature Protection Potions and 47 Stonescale Oils."] = "",

	-- Step 59: Buy 69 Crystal Vials
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["Buy 69 Crystal Vials"] = "",
	["For 25 Elixirs of Greater Intellect and 44 Elixirs of Greater Defense."] = "",

	-- Step 60: Pick Kingsblood, Liferoot, Fadeleaf, Goldthorn and Khadgar's Whisker until Herbalism 200
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick {item:3356}, {item:3357}, {item:3818}, {item:3821} and Khadgar's Whisker until {skill:182} 200"] = "",

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
	["Taught at 195, before the part of the guide you started from."] = "",

	-- Step 66: Craft 26 Nature Protection Potions until 235
	-- plural, as words: Nature Protection Potions = {item:6052} Nature Protection Potion
	["Craft 26 Nature Protection Potions until 235"] = "",
	["About 26 crafts. Green for the last 5 points: short of 235? A few more do it."] = "",

	-- Step 67: Pick 15 Khadgar's Whisker
	-- {object:2043} Khadgar's Whisker
	["Pick 15 {object:2043}"] = "",
	["For 15 Elixirs of Greater Intellect."] = "",

	-- Step 68: Pick Kingsblood, Liferoot, Fadeleaf, Goldthorn and Khadgar's Whisker until Herbalism 210
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick {item:3356}, {item:3357}, {item:3818}, {item:3821} and Khadgar's Whisker until {skill:182} 210"] = "",
	-- {item:9179} Elixir of Greater Intellect · {skill:182} Herbalism
	["What {item:9179} needs comes from {skill:182} 260."] = "",

	-- Step 69: Pick Goldthorn, Khadgar's Whisker, Wintersbite, Firebloom and Purple Lotus until Herbalism 230
	-- {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:3819} Wintersbite · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:3821}, {object:2043}, {item:3819}, {item:4625} and {item:8831} until {skill:182} 230"] = "",

	-- Step 70: Pick Fadeleaf, Goldthorn, Purple Lotus and Sungrass until Herbalism 260
	-- {item:3818} Fadeleaf · {item:3821} Goldthorn · {item:8831} Purple Lotus · {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:3818}, {item:3821}, {item:8831} and {item:8838} until {skill:182} 260"] = "",

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

	-- Step 76: Craft 47 Stonescale Oils · keep them all for the elixirs at 265
	-- plural, as words: Stonescale Oils = {item:13423} Stonescale Oil
	["Craft 47 Stonescale Oils · keep them all for the elixirs at 265"] = "",
	-- {skill:171} Alchemy
	["They take {skill:171} to about 260. Each craft makes 2 oils."] = "",

	-- Step 77: Pick 10 Khadgar's Whisker
	-- {object:2043} Khadgar's Whisker
	["Pick 10 {object:2043}"] = "",
	["For 10 Elixirs of Greater Intellect."] = "",

	-- Step 78: Pick Goldthorn, Khadgar's Whisker, Purple Lotus, Sungrass, Blindweed, Ghost Mushroom, Gromsblood and Golden Sansam until Herbalism 285
	-- {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:8831} Purple Lotus · {item:8838} Sungrass · {item:8839} Blindweed · {item:8845} Ghost Mushroom · {item:8846} Gromsblood · {item:13464} Golden Sansam · {skill:182} Herbalism
	["Pick {item:3821}, {object:2043}, {item:8831}, {item:8838}, {item:8839}, {item:8845}, {item:8846} and {item:13464} until {skill:182} 285"] = "",
	-- {item:9179} Elixir of Greater Intellect
	["This loop gives part of what {item:9179} needs; the next one the rest."] = "",

	-- Step 79: Pick 10 Blindweed
	-- {item:8839} Blindweed
	["Pick 10 {item:8839}"] = "",

	-- Step 80: Learn Elixir of Greater Intellect
	["Taught at 235, before the part of the guide you started from."] = "",

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

	-- Step 86: Pick Purple Lotus, Arthas' Tears, Sungrass, Golden Sansam, Dreamfoil, Mountain Silversage and Plaguebloom until Herbalism 300
	-- {item:8831} Purple Lotus · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick {item:8831}, {item:8836}, {item:8838}, {item:13464}, {item:13463}, {item:13465} and {item:13466} until {skill:182} 300"] = "",
	-- {skill:182} Herbalism · {skill:171} Alchemy
	["{skill:182} 300 before the last stretch: the guide ends with {skill:171}."] = "",

	-- Step 87: Craft 44 Elixirs of Greater Defense until 300
	["Craft 44 Elixirs of Greater Defense until 300"] = "",
	["About 44 crafts. Yellow from 280: short of 300? A few more do it."] = "",
}
