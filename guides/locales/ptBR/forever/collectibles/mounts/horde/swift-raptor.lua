-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "Raptor Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding · {faction:530} Darkspear Trolls
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} to Trolls for 1,000g (10% less at Honored with {faction:530}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift raptor costs 200g here."] = "{npc:7953} e os raptores de {npc:7952} ficam em {area:367}, na costa de {zone:1411}. No nível 60, {npc:7953} ensina {skill:762} Profissional aos Trolls por 1.000g (10% menos com Honrado em {faction:530}); a Blizzard diz que vem junto uma montaria. As outras raças treinam no instrutor de equitação da própria raça. Cada raptor veloz custa 200g aqui.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de equitação",

	-- Step 2: Raptor Riding for other races
	-- {spell:10861} Raptor Riding
	["{spell:10861} for other races"] = "{spell:10861} para outras raças",
	-- {spell:10861} Raptor Riding · {skill:762} Riding · {npc:7953} Xar'Ti · {faction:530} Darkspear Trolls
	["Any Horde race can buy these raptors, but riding one also takes {spell:10861}, which only Trolls get with {skill:762}. {npc:7953} teaches it to other races once they are Exalted with {faction:530} (the Darkspear Trolls Reputation guide shows the way). Until then, don't buy a raptor for this character."] = "Qualquer raça da Horda pode comprar estes raptores, mas montar um também exige {spell:10861}, que só os Trolls recebem com {skill:762}. {npc:7953} ensina às outras raças quando elas estão Exaltadas com {faction:530} (o guia Reputação: Trolls Lançanegra mostra o caminho). Até lá, não compre raptor para este personagem.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se a montaria que recebeu é a que você gosta.",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}, 200g",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}, 200g",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}, 200g",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "O {item:46102} (nível 60) está no cliente Forever, mas a origem dele ainda não é conhecida.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953} e os raptores de {npc:7952} estão em {area:367}, na costa de {zone:1411}. No nível 60, {npc:7953} ensina {skill:762} (Profissional) (1,000g segundo os criadores da Blizzard); a Blizzard diz que aprender montaria concede uma montaria. O cliente Forever vende cada raptor veloz por 200g no nível 60.",
}
