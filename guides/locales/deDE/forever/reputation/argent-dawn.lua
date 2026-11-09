-- German (deDE): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Ruf: Argentumdämmerung",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "Scourgestones, {area:2057} und {area:2279}: die Schulterverzauberungen für Widerstand und ein Dutzend Rezepte.",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "Rezepte für Schneider, Lederer, Schmiede, Verzauberer und Alchemisten ab Wohlwollend und Respektvoll",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Allianz)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} steht in {area:3197}, im Süden von {zone:1422}. {object:2160} beginnt für alle bei Neutral 200. Trage das Kommissions-Schmuckstück, während du gegen die Geißel kämpfst: Scourgestones fallen nur, solange du es trägst. {npc:11039} bei {area:2268} gibt dieselbe Kommission; du kannst nur eine annehmen.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horde)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} steht an der {area:152}, an der Straße von {zone:1420} in die {zone:1422}. {object:2160} beginnt für alle bei Neutral 200. Trage das Kommissions-Schmuckstück, während du gegen die Geißel kämpfst: Scourgestones fallen nur, solange du es trägst. {npc:11039} bei {area:2268} gibt dieselbe Kommission; du kannst nur eine annehmen.",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "Von Neutral bis Freundlich: Geißel der {zone:1422}",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "Jeder Geißel-Kill im Pestland gibt 5 Ruf (benannte 15), ab den Ghulen und Skeletten der Stufe 50; auf Stufe 60 nimm die ab Stufe 53, denn graue Mobs geben in Classic nur etwa ein Fünftel. Von Neutral bis Freundlich sind es 2.800: etwa 560 Kills, weniger mit den Quests des Pestlands unterwegs. Die dichteste Geißel steht um die vier Geißelkessel: {area:199} westlich von Andorhal (Skelette, 50-53), {area:200} nördlich von Andorhal (Zombies und Ghule, 52-55), {area:202} im Süden (Ghule, 54-55) und {area:201} im Osten (Geister, 56-57). Behalte jeden Scourgestone und jede Quest, die du aufsparen kannst: Abgaben zählen immer, Kills nicht. {quest:5510} fallen bei etwa vier von zehn dieser Geißel, Invader's bei etwa einem Drittel der Mobs ab Stufe 56. Wenn du stirbst, lege die Kommission ab und wieder an: Sie kann ihre Wirkung verlieren. Paladine (Menschen und Zwerge): {npc:10838} in {area:3197} verlangt einmalig 20 {quest:5510} für Dispelling Evil, 100 Ruf statt 25. Der Vermächtnis-Vorteil „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}: behalte sie",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "Hungering Wraiths bei {area:201}; jede Geißel zählt",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "Soulless Ghouls an der {area:202}",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "Quests im Pestland und die Geißelkessel",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "Die Quests im Pestland zahlen auf 60 ab Stufe 55 voll und zählen immer, insgesamt etwa 1.500; die Level-Guides gehen sie ab. Die Kesselkette von {npc:11053} in {area:3197} (Horde: {npc:11055} an der {area:152}): 150 pro Kessel mit seiner Rückgabe, dann Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, Elite). Bei {area:2268}: die {area:2262}-Quests von {npc:11063} (Brother Carlin 50 von Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) und Hidden Treasures 200 von {npc:10926} am Ende der Geschichte von {area:2262}; {npc:12250} 75 von {npc:11038}. Nach Mission Accomplished! nimmt jeder Kessel eine wiederholbare Lieferung an: jedes Mal 25 Ruf, bis Ehrfürchtig. {npc:11056} in {area:3197} (Horde: {npc:11057} an der {area:152}) gibt dir einen {item:13370}, ohne den die Reagenzien nie fallen, und verkauft Arcane Quickeners für 50 Silber (einen pro Lieferung; er zerfällt nach 30 Minuten, kaufe ihn also zuletzt). Jede Lieferung nimmt außerdem 4 {item:14047} auf. Farme {area:201}: Seine Geister lassen etwa jedes vierte Mal einen {item:13354} fallen, etwa 16 Kills füllen also eine Lieferung; die anderen Kessel wollen 5 oder 6 Reagenzien, die bei einer von zehn Beuten oder seltener fallen. Sobald die Geißel im Pestland nicht mehr zählt, bringt das etwa viermal so viel wie ihre Scourgestones allein.",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}: frage nach einem {item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057} an der {area:152}: frage nach einem {item:13370}",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}"] = "der Kessel bei {area:201}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "Ectoplasmic Resonators: die Geister um den Kessel",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}, 50 Silber",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "Quests in {area:2268}",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "{area:2268}, auf der Ostseite von {zone:1423}, ist die Heimat von {faction:529}: {npc:11039}, {npc:11035} und {npc:243254} geben seine Dungeon-Quests, je 100 bis 200 Ruf und insgesamt etwa 1.700. Es sind Gruppenquests für {area:2279} und {area:2057} (Stufe 58-60, fünf Spieler): Nimm die an, die deine Gruppe laufen wird. Die Kette des Herzogs endet am {object:176317}, einer Truhe mit Ausrüstung von {faction:529}.",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} ist ein Dungeon für fünf Spieler am Nordende von {zone:1423}. Seine Geißel gibt 5 Ruf pro Kill bis zum letzten Punkt von Wohlwollend, seine Geißel-Bosse 25 bis Ehrfürchtig ({npc:10440} 50), jeder mit einem {item:12843}. Die Black Guard Sentries beim Baron geben 5 bis Ehrfürchtig. Die Seite der Geißel, durch den Dienstboteneingang, zahlt weit mehr als die Seite der Scharlachroten.",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "Plagued Flesh Samples: die Geißel im Inneren",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}: die Vorratskisten",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}, Seite der Scharlachroten",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}; die Quests für {area:2057} deiner Seite geben den {item:13704}, der es öffnet. Es ist der beste Durchlauf für {faction:529}: Seine Mobs geben 5 bis zum letzten Punkt von Wohlwollend, seine dreizehn Bosse bei vollem Clear etwa 375 Ruf, dazu etwa zehn {quest:5508} (rund 250 mehr). {npc:10508} und {npc:1853} geben je 50.",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529} in der Brutstätte",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "Zurück in {area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} führt zu {quest:5213} (die {item:13176} in einem Ziggurat von {area:2279}), die das {item:13209} oder die {item:19812} als Belohnung gibt: bessere Schmuckstücke, die ebenfalls Scourgestones fallen lassen, sie können also die Kommission ersetzen. {quest:5251} führt weiter zum {item:13250} und zu {npc:10440}. Eine {item:13920}, ein seltener Beutefund (etwa 6%) der {quest:5529}, sobald {quest:5529} erledigt ist, startet eine Quest, die jedes Mal 50 wert ist: Behalte sie bis Respektvoll. {npc:10267} in der {zone:1428} schickt dich am Ende ihrer Quests in {area:1583} zu {npc:243254} (75) und weiter zu {item:12368} von {npc:11035} in {area:2057} (25 und 200).",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "Von Freundlich bis Wohlwollend: Steine und benannte Geißel",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "Normale Geißel außerhalb der Dungeons gibt nach der Hälfte von Freundlich keinen Ruf mehr (3.000 von 6.000); {npc:10826}, {npc:10821} und {npc:10825} hören am Ende von Freundlich auf. Danach zählen nur noch Araj, die Mobs von {area:2057} und {area:2279}, die Kessellieferungen und Scourgestones. Gib jetzt die aufgesparten Steine ab: {npc:11039} bei {area:2268} nimmt alle drei Arten an, ebenso die Offiziere in {area:3197} und an der {area:152}. Jede Abgabe zahlt 25 und ein {item:12844}: Behalte 35 Marken für die Mäntel bei Respektvoll und Ehrfürchtig. {quest:5509} sind pro Stein doppelt so viel wert: Die Dark Adepts, Shadowmages, Dread Weavers und Scourge Champions (Stufe 58-60) in {area:2272}, nördlich von {area:2268}, lassen sie etwa bei jedem dritten Mal oder öfter fallen, direkt neben der Abgabe. Die benannte Geißel unten lässt in der Hälfte der Fälle oder öfter einen {item:12843} fallen ({npc:1850} zwei von drei Mal, Araj und {npc:10821} die Hälfte der Zeit) und gibt 15 pro Kill, Araj bis Ehrfürchtig; {npc:1850} gibt keinen Ruf, nur den Stein. Freundlich schaltet die Enriched Manna Biscuits (60 Silber) bei den Rüstmeistern frei.",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}: die benannte Geißel unten und Dungeon-Bosse",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "Dark Adepts und Shadowmages bei {area:2272}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}, Andorhal",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}, {zone:1422}: nur der Stein",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}: 20 für 25 Ruf",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}: 10 für 25 Ruf",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}: 1 für 25 Ruf",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "Von Wohlwollend bis Respektvoll: Dungeons und Steine",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "Von Wohlwollend bis Respektvoll sind es 12.000: etwa 2.400 Mobs aus {area:2057} und {area:2279}, weniger mit ihren Bossen. Ihre Mobs hören bei 11.999 von 12.000 Wohlwollend auf; ein Boss oder eine Abgabe bringt dich darüber. Allein zählen nur Scourgestones, die Kessellieferungen und Araj: 12.000 sind 480 Abgaben oder 4.800 {quest:5509}. Behalte die Steine aus den Dungeons, bis deren Mobs nicht mehr zählen. Wohlwollend schaltet Rezepte bei allen drei Rüstmeistern frei: {npc:11536} bei {area:2268}, {npc:10857} in {area:3197}, {npc:10856} an der {area:152}. Außerdem das {item:22014} (133 Gold) für die Quest Three Kings of Flame.",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}, 3 Gold",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216} ({skill:197}), 2 Gold 20 Silber",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328} ({skill:165}), 2 Gold 20 Silber",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203} ({skill:164}), 2 Gold 20 Silber",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482} ({skill:171}), 1 Gold 50 Silber",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442} ({skill:129}), 10 Gold",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "Bei Respektvoll nimmt {npc:11536} 10 Argent Dawn Valor Tokens für {quest:5504} an (100 Ruf). Danach verkauft jeder Rüstmeister von {faction:529} die fünf Schulterverzauberungen für je 10 Gold: Feuer, Frost, Arkan, Natur und {item:18173}, +5 auf diesen Widerstand. Respektvoll schaltet außerdem die {item:13810} und ihren Saft (60 Silber) und die Rezepte für Respektvoll frei.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "Argent Dawn Valor Tokens, aus den Steinabgaben",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}: wähle den Widerstand, den du brauchst, 10 Gold",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}, 6 Gold",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217} ({skill:197}), 4 Gold",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329} ({skill:165}), 4 Gold",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205} ({skill:164}), 4 Gold",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "Von Respektvoll bis Ehrfürchtig",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000: 840 Abgaben von Scourgestones oder Kesseln, oder die Dungeon-Bosse mit ihren {quest:5508} (ein voller Clear von {area:2057} bringt etwa 600). Gib jeden aufgesparten Stein und jede {item:13920} ab.",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "Bei Ehrfürchtig nimmt {npc:11536} 25 Argent Dawn Valor Tokens für die {quest:5517} an (150 Ruf): +5 auf alle Widerstände, auf deinen Schultern. Danach verkaufen die Rüstmeister weitere für je 40 Gold.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "Argent Dawn Valor Tokens",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "Geißelsteine des Verderbers und Dungeons bis Respektvoll",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen hier Geißelsteine des Eindringlings fallen, dazu Geißelsteine des Dieners und {item:14047}. Gib die des Eindringlings zu je 10 und die des Dieners zu je 20 bei {npc:11039} in der {area:2268} ab. In Classic bringen beide ab Wohlwollend keinen Ruf mehr.",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "Ab Wohlwollend bringen Geißelsteine des Verderbers (einer pro Abgabe) und getötete Gegner der Geißel in {area:2279} und {area:2057} den Ruf. Geißelsteine des Verderbers fallen bei den Bossen der Geißel dort ({npc:1853}, {npc:10433}, Vectus) sowie bei {npc:1852} und Putridius in den {zone:1422}. Viele Dungeonläufe lohnen sich schneller als jedes Farmen in der offenen Welt.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Ghule und Skelette überall in den {zone:1422} lassen in etwa jedem zweiten Fall Geißelsteine des Dieners fallen; hier stehen sie dicht. Gib sie zu je 20 bei einem beliebigen Argentumoffizier ab (Argentumoffizier Pureheart im {area:3197}, Argentumoffizier Garush am {area:152}, {npc:11039} in der {area:2268}). Jede Abgabe bringt auch ein {item:12844} für die Rüstmeister der Argentumdämmerung.",
	-- ["Invader's Scourgestones to Honored"] = "Geißelsteine des Eindringlings bis Wohlwollend",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Lauf weiter {area:2279} und {area:2057} und gib jeden {item:12843} in der {area:2268} ab, bis du ehrfürchtig bist.",
	-- ["Minion's Scourgestones to Friendly"] = "Geißelsteine des Dieners bis Freundlich",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Lauf {area:2279} (beide Flügel) und {area:2057} und töte jeden Gegner der Geißel auf dem Weg.",
	-- ["{faction:529} to Exalted"] = "{faction:529} bis Ehrfürchtig",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "Bei {object:2160} beginnst du neutral. Hol dir die Ernennung bei {npc:10839} am {area:152} und leg sie an: In Classic fallen Geißelsteine nur, solange das Schmuckstück aus {quest:5401} angelegt ist. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "Bei {object:2160} beginnst du neutral. Hol dir die Ernennung bei {npc:10840} im {area:3197} und leg sie an: In Classic fallen Geißelsteine nur, solange das Schmuckstück aus {quest:5401} angelegt ist. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",
}
