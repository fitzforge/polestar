-- Spanish (Latin America) (esMX): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Reputación: Valle de Alterac",

	-- Step 1: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} hasta Amistoso",
	-- {faction:730} Stormpike Guard · {area:2959} Dun Baldar · {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge
	["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730} controla {area:2959}, en el norte de {zone:1459}. Destruir torres, tomar cementerios y minas, y matar capitanes y generales da reputación a todo el equipo. Despoja {quest:7223} de los enemigos caídos para {npc:13257}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- {npc:12096} Stormpike Quartermaster · {item:17542} Coldtooth Supplies
	["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: Ferrohondo y {item:17542} de las minas",

	-- Step 2: Stormpike Guard to Honored
	-- {faction:730} Stormpike Guard
	["{faction:730} to Honored"] = "{faction:730} hasta Honorable",
	-- {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge · {npc:13442} Arch Druid Renferal · {npc:13419} Ivus the Forest Lord · {npc:13577} Stormpike Ram Rider Commander
	-- plural, as words: Storm Crystals = {item:17423} Storm Crystal · Frostwolf Hides = {item:17643} Frostwolf Hide
	["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Sigue ganando en {zone:1459}. Más {quest:7223} ({npc:13257}), Cristales de tormenta para {npc:13442} (invocan a {npc:13419}) y Pellejos Lobo Gélido para {npc:13577} se repiten.",
	-- {npc:13257} Murgot Deepforge · {quest:7223} Armor Scraps
	["{npc:13257}: More {quest:7223}"] = "{npc:13257}: Más {quest:7223}",
	-- {npc:13442} Arch Druid Renferal
	["{npc:13442}: Crystal Cluster"] = "{npc:13442}: Recogida de cristal",

	-- Step 3: Stormpike Guard to Revered
	-- {faction:730} Stormpike Guard
	["{faction:730} to Revered"] = "{faction:730} hasta Reverenciado",
	-- {npc:11946} Drek'Thar
	["Full games that kill {npc:11946} after the towers fall pay the most."] = "Las partidas completas que matan a {npc:11946} después de caer las torres son las que más dan.",

	-- Step 4: Stormpike Guard to Exalted
	-- {faction:730} Stormpike Guard
	["{faction:730} to Exalted"] = "{faction:730} hasta Exaltado",
	-- {faction:730} Stormpike Guard
	["Exalted with the {faction:730} earns a Legacy Point."] = "Ser Exaltado con {faction:730} otorga un Punto de legado.",

	-- Step 5: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} hasta Amistoso",
	-- {faction:729} Frostwolf Clan · {area:2978} Frostwolf Keep · {zone:1459} Alterac Valley · {item:17422} Armor Scraps · {npc:13176} Smith Regzar
	["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729} controla {area:2978}, en el sur de {zone:1459}. Destruir torres, tomar cementerios y minas, y matar capitanes y generales da reputación a todo el equipo. Despoja {item:17422} de los enemigos caídos para {npc:13176}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- {npc:12097} Frostwolf Quartermaster · {item:17522} Irondeep Supplies
	["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: Dentefrío y {item:17522} de las minas",

	-- Step 6: Frostwolf Clan to Honored
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Honored"] = "{faction:729} hasta Honorable",
	-- {zone:1459} Alterac Valley · {npc:13176} Smith Regzar · {item:17306} Stormpike Soldier's Blood · {npc:13236} Primalist Thurloga · {npc:13256} Lokholar the Ice Lord · {npc:13441} Frostwolf Wolf Rider Commander
	-- plural, as words: Alterac Ram Hides = {item:17642} Alterac Ram Hide
	["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Sigue ganando en {zone:1459}. ¡Más botines! ({npc:13176}), {item:17306} para {npc:13236} (invoca a {npc:13256}) y Pellejos de carnero de Alterac para {npc:13441} se repiten.",
	-- {npc:13176} Smith Regzar
	["{npc:13176}: More Booty!"] = "{npc:13176}: ¡Más botines!",
	-- {npc:13236} Primalist Thurloga
	["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: Un galón de sangre",

	-- Step 7: Frostwolf Clan to Revered
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Revered"] = "{faction:729} hasta Reverenciado",
	-- {npc:11948} Vanndar Stormpike
	["Full games that kill {npc:11948} after the towers fall pay the most."] = "Las partidas completas que matan a {npc:11948} después de caer las torres son las que más dan.",

	-- Step 8: Frostwolf Clan to Exalted
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Exalted"] = "{faction:729} hasta Exaltado",
	-- {faction:729} Frostwolf Clan
	["Exalted with the {faction:729} earns a Legacy Point."] = "Ser Exaltado con {faction:729} otorga un Punto de legado.",
}
