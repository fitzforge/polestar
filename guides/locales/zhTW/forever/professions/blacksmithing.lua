-- Chinese (traditional) (zhTW): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
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
	-- {skill:164} Blacksmithing · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "",

	-- Step 2: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1429} is marked."] = "",

	-- Step 3: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1426} is marked."] = "",

	-- Step 4: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1439} is marked."] = "",

	-- Step 5: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:2521} is marked."] = "",

	-- Step 6: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1411} is marked."] = "",

	-- Step 7: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1412} is marked."] = "",

	-- Step 8: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1420} is marked."] = "",

	-- Step 9: Rough Sharpening Stone to 35
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 35"] = "",
	-- {spell:2660} Rough Sharpening Stone · {item:2835} Rough Stone
	["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "",

	-- Step 10: Blacksmithing recipes at 35
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 35"] = "",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone · {spell:1230171} Sharpening Wheel · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "",

	-- Step 11: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320}練到75",
	-- {spell:3320} Rough Grinding Stone · {item:2835} Rough Stone
	["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "",

	-- Step 12: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "中級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {npc:3136} Clarise Gnarltree · {zone:1431} Duskwood · {npc:252479} Daeann Steelwind · {zone:2521} Zephras Isle · {npc:10276} Rotgath Stonebeard · {npc:5511} Therum Deepforge · {zone:1453} Stormwind City · {npc:4596} James Van Brunt · {zone:1458} Undercity · {npc:2998} Karn Stonehoof · {zone:1456} Thunder Bluff · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {npc:1383} Snarl · {npc:3478} Traugh · {zone:1413} The Barrens · {spell:2666} Runed Copper Belt · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "",

	-- Step 13: Blacksmithing 75-150: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 75-150: vendor goods"] = "",
	-- {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and Sovik)."] = "",
	["a tool, keep it in your bags"] = "",

	-- Step 14: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1436} is marked."] = "",

	-- Step 15: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 16: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1439} is marked."] = "",

	-- Step 17: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1413} is marked."] = "",

	-- Step 18: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1421} is marked."] = "",

	-- Step 19: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:2674} Heavy Sharpening Stone · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 20: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:2674} Heavy Sharpening Stone · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1440} is marked."] = "",

	-- Step 21: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:2674} Heavy Sharpening Stone · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1413} is marked."] = "",

	-- Step 23: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320}練到83",
	-- {spell:3320} Rough Grinding Stone · {item:2835} Rough Stone
	["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "",

	-- Step 24: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666}練到100",
	-- {spell:2666} Runed Copper Belt · {item:2840} Copper Bar · {item:2770} Copper Ore · {item:5956} Blacksmith Hammer · {skill:186} Mining
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags. {item:2840} (210 for 75-150): {skill:186}: smelt {item:2770}; or the Auction House."] = "",

	-- Step 25: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "{skill:164}100點的配方",
	-- {skill:164} Blacksmithing · {spell:2674} Heavy Sharpening Stone
	["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "",

	-- Step 26: Heavy Sharpening Stone to 113
	-- {spell:2674} Heavy Sharpening Stone
	["{spell:2674} to 113"] = "",
	-- {spell:2674} Heavy Sharpening Stone · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit
	["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "",

	-- Step 27: Blacksmithing recipes at 113
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 113"] = "",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "",

	-- Step 28: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672}練到150",
	-- {spell:2672} Patterned Bronze Bracers · {item:2841} Bronze Bar · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar · {skill:164} Blacksmithing
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone · Tin Veins = {object:1732} Tin Vein
	["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {item:2841} (320 for 75-150): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House. {skill:164} 150 is a Legacy System milestone."] = "",

	-- Step 29: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "高級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:3501} Green Iron Bracers · {spell:3337} Heavy Grinding Stone · {item:2838} Heavy Stone · {item:3575} Iron Bar · {item:3859} Steel Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}) and {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}) and {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "",

	-- Step 30: Blacksmithing 150-225: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 150-225: vendor goods"] = "",
	-- {item:2605} Green Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra · {item:3859} Steel Bar · {skill:186} Mining · {item:3575} Iron Bar
	["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "",

	-- Step 31: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838}（聯盟）",
	-- {item:2838} Heavy Stone · {item:6040} Golden Scale Bracers · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 32: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838}（部落）",
	-- {item:2838} Heavy Stone · {item:6040} Golden Scale Bracers · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest cluster of {object:1735} in {zone:1441} is marked."] = "",

	-- Step 33: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912}（聯盟）",
	-- {item:7912} Solid Stone · {item:7964} Solid Sharpening Stone · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1434} is marked."] = "",

	-- Step 34: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912}（部落）",
	-- {item:7912} Solid Stone · {item:7964} Solid Sharpening Stone · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 35: Green Iron Bracers to 175
	-- {spell:3501} Green Iron Bracers
	["{spell:3501} to 175"] = "",
	-- {spell:3501} Green Iron Bracers · {item:3575} Iron Bar · {item:2605} Green Dye · {skill:186} Mining · {item:2772} Iron Ore
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby. {item:3575} (168 for 150-225): {skill:186}: smelt {item:2772}; or the Auction House."] = "",

	-- Step 36: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "{skill:164}175點的配方",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "",

	-- Step 37: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964}練到185",
	-- {item:7964} Solid Sharpening Stone · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "",

	-- Step 38: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "{skill:164}185點的配方",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "",

	-- Step 39: Golden Scale Bracers to 205
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 205"] = "",
	-- {item:6040} Golden Scale Bracers · {item:3859} Steel Bar · {spell:3337} Heavy Grinding Stone · {item:3575} Iron Bar · {skill:186} Mining · {npc:5164} Grumnus Steelshaper · {zone:1455} Ironforge · {npc:11177} Okothos Ironrager · {zone:1454} Orgrimmar · {item:7936} Ornate Mithril Boots · {item:7935} Ornate Mithril Breastplate · {npc:11146} Ironus Coldsteel · {npc:11178} Borgosh Corebender · {item:3853} Moonsteel Broadsword · {npc:2482} Zarena Cromwind · {object:3204} Booty Bay (no name in this language: may be words) · {item:3855} Massive Iron Axe
	-- plural, as words: Steel Bars = {item:3859} Steel Bar · Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone · Ornate Mithril Helms = {item:7937} Ornate Mithril Helm · Moonsteel Broadswords = {item:3853} Moonsteel Broadsword · Massive Iron Axes = {item:3855} Massive Iron Axe · Heavy Mithril Axes = {item:7940} Heavy Mithril Axe · Big Black Maces = {item:7945} Big Black Mace
	["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the Armorsmith: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {object:3204}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:3859} (195 for 150-225): {skill:186}: smelt {item:3575} and Coal; or the Auction House."] = "",

	-- Step 40: Blacksmithing recipes at 205
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 205"] = "",
	-- {skill:164} Blacksmithing · {spell:9959} Heavy Mithril Breastplate
	["Back to a {skill:164} trainer: {spell:9959} (from 205)."] = "",

	-- Step 41: Heavy Mithril Breastplate to 225
	-- {item:7930} Heavy Mithril Breastplate
	["{item:7930} to 225"] = "",
	-- {item:7930} Heavy Mithril Breastplate · {item:3860} Mithril Bar · {skill:186} Mining · {item:3858} Mithril Ore · {skill:164} Blacksmithing
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {item:3860} (320 for 150-225): {skill:186}: smelt {item:3858}; or the Auction House. {skill:164} 225 is a Legacy System milestone."] = "",

	-- Step 42: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "專家級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {spell:16640} Dense Weightstone · {spell:9968} Heavy Mithril Boots · {spell:9920} Solid Grinding Stone · {spell:10001} Big Black Mace · {spell:16639} Dense Grinding Stone · {item:1210} Shadowgem · {item:3860} Mithril Bar · {item:4304} Thick Leather · {item:7909} Aquamarine · {item:7910} Star Ruby · {item:7912} Solid Stone · {item:7971} Black Pearl · {item:8170} Rugged Leather · {item:12359} Thorium Bar · {item:12365} Dense Stone · {item:12799} Large Opal
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "",

	-- Step 43: Plans: Ornate Thorium Handaxe
	-- {item:12819} Plans: Ornate Thorium Handaxe · {item:12773} Ornate Thorium Handaxe · {skill:164} Blacksmithing · {npc:11278} Magnus Frostwake · {zone:1422} Western Plaguelands
	["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "",

	-- Step 44: Plans: Huge Thorium Battleaxe
	-- {item:12823} Plans: Huge Thorium Battleaxe · {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing · {npc:11278} Magnus Frostwake · {zone:1422} Western Plaguelands
	["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "",

	-- Step 45: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304}（聯盟）",
	-- {item:4304} Thick Leather · {item:7933} Heavy Mithril Boots · {item:7945} Big Black Mace · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 46: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- {item:4304} Thick Leather · {item:7933} Heavy Mithril Boots · {item:7945} Big Black Mace · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 47: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:7945} Big Black Mace · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest cluster of {object:2040} in {zone:1425} is marked."] = "",

	-- Step 48: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:7945} Big Black Mace · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 49: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（聯盟）",
	-- {item:8170} Rugged Leather · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 50: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {item:8170} Rugged Leather · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 51: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365}（聯盟）",
	-- {item:12365} Dense Stone · {item:12643} Dense Weightstone · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:186} Mining · {object:324} Small Thorium Vein · {zone:1419} Blasted Lands · {zone:1448} Felwood · {zone:1452} Winterspring
	["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60); or the Auction House. The densest cluster of {object:324} in {zone:1419} is marked."] = "",

	-- Step 52: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365}（部落）",
	-- {item:12365} Dense Stone · {item:12643} Dense Weightstone · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:186} Mining · {object:324} Small Thorium Vein · {zone:1448} Felwood · {zone:1451} Silithus · {zone:1452} Winterspring
	["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60); or the Auction House. The densest cluster of {object:324} in {zone:1448} is marked."] = "",

	-- Step 53: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643}練到235",
	-- {item:12643} Dense Weightstone · {item:12365} Dense Stone
	["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "",

	-- Step 54: Heavy Mithril Boots to 247
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 247"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather · {skill:186} Mining · {item:3858} Mithril Ore
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. {item:3860} (596 for 225-300): {skill:186}: smelt {item:3858}; or the Auction House."] = "",

	-- Step 55: Big Black Mace to 250
	-- {item:7945} Big Black Mace
	["{item:7945} to 250"] = "",
	-- {item:7945} Big Black Mace · {item:3860} Mithril Bar · {item:7971} Black Pearl · {item:1210} Shadowgem · {item:7966} Solid Grinding Stone · {item:4304} Thick Leather · {object:1732} Tin Vein · {object:1731} Copper Vein · {object:1733} Silver Vein
	-- plural, as words: Shadowgems = {item:1210} Shadowgem
	["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:1210} (44 for 225-300): {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: buy it at the Auction House, or keep the ones you find while mining. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "",

	-- Step 56: Ornate Thorium Handaxe to 255
	-- {item:12773} Ornate Thorium Handaxe
	["{item:12773} to 255"] = "",
	-- {item:12773} Ornate Thorium Handaxe · {item:12359} Thorium Bar · {item:12799} Large Opal · {item:12644} Dense Grinding Stone · {item:8170} Rugged Leather · {skill:186} Mining · {item:10620} Thorium Ore · {object:175404} Rich Thorium Vein · {object:177388} Ooze Covered Rich Thorium Vein · {object:180215} Hakkari Thorium Vein
	["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby. {item:12359} (2026 for 225-300): {skill:186}: smelt {item:10620}; or the Auction House. {item:12799} (10 for 225-300): {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: buy it at the Auction House, or keep the ones you find while mining."] = "",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 57: Huge Thorium Battleaxe to 285
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 285"] = "",
	-- {item:12775} Huge Thorium Battleaxe · {item:12359} Thorium Bar · {item:12644} Dense Grinding Stone · {item:8170} Rugged Leather · {npc:11278} Magnus Frostwake · {zone:1422} Western Plaguelands · {quest:7654} Imperial Plate Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Dense Grinding Stones = {item:12644} Dense Grinding Stone
	["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} (Caer Darrow, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "",

	-- Step 58: Plans: Imperial Plate Boots
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12700} Plans: Imperial Plate Boots · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7654} Imperial Plate Boots · {quest:7652} A Blue Light Bargain
	["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "",

	-- Step 59: Imperial Plate Boots to 300
	-- {item:12426} Imperial Plate Boots
	["{item:12426} to 300"] = "",
	-- {item:12426} Imperial Plate Boots · {item:12359} Thorium Bar · {item:7910} Star Ruby · {item:7909} Aquamarine · {npc:14567} Derotain Mudsipper · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit · {skill:164} Blacksmithing
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Huge Thorium Battleaxes = {item:12775} Huge Thorium Battleaxe
	["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {item:7909} (19 for 225-300): {item:7909} turns up in about one {object:2047} or {object:123309} in 500: buy it at the Auction House, or keep the ones you find while mining. {item:7910} (19 for 225-300): {item:7910} turns up in about one {object:2047} or {object:123309} in 143: buy it at the Auction House, or keep the ones you find while mining. {skill:164} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:164}"] = "初級{skill:164}",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "專家級需要角色等級35且{skill:164}200點；上限提高到300。225-300所需材料總價約942金。",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:16639}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:16640}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "回到{skill:164}訓練師那裡：{spell:2666}在{skill:164}80點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "回到{skill:164}訓練師那裡：{spell:2668}在{skill:164}95點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "回到{skill:164}訓練師那裡：{spell:2672}在{skill:164}120點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "回到{skill:164}訓練師那裡：{spell:3117}在{skill:164}100點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "回到{skill:164}訓練師那裡：{spell:3320}在{skill:164}45點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "回到{skill:164}訓練師那裡：{spell:7223}在{skill:164}185點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "回到{skill:164}訓練師那裡：{spell:9916}在{skill:164}200點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "回到{skill:164}訓練師那裡：{spell:9918}在{skill:164}175點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "回到{skill:164}訓練師那裡：{spell:9920}、{spell:9935}在{skill:164}210點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:9968}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "回到{skill:164}訓練師那裡：{spell:9985}在{skill:164}155點時可學。",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "高級需要角色等級20且{skill:164}125點；上限提高到225。150-225所需材料總價約42金。",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "中級需要角色等級10且{skill:164}50點；上限提高到150。75-150所需材料總價約9金41銀。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar依你的等級和陣營挑選的刷怪點擊殺掉落它的怪物。拍賣場也買得到。",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "橙色（每次製造必得1點）到120，黃色到135，綠色到150。附近需要有鐵砧。",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "橙色（每次製造必得1點）到125，黃色到140，綠色到155。附近需要有鐵砧。{skill:164}150是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "橙色（每次製造必得1點）到15，黃色到35，綠色到55。",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "橙色（每次製造必得1點）到260，黃色到270，綠色到280。附近需要有鐵砧。",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "橙色（每次製造必得1點）到280，黃色到292，綠色到305。附近需要有鐵砧。{skill:164}300是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "橙色（每次製造必得1點）到85，黃色到105，綠色到125。附近需要有鐵砧。",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8831}；這裡是資料中最密集的草點。拍賣場也買得到。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:1815}、{npc:1816}、{npc:1817}的皮（48-60級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、鉗嘴龜、{npc:2384}、{npc:2354}的皮（18-30級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}的皮（38-50級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}的皮（18-30級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}的皮（38-50級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}的皮（48-60級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或其他專業製造的材料：自己採集或在拍賣場購買。",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "學會{item:12775}（需要{skill:164}255點）。",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "學會{item:250562}（需要{skill:164}240點）。",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "黃色到107，綠色到115：不是每次製造都會加點。",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "黃色到155，綠色到170：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "黃色到170，綠色到185：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "黃色到180，綠色到185：不是每次製造都會加點。",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "黃色到197，綠色到210：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "黃色到212，綠色到225：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "黃色到220，綠色到230：不是每次製造都會加點。附近需要有鐵砧。{skill:164}225是傳承系統的里程碑。",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "黃色到232，綠色到235：不是每次製造都會加點。",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "黃色到235，綠色到245：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "黃色到240，綠色到250：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "黃色到65，綠色到85：不是每次製造都會加點。",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黃色到65，綠色到85：不是每次製造都會加點。75是初級的上限。",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365}來自{object:324}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:12775} to 300"] = "{item:12775}練到300",
	-- ["{item:2319} (Alliance)"] = "{item:2319}（聯盟）",
	-- ["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- ["{item:250562} to 268"] = "{item:250562}練到268",
	-- ["{item:2835} (Alliance)"] = "{item:2835}（聯盟）",
	-- ["{item:2835} (Horde)"] = "{item:2835}（部落）",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}來自{object:1731}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:2836} (Alliance)"] = "{item:2836}（聯盟）",
	-- ["{item:2836} (Horde)"] = "{item:2836}（部落）",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}來自{object:1732}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}來自{object:1735}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包裡",
	-- ["{item:6040} to 200"] = "{item:6040}練到200",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}來自{object:2040}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:7922} to 225"] = "{item:7922}練到225",
	-- ["{item:7931} to 230"] = "{item:7931}練到230",
	-- ["{item:7933} to 244"] = "{item:7933}練到244",
	-- ["{item:7956} to 175"] = "{item:7956}練到175",
	-- ["{item:7963} to 210"] = "{item:7963}練到210",
	-- ["{item:8831} (Alliance)"] = "{item:8831}（聯盟）",
	-- ["{item:8831} (Horde)"] = "{item:8831}（部落）",
	-- ["{skill:164} materials for 150-225"] = "{skill:164}150-225的材料",
	-- ["{skill:164} materials for 225-300"] = "{skill:164}225-300的材料",
	-- ["{skill:164} materials for 75-150"] = "{skill:164}75-150的材料",
	-- ["{skill:164} recipes at 112"] = "{skill:164}112點的配方",
	-- ["{skill:164} recipes at 121"] = "{skill:164}121點的配方",
	-- ["{skill:164} recipes at 155"] = "{skill:164}155點的配方",
	-- ["{skill:164} recipes at 200"] = "{skill:164}200點的配方",
	-- ["{skill:164} recipes at 210"] = "{skill:164}210點的配方",
	-- ["{skill:164} recipes at 230"] = "{skill:164}230點的配方",
	-- ["{skill:164} recipes at 235"] = "{skill:164}235點的配方",
	-- ["{skill:164} recipes at 268"] = "{skill:164}268點的配方",
	-- ["{skill:164} recipes at 45"] = "{skill:164}45點的配方",
	-- ["{skill:164} recipes at 83"] = "{skill:164}83點的配方",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164}可以邊升級邊練。永恆的傳承系統會在專業技能150、225和300（中級、高級和專家級的上限）時給予製造專業獎勵，所以每個階段都很重要。1-75所需材料總價約17銀。",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}：{item:249410}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔煉{item:10620}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔煉{item:2770}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}：熔煉{item:2775}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔煉{item:2840}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔煉{item:3575}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔煉{item:3858}（或在拍賣場購買）",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}：{item:249432}（或在拍賣場購買）",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393}（或在拍賣場購買）",
	-- ["{spell:2660} to 45"] = "{spell:2660}練到45",
	-- ["{spell:2668} to 121"] = "{spell:2668}練到121",
	-- ["{spell:3117} to 112"] = "{spell:3117}練到112",
	-- ["{spell:3333} to 155"] = "{spell:3333}練到155",
}
