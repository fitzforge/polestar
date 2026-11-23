-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "Lobo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {faction:76} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {faction:76}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} to Orcs for 100g (10% less at Honored with {faction:76}), and it comes with a wolf. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4752} e o canil de {npc:3362} ficam no Vale da Honra de {faction:76}. No nível 40, {npc:4752} ensina {skill:762} aos Orcs por 100g (10% menos com Honrado em {faction:76}), e vem junto um lobo. As outras raças aprendem {skill:762}, com a própria primeira montaria, no instrutor de equitação da própria raça.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instrutor de equitação",

	-- Step 2: Wolf Riding for other races
	-- {spell:825} Wolf Riding
	["{spell:825} for other races"] = "{spell:825} para outras raças",
	-- {spell:825} Wolf Riding · {skill:762} Riding · {npc:4752} Kildar · {faction:76} Orgrimmar
	["Any Horde race can buy these wolves, but riding one also takes {spell:825}, which only Orcs get with {skill:762}. {npc:4752} teaches it to other races once they are Exalted with {faction:76} (the Orgrimmar Reputation guide shows the way). Until then, don't buy a wolf for this character."] = "Qualquer raça da Horda pode comprar estes lobos, mas montar um também exige {spell:825}, que só os Orcs recebem com {skill:762}. {npc:4752} ensina às outras raças quando elas estão Exaltadas com {faction:76} (o guia Reputação: Orgrimmar mostra o caminho). Até lá, não compre lobo para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}, 20g",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}, 20g",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}, 20g",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "A {item:1041} está no cliente (20g), mas nossos dados não têm mercador que a venda.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4752} e o canil de {npc:3362} ficam no {object:172958} de {zone:1454}. No nível 40, {npc:4752} ensina {skill:762} (100g segundo os designers da Blizzard), e aprender lhe dá uma montaria. O cliente Forever permite que toda raça da Horda os monte.",
}
