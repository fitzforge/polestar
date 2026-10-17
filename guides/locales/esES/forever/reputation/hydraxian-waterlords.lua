-- Spanish (Spain) (esES): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Reputación: Señores del Agua de Hydraxis",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} está en un islote frente a la costa este de {zone:1447}; ve nadando o caminando por los bajíos hasta él. Los {faction:749} empiezan en Neutral. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "Sirocosos y Estruendores del desierto",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Ambos elementales recorren el noroeste de {zone:1451}; los estruendores se agrupan un poco más al norte.",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Usa {item:17310} en los elementales de agua envenenados de {zone:1423} y luego despoja sus {item:17309} (12). Nuestros datos no tienen puntos de aparición para esos elementales.",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Vuelve con {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, en la Cumbre de Roca Negra superior, suelta {quest:6821}. Requiere un grupo de banda.",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Mata a un {npc:11668}, un {npc:11658}, un {npc:11673} y un {npc:12101} en {area:2717}. Todos los elementales y jefes de {area:2717} también cuentan para los Señores del Agua.",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} requiere Honorable. En Honorable, {npc:13278} entrega {item:17333}, que sirve para apagar las runas de {area:2717} que invocan a {npc:12018}; en Reverenciado, la reutilizable {item:22754}.",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Trae las manos de Lucifron, Gehennas, Shazzrah y Sulfuron de {area:2717}.",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749} hasta Reverenciado",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Limpiar {area:2717} da el resto. Los jefes siempre cuentan; en Classic, matar enemigos menores deja de dar reputación con los Señores del Agua a mitad de camino, así que al final el trabajo lo hacen los jefes.",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749} hasta Exaltado",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "Sigue limpiando {area:2717} hasta Exaltado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:9816} in Upper {area:1583} drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, en la parte superior de {area:1583}, suelta {quest:6821}. Requiere un grupo de banda.",
}
