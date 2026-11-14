-- French (frFR): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Vers {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and follow the road south through the {zone:1437} to the {object:1668} tunnel into {zone:1432}. {area:144}, the dwarf town on the road in the middle of {zone:1432}, has guards who attack the Horde: leave the road before it and pass the town on the hills to its west. The road leaves {zone:1432} to the south into the {zone:1418}; follow it to the goblin camp in the {area:1877}."] = "Dirigez-vous vers le {object:2673}, le grand pont à la limite sud de l'Arathi, traversez-le et suivez la route vers le sud à travers {zone:1437} jusqu'au tunnel de {object:1668} qui mène au {zone:1432}. {area:144}, la ville naine sur la route au milieu du {zone:1432}, a des gardes qui attaquent la Horde : quittez la route avant et contournez la ville par les collines à l'ouest. La route quitte le {zone:1432} par le sud vers {zone:1418} ; suivez-la jusqu'au camp gobelin de la {area:1877}.",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106} : la lettre de Fizzle, de {area:439}",

	-- Step 3: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Allez vers l'ouest par la route en direction de {area:340} ; le camp de {npc:2921} se trouve dans {area:1878}, à mi-chemin.",

	-- Step 4: Kargath
	-- {area:340} Kargath · {quest:1418} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {quest:1418} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} est la forteresse de la Horde bâtie dans les falaises à la limite ouest de la zone. {quest:1418} se tient au niveau supérieur de {area:340}, bien au-dessus du maître de vol : montez par les rampes, la flèche ne distingue pas les niveaux.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "pour Helgrum l'Agile à {area:75}, vers le niveau 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, à l'intérieur",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elémentaires de roche inférieurs ({npc:2735})",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Les petits élémentaires errent dans la plaine entre {area:340} et le camp de {npc:2921}, sur la route du retour vers l'est. Chaque élémentaire de roche de la zone peut laisser tomber les Éclats d'élémentaire de roche de {npc:6868}.",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418} : tuez-les au passage",
	-- {area:1878} The Dustbowl · {zone:1418} Badlands
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards. Careful: Malevolent Mirages (42, elite) drift across the {zone:1418}: give them a wide berth."] = "Les Anciens coyotes des rochers et les Busards géants parcourent le bassin au sud de {area:1878}. Les coyotes lâchent à la fois les mâchoires et les crocs ; les Busards géants lâchent les gésiers. Attention : des Mirages malveillants (42, élites) errent dans {zone:1418} : tenez-vous loin d'eux.",

	-- Step 8: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elémentaires de roche",
	-- {area:345} Agmond's End · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	["South-east across the basin, the bigger Rock Elementals (39) stand on the slopes west of {area:345}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards. Careful: Malevolent Mirages (42, elite) drift across these slopes too."] = "Au sud-est, de l'autre côté du bassin, les grands Elémentaires de roche (39) se tiennent sur les pentes à l'ouest de {area:345} ; chacun lâche une dalle. Chaque élémentaire de roche peut laisser tomber les Éclats d'élémentaire de roche de {npc:6868}. Attention : des Mirages malveillants (42, élites) errent aussi sur ces pentes.",

	-- Step 9: Agmond's End
	-- {area:345} Agmond's End · {area:1517} Uldaman
	["Theldurin sits among the dwarven ruins at {area:345}, just east of the elementals. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "Theldurin est assis parmi les ruines naines de {area:345}, juste à l'est des élémentaires. Sa tablette se trouve juste à l'entrée de la grotte d'{area:1517}, à côté d'élites de niveau 38 : une quête de groupe.",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Troggs Stonevault",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way north from {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Les troggs Stonevault creusent autour des entrées de grottes au sud de la {area:1877}, sur le chemin du nord depuis {area:345} ; les Brise-os et les Chamans lâchent les éclats. Les busards, pour les ailes de {npc:2817}, tournoient au-dessus des collines entre la {area:1877} et {area:345}.",

	-- Step 11: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "La route du nord vers {area:1517} traverse la {area:1877} : {npc:2817} et {npc:4618} prennent les ailes et les éclats au passage.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "pour Fizzle à {area:2240}, sur le chemin de {area:484} à {zone:1446}, vers le niveau 43",

	-- Step 12: Ancient Chest
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Keep north on the road to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "Continuez vers le nord par la route jusqu'à l'entrée d'{area:1517}, dans le nord des {zone:1418} : le coffre se trouve juste à l'entrée de la grotte. {npc:2932} et les Golems d'obsidienne (38) se tiennent à côté, et des Terrassiers Ombreforge (35-36) creusent le tunnel, tous élites : restez groupés.",
	["Below ground"] = "Sous terre",

	-- Step 13: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Redescendez la route vers le sud, en passant {area:1877}.",

	-- Step 14: The Dustbowl
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["North-west across the basin to {npc:2921}'s camp. Short of Jarkal's shards? The Lesser Rock Elementals (37) on the flats west of the camp drop them about one kill in five."] = "Traversez le bassin vers le nord-ouest jusqu'au camp de {npc:2921}. Il vous manque des éclats pour Jarkal ? Les Elémentaires de roche inférieurs (37) dans la plaine à l'ouest du camp en lâchent environ une fois sur cinq.",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s next study wants bracers from the Greater Rock Elementals (42-44) in the south-western gulches, well above you: leave it."] = "L'étude suivante de {npc:2921} demande des brassards des Elémentaires de roche supérieurs (42-44), dans les ravins du sud-ouest, bien au-dessus de vous : laissez-la.",

	-- Step 15: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head west back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Retournez vers l'ouest à {area:340}. {npc:5394} se tient au niveau supérieur de {area:340}, bien au-dessus du maître de vol : montez par les rampes, la flèche ne distingue pas les niveaux.",
	-- {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide flies from {area:340} to {object:3202}."] = "Le prochain guide prend un vol de {area:340} pour {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Tous les élémentaires de roche des {zone:1418} lâchent les éclats de {npc:6868} : les Élémentaires de roche inférieurs (37), sur les plaines à l'ouest du camp de {npc:2921}, sont les plus sûrs, environ une fois sur cinq. Seuls les Élémentaires de roche supérieurs (42-44, bien au-dessus de vous) dans les ravins du sud-ouest lâchent les brassards de {npc:2921}, également environ une fois sur cinq : attirez-les un par un et reposez-vous entre les combats, ou laissez-les. Continuez à tuer en chemin les coyotes et les busards qui vous manquent encore.",
	-- ["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Continuez vers le nord sur la route ; le coffre se trouve sur le site de fouilles d'{area:1517}, au pied des ruines au nord-ouest de la route.",
	-- ["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin l’Egaré se trouve parmi les ruines naines de {area:345}, au sud de la {area:1877}.",
	-- ["{area:1878}: kill these as you meet them"] = "{area:1878} : tuez-les au passage",
	-- ["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920} : seulement si vous avez {item:2868} ({skill:164} ou l'hôtel des ventes)",
}
