-- Portuguese (Brazil) (ptBR): the guide forever/miscellaneous/the-drowned-city-alliance (forever/miscellaneous/the-drowned-city-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16550} The Drowned City
	["{area:16550} (Alliance)"] = "{area:16550} (Allianz)",
	-- {area:16550} The Drowned City
	["Every Alliance quest of the {area:16550} in one run, lead-ins included."] = "Jede Quest der Allianz in {area:16550} in einem Durchlauf, mit den Vorquests.",

	-- Step 1: Sergeant Yohwa
	-- {area:99} Rebel Camp
	["At the {area:99} in northern Stranglethorn."] = "Am {area:99} im Norden des Schlingendorntals.",

	-- Step 2: Kurzen's Compound
	-- {area:99} Rebel Camp · {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["South-east of the {area:99}. The medicine men, headshrinkers and witch doctors drop the remedies; the {item:2634} is in the {object:263}."] = "Südöstlich des {area:99}. Die Medizinmänner, Kopfschrumpfer und Hexendoktoren lassen die Heilmittel fallen; {item:2634} ist in {object:263}.",

	-- Step 4: The Emperor's Tomb
	-- {item:2008} The Fourth Troll Legend · {area:99} Rebel Camp · {area:102} Ruins of Zul'Kunda
	["{item:2008}, west of the {area:99} in the {area:102}, on the hill in the north-west."] = "{item:2008}, westlich des {area:99} in den {area:102}, auf dem Hügel im Nordwesten.",

	-- Step 5: Fall of Gurubashi
	-- {item:2007} The Third Troll Legend
	["{item:2007}, a little south-west in the same ruins."] = "{item:2007}, etwas südwestlich in denselben Ruinen.",

	-- Step 6: Gri'lek the Wanderer
	-- {item:2006} The Second Troll Legend · {area:104} Vile Reef
	["{item:2006}, further south: the tablet lies on the sea floor of the {area:104}. Mind your breath."] = "{item:2006}, weiter südlich: die Tafel liegt auf dem Meeresgrund des {area:104}. Achte auf deinen Atem.",

	-- Step 7: Moon Over the Vale
	-- {item:2005} The First Troll Legend · {area:123} Bal'lal Ruins
	["{item:2005}, in the {area:123} north-east of the reef."] = "{item:2005}, in den {area:123} nordöstlich des Riffs.",

	-- Step 9: Skullsplitter trolls
	["Skullsplitter trolls"] = "Trolls Rachacrânio",
	["The Skullsplitter mystics (level 39 to 40) and witch doctors (41 to 42) in the middle of Stranglethorn drop the fetishes."] = "Die Mystiker der Schädelsplitter (Stufe 39 bis 40) und Hexendoktoren (41 bis 42) in der Mitte des Schlingendorntals lassen die Fetische fallen.",

	-- Step 11: Loremaster Dibbs
	-- {area:271} Southshore
	["In {area:271}."] = "In {area:271}.",

	-- Step 12: Archmage Timear
	-- {area:279} Dalaran
	["In {area:279}. He gives this from level 34."] = "In {area:279}. Er gibt dies ab Stufe 34.",

	-- Step 13: Krazek
	-- {area:35} Booty Bay
	["In {area:35}. Both factions take his two quests, from level 34."] = "In {area:35}. Beide Fraktionen nehmen seine zwei Quests an, ab Stufe 34.",

	-- Step 14: To the The Drowned City
	-- {area:16550} The Drowned City
	["To the {area:16550}"] = "Nach {area:16550}",
	-- {area:17853} Sunken Hollow · {area:104} Vile Reef · {object:3202} Grom'gol (no name in this language: may be words)
	["A dungeon for five players of level 35 to 42. Meet your group at its entrance in {area:17853}, under the {area:104}: due west of {object:3202} and south-west of the reef's tablet. {object:3202} is the Horde's camp: keep clear of its guards. Water breathing helps."] = "Ein Dungeon für fünf Spieler der Stufe 35 bis 42. Triff deine Gruppe an seinem Eingang in {area:17853}, unter dem {area:104}: genau westlich von {object:3202} und südwestlich der Tafel des Riffs. {object:3202} ist das Lager der Horde: Halte Abstand zu seinen Wachen. Wasseratmung hilft.",

	-- Step 15: I'lalai Fetishes
	["I'lalai Fetishes"] = "I'lalai-Fetische",
	-- plural, as words: Profane Necromancers = {npc:263196} Profane Necromancer · Undying Offerings = {npc:263899} Undying Offering
	["Risen Sentries, Profane Necromancers and Undying Offerings drop them."] = "Auferstandene Wachen, Profane Nekromanten und Unsterbliche Opfergaben lassen sie fallen.",

	-- Step 16: First tablet
	["First tablet"] = "Erste Tafel",
	-- {npc:258905} Zul'Alai
	-- plural, as words: Makrura Snappers = {npc:258897} Makrura Snapper · Chasm Crawlers = {npc:258818} Chasm Crawler
	["Past the Makrura Snappers and Chasm Crawlers waits {npc:258905}, the first boss. The first tablet comes soon after him: click it for the rubbing."] = "Hinter den Makrura-Schnappkrebsen und Schluchtkrabblern erwartet dich {npc:258905}, der erste Boss. Die erste Tafel kommt kurz nach ihm: Klicke sie für die Abreibung an.",

	-- Step 17: Var'Taka
	-- {npc:258924} Var'Taka · {npc:260042} Captain Dreadrise
	-- plural, as words: Brinescale Explorers = {npc:258799} Brinescale Explorer
	["Brinescale Explorers and Sorceresses guard the way to {npc:258924}, the second boss. The second tablet is close to him. No Alliance quest asks for him, but once he is dead, disrupt the barrier close to where he fell; you do it once more after {npc:260042}."] = "Salzschuppen-Kundschafter und -Zaubererinnen bewachen den Weg zu {npc:258924}, dem zweiten Boss. Die zweite Tafel liegt nahe bei ihm. Keine Quest der Allianz fragt nach ihm, aber wenn er gestorben ist, störe die Barriere nahe der Stelle, an der er gefallen ist; das machst du nach {npc:260042} noch einmal.",

	-- Step 18: Captain Dreadrise
	["The Saltseer pirates hold his ground: Murderers, Manhunters, Cultists and Coroners, and any of them can drop an artifact. The third tablet is among them, before you reach the captain. After he dies, disrupt the barrier a second time."] = "Die Salzhorer-Räuber halten ihr Gebiet: Mörder, Menschenjäger, Kultisten und Leichenschauer, und jeder von ihnen kann ein Artefakt fallen lassen. Die dritte Tafel ist bei ihnen, bevor du den Kapitän erreichst. Nachdem er gestorben ist, störst du die Barriere ein zweites Mal.",
	-- {npc:773} Krazek
	["One pass through the pirates may give fewer than ten: {npc:773} takes the quest whenever you have them."] = "Ein Durchlauf durch die Räuber kann weniger als zehn bringen: {npc:773} nimmt die Quest an, sobald du sie hast.",

	-- Step 19: Deathless Marrow
	-- {npc:260202} Deathless Marrow
	["Past the Champions of the Deep, {npc:260202} fights with his guardians. He drops the idol."] = "Hinter den Champions der Tiefe kämpft {npc:260202} mit seinen Wächtern. Er lässt das Götzenbild fallen.",

	-- Step 20: Min'loth the Serpent
	["The last boss. The fourth tablet is near him, and its rubbing still counts after he dies."] = "Der letzte Boss. Die vierte Tafel liegt nahe bei ihm, und ihre Abreibung zählt auch nach seinem Tod.",

	-- Step 21: Krazek
	["Once you have the ten artifacts."] = "Sobald du die zehn Artefakte hast.",

	-- Step 24: Abra Cadabra
	-- {area:279} Dalaran
	["In {area:279}."] = "In {area:279}.",

	-- Step 25: Historian Karnik
	-- {object:32356} Hall of Explorers (no name in this language: may be words)
	["In the {object:32356}."] = "In {object:32356}.",
}
