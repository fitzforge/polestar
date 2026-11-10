-- Spanish (Latin America) (esMX): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "Un nuevo aspecto para {spell:118}: convierte al objetivo en cerdo en vez de oveja.",

	-- Step 1: Xylem's tower
	["Xylem's tower"] = "",
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Dismount, and he teleports you up; a trail climbs to the Archmage at the top of the tower."] = "",

	-- Step 2: Warlord Krellian
	-- {npc:8408} Warlord Krellian · {spell:99} Demoralizing Roar · {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["{npc:8408} (level 55, not elite, Strike and {spell:99}) hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He always drops the {item:23250} and is back 5 1/2 minutes after a kill. Leave any raid group first: a raid gets no credit, a party is fine."] = "",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower. Xylem hands the shell back with the next quest: keep it in your bags."] = "",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "Clones polimórficos",
	-- {area:1221} Ruins of Eldarath · {spell:118} Polymorph · {spell:122} Frost Nova · {spell:1449} Arcane Explosion
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Back to the {area:1221}, full of Spitelash naga. Cast your sheep {spell:118} (the turtle one does nothing) on a naga and wait a few seconds: it splits into two to six Polymorph Clones of about 150 health that run off fast. Stand next to the sheep and hit them the moment they appear with {spell:122} and {spell:1449}. Fifty clones are needed, so it takes a while; not in a raid group."] = "",

	-- Step 5: Fragmented Magic
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Regresa con {npc:8395} y sube a la torre.",
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}: {spell:118} (cerdo)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "Lleva la {item:23250} de vuelta a {area:1221}. Lanza Polimorfia sobre una naga Látigo de Ira y espera unos segundos: se divide en pequeños Clones polimórficos ({npc:16479}). Mata a los clones rápido; la concha recoge su esencia.",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "Vuela a {area:3137} (Alianza) o {area:1237} (Horda). {npc:8395} acampa bajo la torre de {npc:8379}: desde la bifurcación del camino principal de {zone:1447} en {area:1221}, ve directo al norte hasta los acantilados. Te teletransporta arriba con el archimago.",
	-- ["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "Krellian se esconde tras sus guardias Látigo de Ira en {area:1223}, el edificio más grande en medio de {area:1221}. Suelta la {item:23250}.",
}
