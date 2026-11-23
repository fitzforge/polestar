-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "Kodo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} to Tauren for 100g (10% less at Honored with {faction:81}), and it comes with a kodo. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:3690} e os kodos de {npc:3685} ficam em {area:222}, {zone:1412}. No nível 40, {npc:3690} ensina {skill:762} aos Taurens por 100g (10% menos com Honrado em {faction:81}), e vem junto um kodo. As outras raças aprendem {skill:762}, com a própria primeira montaria, no instrutor de equitação da própria raça.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de equitação",

	-- Step 2: Kodo Riding for other races
	-- {spell:18995} Kodo Riding
	["{spell:18995} for other races"] = "{spell:18995} para outras raças",
	-- {spell:18995} Kodo Riding · {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes {spell:18995}, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "Qualquer raça da Horda pode comprar estes kodos, mas montar um também exige {spell:18995}, que só os Taurens recebem com {skill:762}. {npc:3690} ensina às outras raças quando elas estão Exaltadas com {faction:81} (o guia Reputação: Penhasco do Trovão mostra o caminho). Até lá, não compre kodo para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} vende as outras cores (20g cada no cliente do Forever). Compre as que quiser, ou nenhuma se a montaria que você ganhou for a que você gosta.",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}, 20g",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}, 20g",
	["new in Forever, 20g; beta players found it here"] = "novo no Forever, 20g; jogadores do beta o encontraram aqui",
	-- {item:277960} Lavender Kodo
	["{item:277960} is a new Forever kodo (level 40, 20g in the client) whose source is not known yet."] = "{item:277960} é um kodo novo do Forever (nível 40, 20g no cliente) cuja origem ainda não se conhece.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993} e {item:277960} são kodos novos do Forever (nível 40, 20g no cliente) cuja origem ainda não é conhecida.",
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Os kodos de {npc:3690} e {npc:3685} estão em {area:222}, {zone:1412}. No nível 40, {npc:3690} ensina {skill:762} (100g segundo os designers da Blizzard), e aprender isso dá a você uma montaria. O cliente do Forever deixa todas as raças da Horda montarem estes.",
}
