-- German (deDE): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Ruf: Alteractal",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "Einmalige Quests im Wert von 2.000 und große Siege machen ihn zum schnellsten der vier; Ehrfürchtig gibt einen Vermächtnispunkt.",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "Master of Alterac Valley: ein Vermächtnispunkt bei Ehrfürchtig",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge (no name in this language: may be words)
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} ist eine Schlacht 40 gegen 40 ab Stufe 51 und der schnellste der vier Schlachtfeld-Rufe: Es gibt etwa 2.000 Ruf aus einmaligen Quests, und ein voller Sieg bringt einige hundert. Dieselben einmaligen Quests zahlen außerdem 1.870 Ruf bei {zone:1455}. {npc:13843} wirbt vor der {object:32372} Rekruten an. Der Vermächtnis-Vorteil „Diplomat“ von Forever fügt jeder Zahl in diesem Guide bis zu 10% hinzu.",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "Das Lager der Stormpike liegt vor dem Tor von {zone:1459}, auf der Seite von {zone:1416} oberhalb von {area:287}. Nimm hier jede Quest an: Alle zahlen einmalig 100 oder mehr.",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}: das {item:17849} in {area:3058}, 100",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}: einen Friedhof angreifen, 100",
	["destroy a tower or bunker banner, 100"] = "ein Banner eines Turms oder Bunkers zerstören, 100",
	["capture a mine, 100"] = "eine Mine erobern, 100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "Reihe dich am Tor, bei einem beliebigen Schlachtfeldmeister oder über den Schlachtfeld-Bildschirm in die Warteschlange ein; du betrittst das Schlachtfeld bei {area:2959} im Norden. Nimm vor dem Öffnen der Tore die Quests in der Stadt an: Sie werden während der Schlacht erledigt.",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058} liegt südwestlich von {area:2959}. Das {item:17849} steht hinten in der Höhle, hinter den Yetis und Harpyien.",

	-- Step 5: The battle
	["The battle"] = "Die Schlacht",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "Das meiste davon erledigst du auf dem Weg zu {npc:11946}. Plündere {quest:7223} von getöteten Spielern und Wachen der Horde. Greife den {area:3301} oder einen beliebigen Friedhof der Horde an, brenne einen Turm der Horde nieder (klicke sein Banner) und nimm {area:2963} ein. {npc:13154} steht bei {area:2962}, der {npc:13597} bei {area:2961}. {quest:7301} verlangt, dass du findest, wo die drei Flügelkommandanten gelandet sind. In Classic brachte jeder Turm, Friedhof oder jede Mine 12 Ruf, {npc:11947} 125 und {npc:11946} etwa 300.",
	["assault a graveyard"] = "einen Friedhof angreifen",
	["Iceblood Tower banner"] = "Banner des Eisblut-Turms",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "Position von {npc:13437}",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "Position von {npc:13439}",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "Position von {npc:13438}",

	-- Step 6: Back in Dun Baldar
	-- {area:2959} Dun Baldar
	["Back in {area:2959}"] = "Zurück in {area:2959}",

	-- Step 7: Back at the gate
	["Back at the gate"] = "Zurück am Tor",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Deine ersten Ehrenabzeichen von Alterac Valley gehören dem {npc:15351} neben {npc:13841}: 150 beim ersten Mal ({quest:8375}), danach 100 für je 3 weitere. Auch Forevers PvP-Ausrüstung kostet neben Ehre Ehrenabzeichen: Entscheide dich, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen von {zone:1459} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",
	["Alterac Valley Marks of Honor: play games"] = "Ehrenabzeichen von Alterac Valley: Spiele spielen",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} auf Freundlich",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "{npc:13816} am Tor will {npc:11946} tot sehen: Gewinne ein Spiel, in dem dein Team ihn tötet. Dann lässt er dich eine Waffe auswählen ({quest:8271}).",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}, 10 und eine Waffe",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "Bei Freundlich lässt {npc:13841} dein Abzeichen aufwerten: 100 Ruf. Von Freundlich bis Wohlwollend sind es 6000 Ruf. In Classic brachte ein voller Sieg mit seinen 3 Abzeichen 300 bis 700; der Brigadegeneral nimmt weiter 3 Abzeichen für 100. Im Schlachtfeld wiederholt sich {item:17354} (75, aus den Winterax-Höhlen) in jedem Spiel; {npc:12159} (200, wenn er in der Mitte des Tals erscheint) geht hier zurück an {npc:13841}. Freundlich schaltet den {item:19032} (1g) und die Überragenden Heil- und Manatränke (5s) bei {npc:13217} neben ihm frei.",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}, 1g",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}: nochmals {quest:8375}, 100 für 3 Abzeichen",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "Wohlwollend: Abzeichen Rang 3, 100 Ruf. Von Wohlwollend bis Respektvoll sind es 12000 Ruf. {npc:13217} neben {npc:13841} verkauft die Umhänge und Anhänger des Stormpike-Soldaten und des Weisen (je etwa 7g), die Stormpike-Gürtel (4g74s bis 7g12s) und die Großen Heil- und Manatränke (10s).",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}: 100 für 3 Abzeichen",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Respektvoll: Abzeichen Rang 4, 150 Ruf. Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, die Hälfte des Weges. Respektvoll schaltet die Waffen bei {npc:13217} frei: {item:19100}, {item:19102} und {item:19104} (31g65s bis 39g85s), und das {npc:14752} (5g). Ab Stufe 51 zahlt Concerted Efforts (je 3 Abzeichen von {zone:1459}, {zone:1461} und {zone:1460}) beim ersten Mal 200 und danach 150, dazu Ruf für die beiden anderen Schlachtfelder.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}: Concerted Efforts",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}: Belohnungen für Respektvoll",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Alterac Valley“ und die letzten beiden Abzeichen, 400 Ruf, die nur noch für das Abzeichen zählen. {npc:13217} verkauft {item:19030} (200g, Stufe 60; eigener Guide), {item:19325} und {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) sowie die Folianten und Nebenhandgegenstände für 50g.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}: Belohnungen für Ehrfürchtig",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} ist eine Schlacht 40 gegen 40 ab Stufe 51 und der schnellste der vier Schlachtfeld-Rufe: Es gibt etwa 2.000 Ruf aus einmaligen Quests, und ein voller Sieg bringt einige hundert. Dieselben einmaligen Quests zahlen außerdem 1.870 Ruf bei {zone:1454}. {npc:13842} steht im {object:172982}. Der Vermächtnis-Vorteil „Diplomat“ von Forever fügt jeder Zahl in diesem Guide bis zu 10% hinzu.",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "Das Lager der Frostwolf liegt vor dem Tor von {zone:1459} im Gebiet {zone:1416}. Nimm hier jede Quest an: Alle zahlen einmalig 100 oder mehr.",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}: das {item:17850} in {area:3337}, 100",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}: einen Friedhof angreifen, 100",
	["capture a tower or bunker, 100"] = "einen Turm oder Bunker erobern, 100",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "Reihe dich am Tor, bei einem beliebigen Schlachtfeldmeister oder über den Schlachtfeld-Bildschirm in die Warteschlange ein; du betrittst das Schlachtfeld bei {area:2961} im Süden. Nimm vor dem Öffnen der Tore die Quests im Dorf an: Sie werden während der Schlacht erledigt.",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337} liegt südlich von {area:2978}. Das {item:17850} steht hinten in der Höhle, hinter den Gnollen.",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "Das meiste davon erledigst du auf dem Weg zu {npc:11948}. Plündere {item:17422} von getöteten Spielern und Wachen der Allianz. Greife den {area:3301} oder einen beliebigen Friedhof der Allianz an, brenne einen Bunker der Allianz nieder (klicke sein Banner) und nimm {area:2957} ein. {npc:13320} steht bei {area:3304}, der {npc:13598} in {area:2959}. {quest:7302} verlangt, dass du findest, wo die drei Flügelkommandanten gelandet sind. In Classic brachte jeder Turm, Friedhof oder jede Mine 12 Ruf, {npc:11949} 125 und Vanndar etwa 300.",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "Banner von {area:3305}",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "Position von {npc:13179}",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "Position von {npc:13180}",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "Position von {npc:13181}",

	-- Step 18: Back in Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Back in {area:2961}"] = "Zurück in {area:2961}",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Deine ersten Ehrenabzeichen von Alterac Valley gehören dem {npc:15350} am Tor: 150 beim ersten Mal ({quest:8369}), danach 100 für je 3 weitere. Auch Forevers PvP-Ausrüstung kostet neben Ehre Ehrenabzeichen: Entscheide dich, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen von {zone:1459} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} auf Freundlich",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "{npc:13817} am Tor will {npc:11948} tot sehen: Gewinne ein Spiel, in dem dein Team ihn tötet. Dann lässt er dich eine Waffe auswählen ({quest:8272}).",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}, 10 und eine Waffe",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "Bei Freundlich lässt {npc:13840} dein Abzeichen aufwerten: 100 Ruf. Von Freundlich bis Wohlwollend sind es 6000 Ruf. In Classic brachte ein voller Sieg mit seinen 3 Abzeichen 300 bis 700; der Kriegshetzer nimmt weiter 3 Abzeichen für 100. Im Schlachtfeld wiederholt sich {item:17354} (75, aus den Winterax-Höhlen) in jedem Spiel; The Legend of Korrak (200, wenn er in der Mitte des Tals erscheint) geht hier zurück an {npc:13840}. Freundlich schaltet den {item:19031} (1g) und die Überragenden Heil- und Manatränke (5s) bei {npc:13219} neben ihm frei.",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}, 1g",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}: nochmals {quest:8369}, 100 für 3 Abzeichen",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "Wohlwollend: Abzeichen Rang 3, 100 Ruf. Von Wohlwollend bis Respektvoll sind es 12000 Ruf. {npc:13219} neben {npc:13840} verkauft die Umhänge und Anhänger des {npc:12051} und des Beraters (je etwa 7g), die Frostwolf-Gürtel (5g9s bis 7g66s) und die Großen Heil- und Manatränke (10s).",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}: 100 für 3 Abzeichen",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Respektvoll: Abzeichen Rang 4, 150 Ruf. Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, die Hälfte des Weges. Respektvoll schaltet die Waffen bei {npc:13219} frei: {item:19099}, {item:19101} und Frostbite (31g53s bis 39g71s), und das {npc:14751} (5g). Ab Stufe 51 zahlt For Great Honor (je 3 Abzeichen von {zone:1459}, {zone:1461} und {zone:1460}) beim ersten Mal 200 und danach 150, dazu Ruf für die beiden anderen Schlachtfelder.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}: For Great Honor",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}: Belohnungen für Respektvoll",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Alterac Valley“ und die letzten beiden Abzeichen, 400 Ruf, die nur noch für das Abzeichen zählen. {npc:13219} verkauft {item:19029} (200g, Stufe 60; eigener Guide), {item:19325} und {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) sowie die Folianten und Nebenhandgegenstände für 50g.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}: Belohnungen für Ehrfürchtig",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "Ehrfürchtig beim {faction:729} bringt einen Vermächtnispunkt.",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "Ehrfürchtig bei der {faction:730} bringt einen Vermächtnispunkt.",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "Volle Partien, in denen {npc:11946} nach dem Fall der Türme getötet wird, bringen am meisten.",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "Volle Partien, in denen {npc:11948} nach dem Fall der Türme getötet wird, bringen am meisten.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Gewinn weiter im {zone:1459}. Mehr Beute! ({npc:13176}), {item:17306} für {npc:13236} (es beschwört {npc:13256}) und Alteracwidderbälge für {npc:13441} sind alle wiederholbar.",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Gewinn weiter im {zone:1459}. Weitere {quest:7223} ({npc:13257}), Sturmkristalle für {npc:13442} (sie beschwören {npc:13419}) und Frostwolfbälge für den {npc:13577} sind alle wiederholbar.",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "Der {faction:729} hält {area:2978} im Süden des {zone:1459}. Türme zerstören, Friedhöfe und Minen einnehmen sowie Hauptmänner und Generäle töten bringt dem ganzen Team Ruf. Plündere {item:17422} von gefallenen Gegnern für {npc:13176}. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "Die {faction:730} hält {area:2959} im Norden des {zone:1459}. Türme zerstören, Friedhöfe und Minen einnehmen sowie Hauptmänner und Generäle töten bringt dem ganzen Team Ruf. Plündere {quest:7223} von gefallenen Gegnern für {npc:13257}. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{faction:729} to Exalted"] = "{faction:729} auf Ehrfürchtig",
	-- ["{faction:729} to Honored"] = "{faction:729} auf Wohlwollend",
	-- ["{faction:729} to Revered"] = "{faction:729} auf Respektvoll",
	-- ["{faction:730} to Exalted"] = "{faction:730} auf Ehrfürchtig",
	-- ["{faction:730} to Honored"] = "{faction:730} auf Wohlwollend",
	-- ["{faction:730} to Revered"] = "{faction:730} auf Respektvoll",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: Irondeep und {item:17542} aus den Minen",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: Coldtooth und {item:17522} aus den Minen",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}: Mehr Beute!",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: Eine Gallone Blut",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}: Weitere {quest:7223}",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}: Haufenweise Kristalle",
}
