-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} e {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} (new in Forever) at 20. Free, no objectives."] = "As magias do sacerdote morto-vivo: {spell:2652} no nível 10, {quest:5644} (nova no Forever) no 20. De graça, sem objetivos.",

	-- Step 1: Touch of Weakness: Tai'jin
	-- {zone:1411} Durotar · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1411}, {npc:3706}, the priest trainer inside the barracks of {area:362}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "No nível 10, em {zone:1411}, {npc:3706}, o instrutor de sacerdote dentro do quartel de {area:362}, entrega uma carta de {spell:2652} para {npc:4606}, na {zone:1458}.",
	-- {npc:3706} Tai'jin · {spell:2652} Touch of Weakness
	["{npc:3706}: take his {spell:2652} letter"] = "{npc:3706}: pegue a carta de {spell:2652} dele",

	-- Step 2: Touch of Weakness: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words) · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity · {zone:1420} Tirisfal Glades
	["At 10 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}. The zeppelin to {zone:1420} leaves from the tower outside {zone:1454}'s front gate."] = "No nível 10, em {zone:1454}, {npc:6018}, no {object:172961}, entrega uma carta de {spell:2652} para {npc:4606}, na {zone:1458}. O zepelim para {zone:1420} sai da torre fora do portão da frente de {zone:1454}.",
	-- {npc:6018} Ur'kyo · {spell:2652} Touch of Weakness
	["{npc:6018}: take his {spell:2652} letter"] = "{npc:6018}: pegue a carta de {spell:2652} dele",

	-- Step 3: Touch of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "No nível 10, em {zone:1412}, {npc:11407}, logo a sudoeste de {area:222}, entrega uma carta de {spell:2652} para {npc:4606}, na {zone:1458}.",
	-- {npc:11407} Var'jun · {spell:2652} Touch of Weakness
	["{npc:11407}: take the {spell:2652} letter"] = "{npc:11407}: pegue a carta de {spell:2652}",

	-- Step 4: Touch of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "No nível 10, em {zone:1456}, {npc:3044}, o instrutor de sacerdote na caverna embaixo de {area:1640}, entrega uma carta de {spell:2652} para {npc:4606}, na {zone:1458}.",
	-- {npc:3044} Miles Welsh · {spell:2652} Touch of Weakness
	["{npc:3044}: take his {spell:2652} letter"] = "{npc:3044}: pegue a carta de {spell:2652} dele",

	-- Step 5: Touch of Weakness: Aelthalyste
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {quest:5658} Touch of Weakness · {area:159} Brill
	["At 10, go to {npc:4606}, the priest trainer in the {zone:1458}'s {object:36070}: she gives {quest:5658} and takes it back at once. No letter needed. From {area:159}, follow the road south to the ruined city of Lordaeron; the {zone:1458}'s lifts are at the back of the throne room. {quest:5658} strikes the next melee attacker for Shadow damage and lowers its melee attack power for 2 minutes."] = "No nível 10, vá até {npc:4606}, a instrutora de sacerdote no {object:36070} da {zone:1458}: ela dá {quest:5658} e pega de volta na hora. Não precisa de carta. De {area:159}, siga a estrada para o sul até a cidade em ruínas de Lordaeron; os elevadores da {zone:1458} ficam no fundo do salão do trono. {quest:5658} atinge o próximo atacante corpo a corpo com dano de Sombra e reduz o poder de ataque corpo a corpo dele por 2 minutos.",

	-- Step 6: Touch of Weakness: Tai'jin's letter
	-- {quest:5660} Touch of Weakness · {npc:3706} Tai'jin
	["{quest:5660}: {npc:3706}'s letter"] = "{quest:5660}: a carta de {npc:3706}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}, a short walk from the {zone:1458}."] = "Entregue a carta a {npc:4606} no {object:36070} da {zone:1458}: o zepelim da torre fora de {zone:1454} pousa em {zone:1420}, a uma curta caminhada da {zone:1458}.",

	-- Step 7: Touch of Weakness: Var'jun's letter
	-- {quest:5661} Touch of Weakness · {npc:11407} Var'jun
	["{quest:5661}: {npc:11407}'s letter"] = "{quest:5661}: a carta de {npc:11407}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: travel to {zone:1454} and take the zeppelin to {zone:1420}."] = "Entregue a carta a {npc:4606} no {object:36070} da {zone:1458}: vá até {zone:1454} e pegue o zepelim para {zone:1420}.",

	-- Step 8: Touch of Weakness: Ur'kyo's letter
	-- {quest:5662} Touch of Weakness · {npc:6018} Ur'kyo
	["{quest:5662}: {npc:6018}'s letter"] = "{quest:5662}: a carta de {npc:6018}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}."] = "Entregue a carta a {npc:4606} no {object:36070} da {zone:1458}: o zepelim da torre fora de {zone:1454} pousa em {zone:1420}.",

	-- Step 9: Touch of Weakness: Miles Welsh's letter
	-- {quest:5663} Touch of Weakness · {npc:3044} Miles Welsh
	["{quest:5663}: {npc:3044}'s letter"] = "{quest:5663}: a carta de {npc:3044}",

	-- Step 10: Dark Sacrifice: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words) · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "No nível 20, em {zone:1454}, {npc:6018}, no {object:172961}, entrega uma carta de {quest:5644} para {npc:4606}, na {zone:1458}.",
	-- {npc:6018} Ur'kyo · {quest:5644} Dark Sacrifice
	["{npc:6018}: take his {quest:5644} letter"] = "{npc:6018}: pegue a carta de {quest:5644} dele",

	-- Step 11: Dark Sacrifice: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "No nível 20, em {zone:1456}, {npc:3044}, na caverna embaixo de {area:1640}, entrega uma carta de {quest:5644} para {npc:4606}, na {zone:1458}.",
	-- {npc:3044} Miles Welsh · {quest:5644} Dark Sacrifice
	["{npc:3044}: take his {quest:5644} letter"] = "{npc:3044}: pegue a carta de {quest:5644} dele",

	-- Step 12: Dark Sacrifice: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words) · {quest:5644} Dark Sacrifice · {spell:2944} Devouring Plague
	["At 20, {npc:4606} in the {object:36070} teaches {quest:5644} with a quest she gives and takes back at once (its text still speaks of {spell:2944}, which every priest now learns from the trainer)."] = "No nível 20, {npc:4606}, no {object:36070}, ensina {quest:5644} com uma missão que ela dá e pega de volta na hora (o texto dela ainda fala de {spell:2944}, que todo sacerdote agora aprende com o instrutor).",

	-- Step 13: Dark Sacrifice: Ur'kyo's letter
	-- {quest:5646} Dark Sacrifice · {npc:6018} Ur'kyo
	["{quest:5646}: {npc:6018}'s letter"] = "{quest:5646}: a carta de {npc:6018}",

	-- Step 14: Dark Sacrifice: Miles Welsh's letter
	-- {quest:5644} Dark Sacrifice · {npc:3044} Miles Welsh
	["{quest:5644}: {npc:3044}'s letter"] = "{quest:5644}: a carta de {npc:3044}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "No nível 10, vá até {npc:4606} no {object:36070} de {zone:1458}. Instrutores de sacerdotes de outros lugares ({npc:6018} em {zone:1454}, {npc:3706} em {area:362}, {npc:3044} em {zone:1456}) enviam você a ela com uma missão de mesmo nome.",
	-- ["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "No nível 20, {npc:4606} ensina {quest:5644}. {npc:6018}, em {zone:1454}, e {npc:3044}, em {zone:1456}, enviam você a ela com uma missão de mesmo nome.",
	-- ["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "Os feitiços de sacerdote Morto-vivo: {spell:2652} no nível 10, {quest:5644} no nível 20.",
}
