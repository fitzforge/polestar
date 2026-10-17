-- German (deDE): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Lerne {skill:129}",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Jeder Lehrer für {skill:129} deiner Fraktion lehrt {skill:129} (Lehrling) (Charakterstufe 5); der Pfeil wählt den nächsten.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: Stoff",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "Humanoide der Stufe 5-20 lassen {item:2589} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} ist ab 1 orange (gelb ab 30, grau ab 60): etwa 61 Herstellungen bis 50. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} (Geselle)",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10: Der Pfeil wählt den nächsten Lehrer für {skill:129} deiner Fraktion. Lerne beim selben Besuch {spell:3276}.",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: Stoff",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} ist ab 50 gelb (gelb ab 50, grau ab 100): etwa 46 Herstellungen bis 80. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: Stoff",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "Humanoide der Stufe 15-30 lassen {item:2592} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} ist ab 80 gelb (gelb ab 80, grau ab 150): etwa 49 Herstellungen bis 115. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder Lehrer für {skill:129} deiner Fraktion lehrt es; der Pfeil wählt den nächsten.",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: Stoff",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} ist ab 115 gelb (gelb ab 115, grau ab 185): etwa 11 Herstellungen bis 125. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} (Experte)",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} (Experte) hebt die Obergrenze auf 225; dafür brauchst du Fertigkeit 125 und Charakterstufe 20: Es ist ein Buch, {item:16084}; der Pfeil wählt den nächsten Verkäufer für deine Fraktion. Kauf es und lies es. Derselbe Händler verkauft die Handbücher für Schwerer Seidenverband und {item:8544}: Kauf beide jetzt, du liest sie bei 180 und 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Kauf und lies {item:16084} ({skill:129} (Experte))",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} ist ab 125 gelb (gelb ab 115, grau ab 185): etwa 38 Herstellungen bis 150. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: Stoff",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "Humanoide der Stufe 25-45 lassen {item:4306} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} ist ab 150 gelb (gelb ab 150, grau ab 210): etwa 42 Herstellungen bis 180. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: Stoff",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} ist ab 180 gelb (gelb ab 180, grau ab 240): etwa 42 Herstellungen bis 210. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: Stoff",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "Humanoide der Stufe 35-50 lassen {item:4338} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} ist ab 210 gelb (gelb ab 210, grau ab 270): etwa 18 Herstellungen bis 225. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 20: Trauma
	["Trauma"] = "Trauma",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} (Fachmann) gibt es über die Quest {quest:6624}. Sie braucht Fertigkeit 225 und Stufe 40; der Lehrer für {skill:129} in {zone:1455} schickt dich zum Arzt in Theramore.",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} (Fachmann) gibt es über die Quest {quest:6622}. Sie braucht Fertigkeit 225 und Stufe 40; der Lehrer für {skill:129} in {zone:1454} schickt dich zum Arzt in {area:321}.",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: Versorge die verwundeten Soldaten im Zelt des Arztes mit den Verbänden, die er dir gibt, die kritischsten zuerst, bevor einer von ihnen stirbt.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} (Fachmann)",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: Versorge die verwundeten Soldaten im Zelt des Arztes mit den Verbänden, die er dir gibt, die kritischsten zuerst, bevor einer von ihnen stirbt.",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} ist ab 225 gelb (gelb ab 210, grau ab 270): etwa 88 Herstellungen bis 260. Verbände brauchen kein Feuer: Stelle sie überall her. {item:8544} bleibt bis 270 gelb; ein Rezept bis 260 spart zwei Wege zum Arzt.",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (Fertigkeit 260) ist ein Fachmannrezept: Nur der Arzt der Quest {quest:6622} lehrt es ({npc:12939} in Theramore, {npc:12920} in {area:321}).",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: Stoff",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "Humanoide der Stufe 45-60 lassen {item:14047} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} ist ab 260 gelb (gelb ab 260, grau ab 320): etwa 65 Herstellungen bis 300. Verbände brauchen kein Feuer: Stell sie überall her. {item:14529} bleibt bis 320 gelb und bringt dich so ohne einen Weg für den Schweren Runenstoffverband bis 300.",
}
