-- German (deDE): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Ruf: Gelkis und Magram (Zentauren)",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Die verfeindeten Clans von {zone:1443}, in Forever überarbeitet: Such dir einen aus, kaufe seine Freundschaft und tausche Totems gegen Rezepte.",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "12 Rezepte für {quest:93224} bei den Clan-Rüstmeistern, kein Rufrang nötig",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "{npc:5601}s Quest: ein Clantitel und die Wahl aus drei seltenen Waffen der Stufe 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Such dir deinen Clan aus",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "Die Gelkis (im Südwesten von {zone:1443}) und die Magram (im Südosten) sind im Krieg: Jeder Kill an einem Clan gibt dem anderen 20 und kostet den eigenen Clan 100, und jede Quest eines Clans kostet den anderen das Fünffache dessen, was sie einbringt (Buying Friendship: 3.000 für deinen, 15.000 Abzug beim anderen), du kannst also nur bei einem aufsteigen. Beide beginnen bei Neutral. Forevers Quests sind jetzt weit mehr wert als Kills. Allianz: {npc:5396} in {area:608} bietet {quest:1382} (Gelkis) und {quest:1385} (Magram) an. Horde: {npc:5412} bietet {quest:1368} und {quest:1367} an. Nimm die Quest deines Clans und {quest:93224} an: Das Buying Friendship jedes Clans (3.000) wird angeboten, sobald du die Totems zurückbringst. Dann hake die Aufgabe ab. Der Guide geht bei den Gelkis weiter; nimmst du stattdessen die Quests der Magram, wechselt er in die Magram-Hälfte. Forever zahlt diese Quests auf jeder Stufe voll aus.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}: Gelkis",
	["Take the quests of one clan"] = "Nimm die Quests eines Clans an",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "Die Kolkar-Zentauren (Stufe 30-33) in den Lagern entlang der östlichen Straße, südlich von {area:608}, lassen die Totems fallen, ebenso die Magram und die Maraudine. Bring fünf zurück, dann nimm das Buying Friendship deines Clans an (Gelkis unten; für die Magram stattdessen das der Magram).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: Kolkar-Zentauren",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "Gelkis oder Magram",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "Keine Quests eines Clans in deinem Questlog: Der Guide geht bei den Gelkis weiter. Für die Magram nimm ihre Wahl-Quest und Buying Friendship an, dann wechselt der Guide in die Magram-Hälfte.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "Gelkis: die Wahl-Quest",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "Die Gelkis-Hälfte beginnt mit der Wahl-Quest des Clans bei dem Questgeber, dem du gerade die Totems abgegeben hast: Die Quests von {npc:5397} in {area:606} folgen daraus, und Buying Friendship allein schaltet sie nicht frei.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}: {npc:5397} und {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} liegt in den Hügeln im Südwesten von {zone:1443}; {npc:5397} steht in seiner Mitte. {npc:253140}, der Rüstmeister der Gelkis, ist am Südende des Dorfes. Allein Buying Friendship bringt dich von Neutral auf Freundlich.",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis: die Lager der Kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Die Kolkar-Zentauren (Stufe 30-33) halten die Lager südlich von {area:608}, entlang der östlichen Straße. Etwa jeder vierte lässt ein {item:6079} fallen.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}: Kolkar-Zentauren",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "Gelkis: {area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "Die Sacks of Meat liegen rund um {area:604}, im Südosten. Jeder Magram, den du unterwegs tötest, bringt den Gelkis 20.",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069}: von den Sacks of Meat",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640}: 20 Gelkis",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641}: 20 Gelkis",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis: {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "Zurück zu {npc:5397}, dann nach Osten in den {zone:1435}: {quest:1373} (Stufe 37) wartet an einem schwarzen Kessel in {area:76}, nordöstlich von {area:75}.",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis: Totems und Kills bis Wohlwollend",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 4.000 darin, es fehlen also 2.000. {npc:253140}s {quest:92812} nimmt 5 {quest:93224} für 750 an, immer wieder: drei Abgaben, 15 Totems. Die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen; die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Magram bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf außerdem drei Handwerksaufträge für je 1.000: Halea will 3 Große mystische Essenzen, {npc:253140} eine {item:10008} (Schneiderei) und Talra ein {item:5739} (Lederverarbeitung). Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}: Maraudine-Zentauren",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "Gelkis: {npc:5397} schickt dich ins Tal",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "Auf Wohlwollend und ab Stufe 35 schickt dich {npc:5397} nach Osten zu {npc:253177}, einem Späher der Gelkis am westlichen Eingang von {quest:93034}, wo der Süden von {zone:1443} in {zone:2652} übergeht. Die Schritte im Tal folgen den Questdaten von Forever: Noch hat niemand, der sein Spiel aufzeichnet, diese Quests gemacht, ein Ort oder die Reihenfolge kann also danebenliegen. Jede Quest im Tal verlangt, dass du bei den Gelkis auf Wohlwollend bleibst, und jede kostet die Magram das Fünffache dessen, was sie einbringt. Von Wohlwollend bis Respektvoll sind es 12.000; das Tal bringt 10.625 davon, {quest:92811} den Rest.",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "Gelkis: {npc:253177}",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "Aus den Questdaten: {npc:253177} wartet am westlichen Eingang des Tals. Er will, dass sechs Untote Verwüster zur Ruhe gebracht werden, und das Ritualgewand eines {npc:11559}: Die Ausgestoßenen sind Verbannte der Gelkis, die sich der Nekromantie der Magram zugewandt haben.",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "Gelkis: der Eingang des Tals",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Aus den Questdaten: Die Untoten Verwüster und {quest:92846} füllen das Tal von {npc:253177} nach Nordosten bis zum Posten von {npc:253136} an seinem nördlichen Eingang; Spieler haben sie überall auf dem Weg angetroffen. Die Magram von {npc:253136} sind einem Freund der Gelkis feindlich gesinnt. Leichenfresser (Elite, Stufe 45) laufen durch das Tal und greifen jeden an.",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "Gelkis: {quest:93041}",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "Aus den Questdaten: {npc:253177} gibt dir {item:255941}, um es {npc:5397} zu zeigen, zusammen mit {item:255945}, den du selbst findest: ein frisch verfluchter Schädel, gehortet im Kiefer eines der Riesenskelette des Tals. Die Spieldaten kennen keinen Ort dafür.",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "{item:255945}: im Kiefer eines Riesenskeletts",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "Gelkis: {npc:5397} und {npc:253713}",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "Aus den Questdaten: zurück nach Westen zu {npc:5397} in {area:606}. Sie braucht Tears of Theradras: {npc:253713}, die Stimme von Theradras, verwahrt sie in der Höhle im Süden des Dorfes, hinter {npc:253140}. Bitte sie im Namen von {npc:5397} darum und bring drei zurück. {npc:253140} nimmt unterwegs {quest:92812} an.",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "{npc:253713}, in der Höhle",
	["three Tears of Theradras"] = "drei Tears of Theradras",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "Gelkis: {quest:93045}",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "Aus den Questdaten: {npc:5397} gibt dir ihren Stab und {item:6071}. Füge sie zu {item:256061} zusammen, bring ihn zum Ritualplatz am Teich gleich östlich des Dorfes und brich den Fluch auf {item:255945}. Dann wieder nach Osten zu {npc:253177}.",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "Brich den Fluch auf {item:255945} am Teich",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "Gelkis: zurück zu {npc:253177}",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "Aus den Questdaten: {npc:253177} zahlt 500 und die Wahl aus drei Waffen für Stufe 35: {item:271794} (Stangenwaffe), {item:271795} (Zweihandschwert) oder {item:271799} (Dolch). Dann hat er zwei Aufträge tiefer im Tal.",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "Gelkis: das Herz des Tals",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "Aus den Questdaten: Östlich von {npc:253177}, im Herzen des Tals, halten die Magram Gelkis Captives fest: Befreie fünf. Zwischen ihnen liegen {npc:253446}, misslungene Beschwörungen, die im Boden feststecken: Bring acht mit {item:256061}, den dir die Quest gibt, zur Ruhe. Leichenfresser und Nekrokhane der Magram (Elite, Stufe 45) laufen durch das Tal und greifen einen Freund der Gelkis an: Lass sie vorbeiziehen, bevor du pullst.",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "Bring {npc:253446} zur Ruhe",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "Befreie fünf Gelkis Captives",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "Gelkis: {quest:93122}",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "Aus den Questdaten: Der nächste Befehl von {npc:253177} führt dich tiefer nach {zone:2652}, um zwei Orte auszukundschaften: {area:16675}, ein Lager der Magram südöstlich des Tals, und {area:16676}, das Lager der Verbannten westlich der Stadt der Shen'dralar, weiter südlich.",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "Gelkis: {area:16675} und {area:16676}",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "Aus den Questdaten: Geh in das Lager der Magram in {area:16675}, dann nach Südwesten in {area:16676}, wo Outcast Necrokhans (Elite, Stufe 45) Wache stehen. In einem Zelt dort bittet dich {npc:254040}, ein Gelkis, den die Ausgestoßenen festhalten, ihn herauszuholen: Eskortiere ihn aus dem Versteck und berichte dann {npc:253177}.",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "Eskortiere {npc:254040} aus dem Versteck",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "Gelkis: der letzte Befehl von {npc:253177}",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "Aus den Questdaten: Während die Krieger der Magram an der Front beschäftigt sind, sieht {npc:253177} eine Gelegenheit, an ihren Khan heranzukommen.",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis: {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "Aus den Questdaten: {npc:5601} (Stufe 37) führt die Magram von der Westseite von {area:604} aus an, nordöstlich von {npc:253177}. Das Dorf ist einem Freund der Gelkis feindlich gesinnt, und zwei Nekrokhane der Magram, Elite und Stufe 45, stehen ein Stück westlich des Khans. {npc:5397} zahlt 6.000, einen Titel und die Wahl aus drei seltenen Waffen der Stufe 35: {item:271801} (Zweihandaxt: Stärke, Ausdauer, Beweglichkeit), {item:271802} (Einhandstreitkolben: Stärke, Ausdauer, Beweglichkeit) oder {item:271805} (Nebenhand: Willenskraft, Intelligenz, Ausdauer). Die Quest kostet die Magram 30.000.",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis: Totems bis Ehrfürchtig",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "Ab Respektvoll bleibt nur noch {quest:92812}: Von Respektvoll bis Ehrfürchtig sind es 21.000, 28 Abgaben, 140 Totems. Für Ruf wird nichts verkauft; die Rezepte unten brauchen nur Totems.",

	-- Step 23: Gelkis done
	["Gelkis done"] = "Gelkis erledigt",
	["No Gelkis quests done: on to the Magram, south-east."] = "Keine Quests der Gelkis erledigt: weiter zu den Magram im Südosten.",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}: {npc:5398} und {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} füllt das Tal im Südosten von {zone:1443}; {npc:5398} steht an seiner Nordseite, {npc:253139}, der Rüstmeister der Magram, am See. Allein Buying Friendship bringt dich von Neutral auf Freundlich.",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram: die Lager der Kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Die Kolkar-Zentauren (Stufe 30-33) halten die Lager südlich von {area:608}.",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "Magram: {quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "Die Tears of Theradras sind Kristalle in der Höhle hinter {area:606}, im Südwesten. Jeder Gelkis, den du unterwegs tötest, bringt den Magram 20.",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369}: die Kristalle ({object:22246})",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648}: 20 Magram",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649}: 20 Magram",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram: {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} will einen {item:4392}: Ingenieure stellen ihn her (4 {item:4234}, ein {item:4389}, ein {item:4382} und eine {item:4387}); alle anderen kaufen einen. Er zahlt 1.000 und die Wahl aus zwei Ingenieurskunst-Bauplänen, dem {item:269900} oder dem {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}: von Ingenieuren hergestellt oder gekauft",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram: Totems und Kills bis Wohlwollend",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 3.000 darin (4.000 mit {quest:1371}), es fehlen also 2.000 bis 3.000. {npc:253139}s {quest:92811} nimmt 5 {quest:93224} für 750 an, immer wieder; die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen, und die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Gelkis bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf zwei Handwerksaufträge für je 1.000: Mirdas 3 Große Schattenschutztränke und Grolkars 2 Massive Eisenäxte (Schmiedekunst). {npc:5398}s {quest:92743} (1.000) ist kein Handwerksauftrag: Er will einen {item:254392} aus einer Gruft in den {zone:1418}, und Forevers Questseiten setzen ihn in seiner Reihe vor das {quest:92841}, bring ihn also mit, bevor du Wohlwollend erreichst. Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "Magram: {npc:5398} schickt dich ins Tal",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "Auf Wohlwollend und ab Stufe 35, nach {quest:92743}, schickt dich {npc:5398} zu {npc:253136} am Südende von {area:604}, dem nördlichen Eingang von {quest:92841}. Die Schritte im Tal folgen den Questdaten von Forever: Noch hat niemand, der sein Spiel aufzeichnet, diese Quests gemacht, ein Ort oder die Reihenfolge kann also danebenliegen. Jede Quest im Tal verlangt, dass du bei den Magram auf Wohlwollend bleibst, und jede kostet die Gelkis das Fünffache dessen, was sie einbringt. Von Wohlwollend bis Respektvoll sind es 12.000; das Tal bringt 11.125 davon, {quest:92811} den Rest.",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "Magram: {npc:253136}",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "Aus den Questdaten: {npc:253136} will Knochen von den Untoten Verwüstern des Tals (das Questlog zählt sie in Hunderten) und sechs {quest:92846} tot: Verbannte der Gelkis, die sich in die neue Magie der Magram einmischen.",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "Magram: der Eingang des Tals",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Aus den Questdaten: Die Untoten Verwüster und {quest:92846} füllen das Tal von {npc:253136} nach Südwesten bis zum Posten von {npc:253177} an seinem westlichen Eingang; Spieler haben sie überall auf dem Weg angetroffen. {npc:253177} ist ein Späher der Gelkis. Leichenfresser (Elite, Stufe 45) laufen durch das Tal und greifen jeden an.",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "Gently Cursed Bones: Untote Verwüster",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "Magram: {quest:92847}",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "Aus den Questdaten: {npc:253136} will drei {item:254841} von den verfluchten Bäumen des Tals (die Spieldaten kennen keinen Ort dafür) und drei {item:254840}: {npc:5398} verwahrt die Kristalle, die du den Gelkis abgenommen hast, also frag ihn.",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "{item:254841}: die verfluchten Bäume des Tals",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "Magram: {quest:92873}",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "Aus den Questdaten: {npc:253136} gibt dir {item:254870}. Er hat auf dem Hügel gleich östlich seines Postens zwei Skelette ausgelegt: Setz den Stab dort ein, und die Nascent Undead Ravagers geben die Well Cursed Bones.",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "Well Cursed Bones: Nascent Undead Ravagers",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "Magram: die nächsten Aufgaben von {npc:253136}",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "Aus den Questdaten: {npc:253136} zahlt 500 und die Wahl aus drei Gegenständen für Stufe 35: {item:271796} (Einhandschwert), {item:271797} (Stab) oder {item:271798} (Schild).",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "Magram: das Herz des Tals",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "Aus den Questdaten: Südöstlich von {npc:253136}, im Herzen des Tals, halten die Magram Gelkis Captives fest: Töte fünf. Die {npc:253446} dort sind misslungene Beschwörungen, die im Boden feststecken: Erwecke zehn mit dem Enhanced Necromancy Staff, den Orgrul dir gegeben hat, und töte die, die sich wehren. Leichenfresser (Elite, Stufe 45) laufen durch das Tal und greifen jeden an; die Nekrokhane der Magram, ebenfalls Elite, lassen einen Freund der Magram in Ruhe.",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "Erwecke oder töte {npc:253446}",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "Magram: {quest:93066}",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "Aus den Questdaten: zurück zu {npc:253136}, dann nach Osten zu {quest:93066} für seinen nächsten Befehl.",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "Magram: die Stacheleber",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "Aus den Questdaten: Die Stacheleber der Borstennacken halten {quest:93066}, östlich des Tals. {npc:253527} (Elite, Stufe 43) und {npc:255678} (Elite, Stufe 42) führen sie an: Lass diese beiden in Ruhe. Melde dich dann bei {npc:253851} in {area:16675}, südlich des Rückzugsorts.",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "Magram: {npc:253851} bei {area:16675}",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "Aus den Questdaten: {npc:253851} schickt dich nach Südwesten zu {area:16676}, dem Lager der Verbannten westlich der Stadt der Shen'dralar.",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "Magram: {area:16676}",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "Aus den Questdaten: Outcast Scouts und Marauders halten das Versteck, mit Outcast Necrokhans (Elite, Stufe 45) unter ihnen. {item:256892} sind Kisten in seinem Westen. Die Quest will auch hier {quest:92846}; Spieler haben sie bisher nur im Tal zwischen {npc:253136} und {npc:253177} angetroffen, hol sie dir also dort, falls das Versteck keine hat.",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "{item:256892}: Kisten",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "Magram: zurück zu {npc:253851}",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "Magram: das Ritual von {npc:253136}",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "Aus den Questdaten: {quest:93196} wurde von Außenstehenden getötet, die für die Gelkis arbeiten, und {npc:253136} will ihn erwecken.",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram: {quest:93196}",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "Aus den Questdaten: Bring {item:257517} zum Ritualplatz, einem Zelt am See in der Mitte von {area:604}, und erwecke {quest:93196}. Der auferstandene Khan nimmt die Quest entgegen: 6.000, einen Titel und die Wahl aus drei seltenen Waffen der Stufe 35: {item:271800} (Stangenwaffe: Ausdauer, Angriffskraft, Beweglichkeit), {item:271803} (Stab: Intelligenz, Ausdauer, Willenskraft) oder {item:271804} (Streitkolben, Haupthand: Intelligenz, Ausdauer, Willenskraft). Die Quest kostet die Gelkis 30.000.",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "Erwecke {quest:93196} im Zelt am See",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram: Totems bis Ehrfürchtig",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "Ab Respektvoll bleibt nur noch {quest:92811}: Von Respektvoll bis Ehrfürchtig sind es 21.000, 28 Abgaben, 140 Totems.",

	-- Step 44: The totem recipes
	["The totem recipes"] = "Die Totem-Rezepte",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Beide Rüstmeister verkaufen dieselben 12 Rezepte für {quest:93224}, kein Rufrang nötig: {item:273613} und - Lesser Healing Power; Greater Spellblasting und {item:250941}; {item:250538}- und {item:250606}-Pläne; die Muster {item:252462}, {item:253973}, {item:10011} und {item:274490}; die Baupläne {item:269900} und {item:269902}. Behalte die Totems, die du dafür brauchst, bevor du den Rest abgibst.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 Rezepte für Geschnitzte Zentaurentotems bei den Clan-Rüstmeistern, kein Rufrang nötig",
	-- ["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "Bei Wohlwollend und nach {quest:92743} schickt dich {npc:5398} zu {npc:253136} am nördlichen Eingang des {quest:92841} in {zone:2652}. {npc:253136}s Quests (je 500: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) und die von Hagiak an der {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) enden mit {npc:5601}: Erwecke den toten Khan mit {npc:253136}s Stab am Zelt beim See in {area:604}, für 6.000, einen Titel und eine seltene Waffe der Stufe 35. Für alle musst du Wohlwollend oder besser bleiben. Von Wohlwollend bis Respektvoll sind es 12.000: Die Quests des Tals bringen davon etwa 11.000, zwei Abgaben von {quest:92811} den Rest.",
	-- ["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "Bei Wohlwollend schickt dich {npc:5397} nach Osten zu {npc:253177} am südlichen Eingang des {quest:93034} in {zone:2652}. {npc:253177}s Quests (je 500) führen dich zu den Untoten und Ausgestoßenen dort: {quest:93035}, {quest:93037} und {quest:93041}, dann A Cleansing Cry von {npc:5397}, und eine zweite Reihe (Saving Our Own, Bone Burying, Checking Things Out), die mit {npc:5601} endet: Töte den Khan der Magram in seinem eigenen Dorf für 6.000, einen Titel und eine seltene Waffe der Stufe 35. Für alle musst du Wohlwollend oder besser bleiben. Von Wohlwollend bis Respektvoll sind es 12.000: Die Quests des Tals bringen davon etwa 10.600, zwei oder drei Abgaben von {quest:92811} den Rest.",
	-- ["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Beide Rüstmeister verkaufen dieselben 12 Rezepte für Geschnitzte Zentaurentotems, kein Rufrang nötig: {item:273613} und - Lesser Healing Power; Greater Spellblasting und {item:250941}; {item:250538}- und {item:250606}-Pläne; die Muster {item:252462}, {item:253973}, {item:10011} und {item:274490}; die Baupläne {item:269900} und {item:269902}. Behalte die Totems, die du dafür brauchst, bevor du den Rest abgibst.",
	-- ["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 3.000 darin (4.000 mit {quest:1371}), es fehlen also 2.000 bis 3.000. {npc:253139}s {quest:92811} nimmt 5 Geschnitzte Zentaurentotems für 750 an, immer wieder; die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen, und die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Gelkis bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf zwei Handwerksaufträge für je 1.000: Mirdas 3 Große Schattenschutztränke und Grolkars 2 Massive Eisenäxte (Schmiedekunst). {npc:5398}s {quest:92743} (1.000) ist kein Handwerksauftrag: Er will einen {item:254392} aus einer Gruft in den {zone:1418}, und Forevers Questseiten setzen ihn in seiner Reihe vor das {quest:92841}, bring ihn also mit, bevor du Wohlwollend erreichst. Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",
	-- ["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 4.000 darin, es fehlen also 2.000. {npc:253140}s {quest:92812} nimmt 5 Geschnitzte Zentaurentotems für 750 an, immer wieder: drei Abgaben, 15 Totems. Die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen; die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Magram bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf außerdem drei Handwerksaufträge für je 1.000: Halea will 3 Große mystische Essenzen, {npc:253140} eine {item:10008} (Schneiderei) und Talra ein {item:5739} (Lederverarbeitung). Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",
	-- ["Gelkis: the {quest:93034}"] = "Gelkis: das {quest:93034}",
	-- ["Magram: the {quest:92841}"] = "Magram: das {quest:92841}",
	-- ["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "Die Gelkis (im Südwesten von {zone:1443}) und die Magram (im Südosten) sind im Krieg: Jeder Kill an einem Clan gibt dem anderen 20 und kostet den eigenen Clan 100, du kannst also nur bei einem aufsteigen. Beide beginnen bei Neutral. Forevers Quests sind jetzt weit mehr wert als Kills, und die Wahl-Quests kosten den anderen Clan nichts mehr. Allianz: {npc:5396} in {area:608} bietet {quest:1382} (Gelkis) und {quest:1385} (Magram) an. Horde: {npc:5412}, östlich von Shadowprey, bietet {quest:1368} und {quest:1367} an. Nimm die Quest deines Clans und dessen Buying Friendship (3.000 fürs Liefern eines Beutels voller Totems), dann hake die Aufgabe ab. Der Guide geht bei den Gelkis weiter; nimmst du stattdessen die Quests der Magram, springt er in die Magram-Hälfte. Forever zahlt diese Quests auf jeder Stufe voll aus.",
}
