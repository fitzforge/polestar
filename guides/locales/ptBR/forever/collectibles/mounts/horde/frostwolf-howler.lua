-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/frostwolf-howler (forever/collectibles/mounts/horde/frostwolf-howler.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Frostwolf Clan
	-- {area:2839} Alterac Valley · {faction:729} Frostwolf Clan · {npc:13219} Jekyll Flandring · {zone:1416} Alterac Mountains · {npc:13218} Grunnda Wolfheart
	["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839} (nível 51+) aumenta {faction:729}: vença, capture torres e cemitérios e entregue as missões do campo de batalha; o guia Reputação: Vale Alterac mostra o jeito mais rápido. {npc:13219} espera na ponta da Horda de {zone:1416}, fora do campo de batalha; {npc:13218}, dentro de {area:2839}, vende a mesma montaria.",

	-- Step 2: Horn of the Frostwolf Howler
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Horde race can ride it."] = "O cliente do Forever a lista por 200g e nível 60. Ela corre em velocidade máxima, então montar exige {skill:762} Profissional; qualquer raça da Horda pode montar.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}, 200g"] = "{npc:13219}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "O cliente Forever cobra 200g e nível 60, e não exige patamar de montaria.",
	-- ["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839} (nível 51+) aumenta a reputação com {faction:729}: vença, capture torres e cemitérios e entregue os itens do campo de batalha. {npc:13219} espera no lado da Horda de {zone:1416}, fora do campo de batalha; {npc:13218}, dentro de {area:2839}, vende a mesma montaria.",
}
