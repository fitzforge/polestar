-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nutritious Slime Sludge
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle · {zone:1458} Undercity
	["Buy {item:278265} from {npc:4612} in the {zone:1458} canals first (25 copper for a stack of 5): you hand it in as soon as the slime offers its quest."] = "Compre antes {item:278265} de {npc:4612}, nos canais da {zone:1458} (25 cobres por uma pilha de 5): você entrega assim que a gosma oferecer a missão dela.",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals"] = "{item:278265}: {npc:4612}, nos canais",

	-- Step 2: WRIGGLE.
	-- {npc:269452} Excitable Slime · {npc:4612} Boyle · {quest:97583} WRIGGLE.
	["Find an {npc:269452}, a little critter in the canal water beside {npc:4612}, target it and /dance at it, again and again, until it dances back and offers {quest:97583}; this takes many tries. Hand in the sludge right away. If the slime seems tired, /dance with it again before you hand in."] = "Encontre {npc:269452}, um bichinho na água do canal ao lado de {npc:4612}, selecione-o e use /dance nele, várias vezes, até ele dançar de volta e oferecer {quest:97583}; isso leva muitas tentativas. Entregue o lodo na hora. Se a gosma parecer cansada, use /dance com ela de novo antes de entregar.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "Encontre o {npc:269452}, um bicho nos canais de {zone:1458}, e use /dance com ele até que ofereça WRIGGLE. Compre {item:278265} de um mercador nos canais e traga de volta; se o visgo parecer cansado, dance com ele de novo.",
	-- ["{item:278265}: {npc:4612}, in the canals beside the slime"] = "{item:278265}: {npc:4612}, nos canais ao lado do visgo",
}
