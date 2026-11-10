-- French (frFR): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "Une nouvelle apparence pour {spell:118} : la cible se transforme en cochon plutôt qu'en mouton.",

	-- Step 1: Xylem's tower
	["Xylem's tower"] = "",
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Dismount, and he teleports you up; a trail climbs to the Archmage at the top of the tower."] = "Volez jusqu'à {area:3137} (Alliance) ou {area:1237} (Horde). {npc:8395} campe au pied de la tour de {npc:8379}, un peu à l'est de {area:1237} : depuis l'embranchement de la route principale d'{zone:1447} aux {area:1221}, allez droit au nord jusqu'aux falaises. Descendez de monture, et il vous téléporte en haut ; un sentier monte jusqu'à l'archimage au sommet de la tour.",

	-- Step 2: Warlord Krellian
	-- {npc:8408} Warlord Krellian · {spell:99} Demoralizing Roar · {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["{npc:8408} (level 55, not elite, Strike and {spell:99}) hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He always drops the {item:23250} and is back 5 1/2 minutes after a kill. Leave any raid group first: a raid gets no credit, a party is fine."] = "{npc:8408} (niveau 55, non élite, Frappe et {spell:99}) se cache derrière ses gardes Fouette-bile dans le {area:1223}, le plus grand bâtiment au milieu des {area:1221}. Il laisse toujours tomber la {item:23250} et revient 5 minutes et demie après avoir été tué. Quittez d'abord tout groupe de raid : un raid ne reçoit pas le crédit, un groupe normal si.",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower. Xylem hands the shell back with the next quest: keep it in your bags."] = "Retournez voir {npc:8395} et montez à la tour. Xylem vous rend la coquille avec la quête suivante : gardez-la dans vos sacs.",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "Clones de métamorphose",
	-- {area:1221} Ruins of Eldarath · {spell:118} Polymorph · {spell:122} Frost Nova · {spell:1449} Arcane Explosion
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Back to the {area:1221}, full of Spitelash naga. Cast your sheep {spell:118} (the turtle one does nothing) on a naga and wait a few seconds: it splits into two to six Polymorph Clones of about 150 health that run off fast. Stand next to the sheep and hit them the moment they appear with {spell:122} and {spell:1449}. Fifty clones are needed, so it takes a while; not in a raid group."] = "Retournez aux {area:1221}, pleines de nagas Fouette-bile. Lancez votre {spell:118} mouton (celle de la tortue ne fait rien) sur un naga et attendez quelques secondes : il se divise en deux à six Clones de métamorphose d'environ 150 points de vie qui s'enfuient vite. Placez-vous à côté du mouton et frappez-les dès qu'ils apparaissent avec {spell:122} et {spell:1449}. Il faut cinquante clones, cela prend donc un moment ; pas en groupe de raid.",

	-- Step 5: Fragmented Magic
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Retournez voir {npc:8395} et montez à la tour.",
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379} : {spell:118} (cochon)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "Rapportez la {item:23250} aux {area:1221}. Lancez Métamorphose sur un naga fouette-bile et attendez quelques secondes : il se divise en petits Clones de métamorphose. Tuez vite les clones ; la coquille recueille leur essence.",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "Volez jusqu'à {area:3137} (Alliance) ou {area:1237} (Horde). {npc:8395} campe au pied de la tour de {npc:8379} : depuis l'embranchement de la route principale d'{zone:1447} aux {area:1221}, allez droit au nord jusqu'aux falaises. Il vous téléporte auprès de l'archimage.",
	-- ["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "Krellian se cache derrière ses gardes fouette-bile dans le {area:1223}, le plus grand bâtiment au milieu des {area:1221}. Il laisse tomber la {item:23250}.",
}
