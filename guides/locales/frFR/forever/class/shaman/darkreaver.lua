-- French (frFR): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; the {item:20134} may be gone in Forever."] = "Un combat à {area:2057} au niveau 60 pour de la réputation auprès de la Horde ; le {item:20134} a peut-être disparu dans Forever.",
	["200 Horde reputation"] = "200 de réputation Horde",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds; every Horde shaman goes to him. Skyborne: Forever's quest page lists this quest for Orcs, Tauren and Trolls only: ask before you buy the diamonds."] = "Au niveau 58, {npc:13417}, maître des chamans dans la {object:172957}, demande deux diamants rares ; tous les chamans de la Horde vont le voir. Éolides : la page de quête de Forever ne réserve cette quête qu'aux Orcs, Taurens et Trolls : renseignez-vous avant d'acheter les diamants.",

	-- Step 2: Two diamonds
	["Two diamonds"] = "Deux diamants",
	-- {item:12800} Azerothian Diamond · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {item:18335} Pristine Black Diamond
	-- plural, as words: Small Thorium Veins = {object:324} Small Thorium Vein
	["Both diamonds are rare: the auction house is the quick way. Miners find the {item:12800} in about one Thorium vein in a hundred (the Small Thorium Veins north of {area:2418} in the {zone:1428} respawn every five minutes). The {item:18335} drops from high-level elites at about one in a hundred, best from the rare elite Revanchion (about one in nine)."] = "Les deux diamants sont rares : l'hôtel des ventes est le plus rapide. Les mineurs trouvent le {item:12800} dans environ un filon de thorium sur cent (les Petits filons de thorium au nord du {area:2418}, dans les {zone:1428}, réapparaissent toutes les cinq minutes). Le {item:18335} tombe sur les élites de haut niveau environ une fois sur cent, surtout sur l'élite rare Revanchion (environ une fois sur neuf).",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668} demande le niveau 60.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "il vous remet {item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {npc:14516} Death Knight Darkreaver · {spell:686} Shadow Bolt · {spell:6958} Blood Leech
	-- plural, as words: Cleaves = {spell:845} Cleave
	["A five-player dungeon event: {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. In the {object:179746}'s basement, first clear every mob in the room, then use the {item:18746} at its centre: four waves of spirits follow, each closing with an Aspect mini-boss (the first wave weak and slow, the rest elite). Fight in a corner so nothing else joins, and drink between waves: it is long. Then {npc:14516} (level 62 elite) appears: he Cleaves, casts {spell:686} and {spell:6958}, and Dominates a player's mind against the group. His head always drops."] = "Un événement de donjon à cinq joueurs : {area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est des {zone:1422}. Au sous-sol du Grand ossuaire, nettoyez d'abord tous les monstres de la salle, puis utilisez le {item:18746} en son centre : quatre vagues d'esprits suivent, chacune terminée par un mini-boss Aspect (la première vague faible et lente, les autres élites). Combattez dans un coin pour que rien d'autre ne s'en mêle, et buvez entre les vagues : c'est long. Ensuite {npc:14516} (élite de niveau 62) apparaît : il porte des Enchaînements, lance {spell:686} et {spell:6958}, et domine l'esprit d'un joueur contre le groupe. Sa tête tombe toujours.",

	-- Step 5: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {item:20134} Skyfury Helm
	["{npc:13417}: 200 Horde reputation; the {item:20134} may be gone"] = "{npc:13417} : 200 de réputation auprès de la Horde ; le {item:20134} a peut-être disparu",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "Un combat à {area:2057} au niveau 60 pour de la réputation Horde ; Forever a supprimé {item:20134}.",
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "Un {item:12800} provient des filons de thorium, un {item:18335} des élites des {zone:1422}, tous deux rarement : achetez-les à l'Hôtel des ventes si vous pouvez.",
	-- ["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "Au niveau 58, {npc:13417}, le maître des chamans de {object:172957}, demande deux diamants rares.",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} se trouve sous {area:2298}, la ville sur l'île au sud-est des {zone:1422}. Utilisez {item:18746} au cœur du sous-sol du Grand ossuaire, battez les esprits qu'il appelle, puis {npc:14516}. Tous sont élites : venez en groupe.",
}
