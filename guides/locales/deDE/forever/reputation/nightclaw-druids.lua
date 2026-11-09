-- German (deDE): the guide forever/reputation/nightclaw-druids (forever/reputation/nightclaw-druids.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Nightclaw Druids = {npc:254152} Nightclaw Druid
	["Nightclaw Druids Reputation"] = "Ruf: Nightclaw Druids",
	-- {zone:2521} Zephras Isle
	["{zone:2521}'s hidden druids: five cultist ears pay 1000 reputation, best done before you outlevel the isle."] = "Die versteckten Druiden von {zone:2521}: fünf Ohren von Kultisten zahlen 1000 Ruf, am besten erledigt, bevor du der Insel entwächst.",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["48 {skill:164}, {skill:165} and {skill:197} patterns"] = "48 Muster für {skill:164}, {skill:165} und {skill:197}",

	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Himmelsboot ab {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the north side of {area:279} about every five minutes; another flies from north of {zone:1456}, and either faction may take either."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen, offen für alle. Ein Himmelsboot legt etwa alle fünf Minuten an der Nordseite von {area:279} ab; ein weiteres fliegt von nördlich von {zone:1456}, und beide Fraktionen dürfen beide nehmen.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Himmelsboot nach {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Himmelsboot ab {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes; another flies from {area:279}, and either faction may take either."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen, offen für alle. Ein Himmelsboot legt etwa alle fünf Minuten an den Klippen südlich von {area:17045}, nördlich von {zone:1456}, ab; ein weiteres fliegt von {area:279}, und beide Fraktionen dürfen beide nehmen.",

	-- Step 3: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Players' turn-ins paid their full reputation well above these quests' level."] = "{npc:252359} steht in {area:16638}, der Stadt der Himmelsgeborenen im Süden der Insel, und hat von den Druiden im Norden nichts gehört. Sein Auftrag ist der Beginn der Nightclaw-Geschichte (ab Stufe 8, jede Rasse). Jede ihrer Quests zahlt Nightclaw-Ruf: insgesamt 4100, genug für Freundlich. Die Abgaben von Spielern zahlten ihren vollen Ruf weit über der Stufe dieser Quests.",

	-- Step 4: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into the {area:16631}. {npc:257944} holds the druids' camp in its north-east."] = "Geh nach Norden in die {area:16631}. {npc:257944} hält das Lager der Druiden in deren Nordosten.",

	-- Step 5: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {area:16720} Nightclaw Cavern
	["{npc:254151}, the druids' quartermaster, waits inside their den: the cave just across the clearing north-east of {npc:257944} ({area:16720} on the map; {npc:257944} calls it the Nightfang Den). Take his ear quest now: the cultists you fight for {npc:257944} drop ears for it."] = "{npc:254151}, der Quartiermeister der Druiden, wartet in ihrem Bau: der Höhle gleich gegenüber der Lichtung nordöstlich von {npc:257944} ({area:16720} auf der Karte; {npc:257944} nennt sie die Nightfang Den). Nimm jetzt seine Ohren-Quest an: Die Kultisten, die du für {npc:257944} bekämpfst, lassen dafür Ohren fallen.",

	-- Step 6: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Footsoldiers = {npc:252665} Al'Aketh Footsoldier · Bloody Heirlooms = {item:265141} Bloody Heirloom · Shadowgale Shrieklings = {npc:256092} Shadowgale Shriekling
	["The Al'Aketh Footsoldiers and Stormchasers camp just north of {npc:257944} and drop the Bloody Heirlooms (and ears, about one kill in four). The Shadowgale Shrieklings flying west of her drop the feathers; the {item:265105} grows on the trees along the stream west of her."] = "Die Al'Aketh Footsoldiers und Stormchasers lagern knapp nördlich von {npc:257944} und lassen die Bloody Heirlooms fallen (und Ohren, etwa bei jedem vierten Kill). Die Shadowgale Shrieklings, die westlich von ihr fliegen, lassen die Federn fallen; die {item:265105} wächst an den Bäumen am Bach westlich von ihr.",
	-- {npc:254151} Vayn Moongaze
	["ears for {npc:254151}: keep every one"] = "Ohren für {npc:254151}: behalte jedes",

	-- Step 7: Elegael Thornpaw's next tasks
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}'s next tasks"] = "Die nächsten Aufgaben von {npc:257944}",
	["500 reputation"] = "500 Ruf",

	-- Step 8: The Nightfang Den and Commander Haalien
	-- {npc:253622} Commander Haalien
	["The Nightfang Den and {npc:253622}"] = "Die Nightfang Den und {npc:253622}",
	-- {npc:257944} Elegael Thornpaw · {npc:258134} Naaleos Leafwhisper · {npc:258130} Jorel Windsinger · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["The Nightfang Den is the cave north across the clearing from {npc:257944}. Heal the seven injured druids inside ({npc:258134} among them) and find {npc:258130}. {npc:253622} stands east of the den: he drops his head and a {quest:94490}; right-click the missive to start its quest."] = "Die Nightfang Den ist die Höhle nördlich gegenüber der Lichtung von {npc:257944}. Heile die sieben verletzten Druiden darin (darunter {npc:258134}) und finde {npc:258130}. {npc:253622} steht östlich des Baus: Er lässt seinen Kopf und eine {quest:94490} fallen; klicke das Schreiben mit der rechten Maustaste an, um seine Quest zu beginnen.",
	-- {npc:253622} Commander Haalien
	["from {npc:253622}"] = "von {npc:253622}",

	-- Step 9: Elegael Thornpaw, the den's fate
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the den's fate"] = "{npc:257944}, das Schicksal des Baus",
	["1000 reputation"] = "1000 Ruf",

	-- Step 10: Ears at the Shrine of Akir
	-- {area:16629} Shrine of Akir
	["Ears at the {area:16629}"] = "Ohren am {area:16629}",
	-- {area:16629} Shrine of Akir · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Honor Guards = {npc:3083} Honor Guard
	["The best ears are south of the forest at the {area:16629}: Skypriests drop one in more than half their kills, Guardians in four of ten, Spiritcallers and Honor Guards in a third. The {area:16626} just north-west of {area:16638} are next best (Brawlers and Pillagers, about four in ten). All cultists are level 8 to 10."] = "Die besten Ohren liegen südlich des Waldes am {area:16629}: Skypriests lassen in mehr als der Hälfte ihrer Kills eines fallen, Guardians in vier von zehn, Spiritcallers und Honor Guards in einem Drittel. Die {area:16626} knapp nordwestlich von {area:16638} sind die zweitbesten (Brawlers und Pillagers, etwa vier von zehn). Alle Kultisten sind Stufe 8 bis 10.",

	-- Step 11: Mercy Falls on Deaf Ears
	-- {npc:254151} Vayn Moongaze
	["Back to {npc:254151} inside the den. Ten ears for 1000 reputation and a green piece: leather gloves, cloth pants or mail boots. {npc:254151} then takes ears five at a time, for 1000 each, as often as you like, up to level 18; in Classic the pay drops from level 19 and is 200 from level 22. The Legacy perk Diplomat adds up to 10% to every gain."] = "Zurück zu {npc:254151} im Bau. Zehn Ohren für 1000 Ruf und ein grünes Teil: Lederhandschuhe, Stoffhose oder Kettenstiefel. {npc:254151} nimmt danach Ohren zu je fünf, für je 1000, beliebig oft, bis Stufe 18; in Classic sinkt die Bezahlung ab Stufe 19 und beträgt ab Stufe 22 noch 200. Der Vermächtnis-Vorteil „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",

	-- Step 12: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Zurück nach {area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["{npc:252359} waits in {area:16638}. Hand in on your way to a skyboat or to the {area:16626}."] = "{npc:252359} wartet in {area:16638}. Gib auf dem Weg zu einem Himmelsboot oder zu den {area:16626} ab.",

	-- Step 13: Friendly to Honored
	["Friendly to Honored"] = "Freundlich bis Wohlwollend",
	-- {npc:254151} Vayn Moongaze
	["The storyline and {npc:254151}'s first quest leave you at Friendly with 2100 to spare. Honored is 3900 more: four turn-ins of five ears up to level 18, twenty from level 22. Friendly opens 32 of {npc:254151}'s patterns, in two colours, Cloudy and Azure: Blacksmithing Skyforged Wristguards and Chain (skill 50, 9s 50c), Gauntlets and Greaves (55, 11s); Leatherworking Gustwoven and Windraveled bracers and belts (50) and gloves and boots (55); Tailoring Stormsewn Cuffs and Cord (50), Handwraps and Shoes (55). They bind when you buy them, so buy them on the crafter."] = "Die Geschichte und die erste Quest von {npc:254151} lassen dich bei Freundlich mit 2100 Reserve zurück. Wohlwollend ist 3900 mehr: vier Abgaben zu je fünf Ohren bis Stufe 18, zwanzig ab Stufe 22. Freundlich öffnet 32 der Muster von {npc:254151}, in zwei Farben, Cloudy und Azure: Schmiedekunst Skyforged Wristguards und Chain (Fertigkeit 50, 9s 50c), Gauntlets und Greaves (55, 11s); Lederverarbeitung Gustwoven- und Windraveled-Armschienen und -Gürtel (50) sowie Handschuhe und Stiefel (55); Schneiderei Stormsewn Cuffs und Cord (50), Handwraps und Shoes (55). Sie werden beim Kauf gebunden, kaufe sie also am Handwerker.",
	["five ears per turn-in"] = "fünf Ohren pro Abgabe",
	-- {quest:93459} More Al'Aketh Ears
	["{quest:93459}: 1000 reputation"] = "{quest:93459}: 1000 Ruf",
	-- {npc:254151} Vayn Moongaze
	["{npc:254151}'s patterns"] = "Die Muster von {npc:254151}",

	-- Step 14: Honored to Revered
	["Honored to Revered"] = "Wohlwollend bis Respektvoll",
	["Honored opens the chest and leg patterns (skill 60, 12s 50c): Skyforged chainmail and legguards, Gustwoven harness and trousers, Windraveled jerkin and pants, Stormsewn vest and leggings. Revered is 12000 more: 12 turn-ins (60 ears, about 160 cultist kills at the Shrine) up to level 18, 60 turn-ins (300 ears) from level 22."] = "Wohlwollend öffnet die Brust- und Beinmuster (Fertigkeit 60, 12s 50c): Skyforged-Kettenhemd und -Beinschutz, Gustwoven-Harness und -Hose, Windraveled-Jerkin und -Hose, Stormsewn-Weste und -Leggings. Respektvoll ist 12000 mehr: 12 Abgaben (60 Ohren, etwa 160 Kultisten-Kills am Schrein) bis Stufe 18, 60 Abgaben (300 Ohren) ab Stufe 22.",

	-- Step 15: Revered to Exalted
	["Revered to Exalted"] = "Respektvoll bis Ehrfürchtig",
	-- {item:280347} Shadowgale Squirrel
	["Revered opens the {item:280347}, a companion pet, for 50s. Exalted is 21000 more: 21 turn-ins (105 ears, about 280 kills) up to level 18, 105 turn-ins (525 ears) from level 22."] = "Respektvoll öffnet den {item:280347}, ein Begleiter-Haustier, für 50s. Ehrfürchtig ist 21000 mehr: 21 Abgaben (105 Ohren, etwa 280 Kills) bis Stufe 18, 105 Abgaben (525 Ohren) ab Stufe 22.",
	-- {item:280347} Shadowgale Squirrel
	["{item:280347}, 50s"] = "{item:280347}, 50s",

	-- Step 16: The Nightclaw Mantle
	-- {item:280363} Nightclaw Mantle
	["The {item:280363}"] = "Die {item:280363}",
	-- {item:280363} Nightclaw Mantle
	["Exalted opens the {item:280363}, green cloth shoulders for level 15, for 8s 16c."] = "Ehrfürchtig öffnet die {item:280363}, grüne Stoffschultern für Stufe 15, für 8s 16c.",
}
