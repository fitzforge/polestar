-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732} e o curral de cavalos de {npc:384} ficam no {area:88}, no leste da {zone:1429}. No nível 40, {npc:4732} ensina {skill:762} (100g segundo os designers da Blizzard), e aprender lhe dá uma montaria. O cliente Forever permite que toda raça da Aliança os monte.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, instrutor de montaria",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20g",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20g",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20g",
	-- {item:2411} Black Stallion Bridle
	["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} está no cliente, mas não há mercador confirmado que o venda no Forever.",
}
