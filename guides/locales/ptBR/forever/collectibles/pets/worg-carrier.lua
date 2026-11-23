-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} na {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12262} Empty Worg Pup Cage · {item:12529} Smolderweb Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He gives you an {item:12262}. He also gives En-Ay-Es-Tee-Why (the {item:12529}): take both, they are done in the same run."] = "{npc:10260} fica dentro da caverna em {area:251}, o acampamento no norte de {zone:1428}, a leste de {area:254}. Ele entrega {item:12262} a você. Ele também entrega Nojento! ({item:12529}): pegue os dois, são feitos na mesma corrida.",

	-- Step 2: Lower Blackrock Spire: Halycon's pups
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}: Halycon's pups"] = "Lower {area:1583}: os filhotes de Halycon",
	-- {npc:10584} Urok Doomhowl · {npc:10221} Bloodaxe Worg Pup
	["The pups are in Lower Blackrock Spire (a group of five, level 55-60), not Upper: they run with Halycon, the great worg, deep in the dungeon beyond {npc:10584}'s ogres. Use the cage on a living {npc:10221} before the pack is dead. Taking damage interrupts the cast, so let the tank hold the pups and cage one from the side. A rogue or druid can sneak in, cage a pup from a corner, then vanish."] = "Os filhotes ficam em Lower Blackrock Spire (grupo de cinco, nível 55-60), não na Upper: eles andam com Halycon, o grande worg, no fundo da masmorra, depois dos ogros de {npc:10584}. Use a gaiola num {npc:10221} vivo antes de o bando morrer. Sofrer dano interrompe a conjuração, então deixe o tanque segurar os filhotes e capture um pelo lado. Um ladino ou druida pode entrar escondido, capturar um filhote de um canto e depois sumir.",
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} Inferior",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "De volta a {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Upper {area:1583}"] = "{area:1583} Superior",
	-- ["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "{area:1583} Superior é para um grupo de raide de até dez, nível 58-60. Use a jaula de {npc:10260} num {npc:10221} (covil de Halycon) para obter o {item:12263}.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} fica na {area:251}, no norte das {zone:1428}, perto da trilha da {area:254}.",
}
