-- German (deDE): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} ist dein Stützpunkt für diesen Guide: Der Ruhestein bringt dich zweimal hierher zurück. Alle stehen rund um den Dorfplatz.",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "Das Plakat {object:1763} beim Gasthaus",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "Das Plakat {quest:567}: Seine Ziele triffst du unterwegs",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Füll den {item:7768} am {object:107045} neben dem Gasthaus",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "Hast du „Mission: Possible But Not Probable“ bei Shenthul abgegeben, bring {quest:2479} zu {npc:2391} in {area:272}. Bleib neben ihm, bis das Brauziel abgeschlossen ist, und gib dann die Folgequest ab, um Gifte zu lernen. Schließe sie auch dann ab, wenn das Zanzilgift schon entfernt wurde; das Entfernen des Debuffs allein lehrt die Fertigkeit nicht.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Gifte",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "Giftreihe unvollendet? Setze deine aktuelle Stufe im Klassen-Guide Gifte (Horde) fort; abgeschlossene Quests müssen nicht neu begonnen werden. Organisiere eine Gruppe für Gallywix, schließe die Folgequest von Hinott ab und kehre dann zu diesem Leveling-Guide zurück.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Bären, Krabbler und Löwen",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "Westlich von Tarrens Mühle streifen Graubären, Waldmooskrabbler und Verhungernde Berglöwen auf dem Weg hinunter zu den Höfen durch die Hügel. Die Krabbler droppen {item:3477} selten; du brauchst nur eins.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Die Höfe östlich des Orts {area:287}. {npc:232} bestellt das Feld beim nördlichen Bauernhaus, {npc:2403} das weiter südöstlich; Landarbeiter und Bauern von Hillsbrad sind überall. {npc:2451} pflegt das Feld südlich der Höfe.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}, neben Lydon",

	-- Step 6: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} ist der Hund von {npc:232}, beim nördlichen Bauernhaus im Gebiet {area:286}.",

	-- Step 7: Peasants and skulls
	["Peasants and skulls"] = "Arbeiter und Schädel",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Die Arbeiter von Hillsbrad bestellen die Felder südlich der Bauernhäuser. Jeder Mensch aus {area:287} droppt Schädel; die Arbeiter am häufigsten.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: die Arbeiter auf den Feldern",

	-- Step 8: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: Befehle für {npc:270438}, auf dem Weg nach Burg Durnholde",

	-- Step 9: Syndicate camps
	["Syndicate camps"] = "Lager des Syndikats",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Geh von {area:272} nach Südosten in die Hügel auf dem Weg zur {area:275}. Schurken und Wachmänner des Syndikats halten die Lager unterwegs.",

	-- Step 10: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull und {npc:2238} sind in Gebäuden im Hof der {area:275} angekettet; öffne beide Schlösser.",
	["Drull's ball and chain"] = "Drulls Kugel und Kette",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Kugel und Kette von {npc:2238}",

	-- Step 11: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj versteckt sich am Hang über {area:290}, südlich von Burg Durnholde, auf dem Weg hinunter zu den Blüten.",

	-- Step 12: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "Südwestlich von Burg Durnholde wachsen die {item:3502} an den Hängen über dem Fluss.",

	-- Step 13: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, in {zone:1458}",

	-- Step 14: The smithy
	["The smithy"] = "Die Schmiede",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "Die Schmiede steht mitten im Ort {area:287}. {npc:2404} und seine Lehrlinge arbeiten an der Esse; die {object:1736} ist daneben gestapelt. {npc:2449} läuft die Straße nördlich davon entlang.",

	-- Step 16: Town hall
	["Town hall"] = "Rathaus",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Das Rathaus liegt auf der Westseite von {area:287}. {npc:2335} (30) und {npc:2448} sind drinnen beim Stadtverzeichnis von Hillsbrad; die Proklamation von Hillsbrad hängt daneben. Ratsherren von Hillsbrad laufen durch den Ort.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Der Ort {area:288} liegt südlich des Orts {area:287}. Minenarbeiter von Hillsbrad arbeiten in den Stollen; {npc:2305} (30) und {npc:2450} (29) sind tief drinnen.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, im Apothekarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Behalte es: die Küste von {area:287}, später auf der Route",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Nimm den Zeppelin von den Türmen vor {zone:1458} nach {zone:1454} und trainiere, bevor du weiterfliegst.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Flieg von {zone:1454} (Zeppelin von den Türmen vor {zone:1458}) nach {area:1638}, trainiere im Ort {area:1639} und flieg dann weiter nach {area:378}.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Flieg von {zone:1454} (Zeppelin von den Türmen vor {zone:1458}) nach {area:378}.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "Die Hütte von {npc:5899} steht auf dem Grat über dem Wasserloch der Stacheleber, südlich von {area:378}, auf dem Weg nach {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: der rote Wasserschlauch aus {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: Der blaue Wasserschlauch wird im {zone:1440} gefüllt, nächster Guide",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Folge der Straße nach Süden zur Ausgrabungsstätte der Zwerge bei {area:359}. {npc:3421} versteckt sich am Südrand der Grabung; {object:3646} steht ganz unten in der Ausgrabung.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:485} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "Südwestlich von Bael Modan wartet {npc:12576} oben am Aufzug ({area:485}).",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Ruhestein nach {area:378} und flieg nach {area:392}. {quest:874} lagert am Ufer nördlich von {area:392}.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, ein großer Dreschadon, schwimmt im seichten Wasser vor der Küste ({area:391}), östlich von {npc:3388} Skyseer.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, bei den Docks in {area:392}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Noch kein Gallywix? Der Klassenguide Gifte (Horde) führt die Questreihe ab Shenthul erneut, mit einer Gruppe für Gallywix.",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Noch kein Gallywix? Der Klassenguide {spell:2842} (Horde) führt die Questreihe ab Shenthul erneut, mit einer Gruppe für Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Nur wenn Gallywix im {zone:1413} gefallen ist (Mission: möglich, aber nicht sehr wahrscheinlich): {npc:2391} steht in {area:272}. Warte bei ihm, während er das Heilmittel braut, und hol dir dann deine Belohnung: Gifte.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Nur wenn Gallywix im {zone:1413} gefallen ist (Mission: möglich, aber nicht sehr wahrscheinlich): {npc:2391} steht in {area:272}. Warte bei ihm, während er das Heilmittel braut, und hol dir dann deine Belohnung: {spell:2842}.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "Die Schmiede steht mitten im Ort {area:287}. {npc:2404} und seine Lehrlinge arbeiten an der Esse; die {item:3564} ist daneben gestapelt. {npc:2449} läuft die Straße nördlich davon entlang.",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Du kommst gebunden am Gasthaus von {area:272} an. Alle stehen rund um den Dorfplatz.",
}
