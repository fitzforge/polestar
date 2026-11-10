-- German (deDE): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449} (Allianz)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Dein {item:5176} für jedes Feuertotem, {spell:3599} damit und Forevers {item:263412}.",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "Mit 10 schickt dich {npc:258113}, der Schamanenlehrer in {area:131}, oder {npc:258098}, der Schamanenlehrer in {zone:1455}, zu {npc:257597}.",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{npc:258113}, {area:131}; oder {npc:258098}, {zone:1455}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "Folge der Straße nach Osten zum Tunnel Richtung {area:806}. Halte dich nach dem ersten Tunnel links an {npc:1959} und dem Turm vorbei: Ein schmaler Pfad, schwer zu sehen, aber auf der Minikarte angezeigt, windet sich den Berg hinauf zur Höhle von {npc:257597} über dem Hof. Er gibt dir {item:6653}: Behalte sie bis zum Ende der Questreihe.",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "Von der Felskante von {npc:257597} aus kannst du vorsichtig den Berg hinunter nach {zone:1432} springen oder durch den Tunnel zurückgehen. {npc:257808} hütet den Schrein auf dem Gipfel direkt südlich von {area:144}: Ein versteckter Pfad an einer Felskante, markiert mit Steintotems, führt von der Straße nördlich des Gipfels hinauf.",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "Die Stonesplinter Seers (Stufe 13-14) halten sich bei den Troggs von {area:923} im Süden des Sees auf, außerdem in den Trogglagern nordöstlich von {area:144}. Sie werfen aus 40 Metern {spell:1245113} und rufen bei Verletzung um Hilfe: Pull sie einzeln. Respawn etwa fünf Minuten.",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "Die Tunnel Rat Geomancers (Stufe 12-13) arbeiten nur in der {area:149} am Nordende des Sees, hinter {area:144}. Sie wirken {spell:2136} hinter einem {spell:134} und rufen bei niedriger Gesundheit um Hilfe.",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "Geh den Pfad wieder hinauf zu {npc:257808}. Er stellt aus dem Teer und dem Beutel den {item:6636} her: Bewahre ihn bei der Fackel auf.",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "{quest:94473} verloren?",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "Nur wenn {quest:94473} nicht mehr in deinen Taschen ist: {npc:257808} gibt dir einen neuen.",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808}: ein neuer {quest:94473}",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "The Shrine of Eternal Flame",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "Geh an {npc:257808} vorbei weiter zum Gipfel. Trink dort neben der Steinstatue den {item:6636}, um {npc:5893} (Stufe 12) zu sehen: Er wartet, bis du angreifst, wird aber stärker, je länger man ihn lässt, und ist immun gegen Feuer. Eröffne sofort mit {spell:8017} und {spell:8042}. Seine {item:6655} fällt jedes Mal.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}, neben der Statue",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "Klicke oben auf dem Schrein mit der Fackel in deinen Taschen auf {object:61934}, um die Glut abzulegen, und klicke dann noch einmal darauf für die nächste Quest: die entzündete {item:277329}.",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Zurück durch den Tunnel am Südtor und den Pfad hinauf zur Höhle von {npc:257597}. Behalte {item:5176} dauerhaft in deinen Taschen: Jedes Feuertotem braucht ihn.",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {spell:3599}, dein {item:5176} und {item:263412}",
}
