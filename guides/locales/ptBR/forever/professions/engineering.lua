-- Portuguese (Brazil) (ptBR): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "{skill:202} (Aprendiz)",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} avança junto com o nivelamento. O Sistema de Legado do Forever recompensa profissões de criação nas perícias 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 62s no total.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: uma ferramenta, mantenha-a nas bolsas",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mate os monstros que o derrubam no local de coleta que o Polestar escolhe para seu nível e facção. A Casa de Leilões também serve.",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Aliança)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} vem de jazidas de {object:1731} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horda)",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "Materiais de {skill:202} para 1-75",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Vêm de esfolar, desencantar ou de outra profissão: colete você mesmo ou compre na Casa de Leilões.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funda {item:2770} (ou a Casa de Leilões)",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "{spell:3918} até 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Laranja (um ponto a cada criação) até 20, amarelo até 30, verde até 40.",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "{spell:3920} até 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "Amarelo até 45, verde até 60: nem toda criação dá ponto.",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "Receitas de {skill:202} em 45",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Volte a um instrutor de {skill:202}: {spell:3922} é ensinado a partir de {skill:202} 45.",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "{spell:3922} até 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 52, verde até 60: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "Receitas de {skill:202} em 60",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Volte a um instrutor de {skill:202}: {spell:3923} é ensinado a partir de {skill:202} 60.",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "{spell:3923} até 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Amarelo até 75, verde até 90: nem toda criação dá ponto. Exige uma bigorna por perto. 75 é o limite de Aprendiz.",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} (Profissional)",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Profissional exige nível de personagem 10 e {skill:202} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 3g 23s no total.",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Aliança)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Mate {npc:98} (nível 17-18) aqui para obtê-lo. A Casa de Leilões também serve.",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Mate {npc:3263} (nível 19-20) aqui para obtê-lo. A Casa de Leilões também serve.",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Aliança)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} vem de jazidas de {object:1732} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horda)",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Aliança)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} vem de jazidas de {object:1735} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horda)",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "Materiais de {skill:202} para 75-150",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funda {item:2840} (ou a Casa de Leilões)",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "{spell:3923} até 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 75, verde até 90: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "Receitas de {skill:202} em 80",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Volte a um instrutor de {skill:202}: {spell:3924} é ensinado a partir de {skill:202} 80.",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "{spell:3924} até 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 95, verde até 110: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "Receitas de {skill:202} em 85",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Volte a um instrutor de {skill:202}: {spell:3929} é ensinado a partir de {skill:202} 85.",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "{spell:3929} até 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "Amarelo até 90, verde até 95: nem toda criação dá ponto.",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "Receitas de {skill:202} em 95",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Volte a um instrutor de {skill:202}: {spell:3926} é ensinado a partir de {skill:202} 95.",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "{spell:3926} até 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 110, verde até 125: nem toda criação dá ponto. Exige uma bigorna por perto.",
	["a tool: keep it in your bags"] = "uma ferramenta: mantenha-a nas bolsas",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "Receitas de {skill:202} em 111",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Volte a um instrutor de {skill:202}: {spell:3937} é ensinado a partir de {skill:202} 105.",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "{spell:3937} até 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 130, verde até 155: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Receitas de {skill:202} em 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Volte a um instrutor de {skill:202}: {spell:3945} é ensinado a partir de {skill:202} 125.",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "{spell:3945} até 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "Amarelo até 135, verde até 145: nem toda criação dá ponto.",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "Receitas de {skill:202} em 139",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Volte a um instrutor de {skill:202}: {spell:3942} é ensinado a partir de {skill:202} 125.",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "{spell:3942} até 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Amarelo até 150, verde até 175: nem toda criação dá ponto. Exige uma bigorna por perto. {skill:202} 150 é um marco do Sistema de Legado.",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202} (Perito)",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Perito exige nível de personagem 20 e {skill:202} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 15g no total.",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Aliança)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384}, {npc:2354} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Aliança)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} vem de jazidas de {object:2040} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horda)",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "Materiais de {skill:202} para 150-225",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funda {item:3575} (ou a Casa de Leilões)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funda {item:3858} (ou a Casa de Leilões)",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} até 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "Amarelo até 170, verde até 195: nem toda criação dá ponto.",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Receitas de {skill:202} em 175",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Volte a um instrutor de {skill:202}: {spell:12590} é ensinado a partir de {skill:202} 175.",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "{item:10498} até 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 195, verde até 215: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Receitas de {skill:202} em 210",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Volte a um instrutor de {skill:202}: {spell:12585}, {spell:12596} são ensinados a partir de {skill:202} 210.",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} até 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Amarelo até 230, verde até 250: nem toda criação dá ponto. Exige uma bigorna por perto. {skill:202} 225 é um marco do Sistema de Legado.",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202} (Artífice)",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Artífice exige nível de personagem 35 e {skill:202} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 67g no total.",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Ensina {item:15994} (exige {skill:202} 260). Mercadores vendem em estoque limitado que se renova; a Casa de Leilões também costuma ter.",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Ensina {item:16000} (exige {skill:202} 275). Mercadores vendem em estoque limitado que se renova; a Casa de Leilões também costuma ter.",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Aliança)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Mate {npc:7027} (nível 56-57) aqui para obtê-lo. A Casa de Leilões também serve.",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Mate {npc:6189} (nível 51-52) aqui para obtê-lo. A Casa de Leilões também serve.",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "Materiais de {skill:202} para 225-300",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funda {item:10620} (ou a Casa de Leilões)",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} até 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 230, verde até 250: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Receitas de {skill:202} em 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Volte a um instrutor de {skill:202}: {spell:12621} é ensinado a partir de {skill:202} 245.",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "{item:10513} até 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 265, verde até 285: nem toda criação dá ponto. Exige uma bigorna por perto.",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "{item:15994} até 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Laranja (um ponto a cada criação) até 280, amarelo até 290, verde até 300. Exige uma bigorna por perto.",
	["from the recipe in your bags"] = "pela receita nas suas bolsas",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} até 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Laranja (um ponto a cada criação) até 295, amarelo até 305, verde até 315. Exige uma bigorna por perto. {skill:202} 300 é um marco do Sistema de Legado.",
}
