-- German (deDE): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "Lerne {skill:197}",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "Lehrling in {skill:197} erlaubt dir, bis 75 herzustellen, für 10c, auf jeder Charakterstufe. Jeder {skill:197}-Lehrer deiner Fraktion lehrt ihn; der Pfeil wählt den nächsten. Behalte jeden {item:2589}, den du erbeutest: Humanoide der Stufen 5-20 lassen ihn fallen. 1-75 kostet etwa 50c für Rezepte und 7s 20c für Händlerware, dazu 144 {item:2589} zum Sammeln oder Kaufen.",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "{skill:197} 1-75: Händlerware",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 72 {item:2320} (7s 20c); insgesamt etwa 7s 20c. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 3: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "144 {item:2589} für {spell:2387} und {item:7026}: Droppt bei Humanoiden der Stufen 5-20; oder im Auktionshaus. Der Pfeil wählt einen Farmplatz für deine Stufe und Fraktion.",

	-- Step 4: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "{spell:2387} bis 15",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{spell:2387} ist bei 1 orange (gelb 35, grün 47, grau 60): etwa 7 Herstellungen bis 15, ein Punkt pro Herstellung. Jede braucht 1 {spell:2963} und 1 {item:2320}. Stelle zuerst die 7 {spell:2963} her: Er bringt ebenfalls Punkte, solange er nicht grau ist. Der Lehrer lehrt es, und es ist der günstigste Weg durch diese Punkte laut den Daten.",

	-- Step 5: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "{skill:197}-Rezepte bei 15",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "Zurück zu einem {skill:197}-Lehrer: {spell:8776} (ab 15, 50c).",

	-- Step 6: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} bis 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "{item:7026} ist bei 15 orange (gelb 50, grün 67, grau 85): etwa 65 Herstellungen bis 75. Jede braucht 1 {spell:2963} und 1 {item:2320}. Stelle zuerst die 65 {spell:2963} her: Er bringt ebenfalls Punkte, solange er nicht grau ist. Jeder Gürtel braucht einen Ballen; die Gürtel lassen sich an Händler verkaufen.",

	-- Step 7: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} (Geselle)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:251991} Taleen Shimmerthread · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Geselle hebt die Obergrenze von 75 auf 150 an, für 5s; er braucht {skill:197} 50 und Charakterstufe 10, also kannst du ihn bei jedem Besuch ab 50 lernen. Nicht jeder {skill:197}-Lehrer lehrt ihn: Allianz {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) und {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) und Tepa ({zone:1456}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:2964} (ab 55, 1s) und {spell:2402} (ab 55, 2s 50c). Lerne auch {spell:1229504} (1s): Forevers Camp-Gegenstand für {skill:197}, ein {spell:2963} und ein {item:2320}; jede Fraktion hat ihren eigenen. Die Quest Camping 101: {skill:197} aus dem Camping-Guide deines Startgebiets (nach The Great Outdoors) schickt dich zu einem Schneiderlehrer, der es kostenlos lehrt. 75-150 kostet etwa 11s für Rezepte und 1g 65s 50c für Händlerware, dazu 567 {item:2592} und 204 {item:4306} zum Sammeln oder Kaufen.",

	-- Step 8: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "{skill:197} 75-150: Händlerware",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) und 98 {item:2604} (49s); insgesamt etwa 1g 65s 50c. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 9: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Allianz)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:98} Riverpaw Taskmaster
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:98} (level 17-18) here."] = "567 {item:2592} für {spell:2402} und {spell:3866}: Droppt bei Humanoiden der Stufen 15-30; oder im Auktionshaus. Droppt hier bei {npc:98} (Stufe 17-18).",

	-- Step 10: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:3263} Bristleback Geomancer
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:3263} (level 19-20) here."] = "567 {item:2592} für {spell:2402} und {spell:3866}: Droppt bei Humanoiden der Stufen 15-30; oder im Auktionshaus. Droppt hier bei {npc:3263} (Stufe 19-20).",

	-- Step 11: Silk Cloth (Alliance)
	-- {item:4306} Silk Cloth
	["{item:4306} (Alliance)"] = "{item:4306} (Allianz)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:2240} Syndicate Footpad
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:2240} (level 32-33) here."] = "204 {item:4306} für {spell:3871}: Droppt bei Humanoiden der Stufen 25-45; oder im Auktionshaus. Droppt hier bei {npc:2240} (Stufe 32-33).",

	-- Step 12: Silk Cloth (Horde)
	-- {item:4306} Silk Cloth
	["{item:4306} (Horde)"] = "{item:4306} (Horde)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:11697} Mannoroc Lasher
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:11697} (level 29-30) here."] = "204 {item:4306} für {spell:3871}: Droppt bei Humanoiden der Stufen 25-45; oder im Auktionshaus. Droppt hier bei {npc:11697} (Stufe 29-30).",

	-- Step 13: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "{spell:2402} bis 104",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "{spell:2402} ist bei 75 orange (gelb 80, grün 97, grau 115): etwa 42 Herstellungen bis 104. Jede braucht 1 {spell:2964} und 1 {item:2321}. Stelle zuerst die 42 {spell:2964} her: Er bringt ebenfalls Punkte, solange er nicht grau ist. {spell:2964} wird in Forever ab 55 gelehrt.",

	-- Step 14: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "{skill:197}-Rezepte bei 104",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "Zurück zu einem {skill:197}-Lehrer: {spell:3866} (ab 85, 2s 50c).",

	-- Step 15: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "{spell:3866} bis 135",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "{spell:3866} ist bei 104 orange (gelb 110, grün 127, grau 145): etwa 49 Herstellungen bis 135. Jede braucht 3 {spell:2964}, 2 {item:2604} und 1 {item:2321}. Stelle zuerst die 147 {spell:2964} her. Drei Wollballen und zwei {item:2604} pro Hemd; {item:2592} droppt bei Humanoiden der Stufen 15-30.",

	-- Step 16: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "{skill:197}-Rezepte bei 135",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "Zurück zu einem {skill:197}-Lehrer: {spell:3839} (ab 100, 5s) und {spell:3871} (ab 135).",

	-- Step 17: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "{spell:3871} bis 150",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "{spell:3871} ist bei 135 orange (gelb 145, grün 150, grau 155): etwa 17 Herstellungen bis 150. Jede braucht 3 {spell:3839}, 2 {item:2324} und 1 {item:2321}. Stelle zuerst die 51 {spell:3839} her. Ab hier Seidenballen: {item:4306} droppt bei Humanoiden der Stufen 25-45. {item:2324} gibt es bei Händlern für Schneiderei und Handwerksbedarf. {skill:197} 150 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 18: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "{skill:197} 150-225: Händlerware",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) und 80 {item:8343} (16g); insgesamt etwa 21g 16s. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "{item:7089} lehrt {item:7053} ({skill:197} 140) für 15s. Verkauft von Allianz: {npc:6576} ({zone:1444}), begrenzter Vorrat, und {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), begrenzter Vorrat, und {npc:251997} ({zone:1416}).",

	-- Step 20: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "264 {item:4306} für {item:7053}: Droppt bei Humanoiden der Stufen 25-45; oder im Auktionshaus. Der Pfeil wählt einen Farmplatz für deine Stufe und Fraktion.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Allianz)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:4467} Vilebranch Soothsayer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:4467} (level 46-47) here."] = "900 {item:4338} für {item:9998} und {item:10024}: Droppt bei Humanoiden der Stufen 35-50; oder im Auktionshaus. Droppt hier bei {npc:4467} (Stufe 46-47).",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horde)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:5472} Dunemaul Enforcer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:5472} (level 46-47) here."] = "900 {item:4338} für {item:9998} und {item:10024}: Droppt bei Humanoiden der Stufen 35-50; oder im Auktionshaus. Droppt hier bei {npc:5472} (Stufe 46-47).",

	-- Step 23: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} (Experte)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}) and {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Experte hebt die Obergrenze von 150 auf 225 an; er braucht {skill:197} 125 und Charakterstufe 20, also kannst du ihn bei jedem Besuch ab 125 lernen. Nur wenige Lehrer lehren ihn: Allianz {npc:1346} ({zone:1453}) und {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}) und {npc:4576} ({zone:1458}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:3865} (ab 140). 150-225 kostet etwa 15s für Rezepte und 21g 16s für Händlerware, dazu 264 {item:4306} und 900 {item:4338} zum Sammeln oder Kaufen. Komm mit allem in deinen Taschen (die Schritte oben, den Rest aus dem Auktionshaus): Diese Lehrer lehren auch {item:9998} (ab 170) und {item:10024} (ab 190), und die Herstellungen brauchen keine Station, also stelle gleich hier her und lerne jedes Rezept, sobald du seine Fertigkeit erreichst. Eine Reise statt 3.",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "{item:7053} bis 170",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "{item:7053} ist bei 150 orange (gelb 160, grün 175, grau 190): etwa 22 Herstellungen bis 170. Jede braucht 3 {spell:3839}, 2 {item:6260} und 2 {item:2321}. Stelle zuerst die 66 {spell:3839} her. Sein Rezept ist das oben gekaufte; es ist der günstigste Weg durch diese Punkte laut den Daten.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 25: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "{skill:197}-Rezepte bei 170",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "Noch beim Lehrer für Experte: {spell:12048} (ab 170).",

	-- Step 26: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "{item:9998} bis 197",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:9998} ist bei 170 orange (gelb 185, grün 200, grau 215): etwa 30 Herstellungen bis 197. Jede braucht 2 {spell:3865} und 3 {item:4291}. Stelle zuerst die 60 {spell:3865} her. Der Lehrer lehrt es, und es ist der günstigste Weg durch diese Punkte laut den Daten.",

	-- Step 27: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "{skill:197}-Rezepte bei 197",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "Noch beim Lehrer für Experte: {spell:12072} (ab 190).",

	-- Step 28: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} bis 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "{item:10024} ist bei 197 orange (gelb 205, grün 220, grau 235): etwa 40 Herstellungen bis 225. Jede braucht 3 {spell:3865} und 2 {item:8343}. Stelle zuerst die 120 {spell:3865} her. Der Lehrer lehrt es, und es ist der günstigste Weg durch diese Punkte laut den Daten. {skill:197} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} (Fachmann)",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "Meister hebt die Obergrenze von 225 auf 300 an; er braucht {skill:197} 200 und Charakterstufe 35, also kannst du ihn bei jedem Besuch ab 200 lernen. Nur wenige Lehrer lehren ihn: Allianz {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:18401} (ab 205) und {spell:18402} (ab 210). 225-300 kostet etwa 1g 60s für Rezepte und 58g für Händlerware, dazu 420 {item:8170}, 3.195 {item:14047} und 124 {item:14227} zum Sammeln oder Kaufen.",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "{skill:197} 225-300: Händlerware",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 116 {item:14341} (58g); insgesamt etwa 58g. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:14481} lehrt {item:13863} ({skill:197} 230) für 1g 60s. Verkauft von {npc:11189} ({zone:1452}), begrenzter Vorrat. Seine Verkäufer haben ein oder zwei auf Lager, die einige Zeit nach einem Verkauf wiederkommen; es wird beim Aufheben gebunden, also gibt es das im Auktionshaus nie.",

	-- Step 32: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Allianz)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} für {item:13863} und {item:13867}: {skill:393}: Tiere der Stufen 48-60; oder im Auktionshaus. Häute hier {npc:1815}, {npc:1816} und {npc:1817} (Stufe 48-60); der {skill:393}-Guide routet das.",

	-- Step 33: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} für {item:13863} und {item:13867}: {skill:393}: Tiere der Stufen 48-60; oder im Auktionshaus. Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} und {npc:6377} (Stufe 48-60); der {skill:393}-Guide routet das.",

	-- Step 34: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Allianz)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:7027} Blackrock Slayer
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "3.195 {item:14047} für {item:13856}, {item:13863} und {item:13867}: Droppt bei Humanoiden der Stufen 45-60; oder im Auktionshaus. Droppt hier bei {npc:7027} (Stufe 56-57).",

	-- Step 35: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:11880} Twilight Avenger
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "3.195 {item:14047} für {item:13856}, {item:13863} und {item:13867}: Droppt bei Humanoiden der Stufen 45-60; oder im Auktionshaus. Droppt hier bei {npc:11880} (Stufe 57-59).",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Allianz)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} für {item:13867}: Droppt bei {npc:1824} (Stufe 54-55) an der markierten Stelle, oder kauf es im Auktionshaus.",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horde)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11739} Rock Stalker
	["124 {item:14227} for {item:13867}: it drops from {npc:11739} (level 57-59) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} für {item:13867}: Droppt bei {npc:11739} (Stufe 57-59) an der markierten Stelle, oder kauf es im Auktionshaus.",

	-- Step 38: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "{item:13856} bis 234",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "{item:13856} ist bei 225 gelb (gelb 225, grün 240, grau 255): etwa 11 Herstellungen bis 234. Jede braucht 3 {item:14048} und 1 {item:14341}. Stelle zuerst die 33 {item:14048} her. {item:14341} gibt es bei Schneiderei-Händlern.",

	-- Step 39: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "{item:13863} bis 265",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "{item:13863} ist bei 234 orange (gelb 245, grün 260, grau 275): etwa 43 Herstellungen bis 265. Jede braucht 4 {item:14048}, 4 {item:8170} und 1 {item:14341}. Stelle zuerst die 172 {item:14048} her. {npc:11189} in {area:2255} hat jeweils ein Muster auf Lager; der Tunnel {area:1769} von {zone:1448} aus ist der Weg hinein, also töte unterwegs nie Holzschlund-Furbolgs.",

	-- Step 40: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "{item:13867} bis 300",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "{item:13867} ist bei 265 orange (gelb 275, grün 290, grau 305): etwa 62 Herstellungen bis 300. Jede braucht 7 {item:14048}, 2 {item:14227}, 4 {item:8170} und 1 {item:14341}. Stelle zuerst die 434 {item:14048} her. Sein Muster ({item:14504}) droppt von Mobs überall in der Welt und wird nicht gebunden: Kauf es im Auktionshaus. Sieben Ballen, zwei {item:14227} und vier {item:8170} pro Herstellung: der teuerste Abschnitt. Die Spinnen von {zone:1422} und {zone:1451} droppen die Seide (die markierten Stellen), oder das Auktionshaus. Kein Muster im Auktionshaus? {item:13863} bringen bis 275 hin und wieder noch einen Punkt, und {item:13864} ({npc:7940}, {zone:1450}) bis 280, bei 4 Ballen pro Herstellung. {item:14342} (Muster von {npc:11189} oder {npc:11188} in {area:2255}; 2 {item:14256} an einem Mondbrunnen) bleibt bis 270 orange und bis 285 gelb, lässt sich aber nur alle vier Tage einmal herstellen. Die Muster für {item:279943} (Merchant's Favor sandals und waistcords von {npc:248202} oder {npc:256735}; der Bauplan des Rads droppt von {npc:246017} in der Stadt Dalaran) und {item:254123} (Pexmit in {zone:2482}, 10g; wir konnten diesen Händler noch nicht bestätigen) sind die anderen Wege weiter. {skill:197} 300 ist ein Meilenstein des Vermächtnissystems.",
	["from the pattern bought at the Auction House"] = "aus dem im Auktionshaus gekauften Muster",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:197}"] = "{skill:197} (Lehrling)",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Fachmann erfordert Charakterstufe 35 und {skill:197} 200; damit steigt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 845g wert.",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Zurück zu einem Lehrer für {skill:197}: {spell:12048} wird ab {skill:197} 185 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Zurück zu einem Lehrer für {skill:197}: {spell:12072} wird ab {skill:197} 205 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Zurück zu einem Lehrer für {skill:197}: {spell:2402} wird ab {skill:197} 80 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Zurück zu einem Lehrer für {skill:197}: {spell:3848} wird ab {skill:197} 110 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Zurück zu einem Lehrer für {skill:197}: {spell:3852} wird ab {skill:197} 125 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Zurück zu einem Lehrer für {skill:197}: {spell:8776} wird ab {skill:197} 50 gelehrt.",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Zurück zu einem Lehrer für {skill:197}: {spell:8799} wird ab {skill:197} 180 gelehrt.",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Experte erfordert Charakterstufe 20 und {skill:197} 125; damit steigt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 135g wert.",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Geselle erfordert Charakterstufe 10 und {skill:197} 50; damit steigt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 17g wert.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Töte die Gegner, die ihn fallen lassen, am Farmplatz, den Polestar für deine Stufe und Fraktion wählt. Das Auktionshaus geht auch.",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "In Forever bringt kein Rezept, das ein Lehrer lehrt oder die Händler beider Fraktionen verkaufen, nach 295 noch Punkte in {skill:197}, daher hat Polestar keine Route für die letzten Punkte. Rezepte, die noch Punkte bringen: {item:14342} (erfordert einen Mondbrunnen), {item:14137} (erfordert {item:279943}), {item:14155} (Rezept wird gedroppt), {item:14128} (Rezept wird gedroppt), {item:19047} (erfordert {item:279943}).",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Orange (jede Herstellung ein Punkt) bis 160, gelb bis 175, grün bis 190.",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Orange (jede Herstellung ein Punkt) bis 245, gelb bis 260, grün bis 275.",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Orange (jede Herstellung ein Punkt) bis 265, gelb bis 280, grün bis 295.",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Orange (jede Herstellung ein Punkt) bis 40, gelb bis 50, grün bis 60.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1815}, {npc:1816}, {npc:1817} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich hin. Das Auktionshaus geht auch.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Lehrt {item:13863} (erfordert {skill:197} 230). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird.",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "Lehrt {item:254123} (erfordert {skill:197} 250).",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Lehrt {item:7053} (erfordert {skill:197} 140). Händler verkaufen es in begrenzter Stückzahl, die wieder aufgefüllt wird.",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "Gelb bis 127, grün bis 145: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Gelb bis 140, grün bis 155: Nicht jede Herstellung bringt einen Punkt. {skill:197} 150 ist ein Meilenstein des Vermächtnissystems.",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "Gelb bis 190, grün bis 200: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "Gelb bis 200, grün bis 215: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Gelb bis 220, grün bis 235: Nicht jede Herstellung bringt einen Punkt. {skill:197} 225 ist ein Meilenstein des Vermächtnissystems.",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "Gelb bis 240, grün bis 255: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "Gelb bis 67, grün bis 85: Nicht jede Herstellung bringt einen Punkt.",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Gelb bis 67, grün bis 85: Nicht jede Herstellung bringt einen Punkt. 75 ist die Obergrenze für Lehrling.",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "Gelb bis 97, grün bis 115: Nicht jede Herstellung bringt einen Punkt.",
	-- ["{item:10045} to 50"] = "{item:10045} bis 50",
	-- ["{item:13856} to 236"] = "{item:13856} bis 236",
	-- ["{item:13863} to 251"] = "{item:13863} bis 251",
	-- ["{item:254123} to 295"] = "{item:254123} bis 295",
	-- ["{item:7026} to 80"] = "{item:7026} bis 80",
	-- ["{item:7053} to 180"] = "{item:7053} bis 180",
	-- ["{item:7062} to 185"] = "{item:7062} bis 185",
	-- ["{item:9998} to 205"] = "{item:9998} bis 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Hier fällt es von {npc:11739} (Stufe 57-59). Das Auktionshaus geht auch.",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Hier fällt es von {npc:1824} (Stufe 54-55). Das Auktionshaus geht auch.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Hier fällt es von {npc:3263} (Stufe 19-20). Das Auktionshaus geht auch.",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Hier fällt es von {npc:5472} (Stufe 46-47). Das Auktionshaus geht auch.",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Hier fällt es von {npc:6006} (Stufe 52-53). Das Auktionshaus geht auch.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Hier fällt es von {npc:6189} (Stufe 51-52). Das Auktionshaus geht auch.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Hier fällt es von {npc:7027} (Stufe 56-57). Das Auktionshaus geht auch.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Hier fällt es von {npc:98} (Stufe 17-18). Das Auktionshaus geht auch.",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (oder das Auktionshaus)",
	-- ["{skill:197} materials for 75-150"] = "Materialien für {skill:197} 75-150",
	-- ["{skill:197} recipes at 110"] = "Rezepte für {skill:197} bei 110",
	-- ["{skill:197} recipes at 125"] = "Rezepte für {skill:197} bei 125",
	-- ["{skill:197} recipes at 180"] = "Rezepte für {skill:197} bei 180",
	-- ["{skill:197} recipes at 185"] = "Rezepte für {skill:197} bei 185",
	-- ["{skill:197} recipes at 205"] = "Rezepte für {skill:197} bei 205",
	-- ["{skill:197} recipes at 50"] = "Rezepte für {skill:197} bei 50",
	-- ["{skill:197} recipes at 80"] = "Rezepte für {skill:197} bei 80",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} läuft neben dem Leveln her. Forevers Vermächtnissystem belohnt herstellende Berufe bei Fertigkeit 150, 225 und 300 (die Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Kontrollpunkte. Die Materialien für 1-75 sind insgesamt etwa 1g 8s wert.",
	-- ["{spell:2402} to 110"] = "{spell:2402} bis 110",
	-- ["{spell:3848} to 125"] = "{spell:3848} bis 125",
	-- ["{spell:3852} to 150"] = "{spell:3852} bis 150",
}
