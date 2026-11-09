-- German (deDE): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Lerne {skill:129}",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "Jeder {skill:129}-Lehrer deiner Fraktion lehrt Lehrling in {skill:129} (Charakterstufe 5, 1s); der Pfeil wählt den nächsten. Forever lehrt dazu {item:118}: {item:2447}, {item:2678} und {item:3371}, orange bis 55. Mit {skill:182} kann es die Leinenverbände unten ersetzen.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: Stoff",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "Humanoide der Stufe 5-20 lassen {item:2589} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 3: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "{item:1251} ist ab 1 orange (gelb bei 30, grün bei 45, grau bei 60): etwa 41 Herstellungen bis 40. Verbände brauchen kein Feuer: Stelle sie überall her. Bei 20 lehrt der Lehrer auch {item:279968} (1s; die Quest Camping 101: {skill:129} im Camp deines Startgebiets lehrt es kostenlos), Forevers Camping-Gegenstand für {skill:129}: drei Leinenverbände und {item:159}; er bringt bis 25 ein paar Punkte.",

	-- Step 4: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: Stoff",

	-- Step 5: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "{item:2581} ist ab 40 orange (gelb bei 50, grün bei 75, grau bei 100): etwa 10 Herstellungen bis 50. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder {skill:129}-Lehrer deiner Fraktion lehrt es ab Fertigkeit 40 für 1s; der Pfeil wählt den nächsten.",

	-- Step 6: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} (Geselle)",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "Geselle in {skill:129} hebt die Obergrenze auf 150 an; er braucht Fertigkeit 50 und Charakterstufe 10: Der Pfeil wählt den nächsten {skill:129}-Lehrer deiner Fraktion; die Ausbildung kostet 5s.",

	-- Step 8: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "{item:2581} ist ab 50 gelb (gelb bei 50, grün bei 75, grau bei 100): etwa 46 Herstellungen bis 80. Verbände brauchen kein Feuer: Stelle sie überall her. Kräuterkundler: {item:858} (ab 55, 1s 50c; {item:2450}, zwei {item:2678} und {item:3371}) ist bis 85 orange.",

	-- Step 9: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: Stoff",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "Humanoide der Stufe 15-30 lassen {item:2592} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 10: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac · {spell:9810} Touch of Zanzil
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for {spell:9810}, and it sells."] = "{spell:3277} ist ab 80 gelb (gelb bei 80, grün bei 115, grau bei 150): etwa 49 Herstellungen bis 115. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder {skill:129}-Lehrer deiner Fraktion lehrt es ab Fertigkeit 80 für 2s 50c; der Pfeil wählt den nächsten. {item:6452} ({item:1475}, von Spinnen) wird ebenfalls bei 80 gelehrt: Schurken brauchen es für {spell:9810}, und es lässt sich verkaufen.",

	-- Step 11: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: Stoff",

	-- Step 12: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "{spell:3278} ist ab 115 gelb (gelb bei 115, grün bei 150, grau bei 185): etwa 11 Herstellungen bis 125. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder {skill:129}-Lehrer deiner Fraktion lehrt es ab Fertigkeit 115 für 10s; der Pfeil wählt den nächsten. Kräuterkundler: {item:929} (ab 110, 8s; {item:2453}, {item:2692} und {item:3372}) ist bis 135 orange.",

	-- Step 13: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} (Experte)",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "Experte in {skill:129} hebt die Obergrenze auf 225 an; er braucht Fertigkeit 125 und Charakterstufe 20: Es ist ein Buch, {item:16084} (1g); der Pfeil wählt den nächsten Verkäufer für deine Fraktion. Kauf es und lies es. Derselbe Händler verkauft die Handbücher für Schwere Seidenverbände und {item:8544} (22s und 50s): Kauf beide jetzt, du liest sie bei 180 und 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Kauf und lies {item:16084} ({skill:129} (Experte))",

	-- Step 15: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} ist ab 125 gelb (gelb bei 115, grün bei 150, grau bei 185): etwa 38 Herstellungen bis 150. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 16: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: Stoff",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "Humanoide der Stufe 25-45 lassen {item:4306} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 17: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "{item:6450} ist ab 150 gelb (gelb bei 150, grün bei 180, grau bei 210): etwa 42 Herstellungen bis 180. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder {skill:129}-Lehrer deiner Fraktion lehrt es ab Fertigkeit 150 für 50s; der Pfeil wählt den nächsten.",

	-- Step 18: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: Stoff",

	-- Step 19: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} ist ab 180 gelb (gelb bei 180, grün bei 210, grau bei 240): etwa 42 Herstellungen bis 210. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 20: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: Stoff",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "Humanoide der Stufe 35-50 lassen {item:4338} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 21: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} ist ab 210 gelb (gelb bei 210, grün bei 240, grau bei 270): etwa 18 Herstellungen bis 225. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 22: Trauma
	["Trauma"] = "Trauma",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "Meister in {skill:129} gibt es durch die Quest {quest:6624}. Sie braucht Fertigkeit 225 und Stufe 35; der {skill:129}-Lehrer in {zone:1455} schickt dich zum Arzt in Theramore. Bring jetzt den Magiestoff (etwa 74) und {item:14047} (etwa 65) für 225-300 mit: Verbände brauchen kein Feuer, also stellst du 225-300 neben dem Arzt her, der die Verbände des Meisters lehrt.",

	-- Step 23: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "Meister in {skill:129} gibt es durch die Quest {quest:6622}. Sie braucht Fertigkeit 225 und Stufe 35; der {skill:129}-Lehrer in {zone:1454} schickt dich zum Arzt in {area:321}. Bring jetzt den Magiestoff (etwa 74) und {item:14047} (etwa 65) für 225-300 mit: Verbände brauchen kein Feuer, also stellst du 225-300 neben dem Arzt her, der die Verbände des Meisters lehrt.",

	-- Step 24: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6624}: Der Arzt gibt dir Triage Bandages; benutze diese, nicht deine eigenen. Drinnen liegen fünfzehn verwundete Soldaten: Verbinde zuerst die kritisch Verletzten, dann die schwer Verletzten, dann die Verletzten, bevor welche sterben (Lebensbalken anzeigen mit Strg+V). Gib die Quest ab, sobald fünfzehn gerettet sind: Die anderen sterben weiter, und zu viele Tote lassen sie scheitern, selbst wenn sie als abgeschlossen angezeigt wird. Scheitert sie, brich sie ab und nimm sie erneut an.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} (Fachmann)",

	-- Step 25: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6622}: Der Arzt gibt dir Triage Bandages; benutze diese, nicht deine eigenen. Drinnen liegen fünfzehn verwundete Soldaten auf dem Boden: Verbinde zuerst die kritisch Verletzten, dann die schwer Verletzten, dann die Verletzten, bevor welche sterben (Lebensbalken anzeigen mit Strg+V). Gib die Quest ab, sobald fünfzehn gerettet sind: Die anderen sterben weiter, und zu viele Tote lassen sie scheitern, selbst wenn sie als abgeschlossen angezeigt wird. Scheitert sie, brich sie ab und nimm sie erneut an.",

	-- Step 27: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "{item:8544} ist ab 225 gelb (gelb bei 210, grün bei 240, grau bei 270): etwa 24 Herstellungen bis 240. Verbände brauchen kein Feuer: Stelle sie überall her. {item:8544} wird bei 240 grün: Wechsle dort zum Schweren Magiestoffverband, der bis 260 weniger Stoff kostet als grüne Magiestoffverbände.",

	-- Step 28: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:10841} (Fertigkeit 240) ist ein Rezept für Fachmänner: Nur der Arzt aus {quest:6622} lehrt es ({npc:12939} in Theramore, {npc:12920} in {area:321}).",

	-- Step 29: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "{item:8545}: Stoff",

	-- Step 30: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "{item:8545} ist ab 240 gelb (gelb bei 240, grün bei 270, grau bei 300): etwa 25 Herstellungen bis 260. Verbände brauchen kein Feuer: Stelle sie überall her.",

	-- Step 31: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (Fertigkeit 260) ist ein Fachmannrezept: Nur der Arzt der Quest {quest:6622} lehrt es ({npc:12939} in Theramore, {npc:12920} in {area:321}).",

	-- Step 32: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: Stoff",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "Humanoide der Stufe 45-60 lassen {item:14047} fallen (oder kauf ihn im Auktionshaus).",

	-- Step 33: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "{item:14529} ist ab 260 gelb (gelb bei 260, grün bei 290, grau bei 320): etwa 65 Herstellungen bis 300. Verbände brauchen kein Feuer: Stelle sie überall her. {item:14529} wird bei 290 grün, braucht aber bis 300 etwa genauso viel {item:14047} wie der Wechsel zu {item:14530} (der Arzt lehrt es bei 290): Ein Rezept genügt.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Jeder Lehrer für {skill:129} deiner Fraktion lehrt {skill:129} (Lehrling) (Charakterstufe 5); der Pfeil wählt den nächsten.",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} (Fachmann) gibt es über die Quest {quest:6622}. Sie braucht Fertigkeit 225 und Stufe 40; der Lehrer für {skill:129} in {zone:1454} schickt dich zum Arzt in {area:321}.",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} (Fachmann) gibt es über die Quest {quest:6624}. Sie braucht Fertigkeit 225 und Stufe 40; der Lehrer für {skill:129} in {zone:1455} schickt dich zum Arzt in Theramore.",
	-- ["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} (Experte) hebt die Obergrenze auf 225; dafür brauchst du Fertigkeit 125 und Charakterstufe 20: Es ist ein Buch, {item:16084}; der Pfeil wählt den nächsten Verkäufer für deine Fraktion. Kauf es und lies es. Derselbe Händler verkauft die Handbücher für Schwerer Seidenverband und {item:8544}: Kauf beide jetzt, du liest sie bei 180 und 210.",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10: Der Pfeil wählt den nächsten Lehrer für {skill:129} deiner Fraktion. Lerne beim selben Besuch {spell:3276}.",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} ist ab 1 orange (gelb ab 30, grau ab 60): etwa 61 Herstellungen bis 50. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} ist ab 260 gelb (gelb ab 260, grau ab 320): etwa 65 Herstellungen bis 300. Verbände brauchen kein Feuer: Stell sie überall her. {item:14529} bleibt bis 320 gelb und bringt dich so ohne einen Weg für den Schweren Runenstoffverband bis 300.",
	-- ["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} ist ab 50 gelb (gelb ab 50, grau ab 100): etwa 46 Herstellungen bis 80. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} ist ab 150 gelb (gelb ab 150, grau ab 210): etwa 42 Herstellungen bis 180. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} ist ab 180 gelb (gelb ab 180, grau ab 240): etwa 42 Herstellungen bis 210. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} ist ab 210 gelb (gelb ab 210, grau ab 270): etwa 18 Herstellungen bis 225. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} ist ab 225 gelb (gelb ab 210, grau ab 270): etwa 88 Herstellungen bis 260. Verbände brauchen kein Feuer: Stelle sie überall her. {item:8544} bleibt bis 270 gelb; ein Rezept bis 260 spart zwei Wege zum Arzt.",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: Versorge die verwundeten Soldaten im Zelt des Arztes mit den Verbänden, die er dir gibt, die kritischsten zuerst, bevor einer von ihnen stirbt.",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: Versorge die verwundeten Soldaten im Zelt des Arztes mit den Verbänden, die er dir gibt, die kritischsten zuerst, bevor einer von ihnen stirbt.",
	-- ["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} ist ab 80 gelb (gelb ab 80, grau ab 150): etwa 49 Herstellungen bis 115. Verbände brauchen kein Feuer: Stelle sie überall her. Jeder Lehrer für {skill:129} deiner Fraktion lehrt es; der Pfeil wählt den nächsten.",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} ist ab 115 gelb (gelb ab 115, grau ab 185): etwa 11 Herstellungen bis 125. Verbände brauchen kein Feuer: Stelle sie überall her.",
	-- ["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} ist ab 125 gelb (gelb ab 115, grau ab 185): etwa 38 Herstellungen bis 150. Verbände brauchen kein Feuer: Stelle sie überall her.",
}
