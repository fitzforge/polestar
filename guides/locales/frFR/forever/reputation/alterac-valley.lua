-- French (frFR): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Réputation : Vallée d'Alterac",

	-- Step 1: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} : Amical",
	-- {faction:730} Stormpike Guard · {area:2959} Dun Baldar · {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge
	["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "La {faction:730} tient {area:2959}, dans le nord de {zone:1459}. Détruire des tours, prendre des cimetières et des mines, et tuer capitaines et généraux rapportent de la réputation à toute l'équipe. Ramassez des {quest:7223} sur les ennemis tombés pour {npc:13257}. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:12096} Stormpike Quartermaster · {item:17542} Coldtooth Supplies
	["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096} : Fournitures de Gouffrefer et de Froide-dent ({item:17542}) des mines",

	-- Step 2: Stormpike Guard to Honored
	-- {faction:730} Stormpike Guard
	["{faction:730} to Honored"] = "{faction:730} : Honoré",
	-- {zone:1459} Alterac Valley · {quest:7223} Armor Scraps · {npc:13257} Murgot Deepforge · {npc:13442} Arch Druid Renferal · {npc:13419} Ivus the Forest Lord · {npc:13577} Stormpike Ram Rider Commander
	-- plural, as words: Storm Crystals = {item:17423} Storm Crystal · Frostwolf Hides = {item:17643} Frostwolf Hide
	["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Continuez à gagner {zone:1459}. Encore des {quest:7223} ({npc:13257}), des Cristaux de tempête pour {npc:13442} (ils invoquent {npc:13419}) et des Peaux de loup des glaces pour le {npc:13577} : tout cela se répète.",
	-- {npc:13257} Murgot Deepforge · {quest:7223} Armor Scraps
	["{npc:13257}: More {quest:7223}"] = "{npc:13257} : encore des {quest:7223}",
	-- {npc:13442} Arch Druid Renferal
	["{npc:13442}: Crystal Cluster"] = "{npc:13442} : Grappes de cristaux",

	-- Step 3: Stormpike Guard to Revered
	-- {faction:730} Stormpike Guard
	["{faction:730} to Revered"] = "{faction:730} : Révéré",
	-- {npc:11946} Drek'Thar
	["Full games that kill {npc:11946} after the towers fall pay the most."] = "Les parties complètes où {npc:11946} meurt après la chute des tours rapportent le plus.",

	-- Step 4: Stormpike Guard to Exalted
	-- {faction:730} Stormpike Guard
	["{faction:730} to Exalted"] = "{faction:730} : Exalté",
	-- {faction:730} Stormpike Guard
	["Exalted with the {faction:730} earns a Legacy Point."] = "Être exalté auprès de la {faction:730} rapporte un point d'héritage.",

	-- Step 5: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} : Amical",
	-- {faction:729} Frostwolf Clan · {area:2978} Frostwolf Keep · {zone:1459} Alterac Valley · {item:17422} Armor Scraps · {npc:13176} Smith Regzar
	["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "Le {faction:729} tient {area:2978}, dans le sud de {zone:1459}. Détruire des tours, prendre des cimetières et des mines, et tuer capitaines et généraux rapportent de la réputation à toute l'équipe. Ramassez des {item:17422} sur les ennemis tombés pour {npc:13176}. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:12097} Frostwolf Quartermaster · {item:17522} Irondeep Supplies
	["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097} : Fournitures de Froide-dent et de Gouffrefer ({item:17522}) des mines",

	-- Step 6: Frostwolf Clan to Honored
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Honored"] = "{faction:729} : Honoré",
	-- {zone:1459} Alterac Valley · {npc:13176} Smith Regzar · {item:17306} Stormpike Soldier's Blood · {npc:13236} Primalist Thurloga · {npc:13256} Lokholar the Ice Lord · {npc:13441} Frostwolf Wolf Rider Commander
	-- plural, as words: Alterac Ram Hides = {item:17642} Alterac Ram Hide
	["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Continuez à gagner {zone:1459}. Plus de butin ! ({npc:13176}), {item:17306} pour {npc:13236} (il invoque {npc:13256}) et les Peaux de bélier d'Alterac ({item:17642}) pour {npc:13441} se répètent tous.",
	-- {npc:13176} Smith Regzar
	["{npc:13176}: More Booty!"] = "{npc:13176} : Plus de butin !",
	-- {npc:13236} Primalist Thurloga
	["{npc:13236}: A Gallon of Blood"] = "{npc:13236} : Quelques litres de sang",

	-- Step 7: Frostwolf Clan to Revered
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Revered"] = "{faction:729} : Révéré",
	-- {npc:11948} Vanndar Stormpike
	["Full games that kill {npc:11948} after the towers fall pay the most."] = "Les parties complètes où {npc:11948} meurt après la chute des tours rapportent le plus.",

	-- Step 8: Frostwolf Clan to Exalted
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Exalted"] = "{faction:729} : Exalté",
	-- {faction:729} Frostwolf Clan
	["Exalted with the {faction:729} earns a Legacy Point."] = "Être exalté auprès du {faction:729} rapporte un point d'héritage.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and {npc:10990} Hides for the {npc:13441} all repeat."] = "Continuez à gagner {zone:1459}. Plus de butin ! ({npc:13176}), du {item:17306} pour {npc:13236} (il invoque {npc:13256}) et des peaux de {npc:10990} pour le {npc:13441} : tout cela se répète.",
}
