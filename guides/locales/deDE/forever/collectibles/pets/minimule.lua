-- German (deDE): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Minimule",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "Handelskommission von Azeroth",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The Alliance camp is at {area:1002} in western {zone:1433}. Merchant's Favor comes from Waylaid Crates that mobs drop from level 10: fill one with a bundle it lists and hand it to {npc:214101}, for 5 to 30 Favor a crate. The treat costs 1,500 Favor and, by beta vendor lists, needs Revered with the Azeroth Commerce Authority. Crates pay no standing: that comes from the Craftsman's Writs, 21,000 from Neutral to Revered. The Supply Factions Reputation guide takes you there."] = "Das Lager der Allianz liegt bei {area:1002} im Westen von {zone:1433}. Gunst der Händler stammt von Waylaid Crates, die Gegner ab Stufe 10 fallen lassen: Fülle eine mit einem Bündel, das sie nennt, und gib sie bei {npc:214101} ab, für 5 bis 30 Gunst pro Kiste. Der Leckerbissen kostet 1.500 Gunst und braucht laut den Händlerlisten der Beta Respektvoll bei der Azeroth Commerce Authority. Kisten bringen keinen Ruf: Der kommt von den Schriftstücken der Handwerker, 21.000 von Neutral bis Respektvoll. Der Ruf-Guide für die Versorgungsfraktionen bringt dich dorthin.",
	["1,500 Merchant's Favor"] = "1.500 Merchant's Favor",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Versorgung und Logistik Durotar",
	-- {npc:256384} Gishah · {zone:1458} Undercity
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The Horde camp is just outside the west gate of the Crossroads. Merchant's Favor comes from Waylaid Crates that mobs drop from level 10: fill one with a bundle it lists and hand it to Dokimi, for 5 to 30 Favor a crate. The treat costs 1,500 Favor and, by beta vendor lists, needs Revered with Durotar Supply and Logistics. Crates pay no standing: that comes from the Craftsman's Writs, 21,000 from Neutral to Revered. The Supply Factions Reputation guide takes you there. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "Das Lager der Horde liegt direkt vor dem Westtor von Crossroads. Gunst der Händler stammt von Waylaid Crates, die Gegner ab Stufe 10 fallen lassen: Fülle eine mit einem Bündel, das sie nennt, und gib sie bei Dokimi ab, für 5 bis 30 Gunst pro Kiste. Der Leckerbissen kostet 1.500 Gunst und braucht laut den Händlerlisten der Beta Respektvoll bei Durotar Supply and Logistics. Kisten bringen keinen Ruf: Der kommt von den Schriftstücken der Handwerker, 21.000 von Neutral bis Respektvoll. Der Ruf-Guide für die Versorgungsfraktionen bringt dich dorthin. (Ein weiterer {npc:256384} steht in {zone:1458}; dies ist der im Lager.)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "Das Lager der Allianz ist bei {area:1002} im westlichen {zone:1433}. Plündere Vorratskisten in der Welt, füll sie und gib sie bei {npc:214101} ab für Merchant's Favor (5-20 pro Kiste); das Leckerli kostet 1.500.",
	-- ["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "Das Lager der Horde liegt gleich außerhalb von {area:380}. Plündere Vorratskisten in der Welt, füll sie und gib sie im Lager ab für Merchant's Favor; das Leckerli kostet 1.500. (Ein weiterer {npc:256384} steht in {zone:1458}; gemeint ist der im Lager.)",
}
