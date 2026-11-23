-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} en {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12262} Empty Worg Pup Cage · {item:12529} Smolderweb Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He gives you an {item:12262}. He also gives En-Ay-Es-Tee-Why (the {item:12529}): take both, they are done in the same run."] = "{npc:10260} está dentro de la cueva de {area:251}, el campamento del norte de {zone:1428}, al este de {area:254}. Te da una {item:12262}. También da Arañas al cuadrado (la {item:12529}): toma las dos, se hacen en la misma pasada.",

	-- Step 2: Lower Blackrock Spire: Halycon's pups
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}: Halycon's pups"] = "{area:1583} inferior: los cachorros de Halycon",
	-- {npc:10584} Urok Doomhowl · {npc:10221} Bloodaxe Worg Pup
	["The pups are in Lower Blackrock Spire (a group of five, level 55-60), not Upper: they run with Halycon, the great worg, deep in the dungeon beyond {npc:10584}'s ogres. Use the cage on a living {npc:10221} before the pack is dead. Taking damage interrupts the cast, so let the tank hold the pups and cage one from the side. A rogue or druid can sneak in, cage a pup from a corner, then vanish."] = "Los cachorros están en la Cumbre de Roca Negra inferior (un grupo de cinco, nivel 55-60), no en la superior: andan con Halycon, el gran huargo, en lo hondo de la mazmorra, más allá de los ogros de {npc:10584}. Usa la jaula en un {npc:10221} vivo antes de que muera la manada. Recibir daño interrumpe el lanzamiento, así que deja que el tanque contenga a los cachorros y enjaula uno desde un costado. Un pícaro o un druida puede colarse, enjaular un cachorro desde un rincón y luego esfumarse.",
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583} inferior",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Vuelve con {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Upper {area:1583}"] = "{area:1583} Superior",
	-- ["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "{area:1583} Superior es para un grupo de banda de hasta diez, nivel 58-60. Usa la jaula de {npc:10260} en un {npc:10221} (la guarida de Halycon) para obtener el {item:12263}.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} está en {area:251}, al norte de {zone:1428}, cerca del camino a {area:254}.",
}
