-- Chinese (traditional) (zhTW): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "",
	-- {skill:165} Leatherworking · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Any {skill:165} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 3: Light Leather (Elwynn Forest)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1922} Gray Forest Wolf · {npc:525} Mangy Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:822} Young Forest Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 4: Light Leather (Dun Morogh)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 5: Light Leather (Teldrassil)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2033} Elder Nightsaber · {npc:2043} Nightsaber Stalker
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 6: Light Leather (Zephras Isle)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:250928} Highlands Ursera · {npc:251284} Hippogryph Protector · {npc:251291} Hippogryph Youth · {npc:251707} Ornery Galestrider · {npc:256092} Shadowgale Shriekling · {npc:253282} Shriekling Fledgling · {npc:250874} Vuldren Alpha · {npc:254588} Windsong Crawler
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 7: Light Leather (Durotar)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 8: Light Leather (Mulgore)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 9: Light Leather (Tirisfal Glades)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "",

	-- Step 10: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "",

	-- Step 11: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "",

	-- Step 12: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "",

	-- Step 13: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "中級{skill:165}",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4212} Telonis · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {zone:1456} Thunder Bluff · {npc:3007} Una · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) and {npc:4212} ({zone:1457}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 308 {item:4234} to gather or buy."] = "",

	-- Step 14: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 15: Medium Leather (Hillsbrad Foothills)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 16: Medium Leather (Darkshore)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 17: Medium Leather (The Barrens)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3236} Barrens Kodo
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 19: Heavy Leather (Alterac Mountains)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 20: Heavy Leather (Thousand Needles)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 23: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "",

	-- Step 24: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "",

	-- Step 25: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye · {skill:171} Alchemy
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all. {item:2457} (24 for 75-150): {skill:171}: {item:2457}; or the Auction House."] = "",

	-- Step 26: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "",
	-- {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "",

	-- Step 27: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "",

	-- Step 28: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 8 {item:2321} (8s) and 32 {item:4291} (1g 60s); about 1g 68s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 29: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304}（聯盟）",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 30: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 31: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "高級{skill:165}",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3007} Una · {zone:1456} Thunder Bluff · {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}) and {npc:4212} ({zone:1457}); Horde {npc:11098} ({zone:1444}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. 150-225 takes about 1g 68s of vendor goods, plus 257 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:4304} (from 155) and {item:8173} (from 175), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8170} (from 205) takes a second trip, to other trainers (below)."] = "",

	-- Step 32: Heavy Armor Kit to 155
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 155"] = "",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 8 crafts to 155. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "",

	-- Step 33: Leatherworking recipes at 155
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 155"] = "",
	-- {spell:20650} Thick Leather
	["Still at the Expert trainer: {spell:20650} (from 155)."] = "",

	-- Step 34: Thick Leather to 177
	-- {item:4304} Thick Leather
	["{item:4304} to 177"] = "",
	-- {item:4304} Thick Leather · {item:4234} Heavy Leather
	-- plural, as words: Thick Armor Kits = {item:8173} Thick Armor Kit
	["{item:4304} is orange at 155 (yellow 175, green 177, grey 180): about 23 crafts to 177. Each takes 6 {item:4234}. Six {item:4234} make one {item:4304}, orange until 175: keep them, the Thick Armor Kits next use them."] = "",

	-- Step 35: Leatherworking recipes at 177
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 177"] = "",
	-- {spell:10487} Thick Armor Kit
	["Still at the Expert trainer: {spell:10487} (from 175)."] = "",

	-- Step 36: Thick Armor Kit to 205
	-- {item:8173} Thick Armor Kit
	["{item:8173} to 205"] = "",
	-- {item:8173} Thick Armor Kit · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8173} is orange at 177 (yellow 195, green 205, grey 215): about 32 crafts to 205. Each takes 5 {item:4304} and 1 {item:4291}. Use the 23 {item:4304} you made earlier; the counts above leave them out. Five {item:4304} a craft; the kits sell to vendors."] = "",

	-- Step 37: Leatherworking recipes at 205
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 205"] = "",
	-- {spell:22331} Rugged Leather · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {skill:165} Leatherworking
	["{spell:22331} (from 205) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "",

	-- Step 38: Rugged Leather to 225
	-- {item:8170} Rugged Leather
	["{item:8170} to 225"] = "",
	-- {item:8170} Rugged Leather · {item:4304} Thick Leather · {skill:165} Leatherworking
	["{item:8170} is orange at 205 (yellow 225, green 225, grey 225): about 20 crafts to 225, a point every craft. Each takes 6 {item:4304}. {item:8170} from {item:4304}: the points come cheap and you need the {item:8170} next. {skill:165} 225 is a Legacy System milestone."] = "",

	-- Step 39: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "專家級{skill:165}",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 205). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1009 {item:8170} and 430 {item:14047} to gather or buy."] = "",

	-- Step 40: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 41: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 42: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 43: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（聯盟）",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 44: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 45: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047}（聯盟）",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:7027} Blackrock Slayer
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "",

	-- Step 46: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:11880} Twilight Avenger
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "",

	-- Step 47: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Use the 20 {item:8170} you made earlier; the counts above leave them out. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "",

	-- Step 48: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 49: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094}練到300",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:165}"] = "初級{skill:165}",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "專家級需要角色等級35且{skill:165}200點；上限提高到300。225-300所需材料總價約312金。",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "回到{skill:165}訓練師那裡：{spell:10482}、{spell:14932}在{skill:165}220點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "回到{skill:165}訓練師那裡：{spell:10487}在{skill:165}195點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "回到{skill:165}訓練師那裡：{spell:3763}在{skill:165}85點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "回到{skill:165}訓練師那裡：{spell:3776}在{skill:165}175點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "回到{skill:165}訓練師那裡：{spell:3817}、{spell:3768}在{skill:165}130點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "回到{skill:165}訓練師那裡：{spell:7151}在{skill:165}170點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "回到{skill:165}訓練師那裡：{spell:7156}在{skill:165}185點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "回到{skill:165}訓練師那裡：{spell:9062}在{skill:165}55點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "回到{skill:165}訓練師那裡：{spell:9068}在{skill:165}100點時可學。",
	-- ["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "回到{skill:165}訓練師那裡：{spell:9074}在{skill:165}120點時可學。",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "高級需要角色等級20且{skill:165}125點；上限提高到225。150-225所需材料總價約61金。",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "中級需要角色等級10且{skill:165}50點；上限提高到150。75-150所需材料總價約11金。",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "橙色（每次製造必得1點）到155，黃色到165，綠色到175。",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "橙色（每次製造必得1點）到205，黃色到215，綠色到225。",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "橙色（每次製造必得1點）到255，黃色到265，綠色到275。",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "橙色（每次製造必得1點）到285，黃色到295，綠色到305。{skill:165}300是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "橙色（每次製造必得1點）到30，黃色到45，綠色到60。",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:1125}、{npc:1127}、{npc:1196}、{npc:1199}、{npc:1126}、{npc:1689}、{npc:1201}、{npc:1138}、{npc:1131}、{npc:1128}的皮（5-20級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:1815}、{npc:1816}、{npc:1817}的皮（48-60級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2248}、{npc:2249}、{npc:2251}、{npc:2407}、{npc:2406}、{npc:2250}、鉗嘴龜的皮（28-40級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、鉗嘴龜、{npc:2384}、{npc:2354}的皮（18-30級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}的皮（38-50級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:3126}、{npc:3123}、{npc:3122}、{npc:3125}、{npc:3099}、{npc:3110}、{npc:3121}、{npc:3100}、{npc:3130}、{npc:3127}的皮（5-20級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}的皮（18-30級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:4107}、{npc:4147}、{npc:4140}、{npc:4139}、{npc:4143}、{npc:4142}的皮（28-40級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}的皮（38-50級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}的皮（48-60級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或由其他專業製造：自己收集或在拍賣場購買。",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "學會{item:15083}（需要{skill:165}235點）。商人限量出售，會補貨。",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "學會{item:15094}（需要{skill:165}265點）。商人限量出售，會補貨。",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "學會{item:252452}（需要{skill:165}135點）。",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "學會{item:252463}（需要{skill:165}185點）。",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "黃色到100，綠色到115：不是每次製造都會得到點數。",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "黃色到115，綠色到130：不是每次製造都會得到點數。",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "黃色到132，綠色到145：不是每次製造都會得到點數。",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "黃色到142，綠色到155：不是每次製造都會得到點數。{skill:165}150是傳承系統的里程碑。",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "黃色到180，綠色到190：不是每次製造都會得到點數。",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "黃色到185，綠色到195：不是每次製造都會得到點數。",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "黃色到195，綠色到205：不是每次製造都會得到點數。",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "黃色到230，綠色到240：不是每次製造都會得到點數。{skill:165}225是傳承系統的里程碑。",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "黃色到235，綠色到245：不是每次製造都會得到點數。",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黃色到70，綠色到85：不是每次製造都會得到點數。75是初級的上限。",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "黃色到85，綠色到100：不是每次製造都會得到點數。",
	-- ["{item:15083} to 267"] = "{item:15083}練到267",
	-- ["{item:15564} to 236"] = "{item:15564}練到236",
	-- ["{item:2318} (Alliance)"] = "{item:2318}（聯盟）",
	-- ["{item:2318} (Horde)"] = "{item:2318}（部落）",
	-- ["{item:2319} (Alliance)"] = "{item:2319}（聯盟）",
	-- ["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- ["{item:252452} to 170"] = "{item:252452}練到170",
	-- ["{item:252463} to 220"] = "{item:252463}練到220",
	-- ["{item:4232} (Alliance)"] = "{item:4232}（聯盟）",
	-- ["{item:4232} (Horde)"] = "{item:4232}（部落）",
	-- ["{item:4234} (Alliance)"] = "{item:4234}（聯盟）",
	-- ["{item:4234} (Horde)"] = "{item:4234}（部落）",
	-- ["{item:4235} (Alliance)"] = "{item:4235}（聯盟）",
	-- ["{item:4235} (Horde)"] = "{item:4235}（部落）",
	-- ["{item:5964} to 175"] = "{item:5964}練到175",
	-- ["{item:5966} to 195"] = "{item:5966}練到195",
	-- ["{item:7279} to 75"] = "{item:7279}練到75",
	-- ["{item:7282} to 120"] = "{item:7282}練到120",
	-- ["{item:7285} to 130"] = "{item:7285}練到130",
	-- ["{item:783} (Alliance)"] = "{item:783}（聯盟）",
	-- ["{item:783} (Horde)"] = "{item:783}（部落）",
	-- ["{item:8150} (Alliance)"] = "{item:8150}（聯盟）",
	-- ["{item:8150} (Horde)"] = "{item:8150}（部落）",
	-- ["{item:8169} (Alliance)"] = "{item:8169}（聯盟）",
	-- ["{item:8169} (Horde)"] = "{item:8169}（部落）",
	-- ["{item:8218} to 225"] = "{item:8218}練到225",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "這裡的{npc:11746}（56-58級）會掉落。拍賣場也買得到。",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "這裡的{npc:6189}（51-52級）會掉落。拍賣場也買得到。",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "這裡的{npc:7027}（56-57級）會掉落。拍賣場也買得到。",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "這裡的{npc:92}（39-40級）會掉落。拍賣場也買得到。",
	-- ["{skill:165} materials for 150-225"] = "{skill:165}150-225所需材料",
	-- ["{skill:165} materials for 75-150"] = "{skill:165}75-150所需材料",
	-- ["{skill:165} recipes at 105"] = "{skill:165}105點的配方",
	-- ["{skill:165} recipes at 120"] = "{skill:165}120點的配方",
	-- ["{skill:165} recipes at 130"] = "{skill:165}130點的配方",
	-- ["{skill:165} recipes at 170"] = "{skill:165}170點的配方",
	-- ["{skill:165} recipes at 175"] = "{skill:165}175點的配方",
	-- ["{skill:165} recipes at 185"] = "{skill:165}185點的配方",
	-- ["{skill:165} recipes at 195"] = "{skill:165}195點的配方",
	-- ["{skill:165} recipes at 220"] = "{skill:165}220點的配方",
	-- ["{skill:165} recipes at 55"] = "{skill:165}55點的配方",
	-- ["{skill:165} recipes at 85"] = "{skill:165}85點的配方",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165}可以邊升級邊練。Forever的傳承系統會在技能150、225和300（中級、高級和專家級的上限）獎勵製造專業，所以每個關卡都很重要。1-75所需材料總價約1金18銀。",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}：{item:2457}（或拍賣場）",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}：{item:3389}（或拍賣場）",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}：{spell:3188}（或拍賣場）",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}：分解優秀（綠色）裝備（或拍賣場）",
	-- ["{spell:2152} to 55"] = "{spell:2152}練到55",
	-- ["{spell:3756} to 85"] = "{spell:3756}練到85",
	-- ["{spell:3763} to 105"] = "{spell:3763}練到105",
	-- ["{spell:3768} to 150"] = "{spell:3768}練到150",
	-- ["{spell:3776} to 185"] = "{spell:3776}練到185",
}
