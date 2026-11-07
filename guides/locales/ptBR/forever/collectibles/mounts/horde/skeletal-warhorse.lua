-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "Cavalo de Guerra Descarnado",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} to Undead for 1,000g (10% less at Honored with {faction:68}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each skeletal warhorse costs 200g here."] = "{npc:4773} e o estábulo de {npc:4731} ficam em {area:159}, {zone:1420}. No nível 60, {npc:4773} ensina {skill:762} Profissional aos Mortos-vivos por 1.000g (10% menos com Honrado em {faction:68}); a Blizzard diz que vem junto uma montaria. As outras raças treinam no instrutor de equitação da própria raça. Cada cavalo de guerra esquelético custa 200g aqui.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de equitação",

	-- Step 2: Undead Horsemanship for other races
	-- {spell:10906} Undead Horsemanship
	["{spell:10906} for other races"] = "{spell:10906} para outras raças",
	-- {spell:10906} Undead Horsemanship · {skill:762} Riding · {npc:4773} Velma Warnam · {faction:68} Undercity
	["Any Horde race can buy these skeletal horses, but riding one also takes {spell:10906}, which only Undead get with {skill:762}. {npc:4773} teaches it to other races once they are Exalted with {faction:68} (the Undercity Reputation guide shows the way). Until then, don't buy a skeletal horse for this character."] = "Qualquer raça da Horda pode comprar estes cavalos esqueléticos, mas montar um também exige {spell:10906}, que só os Mortos-vivos recebem com {skill:762}. {npc:4773} ensina às outras raças quando elas estão Exaltadas com {faction:68} (o guia Reputação: Cidade Baixa mostra o caminho). Até lá, não compre cavalo esquelético para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200g",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200g",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Os novos Cavalos Descarnados Verde, Escuro e Roxo do Forever e o {npc:265653} (nível 60) ainda não têm fonte conhecida.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773} e o estábulo de {npc:4731} ficam em {area:159}, {zone:1420}. No nível 60, {npc:4773} ensina {skill:762} (Profissional) (1.000g segundo os designers da Blizzard); a Blizzard diz que aprender a montar dá uma montaria. O cliente Forever vende cada cavalo de guerra descarnado por 200g no nível 60.",
}
