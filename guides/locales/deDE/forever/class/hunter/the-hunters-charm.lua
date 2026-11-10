-- German (deDE): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "Erfahrung mit Stufe 50 durch {zone:1447} und den {area:1417}; die Gegenstandsauswahl aus Classic gibt es auf Forever womöglich nicht mehr.",
	["Experience"] = "Erfahrung",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Allianz)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "Mit 50 bietet sie jeder Jägerlehrer der Allianz an: {npc:5516} im {object:28027} von {zone:1453}, {npc:5116} in der {object:32390} von {zone:1455} oder Dorion in der Enklave des Cenarius von {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horde)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "Mit 50 bietet sie jeder Jägerlehrer der Horde an: {npc:3352} im {object:172958} von {zone:1454} oder {npc:3039} auf der {area:1641} in {zone:1456}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405} lebt auf einer erhöhten Stelle an den Klippen am Nordostrand der {area:1221}, im Westen von {zone:1447}. Bleib auf den hohen Graten um die Ruinen: Die Grube darunter führt nicht zu ihm hinauf. Allianz: Flieg nach {area:3137}; Horde: Flieg nach {area:1237}, ein kurzes Stück westlich von ihm.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "Du brauchst zwei Perfect Courser Antlers. Mosshoof Coursers (Stufe 52-53, Hirsche) grasen überall in {zone:1447} und lassen etwa bei jedem zwölften Kill eines fallen, rechne also mit zwei Dutzend Kills. Gute Herden: nördlich von {area:1220} im Norden und in den Hügeln nordöstlich und südöstlich von {area:1237}; im Gebiet {area:1234} gibt es außerdem Riesen- und Drachkin-Elite. Sie werden bei 30% Gesundheit wütend. Coursers teilen sich Spawnpunkte mit den Thunderhead-Hippogreifen: Sind keine da, töte die Hippogreife, dann können stattdessen Coursers spawnen. Der Respawn dauert etwa fünfeinhalb Minuten.",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}, von Mosshoof Coursers",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "Du brauchst sechs {item:20087}. Wavethrashers (dreiköpfige Seebestien) leben an den Küsten von {zone:1447}, meist unter Wasser: Die Young Wavethrashers (Stufe 51-52) an der Nordostküste lassen etwa bei jedem dritten Kill eine Schuppe fallen, die Wavethrashers (52-53) der Ostküste beim {area:1229} etwa genauso oft (ein paar laufen dort am Strand), die Great Wavethrashers (53-54) der Südostküste etwa bei jedem siebten. {spell:1494} zeigt sie nicht an; bekämpfe sie dort, wo du atmen kannst, und bring Wasseratmung mit, wenn du kannst. Im tieferen Wasser schwimmen Hai-Elite.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz im {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "Morphaz ist ein grüner Elite-Drache (Stufe 52) im {area:1417}, einem Dungeon für fünf Spieler: Du brauchst eine Gruppe aus fünf. Der Tempel steht in {area:74} im Osten von {zone:1435}: Steig die äußeren Stufen hinauf, tauch in die geflutete Halle und folge den Treppen nach unten zum Eingang. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} oder {area:42} und reite weiter. Er ist bei deiner Ankunft nicht da: Töte zuerst die sechs Trollwächter auf den Plattformen um den oberen Ring, was den Weg hinab zu {npc:5710} in der Opfergrube öffnet. Jammal'ans Tod bringt zwei Drachen hervor, Weaver und Dreamscythe (pull sie einzeln); sind beide tot, erscheinen Morphaz und Hazzas zusammen und lassen sich nicht trennen. Räum zuerst die Drachkin um die Grube, denn sie rufen um Hilfe. Morphaz nutzt {spell:12533} und {spell:11019}. Der Zahn fällt immer. Krieger in der Gruppe wollen vielleicht denselben Lauf für die Voodoo-Federn der Balkon-Trolle.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, im {area:1417}",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "In Classic ließ dich Ogtinc hier {item:19991}, {item:19992} oder {item:20083} wählen. Die Änderungshinweise von Forever sagen, dass die Auswahl entfällt, obwohl die Questseite noch drei unbenannte Belohnungen auflistet: Sieh dir das Belohnungsfenster an, bevor du abgibst.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung mit 50 durch {zone:1447} und {area:1417}; Forever hat die Gegenstandswahl aus Classic entfernt.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz ist ein Elite-Drachenboss im {area:1417}, einem Dungeon für fünf Spieler: Bring eine Gruppe mit. Der Tempel steht mitten im {area:74}; tauch hinab, um den Eingang zu erreichen. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:42} oder zur {area:1438} und reite weiter.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Mooshufrenner grasen überall in {zone:1447}; etwa jeder zwölfte lässt ein Paar Perfekte Rennergeweihe fallen.",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Wellenhauer kriechen an den Küsten von {zone:1447} entlang: Junge Wellenhauer am Nordostufer und Wellenhauer an der Ostküste lassen die Schuppen etwa doppelt so oft fallen wie die Großen Wellenhauer am Südufer.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} lebt oben auf den Klippen nordöstlich der {area:1221}. Allianz: Flieg zur {area:3137}; Horde: Flieg nach {area:1237}.",
}
