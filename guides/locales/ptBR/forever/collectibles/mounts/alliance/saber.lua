-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "Sabre",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 40 {npc:4753} teaches {skill:762} to Night Elves for 100g (10% less at Honored with {faction:69}), and it comes with a saber. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4753} e os sabres de {npc:4730} ficam nos campos de equitação de {area:1658}, em {faction:69}. No nível 40, {npc:4753} ensina {skill:762} aos Elfos Noturnos por 100g (10% menos com Honrado em {faction:69}), e vem junto um sabre. As outras raças aprendem {skill:762}, com a própria primeira montaria, no instrutor de equitação da própria raça.",
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
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} vende as outras cores (20g cada no cliente do Forever). Compre as que quiser, ou nenhuma se a montaria que você ganhou for a que você gosta.",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}, 20g",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}, 20g",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}, 20g",
	["new in Forever, 20g; beta players found it here"] = "novo no Forever, 20g; jogadores do beta o encontraram aqui",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706} é um sabre novo do Forever (nível 40, 20g no cliente) cuja origem ainda não é conhecida.",
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "Os sabres de {npc:4753} e {npc:4730} estão no campo de montaria do {area:1658}, em {zone:1457}. No nível 40, {npc:4753} ensina {skill:762} (100g segundo os designers da Blizzard), e aprender isso dá a você uma montaria. O cliente do Forever deixa todas as raças da Aliança montarem estes.",
}
