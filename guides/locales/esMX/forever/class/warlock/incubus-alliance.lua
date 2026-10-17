-- Spanish (Latin America) (esMX): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Alliance)"] = "Íncubo (Alianza)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un segundo demonio seductor, el sayaad masculino, y una bolsa para llevar tus fragmentos de alma.",

	-- Step 1: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "A nivel 20, {npc:6122}, en el sótano de {object:2164} en {object:2101}, te envía con {npc:6244} en {zone:1413}.",

	-- Step 2: Takar the Seer
	-- {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} acampa en el sur de {zone:1413}, al este del camino al noreste de {area:378}: llega desde el este y mantente lejos de los guardias de la Horda.",

	-- Step 3: Wooden Figurine
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Desde {area:415}, toma el camino al oeste hasta {area:413}: la figurilla está en una casa entre los árboles al norte del puesto.",

	-- Step 4: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb
	["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Regresa con {npc:6122} en {object:2164}. Coloca la figurilla en el círculo de invocación de la cripta bajo él y derrota al íncubo que aparece.",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122}: he binds the incubus to you"] = "{npc:6122}: vincula el íncubo a ti",
}
