-- French (frFR): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Extravagant Extravaganza Coin
	-- {item:276275} Bitter Baitling · {npc:15078} Jang · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay
	["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "Le {item:276275} est une récompense de pêche : {npc:15078} l'échange contre une {item:274026}, récompense du concours de pêche que {npc:15078} organise à {area:35}. La source exacte de la pièce n'est pas encore publiée.",

	-- Step 2: Jang
	-- {npc:15078} Jang · {area:35} Booty Bay
	["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} se tient sur les quais de {area:35}.",
}
