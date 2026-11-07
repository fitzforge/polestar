-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "Cavalo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} to Humans for 100g (10% less at Honored with {faction:72}), and it comes with a horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4732} e o cercado de cavalos de {npc:384} ficam em {area:88}, no leste de {zone:1429}. No nível 40, {npc:4732} ensina {skill:762} aos Humanos por 100g (10% menos com Honrado em {faction:72}), e vem junto um cavalo. As outras raças aprendem {skill:762}, com a própria primeira montaria, no instrutor de equitação da própria raça.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, instrutor de equitação",

	-- Step 2: Horse Riding for other races
	-- {spell:824} Horse Riding
	["{spell:824} for other races"] = "{spell:824} para outras raças",
	-- {spell:824} Horse Riding · {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes {spell:824}, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "Qualquer raça da Aliança pode comprar estes cavalos, mas montar um também exige {spell:824}, que só os Humanos recebem com {skill:762}. {npc:4732} ensina às outras raças quando elas estão Exaltadas com {faction:72} (o guia Reputação: Ventobravo mostra o caminho). Até lá, não compre cavalo para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20g",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20g",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20g",

	-- Step 4: Black Stallion in Menethil Harbor
	-- {npc:5404} Black Stallion · {area:150} Menethil Harbor
	["{npc:5404} in {area:150}"] = "{npc:5404} em {area:150}",
	-- {npc:5404} Black Stallion · {npc:384} Katie Hunter · {npc:1460} Unger Statforth · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["The {npc:5404} is not at {npc:384}: {npc:1460} sells it, at the stables of {area:150} in the {zone:1437} (20g in the Forever client). Skip this unless you want that colour."] = "{npc:5404} não está com {npc:384}: {npc:1460} vende, nos estábulos de {area:150}, em {zone:1437} (20g no cliente do Forever). Pule, a menos que queira essa cor.",
	-- {item:2411} Black Stallion Bridle · {npc:1460} Unger Statforth
	["{item:2411}, 20g, {npc:1460}"] = "{item:2411}, 20g, {npc:1460}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} está no cliente, mas não há mercador confirmado que o venda no Forever.",
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732} e o curral de cavalos de {npc:384} ficam no {area:88}, no leste da {zone:1429}. No nível 40, {npc:4732} ensina {skill:762} (100g segundo os designers da Blizzard), e aprender lhe dá uma montaria. O cliente Forever permite que toda raça da Aliança os monte.",
}
