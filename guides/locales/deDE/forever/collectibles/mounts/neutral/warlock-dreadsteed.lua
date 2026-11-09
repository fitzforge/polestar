-- German (deDE): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Hexenmeister-Schreckensross",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "Dein episches Reittier auf Stufe 60, überall herbeigerufen: kein episches Pferd zu kaufen und kein Reiten (Geselle) für 1.000g nötig.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "Auf Stufe 60 schickt dich {npc:5520}, der Dämonenlehrer im {object:2164}, zu {quest:7562} in der {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "Auf Stufe 60 schickt dich {npc:6382}, der Dämonenlehrer in {zone:1455}, zu {quest:7562} in der {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "Auf Stufe 60 schickt dich {npc:5815}, der Dämonenlehrer in der {object:172960}, zu {quest:7562} in der {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "Auf Stufe 60 schickt dich {npc:5753}, der Dämonenlehrer im {object:36082}, zu {quest:7562} in der {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "{quest:7562} und sein Goblin {npc:14437} lagern auf dem Hügel gegenüber der {area:255}, im äußersten Nordwesten der {zone:1428}, westlich von {area:254}. Die Kette ist lang: etwa 420 Gold für Waren von {npc:14437} und {npc:14522}, ein Haufen hergestellter Materialien, die {area:2057} und {area:2577}. Fang jetzt an, die Materialien der nächsten Schritte zu kaufen oder zu sammeln.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "Jedes Eulenbiest in {zone:1452} (Stufe 53-58, keine Elite) lässt das Blut etwa bei jedem dritten Kill fallen: rund neunzig Kills für dreißig. {area:2250} im Nordosten und die Umgebung des {area:2242} sind voll davon, und sie erscheinen nach fünfeinhalb Minuten wieder.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "Zurück zu {npc:14436}: Er gibt dir den {item:18591} für {npc:14437} neben ihm. Dann verlangt {npc:14436} die Glocke, das Rad und die Kerze, und {npc:14437} schickt dich zu {quest:7623} in {area:1763}: Kaufe dafür drei Shadowy Potions bei ihm (je 6 Gold: eines zum Hineingehen, eines nach {npc:14523} und eines als Reserve, falls eines ausläuft) und bring 150 Gold für den Sternenstaub mit.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "er gibt dir {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, von {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Die Ritualteile",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "{npc:14437} will 10 Elixiere der Schattenmacht ({skill:171}: je 3 Ghost Mushrooms und ein {item:8925}), 6 Large Brilliant Shards ({skill:333}: entzaubere blaue Gegenstände ab Stufe 51), 25 {item:11370} ({skill:186} 230: die Dunkeleisenvorkommen der {zone:1428} und von {area:1584}) und 35 Black Dragonscales ({skill:393}: die schwarzen Drachkin der {zone:1428}, einige Prozent pro Kill, am besten von den {npc:7043}). Stelle her oder sammle, was deine Berufe erlauben, und kaufe den Rest im Auktionshaus; 35 Schuppen zu finden kann dauern.",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "{item:9264}: das Auktionshaus",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "{item:14344}: das Auktionshaus",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "Gib die drei Teile {npc:14437}. Er will dann 3 Arkanitbarren für den {item:18629}: Alchemisten transmutieren sie (je ein {item:12363} und ein {item:12359}, mit langer Abklingzeit); alle anderen kaufen sie.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "{item:12360}: das Auktionshaus",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "{area:1763} liegt knapp südlich von {area:1997} im Westen von {zone:1448}, westlich der Straße; von seinen zwei Höhlen ist {area:1770} die nördliche, weiter oben am Hügel. Trink am Eingang einen {item:18802}: 20 Minuten lang behandelt dich der Schattenrat dort wie einen der Seinen ({spell:23179}). Die Schleime im roten Becken und die Sukkubus Rakaiah dahinter greifen trotzdem an: Halte dich an der Wand an ihnen vorbei. Geh am zweiten, roten Becken vorbei hinunter, die Rampe hinauf und über zwei Brücken zu {quest:7623}, einem großen geflügelten Schreckenslord im hinteren Teil. Er spricht nur mit dir, solange der Trank wirkt.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "{npc:14523} wartet in einem kleinen Nebenraum auf einer Brücke, an der du auf dem Weg nach unten vorbeigekommen bist. Sprich ihn an, und er und vier Wachen greifen an (alle Stufe 57, keine Elite): Lass deinen Leerwandler die Wachen halten und verbrenne {npc:14523}, opfere ihn, wenn es sein muss. Oder klicke deine Aura {spell:23179} ab, um den Kampf zu beginnen, töte {npc:14523} und trink dann einen weiteren Trank: Die Wachen hören sofort auf. Bring sein Herz mit aktivem Trank zurück zu {npc:9516}.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{npc:14522} neben {quest:7623} verkauft den {item:18687} für 150 Gold. Er handelt mit dir nur, solange ein {item:18802} wirkt.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, von {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "Zurück zu {npc:14437} mit dem Sternenstaub; ist auch die {quest:7630} erledigt, gibt er dir den {item:18688} für die {area:2057}. Stelle jetzt eine Gruppe von fünf zusammen: eine Gruppe, keinen Schlachtzug.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}, von {npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "Die {area:2057} (Stufe 58-60, eine Gruppe von fünf) liegt unter {area:2298}, der Inselstadt im Südosten der {zone:1422}: Jemand braucht den {item:13704} oder einen Schurken, um die Tür zu öffnen. Kämpfe dich zum Raum von {npc:10508} durch und benutze den {item:18688} an den Tischen des Alchemielabors rechts: {npc:14500} macht das Pergament. Du musst Ras nicht töten, aber es zählt nur in diesem Labor und nur in einer Gruppe.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "Benutze den {item:18688} im Alchemielabor drinnen",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "Zurück zu {npc:14437}, dann gibt dir {npc:14436} seine Anweisungen. Kaufe {item:18663} (150 Gold), den {item:18629} (50) und den {item:18670} (50) bei {npc:14437}; ein befreundeter Hexenmeister, der sie besitzt, kann stattdessen seine mitbringen. Jeder weitere Hexenmeister, der die Knoten wieder auflädt, braucht einen eigenen Lodestone. Trage 15 oder mehr Seelensplitter bei dir.",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "{item:18663}, 150 Gold",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "{item:18629}, 50 Gold",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "{item:18670}, 50 Gold",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "In Düsterbruch West",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "{area:2577} steht in den Ruinen im Zentrum von {zone:1444}: Geh vom Tor am Fuß der Ruinen durch die äußeren Höfe hinauf zur Tür des Westflügels am Nordende. Diese Tür und eine innere Tür brauchen den {item:18249} (er fällt von Pusillin in Düsterbruch Ost) oder einen Schurken mit 300 Schlossknacken. Bring eine Gruppe von fünf mit. Senke den Schild von {npc:11496}, indem du die Wächter der fünf Pylonen tötest (zwei stehen in seinem eigenen Raum), und töte dann {npc:11496}: Sein Podest ist der Beschwörungskreis. Ruhe dich aus und buffe, bevor du anfängst.",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "{npc:11496}, im Westflügel",

	-- Step 17: The ritual
	["The ritual"] = "Das Ritual",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "Stell dich auf das Podest und benutze {item:18663}: {npc:14500} legt die Glocke, das Rad und die Kerze aus. Die Glocke heilt Hexenmeister, das Rad schützt die Gruppe, die Kerze verbrennt die Wichtel: Ignoriere die Wichtel und töte die Dread Guards (Elite-Teufelswachen, etwa zehn, manchmal zwei auf einmal); Verbannen oder Versklaven hilft. Gib jedem Spieler einen Knoten zum Beobachten: Wenn einer absackt, kippt und ertönt, lädt ein Hexenmeister mit einem Lodestone ihn wieder auf, ein Zauber von 3 Sekunden, den jeder Treffer unterbricht (je ein {item:6265}), also halte Angreifer von ihnen fern. Fallen alle drei aus, endet das Ritual und du beginnst von vorn; solange einer steht, überlebt es sogar einen Wipe. Nach etwa sechs Minuten leuchten neun Symbole und ein roter Strudel schließt den Kreis: Geh hinaus, und die übrigen Dämonen verschwinden an seinem Rand. Ruhe dich aus und benutze dann den {item:18670}. Töte den {npc:14502} (Stufe 62, Elite); bei halber Gesundheit stößt {npc:14506} dazu, ein harter Schläger, der dich zurückstößt. Sprich den {npc:14504} an: Jeder Hexenmeister der Gruppe, der diese Quest hat, kann ihn binden.",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "{item:18663}, auf dem Podest von {npc:11496}",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "{item:18670}, sobald der Kreis vollständig ist",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5520} ({object:2164}) zu {quest:7562} im Gebiet {zone:1428}.",
	-- ["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5753} im {object:36082} zu {quest:7562} im Gebiet {zone:1428}.",
	-- ["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5815} ({object:172960}) zu {quest:7562} im Gebiet {zone:1428}.",
	-- ["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:6382} in {zone:1455} zu {quest:7562} im Gebiet {zone:1428}.",
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Zurück zu {npc:14436}, dann gib {item:18591} an {npc:14437} neben ihm. Danach verlangt {npc:14436} drei Ritualteile, und {npc:14437} schickt dich nach {zone:1448}: Kauf für diese Reise zwei Schattenhafte Tränke bei {npc:14437}.",
	-- ["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Zurück zu {npc:14437} mit dem Sternenstaub. Er gibt dir {item:18688} für {area:2057}.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Zurück zu {npc:14437}, dann gibt dir {npc:14436} seine Anweisungen für das Ritual. Kauf {item:18663}, {item:18629} und {item:18670} bei {npc:14437} und trag mindestens zehn Seelensplitter bei dir.",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki will 10 Elixiere der {spell:5896} ({skill:171}), 6 Große glänzende Splitter ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} und in der {zone:1427}) und 35 Schwarze Drachenschuppen ({skill:393}, schwarze Drachkin in der {zone:1428}). Stell her oder sammle, was deine Berufe erlauben; kauf den Rest im Auktionshaus.",
	-- ["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Gib {npc:14437} die drei Teile. Danach will er 3 Arkanitbarren: Alchemisten transmutieren sie, alle anderen kaufen sie im Auktionshaus.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Die Eulenbestien in {zone:1452} lassen das Blut fallen, etwa jede dritte: die Struppigen und Tobenden Eulenbestien westlich von und rund um {area:2255}, die Wahnsinnigen, Mondbestrahlten und {spell:417141}-Eulenbestien im Osten. Kümmere dich während der Jagd schon um die Materialien des nächsten Schritts: Das Auktionshaus hat sie alle.",
	-- ["The ritual in {area:2577}"] = "Das Ritual in {area:2577}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}: Für die Tür brauchst du ihren Schlüssel oder einen Schurken, und Blutrippes {item:13873}, um tiefer vorzudringen. Benutze {item:18688} am Alchemielabor im Raum von {npc:10508}; {npc:14500} fertigt das Pergament. Nimm eine Gruppe mit.",
	-- ["Use the {item:18688} at the alchemy lab"] = "Benutze {item:18688} am Alchemielabor",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Dein episches Reittier mit 60: überall beschworen, ohne Gold für ein episches Pferd.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} liegt im Westen von {zone:1448}. Trink vor dem Betreten {item:18802}: Die Kultisten des Schattenrats werden eine Weile freundlich, die Dämonen nicht. {quest:7623} wartet tief in der {area:1770}, der Höhle oberhalb von {area:1763}, jenseits einer Brücke in der großen Wurzelkammer.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} steht in den Ruinen im Zentrum von {zone:1444}; der Ritualkreis liegt im Westflügel hinter {npc:11496}, und die Tür braucht {item:18249} oder einen Schurken. Benutze zum Start {item:18663}; wenn die Glocke, das Rad oder die Kerze verblasst, klick sie mit {item:18629} an (je ein {item:6265}). Wenn keine Dämonen mehr kommen, benutze {item:18670}, besiege {npc:14502} und seinen Schreckenslord-Meister und sprich mit {npc:14504}. Nimm eine Gruppe mit.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} will 10 Elixiere der Schattenmacht ({skill:171}), 6 Große glänzende Splitter ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} und in der {zone:1427}) und 35 Schwarze Drachenschuppen ({skill:393}, schwarze Drachkin in der {zone:1428}). Stell her oder sammle, was deine Berufe erlauben; kauf den Rest im Auktionshaus.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}: Es bindet sich an dich",
	-- ["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522} neben {quest:7623} verkauft {item:18687}; er handelt nur mit dir, solange {item:18802} wirkt. Bring reichlich Gold mit.",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} wartet auf dem Rückweg nach oben in einer Seitenkammer bei einer Brücke. Sprich ihn an, dann greifen er und seine vier Wachen an; keiner ist Elite. Bring sein Herz zu {npc:9516} zurück und trink einen weiteren Trank, falls der erste abgelaufen ist.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} und sein Goblin {npc:14437} lagern am {area:255} im Nordwesten von {zone:1428}, westlich von {area:254}. Die Questreihe ist lang, kostet bei {npc:14437} Gold und endet in zwei Dungeons.",
	-- ["{quest:7625}, from {npc:14522}"] = "{quest:7625}, von {npc:14522}",
}
