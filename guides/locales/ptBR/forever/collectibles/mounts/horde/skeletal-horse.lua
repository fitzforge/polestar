-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} to Undead for 100g (10% less at Honored with {faction:68}), and it comes with a skeletal horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4773} e o estábulo de {npc:4731} ficam em {area:159}, {zone:1420}. No nível 40, {npc:4773} ensina {skill:762} aos Mortos-vivos por 100g (10% menos com Honrado em {faction:68}), e vem junto um cavalo esquelético. As outras raças aprendem {skill:762}, com a própria primeira montaria, no instrutor de equitação da própria raça.",
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
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}, 20g",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}, 20g",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}, 20g",
	["new in Forever, 20g; beta players found it here"] = "novo no Forever, 20g; jogadores do beta o encontraram aqui",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354} é um cavalo novo do Forever (nível 40) cuja origem ainda não é conhecida.",
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "O estábulo de {npc:4773} e {npc:4731} fica em {area:159}, {zone:1420}. No nível 40, {npc:4773} ensina {skill:762} (100g segundo os designers da Blizzard), e aprendê-la dá uma montaria. O cliente Forever permite que todas as raças da Horda montem estes.",
}
