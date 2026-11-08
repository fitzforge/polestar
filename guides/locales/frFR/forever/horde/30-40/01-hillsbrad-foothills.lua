-- French (frFR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Freewind Post flight master
	-- {object:19840} Freewind Post (no name in this language: may be words)
	["{object:19840} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {object:19840} Freewind Post (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words)
	["Fly from {object:19840} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to the Crossroads from there."] = "",

	-- Step 3: Ratchet
	["Ratchet"] = "",
	-- {object:19840} Freewind Post (no name in this language: may be words) · {npc:5901} Islen Waterseer
	["Fly from {object:19840} to Ratchet. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from Ratchet."] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 5: Fly to the Crossroads
	["Ratchet flight master"] = "",

	-- Step 7: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	["Crossroads flight master"] = "",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, si vous l'avez",

	-- Step 10: Train
	["Train"] = "Entraînement",
	["Train your new spells."] = "Apprenez vos nouveaux sorts.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "",
	-- {npc:4483} Moktar Krin · {object:151976} Shimmering Flats (no name in this language: may be words)
	["for {npc:4483} in the {object:151976}, next guide"] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 13: The Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). No potion: skip the Elixir steps in Hillsbrad."] = "",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388} : hôtel des ventes ou un alchimiste, pour {quest:515}.",

	-- Step 14: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} forme les Paladins à {zone:1458}.",

	-- Step 15: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Maître de vol de {zone:1458}",

	-- Step 16: Brazier of Everfount
	-- {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to the Sepulcher. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {object:1772} from the Sepulcher."] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 17: Fly to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to {object:1772}"] = "",
	-- {object:1675} The Sepulcher (no name in this language: may be words)
	["{object:1675} flight master"] = "",

	-- Step 19: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, à l'intérieur",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, pour {npc:2333}",

	-- Step 20: Henchman Valik
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {quest:535} Valik
	["Follow the road north out of {object:1772} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "",

	-- Step 21: Syndicate missives
	["Syndicate missives"] = "Missives du Syndicat",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Les Détrousseurs et Larrons du Syndicat (32-33) autour des camps à l'ouest de la route portent les missives ; environ un sur trois en laisse tomber une.",

	-- Step 24: Helcular's Rod
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the Foothill Caverns in the hills west of {object:1772}; about one in sixteen carries the rod."] = "",

	-- Step 25: Level 30
	["Level 30"] = "",
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {quest:544} Prison Break In · {quest:556} Stone Tokens · {quest:676} The Hammer May Fall
	["{object:1772}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the Scarlet Monastery dungeon (Graveyard) or the Blackfathom Deeps dungeon instead."] = "",
	["Foothill Caverns"] = "",
	-- {npc:2248} Cave Yeti
	["grind on {npc:2248}"] = "",

	-- Step 26: Town hall
	["Town hall"] = "Hôtel de ville",
	-- {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to Hillsbrad town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, à l'intérieur",
	["Inside"] = "À l'intérieur",

	-- Step 27: Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Back east to {object:1772}."] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside: offered from level 30"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside: offered from level 30"] = "",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {quest:655} Hammerfall
	["{npc:2770}: for {npc:2771} in {quest:655}, later in this guide (from level 30)"] = "",

	-- Step 28: Foothill Caverns
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {item:3710} Rod of Helcular · {object:1768} Flame of Azel · {object:1769} Flame of Veraz
	["Back into the yeti caves west of {object:1772} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "",

	-- Step 29: Flame of Uzel
	["The third flame burns in the smaller cave up in the hills north of the caverns."] = "",

	-- Step 31: The Dalaran crater
	["The Dalaran crater"] = "",
	-- {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of Dalaran. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens.\nCareful: Many guards stand in linked pairs and others patrol alone around the camp."] = "",

	-- Step 32: Hillsbrad Foothills
	["Azurelode Mine"] = "",

	-- Step 33: Azurelode Mine
	-- {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south past Hillsbrad town to the Azurelode Mine. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "",
	["Inside Azurelode Mine"] = "",

	-- Step 34: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	["The Torn Fin murlocs camp on the beaches south-west of Southshore's bay, below the mine."] = "",
	["Torn Fin beach"] = "Plage des Aileron déchiré",

	-- Step 35: Helcular's Grave
	["Head east to Southshore's graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north and keep away from the town's guards."] = "",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	["The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "Rivage des Daguéchine",

	-- Step 37: Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Head back north to {object:1772}, east of Southshore."] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, à l'intérieur",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, à l'intérieur",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}: for the 38-39 visit to Alterac"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}: for the 38-39 visit to Alterac"] = "",
	-- {npc:2229} Krusk · {npc:2316} Gol'dir
	["{npc:2229} now offers {npc:2316} (level 36): leave it for the 38-39 visit."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, à l'intérieur",

	-- Step 38: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {object:1784} Dun Garok (no name in this language: may be words) · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {object:1784}, the dwarven keep south-east of Southshore: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 39: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {object:1784} Dun Garok (no name in this language: may be words)
	["{npc:2419}'s sword drops from the same {object:1784} dwarves (about one in twelve)."] = "",

	-- Step 40: Dun Garok
	-- {object:1784} Dun Garok (no name in this language: may be words)
	["Clear {object:1784} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 41: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 43: Shindigger keg
	["Shindigger keg"] = "Tonneau de Shindigger",
	["The keg stands with a few others at the Syndicate camp on the south-east coast of Hillsbrad."] = "",
	["Below ground"] = "Sous terre",

	-- Step 44: Back to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Back to {object:1772}"] = "",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Head back north to {object:1772}."] = "",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Placez le {object:1729} sur la {object:1728} à côté de l'auberge ; à l'étage",

	-- Step 46: Boulderfist camp
	["Boulderfist camp"] = "Camp Rochepoing",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {object:1772} through Thoradin's Wall and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of Northfold Manor."] = "",

	-- Step 47: Level 31
	["Level 31"] = "",
	-- {quest:655} Hammerfall
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["{quest:655}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the Scarlet Monastery dungeon (Graveyard) or the Blackfathom Deeps dungeon instead."] = "",
	-- {npc:2562} Boulderfist Ogre
	["grind on {npc:2562}"] = "",

	-- Step 48: Hammerfall
	-- {npc:2851} Urda
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "La forteresse orque au bout est de la route. {npc:2851}, la maîtresse des coursiers du vent, se tient près de la porte.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "",
	-- {npc:2706} Tor'gan · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2706}: its Syndicate are by the road in from {object:1772}, on the 38-39 visit"] = "",

	-- Step 49: Witherbark Village
	["South-east of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village.\nCareful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 50: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "",
	-- {quest:655} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {quest:655} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "",

	-- Step 51: Hammerfall
	-- {quest:655} Hammerfall
	["Back north to {quest:655}."] = "",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",
	-- {npc:2706} Tor'gan · {npc:2771} Drum Fel · {quest:677} Call to Arms
	["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "",

	-- Step 52: Fly to Undercity
	-- {zone:1458} Undercity
	["Fly to {zone:1458}"] = "",
	-- {quest:655} Hammerfall
	["{quest:655} flight master"] = "",

	-- Step 53: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entraînez-vous pendant que vous êtes à {zone:1458} : les maîtres se trouvent dans {object:36070}, {object:36073} et {object:36082} (paladins : {npc:260093}).",
}
