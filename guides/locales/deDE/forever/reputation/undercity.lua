-- German (deDE): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "Ruf: Undercity",
	-- {item:14047} Runecloth
	["Tirisfal quests while you level, the Plaguelands quests from 55, then {item:14047} to Exalted."] = "Quests in Tirisfal beim Leveln, die Quests in den Pestländern ab 55, dann {item:14047} bis Ehrfürchtig.",
	-- {faction:68} Undercity
	["Exalted with the {faction:68}"] = "Ehrfürchtig bei den {faction:68}",

	-- Step 1: Undercity: how it works
	-- {faction:68} Undercity
	["{faction:68}: how it works"] = "{faction:68}: So funktioniert es",
	-- {faction:68} Undercity · {npc:14729} Ralston Farnsley · {object:36082} Magic Quarter · {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:287} Hillsbrad · {area:272} Tarren Mill · {object:1661} The Undercity
	["{faction:68} reputation comes from quests and cloth. {npc:14729}, the cloth quartermaster, stands in the {object:36082} beside the tailors. He takes four one-time donations of 60 cloth (150 each) and then {quest:7819}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:68} also gives a quarter as much to {zone:1454}, {zone:1456} and the Darkspear Trolls. While you level, do the {faction:68}'s quests within 5 levels of them: Tirisfal at 1 to 12, Silverpine at 10 to 20, {area:287} and {area:272} at 20 to 33. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the {faction:68}'s merchants sell to you for 10% less (the Classic rule), the horse vendor included; at Exalted other races can buy the skeletal horses: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse, once you have mount training. {object:1661} has no tabard or other reward."] = "Der Ruf bei den {faction:68} kommt aus Quests und Stoff. {npc:14729}, der Stoff-Rüstmeister, steht im {object:36082} neben den Schneidern. Er nimmt vier einmalige Spenden von je 60 Stoff (je 150) und danach {quest:7819}, 20 {item:14047} für 50, so oft du willst. Jeder Punkt, den du bei den {faction:68} verdienst, gibt außerdem ein Viertel davon an {zone:1454}, {zone:1456} und die Darkspear-Trolle. Mach beim Leveln die Quests der {faction:68}, die höchstens 5 Stufen unter dir liegen: Tirisfal auf Stufe 1 bis 12, Silberwald auf 10 bis 20, {area:287} und {area:272} auf 20 bis 33. Der Vermächtnis-Vorteil „Diplomat“ bringt bis zu 10% extra. Belohnungen: Bei Wohlwollend verkaufen dir die Händler der {faction:68} 10% günstiger (die Classic-Regel), den Pferdehändler eingeschlossen; bei Ehrfürchtig können andere Völker die Skeletal Horses kaufen: 20 Gold für ein Pferd der Stufe 40, 200 Gold für ein Schlachtross der Stufe 60, sobald du die Reitausbildung hast. {object:1661} hat keinen Wappenrock und keine andere Belohnung.",

	-- Step 2: Deathknell (optional hub)
	-- {area:154} Deathknell
	["{area:154} (optional hub)"] = "{area:154} (optionaler Hub)",
	-- {area:154} Deathknell · {faction:68} Undercity · {npc:1661} Novice Elreth · {npc:1570} Executor Arren · {npc:1740} Deathguard Saltain
	["Forever pays these old quests in full at any level. {area:154}, the Forsaken start at the west end of Tirisfal: about 900 {faction:68} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:1661}, {npc:1570} and {npc:1740} stand in the village."] = "Forever zahlt diese alten Quests auf jeder Stufe in voller Höhe aus. {area:154}, der Start der Verlassenen am Westende von Tirisfal: etwa 900 Ruf bei den {faction:68} in 25 Minuten. Quests in Startgebieten geben den anderen Städten keinen Anteil. {npc:1661}, {npc:1570} und {npc:1740} stehen im Dorf.",

	-- Step 3: Deathknell: the next quests
	-- {area:154} Deathknell
	["{area:154}: the next quests"] = "{area:154}: die nächsten Quests",

	-- Step 4: Around Deathknell
	-- {area:154} Deathknell
	["Around {area:154}"] = "Rund um {area:154}",
	-- {object:164662} Equipment Boxes · {quest:380} Night Web's Hollow · {npc:271961} Webbed Forsaken · {npc:1919} Samuel Fipps · {object:178090} Marla's Grave
	["The {object:164662} are all around the village. {quest:380} is the mine north-west; the {npc:271961} hang inside. {npc:1919} waits at the ruined camp by the road north-east: bury his remains at {object:178090}, in the front row of the village graveyard."] = "Die {object:164662} liegen überall um das Dorf. {quest:380} ist die Mine im Nordwesten; die {npc:271961} hängen drinnen. {npc:1919} wartet im zerstörten Lager an der Straße im Nordosten: Begrabe seine Überreste bei {object:178090}, in der vorderen Reihe des Dorffriedhofs.",
	-- {npc:271961} Webbed Forsaken
	["{npc:271961} freed"] = "{npc:271961} befreit",
	-- {object:178090} Marla's Grave · {item:16333} Samuel's Remains
	["{object:178090}, with {item:16333}"] = "{object:178090}, mit {item:16333}",

	-- Step 5: Deathknell: hand in
	-- {area:154} Deathknell
	["{area:154}: hand in"] = "{area:154}: abgeben",

	-- Step 6: The Scarlet camp
	["The Scarlet camp"] = "Das scharlachrote Lager",
	-- {area:154} Deathknell · {npc:1667} Meven Korgal
	["The Scarlet camp is south-east of {area:154}. {npc:1667} leads it."] = "Das Scharlachrote Lager liegt südöstlich von {area:154}. {npc:1667} führt es an.",
	-- {item:2885} Scarlet Crusade Documents · {npc:1667} Meven Korgal
	["{item:2885}, from {npc:1667}"] = "{item:2885}, von {npc:1667}",
	-- {quest:383} Vital Intelligence · {npc:1515} Executor Zygand · {area:159} Brill
	["{quest:383}, +75: to {npc:1515} in {area:159}"] = "{quest:383}, +75: zu {npc:1515} in {area:159}",

	-- Step 8: Brill (optional hub)
	-- {area:159} Brill
	["{area:159} (optional hub)"] = "{area:159} (optionaler Hub)",
	-- {area:159} Brill · {faction:68} Undercity · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren · {npc:1518} Apothecary Johaan · {npc:1496} Deathguard Dillinger · {npc:1500} Coleman Farthing
	["Forever pays these old quests in full at any level. {area:159} and the fields around it: about 1,100 {faction:68} reputation in 45 minutes. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} and {npc:1500} are in the town."] = "Forever zahlt diese alten Quests auf jeder Stufe in voller Höhe aus. {area:159} und die Felder rundherum: etwa 1.100 Ruf bei den {faction:68} in 45 Minuten. {npc:1515}, {npc:1499}, {npc:1518}, {npc:1496} und {npc:1500} sind in der Stadt.",

	-- Step 9: Around Brill
	-- {area:159} Brill
	["Around {area:159}"] = "Rund um {area:159}",
	-- {item:286176} Executor's Motivator · {area:159} Brill · {quest:99141} Patience · {npc:1496} Deathguard Dillinger · {npc:251001} Deathguard Kristof · {npc:10666} Gordo · {npc:1525} Rotting Dead
	["Use the {item:286176} on five Deathguards around {area:159}. For {quest:99141}, talk to {npc:1496} west of {area:159}, {npc:251001} at the waystation east of it and {npc:10666} on the road. The Rot Hide gnolls dig at the mass grave north of {area:159}. The {npc:1525} walk around the old bridge west of {area:159}; the dry branches lie under the trees there. Darkhounds roam everywhere."] = "Benutze den {item:286176} an fünf Todeswachen rund um {area:159}. Für {quest:99141} sprich mit {npc:1496} westlich von {area:159}, {npc:251001} an der Wegstation östlich davon und {npc:10666} auf der Straße. Die Rot Hide-Gnolle graben am Massengrab nördlich von {area:159}. Die {npc:1525} laufen um die alte Brücke westlich von {area:159}; die trockenen Äste liegen dort unter den Bäumen. Darkhounds streifen überall umher.",
	["Motivate 5 Deathguards"] = "Motiviere 5 Todeswachen",

	-- Step 10: Agamand Mills
	-- {npc:1657} Devlin Agamand · {area:157} Agamand Mills
	["{npc:1657} walks the road to {area:157}; Nissa waits upstairs in the first house, Gregor and Thurman further on in the mills."] = "{npc:1657} läuft die Straße nach {area:157} entlang; Nissa wartet oben im ersten Haus, Gregor und Thurman weiter hinten in den Mühlen.",

	-- Step 11: Brill: hand in
	-- {area:159} Brill
	["{area:159}: hand in"] = "{area:159}: abgeben",

	-- Step 12: Agamand Mills again
	-- {area:157} Agamand Mills
	["{area:157} again"] = "{area:157} noch einmal",
	-- {area:157} Agamand Mills
	-- plural, as words: Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["The skeletons of {area:157} drop the ribs; the Darkeye Bonecasters the skulls."] = "Die Skelette von {area:157} droppen die Rippen; die Darkeye Bonecasters die Schädel.",

	-- Step 13: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14729} offers the {item:14047} donation, and {quest:7819} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Ab hier geht es um Stoff. Wollstoff, Seide und Magiestoff müssen alle abgegeben sein, bevor {npc:14729} die Spende von {item:14047} anbietet, und {quest:7819} braucht die Spende von {item:14047}. Kauf Stoff im Auktionshaus oder farme ihn: Humanoide droppen ihn, Wollstoff von Stufe 15 bis 25, Seide 25 bis 40, Magiestoff 40 bis 50, {item:14047} ab 50. Auf Stufe 60 farmst du Mobs ab Stufe 52: niedrigere sind grau.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: die Thistlefur-Furbolgs lassen ihn bei etwa jedem vierten Kill fallen",

	-- Step 14: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seide: die Syndicate in {area:287} und Alterac lassen sie bei etwa jedem dritten Kill fallen, oder kauf sie.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: die Syndicate",

	-- Step 15: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Magiestoff: die Jadefire-Satyrn im Süden von {zone:1448} und die Dunemaul-Oger in {zone:1446} lassen ihn bei etwa jedem dritten Kill fallen, oder kauf ihn.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: die Jadefire-Satyrn",

	-- Step 16: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: die Scharlachroten bei {area:2266} im {zone:1423}, die Gordok-Oger vor {area:2577} in {zone:1444} und die Lager der Twilight in {zone:1451} lassen ihn bei etwa jedem dritten Kill fallen. Das Auktionshaus geht schneller, wenn du Gold hast.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: die Scharlachroten vor {area:2266}",

	-- Step 17: Undercity: Harbinger Balthazad
	-- {area:152} Bulwark · {npc:10879} Harbinger Balthazad · {faction:68} Undercity
	["The level 55 to 60 quests pay in full. First the {area:152}: {npc:10879}, by the {faction:68}'s elevators, sends you there."] = "Die Quests der Stufen 55 bis 60 zahlen voll. Zuerst die {area:152}: {npc:10879} bei den Aufzügen der {faction:68} schickt dich dorthin.",

	-- Step 18: Bulwark: Scarlet Diversions
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {npc:10837} High Executor Derrington · {faction:68} Undercity · {item:12814} Flame in a Bottle · {area:200} Dalson's Tears · {area:199} Felstone Field · {item:12807} Scourge Banner
	["{area:152} is the Forsaken camp on the road from Tirisfal into the {zone:1422}. {npc:10837}'s chain sends you against the Scourge cauldrons of the {zone:1422}: about 820 {faction:68} reputation. Take a {item:12814} from the box beside him; burn the command tent of the Scarlet camp between {area:200} and {area:199} and plant the {item:12807} beside it."] = "{area:152} ist das Lager der Verlassenen an der Straße von Tirisfal ins {zone:1422}. Die Questreihe von {npc:10837} schickt dich gegen die Kessel der Geißel im {zone:1422}: etwa 820 Ruf bei den {faction:68}. Nimm eine {item:12814} aus der Kiste neben ihm; verbrenne das Kommandozelt des Scharlachroten Lagers zwischen {area:200} und {area:199} und platziere das {item:12807} daneben.",
	-- {quest:5096} Scarlet Diversions
	["{quest:5096}, +100 (level 53)"] = "{quest:5096}, +100 (Stufe 53)",
	-- {object:176088} Scarlet Crusade Forward Camp (no name in this language: may be words)
	["the {object:176088}"] = "das {object:176088}",

	-- Step 19: Bulwark: the cauldrons
	-- {area:152} Bulwark
	["{area:152}: the cauldrons"] = "{area:152}: die Kessel",
	-- {quest:5229} Target: Felstone Field
	["{quest:5229}, +100 (level 53)"] = "{quest:5229}, +100 (Stufe 53)",

	-- Step 20: Felstone Field and the Andorhal towers
	-- {area:199} Felstone Field
	["{area:199} and the Andorhal towers"] = "{area:199} und die Türme von Andorhal",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {quest:5230} Return to the Bulwark · {item:12815} Beacon Torch
	["{npc:11075} guards the cauldron at {area:199}. Click the cauldron after the kill to start {quest:5230}. Mark the four towers of Andorhal with the {item:12815} at their doors."] = "{npc:11075} bewacht den Kessel bei {area:199}. Klicke nach dem Kill auf den Kessel, um {quest:5230} zu starten. Markiere die vier Türme von Andorhal mit der {item:12815} an ihren Türen.",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "der {object:176361}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["{npc:10902}: use the {item:12815} at the door"] = "{npc:10902}: Benutze die {item:12815} an der Tür",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Markiere {npc:10902} mit der {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Markiere {npc:10903} mit der {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Markiere {npc:10904} mit der {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Markiere {npc:10905} mit der {item:12815}",

	-- Step 22: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["{npc:11077} guards the cauldron at {area:200}."] = "{npc:11077} bewacht den Kessel bei {area:200}.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "der {object:177289}",

	-- Step 23: Bulwark: the Writhing Haunt
	-- {area:152} Bulwark · {area:202} Writhing Haunt
	["{area:152}: the {area:202}"] = "{area:152}: das {area:202}",

	-- Step 24: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt
	["{npc:11076} guards the cauldron at the {area:202}."] = "{npc:11076} bewacht den Kessel am {area:202}.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "der {object:176393}",

	-- Step 26: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}."] = "{npc:11078} bewacht den Kessel bei {area:201}.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "der {object:176392}",

	-- Step 27: Bulwark: done
	-- {area:152} Bulwark
	["{area:152}: done"] = "{area:152}: fertig",
	-- {area:152} Bulwark · {area:2057} Scholomance · {npc:10136} Chemist Fuely · {faction:68} Undercity · {zone:1448} Felwood · {zone:1449} Un'Goro Crater
	["{area:152} is also where The Key to {area:2057} ends (200), after a longer chain. {npc:10136} in the {faction:68}'s Apothecarium pays about 290 more for oozes from {zone:1448} and {zone:1449}."] = "Bei {area:152} endet auch The Key to {area:2057} (200), nach einer längeren Questreihe. {npc:10136} im Apothecarium der {faction:68} zahlt etwa 290 mehr für Schlicke aus {zone:1448} und {zone:1449}.",

	-- Step 28: Nathanos Blightcaller
	-- {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {faction:68} Undercity
	["{npc:11878}, the Ranger Lord, keeps his camp on the western edge of the {zone:1423}. His quests are level 58 to 60 and pay in full: 500 {faction:68} reputation."] = "{npc:11878}, der Waldläuferlord, hat sein Lager am Westrand der {zone:1423}. Seine Quests sind Stufe 58 bis 60 und zahlen voll: 500 Ruf bei den {faction:68}.",

	-- Step 29: Plaguebats, Quel'Lithien Lodge and Corin's Crossing
	-- {area:2276} Quel'Lithien Lodge · {area:2264} Corin's Crossing
	["Plaguebats, {area:2276} and {area:2264}"] = "Plaguebats, {area:2276} und {area:2264}",
	-- {area:2276} Quel'Lithien Lodge · {area:2268} Light's Hope Chapel · {item:15847} Quel'Thalas Registry · {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {item:15448} Coagulated Rot
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["The Noxious Plaguebats fly in the south of the zone, the Monstrous Plaguebats further north-west. {area:2276} is north-west of {area:2268}; the {item:15847} lies inside. Do {area:2264} last: its Scourge drop {item:15447}, which lasts only 10 minutes. With 7 in your bags, use the {item:15454} at once for the {item:15448}."] = "Die Noxious Plaguebats fliegen im Süden des Gebiets, die Monstrous Plaguebats weiter nordwestlich. {area:2276} liegt nordwestlich von {area:2268}; die {item:15847} liegt drinnen. Mach {area:2264} zuletzt: Die Geißel dort droppt {item:15447}, das nur 10 Minuten hält. Wenn du 7 in deinen Taschen hast, benutze sofort den {item:15454} für das {item:15448}.",
	-- {item:15448} Coagulated Rot · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15448}: 7 {item:15447} and the {item:15454}"] = "{item:15448}: 7 {item:15447} und der {item:15454}",

	-- Step 30: Nathanos Blightcaller: hand in
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}: hand in"] = "{npc:11878}: abgeben",

	-- Step 31: Duskwing and Borelgore
	-- {npc:11897} Duskwing · {npc:11896} Borelgore
	["{npc:11897} and {npc:11896}"] = "{npc:11897} und {npc:11896}",
	-- {npc:11897} Duskwing · {area:2260} Marris Stead · {npc:11896} Borelgore · {area:2272} Northdale
	["{npc:11897}, an elite bat, roams the fields north of {area:2260}. {npc:11896} paces a long valley west of {area:2272}."] = "{npc:11897}, eine Elite-Fledermaus, streift durch die Felder nördlich von {area:2260}. {npc:11896} läuft durch ein langes Tal westlich von {area:2272}.",
	-- {npc:11878} Nathanos Blightcaller · {faction:68} Undercity · {area:2279} Stratholme · {npc:12337} Crimson Courier
	["{npc:11878}: 500 {faction:68} reputation. His {area:2279} quests (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) need a group."] = "{npc:11878}: 500 Ruf bei den {faction:68}. Seine Quests in {area:2279} (The {npc:12337}, The Scarlet Oracle, Demetria, Ramstein) brauchen eine Gruppe.",

	-- Step 32: The Spider God (optional chain)
	-- {quest:2936} The Spider God
	["{quest:2936} (optional chain)"] = "{quest:2936} (optionale Questreihe)",
	-- {zone:1425} Hinterlands · {area:272} Tarren Mill · {area:367} Sen'jin Village · {area:978} Zul'Farrak · {faction:68} Undercity · {quest:2937} Summoning Shadra · {quest:2938} Venom to the Undercity · {quest:2933} Venom Bottles
	["Six quests across the {zone:1425}, {area:272}, {area:367}, {area:978} and the {faction:68}: 600 {faction:68} and 225 Darkspear reputation. {quest:2937} and {quest:2938} are level 55 and pay 400 in full at 60; the four before them are level 43 to 45 and pay in full too. Allow about 90 minutes with the travel. The {quest:2933} stand on the tables of the Witherbark village in the west of the {zone:1425}: click one to start."] = "Sechs Quests quer durch das {zone:1425}, {area:272}, {area:367}, {area:978} und die {faction:68}: 600 Ruf bei den {faction:68} und 225 bei den Darkspear. {quest:2937} und {quest:2938} sind Stufe 55 und zahlen auf 60 voll 400; die vier davor sind Stufe 43 bis 45 und zahlen ebenfalls voll. Rechne mit etwa 90 Minuten mit den Reisewegen. Die {quest:2933} stehen auf den Tischen des Witherbark-Dorfes im Westen des {zone:1425}: Klicke eine an, um zu starten.",

	-- Step 34: Shadra'Alor: an Undamaged Venom Sac
	-- {area:353} Shadra'Alor · {quest:2934} Undamaged Venom Sac
	["{area:353}: an {quest:2934}"] = "{area:353}: ein {quest:2934}",
	-- {area:353} Shadra'Alor · {zone:1425} Hinterlands
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["The Witherbark Broodguards crawl around {area:353} in the south-west of the {zone:1425}; about one in ten carries an undamaged sac."] = "Die Witherbark Broodguards kriechen rund um {area:353} im Südwesten des {zone:1425}; etwa jeder zehnte trägt einen unbeschädigten Sack.",
	-- {quest:2934} Undamaged Venom Sac
	-- plural, as words: Witherbark Broodguards = {npc:2686} Witherbark Broodguard
	["{quest:2934}, from Witherbark Broodguards"] = "{quest:2934}, von Witherbark Broodguards",

	-- Step 35: Tarren Mill, then Sen'jin Village
	-- {area:272} Tarren Mill · {area:367} Sen'jin Village
	["{area:272}, then {area:367}"] = "{area:272}, dann {area:367}",
	-- {quest:2935} Consult Master Gadrin
	["{quest:2935}, +75 Darkspear"] = "{quest:2935}, +75 bei den Darkspear",
	-- {npc:3188} Master Gadrin · {area:367} Sen'jin Village
	["{npc:3188}, in {area:367}"] = "{npc:3188}, in {area:367}",
	-- {quest:2936} The Spider God
	["{quest:2936}, +150 Darkspear"] = "{quest:2936}, +150 bei den Darkspear",

	-- Step 36: Zul'Farrak: the Tablet of Theka
	-- {area:978} Zul'Farrak · {object:142715} Tablet of Theka
	["{area:978}: the {object:142715}"] = "{area:978}: die {object:142715}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7272} Theka the Martyr · {object:142715} Tablet of Theka
	["{area:978} is a level 44 to 54 dungeon in northern {zone:1446}; a level 60 can clear the way alone, or bring a group. {npc:7272}, an elite troll, guards his tomb in the instance: kill him and read the {object:142715} there."] = "{area:978} ist ein Dungeon der Stufen 44 bis 54 im Norden von {zone:1446}; ein Spieler der Stufe 60 kann den Weg allein räumen, oder bring eine Gruppe mit. {npc:7272}, ein Elite-Troll, bewacht sein Grab in der Instanz: Töte ihn und lies dort die {object:142715}.",
	-- {object:142715} Tablet of Theka
	["read the {object:142715}"] = "lies die {object:142715}",

	-- Step 38: Shadra'Alor: Shadra
	-- {item:9323} Gadrin's Parchment · {area:353} Shadra'Alor · {npc:2707} Shadra
	["Read {item:9323} at the altar of {area:353} to call {npc:2707}, an elite level 55 spider: she drops her venom every time."] = "Lies {item:9323} am Altar von {area:353}, um {npc:2707} zu rufen, eine Elite-Spinne der Stufe 55: Sie droppt ihr Gift jedes Mal.",
	-- {item:9324} Shadra's Venom · {npc:2707} Shadra
	["{item:9324}, from {npc:2707}"] = "{item:9324}, von {npc:2707}",

	-- Step 39: Tarren Mill and the Undercity
	-- {area:272} Tarren Mill · {faction:68} Undercity
	["{area:272} and the {faction:68}"] = "{area:272} und die {faction:68}",
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, im Apothekarium",

	-- Step 40: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819} bis Wohlwollend",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth
	["{quest:7819}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an Undead starts at Friendly 1,000: 100 hand-ins; every other race starts at Neutral 500 and first needs 50 hand-ins, 1,000 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7819}: 20 {item:14047} für 50 Ruf, so oft du willst. Von Freundlich bis Wohlwollend sind es 6.000: 120 Abgaben, 2.400 {item:14047}, abzüglich dessen, was dir die Quests gegeben haben (ein Untoter startet bei Freundlich 1.000: 100 Abgaben; jedes andere Volk startet bei Neutral 500 und braucht zuerst 50 Abgaben, 1.000 {item:14047}, um Freundlich zu erreichen). Gib alle 20, die du trägst, ab, eine Abgabe nach der anderen.",

	-- Step 41: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819} bis Respektvoll",
	-- {item:14047} Runecloth · {item:12358} Darkstone Tablet · {area:1584} Blackrock Depths
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The {item:12358} ({area:1584}) pays 150 in full."] = "Von Wohlwollend bis Respektvoll sind es 12.000: 240 Abgaben, 4.800 {item:14047}. Die {item:12358} ({area:1584}) zahlt 150 in voller Höhe.",

	-- Step 42: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819} bis Ehrfürchtig",
	-- {item:14047} Runecloth · {npc:4731} Zachariah Post · {area:159} Brill
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:4731} in {area:159} sells the skeletal horses to every Horde race: 20 gold for a level 40 horse, 200 gold for a level 60 warhorse (Forever's prices); in Classic other races needed Exalted to buy them."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000: 420 Abgaben, 8.400 {item:14047}. For The Horde! (Rends Kopf) und The Lord of Blackrock (Nefarians Kopf) geben 200 für jede Horde-Stadt. Bei Ehrfürchtig verkauft {npc:4731} in {area:159} die Skeletal Horses an jedes Horde-Volk: 20 Gold für ein Pferd der Stufe 40, 200 Gold für ein Schlachtross der Stufe 60 (Forevers Preise); in Classic brauchten andere Völker Ehrfürchtig, um sie zu kaufen.",
	-- {npc:4731} Zachariah Post
	["{npc:4731}: the skeletal horses"] = "{npc:4731}: die Skeletal Horses",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder Geißel-Kill hier zählt auch für die {object:92525} (siehe den Guide dazu). Das Auktionshaus geht auch.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7819} ab, bis {faction:68} Ehrfürchtig ist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
	-- ["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7819} ab, jeweils 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Zentauren der Kolkar (Stufe 30-33) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Vollstrecker der Venture Co. an der {area:381} (Stufe 16-17) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729} nimmt Stoff für {faction:68} an, in {faction:68}. Die ersten Spenden von Woll-, Seiden-, Magie- und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach wiederholt sich {quest:7819} bis Ehrfürchtig. Ehrfürchtig bei der Hauptstadt eines anderen Volkes erlaubt dir, dessen Reittiere zu kaufen. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14729}: {item:14047} delivered"] = "{npc:14729}: {item:14047} abgegeben",
	-- ["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819} nimmt 20 {item:14047} pro Abgabe und lässt sich beliebig oft wiederholen. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
}
