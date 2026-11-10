-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/polymorph-pig (forever/class/mage/polymorph-pig.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:118} Polymorph
	["A new look for {spell:118}: it turns the target into a pig rather than a sheep."] = "Um novo visual para {spell:118}: transforma o alvo em porco em vez de ovelha.",

	-- Step 1: Xylem's tower
	["Xylem's tower"] = "Torre de Tauriel",
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem · {zone:1447} Azshara · {area:1221} Ruins of Eldarath
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Dismount, and he teleports you up; a trail climbs to the Archmage at the top of the tower."] = "Voe para {area:3137} (Aliança) ou {area:1237} (Horda). {npc:8395} acampa embaixo da torre de {npc:8379}, um pouco a leste de {area:1237}: da bifurcação da estrada principal de {zone:1447} em {area:1221}, siga reto para o norte até os penhascos. Desça da montaria e ele teleporta você para cima; uma trilha sobe até o Arquimago, no alto da torre.",

	-- Step 2: Warlord Krellian
	-- {npc:8408} Warlord Krellian · {spell:99} Demoralizing Roar · {area:1223} Temple of Zin-Malor · {area:1221} Ruins of Eldarath · {item:23250} Prismatic Shell
	["{npc:8408} (level 55, not elite, Strike and {spell:99}) hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He always drops the {item:23250} and is back 5 1/2 minutes after a kill. Leave any raid group first: a raid gets no credit, a party is fine."] = "{npc:8408} (nível 55, não elite, Golpe e {spell:99}) se esconde atrás dos guardas Iralisca em {area:1223}, o prédio maior no meio de {area:1221}. Ele sempre deixa cair a {item:23250} e volta 5 minutos e meio depois de morto. Saia de qualquer grupo de raide antes: raide não conta, grupo normal conta.",

	-- Step 3: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower. Xylem hands the shell back with the next quest: keep it in your bags."] = "De volta a {npc:8395} e para cima da torre. O Tauriel devolve a concha junto com a próxima missão: guarde nas bolsas.",

	-- Step 4: Polymorph Clones
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Polymorph Clones"] = "Clones Polimorfados",
	-- {area:1221} Ruins of Eldarath · {spell:118} Polymorph · {spell:122} Frost Nova · {spell:1449} Arcane Explosion
	-- plural, as words: Polymorph Clones = {npc:16479} Polymorph Clone
	["Back to the {area:1221}, full of Spitelash naga. Cast your sheep {spell:118} (the turtle one does nothing) on a naga and wait a few seconds: it splits into two to six Polymorph Clones of about 150 health that run off fast. Stand next to the sheep and hit them the moment they appear with {spell:122} and {spell:1449}. Fifty clones are needed, so it takes a while; not in a raid group."] = "De volta a {area:1221}, cheia de nagas Iralisca. Use o seu {spell:118} de ovelha (o de tartaruga não faz nada) num naga e espere alguns segundos: ele se divide em dois a seis Clones Polimorfados com uns 150 de vida que saem correndo rápido. Fique colado na ovelha e acerte os clones assim que aparecerem com {spell:122} e {spell:1449}. São cinquenta clones, então demora; nada de grupo de raide.",

	-- Step 5: Fragmented Magic
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Volte a {npc:8395} e suba à torre.",
	-- {npc:8379} Archmage Xylem · {spell:118} Polymorph
	["{npc:8379}: {spell:118} (pig)"] = "{npc:8379}: {spell:118} (porco)",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Carry the {item:23250} back to the {area:1221}. Polymorph a Spitelash naga and wait a few seconds: it splits into small Polymorph Clones. Kill the clones quickly; the shell collects their essence."] = "Leve a {item:23250} de volta para {area:1221}. Use Polimorfia numa naga Iralisca e espere alguns segundos: ela se divide em pequenos Clones Polimorfados. Mate os clones rápido; a concha coleta a essência deles.",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below {npc:8379}'s tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to the Archmage."] = "Voe até {area:3137} (Aliança) ou {area:1237} (Horda). {npc:8395} acampa ao pé da torre de {npc:8379}: da bifurcação da estrada principal de {zone:1447} nas {area:1221}, siga direto para o norte até os penhascos. Ele teleporta você até o Arquimago.",
	-- ["Krellian hides behind his Spitelash guards in the {area:1223}, the biggest building in the middle of the {area:1221}. He drops the {item:23250}."] = "Krellian se esconde atrás dos guardas Iralisca no {area:1223}, o maior edifício no meio das {area:1221}. Ele deixa cair a {item:23250}.",
}
