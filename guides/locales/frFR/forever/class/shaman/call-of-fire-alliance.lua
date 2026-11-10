-- French (frFR): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449} (Alliance)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Votre {item:5176} pour chaque totem de feu, {spell:3599} avec, et le {item:263412} propre à Forever.",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "Au niveau 10, {npc:258113}, maîtresse des chamans à {area:131}, ou {npc:258098}, maître des chamans à {zone:1455}, vous envoie voir {npc:257597}.",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{npc:258113}, {area:131} ; ou {npc:258098}, {zone:1455}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "Suivez la route vers l'est jusqu'au tunnel qui mène à l'{area:806}. À la sortie du premier tunnel, restez à gauche après {npc:1959} et la tour : un sentier étroit, difficile à voir mais indiqué sur la minicarte, serpente dans la montagne jusqu'à la grotte de {npc:257597}, au-dessus de la ferme. Il vous remet la {item:6653} : gardez-la jusqu'à la fin de la chaîne.",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "Depuis la corniche de {npc:257597}, vous pouvez descendre prudemment la montagne jusqu'au {zone:1432}, ou revenir par le tunnel. {npc:257808} garde le sanctuaire sur le pic juste au sud de {area:144} : un sentier caché le long d'une corniche, balisé de totems de pierre, y monte depuis la route au nord du pic.",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "Les Prophètes Brisepierre (niveau 13-14) se tiennent parmi les troggs de la {area:923}, au sud du loch, et dans les camps de troggs au nord-est de {area:144}. Ils lancent des {spell:1245113} à 40 mètres et fuient chercher de l'aide quand ils sont blessés : attirez-les un par un. Réapparition en cinq minutes environ.",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "Les Géomanciens Rat des tunnels (niveau 12-13) ne travaillent qu'à l'intérieur de la {area:149}, au nord du loch, après {area:144}. Ils lancent {spell:2136} derrière un {spell:134} et fuient chercher de l'aide quand leur vie est basse.",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "Remontez le sentier jusqu'à {npc:257808}. Il prépare le {item:6636} avec le goudron et la bourse : gardez-le avec la torche.",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "Vous avez perdu le {quest:94473} ?",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "Seulement si le {quest:94473} n'est plus dans vos sacs : {npc:257808} vous en donne un autre.",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808} : un nouveau {quest:94473}",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "L'autel de la Flamme éternelle",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "Grimpez au-delà de {npc:257808} jusqu'au pic. Buvez le {item:6636} à côté de la statue de pierre pour voir la {npc:5893} (niveau 12) : elle attend que vous frappiez, mais devient plus forte à mesure qu'on la laisse, et elle est insensible au feu. Ouvrez aussitôt avec {spell:8017} et {spell:8042}. Sa {item:6655} tombe à chaque fois.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}, à côté de la statue",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "Le {object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "Cliquez sur le {object:61934}, au sommet du sanctuaire, avec la torche dans vos sacs pour y déposer la braise, puis cliquez de nouveau dessus pour la quête suivante : la {item:277329} allumée.",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Retraversez le tunnel de la porte Sud et remontez le sentier jusqu'à la grotte de {npc:257597}. Gardez le {item:5176} dans vos sacs pour de bon : chaque totem de feu en a besoin.",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597} : {spell:3599}, votre {item:5176} et le {item:263412}",
}
