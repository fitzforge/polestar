-- German (deDE): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "Lerne {skill:165}",
	-- {skill:165} Leatherworking · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Any {skill:165} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "Lehrling in {skill:165} erlaubt dir, bis 75 herzustellen, für 10c, auf jeder Charakterstufe. Jeder {skill:165}-Lehrer deiner Fraktion lehrt ihn; der Pfeil wählt den nächsten. Kombiniere ihn mit {skill:393}: {item:2318} bekommst du von den Tieren jedes Startgebiets. {item:2320} und Salz verkaufen Händler für Lederverarbeitung und Handwerksbedarf. 1-75 kostet etwa 1s 50c für Rezepte und 5s für Händlerware, dazu 349 {item:2318} zum Sammeln oder Kaufen.",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "{skill:165} 1-75: Händlerware",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 50 {item:2320} (5s); insgesamt etwa 5s. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 3: Light Leather (Elwynn Forest)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1922} Gray Forest Wolf · {npc:525} Mangy Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:822} Young Forest Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} und {npc:822} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 4: Light Leather (Dun Morogh)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} und {npc:1128} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 5: Light Leather (Teldrassil)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2033} Elder Nightsaber · {npc:2043} Nightsaber Stalker
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:2033}, Nachtsäbler und {npc:2043} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 6: Light Leather (Zephras Isle)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:250928} Highlands Ursera · {npc:251284} Hippogryph Protector · {npc:251291} Hippogryph Youth · {npc:251707} Ornery Galestrider · {npc:256092} Shadowgale Shriekling · {npc:253282} Shriekling Fledgling · {npc:250874} Vuldren Alpha · {npc:254588} Windsong Crawler
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} und {npc:254588} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 7: Light Leather (Durotar)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} und {npc:3127} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 8: Light Leather (Mulgore)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} und {npc:2960} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 9: Light Leather (Tirisfal Glades)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} für {spell:2152}, {spell:3756} und {spell:3763} (210 davon für 75-150: Sammle jetzt alle): {skill:393}: Tiere der Stufen 5-20; oder im Auktionshaus. Häute hier {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} und {npc:1554} (Stufe 5-20); der {skill:393}-Guide routet das.",

	-- Step 10: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "{spell:2152} bis 51",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "{spell:2152} ist bei 1 orange (gelb 30, grün 45, grau 60): etwa 64 Herstellungen bis 51. Jede braucht 1 {item:2318}. Ein {item:2318} pro Herstellung; die Sets lassen sich an Händler verkaufen.",

	-- Step 11: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "{skill:165}-Rezepte bei 51",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "Zurück zu einem {skill:165}-Lehrer: {spell:3756} (ab 40, 1s 50c). Lerne auch {spell:1229432} (1s): Forevers Camp-Gegenstand für {skill:165}, 5 {item:2318}, an einem Lagerplatz neben ein Lagerfeuer gestellt. Die Quest Camping 101: {skill:165} aus dem Camping-Guide deines Startgebiets (nach The Great Outdoors) schickt dich zu einem Lehrer für Lederverarbeitung, der es kostenlos lehrt.",

	-- Step 12: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "{spell:3756} bis 75",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "{spell:3756} ist bei 51 orange (gelb 70, grün 85, grau 100): etwa 25 Herstellungen bis 75. Jede braucht 3 {item:2318} und 2 {item:2320}. Forever lehrt {spell:3756} ab 40.",

	-- Step 13: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "{skill:165} (Geselle)",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4212} Telonis · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {zone:1456} Thunder Bluff · {npc:3007} Una · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) and {npc:4212} ({zone:1457}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 308 {item:4234} to gather or buy."] = "Geselle hebt die Obergrenze von 75 auf 150 an, für 5s; er braucht {skill:165} 50 und Charakterstufe 10, also kannst du ihn bei jedem Besuch ab 50 lernen. Nicht jeder {skill:165}-Lehrer lehrt ihn: Allianz {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) und {npc:4212} ({zone:1457}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) und {npc:3007} ({zone:1456}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:3763} (ab 55, 3s). 75-150 kostet etwa 15s 50c für Rezepte und 57s für Händlerware, dazu 144 {item:2319}, 24 {item:2457} und 308 {item:4234} zum Sammeln oder Kaufen.",

	-- Step 14: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "{skill:165} 75-150: Händlerware",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 70 {item:2320} (7s) und 50 {item:2321} (50s); insgesamt etwa 57s. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 15: Medium Leather (Hillsbrad Foothills)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} für {item:7285}: {skill:393}: Tiere der Stufen 18-30; oder im Auktionshaus. Häute hier {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} und {npc:2354} (Stufe 18-30); der {skill:393}-Guide routet das.",

	-- Step 16: Medium Leather (Darkshore)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} für {item:7285}: {skill:393}: Tiere der Stufen 18-30; oder im Auktionshaus. Häute hier {npc:3823} und {npc:2071} (Stufe 18-30); der {skill:393}-Guide routet das.",

	-- Step 17: Medium Leather (The Barrens)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3236} Barrens Kodo
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} für {item:7285}: {skill:393}: Tiere der Stufen 18-30; oder im Auktionshaus. Häute hier {npc:3236} und Thunderhead (Stufe 18-30); der {skill:393}-Guide routet das.",

	-- Step 19: Heavy Leather (Alterac Mountains)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} für {spell:3780} und {item:4304} (178 davon für 150-225: Sammle jetzt alle): {skill:393}: Tiere der Stufen 28-40; oder im Auktionshaus. Häute hier {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} und Snapjaw (Stufe 28-40); der {skill:393}-Guide routet das.",

	-- Step 20: Heavy Leather (Thousand Needles)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} für {spell:3780} und {item:4304} (178 davon für 150-225: Sammle jetzt alle): {skill:393}: Tiere der Stufen 28-40; oder im Auktionshaus. Häute hier {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} und {npc:4142} (Stufe 28-40); der {skill:393}-Guide routet das.",

	-- Step 23: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "{spell:3763} bis 102",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "{spell:3763} ist bei 75 orange (gelb 85, grün 100, grau 115): etwa 35 Herstellungen bis 102. Jede braucht 6 {item:2318} und 2 {item:2320}. Forever lehrt {spell:3763} ab 55.",

	-- Step 24: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "{skill:165}-Rezepte bei 102",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "Zurück zu einem {skill:165}-Lehrer: {spell:9074} (ab 95, 5s).",

	-- Step 25: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "{item:7285} bis 125",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye · {skill:171} Alchemy
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all. {item:2457} (24 for 75-150): {skill:171}: {item:2457}; or the Auction House."] = "{item:7285} ist bei 102 orange (gelb 120, grün 132, grau 145): etwa 24 Herstellungen bis 125. Jede braucht 1 {item:2457}, 6 {item:2319} und 1 {item:2321}. Jede braucht einen {item:2457}: Ein Alchemist stellt ihn aus {item:2452} und {item:765} her, und im Auktionshaus ist er günstig. Ohne Elixiere nimm {spell:3763} weiter bis 105 und {item:2316} (ab 85: 8 {item:2319}, 1 {item:4340} und 1 {item:2321}) bis 125: etwa 28 Umhänge, insgesamt 224 {item:2319}. {item:2457} (24 für 75-150): {skill:171}: {item:2457}; oder im Auktionshaus.",

	-- Step 26: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "{skill:165}-Rezepte bei 125",
	-- {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "Zurück zu einem {skill:165}-Lehrer: {spell:3780} (ab 125, 7s 50c).",

	-- Step 27: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "{spell:3780} bis 150",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "{spell:3780} ist bei 125 orange (gelb 145, grün 155, grau 165): etwa 26 Herstellungen bis 150. Jede braucht 5 {item:4234} und 1 {item:2321}. Fünf {item:4234} pro Herstellung (Tiere der Stufen 28-40); die Sets lassen sich an Händler verkaufen. {skill:165} 150 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 28: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "{skill:165} 150-225: Händlerware",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 8 {item:2321} (8s) and 32 {item:4291} (1g 60s); about 1g 68s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 8 {item:2321} (8s) und 32 {item:4291} (1g 60s); insgesamt etwa 1g 68s. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 29: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Allianz)",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} für {item:8173} und {item:8170}: {skill:393}: Tiere der Stufen 38-50; oder im Auktionshaus. Häute hier {npc:2729}, {npc:2730}, {npc:2732} und {npc:2734} (Stufe 38-50); der {skill:393}-Guide routet das.",

	-- Step 30: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horde)",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} für {item:8173} und {item:8170}: {skill:393}: Tiere der Stufen 38-50; oder im Auktionshaus. Häute hier {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} und {npc:5296} (Stufe 38-50); der {skill:393}-Guide routet das.",

	-- Step 31: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "{skill:165} (Experte)",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3007} Una · {zone:1456} Thunder Bluff · {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}) and {npc:4212} ({zone:1457}); Horde {npc:11098} ({zone:1444}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. 150-225 takes about 1g 68s of vendor goods, plus 257 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:4304} (from 155) and {item:8173} (from 175), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8170} (from 205) takes a second trip, to other trainers (below)."] = "Experte hebt die Obergrenze von 150 auf 225 an; er braucht {skill:165} 125 und Charakterstufe 20, also kannst du ihn bei jedem Besuch ab 125 lernen. Nur wenige Lehrer lehren ihn: Allianz {npc:11097} ({zone:1425}) und {npc:4212} ({zone:1457}); Horde {npc:11098} ({zone:1444}) und {npc:3007} ({zone:1456}). Der Pfeil wählt den nächsten deiner Fraktion. 150-225 kostet etwa 1g 68s für Händlerware, dazu 257 {item:4304} zum Sammeln oder Kaufen. Komm mit allem in deinen Taschen (die Schritte oben, den Rest aus dem Auktionshaus): Diese Lehrer lehren auch {item:4304} (ab 155) und {item:8173} (ab 175), und die Herstellungen brauchen keine Station, also stelle gleich hier her und lerne jedes Rezept, sobald du seine Fertigkeit erreichst. Eine Reise statt 3. {item:8170} (ab 205) braucht eine zweite Reise zu anderen Lehrern (unten).",

	-- Step 32: Heavy Armor Kit to 155
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 155"] = "{spell:3780} bis 155",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 8 crafts to 155. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "{spell:3780} ist bei 150 gelb (gelb 145, grün 155, grau 165): etwa 8 Herstellungen bis 155. Jede braucht 5 {item:4234} und 1 {item:2321}. Fünf {item:4234} pro Herstellung (Tiere der Stufen 28-40); die Sets lassen sich an Händler verkaufen.",

	-- Step 33: Leatherworking recipes at 155
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 155"] = "{skill:165}-Rezepte bei 155",
	-- {spell:20650} Thick Leather
	["Still at the Expert trainer: {spell:20650} (from 155)."] = "Noch beim Lehrer für Experte: {spell:20650} (ab 155).",

	-- Step 34: Thick Leather to 177
	-- {item:4304} Thick Leather
	["{item:4304} to 177"] = "{item:4304} bis 177",
	-- {item:4304} Thick Leather · {item:4234} Heavy Leather
	-- plural, as words: Thick Armor Kits = {item:8173} Thick Armor Kit
	["{item:4304} is orange at 155 (yellow 175, green 177, grey 180): about 23 crafts to 177. Each takes 6 {item:4234}. Six {item:4234} make one {item:4304}, orange until 175: keep them, the Thick Armor Kits next use them."] = "{item:4304} ist bei 155 orange (gelb 175, grün 177, grau 180): etwa 23 Herstellungen bis 177. Jede braucht 6 {item:4234}. Sechs {item:4234} ergeben ein {item:4304}, orange bis 175: Behalte sie, die Thick Armor Kits brauchen sie als Nächstes.",

	-- Step 35: Leatherworking recipes at 177
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 177"] = "{skill:165}-Rezepte bei 177",
	-- {spell:10487} Thick Armor Kit
	["Still at the Expert trainer: {spell:10487} (from 175)."] = "Noch beim Lehrer für Experte: {spell:10487} (ab 175).",

	-- Step 36: Thick Armor Kit to 205
	-- {item:8173} Thick Armor Kit
	["{item:8173} to 205"] = "{item:8173} bis 205",
	-- {item:8173} Thick Armor Kit · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8173} is orange at 177 (yellow 195, green 205, grey 215): about 32 crafts to 205. Each takes 5 {item:4304} and 1 {item:4291}. Use the 23 {item:4304} you made earlier; the counts above leave them out. Five {item:4304} a craft; the kits sell to vendors."] = "{item:8173} ist bei 177 orange (gelb 195, grün 205, grau 215): etwa 32 Herstellungen bis 205. Jede braucht 5 {item:4304} und 1 {item:4291}. Nutze die 23 {item:4304}, die du vorher hergestellt hast; die Zahlen oben lassen sie weg. Fünf {item:4304} pro Herstellung; die Sets lassen sich an Händler verkaufen.",

	-- Step 37: Leatherworking recipes at 205
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 205"] = "{skill:165}-Rezepte bei 205",
	-- {spell:22331} Rugged Leather · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {skill:165} Leatherworking
	["{spell:22331} (from 205) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "{spell:22331} (ab 205) lehren nur die Lehrer für Meister: Allianz {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). Du kannst dort jetzt Meister lernen, wenn du Stufe 35 bist (er braucht {skill:165} 200); das spart die Reise bei 225.",

	-- Step 38: Rugged Leather to 225
	-- {item:8170} Rugged Leather
	["{item:8170} to 225"] = "{item:8170} bis 225",
	-- {item:8170} Rugged Leather · {item:4304} Thick Leather · {skill:165} Leatherworking
	["{item:8170} is orange at 205 (yellow 225, green 225, grey 225): about 20 crafts to 225, a point every craft. Each takes 6 {item:4304}. {item:8170} from {item:4304}: the points come cheap and you need the {item:8170} next. {skill:165} 225 is a Legacy System milestone."] = "{item:8170} ist bei 205 orange (gelb 225, grün 225, grau 225): etwa 20 Herstellungen bis 225, ein Punkt pro Herstellung. Jede braucht 6 {item:4304}. {item:8170} aus {item:4304}: Die Punkte sind billig, und du brauchst das {item:8170} als Nächstes. {skill:165} 225 ist ein Meilenstein des Vermächtnissystems.",

	-- Step 39: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "{skill:165} (Fachmann)",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 205). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1009 {item:8170} and 430 {item:14047} to gather or buy."] = "Meister hebt die Obergrenze von 225 auf 300 an; er braucht {skill:165} 200 und Charakterstufe 35, also kannst du ihn bei jedem Besuch ab 200 lernen. Nur wenige Lehrer lehren ihn: Allianz {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). Der Pfeil wählt den nächsten deiner Fraktion. Lerne jetzt: {spell:19058} (ab 205). 225-300 kostet etwa 3g 40s für Rezepte und 44g 90s für Händlerware, dazu 1.009 {item:8170} und 430 {item:14047} zum Sammeln oder Kaufen.",

	-- Step 40: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "{skill:165} 225-300: Händlerware",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Kauf den Bedarf des ganzen Abschnitts auf einmal: 39 {item:2325} (3g 90s) und 82 {item:14341} (41g); insgesamt etwa 44g 90s. Der Pfeil wählt den nächsten Verkäufer deiner Fraktion ({zone:1453}: {npc:1347}, {npc:1286} und {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} und {npc:5817}).",

	-- Step 41: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15725} lehrt {item:15083} ({skill:165} 235) für 1g 20s. Verkauft von Allianz: {npc:12942} ({zone:1422}), begrenzter Vorrat; Horde: {npc:12943} ({zone:1422}), begrenzter Vorrat. Seine Verkäufer haben ein oder zwei auf Lager, die einige Zeit nach einem Verkauf wiederkommen; es wird beim Aufheben gebunden, also gibt es das im Auktionshaus nie.",

	-- Step 42: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15756} lehrt {item:15094} ({skill:165} 265) für 2g 20s. Verkauft von {npc:12941} ({zone:1423}), begrenzter Vorrat. Seine Verkäufer haben ein oder zwei auf Lager, die einige Zeit nach einem Verkauf wiederkommen; es wird beim Aufheben gebunden, also gibt es das im Auktionshaus nie.",

	-- Step 43: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Allianz)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "1.009 {item:8170} für {item:15564}, {item:15083} und {item:15094}: {skill:393}: Tiere der Stufen 48-60; oder im Auktionshaus. Häute hier {npc:1815}, {npc:1816} und {npc:1817} (Stufe 48-60); der {skill:393}-Guide routet das.",

	-- Step 44: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "1.009 {item:8170} für {item:15564}, {item:15083} und {item:15094}: {skill:393}: Tiere der Stufen 48-60; oder im Auktionshaus. Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} und {npc:6377} (Stufe 48-60); der {skill:393}-Guide routet das.",

	-- Step 45: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Allianz)",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:7027} Blackrock Slayer
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "430 {item:14047} für {item:15094}: Droppt bei Humanoiden der Stufen 45-60; oder im Auktionshaus. Droppt hier bei {npc:7027} (Stufe 56-57).",

	-- Step 46: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:11880} Twilight Avenger
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "430 {item:14047} für {item:15094}: Droppt bei Humanoiden der Stufen 45-60; oder im Auktionshaus. Droppt hier bei {npc:11880} (Stufe 57-59).",

	-- Step 47: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "{item:15564} bis 239",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Use the 20 {item:8170} you made earlier; the counts above leave them out. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "{item:15564} ist bei 225 gelb (gelb 225, grün 235, grau 245): etwa 23 Herstellungen bis 239. Jede braucht 5 {item:8170}. Nutze die 20 {item:8170}, die du vorher hergestellt hast; die Zahlen oben lassen sie weg. Fünf {item:8170} pro Herstellung. Spezialisierung (optional): bei 225 und Charakterstufe 40. Drachenschuppenleder: {npc:7866} ({zone:1447}) oder {npc:7867} ({zone:1418}) will 2 Tough Scorpid Breastplates, 2 {item:8204} (die Muster droppen bei den Wastewander-Banditen in {zone:1446}) und 10 {item:8165}. Elementarleder: {npc:7868} ({zone:1427}) oder {npc:7869} ({zone:1417}) will je 2 {item:7077}, {item:7079}, {item:7075} und {item:7081}. Stammesleder (ab 235): {npc:7870} ({zone:1444}) oder {npc:7871} ({zone:1434}) will eine {item:8211} und Helm, nach den Wild-Leather-Quests von {npc:7852} oder {npc:7854} in {zone:1444}. In Forever brauchen die Spezialisierungsmuster ein {item:279941}. Du kannst nur eine nehmen; für 300 wird keine gebraucht, und die Beta hat sie nie getestet (sie endete bei Stufe 30).",

	-- Step 48: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "{item:15083} bis 269",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "{item:15083} ist bei 239 orange (gelb 255, grün 265, grau 275): etwa 39 Herstellungen bis 269. Jede braucht 8 {item:8170}, 1 {item:2325} und 1 {item:14341}. Acht {item:8170} pro Herstellung; {item:2325} und {item:14341} gibt es bei Händlern für Lederverarbeitung oder Schneiderei.",
	["from the recipe in your bags"] = "aus dem Rezept in deinen Taschen",

	-- Step 49: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094} bis 300",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "{item:15094} ist bei 269 orange (gelb 285, grün 295, grau 305): etwa 43 Herstellungen bis 300. Jede braucht 14 {item:8170}, 10 {item:14047} und 1 {item:14341}. 14 {item:8170} und 10 {item:14047} pro Herstellung: der teuerste Abschnitt. {skill:165} 300 ist ein Meilenstein des Vermächtnissystems.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:165}"] = "{skill:165} (Lehrling)",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "Fachmann benötigt Charakterstufe 35 und {skill:165} 200; es hebt die Obergrenze auf 300. Die Materialien für 225-300 sind insgesamt etwa 312g wert.",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "Zurück zu einem Lehrer für {skill:165}: {spell:10482}, {spell:14932} werden ab {skill:165} 220 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "Zurück zu einem Lehrer für {skill:165}: {spell:10487} wird ab {skill:165} 195 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "Zurück zu einem Lehrer für {skill:165}: {spell:3763} wird ab {skill:165} 85 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "Zurück zu einem Lehrer für {skill:165}: {spell:3776} wird ab {skill:165} 175 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "Zurück zu einem Lehrer für {skill:165}: {spell:3817}, {spell:3768} werden ab {skill:165} 130 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "Zurück zu einem Lehrer für {skill:165}: {spell:7151} wird ab {skill:165} 170 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "Zurück zu einem Lehrer für {skill:165}: {spell:7156} wird ab {skill:165} 185 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "Zurück zu einem Lehrer für {skill:165}: {spell:9062} wird ab {skill:165} 55 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "Zurück zu einem Lehrer für {skill:165}: {spell:9068} wird ab {skill:165} 100 gelehrt.",
	-- ["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "Zurück zu einem Lehrer für {skill:165}: {spell:9074} wird ab {skill:165} 120 gelehrt.",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "Experte benötigt Charakterstufe 20 und {skill:165} 125; es hebt die Obergrenze auf 225. Die Materialien für 150-225 sind insgesamt etwa 61g wert.",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "Geselle benötigt Charakterstufe 10 und {skill:165} 50; es hebt die Obergrenze auf 150. Die Materialien für 75-150 sind insgesamt etwa 11g wert.",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "Orange (jede Herstellung ein Punkt) bis 155, gelb bis 165, grün bis 175.",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "Orange (jede Herstellung ein Punkt) bis 205, gelb bis 215, grün bis 225.",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "Orange (jede Herstellung ein Punkt) bis 255, gelb bis 265, grün bis 275.",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "Orange (jede Herstellung ein Punkt) bis 285, gelb bis 295, grün bis 305. {skill:165} 300 ist ein Meilenstein des Vermächtnis-Systems.",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "Orange (jede Herstellung ein Punkt) bis 30, gelb bis 45, grün bis 60.",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} (Wildtiere der Stufe 5-20 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:1815}, {npc:1816}, {npc:1817} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Schnappkiefer (Wildtiere der Stufe 28-40 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Schnappkiefer, {npc:2384}, {npc:2354} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} (Wildtiere der Stufe 5-20 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (Wildtiere der Stufe 18-30 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} (Wildtiere der Stufe 28-40 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (Wildtiere der Stufe 38-50 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Häute hier {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (Wildtiere der Stufe 48-60 liefern es); der Guide für {skill:393} führt dich dorthin. Das Auktionshaus geht auch.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Gehäutet, entzaubert oder von einem anderen Beruf hergestellt: Sammle sie selbst oder kauf sie im Auktionshaus.",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "Lehrt {item:15083} (benötigt {skill:165} 235). Händler haben es nur in begrenzter Menge, die wieder aufgefüllt wird.",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "Lehrt {item:15094} (benötigt {skill:165} 265). Händler haben es nur in begrenzter Menge, die wieder aufgefüllt wird.",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "Lehrt {item:252452} (benötigt {skill:165} 135).",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "Lehrt {item:252463} (benötigt {skill:165} 185).",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "Gelb bis 100, grün bis 115: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "Gelb bis 115, grün bis 130: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "Gelb bis 132, grün bis 145: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "Gelb bis 142, grün bis 155: Nicht jede Herstellung gibt einen Punkt. {skill:165} 150 ist ein Meilenstein des Vermächtnis-Systems.",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "Gelb bis 180, grün bis 190: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "Gelb bis 185, grün bis 195: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "Gelb bis 195, grün bis 205: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "Gelb bis 230, grün bis 240: Nicht jede Herstellung gibt einen Punkt. {skill:165} 225 ist ein Meilenstein des Vermächtnis-Systems.",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "Gelb bis 235, grün bis 245: Nicht jede Herstellung gibt einen Punkt.",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Gelb bis 70, grün bis 85: Nicht jede Herstellung gibt einen Punkt. 75 ist die Obergrenze für Lehrling.",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "Gelb bis 85, grün bis 100: Nicht jede Herstellung gibt einen Punkt.",
	-- ["{item:15083} to 267"] = "{item:15083} bis 267",
	-- ["{item:15564} to 236"] = "{item:15564} bis 236",
	-- ["{item:2318} (Alliance)"] = "{item:2318} (Allianz)",
	-- ["{item:2318} (Horde)"] = "{item:2318} (Horde)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Allianz)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- ["{item:252452} to 170"] = "{item:252452} bis 170",
	-- ["{item:252463} to 220"] = "{item:252463} bis 220",
	-- ["{item:4232} (Alliance)"] = "{item:4232} (Allianz)",
	-- ["{item:4232} (Horde)"] = "{item:4232} (Horde)",
	-- ["{item:4234} (Alliance)"] = "{item:4234} (Allianz)",
	-- ["{item:4234} (Horde)"] = "{item:4234} (Horde)",
	-- ["{item:4235} (Alliance)"] = "{item:4235} (Allianz)",
	-- ["{item:4235} (Horde)"] = "{item:4235} (Horde)",
	-- ["{item:5964} to 175"] = "{item:5964} bis 175",
	-- ["{item:5966} to 195"] = "{item:5966} bis 195",
	-- ["{item:7279} to 75"] = "{item:7279} bis 75",
	-- ["{item:7282} to 120"] = "{item:7282} bis 120",
	-- ["{item:7285} to 130"] = "{item:7285} bis 130",
	-- ["{item:783} (Alliance)"] = "{item:783} (Allianz)",
	-- ["{item:783} (Horde)"] = "{item:783} (Horde)",
	-- ["{item:8150} (Alliance)"] = "{item:8150} (Allianz)",
	-- ["{item:8150} (Horde)"] = "{item:8150} (Horde)",
	-- ["{item:8169} (Alliance)"] = "{item:8169} (Allianz)",
	-- ["{item:8169} (Horde)"] = "{item:8169} (Horde)",
	-- ["{item:8218} to 225"] = "{item:8218} bis 225",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "{npc:11746} (Stufe 56-58) lassen es hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "{npc:6189} (Stufe 51-52) lassen es hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "{npc:7027} (Stufe 56-57) lassen es hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "{npc:92} (Stufe 39-40) lassen es hier fallen. Das Auktionshaus geht auch.",
	-- ["{skill:165} materials for 150-225"] = "Materialien für {skill:165} 150-225",
	-- ["{skill:165} materials for 75-150"] = "Materialien für {skill:165} 75-150",
	-- ["{skill:165} recipes at 105"] = "Rezepte für {skill:165} bei 105",
	-- ["{skill:165} recipes at 120"] = "Rezepte für {skill:165} bei 120",
	-- ["{skill:165} recipes at 130"] = "Rezepte für {skill:165} bei 130",
	-- ["{skill:165} recipes at 170"] = "Rezepte für {skill:165} bei 170",
	-- ["{skill:165} recipes at 175"] = "Rezepte für {skill:165} bei 175",
	-- ["{skill:165} recipes at 185"] = "Rezepte für {skill:165} bei 185",
	-- ["{skill:165} recipes at 195"] = "Rezepte für {skill:165} bei 195",
	-- ["{skill:165} recipes at 220"] = "Rezepte für {skill:165} bei 220",
	-- ["{skill:165} recipes at 55"] = "Rezepte für {skill:165} bei 55",
	-- ["{skill:165} recipes at 85"] = "Rezepte für {skill:165} bei 85",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165} läuft neben dem Leveln mit. Das Vermächtnis-System von Forever belohnt Herstellungsberufe bei Fertigkeit 150, 225 und 300 (den Obergrenzen für Geselle, Experte und Fachmann), daher zählt jeder dieser Punkte. Die Materialien für 1-75 sind insgesamt etwa 1g 18s wert.",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}: {item:2457} (oder das Auktionshaus)",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}: {item:3389} (oder das Auktionshaus)",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}: {spell:3188} (oder das Auktionshaus)",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: ungewöhnliche (grüne) Ausrüstung entzaubern (oder das Auktionshaus)",
	-- ["{spell:2152} to 55"] = "{spell:2152} bis 55",
	-- ["{spell:3756} to 85"] = "{spell:3756} bis 85",
	-- ["{spell:3763} to 105"] = "{spell:3763} bis 105",
	-- ["{spell:3768} to 150"] = "{spell:3768} bis 150",
	-- ["{spell:3776} to 185"] = "{spell:3776} bis 185",
}
