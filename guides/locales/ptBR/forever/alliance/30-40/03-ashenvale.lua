-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, lá dentro",

	-- Step 2: Dartol's Rod
	["Dartol's Rod"] = "Bastão de Transformação de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Os Ancientes Enlouquecidos e Ancientes Fenescidos ao norte do poço lunar carregam a {item:5475}; o baú gasto que ela abre fica entre eles.",

	-- Step 3: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Pegue o túnel para {area:419}; o tomo está nas ruínas no extremo oeste.",

	-- Step 5: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Siga a estrada para leste até os acampamentos de sátiros de {area:429}; {npc:3920} se esconde na borda deles.",

	-- Step 6: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera os sátiros de {area:429}; ele carrega o galho.",

	-- Step 7: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} fica lá.",

	-- Step 8: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}: vá matando estes pelo caminho",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "O acampamento dos Renegados fica na mata ao sul de {area:2358}.\nBaús enferrujados ficam em volta dos acampamentos furbolg Umbrárvore a oeste dos Renegados; abra até achar o do pomo.\nCuidado: Renegados não elite de nível 28-30 guardam o acampamento. Alguns estão furtivos, e os que ficam em volta da mesa costumam vir juntos.",

	-- Step 9: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "O {npc:3931} anda pela margem do {quest:1035}, a sudoeste dos baús; o {object:669176} está ao norte do lago, no caminho.\nCuidado: outros monstros, alguns debaixo d'água, ficam perto da ilha. Limpe-os antes para não entrarem na briga quando você puxar o Oráculo.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} em {area:415}",

	-- Step 11: Insane druids
	["Insane druids"] = "Druidas enlouquecidos",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Os três druidas ficam juntos no acampamento dos Renegados ao sul de {area:2358}.\nCuidado: o covil tem muitos monstros que renascem rápido, incluindo mortos-vivos furtivos e patrulhas, então é comum vir monstro a mais.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, dentro de {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, dentro de {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, dentro de {area:432}",

	-- Step 12: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "O {object:19901} fica no acampamento dos sátiros em {area:430}, mais a leste pela estrada.\nCuidado: os Ladinos Malmíscar de {area:428} costumam ficar furtivos, e {area:430} tem sátiros lançadores de feitiço.",

	-- Step 14: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "O segundo {object:19901} fica no vale de {area:428}, no caminho para oeste.",

	-- Step 16: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "O santuário fica na colina logo a sudeste do poço lunar; suba pela trilha sinuosa.",

	-- Step 19: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, um furbolg intocado pela corrupção, fica ao sul da estrada abaixo de {area:421}.",

	-- Step 20: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} e os guardas dele acampam logo a leste de {npc:3897}.\nCuidado: lobos e aranhas andam perto do acampamento e podem entrar na briga. Alguns lobos andam em dupla.",

	-- Step 22: Hearth to Astranaar
	-- {area:415} Astranaar
	["Hearth to {area:415}"] = "Pedra de Regresso para {area:415}",

	-- Step 25: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",

	-- Step 27: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Mestre de voo de {area:415}",

	-- Step 28: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 29: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} fica no andar de cima da fortaleza de Menethil.",
	["Inside"] = "Lá dentro",

	-- Step 31: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Os destroços do Flying Osprey estão na água rasa ao sul da fortaleza.",

	-- Step 32: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lingotes da Forja de Luz",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Os murlocs Guelrazul na praia a sudoeste de Menethil carregam os lingotes.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702}; debaixo d'água",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Volte para oeste pela estrada até os acampamentos de sátiros de {area:429}.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Siga a estrada para oeste saindo de {area:415}; {area:413} fica ao norte dela.",
	-- ["From {area:608}"] = "De {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Druidas insanos",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Baús Enferrujados ficam em volta dos acampamentos furbolgs Umbrárvore a oeste dos Renegados; abra-os até um conter o Castão de Ferro.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Pegue o barco para {area:150} nas docas de {area:442}.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "O acampamento dos Renegados fica na mata ao sul de {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "O poço lunar fica nas colinas a nordeste de {area:415}.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Os três druidas ficam juntos no acampamento dos Renegados ao sul de {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "As duas ficam juntas no extremo oeste da estrada.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "O navio naufragado está nas águas rasas ao sul da fortaleza.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "O {npc:3931} anda pela margem de {quest:1035}, a sudoeste dos baús; o {object:669176} está ao norte do lago, no caminho.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901} fica no acampamento de sátiros de {area:430}, mais a leste pela estrada.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} e {npc:221269} ficam lá.",
	-- ["{area:429} satyrs"] = "Sátiros de {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} fica no andar de cima da fortaleza de Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} e seus guardas acampam logo a leste de {npc:3897}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: para {npc:1480} em Menethil, no fim deste guia",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} e {npc:4962} estão todos na estalagem de Menethil; Tapoke luta com você quando você fala com {npc:4963}, mas desiste quando derrotado. {npc:1480} fica a uma curta caminhada a nordeste da estalagem.",
}
