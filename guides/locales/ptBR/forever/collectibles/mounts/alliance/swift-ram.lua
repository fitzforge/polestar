-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "Carneiro Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} to Dwarves for 1,000g (10% less at Honored with {faction:47}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift ram costs 200g here."] = "{area:803} fica a leste de {area:131}, na estrada para {zone:1432}; {npc:4772} fica ao lado dos carneiros de {npc:1261}. No nível 60, {npc:4772} ensina {skill:762} Profissional aos Anões por 1.000g (10% menos com Honrado em {faction:47}); a Blizzard diz que vem junto uma montaria. As outras raças treinam no instrutor de equitação da própria raça. Cada carneiro veloz custa 200g aqui.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, instrutor de equitação",

	-- Step 2: Ram Riding for other races
	-- {spell:826} Ram Riding
	["{spell:826} for other races"] = "{spell:826} para outras raças",
	-- {spell:826} Ram Riding · {skill:762} Riding · {npc:4772} Ultham Ironhorn · {faction:47} Ironforge
	["Any Alliance race can buy these rams, but riding one also takes {spell:826}, which only Dwarves get with {skill:762}. {npc:4772} teaches it to other races once they are Exalted with {faction:47} (the Ironforge Reputation guide shows the way). Until then, don't buy a ram for this character."] = "Qualquer raça da Aliança pode comprar estes carneiros, mas montar um também exige {spell:826}, que só os Anões recebem com {skill:762}. {npc:4772} ensina às outras raças quando elas estão Exaltadas com {faction:47} (o guia Reputação: Altaforja mostra o caminho). Até lá, não compre carneiro para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se a montaria que recebeu é a que você gosta.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200g",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200g",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "O {area:803} fica a leste de {area:131}, na estrada para {zone:1432}; {npc:4772} fica ao lado dos carneiros de {npc:1261}. No nível 60, {npc:4772} ensina {skill:762} (Profissional) (1,000g segundo os criadores da Blizzard); a Blizzard diz que aprender montaria concede uma montaria. O cliente Forever vende cada carneiro veloz por 200g no nível 60.",
}
