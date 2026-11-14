-- Spanish (Spain) (esES): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; the {item:20134} may be gone in Forever."] = "Un combate en {area:2057} a nivel 60 por reputación con la Horda; puede que Forever haya eliminado el {item:20134}.",
	["200 Horde reputation"] = "200 de reputación con la Horda",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds; every Horde shaman goes to him. Skyborne: Forever's quest page lists this quest for Orcs, Tauren and Trolls only: ask before you buy the diamonds."] = "",

	-- Step 2: Two diamonds
	["Two diamonds"] = "Dos diamantes",
	-- {item:12800} Azerothian Diamond · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {item:18335} Pristine Black Diamond
	-- plural, as words: Small Thorium Veins = {object:324} Small Thorium Vein
	["Both diamonds are rare: the auction house is the quick way. Miners find the {item:12800} in about one Thorium vein in a hundred (the Small Thorium Veins north of {area:2418} in the {zone:1428} respawn every five minutes). The {item:18335} drops from high-level elites at about one in a hundred, best from the rare elite Revanchion (about one in nine)."] = "",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668} requiere nivel 60.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "te da el {item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {npc:14516} Death Knight Darkreaver · {spell:686} Shadow Bolt · {spell:6958} Blood Leech
	-- plural, as words: Cleaves = {spell:845} Cleave
	["A five-player dungeon event: {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. In the {object:179746}'s basement, first clear every mob in the room, then use the {item:18746} at its centre: four waves of spirits follow, each closing with an Aspect mini-boss (the first wave weak and slow, the rest elite). Fight in a corner so nothing else joins, and drink between waves: it is long. Then {npc:14516} (level 62 elite) appears: he Cleaves, casts {spell:686} and {spell:6958}, and Dominates a player's mind against the group. His head always drops."] = "",

	-- Step 5: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {item:20134} Skyfury Helm
	["{npc:13417}: 200 Horde reputation; the {item:20134} may be gone"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "Un {item:12800} sale de las filones de torio y un {item:18335} de los élites de {zone:1422}, ambos rara vez: cómpralos en la casa de subastas si puedes.",
	-- ["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "A nivel 58 {npc:13417}, el instructor de chamanes de {object:172957}, pide dos diamantes raros.",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} está bajo {area:2298}, el pueblo de la isla del sureste de {zone:1422}. Usa el {item:18746} en el centro del sótano de El Gran Osario, vence a los espíritus que invoca y luego a {npc:14516}. Todos son élite: lleva un grupo.",
}
