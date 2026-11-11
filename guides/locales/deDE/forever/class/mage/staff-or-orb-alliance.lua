-- German (deDE): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "Ley oder {item:9514} oder Orb (Allianz)",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "Ein Stab oder ein Orb für die Nebenhand mit Stufe 10 vom Magierlehrer deiner Heimatstadt; Himmelsgeborene bekommen zusätzlich einen Zauberstab.",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "Mit Stufe 10 schickt dich {npc:252373}, der Magierlehrer von {area:16638}, zu {npc:256507}, dem Stabhändler wenige Schritte entfernt in derselben Stadt.",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Die Windsteinformationen",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "Der Ast liegt am Boden zwischen den Windstone Formations, dem Windschrein auf der Anhöhe westlich von Fillions Lager, südlich von {area:16636}. Er funkelt nicht, such also den Boden bei den Steinen ab; es gibt zwei Stellen dafür.",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "Zurück zu {npc:256507}",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "{quest:1861} (die nächsten Schritte) wartet mit etwa Stufe 15 bei {npc:5497} in {zone:1453} auf dich.",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "Mit Stufe 10 schickt dich {npc:328}, der Magierlehrer von {area:87}, oben im Lion's Pride Inn, zu {npc:5497} in {zone:1453}. Sie anzunehmen schließt {quest:1879} aus, den Botengang des Lehrers von {area:131}; {quest:1861} und Gizmonitor von {npc:5144} schließen sich gegenseitig aus, du bekommst also einen Stab oder Orb.",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "Mit Stufe 10 schickt dich {npc:1228}, der Magierlehrer von {area:131} in der {area:2102}, zu {npc:5144} in {zone:1455}. Sie anzunehmen schließt {quest:1860} aus, den Botengang des Lehrers von {area:87}; Gizmonitor von {npc:5144} und {quest:1861} von {npc:5497} schließen sich gegenseitig aus, du bekommst also einen Stab oder Orb. (Ein Gnom, der stattdessen die Quest von {npc:328} in {area:87} angenommen hat, folgt den Schritten von {quest:1861}; ein Mensch, der diese angenommen hat, den Gizmonitor-Schritten.)",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "Folge der Straße nach Norden nach {zone:1453} und nach Westen zum {object:2101}. {npc:5497} steht oben im Wizard's Sanctum, dem hohen violetten Turm: Steig die Spiralrampe hinauf und tritt nahe dem oberen Ende ins Portal, das dich neben sie setzt. Sie gibt dir {item:7207}. Himmelsgeborene Magier nehmen {quest:1861} bei ihr an, wenn sie zum ersten Mal {zone:1453} erreichen, mit etwa Stufe 15.",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "Der Wasserfall von {quest:1861}",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "Verlasse {zone:1453} durch das Haupttor und geh nach Südwesten zum Wasserfall, der {quest:1861} speist. Wate unter das herabstürzende Wasser bis zum Fels dahinter und benutze dort {item:7207} (5 Sekunden Zauberzeit); überall sonst scheitert es. Defias-Zauberwirker der Stufe 10 stehen auf den Felsen zu beiden Seiten der Fälle und schießen aus der Ferne: Pull sie einzeln oder füll die Flasche aus dem Wasser.",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "{item:7207}, unter den Fällen",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Zurück zu {npc:5497}",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "Geh zurück hinauf im Wizard's Sanctum und durch das Portal. Der Orb ist eine Nebenhand für eine Einhandwaffe; der Stab ist eine Zweihandwaffe.",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497}: {item:7508} oder {item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144} bildet Magier im {object:32362} aus, hinten in {zone:1455} hinter der {object:32386}.",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "Geh die Straße nach Westen zu {area:133}. Direkt nördlich des Eingangs stehen zwei Hütten; die Werkzeugkiste ist in der höheren, östlichen, der Hütte mit dem Aufzug: eine kleine graue Kiste im Erdgeschoss, halb unter dem Tisch neben dem Aufzug. Leper Gnomes (Stufe 8) bewachen die Hütten: pull sie einzeln. Es gibt nur eine Werkzeugkiste, und sie braucht 15 Minuten, um wiederzukommen, nachdem jemand sie geöffnet hat; warte also in der Nähe, wenn sie weg ist.",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "Zurück zu {npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144}: {item:7507} oder {item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "Zauberstab von {npc:256507} (optional)",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "Die Quest von {npc:256507} steht auch menschlichen und gnomischen Magiern offen, wenn du je {area:16638} auf {zone:2521}, der Heimat der Himmelsgeborenen, besuchst: {npc:252373}, der Magierlehrer der Stadt, schickt dich zu {npc:256507} nebenan, der einen {item:262668} vom Boden bei den Windstone Formations südlich von {area:16636} will, für {item:263430}. Sie schließt den Stab oder den Orb nicht aus.",
}
