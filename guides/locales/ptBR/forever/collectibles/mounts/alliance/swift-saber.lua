-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "Sabre Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 60 {npc:4753} teaches Journeyman {skill:762} to Night Elves for 1,000g (10% less at Honored with {faction:69}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift saber costs 200g here."] = "{npc:4753} e os sabres de {npc:4730} ficam nos campos de equitação de {area:1658}, em {faction:69}. No nível 60, {npc:4753} ensina {skill:762} Profissional aos Elfos Noturnos por 1.000g (10% menos com Honrado em {faction:69}); a Blizzard diz que vem junto uma montaria. As outras raças treinam no instrutor de equitação da própria raça. Cada sabre veloz custa 200g aqui.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, instrutor de equitação",

	-- Step 2: Tiger Riding for other races
	-- {spell:828} Tiger Riding
	["{spell:828} for other races"] = "{spell:828} para outras raças",
	-- {spell:828} Tiger Riding · {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes {spell:828}, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "Qualquer raça da Aliança pode comprar estes sabres, mas montar um também exige {spell:828}, que só os Elfos Noturnos recebem com {skill:762}. {npc:4753} ensina às outras raças quando elas estão Exaltadas com {faction:69} (o guia Reputação: Darnassus mostra o caminho). Até lá, não compre sabre para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200g",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200g",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "{npc:4753} e os sabres de {npc:4730} ficam no campo de montaria do {area:1658}, em {zone:1457}. No nível 60, {npc:4753} ensina {skill:762} (Profissional) (1.000g segundo os designers da Blizzard); a Blizzard diz que aprender a montar dá uma montaria. O cliente Forever vende cada sabre veloz por 200g no nível 60.",
}
