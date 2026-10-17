-- French (frFR): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Alliance)"] = "Incube (Alliance)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un second démon séducteur, le sayaad mâle, et un sac d'éclats d'âme pour transporter vos éclats.",

	-- Step 1: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "Au niveau 20, {npc:6122}, dans la cave de {object:2164} dans {object:2101}, vous envoie voir {npc:6244} dans {zone:1413}.",

	-- Step 2: Takar the Seer
	-- {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} campe dans le sud de {zone:1413}, à l'est de la route au nord-est de {area:378} : arrivez par l'est et évitez les gardes de la Horde.",

	-- Step 3: Wooden Figurine
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Depuis {area:415}, prenez la route vers l'ouest jusqu'à {area:413} : la figurine se trouve dans une maison parmi les arbres au nord du poste.",

	-- Step 4: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb
	["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Retournez voir {npc:6122} à {object:2164}. Posez la figurine sur le cercle d'invocation de la crypte sous lui et vainquez l'incube qu'elle appelle.",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122}: he binds the incubus to you"] = "{npc:6122} : il vous lie l'incube",
}
