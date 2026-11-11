-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/stormpike-battle-charger (forever/collectibles/mounts/alliance/stormpike-battle-charger.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormpike Guard
	-- {area:2839} Alterac Valley · {faction:730} Stormpike Guard · {npc:13217} Thanthaldis Snowgleam · {zone:1416} Alterac Mountains · {area:287} Hillsbrad · {npc:13216} Gaelden Hammersmith
	["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839} (nível 51+) aumenta {faction:730}: vença, capture torres e cemitérios e entregue as missões do campo de batalha; o guia Reputação: Vale Alterac mostra o jeito mais rápido. {npc:13217} espera fora do campo de batalha, na divisa de {zone:1416}, acima de {area:287}; {npc:13216}, dentro de {area:2839}, vende a mesma montaria.",

	-- Step 2: Stormpike Battle Charger
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Alliance race can ride it."] = "O cliente do Forever a lista por 200g e nível 60. Ela corre em velocidade máxima, então montar exige {skill:762} Profissional; qualquer raça da Aliança pode montar.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}, 200g"] = "{npc:13217}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "O cliente Forever a lista por 200g e nível 60, e não pede nível de montaria.",
	-- ["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839} (nível 51+) aumenta {faction:730}: vença, capture torres e cemitérios e faça as entregas do campo de batalha. {npc:13217} espera do lado de fora do campo de batalha, na divisa das {zone:1416} acima de {area:287}; {npc:13216}, dentro de {area:2839}, vende a mesma montaria.",
}
