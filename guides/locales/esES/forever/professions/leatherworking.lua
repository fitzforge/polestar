-- Spanish (Spain) (esES): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "Aprende {skill:165}",
	["No character level needed."] = "",

	-- Step 2: Buy 10 Salt
	["Buy 10 Salt"] = "",
	-- plural, as words: Cured Light Hides = {spell:3816} Cured Light Hide
	["For 10 Cured Light Hides."] = "",

	-- Step 3: Buy 40 Coarse Thread
	-- {item:2320} Coarse Thread
	["Buy 40 {item:2320}"] = "",
	-- {spell:3756} Embossed Leather Gloves
	["For 20 {spell:3756}."] = "",

	-- Step 4: Get 105 Ruined Leather Scraps
	-- {item:2934} Ruined Leather Scraps
	["Get 105 {item:2934}"] = "",
	-- {item:2318} Light Leather
	["For 35 {item:2318}."] = "",

	-- Step 5: Craft 35 Light Leather until 30
	-- {item:2318} Light Leather
	["Craft 35 {item:2318} until 30"] = "",
	["About 35 crafts. Keep the leather: the gloves at 40 use it."] = "",

	-- Step 6: Get 10 Light Hide
	-- {item:783} Light Hide
	["Get 10 {item:783}"] = "",

	-- Step 7: Learn Cured Light Hide
	-- {spell:3816} Cured Light Hide
	["Learn {spell:3816}"] = "",

	-- Step 8: Craft 10 Cured Light Hides until 40
	-- plural, as words: Cured Light Hides = {spell:3816} Cured Light Hide
	["Craft 10 Cured Light Hides until 40"] = "",
	-- {spell:3759} Embossed Leather Pants
	["About 10 crafts. Keep all 10 hides for the {spell:3759} at 70."] = "",

	-- Step 9: Get 25 Light Leather
	-- {item:2318} Light Leather
	["Get 25 {item:2318}"] = "",
	-- {spell:3756} Embossed Leather Gloves
	["For 20 {spell:3756}. 35 more come from your own crafts."] = "",

	-- Step 10: Learn Embossed Leather Gloves
	-- {spell:3756} Embossed Leather Gloves
	["Learn {spell:3756}"] = "",

	-- Step 11: Craft 20 Embossed Leather Gloves until 60
	-- {spell:3756} Embossed Leather Gloves
	["Craft 20 {spell:3756} until 60"] = "",
	["About 20 crafts."] = "",

	-- Step 12: Buy 84 Coarse Thread
	-- {item:2320} Coarse Thread
	["Buy 84 {item:2320}"] = "",
	-- {spell:3756} Embossed Leather Gloves · {spell:3759} Embossed Leather Pants
	-- plural, as words: Fine Leather Belts = {spell:3763} Fine Leather Belt
	["For 10 {spell:3756}, 10 {spell:3759} and 22 Fine Leather Belts."] = "",

	-- Step 13: Buy 95 Salt
	["Buy 95 Salt"] = "",
	-- plural, as words: Cured Medium Hides = {spell:3817} Cured Medium Hide · Cured Heavy Hides = {spell:3818} Cured Heavy Hide
	["For 20 Cured Medium Hides and 25 Cured Heavy Hides."] = "",

	-- Step 14: Buy 72 Fine Thread
	-- {item:2321} Fine Thread
	["Buy 72 {item:2321}"] = "",
	-- {spell:3764} Hillman's Leather Gloves
	-- plural, as words: Dark Leather Belts = {spell:3766} Dark Leather Belt
	["For 20 Dark Leather Belts and 8 {spell:3764}."] = "",

	-- Step 15: Buy 20 Gray Dye
	-- {item:4340} Gray Dye
	["Buy 20 {item:4340}"] = "",
	-- plural, as words: Dark Leather Belts = {spell:3766} Dark Leather Belt
	["For 20 Dark Leather Belts."] = "",

	-- Step 16: Get 90 Light Leather
	-- {item:2318} Light Leather
	["Get 90 {item:2318}"] = "",
	-- {spell:3756} Embossed Leather Gloves · {spell:3759} Embossed Leather Pants
	["For 10 {spell:3756} and 10 {spell:3759}."] = "",

	-- Step 17: Train Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Train Journeyman {skill:165}"] = "",
	["Needs level 10."] = "",

	-- Step 18: Learn Embossed Leather Pants
	-- {spell:3759} Embossed Leather Pants
	["Learn {spell:3759}"] = "",
	["For 70-80: taught here now, so no second trip."] = "",

	-- Step 19: Learn Fine Leather Belt
	-- {spell:3763} Fine Leather Belt
	["Learn {spell:3763}"] = "",
	["For 95-105: taught here now, so no second trip."] = "",

	-- Step 20: Learn Embossed Leather Gloves
	["Taught at 40; done at once if you learned it then."] = "",

	-- Step 21: Craft 10 Embossed Leather Gloves until 70
	-- {spell:3756} Embossed Leather Gloves
	["Craft 10 {spell:3756} until 70"] = "",
	["About 10 crafts."] = "",

	-- Step 22: Craft 10 Embossed Leather Pants until 80
	-- {spell:3759} Embossed Leather Pants
	["Craft 10 {spell:3759} until 80"] = "",
	["About 10 crafts. No points past 75 until Journeyman is trained."] = "",

	-- Step 23: Get 20 Medium Hide
	-- {item:4232} Medium Hide
	["Get 20 {item:4232}"] = "",
	-- plural, as words: Cured Medium Hides = {spell:3817} Cured Medium Hide
	["For 20 Cured Medium Hides."] = "",

	-- Step 24: Learn Cured Medium Hide
	-- {spell:3817} Cured Medium Hide
	["Learn {spell:3817}"] = "",

	-- Step 25: Craft 20 Cured Medium Hides until 95
	-- plural, as words: Cured Medium Hides = {spell:3817} Cured Medium Hide
	["Craft 20 Cured Medium Hides until 95"] = "",
	-- plural, as words: Dark Leather Belts = {spell:3766} Dark Leather Belt
	["About 20 crafts. Keep all 20 hides for the Dark Leather Belts at 105."] = "",

	-- Step 26: Get 132 Light Leather
	-- {item:2318} Light Leather
	["Get 132 {item:2318}"] = "",
	-- plural, as words: Fine Leather Belts = {spell:3763} Fine Leather Belt
	["For 22 Fine Leather Belts."] = "",

	-- Step 27: Learn Fine Leather Belt
	["Taught at 60; done at once if you learned it then."] = "",

	-- Step 28: Craft 22 Fine Leather Belts until 105
	-- plural, as words: Fine Leather Belts = {spell:3763} Fine Leather Belt
	["Craft 22 Fine Leather Belts until 105"] = "",
	-- plural, as words: Dark Leather Belts = {spell:3766} Dark Leather Belt
	["About 22 crafts. Keep 20 belts: the Dark Leather Belts at 105 are made from them."] = "",

	-- Step 29: Learn Dark Leather Belt
	-- {spell:3766} Dark Leather Belt
	["Learn {spell:3766}"] = "",

	-- Step 30: Craft 20 Dark Leather Belts until 125
	-- plural, as words: Dark Leather Belts = {spell:3766} Dark Leather Belt
	["Craft 20 Dark Leather Belts until 125"] = "",

	-- Step 31: Get 40 Medium Leather
	-- {item:2319} Medium Leather
	["Get 40 {item:2319}"] = "",
	-- {item:4234} Heavy Leather
	["For 8 {item:4234}."] = "",

	-- Step 32: Learn Heavy Leather
	-- {spell:20649} Heavy Leather
	["Learn {spell:20649}"] = "",

	-- Step 33: Learn Cured Heavy Hide
	-- {spell:3818} Cured Heavy Hide
	["Learn {spell:3818}"] = "",
	["For 130-143: taught here now, so no second trip."] = "",

	-- Step 34: Learn Hillman's Leather Gloves
	-- {spell:3764} Hillman's Leather Gloves
	["Learn {spell:3764}"] = "",
	["For 143-150: taught here now, so no second trip."] = "",

	-- Step 35: Craft 8 Heavy Leather until 130
	-- {item:4234} Heavy Leather
	["Craft 8 {item:4234} until 130"] = "",
	-- {item:4234} Heavy Leather
	["About 8 crafts. Keep the {item:4234} for the shoulders at 150."] = "",

	-- Step 36: Get 25 Heavy Hide
	-- {item:4235} Heavy Hide
	["Get 25 {item:4235}"] = "",
	-- plural, as words: Cured Heavy Hides = {spell:3818} Cured Heavy Hide
	["For 25 Cured Heavy Hides."] = "",

	-- Step 37: Learn Cured Heavy Hide
	["Taught at 125; done at once if you learned it then."] = "",

	-- Step 38: Craft 25 Cured Heavy Hides until 143
	-- plural, as words: Cured Heavy Hides = {spell:3818} Cured Heavy Hide
	["Craft 25 Cured Heavy Hides until 143"] = "",
	["About 25 crafts. Keep all 25: 15 for the shoulders at 150, 10 for the gloves at 165."] = "",

	-- Step 39: Get 112 Medium Leather
	-- {item:2319} Medium Leather
	["Get 112 {item:2319}"] = "",
	-- {spell:3764} Hillman's Leather Gloves
	["For 8 {spell:3764}."] = "",

	-- Step 41: Craft 8 Hillman's Leather Gloves until 150
	-- {spell:3764} Hillman's Leather Gloves
	["Craft 8 {spell:3764} until 150"] = "",
	["About 8 crafts."] = "",

	-- Step 42: Buy 50 Fine Thread
	-- {item:2321} Fine Thread
	["Buy 50 {item:2321}"] = "",
	-- {item:5964} Barbaric Shoulders · {item:5739} Barbaric Harness
	["For 15 {item:5964} and 10 {item:5739}."] = "",

	-- Step 43: Buy 54 Silken Thread
	-- {item:4291} Silken Thread
	["Buy 54 {item:4291}"] = "",
	-- {item:5966} Guardian Gloves
	-- plural, as words: Nightscape Headbands = {item:8176} Nightscape Headband
	["For 10 {item:5966} and 22 Nightscape Headbands."] = "",

	-- Step 44: Get 152 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 152 {item:4234}"] = "",
	-- {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves
	["For 15 {item:5964} and 10 {item:5966}. 8 more come from your own crafts."] = "",

	-- Step 45: Train Expert Leatherworking
	-- {skill:165} Leatherworking
	["Train Expert {skill:165}"] = "",
	["Needs level 20."] = "",

	-- Step 46: Learn Barbaric Shoulders
	-- {spell:7151} Barbaric Shoulders
	["Learn {spell:7151}"] = "",

	-- Step 47: Craft 15 Barbaric Shoulders until 165
	-- {item:5964} Barbaric Shoulders
	["Craft 15 {item:5964} until 165"] = "",
	["About 15 crafts."] = "",

	-- Step 48: Learn Guardian Gloves
	-- {spell:7156} Guardian Gloves
	["Learn {spell:7156}"] = "",

	-- Step 49: Learn Barbaric Harness
	-- {spell:6661} Barbaric Harness
	["Learn {spell:6661}"] = "",
	["For 175-185: taught here now, so no second trip."] = "",

	-- Step 50: Craft 10 Guardian Gloves until 175
	-- {item:5966} Guardian Gloves
	["Craft 10 {item:5966} until 175"] = "",
	["About 10 crafts. Orange to 185: more hides? These carry on in place of the harness."] = "",

	-- Step 51: Get 140 Heavy Leather
	-- {item:4234} Heavy Leather
	["Get 140 {item:4234}"] = "",
	-- {item:5739} Barbaric Harness
	["For 10 {item:5739}."] = "",

	-- Step 52: Get 10 Iron Buckle
	-- {item:7071} Iron Buckle
	["Get 10 {item:7071}"] = "",

	-- Step 53: Learn Barbaric Harness
	["Taught at 165; done at once if you learned it then."] = "",

	-- Step 54: Craft 10 Barbaric Harness until 185
	-- {item:5739} Barbaric Harness
	["Craft 10 {item:5739} until 185"] = "",

	-- Step 55: Get 110 Thick Leather
	-- {item:4304} Thick Leather
	["Get 110 {item:4304}"] = "",
	-- plural, as words: Nightscape Headbands = {item:8176} Nightscape Headband
	["For 22 Nightscape Headbands."] = "",

	-- Step 56: Learn Nightscape Headband
	-- {spell:10507} Nightscape Headband
	["Learn {spell:10507}"] = "",

	-- Step 57: Craft 22 Nightscape Headbands until 205
	-- plural, as words: Nightscape Headbands = {item:8176} Nightscape Headband
	["Craft 22 Nightscape Headbands until 205"] = "",
	["About 22 crafts."] = "",

	-- Step 58: Buy 144 Silken Thread
	-- {item:4291} Silken Thread
	["Buy 144 {item:4291}"] = "",
	-- {item:8193} Nightscape Pants
	["For 36 {item:8193}."] = "",

	-- Step 59: Buy 36 Black Dye
	-- {item:2325} Black Dye
	["Buy 36 {item:2325}"] = "",
	-- {item:15083} Wicked Leather Gauntlets
	["For 36 {item:15083}."] = "",

	-- Step 60: Buy 85 Rune Thread
	-- {item:14341} Rune Thread
	["Buy 85 {item:14341}"] = "",
	-- {item:15083} Wicked Leather Gauntlets
	-- plural, as words: Runic Leather Headbands = {item:15094} Runic Leather Headband
	["For 36 {item:15083} and 49 Runic Leather Headbands."] = "",

	-- Step 61: Get 504 Thick Leather
	-- {item:4304} Thick Leather
	["Get 504 {item:4304}"] = "",

	-- Step 62: Train Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Train Artisan {skill:165}"] = "",
	["Needs level 35."] = "",

	-- Step 63: Learn Nightscape Pants
	-- {spell:10548} Nightscape Pants
	["Learn {spell:10548}"] = "",

	-- Step 64: Craft 36 Nightscape Pants until 235
	-- {item:8193} Nightscape Pants
	["Craft 36 {item:8193} until 235"] = "",
	["About 36 crafts. No points past 225 until Artisan is trained."] = "",

	-- Step 65: Get 288 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 288 {item:8170}"] = "",

	-- Step 66: Buy Pattern: Wicked Leather Gauntlets · Leonard Porter
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {npc:12942} Leonard Porter
	["Buy {item:15725} · {npc:12942}"] = "",
	["It binds when picked up."] = "",

	-- Step 67: Buy Pattern: Wicked Leather Gauntlets · Werg Thickblade
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {npc:12943} Werg Thickblade
	["Buy {item:15725} · {npc:12943}"] = "",

	-- Step 68: Learn Wicked Leather Gauntlets
	-- {spell:19049} Wicked Leather Gauntlets
	["Learn {spell:19049}"] = "",
	["From the pattern in your bags."] = "",

	-- Step 69: Craft 36 Wicked Leather Gauntlets until 265
	-- {item:15083} Wicked Leather Gauntlets
	["Craft 36 {item:15083} until 265"] = "",
	["About 36 crafts."] = "",

	-- Step 70: Get 686 Rugged Leather
	-- {item:8170} Rugged Leather
	["Get 686 {item:8170}"] = "",
	-- plural, as words: Runic Leather Headbands = {item:15094} Runic Leather Headband
	["For 49 Runic Leather Headbands."] = "",

	-- Step 71: Get 490 Runecloth
	-- {item:14047} Runecloth
	["Get 490 {item:14047}"] = "",

	-- Step 72: Buy Pattern: Runic Leather Headband · Jase Farlane
	-- {item:15756} Pattern: Runic Leather Headband · {npc:12941} Jase Farlane
	["Buy {item:15756} · {npc:12941}"] = "",
	-- {area:2268} Light's Hope Chapel
	["At {area:2268}. It binds when picked up."] = "",

	-- Step 73: Learn Runic Leather Headband
	-- {spell:19082} Runic Leather Headband
	["Learn {spell:19082}"] = "",

	-- Step 74: Craft 49 Runic Leather Headbands until 300
	-- plural, as words: Runic Leather Headbands = {item:15094} Runic Leather Headband
	["Craft 49 Runic Leather Headbands until 300"] = "",
	["About 49 crafts. Yellow from 285, green from 295: short of 300? A few more do it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "1029 {item:8170} para {item:15564}, {item:15083} y {item:15094}: {skill:393}: bestias de nivel 48-60. Despelleja aquí a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} y {npc:6377} (nivel 48-60); la guía de {skill:393} marca la ruta.",
	-- ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "1029 {item:8170} para {item:15564}, {item:15083} y {item:15094}: {skill:393}: bestias de nivel 48-60. Despelleja aquí a {npc:8598}, Can de la Peste y {npc:8596} (nivel 48-60); la guía de {skill:393} marca la ruta.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: bestias de nivel 18-30. Despelleja aquí a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384} y {npc:2354} (nivel 18-30); la guía de {skill:393} traza esta ruta.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: bestias de nivel 18-30. Despelleja aquí a {npc:3236} y Cabeza de Trueno (nivel 18-30); la guía de {skill:393} traza esta ruta.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: bestias de nivel 18-30. Despelleja aquí a {npc:3823} y {npc:2071} (nivel 18-30); la guía de {skill:393} traza esta ruta.",
	-- ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "22 {item:4235} para {item:5964} y {item:5966}: {skill:393}: bestias de nivel 28-40. Despelleja aquí a {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} y Quijaforte (nivel 28-40); la guía de {skill:393} marca la ruta.",
	-- ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "22 {item:4235} para {item:5964} y {item:5966}: {skill:393}: bestias de nivel 28-40. Despelleja aquí a {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} y {npc:4142} (nivel 28-40); la guía de {skill:393} marca la ruta.",
	-- ["24 {item:2457} for {item:7285}: {skill:171}: {item:2457}."] = "24 {item:2457} para {item:7285}: {skill:171}: {item:2457}.",
	-- ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "321 {item:4234} para {spell:3780}, {item:5964} y {item:5966} (191 de ellos para 150-225: recógelos todos ahora): {skill:393}: bestias de nivel 28-40. Despelleja aquí a {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} y Quijaforte (nivel 28-40); la guía de {skill:393} marca la ruta.",
	-- ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "321 {item:4234} para {spell:3780}, {item:5964} y {item:5966} (191 de ellos para 150-225: recógelos todos ahora): {skill:393}: bestias de nivel 28-40. Despelleja aquí a {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} y {npc:4142} (nivel 28-40); la guía de {skill:393} marca la ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a Correnubes, Galestrid, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, garraorgullo, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} y {npc:254588} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} y {npc:1128} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} y {npc:1554} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1922}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Desuella {npc:1922}, merodeadores, {npc:524}, {npc:113} y {npc:822} aquí (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:1922}, {npc:525}, Merodeador, {npc:524}, {npc:113} y {npc:822} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:2033}, Sable de la noche y {npc:2043} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} y {npc:2960} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} y {spell:3763} (210 de ellos para 75-150: recógelos todos ahora): {skill:393}: bestias de nivel 5-20. Despelleja aquí a {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} y {npc:3127} (nivel 5-20); la guía de {skill:393} traza esta ruta.",
	-- ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "373 {item:4304} para {item:8176} y {item:8193}: {skill:393}: bestias de nivel 38-50. Despelleja aquí a {npc:2729}, {npc:2730}, {npc:2732} y {npc:2734} (nivel 38-50); la guía de {skill:393} marca la ruta.",
	-- ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "373 {item:4304} para {item:8176} y {item:8193}: {skill:393}: bestias de nivel 38-50. Despelleja aquí a {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} y {npc:5296} (nivel 38-50); la guía de {skill:393} marca la ruta.",
	-- ["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "430 {item:14047} para {item:15094}: lo sueltan los humanoides de nivel 45-60. Guarda lo que despojes mientras subes de nivel o sácalo de tu banco.",
	-- ["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Not every {skill:165} trainer teaches it: Alliance {npc:1632} ({zone:1429}), {npc:11083} ({zone:1457}), {npc:252376} ({zone:2521}), {npc:1466} ({zone:1455}), {npc:251993} ({zone:2521}), {npc:3605} ({zone:1438}) and {npc:11096} ({zone:1453}); Horde {npc:3069} ({zone:1412}), {npc:223} ({zone:1458}), {npc:252376} ({zone:2521}), {npc:251993} ({zone:2521}), {npc:5811} ({zone:1454}), {npc:3008} ({zone:1456}) and {npc:3549} ({zone:1420}). The arrow picks the nearest of your faction. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "{skill:165} de aprendiz te permite fabricar hasta 75 por 10c, a cualquier nivel de personaje. No todos los instructores de {skill:165} lo enseñan: Alianza: {npc:1632} ({zone:1429}), {npc:11083} ({zone:1457}), {npc:252376} ({zone:2521}), {npc:1466} ({zone:1455}), {npc:251993} ({zone:2521}), {npc:3605} ({zone:1438}) y {npc:11096} ({zone:1453}); Horda: {npc:3069} ({zone:1412}), {npc:223} ({zone:1458}), {npc:252376} ({zone:2521}), {npc:251993} ({zone:2521}), {npc:5811} ({zone:1454}), {npc:3008} ({zone:1456}) y {npc:3549} ({zone:1420}). La flecha elige el más cercano de tu facción. Combínala con {skill:393}: el {item:2318} sale de las bestias de todas las zonas iniciales. El {item:2320} y la Sal los venden los mercaderes de suministros de peletería y de objetos comerciables. De 1 a 75 hacen falta unos 1s 50c en recetas y 5s en artículos de mercader, además de 349 {item:2318} que recolectar o comprar.",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "Artesano requiere nivel de personaje 35 y {skill:165} 200; sube el límite a 300. Los materiales de 225 a 300 cuestan en total unos 312 o.",
	-- ["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 225). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1029 {item:8170} and 430 {item:14047} to gather or buy."] = "Artesano sube el tope de 225 a 300; requiere {skill:165} 200 y nivel de personaje 35, así que puedes aprenderlo en cualquier visita a partir de 200. Solo lo enseñan unos pocos instructores: Alianza: {npc:11097} ({zone:1425}); Horda: {npc:11098} ({zone:1444}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:19058} (desde 225). De 225 a 300 hacen falta unos 3g 40s en recetas y 44g 90s en artículos de mercader, además de 1029 {item:8170} y 430 {item:14047} que recolectar o comprar.",
	-- ["Artisan {skill:165}"] = "{skill:165} de artesano",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "Vuelve con un instructor de {skill:165}: {spell:10482} y {spell:14932} se enseñan desde {skill:165} 220.",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "Vuelve con un instructor de {skill:165}: {spell:10487} se enseña desde {skill:165} 195.",
	-- ["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "Vuelve con un instructor de {skill:165}: {spell:3756} (desde 40, 1s 50c). Aprende también {spell:1229432} (1s): el objeto de campamento de {skill:165} de Forever, con 5 {item:2318}, que se coloca en un campamento junto a una hoguera. La misión “Campamento 101: {skill:165}” del guía de campamento de tu zona inicial (después de “Bendita naturaleza”) te envía a un instructor de peletería que lo enseña gratis.",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "Vuelve con un instructor de {skill:165}: {spell:3763} se enseña desde {skill:165} 85.",
	-- ["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "Vuelve con un instructor de {skill:165}: {spell:3780} (desde 125, 7 p 50 c).",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "Vuelve con un instructor de {skill:165}: {spell:3817} y {spell:3768} se enseñan desde {skill:165} 130.",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "Vuelve con un instructor de {skill:165}: {spell:7151} se enseña desde {skill:165} 170.",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "Vuelve con un instructor de {skill:165}: {spell:7156} se enseña desde {skill:165} 185.",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "Vuelve con un instructor de {skill:165}: {spell:9062} se enseña desde {skill:165} 55.",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "Vuelve con un instructor de {skill:165}: {spell:9068} se enseña desde {skill:165} 100.",
	-- ["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "Vuelve con un instructor de {skill:165}: {spell:9074} (desde 95, 5 p).",
	-- ["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 66 Salt (33s) and 145 {item:4291} (7g 25s); about 7g 87s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 29 {item:2321} (29s), 66 de Sal (33s) y 145 {item:4291} (7g 25s); unos 7g 87s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} y {npc:5817}).",
	-- ["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 39 {item:2325} (3g 90s) y 82 {item:14341} (41g); unos 44g 90s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} y {npc:5817}).",
	-- ["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 50 {item:2320} (5s); unos 5s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} y {npc:5817}).",
	-- ["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 70 {item:2320} (7s) y 50 {item:2321} (50s); unos 57s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} y {npc:5817}).",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "Experto requiere nivel de personaje 20 y {skill:165} 125; sube el límite a 225. Los materiales de 150 a 225 cuestan en total unos 61 o.",
	-- ["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4212} ({zone:1457}); Horde {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3818} (from 125, 5s) and {spell:7151} (from 150). 150-225 takes about 5s of recipes and 7g 87s of vendor goods, plus 22 {item:4235} and 373 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:5966} (from 165) and {item:8176} (from 180), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8193} (from 210) takes a second trip, to other trainers (below)."] = "Experto sube el tope de 150 a 225; requiere {skill:165} 125 y nivel de personaje 20, así que puedes aprenderlo en cualquier visita a partir de 125. Solo lo enseñan unos pocos instructores: Alianza: {npc:4212} ({zone:1457}); Horda: {npc:3007} ({zone:1456}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:3818} (desde 125, 5s) y {spell:7151} (desde 150). De 150 a 225 hacen falta unos 5s en recetas y 7g 87s en artículos de mercader, además de 22 {item:4235} y 373 {item:4304} que recolectar o comprar. Ven con todo en las bolsas (los pasos de arriba; el resto, de la casa de subastas): estos instructores también enseñan {item:5966} (desde 165) y {item:8176} (desde 180), y las fabricaciones no necesitan estación, así que fabrica aquí mismo y aprende cada receta al alcanzar su habilidad. Un viaje en lugar de 3. {item:8193} (desde 210) requiere un segundo viaje, a otros instructores (más abajo).",
	-- ["Expert {skill:165}"] = "{skill:165} de experto",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "Oficial requiere nivel de personaje 10 y {skill:165} 50; sube el límite a 150. Los materiales de 75 a 150 cuestan en total unos 11 o.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:252376} ({zone:2521}), {npc:11081} ({zone:1457}), {npc:5127} ({zone:1455}) and {npc:5564} ({zone:1453}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}) and {npc:11084} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 321 {item:4234} to gather or buy."] = "Oficial sube el tope de 75 a 150 por 5s; requiere {skill:165} 50 y nivel de personaje 10, así que puedes aprenderlo en cualquier visita a partir de 50. No todos los instructores de {skill:165} lo enseñan: Alianza: {npc:3967} ({zone:1440}), {npc:252376} ({zone:2521}), {npc:11081} ({zone:1457}), {npc:5127} ({zone:1455}) y {npc:5564} ({zone:1453}); Horda: {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}) y {npc:11084} ({zone:1456}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:3763} (desde 55, 3s). De 75 a 150 hacen falta unos 15s 50c en recetas y 57s en artículos de mercader, además de 144 {item:2319}, 24 {item:2457} y 321 {item:4234} que recolectar o comprar.",
	-- ["Journeyman {skill:165}"] = "{skill:165} de oficial",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "Naranja (un punto con cada fabricación) hasta 155, amarillo hasta 165 y verde hasta 175.",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "Naranja (un punto con cada fabricación) hasta 205, amarillo hasta 215 y verde hasta 225.",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "Naranja (un punto con cada fabricación) hasta 255, amarillo hasta 265 y verde hasta 275.",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "Naranja (un punto con cada fabricación) hasta 285, amarillo hasta 295 y verde hasta 305. {skill:165} 300 es un hito del sistema de Legado.",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "Naranja (un punto con cada fabricación) hasta 30, amarillo hasta 45 y verde hasta 60.",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} aquí (las bestias de nivel 5-20 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:1815}, {npc:1816}, {npc:1817} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Quijaforte aquí (las bestias de nivel 28-40 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384}, {npc:2354} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} aquí (las bestias de nivel 5-20 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} aquí (las bestias de nivel 28-40 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú o cómpralos en la casa de subastas.",
	-- ["Still at the Expert trainer: {spell:10507} (from 180)."] = "Todavía con el instructor de Experto: {spell:10507} (desde 180).",
	-- ["Still at the Expert trainer: {spell:10548} (from 210)."] = "Todavía con el instructor de Experto: {spell:10548} (desde 210).",
	-- ["Still at the Expert trainer: {spell:7156} (from 165)."] = "Todavía con el instructor de Experto: {spell:7156} (desde 165).",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "Enseña {item:15083} (requiere {skill:165} 235). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "Enseña {item:15094} (requiere {skill:165} 265). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "Enseña {item:252452} (requiere {skill:165} 135).",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "Enseña {item:252463} (requiere {skill:165} 185).",
	-- ["What 1-75 takes that the Auction House sells: 349 {item:2318}. The counts drop by what your bags, bank and mail hold."] = "Lo que necesitas para el tramo 1-75 y vende la casa de subastas: 349 {item:2318}. Las cantidades bajan según lo que tengas en las bolsas, el banco y el correo.",
	-- ["What 150-225 takes that the Auction House sells: 22 {item:4235} and 373 {item:4304}. The counts drop by what your bags, bank and mail hold."] = "Lo que necesitas para el tramo 150-225 y vende la casa de subastas: 22 {item:4235} y 373 {item:4304}. Las cantidades bajan según lo que tengas en las bolsas, el banco y el correo.",
	-- ["What 225-300 takes that the Auction House sells: 1029 {item:8170} and 430 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "Lo que necesitas para el tramo 225-300 y vende la casa de subastas: 1029 {item:8170} y 430 {item:14047}. Las cantidades bajan según lo que tengas en las bolsas, el banco y el correo.",
	-- ["What 75-150 takes that the Auction House sells: 144 {item:2319}, 24 {item:2457} and 321 {item:4234}. The counts drop by what your bags, bank and mail hold."] = "Lo que necesitas para el tramo 75-150 y vende la casa de subastas: 144 {item:2319}, 24 {item:2457} y 321 {item:4234}. Las cantidades bajan según lo que tengas en las bolsas, el banco y el correo.",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "Amarillo hasta 100 y verde hasta 115: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "Amarillo hasta 115 y verde hasta 130: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "Amarillo hasta 132 y verde hasta 145: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "Amarillo hasta 142 y verde hasta 155: no todas las fabricaciones dan un punto. {skill:165} 150 es un hito del sistema de Legado.",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "Amarillo hasta 180 y verde hasta 190: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "Amarillo hasta 185 y verde hasta 195: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "Amarillo hasta 195 y verde hasta 205: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "Amarillo hasta 230 y verde hasta 240: no todas las fabricaciones dan un punto. {skill:165} 225 es un hito del sistema de Legado.",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "Amarillo hasta 235 y verde hasta 245: no todas las fabricaciones dan un punto.",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 70 y verde hasta 85: no todas las fabricaciones dan un punto. 75 es el límite de aprendiz.",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "Amarillo hasta 85 y verde hasta 100: no todas las fabricaciones dan un punto.",
	-- ["from the recipe in your bags"] = "con la receta de tus bolsas",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- ["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "{item:15083} es naranja a 239 (amarillo 255, verde 265, gris 275): unas 39 fabricaciones hasta 269. Cada una lleva 8 {item:8170}, 1 {item:2325} y 1 {item:14341}. Ocho {item:8170} por fabricación; {item:2325} y {item:14341}, de los mercaderes de peletería o sastrería.",
	-- ["{item:15083} to 269"] = "{item:15083} hasta 269",
	-- ["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "{item:15094} es naranja a 269 (amarillo 285, verde 295, gris 305): unas 43 fabricaciones hasta 300. Cada una lleva 14 {item:8170}, 10 {item:14047} y 1 {item:14341}. 14 {item:8170} y 10 {item:14047} por fabricación: el tramo más caro. {skill:165} 300 es un hito del Sistema de Legado.",
	-- ["{item:15094} to 300"] = "{item:15094} hasta 300",
	-- ["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "{item:15564} es amarillo a 225 (amarillo 225, verde 235, gris 245): unas 23 fabricaciones hasta 239. Cada una lleva 5 {item:8170}. Cinco {item:8170} por fabricación. Especialización (opcional): a 225 y nivel de personaje 40. Peletería dragontina: {npc:7866} ({zone:1447}) o {npc:7867} ({zone:1418}) pide 2 Corazas de escórpido resistentes, 2 {item:8204} (los patrones los sueltan los bandidos Deambuladores de {zone:1446}) y 10 {item:8165}. Peletería elemental: {npc:7868} ({zone:1427}) o {npc:7869} ({zone:1417}) pide 2 de cada uno: {item:7077}, {item:7079}, {item:7075} y {item:7081}. Peletería tribal (desde 235): {npc:7870} ({zone:1444}) o {npc:7871} ({zone:1434}) pide un {item:8211} y el Casco, después de las misiones de cuero salvaje de {npc:7852} o {npc:7854} en {zone:1444}. En Forever, los patrones de especialización necesitan un {item:279941}. Solo puedes elegir una; ninguna hace falta para llegar a 300, y la beta nunca las probó (se detuvo en el nivel 30).",
	-- ["{item:15564} to 239"] = "{item:15564} hasta 239",
	-- ["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15725} enseña {item:15083} ({skill:165} 235) por 1g 20s. Lo venden: Alianza: {npc:12942} ({zone:1422}), existencias limitadas; Horda: {npc:12943} ({zone:1422}), existencias limitadas. Sus vendedores tienen una o dos en existencia, que se reponen un tiempo después de cada venta; se liga al recogerla, así que la casa de subastas nunca la tiene.",
	-- ["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15756} enseña {item:15094} ({skill:165} 265) por 2g 20s. Lo venden {npc:12941} ({zone:1423}), con existencias limitadas. Sus vendedores tienen una o dos en existencia, que se reponen un tiempo después de cada venta; se liga al recogerla, así que la casa de subastas nunca la tiene.",
	-- ["{item:2318} (Alliance)"] = "{item:2318} (Alianza)",
	-- ["{item:2318} (Horde)"] = "{item:2318} (Horda)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- ["{item:252452} to 170"] = "{item:252452} hasta 170",
	-- ["{item:252463} to 220"] = "{item:252463} hasta 220",
	-- ["{item:4232} (Alliance)"] = "{item:4232} (Alianza)",
	-- ["{item:4232} (Horde)"] = "{item:4232} (Horda)",
	-- ["{item:4234} (Alliance)"] = "{item:4234} (Alianza)",
	-- ["{item:4234} (Horde)"] = "{item:4234} (Horda)",
	-- ["{item:4235} (Alliance)"] = "{item:4235} (Alianza)",
	-- ["{item:4235} (Horde)"] = "{item:4235} (Horda)",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Alianza)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- ["{item:5964} is orange at 158 (yellow 170, green 180, grey 190): about 7 crafts to 165, a point every craft. Each takes 8 {item:4234}, 1 {spell:3818} and 2 {item:2321}. Make the 7 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:5964} es naranja a 158 (amarillo 170, verde 180, gris 190): unas 7 fabricaciones hasta 165, un punto por fabricación. Cada una lleva 8 {item:4234}, 1 {spell:3818} y 2 {item:2321}. Haz primero los 7 {spell:3818}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos.",
	-- ["{item:5964} to 165"] = "{item:5964} hasta 165",
	-- ["{item:5964} to 175"] = "{item:5964} hasta 175",
	-- ["{item:5966} is orange at 165 (yellow 185, green 195, grey 205): about 15 crafts to 180, a point every craft. Each takes 4 {item:4234}, 1 {spell:3818} and 1 {item:4291}. Make the 15 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:5966} es naranja a 165 (amarillo 185, verde 195, gris 205): unas 15 fabricaciones hasta 180, un punto por fabricación. Cada una lleva 4 {item:4234}, 1 {spell:3818} y 1 {item:4291}. Haz primero los 15 {spell:3818}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos.",
	-- ["{item:5966} to 180"] = "{item:5966} hasta 180",
	-- ["{item:5966} to 195"] = "{item:5966} hasta 195",
	-- ["{item:7279} to 75"] = "{item:7279} hasta 75",
	-- ["{item:7282} to 120"] = "{item:7282} hasta 120",
	-- ["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all."] = "{item:7285} es naranja a 102 (amarillo 120, verde 132, gris 145): unas 24 fabricaciones hasta 125. Cada una lleva 1 {item:2457}, 6 {item:2319} y 1 {item:2321}. Cada una lleva un {item:2457}: un alquimista lo hace con una {item:2452} y una {item:765}, y en la casa de subastas está barato. Sin elixires, sigue con {spell:3763} hasta 105 y {item:2316} (desde 85: 8 {item:2319}, un {item:4340} y un {item:2321}) hasta 125: unas 28 capas, 224 {item:2319} en total.",
	-- ["{item:7285} to 125"] = "{item:7285} hasta 125",
	-- ["{item:783} (Alliance)"] = "{item:783} (Alianza)",
	-- ["{item:783} (Horde)"] = "{item:783} (Horda)",
	-- ["{item:8150} (Alliance)"] = "{item:8150} (Alianza)",
	-- ["{item:8150} (Horde)"] = "{item:8150} (Horda)",
	-- ["{item:8169} (Alliance)"] = "{item:8169} (Alianza)",
	-- ["{item:8169} (Horde)"] = "{item:8169} (Horda)",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- ["{item:8176} is orange at 180 (yellow 200, green 210, grey 220): about 41 crafts to 213. Each takes 5 {item:4304} and 2 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:8176} es naranja a 180 (amarillo 200, verde 210, gris 220): unas 41 fabricaciones hasta 213. Cada una lleva 5 {item:4304} y 2 {item:4291}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos.",
	-- ["{item:8176} to 213"] = "{item:8176} hasta 213",
	-- ["{item:8193} is orange at 213 (yellow 225, green 235, grey 245): about 12 crafts to 225, a point every craft. Each takes 14 {item:4304} and 4 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:165} 225 is a Legacy System milestone."] = "{item:8193} es naranja a 213 (amarillo 225, verde 235, gris 245): unas 12 fabricaciones hasta 225, un punto por fabricación. Cada una lleva 14 {item:4304} y 4 {item:4291}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos. {skill:165} 225 es un hito del sistema de Legado.",
	-- ["{item:8193} to 225"] = "{item:8193} hasta 225",
	-- ["{item:8218} to 225"] = "{item:8218} hasta 225",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "Cada {npc:11746} (nivel 56-58) puede soltarlo aquí. También sirve la casa de subastas.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Cada {npc:6189} (nivel 51-52) puede soltarlo aquí. También sirve la casa de subastas.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Cada {npc:7027} (nivel 56-57) puede soltarlo aquí. También sirve la casa de subastas.",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "Cada {npc:92} (nivel 39-40) puede soltarlo aquí. También sirve la casa de subastas.",
	-- ["{skill:165} 1-75: Auction House"] = "{skill:165} 1-75: casa de subastas",
	-- ["{skill:165} 1-75: vendor goods"] = "{skill:165} 1-75: artículos de mercader",
	-- ["{skill:165} 150-225: Auction House"] = "{skill:165} 150-225: casa de subastas",
	-- ["{skill:165} 150-225: vendor goods"] = "{skill:165} 150-225: artículos de mercader",
	-- ["{skill:165} 225-300: Auction House"] = "{skill:165} 225-300: casa de subastas",
	-- ["{skill:165} 225-300: vendor goods"] = "{skill:165} 225-300: artículos de mercader",
	-- ["{skill:165} 75-150: Auction House"] = "{skill:165} 75-150: casa de subastas",
	-- ["{skill:165} 75-150: vendor goods"] = "{skill:165} 75-150: artículos de mercader",
	-- ["{skill:165} materials for 150-225"] = "Materiales de {skill:165} para 150-225",
	-- ["{skill:165} materials for 75-150"] = "Materiales de {skill:165} para 75-150",
	-- ["{skill:165} recipes at 102"] = "Recetas de {skill:165} a 102",
	-- ["{skill:165} recipes at 125"] = "Recetas de {skill:165} a 125",
	-- ["{skill:165} recipes at 130"] = "Recetas de {skill:165} a 130",
	-- ["{skill:165} recipes at 165"] = "Recetas de {skill:165} a 165",
	-- ["{skill:165} recipes at 170"] = "Recetas de {skill:165} a 170",
	-- ["{skill:165} recipes at 175"] = "Recetas de {skill:165} a 175",
	-- ["{skill:165} recipes at 180"] = "Recetas de {skill:165} a 180",
	-- ["{skill:165} recipes at 185"] = "Recetas de {skill:165} a 185",
	-- ["{skill:165} recipes at 195"] = "Recetas de {skill:165} a 195",
	-- ["{skill:165} recipes at 213"] = "Recetas de {skill:165} a 213",
	-- ["{skill:165} recipes at 220"] = "Recetas de {skill:165} a 220",
	-- ["{skill:165} recipes at 51"] = "Recetas de {skill:165} a 51",
	-- ["{skill:165} recipes at 85"] = "Recetas de {skill:165} a 85",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165} avanza a la vez que subes de nivel. El sistema de Legado de Forever recompensa las profesiones de fabricación a 150, 225 y 300 de habilidad (los límites de oficial, experto y artesano), así que cuenta cada uno de esos hitos. Los materiales de 1 a 75 cuestan en total unos 1 o 18 p.",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}: {item:2457} (o la casa de subastas)",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}: {item:3389} (o la casa de subastas)",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}: {spell:3188} (o la casa de subastas)",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: desencanta equipo poco común (verde) (o la casa de subastas)",
	-- ["{spell:10548} (from 210) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "{spell:10548} (desde 210) solo lo enseñan los instructores de artesano: Alianza, {npc:11097} ({zone:1425}); Horda, {npc:11098} ({zone:1444}). Si eres de nivel 35, puedes aprender artesano allí ahora (requiere {skill:165} 200), lo que te ahorra el viaje a 225.",
	-- ["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "{spell:2152} es naranja a 1 (amarillo 30, verde 45, gris 60): unas 64 fabricaciones hasta 51. Cada una lleva 1 {item:2318}. Un {item:2318} por fabricación; los kits se venden a los mercaderes.",
	-- ["{spell:2152} to 51"] = "{spell:2152} hasta 51",
	-- ["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "{spell:3756} es naranja a 51 (amarillo 70, verde 85, gris 100): unas 25 fabricaciones hasta 75. Cada una lleva 3 {item:2318} y 2 {item:2320}. En Forever, {spell:3756} se enseña desde 40.",
	-- ["{spell:3756} to 75"] = "{spell:3756} hasta 75",
	-- ["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "{spell:3763} es naranja a 75 (amarillo 85, verde 100, gris 115): unas 35 fabricaciones hasta 102. Cada una lleva 6 {item:2318} y 2 {item:2320}. En Forever, {spell:3763} se enseña desde 55.",
	-- ["{spell:3763} to 102"] = "{spell:3763} hasta 102",
	-- ["{spell:3768} to 150"] = "{spell:3768} hasta 150",
	-- ["{spell:3776} to 185"] = "{spell:3776} hasta 185",
	-- ["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "{spell:3780} es naranja a 125 (amarillo 145, verde 155, gris 165): unas 26 fabricaciones hasta 150. Cada una lleva 5 {item:4234} y 1 {item:2321}. Cinco {item:4234} por fabricación (bestias de nivel 28-40); los kits se venden a los mercaderes. {skill:165} 150 es un hito del Sistema de Legado.",
	-- ["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "{spell:3780} es amarillo a 150 (amarillo 145, verde 155, gris 165): unas 15 fabricaciones hasta 158. Cada una lleva 5 {item:4234} y 1 {item:2321}. Cinco {item:4234} por fabricación (bestias de nivel 28-40); los kits se venden a los mercaderes.",
	-- ["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. If you got here without learning {spell:3780}, learn it now: an earlier step teaches it."] = "{spell:3780} es amarillo en 150 (amarillo 145, verde 155, gris 165): unas 15 fabricaciones hasta 158. Cada una lleva 5 {item:4234} y 1 {item:2321}. Cinco {item:4234} por fabricación (bestias de nivel 28-40); los kits se venden a mercaderes. Si llegaste aquí sin aprender {spell:3780}, apréndelo ahora: lo enseña un paso anterior.",
	-- ["{spell:3780} to 150"] = "{spell:3780} hasta 150",
	-- ["{spell:3780} to 158"] = "{spell:3780} hasta 158",
}
