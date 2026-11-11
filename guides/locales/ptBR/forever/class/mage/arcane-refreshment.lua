-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "{spell:10140} de nível 60, de uma biblioteca de {area:2577}: bebida para você e seu grupo.",
	["Shen'dralar reputation"] = "Reputação com os Shen'dralar",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18594} Powerful Seaforium Charge
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing, or through the North wing's courtyard doors with a {item:18249} (it drops from the imp Pusillin in the East wing; a {item:18594} also opens them; Blink no longer gets past). Other mages in your group can take it too: share it."] = "Voe para Plumaluna (Aliança) ou {area:1099} (Horda) e cavalgue até {area:2577}, no centro de {zone:1444}. {npc:14368} espera no Ateneu, a biblioteca, que se alcança pela ala Oeste ou pelas portas do pátio da ala Norte com uma {item:18249} (ela cai do diabrete Pusillin, na ala Leste; uma {item:18594} também abre; Lampejo não passa mais). Outros magos do grupo também podem pegar a missão: compartilhe.",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "Rebentágua",
	-- {area:1758} Riptide
	["Hydrospawn, a level 57 elite water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool. A group of five. Frost does nothing to him, so frost mages switch to fire or arcane. {area:1758} hits everyone within 10 yards, so ranged stand back; at a quarter health he calls Hydrolings. The essence always drops; he does not come back until the instance resets."] = "Rebentágua, um elemental da água elite de nível 57, vive no Bairro Lenhatorta (a ala leste da masmorra): persiga o diabrete Pusillin até ele se virar para lutar, limpe a sala dos sátiros e desça a rampa em espiral até a piscina. Grupo de cinco. Gelo não faz nada nele, então magos de gelo trocam para fogo ou arcano. {area:1758} acerta todo mundo num raio de 10 metros, então quem ataca de longe fica afastado; com um quarto de vida ele chama crias de água. A essência sempre cai; ele só volta quando a instância reinicia.",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}: Rebentágua",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "De volta a Lydros",
	-- {npc:14368} Lorekeeper Lydros · {spell:10140} Conjure Water
	["{npc:14368}: {spell:10140}, and 200 Shen'dralar reputation"] = "{npc:14368}: {spell:10140}, e 200 de reputação com os Shen'dralar",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "Voe para o Domínio de Plumaluna (Aliança) ou {area:1099} (Horda) e cavalgue até {area:2577}, no centro de {zone:1444}. {npc:14368} espera no Ateneu, a biblioteca, alcançado pela ala Oeste (ou pela ala Norte com uma {item:18249}).",
	-- ["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "Rebentágua, um elemental da água, vive no Warpwood Quarter (Gládio Cruel Leste): persiga o diabrete Pusillin até ele se virar para lutar, limpe a sala dos sátiros e desça a rampa em espiral até o lago.",
}
