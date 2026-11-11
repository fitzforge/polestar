-- French (frFR): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:444} Tower of Althalaxx
	["Starts now at 22 at the {area:444}; its mobs are 28-30, so go nearer 30 or with a friend. Alliance only for now."] = "",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore · {spell:686} Shadow Bolt · {object:409311} Spear of Mannoroth
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic · Dark Strand Voidcallers = {npc:2337} Dark Strand Voidcaller
	["Climb to the top of the {area:444} in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts {spell:686} from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "Montez au sommet de la {area:444}, dans le nord de {zone:1439}. Les Fanatiques de la Rive noire alentour sont faciles (niveau 16-17), mais quatre Anéantisseurs de la Rive noire (niveau 28-29) se tiennent dans la tour sur le chemin de l'orbe : chacun appelle un marcheur du Vide et lance {spell:686} à distance. Aux niveaux 22-25, venez avec un ou deux amis, attirez-les un par un et placez-vous derrière un mur pour qu'ils viennent à vous. Fouillez l'Orbe étrange au sommet : il vous donne l'Orbe d'Althalaxx ; faites un clic droit dessus pour lancer la quête. Gardez l'orbe dans vos sacs jusqu'à la {object:409311} : trois quêtes suivantes en ont besoin.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb au sommet de {area:444} : clic droit sur l'Althalaxx Orb qu'il donne",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale · {zone:1439} Darkshore · {zone:1453} Stormwind
	["{npc:3663} stands at {area:413} in western {zone:1440}, south of the {zone:1439} road. He sends you to {zone:1453} with the orb."] = "{npc:3663} se tient au {area:413}, dans l'ouest d'{zone:1440}, au sud de la route de {zone:1439}. Il vous envoie à {zone:1453} avec l'orbe.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} stands in the Cathedral of Light; she sends you to a warlock for a second opinion."] = "{npc:5492} se tient dans la cathédrale de la Lumière ; elle vous envoie demander un deuxième avis à un démoniste.",

	-- Step 4: Ursula Deline
	-- {npc:5495} Ursula Deline · {object:2101} Mage Quarter · {object:2164} Slaughtered Lamb · {item:209778} Summoner's Salt
	["{npc:5495}, the warlock trainer, is in the {object:2101}'s warlock sanctum, down in the {object:2164}'s cellar. She wants 14 {item:209778} to read the orb."] = "{npc:5495}, la maîtresse des démonistes, se trouve dans le sanctuaire des démonistes du {object:2101}, dans la cave de l'{object:2164}. Elle veut 14 {item:209778} pour lire l'orbe.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt · {area:69} Lakeshire · {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner · Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The Blackrock Summoners, Champions and Trackers (level 22-25, not elite) camp in the north-west of Redridge and drop the {item:209778}; you need 14. Two elite Blackrock Shadowcasters (22-23) stand at the cave mouth at the camp's east end: pull around them. The Blackrock camps east of {area:69} drop the salt too, but their Shadowcasters, Sentries and Hunters are elite (level 21-24), and so is {npc:334} (26): stay in the north-west."] = "Les Invocateurs, Champions et Pisteurs Blackrock (niveau 22-25, non élites) campent dans le nord-ouest des Carmines et laissent tomber le {item:209778} ; il vous en faut 14. Deux Exhalombres Blackrock élites (22-23) se tiennent à l'entrée de la grotte, à l'extrémité est du camp : contournez-les. Les camps Blackrock à l'est de {area:69} laissent aussi tomber le sel, mais leurs Exhalombres, Sentinelles et Chasseurs sont élites (niveau 21-24), tout comme {npc:334} (26) : restez dans le nord-ouest.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "Retour auprès d'{npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Granules de Mannoroth",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale · {area:431} Splintertree Post · {spell:686} Shadow Bolt · {spell:348} Immolate
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}, east of {area:431} (a Horde camp: go round it). The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds (level 29-30, not elite) drop the Motes of Mannoroth; you need 12. Below about 27 they are hard alone: come with a second player or later. Felguards knock you down, Lashers cast {spell:686} and {spell:348}, Infernals keep a fire shield up. They respawn in five minutes."] = "Le {area:435} se trouve dans le sud-est d'{zone:1440}, à l'est d'{area:431} (un camp de la Horde : contournez-le). Les Flagellantes de Mannoroc, Infernaux incendiaires, Gangregardes et Molosses de la Légion (niveau 29-30, non élites) laissent tomber les Granules de Mannoroth ; il vous en faut 12. En dessous du niveau 27 environ, ils sont durs en solo : venez avec un autre joueur ou plus tard. Les Gangregardes vous renversent, les Flagellantes lancent {spell:686} et {spell:348}, les Infernaux gardent un bouclier de feu. Ils réapparaissent en cinq minutes.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb
	["The {object:409311} stands at the east end of {area:435}. Hand in the motes at the spear with the Althalaxx Orb in your bags: the orb shatters, and the {object:409315} beside it starts the last quest."] = "La {object:409311} se dresse à l'extrémité est du {area:435}. Rendez les granules à la lance avec l'Orbe d'Althalaxx dans vos sacs : l'orbe se brise, et l'{object:409315} à côté lance la dernière quête.",
	-- {object:409315} Shattered Orb
	["from the {object:409315}"] = "sur l'{object:409315}",

	-- Step 9: Return to Delgren
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Back to {npc:3663} at {area:413} in western {zone:1440}, across the whole zone."] = "Retournez voir {npc:3663} au {area:413}, dans l'ouest d'{zone:1440}, en traversant toute la zone.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Une cape rare au niveau 30, tirée de l'ancienne histoire de {spell:407778} ; pour l'instant, seuls les paladins de l'Alliance peuvent la terminer.",
	-- ["Back to {area:413}."] = "Retour à {area:413}.",
	-- ["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Les Invocateurs, Champions et Pisteurs Blackrock campent dans le nord-ouest des Carmines ; ils laissent tomber le {item:209778}.",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Montez au sommet de {area:444}, dans le nord de {zone:1439}. Fouillez le Strange Orb là-haut : il vous donne l'Althalaxx Orb, qui lance la quête.",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts {spell:686} from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "Montez au sommet de la {area:444}, dans le nord de {zone:1439}. Les Fanatiques de la Rive noire alentour sont faciles (niveau 16-17), mais quatre Anéantisseurs de la Rive noire (niveau 28-29) se tiennent dans la tour sur le chemin de l'orbe : chacun appelle un marcheur du Vide et lance {spell:686} à distance. Aux niveaux 22-25, venez avec un ou deux amis, attirez-les un par un et placez-vous derrière un mur pour qu'ils viennent à vous. Fouillez l'Orbe étrange au sommet : il vous donne l'Orbe d'Althalaxx ; faites un clic droit dessus pour lancer la quête. Gardez l'orbe dans vos sacs jusqu'à la {object:409311} : trois quêtes suivantes en ont besoin.",
	-- ["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine vous envoie voir les démonistes dans {object:2101} ; {npc:5495} parle en leur nom.",
	-- ["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb au sommet de {area:444} : clic droit sur l'Althalaxx Orb qu'il donne",
	-- ["The Strange Orb"] = "Strange Orb",
	-- ["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} se dresse à l'extrémité est de {area:435}. Brisez l'orbe dessus ; l'{object:409315} apparaît à côté.",
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} se dresse à l'extrémité est de {area:435}. Lancez {spell:11170} sur l'orbe qui s'y trouve ; {object:409315} apparaît à côté.",
	-- ["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435} se trouve dans le sud-est d'{zone:1440}. Les Flagellantes de Mannoroc, Infernaux incendiaires, Gangregardes et Molosses de la Légion qui s'y trouvent laissent tomber les Granules de Mannoroth.",
	-- ["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} se trouve à {area:413}, dans l'ouest de {zone:1440}.",
	-- ["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} est dans la cathédrale de la Lumière.",
}
