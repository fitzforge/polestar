-- German (deDE): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71} und eine Waffe (Horde)",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek · {area:159} Brill
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "{spell:71} mit Stufe 10 und eine Einhandwaffe nach Wahl: der Weg von {npc:5810}, die Gruft von {area:159} oder der Skybreaker-Schild.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} in {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "Mit Stufe 10 steht {npc:252377} mit den Lehrern am Westtor von {area:16638}. Ein Kultist, {npc:257196}, hält den Schild ihrer Familie am {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Geh von {area:16638} nach Nordwesten zum {area:16629}. {npc:257196} steht westlich des Schreinzugangs zwischen den Guardians, Spiritcallers und Blademasters des Kults: Pull sie einzeln, bevor du dir ihn vornimmst. Er lässt {item:263993} fallen.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, von {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "Zurück zu {npc:252377} in {area:16638}. Sie bringt dir {spell:71} bei und gibt dir {item:275290}, einen Schild dafür. Der Weg von {npc:5810} unten gibt dir später trotzdem eine Waffe, sobald du Kalimdor erreichst.",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {area:362} Razor Hill · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon · {area:159} Brill
	["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "Mit Stufe 10 schickt dich {npc:3169}, der Kriegerlehrer in der Kaserne von {area:362}, zu {npc:5810} im {zone:1413}. Sorek in {object:172958} von {zone:1454} bietet sie ebenfalls an. Jeder Horde-Krieger darf einen der zwei Wege nehmen, nie beide: Gehst du mit 10 sowieso nach {zone:1420}? {npc:2131} im Gasthaus von {area:159} bietet den anderen an: ein Kampf am Friedhof von {area:159} für dieselbe Haltung, dann die Agamand-Gruft für eine Erbstück-Waffe.",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {area:222} Bloodhoof Village · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "Mit Stufe 10 schickt dich {npc:3063}, der Kriegerlehrer von {area:222}, zu {npc:5810} im {zone:1413}. {npc:3041} in {zone:1456} bietet sie ebenfalls an.",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:5810} at {area:379}"] = "{npc:5810} bei {area:379}",
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "{npc:5810} ist leicht zu übersehen: Er steht unter einem kleinen Vordach an einem großen Baum direkt westlich von {area:379}, unterhalb der Südseite der Straße, mit dem Posten in Sichtweite im Osten. Wenn du vom Posten geradeaus nach Süden gehst, kommst du nicht zu ihm. Überquere von {zone:1411} aus die Brücke nach Westen; von {zone:1412} aus geh nördlich an den Crossroads vorbei.",

	-- Step 7: Singed Scales in Thunder Ridge
	-- {area:369} Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in {area:369}"] = "Singed Scales in {area:369}",
	-- {area:369} Thunder Ridge · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens · {spell:5401} Lizard Bolt
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "Du brauchst fünf Singed Scales. Thunder Lizards (Stufe 9-10) und Lightning Hides (10-11) leben unten in der Schlucht von {area:369} im Nordwesten von {zone:1411}, südlich von {zone:1454}: Biege an der Brücke zum {zone:1413} links ab und folge dem Fluss nach Norden hinein. Beide lassen bei etwa vier von fünf Kills eine Schuppe fallen; beide wirken {spell:5401}.",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}, von den Echsen",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["Back to {npc:5810} under his tree west of {area:379}."] = "Zurück zu {npc:5810} unter seinem Baum westlich von {area:379}.",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "Die Hütte von {npc:5878} sitzt auf {area:1699}, östlich der Crossroads. Die meisten Hänge sind zu steil: Steig den breiten Grat an der Nord- oder Ostseite hinauf.",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "{object:58369} steht bei einem kaputten Wagen im Razormane-Lager nordwestlich von {npc:5878}, nordöstlich der Crossroads. Zwei Razormanes bewachen sie, und ihre Jäger ziehen weitere Stacheleber heran: Räum sie einzeln, dann öffne die Truhe (sie füllt sich binnen Sekunden wieder, ein Freund kann sie also auch plündern).",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}, aus {object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {area:159} Brill · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "Mit Stufe 10 schickt dich {npc:2131}, der Kriegerlehrer im Gasthaus von {area:159}, zu {npc:1496} am Friedhof am Westrand von {area:159}. Dieser Weg und der von {npc:5810} schließen sich gegenseitig aus: Wirf {quest:1505} oder {quest:1498} aus deinem Log, falls du eine hast.",

	-- Step 12: Deathguard Dillinger
	-- {area:159} Brill · {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "Dillinger steht am Friedhof am Westrand von {area:159}. Ein Orc, Troll, Tauren oder Himmelsgeborener, der {quest:1818} von {npc:2131} statt des Weges von {npc:5810} genommen hat, wird von hier aus durch {area:159} geführt.",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390} schläft im Mausoleum auf dem Friedhof direkt nördlich von Dillinger. Um ihn zu wecken, klicke die flache Schädelplakette auf dem Boden links des Pfades zur Mausoleumstür an; das Siegel hebt sich und {npc:6390} (Stufe 11, kein Elite) kommt heraus. Fang mit voller Gesundheit an.",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500} ist in {area:2119}, dem Gasthaus an der Ostseite von {area:159}.",

	-- Step 15: The Agamand Family Crypt
	-- {area:158} Agamand Family Crypt
	["The {area:158}"] = "{area:158}",
	-- {area:158} Agamand Family Crypt · {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "Die vier Agamand Weapon Racks stehen in {area:158} am Nordende von {area:157}, nördlich von {area:159}, ein Ständer pro Raum: einer im untersten Raum, zwei im Raumpaar die Treppe hinauf, einer im Raum darüber. Der Axtständer steht in einer dunklen Ecke. Die Untoten der Gruft kommen in Gruppen von drei oder mehr und kehren schnell zurück; die im obersten Raum sind nicht verbunden. Die Ständer mit Axt, Dolch und Streitkolben brauchen 15 Minuten, um sich zu füllen, nachdem jemand sie geplündert hat.",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "Zurück zu {npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Die vier Agamand-Waffenregale stehen zwischen den Gebäuden von {area:157}, nördlich von {area:159}. Die Untoten der Mühlen greifen sofort an.",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} steht in {area:159}. {npc:6390} wartet im Mausoleum auf dem Hügel direkt nördlich des Ortes: Öffne das Tor und kämpf gegen ihn.",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} ist im Gasthaus, der {area:2119}, in {area:159}.",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} und mit Stufe 10 eine Einhandwaffe deiner Wahl.",
}
