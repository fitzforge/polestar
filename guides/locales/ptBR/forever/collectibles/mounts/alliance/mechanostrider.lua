-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "Mecanostruz",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a cavalgar",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding · {faction:54} Gnomeregan Exiles
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} to Gnomes for 100g (10% less at Honored with {faction:54}), and it comes with a mechanostrider. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, instrutor de montaria",

	-- Step 2: Mechanostrider Piloting for other races
	-- {spell:10907} Mechanostrider Piloting
	["{spell:10907} for other races"] = "",
	-- {spell:10907} Mechanostrider Piloting · {skill:762} Riding · {npc:7954} Binjy Featherwhistle · {faction:54} Gnomeregan Exiles
	["Any Alliance race can buy these mechanostriders, but riding one also takes {spell:10907}, which only Gnomes get with {skill:762}. {npc:7954} teaches it to other races once they are Exalted with {faction:54} (the Gnomeregan Exiles Reputation guide shows the way). Until then, don't buy a mechanostrider for this character."] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se a montaria que recebeu é a que você gosta.",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}, 20g",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}, 20g",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}, 20g",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}, 20g",
	-- {spell:10907} Mechanostrider Piloting
	["In Classic only Dwarves and Gnomes could ride mechanostriders; in Forever every Alliance race can learn {spell:10907}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "O Era só deixava Anões e Gnomos montarem mecanostruzes; o cliente Forever permite todas as raças da Aliança.",
	-- ["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "A {area:189} fica logo a leste de {area:131}; {npc:7954} fica ao lado dos mecanostruzes de {npc:7955}. No nível 40, {npc:7954} ensina {skill:762} (100g segundo os criadores da Blizzard), e aprender lhe dá uma montaria. O cliente Forever deixa toda raça da Aliança montar estes.",
}
