-- German (deDE): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Ins {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and follow the road south through the {zone:1437} to the {object:1668} tunnel into {zone:1432}. {area:144}, the dwarf town on the road in the middle of {zone:1432}, has guards who attack the Horde: leave the road before it and pass the town on the hills to its west. The road leaves {zone:1432} to the south into the {zone:1418}; follow it to the goblin camp in the {area:1877}."] = "Halte auf die {object:2673} zu, die große Brücke am Südrand von Arathi, überquere sie und folge der Straße nach Süden durch das {zone:1437} zum Tunnel {object:1668} nach {zone:1432}. {area:144}, die Zwergenstadt an der Straße mitten in {zone:1432}, hat Wachen, die die Horde angreifen: Verlasse die Straße davor und umgehe die Stadt auf den Hügeln westlich davon. Die Straße verlässt {zone:1432} nach Süden in die {zone:1418}; folge ihr zum Goblinlager im {area:1877}.",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: Fizzles Brief aus {area:439}",

	-- Step 3: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Geh auf der Straße nach Westen Richtung {area:340}; das Lager von {npc:2921} liegt auf halbem Weg im {area:1878}.",

	-- Step 4: Kargath
	-- {area:340} Kargath · {quest:1418} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {quest:1418} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} ist die Festung der Horde, die in die Klippen am westlichen Rand des Gebiets gebaut ist. {quest:1418} steht auf der oberen Ebene von {area:340}, hoch über dem Flugmeister: Nimm die Rampen nach oben, der Pfeil kann die Ebenen nicht unterscheiden.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "für Helgrum in {area:75}, etwa ab Stufe 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, drinnen",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Kleine Felselementare",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Die kleinen Elementare treiben über die Ebenen zwischen {area:340} und dem Lager von {npc:2921}, auf dem Rückweg nach Osten. Jedes Felselementar im Gebiet kann die Felselementar-Splitter von {npc:6868} fallen lassen.",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418}: Töte diese, wenn sie dir begegnen",
	-- {area:1878} The Dustbowl · {zone:1418} Badlands
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards. Careful: Malevolent Mirages (42, elite) drift across the {zone:1418}: give them a wide berth."] = "Die Älteren Felsspalten-Kojoten und Riesenbussarde streifen durch das Becken südlich des {area:1878}. Kojoten lassen sowohl die Kieferknochen als auch die Reißzähne fallen; die Riesenbussarde die Kröpfe. Vorsicht: Bösartige Trugbilder (42, Elite) treiben durch {zone:1418}: Mach einen weiten Bogen um sie.",

	-- Step 8: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Felselementare",
	-- {area:345} Agmond's End · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	["South-east across the basin, the bigger Rock Elementals (39) stand on the slopes west of {area:345}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards. Careful: Malevolent Mirages (42, elite) drift across these slopes too."] = "Südöstlich durch das Becken stehen die größeren Felselementare (39) an den Hängen westlich von {area:345}; jedes lässt eine Platte fallen. Jedes Felselementar kann die Felselementar-Splitter von {npc:6868} fallen lassen. Vorsicht: Auch Bösartige Trugbilder (42, Elite) treiben über diese Hänge.",

	-- Step 9: Agmond's End
	-- {area:345} Agmond's End · {area:1517} Uldaman
	["Theldurin sits among the dwarven ruins at {area:345}, just east of the elementals. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "Theldurin sitzt zwischen den Zwergenruinen bei {area:345}, direkt östlich der Elementare. Seine Tafel liegt direkt im Höhleneingang von {area:1517}, neben Elites der Stufe 38: eine Quest für eine Gruppe.",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Steingrufttroggs",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way north from {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Die Stonevault-Troggs graben um die Höhleneingänge südlich des {area:1877}, auf dem Weg nach Norden von {area:345}; die Knochenschnapper und Schamanen lassen die Flocken fallen. Die Bussarde für die Flügel von {npc:2817} kreisen über den Hügeln zwischen dem {area:1877} und {area:345}.",

	-- Step 11: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "Die Straße nach Norden nach {area:1517} führt durch das {area:1877}: {npc:2817} und {npc:4618} nehmen die Flügel und die Flocken auf dem Weg an.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "für Fizzle an der {area:2240}, auf dem Weg von {area:484} nach {zone:1446} bei etwa Stufe 43",

	-- Step 12: Ancient Chest
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Keep north on the road to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "Bleib auf der Straße nach Norden zum Eingang von {area:1517} im Norden von {zone:1418}: Die Truhe liegt gleich hinter dem Höhleneingang. {npc:2932} und die Obsidian Golems (38) stehen daneben, und Shadowforge Diggers (35-36) arbeiten im Tunnel, alle Elite: Halte deine Gruppe zusammen.",
	["Below ground"] = "Unter der Erde",

	-- Step 13: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Geh die Straße zurück nach Süden, am {area:1877} vorbei.",

	-- Step 14: The Dustbowl
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["North-west across the basin to {npc:2921}'s camp. Short of Jarkal's shards? The Lesser Rock Elementals (37) on the flats west of the camp drop them about one kill in five."] = "Nach Nordwesten durch das Becken zum Lager von {npc:2921}. Fehlen dir noch Jarkals Splitter? Die Geringeren Felselementare (37) auf den Ebenen westlich des Lagers lassen sie bei etwa jedem fünften Kill fallen.",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s next study wants bracers from the Greater Rock Elementals (42-44) in the south-western gulches, well above you: leave it."] = "Die nächste Studie von {npc:2921} will Armschienen von den Größeren Felselementaren (42-44) in den südwestlichen Schluchten, weit über dir: Lass sie liegen.",

	-- Step 15: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head west back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Geh nach Westen zurück nach {area:340}. {npc:5394} steht auf der oberen Ebene von {area:340}, hoch über dem Flugmeister: Nimm die Rampen nach oben, der Pfeil kann die Ebenen nicht unterscheiden.",
	-- {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide flies from {area:340} to {object:3202}."] = "Der nächste Guide fliegt von {area:340} nach {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Bleib auf der Straße nach Norden; die Truhe liegt in der Grabungsstätte von {area:1517}, am Fuß der Ruinen nordwestlich der Straße.",
	-- ["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin sitzt zwischen den Zwergenruinen an der {area:345}, südlich vom {area:1877}.",
	-- ["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: nur wenn du {item:2868} dabeihast ({skill:164} oder Auktionshaus)",
}
