-- German (deDE): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Ruf: Orgrimmar",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "Quests in {zone:1411} und am Crossroads beim Leveln, Quests in {zone:1448} und {zone:1447} ab 55, dann {item:14047} bis Ehrfürchtig.",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "Ehrfürchtig bei {faction:76}",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76}: so funktioniert es",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "Der Ruf bei {faction:76} kommt von Quests und Stoff. {npc:14726}, die Stoff-Rüstmeisterin, steht im Drag neben dem Laden für Stoff- und Lederrüstung. Sie nimmt vier einmalige Spenden von je 60 Stoff (je 150) an und danach {quest:7832}, 20 {item:14047} für 50, so oft du willst. Jeder Punkt, den du bei {faction:76} verdienst, gibt außerdem ein Viertel davon an {zone:1456}, die {zone:1458} und die Darkspear-Trolle. Während du levelst, mach die Quests von {faction:76} innerhalb von 5 Stufen: {zone:1411} bei 5 bis 12, das Crossroads bei 12 bis 20, {npc:4949}s {quest:5726} bei 12 bis 16. Der Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr. Belohnungen: Bei Wohlwollend verkaufen dir die Händler von Orgrimmar 10 % günstiger (die Classic-Regel), der Wolfshändler eingeschlossen; bei Ehrfürchtig können auch andere Völker die Wölfe kaufen: 20 Gold für einen Wolf der Stufe 40, 200 Gold für einen schnellen Wolf auf Stufe 60, sobald du die Reitausbildung hast. {faction:76} hat keinen Wappenrock und keine andere Belohnung.",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (optionaler Knotenpunkt)",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Forever zahlt diese alten Quests auf jeder Stufe voll aus. Das {area:363} ist das Beste davon: etwa 1.400 {faction:76} und 1.400 Darkspear-Ruf in 25 Minuten. {npc:3143} wartet in der Höhle, der großen Hütte; {npc:10176} steht davor.",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144} in {faction:76}: {quest:787}, +50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}: {quest:792}, nur Hexenmeister",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "Eber, Waffen und Peons",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "Die Übungswaffen liegen in der Höhle auf dem Boden und zwischen den Ebern im Norden. Für die Peons: Wähle einen schlafenden {npc:10556} als Ziel und benutze den {item:16114} an ihm.",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}: schlag ihn mit dem {item:16114}",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "Wecke {npc:10556}",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}: abgeben",

	-- Step 5: North of the Den
	["North of the Den"] = "Nördlich der Höhle",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "Die Kaktusäpfel wachsen neben den Kakteen nördlich der Höhle. {npc:3287} liegt verwundet bei den Felsen im Norden; {quest:790}, sein großer Skorpid, streift in der Nähe umher. {quest:792} wimmeln am Eingang des {area:365}; {quest:6394} liegt darin: Nimm den mittleren Tunnel, wo er sich dreifach teilt.",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}, in der Höhle",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}: erneut abgeben",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "Geh zurück in die Höhle und halte dich die ganze Zeit an die rechte Wand, über einen kleinen Bach, bis zu {npc:3183} auf einem Felsvorsprung über einem Teich.",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}, von {npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}, in der Höhle",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "{quest:805}, +50: {quest:97225} wartet darauf",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367} (optionaler Knotenpunkt)",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Forever zahlt diese alten Quests auf jeder Stufe voll aus. {area:367} und die {area:368}: etwa 700 {faction:76} und 650 Darkspear-Ruf in 25 Minuten. {npc:3188} und {npc:3304} stehen bei den Hütten, {npc:3194} am Wasser, {npc:7953} südlich des Dorfes.",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "{quest:97225}, +100: braucht {quest:805} aus der Höhle",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "Die {area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "Schwimm zur größten der {area:368}, südöstlich des Dorfes. {quest:826}, die Idole und die Schädel am Kreis der Macht sind alle dort; die Durotar-Tiger streifen über die kleineren Inseln.",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}: klicke einen {object:3237}-Schädel an",

	-- Step 11: The coast and the road
	["The coast and the road"] = "Die Küste und die Straße",
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Makrura und Brandungskrebse laufen an den Stränden östlich und südlich von Sen'jin. Die {quest:97223} ist östlich des Dorfes. Die Ridgeshade-Spinnen sind an der Straße südlich von {area:362} und nordöstlich der Höhle.",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}: abgeben",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949}: {quest:5726} (optionaler Knotenpunkt)",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "Forever zahlt diese alten Quests auf jeder Stufe voll aus. {quest:5726}: 400 Ruf bei {faction:76} in 20 Minuten, mit einem Durchlauf durch {area:2437}, den ein Spieler der Stufe 60 allein schafft.",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827}: das {item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827} ist die Höhle gleich östlich von {faction:76}. Die Burning Blade Fanatics und Apprentices darin lassen das Abzeichen bei etwa jedem fünften Kill fallen.",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76}: {npc:4949} und {npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216} ist in der {object:172960}. Sag ihm, er darf offen sprechen, und klick dich durch seine Geschichte.",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216}: hör ihn an",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "{area:2437} geht von der {object:172960} ab. {npc:11518} und {npc:11519} warten am anderen Ende.",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518} und {npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76}: {quest:5728} erledigt",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}: Abgaben bei Sen'jin",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (optionaler Knotenpunkt)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "Forever zahlt diese alten Quests auf jeder Stufe voll aus. {area:362} und das nördliche {zone:1411}: etwa 1.800 {faction:76} und 1.650 Darkspear-Ruf in 80 Minuten. {npc:3142} und {npc:3139} stehen mitten in der Stadt, {npc:3191} bei der Kaserne, {npc:3147} und {npc:266940} an den Rändern.",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100: braucht {quest:823} aus Sen'jin",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "Die Festung liegt südlich von {area:362} an der Küste. {npc:3192} ist im einzigen Gebäude der Festung; sein Schlüssel öffnet {object:3239} auf dem Dach, und der {item:4881} darin startet {quest:830}. Die Seeleute und Marinesoldaten lassen die {item:4870} fallen; der {item:275713}, Battleaxe und Shield liegen vor der Festung.",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} und die {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Die Lager der Razormane sind südwestlich und westlich von {area:362}; dazwischen wachsen die Prickly-Pear-Kakteen. Dann geh zu den {area:368} für die {object:3240}: Jedes Nest gibt jedes Mal ein Ei.",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}: abgeben",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}, +100: zu {npc:3230} in {faction:76}",

	-- Step 23: The wreck
	["The wreck"] = "Das Wrack",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "Das gestrandete Schiff liegt im Flachwasser östlich von {area:372}. Öffne die Gnomish Toolboxes.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "zurück bei {npc:3139} in {area:362}",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Nördliches {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} steht an der Straße nördlich von {area:362}, {npc:3193} auf ihrer Farm westlich davon.",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} und {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} hat ein Lager der Burning Blade in {area:369}, südlich von {faction:76}, zwischen den Donnerechsen. Die Vorratssäcke liegen in {area:410}, nördlich von {area:362}. {item:4891} lassen die Krokilisken am Fluss im Westen fallen, etwa jeder zehnte.",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} und Misha",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "Ein {npc:3118} lässt vielleicht einen {item:277661} fallen: Benutze ihn, um {quest:97281} zu starten. Sobald du die abgegeben hast, bietet {npc:3293} {quest:97282} an.",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, in {area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "Die Charged Thunder Lizard Organs stammen von den Donnerechsen auf {area:369}, gleich westlich von {npc:3293}.",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828} lagert vor {quest:827}, der Höhle gleich östlich von {faction:76}.",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76}: {npc:3216} und {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829} ist in der {object:172960}; {npc:3230} in der Halle Grommash neben {npc:4949}.",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Lauf durchs Westtor von {faction:76} und über die Brücke ins {zone:1413}. {npc:3337} und {quest:809} stehen bei {area:379}.",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}, +100: zu {npc:3338}",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380} (optionaler Knotenpunkt)",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "Forever zahlt diese alten Quests auf jeder Stufe voll aus. {area:380}: etwa 1.500 Ruf bei {faction:76} in 70 Minuten, nur bei {faction:76}. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} und {npc:267310} stehen in der Stadt, {npc:3432} beim Gasthaus.",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "Rund ums Crossroads",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "Die Lager der Razormane und die Vorratskisten liegen nordöstlich der Stadt; {npc:267307}, ein Elite-Eber, sitzt tief in der Höhle von {area:1699} dort. Die Witchwing-Harpyien nisten weit im Nordwesten. Die {npc:10668} liegt nordöstlich von {area:378}, im Süden: Klick sie mit rechts an. Raptoren und Plainstrider sind überall.",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668}: Rechtsklick",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380}: abgeben",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "Zhevras, Stacheleber, Harpyien und die {area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "Zhevra Runners grasen südlich und westlich der Stadt. {npc:3438} führt die Lager der Razormane im Nordosten an. Die Witchwing Slayers tragen die Ringe. Die {quest:3281} ist in den {area:1697} östlich von {area:378}: Folge dem von Nestern gesäumten Pfad auf seiner linken Seite bis zum letzten Nest.",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380}: erneut abgeben",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "Prowlers, {npc:3452} und {quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "Savannah Prowlers sind westlich und nördlich des Crossroads. {quest:876} führt die Witchwing-Harpyien im äußersten Nordwesten an. Dann gibt dir {npc:3338} das {item:10327}: Blas es neben den Kodoknochen bei {object:147524}, nördlich der Stadt, und töte den weißen Löwen.",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819} (optionaler Knotenpunkt)",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "Forever zahlt sie auf jeder Stufe voll aus. {quest:819} liegt an einer von mehreren Stellen im mittleren und nördlichen {zone:1413} auf dem Boden, die meisten an den Straßen rund ums Crossroads; sobald jemand es nimmt, taucht es woanders auf. {npc:3292} in {area:392} zahlt 250 Ruf bei {faction:76} für das Fass und seine erste Füllung, dann 50 für jede weitere, so oft du willst.",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819}: such es an den Straßen",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "Löwen, Plainstrider und eine Donnerechse",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "Savannah-Löwen, Plainstrider und Donnerechsen streifen durch das gesamte nördliche {zone:1413}. Die Löwen lassen etwa bei jedem zweiten Kill einen Hauer fallen, die Plainstrider etwa bei zwei von fünf Kills eine Niere; jede Donnerechse kann das Horn fallen lassen, etwa jede fünfte.",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392}: das wiederholbare Fass",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "Ab jetzt nimmt Drohn 5 Lightning Glands, eine {item:4897} und eine {item:4896} für 50 an, so oft du willst. Die Donnerechsen {npc:3238} (etwa jeder zweite Kill gibt eine Drüse), die Greater Thunderhawks und die Kodos südlich von {area:378} lassen sie fallen. Sammle mehrere Sätze, bevor du zurück nach {area:392} gehst.",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}, von Stormhides",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}, von Greater Thunderhawks",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}, von den Kodos",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Ab hier geht es um Stoff. Wolle, Seide und Magiestoff müssen alle abgegeben sein, bevor {npc:14726} die {item:14047}-Spende anbietet, und {quest:7832} braucht die {item:14047}-Spende. Kauf Stoff im Auktionshaus oder farme ihn: Humanoide lassen ihn fallen, Wolle von Stufe 15 bis 25, Seide 25 bis 40, Magiestoff 40 bis 50, {item:14047} ab 50. Auf 60 farme Mobs ab Stufe 52: niedrigere sind grau.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: die Thistlefur-Furbolgs lassen ihn bei etwa jedem vierten Kill fallen",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seide: die Syndicate in {area:287} und Alterac lassen sie bei etwa jedem dritten Kill fallen, oder kauf sie.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: die Syndicate",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Magiestoff: die Jadefire-Satyrn im Süden von {zone:1448} und die Dunemaul-Oger in {zone:1446} lassen ihn bei etwa jedem dritten Kill fallen, oder kauf ihn.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: die Jadefire-Satyrn",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: die Scharlachroten bei {area:2266} im {zone:1423}, die Gordok-Oger vor {area:2577} in {zone:1444} und die Lager der Twilight in {zone:1451} lassen ihn bei etwa jedem dritten Kill fallen. Das Auktionshaus geht schneller, wenn du Gold hast.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: die Scharlachroten vor {area:2266}",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "Diese Quests sind Stufe 56 bis 59, werden also auf 60 voll ausgezahlt. {npc:10306} steht bei {area:1997}; die Eulenbestien leben in {zone:1452}, durch den Timbermaw-Tunnel nördlich von {zone:1448}.",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452}: Eulenbestien",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "Raging Owlbeasts nordwestlich von {area:2255}, Ragged Owlbeasts weiter westlich.",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997}: abgeben",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452}: Moontouched-Eulenbestien",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "Moontouched Owlbeasts nördlich von {area:2255} und südlich davon.",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997}: erneut abgeben",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452}: Berserk-Eulenbestien",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "Die meisten Berserk Owlbeasts sind nördlich von {area:2255}. Jetzt kann eine {item:12558} von den Eulenbestien fallen: Benutze sie, um {quest:4882} zu starten.",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997}: letzte Abgabe",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}, +100 {zone:1456}: zu {npc:5770} auf {area:1639} in {zone:1456}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721}: 300 Ruf bei {faction:76}.",

	-- Step 54: Belgrom Rockmaul: Betrayed
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {object:173084} Hall of the Brave (no name in this language: may be words) · {quest:3504} Betrayed
	["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay in full at 60 too, as every quest does in Forever."] = "{npc:4485} steht im {object:172958} vor der {object:173084}. Die ersten beiden {quest:3504}-Quests sind Stufe 53 und werden auch auf 60 voll ausgezahlt, wie jede Quest in Forever.",

	-- Step 55: Valormok
	-- {area:1237} Valormok · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist
	["Fly to {area:1237} in western {zone:1447}. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "Flieg nach {area:1237} im westlichen {zone:1447}. {npc:8576} schickt dich nordöstlich zum Lager der Blutelfen auf den Klippen der nördlichen Halbinsel.",

	-- Step 56: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "Töte die Reclaimers und Surveyors und geh dann zum Buch im Ring aus Steinsäulen. Lies dort das {object:151286}, um die nächste Quest zu starten: Zerbrich die Kristalle um den Kreis, töte die Wache, die kommt, dann {npc:8578}.",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "Finde das Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["the {object:151286}"] = "das {object:151286}",

	-- Step 57: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237} und {faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485} in {faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506}: 300 Ruf bei {faction:76} auf 60.",

	-- Step 58: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Schwarzfels, mit einer Gruppe",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{area:340} in den {zone:1418} vergibt Quests von {faction:76} für {area:1584} und {area:1583}, alle Stufe 58 bis 60 und voll ausgezahlt: Precarious Predicament und Operation: Death to Angerforge (je 150), {quest:4724} und {item:12652} (je 100), {quest:4903} (150), {npc:3144}s Wisdom (100) und For The Horde! (Rends Kopf, 200 für jede Horde-Stadt). Das sind Dungeon-Quests: Nimm sie an, wenn deine Gruppe losgeht.",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077}: {quest:4903}, +150, eine Gruppe aus fünf",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081}: {quest:4724}, +100, eine Gruppe aus fünf",

	-- Step 59: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} bis Wohlwollend",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832}: 20 {item:14047} für 50 Ruf, so oft du willst. Von Freundlich bis Wohlwollend sind es 6.000: 120 Abgaben, 2.400 {item:14047}, abzüglich dessen, was die Quests dir gegeben haben (ein Orc startet bei Freundlich 1.000: 100 Abgaben; ein Untoter oder Himmelsgeborener startet bei Neutral 2.000 und braucht zuerst 20 Abgaben, 400 {item:14047}, um Freundlich zu erreichen). Gib jedes Mal 20 ab, die du dabeihast, eine Abgabe nach der anderen.",

	-- Step 60: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} bis Respektvoll",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "Von Wohlwollend bis Respektvoll sind es 12.000: 240 Abgaben, 4.800 {item:14047}. Der Auktionshauspreis eines Stapels entscheidet, ob du farmst oder kaufst.",

	-- Step 61: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} bis Ehrfürchtig",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000: 420 Abgaben, 8.400 {item:14047}. Auch Schlachtzug-Köpfe zahlen: The Lord of Blackrock (Nefarian) 200 für jede Horde-Stadt und Victory for the Horde (Onyxia) 400 für {faction:76}. Bei Ehrfürchtig verkauft {npc:3362} im {object:172958} die Wölfe an jedes Horde-Volk: 20 Gold für einen Wolf der Stufe 40, 200 Gold für einen schnellen Wolf auf Stufe 60 (Forevers Preise); in Classic mussten andere Völker Ehrfürchtig sein, um sie zu kaufen.",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362}: die Wölfe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder Kill der Geißel hier zählt auch für die {object:92525} (siehe diesen Guide). Das Auktionshaus geht auch.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7832} ab, bis {faction:76} auf Ehrfürchtig ist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7832} ab, je 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Kolkar-Zentauren (Stufe 30-33) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Vollstrecker der Venture Co. in der {area:381} (Stufe 16-17) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} nimmt Stoff für {faction:76} in {faction:76} an. Die ersten Spenden von Wollstoff, Seidenstoff, Magiestoff und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach ist {quest:7832} bis Ehrfürchtig wiederholbar. Ehrfürchtig bei der Stadt eines anderen Volkes erlaubt dir, dessen Reittiere zu kaufen. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726}: {item:14047} abgeliefert",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832} nimmt 20 {item:14047} pro Abgabe und ist beliebig oft wiederholbar. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
}
