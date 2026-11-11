-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old item choice may be gone in Forever."] = "Uma pedra de uso único que deixa você bem mais forte contra mortos-vivos por 10 minutos; a escolha de item antiga pode não existir mais no Forever.",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 50 {npc:928}, the paladin trainer in the Cathedral of Light, sends you to {area:3197} in the {zone:1422}. {npc:5149} in {zone:1455} gives the same quest."] = "No nível 50, {npc:928}, o instrutor de paladino na Catedral da Luz, manda você a {area:3197}, em {zone:1422}. {npc:5149}, em {zone:1455}, dá a mesma missão.",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 50 {npc:5149}, the paladin trainer in the {object:32362}, sends you to {area:3197} in the {zone:1422}. {npc:928} in {zone:1453} gives the same quest."] = "No nível 50, {npc:5149}, o instrutor de paladino na {object:32362}, manda você a {area:3197}, em {zone:1422}. {npc:928}, em {zone:1453}, dá a mesma missão.",

	-- Step 3: Chillwind Camp
	-- {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:10838} Commander Ashlam Valorfist · {npc:10840} Argent Officer Pureheart
	["{area:3197} is the Alliance camp at the south end of the {zone:1422}, north of the Alterac foothills. {npc:10838} commands it; {npc:10840} stands in the same camp."] = "{area:3197} é o acampamento da Aliança na ponta sul de {zone:1422}, ao norte do sopé de Alterac. Quem comanda é {npc:10838}; {npc:10840} fica no mesmo acampamento.",

	-- Step 4: The Argent Dawn Commission
	-- {quest:5401} Argent Dawn Commission
	["The {quest:5401}"] = "{quest:5401}",
	-- {quest:5401} Argent Dawn Commission · {npc:10840} Argent Officer Pureheart · {area:2268} Light's Hope Chapel
	["The Scourge drop no Scourgestones unless you wear an {quest:5401}. {npc:10840} gives you one through her quest, {quest:5401}, which you hand in straight away (if you already have one from {area:2268}, wear that). Equip it in a trinket slot: it shows as a buff that never runs out. Keep it on until you have 20 stones."] = "O Flagelo só deixa cair Pedras do Flagelo se você estiver usando uma {quest:5401}. {npc:10840} dá uma pela missão dela, {quest:5401}, que você entrega na hora (se já tiver uma de {area:2268}, use essa). Equipe num espaço de berloque: aparece como um bônus que nunca acaba. Fique com ela até juntar 20 pedras.",
	-- {quest:5401} Argent Dawn Commission
	["the {quest:5401} trinket: equip it"] = "o berloque {quest:5401}: equipe-o",

	-- Step 5: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "Pedras do Flagelo do Lacaio",
	-- {zone:1422} Western Plaguelands · {item:12840} Minion's Scourgestone · {area:197} Sorrow Hill · {area:3197} Chillwind Camp · {area:196} Uther's Tomb · {spell:120} Cone of Cold · {spell:1449} Arcane Explosion
	-- plural, as words: Flesh Golems = {npc:1805} Flesh Golem · Skeletal Guardians = {npc:10390} Skeletal Guardian · Dark Summoners = {npc:8551} Dark Summoner
	["Kill the Scourge of the {zone:1422} with the Commission on: skeletons, ghouls and cultists (level 50-58) drop a {item:12840} about two kills in five. {area:197}, just east of {area:3197} around {area:196}, is the closest farm. Avoid the Flesh Golems that patrol the fields; Skeletal Guardians cast {spell:120} and {spell:1449} up close, Dark Summoners run for help at low health."] = "Mate o Flagelo de {zone:1422} com a Ordem equipada: esqueletos, carniçais e sectários (nível 50-58) deixam cair uma {item:12840} mais ou menos duas vezes a cada cinco. {area:197}, logo a leste de {area:3197}, em volta de {area:196}, é o lugar mais perto para farmar. Evite os Golens de Carne que patrulham os campos; os Guardiões Descarnados soltam {spell:120} e {spell:1449} de perto, e os Evocadores das Trevas fogem atrás de ajuda com pouca vida.",
	-- {item:12840} Minion's Scourgestone
	["{item:12840} x20"] = "{item:12840} x20",

	-- Step 6: High Priest Thel'danis
	-- {npc:1854} High Priest Thel'danis · {area:196} Uther's Tomb · {area:197} Sorrow Hill · {item:20612} Inert Scourgestone
	["{npc:1854} keeps watch at {area:196} on {area:197}, east of the camp. He turns your 20 stones into one {item:20612}: keep it."] = "{npc:1854} vigia em {area:196}, em {area:197}, a leste do acampamento. Ele transforma suas 20 pedras numa {item:20612}: guarde.",

	-- Step 7: Commander Ashlam Valorfist
	-- {area:3197} Chillwind Camp · {area:1417} Sunken Temple
	["Back to {area:3197}. Ashlam needs the voodoo of the {area:1417}'s trolls for the stone."] = "De volta a {area:3197}. O Ashlam precisa do vodu dos trolls de {area:1417} para a pedra.",

	-- Step 8: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["{area:1477}, the {area:1417}, lies in the {area:74} in eastern {zone:1435}: go up the ruin's stairs, dive into the flooded hall and follow the stairs down to the portal. It is a dungeon for a group of five at about 50-55. Six elite troll minibosses (level 51-52) stand on the balconies around the temple's great round room, each behind a pack of elites on its side path. Each drops its feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green; you need all six. Hukku calls guardians and throws Shadow Bolt Volleys, Mijan heals: kill them first."] = "{area:1477}, {area:1417}, fica em {area:74}, no leste de {zone:1435}: suba a escadaria da ruína, mergulhe no salão alagado e siga as escadas até o portal. É uma masmorra para grupo de cinco, por volta do nível 50-55. Seis minichefes troll elite (nível 51-52) ficam nas sacadas em volta do grande salão redondo do templo, cada um atrás de um bando de elites no seu caminho lateral. Cada um sempre deixa cair a sua pena: Talho e {npc:5716} a Âmbar, Hukkah e Mirran a Azul, Zolo e Lorro a Verde; você precisa das seis. O Hukkah chama guardiões e solta Saraivadas de Seta Sombria, o Mirran cura: mate esses primeiro.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606} x2: Gasher, {npc:5716}"] = "{item:20606} x2: Talho, {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607} x2: Hukku, Mijan"] = "{item:20607} x2: Hukkah, Mirran",
	-- {item:20608} Green Voodoo Feather
	["{item:20608} x2: Zolo, Loro"] = "{item:20608} x2: Zolo, Lorro",

	-- Step 9: Forging the Mightstone
	-- {area:3197} Chillwind Camp · {item:20620} Holy Mightstone · {item:20505} Chivalrous Signet · {item:20504} Lightforged Blade · {item:20512} Sanctified Orb · {area:2279} Stratholme · {area:2057} Scholomance
	["Back to Ashlam in {area:3197}: he forges the {item:20620}. Look at the reward window before you hand in: Classic also offered the {item:20505}, the {item:20504} or the {item:20512}, and Forever's notes say that choice may be gone. Use the stone before a fight against undead ({area:2279}, {area:2057}): it lasts ten minutes and is gone after one use."] = "De volta ao Ashlam, em {area:3197}: ele forja o {item:20620}. Olhe a janela de recompensa antes de entregar: o Classic também oferecia o {item:20505}, a {item:20504} ou o {item:20512}, e as notas do Forever dizem que essa escolha pode ter acabado. Use a pedra antes de uma luta contra mortos-vivos ({area:2279}, {area:2057}): ela dura dez minutos e some depois de um uso.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "Uma pedra de uso único que o deixa muito mais forte contra mortos-vivos por 10 minutos; as antigas recompensas à escolha foram removidas.",
	-- ["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "O Flagelo em todas as {zone:1422} solta Pedras do Flagelo do Lacaio.",
	-- ["The {item:12846}"] = "A {item:12846}",
	-- ["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477} fica no {area:74}, no leste do {zone:1435}. Lá dentro, Talho e {npc:5716} soltam a {item:20606}, Hukkah e Mirran a azul, Zolo e Lorro a verde.",
	-- ["{item:12846}: equip it"] = "{item:12846}: equipe",
	-- ["{item:20606}, inside"] = "{item:20606}, lá dentro",
	-- ["{item:20607}, inside"] = "{item:20607}, lá dentro",
	-- ["{item:20608}, inside"] = "{item:20608}, lá dentro",
	-- ["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838} comanda o {area:3197}, no sul das {zone:1422}.",
	-- ["{npc:5149} is in the {object:32362}."] = "{npc:5149} fica na {object:32362}.",
	-- ["{npc:928} is in the Cathedral of Light."] = "{npc:928} fica na Catedral da Luz.",
}
