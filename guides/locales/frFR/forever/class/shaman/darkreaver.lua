-- French (frFR): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "Un combat à {area:2057} au niveau 60 pour de la réputation Horde ; Forever a supprimé {item:20134}.",
	["200 Horde reputation"] = "200 de réputation Horde",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "Au niveau 58, {npc:13417}, le maître des chamans de {object:172957}, demande deux diamants rares.",

	-- Step 2: Two diamonds
	["Two diamonds"] = "Deux diamants",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "Un {item:12800} provient des filons de thorium, un {item:18335} des élites des {zone:1422}, tous deux rarement : achetez-les à l'Hôtel des ventes si vous pouvez.",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668} demande le niveau 60.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "il vous remet {item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} se trouve sous {area:2298}, la ville sur l'île au sud-est des {zone:1422}. Utilisez {item:18746} au cœur du sous-sol du Grand ossuaire, battez les esprits qu'il appelle, puis {npc:14516}. Tous sont élites : venez en groupe.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} se trouve sous {area:2298}, la ville sur l'île au sud-est des {zone:1422}. Utilisez {item:18746} au cœur du sous-sol de {object:179746}, battez les esprits qu'il appelle, puis {npc:14516}. Tous sont élites : venez en groupe.",
}
